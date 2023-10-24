Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4887D4556
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjJXCIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJXCIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:08:41 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2130.outbound.protection.outlook.com [40.107.117.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1BCD7A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:08:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVYMUYVj55jh2CdAFUXwq5M+ZsFhm4GxY6XN1oDZNQpk7uOAoMXarotmMY0tOY8uMqMVAfUysJZi/Pho4B6mh0y2NFR6Y7K7p/u1L1z/sWi8/6kN5BSoH0bEj9C85zouGOjqYpjS/qyv0flMtxrCfWqWLL5axcvMhQ4PuxVm9c9EdJAc6zE+zq8RL5Jx7/7d7wZQbpew6ROzwM84K6GA5N2ZGfrIPNhLoTYG0oBLRIrYGjYboPfAKyu7Sh5WUN+s2p8JMTD7EsmPXgcCx2IsYozF/8XPpAZfkXTTne8jioOqnnD48GXLJ6+khEzDPe+p47Rj5L1JF2KFpCoeAh982A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgcQVI/IRUxGKVkjJQJmj2KOCNuRVn+OekjLnFQwC3o=;
 b=KmvXoWA3JlQJ/75+fTAwYaL31b0CMJuTINljbWmyLh3iK15vLYKLw+7wffVmol7YPMWEcEEcU1T5ZXDwt4Bh7/RK6KBMzxvHQb4xGEr5/aTW23r0E+HZmQG9H6hYVlzUbRdom4HKUR6yJbGxmEGF6/SRCv1OS5rxyzqQ0z+QAPDmFqRebMGrZgCwKr2c/3yb6md3EM+LGYFGJ3xYYn+GyaNe+RHsNDScbu+MgnRH5vT9WO5V1RfB1hj2yGQZd2maIwnzF2UeNS8thnHgzWEYsXxosjW9QTMjM99bciUkIjFKV0vC9ATFXV0uyMWgIF0fJDHKFCa/hqIHK6eKMiswjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgcQVI/IRUxGKVkjJQJmj2KOCNuRVn+OekjLnFQwC3o=;
 b=YMBzOvzvuSMQtQ+EP0+hN+gSWykpOu7Trooe/QOxYjpklb7YSS5mSIZ+QTUfY7cE+VUmrk2a71LbtZylbRdQ+qWMSCuJoLIv22oa5XGTI4uLWdULszxqCz15yJYGRxwMjWcRItX+6qlJIHJl0YxKRgeu//sQQj+UT9LVRPwPgCdWbUHi2xCirxMTkG5eWFyhkfILhEg+c5rvQjoWgAS9/DjOFOLPgA7ShrrTGGZfd5DEqqRjKKXlJ2Hjbx6LBTDlpsq+mJ19k9P5KSdOJRtj3I4VaCjbzOZvQiUuyzWUgExrTrL8ftL3lr9a9/dnFkTrspe17FwwJDOrOiGyPvVS2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TY0PR06MB6804.apcprd06.prod.outlook.com (2603:1096:405:17::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 02:08:31 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d%3]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 02:08:31 +0000
Message-ID: <714977e1-8f99-4fe6-a56c-757637118356@vivo.com>
Date:   Tue, 24 Oct 2023 10:08:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm:vmscan: the dirty folio in folio_list skip
 unmap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZTZuui+0Ppe6cjgC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TY0PR06MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6ec04d-3586-48e8-2af7-08dbd4361ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWkft7DoFJ750XyOuJLXzapiqxd1wM3CANf0Z25VHp49qCiWhifrq/qHVs397Rxt2DtFqWTO9G6nxwUrUDvJ1PYB1sxufC7wpv0wq0fm1Nc8K98WScsVPpb79ta7noo2Q/mZYHTGmt5lV6FNiCiyKcg3u0v1TpNIJp3Kz5otO+2j9i5nWdqE4kHQgMQtEfEvb8UGSu0osGgwH3mg7W/UIKySCySMfqt5fbYLG4a9UCQ+YNpS7SVnuwK+gl1lsqu0wI/Z6w9KQXjUqVTvtJKLHdUGcOQw4BAh4kS/Ip33LyDE+QMarwFDupAfuMLTcnciD+RspMPhpXmRcG0/JigFMB97/C5XEiGBz56Ee8oEb/rQIhUdQeyQrJeu/MW3OoGT/4EQaVSme3CTY1TnqWgOp9Be5/UkZY5prd+0Gn3++KL6rolaZa5ByicCA2IMqo5uCWcodF392gsZcveWSzjl5WyhFseWQfA6PYq3Wvcx1d1XVHlLXy1sMvlHmbpNpxI8ZjwM6+wNqDNuwz0wHSOTWvEFX6jbt8zZH8psgHUnpwWZxrUCf4gyVQh7BnYreA90Qb0mWWVcE6Cv1UIqXC5RNrdtXh5NEPZPrxEinvIFWDwmNdE8kz15TDEWhNQxXzXlZpcbYyrx632eOYsPcUS2pSMJdqopgk5GPKz45kvFOV2pAoXQnOFKbFNioGfIqDLCIS1bVpOSwzRRqO2JkuMU4LkwZnMNBO3UaMNZFcCfKI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(84040400005)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(41300700001)(66556008)(66476007)(6666004)(6916009)(54906003)(6486002)(478600001)(8936002)(66946007)(316002)(8676002)(5660300002)(2616005)(31696002)(4326008)(83380400001)(36756003)(6506007)(38100700002)(107886003)(26005)(86362001)(52116002)(6512007)(38350700005)(31686004)(43062005)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2IxMEpOaUlBdy8zbXo4RGd3cVFudDk4WUI5VFBoM2JYek0vY0NNc2FwV3Jy?=
 =?utf-8?B?VWpZYWdqTnZrdHJEQ2lnWVhLTm1mZE0wQTlkSDM2ak9SRFV3KzJYMm1MV0Ju?=
 =?utf-8?B?SnJDc1k5VGF1aFhuaTdsWExiY01KQjhuUzVHL1lGV3VwVFhDS3lXMXA5cXV0?=
 =?utf-8?B?ZlpCUjZmWmZRcTNQNmg4S2ZUUythZVNaUHQyZUlXdmJFK3hPMEdyZWM4Yk9O?=
 =?utf-8?B?Qk0vYmxJS0ZEcHdWeUhWZlJYL0E1SHFUNjZyTjR5b2xGMURyVjRWQ2F4RFVR?=
 =?utf-8?B?WmNYWk9vOFR5ZStKSU1zWUgySHkwd1AzYk14dXlDcmRqZFc4MldrdVU4dk5I?=
 =?utf-8?B?WTFqN2xmZU1NaVVzTXlZQStlWXZYWkV1VlJKK2tVSFBrc0dQakpQTk1iWExh?=
 =?utf-8?B?VmJpaWNOZEgrMG9oaGxhN2ZrVVY4ckt6bWJtVXhLVU5KaTJOelRnaGgwbzJC?=
 =?utf-8?B?em13WVBKMGhoSUNxWjBiVHNwTm5lcjUydjdPbjZHdFkxdEphNTlNL2gzV2hs?=
 =?utf-8?B?SVJSZW04VTQxR29RdVd1R0pkemM3b3ZyS1lZaTVQZzJGKzlyOTBkWFUvWlBh?=
 =?utf-8?B?UlZYcjZ0Sm5FK2JHejFyWnYzTFRBc1ppamxNYVZaRmRycE8yK3BRckxGOXRv?=
 =?utf-8?B?ZnphR2FjSitBMUExcUFtaTl0SDg4eTBuYnRTZGdMeUY2WkJqczNsbDB0aTFn?=
 =?utf-8?B?YUxTN200NWhQbDVWZG45dllqMGVmMk5zMnk0MU5sbjJUbkNpa3lUZXcyeWY0?=
 =?utf-8?B?REFhalcrQTlLMUUzSC9uTHpQd1I3RGNjL2tXblhnRUI2VS9Td1AvamxlbjFJ?=
 =?utf-8?B?TFEzWmNmOUVCczZkS1c4UkFWS095aTRSSXpNWmxjd1dSQm5RNFFkS1JMVGNv?=
 =?utf-8?B?NVRtNytpcTRsOXFub3pYQk5tTDBGM3lsWVlPWFYwYjR2aklENy84Ri80MHVL?=
 =?utf-8?B?TGhHa1ZOUC9ZN3h2R3pEVERpakZzdVdOajExUGJCSXNWSGQ3NElxRTZxcHFL?=
 =?utf-8?B?K0JaOUxoYXl1Z0VoUDlhL0FnT0paQkRWb1dOcDZQem9LTXpQQW9CL2lVZ0tr?=
 =?utf-8?B?cGxlM2dOZnFQNTQ2M0p0ZFFqTEV2Rkt5QUIrc1lHK0JUYXlsL0Q2TXR5T2JE?=
 =?utf-8?B?YUpTa0ZKdThOQWdIRTFnS0FJaXUxdkhyVjVWamRNM0xwL3VZa1NScURMOEhR?=
 =?utf-8?B?aGgxZ3JaZCtvcWV4TFFzZVdjUGhpcE9BVVIyWUhEODFNbW5Rb05WS2kySzQr?=
 =?utf-8?B?S01PaDVFTFo4UzRQL0xNRGFYbmFnb0xuOVdreVVmYkovQm9KMC9vRnVMZlk1?=
 =?utf-8?B?Z3dISVZLZzBWbjk3bTZMUytDTUpjMU5yaVNtYldiaXdiTjJRam1vZmtpdHJW?=
 =?utf-8?B?ZlY5dWYxZE9NdUEzMUpJTVU5M2FBa1k4ckg3TGk2eVY2ZnEzczNOOERQcVVk?=
 =?utf-8?B?U2lnWkRpdjYrMHI1cUxwbzRQWVExWkp2bmdHSUJIS1E4SjZuUGFmYUxyT0Ny?=
 =?utf-8?B?akpyNjUvVTdwK2EyS01XL1NCM3B3dmtPWS9VWEUwdk96UGFEa040MVdCNUpR?=
 =?utf-8?B?SXlvcTJScGhTcVRsMm5qSE9VdWZ3L2lCMUI4SWRSbGQ2blZ0N1htWmdrN3pj?=
 =?utf-8?B?amlVVVZPWWhRZ1c3dHJVb2V4dzZnaytZZW5ReTQ0UjUzL2xISkFwR0ZtRlNq?=
 =?utf-8?B?dEJDd1UzdmQwRUsyUk1MdENEZ3ozVDBJSDc1aWJlL2NjUW9aR2pISE1LaXli?=
 =?utf-8?B?MkIrVUtucEVYN2NCdEs5RFE1c291aDVaUU55TGoxT0FMVmxqTlE3KzdMRkpl?=
 =?utf-8?B?T3RWU2pHMVgvMW5kTWpaVi83K0gwSkpKQkN3NGNoRCtsSmJxdTgxOVNuWUlF?=
 =?utf-8?B?QzJOUWU3cVM4YnJLMThaSnBxaDJFVytQdTJIVzYxSzA5MUQwV0hYZWFBd0NJ?=
 =?utf-8?B?TTZ6N2F4R242YzNLQmF2T21tZDZxMW03aFEvQkFIZVRPY0UxWFArZW9PMTh1?=
 =?utf-8?B?M0l1Vjg4Z0FFN0JSZTI5cytybDJ2NnFNcTZ2SGNVdUhIRlcvMXRZSUZtMkVx?=
 =?utf-8?B?RmtrVkZjSkRhOEx1ZXUxazFMcjMwN2RjNXpSeVZINW1HeEZlck9mZHMzZmY3?=
 =?utf-8?Q?ZkiCUoHX2s5FMVfPt26QQj5C6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6ec04d-3586-48e8-2af7-08dbd4361ef8
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 02:08:31.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19mawDtdx9xkrsHv8QwKJJP2IQjf1OG6pd6fqwgDj4jnBCKliBYJORGBwLLL2tolg/LFNgghq4YOijJM1zFFUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/23 21:01, Matthew Wilcox 写道:
> On Mon, Oct 23, 2023 at 08:44:55PM +0800, zhiguojiang wrote:
>> 在 2023/10/23 20:21, Matthew Wilcox 写道:
>>> On Mon, Oct 23, 2023 at 04:07:28PM +0800, zhiguojiang wrote:
>>>>> Are you seeing measurable changes for any workloads?  It certainly seems
>>>>> like you should, but it would help if you chose a test from mmtests and
>>>>> showed how performance changed on your system.
>>>> In one mmtest, the max times for a invalid recyling of a folio_list dirty
>>>> folio that does not support pageout and has been activated in
>>>> shrink_folio_list() are: cost=51us, exe=2365us.
>>>>
>>>> Calculate according to this formula: dirty_cost / total_cost * 100%, the
>>>> recyling efficiency of dirty folios can be improved 53.13%、82.95%.
>>>>
>>>> So this patch can optimize shrink efficiency and reduce the workload of
>>>> kswapd to a certain extent.
>>>>
>>>> kswapd0-96      (     96) [005] .....   387.218548:
>>>> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 nr_taken 32
>>>> nr_reclaimed 31 nr_dirty  1 nr_unqueued_dirty  1 nr_writeback 0
>>>> nr_activate[1]  1 nr_ref_keep  0 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>>>> total_cost 96 total_exe 2365 dirty_cost 51 total_exe 2365
>>>>
>>>> kswapd0-96      (     96) [006] .....   412.822532:
>>>> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 nr_taken 32
>>>> nr_reclaimed  0 nr_dirty 32 nr_unqueued_dirty 32 nr_writeback 0
>>>> nr_activate[1] 19 nr_ref_keep 13 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>>>> total_cost 88 total_exe 605  dirty_cost 73 total_exe 605
>>> I appreciate that you can put probes in and determine the cost, but do
>>> you see improvements for a real workload?  Like doing a kernel compile
>>> -- does it speed up at all?
>> Can you help share a method for testing thread workload, like kswapd?
> Something dirt simple like 'time make -j8'.
Two compilations were conducted separately, and compared to the 
unmodified compilation,
the compilation time for adding modified patches had a certain 
reduction, as follows:

Compilation command:
make distclean -j8
make ARCH=x86_64 x86_64_defconfig
time make -j8

1.Unmodified Compilation time:
real    2m40.276s
user    16m2.956s
sys     2m14.738s

real    2m40.136s
user    16m2.617s
sys     2m14.722s

2.[Patch v2 1/2] Modified Compilation time:
real    2m40.067s
user    16m3.164s
sys     2m14.211s

real    2m40.123s
user    16m2.439s
sys     2m14.508s

3.[Patch v2 1/2] + [Patch v2 2/2] Modified Compilation time:
real    2m40.367s
user    16m3.738s
sys     2m13.662s

real    2m40.014s
user    16m3.108s
sys     2m14.096s

Thanks

