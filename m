Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBF378D990
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbjH3Sd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242891AbjH3J5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:57:06 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C862C1B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUAsIdY2sjacskHNMwIIhgedAQJa7JkFRtxLTKIsGs2CRx8vj3bJJr2E6xSv7xryCZUMB/u7jgVkwrOY8sL6CRnt4pfVcJtekzmlRXmqYzBMmBO3tEiVY0sZXJDm12TJjA52ORBWUU2QZCjaNQzmv9l7UZjGZmefifP0ahdbTeDGi49xec/5RQC4WLWfW9GhALrIX7KFV6uerb6QDLe3XgfqP+TGHNTZPmXsipcYhv70lKu+OE7Ct5Q9Ot14JVLP3PVy3TeQIY87DC4H0h+C/Iqveqx8fj19flxClkKtr5EXRxb80R8kpvsatGQNmjIWF5SOo/H7nQZ9nJIgngSLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7zUJDPUMQbP8k4fo0x69DJu5C6rLopPZa78e7V8Drk=;
 b=MKe805QEnv1+IsYb2bbcltLvYbb4KdLOXrhZlUHaNaWXWbzLIMRXq9fx4EplGNwn8QZHk15QBNPtyOo8pFQ12YtRn+P+rUf+PDtTFQ49J3Ru1wSKIy2Mt3kB5z0Rs9xystBwE65iweQnFKfov1cXKvKa9PKDdKh9Kdcq47Eh/7xqaUwIK7vvey3RKybpHJKH3wGEu1EWPJP181VGfNVpC7y5stJZz0AYc11lhs5QWsmNJJZldEtQIhUr2dh1SvFikbZTZlkY30tVkvjhcCJfiF+RrnKZWAK6sWAbuy5E3dV9f8lIURySiHDX83A/2TFD0GM613Wi1uQRmdOVuUq6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7zUJDPUMQbP8k4fo0x69DJu5C6rLopPZa78e7V8Drk=;
 b=l/KM7X+Ym7amKF9B4jiCZkZOXZZvOBLWfrYRQUGWjRbeP0FkhDHRux0QP/+RY9ro2+WrhYMFlHgH8A68vQY1G0q6MdG+13/4m4WPOWL/OjdUHxDP1wXrKbnPBkQ8iA7z1GYiUa0a02CR4Fyd4Tb9z0h13MmeJztzNrOAxlIaG54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 09:56:56 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 09:56:56 +0000
Message-ID: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
Date:   Wed, 30 Aug 2023 15:26:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 0/7] sched: Implement shared runqueue in CFS
Content-Language: en-US
To:     David Vernet <void@manifault.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com,
        kprateek.nayak@amd.com
