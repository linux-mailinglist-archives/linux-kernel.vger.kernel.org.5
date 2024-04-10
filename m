Return-Path: <linux-kernel+bounces-139509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84348A03CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8461F2BE63
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523CA46449;
	Wed, 10 Apr 2024 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="DC2eWuMQ"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618CE138E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789779; cv=none; b=B0VknyadpLShB1GqUF+HBMPYpfQ0MpxdmzQ7D3jmmFLS5YCgAGFcDgLFtLq++zoj0x4my0YsneOPsyuOUp+pLYy9+UKug66POtJTuIOlY40GcSj9Lvw7oyV6PZipWBpWmqIUL86uyULE0VAEl80O12vl1kHnX8e5/TF9iS/nkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789779; c=relaxed/simple;
	bh=zvMSGfeK4E88OHQT7uYLwGp9kAGs4M2gu86sn8vNqSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SybSzZv5mhQKvjRvLC4GU9bZBHiW9OMfKry+qqaSa5JkHQGxnvJR++N2+u5DnMNP4BxT3DTpcs0Lc9lmQrF+I8YnKO+W23pwkFjnI9L2NDGRk5d9l/coEN8HdyBlKgRP6yX3MMCdSVzOyoyDeFQ/xdFDjE88ruIRkHc39yfYfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=DC2eWuMQ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso40366839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1712789775; x=1713394575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GyxaHDyobyrHK29+TbdqhOwVCGCCLlNb/+pVnehXmoE=;
        b=DC2eWuMQYshdq2XQ5JOgnB8Jz0r+5p7gmrcPAlqVNjDMBp3dCg7yVimsHIqV49r/qz
         x9bPo93BsmjOg3CGkC/S7gybpD2x7d1oHvz8aJJQlCiFgMYV5dYrE9CLgdY8shW5nKl8
         HsVLkKpMiSSDu0WpukF50XhOXok/dMbK7gW9TBTecnmRzryyQd26eW0PyNfB8RXQs6Dd
         4I1a2ghoy08le04zpjD+L/0wAP/rTbV+gzo7okVzEGPl7lNRDkjBq+bcm2h7rciOwFm0
         TyIZ+5Ib8N1WGiahsv5uzWDIWAO04tmbqidL9zRZjonQ1cfxjhqKllhv6XVqL5hFGLE4
         /TTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712789775; x=1713394575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyxaHDyobyrHK29+TbdqhOwVCGCCLlNb/+pVnehXmoE=;
        b=C+ORC5v2lUi6mnnjc54pDe14QYNat7wLt6pqkJ62KzRNBMg2w4kC7GghVY0bu6GYXF
         rt5Ik++RpJc3WClLSVwRWUNgs5fdLe5qRAgaTW9a5cYCz6InciB+6k77fDxPS1XG0f68
         AyD+yZ3joUq8mk6n3uQpXGcqLsZtoJWMeGtWMsx1dMvdvjMOWTY/TB6UCE4eaRPgUEWj
         igeFi6q7SNpEDeQzUoYpsTJKx2gI5TIXrOcUTVyCoG+1MY7wJUmt8Mkx+WqLfii3tDEP
         OwNrNSpHw1bgw0yWRvH9N9ZnN7a3g6W0oZz0LLQOA0b27+DU+ZA1BmOSJMKBa4K6x4tV
         Q17w==
X-Gm-Message-State: AOJu0YxK1xSPyj3mWmDrhXT+4zt3oi3NFsRGNy+4SmXD0lVPTwUspo/m
	gy6w0bEs/ASgChH4uvFvJMJaLl3jO6UhVm7jTSzSE64Jgprewn4lymxUMsUQW/g=
X-Google-Smtp-Source: AGHT+IGEl72QKOeW1AXvy/BpZNjIpqR7N5c7VbgyHq91ltMDCBzHA+SYRnP5VADwFA+GLeftb3nGoA==
X-Received: by 2002:a05:6e02:60a:b0:368:8d92:3262 with SMTP id t10-20020a056e02060a00b003688d923262mr3790263ils.2.1712789775458;
        Wed, 10 Apr 2024 15:56:15 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.85])
        by smtp.gmail.com with ESMTPSA id j3-20020a635503000000b005e83b64021fsm72176pgb.25.2024.04.10.15.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 15:56:15 -0700 (PDT)
