Return-Path: <linux-kernel+bounces-90979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065118707FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D52AB27601
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D825FDCB;
	Mon,  4 Mar 2024 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbwyWtuK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80FB4642A;
	Mon,  4 Mar 2024 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571937; cv=none; b=dXDbkAt8xr7h9m99ck57lruSFVxgaQxVLsSFKFU1zoOXFSUdPc2VtpjnhazLa5DeMJfKQGwOPkz05nprCucjbhzRB7esTp/I7/yTyMEN/BlmtfJuPSepWeiUIKoDKHKbD8TSt3W4DSgAxDTl4Z3iahrBcX82Q0sa6UmDcxN5q6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571937; c=relaxed/simple;
	bh=zD/c78WU8bA5wQQx/rSC8cu3BgvCF8zH72PFnPryMV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ty2Fuo2jnexM+nb/wiSYyNBF5CHE9HZ5i0hyBdqw3PbK6Tn5yyRGu5Q0jhEuawyzWX8x0LwAll+pA4SM2rmFfktNPfI/+q6ODedpsq7leDjUQ9GY97J5Y5IpW5OVi7/1maBNsJBHBSpcNYZPVM+gLmXkLTE2CMhq7mtScHsJQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbwyWtuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB05C433F1;
	Mon,  4 Mar 2024 17:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709571937;
	bh=zD/c78WU8bA5wQQx/rSC8cu3BgvCF8zH72PFnPryMV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SbwyWtuK6Rx2U+B0kvWk5iyMuOMeQI5LTV9i1o+wsg9u6IgWRj8IdS3bp18lLU+ba
	 dYlNm9VRoClfUQRYeqnVXTzunuNhbDdN6aJowp6W2opIPxDF3d8j/ccBAN1NCxwbTo
	 0ctZiAFaike4Vqkxce3WTT3+b+0Iq6OiVKcsXu4ElZmCs4jpERA56BuDk61LPGV95B
	 4t2HRl5q3aYFPO8qsJMerOOITjwgbmkbfhQk0HvbvemAZTrtj5KYTswLRmWbcAtkoe
	 S8rKdizzTP6rhozbgC8929PXnrl7p2lkjnoWaG8wwBPvFBp/SG+hb1XrzG5Ya8MY9O
	 t0osBkJ4gTOBg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d382a78c38so22718911fa.1;
        Mon, 04 Mar 2024 09:05:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/CT9qWhdRZ/ZAql39wWgjVqSSFK4l+YHR+uiJksXfs70iQ0BcSeyqswtrgnm0azL/6CHWvI7+kPY1AWGo5p7RWtTx8DOxsoY/eMHw
X-Gm-Message-State: AOJu0YwqcJ7kg0ZKtS/i0D0MbM+xPdfJW6nF+FEZGR9made4xcNjjbLk
	S9Ab8Zw+0RFaHtdYcrlB0lKmOeXzYob//6qgXp0a76V0EfZUg89q6Ep8jwQ+qH2TP/Lb6TbSmVR
	Ab5yA3i4WMOs4zGUvvbEzY0mnBA==
X-Google-Smtp-Source: AGHT+IEG/k9XM1uX3m8yp7kREFJTf/frvjwwPIpybcwq84QP9Bm88kROlZOHDg9QRJu54OsPp4uTFKgsgcB0L908Yi0=
X-Received: by 2002:a2e:a4c4:0:b0:2d2:a2f5:596e with SMTP id
 p4-20020a2ea4c4000000b002d2a2f5596emr6113226ljm.38.1709571935590; Mon, 04 Mar
 2024 09:05:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL_JsqKNGjKq3vcUPFiPa9JNq-8=oP=uBSD=tyKaPMH3cvAkww@mail.gmail.com>
 <20240304150227.166053-1-skseofh@gmail.com>
In-Reply-To: <20240304150227.166053-1-skseofh@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 4 Mar 2024 11:05:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKaZ4KcvfNZmn2gj+yXa8eLgzMpdhJJ=+OmMJPvzm-1Qg@mail.gmail.com>
Message-ID: <CAL_JsqKaZ4KcvfNZmn2gj+yXa8eLgzMpdhJJ=+OmMJPvzm-1Qg@mail.gmail.com>
Subject: Re: [PATCH] of: fdt: modify small size memory check
To: skseofh@gmail.com
Cc: devicetree@vger.kernel.org, frowand.list@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 9:03=E2=80=AFAM <skseofh@gmail.com> wrote:
>
>
> >>
> >> From: Daero Lee <skseofh@gmail.com>
> >>
> >> After page aligning, the size may become zero. So I added exception
> >> handling code for size 0.
> >
> >That may be true, but when would anyone only have memory regions of
> >less than 2 pages. In any case memblock_add will just do nothing. What
> >is the actual problem you are having?
> >
> >Rob
>
> Ignore the previous mail.
> I modified the patch to clear this size check routine. Please check

You still haven't answered my questions above.

Though the patch below is a bit more readable than what we currently have..=
.

>
> -------------------------------------------------------------------------
> From 2135d37c37f8c369033f79102b17ddf5bb3ff838 Mon Sep 17 00:00:00 2001
> From: Daero Lee <skseofh@gmail.com>
> Date: Mon, 4 Mar 2024 23:21:14 +0900
> Subject: [PATCH] of: fdt: modify small size memory check
>
> Small size memory which is less than 1 PAGE_SIZE after page align
> should not be added to memblock.
>
> In this patch, the size check was modified to make it clear.
>
> Signed-off-by: Daero Lee <skseofh@gmail.com>
> ---
>  drivers/of/fdt.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bf502ba8da95..9cf844e664b0 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1220,18 +1220,16 @@ int __init early_init_dt_scan_chosen(char *cmdlin=
e)
>  void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
>  {
>         const u64 phys_offset =3D MIN_MEMBLOCK_ADDR;
> +       u64 abase =3D PAGE_ALIGN(base), aend =3D PAGE_ALIGN_DOWN(base + s=
ize);
>
> -       if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
> +       if((aend - abase) < PAGE_SIZE) {
>                 pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
>                         base, base + size);
>                 return;
>         }
>
> -       if (!PAGE_ALIGNED(base)) {
> -               size -=3D PAGE_SIZE - (base & ~PAGE_MASK);
> -               base =3D PAGE_ALIGN(base);
> -       }
> -       size &=3D PAGE_MASK;
> +       base =3D abase;
> +       size =3D (aend - abase) & PAGE_MASK;
>
>         if (base > MAX_MEMBLOCK_ADDR) {
>                 pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
> --
> 2.25.1
>
>

