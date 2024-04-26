Return-Path: <linux-kernel+bounces-160350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE258B3C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C96B279B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A5016DEC7;
	Fri, 26 Apr 2024 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="F7Byt8J4"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71065157463;
	Fri, 26 Apr 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147262; cv=none; b=hCoFxeO5mRBE7HieDriLrI5l23l4vZHpRwF8sEL8/R6UtE/+uE+7tLAimrFAkEr/i7v3mvrcT+yHRn5UlQ0uKndKrUouIXCIBh0HV1oYAuzEh5Z6SJayZoi0FASY1x4HKIjoReUj43jZS62xRep9KxPXZ2+scftINFVWnzfIEIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147262; c=relaxed/simple;
	bh=uulYlAkCUz11COWeZOP+CzKbGlqVCgeSXf4Xrw39bQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCtjNqSPBG7nxl2u8kQJms9rha1WwbmZ6tacZ2Zx176ORTmvLyzjR4mbbaJQdgHFSbUZ88uBBEFnDG30789fqBHgwFM6JdjX98P4Gx7eQe2MOwUv9S5UfqzZyJYha6AUG7Pp7eMrRgifcpkzfsoVPuBs11VB5444GMxq0u3lA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=F7Byt8J4; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 37FCC884F3;
	Fri, 26 Apr 2024 18:00:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714147250;
	bh=dLpoxPvvgiNhLq6wWoquSG/kLA+2IkGrgHtcMPVbqTg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F7Byt8J41Nr3+ZuOu+e1nlotRJfZKjoMWnH9uY/GvbLcAwtiQHyUxRzAPgoIq23rl
	 9NSY1IuO/1boW/8uMSl3ZaxFLmhB/lixjFmp6YUJxuGI06fKzQE2+v4pAKt9BmcGhL
	 k5gO/9+czmd5py0AjXJBdYvhQTBtHInv7dxMsmbxGVcnoW0t8GV/O5hFEp+5r8i2Qq
	 wOkhW80/CgojCeuewAaqVl0i0qmmxP2Nr9v2xh1iawpBamunc4ZThBN6UuH/zTFVFJ
	 b/Fpo/URooZLlUBh9J6yN32sdCVrx3EOO1XBBLoH18vMe5lWLA0/Z+4W+zSQrgCTTU
	 CyyQ/RJ3oToQQ==
Message-ID: <56f2d023-82d5-4910-8c4e-68e9d62bd1fe@denx.de>
Date: Fri, 26 Apr 2024 16:53:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] net: stmmac: dwmac-stm32: rework glue to
 simplify management
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
 <20240426125707.585269-4-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240426125707.585269-4-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/26/24 2:56 PM, Christophe Roullier wrote:
> Change glue to be more generic and manage easily next stm32 products.
> The goal of this commit is to have one stm32mp1_set_mode function which
> can manage different STM32 SOC. SOC can have different SYSCFG register
> bitfields. so in pmcsetr we defined the bitfields corresponding to the SOC.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>   .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 76 +++++++++++++------
>   1 file changed, 51 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> index c92dfc4ecf57..68a02de25ac7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> @@ -23,10 +23,6 @@
>   
>   #define SYSCFG_MCU_ETH_MASK		BIT(23)
>   #define SYSCFG_MP1_ETH_MASK		GENMASK(23, 16)
> -#define SYSCFG_PMCCLRR_OFFSET		0x40
> -
> -#define SYSCFG_PMCR_ETH_CLK_SEL		BIT(16)
> -#define SYSCFG_PMCR_ETH_REF_CLK_SEL	BIT(17)
>   
>   /* CLOCK feed to PHY*/
>   #define ETH_CK_F_25M	25000000
> @@ -46,9 +42,6 @@
>    * RMII  |   1	 |   0	  |   0	   |  n/a  |
>    *------------------------------------------
>    */
> -#define SYSCFG_PMCR_ETH_SEL_MII		BIT(20)
> -#define SYSCFG_PMCR_ETH_SEL_RGMII	BIT(21)
> -#define SYSCFG_PMCR_ETH_SEL_RMII	BIT(23)
>   #define SYSCFG_PMCR_ETH_SEL_GMII	0
>   #define SYSCFG_MCU_ETH_SEL_MII		0
>   #define SYSCFG_MCU_ETH_SEL_RMII		1
> @@ -90,19 +83,33 @@ struct stm32_dwmac {
>   	int eth_ref_clk_sel_reg;
>   	int irq_pwr_wakeup;
>   	u32 mode_reg;		 /* MAC glue-logic mode register */
> +	u32 mode_mask;
>   	struct regmap *regmap;
>   	u32 speed;
>   	const struct stm32_ops *ops;
>   	struct device *dev;
>   };
>   
> +struct stm32_syscfg_pmcsetr {
> +	u32 eth1_clk_sel;
> +	u32 eth1_ref_clk_sel;
> +	u32 eth1_selmii;
> +	u32 eth1_sel_rgmii;
> +	u32 eth1_sel_rmii;
> +	u32 eth2_clk_sel;
> +	u32 eth2_ref_clk_sel;
> +	u32 eth2_sel_rgmii;
> +	u32 eth2_sel_rmii;
> +};

[...]

> @@ -487,8 +502,19 @@ static struct stm32_ops stm32mp1_dwmac_data = {
>   	.suspend = stm32mp1_suspend,
>   	.resume = stm32mp1_resume,
>   	.parse_data = stm32mp1_parse_data,
> -	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
> -	.clk_rx_enable_in_suspend = true
> +	.clk_rx_enable_in_suspend = true,
> +	.syscfg_clr_off = 0x44,
> +	.pmcsetr = {
> +		.eth1_clk_sel		= BIT(16),
> +		.eth1_ref_clk_sel	= BIT(17),
> +		.eth1_selmii		= BIT(20),
> +		.eth1_sel_rgmii		= BIT(21),
> +		.eth1_sel_rmii		= BIT(23),
> +		.eth2_clk_sel		= 0,
> +		.eth2_ref_clk_sel	= 0,
> +		.eth2_sel_rgmii		= 0,
> +		.eth2_sel_rmii		= 0
> +	}
>   };

Is this structure really necessary ?

It seems the MP15 single ethernet config bitfield is at offset 16.
MP13 has two bitfields, one at offset 16, the other at offset 24 .

All you need to do is figure out which of the two MACs you are 
configuring, and then shift the bitfield mask by 16 or 24, since the 
bits are at the same offset for both bitfields.

See the matching upstream U-Boot commit for how this shift can be done:
a440d19c6c91 ("net: dwc_eth_qos: Add DT parsing for STM32MP13xx platform")