Date: Wed, 10 Apr 2024 15:56:11 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kbuild: buildtar: Add arm support
Message-ID: <ZhcZCwMmANQS39s2@mozart.vkv.me>
References: <e7c14a0d329e28bdcda21376b54a43c85a4aaf3f.1712682861.git.calvin@wbinvd.org>
 <20240410170450.GA1828262@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410170450.GA1828262@dev-arch.thelio-3990X>

On Wednesday 04/10 at 10:04 -0700, Nathan Chancellor wrote:
> Hi Calvin,
> 
> Thanks for the patch!
> 
> On Tue, Apr 09, 2024 at 10:17:07AM -0700, Calvin Owens wrote:
> > Make 'make tar-pkg' and friends work on 32-bit arm.
> > 
> > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> 
> Technically speaking, buildtar works for 32-bit ARM right now (I use it
> almost daily), this is just explicitly adding it to the supported list
> to avoid the warning and putting zImage at vmlinuz-${KERNELRELEASE}
> instead of vmlinux-kbuild-${KERNELRELEASE}, right?

Exactly. I assumed (maybe incorrectly?) the vmlinux-kbuild-* name was
generic "unimplemented" filler that was meant to be replaced. It seems
like the vmlinuz-* naming has sort of become a de facto standard in the
tar-pkgs.

The context for me is a pile of scripts that build kernels and boot them
with QEMU on arm and arm64: it's convenient if the tar-pkg structure is
consistent between the two (and across other architectures too).

> That said, looks mostly fine to me, one comment below.
> 
> Before:
> 
>   './System.map' -> 'tar-install/boot/System.map-6.9.0-rc3-00023-g2c71fdf02a95'
>   '.config' -> 'tar-install/boot/config-6.9.0-rc3-00023-g2c71fdf02a95'
>   './vmlinux' -> 'tar-install/boot/vmlinux-6.9.0-rc3-00023-g2c71fdf02a95'
>   'arch/arm/boot/zImage' -> 'tar-install/boot/vmlinux-kbuild-6.9.0-rc3-00023-g2c71fdf02a95'
> 
>   ** ** **  WARNING  ** ** **
> 
>   Your architecture did not define any architecture-dependent files
>   to be placed into the tarball. Please add those to scripts/package/buildtar ...
> 
> After:
> 
>   './System.map' -> 'tar-install/boot/System.map-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
>   '.config' -> 'tar-install/boot/config-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
>   './vmlinux' -> 'tar-install/boot/vmlinux-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
>   './arch/arm/boot/zImage' -> 'tar-install/boot/vmlinuz-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
> 
> and the location of zImage is the only thing that changes as expected.
> 
> > ---
> >  scripts/package/buildtar | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/scripts/package/buildtar b/scripts/package/buildtar
> > index 72c91a1b832f..0939f9eabbf2 100755
> > --- a/scripts/package/buildtar
> > +++ b/scripts/package/buildtar
> > @@ -101,6 +101,9 @@ case "${ARCH}" in
> >  			fi
> >  		done
> >  		;;
> > +	arm)
> > +		[ -f "${objtree}/arch/arm/boot/zImage" ] && cp -v -- "${objtree}/arch/arm/boot/zImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> 
> While it probably does not matter too much, it would be more proper to
> make this
> 
>   [ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> 
> as the current line does not work with CONFIG_XIP_KERNEL=y, since zImage
> does not exist (KBUILD_IMAGE is arch/arm/boot/xipImage with this
> configuration)
> 
>   $ ls arch/arm/boot
>   compressed  dts  xipImage
> 
> resulting in buildtar failing because
> 
>   [ -f "${objtree}/arch/arm/boot/zImage" ]
> 
> fails and is the last statement that runs in the script (and the tar
> package is not really complete in this configuration anyways).
> 
> Prior to this change, the correct image would get placed into the
> tarball.
> 
>   'arch/arm/boot/xipImage' -> 'tar-install/boot/vmlinux-kbuild-6.9.0-rc3-00023-g2c71fdf02a95'

Makes sense, thanks. Although...

> > +		;;
> >  	*)
> >  		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
> >  		echo "" >&2

..it ends up looking almost identical to the default case. Does it make
make more sense to change the destination in the default case and remove
the warning? I'm not sure if anything might rely on the current
behavior, it goes all the way back (git sha 6d983feab809).

Thanks,
Calvin

> > -- 
> > 2.39.2
> > 
> 
> Cheers,
> Nathan

