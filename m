Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5A87779D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjHJNql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjHJNqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:46:39 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC37CE54;
        Thu, 10 Aug 2023 06:46:38 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37ABphRs008067;
        Thu, 10 Aug 2023 15:46:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=HbT+tUHLMeYFY+/JIhpY3GrboVoERo5Z1ifpZ9cL6vE=; b=RH
        O5fty8jncHHGv8wC1zIJAQ1wxJo0nTjqRF8P9VMF7V3+GS5MbP34E9u7EQH7YqyS
        v8ZUpxWKkRIKA4XemZjB5cXbamd3lAovMi5iLFdD6shomomKIuAE0Vq4bYKNbR5L
        0pFagd3tZGfp/nyvh9zfE92q2kSdsbfLCyX0SR4kAqM+jcMPGRiVzYHTTDq55mlz
        ZcgCyX8UahpR1yzW6N6ZUlkewOULK4mXvcCXyQAtQWAqWCiaVCdl14OQpFyhzVWa
        u2o2bkxrsOwzrtdHqxBiwhrBdzQaEuLXcxdJMMH3+1j8iVL5LrWchqUEgucOqkTN
        6j4hsE5c6cNP+FKE3F3Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3scdv7phy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 15:46:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2AC4C100053;
        Thu, 10 Aug 2023 15:46:18 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 22D1A21BF73;
        Thu, 10 Aug 2023 15:46:18 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 10 Aug
 2023 15:46:17 +0200
Message-ID: <7308becc-cdc2-74da-9eda-4b7923cbf5d0@foss.st.com>
Date:   Thu, 10 Aug 2023 15:46:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v3 03/10] net: stmmac: mdio: enlarge the max
 XGMAC C22 ADDR to 31
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
 <20230809165007.1439-4-jszhang@kernel.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230809165007.1439-4-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 18:50, Jisheng Zhang wrote:
> The IP can support up to 31 xgmac c22 addresses now.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index 3db1cb0fd160..e6d8e34fafef 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -40,7 +40,7 @@
>   #define MII_XGMAC_WRITE			(1 << MII_XGMAC_CMD_SHIFT)
>   #define MII_XGMAC_READ			(3 << MII_XGMAC_CMD_SHIFT)
>   #define MII_XGMAC_BUSY			BIT(22)
> -#define MII_XGMAC_MAX_C22ADDR		3
> +#define MII_XGMAC_MAX_C22ADDR		31
>   #define MII_XGMAC_C22P_MASK		GENMASK(MII_XGMAC_MAX_C22ADDR, 0)
>   #define MII_XGMAC_PA_SHIFT		16
>   #define MII_XGMAC_DA_SHIFT		21

Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>

Regards
Alex

