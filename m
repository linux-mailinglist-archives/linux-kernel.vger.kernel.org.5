Return-Path: <linux-kernel+bounces-85582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D9B86B7F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96271C20FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC12971ECE;
	Wed, 28 Feb 2024 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p92BeJhC"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EEA3FBA7;
	Wed, 28 Feb 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147855; cv=fail; b=AyiOgA4a1SZaitghGNfBuMTlpVEGCz+mjLVW2NKNa1gA8891uiHY/oAR0UmbnLTRskM4Z0z1WgtBmTH3DzW/n6uOBu9OdfVQ/J2EQEPDMGpF2Urbxnipb/re7LTgkWv/MmC0rt4A++TWCMliCfuUfBB5qKa1ZmFFlSwRNbudMtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147855; c=relaxed/simple;
	bh=lkP7qia0nfbe8wj/WqGQQprK2DA+sNk7UUKg6SOfTt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QWPvFdexGD6ItYRDCWave88/eCxtRLux+MMWugEY0sMMtEqa0VF+moPsMqP7toGTcCzjLgGJXoTt/JCslwtsC6R9kAmrSBXQkROJwr/soMUwWmuoDstLcIg6+oN/D5UnzT6GnVlbfizMBf8siJIc9GygpGVE5w9nzZoPfUULmF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=p92BeJhC; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVUTD6WwlbeH7uVB74AI88t5ER6idgETM28CzKbjKeMDV9ljNmwbciOIqSBy8pVdUqeK4Uekj3XBVJLJt8J5HNwz+UbjIjMeUt+hpSPTdXMhcCOEgpA55x6JEmUF/XBit6rIcGLCXD0KyhLWkSf19Znrd+t1RVPEdHq42iHbifueC6GzGsngc6yaUx+tBwQGAvImwg5ewjLRKkz3j7NfchKyqEHoXwxqm+CIC0Qb8Mp9w/j0cHB3eSAlUoJPZ4EKir1PZ4+hq9KJr3coiuo35P4MKpyA6ozcg2d9v1yzSBnO+nYtgrvNMF+RXoccFQIwwY6CQg4Zu8/Syrn8bnm3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b94aws+kxhFrj/P95ap7TccXYEM6hOfICE6w1SnnVTk=;
 b=hu7vCrSxhhvbmI148ttq2BEHR5FZoIyjz8omXDHTgGkNTNRNYmqmD32qcjWj5t413g3IYTwkDJKIc7EswEW+veBLEJfyvL1sLSxY0+bFrTmxUR5dgRviT2Ps26SxWunNUXEmmgmQnY6HPCh7II5CLT5fv4mD0MoBXmdEOrXESjIhYNMfbKX1jTqeZl6uiMzwS71rzC/XiUokPP0Z2szOfBfElq0okigPCkOrJwgKdz0AiGLRcL8u4LS/MDAD1VBdhj7N+HcjaPPLyVp2yNU3+84fL7LiisvsGY4ad7CBjqHy8mpXzdfrNSFkUagKLCBkkZS0fTSD92jsVagiigETuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b94aws+kxhFrj/P95ap7TccXYEM6hOfICE6w1SnnVTk=;
 b=p92BeJhCz5nX+mzbfuCN/6mnaUPxMz9/+Thneuq+G74ii+u1QGnXy5j+YQTwPJ4IBEHETabYs6+uaKk76iOlwZqeCtbFERsFYttA3aaxCNDP5814XO3IfhYAFseHcUpe81mxFiseARdk3VqTf5VL6Ascgltj04cvuGMC1nafwDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8887.eurprd04.prod.outlook.com (2603:10a6:10:2e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 19:17:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:17:30 +0000
Date: Wed, 28 Feb 2024 14:17:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] clk: imx: lpcg-scu: SW workaround for errata (e10858)
Message-ID: <Zd+GwrE5IvDgZX/c@lizhi-Precision-Tower-5810>
References: <20240228082649.1633083-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228082649.1633083-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: BY3PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: e0026e75-55f9-4fa8-a103-08dc3891e8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2+vAESItKLiZwe8I22a0G7Qxcy6/mu6h6KO4iGS162M1cI3BaSXUOY8JZo25ojzxyAydLQipNrfLTgvquOGLsLdZTSUg4IYpCz/zRKqy2X/ENRq0qypPqDWGdxZMv4vF24KggaNUrDSsoFSSh5rZCZd4rUe9eJrPoLOKxsKnVc4fEsXY0XKyeOM1Gtk5ldUE4M6EdJdaYDAetZbGgAB49P/Nap2Jzmux5qzymIW9YN4V1It8jhzsXiI5eKDlQcqyW/bMz+heN/obnkYCM1OayrBQ4UJsvZ9Yem1xxQJrMbjqsC4yTq+WRtrIZsYS3FdfW8iefQx/QyXNZdRVNvq+NLkRUYkcgHf+O5E9MfotQu6T6eEbAQiunYc/ySdk3SOheyj6jVIok2UXNAcJqMlmDv2EVdmhyc5zrHUmvVK048hrZ/3RpoOdguA9fFb8CbQwgaueMc2qn08MHrj6wuOJ39Jedc1btVhVofSDaRpm3XR3HhPOSGACB3zWgVvbUsRmb6jWkiV7NwfQjCPaUJs6LfhhOc9vYkTjH5gN0/KdmwqGgb5s4zDxeT5A3oZ1DKHZuPN+rAnBW3IkuXhnjW6cgNB5r7k259CTd0HhgKL6wvbcTDSuOfmGGikkjCG1P246i016PnXAT1aH+MCKDLIKOyXA4/TEE+pQzeViFUpnf7s+9oe+BoemHafd3zz1goUEn7/TRxT+P7dFnGJVf8SgOK46TuDN5TGshG8PClYPBIk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G2buH+sd++cGLTkeIt1K+/iG6A7NfAliMegaQ/E5nlk1PIX4+I9+W5F8IbLu?=
 =?us-ascii?Q?iMD1gxPY0EHfMCxw3K96DuEbexpQ0C1aT0l3cRPXDSI7VoIB7gF6j7sy4sSQ?=
 =?us-ascii?Q?kCnpZloTvdg8T/o4QPen2xoHpVYayVG3k99mQskWL5m17Bzfk4TTSZZQwFcm?=
 =?us-ascii?Q?iUjxpJzHUdqBNTcdAucmOhAVAkFvGSpw1qelEzUUOXvytvlhkvQ5H3P/cRfS?=
 =?us-ascii?Q?8JxU7CRrhzIx+jBgHw+gxqeORbJ4NKdNslMOBNXhk2ObjXybJPkGn+KSmU8o?=
 =?us-ascii?Q?1Y3TGAyC/3zEq320WFY0A7GoGopCEdEhF4GDqrby4zmxMdTQMH3DZgcwH11d?=
 =?us-ascii?Q?f+sQL9QkIVeNeghVkPDAtRbzGDb0Hct1GQd8LZkV6Yq7Fc5ZVRufjnGqtRVp?=
 =?us-ascii?Q?UviD0+ZtBq33qZLlSAYCto4fCaLJpZudqqjQQjjDsb64xDte4RBn7tBeZ6AI?=
 =?us-ascii?Q?H0IRgsUimAUY8yqWBSvV/SzqOui7nA46EQ4EXCGH2VwOL0KB+kQGuSaeDfOg?=
 =?us-ascii?Q?RtmP+McQlDO7ak1Ql+sDRkRBjw/3cBvWMPSOBQ2dnPvqKEbxHVjgcPIfs3DF?=
 =?us-ascii?Q?tyyWKWYhhF2yaQdElaXxQipejmGeVtUUtomjGCUa4GDnjflnzpR3b6C3qhvk?=
 =?us-ascii?Q?JcJEvp1ne4envXH1hFvuLs7SUdsunk4IG7vS0h+//69Y1rECYWqhKY+9E2eJ?=
 =?us-ascii?Q?1+T52t9oviM0HHks4rtK3XB9byaO4/aA3pJqzvHT+W2lunKHUw1ymkYt7YX/?=
 =?us-ascii?Q?POg2iYCZLjgo05er7kM4IBJiKKw4RiuvuNAVUSKaBhWChsqZGn1otBesfIQU?=
 =?us-ascii?Q?t8T2RHLmkGSrS01ueVGTO2ZrhlXzmIoUk86kSEOJUGT/Wi3g2WubLA1hu8ba?=
 =?us-ascii?Q?tZFg+gLwyAmDFNJk370A06KNIA13wNFMeDtQiwC/DMeq6jqsHx219vIaq6nU?=
 =?us-ascii?Q?34OsBTLOfB1rNNP/rrIuhpFrsOGrjCPOklb0pj0J1PZLf3I+s63wmmg2tL6N?=
 =?us-ascii?Q?jnGXZmssf/CQUp40Bvl3qRlbqaug35mvGplCNcYqTgUaIQxP2qygAQC9trXB?=
 =?us-ascii?Q?maTAu9mK4Lv8Wb8pGAFiEgr89QgZlPU6QzYvULswQGNe7+tGjO7NE9VNVHS0?=
 =?us-ascii?Q?O1kDhSBkcCGtvb88ORFS8hYCVHsyGlvcVSVdOpJOKg9vi1ZF3RPg26OvMYe3?=
 =?us-ascii?Q?9u5zPprrPWscVNAN0MFDuWhvthdpdtyjs8nTjP5RUDpTPQucWgRaZe2YmvNj?=
 =?us-ascii?Q?OPCN6/Ga1+o4k58XgHrFPa/s8+cYCcXyODkj7WomNwp4oGiaeW6tEKEH6HAK?=
 =?us-ascii?Q?1/CJNUJv6/uk1LZPrWDyc6U7X9bVNwr/7/S45d4TYzfNtY522g17FEbvs2vM?=
 =?us-ascii?Q?k9vzV7Ki8NLFExhIvfaWKpOQZQAk1AlOMt+5Mi+oWSVZxs6IE79FFsgAQuUg?=
 =?us-ascii?Q?oLboHIy06QZuiAdir48Ydy4JMaGtGtdfwOE8PB0dLMUgEQOXmEo+nUN2QCEk?=
 =?us-ascii?Q?K//gdqWXB1cqE7PEYt7aKzlZ5Y397FhTkfEneMjC9dC5wHSpcOv1vtvHQn0H?=
 =?us-ascii?Q?Ex0L2BzifE++BNhj1alnmDHF/bakQd/SZlSryEN0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0026e75-55f9-4fa8-a103-08dc3891e8c7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:17:30.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KqB09uDoqJnCB209HPKhW1LqKD5y6EGrqYoHxyMpSZ+3pm0mlV3V+J3INvAMiDsLS6PKqZslio/uiIuDu/dBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8887

