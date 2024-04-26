Return-Path: <linux-kernel+bounces-160348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9798B3C43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0692C1F24AA2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C0B15E5D0;
	Fri, 26 Apr 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="KLc6eWKI"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3514A4D9;
	Fri, 26 Apr 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147258; cv=none; b=CUKe4GzsJ2iDqSxyeLaR0lQmlpTqUZULlDK1vwnsbI2xuEVjipncwtvdgscWQ7EQBq4JsiOHsEYFMACa/XLM/qvU2CfarflZukDAyXDC6t8O3vEMCQSHdMRl7yle11Y6rfQXEI0oDkdogR6akm04jBDiI3GkBl2JyPWSZeAPEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147258; c=relaxed/simple;
	bh=GHpAhp43gXbQiBLunOPFF1TgsOqR+/UXG5NrXX5hE8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwyhfNqg7IeuTyhNQhYycgvRSdu5mSHRHxhj7trE0OdFutLYbhFcotwyJVKVQgg0MVnWCJxYwe1+JwpOkCBkweoiYAQpR4j+3hkthlIy/7+ISeANmolEpe6h5H4rHA2M5jJeiawWU9M8xc8mFGBwdCJayayZsidXHZHPLTSBbk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=KLc6eWKI; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7D9FB8857C;
	Fri, 26 Apr 2024 18:00:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714147251;
	bh=Amw4/bajJowEQc3xMpXrC2fZXOfCeYn8U9XHLfZLBK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KLc6eWKIpa/Wh3b5Q63HZaxGBZwMGpx4phoHXtpPPNVSgZ+sMEVfxdH41flNm35TC
	 tO57KUR5RU12Ce3Kaz2k+xYbJT7Bj8qE+9qF2H7ljtYFh+Fd1PGUOOAzQY9HjmaiAU
	 OlK22tHP3YNOk93pjPUEeBDY66K1zE3ZMgSgojIO6KEqsqNJ/ea9PGcDQDfYStXUkp
	 SGJ9Yf9WetN+yRsDhTex6HVbCjWUngf4aI+7SVp08CrHttLxqvg3NupJ5hpUa6ST/c
	 6xMeZm8JGlUR1IVvxMShD0QjSGLC5wcJsUECgLhWvpgiU4didTAzctuzdRiteOB9Gd
	 NyTnMv0uMqW9A==
Message-ID: <b790f34e-8bfb-44f6-869d-798508008483@denx.de>
Date: Fri, 26 Apr 2024 17:37:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] net: stmmac: dwmac-stm32: update config
 management for phy wo cristal
