Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D603080043F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjLAHCX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Dec 2023 02:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjLAHCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:02:21 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FEC171C;
        Thu, 30 Nov 2023 23:02:23 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 802EE806C;
        Fri,  1 Dec 2023 15:02:14 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Dec
 2023 15:02:14 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Fri, 1 Dec 2023 15:02:14 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     "kernel@esmil.dk" <kernel@esmil.dk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "conor@kernel.org" <conor@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        "drew@beagleboard.org" <drew@beagleboard.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: RE: [PATCH v2 0/6] Initial device tree support for StarFive JH8100
 SoC
Thread-Topic: [PATCH v2 0/6] Initial device tree support for StarFive JH8100
 SoC
Thread-Index: AQHaIoltfrp3sT1yT0ef06easE87zLCUArOg
Date:   Fri, 1 Dec 2023 07:02:14 +0000
Message-ID: <1cef32884e2c4921a07d408e22fe23f8@EXMBX066.cuchost.com>
References: <20231129060043.368874-1-jeeheng.sia@starfivetech.com>
In-Reply-To: <20231129060043.368874-1-jeeheng.sia@starfivetech.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [60.54.3.230]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Krzysztof, Conor, and LeyFoon, for your comments.
I will prepare version 3 to address all the feedback.

> -----Original Message-----
> From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Sent: Wednesday, November 29, 2023 2:01 PM
> To: kernel@esmil.dk; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; krzk@kernel.org; conor+dt@kernel.org;
> paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; daniel.lezcano@linaro.org; tglx@linutronix.de;
> conor@kernel.org; anup@brainfault.org; gregkh@linuxfoundation.org; jirislaby@kernel.org; michal.simek@amd.com; Michael Zhu
> <michael.zhu@starfivetech.com>; drew@beagleboard.org
> Cc: devicetree@vger.kernel.org; linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; JeeHeng Sia
> <jeeheng.sia@starfivetech.com>; Leyfoon Tan <leyfoon.tan@starfivetech.com>
> Subject: [PATCH v2 0/6] Initial device tree support for StarFive JH8100 SoC
> 
> StarFive JH8100 SoC consists of 4 RISC-V performance Cores (Dubhe-90) and
> 2 RISC-V energy efficient cores (Dubhe-80). It also features various
> interfaces such as DDR4, Gbit-Ether, CAN, USB 3.2, SD/MMC, etc., making it
> ideal for high-performance computing scenarios.
> 
> This patch series introduces initial SoC DTSI support for the StarFive
> JH8100 SoC. The relevant dt-binding documentation has been updated
> accordingly. Below is the list of IP blocks added in the initial SoC DTSI,
> which can be used for booting via initramfs on FPGA:
> 
> - StarFive Dubhe-80 CPU
> - StarFive Dubhe-90 CPU
> - PLIC
> - CLINT
> - UART
> 
> The primary goal is to include foundational patches so that additional
> drivers can be built on top of this framework.
> 
> Changes since v1:
> - Dropped patch 5.
> - Moved timebase-frequency from .dts to .dtsi.
> - Moved soc node from .dts to .dtsi.
> - Revised the title for the dt-binding document by removing Xilinx
>   wording.
> - Added a full stop to the end of the commit messages.
> - Removed extra blank lines.
> - Used hyphen for a node name.
> - Added more recipients to the mailing list.
> 
> Sia Jee Heng (6):
>   dt-bindings: riscv: Add StarFive Dubhe compatibles
>   dt-bindings: riscv: Add StarFive JH8100 SoC
>   dt-bindings: timer: Add StarFive JH8100 clint
>   dt-bindings: interrupt-controller: Add StarFive JH8100 plic
>   dt-bindings: serial: cdns: Add new compatible string for StarFive
>     JH8100 UART
>   riscv: dts: starfive: Add initial StarFive JH8100 device tree
> 
>  .../sifive,plic-1.0.0.yaml                    |   1 +
>  .../devicetree/bindings/riscv/cpus.yaml       |   2 +
>  .../devicetree/bindings/riscv/starfive.yaml   |   5 +-
>  .../devicetree/bindings/serial/cdns,uart.yaml |   4 +
>  .../bindings/timer/sifive,clint.yaml          |   1 +
>  arch/riscv/boot/dts/starfive/Makefile         |   1 +
>  arch/riscv/boot/dts/starfive/jh8100-evb.dts   |  28 ++
>  arch/riscv/boot/dts/starfive/jh8100.dtsi      | 378 ++++++++++++++++++
>  8 files changed, 419 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh8100-evb.dts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh8100.dtsi
> 
> 
> base-commit: 18d46e76d7c2eedd8577fae67e3f1d4db25018b0
> --
> 2.34.1

