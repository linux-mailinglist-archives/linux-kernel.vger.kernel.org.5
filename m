Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261647F16B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjKTPHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjKTPG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:06:58 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2232E94
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:06:55 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6ce2988d62eso2585660a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700492814; x=1701097614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vVhCBw4UGnbOTaPublp+dT13ul5pmR1HyKDFK4Q5L8=;
        b=sYPcyH8FC2/TI3GRqENHP2USiyIzWe5ZfI2yrsR2/DgUI6kBqoYsCfcRFRH+Zba6nK
         gAtwKNGmZPJJ6zomhngB6MnD8rpeNDe2VeIGBQZiFuNLmtf/YqNkpcB0IpIQXve1lxoW
         K3c79JPUfd0g1GZemvXRlEFLlNVS6QzVwbZk5Ig+QQ9URuvpR20k8T5AsGbKjbsoI01r
         WunVKmvbsEpnpGAw/jHpuJWprAgq9FwK7+mtjvkNRKWCSWqsZXLpU8Wy0B6PPFmNiAnN
         JBt65uB3NKy24Rg9i6aPRBx2ZEsQ8X7cGLn8/7f0sGAm1DcQLSMVBnSG9zRWmcgflk3u
         sgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700492814; x=1701097614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vVhCBw4UGnbOTaPublp+dT13ul5pmR1HyKDFK4Q5L8=;
        b=uNREdvlCeft7Y4Xiwlk8A+ZtBXOlVIxeFX1uaNcnoCvpV4FgZwsrzmB0m1sFr+/Omj
         /Jwau6kkr7yKEqZr++6BA+XUDXGH+hqaqJWh6IbmO18qJjeibTWgaKOJpHzV7ydegAab
         ZO2/Y6MhbKvppPnuqiJ+0qHNfNuaB7uQm9f8YW7Yb2ptU1ChOrOSzML+YaqepxOUh9S5
         n1xtiDcVMkTbjZ9A3DerIlrT7e0WH8OYB+ko2P+QRmXf4wxgf+Ollk2NI6JqfBtM0+24
         Z5/TlrRR+N+rUKx4IDQ0fF/2FZd42cT7ubW5ZKeWUvsv2WiYrs8MWNdRr1bHQAy6zLQC
         XsVQ==
X-Gm-Message-State: AOJu0Yxlit/URSYlalnd4KUt/OgMOJpNBbuOJdC2qn+qyDhIVRr1sSvJ
        JY1wo0bkaxhC3gZUzK44vbRS5gpM5u8/eN9RlSBbqQ==
X-Google-Smtp-Source: AGHT+IHiOw/GOhoqSglQEq4xwFJxVajS26VlN4i3Ic8j6+NDTi7W6YgdeZC24XKyFtN4IUFTWod/HG5DRe7EefXqyME=
X-Received: by 2002:a05:6358:7e14:b0:16b:c63d:5dfe with SMTP id
 o20-20020a0563587e1400b0016bc63d5dfemr7829578rwm.16.1700492814326; Mon, 20
 Nov 2023 07:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20231115165001.2932350-1-brgl@bgdev.pl> <CACRpkdbDny8X3WB_qJ4h_vbwrjno5ytAtNMgTeXg4jpegdUH2w@mail.gmail.com>
In-Reply-To: <CACRpkdbDny8X3WB_qJ4h_vbwrjno5ytAtNMgTeXg4jpegdUH2w@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 20 Nov 2023 16:06:43 +0100
Message-ID: <CAMRc=McZJzdj04Ckf_ygDhWNN2JcbTfY+yefOZSYx_nTE_Jpjg@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: don't use gpiod_to_chip()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 2:43=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Wed, Nov 15, 2023 at 5:50=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Let's start working towards removing gpiod_to_chip() from the kernel.
> > Start with pinctrl. The first patch should go through the GPIO tree
> > and become available through an immutable tag so that we can get more
> > conversions in this cycle elsewhere.
>
> Fair enough, maybe an immutable branch with all three patches?
> Probably best to merga all three into both subsystems I think.
>

Nah, I don't think I need to pollute the GPIO tree with every pinctrl
patch. It's enough to just merge the first one into GPIO and you do
the same in pinctrl.

Bart

> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
