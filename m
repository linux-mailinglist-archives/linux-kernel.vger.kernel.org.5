Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487DF8112C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378985AbjLMNYf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 08:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjLMNYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:24:32 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC9CE3;
        Wed, 13 Dec 2023 05:24:32 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1D5DA24E246;
        Wed, 13 Dec 2023 21:24:24 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Dec
 2023 21:24:23 +0800
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Dec
 2023 21:24:23 +0800
Received: from EXMBX061.cuchost.com ([fe80::413f:35c8:bf4f:599a]) by
 EXMBX061.cuchost.com ([fe80::413f:35c8:bf4f:599a%14]) with mapi id
 15.00.1497.044; Wed, 13 Dec 2023 21:24:23 +0800
From:   Leyfoon Tan <leyfoon.tan@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        JeeHeng Sia <jeeheng.sia@starfivetech.com>
CC:     "kernel@esmil.dk" <kernel@esmil.dk>,
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
        "anup@brainfault.org" <anup@brainfault.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        "drew@beagleboard.org" <drew@beagleboard.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v3 2/6] dt-bindings: riscv: Add StarFive JH8100 SoC
Thread-Topic: [PATCH v3 2/6] dt-bindings: riscv: Add StarFive JH8100 SoC
Thread-Index: AQHaJE/+gN06PgKn10+OgNsQzAP7lrCmtRSAgACQEsA=
Date:   Wed, 13 Dec 2023 13:24:23 +0000
Message-ID: <84b808cb028c40a29c9f81011931afba@EXMBX061.cuchost.com>
References: <20231201121410.95298-1-jeeheng.sia@starfivetech.com>
 <20231201121410.95298-3-jeeheng.sia@starfivetech.com>
 <20231213-imminent-favorable-a7d25e6555af@spud>
In-Reply-To: <20231213-imminent-favorable-a7d25e6555af@spud>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.16.6.8]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Wednesday, December 13, 2023 8:43 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: kernel@esmil.dk; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> krzk@kernel.org; conor+dt@kernel.org; paul.walmsley@sifive.com;
> palmer@dabbelt.com; aou@eecs.berkeley.edu; daniel.lezcano@linaro.org;
> tglx@linutronix.de; anup@brainfault.org; gregkh@linuxfoundation.org;
> jirislaby@kernel.org; michal.simek@amd.com; Michael Zhu
> <michael.zhu@starfivetech.com>; drew@beagleboard.org;
> devicetree@vger.kernel.org; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Conor
> Dooley <conor.dooley@microchip.com>
> Subject: Re: [PATCH v3 2/6] dt-bindings: riscv: Add StarFive JH8100 SoC
> 
> On Fri, Dec 01, 2023 at 08:14:06PM +0800, Sia Jee Heng wrote:
> > Add device tree bindings for the StarFive JH8100 RISC-V SoC.
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/riscv/starfive.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml
> > b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > index cc4d92f0a1bf..12d7844232b8 100644
> > --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > @@ -30,6 +30,10 @@ properties:
> >                - starfive,visionfive-2-v1.3b
> >            - const: starfive,jh7110
> >
> > +      - items:
> > +          - enum:
> > +              - starfive,jh8100-evb
> 
> Hmm, reading some of the other threads it appears that the evaluation
> platform that you guys have is actually just an FPGA? Could you please provide
> more information as to what this "evb" actually is?
> 
> If it is just an FPGA-based evaluation platform I don't think that we want to
> merge patches for the platform. I'm fine with patches adding peripheral
> support, but the soc/board dts files and things like pinctrl or clock drivers I am
> not keen on.
> Perhaps Emil also has an opinion on this.
> 
> Thanks,
> Conor.

We have been testing on the FPGA/emulator for pre-silicon validation. It will have real silicon SoC next year.

Regards
Ley Foon
