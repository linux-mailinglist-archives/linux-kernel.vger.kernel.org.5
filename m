Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4FD7790DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjHKNfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjHKNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:35:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6409719E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:35:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km1caumKuGu89UCecbWHXIzYX7RvbFrOx02pMoBYvtdqmFDgaF8TADj3yO9IGLsqLfy7TZlw/ezuK+9C8+XjkJrL2OoJ21Zmn7un0JnjSPSkyQqxvw8JMb62ANq1gY5qwT9KQaIImBTDP7zQL3w4gPI3BMOPF1BA2uR4e25QbvxRWjMrBUJK3Nabnhwc0c14xwEg76OPI3SqNFf03lPV11KxNQWLFTGI/kWSd+4iYU5wB4pl11Mlph2zyYLVBc4dCRA59esY7BDO9qcfNzBAGNZ8yhz/Fpdn4m7P+UdqHTl4GHJvyxBTRCwV3junbZA19P2+T1vD+wy/vzdAupAtyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCtb+r1GQarEEJZl9DBsTpsPAKYdmLPynqFVS5mHZBQ=;
 b=KhGaCkMtCSzcCq6N61ceiCLAGpjbOgJpwjOV3DCcnmf6OSetUXi7oLrWH/o8bsLi7/eQGYIuxVJG/dS8I+mWx5BKrLapCKbn3kAFxPIlvVLwl6ddQEpIIHnCDFxftkZzQtvrjQQ4KlpgF2rkCCNn4wTqYOhS3SNKYtdDejh64TLUXMiBogdp8/SX8474L4prDy49pnLeEzUgc6DQhejv300bhGEPURBz5ETQ4AtBIS+S1U1yu5Vpy8qoX0gazP27+8kJ1g6wZWu6K1IqPuOqVqe604oAoDbrk9EwxzYE55kh4vDxrYJri2qvjZdU8efO6/1KkAxMWtMu9Et4DZfz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCtb+r1GQarEEJZl9DBsTpsPAKYdmLPynqFVS5mHZBQ=;
 b=uFm3/577hBdWCBcmGBQNplaWO4y+4QilgC9IdZcGGe/Lu/Fc1vkMyZNTJ1lVDof6of4o4cmyxvdWU5jGbxU/jYczUDAuJcDynf68pyb0b08uQ8mJHyExe/WUsVP9ouH8k91z7imZ58VU6DMCfsyLW7c9sZl6gISYzOMbYB2zgyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 13:35:31 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::1ddb:13ad:2eae:53cb]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::1ddb:13ad:2eae:53cb%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 13:35:30 +0000
Message-ID: <8cadfcd2-3b11-a7af-6f80-ace309562ed2@amd.com>
Date:   Fri, 11 Aug 2023 19:05:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V3 1/1] sched/numa: Fix disjoint set vma scan
 regression
Content-Language: en-US
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>
References: <cover.1685506205.git.raghavendra.kt@amd.com>
 <8581ca937d4064b3cd138845d5bd418580d177da.1685506205.git.raghavendra.kt@amd.com>
 <20230721151834.yaymi6emrppl3mzl@suse.de>
 <77632c46-edd1-36bc-1f2b-d3c82b0d5ebc@amd.com>
