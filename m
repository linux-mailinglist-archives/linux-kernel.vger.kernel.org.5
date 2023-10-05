Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7760E7BA041
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbjJEOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjJEOeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:34:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1485B92
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 22:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3UkC5XnQsNf0GxTc2NZ2sb5NjThjo8WHXNxvqsxxJGCx2VgyyIldborj7cIQWJ0aluNanE4t48Kyxbe1sbrFZK+mZ0JpZkmYJqx6p6E8SXCznH7sSNqj+x67AaP23X2T4RkSWaSafV5JiD0g9vzMZADQr/xoA1ntBhSGblwvdUmP5fd4aoZ2ztF0/M/VHJObfeRgT3CFkXzskGQnKFKu8Ui8SZ9EZRdgVnPWxvYQ6OXuw3EvoVacW8GIr8vbfWHSMbeBa7zyLVm2nNUG/kDNIZ4sHD3GHgPu0s9u+rM25yVIYTbKgo33tqCrbjdKQ8a9MrVY3SezSCnqHdLNsPT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P0j9knUmr0H0lPh0ERsxpQt0YSYCB9Ou42Ok0OhiUI=;
 b=i7qGHXUBNTxYPrf5nlkHMSdsRzcvQcFzX77x3nIVDwmiZL5U2iDr1AfkIp9Y4CKfcZi+4VjfiVNkT3uwx2iRAYHZm6Jk1kgjwEb2LACHVITK574qHqaV6i8GomCLeMarNztKVG0Th0OXP3ll31IIvG0hW3YTUEhy7X5Zd77DU6/mZua9uLqGYtUN0ZmVk+DspSDxDAutM9f6Qr0UNQQqBme4xujgt7ZjKBIYQRSrPI684VNQWKEcZQGOL3kPzasq4MkiU8UXCMsQRk8PojNQQvgRQHveK4SPISv//sNto2Pt+fMe6V5CxotxX8sd/VHIglYnAdQBVQueiOTMMCRNmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P0j9knUmr0H0lPh0ERsxpQt0YSYCB9Ou42Ok0OhiUI=;
 b=RMR95POeSmBuox0mW8CXVaeukeYoY7joX/3L9ByRueTMqfQh8JLfyLjtD+j4f4vssdxAS3dA3ftE1C/wfZipPStK6pGoXnp40vyphH5ZLFL7egHkQ7sXWS64KT2XpKt4n2T3gBTYDRaQjplKaCY9c34qfbMCbJ944bDwd7Dw1gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.28; Thu, 5 Oct 2023 05:56:24 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 05:56:24 +0000
Message-ID: <6b976368-9ed9-e2a9-a725-2f8f7e76d401@amd.com>
Date:   Thu, 5 Oct 2023 11:26:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] sched/fair: Preserve PLACE_DEADLINE_INITIAL deadline
Content-Language: en-US
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     bristot@redhat.com, bsegall@google.com, chris.hyser@oracle.com,
        corbet@lwn.net, dietmar.eggemann@arm.com, efault@gmx.de,
        joel@joelfernandes.org, joshdon@google.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        patrick.bellasi@matbug.net, pavel@ucw.cz, pjt@google.com,
        qperret@google.com, qyousef@layalina.io, rostedt@goodmis.org,
        tglx@linutronix.de, tim.c.chen@linux.intel.com, timj@gnu.org,
        vincent.guittot@linaro.org, youssefesmat@chromium.org,
        yu.c.chen@intel.com, peterz@infradead.org
