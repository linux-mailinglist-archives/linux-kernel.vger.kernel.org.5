Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA47FF3C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346381AbjK3Pmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjK3Pmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:42:53 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2114.outbound.protection.outlook.com [40.107.105.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A39710D5;
        Thu, 30 Nov 2023 07:42:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iP7KW+nDxT3KDTeqOo/NmmX5MAr2tbMwCKsSvmfKVAj/LrouSECpcq3KWqSz713f2t0CFNLCZ6MIXngyWD0OuM6TwY3gMoJe7wAH3tY8YQaBvUljNJ8b+14GYTqeEGY2GYErx+PBt4NPu+IkUQsABZnNU3xWcv+JVYHWt1ZjoDRc/Iz/n0hByT/0zHI6IawCj402G7RxxiDi7YIT5gfzoGgR4xTewzUyCFC9wBGZg2RC3plj6Gc5hRKIHlVDRi0UVXTL3Tgqk9rWt9Kw2ViIM34O+McrJ913t70AI3z3HMIHL1BodWyEvZBxlQ+0EfMG2JZDOxrIzPmcoDPxuvxb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co+chC5/TUuIsA0L/hFaWmMeMwsvcZDZsrd1SUdr/rw=;
 b=AFLTXFqgttw0rIxVSaUW5bcmOij7qwjPDPYr6HXcgYQHN0pt7A5n2NgR7XlcUKwwNHV+FBvqPhcwvin4UvPw2aD4ZX0ot3n4/DYOHiR2fMQVT/exM90aFGbZAxZZUi/K08yEE8pZ2KIluupfGIsNB7LAtylO42lsZewPSPQeXxd/yab+s2SC1gGuO632k7O3KZPaSouKEI0yagIiq0UGmTTt6rOT1wYZRDhAka8SGLEmU2saNbn50u7QYaccE3ZdQcNg1lO8HfJFWSkzEXFbYfMWaS+keBCFbDHHOo6YpIiHRESRGreWUC7qTJgQs5mCc4a7wY05ZjSps3Nxg50vYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co+chC5/TUuIsA0L/hFaWmMeMwsvcZDZsrd1SUdr/rw=;
 b=c7xsAGI101TxoUHmBUIyNzGc1BOd/f8BB/Rk27JeOaligeAMbXNkjcc2NHReK+vjjEcyFg4hX9lU7v77I2s4SMqwC9MGi65erwoNI7DZlXmI4bbqZHBYFetVWZuqhXZPAuIXTyR6/onkyr5v4abdK5LX/F1FmcLKpnym54eLsFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM9PR10MB4069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 15:42:57 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d%5]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 15:42:57 +0000