In-Reply-To: <77632c46-edd1-36bc-1f2b-d3c82b0d5ebc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::14) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f8fe57-425e-4455-87a2-08db9a6fd497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgeF+ysy90iXDWqmk2BUdJj1dxy/DWKxxlLC+pcdK/42NcK3Yr3ZTV18tJbOO+7lMSyXuymelLJP8c9dMxPzq6LNdqQIBorA+jke4/FphO9OPSJV4auNqinTy/WuCPJAdQ+Kaa6WvMnn8Px8HzoxcTgI8WgcJdN6M4T0k9LBkB6TMy7RofJga61gecvDbaK9gvHG7IZmyJoY/7o4GIGt5XKMdLeEs9oFfO4MxFVT9WT5sPjALNG+ae+amGN46qAEBPXuoiML3IcdjOBAoQfLM+eqrSYYUOaIRLIpUGR6tSAtbU7aQFjg0RwFEHp9WsA0XuzF6B+o6A1l8o4dYCsIALGG++cAbp8HsdBbaAr7Hn/A9JcDB5hei9VACQZFWR7YDPIxJALd9cbXUizVN9f9xBlNR3vY8BMB6QZC78hwHQpmQsQAY9GGJZpIBL4U2D07tqqfaNZB7x3c7vJ8G16NeRXhu97037uOF2EeolNGnhXJKOpQcuAS57zBx38nUhVF8VtQbTYMAg69BCTPWpPjgUHUSAIEoQPtXq8ben1dJDzz8e0j0yU9VUPySADAVZZKsKuMXDp+fPC2te+xDobaEWv410KILe4CYXp985soWFRsqqeQ7vdRzJXYHPHzPIGN9KOVwYEea8JDmIH9dde7Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(39860400002)(376002)(1800799006)(186006)(451199021)(6512007)(31686004)(966005)(54906003)(4326008)(5660300002)(66476007)(66946007)(66556008)(6916009)(6486002)(316002)(478600001)(6666004)(41300700001)(6506007)(8676002)(26005)(8936002)(53546011)(31696002)(7416002)(36756003)(2616005)(38100700002)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXcrTk5UdzVpQmhkM1JzRkM0ZHhCeTVRcjhrSFNicnEyRlJpYkhvM0RlcFY2?=
 =?utf-8?B?bnQ4Wk1ZSVo3TGluM25kQ2hURVJkdm42cUMvbnNRMjhoWWJHbU15Rm5HNUZS?=
 =?utf-8?B?Nm80VG9aTlRQelp1bnRjcVZlaUtlcDN4ZjdFY0Vuc29jemg4R1oyYjdBRzU0?=
 =?utf-8?B?YWVQdFI3aXM1bm5XbUNFVjBXMjJsV1FOa0FXMEJMWlpXYmhSVFgzWEwyUkpt?=
 =?utf-8?B?cWEyUGIvWjZ0eHpxSUJWYnpGNDVBRXo5RUxWNHlHMktHNWpHRk1UWHpZWTZl?=
 =?utf-8?B?RWR3SWFoRWJqY3hkWXdXR0RvZWNXUUtnczJPbjlHdU5sdU4yOVFMNm4zLys4?=
 =?utf-8?B?bnNsdGN1U3dpS2lXT1NwdVdVd0ZyYlBNYnlQM1dLeG1DTlIyWnR2ME5DNnF2?=
 =?utf-8?B?OXFjYXcxdUxlOGxadXdGODlFdGtoZXQ5YmFqYmk0MWFBZ29scHRtMjhIdDd0?=
 =?utf-8?B?L0srYUl3byt5M2cwYVM5cTkyc290bldDRVRpNFpRRmRmUzFaTUI1ajJVWm8z?=
 =?utf-8?B?TDNKZ3ZnRUFRdFluQWZNMmNadGNpUE5CY3VHb01ia1JaNy9CNVNldlp0RVVj?=
 =?utf-8?B?UFlKdHIzNk1UQkdjZnRuNXd4N2w4OW4wR1VicGRLMlNEejFQRDFGdURBemJi?=
 =?utf-8?B?a1JiR2FsbzhCQ2V2MHh5bFcxQWdnZmE2Sks4d3dPTEtrRW91OWJ0N09qbHcw?=
 =?utf-8?B?SmpoeUJUbU1sTTFhWmdlU3RlYjVqQUZScy9IR0JhV3V6bjZyb29xaUpPTzNz?=
 =?utf-8?B?QWdtL1JSK0VZME9lYW1sWlJRdStvZ2ZLcTZaY0dhQmpiVXNXeTlHQVN4VkQy?=
 =?utf-8?B?RTNTcVQ5eVpNazFMV2xUTit3akVaZ1FlTCt0c0NaUUYrQkdDaVVQaGZ4Qndt?=
 =?utf-8?B?YUhyVzFWVDY1bUIxMnVmb2J2dFVWVVZPYVkvMkNJVVFGcXk4WU4zWFBoSkdX?=
 =?utf-8?B?UzBRM1BWL0I1NGJtYlhCN0Zpb0lwUVFtQkFBcm9TN1ZJVjJJMXFoN0UwYVdt?=
 =?utf-8?B?akVuZXFZeXRYZGNXa1VGT1RFMHFMQTZ0UnU0N0NYUHNTYzBtdlVJVWlOTjg2?=
 =?utf-8?B?U2VOc01GRFFCVTZTR2UybVBWamduUHhZZk1uRVUxLzB6S1psQkY3aFdhT1NH?=
 =?utf-8?B?UFI4U3cySmNpTkJPc1QvcmFueWdNU04xa0kvbThrQU9zVVlzVnE4M3RlS0t2?=
 =?utf-8?B?Y0QzcTdiL0ZneTl5VjdYUlgwR05tbkZ4c2tmL3FySk5xdUxhMVQrTlRPaTlx?=
 =?utf-8?B?QlZwTUdHOHc2TWd4VUt5YmhCNE9obElLK0ZlMzJURHNnWmwrK2hJUUhWek11?=
 =?utf-8?B?K0p4M3laL1FIL3o2emJjL24vTmpwaE91bFhBekVvdzBEc2IxL2FNYy83dGZC?=
 =?utf-8?B?cEMweXlRa0hEYllIdXJnSjB4N25KN2N5eW12OXBtMnNGd1NtWWZMaXA4UE1J?=
 =?utf-8?B?TkZRanVUUUVoUDZhbFNqYkVJSFozWHBuZE1pbjNxeUlqczI0bGp3N2Y0MVBM?=
 =?utf-8?B?RlZGZXdLTUtQMWhQLytVZTI3L0VnU0h1WGFFMW5QZG5JbDB4WFhOWnZQRk9p?=
 =?utf-8?B?VEJqZUVCYUYrQys4cGlac1VpOVB2UVNUQUZmSlJhdjlxRWphZ1N3RVpieGh3?=
 =?utf-8?B?bkcxL1BUbndxdk5FeGxjYmwveVFoSi9INjd4UHk0eHRTRW9FeDVTTU5GemJN?=
 =?utf-8?B?a1Q3Z1oxU1ZMZ28wRmpYMWJTbUR6VXhzcSt3K09WNitYZWxZRmJmRllWcGM1?=
 =?utf-8?B?c0d2dXNWdEU2QitpU09yWVR1aWNFVWFzTmlKRkt0SVJHdjdNdkplNmI2NDdC?=
 =?utf-8?B?ZFVSUVZ6V0ordXk2ckk2ODZqQk9tT1JMTm9vMkRkMnJUaVZDa0ozMUpSQStT?=
 =?utf-8?B?WjIzOE1qcE1HeVVWUEQ5M3Q2Y3hjZm8xdk1ZSk5mMVFpL0xtMUxCN0FFcU1Q?=
 =?utf-8?B?T0RuZDRqbnNxTFhhNXpZdzFPcXZwTEtzcnRWV1BpaXRQZE1yUDVwMlJzeVZm?=
 =?utf-8?B?d09GSXFBQUdoVCswb2VNL3NLdUJQeVdXdEpLUXVnWVZ1QUZSSlZqS0pPKzVt?=
 =?utf-8?B?WHlKclU5NXg5UGFmUU9UZ0J3dDkrTkx6L1JNTHlFS0JqZ0hRdnJuaGtNN3NI?=
 =?utf-8?Q?MBAfd5AITLoRJ6jJRLDOu/hTu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f8fe57-425e-4455-87a2-08db9a6fd497
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 13:35:30.7660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zgegnyl9YVDEGTX8VtaE87g21VwI8cAGhSPyR+Rr4HRF0CduccpbxdAFUPZVMR9lVtBQcYuzXBPAKPdW1YCeSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/2023 1:11 PM, Raghavendra K T wrote:
> On 7/21/2023 8:48 PM, Mel Gorman wrote:
>> On Wed, May 31, 2023 at 09:55:26AM +0530, Raghavendra K T wrote:
>>>   With the numa scan enhancements [1], only the threads which had 
>>> previously
>>> accessed vma are allowed to scan.
>>>
>>
>> I know it's very late to be reading this properly for the first time.  
>> It's a
>> brief review as it's late but I'm not 100% convinced by the patch as-is.
>>
> 
> Thank you Mel for the review.  Expert opinion / intuition from you,
> PeterZ helped, helps alot to improve to solve the problem in better way 
> finally.
[...]
>>> ---
>>>   include/linux/mm_types.h |  1 +
>>>   kernel/sched/fair.c      | 31 ++++++++++++++++++++++++-------
>>>   2 files changed, 25 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>> index 306a3d1a0fa6..992e460a713e 100644
>>> --- a/include/linux/mm_types.h
>>> +++ b/include/linux/mm_types.h
>>> @@ -479,6 +479,7 @@ struct vma_numab_state {
>>>       unsigned long next_scan;
>>>       unsigned long next_pid_reset;
>>>       unsigned long access_pids[2];
>>> +    unsigned int scan_counter;
>>>   };
>>
>> Vague name as it's not counting and gets reset. It might have been 
>> clearer
>> to name is something like scan_selective with an initial value related to
>> the VMA size that decrements. When it hits 0, the scan is forced *once*
>> for the unlucky task. The suggested name is also bad, I'm terrible at
>> naming but "counter" gives no hints either.
>>
> 
> Agree that naming is bad, will use scan_selective / or try if I get more
> idea on naming.
> So you are suggesting to try other-way where we force scan once we hit
> zero. Looks fair to me. will try the idea and see how it goes.
> 

