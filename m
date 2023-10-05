Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB1D7BA6B2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjJEQku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbjJEQjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:39:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4686A42
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 23:22:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHwsAq8I/kFeMHZCgcUiXt3gZfbrVmEi7Q1KQKDfCFCb2DRGcC8QjKQENUD3si0ScvKBLU6LkBuEWrlIRbeSoPVSbKDKcf3dV+K9VQUfldvPmWyCf5ma4K+4/hvvEa80gSmRfIkkRPR0t2IEvXBhY/4YCKObrAmbrR/tYFjkdOIZSYs74+6o/FuZc5EzmDCTC6o7cW7lrMqpmrwy9e0fm/beEzrvJa27E+1uaG4gDldW9ZVDeWzwHf9wrAVMFYHLQFoWiBK1Db1bN0ps8njrM4ScvyB08hSbi2cDa+rmCZgP+UoFOkfAiRZcw/9uQkaD3/sn+CFYWGBDHP/zYVmZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSiTjHAQ9P0TDSWR3YIHNCCxllWE6Jaa4DFzSab6cn8=;
 b=doDzrpFrZSflHpIGU2+mKn9ypiIsLDMBeisRNZtO/1sxji0qa4gSkdATvDk3pNg3AZs6OQRy7b+oDv6/C+WCzRyrWg5ypaTADpJG0NLD/SJgp0rbCr7/r8g0qMvP1R+AEn+rl70l6VQCdzFn8A4ehQyfpVS/YikDrZpcJ3KO3bgvS/nfsuJA6gV0MGQA9XeeLaOFLeS7Yw78ynDeqCDsgRNHv1VwCqplSdkLK7VvICcJHYiFKN+xjazWb6yXQSGtKu09WU1OMW56gsRpe9zirDipBaoOwNAcQbMUI693Y57j0x2LUNhh98t9X1WWNBZDbiknWZMGOqJE4+mszVKf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSiTjHAQ9P0TDSWR3YIHNCCxllWE6Jaa4DFzSab6cn8=;
 b=ulFVI+I1VCG1b515H+qp37KevCEFTB45k7KE/84e2JVn3u7zxWFjrGyuTozRb4r8d3kVL6Rvi9oRVm/OxWAE5PWc1Bt06ks/EPhmg27xDRi9SEh0cOn49lsTB/ir6VBn7JZh2cZZBA6wOn0y1AVjiDCoVEdBnq07se2zAZ/DOps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 5 Oct
 2023 06:22:27 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 06:22:27 +0000
