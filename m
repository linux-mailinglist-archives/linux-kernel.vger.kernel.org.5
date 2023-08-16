Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247F777DB5C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbjHPHqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbjHPHqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:46:09 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121572128;
        Wed, 16 Aug 2023 00:46:07 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G12L0T009086;
        Wed, 16 Aug 2023 09:45:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=3UWe2zKENf3Jn6OVp3ZWQ9Px4PyTOv77PIs6n4hvMLU=; b=Md
        fmIXLN2ugCM+UuU2K+vwXbzTQtncl0KIKwZUIRVVaTuSTI2iT9KJcZVDX+NRtu43
        3j234NC/Swr4vNwAzuLR9CWFVI3SKmQyEYQaIe8QLksjL0sLy4VKwafRcYuzqD2c
        wFtV+anCMPNIKvWITwLz54hbFj4t5Sa7m+sDToc5WL6bixYwXQfxCApOrricRle5
        r6spcKqdoLNuN6jfbsRepQUpfPxWnO+TF+4FXrvS11BjY4qRGS19VpiT3q5YCvXl
        cG/GqrR3py4m/Fj4kosLdkQzsKRlDVKMS+yQBQqXqMuqFuWD1bcUFyjZQfvfZPXX
        HZy3nxX7tTDRPC4sq1tA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sg0k265xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 09:45:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 50F7710005D;
        Wed, 16 Aug 2023 09:45:55 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 42C5D2194F2;
        Wed, 16 Aug 2023 09:45:55 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 09:45:54 +0200
Message-ID: <ce0a160e-a666-5b34-b7b7-cbd18c480e58@foss.st.com>
Date:   Wed, 16 Aug 2023 09:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: sti: add STi platform syscon
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230213185633.15187-1-avolmat@me.com>
 <20230213185633.15187-2-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230213185633.15187-2-avolmat@me.com>
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
> Add DT schema of STi platform syscon
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> v3: correct subject line arm -> soc
> 
> v2: update wording of commit log
>     reorder compatible enum
>     update example within the binding file
>  .../bindings/soc/sti/st,sti-syscon.yaml       | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml b/Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml
> new file mode 100644
> index 000000000000..5f97d9ff17fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/sti/st,sti-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STi platform sysconfig
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +
> +description: |
> +  Binding for the various sysconfig nodes used within the STi
> +  platform device-tree to point to some common configuration
> +  registers used by other nodes.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - st,stih407-core-syscfg
> +          - st,stih407-flash-syscfg
> +          - st,stih407-front-syscfg
> +          - st,stih407-lpm-syscfg
> +          - st,stih407-rear-syscfg
> +          - st,stih407-sbc-reg-syscfg
> +          - st,stih407-sbc-syscfg
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscfg_sbc: syscon@9620000 {
> +        compatible = "st,stih407-sbc-syscfg", "syscon";
> +        reg = <0x9620000 0x1000>;
> +    };
> +
> +...
Applied on sti-next

Thanks 
Patrice
