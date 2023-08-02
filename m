Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F2076C22B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjHBBZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjHBBZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:25:33 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67005269A;
        Tue,  1 Aug 2023 18:25:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQc3DYT+dwOVbz6TImXhTL4EHSVgVvHS+a/Fo3OtGg6dIfG1xxvVwH3lH5711XX+1kxU13j0fqPmxAtTKRCWTUAxoCEa5HV9jLApqYEL254ICd7H2fzQH+F0pohAdAGOyb4/rYKYqk2cHD3uZz2lmJE3CGOemyFt8F5MSUNKjFNkhpl56TQmSOzTy1z5MkfhetKP8PUXqkb7sRHQNHG6fEbZkgPGNkSOCP8NaOoB/y9VPs6ClRQLr4y/52QbIDr3WmiztNJRKRJKLooO78jthlQemnSMJlIywSKrmERDDR+IGScfnKzztbiBlzb1pfPMwRKzgDrPyZrDEiDCrt2ylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxIDSCI9msoKyZ5L/931XlKP0XLcnvQ7Coporw/iTEY=;
 b=lIzmjw1F9iYRcCJ8f+n3nxRbGMtTqArSBINdcR+G4+fF37raSuG335641PIxxVS5OEX52B5MYEk5dwWtvIjkPnWYvYk3h+bv9vGTO4Wy5UG42B8YrDfJ9JnM6LXvsMHZscsWOIrDdjaOf7lQL+n0Ob+ttBQBFuWwJcSxoE9M1rssD+DZTojcVPNa1YxEK7SxpMpdupL7yu1q+b0SxoXOHWXiS1VGBVdI3ob3rKGbsPQV+zI0qCZTUElofDU9ql+StoFOaFvVum/9a59Nqb4aDy2b4pT+5v5rry2ay8klodCnagp8wYseIdSHdmaApgQbJrmUTvRijwOYLY42ppmtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxIDSCI9msoKyZ5L/931XlKP0XLcnvQ7Coporw/iTEY=;
 b=DN0cZHQ0eXa/u70MKCuVchXJcMtU7miBocnnFCxwm8wUruW7RMUo6C/+3vn6KwrCdmYxrU9YVmheSXaGq2YKp+qqOXepaTSvj2DA+d+G1lmG86+Jbi8OizVzSqYFIb3V3gvilsJTCio64ouoKU61tT1yaCOx6rlDYkE0MD35cMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 01:25:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 01:25:27 +0000