Message-ID: <27651e14-f441-c1e2-9b5b-b958d6aadc79@amd.com>
Date:   Thu, 5 Oct 2023 11:52:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/2] Introduce SIS_CACHE to choose previous CPU during
 task wakeup
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <cover.1695704179.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::9) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MN2PR12MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: 02aed475-c8c4-4b65-8dd4-08dbc56b720c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOPH4GtNvK4sK1tiGypK1sYA4Oyn8fyjDSoUoe7T+qqVYY6AJX0KYYpabNeN7JkvIBBvRnsLLIfozM9H6VQX1Zxq7Yyh0YAyR5b7gdY6qGEaRP5DQO2Gur3a7pUPMxH0ytIgYurqy1reWZms7By6WQxJkApVTlkJo6mOqsPNchGvVEjQBcZ1xsUVG/r50RnItQNdxUcsxdEcDC9gX6NMHeTvrGJf6mcsy5723q+EEotQ799d95ftP6xM32nftKllDdTsIvFObkRuEKxApZzq67A55EnbmuzxaD33XQ3qRQyT8qHkYGSutkNrUryhgLOMtDT05vLt4g4UbPucdzIsr/e9cnr4ftUrAkzl5fMlA8CudcIipQgBJ2MLsWQDnFUzr+JoAhPNRD7MEbzDs7r6MGCCu8GMZaX950KkQkGP6LctJVUEDPcgR/TRP4AhsKP7ZbuNzYCTdsUqludZubOPFfGweaLwO+nZwUYwIjcpbQA0oBPqt219OEgzr3cedHeqkx9x+SdG76hZQflN+WF9Zzh9fhojJVpKHv9B9uXRZP+5+n3XORXc8EPRvIoJRoT75gPFsbaRq+ukM6tlvjGw+aekmRlT+AgzRmwEgX09k9PUMZsMqiUOKq655XHawav6c/TIU6kkf6QYtW7NoYYTXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(36756003)(31696002)(86362001)(31686004)(110136005)(478600001)(41300700001)(66946007)(6486002)(66476007)(2616005)(66556008)(6666004)(8676002)(54906003)(5660300002)(316002)(8936002)(26005)(53546011)(6512007)(7416002)(4326008)(2906002)(38100700002)(83380400001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5HZThvbno4S3RPWVQ3ZDFWOUloMUZsT29SbnVjZ2lJS0h4cFhiOE5LMlor?=
 =?utf-8?B?L0ZJSnV6VzlVZnQ0c1ZlR2pFOHFKRW9WMXBMbzR3SlVIV0U3T1l4WXZhRmZr?=
 =?utf-8?B?ek5NeDZsMmp6WTJXSkx2TGpTWUNwWkJDaTliT0NwYXV6clQzMW0yUFM0Nmxz?=
 =?utf-8?B?VUIxQkQxZjlKeVBkV012QUp1c1V5eXpXaDNxMmxjQ0RxSDdVSWd3MFhQWWJI?=
 =?utf-8?B?eHk4Z0xNbEo2YUpOZDJVczNkbnJaWWFiUHU3NWlYUWVVM3ZJMUU1OExQMEtE?=
 =?utf-8?B?bTB3OUFyOHZoZUlpZXl5YW1CWkRiWmpiY3ROTGhnb05VSDBKSkZtU2pLdkxQ?=
 =?utf-8?B?NklNWU9uZDd1akVJNm1MMVpUZzBiWGJTWGhvRjRaeERPa0crVndxTGdjZTB4?=
 =?utf-8?B?MXZxc2d6TDJvbXpheXFpaXRNTUZWVFRkSVE1eW13ZXQ4NXo5bHhzZXhrMlpS?=
 =?utf-8?B?L0dtUjY0NTJ0RTZhc0kxU1hsbDVPMFBvdGlsZnFxK0wraDNLTkJteUx4TXhN?=
 =?utf-8?B?c2xyZUxZY0lxSC9WME5DTU5sRUxBdWVDS0hqa0hGZFlpWS8wQ1Y1WHl5Q3Zt?=
 =?utf-8?B?bFNzWmI1eXBwYnE2elNqY0hocm9vMmJ1WjFoOTRJbXN1djVmUlI5dHBoY2hE?=
 =?utf-8?B?ejZ2UmIyR1hHZDdrZUhna2t6U3lZeG5xUEcwMGQxK1RNWGx3cXd3VjFYa2ZX?=
 =?utf-8?B?N0NtRTlNY3pSckVUU01MMXNDMjgrMGlzTUZ2Q1hSQjB6VmFFUlRRc3VZRkNo?=
 =?utf-8?B?WUUwNVZwTk1ad2ZRM3JnanFQN0twSGxtcVlJTW80Zjc1US9oeUs3alV5aER5?=
 =?utf-8?B?R1IvSW9HdkxwYUh4ZFJWNzJuclhQV0lxOCtFQ245NXZaRXJ2U3Y0NDFQNUFz?=
 =?utf-8?B?Tm5ZazNtQ3JGVXVvcEZUTERBQ3lQbC9LN0drMFdGR0p2M2tDek5Gc3FVRmJO?=
 =?utf-8?B?ajQyRWRlWU50ZXkrM0swTU9VbTVtMVBRZzVOZFRkRFM3N0U0Tk5CWERZQ016?=
 =?utf-8?B?aFJFaW5tbVJFQnYvZGQ4Tmx4VEZOeE9xUkxYVkZ4dG91N3V2N3hCekI1R0lV?=
 =?utf-8?B?dUs4ekdVYlRtVEJURXdWSTB5WXFHM1M4L25UQjY2c0FXVnZIZ1IxdEwvZjdm?=
 =?utf-8?B?L3dTRldSRDJRMFFEMTlZZ05oVVNFREk0YUtmKzF6RmJXLzI4Z1dSTE5panRo?=
 =?utf-8?B?a1lRazdYYzFmREhydUZaVTIrRXgyNjU5TVRzZUUyVWRVcGNTTE5RKzNlN3dL?=
 =?utf-8?B?bXFaMmE1cXhwU3VTQ3lFMkpTSTZyUVlyTXR2QmJDY3p4Q0FoRDBaaXNsamJu?=
 =?utf-8?B?bE5KeG1tNEgrOFRTRmwrQ2E1QnY2ZTZRQno4MkZaT2VpOGYwS0RyNmJNbTFp?=
 =?utf-8?B?aTNJTHcxV1pTb1h0SzZBWkFaYnBqVUNnbHdOR2FWRzJjZlVJeUdhaDlJYVM3?=
 =?utf-8?B?dVYvOHVDZzdwUFcxUWx1ZmtuU0dGR2p1alZRTVhkNGhteHM3NXl0NjcwOGpB?=
 =?utf-8?B?eW9kdUQvZXpBem1GZ1BOK0MyMUR5RGJkeTFsb3o5Tk5tMytueTRXN3BlNVpF?=
 =?utf-8?B?L0dGei91dVFBdm9lNy9pRjQ5TGZUd2NHYkRmRVpocXYyREEzTWNseDFnR1ky?=
 =?utf-8?B?cmgvTjVHL2dLWWhwZTFjbWRQbi9hU2t3QXZuN0xjSjl5M2hZTXhOOUdjbExD?=
 =?utf-8?B?K3k1b3Y4K3UvTEZrZHlkdTlXK21ZNHpMUm9YOCtTS203NVZScmRvS0g4ZVdt?=
 =?utf-8?B?YStBNmJ6NFF4MngwL3BQbUtFZE54bjFPMDl2VlBENWJOb0s1OEVSeXd2VGFn?=
 =?utf-8?B?NVdsQkc3YWdnTWVDNlhsWGM5Z3ZxQTVGQ2x5d0QvRjZNTmJROWpjTGxZSHEr?=
 =?utf-8?B?bTZKUTdmYTVkdVdtdWdQVnpibnN4OEYyQnNQSWhUVVhieC9aYUNNcEV5NXpQ?=
 =?utf-8?B?YUdqQUZGY21hcnUwMlpSTEsrMGJlbGcrRnJXSVZJVTR6NktSa3RFQUZZenZY?=
 =?utf-8?B?aHAxL0I5SU04MXI0bmEvaFIyUDZvOUN1ZklFTlV6WUdGUS93K1BZcXNMU1Ba?=
 =?utf-8?B?QXlnQytVcWF4RzM5L05lRWJUOG1IZ2NtNkpVMFkxOUlSNTI4MmJUNTRPRkdB?=
 =?utf-8?Q?MmWXI7QQWM39kowm/rSkGPtmj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02aed475-c8c4-4b65-8dd4-08dbc56b720c
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 06:22:27.2210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKNOlZE+rRHwFESwosXhu/c1+i7IEO06PcXgo12LIY8ZobbrfFnumzSbxKnU+JvTBv5THftNol6OkWQG1VaaVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 9/26/2023 10:40 AM, Chen Yu wrote:
> RFC -> v1:
> - drop RFC
> - Only record the short sleeping time for each task, to better honor the
>   burst sleeping tasks. (Mathieu Desnoyers)
> - Keep the forward movement monotonic for runqueue's cache-hot timeout value.
>   (Mathieu Desnoyers, Aaron Lu)
> - Introduce a new helper function cache_hot_cpu() that considers
>   rq->cache_hot_timeout. (Aaron Lu)
> - Add analysis of why inhibiting task migration could bring better throughput
>   for some benchmarks. (Gautham R. Shenoy)
> - Choose the first cache-hot CPU, if all idle CPUs are cache-hot in
>   select_idle_cpu(). To avoid possible task stacking on the waker's CPU.
>   (K Prateek Nayak)
> 
> Thanks for your comments and review!

Sorry for the delay! I'll leave the test results from a 3rd Generation
EPYC system below.

tl;dr

- Small regression in tbench and netperf possible due to more searching
  for an idle CPU.

- Small regression in schbench (old) at 256 workers albeit with large
  run to run variance.

- Other benchmarks are more or less same.

I'll leave the full result below

o System details

- 3rd Generation EPYC System
- 2 sockets each with 64C/128T
- NPS1 (Each socket is a NUMA node)
- Boost enabled, C2 Disabled (POLL and MWAIT based C1 remained enabled)


o Kernel Details

- tip:	tip:sched/core at commit 5fe7765997b1 (sched/deadline: Make
	dl_rq->pushable_dl_tasks update drive dl_rq->overloaded)

- SIS_CACHE: tip + this series


o Benchmark results

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:           tip[pct imp](CV)     SIS_CACHE[pct imp](CV)
 1-groups     1.00 [ -0.00]( 2.36)     1.01 [ -1.47]( 3.02)
 2-groups     1.00 [ -0.00]( 2.35)     0.99 [  0.92]( 1.01)
 4-groups     1.00 [ -0.00]( 1.79)     0.98 [  2.34]( 0.63)
 8-groups     1.00 [ -0.00]( 0.84)     0.98 [  1.73]( 1.02)
16-groups     1.00 [ -0.00]( 2.39)     0.97 [  2.76]( 2.33)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:    tip[pct imp](CV)      SIS_CACHE[pct imp](CV)
    1     1.00 [  0.00]( 0.86)     0.97 [ -2.68]( 0.74)
    2     1.00 [  0.00]( 0.99)     0.98 [ -2.18]( 0.17)
    4     1.00 [  0.00]( 0.49)     0.98 [ -2.47]( 1.15)
    8     1.00 [  0.00]( 0.96)     0.96 [ -3.81]( 0.24)
   16     1.00 [  0.00]( 1.38)     0.96 [ -4.33]( 1.31)
   32     1.00 [  0.00]( 1.64)     0.95 [ -4.70]( 1.59)
   64     1.00 [  0.00]( 0.92)     0.97 [ -2.97]( 0.49)
  128     1.00 [  0.00]( 0.57)     0.99 [ -1.15]( 0.57)
  256     1.00 [  0.00]( 0.38)     1.00 [  0.03]( 0.79)
  512     1.00 [  0.00]( 0.04)     1.00 [  0.43]( 0.34)
 1024     1.00 [  0.00]( 0.20)     1.00 [  0.41]( 0.13)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)      SIS_CACHE[pct imp](CV)
 Copy     1.00 [  0.00]( 2.52)     0.93 [ -6.90]( 6.75)
