Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1076075767F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjGRIZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjGRIZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:25:19 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5835E56;
        Tue, 18 Jul 2023 01:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foi3NihbyVlh+aIBe4k9uOpnlSnlwUkapTx+gk3TgOiWMX4LjLRJGtvJBOA/30VzKi6cFRRjl2svJNW7//Ul/KXIL6QDjePK2mRK1/e4qdem1GuwC58wkqCu8Bj1HdQu/H6Oyh8yb10fgfK+tvt/bhwSEtIISxnQRA5HsU1UHkBNH55K1oFcsKJUNvvJyMjx1X/VfBiwUfWJHSu36P6byz/1Pd/8JR5JR2vmOYKrfzjgaXvY932Wthyqrxl0TCsgPAsH9ymi8URf6d09Qx/csKiOBIa7zOgiK+NpGbXPCOuGTjYsQ2Sz+2pLMJ+dCnEoXw+NvH1x5jWD7InIDIk1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnxMBvWyXJI4jvBL/6gwS3cp/uLtAzNc7IsG1YDlGBw=;
 b=jZIZjQMviSNMEshL910/tAK2UbIDJHKNYbjhvXEvyViK25iafy2xm9Upk+SqOWcWDCDoztmJQ9C+lyEaLpqtdEzea4s8qlruvMvQbKHt7puos3VJJI/EO0LWHkKY4aszEDS1xZhjoW5oC+LY+nsfjFJ+nowgtAwyam7ychlF/68CTL1re/U5AD0QSuiHpQCsImMjEzw8QKw5H3vUBe19wGLTZTqyNScZgr8NUY+/eSRlUwE20fYXa0lV/dBrJV7Ms1IaIkTR8tGWVGs8CtyjAnnji1hjvk83acGZ6ynPLRdtG3mBxGck1iARQ4jdv0t1s9XN5dyI7tOZ27D5FcFzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnxMBvWyXJI4jvBL/6gwS3cp/uLtAzNc7IsG1YDlGBw=;
 b=Lw6/wvk4SAo5PuSXXuOycaQa70tFjOHXhwboy3Ufa3PPuIu/XToBsZ9hv3He07V+eitXgGfNhoc7c/c0S+5DaDGkkzWMQBESteO5VrcBw5jGDIhjLXjRonziiXd6JdOvM1w4qJT1U7ed9SX23Tkf51w41TNUP8C/PNJqQNPNsDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by DU2PR04MB8775.eurprd04.prod.outlook.com (2603:10a6:10:2e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 08:25:06 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f1e4:90a0:aabe:ac23]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f1e4:90a0:aabe:ac23%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 08:25:06 +0000