References: <20230809221218.163894-1-void@manifault.com>
 <ZN3dW5Gvcb0LFWjs@BLR-5CG11610CF.amd.com> <20230818050355.GA5718@maniforge>
 <ZN8wfiAVttkNnFDe@BLR-5CG11610CF.amd.com>
 <ZOc7i7wM0x4hF4vL@BLR-5CG11610CF.amd.com> <20230824225150.GB6119@maniforge>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230824225150.GB6119@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::7) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: d53d282c-532c-4cd7-26d6-08dba93f7170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyArC7BaJggLmzb/TLchUsGCbF8rnhFG0MsPwtnVOp7Rvv2S4eV9m3z3Ky6d1heyBXavkR1LsV1D/eOZmuEw9m6YWIFBqszfYFeMbiK1jrKDTjDpslP5VBpZx4h3aNDX7uhDN3suzg85Of25fI55Qx0dvJSCaIJw24VLSccK4QU1phvHBc6z9SwSL8vyP0dPbsOH1U8ufM1Yy2eFnQXvFKQVSBdwBYie3ldcZ2tjI90XncH7oAG6KuNgm3mkr/b2P/+nxqlxK0oXfd/r00ER7WscMdFs2tR8SReJT9PSIPIZWJCQ3J5A1nCFKzlLebwt4Tfzd29xxh5I5IKZnNRnC9uC1k9bbcjJoCulMD9XZBJK+yjpJko67aFB+0C64Cd122EwYpbZs9xo74g0a4st5PnbTjvmn09WmOpik461itxxGMLYhGIrd2ulmThIIj8pDSQT8BdddtmawfMU8Ya7kD9wPtIruAwqqWVmTQ+79IGt7m6QgMQC4fhQz1vP81Q/M/0PBZwiDRCxiYjBY6f3G48o0NHVDKZC9TD4s4tr4hyABMLZpxrD7On0mrFyCiuXxiXo+cCSzJ+NamOczb3Teme+HZtK6j1bRyc27ZDK+OfCLrSbIMMUxaXf4yHUIUUKoMKSdRJBfhYBXZ1YTCn5RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(186009)(1800799009)(451199024)(31686004)(6486002)(6512007)(6666004)(6506007)(4326008)(86362001)(36756003)(38100700002)(31696002)(2906002)(30864003)(83380400001)(26005)(478600001)(53546011)(110136005)(8676002)(41300700001)(66556008)(8936002)(5660300002)(66946007)(66476007)(7416002)(316002)(6636002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW1XVkhYZndmV256K0RnczdPVjhyOG51eks5Ni93ODJrVnZzdnZiRFlsek1h?=
 =?utf-8?B?VjNjQ0k0V0lYZDhyY3NtS3NGWHU1MlZpeUlPOG83S3pvR3ZKWkhSR1VQY2lr?=
 =?utf-8?B?NW5rVys0bDV2ZGFMUk80WVZhdVZzMDAwcXIxVmppbjBFcWwrbzJuSHNOSXBD?=
 =?utf-8?B?MWtQNVpEaFpCdGw1QlZuTnNSakJudU5XZ2VwM2VVZlNPZ1grR09nRlRCMmNT?=
 =?utf-8?B?VXdGYlZuNHZ5MmkySTFaL0xhQTR0bWZYQmQ3bWNyUTBJL1EvU3ZuSnU1Y0Ex?=
 =?utf-8?B?OHV0QTdadStBSnIxZHRVU1Ewc3JNTEQ2OEMzWEpiS01UZkp0b3lrUDBDV215?=
 =?utf-8?B?YUcrMGZzcVdxMlE5MG1kamVxRmt6alZmNGNLWWJMemN0TGZOQmlib0drSjl1?=
 =?utf-8?B?ZngwaTdvN1c1NjZDR3hkNFRiaHlMaU9GMk5oOG5XQ3Q0UkZieE80MjZTUVlV?=
 =?utf-8?B?eHFtTFl1NXM1WG9GN3RiUEJ5VnlZallqZmU1VitsSlJER1R0OTJ6TGY5WTU2?=
 =?utf-8?B?YjJRNkpTbzkzdmIvcjJ4U0Q4ZVFkU1ltUDNuamJINlhJZHV0ZFhEZWRnc2V2?=
 =?utf-8?B?bkRzYUx6MkxmRXJJVkNJaHFvL01WRzFyM204a0tabHJyVkNNbno4N0pacDh0?=
 =?utf-8?B?UFk5L1FDSi93WnFFUTBXNUtvZTQ0ems5NTlReGYvemI3WlZqdDVFYnVlYVk4?=
 =?utf-8?B?dUxkTzdpcXRXR1RncVFWOUJzaFRNazVvUXZadzhSR1BUbHdpaEx1TU5PTDAy?=
 =?utf-8?B?VGNISVZGaUtJMkxwNDBPcjZ5Y1dPQnBtMlR0ZndMTXNIRVBGQTc5akhOZGNt?=
 =?utf-8?B?ZkNmMm8rSzRCb0RxYWZmUzBkaDcrTUxQZ0JNaENzK1BkZ1ZBM2RnUXkyYXpC?=
 =?utf-8?B?SlVwWHVJUHpKcmdhU00wTlA2eG43elJmc2dBNk5JdnlYWE9hRVRjVHJTVkR3?=
 =?utf-8?B?OStIN09rK05kajI0RmVKVEh4bExmRnBHR3BqOTB0YVVOREFkNzNxRHlTNFNE?=
 =?utf-8?B?NnlsU0lyZk0rK0Yxc1grai84VjFZb2tSdTRGWFRiUS91UEJBcDk2YmFBVnJh?=
 =?utf-8?B?dzF3eEdxRjFJbTVvclQ3YWx6Tk9Ma1IvcGU4Q0VyRXowVDBpSk93TDNIc3JW?=
 =?utf-8?B?TzV0cXRDaVRGc1BCSzNhTnBYd3lZNnlZaERxTEMzYlpkWnlFQ3lmQ2pGMklR?=
 =?utf-8?B?TkZBRnBDNW9EbWtsajV5SEVITzdKWGdMWmkzVEt1R2lyMjkra1hOQzVLUFVD?=
 =?utf-8?B?OWNLOENuLzFxVEJvdXQvRWZKWUVZa2dsODRJWE54Q09IRmJZSkgwWVdzN0lB?=
 =?utf-8?B?K2tvWEJxbGg5N21jN1ZaRUVOYmZrQkNYTThlNkpGNms1NVhXeVI1TFczcnAr?=
 =?utf-8?B?MGozL0xGTGZYVFl4aHhwMmQ5MGVNWHNZTjVObUNEdFI3TjRYVE9nRjlLM1FS?=
 =?utf-8?B?M2NQdTRzZWNFRW9CQS84ZWpXUEJvU2sxcFRZMTBQMk51UTlIUEhRNnAyNW9E?=
 =?utf-8?B?NjkxZkx2cUhPZlI4TlRxSlhOam9YUi9sdFAxSWlTTkZkcUdPbHh4ekhsb0Fu?=
 =?utf-8?B?Rll1NmxvbTl3T0RFREs3TGY4a1d2WlRGeWhaSDNwQm5sVGhsOEpCRVVLZ1pZ?=
 =?utf-8?B?QkIrRkl4Z3oyNFdtSXNiQmwzMFZPc3RUQUNNbXAra2EwZ1o4WGVKSDBSNS9L?=
 =?utf-8?B?Ukh5akI3V2VxWlVzbHNNVnc0eTlmV2E2bXhMcCtYNDdSM1loVXE4VUV0bGR3?=
 =?utf-8?B?TUJyajBGNHdRZk5KUmdySzM5Nzd4dklmSG9UWUZLbFVTSnovRGdDODU1bnVs?=
 =?utf-8?B?VmhxNzJIVyswckZ1SFpvUUd6TkNrU0ppV254NGR0WHZZTFptcjZmRERKQTBs?=
 =?utf-8?B?dU9kZzMwRzFYOUNURGxRMG94SmppMmt6eXhWZXBuRUtYbHd2Mno3b1ZuSC9p?=
 =?utf-8?B?VFVJNFl4YVVLOS9DSmtrK2lMTldXM0JsYWNGZmJsTER4aVJ0cUtMQzVXYTBw?=
 =?utf-8?B?Q0FHaGkxTDBac29MaU1HbVIxRE5VaVoxcENQTENMZHphN3JZZjB1bFFTd0Qy?=
 =?utf-8?B?SmpDcG5OMEdMSVBiRGtQNExxZ2YvdWpJbldOclFHbktlZi9xUmpSUDRESXNP?=
 =?utf-8?Q?XTKD5rtCSaG/C0FuXFGi619qB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53d282c-532c-4cd7-26d6-08dba93f7170
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 09:56:56.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9AYcn8o5FYBsppsArAT61q1lzszuDG/Fdm5bfHKVB+uXHokX7BDI4syQP/r3m/Rq5Bs5S+KaPiUMnTcEkJjvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

Short update based on some of my experimentation.

Disclaimer: I've been only looking at tbench 128 client case on a dual
socket 3rd Generation EPYC system (2x 64C/128T). Wider results may
vary but I have some information that may help with the debug and to
proceed further.

On 8/25/2023 4:21 AM, David Vernet wrote:
> On Thu, Aug 24, 2023 at 04:44:19PM +0530, Gautham R. Shenoy wrote:
>> Hello David,
>>
>> On Fri, Aug 18, 2023 at 02:19:03PM +0530, Gautham R. Shenoy wrote:
>>> Hello David,
>>>
>>> On Fri, Aug 18, 2023 at 12:03:55AM -0500, David Vernet wrote:
>>>> On Thu, Aug 17, 2023 at 02:12:03PM +0530, Gautham R. Shenoy wrote:
>>>>> Hello David,
>>>>
>>>> Hello Gautham,
>>>>
>>>> Thanks a lot as always for running some benchmarks and analyzing these
>>>> changes.
>>>>
>>>>> On Wed, Aug 09, 2023 at 05:12:11PM -0500, David Vernet wrote:
>>>>>> Changes
>>>>>> -------
>>>>>>
>>>>>> This is v3 of the shared runqueue patchset. This patch set is based off
>>>>>> of commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
>>>>>> bandwidth in use") on the sched/core branch of tip.git.
>>>>>
>>>>>
>>>>> I tested the patches on Zen3 and Zen4 EPYC Servers like last time. I
>>>>> notice that apart from hackbench, every other bechmark is showing
>>>>> regressions with this patch series. Quick summary of my observations:
>>>>
>>>> Just to verify per our prior conversation [0], was this latest set of
>>>> benchmarks run with boost disabled?
>>>
>>> Boost is enabled by default. I will queue a run tonight with boost
>>> disabled.
>>
>> Apologies for the delay. I didn't see any changes with boost-disabled
>> and with reverting the optimization to bail out of the
>> newidle_balance() for SMT and MC domains when there was no task to be
>> pulled from the shared-runq. I reran the whole thing once again, just
>> to rule out any possible variance. The results came out the same.
> 
> Thanks a lot for taking the time to run more benchmarks.
> 
>> With the boost disabled, and the optimization reverted, the results
>> don't change much.
> 
> Hmmm, I see. So, that was the only real substantive "change" between v2
> -> v3. The other changes were supporting hotplug / domain recreation,
> optimizing locking a bit, and fixing small bugs like the return value
> from shared_runq_pick_next_task(), draining the queue when the feature
> is disabled, and fixing the lkp errors.
> 
> With all that said, it seems very possible that the regression is due to
> changes in sched/core between commit ebb83d84e49b ("sched/core: Avoid
> multiple calling update_rq_clock() in __cfsb_csd_unthrottle()") in v2,
> and commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
> bandwidth in use") in v3. EEVDF was merged in that window, so that could
> be one explanation for the context switch rate being so much higher.
> 
>> It doesn't appear that the optimization is the cause for increase in
>> the number of load-balancing attempts at the DIE and the NUMA
>> domains. I have shared the counts of the newidle_balance with and
>> without SHARED_RUNQ below for tbench and it can be noticed that the
>> counts are significantly higher for the 64 clients and 128 clients. I
>> also captured the counts/s of find_busiest_group() using funccount.py
>> which tells the same story. So the drop in the performance for tbench
>> with your patches strongly correlates with the increase in
>> load-balancing attempts.
>>
>> newidle balance is undertaken only if the overload flag is set and the
>> expected idle duration is greater than the avg load balancing cost. It
>> is hard to imagine why should the shared runq cause the overload flag
>> to be set!
> 
> Yeah, I'm not sure either about how or why woshared_runq uld cause this
> This is purely hypothetical, but is it possible that shared_runq causes
> idle cores to on average _stay_ idle longer due to other cores pulling
> tasks that would have otherwise been load balanced to those cores?
> 
> Meaning -- say CPU0 is idle, and there are tasks on other rqs which
> could be load balanced. Without shared_runq, CPU0 might be woken up to
> run a task from a periodic load balance. With shared_runq, any active
> core that would otherwise have gone idle could pull the task, keeping
> CPU0 idle.
> 
> What do you think? I could be totally off here.
> 
> From my perspective, I'm not too worried about this given that we're
> seeing gains in other areas such as kernel compile as I showed in [0],
> though I definitely would like to better understand it.

Let me paste a cumulative diff containing everything I've tried since
it'll be easy to explain.

o Performance numbers for tbench 128 clients:

tip			: 1.00 (Var: 0.57%)
tip + vanilla v3	: 0.39 (var: 1.15%) (%diff: -60.74%)
tip + v3 + diff		: 0.99 (var: 0.61%) (%diff: -00.24%)

tip is at commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when
cfs bandwidth in use"), same as what Gautham used, so no EEVDF yet.

o Cumulative Diff

Should apply cleanly on top of tip at above commit + this series as is.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d67d86d3bfdf..f1e64412fd48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -198,7 +198,7 @@ struct shared_runq_shard {
 } ____cacheline_aligned;
 
 /* This would likely work better as a configurable knob via debugfs */
-#define SHARED_RUNQ_SHARD_SZ 6
+#define SHARED_RUNQ_SHARD_SZ 16
 #define SHARED_RUNQ_MAX_SHARDS \
 	((NR_CPUS / SHARED_RUNQ_SHARD_SZ) + (NR_CPUS % SHARED_RUNQ_SHARD_SZ != 0))
 
@@ -322,20 +322,36 @@ void shared_runq_toggle(bool enabling)
 }
 
 static struct task_struct *
-shared_runq_pop_task(struct shared_runq_shard *shard, int target)
+shared_runq_pop_task(struct shared_runq_shard *shard, struct rq *rq)
 {
+	int target = cpu_of(rq);
 	struct task_struct *p;
 
 	if (list_empty(&shard->list))
 		return NULL;
 
 	raw_spin_lock(&shard->lock);
+again:
 	p = list_first_entry_or_null(&shard->list, struct task_struct,
 				     shared_runq_node);
-	if (p && is_cpu_allowed(p, target))
+
+	/* If we find a task, delete if from list regardless */
+	if (p) {
 		list_del_init(&p->shared_runq_node);
-	else
-		p = NULL;
+
+		if (!task_on_rq_queued(p) ||
+		    task_on_cpu(task_rq(p), p) ||
+		    !is_cpu_allowed(p, target)) {
+			if (rq->ttwu_pending) {
+				p = NULL;
+				goto out;
+			}
+
+			goto again;
+		}
+	}
+
+out:
 	raw_spin_unlock(&shard->lock);
 
 	return p;
@@ -380,9 +396,12 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
 		curr_idx = (starting_idx + i) % num_shards;
 		shard = &shared_runq->shards[curr_idx];
 
-		p = shared_runq_pop_task(shard, cpu_of(rq));
+		p = shared_runq_pop_task(shard, rq);
 		if (p)
 			break;
+
+		if (rq->ttwu_pending)
+			return 0;
 	}
 	if (!p)
 		return 0;
@@ -395,17 +414,16 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
 	if (task_on_rq_queued(p) && !task_on_cpu(src_rq, p)) {
 		update_rq_clock(src_rq);
 		src_rq = move_queued_task(src_rq, &src_rf, p, cpu_of(rq));
-		ret = 1;
 	}
 
 	if (src_rq != rq) {
 		task_rq_unlock(src_rq, p, &src_rf);
 		raw_spin_rq_lock(rq);
 	} else {
+		ret = 1;
 		rq_unpin_lock(rq, &src_rf);
 		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
 	}
-	rq_repin_lock(rq, rf);
 
 	return ret;
 }