References: <20230531124604.068911180@infradead.org>
 <20231004011737.188682-1-daniel.m.jordan@oracle.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20231004011737.188682-1-daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::17) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: b232b2ee-e31a-4327-0a46-08dbc567ce5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/0ahfPfzk0UG/r7fniAQxgPqgfUskAEAnU2Hgy4nSYweftuPGWE9SVBlR19rvxbCpoiefgxgNWn+ya8vdGFhUVeYpRdNLEmRqVGIj5TvL6a0iJHHasj5oIkQsbkhwQHPKPYRdB/W8+NZtwDL92JiMZDGEha38aOIA9OYeNoTQ0bJD/28vSSpTEXg1vM6u1p7VdBAhMyVzgBpIY0EAMAT7y2zsdgdfbMxclIvsqgov+JW7NbGNqYzfD/dw0wjaT4TYbsYpGhrNOGBxAw+5qCYWb2dlBEGTIowMYSy1Zdtj3OBt4RIPOprrVjdjXE3D43KXtIRFfUJK5bUi5KkLfpLsoec+ApG29dPLJE4si8RUZRpgyU6bdkGMErLLzAAzXXyt6+GvAH/KbYc4PEpdYvEEmjj2rRPlkJNk07sd0mpKP8JiPTQFnp+5WzbdlNEvMDOW+kFzhpSIQM65JNyZkHji+xLR981FbnTnj06fSsX8h5XbE8roCIMqGsBIq1691pkt7fVUsoVvMV/fO0qgNOd/U9wgBwYHLLxz58+g6JB+/vdDgQk3HkyQzH7Ctco3U+AcC3rSDQU6ssF2iFGDkpepeUuVDjK3dsvseIWIE6WOtviTW/+j5bJu4banPITIFADuE4OJJmPiiNqAs7yg3JMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(316002)(2616005)(38100700002)(31696002)(36756003)(86362001)(83380400001)(41300700001)(66946007)(8676002)(4326008)(6916009)(5660300002)(66476007)(8936002)(66556008)(26005)(2906002)(31686004)(7416002)(6512007)(6506007)(53546011)(478600001)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXVQL1pMMDI4VHpyT0FEcVV1UkxvdUpXWThGTDlQMGFoMkFscFlmcU8wVmIr?=
 =?utf-8?B?QjdsSHJ4OGpsRUFmR01URVc0OG9lQWF3dXdPUmlwL1g2cUJxU1Y1WWMxeFVO?=
 =?utf-8?B?cmVGTEJvdXN5a1ZFdElGQ1NBTkRpc29idGR4Si9Gb1JhSDNwUmlieVJIajEz?=
 =?utf-8?B?b1kyNDFEQ3Bhb2YxQkpGcnQwUGZzRzM2TnpNVTg2Wm5EVUVvb2IvL0prQ282?=
 =?utf-8?B?bW8zbFZ0NEY2blRUcGJ4M3lNWWY2VXVudE5RcVdTcVlDOGtkQXNncGlibzBw?=
 =?utf-8?B?R2ZYY3hvdmpFTExyazE3NjA1SnFud1hKdFl0RkF4UkZsMmNRTFd3KzFNdlpz?=
 =?utf-8?B?L2luc1VsaFVYc3lqcThKby9yY29PM1ZsYXBxT2dYbk43dTNpekJLb2xJNlZJ?=
 =?utf-8?B?OWwvTEwxS3kzRzBaZ21nT3Z4eVpKTDk0R2p1eTVvd1kwSzR6WGJVZ3VGYkJi?=
 =?utf-8?B?Z3d6UDVUVXN3UEg2OUVsNU1laVVWNS9uQjVQMEtpa0dlc0dESlBlNDV6emx5?=
 =?utf-8?B?cFNJZjBhLzlIR0Z5RnlaTlNyNDR4cTB4cjVManNpK05KK0Q3QzVaSkRmalRo?=
 =?utf-8?B?RWg2NWRIWHZ5dmo3ZlBTU0wyaXZaRWFWU0VmVjJtWEJxMFBCL2F0U1JCMXdK?=
 =?utf-8?B?dzhJVm1ZRmVhblZTektuemg2NGFhLzE4cTFUVjVJV1BMcW03YkNVdGpudWsv?=
 =?utf-8?B?cko2K2QrTkx4cmczOGlWcW9qUXlDaVcyaGpxWWRVcmFkYWZidUNITDdiU3Y0?=
 =?utf-8?B?eWY1SGFGMTdkY1lrWExJLzhBQ2ZrOHpPMlRtWHlBd1ZGaFMyblFBN2ZaaTg4?=
 =?utf-8?B?ZUJkQjk3dTNRa2xLM2VPNUxSVFNwa0F4L05WS1c5NVJLRUVtUnVSanM5WFMw?=
 =?utf-8?B?akYvL3hSa3kvRlgrUSs2WnFhcW5LeE5WL0ovU1lMbGlQdkdWQ3JLeGJObWxx?=
 =?utf-8?B?dEk4Z2VjQVh3SWJKemc3WkxWMS8wWjFIVFJRY3JEZGp1NDJabFdUSHZYV25Z?=
 =?utf-8?B?d1BxYUthTDYwbXJndE1rNDNabXRJMU0wMVBxbURmdExVeGdOTjhsWWdXb210?=
 =?utf-8?B?Z0NkMnNvTmNYdVNjQU45N2dCbzBnNThsYkE4L3plMUt6eW5EQTJiTEU5MFNn?=
 =?utf-8?B?MmdEMFAySkE3VFkwc1g3Q0pjWXBWY2dQZnlmWTlQUHFiRXcvS1Fsb0d5dzRz?=
 =?utf-8?B?WVdjMHRaRGUrN1dyTDc0QTNtUUZFM0llcENhSEFOT3VVcmQ5L041QzdyaGM0?=
 =?utf-8?B?QVR0WG5lWW1ydnFNMmxDeGlRVElOdFRGK1hIWmptcDhqRm95Y09FRUhJcjdW?=
 =?utf-8?B?VnAyQXhhbS9wODFVdWYwbnMwRTRzQUpOSVI4STZja1IveGNDYlpxU3JpSGZn?=
 =?utf-8?B?RDU2VXFiM2pLUTA1b0NrR0x1a1BrRy9GbE80czRScWE2dTZ4M09QRUdCaUxB?=
 =?utf-8?B?MU85QmtWN05Fa2wySThaZFdCRmlwWTA1elVReTk5amhEVW1wWFlQb1k4b09p?=
 =?utf-8?B?eGZrRzlUS245WVBycWNmeTlVSHdBeGtna3Q2MFEvNCs3NHRzd3h2bTlNa2sv?=
 =?utf-8?B?WmhXWnYrWTZucFk1a1pUZjF3QVBDK2xVUzQ0alBoZ2JuMmpvVTZ5aEtjVmpO?=
 =?utf-8?B?RGpNMVo0Z04wS0VWRHJYdDIyRnZjSWlGaVlNUFpGODBuc0dFUEREOG4yTHZo?=
 =?utf-8?B?WXdkZkRxYWg5TWdXUTV1Y2VWMHpTLytBMXI2UHZ5Q081dWM4TXd5YXdmUy8y?=
 =?utf-8?B?c2tpR3kxdFY5T1dXc1RaWkFRRDJ4RXQ5OVVQd0FPSFVxK2lkMWUxSExoZHJz?=
 =?utf-8?B?SzlOSkVILzhRN3REeUkvc29yaDlHai9aMmFVV0lwZTVCdS9lbkd3NkZZamky?=
 =?utf-8?B?TTRTMTl6UUY5ZUxKd0phZU14WkRxVzdENGF1ZU9yb3Jsc3ZUbFRndjE0Wml1?=
 =?utf-8?B?ZlpwMCtXWWNJVms4UFloOUpqbDk0R2x3RjlpbzdCeFN1cktiWVJ2c1dsRklL?=
 =?utf-8?B?RHBoYUJiaWVxREczWkxUTFdGMHRDbHMyM09PMFB1V3pDbmNqZmdTOEJuckRC?=
 =?utf-8?B?cWMwMkh6WFdKcVltak9FMFpldkxoWks3RFpvRmtDempudnIxcDZTTkdqRmdj?=
 =?utf-8?Q?3yfQ0omOiaBHMqeD46AyX9lEN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b232b2ee-e31a-4327-0a46-08dbc567ce5e
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 05:56:24.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJot0y5vyY1ztLQy3OiaTs7rCDVjG6z0bh8jOrN72L0voyvLXpef4QHVsMhKp+iPJ3Fyn7SwhtSErpKmIVuQ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On 10/4/2023 6:47 AM, Daniel Jordan wrote:
> An entity is supposed to get an earlier deadline with
> PLACE_DEADLINE_INITIAL when it's forked, but the deadline gets
> overwritten soon after in enqueue_entity() the first time a forked
> entity is woken so that PLACE_DEADLINE_INITIAL is effectively a no-op.
> 
> Placing in task_fork_fair() seems unnecessary since none of the values
> that get set (slice, vruntime, deadline) are used before they're set
> again at enqueue time, so get rid of that and just pass ENQUEUE_INITIAL
> to enqueue_entity() via wake_up_new_task().
> 
> Fixes: e8f331bcc270 ("sched/smp: Use lag to simplify cross-runqueue placement")
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>