Hello Mel,
Sorry for going slow from my side. I was experimenting further with
combination patches,  I will be posting set of patches that I mention
further down here.

Just want us to be on same page, posting full description of the
problem, details of solution, and how it looks like (code) etc

Also sorry for long description.

Problem statement (Disjoint VMA set):
====================
Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
vma scanning is allowed if
1) The task had accessed vma
2) Early phase of the scan where mm->numa_scan_seq is less than 2
   while this works for most of the times to reduce scanning overhead
   there are concerning corner case(s) associated with it.

Let's look at these corner caseswith below example of tasks and their 
access pattern.
Set 1 tasks accessing vma_x (group of vmas)
Set 2 tasks accessing vma_y (group of vmas)

              Set1                      Set2
         -------------------         --------------------
         | task_1..task_n/2 |       | task_n/2+1..task_n |
         -------------------         --------------------	
                  |                             |
                  V                             V
         -------------------         --------------------
         |     vma_x       |         |     vma_y         |
         -------------------         --------------------	

Figure. (1)  Tasks accessing disjoint vma

Corner cases:
(a) Out of N tasks, not all of them gets fair opportunity to scan. (PeterZ).
suppose Set1 tasks gets more opportunity to scan in the above example,
then vma_x gets scanned more number of times than vma_y.

