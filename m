Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2725079C96D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjILINl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjILINg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:13:36 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C24E73;
        Tue, 12 Sep 2023 01:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kA9AGRJdwfvzTaXO1kominaO8ZDU/lvmnRVU8/nM3dKY003JOaQH7XwOtCa/AhLONZ74gmkS5s3yKoi0Av80/d4oQAji22GoP691gVyH45xK/4EXgUIsYMjqQ7sqb/Fw4Qjxfi4a4MONOKVTAMsuHAo0RYxJijgEy3vMp4Bv2D8JQwBg7o40FuQA9aTBAlCwrBWdmIul3S7DNhokTMUDOQpNNPQK9lLqslgIRzQIOXV+pnNy151SwwNxh6q+pIOjNV6hhxRaFIgwQF54PJkSzyEsVic9/wHZkYmoqo9Pzv9ZkGYHGAKbD0+BJHqCaqxfaJC8s1wQtzsXLnLXf5GTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52kiePSq9v/6hi02XFy64VcXhAUNfO8paOmy6OMLYZI=;
 b=Rw3tYpuQnSUP1piAL8GD3QVOxS/pGXMsUQOitNWlwYte9fAxGlGhaY1H4zDLgUcclZ8BnIGL55KBpZdza2Wn1JwenUwE/ytKHnMc/IAKnSk57RTBagy8xWdPZoJB9tIomK77gR/dXUe95plbuEl9Nj6m4LUyqlZOJ3VI/m75tq9zcmxdrFtW/5C8YlRTncxozewMPI76I3iPJEJK4KNPLFqtSjMMLbdVYbMTxbolLswQ5TDDPY7bwQdOpbZIwd31FYYt6x2oeWhVRKEtScyKsjUhmNWTb3g10O72BOrVq0yXMzq8WFGBEdApJBbhZBqPNS0HVQ1EH7HkvJMhV6GyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52kiePSq9v/6hi02XFy64VcXhAUNfO8paOmy6OMLYZI=;
 b=VSYZoHPofZzp7J0k+Eu5f6ITA/pnuOBIQPKAIiw5/64rKZzmRQWyALPP8uX6RaY3rg754nqZ1VDrSSQRUrSOKCm8j9mZxarOn97AlbW3oYFdC8zZVVJq2MrVY7x2UhgYJAe4gOCJdolRUhNzlYvAsCor56kndYV5EGvSvgAU1uM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by PAXPR04MB9124.eurprd04.prod.outlook.com (2603:10a6:102:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 08:13:28 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 08:13:28 +0000
Message-ID: <c0b32f41-46b4-81ad-9718-5f0856e42cb1@nxp.com>
Date:   Tue, 12 Sep 2023 11:13:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
References: <20230911224452.15739-1-iuliana.prodan@oss.nxp.com>
 <20230911224452.15739-3-iuliana.prodan@oss.nxp.com>
 <67de5706-d966-dd71-85c3-c95bc1b72733@linaro.org>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <67de5706-d966-dd71-85c3-c95bc1b72733@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::7) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|PAXPR04MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 33faebbf-6288-4714-4b54-08dbb368250b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbyWEVvd7uhtqpnOtaGmVcV9aMESEYJp6StLPorjA3pJRjtboQIHTSY22c1ycPfcQ1hGNuiU4KVHTY0wyZXlG6itSwkWMLs5xQuumyUs0TaAaLIFAh8c7YhAuwqeAIi3HAxIdx0aykURLQOzXCrPE/PihxuPUV1rWQjaVb/q+6/MxedojU2PlhK9ey8lwSRWjNtEhp2SotEW9zfvEMocetJTT/vUtZl44pp7DJm2kuevtFGqkcz1m4UAeGgVx7yKAVv3nDE3XGwvyDjb6IBdQ8o4EydZYXk500z44ZvJ9dbptfo8BKAx2sefgRfoskznfjiG6pYnghUz54Mia7oTwrJD0Jec0BjLWVJDnzw0zAXxZcI87hOTgjmyw7X51s4Bajk/1DAYXdYTlYUB1fFV8vLHp3hnbR487QQO4LeoRl7voHvmhE0UjzG3olABznGBWXRKrWkcAfOfEBhLkxo3UbETCGBPuwu3biJT+RYodYyGirUSzLI7NaAQqwBBv9bhkmo6Jxd3XSH/XySYSE6QhluEHe0TuabgH/fcHORJYWW2ypE/V1NgwSSnAMQwPrlYEzFnBzrPmFKlYliDo0EDuIL0AMXJHPbExTZuIMayP9F4ylikFeHJZlMNYFkIWQxetXJpkPRbEObfNP9mjH+djR+Uw9IEQUowtvOpX9PBLfuXqRKahAtjNO+mXJFxIQ0K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199024)(186009)(1800799009)(5660300002)(6636002)(44832011)(66946007)(41300700001)(316002)(8676002)(8936002)(31686004)(54906003)(4326008)(66476007)(66556008)(110136005)(6512007)(478600001)(36756003)(38100700002)(6486002)(2616005)(7416002)(6666004)(6506007)(26005)(2906002)(31696002)(53546011)(86362001)(921005)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmRJdWdNelpMR3IzWXVVTi93MnVhem0rc0QxazRibkZ6RWNlMkpiTHViYThF?=
 =?utf-8?B?SDdpUUY2eHlTMzBSZExrdmh2VkdhdW9KZGkzVEVLYzN4VFZkTU5IelRKOXVa?=
 =?utf-8?B?Tzk3alFJYnhpeGVtOUFObGFzeHhnR2tLZ0xDU041ZjZvck1BSVVqZ3FOQmp3?=
 =?utf-8?B?am4zZVQ5amg1Mm1WL2VaM1V4b2ozV2ZhTThENDc3ai8wWTFwL3doTkRuaFJ4?=
 =?utf-8?B?c2ZIWHBGd2hBMGlkV2ltbEFVR04zL2kyaTc2VWphSmdTcGloK2JBNWNFV0NN?=
 =?utf-8?B?d1ZjUjY5bTBwR0k2QkZTdzJNWEp6RTNhelBkTUN1S3BTRU05VDRiRU1FVTNh?=
 =?utf-8?B?Q1p3UFhpaEJvOHNFY2gvWmVueVN6Um0rd0c5MENmOENScWJ0UjltZzFJalha?=
 =?utf-8?B?VDduMCs1aDRwaXBFRlZpcktCdWo2QVVPQ1ZTZVNISzFva1ZGeTA2clYrT0Yx?=
 =?utf-8?B?UFB5K3p4dU9QeXE0ZENCbHNFMHBja2RNdHpucUppMzVrZ0ZwQy9HNGZZS3Vv?=
 =?utf-8?B?eURPV3psWVR3K1hZdVd1cVM2QlVJdHNKdi9FS243U0N1N0d6KzZJV0luL2d4?=
 =?utf-8?B?M2RNeXhiUnpSQ0dVM1hpUGUrUUZ5bkw3MWJXaVdUMTlZMUJ5N0dmWlg1dlp2?=
 =?utf-8?B?UDAvNTl5QXNXaTJZTlU1bmtWZkozRE9qcWVEUUxWVE8ra0RveXRsdEZCempj?=
 =?utf-8?B?d1ViTDEwRzF6TElRaURkZkx4eVByM2ExbkI4VGlxOGVsVEh6bTZFTkhsYUV5?=
 =?utf-8?B?Qll3OVhIdlFieENPeE5QYXBoUmxXb0FHZ2k1M2RrUzlrejU3NVlON3hDUGVy?=
 =?utf-8?B?cEphNUVzUVdNN2UyV2tVTjViallobVhrc0VoVGpOSWtMc1A3THNIUFlJQU5j?=
 =?utf-8?B?NnUyUVBjSUZXMXluVytYcG9lVzZRZ0NFMFdpeHF5NnpLWW5vZ3FNS1RvSW5o?=
 =?utf-8?B?VGs4UWE0UEhuVEFYL29SbGFIeWw3bDYvaFc4M21BbENxejNwRzBQaDZlbDE0?=
 =?utf-8?B?NUZEd29pT0ZyVWdvZVVmVkRkVXV6ZmxPTTQrUXp3N0JjejFoOTBrRzVSV0xm?=
 =?utf-8?B?VUFtbmFQWHpGUXBNUjdOb01Ba1NYSnRmNVdIcTFla0ZUNk1wcVYreUJOdGhi?=
 =?utf-8?B?OHVhVk4vUEtuZW0xbGh5NnhLR1JQblJPVFVCbU1XV0hieFBHQi9hZGlpT3Zo?=
 =?utf-8?B?akxvUStkUjFWNGhZOE1FZEpQYlRjYTJSTDhZL2tSK0tTRC9GMHQrSVFvUUdV?=
 =?utf-8?B?R0R6dUhjUDBLN0x0bU9sZnVQOTdsRTBQQTdHd21VR0NRbkc2RnIwZkNKT2pL?=
 =?utf-8?B?ak40RXRkWjRzODZvZXNRZllIc2FSWHdkalZZT1ZNaWFRSFB1Nmx6VlNuUUIy?=
 =?utf-8?B?ZWpxVzFYTXMra3g5QWVWdmNpY3hOV2Fwa2MrU1VZYi8xd2JGUGtDazBucnBY?=
 =?utf-8?B?OUd0VEFoSjlIcS9sS1FyMkNodHhjNmRLUlAweENyUUhKMXlYdkVwRlFhMG1W?=
 =?utf-8?B?L2k4ZWZKSDlqZWxYbzJYK1lMN2doRjliQkVaVEFPcjZSamJwdE9EdjJzWERv?=
 =?utf-8?B?U1FVR0VsMmlvejRNcUhrQkkvelRjV2tlRzZnVDMrenc4czk3Z1dZUHlCelgw?=
 =?utf-8?B?aDE4ZElMUElyc1AvUWdJTmp0L0JlN0daR3B3c3BhdHZ4MklITTZZWEdlUlNS?=
 =?utf-8?B?dEE5STNvdzA5UkUzUkt6RmQ0LzRBYWRBbnFvMUorTjNBTlY4QXdWRTdqemxo?=
 =?utf-8?B?bUNaQVFFRXFmbW5QNjAvOWIzOUI0VlFvL2ZsUGQ1TnNteVpkZUZzTldQNlF3?=
 =?utf-8?B?Mm1PWVpGVXBlL0NVSGZuZGtMQkJERFNJNWNQOUw0dXRTM21HampYaURPb25U?=
 =?utf-8?B?Nm1XNCsyWXdLTmpDTnhDdkg4SmJIQ3U0Sk9rWk5kT1FGLzRDZlpoZGJWMnNp?=
 =?utf-8?B?WHNnRkJhOGl0M2R3UW41UUtvZUlkL3VUVWI5dG96UHMzbExrOW1RajZqY3hS?=
 =?utf-8?B?Yk5ibDI4REgzWEw3d1VNSTArK3hJTDZ2ZjRac1RQd0s2SkhnSy9xSUxmamxN?=
 =?utf-8?B?WFRJRE1tb0JVMWFQK25DRTRZeEs1eG8veXozZm1TeEU1SDVGOHIxUUZnZjJk?=
 =?utf-8?B?b2c1ckxkZDlET1dkL1BISHVFSldIbEZyM0I0OFU5Ym1GWXEvM1V4akMzbjlp?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33faebbf-6288-4714-4b54-08dbb368250b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 08:13:28.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWEuBONmXhXZafnm6uqLNbDC0NOeJF/oJUZNGZiNxy3pUZiTJUEUFmnfHe/Cx4W+xhPoR2T/NVA7iuqFnhn1Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9124
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2023 10:07 AM, Krzysztof Kozlowski wrote:
> On 12/09/2023 00:44, Iuliana Prodan (OSS) wrote:
>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>
>> Add the reserve-memory nodes used by DSP when the rpmsg
>> feature is enabled.
>> These can be later used in a dsp node, like:
>> dsp: dsp@3b6e8000 {
>> 	compatible = "fsl,imx8mp-dsp";
>> 	reg = <0x3b6e8000 0x88000>;
>> 	mbox-names = "tx0", "rx0", "rxdb0";
>> 	mboxes = <&mu2 2 0>, <&mu2 2 1>,
>> 		<&mu2 3 0>, <&mu2 3 1>;
>> 	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
>> 		<&dsp_vdev0vring1>, <&dsp_reserved>;
>> 	status = "okay";
> Drop this example from commit msg, useless and not really correct.
Ok, will drop it. But this is a correct example, is just incomplete.
>> };
>>
>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> index cc406bb338fe..eedc1921af62 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> @@ -210,6 +210,18 @@
>>   		dsp_reserved: dsp@92400000 {
>>   			reg = <0 0x92400000 0 0x2000000>;
>>   			no-map;
> Please test the patches before sending. This does not build.

I've tested on remoteproc tree, but it seems I missed a bracket when 
sending upstream. Sorry abut this, will fix it in v2.

Should I test this on other tree(s)?

Thanks,
Iulia

> Best regards,
> Krzysztof
>
