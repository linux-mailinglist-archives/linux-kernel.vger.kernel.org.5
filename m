Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9323D7C9EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjJPFjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjJPFje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:39:34 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF18E6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlEyUQIQhvooNXT2iJECtIK5mY52fwIG29bvAoj9T5iEBhHkgkGleQvi9+YoiraDd8KvaRxiMpXmiGX1CrLNYeoLxBadAOqanfnX4sFDz2TPihJssYMmJjWmSYasAN0fvVUVuTGiVQ2qJV1iZFu5FC+o/y2OF0yVAF5+0eItXzwJhn4nyB09DRgE9zX0el40o3inuNftQTZuzxIvHU0YGWhr5YnG7V+32iPaJvdw2YQyxfze478Yp79p4BCgsvUIDNaXD16HQ2iBwqIp+vLuv+A3o16VHh5yTqivMCeb5J2U4VdM6qKYYHMRzWUg6VPz1utuJ1Tdn+t5cYsu4qE8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU5yDSOlRE5QZ7uILOUXi+2RDYac4J34dI4raoy0lEE=;
 b=gc87j2KNjXk2ZtQb/0O3XDCMLVceqjljWku/PecLvM66TUP7AmrEPGR6Mag0d4rY9ZzRYPH2N7YtENRXnX2LP+vQRUjQ0jozd2B4jqFAVrvmnRiLeNNOcgKmdLafBavaSDGjGikpbDaGHD1rDztoXmxdbKzDskoULPWMlMYDOfAs3k/rWVQjZBuDgahZQwWuoy9VNP5HyAuxsUPuAw81BDsmBBwJGWu0Joa9fQ+zGRl0Y8Smt+4R6e5rXEVagZE573SBRwrt7boskDaqhYuiSKxSa8PDGkRJxdhSJJKonCSWz1WCBajXOmrOVfdTyIpR10lKKABSLvnoo2cgBLaLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU5yDSOlRE5QZ7uILOUXi+2RDYac4J34dI4raoy0lEE=;
 b=sEMNIi4DgERmT57m35IMHQodqRrDG0C5Qzpq6BXvcuJVAabxmPC5rOVlALUCv/oVjmLFSzgoTrK79Pyam6b3gOuVGtIYlS5iRN4K++0b3zi8TbxiMYwNgCCJhl3g4UMRv9IkU6V2I6BTI5LntX3KoMXtuRXqjlD56eNxn5C8hFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 05:39:27 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 05:39:27 +0000
Message-ID: <1878eaa4-0d2b-933a-12c8-40b28d771251@amd.com>
Date:   Mon, 16 Oct 2023 11:09:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] sched/fair: Always update_curr() before placing at
 enqueue
Content-Language: en-US
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     peterz@infradead.org, bristot@redhat.com, bsegall@google.com,
        chris.hyser@oracle.com, corbet@lwn.net, dietmar.eggemann@arm.com,
        efault@gmx.de, joel@joelfernandes.org, joshdon@google.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@kernel.org, patrick.bellasi@matbug.net,
        pavel@ucw.cz, pjt@google.com, qperret@google.com,
        qyousef@layalina.io, rostedt@goodmis.org, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, timj@gnu.org,
        vincent.guittot@linaro.org, youssefesmat@chromium.org,
        yu.c.chen@intel.com