On Wed, Feb 28, 2024 at 04:26:49PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Back-to-back LPCG writes can be ignored by the LPCG register due to
> a HW bug. The writes need to be separated by at least 4 cycles of
> the gated clock.
> 
> The workaround is implemented as follows:
> 1. For clocks running greater than or equal to 24MHz, a read
> followed by the write will provide sufficient delay.
> 2. For clocks running below 24MHz, add a delay of 4 clock cylces
> after the write to the LPCG register.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Fixes tag? 

Frank
 
> 
>  This is to upstream a downstream patch that goes through many releases
>  in several years. It maybe hard to trigger, but to address potential
>  issues, let's add this workaround.
> 
>  drivers/clk/imx/clk-lpcg-scu.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
> index dd5abd09f3e2..b30d0f8b5bca 100644
> --- a/drivers/clk/imx/clk-lpcg-scu.c
> +++ b/drivers/clk/imx/clk-lpcg-scu.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/bits.h>
>  #include <linux/clk-provider.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> @@ -41,6 +42,31 @@ struct clk_lpcg_scu {
>  
>  #define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
>  
> +/* e10858 -LPCG clock gating register synchronization errata */
> +static void do_lpcg_workaround(u32 rate, void __iomem *reg, u32 val)
> +{
> +	writel(val, reg);
> +
> +	if (rate >= 24000000 || rate == 0) {
> +		u32 reg1;
> +
> +		/*
> +		 * The time taken to access the LPCG registers from the AP core
> +		 * through the interconnect is longer than the minimum delay
> +		 * of 4 clock cycles required by the errata.
> +		 * Adding a readl will provide sufficient delay to prevent
> +		 * back-to-back writes.
> +		 */
> +		reg1 = readl(reg);
> +	} else {
> +		/*
> +		 * For clocks running below 24MHz, wait a minimum of
> +		 * 4 clock cycles.
> +		 */
> +		ndelay(4 * (DIV_ROUND_UP(1000000000, rate)));
> +	}
> +}
> +
>  static int clk_lpcg_scu_enable(struct clk_hw *hw)
>  {
>  	struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
> @@ -57,7 +83,8 @@ static int clk_lpcg_scu_enable(struct clk_hw *hw)
>  		val |= CLK_GATE_SCU_LPCG_HW_SEL;
>  
>  	reg |= val << clk->bit_idx;
> -	writel(reg, clk->reg);
> +
> +	do_lpcg_workaround(clk_hw_get_rate(hw), clk->reg, reg);
>  
>  	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
>  
> @@ -74,7 +101,7 @@ static void clk_lpcg_scu_disable(struct clk_hw *hw)
>  
>  	reg = readl_relaxed(clk->reg);
>  	reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
> -	writel(reg, clk->reg);
> +	do_lpcg_workaround(clk_hw_get_rate(hw), clk->reg, reg);
>  
>  	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
>  }
> @@ -151,7 +178,7 @@ static int __maybe_unused imx_clk_lpcg_scu_resume(struct device *dev)
>  	 */
>  
>  	writel(clk->state, clk->reg);
> -	writel(clk->state, clk->reg);
> +	do_lpcg_workaround(0, clk->reg, clk->state);
>  	dev_dbg(dev, "restore lpcg state 0x%x\n", clk->state);
>  
>  	return 0;
> -- 
> 2.37.1
> 

