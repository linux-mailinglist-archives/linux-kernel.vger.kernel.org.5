Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC8677DB5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242516AbjHPHqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242576AbjHPHqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:46:35 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CA2269F;
        Wed, 16 Aug 2023 00:46:33 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G3mWKe002776;
        Wed, 16 Aug 2023 09:46:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=Ki3nCpAHJxDjoPlXq1GuFrLCln/0J1MjpuWSKx2562Q=; b=pu
        Y47KmtSUdB/Sl2i3mZRalrrgnTBog6/PYyQbIg7YM6SCCUaTfnJjk5f9gAGXh2F2
        19WK234W9zqk/n//zO3q5vele4JJ3KPE4io17LMtioD0g5Ng9BsDHRIV35eGiCVW
        z+JAJ+lPOdI3M6n+FTqBvCUC50PWXJBA2qkutF160+qf5bH5dObDAzV8PMcXJMfy
        u8pjmyVbJU9olVi0lidzfiUlMGv/bIrRXgBk3wkBycPn0l7pGc4mfT9jjpjojQAI
        BLcQUo9uudGALubrlyS4o3CZqUw+2SlXj1Im2nEtAUpozXzZpAlp7BLhcpQXv1EL
        wc2SSsznznr+/IS0tNoA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sgpvgs1ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 09:46:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 64D3010005D;
        Wed, 16 Aug 2023 09:46:13 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5BD5B2194F2;
        Wed, 16 Aug 2023 09:46:13 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 09:46:12 +0200
Message-ID: <ce3a231a-825f-0dab-e33b-d534c0488f6c@foss.st.com>
Date:   Wed, 16 Aug 2023 09:46:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: sti: add STi boards and remove
 stih415/stih416
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230213185633.15187-1-avolmat@me.com>
 <20230213185633.15187-3-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230213185633.15187-3-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_06,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/23 19:56, Alain Volmat wrote:
> Add bindings for STi platform boards and remove stih415/stih416
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v3: move back file into bindings/arm and update commit log accordingly
> v2: update licensing
>     move file into soc/sti folder
>  .../devicetree/bindings/arm/sti.yaml          | 23 ++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sti.yaml b/Documentation/devicetree/bindings/arm/sti.yaml
> index 3ca054c64377..842def3e3f2b 100644
> --- a/Documentation/devicetree/bindings/arm/sti.yaml
> +++ b/Documentation/devicetree/bindings/arm/sti.yaml
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/arm/sti.yaml#
> @@ -13,13 +13,20 @@ properties:
>    $nodename:
>      const: '/'
>    compatible:
> -    items:
> -      - enum:
> -          - st,stih415
> -          - st,stih416
> -          - st,stih407
> -          - st,stih410
> -          - st,stih418
> +    oneOf:
> +      - items:
> +          - const: st,stih407-b2120
> +          - const: st,stih407
> +      - items:
> +          - enum:
> +              - st,stih410-b2120
> +              - st,stih410-b2260
> +          - const: st,stih410
> +      - items:
> +          - enum:
> +              - st,stih418-b2199
> +              - st,stih418-b2264
> +          - const: st,stih418
>  
>  additionalProperties: true
>  
Applied on sti-next

Thanks 
Patrice