References: <20230531124604.068911180@infradead.org>
 <20231006164826.335223-1-daniel.m.jordan@oracle.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20231006164826.335223-1-daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::23) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 4efeaa00-86cc-46a8-c84c-08dbce0a429c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMfYpLOtzZJnAi53qg4L5Gu7mn5rPhUCV8swrSgHxwXKUtaZLFvrQ7ZF/HOkf9DWEdSmEMtBeRL9+nJXuroLScaqaibWtdjD5p6XNtX1ymkSu0IcnzVVCPKcfyOXHqcoVYYUpWplrFYdWNSzeEldoV1BUxFF/FfSHRybYItIvgbd8hqNjTdZmx8G0uTkse381423n8cagPLsTrZOPFqP2lRNzecJ7MC06selOEuyEiXh+n4bS5fLNfliFb8lB9Fp0UU2rEXtw3DDAhncxyKch6SLmtI3/hVtrJszLNoVaT1aeFAo03xwCPcjCtMT/EK5BMGnmuVRUoBeXgJD1x63iTuUdb72rI5RqNGcWPrNA0Oyt9VaW0MkYxlsmiYrb4LHWbQBdE6OabR3hggho6l3Nn5CHgGSUrZ4P33MvOMbSBSY4Ox0UixbkdRmcmcfPlw/M3yxYY7ubVW/8EPgbVOFottIHDfwDe5sj0RBYB/Zvz15RhPZGNba75idrDIxclWhtyc6BTyMza0Duq4zMtoanqenkkeG8gXKp1lNmik8cOGv+RSLOU2a4ZQ9TA0LeDT5Sg6jZ/y7JHA9mpsAgmywS65WkFxOPV/OG3LCo0RPw+3rmSaEq8IqNY2UOSac3WRaiTHG5aAwag1Fm+3ogYDplFX9MWfo/4AhhhzXG8WAGvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(86362001)(31696002)(36756003)(31686004)(6486002)(2906002)(478600001)(6666004)(41300700001)(5660300002)(53546011)(6506007)(38100700002)(2616005)(26005)(66476007)(66946007)(66556008)(6916009)(316002)(8936002)(8676002)(4326008)(83380400001)(7416002)(15650500001)(6512007)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGYrWFg2V3ZsVTh6dWdzTUhQSk1nM0h1UzVFMmlSSDRrZ1M5WFJIbGhKU3h1?=
 =?utf-8?B?cWdaV2d4SE5paXZNc2FORUxVTTBIQ09DWEJBdGdaY1FyMWQrQkc5U09tS1NX?=
 =?utf-8?B?Ny82UkJwU0dNY3J4anVZays0a0diVUVKSnZLMlNmZG5nb3ZvRDNuZE04d0x5?=
 =?utf-8?B?SU05b3c1Q1RrY2NnYVhkU1VOSnVZM0prZG0xZ29LSXdpcHFsTlNvTURoWUs5?=
 =?utf-8?B?Nyt2RXlmOVdRUG9KMEtueEdFT2dSZjB6cHVaQjVBcWg3bm44dWk5OEQ4VFY0?=
 =?utf-8?B?UFYyVG5TRi82VVJ2MzdCaGFlcWxyZ3RmVXNwUjBEK0MrZXVYQWJBOTdHN1FB?=
 =?utf-8?B?cTJRbG94NWI0d1VUdXhwbUo4eHF2ZWxlREhmTHQzUkVnWFF0RWtLK2FoeTRt?=
 =?utf-8?B?dnNaa1kzRDh6cmJGekFWUUwyS0gwTnd1RU9mRkN3QjM4NGlEUUw4MUs5Sm1o?=
 =?utf-8?B?THJVM1BHY05xVmV3cEZDZGlGL2d0VmtaREpKUmFYblQvS0w2SmIvNWFleERU?=
 =?utf-8?B?N3h5MFhNVGl6TGlYNDlRbGNZdFVEeW9FSTcrelFNUDVpdWdOdXc0RnpMWXBt?=
 =?utf-8?B?M21tLzJYL0tyUVRxYlBVTWZFb3ZmMUN2c3pjaENMSCszZVlwajhWbVlkMlVv?=
 =?utf-8?B?bnJwZUlUTVpZSXVaRkdWUHhKM1JwZnJIQk5NWXNQT2t2bDVlcXFBN0wxb20z?=
 =?utf-8?B?VjBPSXNJSHBJVUIreHJ4YVNwU1lzNTRwOWJaMlViQXRCaG01WFhYQlluQXM3?=
 =?utf-8?B?UDAvSW9JVHM2NnhPZmZyL01YeEZDWDhuejdkVUx2WHBFaUw5eEpLaXhWdW1Z?=
 =?utf-8?B?eGlIOHNiTnZYT1JzRXNJWXpFMzRVQVM0Vm5rUWtOWlVFMHNodXB3QUtLdjFS?=
 =?utf-8?B?SjJld3ViNC8ySy8zekxSY2JiVzR6Mm9KZk0ycmpLR0p4VERkRWtFL2ZoMEht?=
 =?utf-8?B?ZXR6V3hnNGs4QytkbG5iRzdSUldoNWRDVGd4YytrL2x0RjU1WGUyRFpYRVNn?=
 =?utf-8?B?eGxpSWpYM0FoeEdnb1k4eU1QL1BUKzZxMjZ0ckt4eTk2czFxMy9JaWkrVFZL?=
 =?utf-8?B?RnBMcTg2cGtIMjZLT0M0ZDR6bTc1bDZCVlJodU5lOWsvRnc1cnNzL3RFMHFl?=
 =?utf-8?B?TGVYdVU4Z0ZJTlN1b0psdVA1V0t2c3lWODduWG1vb2JjRUppMXpFbG11NFN1?=
 =?utf-8?B?a09GdkNwdG9kWDRORTI4T0RRRTUvRmhwQkRZV2gzYmE4dFA3K0h0THdhWG5T?=
 =?utf-8?B?U2k5RkI5Ukc3aGtQVldFSFFkZFVYdEhyc0RkMlQwMHlUOTB4cnhzVno5cEdq?=
 =?utf-8?B?V291ZUJpdG1pbUJudzBoR3FQU1o1ZnVZazlsbVhzSXpVdnZTd1M5SWRmSDgw?=
 =?utf-8?B?d0o5bFVxQjNkL042NlovV1ZDZ1gwbFNuRmI5elByNWg0MkVSZlBzbDZvUlc4?=
 =?utf-8?B?V3I1TlpVNzBjMXZVZXVxM2NuSnp5ZU1lNDRPd2xsTGxFRDJwSFVQZnZmY05E?=
 =?utf-8?B?WmtnemhZNGZHWktVWWttb1EwQnM4SHdqcEI4dkIrZ2s2N01jek92cmpJMGQ5?=
 =?utf-8?B?cS9aTVVHUmFkakV0ZVNTOU5WekkrUWRlemhDakR3dkY5amVoS2pUc2hrZFFm?=
 =?utf-8?B?WEdQNnA4RVlCdllSbDIrNGhLK0hobXNRVlk3NCtPdThiazFsUXRaL3RnNXhQ?=
 =?utf-8?B?ckxPTFZpeGVWY0ZDZk05a29XMUVoVmh5ZEY3bm5CN3FYcXRYaTJweENXbHNx?=
 =?utf-8?B?UDY1Z3UxOUtwRUhNVG9oTHhoT3BWQVFlREtuUUdxOHhLVEQrdDlBcWZScVlN?=
 =?utf-8?B?TUFSR0hPOW9hcG8xWU9MV1ZHOTZZRkdUb3FFckxMOGJhUjJ5Ym5GT1Y4NDlN?=
 =?utf-8?B?MWxDZXhEWUF0WWJSNjF2YWUwR3VNQzlrTm9lanNkdGMyVURvTGsxTFdDSkgz?=
 =?utf-8?B?SnBiOE1tbFZGTWlQSUszWmZOMXZkREg3K1hTUWFmekdFRk1QRm5obTU0L2JQ?=
 =?utf-8?B?UStDSWRWMjhzUFRPNXZDcXRZRk5LaDRCSlEwaVNzS1dMOXFXQXJQTzFHMVl6?=
 =?utf-8?B?Zm9aZHdlNTBsZjF5V1c5YlRzampscksvbjBxRk1IS0dFMEVKbVY0Vy9QWG5F?=
 =?utf-8?Q?q70+q2Eh9tm/iyFPIi68iZnl2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efeaa00-86cc-46a8-c84c-08dbce0a429c
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:39:26.9045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cw5ESIZ3sPbCCeFCVZIcNnJFJUnVmNDxX3dyLSoHseCeyHKxX6Ct/qURSvzMGYSZsZ7xh400146yxlnFiD9vCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

