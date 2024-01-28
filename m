Return-Path: <linux-kernel+bounces-41557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6971783F489
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 08:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9977B2207F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 07:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAA7D530;
	Sun, 28 Jan 2024 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxGhnmCK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CA6C15D;
	Sun, 28 Jan 2024 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706427191; cv=none; b=PrJnSbN8nhA7uzNyoewPHUZGjdEmMo8quAnlSLHLQwohPkij8J08GNhcKI2i+4mMlQZlpfxB915QgyZFOp/sMoyMsmW73tclLhFvlURkC92SJMCe3Yw7G0hhczEs99D+ADWCGn4opIwjemKi7v2wnAAm/TJYtfaOcffUdADIkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706427191; c=relaxed/simple;
	bh=gqM1zyHPRfrWy/ECgf/f24dA+w7bujh2ltxwBhlg2sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gB3t5RWcFnGgEOrgAuiu2r7y66lrRcVvncLx3Xay0oKgvjfoI9leu5HD9QxWVyjHWgIqKCyN2ozlQVyqOoAA9Fdvp6k3L7ylz5R6NCBZZpZ9dqLOEOvLQL4vv6dpEUkqz555weo3bEYmVajzJ0ib0OXdzVMmmx2oOW8mLYEYG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxGhnmCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B02C43394;
	Sun, 28 Jan 2024 07:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706427190;
	bh=gqM1zyHPRfrWy/ECgf/f24dA+w7bujh2ltxwBhlg2sg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RxGhnmCKABnKlEXpNfEKEgDq9J/YbciuIVRKVGwZmT99VZ15LmnpCTn1HCcF4fUDu
	 4g+QnzleEdBSVwD7MY1ylC0PdrEA5a7gwvB72uzLlFW27+kFisUo78hF+y7XDqu9as
	 p+WseU/n2sXMoTyaeSEdag2OW/+a/7V5BEXn3os9uylNUWWx9W8vYHYZGoZFBVfl2a
	 hj7/eEAVJa2Sg6hqBkvMiOnNARV2vOejhQPRqqi05piGmf2l5y8iIG71O7tMS6LCHT
	 zIa4F/A+Y5Q5gPPhVt6e304n4/sL8e+MNgDI4fOJGGEwQhMW1V+Hlv43BiG8xeyztD
	 bGmGJ5Y0Mit4g==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2184133da88so855464fac.0;
        Sat, 27 Jan 2024 23:33:10 -0800 (PST)
X-Gm-Message-State: AOJu0YwBpaegGKze4mg5QacaVzr9NtwVlumGg4ge1Ld/4mLN+F6j+KQw
	t9JQ3OJr+u/6Q2KQ0E73IiIs3dY97v70pscdjsGSmXmJNOjQ/UzSj8+uYEQ1vvXWXheDF+qgFDC
	FMxzuUezv3Mk/4/IpGyFGtlyAT10=
X-Google-Smtp-Source: AGHT+IFMLLRyOYRR7wQ55gXsLacE56gy2EReBGVi00F5vkwOHLOWW3tMZV558RHwfmiws3ERQuYPZ0xm5oakfmwQJ+w=
X-Received: by 2002:a05:6870:71c5:b0:218:7b38:d6f5 with SMTP id
 p5-20020a05687071c500b002187b38d6f5mr292783oag.25.1706427189944; Sat, 27 Jan
 2024 23:33:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNAQCiBtQ3kQznPDKtkD83wpCzodPVDs8eFnfnx5=Y8E5Cw@mail.gmail.com>
 <20240122182253.17973-1-jtornosm@redhat.com>
In-Reply-To: <20240122182253.17973-1-jtornosm@redhat.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 28 Jan 2024 16:32:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR2xDjbn+BZqUrgbDxPJUyQBULFB51kTiN8Nc78DXVyEw@mail.gmail.com>
Message-ID: <CAK7LNAR2xDjbn+BZqUrgbDxPJUyQBULFB51kTiN8Nc78DXVyEw@mail.gmail.com>
Subject: Re: [PATCH] rpm-pkg: simplify installkernel %post
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: dcavalca@meta.com, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com, 
	nicolas@fjasle.eu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 3:23=E2=80=AFAM Jose Ignacio Tornos Martinez
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
> Besides, after installkernel tool execution, check to complete if the
> correct package files vmlinuz, System.map and config files are present
> in /boot directory, and if necessary, copy manually for install operation=
.
> In this way, take into account if  files were not previously copied from
> /usr/lib/kernel/install.d/* scripts and if the suitable files for the
> requested package are present (it could be others if the rpm files were
> replace with a new pacakge with the same release and a different build).
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
> V5 -> V6
> - Simplify and do more compatible checks when copied files wants to be
>   replaced.
> - Remove %preun because it will be better done with another patch.
> - Add indentation and quotation
>
>  scripts/package/kernel.spec | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index 89298983a169..0bff257ec3d4 100644
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
> @@ -70,31 +70,31 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot=
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
> +       /usr/bin/kernel-install add %{KERNELRELEASE} /lib/modules/%{KERNE=
LRELEASE}/vmlinuz
>  fi
> +for file in vmlinuz System.map config; do
> +       if [ ! -e "/boot/${file}-%{KERNELRELEASE}" ] || ! cmp --silent "/=
lib/modules/%{KERNELRELEASE}/${file}" "/boot/${file}-%{KERNELRELEASE}"; the=
n
> +               cp "/lib/modules/%{KERNELRELEASE}/${file}" "/boot/${file}=
-%{KERNELRELEASE}"
> +       fi
> +done



I am fine with this approach, but
[ ! -e "/boot/${file}-%{KERNELRELEASE}" ]
is a redundant check now.


When the file does not exist, "cmp --silent" exits
with 2 instead of 1.
Anyway, "cmp --silent" fails.


You can simplify the conditional to:

if ! cmp --silent "/lib/modules/%{KERNELRELEASE}/${file}"
"/boot/${file}-%{KERNELRELEASE}"; then




>  %preun
>  if [ -x /sbin/new-kernel-pkg ]; then
> -new-kernel-pkg --remove %{KERNELRELEASE} --rminitrd --initrdfile=3D/boot=
/initramfs-%{KERNELRELEASE}.img
> +       new-kernel-pkg --remove %{KERNELRELEASE} --rminitrd --initrdfile=
=3D/boot/initramfs-%{KERNELRELEASE}.img

This is a noise change.
Please drop.



>  elif [ -x /usr/bin/kernel-install ]; then
> -kernel-install remove %{KERNELRELEASE}
> +       /usr/bin/kernel-install remove %{KERNELRELEASE}
>  fi
>
>  %postun
>  if [ -x /sbin/update-bootloader ]; then
> -/sbin/update-bootloader --remove %{KERNELRELEASE}
> +       /sbin/update-bootloader --remove %{KERNELRELEASE}

Ditto.

Please create a separate patch if you change the coding style.
But, rather, I am thinking of reverting
6ef41e22a320 and 27c3bffd230ab




>  fi
>
>  %files
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