@@ -12344,50 +12362,59 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (!cpu_active(this_cpu))
 		return 0;
 
-	if (sched_feat(SHARED_RUNQ)) {
-		pulled_task = shared_runq_pick_next_task(this_rq, rf);
-		if (pulled_task)
-			return pulled_task;
-	}
-
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
 	 * measure the duration of idle_balance() as idle time.
 	 */
 	this_rq->idle_stamp = rq_clock(this_rq);
 
-	/*
-	 * This is OK, because current is on_cpu, which avoids it being picked
-	 * for load-balance and preemption/IRQs are still disabled avoiding
-	 * further scheduler activity on it and we're being very careful to
-	 * re-start the picking loop.
-	 */
-	rq_unpin_lock(this_rq, rf);
-
 	rcu_read_lock();
-	sd = rcu_dereference_check_sched_domain(this_rq->sd);
-
-	/*
-	 * Skip <= LLC domains as they likely won't have any tasks if the
-	 * shared runq is empty.
-	 */
-	if (sched_feat(SHARED_RUNQ)) {
+	if (sched_feat(SHARED_RUNQ))
 		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
-		if (likely(sd))
-			sd = sd->parent;
-	}
+	else
+		sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
 	if (!READ_ONCE(this_rq->rd->overload) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
-		if (sd)
+		while (sd) {
 			update_next_balance(sd, &next_balance);
+			sd = sd->child;
+		}
+
 		rcu_read_unlock();
 
 		goto out;
 	}
 	rcu_read_unlock();
 
