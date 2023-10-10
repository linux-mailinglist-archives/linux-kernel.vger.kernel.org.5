Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A427BF9FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjJJLme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjJJLmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:42:31 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C17AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChXxUeHgIYfm4pnwkiZJXrpT0nY0ZWsbN3PGL2JzarcKRikwNmEcVsD5lvvqWFi4gC4Zxn4CEskq3G9PouS/5JeOqiJN9UBt3hjD+N7KfJD81egRUKJF/bJButSnllTlduRB37C94W8UTwO2Ols6GZgwi8KZc4orwgndQWsbLx7GHdB7CUajzdlJq8Gi4RFDTlTe72mi4Bf5iw2gnkWWdMoH87go1MaQ59QKp2tJPmefan6LN4FuSmTEGz6dusEPYFpjkiFAQoGrHMFv2RRtz38MBUiMVf5Rb1zKu5sBBEO30/w+vJnSTBJAFWGtPtnG42RzMFrfTfsAkhQamIWqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOYqy8Gvdgkj6TkEeij8+K/R3JnB/oALlg/E2319skk=;
 b=Lv2Rov/u37R7ZyzdDaLu6S5Mqm6kXv2mDY600UtFrE2jrEKDbZSHtbVypBe7pvmOmpBUK1vaOF3NdM52qHVdY5Phj3DIZDg6naEB5IkgfIKkj28+9gWeAzc+mV2yN7hx0MAW0aCylaPrFrai+7gR4zpHaf0UBdU+IDi0rqrMUWxfIEA7/jVANzYFTTS+4aw8OBylLgYdgIqeTlLmlba9GHgsU9NwwSncjhQsRet+ym5YMARg39ceRYOc59Wi5EOBLAjU4CMlJe85RPP43UBlti/7bHh8RGzCMxRNBgixliZoDxMfNSxACDnW89Dreaw/7YCJPXDagztS2GNng8uTDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOYqy8Gvdgkj6TkEeij8+K/R3JnB/oALlg/E2319skk=;
 b=ovzwhQKGZ7/rUloN3mxJKcQLDsRc0ZkLwoooVWb5CYkxC6qoTJvL/ZqkCSSNvBw91RQwFkCMaCRqxkEUTkLzBKDeWedX7iLnIe9BPIki8mguW8G7ZBtK9Lq1+7MkYbAYRVI040WDXAIy+DDJ8qgovrHTsKFCCn4KaUc1WlUMg5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 11:42:27 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187%3]) with mapi id 15.20.6863.041; Tue, 10 Oct 2023
 11:42:27 +0000