Scale     1.00 [  0.00]( 6.38)     0.99 [ -1.18]( 7.45)
  Add     1.00 [  0.00]( 6.54)     0.97 [ -2.55]( 7.34)
Triad     1.00 [  0.00]( 5.18)     0.95 [ -4.64]( 6.81)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)      SIS_CACHE[pct imp](CV)
 Copy     1.00 [  0.00]( 0.74)     1.00 [ -0.20]( 1.69)
Scale     1.00 [  0.00]( 6.25)     1.03 [  3.46]( 0.55)
  Add     1.00 [  0.00]( 6.53)     1.05 [  4.58]( 0.43)
Triad     1.00 [  0.00]( 5.14)     0.98 [ -1.78]( 6.24)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:         tip[pct imp](CV)      SIS_CACHE[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.27)     0.98 [ -1.50]( 0.14)
 2-clients     1.00 [  0.00]( 1.32)     0.98 [ -2.35]( 0.54)
 4-clients     1.00 [  0.00]( 0.40)     0.98 [ -2.35]( 0.56)
 8-clients     1.00 [  0.00]( 0.97)     0.97 [ -2.72]( 0.50)
16-clients     1.00 [  0.00]( 0.54)     0.96 [ -3.92]( 0.86)
32-clients     1.00 [  0.00]( 1.38)     0.97 [ -3.10]( 0.44)
64-clients     1.00 [  0.00]( 1.78)     0.97 [ -3.44]( 1.70)
128-clients    1.00 [  0.00]( 1.09)     0.94 [ -5.75]( 2.67)
256-clients    1.00 [  0.00]( 4.45)     0.97 [ -2.61]( 4.93)
512-clients    1.00 [  0.00](54.70)     0.98 [ -1.64](55.09)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:  tip[pct imp](CV)     SIS_CACHE[pct imp](CV)
  1     1.00 [ -0.00]( 3.95)     0.97 [  2.56](10.42)
  2     1.00 [ -0.00]( 5.89)     0.83 [ 16.67](22.56)
  4     1.00 [ -0.00](14.28)     1.00 [ -0.00](14.75)
  8     1.00 [ -0.00]( 4.90)     0.84 [ 15.69]( 6.01)
 16     1.00 [ -0.00]( 4.15)     1.00 [ -0.00]( 4.41)
 32     1.00 [ -0.00]( 5.10)     1.01 [ -1.10]( 3.44)
 64     1.00 [ -0.00]( 2.69)     1.04 [ -3.72]( 2.57)
128     1.00 [ -0.00]( 2.63)     0.94 [  6.29]( 2.55)
256     1.00 [ -0.00](26.75)     1.51 [-50.57](11.40)
512     1.00 [ -0.00]( 2.93)     0.96 [  3.52]( 3.56)

==================================================================
Test          : ycsb-cassandra
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
Metric          tip     SIS_CACHE(pct imp)
Throughput      1.00    1.00 (%diff: 0.27%)


==================================================================
Test          : ycsb-mondodb
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
Metric          tip      SIS_CACHE(pct imp)
Throughput      1.00    1.00 (%diff: -0.45%)


==================================================================
Test          : DeathStarBench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
Pinning      scaling     tip                SIS_CACHE(pct imp)
 1CCD           1        1.00              1.00 (%diff: -0.47%)
 2CCD           2        1.00              0.98 (%diff: -2.34%)
 4CCD           4        1.00              1.00 (%diff: -0.29%)
 8CCD           8        1.00              1.01 (%diff: 0.54%)

> 
> ----------------------------------------------------------------------
> 
> [..snip..]
> 

--
Thanks and Regards,
Prateek
