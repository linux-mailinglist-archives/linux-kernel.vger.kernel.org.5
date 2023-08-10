Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07939777C94
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbjHJPry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbjHJPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:47:51 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D58B1BF7;
        Thu, 10 Aug 2023 08:47:50 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AClMgO009214;
        Thu, 10 Aug 2023 17:47:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=dO02g57JBt0tPglFtQxM7v6lp9jpJQ9kk9OhJ6JsgMA=; b=4c
        myKTHuly1Wfyqef7O974UyigI2j795n01IqiMC4VVN5JKkIo5b2TfnAk8/hO1SMc
        c4RwmE8sEkHHesGiPUSgrjhm0FAmARJPJS0xlbWzKm1ORpdluCnAIXPOqzZ6Qof3
        os1sbCIFPZSqmW0io/DjBZrBvOkzLZ3mOwoEjq8YgNzwgfswOw/QKniMK47DtAe6
        0IGnlIzhwS7cKZblV/hZCpEUpWdBluK4BW4dhVViytqD6SCyN26a+mufJLokoh5K
        n04iajOiMuPtJAS3wJNgJLhJAcd+fN0gfsLN5umgyAko1nsjIfWSuRXoZ1jfqUCy
        pIMbXqSHmjw+ygzSbS+g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sd0730xmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 17:47:36 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2F916100053;
        Thu, 10 Aug 2023 17:47:36 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 25D3221862A;
        Thu, 10 Aug 2023 17:47:36 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 10 Aug
 2023 17:47:35 +0200
Message-ID: <27c25fa9-b76b-e7ff-2930-e9d7de83d347@foss.st.com>
Date:   Thu, 10 Aug 2023 17:47:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/4] ARM: dts: st: stm32mp157c-emstamp: drop incorrect
 vref_ddr property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230730174954.5293-1-krzysztof.kozlowski@linaro.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230730174954.5293-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_13,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/23 19:49, Krzysztof Kozlowski wrote:
> The STPMIC1 PMIC vref_ddr regulator does not support over-current
> protection, according to bindings and Linux driver:
> 
>    stm32mp157c-emsbc-argon.dtb: stpmic@33: regulators:vref_ddr: 'regulator-over-current-protection' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. None
> ---
>   arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi b/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
> index fd89542c69c9..f8e9980ed3d4 100644
> --- a/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
> @@ -310,7 +310,6 @@ vdda: ldo6 {
>   			vref_ddr: vref_ddr {
>   				regulator-name = "vref_ddr";
>   				regulator-always-on;
> -				regulator-over-current-protection;
>   			};
>   
>   			bst_out: boost {


Applied on stm32-next.

Thanks.
Alex
