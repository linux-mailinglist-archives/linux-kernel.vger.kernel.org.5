Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD39758128
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjGRPlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjGRPlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:41:01 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769CEDD;
        Tue, 18 Jul 2023 08:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWY3/RpObjawJOezDAKkEGhC8rAk/vut4kEKDoFXTQfN/8ZKoyabbJzES5TICELAOVbOTajOVCduym8mql/TLXl6YpFqhJvvtqgjuK3OpO1B21ZvPPkZZIO3d27YO9tNTSIsRXePdoUDHHrasOqG2wd0/TJhWyWvj+ZGWlr+uh0IquDQnwEhrEK6klBZCD4ShifCj+yvqDN6vaqP9Prty2VPQChu7Yf2MIOc+dRz9A5JW09oPhY3zjBmmCPoHmGoNnDBX73FxJn1CeMdKjy62BMvUAaYf10/bIFZfcyzd5IBGWiWx/w1dmkFqNexpYyJmC2hHOELEJDu2o5yrGqm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jG7CTn+1t4UFxt+pm9emW0cq48h8DO/l5TMegM506Vw=;
 b=ZFZMCGYU02wWdTzF8P7wbv0Qh8l3J51HoJKTvV8dD20jdC5J/cXVyoe6pve0v9rHEAm9po386anLVk2T98kz9RlF2pcH0UIZBPwZjdc0pMkIIBb5Tk1InrBfVstdKIceDt/Ykszx66FiNmfMXM8dztKGjY90kHPq7bvXoTit88TQoj8t2dM4aWocJmbNUZC/QKSuc73fBWxdRKVIT3ZhPJJ5u9WnOmZoH2X1uNb1JbSc8uRkPtZ5fvngzZD2JPGWP7zh1KW8suDG1CPdcZ0c1JfUxX+FCYtf/IMyovsUUjeTfxVnMbAcU6FyDgFcJTskMkgNO5GYGNvIjusRkr+WqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jG7CTn+1t4UFxt+pm9emW0cq48h8DO/l5TMegM506Vw=;
 b=le+Z0Ruh4wVQ2ZOf0q2zDxMpErMRYae3yMymsbvC+riByjW2FpGeWQNLpZLwT7vsXJYaglCKPKAzKbLfZ2NDL4q9UARRf/2qUwit3Rnv5XTsKxxpq1prn7NqAj+6F3ebQ0sx+s5N0f0MLyZKmVM9ygVT59GqIHmoLQ2qzwEAFyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by AM0PR04MB7155.eurprd04.prod.outlook.com (2603:10a6:208:194::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 15:40:56 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f1e4:90a0:aabe:ac23]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f1e4:90a0:aabe:ac23%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 15:40:55 +0000
