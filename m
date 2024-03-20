Return-Path: <linux-kernel+bounces-109330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC28F8817B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4475C1F22D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A10585636;
	Wed, 20 Mar 2024 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu77r8Kx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE48527E;
	Wed, 20 Mar 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962069; cv=none; b=i3anSFpTcglSKPYhtANZuKSkCTixDGHuhNZt9Z/ljD8miVcjX26ajSspB7fjPE/2/7O83vIxT1hV4ZmR6nedxPZzLKxFYipg1bokSMqBMN5BJtQihEdyaI4M3CUC4U2OLW3MQQyO+ysaxH88sXTgI7Uj9KA1DJjpVxUxUCVNCxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962069; c=relaxed/simple;
	bh=vdStA58m6oWiq0YPE3E6Jl0PhdD4tzGOlQ3v2Yf0374=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKmd0zXi3VdH2qdnf0KqO3yZKN6TCpiikWuY4BG9j8hsXFBi7J0WbFbWwRLTTD86OBadwZYAg44544Brsd8d/QbgBsV8NHav3SMk0F7sajMOwK6LguH9aQVrmj25r97aogHo4qo56aCyflQQvo1zfLUPMeunxpSLVd9aH/Oelg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu77r8Kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3089C433C7;
	Wed, 20 Mar 2024 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710962068;
	bh=vdStA58m6oWiq0YPE3E6Jl0PhdD4tzGOlQ3v2Yf0374=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gu77r8Kxbp07AAMvWBsTv//Mru9P/hLWuCtGKeT1YAjqJko2pfrpTXnOX58Vj3FPs
	 A9JD+OtOUNKk9ursQk7H5bkNCMbV4qSSphr6zpbE+Fg4suuNQbjezFvnhb51/I+9+Y
	 ioSDn3Hggpn6/pCbAjf6thBev6YywlZ7f2dedU0esQmB+knZQuKUyPOSomsPc18d78
	 iuSr5LLOFdd9mkH3+A6uk7ZVZvQaNNbgE5AzAVlwzLPOx1SICieaM2ZhFg90G7/NtR
	 D+alrjePK4MM0LiCM7yTUAyavONDokRGwiYHTmdhuy4aOoc2WJbCJ4Nh7AS5ZVHqK0
	 BcTFTMq18CrYQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513e89d0816so296919e87.0;
        Wed, 20 Mar 2024 12:14:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUohNQ+z484ilAA6p+NzwtZGo+hE0OHb75H70Jb5y4PfGCFa5OtQXD43nyACzrtSsPRL4PL+L4+7hA3H0Z9JlajXqAx52QY+lYNqw3sqwdis2N7ZoQp+ZPrrNnRbHIZvPkbyZReZWfC/w==
X-Gm-Message-State: AOJu0Yzk0No6chaLftt4FNG8QHoorAx1u033mF4RKxbqJEkhlzCM9POx
	Fc106TpjFEcPJ1UjjnW6toSsVwSOl/2yajgp5zMnmR7iGzaS4jT/oD6cBkIhpeWLx/2uqnVxIii
	sWUbxBYv8X9B8QGHHVl5tbDPkkA==
X-Google-Smtp-Source: AGHT+IFI9fLeJlIFi6fxeDLBoqwvE4TgyRBpj1IFM/gAiXp/lJ+A0PnSQ+FgKh3zALXla6OFqxpDuM4Zp6O2TsUNIRc=
X-Received: by 2002:ac2:5f94:0:b0:514:c829:13b3 with SMTP id
 r20-20020ac25f94000000b00514c82913b3mr4315562lfe.32.1710962067220; Wed, 20
 Mar 2024 12:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230317053415.2254616-1-frowand.list@gmail.com>
 <20230317053415.2254616-2-frowand.list@gmail.com> <886049ed-4f5f-4e17-86f4-1245024ade3a@roeck-us.net>
 <CAL_JsqKsF53v7d7uZ3XT4kPFy-2FBWHfvKNSFdTx2oZhmSZkDA@mail.gmail.com> <66409df9-6f5f-4fbe-ae7f-47b86665c113@roeck-us.net>
