Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545FD7DF236
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345888AbjKBMUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjKBMUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:20:50 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DF6DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:20:45 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so12256881fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1698927644; x=1699532444; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uj4dSlf9myqfs2kMBdKnII3t+10Ab0ZOhJNI/Bmzsdg=;
        b=kvzHbP1ZSoIHrHUsyCXIg5ej7tnIPH/TRXQD5BoA28mEB2pkzZsPwlCgig83Us0sQG
         Bko1JdkyCDqUweCLpFj6ZwU6ABJBr3vdDWq1O4ZtxuUoM4MlYB6/nAsmJECiWG9g+kvL
         6Muua9XX4bjwf3SKMABtI/bgGblCH17/VCTydMwlfHc+ALem0O84jUmL5eBHZPelbMsK
         ICtImX9MznwoC8vJxu0IY6HdGrjNcd58Blp1dfqV6NUDVntmQFxe5ySQkq30Q9H+SQHC
         1OdnppVvhQjNBJgWfDSSY0J6YNxAtVyg0Fcjcgx1S1xBieiwOrvmqPPZ5S6xwa7L2eFJ
         GJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698927644; x=1699532444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uj4dSlf9myqfs2kMBdKnII3t+10Ab0ZOhJNI/Bmzsdg=;
        b=NTnn6L1tz84YU0WTIiiBG3DjRE3OICgL84RoqSKIsHpaYAlnCJcdXkBAJUrz6CwFap
         OCWxq65y0ZX3Pajpuqb19KkufSWv4seP3mbqN20HrFRW5qaJonXxEo5H5OcvlyuepQBy
         cwUWnaLyrZAK74ZAov8X6xPKDzR3ue2GTz+/prBTUT5UU830kbyFdzqODOXDyQdF+5ZP
         imdO3UeqOGSXu1AAQFRS820AVKyB44gQYnUoS1nyJB/EGcvlchw+GCjPMLO5xkRZCu1d
         s+fJhtDqvoOKXyLFS+DhTI/6Ep2Fn696Qrep67THo8oPjfekTkx/aWe9/7kLeghtRMvi
         75uw==
X-Gm-Message-State: AOJu0YyHtWwuHbkgG58DuiHdWFerzUTk6lC0H0EIIhq4XYDnTXKVFZ7B
        jZ522s8P0fw9VnrMDn8UvtjrWQ==
X-Google-Smtp-Source: AGHT+IEF+tdOwKzftHjQWezascJrDWOZdacVE4mUohiwxZfaxR+7MowKVMUsQn5+JShGmNWUqPMtyQ==
X-Received: by 2002:a2e:7812:0:b0:2c0:1c32:b4e1 with SMTP id t18-20020a2e7812000000b002c01c32b4e1mr14181239ljc.27.1698927643985;
        Thu, 02 Nov 2023 05:20:43 -0700 (PDT)
Received: from debian ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id a5-20020a2eb545000000b002c02b36d381sm217172ljn.88.2023.11.02.05.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:20:43 -0700 (PDT)
Date:   Thu, 2 Nov 2023 13:20:41 +0100
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        andrew@lunn.ch, netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 8/9] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Message-ID: <ZUOUGf-PMGo8z1s-@debian>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-9-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023154649.45931-9-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 09:16:48PM +0530, Parthiban Veerasooran wrote:
> The LAN8650/1 is designed to conform to the OPEN Alliance 10BASE‑T1x
> MAC‑PHY Serial Interface specification, Version 1.1. The IEEE Clause 4
> MAC integration provides the low pin count standard SPI interface to any
> microcontroller therefore providing Ethernet functionality without
> requiring MAC integration within the microcontroller. The LAN8650/1
> operates as an SPI client supporting SCLK clock rates up to a maximum of
> 25 MHz. This SPI interface supports the transfer of both data (Ethernet
> frames) and control (register access).
> 
> By default, the chunk data payload is 64 bytes in size. A smaller payload
> data size of 32 bytes is also supported and may be configured in the
> Chunk Payload Size (CPS) field of the Configuration 0 (OA_CONFIG0)
> register. Changing the chunk payload size requires the LAN8650/1 be reset
> and shall not be done during normal operation.
> 
> The Ethernet Media Access Controller (MAC) module implements a 10 Mbps
> half duplex Ethernet MAC, compatible with the IEEE 802.3 standard.
> 10BASE-T1S physical layer transceiver integrated into the LAN8650/1. The
> PHY and MAC are connected via an internal Media Independent Interface
> (MII).
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Hi Parthiban

I've been testing the v2 patches out a bit, at Ferroamp we're planning
on using a dual LAN8650 setup in a product.

