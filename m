Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BD07729BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjHGPsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHGPse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:48:34 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB213AA;
        Mon,  7 Aug 2023 08:48:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377FmPMV044546;
        Mon, 7 Aug 2023 10:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691423305;
        bh=NPz7a80K2FkSxjRcF3xZQ2MRydRhRayI5T9R1KAt6bc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=SVMRsDzcPzE0xlZraVy9CwRxgCO7Ma6jL1xw/Ezm1fXxQlb33HmD/fkG7zKQ9mfA4
         tnDZrE3puIqKgZda+kSN7jcEliW2zORL+PhzNe7hi+vjVNGBn7o1DUbmk9bFvzPx/7
         qO62h85VfQd9UW1jyAgK0Q/EBLjSM3Rd1UxquT44=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377FmP5c112492
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 10:48:25 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 10:48:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 10:48:25 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377FmOQc006254;
        Mon, 7 Aug 2023 10:48:25 -0500
Date:   Mon, 7 Aug 2023 21:18:24 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: pinctrl-single: add am62x
 compatible
Message-ID: <20230807154824.y6x2vnfoa65jxcyp@dhruva>
References: <20230803092311.604610-1-d-gole@ti.com>
 <89993371-e26d-0308-060c-312a66c0cb08@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <89993371-e26d-0308-060c-312a66c0cb08@linaro.org>
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

Krzysztof,

On Aug 07, 2023 at 16:53:28 +0200, Krzysztof Kozlowski wrote:
> On 03/08/2023 11:23, Dhruva Gole wrote:
> > Add the am62x compatible property to add support for the new
> > wakeup enable and status bits positions
> > 
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > CC: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> > 
> > Base: tag: next-20230731 + below "depends on" patch
> > Depends on: https://lore.kernel.org/linux-omap/20230731061908.GG5194@atomide.com/T/
> > 
> >  Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> > index b6b6bcd7074b..4c98035a1217 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> > @@ -23,6 +23,7 @@ properties:
> >            - pinconf-single
> >        - items:
> >            - enum:
> > +              - ti,am6-padconf
> 
> This does not look like am62x. Except this, am62x looks like family, not
> SoC.

We are at V3 in this patch,
Tony, please can you review the latest rev?
https://lore.kernel.org/all/20230804050737.635186-1-d-gole@ti.com/

Otherwise, I will re-spin a new series including the DT-Binding patch
and the driver changes in a single patch series, where I will pick Tony's R-by.

> 
> Best regards,
> Krzysztof
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