+	t0 = sched_clock_cpu(this_cpu);
+	if (sched_feat(SHARED_RUNQ)) {
+		pulled_task = shared_runq_pick_next_task(this_rq, rf);
+		if (pulled_task) {
+			curr_cost = sched_clock_cpu(this_cpu) - t0;
+			update_newidle_cost(sd, curr_cost);
+			goto out_swq;
+		}
+	}
+
+	/* Check again for pending wakeups */
+	if (this_rq->ttwu_pending)
+		return 0;
+
+	t1 = sched_clock_cpu(this_cpu);
+	curr_cost += t1 - t0;
+
+	if (sd)
+		update_newidle_cost(sd, curr_cost);
+
+	/*
+	 * This is OK, because current is on_cpu, which avoids it being picked
+	 * for load-balance and preemption/IRQs are still disabled avoiding
+	 * further scheduler activity on it and we're being very careful to
+	 * re-start the picking loop.
+	 */
+	rq_unpin_lock(this_rq, rf);
 	raw_spin_rq_unlock(this_rq);
 
 	t0 = sched_clock_cpu(this_cpu);
@@ -12400,6 +12427,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 		update_next_balance(sd, &next_balance);
 
+		/*
+		 * Skip <= LLC domains as they likely won't have any tasks if the
+		 * shared runq is empty.
+		 */
+		if (sched_feat(SHARED_RUNQ) && (sd->flags & SD_SHARE_PKG_RESOURCES))
+			continue;
+
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
 			break;
 
