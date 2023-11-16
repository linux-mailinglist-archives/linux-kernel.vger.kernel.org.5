Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70C97ED926
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344462AbjKPCLX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 21:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjKPCLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:11:22 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2A119E;
        Wed, 15 Nov 2023 18:11:15 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id BDCAB80BE;
        Thu, 16 Nov 2023 10:11:01 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 16 Nov
 2023 10:11:01 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 16 Nov
 2023 10:10:57 +0800
From:   Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To:     <conor@kernel.org>
CC:     <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <jisheng.teoh@starfivetech.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <leyfoon.tan@starfivetech.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <peterz@infradead.org>, <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <will@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: perf: starfive: Add StarLink PMU
Date:   Thu, 16 Nov 2023 10:10:35 +0800
Message-ID: <20231116021035.4043907-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115-landing-earflap-ed11982ac610@squawk>
References: <20231115-landing-earflap-ed11982ac610@squawk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 20:03:53 +0000
Conor Dooley <conor@kernel.org> wrote:

> Yo,
> 
> On Wed, Nov 15, 2023 at 11:36:08AM +0800, Ji Sheng Teoh wrote:
> > Add device tree binding for StarFive's StarLink PMU (Performance
> > Monitor Unit).
> > 
> > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> > ---
> >  .../bindings/perf/starfive,starlink-pmu.yaml  | 46
> > +++++++++++++++++++ 1 file changed, 46 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/perf/starfive,starlink-pmu.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/perf/starfive,starlink-pmu.yaml
> > b/Documentation/devicetree/bindings/perf/starfive,starlink-pmu.yaml
> > new file mode 100644 index 000000000000..a9426a7faeae --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/perf/starfive,starlink-pmu.yaml
> >  
> 
> btw, since you changed the compatible, the filename should have been
> changed to match it.

The intention to keep the filename generic is to allow addition of new
version of StarLink PMU in future if any, similar to what arm,cmn.yaml
is doing. Hope that makes sense.

> 
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/perf/starfive,starlink-pmu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: StarFive StarLink PMU
> > +
> > +maintainers:
> > +  - Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> > +
> > +description:
> > +  StarFive's StarLink PMU integrates one or more CPU cores with a
> > shared L3
> > +  memory system. The PMU support overflow interrupt, up to 16
> > programmable
> > +  64bit event counters, and an independent 64bit cycle counter.
> > +  StarLink PMU is accessed via MMIO.
> > +
> > +properties:
> > +  compatible:
> > +    const: starfive,starlink-500-pmu  
> 
> So this is not what I had in mind by a "device". I was looking for a
> compatible representing an soc in which this IP had been integrated.
> A soc-specific compatible, rather than something generic, is
> requirement for devicetree - we don't want various integrations of
> this IP to all be using a generic compatible when there may be subtle
> (or less subtle) differences between integrations.
> 
> I'm trying to come up with the syntax for enforcing having two
> compatibles with your current one as the fallback, but I have yet to
> come up with the correct syntax for that that works correctly.
> 
> Hopefully by the time you get some feedback on the driver side of this
> submission I will have a concrete suggestion for what to do here.

Thanks Conor for the enlightenment. In the meantime, to fit the requirement
I would suggest going for "starfive,jh8100-starlink-pmu", making it JH8100
SOC specific if that makes sense.

> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        l3_pmu: pmu@12900000 {  
> 
> This label here is never used and should be dropped.
> 
> Cheers.
> Conor.

Noted, will drop it in v4.

> 
> > +            compatible = "starfive,starlink-500-pmu";
> > +            reg = <0x0 0x12900000 0x0 0x10000>;
> > +            interrupts = <34>;
> > +        };
> > +    };
> > -- 
> > 2.25.1
> >   
> 