I see a good and consistent improvement in Stream (with shorter loops)
with this change. Everything else is more or less the same.

I'll leave the detailed results below.

On 10/6/2023 10:18 PM, Daniel Jordan wrote:
> Placing wants current's vruntime and the cfs_rq's min_vruntime up to
> date so that avg_runtime() is too, and similarly it wants the entity to
> be re-weighted and lag adjusted so vslice and vlag are fresh, so always
> do update_curr() and update_cfs_group() beforehand.
> 
> There doesn't seem to be a reason to treat the 'curr' case specially
> after e8f331bcc270 since vruntime doesn't get normalized anymore.
> 
> Fixes: e8f331bcc270 ("sched/smp: Use lag to simplify cross-runqueue placement")
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>

o Machine details

- 3rd Generation EPYC System
- 2 sockets each with 64C/128T
- NPS1 (Each socket is a NUMA node)
- C2 Disabled (POLL and C1(MWAIT) remained enabled)

o Kernel Details

- tip:	tip:sched/core at commit 3657680f38cd ("sched/psi: Delete the
	'update_total' function parameter from update_triggers()") +
	cherry-pick commit 8dafa9d0eb1a sched/eevdf: Fix min_deadline heap
	integrity") from tip:sched/urgent + cherry-pick commit b01db23d5923
	("sched/eevdf: Fix pick_eevdf()") from tip:sched/urgent

update_curr_opt: tip + this patch

o Benchmark Results

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:           tip[pct imp](CV)    update_curr_opt[pct imp](CV)
 1-groups     1.00 [ -0.00]( 2.69)     1.01 [ -0.71]( 2.88)
 2-groups     1.00 [ -0.00]( 1.69)     1.01 [ -0.62]( 1.40)
 4-groups     1.00 [ -0.00]( 1.25)     1.01 [ -1.17]( 1.03)
 8-groups     1.00 [ -0.00]( 1.36)     1.00 [ -0.43]( 0.83)
16-groups     1.00 [ -0.00]( 1.44)     1.00 [ -0.13]( 2.32)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:    tip[pct imp](CV)    update_curr_opt[pct imp](CV)
    1     1.00 [  0.00]( 0.33)     1.01 [  0.52]( 1.51)
    2     1.00 [  0.00]( 0.22)     1.00 [ -0.01]( 0.37)
    4     1.00 [  0.00]( 0.25)     0.99 [ -0.71]( 0.60)
    8     1.00 [  0.00]( 0.71)     1.00 [ -0.26]( 0.36)
   16     1.00 [  0.00]( 0.79)     0.99 [ -1.21]( 0.77)
   32     1.00 [  0.00]( 0.94)     0.99 [ -0.82]( 1.46)
   64     1.00 [  0.00]( 1.76)     0.99 [ -0.92]( 1.25)
  128     1.00 [  0.00]( 0.68)     0.98 [ -2.22]( 1.19)
  256     1.00 [  0.00]( 1.23)     0.99 [ -1.43]( 0.79)
  512     1.00 [  0.00]( 0.28)     0.99 [ -0.93]( 0.14)
 1024     1.00 [  0.00]( 0.20)     0.99 [ -1.44]( 0.41)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)    update_curr_opt[pct imp](CV)
 Copy     1.00 [  0.00](11.88)     1.22 [ 21.92]( 7.37)
