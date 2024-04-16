Return-Path: <linux-kernel+bounces-146098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39588A60AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B352BB2120C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F95E56A;
	Tue, 16 Apr 2024 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox0pdq59"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8A8F5A;
	Tue, 16 Apr 2024 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233306; cv=none; b=qRPszWGZc2NzdUomLtBpgC7V5uzBPW5sEs4Btk9mBd1y1NI3zn7ilnzfJoWA2WGuY6wYhDm9OcNdTndVksNZ4jzYK8BtO3R3ItrAdog3l501O37X5KiZalEHrtYO2K+v784hkbkr4oflcfcsz+OgHujErztGi0U7KDxnqPlNjqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233306; c=relaxed/simple;
	bh=VhAfUesBXIj5iQJjWVdk62eijlIt6xnT4JPcmMlBOCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWhXwpxhiUpUbvac2AC7zGa7je0tLARyUrREMVDAyQPGvj4uLlGnnmqmRqS3Y5gO2N0DtsjCrfOJALxrF0b8BveDdnF5kS2rTPfue+6sQUKSH6F4XpzDt7GkjoKzFmBDwdOARewQPxD8nSyoSXm2VfFG8mhqO8lnLmaGuzPjFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox0pdq59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5ACC4AF08;
	Tue, 16 Apr 2024 02:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713233306;
	bh=VhAfUesBXIj5iQJjWVdk62eijlIt6xnT4JPcmMlBOCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ox0pdq591S2K5TAaKiWyCXXIFihPzLZvfqLORNG2uZZHOYzxjQWBl3hMwQr0YdEZ0
	 xUhcaGrKSJ75ODL2KKBR1kjjmE3WaoMrj7xhV07QpqJ7gbo+cQTPSr+rOQKQV9q4WC
	 p9gaJK/aIBU55qGUDGXvFn6CHTH43sNQT5Vf5T6Lu/egzWTJE2BeWqM3SzlZe8pLVu
	 uRKkoowOqxpSo9PLAIA5SR5gdAyYAB35i3qZ7jXZJhTKFjWO9nTtOGZ9uD3nDPk1u2
	 r/1nL8cwpjwAoT0/QhvQaQ9Zzm7aGIv3nMgAR4nQgmYvnnU6BPAXyWLdaEY19byUYA
	 ARxmKPBOPg9Ww==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2da63269e75so21475311fa.1;
        Mon, 15 Apr 2024 19:08:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgfNDolAhFodh7BJE9GImn9dl5NzQuOkZYQyj8VoPNCa0kfy/x/VQ//0T83hyQZwj7iw6NxFClUm7IvOoU9QECS/xahAK+rhT/68x3
X-Gm-Message-State: AOJu0YwsMZxxCLOepcgkvcznVbycGezXy1Ven5IVv4iORsd3eoppkl9l
	wlp0dIK98GwlPT3JtecxnHxxhXr7M6jmtvJSHCeHP8QgATFAwvKHIacZO4uymOuZCFcTVT7xUtp
	/2gNw4WvcDKDrlLvUdlAgiGD86FI=
X-Google-Smtp-Source: AGHT+IEZzcEKCAwWWXXGi4mPBa5xOKOPXU4ktX69gk3Gxxt7LGojYmlRbPFqE8Ukhi/e3snCae5UAHyrWBfHIgQ9OO4=
X-Received: by 2002:a2e:8758:0:b0:2d8:3bef:129 with SMTP id
 q24-20020a2e8758000000b002d83bef0129mr8357927ljj.10.1713233304895; Mon, 15
 Apr 2024 19:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414174139.3001175-1-masahiroy@kernel.org>
In-Reply-To: <20240414174139.3001175-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 16 Apr 2024 11:07:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNATqLwewFaMNEy6yDguv5mNoGZJus9p4kbyMOGV9T+yopQ@mail.gmail.com>
Message-ID: <CAK7LNATqLwewFaMNEy6yDguv5mNoGZJus9p4kbyMOGV9T+yopQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: buildtar: add comments about inconsistent package generation
To: linux-kbuild@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 2:42=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> scripts/package/buildtar checks some kernel packages, and copies the
> first image found. This may potentially produce an inconsistent (and
> possibly wrong) package.
>
> For instance, the for-loop for arm64 checks Image.{bz2,gz,lz4,lzma,lzo},
> and vmlinuz.efi, then copies the first image found, which might be a
> stale image.
>
> When CONFIG_EFI_ZBOOT is enabled in the pristine source tree,
> 'make ARCH=3Darm64 tar-pkg' will build and copy vmlinuz.efi. This is the
> expected behavior.
>
> If you build the kernel with CONFIG_EFI_ZBOOT, Image.gz will be created,