@@ -12429,6 +12463,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	raw_spin_rq_lock(this_rq);
 
+out_swq:
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
 
--

o Breakdown

I'll proceed to annotate a copy of diff with reasoning behind the changes:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d67d86d3bfdf..f1e64412fd48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -198,7 +198,7 @@ struct shared_runq_shard {
 } ____cacheline_aligned;
 
 /* This would likely work better as a configurable knob via debugfs */
-#define SHARED_RUNQ_SHARD_SZ 6
+#define SHARED_RUNQ_SHARD_SZ 16
 #define SHARED_RUNQ_MAX_SHARDS \
 	((NR_CPUS / SHARED_RUNQ_SHARD_SZ) + (NR_CPUS % SHARED_RUNQ_SHARD_SZ != 0))

--

	Here I'm setting the SHARED_RUNQ_SHARD_SZ to sd_llc_size for
	my machine. I played around with this and did not see any
	contention for shared_rq lock while running tbench.

--

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d67d86d3bfdf..f1e64412fd48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -322,20 +322,36 @@ void shared_runq_toggle(bool enabling)
 }
 
 static struct task_struct *
-shared_runq_pop_task(struct shared_runq_shard *shard, int target)
+shared_runq_pop_task(struct shared_runq_shard *shard, struct rq *rq)
 {
+	int target = cpu_of(rq);
 	struct task_struct *p;
 
 	if (list_empty(&shard->list))
 		return NULL;
 
 	raw_spin_lock(&shard->lock);
+again:
 	p = list_first_entry_or_null(&shard->list, struct task_struct,
 				     shared_runq_node);
-	if (p && is_cpu_allowed(p, target))
+
+	/* If we find a task, delete if from list regardless */
+	if (p) {
 		list_del_init(&p->shared_runq_node);
-	else
-		p = NULL;
+
+		if (!task_on_rq_queued(p) ||
+		    task_on_cpu(task_rq(p), p) ||
+		    !is_cpu_allowed(p, target)) {
+			if (rq->ttwu_pending) {
+				p = NULL;
+				goto out;
+			}
+
+			goto again;
+		}
+	}
+
+out:
 	raw_spin_unlock(&shard->lock);
 
 	return p;
--

	Context: When running perf with IBS, I saw following lock
	contention:

-   12.17%  swapper          [kernel.vmlinux]          [k] native_queued_spin_lock_slowpath
   - 10.48% native_queued_spin_lock_slowpath
      - 10.30% _raw_spin_lock
         - 9.11% __schedule
              schedule_idle
              do_idle
            + cpu_startup_entry
         - 0.86% task_rq_lock
              newidle_balance
              pick_next_task_fair
              __schedule
              schedule_idle
              do_idle
            + cpu_startup_entry

	So I imagined the newidle_balance is contending with another
	run_queue going idle when pulling task. Hence, I moved some
	checks in shared_runq_pick_next_task() to here.

	I was not sure if the task's rq lock needs to be held to do this
	to get an accurate result so I've left the original checks in
	shared_runq_pick_next_task() as it is.

	Since retry may be costly, I'm using "rq->ttwu_pending" as a
	bail out threshold. Maybe there are better alternates with
	the lb_cost and rq->avg_idle but this was simpler for now.

	(Realizing as I write this that this will cause more contention
	with enqueue/dequeue in a busy system. I'll check if that is the
	case)

	P.S. This did not affect the ~60% regression I was seeing one
	bit so the problem was deeper.

--
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d67d86d3bfdf..f1e64412fd48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -380,9 +396,12 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
 		curr_idx = (starting_idx + i) % num_shards;
 		shard = &shared_runq->shards[curr_idx];
 
-		p = shared_runq_pop_task(shard, cpu_of(rq));
+		p = shared_runq_pop_task(shard, rq);
 		if (p)
 			break;
+
+		if (rq->ttwu_pending)
+			return 0;
 	}
 	if (!p)
 		return 0;
