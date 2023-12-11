Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4DA80D307
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344060AbjLKQ6B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 11:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjLKQ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:57:59 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F6B8E;
        Mon, 11 Dec 2023 08:58:04 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 85DF47FD3;
        Tue, 12 Dec 2023 00:58:03 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 00:58:03 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 00:57:58 +0800
From:   Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <jisheng.teoh@starfivetech.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <leyfoon.tan@starfivetech.com>, <linux-kernel@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <samin.guo@starfivetech.com>,
        <wim@linux-watchdog.org>, <xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: watchdog: starfive,jh7100-wdt: Add compatible for JH8100
Date:   Tue, 12 Dec 2023 00:57:31 +0800
Message-ID: <20231211165731.1604004-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3b53b6c4-96e6-4129-912e-82b8ab9b2269@linaro.org>
References: <3b53b6c4-96e6-4129-912e-82b8ab9b2269@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 11:06:09 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 09/12/2023 15:27, Ji Sheng Teoh wrote:
> > Add "starfive,jh8100-wdt" compatible string for StarFive's JH8100
> > watchdog.
> > Since JH8100 watchdog only has 1 reset signal, update binding
> > document to support one reset for "starfive,jh8100-wdt" compatible.
> > 
> > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> > ---
> >  .../watchdog/starfive,jh7100-wdt.yaml         | 29
> > ++++++++++++++----- 1 file changed, 21 insertions(+), 8 deletions(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > index 68f3f6fd08a6..eec182317219 100644 ---
> > a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > +++
> > b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > @@ -19,14 +19,12 @@ description: isn't cleared, the watchdog will
> > reset the system unless the watchdog reset is disabled. -allOf:
> > -  - $ref: watchdog.yaml#
> > -
> >  properties:
> >    compatible:
> >      enum:
> >        - starfive,jh7100-wdt
> >        - starfive,jh7110-wdt
> > +      - starfive,jh8100-wdt
> >  
> >    reg:
> >      maxItems: 1
> > @@ -44,11 +42,6 @@ properties:
> >        - const: apb
> >        - const: core
> >  
> > -  resets:  
> 
> No, keep it here with min/maxItems.
> 

Ok, will change it up to use min/maxItems.

> > -    items:
> > -      - description: APB reset
> > -      - description: Core reset
> > -
> >  required:
> >    - compatible
> >    - reg
> > @@ -56,6 +49,26 @@ required:
> >    - clock-names
> >    - resets
> >  
> > +allOf:
> > +  - $ref: watchdog.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - starfive,jh8100-wdt
> > +    then:
> > +      properties:
> > +        resets:
> > +          items:
> > +            - description: Watchdog reset  
> 
> Why is it called "Watchdog"? How is it different from "Core"?

Will standardize them to use "Core" instead. Thanks.

> 
> Best regards,
> Krzysztof
> 