The correct sentence is

If you build the kernel with CONFIG_EFI_ZBOOT disabled, ...







> which will remain in the build directory unless you clean it. Even if
> CONFIG_EFI_ZBOOT is turned on later, 'make ARCH=3Darm64 tar-pkg' will cop=
y
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
> ---
>
>  scripts/package/buildtar | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/package/buildtar b/scripts/package/buildtar
> index 72c91a1b832f..ed8d9b496305 100755
> --- a/scripts/package/buildtar
> +++ b/scripts/package/buildtar
> @@ -53,18 +53,24 @@ cp -v -- "${objtree}/vmlinux" "${tmpdir}/boot/vmlinux=
-${KERNELRELEASE}"
>  #
>  # Install arch-specific kernel image(s)
>  #
> +# Note:
> +#   mips, arm64, and riscv copy the first image found. This may not prod=
uce
> +#   the desired outcome because it may pick up a stale file remaining in=
 the
> +#   build tree.
> +#
>  case "${ARCH}" in
>         x86|i386|x86_64)
> -               [ -f "${objtree}/arch/x86/boot/bzImage" ] && cp -v -- "${=
objtree}/arch/x86/boot/bzImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> +               cp -v -- "${objtree}/arch/x86/boot/bzImage" "${tmpdir}/bo=
ot/vmlinuz-${KERNELRELEASE}"
>                 ;;
>         alpha)
> -               [ -f "${objtree}/arch/alpha/boot/vmlinux.gz" ] && cp -v -=
- "${objtree}/arch/alpha/boot/vmlinux.gz" "${tmpdir}/boot/vmlinuz-${KERNELR=
ELEASE}"
> +               cp -v -- "${objtree}/arch/alpha/boot/vmlinux.gz" "${tmpdi=
r}/boot/vmlinuz-${KERNELRELEASE}"
>                 ;;
>         parisc*)
> -               [ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "$=
{tmpdir}/boot/vmlinux-${KERNELRELEASE}"
> +               cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-${KERN=
ELRELEASE}"
>                 [ -f "${objtree}/lifimage" ] && cp -v -- "${objtree}/lifi=
mage" "${tmpdir}/boot/lifimage-${KERNELRELEASE}"
>                 ;;
>         mips)
> +               # Please note the following code may copy a stale file.
>                 if [ -f "${objtree}/arch/mips/boot/compressed/vmlinux.bin=
" ]; then
>                         cp -v -- "${objtree}/arch/mips/boot/compressed/vm=
linux.bin" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
>                 elif [ -f "${objtree}/arch/mips/boot/compressed/vmlinux.e=
coff" ]; then
> @@ -86,6 +92,7 @@ case "${ARCH}" in
>                 fi
>                 ;;
>         arm64)
> +               # Please note the following code may copy a stale file.
>                 for i in Image.bz2 Image.gz Image.lz4 Image.lzma Image.lz=
o vmlinuz.efi ; do
>                         if [ -f "${objtree}/arch/arm64/boot/${i}" ] ; the=
n
>                                 cp -v -- "${objtree}/arch/arm64/boot/${i}=
" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> @@ -94,6 +101,7 @@ case "${ARCH}" in
>                 done
>                 ;;
>         riscv)
> +               # Please note the following code may copy a stale file.
>                 for i in Image.bz2 Image.gz Image; do
>                         if [ -f "${objtree}/arch/riscv/boot/${i}" ] ; the=
n
>                                 cp -v -- "${objtree}/arch/riscv/boot/${i}=
" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
> @@ -102,7 +110,7 @@ case "${ARCH}" in
>                 done
>                 ;;
>         *)
> -               [ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "$=
{tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
> +               cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild=
-${KERNELRELEASE}"
>                 echo "" >&2
>                 echo '** ** **  WARNING  ** ** **' >&2
>                 echo "" >&2
> --
> 2.40.1
>


--
Best Regards
Masahiro Yamada