Message-ID: <18236c47-8673-c6ed-0f1b-3e1d1ae4f8de@amd.com>
Date:   Tue, 10 Oct 2023 17:12:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 6/6] sched/numa: Complete scanning of inactive VMAs when
 there is no alternative
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20231010083143.19593-1-mgorman@techsingularity.net>
 <20231010083143.19593-7-mgorman@techsingularity.net>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20231010083143.19593-7-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::31) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf60c39-fe0b-4563-9dea-08dbc985fa6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWcsLzqyAAx7J5LXg8ZGCFjlyVjzMR+qKGM+UG074TzSzRHHZ2aNpJthdAvcLxSXCRrjr1A2G1L5UHgY/e54CGtUFm80Og6o0qQI70fpGdtsNIharzPiWa9yNMmo5gUtkghpn+w/N2bPBPtF40FrkfmMByatZVjIf6nwGBeNxYdVxC/cntWZoXHi5OWzMt3cnEfLf90ci862U8Hqa3VxH4K3jXGPOuY/51cIbl3ftys6EvKPeFpPRHzEOX4p8d1l6FwLGNCsTHG8zK+Km7l9v+XAGyl3inGtvIV3SJjgWyabjdYN5PtIt0w0UV0JPovYvBxGA6OZQieUYSmKddZ5E9PozxAt3XCR67k2RurAq5Ypvz9wfiawDN6Us6jXpBxopr0b8aMO58upZ1U1qvlHnZIvvvw8AISrkEUMOFJxgsKQMnCJbFl1AF1nwGyR7k3XfRPwnygjp3EK4jpCGYZ4NLPuyVk6fI8FvfCf4Uvkv+lyaU8ImPHv8AHdcxqDDBNsciASSWD7JhIfa+f9U7ZzhnwfC4tTqyVk29l6rLxYMGJC384Ahc37aGsd+MpDndUsuKiFqOvQJnFWb//Drh8a96PNdlPoZQuOytyy7QPoavPfj4cYuBWQgVb65yr4ibfm7HrQSZaMW0JUFCT3UqfsfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(31686004)(83380400001)(26005)(2616005)(53546011)(31696002)(38100700002)(36756003)(478600001)(4326008)(6506007)(2906002)(8676002)(6666004)(6512007)(110136005)(5660300002)(8936002)(6486002)(316002)(41300700001)(54906003)(66556008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1dOQ1J3Nytxb0xMZ3h2YXJiUVdGWGpzQmZRZTVJTzJqZldCZ2pTQ09WN0t0?=
 =?utf-8?B?NHp4R0tSU1JFNWloWWNqazVzbFU4ZTdzRU9pV0U5ZlB3cmpWTDIxMmFNK3lJ?=
 =?utf-8?B?Q3M0N2hFMGxnOHBIaWpMOFloTUxxcFFPMEtjUGFodXVqR0V0VnYyU2c2WHBP?=
 =?utf-8?B?eVJJMHBKUEFxMUt5eEFQYnE5UWtYS1dLd3hOczR3MHNZcXdYSDlPM3lrNG1n?=
 =?utf-8?B?MGtyU0pWNFBUK1ZBMGFIQmdEaTByT2JtZFdyZlJOUlNscW5GaXI5WDNkMjdU?=
 =?utf-8?B?TVVFekRkb0p4Qjdpc1RBVzRCVEllR29yZlV2aXJ3eFFBVU1Rbm9JenVwbnlX?=
 =?utf-8?B?N3ZHaERCRWlCYXlJaGJ6aUZrSmtqZFlDUWxtdHBSZWc2OUZINmJvODcrUDdF?=
 =?utf-8?B?WkIwOVdCU3grZ0EvQ2dmL1ZyNElnNVkyRkcyTmQ5UmM2UFBpQ0xVNi95V2Rl?=
 =?utf-8?B?WnJRTkVYK2pHZHNXM2w5aUhpb3VRRVlmWDdRbFlwWU1WNEdld1E3YlFWZHFi?=
 =?utf-8?B?SW55UHU1eVFwK3BXQjFSTjA5VGUxRDEvcmJPMGczb1VENjg4dlZCeHVZTURI?=
 =?utf-8?B?V3FzR3EwQnFhbnpBcDZ2UmxvcW42WVE5Q21aREpyUlVTazZkMmMxVWlBZWU4?=
 =?utf-8?B?NFhlVVpSQ2hUNmN3dlRicHBOcGc5Q25ETm80MkF4NmlvTHR3eEV6ODg3T0dX?=
 =?utf-8?B?Zkt2ajZBbmhsa2l4SWZESk1zc2hLN0NpS1RONWFIbENoa09zSDFTRS9pWjVP?=
 =?utf-8?B?V1NrWFJKM1VTdFBHTjBQN1Bsb0Y3ajlXTk5LQ3IxRlAzSG12dGZEUkY3SHQ2?=
 =?utf-8?B?U25qK1FqRG43bUhkMTJKd0VQVCtYbWsrcTZ3QXNJd2drMFIzRmI1RVBFVzlP?=
 =?utf-8?B?UjJxY0dDVERVb3FBeERZZVZGNmVmRjdiRnIzZGZBWFdweHU1WUE0VGlIU2xz?=
 =?utf-8?B?eTBHZlQxalJLU3VNWjlrb2V4Kzc1Sm5QRitHcU55MGRsd3FDOHduYmlVUTJG?=
 =?utf-8?B?OTFacUVCOHRpTUxVaUZ1VmxlYUdrVGU5ZlN4cjdzZjhzRENzYW9TZzA2OXpG?=
 =?utf-8?B?L3BLYUtXc24wNmo2d1FsQlMyYnhQa2ZmZnVYNTAzdEhJZDVKQklpMmc4NmRj?=
 =?utf-8?B?QWREN3NwVFhZMXBEQmdMbUE1R1VvOFdENHd3UWM4Vnd6RERxa0NYa1dkdWM2?=
 =?utf-8?B?QUE4NmlCVzJySDJYMzV2d2hwQXIxbzVheWRPeFR1aG55UWdjUW82RDJkRUFs?=
 =?utf-8?B?YytFakQ5UDZKN0t4cUgrUHlTRHFrc213T1BkamZPVUpqYk5hSlA3Rll3Rkpp?=
 =?utf-8?B?N0NjS1FMY1VndkpLYThQdWJvYWkzVkRtT3FHYkxKTTYyVlowMTJadXFrWGV5?=
 =?utf-8?B?c3crZXdmdnRrR1RvRnB3bnlsazlNOHRza1VLc1lYdGM2bGQzWjE4SFJJQ0cv?=
 =?utf-8?B?ZWJyeFpmQXZCODdsSENtY3h2eHRINGhUT1BOYjJTQXkyZjl4bVUvWk5LdmZS?=
 =?utf-8?B?RjI0bHA0cE9uaGhKUVE0UTdJMXY1ZEs1bGlsak9zaSszR3gvdkNOUW5YL0ZM?=
 =?utf-8?B?ZFRWdUpSRzRSc2xpRmt0YlM1UnY5SEE4cjVEZUxMWDg3Q2JBUDhmU20rbEJ1?=
 =?utf-8?B?akVBWERoYnNzVUJJVE9CLytVZ0JhZ3dRN2lRcFdob0p5U3NDbnFsRFB5ajJZ?=
 =?utf-8?B?eFlWeXhKYzVIVEYvUkNDVUdZRlpUcC9mSXZ6eUYydUhZL2hJZVRBcTQ3VC9x?=
 =?utf-8?B?VlhoSzdta1BzRTl4Mk1mclhOK1lBUkFIWmwrSDN1SDQzZysxd3I4dnBGWm1o?=
 =?utf-8?B?MUNDc2U4djF6YnhnbFVCb3NmRkpmVTZvVDhFNU1NcDJHcSt4MFV0QzVTd25j?=
 =?utf-8?B?eHJvZko2ZWhsWVVscHdJUEZLR0pJbHg3MWJHeXFGT3QvdGJDeEZiMkNXczdH?=
 =?utf-8?B?UVFwQ3lYWTkvTzlrcE4wbHNLd0pnYVRTaWFVVU1yQjJFU3hnMG9EaGUrTU54?=
 =?utf-8?B?dUgvTjdiVXZGdDRnKzZ6dWVwNjFvOTBpai9BSzAwMkViV1FQcTZVR3lSUmV6?=
 =?utf-8?B?a1lzODY3clNKS1Q5ZCtXWEhWVjZ0NmxXa0JJaVc5NnJTOThMVUJmbGxjaTdq?=
 =?utf-8?Q?/zPhT/e+8MzBFI20MLqiwiRpI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf60c39-fe0b-4563-9dea-08dbc985fa6b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 11:42:27.5093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfeotK9RHqNkOfwUitNbnzFQ9cHRSKCInonVi5FPYAkS1FBbjMdJ1J/AwDc1yMaDfZXV5Sr/5h8JDKsEcsk3mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 2:01 PM, Mel Gorman wrote:
> VMAs are skipped if there is no recent fault activity but this represents
> a chicken-and-egg problem as there may be no fault activity if the PTEs
> are never updated to trap NUMA hints. There is an indirect reliance on
> scanning to be forced early in the lifetime of a task but this may fail
> to detect changes in phase behaviour. Force inactive VMAs to be scanned
> when all other eligible VMAs have been updated within the same scan
> sequence.
> 
> Test results in general look good with some changes in performance, both
> negative and positive, depending on whether the additional scanning and
> faulting was beneficial or not to the workload. The autonuma benchmark
> workload NUMA01_THREADLOCAL was picked for closer examination. The workload
> creates two processes with numerous threads and thread-local storage that
> is zero-filled in a loop. It exercises the corner case where unrelated
> threads may skip VMAs that are thread-local to another thread and still
> has some VMAs that inactive while the workload executes.
> 
> The VMA skipping activity frequency with and without the patch is as
> follows;
> 
> 6.6.0-rc2-sched-numabtrace-v1
>      649 reason=scan_delay
>     9094 reason=unsuitable
>    48915 reason=shared_ro
>   143919 reason=inaccessible
>   193050 reason=pid_inactive
> 
> 6.6.0-rc2-sched-numabselective-v1
>      146 reason=seq_completed
>      622 reason=ignore_pid_inactive
>      624 reason=scan_delay
>     6570 reason=unsuitable
>    16101 reason=shared_ro
>    27608 reason=inaccessible
>    41939 reason=pid_inactive
> 
> Note that with the patch applied, the PID activity is ignored
> (ignore_pid_inactive) to ensure a VMA with some activity is completely
> scanned. In addition, a small number of VMAs are scanned when no other
> eligible VMA is available during a single scan window (seq_completed).
> The number of times a VMA is skipped due to no PID activity from the
> scanning task (pid_inactive) drops dramatically. It is expected that
> this will increase the number of PTEs updated for NUMA hinting faults
> as well as hinting faults but these represent PTEs that would otherwise
> have been missed. The tradeoff is scan+fault overhead versus improving
> locality due to migration.
> 
> On a 2-socket Cascade Lake test machine, the time to complete the
> workload is as follows;
> 
>                                                 6.6.0-rc2              6.6.0-rc2
>                                       sched-numabtrace-v1 sched-numabselective-v1
> Min       elsp-NUMA01_THREADLOCAL      174.22 (   0.00%)      117.64 (  32.48%)
> Amean     elsp-NUMA01_THREADLOCAL      175.68 (   0.00%)      123.34 *  29.79%*
> Stddev    elsp-NUMA01_THREADLOCAL        1.20 (   0.00%)        4.06 (-238.20%)
> CoeffVar  elsp-NUMA01_THREADLOCAL        0.68 (   0.00%)        3.29 (-381.70%)
> Max       elsp-NUMA01_THREADLOCAL      177.18 (   0.00%)      128.03 (  27.74%)
> 
> The time to complete the workload is reduced by almost 30%
> 
>                     6.6.0-rc2   6.6.0-rc2
>                  sched-numabtrace-v1 sched-numabselective-v1 /
> Duration User       91201.80    63506.64
> Duration System      2015.53     1819.78
> Duration Elapsed     1234.77      868.37
> 
> In this specific case, system CPU time was not increased but it's not
> universally true.
> 
>  From vmstat, the NUMA scanning and fault activity is as follows;
> 
>                                        6.6.0-rc2      6.6.0-rc2
>                              sched-numabtrace-v1 sched-numabselective-v1
> Ops NUMA base-page range updates       64272.00    26374386.00
> Ops NUMA PTE updates                   36624.00       55538.00
> Ops NUMA PMD updates                      54.00       51404.00
> Ops NUMA hint faults                   15504.00       75786.00
> Ops NUMA hint local faults %           14860.00       56763.00
> Ops NUMA hint local percent               95.85          74.90
> Ops NUMA pages migrated                 1629.00     6469222.00
> 
> Both the number of PTE updates and hint faults is dramatically
> increased. While this is superficially unfortunate, it represents
> ranges that were simply skipped without the patch. As a result
> of the scanning and hinting faults, many more pages were also
> migrated but as the time to completion is reduced, the overhead
> is offset by the gain.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>   include/linux/mm_types.h             |  6 +++
>   include/linux/sched/numa_balancing.h |  1 +
>   include/trace/events/sched.h         |  3 +-
>   kernel/sched/fair.c                  | 55 ++++++++++++++++++++++++++--
>   4 files changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 8cb1dec3e358..a123c1a58617 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -578,6 +578,12 @@ struct vma_numab_state {
>   						 * VMA_PID_RESET_PERIOD
>   						 * jiffies.
>   						 */
> +	int prev_scan_seq;			/* MM scan sequence ID when
> +						 * the VMA was last completely
> +						 * scanned. A VMA is not
> +						 * eligible for scanning if
> +						 * prev_scan_seq == numa_scan_seq
> +						 */
>   };
>   
>   /*
> diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
> index 7dcc0bdfddbb..b69afb8630db 100644
> --- a/include/linux/sched/numa_balancing.h
> +++ b/include/linux/sched/numa_balancing.h
> @@ -22,6 +22,7 @@ enum numa_vmaskip_reason {
>   	NUMAB_SKIP_SCAN_DELAY,
>   	NUMAB_SKIP_PID_INACTIVE,
>   	NUMAB_SKIP_IGNORE_PID,
> +	NUMAB_SKIP_SEQ_COMPLETED,
>   };
>   
>   #ifdef CONFIG_NUMA_BALANCING
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 27b51c81b106..010ba1b7cb0e 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -671,7 +671,8 @@ DEFINE_EVENT(sched_numa_pair_template, sched_swap_numa,
>   	EM( NUMAB_SKIP_INACCESSIBLE,		"inaccessible" )	\
>   	EM( NUMAB_SKIP_SCAN_DELAY,		"scan_delay" )	\
>   	EM( NUMAB_SKIP_PID_INACTIVE,		"pid_inactive" )	\
> -	EMe(NUMAB_SKIP_IGNORE_PID,		"ignore_pid_inactive" )
> +	EM( NUMAB_SKIP_IGNORE_PID,		"ignore_pid_inactive" )		\
> +	EMe(NUMAB_SKIP_SEQ_COMPLETED,		"seq_completed" )
>   
>   /* Redefine for export. */
>   #undef EM
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 150f01948ec6..72ef60f394ba 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3175,6 +3175,8 @@ static void task_numa_work(struct callback_head *work)
>   	unsigned long nr_pte_updates = 0;
>   	long pages, virtpages;
>   	struct vma_iterator vmi;
> +	bool vma_pids_skipped;
> +	bool vma_pids_forced = false;
>   
>   	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
>   
> @@ -3217,7 +3219,6 @@ static void task_numa_work(struct callback_head *work)
>   	 */
>   	p->node_stamp += 2 * TICK_NSEC;
>   
> -	start = mm->numa_scan_offset;
>   	pages = sysctl_numa_balancing_scan_size;
>   	pages <<= 20 - PAGE_SHIFT; /* MB in pages */
>   	virtpages = pages * 8;	   /* Scan up to this much virtual space */
> @@ -3227,6 +3228,16 @@ static void task_numa_work(struct callback_head *work)
>   
>   	if (!mmap_read_trylock(mm))
>   		return;
> +
> +	/*
> +	 * VMAs are skipped if the current PID has not trapped a fault within
> +	 * the VMA recently. Allow scanning to be forced if there is no
> +	 * suitable VMA remaining.
> +	 */
> +	vma_pids_skipped = false;
> +
> +retry_pids:
> +	start = mm->numa_scan_offset;
>   	vma_iter_init(&vmi, mm, start);
>   	vma = vma_next(&vmi);
>   	if (!vma) {
> @@ -3277,6 +3288,13 @@ static void task_numa_work(struct callback_head *work)
>   			/* Reset happens after 4 times scan delay of scan start */
>   			vma->numab_state->pids_active_reset =  vma->numab_state->next_scan +
>   				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
> +
> +			/*
> +			 * Ensure prev_scan_seq does not match numa_scan_seq
> +			 * to prevent VMAs being skipped prematurely on the
> +			 * first scan.
> +			 */
> +			 vma->numab_state->prev_scan_seq = mm->numa_scan_seq - 1;

nit:
Perhaps even vma->numab_state->prev_scan_seq = -1 would have worked, but
does not matter.

>   		}
