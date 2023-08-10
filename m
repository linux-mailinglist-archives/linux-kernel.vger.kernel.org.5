Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35520777B57
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbjHJOxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjHJOxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:53:08 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99493A8;
        Thu, 10 Aug 2023 07:53:07 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37AAftPi010419;
        Thu, 10 Aug 2023 16:52:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=BKMmwew5tFclpv2pO0AXv3ufer96Kv+HUcWutf+ce1Q=; b=S+
        aSbS8SUQEas3o1QUbKIb21Q1ovVPkEULlFJiQ6E9FWJl0UXhMhdR9tjGK0U9zVRm
        M4KCHBHuQVTSbUtzb7PMsYe5nixH8OVdq3O1h7C26sRIWQTHC46led62QMgFtwoX
        +NfjpY2uhLELxoRynATdVo4V+zEKw3K59iH5mcScIb8ycVelccaPAG2i14Bdk7j5
        eisF6XW4I+iWCnWBgNSBwoCZ4MeZG4uwmyHa3MEqeDfVKkn1UkbdMC2lhN3PtXwx
        7xryWZelGmmw0tI1GS35FV+N1ezmfV/SOOAe5ecN+ZPbuWqwxYq4u+IUPsBTDRGI
        Lc83cGh3EGHpeTIc+ueg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sctu3tyt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 16:52:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78358100064;
        Thu, 10 Aug 2023 16:52:29 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6F44E2194DD;
        Thu, 10 Aug 2023 16:52:29 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 10 Aug
 2023 16:52:28 +0200
Message-ID: <e5decb2b-f456-dfc8-5a91-76b102d8b9fd@foss.st.com>
Date:   Thu, 10 Aug 2023 16:52:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v3 08/10] net: stmmac: platform: support parsing
 safety irqs from DT
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230809165007.1439-1-jszhang@kernel.org>
 <20230809165007.1439-9-jszhang@kernel.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230809165007.1439-9-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_12,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 18:50, Jisheng Zhang wrote:
> The snps dwmac IP may support safety features, and those Safety
> Feature Correctible Error and Uncorrectible Error irqs may be
> separate irqs. Add support to parse the safety irqs from DT.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   .../net/ethernet/stmicro/stmmac/stmmac_platform.c    | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 23d53ea04b24..29145682b57b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -738,6 +738,18 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>   		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
>   	}
>   
> +	stmmac_res->sfty_ce_irq = platform_get_irq_byname_optional(pdev, "sfty_ce");
> +	if (stmmac_res->sfty_ce_irq < 0) {
> +		if (stmmac_res->sfty_ce_irq == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	stmmac_res->sfty_ue_irq = platform_get_irq_byname_optional(pdev, "sfty_ue");
> +	if (stmmac_res->sfty_ue_irq < 0) {
> +		if (stmmac_res->sfty_ue_irq == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +	}
> +
>   	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
>   
>   	return PTR_ERR_OR_ZERO(stmmac_res->addr);
Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>

Regards
Alex

