Return-Path: <linux-kernel+bounces-15352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6156822A8D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636B31F23FD5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD13D18640;
	Wed,  3 Jan 2024 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNLoKv7+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABFB18632
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d5f402571so69256045e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 01:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704275403; x=1704880203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmKejKBf2avgLbRYliTmm8WeIicCE14MUoUVoAfYgWw=;
        b=ZNLoKv7+EMoT5DtRHcfU+yQquPIA9y09xz7yaIroERNXk2RUCOBpu6hY8faJ8oGlJm
         rFiRnWb3g49W4BiUQuxf936AQSLDrutkqnkwEqGXOnjiT9HFJcxMOTs99aqH+mzGt7e+
         Wz4EtV3Zh99qL0vHCCBkcSMN6fDyNWuGL/4pzpcbB7nrQWE2/IrFOyZhFz8fAZGIxZp7
         mzJyODs2JE8LqRSl4MJnHko15VYtO19TrwV6cehEFZrizT/xm3pmicDKNsYKZHnGDfFT
         +u+dpYl8lxz/TsPVhnlbGJ6aYNoHt7fhqn6Ata2wxaby8XC8hiU6tPuKBF5F+vHBE1HI
         Skwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275403; x=1704880203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmKejKBf2avgLbRYliTmm8WeIicCE14MUoUVoAfYgWw=;
        b=Pbr0mDp2E2FEqDor9nRW590UZK0vloQjD74cciTBtR3W/sEyAR6KSBME5geZstdhyR
         h6OX8435Ev/tliGvkPG9FIOgLHj/cYMHdm8D01XcRV8oIb4YmUxkb09U9PBpJey+M/wz
         eClETRq6EN0PemNnkwocqQdTiMZOLskZK4yC5cVRJ2nAKx9QbXZpfIsbyVUc8FgcB3IA
         XaZ0fhq8OD/8dkVdSvAJ2tpmvZLvOxocnP3+50ZGmrtWK18zuK0FKFTCPc1WhwLgiDZL
         dGZTpSZaTYXoKxZPK+qISTJrS6AVlHkm7GyMybjCs9EnWvxXhTEGIMgKB+QbN5MeEoaq
         wUlw==
X-Gm-Message-State: AOJu0YzkJpdW6A3VQySMODtPhUpsug0PU4TBltRY8TQkOu7sQjn42b55
	07wFzccQAqWpjZfk1vfJsv2SwMn4psJ9Sw==
X-Google-Smtp-Source: AGHT+IFaqwY1UVrdPQleZW7aCPSSqLl/+7BGbnsllxdUXEuCWX011Cu7HlnTvacGgRCavuek48oo5Q==
X-Received: by 2002:a05:600c:3c86:b0:40d:6611:aefe with SMTP id bg6-20020a05600c3c8600b0040d6611aefemr4147210wmb.168.1704275402921;
        Wed, 03 Jan 2024 01:50:02 -0800 (PST)
Received: from [192.168.100.86] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c500700b0040d8eca092esm1775176wmr.47.2024.01.03.01.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 01:50:02 -0800 (PST)
Message-ID: <1d7ef6cc-5c25-4a59-ad7f-38870ac132c4@linaro.org>
Date: Wed, 3 Jan 2024 09:50:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] net: mdio: ipq4019: configure CMN PLL clock for
 ipq5332
Content-Language: en-US
To: Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, robert.marko@sartura.hr
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-4-quic_luoj@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231225084424.30986-4-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/12/2023 08:44, Luo Jie wrote:
> The reference clock of CMN PLL block is selectable, the internal
> 48MHZ is used by default.
> 
> The output clock of CMN PLL block is for providing the clock
> source of ethernet device(such as qca8084), there are 1 * 25MHZ
> and 3 * 50MHZ output clocks available for the ethernet devices.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>   drivers/net/mdio/mdio-ipq4019.c | 129 +++++++++++++++++++++++++++++++-
>   1 file changed, 128 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
> index e24b0e688b10..e4862ac02026 100644
> --- a/drivers/net/mdio/mdio-ipq4019.c
> +++ b/drivers/net/mdio/mdio-ipq4019.c
> @@ -44,6 +44,17 @@
>   /* Maximum SOC PCS(uniphy) number on IPQ platform */
>   #define ETH_LDO_RDY_CNT				3
>   
> +#define CMN_PLL_REFERENCE_SOURCE_SEL		0x28
> +#define CMN_PLL_REFCLK_SOURCE_DIV		GENMASK(9, 8)
> +
> +#define CMN_PLL_REFERENCE_CLOCK			0x784
> +#define CMN_PLL_REFCLK_EXTERNAL			BIT(9)
> +#define CMN_PLL_REFCLK_DIV			GENMASK(8, 4)
> +#define CMN_PLL_REFCLK_INDEX			GENMASK(3, 0)
> +
> +#define CMN_PLL_POWER_ON_AND_RESET		0x780
> +#define CMN_ANA_EN_SW_RSTN			BIT(6)
> +
>   enum mdio_clk_id {
>   	MDIO_CLK_MDIO_AHB,
>   	MDIO_CLK_UNIPHY0_AHB,
> @@ -55,6 +66,7 @@ enum mdio_clk_id {
>   
>   struct ipq4019_mdio_data {
>   	void __iomem *membase;
> +	void __iomem *cmn_membase;
>   	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
>   	struct clk *clk[MDIO_CLK_CNT];
>   };
> @@ -227,12 +239,116 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
>   	return 0;
>   }
>   
> +/* For the CMN PLL block, the reference clock can be configured according to
> + * the device tree property "qcom,cmn-ref-clock-frequency", the internal 48MHZ
> + * is used by default.
> + *
> + * The output clock of CMN PLL block is provided to the ethernet devices,
> + * threre are 4 CMN PLL output clocks (1*25MHZ + 3*50MHZ) enabled by default.
> + *
> + * Such as the output 50M clock for the qca8084 ethernet PHY.
> + */
> +static int ipq_cmn_clock_config(struct mii_bus *bus)
> +{
> +	struct ipq4019_mdio_data *priv;
> +	u32 reg_val, src_sel, ref_clk;
> +	int ret;
> +
> +	priv = bus->priv;
> +	if (priv->cmn_membase) {

if (!priv->cnm_membase)
	return 0;

then move the indentation here one tab left.

---
bod

