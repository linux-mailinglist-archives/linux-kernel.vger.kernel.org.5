Return-Path: <linux-kernel+bounces-153068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8536A8AC897
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107C81F247EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF4053E12;
	Mon, 22 Apr 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghUDNnpX"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB03C4C602
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777164; cv=none; b=jNQ3lRSvQmIymCDIV85QY2xlVjK6N0zdM49en7tEfOy2Legsyx29emmwUCi9FbS2a0MkyE9iVeVJoXPqzxCGAoXtdkZsvEf0bU5goSy7mPFB50HS45sqfRZLrkPaUu5IaJbU0QdgXYC9y9JTCbobL06Bz+grVzee7IFF/fl6h7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777164; c=relaxed/simple;
	bh=WE0KzX3VJKaep+Dhdb0z/FehMwSsCc8bQKgh8J8SkqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdcuDOFbYfLfYpMTFeM4HYRwqB98tHoT5XRUVhahBmCFn22dP9GOWgaVXBHXN1jmxPlwuabhLGI4VV9DhzZ5hOpm4+5h9gaH/wFNu7cJf22T2l/CCia4hCPTh16YBem9wnK/FdDGvwSP7E63Uvu/QYpKPl1gux81FddNFXtiAqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ghUDNnpX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a44ad785a44so380938766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713777161; x=1714381961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LUXy42KiwkMsfzFd8SftlWu2Tv7A1Nv/ePpZqOKpeVo=;
        b=ghUDNnpXjTYtlVIEFNwFXkp85uBLPy2XgJMncBJ1CX2Q8EkBBKQSdDduznY4DcjGtK
         RG5egitNrwDKeUHFhodNwagGQngHW2j4KarIA37Xhukt+bmrownXb8CYKLtveQ0fjb3A
         9JgE4RmGNZMdPYyeQfDIQk1iAt9bOaC6D3jswM6rt+FQQpU1UCJ9QADFvTGZK5puWm/Z
         tr6Pv/1d26kyIIVsprNHpY5BB7gZz17dYe+RTKUUTDIxC++Zi+BNNPcIBaCpPJl9kfuB
         7QBrB4bxP2XZIzykoTVmN4nL6s3DmVW9WzXaFP7bcOjxX3Bnd8fWIOq8wLzMiVfw5lLF
         sCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713777161; x=1714381961;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUXy42KiwkMsfzFd8SftlWu2Tv7A1Nv/ePpZqOKpeVo=;
        b=QTg5/Qp3tszy98cO3x8xJgjdFDy0r0vm8/Ys3QQo9y5OLA/Jl5RJBuoGX5iICjiaKj
         6ruQM6QhzC3zWfmyL8oqTtacohz1ClvrJ/ZHupnoOLXMOieeDbAobLWyqoXdDfe9D7nY
         sf8bm6dKVmtxPbMHlmcMW2T9aGLEXPYwGOkemt/iQD0aV/NZLFU6OMA74oZs0OVlr8mH
         ADC/juh+vr396Dy9+01lWfCl9PieqObw786/1FeXlATX05Eeoe7B1skdL9p1XP+lYwD5
         Xrq2pQCkpBB82TxAGjkZuDfqaJXzsO8XyiCFIlpCyTXvdkqABXUWgRTzXRsyLw56jc0q
         LaRw==
X-Forwarded-Encrypted: i=1; AJvYcCVRbEFo5j1UmnQNY0a1E2US/Se+qEWx/vJRlbb4HKbJRUrk9Kjy3u17GJuFx3QT1YfvRhzozNg9yAz7hIpUa8NpU9y78ZGtZl2mM0+k
X-Gm-Message-State: AOJu0Yxfde+30cb/f5pZv7cu4ok6/RL0aOpLdcrjb/upYIMxMdYmzvXW
	G2RrWzWKw1XO9+1T3cPenaej32ggtnW6OsHUaWT2lpP10/K6+R1TOgpAWb26P3c=
