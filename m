Return-Path: <linux-kernel+bounces-28426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 249C182FE62
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F5828867D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AA717D9;
	Wed, 17 Jan 2024 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml9me1I9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8210E9;
	Wed, 17 Jan 2024 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455003; cv=none; b=eqVY07xgeCcIntfQTtfgv70f0Ep9pdH2TmjncgDwHSnGHoAr9wLrclIGA87PpZhgdIw9S0NWJBsZz3OO6aChplqTW8AHv06WleYTlCMQhWsQdARyR+YAXOyPsKCWM1V1SNbZDIiGYUut9LPEU/9NSjbTVRCibsjsomWNPA8hldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455003; c=relaxed/simple;
	bh=VkxZW3WTCETzIHDSrJ00UWAY4EfWpI3hkFF9sjzQ+gw=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=OS4Vi+12mUGHxFW7mNUSF9HlOd5UGym5G585kWj0M/hSl+mJorUKYuXLYTEq9GFowTYyrJKot35xV3P3+d7PM6fIUCvXxHPp7m+hMyekspNQUF0QjXo8IWZaDLKes/eyQoyvKuoSMfDvsuvZR61CDM/K831s+MM7IZ4oelgSZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml9me1I9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDCEC433F1;
	Wed, 17 Jan 2024 01:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705455002;
	bh=VkxZW3WTCETzIHDSrJ00UWAY4EfWpI3hkFF9sjzQ+gw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ml9me1I9VmBZFtd8moI1ndJupOQk21oJnBK9QV25xKGZdUVEKhsjWuTc5zxb7w8H6
	 kEtLlrQrenL0QtWK1Jzdakh8e0fgMy3XP2ktZHNAPDrNHtfs7agbZ6n+e+Bu4RKdzL
	 SPoZNxSEA+ZL0h2un/5B0ADE+qipsACICbQ+XM9fwsO+VIfIIV6nQ65vQe7tR2k521
	 /qfZSmbr5eSyTbbU3dUBdlQrvlwYHlUZ8BqEwgiIxBEhGUyHmAGs5diYMYXkV3c5GX
	 V4NS+3aR8eJ6qN+qW6SlfZpAMsgp7pXfp0UET5f1bJCcLeetuzvSzmbyDZSaDTrgAr
	 Ypuxz2frj19XQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21080bacc6fso532551fac.0;
        Tue, 16 Jan 2024 17:30:02 -0800 (PST)
X-Gm-Message-State: AOJu0YyX+glSUzKkzgMvEM/+SFVbp1vmbI9uljrnW4fA5McVNFKOcU/v
	51upp3WuFpsXHop3Mh/i56HzhW4Mrm57miTA2vA=
X-Google-Smtp-Source: AGHT+IHyySSwq7pBbsEFZVxT2id6FJyqBoRA06VfSusNrILYosSIxOEVx6983d0eE2JDdMb52oA+Z+Zs24ifTbAXQQ8=
X-Received: by 2002:a05:6870:224e:b0:210:9f53:632 with SMTP id
 j14-20020a056870224e00b002109f530632mr110782oaf.25.1705455002068; Tue, 16 Jan
 2024 17:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNAR_wgQBs-q9NH1icb_FPBoVMNEhQpvV8qzH2dFsrDS0pQ@mail.gmail.com>
 <20240114080644.5086-1-jtornosm@redhat.com>
In-Reply-To: <20240114080644.5086-1-jtornosm@redhat.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 17 Jan 2024 10:29:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ7C+ZN+mxaiw3-10Lmn2f0nAYi+aou=CWraZwV=_iThw@mail.gmail.com>
Message-ID: <CAK7LNAQ7C+ZN+mxaiw3-10Lmn2f0nAYi+aou=CWraZwV=_iThw@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] rpm-pkg: simplify installkernel %post
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: dcavalca@meta.com, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com, 
	nicolas@fjasle.eu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 5:07=E2=80=AFPM Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> The new installkernel application that is now included in systemd-udev