Message-ID: <03d7c703-81cb-20f9-aaf8-2ab8ca3e7138@nxp.com>
Date:   Tue, 18 Jul 2023 18:40:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] remoteproc: imx_dsp_rproc: add mandatory
 find_loaded_rsc_table op
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>, linux-imx <linux-imx@nxp.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
References: <20230712224220.26430-1-iuliana.prodan@oss.nxp.com>
 <ZLV9gAmiDldlvIUR@p14s> <474c0241-a58e-b435-8ac1-82a5a458d79a@nxp.com>
 <ZLauY85b9SRC3z0x@p14s>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <ZLauY85b9SRC3z0x@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::20) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|AM0PR04MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 0376dcea-3068-4a8f-7979-08db87a56032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +G7h4PjTMlXKC6KApQkd/JOEiqPX6uApsGY9QRV+acf4jBdZcFgY7N7USxK1HK9qEWaHzMrrqHt3GKdoSM84ytkB4SIp3LFKVX7P0t1k258z9osMNpD3SPJzfH6L+rXOhhoLRQrfQfVdF0BGRtQneA5yDTpHbeFMo7tsZI2/DLWgz86EmjkN2m3U83/VPFRBfWcAyAo/XlXgc47To5F86mYRBdNQBV2bINbH6vDTq53my6m9fqm7c1iwhlYnqMZpnfAY5+5SFhJI0TiyltuTQGaa0fCy0Uk6Y3Krfn+rxy6awJXhcS4RDZ7lEmTF0WJNrLsF8DDUnuAIj9EsCZccRNIC94M4KA/SHBr5/pw4TlktGnzWlb6lndXWf/4k/F1ohey2VbIYCcsOtO5zQkwJ1xt0xQhFIUVW4f6MNQjwXlMXEz9rTom1X2sUxFr0A4UoAZHna7wWLW/wrXKbL+Bcv4705EeBB+Qr8MXQiWgyb4zjgsb8uW0dwyVLhTyVz8NlR4fNpskTzkcDXhWwBEevieWKk4KUvNifggmBCaNqGrbm+ps5IN5nUTyMUNwNLPH4McB03sIc9onjC1bKnFgg5tsqOyKmeiWLs84MCKVCivFEEjB/y/D4570jQod2ejmNaV9Obv+gCuzbEvczSiZ8jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(31696002)(8676002)(316002)(8936002)(44832011)(66556008)(31686004)(66946007)(5660300002)(6486002)(4326008)(2906002)(478600001)(26005)(6512007)(53546011)(54906003)(6506007)(41300700001)(186003)(66476007)(83380400001)(2616005)(6916009)(38100700002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm9PRVhvZWJsVFg5S2ZPNWhTR1MxUUJUWXZNL1FOdnh4R0JvNjlHQjVLOFFG?=
 =?utf-8?B?VEZZMHhRT2VMMjE1OHAyYkhvL2tqV2gvMjhzR1hyTm1rck8wTEM5SDZsRldF?=
 =?utf-8?B?ZTZWTmd1N1B2QVhOOTJ3ekpnNlN4Tkpid0ZuVHRyUVlzZXgvL0VUTjBTZ0x6?=
 =?utf-8?B?Z0N6NDBVNmxIVzdadklmcmhYcFRNWGpSek9QMEYrSjQ5ZnFIRWVNNitZai8x?=
 =?utf-8?B?ZFczWldOMkFoblExbFVkSmVWdW5SSk1tZWgyVDRJYWlJa01JSDAvdGN3V3Er?=
 =?utf-8?B?S01jSno0cHh3SDRVekhPMURrbjNHNVBJdmZ2WDB4U0trUjZwUk56eFZDOFBa?=
 =?utf-8?B?L0Z0eUNLUFNWeTk3WGUwM1ZDems1TW52dzZEUEdyQkJZUVNHQmxRQy9HaFpG?=
 =?utf-8?B?KzNSUFBUczM0MVJpZXZGdHY2TFUvUXozN0x2Z0VpS252MDJGenBEcytPa0dq?=
 =?utf-8?B?WkRmZ1gyZkh5ZE0ybWFxNlhYUjhVZmdaaHZVQ0hqSFFVVWI1ckZsUmg1M09x?=
 =?utf-8?B?SjRJUTRDdDFIZlFhejJHaDk5MHRSK204dk9jTFJqWWlLTytBZ0F6R1pTV25u?=
 =?utf-8?B?Q2wwcXBZbTZXS2U5bmVBbUF6NCs3bDlYSWM0RzFTUzgreWhYdUlheXFsYUVB?=
 =?utf-8?B?dzA5V2tQd2ovTlViT2ZGWGtBMVR0LzhKR1FKQ1pTZEF1ME9oNHpGVXNNenZt?=
 =?utf-8?B?K2FGcHNCcmxSclBhWVJhUzluNE9uaVJBNW9CdzRnZkMzaFhaSW8rbFRXODBm?=
 =?utf-8?B?RW9HVk83Q2hyMUVPTHZVb2xsT3NEMkhNdlVvQmk2c29Ba2o0TDVsRjBMbEo5?=
 =?utf-8?B?QXorenBvKzNvTHdFbjlSc081WVRRNGI3ejNYQzYrdzJkY2tyU2Zya3AyQ3Ro?=
 =?utf-8?B?VExCazIvTDQwVTZHRE0yMVZQQUZXQ09sS1Nha2YvZ3FYeXg2MWdFeUNlT3N5?=
 =?utf-8?B?KzRMYTRKL2FwTE5HbmFibnB6V0dDb3FFTUR1MGwwTnU5OTFITTJaV01HZlRx?=
 =?utf-8?B?Rm5EOEtWSnBXNHBwZFE1dWY3cUpzWVpYUk5iNkZXVW1oZUtRc1dOcXF3RTVa?=
 =?utf-8?B?RlFTemxGSmF5NzN2YmhTUGUrZlp4QnNIYWo4WExTeXdDQkl0bWdmWHR0WVRO?=
 =?utf-8?B?VGVac2FodG5HSUJvSkFGRnI5dlgvYUNuRi9hWkU3VW1pOGl5a3hSek5BbTVl?=
 =?utf-8?B?UG1HZUNlQVRveEVIcEJXZ3VEek9kT0VCZDVFbkF4eHlYbWY0ZWJrck0raWl4?=
 =?utf-8?B?NWNqdElsMHhOTmlFaHl6YUFueUlwcDIzUUdzdFFzc2YwNTB5Tkd4eDZYN09s?=
 =?utf-8?B?Mm12cnRDazRRUzNDcGNNWEE4elpUWFp1aTJmeDJXc2hqSjcwY2lLT0ZXQVk3?=
 =?utf-8?B?bVB4WUZBQXFVUEdUUFZTQU4ybmJTekpyeWxoR0FIcVpCaTFja1c2Z21mS1Rv?=
 =?utf-8?B?dnFUWUlKSUZXWFZzYlVSUzZYY2s4czNIYlJuYlRTdDV3SWd3Tnk0a01ZcEU2?=
 =?utf-8?B?OXlNQ0RsVjFRclNmTnRMclNUZlpJTi9PNnRwU1NGamJUTmIwOU5GZkM1a2ND?=
 =?utf-8?B?QlhsNjdEZkpQRGcyaThEWmZPK3ZzbjFhdDd3RnFibllPbk1ZbkJrbEdYQVg3?=
 =?utf-8?B?YVZHWHZFOWsrRmFicG1LcmJra3g2NFl2bEJ3aVJkdE1IWmlXNVN3bkNMS1FG?=
 =?utf-8?B?MkpOdDR5cVVtOWNzUHlzY2hmZWg4ck5yQUxZNE9xcWN0Z21oRDdtVmxzNHJ2?=
 =?utf-8?B?WDlYMWlZbnVpTW0yeU1sMDRNbkZpTnFVNUtpSE04dWdoVFNsY2MrazlUMU1U?=
 =?utf-8?B?ME9VeHRuNSsrVEdHUy9EUTFjR3RIOXI2WGppZlFaMmptT0NuL0J6UlNERnFL?=
 =?utf-8?B?L2p1UWdKVlprcWNtWmllc3hTOEpCaHFVNE82SFpCUlFuVTR5QUNDZHdFMEYv?=
 =?utf-8?B?V2x6T0h3Q21rMHVFakw5R2ZoanlxS1lIdE9DVVFveU5wYjYvd09QWlJFMnF6?=
 =?utf-8?B?OFpaL0x1SVd1ckhoZUUwTDRHZC9oQWFwTGhBRHRXZ1BYZkppa3F4Q29BajRM?=
 =?utf-8?B?a1lkT3hDWHRnSWdrNXozUDZ3UDM1UDFYVUdtNEpOMWI1bTRySFVjVlRRL3da?=
 =?utf-8?B?Ni9sWjZxYVowdk43UU0xa0Fwbkt1TTFtdmNLcVlrUW1GcnY0cDd0RFJGT0hV?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0376dcea-3068-4a8f-7979-08db87a56032
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:40:55.9128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sbOgcP6To/F7hmKP0OCqQ3mLfHj0XNbA9iw2fLGFu4BaqFhWM8SFegqY+odvKCa+ihy+tTt8MGh7XOnY7NwVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7155
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/18/2023 6:23 PM, Mathieu Poirier wrote:
> On Tue, Jul 18, 2023 at 11:25:03AM +0300, Iuliana Prodan wrote:
>> On 7/17/2023 8:42 PM, Mathieu Poirier wrote:
>>> On Thu, Jul 13, 2023 at 01:42:20AM +0300, Iuliana Prodan (OSS) wrote:
>>>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>>>
>>>> Add the .find_loaded_rsc_table operation for i.MX DSP.
>>>> We need it for inter-process communication between DSP
>>>> and main core.
>>>>
>>>> This callback is used to find the resource table (defined
>>>> in remote processor linker script) where the address of the
>>>> vrings along with the other allocated resources (carveouts etc)
>>>> are stored.
>>>> If this is not found, the vrings are not allocated and
>>>> the IPC between cores will not work.
>>> Is there a constraint on the system memory the M4 can address?  If so there
>>> will be a need to declare address ranges for vrings and buffers in reserved
>>> memory in the DT.
>>>
>>> Thanks,
>>> Mathieu
>> Hi Mathieu,
>>
>> No, there is no constraint on memory.
>>
>> We want the Cortex A core to communicate with the HiFi4 DSP.
>> The Cortex A is in charge of starting the DSP and loading the firmware in
>> HiFi4's memory.
>> When using rpmsg for IPC, the Cortex A needs to find the resource table
>> (defined in the DSP linker script) and this is done using
>> .find_loaded_rsc_table callback.
>>
>> For the DT, we are using a (not upstream) device tree where we have the
>> reserved-memory for dsp_vdev0vring0, dsp_vdev0vring1 and dsp_vdev0buffer.
> That is the part I'm interested in.  Don't we need the reserved-memory entries?
> Otherwise the M4 may not be able to access the memory chosen by the application
> processor, most likely leading to a crash.

This kernel module (imx_dsp_rproc) is used only for DSP.
For M4 core we use imx_rproc.

Iulia

>> Iulia
>>
>>
>>>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>>>> ---
>>>>    drivers/remoteproc/imx_dsp_rproc.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
>>>> index d95fa5586189..b5634507d953 100644
>>>> --- a/drivers/remoteproc/imx_dsp_rproc.c
>>>> +++ b/drivers/remoteproc/imx_dsp_rproc.c
>>>> @@ -941,6 +941,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
>>>>    	.kick		= imx_dsp_rproc_kick,
>>>>    	.load		= imx_dsp_rproc_elf_load_segments,
>>>>    	.parse_fw	= imx_dsp_rproc_parse_fw,
>>>> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>>>>    	.sanity_check	= rproc_elf_sanity_check,
>>>>    	.get_boot_addr	= rproc_elf_get_boot_addr,
>>>>    };
>>>> -- 
>>>> 2.17.1
>>>>