Message-ID: <092bddfa-ff9d-ab57-63ed-e6c0f2e9b550@oss.nxp.com>
Date:   Wed, 2 Aug 2023 09:25:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] clk: imx: composite-8m: avoid glitches when set_rate
 would be a no-op
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230801162731.3278396-1-a.fatoum@pengutronix.de>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230801162731.3278396-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: df7b065d-aae6-49d9-c6e6-08db92f75a11
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byXJtxDqwyu348mtWu6aJfgPDTXmtaAUrgeC1K0HF1gZMbg+ztrvKwee4v/FHmbUAHH2mTU955OrZNZeHUPj/yQS+MCrGBh5mU0M5DREVZ8bo6T+5qDVe8g6v+sZ6ll8vRnYmuEs/YdVaY+IU0WXFWOKTNgkEBqzTPm818dAPJ5biVQROGtJZKyTogbuLyj1WzSXzYf45oih4BT6mgM7/2B+nMMG4f5VpeK51bE84gfN5Efco94il8VTQeVPto7NVtZbgHiKiiZmdwD9o7CYK4Nf88ZHHTyJ8wJ+kBvnaADFjZB4bTrqj6AlzVq8+gv9/hiJM4nsE3k2Akv264nB+e7E9DDl/t2LQnE7XuhPhYOsouwHRtaMiq182B+6GsMnrvt7IaM4Tr8CrARLzGnifOgsITlPmVzL2m5S2hl6joXKt6vK4ZtVEur8jJHwPB8B3sZjfBa6h4EvVzEuG72HzsLX77iTsIP1aQnJQTh6Z5VCKTFjT+Dq4pa97SN4PDDDa+m4LjSQ6iQYCcRrGTRBZlO/dRJVagvSP6Jg+pVfefNog+FaWa15zpdPI19E1Eo6R/IcSyc4sNMCYADduMll1tAgf21LZToYGsewYJ7WkqgXQ7fXGKYArlApddiDMxY15u+r/uV6Rejd3d/4kohEYVm+fgQYKr9FVn1q//M0Idw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(2616005)(186003)(6512007)(316002)(86362001)(478600001)(110136005)(38100700002)(66946007)(66556008)(66476007)(6666004)(6486002)(4326008)(31696002)(6506007)(53546011)(921005)(41300700001)(26005)(8676002)(5660300002)(8936002)(2906002)(7416002)(44832011)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjBrck93aUNOVGlWc3E4M3I1K3VUT3BxZGxzeGJKVmR2SFJteXRnSjJlcHBp?=
 =?utf-8?B?M3M0aHBZQlhleHJ6MjVjcFp1d1RSRlJWSjQ1NXgwMmwzMnpobktIUGZoU2N3?=
 =?utf-8?B?c2srbUFMdGg4RVhsS0QrMzJmcVBzN3B5eEhqc0xMc0s5WUd2WU1VRkE2TGgw?=
 =?utf-8?B?OWlrbXY5L2hFSDZJaGgxV1FYM0VyMmowaGo4U0RsMktQOXV1Y3QrUDVSZW1W?=
 =?utf-8?B?b3FyNXVIZmpYQVkxSTlKbHQrRTFaMFlxbk4ydWxyc1c4NWJwL21TeDBvUGE2?=
 =?utf-8?B?elBLR2VuaVprdTRoZjBsN1F2aTNaNGZNN0p6L2NFbjJXVWFPbVlxd0I0UWhU?=
 =?utf-8?B?UmpTMnBwWWI4R01kVFk5M05KaURBUlB3ZCtxYU4wQ3pSSmo5YjBiU015U29X?=
 =?utf-8?B?M0haMS8xUFFkUUlkTklyK2hEanFacS9wV2ZrWVlRN29ON29uSGVRdDgxblRy?=
 =?utf-8?B?bmh3dng5Ykw5YjBlVmdNaDkxa1Bwc3pzVnFOcGpDK21md21IVEJxc09FS3ho?=
 =?utf-8?B?VlAyMS9nZkZwNzRjOGJKb214ekwzTUFyR1RzbDUvUDEyRVpzMUorVVlQUm91?=
 =?utf-8?B?OFFmZWpCZ1loM0p0MS9IOVZOSjFrL0dXRWNwdUh2Z1d0MG51Y2RCcGNFUlQw?=
 =?utf-8?B?ZVNzek45dDlvdk8rMDRLQzFCVVlhNlJXdHdpNjcweFVWdVphMTgrQi9QUlAy?=
 =?utf-8?B?MnJqV1B4QmRNNUNLSXlHb2VxcFVyMEhRZEY0QWp4Z2pqM2lOSEpkU0R0RGk4?=
 =?utf-8?B?STFEZ0p6ajUyY3Z5RzcveHJ2TWFxVm15WExCbkZURkpuSG9jMXAxNkwyTFA0?=
 =?utf-8?B?aFVOci9sYk1IcHk3Y2NmVzJuQWpXekRvcTJUMjQzMVByUnkzK0IvQ2VIekk5?=
 =?utf-8?B?Uk9zYUJGYTdIb1FYRmkwUGsvM0tEY0VDdVd3bWZWbno0b1E0TGNwYk1Nbkt5?=
 =?utf-8?B?QU9pN0RFM1dOMVhJWEt1RHpFVW1LM3BjY0I2R1o3MXlta1Y0L1F5T3MwNkl5?=
 =?utf-8?B?NTJaN3JvU3BaYVBuZjFZL1p4VFNwWHdGcEt1d3FKL3dLN0RxODYyRU9nZ1o1?=
 =?utf-8?B?R05Nc3Boc1NQa0U4Vmc0VDdtcEJhRXJpakx6Q2svbDJsZFhwelg0bDVGQUFo?=
 =?utf-8?B?SktvcnJyNUIxZTMvSkJYclAvRDM1MlppeHdkL1Jzc1dlcjRRZlhkRFRBajRm?=
 =?utf-8?B?ck8rSjF6UlB5WURSZ0FsZXczZVVCU242V3lrV0NHNTdqN1lVYTgvNVdpRlFE?=
 =?utf-8?B?UG1EUUVKK0JQek5xUStCTDJyYlNVQ2JqR0grbmxadjZYUjYzRS9pZmQ2dlVp?=
 =?utf-8?B?L2xacUhHZnVPVlgrT1o2c0JKbUd3NEJmNTY0WFQvWEF4WElFUStDL09TbGk0?=
 =?utf-8?B?cEhLTGdDUTkwdTlMVitGY0YyWHlpbGhEOWEzazQvMDU5ekQ4OWJBa0NKV3Zh?=
 =?utf-8?B?OVE4aE9hVFdYVnNFV2tldjNFMDhhd2lOUzdxVlR3Y3RFblBJNEIxdFByWU1T?=
 =?utf-8?B?RlFNcFlYNFhXbTZrdGxYaHcyRHhqZkliK0s0TjF3REZ6TnkrbTlTM0hySk9G?=
 =?utf-8?B?UG9sWHJRcHdCN3VwZ29NbTBmR3FWT1dORytDQk43bXM5TVRvQ3dRNEw1VU9L?=
 =?utf-8?B?U1B1b2NEWGZHL1NJOHlHZHNUay9MRHdMQUVhdFNyQ00yTkVUcmdVcEc1MjBW?=
 =?utf-8?B?SFB6L3h6djhDYUQ3dlFrVEhCcStmUERpamhjamFUZkJVQ29vdHJadXRIZkwr?=
 =?utf-8?B?ZlkwQVJSeGgzQW03MytHbmwyZGNHWjc5d2trVm1SVWRrNFZPMUdFd2xpTDhl?=
 =?utf-8?B?Q0pyM2xhdjYwNFFRYVlyWWRSQ3hzalAyZy9rL0RlbmhFeWltWTlkM1BFeUhT?=
 =?utf-8?B?U2pZVG1WRFFycDkzWDFySGU2QktaRWgybEVJb0ZrbEY2eFM2dWpxU2s2dTlw?=
 =?utf-8?B?TDkreXNkYnNTblNzSTdTS2NyVDJ6ODF5dmlHS3VLTExMRGNGcGk4ZGFtdm9S?=
 =?utf-8?B?Wkt5WkFWS25PejVEZDFPWTBOWVF2UktLc2V3ZzRNRG14clgyTW54Z3JiK1lG?=
 =?utf-8?B?ZXN2Z0FJUzhmdERtZ04zeG9WRUVBbjRpcGpHbVZNU2pxaEU1aldvQjQ1N0tx?=
 =?utf-8?Q?KcsMbnb805bTw0L0fs5Lf3Juh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7b065d-aae6-49d9-c6e6-08db92f75a11
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 01:25:27.2453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrtPx/YOyK9hnxAse5GJOko0k6pSy9AsOoS0EkZYBKwEpduwrzTf5sS8DMa1InoKiLTUxBzc41zW7F+prXgYUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 12:27 AM, Ahmad Fatoum wrote:
> Reconfiguring the clock divider to the exact same value is observed
> on an i.MX8MN to often cause a short clock pause, probably because
> the divider restarts counting from the time the register is written.
> 
> This issue doesn't show up normally, because the clock framework will
> take care to not call set_rate when the clock rate is the same.
> However, when we configure an upstream clock (e.g. an audio_pll), the
> common code will call set_rate with the newly calculated rate on all
> children. As the new rate is different, we enter set_rate and compute
> the same divider values, write them back and cause the glitch (e.g.
> on a SAI's MCLK).


The CCM root has glitch-free mux. When upstream pll freq change,
the child set rate will also touch the mux bit, since div and mux
in one register, so the mux logic will also function.

Per design, it is glitch free, so I not understand well why glitch.

When you configure pll, the downstream sai clk should still not be 
enabled, right?

Thanks,
Peng.

> 
> To avoid the glitch, we skip writing the same value back again.
> 
> Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>   drivers/clk/imx/clk-composite-8m.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
> index cbf0d7955a00..3e9a092e136c 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -97,7 +97,7 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
>   	int prediv_value;
>   	int div_value;
>   	int ret;
> -	u32 val;
> +	u32 orig, val;
>   
>   	ret = imx8m_clk_composite_compute_dividers(rate, parent_rate,
>   						&prediv_value, &div_value);
> @@ -106,13 +106,15 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
>   
>   	spin_lock_irqsave(divider->lock, flags);
>   
> -	val = readl(divider->reg);
> -	val &= ~((clk_div_mask(divider->width) << divider->shift) |
> -			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
> +	orig = readl(divider->reg);
> +	val = orig & ~((clk_div_mask(divider->width) << divider->shift) |
> +		       (clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
>   
>   	val |= (u32)(prediv_value  - 1) << divider->shift;
>   	val |= (u32)(div_value - 1) << PCG_DIV_SHIFT;
> -	writel(val, divider->reg);
> +
> +	if (val != orig)
> +		writel(val, divider->reg);
>   
>   	spin_unlock_irqrestore(divider->lock, flags);
>   