--

	More bailout logic.

--
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d67d86d3bfdf..f1e64412fd48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -395,17 +414,16 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
 	if (task_on_rq_queued(p) && !task_on_cpu(src_rq, p)) {
 		update_rq_clock(src_rq);
 		src_rq = move_queued_task(src_rq, &src_rf, p, cpu_of(rq));
-		ret = 1;
 	}
 
 	if (src_rq != rq) {
 		task_rq_unlock(src_rq, p, &src_rf);
 		raw_spin_rq_lock(rq);
 	} else {
+		ret = 1;
 		rq_unpin_lock(rq, &src_rf);
 		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
 	}
-	rq_repin_lock(rq, rf);
 
 	return ret;
 }
--

	Only return 1 is task is actually pulled else return -1
	signifying the path has released and re-aquired the lock.

	Also leave the rq_repin_lock() part to caller, i.e.,
	newidle_balance() since it makes up for a nice flow (see
	below).

--
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d67d86d3bfdf..f1e64412fd48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12344,50 +12362,59 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (!cpu_active(this_cpu))
 		return 0;
 
-	if (sched_feat(SHARED_RUNQ)) {
-		pulled_task = shared_runq_pick_next_task(this_rq, rf);
-		if (pulled_task)
-			return pulled_task;
-	}
-
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
 	 * measure the duration of idle_balance() as idle time.
 	 */
 	this_rq->idle_stamp = rq_clock(this_rq);
 
