Return-Path: <linux-kernel+bounces-143249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CD68A364A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1BA1F23B72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F44A14F9ED;
	Fri, 12 Apr 2024 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="GAtsDFU/"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87256446BD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949831; cv=none; b=ht5BePAUO8+9zQhA3DC5cobgUwWRmPjS7/Bueacie1YOmAqrubgAYjqf8rvo3sHiKBm0PsZpUZ/LfIlxljhCWdeakFDODy0S814syhbxnLp7xHxy3wjcgASkzJTZQRrouOEGUfAlA6Bsiooy16rQddOQg9kA9Uj/3uMIMPvgQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949831; c=relaxed/simple;
	bh=rWrvxqm8dHbeMR8WrCiwg+HJ9k1NQpNEXDE12y/cVJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0yXnUitfBBp4tGJ89vavArUOKM0+muCR+Ljy9PGP+EM6iM1Q+aGAO/Zk22WJvZ5O7GlmxgvNKqO7X7EJswDOZUdI/PbEpuZYtM/yW54vocsHyvzlPv2SKumXxb+YF8uOkNyL0kmLPZREFANfjS19Xe3Xs5Kt02pDI3ZEYoGGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=GAtsDFU/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecee443c79so182396b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1712949828; x=1713554628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MuDDhdBpGWAW71fus2nLMnzxDNNjMThzumbpweOo2VI=;
        b=GAtsDFU/eIuWDC1SerweAxzsPHC/hvIcc9AnOTM2ys2GR8rX9QeoT5d+A/4BXP7twU
         ccu/oB54ZeLEIHA5+YfmCp6G13cO94Pxs4C5mzPZZ1u9X3xxUmNDf3RI/uUwdN+RpQ21
         UtQ9BK0zLvaeIm3cMMNMkl6XK5CO+iDzlnWDY0zO5iHy53cPQFKalEaNrzcLxfydOZyG
         6aGs30qazZWI9OzL6b9Y6kLs0W2BQSKCCWDLJ/9IOmVisiHeVYhlCD3Id0dePGUMrti1
         Tw8D7yT/aNyAEc1AlFKqBxllWjTRMpy4Q6z2TBNzdOGEYH2OYcD3IU9nNQFd+J7ct4/J
         f8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712949828; x=1713554628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuDDhdBpGWAW71fus2nLMnzxDNNjMThzumbpweOo2VI=;
        b=RdBAQKEK2golj3VKL4z979QiARqop2FXND3KrAQm/PjQgRwrNIHewrD3KTLpkYtTVk
         vcxPLm1bydpWnsajRC3MjunCU2zhbGIZ7x8XsHfF8Og8GobHd6a03btH2AaVm4Hz0I/w
         8pdFMR6gRzLpb53mbpGD/PJuFWgQwoostaZs0LE/DI4fo6i0b49UHrttZZLvpTdXfaDI
         rkI9dyHjQZrEdRELZt1lOjJjooQeFNCEvMlRMaWGjYw/egHO0NP5rwayOsrzl4pABvrw
         RKpcQbdnvoEvS9rOnnSLeND/Tj+MIo9b+ddclniG5qMot8RuQjXXwQb5JTWhJ0rAjWvP
         uIxg==
X-Gm-Message-State: AOJu0YyMblGQar23Gsit8tCQOqgn/kQPyIpamzrRZeILYKUorCqssBIe
	BDI6iqZPqUIcRWoE8HRygXSHlkKBLsn2bjdt8TTd/O2K7FfySmk49Q/84Q8EJDA=
X-Google-Smtp-Source: AGHT+IFwve24o4llz0ETmlp9AFQjC71/8w7y0IIgcx6YF5jsklg4uTsDSHXpAgomIyTqukPkEQQ+eg==
X-Received: by 2002:a05:6a20:a110:b0:1a9:a033:7327 with SMTP id q16-20020a056a20a11000b001a9a0337327mr3603211pzk.3.1712949827668;
        Fri, 12 Apr 2024 12:23:47 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.85])
        by smtp.gmail.com with ESMTPSA id je14-20020a170903264e00b001e22e8a859asm3358624plb.108.2024.04.12.12.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 12:23:47 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:23:42 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kbuild: buildtar: Add arm support
Message-ID: <ZhmKPlMl_WJOPIXs@mozart.vkv.me>
References: <e7c14a0d329e28bdcda21376b54a43c85a4aaf3f.1712682861.git.calvin@wbinvd.org>
 <20240410170450.GA1828262@dev-arch.thelio-3990X>
 <ZhcZCwMmANQS39s2@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhcZCwMmANQS39s2@mozart.vkv.me>

