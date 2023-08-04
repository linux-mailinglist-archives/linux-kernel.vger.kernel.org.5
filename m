Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1653F76F77C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjHDCFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjHDCFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:05:37 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84650E69;
        Thu,  3 Aug 2023 19:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDQqRC+upflFS/b5KshlRpaghK2sTDC0kGp70JuuFpocEK9/AfQQ8EI4/1N74W8a07HnFI2Wpd5n7YwJDog0lH9q5faC31O4b7RrDtrer797r7KdKZptgLbYcWAooQXeRfvHTP+l7efSbxpdWDeX5BNGPVPmovbt34RLd6YjlAvskKkvYQCvC8tOxDCz7mnUBA9nrA2rnTgmmDTrGkkZLpJLuXZC+qWAfAgXc5AonahAZXNK8HnePOXMDzSpz423hY9lPIrr55nFVcxmPjgytQwjU+aMSvQtNaKTR7+TtzdBqTKytYxxd1sYltxBzQcyS0aPW5NcOthxDWqnNxAHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEB0vu/rhi4wL/E3hE7yq2oh+aC+wRjTKYp80yKG/2U=;
 b=Xga3bedp69EdZijfZ/0q76RPP+AjaH0P48kMK7l8V4phBkM8mJ+q/kgthsBQdoCeFiwfRz81ujHT1bObZ1lY6dSqkuIfJmAxKn2EEsz9ODlZFxArUA5O0wUYAMQjUeVJ7OtnxLLHYAD6XdhEAcwg41nKtjtrm/8Arq2KkifIQSUS77NOzh5+KdejcNLFgBrElLj0/NjglbX+HbGwWyyb+Ycbsky0+jkTf3PxvAqHHaCyweVqA6UvIXiVKkjyoMzyrxEOu31dRatlytokRUSzMO2faw9XUxZCZgajaHXjg6CyQiByyXTKVwJouBnNxKm5010TY8MGjOtMjk1CXXJsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEB0vu/rhi4wL/E3hE7yq2oh+aC+wRjTKYp80yKG/2U=;
 b=P+cmuW+ytewRZ8gRuEawLok2TFbyzj+T+y0nURI0YoLHcH6DuXYidU0KLqdMKBLMDarUt4slG7JAaauXyKDhGHUT9nHNdJoqLCS6UvOd5TCX6wfooqUrTSR9PH+XdQBLF6CVTZYqQhdex+UoTqS5N+nT7YRBN5Epsw/jfixMg7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8785.eurprd04.prod.outlook.com (2603:10a6:20b:42c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 02:05:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 02:05:30 +0000
Message-ID: <7b4aa0db-fd8b-902d-4f57-664a55a5f9f8@oss.nxp.com>
Date:   Fri, 4 Aug 2023 10:05:09 +0800
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
 <092bddfa-ff9d-ab57-63ed-e6c0f2e9b550@oss.nxp.com>
 <51e3da0a-edee-a012-139c-f15feb67b973@pengutronix.de>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <51e3da0a-edee-a012-139c-f15feb67b973@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 897c8e73-7cde-4ca8-2725-08db948f473c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTGKloxMv0eH4VmP93OiZAV0tt/+QSCILzTBndHvp6p742MHlsKIukSPG4VEBy0voa4Kx8HXWkHxbVq/K7mvBUBXCu+BHFiBWCVHUncuaIB5BdSE6A4HQAxNSyMd27IO961tcpJkFKVh0aOkvgTYBG29jIgH5JCEorVfTPrRCk/ZYOVOvE3/hDFEiwn6PyPVCGQcjvsWrtCps52Ki7Wh+2mYWJI8u+xZg8MtNMcx0eC2RuiZqyqIII2WQ5xin2qtQ3eprhKER2sRAXh5F1WPgZDvl5XQ/ixF1DUig/z4ZV7Pyid0VD/5ZbqC7anf9u5RJAL+46vTD2phe68LEl0Ti8VZfd9DQ0R1koLHJd8s7i8kQbCCpAPfaFN6uFoS1Ka1iA9uFXpW1Nv7jW+aBp3DGZ1oE6AghzaVDdLMYmhdLjEOL3XMULcOJdjHzkwmBRncH0Hv6oFbUDXs25L6mxtD8kz/+WMbPtGcp8POSBIlo+HlAU4o1H6U8XIJyhlztfBXzUE+ilMXuUUlbvxFf6Ca/iF0wgd25kkldHdX1Gu5/WMAjDpqYWV/QL4dFOiN4wAfoOrqaSw9vWERK7b2xniUxBc/9boK6A6AHkgYyiaNYoy5rrkrmQiz+sCK/BownuvYerSnMcEt18DG3+LMz/nGSaB+pBlUx0ByrDFgehA4BO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(1800799003)(186006)(31696002)(86362001)(31686004)(478600001)(110136005)(38100700002)(921005)(41300700001)(2616005)(6506007)(26005)(83380400001)(53546011)(6486002)(8936002)(44832011)(8676002)(6512007)(6666004)(7416002)(4326008)(316002)(5660300002)(66556008)(66476007)(66946007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1B5MVY4b01aWU04SlZjb1ZSOWc1eStaeCtFSWtac25VcUtZUGk1K2wxazhs?=
 =?utf-8?B?ZDQydWZCZDdHdGNoZTlneUZhSU1HMkR3bTJuVlptcytZVXFhQnRxK3FSZ3hi?=
 =?utf-8?B?cFBUa3YydlRzN0NwL0VrYWdVNENKSWFraFNub0lzNVlZaXFESHRUZjBSU0Er?=
 =?utf-8?B?NWRIbERnQVdpS1lHdTRNNWRTaXFadTF0MTJzZ0hDQ042TTZTaGFiQy9CVDFr?=
 =?utf-8?B?bTNhRG43RnpuaUgzakZ3SUxTOHFpckJhVFpGbG9ETnUveDd0dm9lMm5XVjB4?=
 =?utf-8?B?UDNYM25xRjlVZWhuNVBUelJFL294ZENhUFVIWjFNOFVhMmtCVDl3YzBhOCs0?=
 =?utf-8?B?UmNqRTlUYXgxTlorNks3bEFjbnJ1RXQzNGhlYnJhQXB2c2laWHJ4SzNBbnBu?=
 =?utf-8?B?eHNTWkxIbFIzbXo5WlVvc1lML1ZHUWNUdFYwLytTUjZCVnlaSHY2SDRUT3d3?=
 =?utf-8?B?NHpwTUFwY21UVW9FRWZMWVBzaitHMXVONm9FOWpyYlc5K21ET1R5OXREK2dt?=
 =?utf-8?B?Y3NyMW5Cd0krL3cxOEtObzk5TUx4RGxZUythbUdWTi9JTTB1ZVFSd1RwVTdY?=
 =?utf-8?B?WG5hajJOSnpEYmNNYkc2U2UzRXhYWFZtTng1TFJXMUJzelpTODdCUGVxeTRN?=
 =?utf-8?B?RXA1cjdvK3NlYUEyYmhzQUJnS2lxajd1YWsvMEtTNUduWVBMb29QRk5mV3Bn?=
 =?utf-8?B?bUdqbDVnTEIvMVhqRCtvODNzakc1SEF6TjUySVlBZGZoS25OU1FIODFmS3d5?=
 =?utf-8?B?Sm9md3FPQ2t3d2tkYnh2OEtmTUtmeFV4WWZteGZOakxROEgxU1p2RTlBaG11?=
 =?utf-8?B?bUNXUzVUQUV3ODQvVThmbitNeW4vNmF2aU9EQUNtYnRlY3JSeDJZeW9vczRp?=
 =?utf-8?B?RjdrNjRuNC9PUmQ4NTA0enhkQmxlN3BNbmxmeHZkNURYYlpVRm1EblpaN0pt?=
 =?utf-8?B?bFRFUGg0ZnE1TWlITWxZQ0VOaWZYTWtFOSsrSFRaUXNDb1pWRFhQVzEyUy9t?=
 =?utf-8?B?bnN3Q2NmakVFUVk4eUFLS0hxK1ptSlQyR0ZUb2lxTDJISUlFUExxQVZuME5K?=
 =?utf-8?B?SG1qUzV0MlF0WWN4RXhGWmxESnZkV1pwRlg4aFlRRk5na3gxZW1Na3lBUFpK?=
 =?utf-8?B?MzFNU09XdENqSjFtanBtRThGYjBiaTJ4R2lZY0hyRmcvbmZmd2tuYnFYVVlG?=
 =?utf-8?B?Mi9vNGZTemNaV2FQTjJuSVpzWUZBS0pxRGpxbSswcldHWFRPdXRaWFg4M3l1?=
 =?utf-8?B?aEU0RmUzekZ1NS9oVmpXY2pOTWVGVjdMNU9nNHFyZjVEMUlkQXlocGJINnRS?=
 =?utf-8?B?dDU3ckl2cnByakplWkpVNEdrVzFWOC9pZmUyTkpUUE9WRGJNSWgyL3FraGdL?=
 =?utf-8?B?bEtUejJ3Z0dCcUkwWGtJSUNqSGszdGt5N2wrbFJjSGhReEJyQ004MVJvYWNn?=
 =?utf-8?B?ZXlXMy9SQXBqVktyYXBVTFFNM0lJdDQ4Z1hxYnpxZmZyV1lSL2N2Ny83ZHFG?=
 =?utf-8?B?OU5RbGFLdjF3Y0JxaWNoN3hnZHNkQS9OaW0zaXVYKzRpZ2FxVTJYWUc2R2Vt?=
 =?utf-8?B?S215cUk1dTZLVlZHcGRLZjdVWnFSNnFsQ1pGRXZEUUtsZk1ocXNFZG5TcW9v?=
 =?utf-8?B?eHppdm9PNjNPUXM0WmwrUHBUYU9TelZ6a1BhZjlNRGlrWTRrZnQ3cm1kUVZw?=
 =?utf-8?B?NjQxWWQrUTY4K0tQdDY0dWlxeFBjUkcxdnF1bHgyc083dTk4bU4xbDl1V2hU?=
 =?utf-8?B?UWlVV2kzSmhxZE1yOFVJRk0wSDRHUi9qa3RITnZ4NW1zTTJ2SjZUZmo0RUl4?=
 =?utf-8?B?S0RKNUc3disxQWRObXAyVmFBajZzdDBHM2ZHcGhJSHVPNjUveHlEUGxGZENP?=
 =?utf-8?B?YWQ0YmMxaHFBU0U5ZGMvVFZYMnlMVk5WQmJtNTVsT0RKUWRuNDJsSURQdTgw?=
 =?utf-8?B?T3lYV1cxSDJ2NGFndE1FRlhJZVBWdEloY1Y2QXBjYUtrMlkzNjBmdmNNcnZn?=
 =?utf-8?B?WlhUeDYyQ2p6UFh5aHFIZ21reGxJSUgyc2JWL0dCSVJycExzdjhOaU9ucW44?=
 =?utf-8?B?QUNneU9zVFNrbWYxMTlOSnczOWdTbU5qRUJVenR2RzhieEV2M3ZIamRESUtR?=
 =?utf-8?Q?VVWYRKfE/vnsJEpGbANJd21+Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897c8e73-7cde-4ca8-2725-08db948f473c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 02:05:30.3740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGGopzC+9Dduj842/6T9F1FiovqnM9IA8jVKqPyy9j4iLUVQd27LLfN2x7Mp2zhSqTqemT3E7A53Cd62etSQyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8785
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 2:30 PM, Ahmad Fatoum wrote:
> Hello Peng,
> 
> On 02.08.23 03:25, Peng Fan wrote:
>>
>>
>> On 8/2/2023 12:27 AM, Ahmad Fatoum wrote:
>>> Reconfiguring the clock divider to the exact same value is observed
>>> on an i.MX8MN to often cause a short clock pause, probably because
>>> the divider restarts counting from the time the register is written.
>>>
>>> This issue doesn't show up normally, because the clock framework will
>>> take care to not call set_rate when the clock rate is the same.
>>> However, when we configure an upstream clock (e.g. an audio_pll), the
>>> common code will call set_rate with the newly calculated rate on all
>>> children. As the new rate is different, we enter set_rate and compute
>>> the same divider values, write them back and cause the glitch (e.g.
>>> on a SAI's MCLK).
>>
>>
>> The CCM root has glitch-free mux. When upstream pll freq change,
>> the child set rate will also touch the mux bit, since div and mux
>> in one register, so the mux logic will also function.
>>
>> Per design, it is glitch free, so I not understand well why glitch.
>>
>> When you configure pll, the downstream sai clk should still not be enabled, right?
> 
>    - sai5 is running normally and divides Audio PLL out by 16.
>    - audio_pll1 is increased by 32 Hz -> only kdiv changes, so no glitch
>    - imx8m_clk_composite_divider_set_rate(sai5) is called with
>      32 / 16 = 2 Hz more
>    - imx8m_clk_composite_divider_set_rate computes same divider as before
>      and writes register
>    - divider starts counting from zero, so we have a longer clock pause
>      than usual, e.g. 40ns -> 125ns, external MCLK consumer doesn't like that at all.

Thanks for detailed explaination, I would expect write this down in 
commit message.

> 
> So it's not a glitch in the transient high frequency sense, but rather a transient
> low frequency period. I can reword the commit message to s/glitch/clock pause/
> if you prefer.

clock pause would be better, since the hardware design could avoid real 
glitch.

Thanks,
Peng.

> 
> And yes, if mux is switched, we will probably get the same clock pause, but
> that is not a problem for me currently, because we don't switch parents except
> at boot up. Afterwards, only PLL is tuned.
> 
> Cheers,
> Ahmad
> 
>>
>> Thanks,
>> Peng.
>>
>>>
>>> To avoid the glitch, we skip writing the same value back again.
>>>
>>> Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
>>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>> ---
>>>    drivers/clk/imx/clk-composite-8m.c | 12 +++++++-----
>>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
>>> index cbf0d7955a00..3e9a092e136c 100644
>>> --- a/drivers/clk/imx/clk-composite-8m.c
>>> +++ b/drivers/clk/imx/clk-composite-8m.c
>>> @@ -97,7 +97,7 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
>>>        int prediv_value;
>>>        int div_value;
>>>        int ret;
>>> -    u32 val;
>>> +    u32 orig, val;
>>>          ret = imx8m_clk_composite_compute_dividers(rate, parent_rate,
>>>                            &prediv_value, &div_value);
>>> @@ -106,13 +106,15 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
>>>          spin_lock_irqsave(divider->lock, flags);
>>>    -    val = readl(divider->reg);
>>> -    val &= ~((clk_div_mask(divider->width) << divider->shift) |
>>> -            (clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
>>> +    orig = readl(divider->reg);
>>> +    val = orig & ~((clk_div_mask(divider->width) << divider->shift) |
>>> +               (clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
>>>          val |= (u32)(prediv_value  - 1) << divider->shift;
>>>        val |= (u32)(div_value - 1) << PCG_DIV_SHIFT;
>>> -    writel(val, divider->reg);
>>> +
>>> +    if (val != orig)
>>> +        writel(val, divider->reg);
>>>          spin_unlock_irqrestore(divider->lock, flags);
>>>    
>>
> 
