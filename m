Return-Path: <linux-kernel+bounces-144630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A478A4892
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061DC1C2268D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E29200B7;
	Mon, 15 Apr 2024 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ShuwUXl4"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA821EB48
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164387; cv=none; b=TFGKDG0XTJP4QEdpOD65cx8Tsn2bLTeVjMh1opJag6SPfQEOskAsk/OJYjmdN4CvlNNJA71M8DR+XKr75YSRN1r6iDT4bh72h1k4NlFmYjPxljLIAeJl0g8GRUhQdfUGtqexA86BaCEJE1PWLS9kdJUlr+vVWHNb8FUXx8iudjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164387; c=relaxed/simple;
	bh=P/GOgv76XYdOW625BfkTbcSXUp/VGA45+3y1j8k3JUM=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAAZc7vMH3OrZJ3kr0OXqJmbSg+NaL/2yrwuP5Oams/VZjzEvVZyYZnhxY0sM5s8GNW/JPSAYVPBJClF2UGLyWYsgCRhBK+kCu0GgpBNN226egCw9az61Li78uHQai7aogW+srJYYchGqPEi5KDdkK7HD/JU6i5t6Qv5h2QP7ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ShuwUXl4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6EA1C3FE4D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713164377;
	bh=lKHaDBe06MqDE1Bp/z+A9rd/eujvLw5qYHlN415hVeo=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ShuwUXl4uZF81sQMPq5rO8vf87HGUkxMFhn1ED9KcpvJMZjdDoBiBiOEp6tVp7THf
	 yw2Co/wYFWkO1rzlbn6QYIr3Q1NaPS/ZHxwujUg1L1CV5332rukZiFXEjJitkGskTZ
	 7FULOtq93zelyEOO8iZ+YYxx1f3hlI/TeR9jnQbq+8wRVGVsb9dXNh5Ij4GNhHi4tR
	 oGvjDtztJrKxnSO9EQK9ge2lNXRiHG9giGByA6jpRBWUX4Pb545Dhh4QcNZtrmHYsk
	 cNy/sjHILptYYzVjUQVSQalew21qRAg48v+vzC36NMdtmHTcj7NkNgJ60PMsYnuf22
	 4ugT9+asg8RbA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43485632197so51323471cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713164376; x=1713769176;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKHaDBe06MqDE1Bp/z+A9rd/eujvLw5qYHlN415hVeo=;
        b=lnmoCC5SeKnuAsY0sLP73yb4hglBeqYugyhZEsA06wal3mD+beCjsialm8HVP9z9G5
         M3LEL2K7fdA0LxHZ0N5fslu8AEMCBr/BLOKXuE5sIVDCnAfkrssrdAP21Qy7jwkFPYUa
         QQ/gcLzw64S3DuuKZnE3Xsj0Mn4iHr9I67O/GKh7t75UL+tgiWcv5lj1Be5OkQM9qhyw
         GFQ3rbdlFN1EHbNf/2jAtIwE1V73AVTWX9pC+YoXaak4EW+K8iJOs58IE/EtSOyD+RXH
         0wT/cMwldQ4kJxZsTHMJSf8v9Eb/UuaklErqLbSKBF0dxqp1aD3OtD4j6IArLEJbCty5
         gWow==
X-Forwarded-Encrypted: i=1; AJvYcCWLmCHAu8oiTjmDD5YHqOKiCdV1GKxeFwAW89d+Lf4IgL9ZKqNsWlWOR+vUVHOZcmrb7u8eO+H53/VT9i+zzzSaS9mMNZ14r6xsbH6F
X-Gm-Message-State: AOJu0YwnyiVDQJPV0sw+S3BWAoos+CKTIgolaH0Xcptj2/oIfI8H4IxM
	G2RDTUo4GHre6lafvB/dNEfVTuoqIfLvEDHZG52i/cerfr4FM2httPj8PxQ1VqGSbJaCNapVe5v
	hyoxQvGHwo7TV+GA5lKlSeLpTUBmXjWGH/ZYx8eDoeZbDd31L1MY4cdItJW97KJpa/PXSVCCctq
	U4aqJb/X6bFA5J8ziKncbF2HpCHMs2fHrsLpY4nER2usXLjPWD/NwgHKkR7b9k
X-Received: by 2002:a05:622a:130b:b0:435:882c:e9be with SMTP id v11-20020a05622a130b00b00435882ce9bemr15844223qtk.14.1713164376031;
        Sun, 14 Apr 2024 23:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxW3rB/DranE5JdZ+lECe8KDvPGVPq2P08kjcc3eTf6ysUCyRRXXrL6oRK96huBjLRAVu1p7Vjx7lBTN3MIXQ=
X-Received: by 2002:a05:622a:130b:b0:435:882c:e9be with SMTP id
 v11-20020a05622a130b00b00435882ce9bemr15844209qtk.14.1713164375747; Sun, 14
 Apr 2024 23:59:35 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 14 Apr 2024 23:59:35 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240414174139.3001175-1-masahiroy@kernel.org>