Scale     1.00 [  0.00]( 7.01)     1.04 [  4.02]( 4.89)
  Add     1.00 [  0.00]( 6.56)     1.11 [ 11.03]( 4.77)
Triad     1.00 [  0.00]( 8.81)     1.14 [ 14.12]( 3.89)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)    update_curr_opt[pct imp](CV)
 Copy     1.00 [  0.00]( 1.07)     1.01 [  0.77]( 1.59)
Scale     1.00 [  0.00]( 4.81)     0.97 [ -2.99]( 7.18)
  Add     1.00 [  0.00]( 4.56)     0.98 [ -2.39]( 6.86)
Triad     1.00 [  0.00]( 1.78)     1.00 [ -0.35]( 4.22)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:         tip[pct imp](CV)    update_curr_opt[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.62)     0.99 [ -1.03]( 0.24)
 2-clients     1.00 [  0.00]( 0.36)     1.00 [ -0.32]( 0.66)
 4-clients     1.00 [  0.00]( 0.31)     1.00 [ -0.17]( 0.44)
 8-clients     1.00 [  0.00]( 0.39)     1.00 [  0.24]( 0.67)
16-clients     1.00 [  0.00]( 0.58)     1.00 [  0.50]( 0.46)
32-clients     1.00 [  0.00]( 0.71)     1.01 [  0.54]( 0.66)
64-clients     1.00 [  0.00]( 2.13)     1.00 [  0.35]( 1.80)
128-clients    1.00 [  0.00]( 0.94)     0.99 [ -0.71]( 0.97)
256-clients    1.00 [  0.00]( 6.09)     1.01 [  1.28]( 3.41)
512-clients    1.00 [  0.00](55.28)     1.01 [  1.32](49.78)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers: tip[pct imp](CV)    update_curr_opt[pct imp](CV)
  1     1.00 [ -0.00]( 2.91)     0.97 [  2.56]( 1.53)
  2     1.00 [ -0.00](21.78)     0.89 [ 10.53](10.23)
  4     1.00 [ -0.00]( 4.88)     1.07 [ -7.32]( 6.82)
  8     1.00 [ -0.00]( 2.49)     1.00 [ -0.00]( 9.53)
 16     1.00 [ -0.00]( 3.70)     1.02 [ -1.75]( 0.99)
 32     1.00 [ -0.00](12.65)     0.83 [ 16.51]( 4.41)
 64     1.00 [ -0.00]( 3.98)     0.97 [  2.59]( 8.27)
