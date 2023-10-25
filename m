Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7E7D710D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjJYPiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjJYPiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:38:08 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2099.outbound.protection.outlook.com [40.107.255.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A95E12A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehWgYRCTc3hJ1lo6vaFPasLxaoGCyB3R+xdKY+Es2dei/TjNQ47j84I4JO9BhPDRbBtsk6V4Z6Qto7Ki1xLqQNQ7Nb9OlNP8iJVUtkZP9cIi8HYPdNzXZ0H87A2GNLtgZg8Ms1DX09XPJTRNXXND8TgIuW5pBdwHzIHfJEXfLnbyGjsocQMPNacHQjAgbT6MvMuWpLawREk/QMckQW1N8ep7WEuXermUacN+yFgW/AyEUksB4yGSEd1rNAsIfXJi3PtBgxWehA94n7TJQ9yokGhg45q2IIzpFfbBv9a/d9a5Mj2K6uyPgXIk42T/O6scYpnhaLKhr2ZuRwX/MEu96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLS6A2F7AAE8RHWJMqLyyl3GKFiVRwPgBjNYF/i1W8s=;
 b=OPNgUX0Zx8b0073ozukXhPuWC3XJ0+9MqW5Ft9K7ZUduib8Ucc5mG+M9gGftSNxcQPUmgd3jVBMLDu/17Nu3sAGZG75L04QwzpIwFFgd7HpbnGOKYICyw5PAKiOWuUy4k/l5GoKOwLLcEc7ekyAsYR2MZCWnMPDtmY3Xfrgc+2ipJ8ZQUXBp2qTxNW0g4FhCIpSRih3j1878bVk2hPx77Q3bltQDU+l3nNVMxTpo9q2AvgTVq5u34eOMqqV3G4bMnxuuPnGnPERY0Ur92eL2IQI6pJ6fOKcnlBfBtzY7yr9yl8njEFTQBX9rA7D4OWTw48aZETn3t/CZg6CGsojkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLS6A2F7AAE8RHWJMqLyyl3GKFiVRwPgBjNYF/i1W8s=;
 b=GbrzaCSrC2haIXntvxPoQw9nx4Vh1jUNZ4ssotzHlE6mQypGtmgyECwb4/KSJNOjVOIHE+Zrd/ij+4tcAuxtCViBj6mFCMPort2FozbEWhz8NPhvv14gEFg/poTB4W0F8P8NI8LJF1cXbuSUp75LBq8C5R/WQMiIaZ2k0suZreA12pkTZrkwqEKt6jLw7GjKwsBcoHD/Yy/6Ve64zRMTi+mDqF7ybltlUj0RJ9jl2R4FpYZwQr8h73UhmxxsWZZvsyJTG6/wfCFPZP8oRmw5cYAy+bvpoTUiRA4YywEgoVzOlr2xLz5+2sRQONf0w2RCf1O4Qg7vOJ0Z0/Fh3tFuGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB5391.apcprd06.prod.outlook.com (2603:1096:101:66::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 15:37:56 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 15:37:56 +0000
Message-ID: <3dea1c2e-6aec-4b8b-854d-b671cff98a64@vivo.com>
Date:   Wed, 25 Oct 2023 23:37:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm:vmscan: the dirty folio in folio_list skip
 unmap
From:   zhiguojiang <justinjiang@vivo.com>
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
 <8894fd17-bfa2-4683-a908-f451c940a901@vivo.com>
In-Reply-To: <8894fd17-bfa2-4683-a908-f451c940a901@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: 07750bd0-3f04-4036-e0c3-08dbd5705c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w5XXvq0oDbPkV7gAUU0ZNzveze6Y9P6KY9QTWlZaA/ZvO1Cxr4xo8Bw27i+1SpGX4uxBWWu11NHkjzNXsNHsKucKSJ/8bZ2gmoQx+YRf4dKn4cAZv/tXWeZzj2uFZkgFp2xQ8kWB4F07mZFCA8HTgqodXhuyQQXErCWa5l7RvplKvHBB/E2azLF5q+ooHy0L6Iedkyg/bsgjDqfuQDlODayc1bApr0Ok29evkbi5gGaq4FDQAiGbPojUiUC3a50os5mjDPAo5X9aE2LSB9brIaCSUHqNvvMr5xfFYZqiymNmdRi4IpVKTV/cCGrS27pjlALcC5QsPjleQ/NnrafsWUh+kT6O9XsvRqDfn4fNJ8lToHSbJkutcHDKViCYbP0ZtBn5rqnM3AfAnWUMQucF/WbFxHSAy5k5CKPD8L5ymjOY8pOwgtR2Ye+1Tt2NvN+o56mcalFSk3PmV5DhQ/OWLn6Mzg15kuq5N6a2FWSAutwbHLShhT3lqyyWYje/Ocs6ocYnVXZhXj64dUMfHxgnbGBDOX2BZcV1nt5WNJ3xujb10MSlRNpxGLo1Yfz5D1PjUTE5IJKLuEgNzqD+t6HX123r5ap52kpFTpVG+bwfkYRAeaRnxkpWb7JENKxBuOusRYCf6aUTFgzbeQtUeIpK85S1krEAjaVRw5lViUPaGlJ8CKZWAtTxqyCRRDxBpb9vLZKkDYdJ2qIWHUvBmIPR6ZniibwiUsSVx8bQdutGFPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(84040400005)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38350700005)(107886003)(2616005)(110136005)(66946007)(66556008)(66476007)(316002)(26005)(478600001)(6486002)(6506007)(6666004)(6512007)(52116002)(53546011)(41300700001)(31686004)(38100700002)(31696002)(86362001)(2906002)(5660300002)(36756003)(83380400001)(8936002)(8676002)(4326008)(43062005)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmhOUi90SzFiZTl4MEsvWFR4RWUrSWhJb0ZnQ2xhMmR2OTVoL2VJckM3Wmdn?=
 =?utf-8?B?bE4wZi9hYlo5SFNsYWNQZjVqbE5GRlhOZVJCcEg4WVc1c1A2T20xZ3JoR0po?=
 =?utf-8?B?cEJwN3RibVU2UzVNK0psOXRzeDhGL0hvazkzRUlxR21GdzhMaFRSRmxuQ20y?=
 =?utf-8?B?Z2hWYW5iU2VZOUkrc1I0Q3BRQjB6RW5FWGFIcXR2eVkwRjJ1SWZ1SE1OeTBN?=
 =?utf-8?B?OU41cldWc2hNWkVvWmhoU3Y1cG1uN1BWNVJzYmIwTFpwVTlPUjVXcUZoOWho?=
 =?utf-8?B?ZGNySnl0WXVQRVBMRjByZHFyQ1M5TG9mQk5MTk5WSEpzUlF6Rmw1eHo3azI4?=
 =?utf-8?B?ZDh2eVZ2QUkvL0Q5RGI2U3pZU2YxdWQ5WGV6eVpPYklsa096bm81ZWxSayts?=
 =?utf-8?B?M05TbXZWZXVleCtpS0xtcytiVzRHa3ZhT0p4MDM5d29MUGJDRzRvWm9VMDZK?=
 =?utf-8?B?NExJRnhvU1IzMEFjdENjS29pUkVsOXpvYVBBc01pNGFkZWJrbE5WSURCRkh4?=
 =?utf-8?B?b3dlMXVKaTNjWGdpQW9IeEdmRi9vbVFnRTI3UEU1V0l3aGtzc0FoeUZ2ZjJk?=
 =?utf-8?B?T1ZHTDE2eE5CY1FjTnQvSjl5MHhHdzdCTmdwNGpjWTl6MW1VOWtHVmVaT3l4?=
 =?utf-8?B?OUIrZVVaNHRkOHlBaDBpM2owMEFxMkpwRE9yY1YyTEE5MktQRjFUSHpZa0R6?=
 =?utf-8?B?RlZlVUZMWWtvL3FjaC9IVTg5VHF3cVBBcWVDdUNnRWtpKzlhVkI5RWFrbDBm?=
 =?utf-8?B?Qjd5QVhjUmtTWWtyM3p5MjNtMlg3YmFMM1gzeFMzZVFvRWdIbnY1UmFyUlds?=
 =?utf-8?B?VzN4WVhHeU5KVVFVSHBtVDB3cTlIaCtWTEViTHM0cnIyNkpCSDJRMjAzUlRL?=
 =?utf-8?B?R2NEdDcyeEEzZ1B6SFVQNkRSK1Vqck8yWDd1SkVjQnZ3eHJEbjBzeDB3Mk5H?=
 =?utf-8?B?eDZraTVuQVE5b01yQWF4UTRhMzRRSE1Eb0ZvZm44cUlKejEyc203eVVnY0Ev?=
 =?utf-8?B?R3Z0TnZIOFpFL1RxWk9HZUM2VkFMWmdjUXBqdDFyTkpQejZBQkk5bm90TXJm?=
 =?utf-8?B?RnhJT3lrcnFuK3JhL29lVWZ3ejNQbkQyb1V3L2tOdnJGd3ptQkY1Y3dBaVp5?=
 =?utf-8?B?NjRFelJPSTR4MFlVeGZUbEVBQnh1NitBcTkxVmk0d3g0WGNzTGhnM3VUaE90?=
 =?utf-8?B?aXRjT1I0SEw3c3V4UnVUTE40d05yMDliZWhGZlFWVzYyaVRlQklDS0R0Vk11?=
 =?utf-8?B?SmlRbmI2RkJsNFlHTkJaNDg2MHo1bHoxRGlPc2JkOXhIaGZZUkYweDhIOXFE?=
 =?utf-8?B?S0J3ZzBUZXdCMjJKbXpsR2h4eUQxZ3RBS01pR2pXWnowYUhCYmJxTCtaQkNS?=
 =?utf-8?B?OEhCZUNxUUFmSlp5TnVieGdGbERLcEtjZm9yV21mU1VRY0orOFRjUk9TdTVy?=
 =?utf-8?B?NS8zekR0REp3TndKTUNLSmtZQzBnRS8rVWVmZzZKd1dYSDEzeHVqN3RFNFhB?=
 =?utf-8?B?eEh3SFlsT3pNWGRkdDRVcnhqaXRCaGVia1grNVdsOWw0aTBwazJtSzF6cVdp?=
 =?utf-8?B?cmNkOTV4RGNZQXFUblBlZm5qMHNKV0VkQy9vN2x0QnNsdjlmMTdXUUFxM1VH?=
 =?utf-8?B?STA0M2hUaUpvYVVyVTBNWHdWOHlXRnhQT2RBNDZld0Y4aFVhditrZTdFTXpM?=
 =?utf-8?B?T09KWGNXU3ZCbnI2dWJZQ0YzcWt2aG44czFLZ3F5T2Y5SkVkaEF2aG93ZlMx?=
 =?utf-8?B?ckcwWC9taUtTR3VpV0pzYUVWTm9aSXljQmFVS1JYSFY2ZDNRWW53TkxIMDlx?=
 =?utf-8?B?VWJmVVpoM0licUE3bERpd1RTQ3BEc0NTZiswYkdPVy9ZRDFmZGk5TDBuVVJo?=
 =?utf-8?B?cXYyTUpENVRQNEVaYlZIblR0bkFKcWUzNnE1RFpKcWV4WHV6a0RpMTJRMkNP?=
 =?utf-8?B?RmFDWGUyQXg2eW04NE14NHhPOWY0aTJ5U2M4aDlaUmVDVFhkbDR6ZldwUHo2?=
 =?utf-8?B?WWJDcUpaWTlub0dhOWd3Q2hzT09HckpLTjdJVnhqRFlBS0Q5V1NXaFNNQU8y?=
 =?utf-8?B?a29pWlNkVTJuemxiYW5xdFFWclJoTG1vWUw3a1hrMVppUlIreVdiZXJUeVhr?=
 =?utf-8?Q?kvfJP/PGatW0vSrrZB5iXuD8M?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07750bd0-3f04-4036-e0c3-08dbd5705c10
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 15:37:56.3341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpEn3/o5lo+Focm96EtnuNAHbvMuocZ6M9FKF5Ru+maXVYxpWR1O1OFTSM4ZMV94PD5El5ay+AmyLdRDawDKLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/24 15:21, zhiguojiang 写道:
>
>
> 在 2023/10/24 15:07, David Hildenbrand 写道:
>> On 24.10.23 04:04, zhiguojiang wrote:
>>>
>>>
>>> 在 2023/10/23 21:01, Matthew Wilcox 写道:
>>>> On Mon, Oct 23, 2023 at 08:44:55PM +0800, zhiguojiang wrote:
>>>>> 在 2023/10/23 20:21, Matthew Wilcox 写道:
>>>>>> On Mon, Oct 23, 2023 at 04:07:28PM +0800, zhiguojiang wrote:
>>>>>>>> Are you seeing measurable changes for any workloads?  It 
>>>>>>>> certainly seems
>>>>>>>> like you should, but it would help if you chose a test from 
>>>>>>>> mmtests and
>>>>>>>> showed how performance changed on your system.
>>>>>>> In one mmtest, the max times for a invalid recyling of a 
>>>>>>> folio_list dirty
>>>>>>> folio that does not support pageout and has been activated in
>>>>>>> shrink_folio_list() are: cost=51us, exe=2365us.
>>>>>>>
>>>>>>> Calculate according to this formula: dirty_cost / total_cost * 
>>>>>>> 100%, the
>>>>>>> recyling efficiency of dirty folios can be improved 53.13%、82.95%.
>>>>>>>
>>>>>>> So this patch can optimize shrink efficiency and reduce the 
>>>>>>> workload of
>>>>>>> kswapd to a certain extent.
>>>>>>>
>>>>>>> kswapd0-96      (     96) [005] .....   387.218548:
>>>>>>> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 
>>>>>>> nr_taken 32
>>>>>>> nr_reclaimed 31 nr_dirty  1 nr_unqueued_dirty  1 nr_writeback 0
>>>>>>> nr_activate[1]  1 nr_ref_keep  0 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>>>>>>> total_cost 96 total_exe 2365 dirty_cost 51 total_exe 2365
>>>>>>>
>>>>>>> kswapd0-96      (     96) [006] .....   412.822532:
>>>>>>> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 
>>>>>>> nr_taken 32
>>>>>>> nr_reclaimed  0 nr_dirty 32 nr_unqueued_dirty 32 nr_writeback 0
>>>>>>> nr_activate[1] 19 nr_ref_keep 13 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>>>>>>> total_cost 88 total_exe 605  dirty_cost 73 total_exe 605
>>>>>> I appreciate that you can put probes in and determine the cost, 
>>>>>> but do
>>>>>> you see improvements for a real workload?  Like doing a kernel 
>>>>>> compile
>>>>>> -- does it speed up at all?
>>>>> Can you help share a method for testing thread workload, like kswapd?
>>>> Something dirt simple like 'time make -j8'.
>>> Two compilations were conducted separately, and compared to the
>>> unmodified compilation,
>>> the compilation time for adding modified patches had a certain
>>> reduction, as follows:
>>>
>>> Compilation command:
>>> make distclean -j8
>>> make ARCH=x86_64 x86_64_defconfig
>>> time make -j8
>>>
>>> 1.Unmodified Compilation time:
>>> real    2m40.276s
>>> user    16m2.956s
>>> sys     2m14.738s
>>>
>>> real    2m40.136s
>>> user    16m2.617s
>>> sys     2m14.722s
>>>
>>> 2.[Patch v2 1/2] Modified Compilation time:
>>> real    2m40.067s
>>> user    16m3.164s
>>> sys     2m14.211s
>>>
>>> real    2m40.123s
>>> user    16m2.439s
>>> sys     2m14.508s
>>>
>>> 3 [Patch v2 1/2] + [Patch v2 2/2] Modified Compilation time:
>>> real    2m40.367s
>>> user    16m3.738s
>>> sys     2m13.662s
>>>
>>> real    2m40.014s
>>> user    16m3.108s
>>> sys     2m14.096s
>>>
>>
>> To get expressive numbers two iterations are usually not sufficient. 
>> How much memory does you system have? Does vmscan even ever get active?
> Test system memory:  MemTotal:    8161608 kB.  When multiple Apps were 
> opened, vmscan can get active. I can capture a lot of tracelog data 
> through testing, I only posted two sets of tracelog data.
Hi, please help to continue reviewing this path and draw a conclusion on 
whether it can be merged. Thanks.
>
>