some experiment is also done here:
Link: 
https://lore.kernel.org/lkml/c730dee0-a711-8a8e-3eb1-1bfdd21e6add@amd.com/

(b) Sizes of vmas can differ.
suppose size of vma_y is far greater than size of vma_x, then bigger 
portion of
vma_y can potentially be left unscanned since scanning is bounded by 
scan_size

(c) highly active threads trap a few vmas frequently, and some of the 
vmas not
accessed for long time can potentially get starved of scanning indefinitely
(Mel) (because task access history gets reset periodically. Not sure if this
is is a bigger issue if vma is not important but on the other hand we 
will be
  left with no hints for migration later if necessary)

(d) allocation of memory in some specific manner (Mel).

(e) vmas that are created after two full scans of mm (mm->numa_scan_seq 
 > 2),
will never get scanned. (I have not seen that occurring in some rare cases)

on top of this Combination of some of the above (e.g., (a) and (b))  can 
potentially
amplify the side effect of numa scanning overall.

High level ideas to address the issue:
===================================
Idea 1) depending on vma_size populate per vma scan_select value, 
decrement it and when it hits zero
do force scan (Mel)

this is how vma phases looks like after implementation:

|<--p1--->|<-----p2----->|<-----p2----->|...

p1: new vma, initial phase do not scan till scan_delay

p2: allow scanning if task has accessed vma or vma_scan_selectiv hit zero

repeat p2

pros/cons:
+  : Ratelimiting is inbuilt to the approach
+/-: scanning continues forever
-  : changes in vma size is taken care after force scan

Idea 2) Have a per vma_scan_seq. allow the unconditional scan till 
vma_scan_seq
reaches a value proportional (or equal) to vma_size/scan_size

this is how vma phases looks like after implementation:

|<--p1--->|<-----p2----->|<-----p3----->|<-----p4----->...||<-----p2----->|<-----p3----->|<-----p4-----> 
...||
                                                         RESET 
                                      RESET

p1: new vma, initial phase do not scan till scan_delay