-	/*
-	 * This is OK, because current is on_cpu, which avoids it being picked
-	 * for load-balance and preemption/IRQs are still disabled avoiding
-	 * further scheduler activity on it and we're being very careful to
-	 * re-start the picking loop.
-	 */
-	rq_unpin_lock(this_rq, rf);
-
 	rcu_read_lock();
-	sd = rcu_dereference_check_sched_domain(this_rq->sd);
-
-	/*
-	 * Skip <= LLC domains as they likely won't have any tasks if the
-	 * shared runq is empty.
-	 */
-	if (sched_feat(SHARED_RUNQ)) {
+	if (sched_feat(SHARED_RUNQ))
 		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
-		if (likely(sd))
-			sd = sd->parent;
-	}
+	else
+		sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
 	if (!READ_ONCE(this_rq->rd->overload) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
-		if (sd)
+		while (sd) {
 			update_next_balance(sd, &next_balance);
+			sd = sd->child;
+		}
+
 		rcu_read_unlock();
 
 		goto out;
 	}
 	rcu_read_unlock();
 
+	t0 = sched_clock_cpu(this_cpu);
+	if (sched_feat(SHARED_RUNQ)) {
+		pulled_task = shared_runq_pick_next_task(this_rq, rf);
+		if (pulled_task) {
+			curr_cost = sched_clock_cpu(this_cpu) - t0;
+			update_newidle_cost(sd, curr_cost);
+			goto out_swq;
+		}
+	}
+
+	/* Check again for pending wakeups */
+	if (this_rq->ttwu_pending)
+		return 0;
+
+	t1 = sched_clock_cpu(this_cpu);
+	curr_cost += t1 - t0;
+
+	if (sd)
+		update_newidle_cost(sd, curr_cost);
+
+	/*
+	 * This is OK, because current is on_cpu, which avoids it being picked
+	 * for load-balance and preemption/IRQs are still disabled avoiding
+	 * further scheduler activity on it and we're being very careful to
+	 * re-start the picking loop.
+	 */
+	rq_unpin_lock(this_rq, rf);
 	raw_spin_rq_unlock(this_rq);
 
 	t0 = sched_clock_cpu(this_cpu);
