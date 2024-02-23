Return-Path: <linux-kernel+bounces-77717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F1C86096B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAC11C237D6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180CDD51B;
	Fri, 23 Feb 2024 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM+eaPCw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098C2CA5;
	Fri, 23 Feb 2024 03:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659147; cv=none; b=GSYt4AurziKNE3T0kOoqNTLAcfXLReSW5zlIlNc6Cp5IXdBLX6IwVPlUgN8Fk8b3DllZ7vbJjA2ws9xBNRgNl5/5LTEYkHVtt2TcgJZl3PeQlVDbHRDudQ6VaS5lujW07Zvg/ytzKCArJNJQlWIWND/HBSAYlaqkT9DamIBcapA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659147; c=relaxed/simple;
	bh=HQM0wsnwPouU65BfwTChkwlVKHGOwaT3dqDpl+nlGDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHwU5LHXznWdfN+RyTkg12OadkB3E8m1YzZnwzbRP3LSHEF16lXZTRIdbxEpm+rEYhRS/S6IaA//W4xHb3MEvmzeCJ+gbHNyHNE+5Foca2XCCRuS2czYVENdfXdOazvlWQE0aFmPeLqr4SViFtK5/ZXR+f4RJtnDWUgiB8jV2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM+eaPCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B335AC43390;
	Fri, 23 Feb 2024 03:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708659145;
	bh=HQM0wsnwPouU65BfwTChkwlVKHGOwaT3dqDpl+nlGDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KM+eaPCwttUR09OE0ZqmgM6Xp8FaxXr9Xh2+nRNbF4C86ALgVIWa5qEXqYhNHauRJ
	 /YjXcEYPxhVngldsJPq/LqfYDSLMk7yhLUc3hrzk4PNKmR11w3fcTSxObZyaAJhPKh
	 3pzxvqsZ3UJ2DBRxdAzSbLWKudV5ZREF5+bmZJMx9Uk/ZLg5pElvn5BgAEL86ZtXbg
	 HerTiGlqki4jtAyiqacjZTJVLOtrLjUtkWcjysLc9O85ddaA05GuIuqCiuiLXKSEOi
	 9w6bzhy1jFrGzMTfNF6HZQGRTrDuJ++cGNc4c7bqGYmLWviGpmhbEOloQQb8Cn/c0g
	 3dBu8cTnHYydg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512b3b04995so500715e87.3;
        Thu, 22 Feb 2024 19:32:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIIGLQyu4QNkJTZCswpYU5RaFkYnV6CPmqrVH5cnOu71KvniDQOO8wz1mOLGXArPwXkRjcs8HI0c2iBLnF2JXVI6+4IHFbr52BsT6DynMDz2/vMLISdNplYliD1cx6//zWCE8iaDj0p8Am
X-Gm-Message-State: AOJu0YxbQGEhahBMh62UiVpjXKaGUpnb+VPJGLMQ59Wc13oLWzNhX3og
	AeHdTBmUzQjCICo1wNKQ4ep/vHj5v1dJa6ZFetrY3hMZukTchal8MERW5NrOf1EJwydtwsVXdJR
	g7mcFNcz/+Nv/tYs5E1EhR0L6txc=
X-Google-Smtp-Source: AGHT+IF8CmRNYrVUNeXlMvx4sCf1lCJydSIXAPe6asI6L3JgZhpBJWiV1MCp1wMH7JLvwQG6WHLkYW+iuqWlQFNQXmc=
X-Received: by 2002:a05:6512:3e24:b0:512:cef7:4754 with SMTP id
 i36-20020a0565123e2400b00512cef74754mr758181lfv.5.1708659144143; Thu, 22 Feb
 2024 19:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <06e09da69e6c34d03a303c11088d9ffd@tfwno.gf>
In-Reply-To: <06e09da69e6c34d03a303c11088d9ffd@tfwno.gf>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 23 Feb 2024 12:31:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNARtPGSvihrOnhUXPEhw2o-q-UUtTx7xg7TVVby6KPTGXQ@mail.gmail.com>
Message-ID: <CAK7LNARtPGSvihrOnhUXPEhw2o-q-UUtTx7xg7TVVby6KPTGXQ@mail.gmail.com>
Subject: Re: make install doesn't install proper files for some architectures
To: ns@tfwno.gf
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:07=E2=80=AFAM <ns@tfwno.gf> wrote:
>
> Greetings,
>
> The kernel's build system has an install target. Most of the time this
> works fine, but it is limited to only one file, which can make it busted
> for some arches.
>
> One example of a target where it is busted is a generic ppc32 kernel,
> where there are plenty of supported platforms, some of which can boot
> perfectly fine through Open Firmware & some which are from bad, bad
> times o' yore where you had to embed the DT straight into the kernel. &
> some more on top of that. When you run make install for ppc32, it only
> installs the uncompressed vmlinux. This is almost certainly not the
> correct decision for _any_ of the platforms in question, & it totally
> leaves out the properly wrapped images that many of these platforms
> absolutely need in order to boot (e.g. PS3 & Wii, which need an image
> with an embedded DT).
>
> This is not really great. By contrast, the all target built all the
> specific images that my config selected. I didn't have to read the
> arch's boot Makefile to figure out what files I have to build. Is there
> any target which does the same but for installing every image the all
> target produced? It'd be a much better experience than leaving the
> details of every arch & bizzare platform supported by it up to (most
> likely incomplete) scripts, when the Makefiles already have all that
> information properly written. I suppose it'd also come in handy if e.g.
> x86 had a saner image format [1] in the future or something of the sort.
>
> [1]:
> https://source.denx.de/u-boot/u-boot/-/blob/master/doc/usage/fit/x86-fit-=
boot.rst




