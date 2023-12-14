Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF6C8126D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443150AbjLNFSE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 00:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNFSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:18:02 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC48D0;
        Wed, 13 Dec 2023 21:18:06 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 97AA980A4;
        Thu, 14 Dec 2023 13:17:58 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 13:17:58 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 13:17:52 +0800
From:   Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To:     <conor@kernel.org>
CC:     <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <jisheng.teoh@starfivetech.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <leyfoon.tan@starfivetech.com>, <linux-kernel@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <samin.guo@starfivetech.com>,
        <wim@linux-watchdog.org>, <xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: watchdog: starfive,jh7100-wdt: Add compatible for JH8100
Date:   Thu, 14 Dec 2023 13:17:17 +0800
Message-ID: <20231214051717.9795-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231213-rectified-unmindful-4064c852930f@spud>
References: <20231213-rectified-unmindful-4064c852930f@spud>
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

On Wed, 13 Dec 2023 16:35:39 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Dec 13, 2023 at 10:57:59AM +0800, Ji Sheng Teoh wrote:
> > On Tue, 12 Dec 2023 16:47:59 +0000
> > Conor Dooley <conor@kernel.org> wrote:
> >   
> > > On Tue, Dec 12, 2023 at 04:46:00PM +0000, Conor Dooley wrote:  
> > > > On Tue, Dec 12, 2023 at 11:17:31AM +0800, Ji Sheng Teoh wrote:
> > > >   
> > > > > Add "starfive,jh8100-wdt" compatible string for StarFive's
> > > > > JH8100 watchdog.
> > > > > Since JH8100 watchdog only has 1 reset signal, update binding
> > > > > document to support one reset for "starfive,jh8100-wdt"
> > > > > compatible.
> > > > > 
> > > > > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > > > > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> > > > > ---
> > > > >  .../devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > > > > | 2 ++ 1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > > > > b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > > > > index 68f3f6fd08a6..02572b16ac08 100644 ---
> > > > > a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > > > > +++
> > > > > b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > > > > @@ -27,6 +27,7 @@ properties: enum:
> > > > >        - starfive,jh7100-wdt
> > > > >        - starfive,jh7110-wdt
> > > > > +      - starfive,jh8100-wdt
> > > > >  
> > > > >    reg:
> > > > >      maxItems: 1
> > > > > @@ -45,6 +46,7 @@ properties:
> > > > >        - const: core
> > > > >  
> > > > >    resets:
> > > > > +    minItems: 1
> > > > >      items:
> > > > >        - description: APB reset
> > > > >        - description: Core reset    
> > > > 
> > > > This relaxes the constraints for the existing devices, please
> > > > add per compatible constraints to avoid doing so.    
> > >   
> > Thanks Conor. Just to clarify, are you suggesting to add what was
> > done in v1?
> > v1:
> > https://lore.kernel.org/all/20231209142723.2060196-3-jisheng.teoh@starfivetech.com/
> >  
> 
> No, but similar. Add numerical constraints that vary per SoC without
> changing the names of the resets on a per-SoC basis.:wq
> 
Sent out v3, hope it addresses the comments.
v3:
https://lore.kernel.org/all/20231214033056.3953143-2-jisheng.teoh@starfivetech.com/
