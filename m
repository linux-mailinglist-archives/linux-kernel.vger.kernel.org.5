Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDF77D2CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjJWIfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJWIfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:35:38 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AF5DA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:35:36 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9ac43d3b71so2938011276.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698050136; x=1698654936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mwmd78xs9HxhMGBj7oIOsT6gI0D9O6zUKd9Dh3MymY=;
        b=f7MPM3MEm0g5IkhTY9s+5nR7OlulqcyyZAGQ4cbgRynNwI3V2kSUaam8L6/x35NpBV
         bt6cDUSq1e6N6MYxMP8YXmjPhkgX5IJFyYP3K7JtINW/Ts35HU7jdCqKdyLqNOOHUn00
         mc0l28igCeDEl1nJsorcrVS9HN5lIVRMuDTSOdxdHoPcHRWEhN46L/tyWaCgDwXU725c
         CvaK1bzs/2YqwhDPYcpXEPajRoSp3sIFZ/mjOF8Y62e6C+Ty86C4MWhvg2oyvo1+cFAW
         gON/lJrXu+i2BsWn3LRTzaDUVJtyuOGjDnfXp+3Ezjy74AlqylbNGISlT+Y/uprDLd3j
         LKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698050136; x=1698654936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mwmd78xs9HxhMGBj7oIOsT6gI0D9O6zUKd9Dh3MymY=;
        b=FCsZ2BL9DWJydeI15dDSwA/ocKDtsPrPcQxGJAfsGW8jJ2tM+O+obrjVuThWpBXaJV
         48dsrLujofAa5qjKibiVWQeeVTA2xCmfoyOqR8v/PMV8Kw1aQ/08BZtqRPBegeqrqTvL
         MEb9Peq2bv+98psaWcSSzlewhc4xzd8IOEQb+Vj+ygz2XA21NkAu9TUJktLBQAAGhfC1
         dimAyctRZQP6QUKXpk1slgvXn4IldIr2Ni48csVM7zOv6tJj8MSwLTF49wyDoGMnEQGi
         NysBYvCT5JbrqB1iS+sgXKOyI/RhsngbnrGg9oWNtNmjumcrPkpVR/Iy0gdOvrTEiGPN
         1CMw==
X-Gm-Message-State: AOJu0YxCELNEFEOuhNh+/r9s3nWJOcqevuOXzyb9WZYm6g1p9qXWoo13
        U1DXBlIfU9P2scVkc+aL4Ti9NkO22iKf0hJD/+seDw==
X-Google-Smtp-Source: AGHT+IFLaQFg+y5gLi6XYCmqbWW4yOYzUhAuqMg9rBSYQcedOU2GIgVfAG+RjKA0FfI1WDqSVq00BjS2om75bKau9+I=
X-Received: by 2002:a25:e6c8:0:b0:d9c:f9f2:ec45 with SMTP id
 d191-20020a25e6c8000000b00d9cf9f2ec45mr7997201ybh.15.1698050135883; Mon, 23
 Oct 2023 01:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231020-mtd-otp-byteswap-v4-1-0d132c06aa9d@linaro.org> <20231023102552.4b053b17@xps-13>
In-Reply-To: <20231023102552.4b053b17@xps-13>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 23 Oct 2023 10:35:24 +0200
Message-ID: <CACRpkdYaq=RxgLJhRanfgw1+280N1K-aRvpy_BTM3SYY9Xtokw@mail.gmail.com>
Subject: Re: [PATCH v4] mtd: cfi_cmdset_0001: Byte swap OTP info
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 10:25=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:

> linus.walleij@linaro.org wrote on Fri, 20 Oct 2023 22:30:29 +0200:
>
> > Currently the offset into the device when looking for OTP
> > bits can go outside of the address of the MTD NOR devices,
> > and if that memory isn't readable, bad things happen
> > on the IXP4xx (added prints that illustrate the problem before
> > the crash):
> >
> > cfi_intelext_otp_walk walk OTP on chip 0 start at reg_prot_offset 0x000=
00100
> > ixp4xx_copy_from copy from 0x00000100 to 0xc880dd78
> > cfi_intelext_otp_walk walk OTP on chip 0 start at reg_prot_offset 0x120=
00000
> > ixp4xx_copy_from copy from 0x12000000 to 0xc880dd78
> > 8<--- cut here ---
> > Unable to handle kernel paging request at virtual address db000000
> > [db000000] *pgd=3D00000000
> > (...)
> >
> > This happens in this case because the IXP4xx is big endian and
> > the 32- and 16-bit fields in the struct cfi_intelext_otpinfo are not
> > properly byteswapped. Compare to how the code in read_pri_intelext()
> > byteswaps the fields in struct cfi_pri_intelext.
> >
> > Adding a small byte swapping loop for the OTP in read_pri_intelext()
> > and the crash goes away.
> >
> > The problem went unnoticed for many years until I enabled
> > CONFIG_MTD_OTP on the IXP4xx as well, triggering the bug.
> >
> > Cc: stable@vger.kernel.org
>
> Would you like to add a Fixes tag as well? Or is this skipped on
> purpose?

Yes the actual commit predates existing git history... :/

Git blame looks like that:

^1da177e4c3f4 (Linus Torvalds         2005-04-16 15:20:36 -0700  423)
^1da177e4c3f4 (Linus Torvalds         2005-04-16 15:20:36 -0700  424)
         /* Protection Register info */
b359ed5184aeb (Jean-Philippe Brucker  2020-04-17 16:23:26 +0200  425)
         if (extp->NumProtectionFields)
b359ed5184aeb (Jean-Philippe Brucker  2020-04-17 16:23:26 +0200  426)
                 extra_size +=3D (extp->NumProtectionFields - 1) *
b359ed5184aeb (Jean-Philippe Brucker  2020-04-17 16:23:26 +0200  427)
                               sizeof(struct cfi_intelext_otpinfo);

Jean-Philippe's patch is not the root cause AFAICT, but something
predating it, and predating git history.

The fix easily applies to all maintained stable kernels.

> > Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v3->v4:
> > - Collected Nico's ACK.
> > - Stalled since june! Has this been missed?
>
> Our current organization relies on Vignesh to pick-up (or tell me to
> pick-up) cfi patches. But he is slightly less active these days, so if I
> don't get any feedback from him soon I will take it for the next merge
> window.
>
> Sorry for the delay anyway.

No worries it's not like the patch is urgent.

Yours,
Linus Walleij
