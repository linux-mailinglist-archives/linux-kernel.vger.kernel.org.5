Return-Path: <linux-kernel+bounces-12548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F255481F688
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C75B1F232B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E0D6FA2;
	Thu, 28 Dec 2023 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByFrWrM7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A175863D2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-555104e21faso2513893a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703756996; x=1704361796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zt3Goil3g9CZsxO7JmIZIMG3puod+coP4eILkunbLhA=;
        b=ByFrWrM7pz0mvzW2PuK+Q59qRnv3fHKEMpZY97NneVxIuisR3Ph8Gva55nZJaCsFRS
         8gFFTy3vr5wU9H8uctuZNsX9qUphURT/Yteuz5oXiw4DK+qpbKKIB9FZsh09OQNE49Oe
         KiKRZuE9a7gyIPjFpCoW98BJFlhleG4E1OWdvrGoM9atDWa6THyinWwtA1N1IAbTHC1y
         LvIuA0TpzlThses52EZECaDpruAHMQNc5IKLM2zmuu1ADhvQWLjhleEFPkIvJVTH022Y
         IQdOEdG0i44fU860pwmPHthgtoMj80EyiHnIuQSHhnZceIzd/+/u57wKbOnG8wWEpsa9
         XkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703756996; x=1704361796;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt3Goil3g9CZsxO7JmIZIMG3puod+coP4eILkunbLhA=;
        b=tUjgOKrX/XgpBT4fVwnI+pxwo1k8gpj1wqRKnQc/4AWhssnTgOcnUpN/r/7f5vLD5h
         1c4G615vEyFv8OXrMcsJIGRrsvZIFbgAKPWV93q8oTJRwuznkrbmtVyNcds5vWWPXEqF
         OPrcr2wBqwPLvvWe+wZmUSYYI6d1ylddJa2Fw1RD04cXkZMj9waYgJcDQFDY8gaGdu3m
         Gts4Xg1aRty/eGMyfWKyS0bsjJQUhKQgSJO8jj4tnEFIzgh8+IJx7sT346vYuouak7k3
         7QoEeOkoabRihYZHFql923awEmSQEASBNOroPWK782XbNOUSWAtRSsZSI9zw0Q/FvSyy
         h20w==
X-Gm-Message-State: AOJu0YwZwH+TkSvSlglUMlWN2S4YyovuL2asmklzJbCwqvvCWRCisvwi
	FwooWeTtGFhifwF90DWUrz/lQUXcZP7W6Q==
X-Google-Smtp-Source: AGHT+IGybebBclQgoLB62bMHk+vv3ureLCHen0DyKZy3oITNiLPY/9fLDeaFU8L6A9gMT50dUMe/YQ==
X-Received: by 2002:a50:9e0e:0:b0:554:489a:3004 with SMTP id z14-20020a509e0e000000b00554489a3004mr3735592ede.56.1703756995836;
        Thu, 28 Dec 2023 01:49:55 -0800 (PST)
Received: from [192.168.199.125] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id t15-20020a056402020f00b005534057c72dsm9502420edv.18.2023.12.28.01.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 01:49:55 -0800 (PST)
Message-ID: <aa495827-4d20-4b66-8496-eef378d8f7c1@linaro.org>
Date: Thu, 28 Dec 2023 10:49:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] net: mdio: ipq4019: move eth_ldo_rdy before MDIO
 bus register
