Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6617A065B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbjINNrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbjINNrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:47:48 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E241AE;
        Thu, 14 Sep 2023 06:47:44 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38EDlV8g042617;
        Thu, 14 Sep 2023 08:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694699251;
        bh=bvTFouSGru3/P8THWO1c+pCZJasbLhY1JpKYv57LT34=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=X9fVAQJGJ5F0aw1gZVlH3T7xvbEVi7q2ezZ5LL0t3Xxsk/gJSWhfn1DQULw1efgjP
         ZNz9QVUEiPNtqdIT+LuLIvwJri2mSn+W2lEuwEycOMj+HdCcIjNCkMBytUSwim0zDB
         LZsFoDjHsNNYyGGbIbroEN5Lcmm7qRUOMLF/kwi4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38EDlVFB027658
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Sep 2023 08:47:31 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Sep 2023 08:47:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Sep 2023 08:47:31 -0500
Received: from [128.247.81.19] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38EDlUUA004373;
        Thu, 14 Sep 2023 08:47:30 -0500
Message-ID: <e7a48365-3cfd-8a5f-f4d7-6b40dd394f54@ti.com>
Date:   Thu, 14 Sep 2023 08:47:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: syscon: Add
 ti,am654-dss-oldi-io-ctrl compatible
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911142556.64108-1-afd@ti.com>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20230911142556.64108-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/23 09:25, Andrew Davis wrote:
> Add TI DSS OLDI-IO control registers compatible. This is a region of 5
> 32bit registers found in the TI AM65 CTRL_MMR0 register space[0]. They
> are used to control the characteristics of the OLDI DATA/CLK IO as needed
> by the DSS display controller node.
> 
> [0] https://www.ti.com/lit/pdf/spruid7
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

> ---
> 
> Changes for v2:
>  - Use device specific compatible string
> 
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 8103154bbb529..ab7e26c3469af 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -69,6 +69,7 @@ properties:
>                - rockchip,rk3588-qos
>                - rockchip,rv1126-qos
>                - starfive,jh7100-sysmain
> +              - ti,am654-dss-oldi-io-ctrl
>  
>            - const: syscon
>  