In-Reply-To: <66409df9-6f5f-4fbe-ae7f-47b86665c113@roeck-us.net>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 20 Mar 2024 14:14:14 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+0JHTDmBPr94ZZF_5rtQg14q8OmWH6WpRspjHMX-MZmg@mail.gmail.com>
Message-ID: <CAL_Jsq+0JHTDmBPr94ZZF_5rtQg14q8OmWH6WpRspjHMX-MZmg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] of: create of_root if no dtb provided
To: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Boyd <sboyd@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lizhi Hou <lizhi.hou@xilinx.com>, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 4:31=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 3/18/24 12:26, Rob Herring wrote:
> > +Stephen
> >
> > On Mon, Mar 18, 2024 at 12:09=E2=80=AFPM Guenter Roeck <linux@roeck-us.=
net> wrote:
> >>
> >> Hi,
> >>
> >> On Fri, Mar 17, 2023 at 12:34:14AM -0500, Frank Rowand wrote:
> >>> When enabling CONFIG_OF on a platform where of_root is not populated =
by
> >>> firmware, we end up without a root node. In order to apply overlays a=
nd
> >>> create subnodes of the root node, we need one. Create this root node
> >>> by unflattening an empty builtin dtb.
> >>>
> >>> If firmware provides a flattened device tree (FDT) then the FDT is
> >>> unflattened via setup_arch().  Otherwise setup_of(), which is called
> >>> immediately after setup_arch(), will create the default root node
> >>> if it does not exist.
> >>>
> >>> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> >>
> >> This patch results in a crash on nios2.
> >
> > This patch was never applied. I assume you meant a later version of it
> > that did get applied.
> >
> >>
> >> Building nios2:10m50-ghrd:10m50_defconfig:10m50_devboard.dts ... runni=
ng ...R failed (crashed)
> >
> > Booting with DT?
> >
> >> ------------
> >> qemu log:
> >> earlycon: uart8250 at MMIO32 0x18001600 (options '')
> >> printk: legacy bootconsole [uart8250] enabled
> >> Linux version 6.8.0-11409-gf6cef5f8c37f (groeck@desktop) (nios2-linux-=
gcc (GCC) 11.4.0, GNU ld (GNU Binutils) 2.40) #1 Sun Mar 17 23:38:59 PDT 20=
24
> >> Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Failed to=
 allocate 72 bytes align=3D0x40
> >> ---[ end Kernel panic - not syncing: early_init_dt_alloc_memory_arch: =
Failed to allocate 72 bytes align=3D0x40 ]---
> >
> > nios2 looks utterly broken to me. This change should be a nop unless
> > initial_boot_params is NULL. It looks like it is possible for r6 (dtb
> > address) to be 0 depending on kconfig options, but that would have
> > skipped copying and unflattening which would then panic in
> > setup_cpuinfo(). If initial_boot_params is not NULL, then the same
> > early_init_dt_alloc_memory_arch() calls should fail when copying the
> > DT. So I don't see how nios2 booting with DT ever worked.
> >
>
> For nios2, in early_init_devtree():
>
> void __init early_init_devtree(void *params)
> {
>          __be32 *dtb =3D (u32 *)__dtb_start;
>         ...
>          if (be32_to_cpu((__be32) *dtb) =3D=3D OF_DT_HEADER)
>                  params =3D (void *)__dtb_start;
>
> That worked fine until this patch. Starting with this patch, __dtb_start
> always points to a valid empty devicetree blob, which overrides the
> devicetree blob passed to early_init_devtree(). This causes the problem.

With an external DTB, it doesn't boot with or without this patch. It
just dies in different spots. Before it just skipped any memory
allocs. With 'CONFIG_NIOS2_DTB_SOURCE=3D"10m50_devboard.dts"', it boots
fine for me with or without this patch. This is what I'm running:

qemu-system-nios2 -kernel .build-nios2/vmlinux -nographic -dtb
build-nios2/arch/nios2/boot/dts/10m50_devboard.dtb -append
"earlycon=3Duart8250,mmio32,0x18001600,115200n8"

Rob