References: <20240414174139.3001175-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 14 Apr 2024 23:59:35 -0700
Message-ID: <CAJM55Z9x9AYVSqdKZTDXQ4EkJ=dDaA0vnDR4mBQ3+m-MwzdtXQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: buildtar: add comments about inconsistent package generation
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Masahiro Yamada wrote:
> scripts/package/buildtar checks some kernel packages, and copies the
> first image found. This may potentially produce an inconsistent (and
> possibly wrong) package.
>
> For instance, the for-loop for arm64 checks Image.{bz2,gz,lz4,lzma,lzo},
> and vmlinuz.efi, then copies the first image found, which might be a
> stale image.
>
> When CONFIG_EFI_ZBOOT is enabled in the pristine source tree,
> 'make ARCH=arm64 tar-pkg' will build and copy vmlinuz.efi. This is the
> expected behavior.
>
> If you build the kernel with CONFIG_EFI_ZBOOT, Image.gz will be created,
> which will remain in the build directory unless you clean it. Even if
> CONFIG_EFI_ZBOOT is turned on later, 'make ARCH=arm64 tar-pkg' will copy
> stale Image.gz instead of the latest vmlinuz.efi, as Image.gz takes
> precedence over vmlinuz.efi.
>
> In summary, the code "[ -f ... ] && cp" does not consistently produce
> the desired outcome.
>
> The other package scripts are deterministic; scripts/package/mkdebian,
> for example, chooses a copied kernel image based on CONFIG options.
>
> I removed [ -f ... ] checks from x86, alpha, parisc, and the default
> because they have a single kernel image to copy. If it is missing, it
> should be an error.
>
> I did not modify the code for mips, arm64, riscv. Instead, I left some
> comments. Eventually, someone may fix the code, or at the very least,
> it may discourage the copy-pasting of incorrect code.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Hi Masahiro,

Thanks for the patch. I wonder why arm64 and riscv is not just using
KBUILD_IMAGE as the source path of the image to copy like some other
architectures do. In any case:

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>
>  scripts/package/buildtar | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/package/buildtar b/scripts/package/buildtar
> index 72c91a1b832f..ed8d9b496305 100755
> --- a/scripts/package/buildtar
> +++ b/scripts/package/buildtar
> @@ -53,18 +53,24 @@ cp -v -- "${objtree}/vmlinux" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
>  #
>  # Install arch-specific kernel image(s)
>  #
> +# Note:
> +#   mips, arm64, and riscv copy the first image found. This may not produce
> +#   the desired outcome because it may pick up a stale file remaining in the
> +#   build tree.
> +#
>  case "${ARCH}" in
>  	x86|i386|x86_64)
> -		[ -f "${objtree}/arch/x86/boot/bzImage" ] && cp -v -- "${objtree}/arch/x86/boot/bzImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> +		cp -v -- "${objtree}/arch/x86/boot/bzImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
>  		;;
>  	alpha)
> -		[ -f "${objtree}/arch/alpha/boot/vmlinux.gz" ] && cp -v -- "${objtree}/arch/alpha/boot/vmlinux.gz" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> +		cp -v -- "${objtree}/arch/alpha/boot/vmlinux.gz" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
>  		;;
>  	parisc*)
> -		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
> +		cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
>  		[ -f "${objtree}/lifimage" ] && cp -v -- "${objtree}/lifimage" "${tmpdir}/boot/lifimage-${KERNELRELEASE}"
>  		;;
>  	mips)
> +		# Please note the following code may copy a stale file.
>  		if [ -f "${objtree}/arch/mips/boot/compressed/vmlinux.bin" ]; then
>  			cp -v -- "${objtree}/arch/mips/boot/compressed/vmlinux.bin" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
>  		elif [ -f "${objtree}/arch/mips/boot/compressed/vmlinux.ecoff" ]; then
> @@ -86,6 +92,7 @@ case "${ARCH}" in
>  		fi
>  		;;
>  	arm64)
> +		# Please note the following code may copy a stale file.
>  		for i in Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo vmlinuz.efi ; do
>  			if [ -f "${objtree}/arch/arm64/boot/${i}" ] ; then
>  				cp -v -- "${objtree}/arch/arm64/boot/${i}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> @@ -94,6 +101,7 @@ case "${ARCH}" in
>  		done
>  		;;
>  	riscv)
> +		# Please note the following code may copy a stale file.
>  		for i in Image.bz2 Image.gz Image; do
>  			if [ -f "${objtree}/arch/riscv/boot/${i}" ] ; then
>  				cp -v -- "${objtree}/arch/riscv/boot/${i}" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
> @@ -102,7 +110,7 @@ case "${ARCH}" in
>  		done
>  		;;
>  	*)
> -		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
> +		cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
>  		echo "" >&2
>  		echo '** ** **  WARNING  ** ** **' >&2
>  		echo "" >&2
> --
> 2.40.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

