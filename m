Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EFB7F5189
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjKVUYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjKVUYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:24:34 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61B31BD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:24:29 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c873cf9f74so2679761fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700684668; x=1701289468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pa4PSx1bqwHUNtr2jOQTdwbCw2lGoLr2aW9SF4QV68E=;
        b=trJZ9rCtBBkRyoW5ItepmGgU4L9zF4BIn6Jin5AdJegD6zRDhSheOjEmmOBTGnwvct
         lbIB4p0pYlxttSLzDTBxw1YahC1CsTQok0XRB3mGcOKT60/z5Hjas28wV5fY6AOqoR5H
         NYdwlwGyltCWdTn7ANOjAP3YCA8rwmpEBeAA6iHuyhKhYCcGigvhaP1Ws9nmVWk11iKB
         UBF+tPS9moJRHWhpYaH54zSfk2vS9xlZw+v7qQSFKcZLsVCqheChyBndgv1dCFyDv4ew
         ZSeV8pFFlghK2AnvOIsFm+GurSSeVe+Bi+3u59vXVjW9NsjUdcIsI52pXGR4sxU6J3kq
         qjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700684668; x=1701289468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pa4PSx1bqwHUNtr2jOQTdwbCw2lGoLr2aW9SF4QV68E=;
        b=LM2qeFzV3JRnAtxPFPrIgy/3MZtB6eU1S0MbOs7mwTNiUpnOHkAlfuk1Ha2IL5wrWc
         6jfKaCyGTTRbJkCo9DdO7w5KavuWK5SA4ybMWT8x1E54loR2V/Lv0mofzyl7JJxJ3YJV
         gEbHG2qSouktHBD2zEvomAi1fPTzdd4SVz/xraGp/+0gfyEI/SnAa2PZ0/8bzksTrul0
         hW9Rx2t9WU2hS4wM/4gsSxH4+JW/4SAPGTzeJtTFkSO9SMBXb1zOj74GCciggoa0Mrax
         gn4pN7tmgpZkyrGovBv5HZikkMYpVu9eVkjHzewfW9WDAFPq7pxwPrFJQ+gQtA+XI+98
         n45A==
X-Gm-Message-State: AOJu0YxckKF+OAR1H5oT1oM4u3dAmtc4HTvDLlL3yYMKge/9zILZt+xr
        txTt7SAFFVENQj8NMPABbxMBBQ==
X-Google-Smtp-Source: AGHT+IHCqJnqmqruquEzZmPUrGzbkNt3QnbrS5s9HB1QFQs8oQy4JStcei9zVZVifxLEVasGTNqeiw==
X-Received: by 2002:a2e:920b:0:b0:2c5:23e3:ed11 with SMTP id k11-20020a2e920b000000b002c523e3ed11mr2713058ljg.30.1700684667938;
        Wed, 22 Nov 2023 12:24:27 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f27-20020a2eb5bb000000b002b9f03729e2sm42821ljn.36.2023.11.22.12.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 12:24:27 -0800 (PST)
Message-ID: <f18b6552-bf8d-4826-969a-a0de60bd0ad3@linaro.org>
Date:   Wed, 22 Nov 2023 21:24:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] net: mdio: ipq4019: configure CMN PLL clock for
 ipq5332
Content-Language: en-US
To:     Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        robert.marko@sartura.hr
Cc:     linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-5-quic_luoj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231115032515.4249-5-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/23 04:25, Luo Jie wrote:
> The reference clock of CMN PLL block is selectable, the internal
> 48MHZ is used by default.
> 
> The output clock of CMN PLL block is for providing the clock
> source of ethernet device(such as qca8084), there are 1 X 25MHZ
> and 3 x 50MHZ output clocks available.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>   drivers/net/mdio/mdio-ipq4019.c | 81 ++++++++++++++++++++++++++++++++-
>   1 file changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
> index 93ae4684de31..ca9cda98d1f8 100644
> --- a/drivers/net/mdio/mdio-ipq4019.c
> +++ b/drivers/net/mdio/mdio-ipq4019.c
> @@ -43,6 +43,13 @@
>   /* Maximum SOC PCS(uniphy) number on IPQ platform */
>   #define ETH_LDO_RDY_CNT				3
>   
> +#define CMN_PLL_REFERENCE_CLOCK			0x784
> +#define CMN_PLL_REFCLK_INDEX			GENMASK(3, 0)
> +#define CMN_PLL_REFCLK_EXTERNAL			BIT(9)
> +
> +#define CMN_PLL_POWER_ON_AND_RESET		0x780
> +#define CMN_ANA_EN_SW_RSTN			BIT(6)
> +
>   enum mdio_clk_id {
>   	MDIO_CLK_MDIO_AHB,
>   	MDIO_CLK_UNIPHY0_AHB,
> @@ -54,6 +61,7 @@ enum mdio_clk_id {
>   
>   struct ipq4019_mdio_data {
>   	void __iomem *membase;
> +	void __iomem *cmn_membase;
>   	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
>   	struct clk *clk[MDIO_CLK_CNT];
>   	struct gpio_descs *reset_gpios;
> @@ -227,12 +235,73 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
>   	return 0;
>   }
>   
> +/* For the CMN PLL block, the reference clock can be configured according to
> + * the device tree property "cmn_ref_clk", the internal 48MHZ is used by default
> + * on the ipq533 platform.
> + *
> + * The output clock of CMN PLL block is provided to the MDIO slave devices,
> + * threre are 4 CMN PLL output clocks (1x25MHZ + 3x50MHZ) enabled by default.
> + *
> + * such as the output 50M clock for the qca8084 PHY.
> + */
> +static void ipq_cmn_clock_config(struct mii_bus *bus)
> +{
> +	u32 reg_val;
> +	const char *cmn_ref_clk;
> +	struct ipq4019_mdio_data *priv = bus->priv;
> +
> +	if (priv && priv->cmn_membase) {
> +		reg_val = readl(priv->cmn_membase + CMN_PLL_REFERENCE_CLOCK);
> +		reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL | CMN_PLL_REFCLK_INDEX);
> +
> +		/* Select reference clock source */
> +		cmn_ref_clk = of_get_property(bus->parent->of_node, "cmn_ref_clk", NULL);
> +		if (!cmn_ref_clk) {
> +			/* Internal 48MHZ selected by default */
> +			reg_val |= FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7);
> +		} else {
> +			if (!strcmp(cmn_ref_clk, "external_25MHz"))
As pointed out by others, such string properties won't go through

Konrad
