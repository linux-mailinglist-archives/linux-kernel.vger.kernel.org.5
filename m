Return-Path: <linux-kernel+bounces-143395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AF68A3811
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC0728341F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C35D152182;
	Fri, 12 Apr 2024 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izWzK6xI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B111509BB;
	Fri, 12 Apr 2024 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712958469; cv=none; b=dgW/0Md+fytebj7D0J4pti6vEHkcxAN9WjFm4PW7Hn3YZN3Xo2Qv7efNMcN/JyADs9OsHuU3v4Qn/SPCeqAHu65yg6ORPymXYIu3u9ASZ4QBJPm7MB7GdjM5XjeU0MdcN2Ej8E5sbBeFLGE8LIa2dAC0C/5hWWMhDveM7hK1o7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712958469; c=relaxed/simple;
	bh=+TSv2iCRQQvuaL7Bz4VcHsmBjX5cRIrAU4SW7vSXszk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhkJdowqDgjKmApIQEX0ai0EimPHxb3eXgiMBGhKH2fsQIWQUfQdxH0W/S51qCXvQT7Gok+vQ2mF3tKnY8FSZ0IdGP85inBkVYwHtV3qsgm878r4mZ2/rtHwJygXTYWMgz/zzfsVetDvx+yijmgADOYLmwZBbG83xErlhZqIzhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izWzK6xI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2988C113CC;
	Fri, 12 Apr 2024 21:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712958469;
	bh=+TSv2iCRQQvuaL7Bz4VcHsmBjX5cRIrAU4SW7vSXszk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izWzK6xImDaDNMWaZlM6w/DaMBLe/BcIY1ueBgf6aHjz1jndkq/zWuqRjfHQ/ITbt
	 4bj4MlGFiAkz5bVd1wL0+uiKrGT6O+c4jYZmmRAK3D8+DtJ/XOHGRt+EK6n4WgDJYY
	 9nH1yQ0Oi4rTEuyMJ7cf3toRefEIKfUOatEYkSjerUhC2AKDICfjJbZ5MbF1pXvsqU
	 sVG07YJzxn2vP51inrMxw5NIydlW33CWBZHZ1cL7uWodaowNKy7JHdwQ+ds0H/DYEC
	 bl3lw9WWz3Htf05HAtFCRqjTE9VW4+BcDjaYsW/O2mMKSbfKMmLFAsVoowg9vfLYql
	 BbKaxjgjoYHeQ==
Date: Fri, 12 Apr 2024 14:47:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kbuild: buildtar: Add arm support
Message-ID: <20240412214747.GE2252629@dev-arch.thelio-3990X>
References: <e7c14a0d329e28bdcda21376b54a43c85a4aaf3f.1712682861.git.calvin@wbinvd.org>
 <20240410170450.GA1828262@dev-arch.thelio-3990X>
 <ZhcZCwMmANQS39s2@mozart.vkv.me>
 <ZhmKPlMl_WJOPIXs@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhmKPlMl_WJOPIXs@mozart.vkv.me>

On Fri, Apr 12, 2024 at 12:23:42PM -0700, Calvin Owens wrote:
> On Wednesday 04/10 at 15:56 -0700, Calvin Owens wrote:
> > On Wednesday 04/10 at 10:04 -0700, Nathan Chancellor wrote:
> > > Hi Calvin,
> > > 
> > > Thanks for the patch!
> > > 
> > > On Tue, Apr 09, 2024 at 10:17:07AM -0700, Calvin Owens wrote:
> > > > Make 'make tar-pkg' and friends work on 32-bit arm.
> > > > 
> > > > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > > 
> > > Technically speaking, buildtar works for 32-bit ARM right now (I use it
> > > almost daily), this is just explicitly adding it to the supported list
> > > to avoid the warning and putting zImage at vmlinuz-${KERNELRELEASE}
> > > instead of vmlinux-kbuild-${KERNELRELEASE}, right?
> > 
> > Exactly. I assumed (maybe incorrectly?) the vmlinux-kbuild-* name was
> > generic "unimplemented" filler that was meant to be replaced. It seems
> > like the vmlinuz-* naming has sort of become a de facto standard in the
> > tar-pkgs.

I think your first assumption is likely correct although I have not
looked back at the history to confirm that. I am not as sure on the
second statement, mainly just because not all kernel images are
compressed so they wouldn't necessarily make sense as vmlinuz. I think
it just happens that many of the most popular architectures have default
compressed kernel images.

> > The context for me is a pile of scripts that build kernels and boot them
> > with QEMU on arm and arm64: it's convenient if the tar-pkg structure is
> > consistent between the two (and across other architectures too).