128     1.00 [ -0.00]( 1.49)     0.96 [  3.60]( 8.01)
256     1.00 [ -0.00](40.79)     0.80 [ 20.39](36.89)
512     1.00 [ -0.00]( 1.12)     0.98 [  2.20]( 0.75)


==================================================================
Test          : ycsb-cassandra
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
metric      tip     update_curr_opt (%diff)
throughput  1.00    1.00 (%diff: -0.45%)


==================================================================
Test          : ycsb-mondodb
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
metric      tip     update_curr_opt (%diff)
throughput  1.00    1.00 (%diff: -0.13%)


==================================================================
Test          : DeathStarBench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
Pinning   scaling   tip     update_curr_opt (%diff)
1CCD        1       1.00    1.01 (%diff: 0.57%)
2CCD        2       1.00    1.00 (%diff: -0.27%)
4CCD        4       1.00    1.00 (%diff: 0.06%)
8CCD        8       1.00    1.00 (%diff: 0.45%)

--
Feel free to include

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

I'll keep a lookout for future versions.

> ---
> 
> Not sure what the XXX above place_entity() is for, maybe it can go away?
> 
> Based on tip/sched/core.
> 
>  kernel/sched/fair.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04fbcbda97d5f..db2ca9bf9cc49 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5047,15 +5047,6 @@ static inline bool cfs_bandwidth_used(void);
>  static void
>  enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> -	bool curr = cfs_rq->curr == se;
> -
> -	/*
> -	 * If we're the current task, we must renormalise before calling
> -	 * update_curr().
> -	 */
> -	if (curr)
> -		place_entity(cfs_rq, se, flags);
> -
>  	update_curr(cfs_rq);
>  
>  	/*
> @@ -5080,8 +5071,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	 * XXX now that the entity has been re-weighted, and it's lag adjusted,
>  	 * we can place the entity.
>  	 */
> -	if (!curr)
> -		place_entity(cfs_rq, se, flags);
> +	place_entity(cfs_rq, se, flags);
>  
>  	account_entity_enqueue(cfs_rq, se);
>  
> @@ -5091,7 +5081,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  
>  	check_schedstat_required();
>  	update_stats_enqueue_fair(cfs_rq, se, flags);
> -	if (!curr)
> +	if (cfs_rq->curr != se)
>  		__enqueue_entity(cfs_rq, se);
>  	se->on_rq = 1;
>  

--
Thanks and Regards,
Prateek
