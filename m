Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF09780E15C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345531AbjLLCWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjLLCWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:22:37 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2055.outbound.protection.outlook.com [40.92.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D82B8;
        Mon, 11 Dec 2023 18:22:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuILh3tRQzNktIumG4eeRvz3yEo/cDWeheUD2+06lbfpG0UgK+8n7HEZR57lFTpwJE0lG9f8mIY+AiRofwZyrZ53ZUaK1J7RHiciau66mZie4OIcglDTuKd1Vej6bnBhyRbPaa//HAHdUNdnuQIla89VLVJmeV/Ac+MnH3Uj16JXFULqOkOchvJJD4DkmKzpN6gMVA2c2LngQgakvVqKBzn08aZoPTnPpAjnOs/VcCYPFer+AdhPolW0Ie3Qivao19I0NP8oDN3vHx4rY7hyoMeUMYi9TusqIE2RGytgCaaUVRk7uD9vShfRFTSRyl5Z2vnx/gRXfZZxsLGTxo0/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPKeCWKaj5tmjJt6v4upASNpNHZbRxdrlrygQWDO5mg=;
 b=c1w22ilSQYZwNRBuW9c7x7pNyP0FA0vCnumBKDmJQaoAH4QF+nm4yFuABC6Xkwi1fMgGyiX4X1WWR9TnQ2J1E8bpI6dhhRDk7widzGKAFrK/ZaeJJsHTA+zO6u7KLfVVr/Vy4fV3RbNbxovkpjlzkA1HPohY7MZmv3P5KSqd0JelKEFbobpJcOvy05igxRF2VjBF2YQoNCutSaXzjn6zVRRBwjhUxWgsqB68Xt9kC7Dj9Xdgw7+quWuoOf+f0SJNmZsOIP+ek0b1LB3D9bWxJOroUZwitZ4rEQC8JV+ufefUGVR2+ThKygUrai7VW7fNkoCq5m29ihFK0Dv2PlibDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPKeCWKaj5tmjJt6v4upASNpNHZbRxdrlrygQWDO5mg=;
 b=F13V4JiF3DzpaO4ZjqLTTvgOce7EcsQdJaiL20y5aukl2GEQQyacLUwht/sEixpKgeOayqNO7ubsEcwMK6EB9FPAtpZxAB/zz9wqoXQL/FMnZmefSsZEjOFdTmJjiEh2bO+65XT18ZfsVXVQXSM+ogKlcI2I4M0LCC3oEU3DPNlrmvGvkmHYqTTmwzbedZIavSPv42XY+kwhYz8ravt9oycY3ER2FkZBPkQcwwgzmJ/H559piAqzT2Gme5CdruvHDKXFzh+a2VYidOEP8pP1nl+uhaqL3SXWj5YZOWCGmi8u23CL1HzXfc+Z5nyJFVr1WjcpMGkGijN4GgR1jOqEYA==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 MA0P287MB0019.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:5c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.33; Tue, 12 Dec 2023 02:22:33 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 02:22:33 +0000
Message-ID: <MA0P287MB0332A937E4DF0044594B19CCFE8EA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Tue, 12 Dec 2023 10:22:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] clk: sophgo: Add SG2042 clock generator driver
To:     Conor Dooley <conor@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
References: <cover.1701997033.git.unicorn_wang@outlook.com>
 <d1aa4f76f360ebd7b790a4786641f1b0188dbba8.1701997033.git.unicorn_wang@outlook.com>
 <20231208-opposite-stand-fc92fbaaed9c@spud>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231208-opposite-stand-fc92fbaaed9c@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [aTkwQRM4CyC17V6ryJRnCZ5mOkLvd7kA]
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <dab00686-bee1-49c3-a35a-75b23a824722@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|MA0P287MB0019:EE_
X-MS-Office365-Filtering-Correlation-Id: 763bf2b3-6590-4ed8-baec-08dbfab932a8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhFr9rwa+cs/N9Zp/X1cvGVf7rVfKwNQBj7NZ2ObVci45jQun5qBoFW5LMc1L3GpK+XucUbwE2a8V+ljYv/mDxfgoHytLWJ69FxfxLnXSPuEuRJ0r2yxQkacQIZcIC3NI0eWr/xidlGzExk/2CBsHws677uUuuBA28MJgkeMH1x9O3qHaIVlEqkUd/DHs5032nGdbVxYE7t235hzBpN7E+32I1Kw+oBiF6IGwOJqsGTfssNIqBOZZ5eD0npcoVTaphIGDtvzu5evBfSLBncc/e3rhEs7nTMCeH/Y6wuTqu4jP8EUikVjN4/z0tCfKo3+dsos9QaJGRRUvNMWj1nBv2jDuwyNlJku4552h7evQBQPJTceBI1sGRjJDYR83cVEW3CFkI3R2f4DzVj5u26lBQN3AEgdpeAVeZur1ii49jSFR4Z3l4h/Z1mmDDOUcSIWE1YoYkrZM4ky2tCJK8cpnA3T53t1gEPXIIvAYB1CdfKrbv6+4fWRfHSxM2E26Yu8Mn7d35BLBS3+k4tZT6wMoEFQlxvlRz6SBOmQ6d49CNFxGgRBN3nucMX1Xp/qLyos8FsbXP1VpThcFmJf3Gj+emkKJd2jhfWOXQ+oU2ztEg4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVdPamV1bk5YRzNncnJlRWd6czA0alAyc3pFWWZtU0dIMm5NVzFwazI1ZHBK?=
 =?utf-8?B?YWs1eC81WHhVbERSWnZSSEJyYmhRRm1rditoY3BIa1dpdDZwMkFQbGtiZWN6?=
 =?utf-8?B?TkN3TU1IN0p6U20yMlNhbU1HMGFIazRuZ2Y3djhpeWY4di94cGlZQmtHaEJa?=
 =?utf-8?B?bTdvdlhCb20vdkcxRDlpMjlmT1hSTFpuajJLT3pXaG51TlNvOGJhMlQ4OFZJ?=
 =?utf-8?B?d2xFbUR5bGZXZ1dNNlMxMnVFZy9qbVg0ZkRBb0RLN2JHVURhNTk0L0htbm01?=
 =?utf-8?B?TU9Qa1JwNVpwaHBGaEZaTGNXbzFpSmRoNEtJcTVib0NFQTN3QnRQMS8yazZa?=
 =?utf-8?B?OWt6Umg2OHVqV0ordGZWYW9NaGM4eUx3bEN4a3BqV2dLclBIT3NML3J0Sm5J?=
 =?utf-8?B?RUxicEJ3SG1ZOTRIZHRPRUUyd0lCSG04dnh1NjdYOWxRcFBnL0ViZC8wRzRM?=
 =?utf-8?B?Y21sK0x4aS9MWlFtaEVMckN0YkNkd2lNOG1idGx4V2tnTnZPaStQdy9mNDF4?=
 =?utf-8?B?Z0xsZ2NwL1hURzJGSmROUzZvbmxiVHZSK1NqT1NZSkVWS3c3ZXlSSkxRM1lX?=
 =?utf-8?B?MFo0aGFrbDY3UnR1bG9ZWVN2dVRjbzVvVHVubjk5ejRQUm5hWEdVYXNreXgy?=
 =?utf-8?B?RDR2Qk5jUnIweGx0d1ZyN01SbEVZVVZyTUJ0cHhuV2pqTnlUNWtDSU1jWEVV?=
 =?utf-8?B?TVR2Ti9abCs4Uys3Q2FsNWIyTEhsS0VPUG5PL2sybmdPT1FJL0RtYVU2OWx5?=
 =?utf-8?B?bWI4UjB4bmJ0dldRQnN6djFSbEFBZlBnQVM0MEJIQSt0TTJCVmJoZzR2dXFL?=
 =?utf-8?B?WExjZFFZaVFReU56RjRVUjR6QlRudUxxaC9YSFNzWUdSNk9vWEFGdHdUVEtR?=
 =?utf-8?B?MERZN1IwOWwyQ3JGQUQxelBjeHJtaXB4eXJKYzI2cjM3ODJESEdIWXozaURY?=
 =?utf-8?B?cDlESHZqYzkyS0YxUG41T2hLV0pBWUE3L2FOKzBUZ3l0Zis3QlpJWnpuaDhE?=
 =?utf-8?B?TEFHMDFETnVIeXlaQlAxQVcySmNYbWF6WDdtZC9lZWRWaHgxOHhsSXQwSVZ2?=
 =?utf-8?B?R2QybkxZUEJnTk5vYlpSaUxSSzgrd0ptMFNlS0R2Vjk0Y29pQy9DdnA3K2dY?=
 =?utf-8?B?YzFZeXcySThQT0tzbmI1KzdMYXU2SDRleEh0Z2phNXBNbklPVVVjVWZQYWFa?=
 =?utf-8?B?aVM1RGh4eERPaHBJRjg3eVBDeTJLT1RFcSttZFJXMWoyazZkVFJaWGhWWXlG?=
 =?utf-8?B?aGFQZmc5eFQwRTNhdEQzZXdPUk1uUVNPWWhzYjNUNjFWd2pROGxrZXJwYTF3?=
 =?utf-8?B?KytTSlQxS0J0dDBVSjBrYU5EOURkZGdMR01tdThKdDkvaUgwQmh3K25XR3dh?=
 =?utf-8?B?Zk1WTWdyTGNmUjRkVnFUUWN0YTQ4MTdPODlGOGNPZlF3Tkl3dHVyQzNuK3RR?=
 =?utf-8?B?cU44N1JRbTBlN2tSbktWQjhrc1Y1d255S0RqbUF6aXR2WCt6ZUNtdXI0QWt2?=
 =?utf-8?B?WWJBYllrVFJyaVpsWUdDYjYzeUNKZklnMWs5UFlrZWY1SithOGNQQTg2VS9F?=
 =?utf-8?B?bDUwd3NEVC9wQzNmT2QxMEV4c1phRGI3SEIwQ0pXTW9xMlUrQkFhOVVrNFl4?=
 =?utf-8?Q?t0Az9+w2i5h8ehkHE80vbuvG242aNFFWOeSvaPwRAB0E=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763bf2b3-6590-4ed8-baec-08dbfab932a8
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 02:22:33.3611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