To: Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-6-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240426125707.585269-6-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/26/24 2:57 PM, Christophe Roullier wrote:
> Some cleaning because some Ethernet PHY configs do not need to add
> st,ext-phyclk property.
> Change print info message "No phy clock provided" only when debug.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>   .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 27 ++++++++++---------
>   1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> index 7529a8d15492..e648c4e790a7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> @@ -55,17 +55,17 @@
>    *|         |        |      25MHz    |        50MHz       |                  |
>    * ---------------------------------------------------------------------------
>    *|  MII    |	 -   |     eth-ck    |	      n/a	  |	  n/a        |
> - *|         |        | st,ext-phyclk |                    |		     |
> + *|         |        |	             |                    |		     |
>    * ---------------------------------------------------------------------------
>    *|  GMII   |	 -   |     eth-ck    |	      n/a	  |	  n/a        |
> - *|         |        | st,ext-phyclk |                    |		     |
> + *|         |        |               |                    |		     |
>    * ---------------------------------------------------------------------------
>    *| RGMII   |	 -   |     eth-ck    |	      n/a	  |      eth-ck      |
> - *|         |        | st,ext-phyclk |                    | st,eth-clk-sel or|
> + *|         |        |               |                    | st,eth-clk-sel or|
>    *|         |        |               |                    | st,ext-phyclk    |
>    * ---------------------------------------------------------------------------
>    *| RMII    |	 -   |     eth-ck    |	    eth-ck        |	  n/a        |
> - *|         |        | st,ext-phyclk | st,eth-ref-clk-sel |		     |
> + *|         |        |               | st,eth-ref-clk-sel |		     |
>    *|         |        |               | or st,ext-phyclk   |		     |
>    * ---------------------------------------------------------------------------
>    *
> @@ -174,23 +174,22 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>   	dwmac->enable_eth_ck = false;
>   	switch (plat_dat->mac_interface) {
>   	case PHY_INTERFACE_MODE_MII:
> -		if (clk_rate == ETH_CK_F_25M && dwmac->ext_phyclk)
> +		if (clk_rate == ETH_CK_F_25M)

I see two problems here.

First, according to the table above, in MII mode, clk_rate cannot be 
anything else but 25 MHz, so the (clk_rate == ETH_CK_F_25M) condition is 
always true. Why not drop that condition ?

The "dwmac->ext_phyclk" means "Ethernet PHY have no crystal", which 
means the clock are provided by the STM32 RCC clock IP instead, which 
means if the dwmac->ext_phyclk is true, dwmac->enable_eth_ck should be 
set to true, because dwmac->enable_eth_ck controls the enablement of 
these STM32 clock IP generated clock.

Second, as far as I understand it, there is no way to operate this IP 
with external clock in MII mode, so this section should always be only:

dwmac->enable_eth_ck = true;

>   			dwmac->enable_eth_ck = true;
>   		val = dwmac->ops->pmcsetr.eth1_selmii;
>   		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
>   		break;
>   	case PHY_INTERFACE_MODE_GMII:
>   		val = SYSCFG_PMCR_ETH_SEL_GMII;
> -		if (clk_rate == ETH_CK_F_25M &&
> -		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
> +		if (clk_rate == ETH_CK_F_25M)
>   			dwmac->enable_eth_ck = true;
> -			val |= dwmac->ops->pmcsetr.eth1_clk_sel;
> -		}
>   		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_GMII\n");
>   		break;
>   	case PHY_INTERFACE_MODE_RMII:
>   		val = dwmac->ops->pmcsetr.eth1_sel_rmii | dwmac->ops->pmcsetr.eth2_sel_rmii;
> -		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_50M) &&
> +		if (clk_rate == ETH_CK_F_25M)
> +			dwmac->enable_eth_ck = true;
> +		if (clk_rate == ETH_CK_F_50M &&
>   		    (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk)) {

This doesn't seem to be equivalent change to the previous code . Here, 
if the clock frequency is 25 MHz, the clock are unconditionally enabled. 
Before, the code enabled the clock only if clock frequency was 25 MHz 
AND one of the "dwmac->eth_ref_clk_sel_reg" or "dwmac->ext_phyclk" was 
set (i.e. clock provided by SoC RCC clock IP).

I think it might make this code easier if you drop all of the frequency 
test conditionals, which aren't really all that useful, and only enable 
the clock if either dwmac->ext_phyclk / dwmac->eth_clk_sel_reg / 
dwmac->eth_ref_clk_sel_reg is set , because effectively what this entire 
convoluted code is implementing is "if (clock supplied by clock IP i.e. 
RCC) enable the clock()" *, right ?

* And it is also toggling the right clock mux bit in PMCSETR.

So, for MII this would be plain:
dwmac->enable_eth_ck = true;

For GMII/RGMII this would be:
if (dwmac->ext_phyclk || dwmac->eth_clk_sel_reg)
   dwmac->enable_eth_ck = true;

For RMII this would be:
if (dwmac->ext_phyclk || dwmac->eth_ref_clk_sel_reg)
   dwmac->enable_eth_ck = true;

Maybe the clock frequency validation can be retained, but done separately?

>   			dwmac->enable_eth_ck = true;
>   			val |= dwmac->ops->pmcsetr.eth1_ref_clk_sel;
> @@ -203,7 +202,9 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>   	case PHY_INTERFACE_MODE_RGMII_RXID:
>   	case PHY_INTERFACE_MODE_RGMII_TXID:
>   		val = dwmac->ops->pmcsetr.eth1_sel_rgmii | dwmac->ops->pmcsetr.eth2_sel_rgmii;
> -		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_125M) &&
> +		if (clk_rate == ETH_CK_F_25M)
> +			dwmac->enable_eth_ck = true;
> +		if (clk_rate == ETH_CK_F_125M &&
>   		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
>   			dwmac->enable_eth_ck = true;
>   			val |= dwmac->ops->pmcsetr.eth1_clk_sel;
> @@ -219,7 +220,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>   	}
>   
>   	/* Need to update PMCCLRR (clear register) */
> -	regmap_write(dwmac->regmap, reg + dwmac->ops->syscfg_clr_off,
> +	regmap_write(dwmac->regmap, dwmac->ops->syscfg_clr_off,
>   		     dwmac->mode_mask);
>   
>   	/* Update PMCSETR (set register) */
> @@ -328,7 +329,7 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
>   	/*  Get ETH_CLK clocks */
>   	dwmac->clk_eth_ck = devm_clk_get(dev, "eth-ck");
>   	if (IS_ERR(dwmac->clk_eth_ck)) {
> -		dev_info(dev, "No phy clock provided...\n");
> +		dev_dbg(dev, "No phy clock provided...\n");
>   		dwmac->clk_eth_ck = NULL;
>   	}
>   

