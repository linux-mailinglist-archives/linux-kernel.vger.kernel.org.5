Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC82376F48F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjHCVQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjHCVQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:16:24 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4575E212B;
        Thu,  3 Aug 2023 14:15:50 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373LFWTb093898;
        Thu, 3 Aug 2023 16:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691097332;
        bh=EykX/fSWMDfipxutXXuVj15oqbyV5u2JGSo7DRMwIaQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=OOCWpb+PtMJ4i/j1cga2VjQ9IIX7wT1FPy7dkFNhK0VdXf5FALEg4h5HrfUWyaSFz
         WhVAg7wqpkjSJhb+sP+TN5jw/GFwLDMpTR1us5+E/RnC7CVrrT20eEYbMunvFnRQ8w
         7ifsUupDmvv2R5IXwCAEMMnOgKmS0kCPtSu/R5wE=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373LFWx9039379
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 16:15:32 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 16:15:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 16:15:32 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373LFWXS040988;
        Thu, 3 Aug 2023 16:15:32 -0500
Date:   Thu, 3 Aug 2023 16:15:32 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Dhruva Gole <d-gole@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH V2] dt-bindings: pinctrl: pinctrl-single: add am625
 compatible
Message-ID: <20230803211532.ge4yr5r6pwprlyml@bonsai>
References: <20230803150955.611717-1-d-gole@ti.com>
 <20230803-antennae-donut-6cae9d43d791@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803-antennae-donut-6cae9d43d791@spud>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:29-20230803, Conor Dooley wrote:
> On Thu, Aug 03, 2023 at 08:39:55PM +0530, Dhruva Gole wrote:
> > Add the am625 compatible property to add support for the new
> > wakeup enable and status bits positions
> > 
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > CC: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.
> 
> > ---
> > 
> > Base: tag: next-20230731 + below "depends on" patch
> > Depends on: https://lore.kernel.org/linux-omap/20230731061908.GG5194@atomide.com/T/
> > 
> > v1 -> v2 changes:
> > rename to use am625 instead of am6
> > 
> > link to previous version:
> > https://lore.kernel.org/all/20230803092311.604610-1-d-gole@ti.com/
> > 
> >  Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> > index b6b6bcd7074b..902469986fff 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> > @@ -23,6 +23,7 @@ properties:
> >            - pinconf-single
> >        - items:
> >            - enum:
> > +              - ti,am625-padconf
> >                - ti,am437-padconf

please keep this sorted.
> >                - ti,dra7-padconf
> >                - ti,omap2420-padconf
> > -- 
> > 2.34.1
> > 



-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