On Wednesday 04/10 at 15:56 -0700, Calvin Owens wrote:
> On Wednesday 04/10 at 10:04 -0700, Nathan Chancellor wrote:
> > Hi Calvin,
> > 
> > Thanks for the patch!
> > 
> > On Tue, Apr 09, 2024 at 10:17:07AM -0700, Calvin Owens wrote:
> > > Make 'make tar-pkg' and friends work on 32-bit arm.
> > > 
> > > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > 
> > Technically speaking, buildtar works for 32-bit ARM right now (I use it
> > almost daily), this is just explicitly adding it to the supported list
> > to avoid the warning and putting zImage at vmlinuz-${KERNELRELEASE}
> > instead of vmlinux-kbuild-${KERNELRELEASE}, right?
> 
> Exactly. I assumed (maybe incorrectly?) the vmlinux-kbuild-* name was
> generic "unimplemented" filler that was meant to be replaced. It seems
> like the vmlinuz-* naming has sort of become a de facto standard in the
> tar-pkgs.
> 
> The context for me is a pile of scripts that build kernels and boot them
> with QEMU on arm and arm64: it's convenient if the tar-pkg structure is
> consistent between the two (and across other architectures too).
> 
> > That said, looks mostly fine to me, one comment below.
> > 
> > Before:
> > 
> >   './System.map' -> 'tar-install/boot/System.map-6.9.0-rc3-00023-g2c71fdf02a95'
> >   '.config' -> 'tar-install/boot/config-6.9.0-rc3-00023-g2c71fdf02a95'
> >   './vmlinux' -> 'tar-install/boot/vmlinux-6.9.0-rc3-00023-g2c71fdf02a95'
> >   'arch/arm/boot/zImage' -> 'tar-install/boot/vmlinux-kbuild-6.9.0-rc3-00023-g2c71fdf02a95'
> > 
> >   ** ** **  WARNING  ** ** **
> > 
> >   Your architecture did not define any architecture-dependent files
> >   to be placed into the tarball. Please add those to scripts/package/buildtar ...
> > 
> > After:
> > 
> >   './System.map' -> 'tar-install/boot/System.map-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
> >   '.config' -> 'tar-install/boot/config-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
> >   './vmlinux' -> 'tar-install/boot/vmlinux-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
> >   './arch/arm/boot/zImage' -> 'tar-install/boot/vmlinuz-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
> > 
> > and the location of zImage is the only thing that changes as expected.
> > 
> > > ---
> > >  scripts/package/buildtar | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/scripts/package/buildtar b/scripts/package/buildtar
> > > index 72c91a1b832f..0939f9eabbf2 100755
> > > --- a/scripts/package/buildtar
> > > +++ b/scripts/package/buildtar
> > > @@ -101,6 +101,9 @@ case "${ARCH}" in
> > >  			fi
> > >  		done
> > >  		;;
> > > +	arm)
> > > +		[ -f "${objtree}/arch/arm/boot/zImage" ] && cp -v -- "${objtree}/arch/arm/boot/zImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> > 
> > While it probably does not matter too much, it would be more proper to
> > make this
> > 
> >   [ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> > 
> > as the current line does not work with CONFIG_XIP_KERNEL=y, since zImage
> > does not exist (KBUILD_IMAGE is arch/arm/boot/xipImage with this
> > configuration)
> > 
> >   $ ls arch/arm/boot
> >   compressed  dts  xipImage
> > 
> > resulting in buildtar failing because
> > 
> >   [ -f "${objtree}/arch/arm/boot/zImage" ]
> > 
> > fails and is the last statement that runs in the script (and the tar
> > package is not really complete in this configuration anyways).
> > 
> > Prior to this change, the correct image would get placed into the
> > tarball.
> > 
> >   'arch/arm/boot/xipImage' -> 'tar-install/boot/vmlinux-kbuild-6.9.0-rc3-00023-g2c71fdf02a95'
> 
> Makes sense, thanks. Although...
> 
> > > +		;;
> > >  	*)
> > >  		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
> > >  		echo "" >&2
> 
> ...it ends up looking almost identical to the default case. Does it make
> make more sense to change the destination in the default case and remove
> the warning? I'm not sure if anything might rely on the current
> behavior, it goes all the way back (git sha 6d983feab809).

What I'm trying to say is: using KBUILD_IMAGE like you suggest allows
more of the existing cases to be combined, like the below (and probably
alpha too, at least).

Thanks,
Calvin

---8<---

diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index 72c91a1b832f..66b4d8d308b6 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -54,8 +54,8 @@ cp -v -- "${objtree}/vmlinux" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
 # Install arch-specific kernel image(s)
 #
 case "${ARCH}" in
-	x86|i386|x86_64)
-		[ -f "${objtree}/arch/x86/boot/bzImage" ] && cp -v -- "${objtree}/arch/x86/boot/bzImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
+	x86|i386|x86_64|arm)
+		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
 		;;
 	alpha)
 		[ -f "${objtree}/arch/alpha/boot/vmlinux.gz" ] && cp -v -- "${objtree}/arch/alpha/boot/vmlinux.gz" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"

