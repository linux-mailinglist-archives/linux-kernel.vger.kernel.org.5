Return-Path: <linux-kernel+bounces-29531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AED830FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C8C2816A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31382563F;
	Wed, 17 Jan 2024 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq+tm3DN"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE7E24B25;
	Wed, 17 Jan 2024 23:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532664; cv=none; b=DqULi21dzRcHKB26eUT3rxMQAfq5hImIl5jh7WDgpLizyVpSaMjRy0NxKfg09sNXSinJIB6PZYOYPGbqibdnVirTsTm5+4boSe31QxV26oz/KdAq2tim/2xrkolGVaXRooo6jHopXBAh0o0cIZ+P2OtDfCQIMEEiXJ6I81qfH3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532664; c=relaxed/simple;
	bh=wXVonUxeD2ai6nHHr0EMoXrBCxKGe8NKsIPxwhj2VwM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=D0lTncGSI0XutDiU8lj2apybDdGYZWbaEoehHHMrZrUHlvfMwYQukdQMyhBDecWVjZ3fc8HySqX/9KYIQxrmOnTaFWJxJzZ+cnEcVhH1sVswzAkUZtkTuDRhUieHeIGtFKRFBr8TekybtVLkHWB63TwlAaT0e5+cih3dh8gDCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iq+tm3DN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e8f710d44so2033205e9.3;
        Wed, 17 Jan 2024 15:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705532661; x=1706137461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P9Tq0+VI5CEr6uk7/Ro+mbe/sL1gYF6tkxHkvmpyY0Q=;
        b=Iq+tm3DNpSpnqqHhNATQJuTFwzxEBEojLfeB8tlJF7ffdDy//jsSPEZlXXJsAZIfUm
         7E0kgUy2a0NrlJY2L3UYiUHlfGEQ5rWfkOs7XzsvsPR4AdISDuR8OLfROFbnpzbZBHjk
         cgtgxag93wJ7za+Kk8j5u/lrNsoiQV7rVmi3ywrEITNC91f2WsR2WOY9aFUvcD2YlRke
         I2NguY6UOXFMBO7ogZl9LPSVSUr3/cEz83I8ZoGHWC15IOfKO6BWI+acv7Z6if5x2mM6
         p0AV+GHi9gnr6FdV2m0zNGlnHVsdX3aJRnHpTxgRj4/XJ2/HppboCUi3i1nFpfaqkZm/
         mtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705532661; x=1706137461;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9Tq0+VI5CEr6uk7/Ro+mbe/sL1gYF6tkxHkvmpyY0Q=;
        b=bskXVdoJDYMC+pKRJN8P9/0t+Ufz/78cLyXslQddkfFyaf6yCj+xZuwvWMog7be3+g
         Na0y/zAIEiJVENkQ4Q5Kq0pY0YoSwhVFCVWEg39EBCmOjp1qKvbvyhqPow100ILVKSrL
         01aXKFCifvMV3YcczSvVk5MkM3G/EsBPBxdVYHuyBbBMrOA8SPQ/IhZ5Kr1u3akh+sF7
         j7GAvJdiGSiUqUI9AoLyOs+XCFcVjvJyk4FTJyHoVztUHTrQ0PABPD+42Qu9W/4u+A8U
         QmxtZSZgGZsi88ZVbcJy9s1rQRlR4NPofLZlTzpnvL2MwU3K10tQvK/hhiFEeEXq60YQ
         mucg==
X-Gm-Message-State: AOJu0YxN9KCZIRvR/LCMGMCXQ21sZ+aYY0wtSqL2E92LsLmgfKw42h27
	umDg3KXB5u8/LsZRWQQPr8o=
X-Google-Smtp-Source: AGHT+IE2xjge4UH9rYyWqY52nTgwOx6Sr0Yug2vyNPuBXZRC11gOcQQp4pTRXzBmiNJ+K2nfpB6e2w==
X-Received: by 2002:a05:600c:6a03:b0:40e:5808:53f9 with SMTP id jj3-20020a05600c6a0300b0040e580853f9mr5086488wmb.73.1705532660659;
        Wed, 17 Jan 2024 15:04:20 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id m17-20020adffa11000000b00336c6b77584sm2613221wrr.91.2024.01.17.15.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 15:04:19 -0800 (PST)
Message-ID: <65a85cf3.df0a0220.9615c.a798@mx.google.com>
X-Google-Original-Message-ID: <ZahYwII7E_zAz_X-@Ansuel-xps.>
Date: Wed, 17 Jan 2024 23:46:24 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Russell King <linux@armlinux.org.uk>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Nick Hawkins <nick.hawkins@hpe.com>,
	John Crispin <john@phrozen.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] ARM: mach-qcom: fix support for ipq806x
