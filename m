Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7097D485F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjJXHWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjJXHWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:22:05 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2134.outbound.protection.outlook.com [40.107.255.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35EC10C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaqL/WjJW30hqUqVOxK2nv8Yus2M7/nDh0XjVf13vcoctY3NtOo7CzCluBmlidR1lPN4V6LL9nhM/zi2OI5eEgkuOf1DNLBZ7bCIZZTK5V0FajV6N4b7IBwHnT8dyHvdTCQiqrqbbUihKgLs0PCW9Hia98b6i7sCbc6PxFque3aLlesHjACAW7Lxu5vM01Eet0HNRtSixaf9gwzuC2wf4l/mCwYwHR2TSDHtFHAPHjr15HH0FuR/fQkQk3g6Or6p0hUyCiDX4Ozsba63UI/oGQ0cIMMi1I2NpPMBNLL6m5MS0BjMw4je+HswkzqVFqhBEr73qGIe1Hts3gJ27/XSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joyPzdJknG7liU17GMQ9n7ZyJlKVBtaRd+4z32YsZgY=;
 b=T7nj1sjFB8440JH1HR/KazxZxyrf91GHwy4dydOmE5KIYVQMvbMdRIvXIhiX1okZ/Z9DX2eXXRPq/iKu/IB4WOalPmK/BebtMSpQGj4+sXcG3lYhblVQWPErNLNDHODN9bTBrcFjI64FjEOA0Qy0Je0/o7YGQIlwCpZZ4Itl8Q10492fHMy8QhV8cj9VQoG6carKLPSz3sIebY1hD5AUyUroSJFJ8Vb4YMP0W2lgwFOxiJS1SZ9fQ85AHPKrNTsNQJUOadyg8Un8G0gJQAQV5BAO5fEpM5HNOPHRaSiB3qoUHiSlPqGnPnnwbIAih6b6rbAoJxYS87/7ZFSTppehwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joyPzdJknG7liU17GMQ9n7ZyJlKVBtaRd+4z32YsZgY=;
 b=LDw0VvoMpdPJroDYrIV2uZXLjlvZnHzxpIZTIzuvZ1KIr/+3ydwEbiqyeU1/cLomYmTL6DtV5pY5DvrgEUTny58d7W/hZ58IEo/+zvVCiUZKG+5IVS6/Bg0iVUKsgjrDymxkheB7Tg8ydow0BKD+KaBGn/Ob1L8Oh+RJJ4xjOX+IB1PjiBC0z9gJKdrQMqHu04VXwAyIWtCOohhArvwyBbGvtZPC9MpI34VJaSALyhpUW13jqlV+FfFRCdJJrUr3x/bGF8e5C7D14lZOBgTe7cPVlhHKJL1y6HGDx8UzA5QYcv2Vp+T+B36UhGaynGRRIU2wEblC4iyxrdCv8TOaVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB6819.apcprd06.prod.outlook.com (2603:1096:820:10c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 07:21:56 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d%3]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 07:21:55 +0000
Message-ID: <8894fd17-bfa2-4683-a908-f451c940a901@vivo.com>
Date:   Tue, 24 Oct 2023 15:21:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm:vmscan: the dirty folio in folio_list skip
 unmap
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20231019131446.317-1-justinjiang@vivo.com>
 <20231019131446.317-2-justinjiang@vivo.com>
 <2d847d76-2e33-4296-992f-1a6d00c66ff5@redhat.com>
 <02e73251-33ff-4632-9d2c-bc268f397202@vivo.com>
 <ZTH+7ZJyPnyZOe7V@casper.infradead.org>
 <380bc753-5ee7-4bc7-a76e-a804d5179d87@vivo.com>
 <ZTZlR2qJivLIdgsB@casper.infradead.org>
 <4eacc9e4-65ba-4fd9-bd30-575b0f23b63e@vivo.com>
 <ZTZuui+0Ppe6cjgC@casper.infradead.org>
 <ec6b681b-132e-4323-93eb-5925b0ca7ace@vivo.com>
 <356a0ae7-6fba-4065-bdb3-5da184074f60@redhat.com>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <356a0ae7-6fba-4065-bdb3-5da184074f60@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 488dc56c-c7c6-4c31-890d-08dbd461e6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pYfHyw2dBfeX70wIjLm4ot6U1UMaJh+KynF0kXTESlmm3Rs+Ce5mFmwbB2ViUhbQ04y5tw4Lh42C7w8kwhLwxtvwuF23ySWa+rM4ktdv3wdeHo222NTPUfjomCFP2Ved/Il541ZNRdXX+zNyWA4qkyjDlhp0SjlwoZOgGQTsSI7GK6bHlAgG0JdA+5r9jt/+GtYCnMPFN5VB9lhYrzy+1gefzDOpPtsitVHhfnpN2rHf3kkfyxtQikBt/nDk65yv8v35BptMZ4yHbeQCgpKqTF1HgyfONROTUl9efO7IZ9bnISERztqd4n8Z2nlUhT6+pDgRPJgjvkuBxBo1CfHCZfQV8fbnmawplnvTnr1JvPe3m4qHyTg7qokwyQtAf6ziTSngZbwsQ4XLna1FOyDGxrY3niH4J9L7QgPOTvjfXtV+Jec0IcI4TKL3h4imgB9CPTAQTwMuMQcfS5MIMw/I25qujXMrVonCrkmFOxoqNWklvcH324QmXRlh9WX0FDJeYLcrCMZgykUxkya/kh/SrUkcmcJ2HdJBE8zK9jcsfauGqv7nXfmhT0jrIuSzMkPAlEUKh2W5u1VL73o4XZSSxQW6IfBWlKxGV+eqrlcHa+4TPdam5kKUWg8y/pcxvPyJgmSCvIf0xIQerUDYODE6pbZcVIMBIVLcvZ/fqdBqoPr2vX7a3Y8mLQXwTYAyze2u8ADx4IHGRTylrzH35bMElb3UB49q/W2W4akPp8dWvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(84040400005)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(41300700001)(5660300002)(8676002)(8936002)(4326008)(2906002)(31686004)(66476007)(316002)(66556008)(66946007)(110136005)(31696002)(86362001)(6666004)(38350700005)(2616005)(6506007)(6512007)(36756003)(26005)(52116002)(53546011)(107886003)(83380400001)(6486002)(478600001)(38100700002)(43062005)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkgyTkFxeCtzamZBZm9mNy9KZjRNWDErV2Vqc0YrZ0VvTzRLQXZiYjZzUllT?=
 =?utf-8?B?ZXc2V1VmdjVucEV2SkdWUktBcXlVSzBDRktVbDcxZzNsR09qNEIwcnM5RUZ2?=
 =?utf-8?B?RXBOOWpxZXF5U0t4dlRCY2NGTEJUWVB4MVpDR2NrcnN3UEpvdDk4MmFGTVpm?=
 =?utf-8?B?N0NucGFVTHNNejl6bCsweUVHdVVhTWM2TmlEK0UyK1VwMzZWWlQ1YUxsNDZX?=
 =?utf-8?B?NFIxRGxWckkzQ2hsTlZJNEtpc1JlTWNkbnh4RWxzNmxDZnkwakpad1VIblpN?=
 =?utf-8?B?b2pFZ0RibEFqekpiSUM1NjVhc2VFNXZVM2dRNFNLTnBjMEZ4Z0lXYXpadWJ0?=
 =?utf-8?B?M3FsZmc3a0dyWXdSRGJ6bzlvZjJxRU9qQ2xZVGN3OXI1N1hDQ0hlaUFtKzFq?=
 =?utf-8?B?RkxYdm1TSlYvQ0wyYjczenRoNHF5cEJQdVNiVTJsaUd4c2ZJeUZ5RFhML0lP?=
 =?utf-8?B?RkY1MFl1YUorSXptdktRdjAyeEhjNE0ycnFXVkFKajI1MjNpdWI3UURtL1Bs?=
 =?utf-8?B?Wkp0c2xqeDVSL29WRGhlSjUxY3pjam14cUtBMkg0TVhMR285cHc4OS96U0ho?=
 =?utf-8?B?N3pZeVY5Qk1SSFRaQ3FpVGErdlBHMmUzTzU0bDV0NGR3REEvU0poRXAzejJY?=
 =?utf-8?B?RlQ3dkFOTjE5a2hIaURFTlJmelQ3Q2FBaHJEY0htWGR3VkdqR0sySFd3Z1Bi?=
 =?utf-8?B?WFcraHhseGRMbzR6NDI1ejVvanZxU1dLcXY1NmFyMGNXei9GWktpYmoyTmdi?=
 =?utf-8?B?RGFBbzE5dWczNmlueGdZVWYwMjZUYkpHUy8ybXNtVmduN1k4ZG56d3pDUkJm?=
 =?utf-8?B?Q1hlU0VGVUE5SU1rUjdZdThnWmU5Z2Z6cjhwZFlBaldMdWgrVTQrNmJ5b3RL?=
 =?utf-8?B?ekhqWE1XTFdyZnZwQ1VGYkVEQzdiazlmY3FJSDVTQmlmWlI4Y2ZJNGVmQTJw?=
 =?utf-8?B?eGIwVDZhSjdTOUhRazRhS2ZvcU1yczVQaXV3aTBpUkowbGlqK0FjQXc4eUZP?=
 =?utf-8?B?MExWQW9vK3k3VkNITjRxYi83MHZhb01pWVZ4a3h0dCtKT0s5R2ZzNzUybU56?=
 =?utf-8?B?djlUZitOaFhHc284cTBZZVZybUQvM2dLblAyN2xoU3hFYzV4dUdDYXdvbWxw?=
 =?utf-8?B?djZ4Nll3WXpxeHJ2cFNLVmkvSFJ3WWFJdkFXckl6SUUwR3NvbDVDc05pNUli?=
 =?utf-8?B?aFpLWmQ3UXIyTUVoNTZpUncwUk9ZWjEyV0doUy9lSjgweTRCNE9hNjkvN2hy?=
 =?utf-8?B?eFdwK1B4N3BlREpmaWVYUGVqaTdqQTBXQTNZWG45NWp2cm1oQmpad2Q1aUZH?=
 =?utf-8?B?RDMvMUM2cDFXZmd6MC96a3U1VytYc0dRcFlUcXA4NHRFY3FsdHBBd2NPTzVM?=
 =?utf-8?B?aEYrOTBMbWJ5NUU0VEkwY2xXenZGY1RTclA4NEVlaGhIeS9GYzR2dW02b2hX?=
 =?utf-8?B?blhWZTFNeDBWYllQQWZoWVFzYm9PSU45RmxvTkN1L21uZk9lb3hUVG9ld21i?=
 =?utf-8?B?SzFpYURsRTFaNytnZG9seGFYY2w3aVBnNzdVcXFpM0JsdWRKcUVyZHJxd1dU?=
 =?utf-8?B?T1ZxQk9TU2VTUTcvMzhoY284S0tUYVV2TDhON2haT2MzcVRrUFBLcTBxVG1n?=
 =?utf-8?B?L1BWdTRPdFEvTit6bkJyV3MxTmVtUkIySVlzZVZiWVNoUnMxS2NQODAxeTc5?=
 =?utf-8?B?bDM4czk0ZEFsUjFxU2JUY29IRWJNdmRNZm1NMWdtM1hwRGluWVVrR0JlRE1a?=
 =?utf-8?B?WHkrMEZhdWNxZFovUkJhQzVOV2YyalRjVjlSMW1zVnVKcFVaZy9XRjJoMHU0?=
 =?utf-8?B?eWF0MkE5eXMzUTdMVVlVRG5vcnU2V1JvTjJkOGZnQUNuNUthb3hhbm9IZzFJ?=
 =?utf-8?B?S2NaUmhjeTdpdkk1cXZtYSs0a1lGcnloRkY3NTJLOE05SHdWdjJNQW9GdmNy?=
 =?utf-8?B?ZkNaa2hxYTNjU1k1cDF5WC9JN2c4U1NJOSs3dCtxK29rcGRESmFvSy9zaklo?=
 =?utf-8?B?a2owWHhZOVFRQmpwcWxSamgvK2hNRFBtREQ4S2QyTTZScVBGM0xsQ0JVYmlm?=
 =?utf-8?B?UVpsWWVyMWxGdlRlclNxQjhzbzM1OU5SVWMrd09TY0swVmN6RVdMbFVFcWU3?=
 =?utf-8?Q?gGel1zo8ajIAdVgpn1CITUnoY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488dc56c-c7c6-4c31-890d-08dbd461e6a6
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 07:21:55.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7dkXSdZy0tLUl6z4oesLC7Q68fHpFOecmBLkDqa8JcN1La+FW5jccBX93O9tkFuTthZDgnBTJRKIR0dE1LOOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/24 15:07, David Hildenbrand 写道:
> On 24.10.23 04:04, zhiguojiang wrote:
>>
>>
>> 在 2023/10/23 21:01, Matthew Wilcox 写道:
>>> On Mon, Oct 23, 2023 at 08:44:55PM +0800, zhiguojiang wrote:
>>>> 在 2023/10/23 20:21, Matthew Wilcox 写道:
>>>>> On Mon, Oct 23, 2023 at 04:07:28PM +0800, zhiguojiang wrote:
>>>>>>> Are you seeing measurable changes for any workloads?  It 
>>>>>>> certainly seems
>>>>>>> like you should, but it would help if you chose a test from 
>>>>>>> mmtests and
>>>>>>> showed how performance changed on your system.
>>>>>> In one mmtest, the max times for a invalid recyling of a 
>>>>>> folio_list dirty
>>>>>> folio that does not support pageout and has been activated in
>>>>>> shrink_folio_list() are: cost=51us, exe=2365us.
>>>>>>
>>>>>> Calculate according to this formula: dirty_cost / total_cost * 
>>>>>> 100%, the
>>>>>> recyling efficiency of dirty folios can be improved 53.13%、82.95%.
>>>>>>
>>>>>> So this patch can optimize shrink efficiency and reduce the 
>>>>>> workload of
>>>>>> kswapd to a certain extent.
>>>>>>
>>>>>> kswapd0-96      (     96) [005] .....   387.218548:
>>>>>> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 
>>>>>> nr_taken 32
>>>>>> nr_reclaimed 31 nr_dirty  1 nr_unqueued_dirty  1 nr_writeback 0
>>>>>> nr_activate[1]  1 nr_ref_keep  0 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>>>>>> total_cost 96 total_exe 2365 dirty_cost 51 total_exe 2365
>>>>>>
>>>>>> kswapd0-96      (     96) [006] .....   412.822532:
>>>>>> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 
>>>>>> nr_taken 32
>>>>>> nr_reclaimed  0 nr_dirty 32 nr_unqueued_dirty 32 nr_writeback 0
>>>>>> nr_activate[1] 19 nr_ref_keep 13 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>>>>>> total_cost 88 total_exe 605  dirty_cost 73 total_exe 605
>>>>> I appreciate that you can put probes in and determine the cost, 
>>>>> but do
>>>>> you see improvements for a real workload?  Like doing a kernel 
>>>>> compile
>>>>> -- does it speed up at all?
>>>> Can you help share a method for testing thread workload, like kswapd?
>>> Something dirt simple like 'time make -j8'.
>> Two compilations were conducted separately, and compared to the
>> unmodified compilation,
>> the compilation time for adding modified patches had a certain
>> reduction, as follows:
>>
>> Compilation command:
>> make distclean -j8
>> make ARCH=x86_64 x86_64_defconfig
>> time make -j8
>>
>> 1.Unmodified Compilation time:
>> real    2m40.276s
>> user    16m2.956s
>> sys     2m14.738s
>>
>> real    2m40.136s
>> user    16m2.617s
>> sys     2m14.722s
>>
>> 2.[Patch v2 1/2] Modified Compilation time:
>> real    2m40.067s
>> user    16m3.164s
>> sys     2m14.211s
>>
>> real    2m40.123s
>> user    16m2.439s
>> sys     2m14.508s
>>
>> 3 [Patch v2 1/2] + [Patch v2 2/2] Modified Compilation time:
>> real    2m40.367s
>> user    16m3.738s
>> sys     2m13.662s
>>
>> real    2m40.014s
>> user    16m3.108s
>> sys     2m14.096s
>>
>
> To get expressive numbers two iterations are usually not sufficient. 
> How much memory does you system have? Does vmscan even ever get active?
Test system memory:  MemTotal:    8161608 kB.  When multiple Apps were 
opened, vmscan can get active. I can capture a lot of tracelog data 
through testing, I only posted two sets of tracelog data.


