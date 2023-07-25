Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED5F761BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjGYOdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjGYOdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:33:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744D31A1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:32:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bbc7b2133fso1122025ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690295559; x=1690900359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cw7wtsxH00GFHx0g/XaPLY6Xq6F6potf4XWzXuoGwwI=;
        b=Z21lBCfU5uaS+EKnc2WTDx+A8qja0Aaifui042ac3RPNUrmOVAeJBlSsTSaBJg0B2f
         6ap4ReuiP3smJ4tR9lB4S4sIoNuXCUk44+mQx3Mg93XMpOmOUM5dHlW566tIa+I3dMz+
         NbWoOJUB2SWbPn8K4IEE6nRv1ihtLlNit55qTa0ver9phI76nVlJ95FtNq0tzE1RT3Ie
         WE42MPHhWTebw3e7VqZa6IuXvS6Rzoy5378oJSW91BHoqMJd/9PJNB0NxV7KIl/BP5Ie
         jVJFnoyf+6xUDNDTY+rpP9NhunWuD2JWPI0wZI4OQ3xhR6FHNdS48B6kd3CvCsN53N+z
         tBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690295559; x=1690900359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cw7wtsxH00GFHx0g/XaPLY6Xq6F6potf4XWzXuoGwwI=;
        b=O0a6S2bPjc9bsddgnRs5x4hlWiSAuaSZpYiaa9/5Xu/xlOMNIIBWGltS+b22GoKToV
         OuOnGePuFGngEGO/JpECORN3BCYnYt6u4e+SxctbjFRnNCipzY1BSwX4RNcPyqM9oAaA
         Q+i/fBRhkBoV2Jk73A7teu6QGkDx6cjYrI5NYB6jmatDieyP9nS0Z4VcoB0VTvkKmlWV
         m6D0KAZVZ7yqotnQdq1ctVXC3iE43jdn1AE4PxWAba+sMDhnYy4MGkIeP2e7D8cLUPBB
         RjTTWwl0TZ7sKc4sy0m+fAz2kMRWMaY5+SzAunXCMhXXdU1NZ0p2FhFYck7pYxqgxWDT
         GyBQ==
X-Gm-Message-State: ABy/qLYUytZHsufyYYmQAQnEjwSIpbMxEWfeBudEJrjJ1XfesciZmiOv
        E9UPa6rAnHpP6AXgM6u2lR8gYQ==
X-Google-Smtp-Source: APBJJlG8kF2vYVgmupUDRv18zEVuedLPx+h1QS8U117AiwVlVjtMGecGSxYYfKf8MMaXZAuVxDmmDQ==
X-Received: by 2002:a17:902:a510:b0:1bb:a056:2c5f with SMTP id s16-20020a170902a51000b001bba0562c5fmr4542617plq.7.1690295558974;
        Tue, 25 Jul 2023 07:32:38 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:2cbf:9196:a906:e222])
        by smtp.gmail.com with ESMTPSA id be3-20020a170902aa0300b001b872695c1csm10990705plb.256.2023.07.25.07.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 07:32:38 -0700 (PDT)
Date:   Tue, 25 Jul 2023 07:32:36 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Xi Ruoyao <xry111@linuxfromscratch.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <ZL/dBHfk72wDnuQd@x1>
References: <20230617161529.2092-1-jszhang@kernel.org>
 <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
 <20230725-unheard-dingy-42f0fafe7216@wendy>
 <20230725-distant-overrule-a98ad406125f@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725-distant-overrule-a98ad406125f@wendy>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 09:10:06AM +0100, Conor Dooley wrote:
