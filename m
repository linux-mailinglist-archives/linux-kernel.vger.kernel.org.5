Return-Path: <linux-kernel+bounces-97917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD30D877199
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA1F1F21529
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EFA40874;
	Sat,  9 Mar 2024 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/8AKRg3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D92C3C08E;
	Sat,  9 Mar 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709994307; cv=none; b=bVbyh16fn+bgtk5R/PeDCQgwpqLfNhNTRW6CMPp9S43lQVyqX0qEEejoau4N7i6jtOaJMQEgOJNTg85aFHJlNJYkLp2m8FTLz9Q9VrYM5y2wp+UFIhOEEGQubJILVG2596/3uteIif4WH2N3qJnp9Uaqqn/wu0N6kC/00s/ujKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709994307; c=relaxed/simple;
	bh=aNVgWD8ilbHhgD7lp+ZEhfwJD+ID/RdcVUU+nXM53v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCsbsK62NCZFqmMN066wM765T5WmoghCGWyGh5QvLvgFsqIoyIgi6gtU2nNkd0t9n8yP9tSyjJ2vhl77AnZgOY1aig29VT6SYt0490JloL91p9xVsLfuFA+k0vF9zD1j0fVQsJ7Ls1CFePdXazIV+wt/bbI9+nb2H9A9r/WeLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/8AKRg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134A1C433F1;
	Sat,  9 Mar 2024 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709994307;
	bh=aNVgWD8ilbHhgD7lp+ZEhfwJD+ID/RdcVUU+nXM53v8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X/8AKRg3FJlZyozYdI+Qp4tehKkeBDHvC7nEbT7tt+dNqUCNGJGnrbg5QnK8Wzmzd
	 8Q/aCvZozAAwButDuLgnqk54qhrFkPlGv74d85EO2SY2YXWNxRSTF8D3URqvJoEZVb
	 X7lRYqTfW3Fh2+WAq/4kqhuYF/Wk+D/z2XN3AopI/RBJSb8x7yXfoDFySzDkB5k3YO
	 j5mihan9DZq8EkTrrXrIjvkWnWsTPwxpm21BLEEE9fhRaJRnLzulx6D2QcS9ueHGCS
	 QBx87ntrjgJeaONHr6IRnLEcqLGiVJM2sqbcajer792a0TIiiYo/4kpVyYz7uPhVJL
	 LaVMWLGmH4Mxw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5135ab96dcbso3253491e87.1;
        Sat, 09 Mar 2024 06:25:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6ZtpoEqiEbCl5cIaV4Gq6AOs6h7o6ZJThUZUTX4F/VqdkG+t3idaMsHBmDPp/yY9cPdYYKCZRZYOX7PJBIXTo3zBXeq1uIq79kb7ZKW0V72MDXSM3vw27GWdwK3MFB/jl4F5UdwQGm8JP
X-Gm-Message-State: AOJu0YxoyeiT7pJa40qtbuK+57C96k0ZQ5YTDHKhtMC3BntMxTRbgHB/
	wJNmyzmxYnbY0y4FuqMBRwKt/UwLJo8dDCX2vnrihpHRRVJoI5HZSVqkkkZWBWEP1TpE3ThtVoa
	34GYGNoIZk8y7puGa1sCW6t+BjBs=
X-Google-Smtp-Source: AGHT+IGv0Ycu6AT5vUmNTCfmv5w8PuFh6nXpl0xiTZtF7HgfclsOa+bV+utpZPu8MhIKbyM6Lxgkmsr2Qg91dYfWH8c=
X-Received: by 2002:ac2:4d8e:0:b0:513:3b3e:c361 with SMTP id
 g14-20020ac24d8e000000b005133b3ec361mr1136256lfe.2.1709994305575; Sat, 09 Mar
 2024 06:25:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305110915.184868-1-jtornosm@redhat.com>