Message-ID: <474c0241-a58e-b435-8ac1-82a5a458d79a@nxp.com>
Date:   Tue, 18 Jul 2023 11:25:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] remoteproc: imx_dsp_rproc: add mandatory
 find_loaded_rsc_table op
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
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
 <ZLV9gAmiDldlvIUR@p14s>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <ZLV9gAmiDldlvIUR@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0277.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::25) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|DU2PR04MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c07ab93-610e-4d43-e675-08db87687dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sXEeNHhvKrxY9/0lfrZkp1t2wQ2x7Hu18KJbhKMZIxK7OzNymPBvXrsxnk+L5OIoya1PxjfQPpmk2IajZodIKCosvxJXcKKzszQoQsHzC/6DoJUvi382yStUdiSCqcRiF9nwy0kQOtva82giRFjZgUCzQJysPNp2cQXjMTqgpkTsmJMCUz4+HGTSWk7osdUNygvpOUSE+MUQzT3dLd0p5va/yBuU56Z7zasPQHNBMgjWs9n06+KwMAM/y4uXROKyRJe6MTTd2FyPdGnqJflC9x0n6ttQC7JdafuieiIQtdln5lGCz0nDVWTDHOUqlfQ6JoO72EyFLB1g5cRJPr+hTGrtGn3bGRxyktczxT/fbmfpLWPEZD1WUidgeRq6LdbxYfoDmi2q297GNNSpg+v8iva3Jv5pvoaxvAKLBcx68eQOnsI5nkG3vJI5HQgIYyBItkqWmAfzHN2T+c+oR44mbzi3h7ZALrXO09hlJgWKOGf+KBSoRFtwqagVRWlUg9djbl3B2hSomAnx2Mk3sLv4oiD7DN9/ZA0APbNbotnqnMLLTqzNalinHrkWCUJyh5Rq+AsPOM58NGvNsvaAQuPm3mx3cwyrUmtuGk1XlGsBRno0zPpIUe9X/I8ZU4rVsflJ4T/oTUdLHisUBybXaRMsnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(54906003)(478600001)(6486002)(6666004)(110136005)(6506007)(186003)(53546011)(26005)(6512007)(2906002)(44832011)(4326008)(316002)(41300700001)(66946007)(66556008)(8676002)(8936002)(5660300002)(66476007)(38100700002)(31696002)(36756003)(2616005)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjY1UmJxZE0xWVY2K0dlL0VwNmh2OC9ZbkNJMVA4eWxtRTRqd0RjZzIveEhm?=
 =?utf-8?B?YXJQVUtYTm1ZVWF0QVd1SEU1NzdndGxsVWFEWEJBSnV2R0greFNhNTNnMXFZ?=
 =?utf-8?B?YVZYSVJkbzB0eTd5MXhPM1JVVlBScTYrR21CZXpoaU1WQTczdG5oWWo0MWlz?=
 =?utf-8?B?aW54Rk1jTTBITXhrUytsN0NjQk5yaVd3OVFUSmc4MFJXTHEyNEhXOWNUZkpO?=
 =?utf-8?B?c3YvaFp2bFdrdllXSUpLQjZhd2RkemJmMzJIQVdZY2JXRkpvbkJOK3pzOEdP?=
 =?utf-8?B?ekpOaW5ITDgwdVRmeUxYaFM2UmFEL3IzNTIzallvbkpyTFErK2VhUTZaTERY?=
 =?utf-8?B?M0RsSUVFenhFWFVvcnJMdU1NTUNpMlMyZDFSSjdzNC93NXdLNjc5ZEQ0YjVM?=
 =?utf-8?B?R0Y2cVNpRzNzNjEzK0VSd0ZxdVBlVlZzZnVKOGRHOEVvZTM1ZnoyeDd3RFAx?=
 =?utf-8?B?UFMyc1AwblErTW9sQ1Y5S3JOTzFXWXdFQ21URTBYeDA2UmNUY09lM0xlZlY1?=
 =?utf-8?B?WnZ6b3VEZ1R0MVpvdWE0VUUwMk13eTJkOWZKYS85YTBYRGo5aWpnOCtjMGY1?=
 =?utf-8?B?cVJKWUpLYTYwWTF1Q2kvcTJHdzd6cTFBS3dnbUpyam5vMDlOcU9MUmhETnBi?=
 =?utf-8?B?WUpFRnowM1c0UlNaekJoSC9LSlFxd1IvU2NObWxSalMvSUk5NE1adVd5eWlU?=
 =?utf-8?B?dHRvenJlajdhbUpsN0NTR3RvenBwSUtPL1JzYmIzdUFyQVozOFRGV3V1Y3h5?=
 =?utf-8?B?ZENNQkdPcDhReUNhZG1SdTQ2U1Q3cVoxWG1kRGNjR0s3RlJXRm5nUjd6SDZl?=
 =?utf-8?B?eWkwY2J3RUZ5VW5OK1pnQ3VQT1Q0MER5Z2JrZVFiK1R2VkM0Z3dBV1owclBH?=
 =?utf-8?B?bFVSbUFjT21vbnpsWGdZbDZ3ejlVUERvWFF5SDJ2NkpHTWM4SCtBYklCNElT?=
 =?utf-8?B?a0dRV2NRWnFDMEdQL0k4dzl2THZJWGVBSTFBM3hkaXJhMTVaOFE2VjNSM1Jr?=
 =?utf-8?B?T3FraEh6NWdlL1N4Y2ZPbUFydEFjeUhRVzdzbnBKYk9MUWJmQWluZzlGNjRi?=
 =?utf-8?B?K3dRT0Nyd3RwbXZwSm95L0V1R0VkN2xjT3R0Z0xtUWh1Rjk5aUQxc0tMOEt6?=
 =?utf-8?B?b2o5MnorRFFiY0d1eTBBMGU5c3hTYlhHVUhweFZiVjg0V2VQeTUvbkVyeE8v?=
 =?utf-8?B?QnZWcGpLaExBekJpWjRiVGo5QlprR05RTFFRY0FMR3FTQ0VBNjluaUYwaHBv?=
 =?utf-8?B?c3FjN1RWbDhoSGpxQ1B5SStrVzg5R0MyRS8xWGVDNW5nY0Vqdm5aOUtoTFlV?=
 =?utf-8?B?a29GWk8zZHRPYmNPNk8zRHFzQzNvcFlKM0tST3V1bWtsZkkwcFpjY0E1OWEw?=
 =?utf-8?B?YkRCSXp5NzVaSmZmeGUrSkU5dXQ2NkY1aVVYL1B0TmRwZHRBQzE0RjRLWGVL?=
 =?utf-8?B?eVRXL3pZbjB5VUhsNHgwRTUwdjVmMTZQSXNWZlZoSlRDQUtUb0hTRFBOSVdn?=
 =?utf-8?B?a29zOVVzVHZLRmRmRWZZZTk1UnhESXMvbmJBL3pjaXM4Z0R1L3JFeDNpYTI1?=
 =?utf-8?B?WHIrVjcxbnNJS3FBVXZwN0xaaCtGeGcyL0w0d3B4L1VZeDRvRy9ISXZVdjU0?=
 =?utf-8?B?ZjVNMkhPNE40eHh1NjUwdVlEaWZETEpWcnc2d24xR0MrR0t6SjRGM2o4MExO?=
 =?utf-8?B?NFZwSkJPUCtoSy9BSnZTWGFQSUJpQjAyS0pFb2FOaFdBRnRidFFqZlhCdDJY?=
 =?utf-8?B?ME1tYjZ6ekkzbE9oSkZMNzBFYmw0Ynh5U0g2cVRlVk4xQ2wxSXd6R0xURURt?=
 =?utf-8?B?S1lpWkVlMUNxdUtRYnpWWFpJNG1uY3VHUEdtNTZwSkVpenU1MHpjVFRTWGxH?=
 =?utf-8?B?NC9rSnZYY0FnV05XeVFKaVNIblJ1VnNyZkZiVUE0VVNIK1l1YmtTRzN2TzBS?=
 =?utf-8?B?VFB4UUlEblA5cFZyL2o4Tlp1RVh3UVJSL0NoZW1Ta2wzajdONHJySFBoZUdH?=
 =?utf-8?B?bWVlejJKTEtYWHJsQmdBazBVUXE0OUozd1NTSzdvY1lUc2F5TmZwNXVKWE1B?=
 =?utf-8?B?L0RCNGRWbTdsaG51TWhaZXRRM3lvZWtqbG5jTlRIdEV2UHozeGdhMnhWZENQ?=
 =?utf-8?B?UkhIYnA4MW9OYitiWXV0bUxwMkpKWUxBL0NQcVRTQ3dPR3FIMXViSlRGZWlK?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c07ab93-610e-4d43-e675-08db87687dc9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 08:25:06.2328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpfC27EA7O6K6rv/EJnaQyAW8TojUaAYkRJkVK5USvSPvbJZW0CbPp1if/wQh3iqovsIKagaELJQl7id3C7dTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8775
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/2023 8:42 PM, Mathieu Poirier wrote:
> On Thu, Jul 13, 2023 at 01:42:20AM +0300, Iuliana Prodan (OSS) wrote:
>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>
>> Add the .find_loaded_rsc_table operation for i.MX DSP.
>> We need it for inter-process communication between DSP
>> and main core.
>>
>> This callback is used to find the resource table (defined
>> in remote processor linker script) where the address of the
>> vrings along with the other allocated resources (carveouts etc)
>> are stored.
>> If this is not found, the vrings are not allocated and
>> the IPC between cores will not work.
> Is there a constraint on the system memory the M4 can address?  If so there
> will be a need to declare address ranges for vrings and buffers in reserved
> memory in the DT.
>
> Thanks,
> Mathieu

