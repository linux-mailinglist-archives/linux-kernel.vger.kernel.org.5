Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1B7B4862
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 17:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjJAPUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 11:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjJAPUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 11:20:01 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE27C99
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 08:19:59 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-49d0d90a7ddso1134283e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 08:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696173599; x=1696778399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlqqAdUK9+XiZ3vr9zfHOEKY61BQKj01sr184YRw5U0=;
        b=bHX8cDQXbquFxXSYfRIsNfxRQw0HhsYskdQKU0/x1WIpKGMBHG6qLpO7HmW+IuzFmE
         eG2+3mMWT6UzBz41ua9mr42t/rezTke6WSax33mHOgMFV2xyr/cKfyQ6hTDU5z0Vq9Rq
         HR98pljJqSDdHoNv2csl7t0QOceIOhLciU3Xa8tGQtJ8b5LhYkRo6GSp8rFAcg6ljBoZ
         /rbprA1gBnfRMWukIUwonNlnj84qCcHDaSX1OhpGjH8ln/6ADpW9f4cxRk1BKwfBpWKR
         mr+c/Parbwu8MAKP/Dar21MI+ceZbUh/FJHUslA9VJ8rUZROg+JQjoSlUoPaT7OO9GGK
         rDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696173599; x=1696778399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlqqAdUK9+XiZ3vr9zfHOEKY61BQKj01sr184YRw5U0=;
        b=rr3YOvceg2geCoWxkUn8Xprj125O2eXFtURw56I0z+LuBv/4AKp+c4hQomri2uYfQ9
         gli2xgXu4NEs2MpD9zqjdOSSasrfQQWnOu6DktkJybXCTYFN7GJeMLyplyT/GtB6/H4T
         UQ8bxU82r5B+gWpJJH9r+YhFOUANMbtbolBbAaXxUt2vE5SkCqQzWfNWJ9rOp+w9LzjP
         8RvLDB64Go/EYTKfTK6fy+CBpUJVGJHT60rD8GfO5RJHUJmdHt+++Lo01uxDNvG07XF+
         nI7BFnT/oVwjycw0z+wOmzXHAoNCsSh7x2zjbEdg/NIMf8OXHdu3OTr7h2N/a5zQ7nZq
         gVqQ==
X-Gm-Message-State: AOJu0YwHSBKR++sT9Xn+ODv68Gz4cu+4gIbUWUjQ1Mh+iZ2gglXWHe3g
        DJBf/+ZumsYxewr9ck5WZZCRTKKUzCz7voOYvBevOSZ0
X-Google-Smtp-Source: AGHT+IE4j3gWxMSOq6OvgLxoyzhdOUwDwvHxGddLU/JkAl6FbHrfp+/DN0/951hZIUWzbtcBLYlLKbL/bWmW7iCfKG8=
X-Received: by 2002:a1f:c5c7:0:b0:49a:6dc0:5a89 with SMTP id
 v190-20020a1fc5c7000000b0049a6dc05a89mr6121125vkf.5.1696173598711; Sun, 01
 Oct 2023 08:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230929211155.3910949-4-samitolvanen@google.com>
 <20230929211155.3910949-6-samitolvanen@google.com> <202309291452.66ED9B4D83@keescook>
 <CABCJKufxUVoO+yJ+513W5FOFu6u45N=6wZe6a69u+8LU6A_N2Q@mail.gmail.com>
 <20230930-emporium-share-2bbdf7074e54@spud> <202309301400.4E1AD87@keescook>
In-Reply-To: <202309301400.4E1AD87@keescook>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Sun, 1 Oct 2023 16:19:47 +0100
Message-ID: <CAKbZUD08W9_HB9F7tQqwreYvVapgVMOkS3QokzwHPcBnFnVMig@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: mm: Update mmap_rnd_bits_max
To:     Kees Cook <keescook@chromium.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 1, 2023 at 2:51=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Sat, Sep 30, 2023 at 10:02:35AM +0100, Conor Dooley wrote:
> > On Fri, Sep 29, 2023 at 03:52:22PM -0700, Sami Tolvanen wrote:
> > > On Fri, Sep 29, 2023 at 2:54=E2=80=AFPM Kees Cook <keescook@chromium.=
org> wrote:
> > > >
> > > > On Fri, Sep 29, 2023 at 09:11:58PM +0000, Sami Tolvanen wrote:
> > > > > ARCH_MMAP_RND_BITS_MAX is based on Sv39, which leaves a few
> > > > > potential bits of mmap randomness on the table if we end up enabl=
ing
> > > > > 4/5-level paging. Update mmap_rnd_bits_max to take the final addr=
ess
> > > > > space size into account. This increases mmap_rnd_bits_max from 24=
 to
> > > > > 33 with Sv48/57.
> > > > >
> > > > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > >
> > > > I like this. Is RISCV the only arch where the paging level can be c=
hosen
> > > > at boot time?
> > >
> > > I haven't seen this elsewhere, but I also haven't looked at all the
> > > other architectures that closely. arm64 does something interesting
> > > with ARM64_VA_BITS_52, but I think we can still handle that in
> > > Kconfig.
> >
> > AFAIU, x86-64 can do this also:
> >
> >       no4lvl          [RISCV] Disable 4-level and 5-level paging modes.=
 Forces
> >                       kernel to use 3-level paging instead.
> >
> >       no5lvl          [X86-64,RISCV] Disable 5-level paging mode. Force=
s
> >                       kernel to use 4-level paging instead.
>
> Ah-ha! Okay, well, then let's track this idea:
> https://github.com/KSPP/linux/issues/346

(Replying here for visibility, tell me if you want to move this
discussion to github)

AIUI, x86 cannot do this for compat reasons. Even if you enable LA57,
mmap only gives you < 48-bit addresses, for compatibility with things
like JITs, etc that stash information in the upper 16 bits. You need
to pass a > 48-bit mmap hint to get 57-bit addresses.

I imagine riscv does not have this issue yet, due to little
accumulated cruft, but it may be wise to check against popular JITters
for these problems on riscv code.

--=20
Pedro