--

	This hunk does a few things:

	1. If a task is successfully pulled from shared rq, or if the rq
	   lock had been released and re-acquired with, jump to the
	   very end where we check a bunch of conditions and return
	   accordingly.

	2. Move the shared rq picking after the "rd->overload" and
	   checks against "rq->avg_idle".

	   P.S. This recovered half the performance that was lost.

	3. Update the newidle_balance_cost via update_newidle_cost()
	   since that is also used to determine the previous bailout
	   threshold.

	4. A bunch of update_next_balance().

	5. Move rq_unpin_lock() below. I do not know the implication of
	   this the kernel is not complaining so far (mind you I'm on
	   x86 and I do not have lockdep enabled)

	A combination of 3 and 4 seemed to give back the other half of
	tbench performance.

--
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d67d86d3bfdf..f1e64412fd48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12400,6 +12427,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 		update_next_balance(sd, &next_balance);
 
+		/*
+		 * Skip <= LLC domains as they likely won't have any tasks if the
+		 * shared runq is empty.
+		 */
+		if (sched_feat(SHARED_RUNQ) && (sd->flags & SD_SHARE_PKG_RESOURCES))
+			continue;
+
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
 			break;
 
--

	This was based on my suggestion in the parallel thread.

	P.S. This alone, without the changes in previous hunk showed no
	difference in performance with results same as vanilla v3.

--
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d67d86d3bfdf..f1e64412fd48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12429,6 +12463,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	raw_spin_rq_lock(this_rq);
 
+out_swq:
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
 
--

	The last part of newidle_balance() does a bunch of accounting
	which is relevant after the above changes. Also the
	rq_repin_lock() I had removed now happens here.

--

Again most of this is lightly tested with just one workload but I would
like to hear your thoughts, especially with the significance of
"rd->overload", "max_newidle_lb_cost", and "update_next_balance()".
however, I'm afraid these may be the bits that led to the drop in
utilization you mentioned in the first place.

Most of the experimentation (except for rq lock contention using IBS)
was done by reading the newidle_balance() code.

Finally a look at newidle_balance counts (tip vs tip + v3 + diff) for
128-clients of tbench on the test machine:


< ----------------------------------------  Category:  newidle (SMT)  ---------------------------------------- >
load_balance cnt on cpu newly idle                         :     921871,   0	(diff: -100.00%)
--
< ----------------------------------------  Category:  newidle (MC)   ---------------------------------------- >
load_balance cnt on cpu newly idle                         :     472412,   0	(diff: -100.00%)
--
< ----------------------------------------  Category:  newidle (DIE)  ---------------------------------------- >
load_balance cnt on cpu newly idle                         :        114, 279	(diff: +144.74%)
--
< ----------------------------------------  Category:  newidle (NUMA) ---------------------------------------- >
load_balance cnt on cpu newly idle                         :          9,   9	(diff: +00.00%)
--

Let me know if you have any queries. I'll go back and try to bisect the
diff to see if only a couple of changes that I thought were important
are good enought to yield back the lost performance. I'll do wider
testing post hearing your thoughts.

> 
> [..snip..]
> 
> So as I said above, I definitely would like to better understand why
> we're hammering load_balance() so hard in a few different contexts. I'll
> try to repro the issue with tbench on a few different configurations. If
> I'm able to, the next step would be for me to investigate my theory,
> likely by doing something like measuring rq->avg_idle at wakeup time and
> in newidle_balance() using bpftrace. If avg_idle is a lot higher for
> waking cores, maybe my theory isn't too far fetched?
> 
> With all that said, it's been pretty clear from early on in the patch
> set that there were going to be tradeoffs to enabling SHARED_RUNQ. It's
> not surprising to me that there are some configurations that really
> don't tolerate it well, and others that benefit from it a lot. Hackbench
> and kernel compile seem to be two such examples; hackbench especially.
> At Meta, we get really nice gains from it on a few of our biggest
> services. So my hope is that we don't have to tweak every possible use
> case in order for the patch set to be merged, as we've already done a
> lot of due diligence relative to other sched features.
> 
> I would appreciate hearing what others think as well.
> 
> Thanks,
> David

--
Thanks and Regards,
Prateek