Hi Mathieu,

No, there is no constraint on memory.

We want the Cortex A core to communicate with the HiFi4 DSP.
The Cortex A is in charge of starting the DSP and loading the firmware 
in HiFi4's memory.
When using rpmsg for IPC, the Cortex A needs to find the resource table 
(defined in the DSP linker script) and this is done using 
.find_loaded_rsc_table callback.

For the DT, we are using a (not upstream) device tree where we have the 
reserved-memory for dsp_vdev0vring0, dsp_vdev0vring1 and dsp_vdev0buffer.

Iulia


>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>> ---
>>   drivers/remoteproc/imx_dsp_rproc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
>> index d95fa5586189..b5634507d953 100644
>> --- a/drivers/remoteproc/imx_dsp_rproc.c
>> +++ b/drivers/remoteproc/imx_dsp_rproc.c
>> @@ -941,6 +941,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
>>   	.kick		= imx_dsp_rproc_kick,
>>   	.load		= imx_dsp_rproc_elf_load_segments,
>>   	.parse_fw	= imx_dsp_rproc_parse_fw,
>> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>>   	.sanity_check	= rproc_elf_sanity_check,
>>   	.get_boot_addr	= rproc_elf_get_boot_addr,
>>   };
>> -- 
>> 2.17.1
>>