X-Google-Smtp-Source: AGHT+IGVWr/WXuKg0Q8wHZL7jKFrJPfUhktVV54/z+G0ymvn4BrzyGuYjtvyoPwkjXcM2lNYBNXXRg==
X-Received: by 2002:a17:907:7e81:b0:a55:b485:fee1 with SMTP id qb1-20020a1709077e8100b00a55b485fee1mr1935856ejc.36.1713777161195;
        Mon, 22 Apr 2024 02:12:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id t8-20020a170906a10800b00a4e253c8735sm5525254ejy.52.2024.04.22.02.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 02:12:40 -0700 (PDT)
Message-ID: <015d5f6c-9209-40fc-9d2c-c642070df99e@linaro.org>
Date: Mon, 22 Apr 2024 11:12:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: stmicro: imx: set TX_CLK direction in RMII mode
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Linux Team <linux-imx@nxp.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240422-v6-9-topic-imx93-eqos-rmii-v1-0-30151fca43d2@pengutronix.de>
 <20240422-v6-9-topic-imx93-eqos-rmii-v1-3-30151fca43d2@pengutronix.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240422-v6-9-topic-imx93-eqos-rmii-v1-3-30151fca43d2@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 10:46, Steffen Trumtrar wrote:
> In case of RMII connection, the TX_CLK must be set to output direction.
> Parse the register and offset from the devicetree and set the direction
> of the TX_CLK when the property was provided.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 27 +++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> index 6b65420e11b5c..0fc81a626a664 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> @@ -37,6 +37,9 @@
>  #define MX93_GPR_ENET_QOS_INTF_SEL_RGMII	(0x1 << 1)
>  #define MX93_GPR_ENET_QOS_CLK_GEN_EN		(0x1 << 0)
>  
> +#define MX93_GPR_ENET_QOS_TX_CLK_SEL_MASK	GENMASK(1, 1)
> +#define MX93_GPR_ENET_QOS_TX_CLK_SEL		(0x1 << 1)
> +
>  #define DMA_BUS_MODE			0x00001000
>  #define DMA_BUS_MODE_SFT_RESET		(0x1 << 0)
>  #define RMII_RESET_SPEED		(0x3 << 14)
> @@ -57,7 +60,9 @@ struct imx_priv_data {
>  	struct clk *clk_tx;
>  	struct clk *clk_mem;
>  	struct regmap *intf_regmap;
> +	struct regmap *enet_clk_regmap;
>  	u32 intf_reg_off;
> +	u32 enet_clk_reg_off;
>  	bool rmii_refclk_ext;
>  	void __iomem *base_addr;
>  
> @@ -116,6 +121,18 @@ static int imx93_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
>  		break;
>  	case PHY_INTERFACE_MODE_RMII:
>  		val = MX93_GPR_ENET_QOS_INTF_SEL_RMII;
> +
> +		/* According to NXP AN14149, the direction of the
> +		 * TX_CLK must be set to output in RMII mode.
> +		 */
> +		if (dwmac->enet_clk_regmap)
> +			regmap_update_bits(dwmac->enet_clk_regmap,
> +					   dwmac->enet_clk_reg_off,
> +					   MX93_GPR_ENET_QOS_TX_CLK_SEL_MASK,
> +					   MX93_GPR_ENET_QOS_TX_CLK_SEL);
> +		else
> +			dev_warn(dwmac->dev, "TX_CLK can't be set to output mode.\n");
> +
>  		break;
>  	case PHY_INTERFACE_MODE_RGMII:
>  	case PHY_INTERFACE_MODE_RGMII_ID:
> @@ -310,6 +327,16 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
>  			dev_err(dev, "Can't get intf mode reg offset (%d)\n", err);
>  			return err;
>  		}
> +
> +		dwmac->enet_clk_regmap = syscon_regmap_lookup_by_phandle(np, "enet_clk_sel");
> +		if (IS_ERR(dwmac->enet_clk_regmap))
> +			return PTR_ERR(dwmac->enet_clk_regmap);

This looks like breaking ABI. Please test your changes without the DTS.
Does the DTS pass dtbs_check? Does the driver probe correctly with such DTS?

Best regards,
Krzysztof


