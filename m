Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEBD791F86
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 00:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbjIDWbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 18:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbjIDWb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 18:31:29 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2078.outbound.protection.outlook.com [40.107.241.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985EAAF;
        Mon,  4 Sep 2023 15:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOpzzsJvlIme1AUpKOh8BmXaucTbWUXBau8/uYioD4VVo/xAqWBnuh4ceBiJCGWtUMkgTgS1k9cAdSX4bhjliBsJxR0YUkSQY1bTWrWRWxn3Hr1OPd3jbqAo+Sz9fVlysgBuLCHnlOv8nQM08skIe6Z6lj8e2Xb4GUoongO8vqtiULzQDnN9DwB5FbximolRTzROZLAnjJviuu8QRvGZdKa6SZfbsh8YwOqcqcMIkgIIL1ew2QBltfUCr8Kon6O5LQr11f+u7b1CauUCwMMPSPRt6pIRk7I5p5OWUocJf6cfA1xu/3kxibpGLugaHjYh4uue87d1SQ8QvzDl7BXXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx8eMzmpd50MJsMMsM3TVvAeIcOznZC+1B3IKthx8iQ=;
 b=DpTn93ZTmekGIaOtAFriSUGdhC4WHjHnZRHmtCArDdqsERrT86GidVb3xgsKv2LQfsJRd3Zd2L46XeQxcrdYWeB9gX5a82wMA+Ot3jZe39BdivgUaDJTYW8/JaEt0Fd1GTeNmezVF7WJBeBzbl4t7nE09dUkb6qu4X9WnyaUgYliFAbVyUYeZ+3dy9v2M7QOcmy4XobbSJbAidibDrHRyWzHsEWTt9zH6qCh4PFYeFORKmGctCWb1U8aflyS9SRRteCC/GhnQP2UPz9r3k+0PGRPX33i/nx0e7te36DHVuRwhFZ7Yh5fG9/0Qp8QMLqW7fak/caEMGKvk33uUCR2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx8eMzmpd50MJsMMsM3TVvAeIcOznZC+1B3IKthx8iQ=;
 b=bjeQE+Uwz6Wkiha9omr6HYqSfcUv4GuaEV3JgThbkb8VRV/6TLDdKlZyZHjR1VkZ96t1yGFv8OHHVXwYeqiXlYCO8vLrh1XVV7rbmTne7wx+XqnK81Yy9f+S0Up5a8t7Lzk3WEI9evihWowYyYJhe2qFxdG1yBURmPKtPsWN2E0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by PA4PR04MB7693.eurprd04.prod.outlook.com (2603:10a6:102:e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 22:31:22 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 22:31:22 +0000
Message-ID: <132d1906-fcea-729d-e226-f3c70ad4090b@nxp.com>
Date:   Tue, 5 Sep 2023 01:31:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] remoteproc: imx_dsp_rproc: add mandatory
 find_loaded_rsc_table op
Content-Language: en-US
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
 <ZLauY85b9SRC3z0x@p14s> <03d7c703-81cb-20f9-aaf8-2ab8ca3e7138@nxp.com>
 <ZPZJLJpL+f9nB1cn@p14s>
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <ZPZJLJpL+f9nB1cn@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0034.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::12) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|PA4PR04MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 61bd43bf-b156-4df3-093e-08dbad96aa67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4q6bIKU7oiyYdghEMWYoMgrfvaAaWXLrYkEg0dCrs003my167qVmBqiMmzmvJAJAAtURYqQYZrFrK9Llf2MMsLlP1y2tBgS8viaRqpYamh1PyLpc8MV09YHS4t7WxXAT0c3wYwXRp0irSI4ONxYcN7pm2N6qTB7hr+uvaCUHUKqydxzAh8MDHOUSjq2yeZJJWuovVT5zzbak1zQvVZ8yaHb3/QdF+Tnuyh3yweo156GDkuYB2OpMzRXcuQpUDaZN/31ePWf6BYLJ4n8PHjvs+536fjmlOz6d+BZduecSvVEbvtQOIujNH/KcMGBsdFFh+BasDqcxT8Z1fJb3Uo7T+xzSO+dYQwdE9/Fswi0dzLmaV+TWw2IVsXs9ILHcyTMozWRxvJGa8eAdmmSPNdiM8B4HoEfugGcLzOTdszBGx3hf0jx2pWKdaDceXifHq1fi11obGEfUARGu80+83NbxNH6vyG0S3Y8ynGC+9ff9cL7qV+HNOQQjdd3SR7ARfLEyRmDmbSYsO6mdHI/LIyfyG8fABTuhmqW9RcmhBpzG0gb/Ksx0OEFDXPUvfi4o88CvCnzPkqtQywRmLNaqp/m4zbKSPk0CIyFC3wZXtVRjx4+RixU+dUF/Www4iW/E40QvxHViTyHD5iOX5GXTt6ofFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199024)(186009)(1800799009)(31686004)(66476007)(6916009)(2906002)(66946007)(54906003)(36756003)(86362001)(31696002)(316002)(66556008)(5660300002)(8936002)(4326008)(44832011)(8676002)(41300700001)(6512007)(2616005)(83380400001)(26005)(38100700002)(966005)(478600001)(6486002)(6506007)(6666004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVB6VzJoUm1Db3doOFBZTnhkL0U2T3BlL052RHFxU0JIOGJra1BmQUxmcDlJ?=
 =?utf-8?B?QXNHLzlHTkJ3WDdadDBMWlJ1NG5BbU4zMXNCSURsMTZnNFlTWGxFQzkyRkIw?=
 =?utf-8?B?ZldXdGVXL0pYNE1HQ2tSWEFXZEhBL21vS3BaQ2VHUTNTRFVac0txbk1uWHRY?=
 =?utf-8?B?SjYxeGJabTZ4a1B0SkhPT0F1NFNFbVd4cVd0YitxWThTNWpmaWYxTDArR1hT?=
 =?utf-8?B?MzJSVmNkZXI5V2FwRW1TNHVpMWcxcDZaVjZ5TkZTWC9mV1MzSHhGc0o2VlUy?=
 =?utf-8?B?OTRPMjBvdHhVRjRyNjE1aWZxWEJrZHYxMXhSWXVkTzA0UHJaOTMrTG1IdXJU?=
 =?utf-8?B?dklaWVFjUktlN1RjQ21RWW16TUQ1Q0d3OE15WFpsc00vSUVYK2FHNEFZTFMy?=
 =?utf-8?B?NjIrUWNFNlpWbFAwaTZkRG94TW93eU1MZ2FMTmp5OC9raVlzQUFXYkovSWR0?=
 =?utf-8?B?c09Kck9uZGVBRjc0SW9NVE9wWFF4bWwwUmhzSHZqUEdqMERTWVBzK1RPM0xV?=
 =?utf-8?B?ZXA4SWVFdWZZOGhhSThBUFFtZ2poM0F4Nk9CSFJBODF3d1ZBcjNaL1hna2M1?=
 =?utf-8?B?d1pJQXJNUWtySm1uYnNEZWtZdUQyUkhvaUFMTFJOQXpMVVphNVZlQThmQk9F?=
 =?utf-8?B?Vy9vcHlNK3ZKYVRRTmhVcFl6Nmt6a21KVjFYUGkyMHhtS1B5cFk0b2t5YXJv?=
 =?utf-8?B?Q1d5dWsyeFF4ZjVOQU41aHJEYkdJcVJvbU41YUJuVUFXeTl1eldpQ2xmQm5w?=
 =?utf-8?B?ZXQ3QWk5ZWowa29EMjF5Zm1OMHM4eGtRYTBQVjBtaThZUFo5SFVMdXl0T0hW?=
 =?utf-8?B?RzdyaVdBeDZFamxUcHNyZWRVOVcrTEFmQ3d0RThHdFNxRFRkdkVTSHRzcVVH?=
 =?utf-8?B?TlZyeFpSQTFrcVNyRzFMNTEvckt1RHRyOHU1UTA2Lzd1eXczRzRBUjg3T0Mv?=
 =?utf-8?B?dzZmSTk2dUJlK09SQ1JNU2k0Nk9FT1VCeXJpcEpmMXR0TVJvYXZFb3Q1cHNa?=
 =?utf-8?B?a0xTb1lsazgwWU42ckVhOHNkWnovaEdoYWl2WWdQRitUYk02SnE2SGhzTzU0?=
 =?utf-8?B?aVh2RVdsRlcvSTBlVjc1WXc0WjFqeXdXMDBhcGlEaUQ3U0kybjAxUmE3TmpH?=
 =?utf-8?B?QUpTUTZZNjc0SGx3OUhzMW1oa2p1WlZDKzFRTTJhU1NzY2FIeDQ3eUdlMW9k?=
 =?utf-8?B?RW1vam15dVBDSEs5WFpsVExyMUlVMk5ZSUduNUJXeGlFdVMvU1dMV2dMN3F2?=
 =?utf-8?B?TDl6VzRuYWE2R1hzVmtNU0h0dTZ6K2JuRE9hV2RFY2FXTFlOQ0dIOW5PK3Ft?=
 =?utf-8?B?NkRNSjhZZEZVbU5OSGM0Q2d1VVMrUXRwZmlFZlNIekJlWFZpZVR1TWdIRlpD?=
 =?utf-8?B?ZVNxT2gyanRlUy9vNTAvRnY0WTlINE9OR2liNGpnS2pyOU9lUHEwaG9RYU1x?=
 =?utf-8?B?WDBDYUlLREFLWWRjMm5ScnM4N0FkRVU0V0RlVzQ4RTdSOThHT1VFMDV0c2dz?=
 =?utf-8?B?cG1zVmh6TUVsK2dSYThRaG50emkrQWJxcXFEcDRJb2ZLeTlaMU9YSXY1c1FN?=
 =?utf-8?B?bTczclpzVU9DN05PTExjT1h4WnBvS3IxRWpGTWNZOVQ2NTBGaGFlemJ5Vzdi?=
 =?utf-8?B?dUhsNTQzWXlpbWlLSVA5Z2FGRmUxZ1NyV1FReEc0ZzdXQlhpTG1YYlQ1VS9p?=
 =?utf-8?B?VnhaYmJXK0xtUVNPUG45Ny9xT1UvYlhGRTRMS2JhbVFBb2xoVW50cEx4YW01?=
 =?utf-8?B?ZjBQUjN6bGJHeXh1eU1IQ3pQQnNwSWVOTUdoUFYzeUNkamJKbXFvbGgwNkxO?=
 =?utf-8?B?cTZHbFc1STVoME02OFAzektQcU1rZlV5cUtNSHFLeHZxTVRHWXNNeURQTktk?=
 =?utf-8?B?RFFZZWJuRkdrTjhCWTFISGhDUEZBaTVnQmlHeUpWdzAwQ282ZWM3dDI4MHVQ?=
 =?utf-8?B?VDBqc3RodHpXY3B1bEdXSjNEb3RCZUd5L09yRVIySUpwbXN0Nm9CeHlCZDYx?=
 =?utf-8?B?S3J4MWZNbWdzWVFjdmZ5ZFpHU24wWmdNZkpzSzlRWHNzaVJoUHZDL0ZOek1F?=
 =?utf-8?B?UEJBZXY5NWp3OXRKek80ZWlzSFFWUlRaNHh3dVRtYm10clFzRk9veVhKMVBK?=
 =?utf-8?Q?O0b+M/qaMwXcmeKb0XE8H8Ia6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bd43bf-b156-4df3-093e-08dbad96aa67
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 22:31:22.0737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3WB6h+acgr6BTCvreS8+XtfPwbGGiFbDrvnwn79dkFmbgQ2P6sgmy8WfSb3MgOyj0QxBgYSd68Cl9/9p0fo+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7693
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/2023 12:16 AM, Mathieu Poirier wrote:
> On Tue, Jul 18, 2023 at 06:40:53PM +0300, Iuliana Prodan wrote:
>> On 7/18/2023 6:23 PM, Mathieu Poirier wrote:
>>> On Tue, Jul 18, 2023 at 11:25:03AM +0300, Iuliana Prodan wrote:
>>>> On 7/17/2023 8:42 PM, Mathieu Poirier wrote:
>>>>> On Thu, Jul 13, 2023 at 01:42:20AM +0300, Iuliana Prodan (OSS) wrote:
>>>>>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>>>>>
>>>>>> Add the .find_loaded_rsc_table operation for i.MX DSP.
>>>>>> We need it for inter-process communication between DSP
>>>>>> and main core.
>>>>>>
>>>>>> This callback is used to find the resource table (defined
>>>>>> in remote processor linker script) where the address of the
>>>>>> vrings along with the other allocated resources (carveouts etc)
>>>>>> are stored.
>>>>>> If this is not found, the vrings are not allocated and
>>>>>> the IPC between cores will not work.
>>>>> Is there a constraint on the system memory the M4 can address?  If so there
>>>>> will be a need to declare address ranges for vrings and buffers in reserved
>>>>> memory in the DT.
>>>>>
>>>>> Thanks,
>>>>> Mathieu
>>>> Hi Mathieu,
>>>>
>>>> No, there is no constraint on memory.
>>>>
>>>> We want the Cortex A core to communicate with the HiFi4 DSP.
>>>> The Cortex A is in charge of starting the DSP and loading the firmware in
>>>> HiFi4's memory.
>>>> When using rpmsg for IPC, the Cortex A needs to find the resource table
>>>> (defined in the DSP linker script) and this is done using
>>>> .find_loaded_rsc_table callback.
>>>>
>>>> For the DT, we are using a (not upstream) device tree where we have the
>>>> reserved-memory for dsp_vdev0vring0, dsp_vdev0vring1 and dsp_vdev0buffer.
>>> That is the part I'm interested in.  Don't we need the reserved-memory entries?
>>> Otherwise the M4 may not be able to access the memory chosen by the application
>>> processor, most likely leading to a crash.
>> This kernel module (imx_dsp_rproc) is used only for DSP.
>> For M4 core we use imx_rproc.
>>
> The point here is that if I merge this patch and someone tries to load a
> firmware image that has a resource table, the system will likely crash because
> reserved memories haven't been specified in the DT.
>
> Unless there is a very good reason not to, I would like to see the companion DT
> changes submitted with this patch so that the feature is complete.
TBH, so far, I haven't realized that those reserved-memory nodes are not 
upstream
I see they are, as examples, in fsl,dsp.yaml [1]

Let me check why is that and I'll get back - hope, with the DT changes.

[1] 
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml#L170

>> Iulia
>>
>>>> Iulia
>>>>
>>>>
>>>>>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>>>>>> ---
>>>>>>     drivers/remoteproc/imx_dsp_rproc.c | 1 +
>>>>>>     1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
>>>>>> index d95fa5586189..b5634507d953 100644
>>>>>> --- a/drivers/remoteproc/imx_dsp_rproc.c
>>>>>> +++ b/drivers/remoteproc/imx_dsp_rproc.c
>>>>>> @@ -941,6 +941,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
>>>>>>     	.kick		= imx_dsp_rproc_kick,
>>>>>>     	.load		= imx_dsp_rproc_elf_load_segments,
>>>>>>     	.parse_fw	= imx_dsp_rproc_parse_fw,
>>>>>> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>>>>>>     	.sanity_check	= rproc_elf_sanity_check,
>>>>>>     	.get_boot_addr	= rproc_elf_get_boot_addr,
>>>>>>     };
>>>>>> -- 
>>>>>> 2.17.1
>>>>>>