> package allows installation although destination files are already presen=
t
> in the boot directory of the kernel package, but is failing with the
> implemented workaround for the old installkernel application from grubby
> package.
>
> For the new installkernel application, as Davide says:
> <<The %post currently does a shuffling dance before calling installkernel=
.
> This isn't actually necessary afaict, and the current implementation
> ends up triggering downstream issues such as
> https://github.com/systemd/systemd/issues/29568
> This commit simplifies the logic to remove the shuffling. For reference,
> the original logic was added in commit 3c9c7a14b627("rpm-pkg: add %post
> section to create initramfs and grub hooks").>>
>
> But we need to keep the old behavior as well, because the old installkern=
el
> application from grubby package, does not allow this simplification and
> we need to be backward compatible to avoid issues with the different
> packages.
>
> Mimic Fedora shipping process and store vmlinuz, config amd System.map
> in the module directory instead of the boot directory. In this way, we wi=
ll
> avoid the commented problem for all the cases, because the new destinatio=
n
> files are not going to exist in the boot directory of the kernel package.
>
> Replace installkernel tool with kernel-install tool, because the latter i=
s
> more complete.
>
> Besides, after installkernel tool execution, check to complete if suitabl=
e
> (same release and build) vmlinuz, System.map and config files are present
> in /boot directory, and if necessary, copy manually for install operation
> or remmove manually for remove operation.
>
> Tested with Fedora 38, Fedora 39, RHEL 9, Oracle Linux 9.3,
> openSUSE Tumbleweed and openMandrive ROME, using dnf/zypper and rpm tools=
.
>
> cc: stable@vger.kernel.org
> Co-Developed-by: Davide Cavalca <dcavalca@meta.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> V1 -> V2:
> - Complete to be backward compatible with the previous installkernel
> application.
> V2 -> V3:
> - Follow the suggestions from Masahiro Yamada and change the installation
> destination to avoid problems instead of checking the package.
> V3 -> V4:
> - Make the patch applicable to linux-kbuild/for-next (ia64 support was
> already removed).
> V4 -> V5:
> - Complete for other Linux distributions.
>
>  scripts/package/kernel.spec | 39 +++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index 89298983a169..74542af8cbfe 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -55,12 +55,12 @@ patch -p1 < %{SOURCE2}
>  %{make} %{makeflags} KERNELRELEASE=3D%{KERNELRELEASE} KBUILD_BUILD_VERSI=
ON=3D%{release}
>
>  %install
> -mkdir -p %{buildroot}/boot
> -cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KER=
NELRELEASE}
> +mkdir -p %{buildroot}/lib/modules/%{KERNELRELEASE}
> +cp $(%{make} %{makeflags} -s image_name) %{buildroot}/lib/modules/%{KERN=
ELRELEASE}/vmlinuz
>  %{make} %{makeflags} INSTALL_MOD_PATH=3D%{buildroot} modules_install
>  %{make} %{makeflags} INSTALL_HDR_PATH=3D%{buildroot}/usr headers_install
> -cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
> -cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
> +cp System.map %{buildroot}/lib/modules/%{KERNELRELEASE}
> +cp .config %{buildroot}/lib/modules/%{KERNELRELEASE}/config
>  ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KER=
NELRELEASE}/build
>  %if %{with_devel}
>  %{make} %{makeflags} run-command KBUILD_RUN_COMMAND=3D'${srctree}/script=
s/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE=
}'
> @@ -70,19 +70,35 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot=
}/lib/modules/%{KERNELRELEA
>  rm -rf %{buildroot}
>
>  %post
> -if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /=
boot/System.map-%{KERNELRELEASE} ]; then
> -cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
> -cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-=
rpm
> -rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
> -/sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm=
 /boot/.System.map-%{KERNELRELEASE}-rpm
> -rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELE=
ASE}-rpm
> +if [ -x /usr/bin/kernel-install ]; then
> +/usr/bin/kernel-install add %{KERNELRELEASE} /lib/modules/%{KERNELRELEAS=
E}/vmlinuz
>  fi
> +if [ -e /boot/vmlinuz-%{KERNELRELEASE} ] && file -bL /boot/vmlinuz-%{KER=
NELRELEASE} | grep -q " #%{release} "; then
> +release_match=3D0
> +else
> +release_match=3D1
> +fi
> +for file in vmlinuz System.map config; do
> +if [ ! -e /boot/${file}-%{KERNELRELEASE} ] || [ ${release_match} !=3D 0 =
]; then
> +cp -v /lib/modules/%{KERNELRELEASE}/${file} /boot/${file}-%{KERNELRELEAS=
E}
> +fi
> +done
>
>  %preun
>  if [ -x /sbin/new-kernel-pkg ]; then
>  new-kernel-pkg --remove %{KERNELRELEASE} --rminitrd --initrdfile=3D/boot=
/initramfs-%{KERNELRELEASE}.img
>  elif [ -x /usr/bin/kernel-install ]; then
> -kernel-install remove %{KERNELRELEASE}
> +/usr/bin/kernel-install remove %{KERNELRELEASE}
> +if [ -e /boot/vmlinuz-%{KERNELRELEASE} ] && file -bL /boot/vmlinuz-%{KER=
NELRELEASE} | grep -q " #%{release} "; then


I do not understand why this is needed.

Please explain.


And, is the output of 'file' standardized?


You need to understand that ARCH is not always x86,
and /boot/vmlinuz-%{KERNELRELEASE}
is not always arch/x86/boot/bzImage.



See arch/arm64/Makefile

KBUILD_IMAGE    :=3D $(boot)/Image.gz


For arm64, /boot/vmlinuz-%{KERNELRELEASE} is Image.gz

'file' says it is gzip data, that's all.
You cannot read the build version.







> +release_match=3D0
> +else
> +release_match=3D1
> +fi
> +for file in vmlinuz System.map config; do
> +if [ -e /boot/${file}-%{KERNELRELEASE} ] && [ ${release_match} =3D=3D 0 =
]; then
> +rm -v /boot/${file}-%{KERNELRELEASE}
> +fi
> +done


Unreadable.

I suggested code with indentation and quotation,
but you got rid of them.






>  fi
>
>  %postun
> @@ -94,7 +110,6 @@ fi
>  %defattr (-, root, root)
>  /lib/modules/%{KERNELRELEASE}
>  %exclude /lib/modules/%{KERNELRELEASE}/build
> -/boot/*
>
>  %files headers
>  %defattr (-, root, root)
> --
> 2.43.0
>


--=20
Best Regards
Masahiro Yamada

