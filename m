Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D0A8004FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377765AbjLAHqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjLAHqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:46:53 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A30A8;
        Thu, 30 Nov 2023 23:46:59 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B17klIs091024;
        Fri, 1 Dec 2023 01:46:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701416807;
        bh=WEQ2+V2GxV6+mOf3O0qmIFLWLRbLrd2v99yg60idhug=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=OH3Fs5O+xUEdURWUrJ7SDFXM+scTL2VX7wNrlHYXjh6TQ/jgxCREwCdo653lwXB3I
         Sh8FmqT4RCftyLl0GcySHc5MiNGoSTRLV53H4Nl856HbwVe6sfqQkq9REKeJPoB3D5
         LTHalZCY0zlNpeRnGbCK9ie6lcKnsum/baPDcZCY=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B17klX4116840
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Dec 2023 01:46:47 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 01:46:47 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 01:46:47 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B17klNU002242;
        Fri, 1 Dec 2023 01:46:47 -0600
Date:   Fri, 1 Dec 2023 01:46:47 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Thomas Richard <thomas.richard@bootlin.com>
CC:     Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>, <gregory.clement@bootlin.com>,
        <u-kumar1@ti.com>
Subject: Re: [PATCH 1/5] dt-bindings: arm: keystone: add ti,j7200-sci
 compatible
Message-ID: <20231201074647.orwgcpo3a2cv46gg@excitable>
References: <20231129-j7200-tisci-s2r-v1-0-c1d5964ed574@bootlin.com>
 <20231129-j7200-tisci-s2r-v1-1-c1d5964ed574@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231129-j7200-tisci-s2r-v1-1-c1d5964ed574@bootlin.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:31-20231129, Thomas Richard wrote:
> On j7200, during suspend to ram the soc is powered-off.
> At resume requested irqs shall be restored which is a different behavior
> from other platforms.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> index c24ad0968f3e..53d9c58dcd70 100644
> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> @@ -40,6 +40,8 @@ properties:
>        - description: System controller on TI AM654 SoC
>          items:
>            - const: ti,am654-sci
> +      - description: System controller on TI J7200 SOC
> +          - const: ti,j7200-sci
>  
>    reg-names:
>      description: |
> 
> -- 
> 2.39.2
> 

Sorry, but I don't see why this is any different for all K3 devices.
they all follow the same pattern of usage.

Also, constraints you are speaking off is also present even for
am654-sci. just handle this in the driver.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