> Hey Guo Ren,
> 
> On Tue, Jul 25, 2023 at 08:52:09AM +0100, Conor Dooley wrote:
> > On Tue, Jul 25, 2023 at 03:38:58PM +0800, Xi Ruoyao wrote:
> > > On Sun, 2023-06-18 at 00:15 +0800, Jisheng Zhang wrote:
> > > > Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> > > > module which is powered by T-HEAD's TH1520 SoC. Add minimal device
> > > > tree files for the core module and the development board.
> > > > 
> > > > Support basic uart/gpio/dmac drivers, so supports booting to a basic
> > > > shell.
> > > 
> > > Thanks for the excellent work, but when I tried to boot Linux 6.5.0-rc3
> > > on my Lichee Pi 4A it fails with:
> > > 
> > > ## Flattened Device Tree blob at 01f00000
> > >    Booting using the fdt blob at 0x1f00000
> > >    Using Device Tree in place at 0000000001f00000, end 0000000001f050c4
> > > 
> > > Starting kernel ...
> > > 
> > > [    0.000000] Linux version 6.5.0-rc3 (lfs@stargazer) (riscv64-lfs-linux-gnu-gcc (GCC) 13.1.0, GNU ld (GNU Binutils) 2.40) #1 SMP PREEMPT Tue Jul 25 13:38:20 CST 2023
> > > [    0.000000] Machine model: Sipeed Lichee Pi 4A
> > > [    0.000000] SBI specification v0.3 detected
> 
> > > [    0.000000] SBI implementation ID=0x1 Version=0x9
> 
> > > [    0.000000] Oops - load access fault [#1]
> > > [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.5.0-rc3 #1
> > > [    0.000000] Hardware name: Sipeed Lichee Pi 4A (DT)
> > > [    0.000000] epc : __plic_toggle+0x5a/0x62
> > > [    0.000000]  ra : __plic_init.isra.0+0x2d0/0x462
> > > [    0.000000] epc : ffffffff802ce8ec ra : ffffffff80618816 sp : ffffffff80e03c90
> > > [    0.000000]  gp : ffffffff80ec5bb8 tp : ffffffff80e10d40 t0 : ffffffd900045940
> > > [    0.000000]  t1 : 0000000000000002 t2 : ffffffd90004a10c s0 : ffffffd9fef6ed68
> > > [    0.000000]  s1 : ffffffd900045680 a0 : ffffffc801002080 a1 : 0000000000000002
> > > [    0.000000]  a2 : 0000000000000000 a3 : 00000000000000f4 a4 : 0000000000000001
> > > [    0.000000]  a5 : 0000000000000000 a6 : 0000000000000b40 a7 : ffffffd900045940
> > > [    0.000000]  s2 : ffffffd9fef6ed78 s3 : ffffffff80ef9630 s4 : 0000000000000001
> > > [    0.000000]  s5 : ffffffd9ffff5af8 s6 : 0000000000000001 s7 : ffffffff80815d68
> > > [    0.000000]  s8 : 0000000000000008 s9 : 0000000000000000 s10: ffffffff80815d68
> > > [    0.000000]  s11: ffffffff80b1b1b8 t3 : ffffffff80c003d0 t4 : 0000000000000001
> > > [    0.000000]  t5 : 0000000000000003 t6 : 0000000000000001
> > > [    0.000000] status: 8000000201800100 badaddr: 000000ffd8002080 cause: 0000000000000005
> > > [    0.000000] [<ffffffff802ce8ec>] __plic_toggle+0x5a/0x62
> > > [    0.000000] [<ffffffff8061ffc8>] of_irq_init+0x14a/0x248
> > > [    0.000000] [<ffffffff80600a7e>] start_kernel+0x40c/0x6fe
> > > [    0.000000] [<ffffffff806034f6>] init_IRQ+0xc6/0x100
> > > [    0.000000] [<ffffffff80600a7e>] start_kernel+0x40c/0x6fe
> > > [    0.000000] Code: 0007 c319 9123 00e7 8082 000f 0140 411c 000f 0820 (c593) fff5 
> > > [    0.000000] ---[ end trace 0000000000000000 ]---
> > > [    0.000000] Kernel panic - not syncing: Fatal exception in interrupt
> > > 
> > > I guess I'm either using some unsupported configuration or making some
> > > stupid mistakes, but I cannot find any documentation about how to
> > > configure the mainline kernel for Lichee Pi 4A properly.  Could you give
> > > some pointers?
> > 
> > Are you using the vendor OpenSBI? IIRC, and the lads can probably
> > correct me here, you need to have an OpenSBI that contains
> > https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b9fb31623a42ced45f38ea6
> > which the vendor supplied OpenSBI does not have.
> 
> Guo Ren, can you try to get this sorted out? The T-Head SDK seems to be
> shipping stuff that is several years old, so new SoCs from vendors that
> have used your SDK are unable to run mainline kernels (and therefore
> mainstream distros), without a firmware update.
> 
> The TH1520 branch on github, seems to be based on OpenSBI v0.9:
> > > [    0.000000] SBI implementation ID=0x1 Version=0x9
> https://github.com/T-head-Semi/opensbi/blob/4e77060e0512ad981eee55d5a2501f6d88a41fd9/include/sbi/sbi_version.h#L13
> OpenSBI v0.9 was released on the 18/01/2021:
> https://github.com/riscv-software-src/opensbi/releases/tag/v0.9
> The "fix" I linked above was included in v1.0, released on 24/12/2021.
> 
> I think it is hitting here for the Lichee Pi4a, but I know the same
> thing has happened to the BeagleV Ahead, and I figure it'll impact
> other SoCs going forward too.

I ran into the access fault in the PLIC code when I first attempted to
run mainline Linux on the BeagleV Ahead. I switched from the vendor
OpenSBI v0.9 to uptream OpenSBI v1.3 and the PLIC oops went away.

For reference, my boot log when using OpenSBI v1.3:
https://gist.github.com/pdp7/23259595a7570f1f11086d286e16dfb6

And my device tree patch which essentially just adjusts the memory node
to match the amount of DDR in the BeagleV Ahead versus the lpi4a that
Jisheng has:
https://lore.kernel.org/linux-riscv/20230722-upstream-beaglev-ahead-dts-v2-0-a470ab8fe806@baylibre.com/

-Drew