First let me say that we'd be happy to assist with testing and
development.

I got some observations that I think this patch is the resonable place
to discuss it, since they seem to be MAC/PHY related.

In order to get a reliable link I'm using the dts snippet below (for an
imx8 cpu)

&ecspi1 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_ecspi1>;
	cs-gpios = <0> , <&gpio5 9 GPIO_ACTIVE_LOW>;
	status = "okay";

	spe1: ethernet@1{
		compatible = "microchip,lan865x";
		reg = <1>;
		interrupt-parent = <&gpio5>;
		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
		spi-max-frequency = <50000000>;
		oa-tc6{
			#address-cells = <1>;
			#size-cells = <0>;
			oa-cps = <32>;
			oa-prote;
			oa-dprac;
		};
	};
};

With this setup I'm getting a maximum throughput of about 90kB/s.
If I increase the chunk size / oa-cps to 64 I get a might higher
throughput ~900kB/s, but after 0-2s I get dump below (or similar).

[  363.444460] eth0: Transmit protocol error
[  363.448527] eth0: Transmit buffer underflow
[  363.452740] eth0: Receive buffer overflow
[  363.456780] eth0: Header error
[  363.459869] eth0: Footer frame drop
[  363.463379] eth0: SPI transfer failed
[  363.470590] eth0: Receive buffer overflow
[  363.474631] eth0: Header error
[  363.477776] eth0: SPI transfer failed
[  363.482596] eth0: Footer frame drop
[  369.884680] ------------[ cut here ]------------
[  369.889336] NETDEV WATCHDOG: eth0 (lan865x): transmit queue 0 timed out 6448 ms
[  369.896726] WARNING: CPU: 1 PID: 0 at net/sched/sch_generic.c:525 dev_watchdog+0x22c/0x234
[  369.905023] Modules linked in:
[  369.908091] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.4.16-gc5e8aa9586d6 #3
[  369.915241] Hardware name: <Ferroamp dev kit>
[  369.921169] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  369.928146] pc : dev_watchdog+0x22c/0x234
[  369.932168] lr : dev_watchdog+0x22c/0x234
[  369.936190] sp : ffff80000800be20
[  369.939510] x29: ffff80000800be20 x28: 0000000000000101 x27: ffff80000800bf00
[  369.946665] x26: ffff8000092469c0 x25: 0000000000001930 x24: ffff800009246000
[  369.953817] x23: 0000000000000000 x22: ffff000000e883dc x21: ffff000000e88000
[  369.960971] x20: ffff0000010dc000 x19: ffff000000e88488 x18: ffffffffffffffff
[  369.968124] x17: 383434362074756f x16: 2064656d69742030 x15: 0720072007200720
[  369.975276] x14: 0720072007200720 x13: ffff80000925fe88 x12: 0000000000000444
[  369.982431] x11: 000000000000016c x10: ffff8000092b7e88 x9 : ffff80000925fe88
[  369.989584] x8 : 00000000ffffefff x7 : ffff8000092b7e88 x6 : 80000000fffff000
[  369.996738] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[  370.003890] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000000dd400
[  370.011044] Call trace:
[  370.013496]  dev_watchdog+0x22c/0x234
[  370.017173]  call_timer_fn.constprop.0+0x24/0x80
[  370.021802]  __run_timers.part.0+0x1f8/0x244
[  370.026080]  run_timer_softirq+0x3c/0x74
[  370.030012]  __do_softirq+0x10c/0x280
[  370.033683]  ____do_softirq+0x10/0x1c
[  370.037357]  call_on_irq_stack+0x24/0x4c
[  370.041292]  do_softirq_own_stack+0x1c/0x28
[  370.045484]  __irq_exit_rcu+0xe4/0x100
[  370.049244]  irq_exit_rcu+0x10/0x1c
[  370.052744]  el1_interrupt+0x38/0x68
[  370.056331]  el1h_64_irq_handler+0x18/0x24
[  370.060439]  el1h_64_irq+0x64/0x68
[  370.063851]  cpuidle_enter_state+0x134/0x2e0
[  370.068133]  cpuidle_enter+0x38/0x50
[  370.071719]  do_idle+0x1f4/0x264
[  370.074960]  cpu_startup_entry+0x24/0x2c
[  370.078895]  secondary_start_kernel+0x130/0x150
[  370.083440]  __secondary_switched+0xb8/0xbc
[  370.087634] ---[ end trace 0000000000000000 ]---


Additionally when hotplugging cables, which might not be a realworld
scenario I'm also seeing intermittent watchdog timeouts.

In both scenarios the driver does not recover.
