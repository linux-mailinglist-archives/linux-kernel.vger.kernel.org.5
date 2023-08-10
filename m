Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42B377808A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjHJSnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjHJSnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:43:14 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D6526B7;
        Thu, 10 Aug 2023 11:43:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AIh8n5059097;
        Thu, 10 Aug 2023 13:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691692988;
        bh=ulw8wu2CRUdHfVz4Z3pklU+Ks0wJZs85pwH0V1QmuBQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=sDETJa8yAhyqIRbEFXuRA6gNCeWbVit9r8PeS9DVnOuZJrNQxJrwVEraiNv5UHvkp
         1ZyCegx5E4lDRxzHnDnj70h2zkIfWSVGGJ2jHpu+K/nT9G4jjgbqjGcbN1rEd/R5FP
         enxHNG0gTEe3NqmdgzDmzG8m+buVeA6r0J+EsGZo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AIh8Id110147
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 13:43:08 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 13:43:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 13:43:08 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AIh8j1025811;
        Thu, 10 Aug 2023 13:43:08 -0500
Date:   Thu, 10 Aug 2023 13:43:08 -0500
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
Message-ID: <20230810184308.q67ldarld6qwo5uq@erased>
References: <20230810045314.2676833-1-vigneshr@ti.com>
 <20230810045314.2676833-2-vigneshr@ti.com>
 <20230810-exile-accurate-790c6828133b@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230810-exile-accurate-790c6828133b@spud>
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

On 17:03-20230810, Conor Dooley wrote:
> On Thu, Aug 10, 2023 at 10:23:12AM +0530, Vignesh Raghavendra wrote:
> > From: Bryan Brattlof <bb@ti.com>
> > 
> > Add bindings for TI's AM62P5 family of devices.
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > ---
> >  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > index 5ca6af492507..93b2774cc0a9 100644
> > --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > @@ -25,6 +25,12 @@ properties:
> >                - ti,am62a7-sk
> >            - const: ti,am62a7
> >  
> > +      - description: K3 AM62P5 SoC
> 
> SoC seems a bit off here, since the sk is actually a board using the
> SoC, but it seems to be the convention for TI stuff,

Thanks for providing that perspective - there will be new boards
getting added to the enum list, they should be one line additions at
this point.

But, your point taken. K3 AM625P SoC based boards is more appropriate.

I can do the local change as I apply and keep your ack unless you
object.

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> 
> 
> > +        items:
> > +          - enum:
> > +              - ti,am62p5-sk
> > +          - const: ti,am62p5
> > +
> >        - description: K3 AM625 SoC PHYTEC phyBOARD-Lyra
> >          items:
> >            - const: phytec,am625-phyboard-lyra-rdk
> > -- 
> > 2.41.0
> > 



-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
