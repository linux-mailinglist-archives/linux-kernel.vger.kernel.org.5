Return-Path: <linux-kernel+bounces-104827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EE487D43A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02830285F69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F994CB37;
	Fri, 15 Mar 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsHqRNeN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356533C6AC;
	Fri, 15 Mar 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529225; cv=none; b=dwU9VINuEdSWYcqm0u5gEfSUZfMoYhVkMy5uTmd7ww21ezuhSRzLNm2TQ6NIKzJVo4qHYVUWY5jrsvRd0fgO9mW0DEg+3xzXHxeSG32noirG9ltulVnhkQzzepyT1lqmiUXZCaJVTKobfeHJ+9yE+3dJbvhsXzrbn7tBMp47F68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529225; c=relaxed/simple;
	bh=dFaIIP3h2/4z7Ri/hpxDhx7MtkGrBQZ5gt0kHZ6Fl7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFS3bQdNFySikc3S4a1XQLd6OUQRu+veqO/FFHcc4jR/OhTfF90QxNghjcqsmJ+OmG3RdABoCdleaiRYI/Y1tko94fnZMIaUUsJ0Q/Y0qJ1KJkH00/o6loLwmcSLLLMjWVTwcSUCrc3uQjI8+K4XoZw6ea7HecWxqsrS1YQPNVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsHqRNeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DB1C433C7;
	Fri, 15 Mar 2024 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710529223;
	bh=dFaIIP3h2/4z7Ri/hpxDhx7MtkGrBQZ5gt0kHZ6Fl7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsHqRNeNcdZDysuSGfidc9Q3PdZBQFEso4FZdF8tBIjAqixqSNWJMdXspWXzt8joQ
	 JALhYTmd7HIYDFhhOB046n51nqHSobjprfnyoN3knFvixxKesQKPvz1Wbk6cPPiwZG
	 gyM4IynaY412PxmmBKZb74k6zH0Bhryx+AitwkPgc7FVj21icf001KgjCqmmZobhWz
	 ZDC2HWpqVfxMfQRZrx1yqO13Czv2At70AD96xgwDfGskLcPy2nGm6pxIJ3ed5uTGBB
	 iAGmYJD5sob+yEaPMdoXPDz9UD7Z/ux862WwQ/usDpjMVMqJQqAJIv7tZxhfJOwoxP
	 QZf2qcOILoe8Q==
Date: Fri, 15 Mar 2024 12:00:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: masahiroy@kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, nicolas@fjasle.eu
Subject: Re: [PATCH V2] kbuild: rpm-pkg: add dtb files in kernel rpm
Message-ID: <20240315190021.GA721491@dev-arch.thelio-3990X>
References: <CAK7LNAQ6_kr0Q1RB0dELiGUObFJ4HEEu3XTErGf6FaNntKMnTg@mail.gmail.com>
 <20240311162238.1761147-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311162238.1761147-1-jtornosm@redhat.com>

On Mon, Mar 11, 2024 at 05:22:38PM +0100, Jose Ignacio Tornos Martinez wrote:
> Some architectures, like aarch64 ones, need a dtb file to configure the
> hardware. The default dtb file can be preloaded from u-boot, but the final
> and/or more complete dtb file needs to be able to be loaded later from
> rootfs.
> 
> Add the possible dtb files to the kernel rpm and mimic Fedora shipping
> process, storing the dtb files in the module directory. These dtb files
> will be copied to /boot directory by the install scripts, but add fallback
> just in case, checking if the content in /boot directory is correct.
> 
> Mark the files installed to /boot as %ghost to make sure they will be
> removed when the package is uninstalled.
> 
> Tested with Fedora Rawhide (x86_64 and aarch64) with dnf and rpm tools.
> In addition, fallback was also tested after modifying the install scripts.
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Tested-by: Nathan Chancellor <nathan@kernel.org>

I can see the new files in my arm64 package using 'rpm -qf'.

> ---
> V1 -> V2:
> - Follow the suggestions from Masahiro Yamada to improve the checks and
> avoid the loop to ghost the dtb files in /boot folder.
> 
>  scripts/package/kernel.spec | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index c256b73cca3e..e095eb1e290e 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -61,6 +61,9 @@ cp $(%{make} %{makeflags} -s image_name) %{buildroot}/lib/modules/%{KERNELRELEAS
>  %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
>  cp System.map %{buildroot}/lib/modules/%{KERNELRELEASE}
>  cp .config %{buildroot}/lib/modules/%{KERNELRELEASE}/config
> +if %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='test -d ${srctree}/arch/${SRCARCH}/boot/dts' 2>/dev/null; then
> +	%{make} %{makeflags} INSTALL_DTBS_PATH=%{buildroot}/lib/modules/%{KERNELRELEASE}/dtb dtbs_install
> +fi
>  ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
>  %if %{with_devel}
>  %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
> @@ -81,6 +84,11 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEA
>  		echo "%ghost /boot/${x}-%{KERNELRELEASE}"
>  	done
>  
> +	if [ -d "%{buildroot}/lib/modules/%{KERNELRELEASE}/dtb" ];then
> +		echo "/lib/modules/%{KERNELRELEASE}/dtb"
> +		find "%{buildroot}/lib/modules/%{KERNELRELEASE}/dtb" -printf "%%%ghost /boot/dtb-%{KERNELRELEASE}/%%P\n"
> +	fi
> +
>  	echo "%exclude /lib/modules/%{KERNELRELEASE}/build"
>  } > %{buildroot}/kernel.list
>  
> @@ -96,6 +104,11 @@ for file in vmlinuz System.map config; do
>  		cp "/lib/modules/%{KERNELRELEASE}/${file}" "/boot/${file}-%{KERNELRELEASE}"
>  	fi
>  done
> +if [ -d "/lib/modules/%{KERNELRELEASE}/dtb" ] && \
> +   ! diff -rq "/lib/modules/%{KERNELRELEASE}/dtb" "/boot/dtb-%{KERNELRELEASE}" >/dev/null 2>&1; then
> +	rm -rf "/boot/dtb-%{KERNELRELEASE}"
> +	cp -r "/lib/modules/%{KERNELRELEASE}/dtb" "/boot/dtb-%{KERNELRELEASE}"
> +fi
>  if [ ! -e "/lib/modules/%{KERNELRELEASE}/modules.dep" ]; then
>  	/usr/sbin/depmod %{KERNELRELEASE}
>  fi
> -- 
> 2.44.0
> 