Yes, I think including that reasoning in the commit message makes sense,
since it is justification for changing the status quo.

> > > That said, looks mostly fine to me, one comment below.
> > > 
> > > Before:
> > > 
> > >   './System.map' -> 'tar-install/boot/System.map-6.9.0-rc3-00023-g2c71fdf02a95'
> > >   '.config' -> 'tar-install/boot/config-6.9.0-rc3-00023-g2c71fdf02a95'
> > >   './vmlinux' -> 'tar-install/boot/vmlinux-6.9.0-rc3-00023-g2c71fdf02a95'
> > >   'arch/arm/boot/zImage' -> 'tar-install/boot/vmlinux-kbuild-6.9.0-rc3-00023-g2c71fdf02a95'
> > > 
> > >   ** ** **  WARNING  ** ** **
> > > 
> > >   Your architecture did not define any architecture-dependent files
> > >   to be placed into the tarball. Please add those to scripts/package/buildtar ...
> > > 
> > > After:
> > > 
> > >   './System.map' -> 'tar-install/boot/System.map-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
> > >   '.config' -> 'tar-install/boot/config-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
> > >   './vmlinux' -> 'tar-install/boot/vmlinux-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
> > >   './arch/arm/boot/zImage' -> 'tar-install/boot/vmlinuz-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
> > > 
> > > and the location of zImage is the only thing that changes as expected.
> > > 
> > > > ---
> > > >  scripts/package/buildtar | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/scripts/package/buildtar b/scripts/package/buildtar
> > > > index 72c91a1b832f..0939f9eabbf2 100755
> > > > --- a/scripts/package/buildtar
> > > > +++ b/scripts/package/buildtar
> > > > @@ -101,6 +101,9 @@ case "${ARCH}" in
> > > >  			fi
> > > >  		done
> > > >  		;;
> > > > +	arm)
> > > > +		[ -f "${objtree}/arch/arm/boot/zImage" ] && cp -v -- "${objtree}/arch/arm/boot/zImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> > > 
> > > While it probably does not matter too much, it would be more proper to
> > > make this
> > > 
> > >   [ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> > > 
> > > as the current line does not work with CONFIG_XIP_KERNEL=y, since zImage
> > > does not exist (KBUILD_IMAGE is arch/arm/boot/xipImage with this
> > > configuration)
> > > 
> > >   $ ls arch/arm/boot
> > >   compressed  dts  xipImage
> > > 
> > > resulting in buildtar failing because
> > > 
> > >   [ -f "${objtree}/arch/arm/boot/zImage" ]
> > > 
> > > fails and is the last statement that runs in the script (and the tar
> > > package is not really complete in this configuration anyways).
> > > 
> > > Prior to this change, the correct image would get placed into the
> > > tarball.
> > > 
> > >   'arch/arm/boot/xipImage' -> 'tar-install/boot/vmlinux-kbuild-6.9.0-rc3-00023-g2c71fdf02a95'
> > 
> > Makes sense, thanks. Although...
> > 
> > > > +		;;
> > > >  	*)
> > > >  		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
> > > >  		echo "" >&2
> > 
> > ...it ends up looking almost identical to the default case. Does it make
> > make more sense to change the destination in the default case and remove
> > the warning? I'm not sure if anything might rely on the current
> > behavior, it goes all the way back (git sha 6d983feab809).
> 
> What I'm trying to say is: using KBUILD_IMAGE like you suggest allows
> more of the existing cases to be combined, like the below (and probably
> alpha too, at least).

I see you already sent v2, which I will review shortly, but doing this
change certainly seems reasonable to me. We could add a comment above it
like

  # Architectures with just a compressed KBUILD_IMAGE

> ---8<---
> 
> diff --git a/scripts/package/buildtar b/scripts/package/buildtar
> index 72c91a1b832f..66b4d8d308b6 100755
> --- a/scripts/package/buildtar
> +++ b/scripts/package/buildtar
> @@ -54,8 +54,8 @@ cp -v -- "${objtree}/vmlinux" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
>  # Install arch-specific kernel image(s)
>  #
>  case "${ARCH}" in
> -	x86|i386|x86_64)
> -		[ -f "${objtree}/arch/x86/boot/bzImage" ] && cp -v -- "${objtree}/arch/x86/boot/bzImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> +	x86|i386|x86_64|arm)
> +		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
>  		;;
>  	alpha)
>  		[ -f "${objtree}/arch/alpha/boot/vmlinux.gz" ] && cp -v -- "${objtree}/arch/alpha/boot/vmlinux.gz" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"