Thank you Conor for your carefully review, I need some time to digest 
your comments. While I have some quick questions embeded.

On 2023/12/9 0:47, Conor Dooley wrote:
> On Fri, Dec 08, 2023 at 09:14:32AM +0800, Chen Wang wrote:
>
>> +#define div_mask(width) ((1 << (width)) - 1)
> Looks like this should be genmask.
Yes, I will improve this.
>
>> +#define ENCODE_PLL_CTRL(fbdiv, p1, p2, refdiv) \
>> +	(((fbdiv & 0xfff) << 16) | ((p2 & 0x7) << 12) | ((p1 & 0x7) << 8) | (refdiv & 0x3f))
> IMO this should be a function not a macro.
Would like to listen why it should be a function instead of a macro? Any 
experiences you can share with me?
>
>> +
>> +static inline int __sg2042_pll_enable(struct sg2042_pll_clock *pll, bool en)
> Why the __ prefixing of function names btw?

:) I just want to differ/highlight these functions agaist those clk 
operators. Anyway, this is indeed confusing, I will remove this ugly "__".

>> +{
>> +	unsigned int value = 0;
>> +	unsigned long enter;
>> +	struct regmap *map = pll->map;
>> +
>> +	if (en) {
>> +		/* wait pll lock */
>> +		enter = jiffies;
>> +		regmap_read(map, pll->offset_status, &value);
>> +		while (!((value >> pll->shift_status_lock) & 0x1)) {
>> +			regmap_read(map, pll->shift_status_lock, &value);
>> +			if (time_after(jiffies, enter + HZ / 10))
>> +				pr_warn("%s not locked\n", pll->name);
>> +		}
> Can't you just use read_poll_timeout()?
> https://elixir.bootlin.com/linux/latest/source/include/linux/iopoll.h#L16
It looks like this, will check more.
>> +		/* wait pll updating */
>> +		enter = jiffies;
>> +		regmap_read(map, pll->shift_status_updating, &value);
>> +		while (((value >> pll->shift_status_updating) & 0x1)) {
>> +			regmap_read(map, pll->shift_status_updating, &value);
>> +			if (time_after(jiffies, enter + HZ / 10))
>> +				pr_warn("%s still updating\n", pll->name);
>> +		}
>> +		/* enable pll */
>> +		regmap_read(map, pll->offset_enable, &value);
>> +		regmap_write(map, pll->offset_enable, value | (1 << pll->shift_enable));
>> +	} else {
>> +		/* disable pll */
>> +		regmap_read(map, pll->offset_enable, &value);
>> +		regmap_write(map, pll->offset_enable, value & (~(1 << pll->shift_enable)));
>> +	}
>> +
>> +	return 0;
>> +}
>> + +static unsigned int __sg2042_get_table_div(
>> +	const struct clk_div_table *table,
>> +	unsigned int val)
>> +{
>> +	const struct clk_div_table *clkt;
>> +
>> +	for (clkt = table; clkt->div; clkt++)
>> +		if (clkt->val == val)
>> +			return clkt->div;
>> +	return 0;
>> +}
>> +
>> +static unsigned int __sg2042_get_div(
>> +	const struct clk_div_table *table,
>> +	unsigned int val,
>> +	unsigned long flags, u8 width)
>> +{
>> +	if (flags & CLK_DIVIDER_ONE_BASED)
>> +		return val;
>> +	if (flags & CLK_DIVIDER_POWER_OF_TWO)
>> +		return 1 << val;
>> +	if (flags & CLK_DIVIDER_MAX_AT_ZERO)
>> +		return val ? val : div_mask(width) + 1;
>> +	if (table)
>> +		return __sg2042_get_table_div(table, val);
>> +	return val + 1;
>> +}
> Are these not effectively the same as clk_divider's ops?
Will double check.
>
>> +
>> +/*
>> + * @reg_value: current register value
>> + * @parent_rate: parent frequency
>> + *
>> + * This function is used to calculate below "rate" in equation
>> + * rate = (parent_rate/REFDIV) x FBDIV/POSTDIV1/POSTDIV2
>> + *      = (parent_rate x FBDIV) / (REFDIV x POSTDIV1 x POSTDIV2)
>> + */
>> +static unsigned long __sg2042_pll_recalc_rate(
>> +	unsigned int reg_value,
>> +	unsigned long parent_rate)
>> +{
>> +	unsigned int fbdiv, refdiv;
>> +	unsigned int postdiv1, postdiv2;
>> +	u64 rate, numerator, denominator;
>> +
>> +	fbdiv = (reg_value >> 16) & 0xfff;
>> +	refdiv = reg_value & 0x3f;
>> +	postdiv1 = (reg_value >> 8) & 0x7;
>> +	postdiv2 = (reg_value >> 12) & 0x7;
> IMO all of these are opportunities for GENMASK and defines.
Looks like this, will double check.
>> +
>> +	numerator = parent_rate * fbdiv;
>> +	denominator = refdiv * postdiv1 * postdiv2;
>> +	do_div(numerator, denominator);
>> +	rate = numerator;
>> +
>> +	return rate;
>> +}
>> +
>> +/*
>> + * Below array is the total combination lists of POSTDIV1 and POSTDIV2
>> + * for example:
>> + * postdiv1_2[0] = {2, 4, 8}
>> + *           ==> div1 = 2, div2 = 4 , div1 * div2 = 8
>> + * And POSTDIV_RESULT_INDEX point to 3rd element in the array
>> + */
>> +#define	POSTDIV_RESULT_INDEX	2
>> +static int postdiv1_2[][3] = {
>> +	{2, 4,  8}, {3, 3,  9}, {2, 5, 10}, {2, 6, 12},
>> +	{2, 7, 14}, {3, 5, 15}, {4, 4, 16}, {3, 6, 18},
>> +	{4, 5, 20}, {3, 7, 21}, {4, 6, 24}, {5, 5, 25},
>> +	{4, 7, 28}, {5, 6, 30}, {5, 7, 35}, {6, 6, 36},
>> +	{6, 7, 42}, {7, 7, 49}
>> +};
>> +
>> +/*
>> + * Based on input rate/prate/fbdiv/refdiv, look up the postdiv1_2 table
>> + * to get the closest postdiiv combination.
>> + * @rate: FOUTPOSTDIV
>> + * @prate: parent rate, i.e. FREF
>> + * @fbdiv: FBDIV
>> + * @refdiv: REFDIV
>> + * @postdiv1: POSTDIV1, output
>> + * @postdiv2: POSTDIV2, output
>> + * See TRM:
>> + * FOUTPOSTDIV = FREF * FBDIV / REFDIV / (POSTDIV1 * POSTDIV2)
>> + * So we get following formula to get POSTDIV1 and POSTDIV2:
>> + * POSTDIV = (prate/REFDIV) x FBDIV/rate
>> + * above POSTDIV = POSTDIV1*POSTDIV2
>> + */
>> +static int __sg2042_pll_get_postdiv_1_2(
>> +	unsigned long rate,
>> +	unsigned long prate,
>> +	unsigned int fbdiv,
>> +	unsigned int refdiv,
>> +	unsigned int *postdiv1,
>> +	unsigned int *postdiv2)
> This is not the coding style btw.
Agree, will fix this.
>> +{
>> +	int index = 0;
>> +	int ret = 0;
>> +	u64 tmp0;
>> +
>> +	/* prate/REFDIV and result save to tmp0 */
>> +	tmp0 = prate;
>> +	do_div(tmp0, refdiv);
>> +
>> +	/* ((prate/REFDIV) x FBDIV) and result save to tmp0 */
>> +	tmp0 *= fbdiv;
>> +
>> +	/* ((prate/REFDIV) x FBDIV)/rate and result save to tmp0 */
>> +	do_div(tmp0, rate);
>> +
>> +	/* tmp0 is POSTDIV1*POSTDIV2, now we calculate div1 and div2 value */
>> +	if (tmp0 <= 7) {
>> +		/* (div1 * div2) <= 7, no need to use array search */
>> +		*postdiv1 = tmp0;
>> +		*postdiv2 = 1;
>> +	} else {
>> +		/* (div1 * div2) > 7, use array search */
>> +		for (index = 0; index < ARRAY_SIZE(postdiv1_2); index++) {
>> +			if (tmp0 > postdiv1_2[index][POSTDIV_RESULT_INDEX]) {
>> +				continue;
>> +			} else {
>> +				/* found it */
>> +				break;
>> +			}
>> +		}
>> +		if (index < ARRAY_SIZE(postdiv1_2)) {
>> +			*postdiv1 = postdiv1_2[index][1];
>> +			*postdiv2 = postdiv1_2[index][0];
>> +		} else {
>> +			pr_debug("%s can not find in postdiv array!\n", __func__);
>> +			ret = -EINVAL;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
> Reading this function it makes me wonder if (and I am far from the best
> person to comment, someone like Stephen is vastly more qualified) you
> should model this as several "stages", each implemented by the
> "standard" clocks - like clk_divider etc. The code here is quite
> complicated IMO as it seems to be trying to implement several stages of
> division in one go.

The objective of __sg2042_pll_get_postdiv_1_2() is straightforward: 
based on the formula defined by the TRM, with input 
rate/prate/fbdiv/refdiv, we can get the possiblle combination of 
POSTDIV1 and POSTDIV2 by looking up the table of postdiv1_2. We will 
later use it to setup the clock register.

Though the codes looks a bit complicated, but accually it is calculate 
with the formula : POSTDIV = (prate/REFDIV) x FBDIV/rate, I just 
separate it into several steps to make it easy to understand, I have 
listed the formula in the comment on top of the function.

>
> There's quite a lot in the driver and I will admit that I have not read
> it all my any means (I skimmed from here onwards), but in general my
> advice would be to try and reuse the generic code as much as possible.
Agree, I will double check and try to optimize the code in next revision.
>
> Thanks,
> Conor.
>
......