Message-ID: <a84b42eb-5543-4fff-ac92-bdf32cad1985@kontron.de>
Date:   Thu, 30 Nov 2023 16:42:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: imx8mm: Simplify mipi_dsi clocks
Content-Language: en-US, de-DE
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembeded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231128045415.210682-1-aford173@gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20231128045415.210682-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM9PR10MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: fcfe6370-890d-43f0-2af0-08dbf1bb0634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOSqFIUEz69BhOry7IA+uXgX3uXk8CSgx+YeC4+9r/lkB7cF9kVAECTzHPhaeq269uMrwrlcQBhjh4ejvxfRJMH0Ln6EiSKbX/ZHrRQ5y/Q+I+kqxQALVVTLyfaStyeEczvw9rzoMf8LiN3fv2olshwiEmK8O6jK/+/uP8etpmMtiNUryDo6O/7aqNpvDIrRE9ENcF6yS2v3SlTblYGhuJvFRkYnN3p0lhaLX+nkWpYKN+60KJZ7uVoCRhLVYZEjDA4XC23KrNOjRtSARJURjj4q3FEvRcqOW9d7VI0YydNFhgRML8MSfVO43lAGDRaH8MB782O74+bwA9GdozEScsqsxguxA6K7IpfsDtbkoI2gY36wgJO1Thx9LIfHb+o43XvLbU1OyylkbkU7WE1tTUQmkubtVFCWVkNI8mWkJ4cW/gGoL2M5PL01kJfHSPN+5zujjvzRE0OU4pkl4VQ8LSQEqJr8iX9LjIVkOb4Blzz8eTeyp5XiRnt22kDbjx/Ho9yyoEtoqFnzi7jIoazlwUpvlvd98+hmgRnavcs9gYQgjDPrdG4AC5DCqIKC0FiD8aSYdrb4oE9bNijr7bW+hjNDNx5zXBR38DzD3y+W8eyeygjYEtkClIqls1WyLYYt+noICA3YDxTDTeExBs7hHdIv3zddzz1Qj5qBpjQkr/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(86362001)(66946007)(54906003)(66476007)(38100700002)(36756003)(31696002)(26005)(6506007)(83380400001)(2616005)(6512007)(6666004)(53546011)(2906002)(316002)(66556008)(6486002)(8676002)(5660300002)(44832011)(478600001)(41300700001)(4326008)(7416002)(8936002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1M5UWhaU3BjVDJUMWdGOFIwYW1BRzZ0UzZvM0dEeVdpM1RQdVllaXg0RTc3?=
 =?utf-8?B?V3hVYlpJVXd4c0UxS0VHY3pUNTJpNFNnbllWR1VWZ1VJR2ZrTE00Z3gyMGFw?=
 =?utf-8?B?UHRoOHVKNkpENzhoa1p2OUVMaExEQ2Ixekp0Um5tSnB2WmIzNUxIUU9IRzJI?=
 =?utf-8?B?MHRERUNjb285eG1TWEt6R2FwNEhSa050akZ2bEh3WFlkcURod2VCUnA5UG9K?=
 =?utf-8?B?Q1pnWlFqNlc0cVhpRXNXYm01UHZVRm9DOE96RlhIYkR3bDBNUkF2dFFVMnRz?=
 =?utf-8?B?bnhWNHpNbjFKR1BON0txVnNYVTFZN3RSQ2tldGRBZXJUUFhEWC9ZQklDYVJE?=
 =?utf-8?B?SGVGaDR3QlVGd3ZVMEJ0VGFUTzZQcDIxWkpibEVTMDZjdHdEYkF5K0xEeHhq?=
 =?utf-8?B?amRYUk1YVUNDNjRlL01hdyt2SUtBWnQ2RE5YRnVRMU9Xd2YxR0RNM25LMElu?=
 =?utf-8?B?MWdGNDJxQldURWsvKzhNdWcrbGdsd0U2eWpkV3YzNTNBKzhUMU1Zek5nTzlY?=
 =?utf-8?B?L3kxN0tTTUIrdkpaWjZHWGdNRnNYaUJ5c0piWndmdkI3ZCtoTnNNN0JYeDZk?=
 =?utf-8?B?OG13bm1VVUN5S1oyZ3NDVFZ4emIzVlRQWEw5a0xqeWp0QUJha3crZjFBZVla?=
 =?utf-8?B?aVlpWGpRT2M2cUJZZnJzVjI3ZEJuRDJxM1VQd2FBYXBoY0RicWM3SWFieG8v?=
 =?utf-8?B?WEIxa1lROStGY2wzcTZ0TSsrd2Nqc0N0N2daZ1VOYzEyTldYQjU5SU16ZllZ?=
 =?utf-8?B?YUpaNWFTUGhWVzF2Y3AxOWRIQjlnU0NJY2FzbXQ0NUs3YUU5aUJoNU5Lb1RY?=
 =?utf-8?B?QzZEVVc5K1ZBeHFSRnhtWEl2OWZ1SS9Vc1JubzJWa3BnUldIMjlaN1RIaHhy?=
 =?utf-8?B?K3pDWlVRQ255b2dSTmtvMnp1MllRcitzTTlqdG1oNkl5QkdHQis3UGM5aUpl?=
 =?utf-8?B?dmE2bHJ3OGVLTjhLNTIvRUVQZlpHaTMzc3h1a1J5dEZ5dXZGemZxWCtYTFdr?=
 =?utf-8?B?dWdGZXdHSHJ3UlF2OHY2YitJVEN1a2lyZE5ibjNJVk15Yll4c01SZzdxbXNt?=
 =?utf-8?B?TTBKRDd0UVdSTi9Zb1hMcjkzS2VPMGN1d1dlSVI1TUlra2dCRUg1ektlR3g3?=
 =?utf-8?B?Y0RpUVNER21uMkFHeWphY2VYb0lBOE91TFFwS3NrUVFPNCszTFNnQWhGZG10?=
 =?utf-8?B?TGw4RHl5dVJxOVlVUkFQOVd0V1k2SHBnL3k3UU5Ed3JGazNjZlh6QlRpMG5N?=
 =?utf-8?B?VFF5SWw4TGhXSzloUTFzczFKdE9SVGltTTBtVXRRUzJkbElsMWlKcklpcnRy?=
 =?utf-8?B?dDRMbUtKTVdVTmtqajdTQ1FrMVlCVng0TXpRWVRYYjdEa3U4K2U4ZFBFQ29k?=
 =?utf-8?B?WXU4SXYrK0xDOUEwanhXSzZDQjI5UERIYWFrQUFFck5BWWhRM3pKTGNqcWFI?=
 =?utf-8?B?OW53WkplSTdoNG4wcFM2YnZ5NVM5RnRKaHhUNU9BeXB5UUhXWEZJTjlYam5m?=
 =?utf-8?B?WlhNRW1HSE10MFRPVkZuRHIzTmVLVUlBRjRvdm9jZjdHbm13UkhkSms2cXQ0?=
 =?utf-8?B?blNoay8wQldtN2VweThhQ2UwelB3ZWt5T2REcUVqSnV5VkZ2MVhhVW1nb2pr?=
 =?utf-8?B?MGxPdkk1cExXZ083STJvRS9NTkkzRXUyV3VXZURTQk9FZEdQd1ZsOVBVMVY4?=
 =?utf-8?B?VEVjVnVTaXZIWFpiRWdad1ZzZzNsSDdzRkRycm4xa3djZXlaT3VFbHZIbXZx?=
 =?utf-8?B?Zlo5dGZZL1h1VkFiaFNtQWpwVll3bkNSelFJeGlWZ01CZVl1MUNSYURtSEpR?=
 =?utf-8?B?eHZBV3ZlTkpzT3J5WGgyVEV3NHpPSFZRc1oxeHZiK2kyOXFTRzVFaXprcnlu?=
 =?utf-8?B?c25HTUpsUmxTSW45OWQ1OW1paVRWNVJHbkZ0MGE4Z0JSTVJQa3Y4bm5wMlJZ?=
 =?utf-8?B?UGhYZjdRbWVnV0d2dm5ST1NpelI1UDN0elNSZ0dUUisxY2JuMzQrMEY3YTFO?=
 =?utf-8?B?aFNneWw5MkxSL1BSUUJFbGVMbENmUnFPSGZWTUdCa1VCMFllYkFnSGE2R3RD?=
 =?utf-8?B?Myt4ZGJzNm1UQThnM2YzQkZHQ2pNaW16VlZnbEVoYUFlZEliNnFEdjdBcHhm?=
 =?utf-8?B?Zk94b3M5NFk4dTRLSCtOZzhPVEY2aTlaaGw4REtpYWZBR1FVdWFJb2ZDL1RN?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfe6370-890d-43f0-2af0-08dbf1bb0634
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 15:42:56.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNTlLegtJCdLBmjEG9536tH8RGhTPyHHePGyn7yy/2Lcj4rb5oAFtqvrPiZtMbZNZBKQHj51ofPXNruX0jlbvnZlfcfFdGkbBTBuk37iCvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4069
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.23 05:54, Adam Ford wrote:
> The device tree clock structure for the mipi_dsi is
> unnecessarily redundant.
> 
> The default clock parent of IMX8MM_CLK_DSI_PHY_REF is
> already IMX8MM_CLK_24M, so there is no need to set the
> parent-child relationship between them.  The default clock
> rates for IMX8MM_SYS_PLL1_266M and IMX8MM_CLK_24M are
> already defined to be 266MHz and 24MHz respectively,
> so there is no need to define those clock rates.
> 
> On i.MX8M[MNP] the  samsung,pll-clock-frequency is not
> necessary, because the driver will read it from sclk_mipi
> which is also already set to 24MHz making it also
> redundant.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 738024baaa57..8d872568231d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -1151,12 +1151,8 @@ mipi_dsi: dsi@32e10000 {
>  				clocks = <&clk IMX8MM_CLK_DSI_CORE>,
>  					 <&clk IMX8MM_CLK_DSI_PHY_REF>;
>  				clock-names = "bus_clk", "sclk_mipi";
> -				assigned-clocks = <&clk IMX8MM_CLK_DSI_CORE>,
> -						  <&clk IMX8MM_CLK_DSI_PHY_REF>;
> -				assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_266M>,
> -							 <&clk IMX8MM_CLK_24M>;
> -				assigned-clock-rates = <266000000>, <24000000>;
> -				samsung,pll-clock-frequency = <24000000>;
> +				assigned-clocks = <&clk IMX8MM_CLK_DSI_CORE>;
> +				assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_266M>;
>  				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
>  				power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_MIPI_DSI>;
>  				status = "disabled";

Thanks for the cleanup!

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL
i.MX8MM