In-Reply-To: <20240305110915.184868-1-jtornosm@redhat.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 9 Mar 2024 23:24:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ6_kr0Q1RB0dELiGUObFJ4HEEu3XTErGf6FaNntKMnTg@mail.gmail.com>
Message-ID: <CAK7LNAQ6_kr0Q1RB0dELiGUObFJ4HEEu3XTErGf6FaNntKMnTg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rpm-pkg: add dtb files in kernel rpm
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: nathan@kernel.org, nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 8:09=E2=80=AFPM Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> Some architectures, like aarch64 ones, need a dtb file to configure the
> hardware. The default dtb file can be preloaded from u-boot, but the fina=
l
> and/or more complete dtb file needs to be able to be loaded later from
> rootfs.
>
> Add the possible dtb files to the kernel rpm and mimic Fedora shipping
> process, storing the dtb files in the module directory. These dtb files
> will be copied to /boot directory by the install scripts, but add fallbac=
k
> just in case, checking if the content in /boot directory is correct.
>
> Mark the files installed to /boot as %ghost to make sure they will be
> removed when the package is uninstalled.
>
> Tested with Fedora Rawhide (x86_64 and aarch64) with dnf and rpm tools.
> In addition, fallback was also tested after modifying the install scripts=
.
>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  scripts/package/kernel.spec | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index c256b73cca3e..5c4c1ffcba6c 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -61,6 +61,9 @@ cp $(%{make} %{makeflags} -s image_name) %{buildroot}/l=
ib/modules/%{KERNELRELEAS
>  %{make} %{makeflags} INSTALL_HDR_PATH=3D%{buildroot}/usr headers_install
>  cp System.map %{buildroot}/lib/modules/%{KERNELRELEASE}
>  cp .config %{buildroot}/lib/modules/%{KERNELRELEASE}/config
> +if [ -d "${srctree}/arch/${SRCARCH}/boot/dts" ];then



${srctree} and ${SRCARCH} are not always defined in kernel.spec.


They are not defined if you directly run 'rpmbuild -rb <SRPM>'.


The following will correctly check the presence of
${srctree}/arch/${SRCARCH}/boot/dts.


if %{make} %{makeflags} run-command KBUILD_RUN_COMMAND=3D'test -d
${srctree}/arch/${SRCARCH}/boot/dts'; then








> +       %{make} %{makeflags} INSTALL_DTBS_PATH=3D%{buildroot}/lib/modules=
/%{KERNELRELEASE}/dtb dtbs_install
> +fi
>  ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KER=
NELRELEASE}/build
>  %if %{with_devel}
>  %{make} %{makeflags} run-command KBUILD_RUN_COMMAND=3D'${srctree}/script=
s/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE=
}'
> @@ -81,6 +84,14 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}=
/lib/modules/%{KERNELRELEA
>                 echo "%ghost /boot/${x}-%{KERNELRELEASE}"
>         done
>
> +       if [ -d "%{buildroot}/lib/modules/%{KERNELRELEASE}/dtb" ];then
> +               echo "/lib/modules/%{KERNELRELEASE}/dtb"
> +               for x in $(find "%{buildroot}/lib/modules/%{KERNELRELEASE=
}/dtb" -name "*" \
> +                               -exec realpath --relative-to "%{buildroot=
}/lib/modules/%{KERNELRELEASE}/dtb" {} \;); do
> +                       echo "%ghost /boot/dtb-%{KERNELRELEASE}/${x}"
> +               done


Instead of the for-loop, you can write it in one command:


  find "%{buildroot}/lib/modules/%{KERNELRELEASE}/dtb" -printf
"%%%ghost /boot/dtb-%{KERNELRELEASE}/%%P\n"


Is the escaping % complex?













> +       fi
> +
>         echo "%exclude /lib/modules/%{KERNELRELEASE}/build"
>  } > %{buildroot}/kernel.list
>
> @@ -96,6 +107,12 @@ for file in vmlinuz System.map config; do
>                 cp "/lib/modules/%{KERNELRELEASE}/${file}" "/boot/${file}=
-%{KERNELRELEASE}"
>         fi
>  done
> +if [ -d "/lib/modules/%{KERNELRELEASE}/dtb" ]; then
> +       if ! diff -rq "/lib/modules/%{KERNELRELEASE}/dtb" "/boot/dtb-%{KE=
RNELRELEASE}" &>/dev/null; then


I do not recommend the bash'ism "&>/dev/null".

The scriptlet is executed by /bin/sh, which
may not be bash, although on most RPM-based
distro, it is a symlink to bash.


You can squash the nested if-conditionals:


if [ -d "/lib/modules/%{KERNELRELEASE}/dtb" ] && \
   ! diff -rq "/lib/modules/%{KERNELRELEASE}/dtb"
"/boot/dtb-%{KERNELRELEASE}" >/dev/null 2>&1; then
        ...
fi





> +               rm -rf "/boot/dtb-%{KERNELRELEASE}"
> +               cp -r "/lib/modules/%{KERNELRELEASE}/dtb" "/boot/dtb-%{KE=
RNELRELEASE}"
> +       fi
> +fi
>  if [ ! -e "/lib/modules/%{KERNELRELEASE}/modules.dep" ]; then
>         /usr/sbin/depmod %{KERNELRELEASE}
>  fi
> --
> 2.43.2
>
>


--
Best Regards



Masahiro Yamada