References: <20221021181016.14740-1-ansuelsmth@gmail.com>
 <CACRpkdbfvr1pkVb3XhBZLnmn7vy3XyzavwVjW_VmFKTdh3LABQ@mail.gmail.com>
 <63531543.050a0220.b6bf5.284d@mx.google.com>
 <CACRpkdbOQq9hUT=d1QBDMmgLaJ1wZ=hd44ciMnjFVgpLCnK8Wg@mail.gmail.com>
 <6357240c.170a0220.999b2.23d6@mx.google.com>
 <CACRpkdb4iqazgVerHCPU0VqZKYoB5kJeDSaL+ek67L=2Txem-A@mail.gmail.com>
 <65a7d352.050a0220.ee5cf.f69f@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a7d352.050a0220.ee5cf.f69f@mx.google.com>

On Wed, Jan 17, 2024 at 02:17:03PM +0100, Christian Marangi wrote:
> On Wed, Oct 26, 2022 at 10:19:21AM +0200, Linus Walleij wrote:
> > On Tue, Oct 25, 2022 at 1:47 AM Christian Marangi <ansuelsmth@gmail.com> wrote:
> > 
> > > bad news... yesterday I tested this binding and it's problematic. It
> > > does work and the router correctly boot...
> > 
> > That's actually partly good news :D
> 
> Hi,
> sorry for the necroposting but I got some time and wanted to fix and
> bisect this for good since IPQ806x is finally in a better shape and is
> actually modern enough.
> 
> > 
> > > problem is that SMEM is
> > > broken with such configuration... I assume with this binding, by the
> > > system view ram starts from 0x42000000 instead of 0x40000000 and this
> > > cause SMEM to fail probe with the error "SBL didn't init SMEM".
> > 
> > We need to fix this.
> > 
> 
> Totally but I think the problem is more deep...
> 
> > > This is the location of SMEM entry in ram
> > >
> > >                 smem: smem@41000000 {
> > >                         compatible = "qcom,smem";
> > >                         reg = <0x41000000 0x200000>;
> > >                         no-map;
> > >
> > >                         hwlocks = <&sfpb_mutex 3>;
> > >                 };
> > (...)
> > > Wonder if you have other ideas about this.
> > 
> > So the problem is that the resource is outside of the system RAM?
> > 
> > I don't understand why that triggers it since this is per definition not
> > system RAM, it is SMEM after all. And it is no different in esssence
> > from any memory mapped IO or other things that are outside of
> > the system RAM.
> > 
> > The SMEM node is special since it is created without children thanks
> > to the hack in drivers/of/platform.c.
> > 
> > Then the driver in drivers/soc/qcom/smem.c
> > contains things like this:
> > 
> >         rmem = of_reserved_mem_lookup(pdev->dev.of_node);
> >         if (rmem) {
> >                 smem->regions[0].aux_base = rmem->base;
> >                 smem->regions[0].size = rmem->size;
> >         } else {
> >                 /*
> >                  * Fall back to the memory-region reference, if we're not a
> >                  * reserved-memory node.
> >                  */
> >                 ret = qcom_smem_resolve_mem(smem, "memory-region",
> > &smem->regions[0]);
> >                 if (ret)
> >                         return ret;
> >         }
> > 
> > However it is treated as memory-mapped IO later:
> > 
> >         for (i = 1; i < num_regions; i++) {
> >                 smem->regions[i].virt_base = devm_ioremap_wc(&pdev->dev,
> > 
> > smem->regions[i].aux_base,
> > 
> > smem->regions[i].size);
> >                 if (!smem->regions[i].virt_base) {
> >                         dev_err(&pdev->dev, "failed to remap %pa\n",
> > &smem->regions[i].aux_base);
> >                         return -ENOMEM;
> >                 }
> >         }
> > 
> > As a first hack I would check:
> > 
> > 1. Is it the of_reserved_mem_lookup() or qcom_smem_resolve_smem() stuff
> >    in drivers/soc/qcom/smem.c that is failing?
> > 
> > If yes then:
> > 
> > 2. Add a fallback path just using of_iomap(node) for aux_base and size
> >   with some comment like /* smem is outside of the main memory map */
> >   and see if that works.
> >
> 
> I think we got confused and we didn't read the code correctly. The
> error is "SMEM is not initialized by SBL" that is triggered by...
> 
> 	header = smem->regions[0].virt_base;
> 	if (le32_to_cpu(header->initialized) != 1 ||
> 	    le32_to_cpu(header->reserved)) {
> 		dev_err(&pdev->dev, "SMEM is not initialized by SBL\n",);
> 		return -EINVAL;
> 	}
> 
> I verified correctly that aux_base and size are the correct values
> 0x41000000 and 0x200000. And from what I can see they get correctly
> iomapped.
> 
> Problem is that initialized and reserved have garbage in it. (not random
> data tho but everytime the same data)
> 
> My theory is that somehow the loader is still writing data there but I'm
> a bit lost on how to verify that. (the fact that the data in those
> values is always the same with the same compiled image makes me think
> it's actually just loaded data)
> 
> I also tested with disabling the CONFIG_ARM_ATAG_DTB_COMPAT flag but I
> have the same result.
> 
> What I'm using is this memory node
> 
> 	memory@0 {
> 		reg = <0x42000000 0x1e000000>;
> 		device_type = "memory";
> 	};
> 
> And in chosed I have
> 
> 	chosen {
> 		bootargs = "earlycon";
>                 linux,usable-memory-range = <0x42000000 0x10000000>;
> 	};
> 
> (the size is different just for the sake of it but it should not cause
> problem right?)
> 
> Maybe there is a way to make the SMEM reclaim those RAM space and reinit
> it? (it's a workaround tho)
> 
> Also with the current situation the kernel panics with... But I assume
> this is caused by SMEM malfunctioning (the panic happen right after rpm
> init when the RPM regulators are getting init. Looking at the affected
> codes maybe it's failing at the "Free unused pages" stage?
> 
> [    1.912392] 8<--- cut here ---
> [    1.912431] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [    1.914356] [00000000] *pgd=00000000
> [    1.922676] Internal error: Oops: 80000007 [#1] SMP ARM
> [    1.926158] Modules linked in:
> [    1.931103] CPU: 1 PID: 84 Comm: modprobe Not tainted 6.1.65 #0
> [    1.934229] Hardware name: Generic DT based system
> [    1.940045] PC is at 0x0
> [    1.944902] LR is at release_pages+0x114/0x36c
> [    1.947595] pc : [<00000000>]    lr : [<c04298dc>]    psr: 40000013
> [    1.951851] sp : c27abe18  ip : c13cd5c1  fp : c27abe38
> [    1.958012] r10: 0000009c  r9 : c4018268  r8 : 00000005
> [    1.963220] r7 : c243f400  r6 : c243f400  r5 : 00000098  r4 : df992b54
> [    1.968431] r3 : 00000000  r2 : 00000000  r1 : 60000013  r0 : df992b54
> [    1.975029] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    1.981543] Control: 10c5787d  Table: 4367806a  DAC: 00000051
> [    1.988744] Register r0 information: non-slab/vmalloc memory
> [    1.994472] Register r1 information: non-paged memory
> [    2.000200] Register r2 information: NULL pointer
> [    2.005148] Register r3 information: NULL pointer
> [    2.009834] Register r4 information: non-slab/vmalloc memory
> [    2.014525] Register r5 information: non-paged memory
> [    2.020252] Register r6 information: slab kmalloc-1k start c243f400 pointer offset 0 size 1024
> [    2.025206] Register r7 information: slab kmalloc-1k start c243f400 pointer offset 0 size 1024
> [    2.033714] Register r8 information: non-paged memory
> [    2.042301] Register r9 information: non-slab/vmalloc memory
> [    2.047424] Register r10 information: non-paged memory
> [    2.053152] Register r11 information: non-slab/vmalloc memory
> [    2.058100] Register r12 information: non-paged memory
> [    2.063915] Process modprobe (pid: 84, stack limit = 0x(ptrval))
> [    2.068953] Stack: (0xc27abe18 to 0xc27ac000)
> [    2.075115] be00:                                                       00000000 00000000
> [    2.079378] be20: c147514c ffefffcf 00000000 00000000 0000009c 60000013 dfa12928 dfa12b44
> [    2.087537] be40: c27abf24 0000009c c4018000 c401800c c27abf0c c27abf24 00000000 000000f8
> [    2.095697] be60: 00000000 c045b248 ffffffff c27abf0c c35d1400 00000000 c35d1438 c045b4f8
> [    2.103858] be80: c27abf0c 00002000 00000000 c044fb14 00000000 c0b6c2bc c35d1400 ffffffff
> [    2.112016] bea0: ffffffff c35a4c0c 00000000 ffffffff 00000000 00001c01 00000000 c3591510
> [    2.120176] bec0: 00000000 c35d1400 ffffffff c3591510 00000000 c35d1400 00000000 c0458f30
> [    2.128336] bee0: 00000000 c08f35c8 c36ebf00 c35d1400 00010000 00013fff c35a4c0c 00000000
> [    2.136496] bf00: ffffffff 00000000 00000101 c35d1400 ffffffff ffffffff c2420501 00000001
> [    2.144656] bf20: c4018000 c4018000 00000000 00000008 dfde733c dfde7360 dfde7384 dfde73a8
> [    2.152815] bf40: dfa12a44 dfa12948 dfa129d8 dfa12ad4 c35d1400 00000000 c35d1438 00000698
> [    2.160976] bf60: c27abf78 c0318a34 c35d1400 c2731000 c35d1438 c0320604 0000ff00 c258ea00
> [    2.169136] bf80: c2731000 c2456f40 c03002c4 c2456f40 00000000 c0320e0c 000000f8 c0320e6c
> [    2.177294] bfa0: ffffffff c0300060 ffffffff bed38eb4 ffffffff bed38dcc 00000000 ffffffff
> [    2.185455] bfc0: ffffffff bed38eb4 00010f60 000000f8 6474e552 00000020 00000000 00000000
> [    2.193614] bfe0: 6ffffff9 bed38e78 b6f91f1c b6fa4a44 60000010 ffffffff 00000000 00000000
> [    2.201777]  release_pages from tlb_batch_pages_flush+0x3c/0x70
> [    2.209927]  tlb_batch_pages_flush from tlb_finish_mmu+0x4c/0x130
> [    2.215656]  tlb_finish_mmu from exit_mmap+0xec/0x1e0
> [    2.221903]  exit_mmap from mmput+0x40/0x120
> [    2.226939]  mmput from do_exit+0x238/0x890
> [    2.231279]  do_exit from do_group_exit+0x34/0x84
> [    2.235184]  do_group_exit from __wake_up_parent+0x0/0x18
> [    2.240053] Code: bad PC value
> [    2.245556] ---[ end trace 0000000000000000 ]---
> [    2.248448] Kernel panic - not syncing: Fatal exception
> [    2.253158] CPU0: stopping
> [    2.253169] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D            6.1.65 #0
> [    2.253180] Hardware name: Generic DT based system
> [    2.253189]  unwind_backtrace from show_stack+0x10/0x14
> [    2.253216]  show_stack from dump_stack_lvl+0x40/0x4c
> [    2.253249]  dump_stack_lvl from do_handle_IPI+0xf0/0x124
> [    2.253276]  do_handle_IPI from ipi_handler+0x18/0x20
> [    2.253293]  ipi_handler from handle_percpu_devid_irq+0x78/0x134
> [    2.253313]  handle_percpu_devid_irq from generic_handle_domain_irq+0x28/0x38
> [    2.253338]  generic_handle_domain_irq from gic_handle_irq+0x74/0x88
> [    2.253361]  gic_handle_irq from generic_handle_arch_irq+0x34/0x44
> [    2.253391]  generic_handle_arch_irq from call_with_stack+0x18/0x20
> [    2.253419]  call_with_stack from __irq_svc+0x80/0x98
> [    2.253438] Exception stack(0xc1401f00 to 0xc1401f48)
> [    2.253451] 1f00: 00000005 00000000 00000a61 c03128a0 c1408640 00000000 c1404f68 c1404fa4
> [    2.253461] 1f20: 00000000 c13c9c38 00000000 00000000 c14c1f00 c1401f50 c0307148 c030714c
> [    2.253467] 1f40: 60000013 ffffffff
> [    2.253474]  __irq_svc from arch_cpu_idle+0x38/0x3c
> [    2.253500]  arch_cpu_idle from default_idle_call+0x24/0x34
> [    2.253526]  default_idle_call from do_idle+0x1ec/0x240
> [    2.253545]  do_idle from cpu_startup_entry+0x28/0x2c
> [    2.253559]  cpu_startup_entry from kernel_init+0x0/0x12c
> [    2.376160] Rebooting in 1 seconds..
>

Some followup on this... I manage to enable DEBUG_LL and can have debug
output from the decompressor...

From what I can see fdt_check_mem_start is not called at all...

What I'm using with kernel config are:
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
And a downstream patch that mangle all the atags and takes only the
cmdline one.

The load and entry point is:
0x42208000

With the current setup I have this (I also added some debug log that
print what is actually passed to do decompress

DTB:0x42AED270 (0x00008BA7)
Uncompressing Linux...
40208000 
4220F10C done, booting the kernel.

Where 40208000 is the value of output_start and 4220F10C is input_data.

And I think this confirm that it's getting loaded in the wrong position
actually in reserved memory... But how this is possible??? Hope can
someone help me in this since I wasted the entire day with this and
didn't manage to make any progress... aside from having fun with the
head.S assembly code.

-- 
	Ansuel

