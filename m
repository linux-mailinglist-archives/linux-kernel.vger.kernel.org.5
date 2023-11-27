Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83127F9B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjK0IHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjK0IHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:07:17 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2042.outbound.protection.outlook.com [40.92.103.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FD4B5;
        Mon, 27 Nov 2023 00:07:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur85VhFn9PxMJmrvw21d7doozFssbzDJn0bu3L9Gxby4lNWPY27ByDiLuhsozsPjc7azq4uX8zBLWO+RdRTXBavZOchAF+mH2J8fRIaPcs2XyHz1/qulSovnZHHwLDnlSELseZywVWEkXenkKfGpisxPoFHnssD3gIg+QLmFQkzjVQHr8BoT8cdLnFnDZVvwlWgGAFWm/JOwYpsxV9y5nbURTlnYGd/Vtmn0z4fllC4pCWiP+WGTULlp2oqtiVjVtsqDzptt/fNKmAPAJTn55pKNGqhPCzFFWA1IVlCqVr23XQ7AA9aSUx5nbKrQU3j+J5VsKsGRApK/uMgTY3wv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR2yUk3o2sX4BBmQ7DHwlK2oQyPNgPORTOHQUgWUWuo=;
 b=gL8O8rp4E4Y/surZPOEdx7eKLw/XJv6g7QOvyczNgq7Eb908nf5pYAdiR5bCyejhH1vqBStJIM9UV23iayjH1GkAYNefPKDvO1Oxba/kIIooNXyRO5zUw9heS9dYzL1f9NPfTrl/GhLh0sqq3GP9YfeMkURtJMGlv+fuX017jmdmksj2YZB6HanUI/Xe5saRH6o5iMro/t5a6lWnXd8iahhKnDMAwmJa6GFOL5KkVhKJvSdNJBftaw5WiL5mgGk3oov2aV+9sdoAMkiPK3opc9qOeUhXmNpRo7Q0rZ2cJvfQ02kY0sgW1+5qkqKM7SKlSnWfhQPRa6OY5U+/7m1U2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR2yUk3o2sX4BBmQ7DHwlK2oQyPNgPORTOHQUgWUWuo=;
 b=XbLa0MqxsUpFV0iknJolQd/+9bh0IYk/jChRujggxIc1LR2uaRbdBteCr5kkBntITcawElqSC6tBLb7sWBS+Zao2v/FlYCVWJweMMHRw9NedZWmeQX6eTtQpjfs3wQbWAmtkpgRlnon1KNaNIu6pqcf4cberebywxguYXBlQYFZl4FO6g7GsKCtDAoBmWbGiXb9kU8oHOpqfhzucmBJFTXsmVysqfxYlrwbdKsa5hpnS6NAyBCSFf0rvu5Cg6n2nDFD9DEAz07E8M1a7WQkJiYuwosA++d92ba9rQEAn3van2ds+B6h+DCMakZD1DAmmNgOAvFGVF8I9Sx0LSFH6uQ==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN0P287MB1048.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:143::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.28; Mon, 27 Nov 2023 08:07:14 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 08:07:14 +0000
Message-ID: <MA0P287MB03329CFBA3BB6A4E4F322F99FEBDA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Mon, 27 Nov 2023 16:07:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] clk: sophgo: Add SG2042 clock generator driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
References: <cover.1701044106.git.unicorn_wang@outlook.com>
 <c06130afb4bdc1890b4e8d29388fa6feef1f1826.1701044106.git.unicorn_wang@outlook.com>
 <81d421c8-bfd6-42b5-9da1-f067792f8f48@linaro.org>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <81d421c8-bfd6-42b5-9da1-f067792f8f48@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [fR3pS4hF/Iu54SRmBKeGOTf18NsVrMm+]
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <8d100c7d-6439-4b41-abe6-5a690dda9cbc@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN0P287MB1048:EE_
X-MS-Office365-Filtering-Correlation-Id: b91567f4-dac3-4402-1cf5-08dbef1fdd54
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3M4aB/2t2ClB/Vk+G8rjqfGhWDgGt6BWcGKiH4qKvJoyLj9FzICpVmPUw1W+TtC6ZR9nUnsmyVPsrnlmztFHO9Y7mrpebkgWxnMy8LEAqUSgNWzwozzKRQZ4M5xX5bgx4T7MlnbjyiEKTMFgp8eEn/lovPm8Fc20LaTQKn5VEi/9pgJX748oJ1Bm4EiC6GEoAqxjT1VQt5ImEZL+7s2q/vPa/Etlx7aTaFvB075qwT6ZKhepmmIblk/RJeojqLVhlWzwPybZBAQH++G6rnIH8aijLJhiIduF+WFALCnT3BSULAePin6vqmODLtWz/1t9Mz6MX+9eehe9dq2XkRMI1llf3k+2bldaQQBfEybSxoly1MvkSKHaCSzHEKbZa8YBGqgkEhuonNVZCAEf8UzFXyR1qKJ6B/UflepPR4szvEMTCG6xXPhnuZILwpSGtn9SBFxXJkvbDVqun7m5K94MBYbH05n9kCTFF4FsVfXMm7dJ16Ei27piile6unpz2VWAs6eqjVA4ntbDVEltpVaQtey7x8oPrug6KnnH8kyRqlbYiSpJZkW6HaIdCIX9kk/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnRYREdFOW5sUEhJVzVjYjlvNUliNW0vQlVEcE52YTZqWlN2cXlQM0xrUFpF?=
 =?utf-8?B?WXBiU0pCY0oxdnZsWGZKWXVhUVIrOGtESzRtbURXdldzNXRkK2VETUpTUldM?=
 =?utf-8?B?M0pENlczQU5JOGxWY2VmRWwrQmFsdGJGWjhyblJIN0h0NzBELzZyWjJIQUUv?=
 =?utf-8?B?UXhxQTlKTk5NYUg5RW5saitmRzJRQ1ZvS2FmTDVxdGE2R20wdVBreWsvUUxj?=
 =?utf-8?B?YjdNbnEyREtmWGR2bXkydTRMY1ZvenYvc0c1MlEzUnNMMUh5bTlZRGo0Sys3?=
 =?utf-8?B?N1liOWxYVnZPMEFqcHc2MHhXWEU5NnNDRS9JZWRnNVdSZHltRzY4dnVOcTdK?=
 =?utf-8?B?NXVRVm55K1NtVEQyTW9sMEJnUVp4cnJwVll1SkhUQjBZSTdIc1d3WHc5RUZx?=
 =?utf-8?B?VTI4bVNqMUVPNVh2WlRnYkw3T01ib3RRNVRxMXNXZmJiOURIc2UwS0RKT0c1?=
 =?utf-8?B?d1ZJVUM5KzdZSit0RmpnNWNjLy9VbVJhNko3L2tsenp5dm0rRnVIbW1lTGZr?=
 =?utf-8?B?MFhka3R3RkllZlhzNC81VWgwUHZxNHVLdGpob05jVXE5Q2gvNHNJSTFCL1FB?=
 =?utf-8?B?MEp0d3FTYU1SbnRnUHplUmVQZVVNL25nQTdQTnlJSnd3N0RCNUFzaGpYdEx1?=
 =?utf-8?B?cWtHNldWdXJGeldNMjdDeG1CM0xpeWtkNDBrRktxbCtVd1kvOTV2Vk5kbGM2?=
 =?utf-8?B?RmlDVjd4SVJVVWZmL1ZpVnpaYkdpWDBWSHQxRlpBWjZoaDcrNFZRTENXWFZT?=
 =?utf-8?B?REFBTWNGbFB5MXFSaHI1cDNveUlWSWtTaEx2RkR5L2Y4Tk5YQklsS01YZmRu?=
 =?utf-8?B?WjZkaEZ4U05ZdWthQUU3UVlRaGtFNklxRWdMMGdqVm9xdEhNQTF5MjZzQ0V3?=
 =?utf-8?B?dWZHdTVHVUREY2o4dmJ6cWk1ZGhSbVJrZVMyeUttd2pSZm45RlFkRVo0UitJ?=
 =?utf-8?B?Sk5iVHY3RWRyQ2RsQXEzMytKZTFMSllQMlMwUFFsV0swTmlodUx4blZ2Y1hU?=
 =?utf-8?B?NFRYbmxlM0pxRHBKa0I5d1VmQXhrakw3eG4xaWYveDE5NS81LzJjd3pPS25q?=
 =?utf-8?B?c0RIYmptUHZvWnlkNWF1QmVVNS9WRjJLcU9tUzVnb2FHSnZVTk1kSU10ZEFy?=
 =?utf-8?B?dzBjM2Jmdk5ZUGtrTlYvTkR6eWhOL0FNa09xUFJ0aExVeTFnK0NObThXb1FZ?=
 =?utf-8?B?UjVtYW03UFhnR2RmNksvWTNyV3pzakFmd1VHQS85VjR2d29ERy9UM3U5L3dp?=
 =?utf-8?B?bjVtNVNnbHlFc1k0RTg1Q2tTdzFjNVlkMHBMck5CMXRvcms2T00xQUNOdUJO?=
 =?utf-8?B?eWF1U0poOHRXNHEvK2Nhb1NKaDNhckNIUHpjQnRwdHlLMGV2MXF6NllhR1NS?=
 =?utf-8?B?Sk1SL0sxRTZrTUpneEtrWUV1WncvaDVSMExEalNpbXBVdkRoYStYQzFuS3lO?=
 =?utf-8?B?WVdBNHZ5T29DWUMza0xwbVBaQU5DSDFwdGhVWlU2cjBNVkh4VkI3aGdtZzV5?=
 =?utf-8?B?N0Z2VnhrU3pxWkhiMlFKaFNORVJ3RzJXdUVuYTdBVTB1ZGhZcExkR2xYeVpZ?=
 =?utf-8?B?K1B3RG9RY0FWTU5UQUR0aVlWcEMyZHdpdDZoUVhnNGxSME1yZDBobGNQUXFn?=
 =?utf-8?Q?AiA419N0tpUsbCTM1sUcc7YAv1eCwOfzA3e2iB8Gphmw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91567f4-dac3-4402-1cf5-08dbef1fdd54
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 08:07:14.4990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1048
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/27 15:12, Krzysztof Kozlowski wrote:
> On 27/11/2023 02:15, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add a driver for the SOPHGO SG2042 clock generator.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ...
>
>> +static void __init sg2042_clk_init(struct device_node *node)
>> +{
>> +	struct sg2042_clk_data *clk_data = NULL;
>> +	int i, ret = 0;
>> +	int num_clks = 0;
>> +
>> +	num_clks = ARRAY_SIZE(sg2042_pll_clks) +
>> +		   ARRAY_SIZE(sg2042_div_clks) +
>> +		   ARRAY_SIZE(sg2042_gate_clks) +
>> +		   ARRAY_SIZE(sg2042_mux_clks);
>> +	if (num_clks == 0) {
>> +		ret = -EINVAL;
>> +		goto error_out;
>> +	}
>> +
>> +	ret = sg2042_clk_init_clk_data(node, num_clks, &clk_data);
>> +	if (ret < 0)
>> +		goto error_out;
>> +
>> +	ret = sg2042_clk_register_plls(clk_data, sg2042_pll_clks,
>> +				ARRAY_SIZE(sg2042_pll_clks));
>> +	if (ret)
>> +		goto cleanup;
>> +
>> +	ret = sg2042_clk_register_divs(clk_data, sg2042_div_clks,
>> +				ARRAY_SIZE(sg2042_div_clks));
>> +	if (ret)
>> +		goto cleanup;
>> +
>> +	ret = sg2042_clk_register_gates(clk_data, sg2042_gate_clks,
>> +				ARRAY_SIZE(sg2042_gate_clks));
>> +	if (ret)
>> +		goto cleanup;
>> +
>> +	ret = sg2042_clk_register_muxs(clk_data, sg2042_mux_clks,
>> +				ARRAY_SIZE(sg2042_mux_clks));
>> +	if (ret)
>> +		goto cleanup;
>> +
>> +	for (i = 0; i < num_clks; i++)
>> +		dbg_info("provider [%d]: %s\n", i, clk_hw_get_name(clk_data->onecell_data.hws[i]));
>> +	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, &clk_data->onecell_data);
>> +	if (ret)
>> +		goto cleanup;
>> +
>> +	return;
>> +
>> +cleanup:
>> +	for (i = 0; i < num_clks; i++) {
>> +		if (clk_data->onecell_data.hws[i] != NULL)
>> +			clk_hw_unregister(clk_data->onecell_data.hws[i]);
>> +	}
>> +	kfree(clk_data);
>> +
>> +error_out:
>> +	pr_err("%s failed error number %d\n", __func__, ret);
>> +}
>> +
>> +CLK_OF_DECLARE(sg2042_clk, "sophgo,sg2042-clkgen", sg2042_clk_init);
> No, this should be platform device. It's a child of another device, so
> you cannot use other way of init ordering.

hi, Krzysztof,

Thanks for your review.

I don't quite understand your opinion. Do you mean CLK_OF_DECLARE is 
only used for platform device so it can not be use here? But I think 
this driver is still for platform device though I move the clock 
controller node as a child of the system contoller node. System 
controller node is just a block of registers which are used to control 
some other platform devices ,such as clock controller, reset controller 
and pin controller for this SoC.

And I also see other similar code in kernel, for example: 
drivers/clk/clk-k210.c.

And I'm confused by your input "so you cannot use other way of init 
ordering." Do you mean "so you CAN use other way of init ordering"? 
What's the other way of init ordering do you mean?

Thanks,

Chen