I got a chance to this this on a 3rd Generation EPYC system. I don't
see anything out of the ordinary except for a small regression on
hackbench. I'll leave the full result below.

o System details

- 3rd Generation EPYC System
- 2 sockets each with 64C/128T
- NPS1 (Each socket is a NUMA node)
- Boost enabled, C2 Disabled (POLL and MWAIT based C1 remained enabled)


o Kernel Details

- tip:	tip:sched/core at commit d4d6596b4386 ("sched/headers: Remove
	duplicate header inclusions")

- place-deadline-fix: tip + this patch


o Benchmark Results

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:           tip[pct imp](CV)    place-deadline-fix[pct imp](CV)
 1-groups     1.00 [ -0.00]( 2.58)     1.04 [ -3.63]( 3.14)
 2-groups     1.00 [ -0.00]( 1.87)     1.03 [ -2.98]( 1.85)
 4-groups     1.00 [ -0.00]( 1.63)     1.02 [ -2.35]( 1.59)
 8-groups     1.00 [ -0.00]( 1.38)     1.03 [ -2.92]( 1.20)
16-groups     1.00 [ -0.00]( 2.67)     1.02 [ -1.61]( 2.08)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:           tip[pct imp](CV)    place-deadline-fix[pct imp](CV)
    1     1.00 [  0.00]( 0.59)     1.02 [  2.09]( 0.07)
    2     1.00 [  0.00]( 1.19)     1.02 [  2.38]( 0.82)
    4     1.00 [  0.00]( 0.33)     1.03 [  2.89]( 0.99)
    8     1.00 [  0.00]( 0.76)     1.02 [  2.10]( 0.46)
   16     1.00 [  0.00]( 1.10)     1.01 [  0.81]( 0.49)
   32     1.00 [  0.00]( 1.47)     1.02 [  1.77]( 0.58)
   64     1.00 [  0.00]( 1.77)     1.02 [  1.83]( 1.77)
  128     1.00 [  0.00]( 0.41)     1.02 [  2.49]( 0.52)
  256     1.00 [  0.00]( 0.63)     1.03 [  3.03]( 1.38)
  512     1.00 [  0.00]( 0.32)     1.02 [  1.61]( 0.45)
 1024     1.00 [  0.00]( 0.22)     1.01 [  1.00]( 0.26)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:           tip[pct imp](CV)    place-deadline-fix[pct imp](CV)
 Copy     1.00 [  0.00]( 9.30)     0.85 [-15.36](11.26)
Scale     1.00 [  0.00]( 6.67)     0.98 [ -2.36]( 7.53)
  Add     1.00 [  0.00]( 6.77)     0.92 [ -7.86]( 7.83)
Triad     1.00 [  0.00]( 7.36)     0.94 [ -5.57]( 6.82)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:           tip[pct imp](CV)    place-deadline-fix[pct imp](CV)
 Copy     1.00 [  0.00]( 1.83)     0.96 [ -3.68]( 5.08)
Scale     1.00 [  0.00]( 6.41)     1.03 [  2.66]( 5.28)
  Add     1.00 [  0.00]( 6.23)     1.02 [  1.54]( 4.97)
Triad     1.00 [  0.00]( 0.89)     0.94 [ -5.68]( 6.78)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:           tip[pct imp](CV)    place-deadline-fix[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.05)     1.02 [  1.83]( 1.98)
 2-clients     1.00 [  0.00]( 0.93)     1.02 [  1.87]( 2.45)
 4-clients     1.00 [  0.00]( 0.54)     1.02 [  2.19]( 1.99)
 8-clients     1.00 [  0.00]( 0.48)     1.02 [  2.29]( 2.27)
16-clients     1.00 [  0.00]( 0.42)     1.02 [  1.60]( 1.70)
32-clients     1.00 [  0.00]( 0.78)     1.02 [  1.88]( 2.08)
64-clients     1.00 [  0.00]( 1.45)     1.02 [  2.33]( 2.18)
128-clients    1.00 [  0.00]( 0.97)     1.02 [  2.38]( 1.95)
256-clients    1.00 [  0.00]( 4.57)     1.02 [  2.50]( 5.42)
512-clients    1.00 [  0.00](52.74)     1.03 [  3.38](49.69)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:           tip[pct imp](CV)    place-deadline-fix[pct imp](CV)
  1     1.00 [ -0.00]( 3.95)     0.90 [ 10.26](31.80)
  2     1.00 [ -0.00](10.45)     1.08 [ -7.89](15.33)
  4     1.00 [ -0.00]( 4.76)     0.93 [  7.14]( 3.95)
  8     1.00 [ -0.00]( 9.35)     1.06 [ -6.25]( 8.90)
 16     1.00 [ -0.00]( 8.84)     0.92 [  8.06]( 4.39)
 32     1.00 [ -0.00]( 3.33)     1.04 [ -4.40]( 3.68)
 64     1.00 [ -0.00]( 6.70)     0.96 [  4.17]( 2.75)
128     1.00 [ -0.00]( 0.71)     0.96 [  3.55]( 1.26)
256     1.00 [ -0.00](31.20)     1.28 [-28.21]( 9.69)
512     1.00 [ -0.00]( 4.98)     1.00 [  0.48]( 2.76)


==================================================================
Test          : ycsb-cassandra
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
Metric          tip    place-deadline-fix(pct imp)
Throughput      1.00    1.01 (%diff: 1.06%)


==================================================================
Test          : ycsb-mondodb
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
Metric          tip    place-deadline-fix(pct imp)
Throughput      1.00    1.00 (%diff: 0.25%)


==================================================================
Test          : DeathStarBench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
Pinning      scaling     tip            place-deadline-fix(pct imp)
 1CCD           1       1.00            1.00 (%diff: -0.32%)
 2CCD           2       1.00            1.00 (%diff: -0.26%)
 4CCD           4       1.00            1.00 (%diff: 0.17%)
 8CCD           8       1.00            1.00 (%diff: -0.17%)


--
I see there is a v2. I'll give that a spin as well.

> ---
> 
> Tested on top of peterz/sched/eevdf from 2023-10-03.
> 
>  kernel/sched/core.c | 2 +-
>  kernel/sched/fair.c | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 779cdc7969c81..500e2dbfd41dd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4854,7 +4854,7 @@ void wake_up_new_task(struct task_struct *p)
>  	update_rq_clock(rq);
>  	post_init_entity_util_avg(p);
>  
> -	activate_task(rq, p, ENQUEUE_NOCLOCK);
> +	activate_task(rq, p, ENQUEUE_INITIAL | ENQUEUE_NOCLOCK);
>  	trace_sched_wakeup_new(p);
>  	wakeup_preempt(rq, p, WF_FORK);
>  #ifdef CONFIG_SMP
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a0b4dac2662c9..5872b8a3f5891 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12446,7 +12446,6 @@ static void task_fork_fair(struct task_struct *p)
>  	curr = cfs_rq->curr;
>  	if (curr)
>  		update_curr(cfs_rq);
> -	place_entity(cfs_rq, se, ENQUEUE_INITIAL);
>  	rq_unlock(rq, &rf);
>  }
>  
 
--
Thanks and Regards,
Prateek
