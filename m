Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355C477A676
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 15:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjHMNGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 09:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMNG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 09:06:29 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9A71710;
        Sun, 13 Aug 2023 06:06:30 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37DD6Mll069642;
        Sun, 13 Aug 2023 08:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691931982;
        bh=BSQNJsLiMFBeXbQhutgn6GIg9yUdJpSOyZRe4MGdYcw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=yaGHWImLsxuoQUH/hEfiWTw+VlchfM5g2LNGlKancWuZJAAGOp/t5F1UY/XeM9bQV
         PlFl8pxE1vI/fH866yQTeEPUANNaijkLhT6ljxvIOi++F3S8wD4jSWNs80s/S4wT90
         RZQ7fl7wt7os2JkDcTJ3uGrmHAWwRYrG0Pz+Bo9E=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37DD6LPg105507
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 13 Aug 2023 08:06:22 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 13
 Aug 2023 08:06:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 13 Aug 2023 08:06:21 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37DD6Lgw018615;
        Sun, 13 Aug 2023 08:06:21 -0500
Date:   Sun, 13 Aug 2023 08:06:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm: ti: Add bindings for AM62P5 SoCs
Message-ID: <20230813130621.giejq3snmp6dt5gs@cheer>
References: <20230810045314.2676833-1-vigneshr@ti.com>
 <20230810045314.2676833-2-vigneshr@ti.com>
 <20230810-exile-accurate-790c6828133b@spud>
 <20230810184308.q67ldarld6qwo5uq@erased>
 <20230813-sleek-trash-16ea454e2640@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230813-sleek-trash-16ea454e2640@spud>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:55-20230813, Conor Dooley wrote:
> On Thu, Aug 10, 2023 at 01:43:08PM -0500, Nishanth Menon wrote:
> > On 17:03-20230810, Conor Dooley wrote:
> > > On Thu, Aug 10, 2023 at 10:23:12AM +0530, Vignesh Raghavendra wrote:
> > > > From: Bryan Brattlof <bb@ti.com>
> > > > 
> > > > Add bindings for TI's AM62P5 family of devices.
> > > > 
> > > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > > > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > > > index 5ca6af492507..93b2774cc0a9 100644
> > > > --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > > > @@ -25,6 +25,12 @@ properties:
> > > >                - ti,am62a7-sk
> > > >            - const: ti,am62a7
> > > >  
> > > > +      - description: K3 AM62P5 SoC
> > > 
> > > SoC seems a bit off here, since the sk is actually a board using the
> > > SoC, but it seems to be the convention for TI stuff,
> > 
> > Thanks for providing that perspective - there will be new boards
> > getting added to the enum list, they should be one line additions at
> > this point.
> > 
> > But, your point taken. K3 AM625P SoC based boards is more appropriate.
> > 
> > I can do the local change as I apply and keep your ack unless you
> > object.
> 
> Oh totally no objection, "xyz SoC based boards" is what most people seem
> to use.

Thank you V2 addresses it (the version I committed in), but looks like
the k3.yaml can do with a cleanup - will do it in one shot once the
window opens up.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
