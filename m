Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F027F86B4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjKXX3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKXX3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:29:06 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C4F10DE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:29:13 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso2052365276.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700868552; x=1701473352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsOhbxgo0w5vrLvqlyS+CI33FHpY1D06+ACp6sG/31M=;
        b=GTf5m98EgD+7w8yCztkXm+JckLfmdHG/JnmNR7ekvYqlqepF4pr7CUR3+tUK1G2bVg
         C8ptJVn8r/OnNcXlatY5uAxu24QA7Y80sPYDJgBqNrIYZapZyfDkKD3R40pI5xui5cQc
         cgFYra6+httF6E9KykWs048rdKSayCjKG3LxAwjJ/swZcdQzEB3WNfBF548ZAvxaSdy2
         7XoIW14ofBR0zwXuTr5OsN+vSQwn2shytnT1mGYogW5VmQeR4Mf3s4XF1OxS9GKU+9/M
         4v68LXpVLPaA+PBJav/oz7+DTp3cemLmhsFZbVJo2ZTQhZKC0w1UQGvQ0eEU4JRiMDF2
         LZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700868552; x=1701473352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsOhbxgo0w5vrLvqlyS+CI33FHpY1D06+ACp6sG/31M=;
        b=iJrvH2r9E93hySfec0ZW5gfbFyNeyDkdLNEC6abkhqbBRkwPy2mQHvsTfiMXalA7QE
         qOsOcO3VKIy9RnJhH3epL52XNG1S2aARwvk4THkuP3bvbGJ3pfWeX9pupt7lwL0Pt5HZ
         pQktBM6iwgpA98HBqKQxVzu+WS6fID4OBbsz/axSYv+wRWKmxcSHpPCeQ5veLcp8DSpO
         BzFvmGU55a3kXshsOn95Yqc515Pv9mzLdcUwzuNJ4AcLfd/PhkTN4mXqt7Y7cvKyA1kv
         /y2H4v3hMkzfUasPVfqAJWVHCy584hk4Bdi8ACHTGiOt3IgIgJVb7NWD4m1H68WopVQw
         l4rw==
X-Gm-Message-State: AOJu0YwuCHgYJtEYGeSmHPiuH6FLoItlUrdehpXIV2TwC2RX4FTHhdGc
        I+BBhmAAWawQWX7ab07P5BxtxbFBL2hKCkc71UcZmQ==
X-Google-Smtp-Source: AGHT+IHacgXTdMc3t9a8/JgK7vOiOb1nS+bmjqs0kfUuGY+kRG1kBJzz1yGjDpKpKdgkAOs/hXTjEcKqqFgReOEYS9g=
X-Received: by 2002:a25:400b:0:b0:d80:4533:9556 with SMTP id
 n11-20020a25400b000000b00d8045339556mr3605329yba.63.1700868552394; Fri, 24
 Nov 2023 15:29:12 -0800 (PST)
MIME-Version: 1.0
References: <20231115165001.2932350-1-brgl@bgdev.pl> <CACRpkdbDny8X3WB_qJ4h_vbwrjno5ytAtNMgTeXg4jpegdUH2w@mail.gmail.com>
 <CAMRc=McZJzdj04Ckf_ygDhWNN2JcbTfY+yefOZSYx_nTE_Jpjg@mail.gmail.com>
 <CACRpkdb7QwWcq=mDa4y8bh_QLAFU+X9LCr0chrGVL-_9YE5P9A@mail.gmail.com> <CAMRc=Md+5N_u0QkL+OTc2xVQuxP0dZY-1GbrdGQqwhdJrv4Cbg@mail.gmail.com>
In-Reply-To: <CAMRc=Md+5N_u0QkL+OTc2xVQuxP0dZY-1GbrdGQqwhdJrv4Cbg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 25 Nov 2023 00:29:01 +0100
Message-ID: <CACRpkdadxCYg-z5qqp_h+8NhPUy6H4x5Ev06Q_bi_fL16e95OQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: don't use gpiod_to_chip()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 8:40=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Fri, Nov 24, 2023 at 11:01=E2=80=AFAM Linus Walleij <linus.walleij@lin=
aro.org> wrote:
> >
> > On Mon, Nov 20, 2023 at 4:06=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> > > On Thu, Nov 16, 2023 at 2:43=E2=80=AFPM Linus Walleij <linus.walleij@=
linaro.org> wrote:
> > > > On Wed, Nov 15, 2023 at 5:50=E2=80=AFPM Bartosz Golaszewski <brgl@b=
gdev.pl> wrote:
> > > >
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >
> > > > > Let's start working towards removing gpiod_to_chip() from the ker=
nel.
> > > > > Start with pinctrl. The first patch should go through the GPIO tr=
ee
> > > > > and become available through an immutable tag so that we can get =
more
> > > > > conversions in this cycle elsewhere.
> > > >
> > > > Fair enough, maybe an immutable branch with all three patches?
> > > > Probably best to merga all three into both subsystems I think.
> > > >
> > >
> > > Nah, I don't think I need to pollute the GPIO tree with every pinctrl
> > > patch. It's enough to just merge the first one into GPIO and you do
> > > the same in pinctrl.
> >
> > Fair enough, but I need that immutable branch for patch 1 so I
> > can merge the rest on top.
> >
> > Yours,
> > Linus Walleij
>
> I applied the first patch (after fixing the typo in the commit
> message) and sent you the immutable branch to pull. Please apply the
> remaining patches to the pinctrl tree directly.

Pulled it and applied the other two patches on top, thanks!

Yours,
Linus Walleij
