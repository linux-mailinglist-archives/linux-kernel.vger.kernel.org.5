Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBFE7779D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjHJNq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjHJNq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:46:26 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBC1211D;
        Thu, 10 Aug 2023 06:46:25 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37ACP2ei017875;
        Thu, 10 Aug 2023 15:46:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=97HpYr8jD4ZchTkTGJi8K10RVqD9nsGZy5MZRTtMlyM=; b=mu
        V0XlosQQ3/70vwwk/mdmYqMFWCG4nT4licVI94r0HiJZVEqb0BdIPGEmjLyD0ENm
        rU90t5WINBz511xBJnrhz54uTI1H1NpIFXr4AvFdVkHs5+EKH/pfk2rBgGQ7OHaM
        ww6EiCCcLnYKfIkSeYBaTfxqClVww5oTjk87DOBxWJDgEgiCn1iRehdlGVXGN9Iv
        pteTtqw6H21Nk1y1dwV2W5vHFpEz0LApDcD15g6PqAhPmrKI3vHeYa0b2RGu2/Ek
        clZs9AN5Z+joYRweJ3lUyh03XHzjOQ1TLGFDxN4cZNKM3+qezOmGsotcvk9TQrx3
        4iJnkCSpGwyPamQDBWeg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3scdvdpgxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 15:46:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E4C3B100057;
        Thu, 10 Aug 2023 15:46:02 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DCC8A21BF73;
        Thu, 10 Aug 2023 15:46:02 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 10 Aug
 2023 15:46:01 +0200
Message-ID: <2379f0b2-463a-236c-05f4-b073470588ea@foss.st.com>
Date:   Thu, 10 Aug 2023 15:46:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v3 02/10] net: stmmac: xgmac: add more feature
 parsing from hw cap
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
 <20230809165007.1439-3-jszhang@kernel.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230809165007.1439-3-jszhang@kernel.org>
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

On 8/9/23 18:49, Jisheng Zhang wrote:
> The XGMAC_HWFEAT_GMIISEL bit also indicates whether support 10/100Mbps
> or not.
> The XGMAC_HWFEAT_HDSEL bit indicates whether support half duplex or
> not.
> The XGMAC_HWFEAT_ADDMACADRSEL bit indicates whether support Multiple
> MAC address registers or not.
> The XGMAC_HWFEAT_SMASEL bit indicates whether support SMA (MDIO)
> Interface or not.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     | 3 +++
>   drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 4 ++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 153321fe42c3..81cbb13a101d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -111,6 +111,7 @@
>   #define XGMAC_LPI_TIMER_CTRL		0x000000d4
>   #define XGMAC_HW_FEATURE0		0x0000011c
>   #define XGMAC_HWFEAT_SAVLANINS		BIT(27)
> +#define XGMAC_HWFEAT_ADDMACADRSEL	GENMASK(22, 18)
>   #define XGMAC_HWFEAT_RXCOESEL		BIT(16)
>   #define XGMAC_HWFEAT_TXCOESEL		BIT(14)
>   #define XGMAC_HWFEAT_EEESEL		BIT(13)
> @@ -121,7 +122,9 @@
>   #define XGMAC_HWFEAT_MMCSEL		BIT(8)
>   #define XGMAC_HWFEAT_MGKSEL		BIT(7)
>   #define XGMAC_HWFEAT_RWKSEL		BIT(6)
> +#define XGMAC_HWFEAT_SMASEL		BIT(5)
>   #define XGMAC_HWFEAT_VLHASH		BIT(4)
> +#define XGMAC_HWFEAT_HDSEL		BIT(3)
>   #define XGMAC_HWFEAT_GMIISEL		BIT(1)
>   #define XGMAC_HW_FEATURE1		0x00000120
>   #define XGMAC_HWFEAT_L3L4FNUM		GENMASK(30, 27)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index b09395f5edcb..b5ba4e0cca55 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -406,6 +406,10 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
>   	dma_cap->pmt_remote_wake_up = (hw_cap & XGMAC_HWFEAT_RWKSEL) >> 6;
>   	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
>   	dma_cap->mbps_1000 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
> +	dma_cap->mbps_10_100 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
> +	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
> +	dma_cap->multi_addr = (hw_cap & XGMAC_HWFEAT_ADDMACADRSEL) >> 18;
> +	dma_cap->sma_mdio = (hw_cap & XGMAC_HWFEAT_SMASEL) >> 5;
>   
>   	/* MAC HW feature 1 */
>   	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE1);

Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>

Regards
Alex

