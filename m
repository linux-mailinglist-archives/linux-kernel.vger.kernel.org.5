Return-Path: <linux-kernel+bounces-121922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E088EF79
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2311F30E67
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B17515216B;
	Wed, 27 Mar 2024 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz9NlcMR"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA451E52C;
	Wed, 27 Mar 2024 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568860; cv=none; b=B/INiYfrM4kewBEAZfPi01lY5OUUub2a61tJACqet9V+bobc/40/yioRijDuUEFxMDUl8OuNSZ20ov/Zw5aYJIqbZArcXJQCfVR6lK1soSAwhOkuMx8wMs/jKaiG+l9rkQwmaOiPlXdN/FMJiqMkpmywvON1hwX1d2onFdNjlBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568860; c=relaxed/simple;
	bh=50zkMHpmeu2BXZaa+07J+qhchKV9JjzJT9oJd3EfDP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEPT+SEKG23oznkdlraynCNCGAg72dQJOsN0LjTziNoXUap6vMLKTS10GbGbtWC9VF/CgABnr41UGHsJcmkEutyeP+CngyH1QLkW+QYnwx1PMvwZyewmJJaywTv0nDJv7vTOVV14VFa0GWmK4VHS1louUgxUpqtJNY+HCLHTdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wz9NlcMR; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso183097b3a.1;
        Wed, 27 Mar 2024 12:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711568858; x=1712173658; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47u6Kb+FFTfEFpXFT9JPb5a2F34be35AHuX91vA9X/g=;
        b=Wz9NlcMRUIi7XRAfC1hhAyuUhDvJ69RnXWOSJTI8btujyydrz/NLwkw06LPVEtA1M0
         yehLnUybKHVgnKcdmURhQ9q6ze/RRZ8m/3GKT32xIIrbhju9IOgVawSAMsmElEczDI2s
         XEcAQK/fcHylzIrIlf/D8LwMhFHCoo2VpzJawOR9lbbwxBB3X2rvSL4HyzH6pF3O3hiU
         fbJU8PkJj0sR7KVOULyOYVMfx8u+6vmHgsD35Vg8NTBy9MCdFI7bvu7Y8psUvh+y4jn5
         qJ53WAdkI8GdE6NNTMuyaM1ojVb7X3rN8lGBvIdizkjX6sRdEqZ5aA2pV/qd14NwcieV
         DX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711568858; x=1712173658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47u6Kb+FFTfEFpXFT9JPb5a2F34be35AHuX91vA9X/g=;
        b=t4zocSDJGWqueDqfd3twZPslvday0OjkFx5FqII+UD6H/UwxC4U2udy+IPtgGD2iNU
         2CFnXPstgsl4xQeTJXwduL24XcZNcLS5rTwljMELQuINECUM7HjX6e4CzzoEW1lEecn2
         ehImA/w/jboGnVSCFBViHEa9gBrhlPk3+RMY22jftT+i7wA9B1c22dhYsKS89E4OHwp2
         1onJoMB8e6AUJy+6TUIzlr1qYepU1xnwcz0EUtkTtdtEE0Iur9qPuk9KlzP9gEOnWyQU
         VayXizFm1u+so21tfLWxV/DrM8Um+0ZKxDuuY6TzDujLKmiVGICvYdTQQz1+ynqkoV70
         OrrA==
X-Forwarded-Encrypted: i=1; AJvYcCV53T1UrGMdKb7EgXjBBMkj75OH4Owr1aRQN3RbwjSFFo6Lz7hDLsAJ7kopnH5D6e5iQfecCfVmU3v9xM05tdHIB+HCyx1HV8Qe4tN9IfmklCRYtv4CwXALEIoHVi/4Nztgj1vrT3kODg==
X-Gm-Message-State: AOJu0YxmGwf3hfsJMoDsAbQqtDKzTFw+wHkMmuHC58sob39WHRURkPmH
	jlsvBSyw6HNw1Mr83jxPmpmRD3n+YdLXgB9ISpHXK8jARvGRBuzb
X-Google-Smtp-Source: AGHT+IEQfNRHD1Wu4WA07A1SiDYhssQcEn6P/qXPngg8Y6jwqVWg3gKqrHY7Gy/BxzBXdeYOKCNlRQ==
X-Received: by 2002:a05:6a00:1ad3:b0:6ea:ba98:1b8 with SMTP id f19-20020a056a001ad300b006eaba9801b8mr275567pfv.7.1711568857566;
        Wed, 27 Mar 2024 12:47:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fn18-20020a056a002fd200b006e4e93f4f17sm8253857pfb.117.2024.03.27.12.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:47:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Mar 2024 12:47:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robh+dt@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lizhi Hou <lizhi.hou@xilinx.com>,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/2] of: create of_root if no dtb provided