p2: allow scanning if task has accessed vma or vma_scan_seq has reached 
till
    f1(vma_size)/scan_size) for e.g., number of scan to cover full or 
half of vmas

p3: allow scanning if task has accessed vma or vma_scan_seq has reached till
    f2(vma_size)/scan_size in rate limited manner (Optional)

p4: allow scanning iff task has accessed vma

Reset after p4 ( f(scan_delay) ??)

and repeat p2, p3 p4

+  : Ratelimiting need to be taken care separately if needed
+/-: scanning continues only if RESET of vma_scan_seq is implemented
+  : changes in vma size is taken care in every scan
-  :

Additional optimizations (unconditionally allow if vma is hot
i.e., either accessed very recently or number of tasks accessing vma
is very high)

Idea 3) Take bitmask_weight of pid_access history of vma. (suggested by 
Bharata)
(vma->numab_state->pid_access[1] | vma->numab_state->pid_access[0])
  If number of tasks accessing vma is > THRESHOLD (say 3),
  unconditionally allow scanning

Idea 4) Take bitmask_weight of latest pid_access value 
(vma->numab_state->pid_access[1])
If number of tasks accessing vma is >= 1, i.e. recently accessed
  unconditionally allow scanning.

Other ideas still to explore:
5)  Can we maintain more pid access history (vs last two as maintained now)
The whole idea with code has been already given by PeterZ.

Some of the observations from my experiments:
-----------------------------------
- It is very critical to allow scanning after initial scan_delay (as 
mentioned by Mel)
so as to capture early patterns.
- It is also important to limit (or rate limit) unconditional scans to 
avoid excess
scanning overhead.

Example code for idea1:
=======================
static inline unsigned int vma_scan_ratelimit(struct vm_area_struct *vma)
{
         unsigned int vma_size, ratelimit;

         /* vma size */
         vma_size = (vma->vm_end - vma->vm_start);

         if (vma_size)
                 ratelimit  = (1 << 15) / vma_size;

         /* for 4KB vma rate limit is 1 in 9 */
         /* and for > 64K it is 1 in 2 */

         return 1 + ratelimit;
}

static bool task_disjoint_vma_select(struct vm_area_struct *vma)
{
         if (vma->numab_state->vma_scan_seq > 0) {
                 vma->numab_state->vma_scan_selective--;
                 return false;
         } else
                 vma->numab_state->vma_scan_selective = 
vma_scan_ratelimit(vma);
}

Example code for idea 2:
=======================
static inline unsigned int disjoint_vma_scan_threshold(struct 
vm_area_struct *vma)
{
         unsigned int vma_size, scan_size, threshold;

         scan_size = READ_ONCE(sysctl_numa_balancing_scan_size);

         /* vma size in MB */
         vma_size = (vma->vm_end - vma->vm_start) >> 20;

         /* Total scans needed to cover VMA. Add minimum of one */
         threshold = 1 + (vma_size / scan_size);

         return threshold;
}

static bool task_disjoint_vma_select(struct vm_area_struct *vma)
{
         return (vma->numab_state->vma_scan_seq <= 
disjoint_vma_scan_threshold(vma));
}

Example code for idea 3,4 combined:
================================

#define HOT_VMA_NR_TASK_THRESH  3

static bool vma_is_accessed(struct vm_area_struct *vma)
{
         unsigned long pids, recent_hist;
         unsigned int hashval;

         recent_hist = READ_ONCE(vma->numab_state->access_pids[1]);
         pids = vma->numab_state->access_pids[0] | recent_hist ;

         /*
	 * Check if vma was recently accessed OR
	 * vma is being accessed by more than 2 tasks
	*/
         if (recent_hist || bitmap_wight(&pids, BITS_PER_LONG))
		return true;

	hashval = hash_32(current->pid, ilog2(BITS_PER_LONG));

         return test_bit(hashval, &pids);
}

Additionally, to Implement vma_scan_seq reset have used something like

#define VMA_SCANSEQ_RESET_PERIOD        (4 * VMA_PID_RESET_PERIOD)
/* this is to recent per vma scan_seq */

I will be posting combination of idea1 and idea3, idea4  by next week
mostly as a new enhancement series.

(OR idea2 and idea3, idea4  in case you have any positive thought about 
idea2)

initial results are looking good for both the ideas, I am taking more 
time to
experiment further and fine tune.

Thanks
- Raghu