If you see scripts/install.sh, the second parameter
to 'installkernel' is ${KBUILD_IMAGE}.



arch Makefile can set the best image to install,
but there is no such code in arch/powerpc/Makefile.

Presumably, 'make install' will install the default
'vmlinux' for powerpc.






$ git grep KBUILD_IMAGE -- arch/
arch/arm/Makefile:KBUILD_IMAGE :=3D $(boot)/xipImage
arch/arm/Makefile:KBUILD_IMAGE :=3D $(boot)/zImage
arch/arm/Makefile:all:  $(notdir $(KBUILD_IMAGE))
arch/arm/Makefile:$(INSTALL_TARGETS): KBUILD_IMAGE =3D
$(boot)/$(patsubst %install,%Image,$@)
arch/arm64/Makefile:KBUILD_IMAGE        :=3D $(boot)/Image.gz
arch/arm64/Makefile:KBUILD_IMAGE        :=3D $(boot)/vmlinuz.efi
arch/arm64/Makefile:all:        $(notdir $(KBUILD_IMAGE))
arch/arm64/Makefile:install: KBUILD_IMAGE :=3D $(boot)/Image
arch/loongarch/Makefile:KBUILD_IMAGE    :=3D $(boot)/vmlinux.elf
arch/loongarch/Makefile:KBUILD_IMAGE    :=3D $(boot)/$(image-name-y).efi
arch/loongarch/Makefile:all:    $(notdir $(KBUILD_IMAGE)) $(KBUILD_DTBS)
arch/loongarch/Makefile:        $(Q)install -D -m 755 $(KBUILD_IMAGE)
$(INSTALL_PATH)/$(image-name-y)-$(KERNELRELEASE)
arch/m68k/Makefile:install: KBUILD_IMAGE :=3D vmlinux.gz
arch/mips/boot/compressed/Makefile:$(obj)/vmlinux.bin: $(KBUILD_IMAGE) FORC=
E
arch/nios2/Makefile:KBUILD_IMAGE :=3D $(nios2-boot)/vmImage
arch/nios2/Makefile:  echo  '* vmImage         - Kernel-only image for
U-Boot ($(KBUILD_IMAGE))'
arch/parisc/Makefile:KBUILD_IMAGE :=3D $(boot)/bzImage
arch/parisc/Makefile:install: KBUILD_IMAGE :=3D vmlinux
arch/parisc/Makefile:zinstall: KBUILD_IMAGE :=3D vmlinuz
arch/riscv/Makefile:KBUILD_IMAGE :=3D $(boot)/xipImage
arch/riscv/Makefile:KBUILD_IMAGE        :=3D $(boot)/Image.gz
arch/riscv/Makefile:KBUILD_IMAGE :=3D $(boot)/loader.bin
arch/riscv/Makefile:KBUILD_IMAGE :=3D $(boot)/Image.gz
arch/riscv/Makefile:KBUILD_IMAGE :=3D $(boot)/vmlinuz.efi
arch/riscv/Makefile:all:        $(notdir $(KBUILD_IMAGE))
arch/riscv/Makefile:install: KBUILD_IMAGE :=3D $(boot)/Image
arch/riscv/Makefile:zinstall: KBUILD_IMAGE :=3D $(boot)/Image.gz
arch/s390/Makefile:#KBUILD_IMAGE is necessary for packaging targets
like rpm-pkg, deb-pkg...
arch/s390/Makefile:KBUILD_IMAGE :=3D $(boot)/bzImage
arch/sh/Makefile:KBUILD_IMAGE           :=3D $(boot)/$(defaultimage-y)
arch/sh/Makefile:all: $(notdir $(KBUILD_IMAGE))
arch/sparc/Makefile:KBUILD_IMAGE :=3D $(boot)/zImage
arch/x86/Makefile:# KBUILD_IMAGE specify target image being built
arch/x86/Makefile:KBUILD_IMAGE :=3D $(boot)/bzImage
arch/x86/Makefile:      $(Q)$(MAKE) $(build)=3D$(boot) $(KBUILD_IMAGE)




--=20
Best Regards
Masahiro Yamada