Message-ID: <932e8cb7-1874-4c4a-8fee-bc0b9dffe94c@roeck-us.net>
References: <20230317053415.2254616-1-frowand.list@gmail.com>
 <20230317053415.2254616-2-frowand.list@gmail.com>
 <886049ed-4f5f-4e17-86f4-1245024ade3a@roeck-us.net>
 <CAL_JsqKsF53v7d7uZ3XT4kPFy-2FBWHfvKNSFdTx2oZhmSZkDA@mail.gmail.com>
 <66409df9-6f5f-4fbe-ae7f-47b86665c113@roeck-us.net>
 <CAL_Jsq+0JHTDmBPr94ZZF_5rtQg14q8OmWH6WpRspjHMX-MZmg@mail.gmail.com>
 <23ed5bbb-7616-424b-96ee-3fe1c6d8ca89@roeck-us.net>
 <CAL_JsqJd-upC4TgOwP5-DMXKL+x=X7sGC7qqiy2PTjD6pnSV7Q@mail.gmail.com>
 <407867d2-2e32-4df4-96ac-f9ae84b44375@roeck-us.net>
 <CAL_JsqJ2DijyKa-WSWdOszZt9UfQbb1MnD2zHh3ywntx6a=N+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJ2DijyKa-WSWdOszZt9UfQbb1MnD2zHh3ywntx6a=N+w@mail.gmail.com>