To: Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org, andersson@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, robert.marko@sartura.hr
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-2-quic_luoj@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231225084424.30986-2-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.12.2023 09:44, Luo Jie wrote:
> The ethernet LDO provides the clock for the ethernet PHY that
> is connected with PCS, each LDO enables the clock output to
> each PCS, after the clock output enablement, the PHY GPIO reset
> can take effect.
> 
> For the PHY taking the MDIO bus level GPIO reset, the ethernet
> LDO should be enabled before the MDIO bus register.
> 
> For example, the qca8084 PHY takes the MDIO bus level GPIO
> reset for quad PHYs, there is another reason for qca8084 PHY
> using MDIO bus level GPIO reset instead of PHY level GPIO
> reset as below.
> 
> The work sequence of qca8084:
> 1. enable ethernet LDO.
> 2. GPIO reset on quad PHYs.
> 3. register clock provider based on MDIO device of qca8084.
> 4. PHY probe function called for initializing common clocks.
> 5. PHY capabilities acquirement.
> 
> If qca8084 takes PHY level GPIO reset in the step 4, the clock
> provider of qca8084 can't be registered correctly, since the
> clock parent(reading the current qca8084 hardware registers in
> step 3) of the registered clocks is deserted after GPIO reset.
> 
> There are two PCS(UNIPHY) supported in SOC side on ipq5332,
> and three PCS(UNIPHY) supported on ipq9574.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/net/mdio/mdio-ipq4019.c | 51 +++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
> index abd8b508ec16..5273864fabb3 100644
> --- a/drivers/net/mdio/mdio-ipq4019.c
> +++ b/drivers/net/mdio/mdio-ipq4019.c
> @@ -37,9 +37,12 @@
>  
>  #define IPQ_PHY_SET_DELAY_US	100000
>  
> +/* Maximum SOC PCS(uniphy) number on IPQ platform */
> +#define ETH_LDO_RDY_CNT				3
> +
>  struct ipq4019_mdio_data {
> -	void __iomem	*membase;
> -	void __iomem *eth_ldo_rdy;
> +	void __iomem *membase;
> +	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
>  	struct clk *mdio_clk;
>  };
>  
> @@ -206,19 +209,8 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
>  static int ipq_mdio_reset(struct mii_bus *bus)
>  {
>  	struct ipq4019_mdio_data *priv = bus->priv;
> -	u32 val;
>  	int ret;
>  
> -	/* To indicate CMN_PLL that ethernet_ldo has been ready if platform resource 1
> -	 * is specified in the device tree.
> -	 */
> -	if (priv->eth_ldo_rdy) {
> -		val = readl(priv->eth_ldo_rdy);
> -		val |= BIT(0);
> -		writel(val, priv->eth_ldo_rdy);
> -		fsleep(IPQ_PHY_SET_DELAY_US);
> -	}
> -
>  	/* Configure MDIO clock source frequency if clock is specified in the device tree */
>  	ret = clk_set_rate(priv->mdio_clk, IPQ_MDIO_CLK_RATE);
>  	if (ret)
> @@ -236,7 +228,7 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
>  	struct ipq4019_mdio_data *priv;
>  	struct mii_bus *bus;
>  	struct resource *res;
> -	int ret;
> +	int ret, index;
>  
>  	bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(*priv));
>  	if (!bus)
> @@ -252,11 +244,32 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->mdio_clk))
>  		return PTR_ERR(priv->mdio_clk);
>  
> -	/* The platform resource is provided on the chipset IPQ5018 */
> -	/* This resource is optional */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (res)
> -		priv->eth_ldo_rdy = devm_ioremap_resource(&pdev->dev, res);
> +	/* These platform resources are provided on the chipset IPQ5018 or
> +	 * IPQ5332.
> +	 */
> +	/* This resource are optional */
> +	for (index = 0; index < ETH_LDO_RDY_CNT; index++) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
> +		if (res) {
if (!res)
	break

> +			priv->eth_ldo_rdy[index] = devm_ioremap(&pdev->dev,
> +								res->start,
> +								resource_size(res));
> +
> +			/* The ethernet LDO enable is necessary to reset PHY
> +			 * by GPIO, some PHY(such as qca8084) GPIO reset uses
> +			 * the MDIO level reset, so this function should be
> +			 * called before the MDIO bus register.
> +			 */
> +			if (priv->eth_ldo_rdy[index]) {
> +				u32 val;
> +
> +				val = readl(priv->eth_ldo_rdy[index]);
> +				val |= BIT(0);
> +				writel(val, priv->eth_ldo_rdy[index]);
> +				fsleep(IPQ_PHY_SET_DELAY_US);
fsleep should only be used when the argument is variable

Konrad

