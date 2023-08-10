Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B126777896
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjHJMgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjHJMgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:36:13 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928A21B4;
        Thu, 10 Aug 2023 05:36:12 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37ACFZBp017767;
        Thu, 10 Aug 2023 14:35:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=0T7Rg2lU27wBJcvPApX+ZRcZnKoy8Ze8aqeV+poDlHY=; b=j0
        6NU18S0325zaon9+rfW7FxRZfYjtk9zPfqUM6I5HXMfAbpqaHotlFcB4PZ7rHLxo
        TneY88iXFZQI5IO15l6PG/+waGNrd36IzYjArdRU46gC8VgLQ/qk8CsWu+8VL9BL
        U1SHNL4Z8lrwdDxVtzKpjdZFwxYlwmIYM8NCvvplmA2xo+JZjEhHLKYjUi7WdQ77
        3h160UPCMU57/Cvl2ixEalxYyvnp5bKAWUbBiW/uNVqMB0ZyMT8L6i9iVwh7sRrD
        ABiw3x7dQ3C0nIANzbVDPjCW4SSdLFrIdoDAxqC99CTjoGfSQ86DnLtZmM/SPByb
        5Ya4i6R8VOiheJ+xPhxw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3scdvdp3bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 14:35:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BA25E100057;
        Thu, 10 Aug 2023 14:35:57 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AFFCE2194E6;
        Thu, 10 Aug 2023 14:35:57 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 10 Aug
 2023 14:35:57 +0200
Message-ID: <4da65f77-c170-f82d-efa7-1727a470bc9f@foss.st.com>
Date:   Thu, 10 Aug 2023 14:35:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ARM: dts: stm32: fix dts check warnings on stm32mp15-scmi
Content-Language: en-US
To:     <p.paillet@foss.st.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230717134627.2064553-1-p.paillet@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230717134627.2064553-1-p.paillet@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 15:46, p.paillet@foss.st.com wrote:
> From: Pascal Paillet <p.paillet@foss.st.com>
> 
> Fix dts check warnings on stm32mp15-scmi reported by
> arm,scmi.yaml.
> 
> Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> ---

No more YAML issue on ST SCMI boards. Thanks!

Applied on stm32-next.

Thanks.
Alex


>   arch/arm/boot/dts/st/stm32mp15-scmi.dtsi | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp15-scmi.dtsi b/arch/arm/boot/dts/st/stm32mp15-scmi.dtsi
> index ad2584213d99..dc3b09f2f2af 100644
> --- a/arch/arm/boot/dts/st/stm32mp15-scmi.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp15-scmi.dtsi
> @@ -34,22 +34,21 @@ scmi_reguls: regulators {
>   					#address-cells = <1>;
>   					#size-cells = <0>;
>   
> -					scmi_reg11: reg11@0 {
> +					scmi_reg11: regulator@0 {
>   						reg = <0>;
>   						regulator-name = "reg11";
>   						regulator-min-microvolt = <1100000>;
>   						regulator-max-microvolt = <1100000>;
>   					};
>   
> -					scmi_reg18: reg18@1 {
> -						voltd-name = "reg18";
> +					scmi_reg18: regulator@1 {
>   						reg = <1>;
>   						regulator-name = "reg18";
>   						regulator-min-microvolt = <1800000>;
>   						regulator-max-microvolt = <1800000>;
>   					};
>   
> -					scmi_usb33: usb33@2 {
> +					scmi_usb33: regulator@2 {
>   						reg = <2>;
>   						regulator-name = "usb33";
>   						regulator-min-microvolt = <3300000>;