On Wed, Mar 27, 2024 at 01:38:13PM -0500, Rob Herring wrote:
> On Wed, Mar 27, 2024 at 9:40 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 3/27/24 06:11, Rob Herring wrote:
> > > On Wed, Mar 20, 2024 at 3:06 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >>
> > >> On 3/20/24 12:14, Rob Herring wrote:
> > >>> On Mon, Mar 18, 2024 at 4:31 PM Guenter Roeck <linux@roeck-us.net>
> > >>> wrote:
> > >>>>
> > >>>> On 3/18/24 12:26, Rob Herring wrote:
> > >>>>> +Stephen
> > >>>>>
> > >>>>> On Mon, Mar 18, 2024 at 12:09 PM Guenter Roeck <linux@roeck-us.net>
> > >>>>> wrote:
> > >>>>>>
> > >>>>>> Hi,
> > >>>>>>
> > >>>>>> On Fri, Mar 17, 2023 at 12:34:14AM -0500, Frank Rowand wrote:
> > >>>>>>> When enabling CONFIG_OF on a platform where of_root is not
> > >>>>>>> populated by firmware, we end up without a root node. In order to
> > >>>>>>> apply overlays and create subnodes of the root node, we need one.
> > >>>>>>> Create this root node by unflattening an empty builtin dtb.
> > >>>>>>>
> > >>>>>>> If firmware provides a flattened device tree (FDT) then the FDT is
> > >>>>>>> unflattened via setup_arch().  Otherwise setup_of(), which is
> > >>>>>>> called immediately after setup_arch(), will create the default root
> > >>>>>>> node if it does not exist.
> > >>>>>>>
> > >>>>>>> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> > >>>>>>
> > >>>>>> This patch results in a crash on nios2.
> > >>>>>
> > >>>>> This patch was never applied. I assume you meant a later version of
> > >>>>> it that did get applied.
> > >>>>>
> > >>>>>>
> > >>>>>> Building nios2:10m50-ghrd:10m50_defconfig:10m50_devboard.dts ...
> > >>>>>> running ...R failed (crashed)
> > >>>>>
> > >>>>> Booting with DT?
> > >>>>>
> > >>>>>> ------------ qemu log: earlycon: uart8250 at MMIO32 0x18001600
> > >>>>>> (options '') printk: legacy bootconsole [uart8250] enabled Linux
> > >>>>>> version 6.8.0-11409-gf6cef5f8c37f (groeck@desktop) (nios2-linux-gcc
> > >>>>>> (GCC) 11.4.0, GNU ld (GNU Binutils) 2.40) #1 Sun Mar 17 23:38:59 PDT
> > >>>>>> 2024 Kernel panic - not syncing: early_init_dt_alloc_memory_arch:
> > >>>>>> Failed to allocate 72 bytes align=0x40 ---[ end Kernel panic - not
> > >>>>>> syncing: early_init_dt_alloc_memory_arch: Failed to allocate 72
> > >>>>>> bytes align=0x40 ]---
> > >>>>>
> > >>>>> nios2 looks utterly broken to me. This change should be a nop unless
> > >>>>> initial_boot_params is NULL. It looks like it is possible for r6 (dtb
> > >>>>> address) to be 0 depending on kconfig options, but that would have
> > >>>>> skipped copying and unflattening which would then panic in
> > >>>>> setup_cpuinfo(). If initial_boot_params is not NULL, then the same
> > >>>>> early_init_dt_alloc_memory_arch() calls should fail when copying the
> > >>>>> DT. So I don't see how nios2 booting with DT ever worked.
> > >>>>>
> > >>>>
> > >>>> For nios2, in early_init_devtree():
> > >>>>
> > >>>> void __init early_init_devtree(void *params) { __be32 *dtb = (u32
> > >>>> *)__dtb_start; ...  if (be32_to_cpu((__be32) *dtb) == OF_DT_HEADER)
> > >>>> params = (void *)__dtb_start;
> > >>>>
> > >>>> That worked fine until this patch. Starting with this patch,
> > >>>> __dtb_start always points to a valid empty devicetree blob, which
> > >>>> overrides the devicetree blob passed to early_init_devtree(). This
> > >>>> causes the problem.
> > >>>
> > >>> With an external DTB, it doesn't boot with or without this patch. It
> > >>> just dies in different spots. Before it just skipped any memory
> > >>
> > >> No, that is incorrect.
> > >
> > > Well, I can tell you it doesn't boot for me. So I must be doing something
> > > different from your setup.
> > >
> >
> > Maybe you have OF_UNITTEST enabled and it indeed results in the problem you
> > mention below. I don't have it enabled because it produces various
> > backtraces which would hide real problems.
> 
> I thought of that, but I don't think I did. What I suspect is the external
> dtb is at address 0.
> 
> > >> Up to this patch it booted just fine with an external dtb using the
> > >> "-initrd" command line argument, and I explained to you above why this
> > >> is the case.
> > >
> > > What does -initrd have to do with anything? Does that shift where the
> > > external dtb is placed or something?
> > >
> >
> > Nothing. I meant to say -dtb.
> >
> > > I think I see the issue. __dtb_start points to the start of *all*
> > > built-in DTBs, not a specific one. In this case, arc, csky, loongarch,
> > > mips, openrisc, riscv, sh, and xtensa may all be broken too (if one picks
> > > the magic combination of booting modes and kconfig options). I
> >
> > No.
> >
> > - arc only picks the internal dtb if use_embedded_dtb is true. This flag is
> > only set if there is no external dtb, or if the external dtb does not
> > provide a valid machine description.
> 
> Right, but when it does pick the internal dtb, it is expecting its dtb at
> __dtb_start. What I'm saying is that's never been a good or safe assumption.
> We just happened to add another case to trigger it. The only reliable way to
> get a built-in DTB is if foo.dtb is built-in, then use __dtb_foo_begin to get
> its address. That's what some MIPS platforms with multiple DTBs do.
> 

I may be missing something, but it seems to me that most if not all
platforms with support for configurable built-in dtbs use __dtb_start
to get its address.

> > - openrisc only picks the internal dtb if no external dtb is provided.  -
> > riscv only picks the internal dtb if CONFIG_BUILTIN_DTB is enabled.  - sh
> > only used the internal dtb if CONFIG_USE_BUILTIN_DTB is enabled.  - xtensa
> > only picks the internal dtb if there is no external dtb.
> >
> > However, nios2 picks the internal dtb _even if_ an external dtb is provided
> > if there is an internal dtb. In other words, it prefers the internal dtb
> > over the external dtb. All other architectures prefer the external dtb over
> > the internal dtb.
> 
> Thanks for the analysis. I had started and abandoned common support (mostly
> Kconfig options) for built-in dtbs years ago. I decided against it because it
> is not something we want to encourage (as the boot dtb). In the meantime,
> we've gained new architectures that have added it. Sigh. So now I'm
> reconsidering something common (though not for v6.9).
> 
> >
> > > would expect all these cases have been broken forever if the DT unittest
> > > is enabled as it too adds a built-in dtb. But I would also
> >
> > Even if that is correct for nios2, that hardly seems to be an argument to
> > break nios2 boot with external dtb unconditionally.
> 
> That wasn't an argument for breaking it. Using an external dtb should really
> be the default and strongly preferred though.
> 
> I'm still not sure how to fix this easily for 6.9. Something like what
> microblaze does which puts the boot dtb under a consistent symbol name. Or
> perhaps we could iterate thru the built-in dtbs and skip ones without
> top-level compatible.
> 

I did submit a patch to only override the external dtb if support for the
internal dtb is enabled. I copied you on it, so you should have seen it.

https://lore.kernel.org/linux-kernel/20240322065419.162416-1-linux@roeck-us.net/

Maybe that is less than perfect, but it is minimalistic, and I didn't want
to change code behavior more than absolutely necessary without guidance
from the nios2 maintainer.

Guenter

