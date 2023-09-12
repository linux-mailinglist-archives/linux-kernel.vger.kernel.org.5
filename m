Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5592D79D38C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbjILO1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjILO1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:27:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E53210D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKisALyqVtizQ+78b0riLTelD9ptYXBobGGdftJNdGEEpHalte7ovAhFPqwYfNacPHaVBRMIlwhckab9KUJQts/c5+HkWfgDnJrqB4CQs76LxR9bw2A7q8KMb908j5qAG4Ds3zLcQ54GUYOacQjozMKCw2jJG8wg3bcPECXxnYK5WEs4aPc9741MGb1JwSNKUReuUZUO9r3odEtpQevsUGLKUUPjSKRFqEp0jKhM0uPpOcqSxs/yTYO2e92lNOKsqbCwrzM7WnM1EOVkpPsvTS97QMSY+i76uIYTM3y6TNfqANCFT8kIP/ss87l2XHTODoHXWJ3taWLqHY8plMzr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDX0EkvdohX8eBsvKm2QiQU7TSdJTQRKei8+kwPGRO4=;
 b=A3gA1BBf3Gox018+LPRo24oL5lZaNM1VwmmSZ+rYKcuyd1OK6zRn2Qiy7j2D6uHzdzpM8GDF+XWlk4IiL8TJLU0IhoJglDpsqfVdRwnTMRJfCcLnohZPzEB8qPo5fyLsakEcChopUlpVFd/g5PZygjHcPwgv+mPoMMhkBnHNb6gcmnQ/uEQZWh1HIkoyVHbjfD37GdWKgaDyBm3bNvHwPXGQkwpK1HkL84/+J1WawuqvQ62nW4RbzXfR4ay2zROFVYnnACXx9Vx/tKgnmBBuD2JuBeyXpvHbuya+bvngADhjcubxJQiVVQIJpuo4gq5usWUCoCW/bMK4oRizMffLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDX0EkvdohX8eBsvKm2QiQU7TSdJTQRKei8+kwPGRO4=;
 b=aCFXfTnFtIJ1gcgeihAL0xn9rzz6Ob164SaqoDFyUDLYSZGW0S3W/caBrkCrBpAQ3kETJnrdzDdq6Rjt/ZdgnrUkjeDZtcqIwvRjDjeA7ep22/cWd18F9tc3j/qPfSB4Tf9O9jGz0VFA1/u6hC9fLBJ05itVavbwEZ3snaXdr+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 14:26:56 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 14:26:54 +0000
Message-ID: <229069c1-3d61-53bb-fff7-691942c48d21@amd.com>
Date:   Tue, 12 Sep 2023 19:56:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <31c910c2-717d-b86c-4e08-5c94383682e8@amd.com>
 <ZP7ptt70uF10wxlg@chenyu5-mobl2>
 <5b35ae2b-a401-2489-4b3a-a03e8284d138@amd.com>
 <ZQBaWRCmMOvIGmem@chenyu5-mobl2.ccr.corp.intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZQBaWRCmMOvIGmem@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::13) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5ae4ea-b93b-4633-c4d3-08dbb39c4fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeo5Ba6IIQkBGUAZI45LX70ezw87RjnaqIILlq794AW2F3HASCyd8R6bSvITv/SCMpK0Fr6rczhZxYLEnuUo/bCQbaIwC1HL7IDPVECbh2NqJa0XiESInLw1bkCBQQzjvhHJSnJrTelxMwfBpP8aipFAjUelEToqXXL+IjBKi0ZDUp4tRpaNtcth+1zdSfRhFEqxt5UBs6gMln9F4T67/wR2VtI3hrNxps1r4GV9UOOFPDes+oFzHCKHKymdFnBdC3QKjQHeIw2yKiHS69d7ep+mVIiC9niYf6FCzmf8lpMOplfmIe3VxNHb5A19DZXX7I5l7TJm1ddJB8TbrhgxnDRGdxZK+Wt+AU3BHjDaWNkb8JkzAjqkNKBolVWTJTR57Z6AxeoQ1uLMvBEnloDF0cXWETcSTaYa5rSwGSf8ePUj0Y8OkBZBRD3Cjr0b2XhemLkF4q5d/jS0p1LBYIFVsCnFlZGuQT1GEsfIohekvF+BUElg0s6RxIc/CbXjPNvi/YD5d/NDWNagBlGHHq3qzNybfD2HMitRMatD4/Gat5NOLPsg+4xGjuk1Gf0Cyxm5NUUhckjxvWWx5TCm5wYhODcY5Nkgo+W+rAuJ2LyDIyUJoxk93SGjsS71ZD54XAmHZ2lfIFnd5/IScqk2R0HZpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(1800799009)(451199024)(186009)(41300700001)(31686004)(6506007)(53546011)(6486002)(6666004)(38100700002)(36756003)(86362001)(31696002)(2616005)(6512007)(2906002)(83380400001)(26005)(4326008)(7416002)(8936002)(316002)(5660300002)(478600001)(8676002)(66556008)(6916009)(66946007)(54906003)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N20vQ0NFVHBPS2EzejVvWGRONllhdGY4c2F6cFAvVStlVUo5WHN6WGoybVVJ?=
 =?utf-8?B?THlyMktjdEFUNGE2alNPMjNhMHVaWFEvKzdwOVVZZHc1MkRqOENaUVhrUHlH?=
 =?utf-8?B?dGtVa2tLeE5ENVRUMkU1NnJXUnVxZnBGYk9jVEpGMmFNSXRGVlNoR3hSa01P?=
 =?utf-8?B?bzNMWG5YSjZUck4wb2E2RjRaRnkyVFZ5bzJ4YXBxQzBFSnJtZTNUMitpSEE5?=
 =?utf-8?B?NUgwbGs5YnpjdG9obm5na1ArVGNMbzVCeXVWNzZ2c2tNaW8vekhXTWd5M09p?=
 =?utf-8?B?T01mTGEyV05HNE84bmVaS1JEdlhMRDhTMmEzeExuVXJMOUtLS3FWdnFtSzRC?=
 =?utf-8?B?cTZ4b0JmdTVqVmREOUQ4OHVUd2M4amxWTWRPMSszbXFhUTRxZUNKWW4xUnpL?=
 =?utf-8?B?czloNFJHRG1xOHVzSnRBNmtZb1Q5VlJ2UVJGckxFQ25ES1FUZ2w5QzQzN2dv?=
 =?utf-8?B?ZDRkb3MzeVdXOWNCWkpJSFY3WjVIalZDcDJvZkdHNnF2RzNHaEZSd1RLNXk3?=
 =?utf-8?B?Lzg4eTZ2SHh6dEFhUkEyOXZXZ2Fndzc4VXdVMnBteUR1a3R5UFZ4eVhwamlt?=
 =?utf-8?B?UVZIellGcGZZSGxyVFpJOEh0VFRRQUJtRWI4eFVMaUMzNjQzbUFXN2ZTNmov?=
 =?utf-8?B?aTBZQkxKbG12aFhYaXM0aUs2bFlnend5YVNGMzVWYmtxQVpKTytweHc0bGFk?=
 =?utf-8?B?L0JNMHdaTjZJR0hoRnI1bUNsM0NhM0FkVFpRZWZFNmh6RGNSMXJxNE45TWds?=
 =?utf-8?B?S3ZWMW52Y1VIaTd0Z0ZpSHl3d1BkQ2k3N1NNbUZhL2NOdkRVN0xWKzVaeE1F?=
 =?utf-8?B?cVQ4cVZieHlQSTh2SUdSNTBSWFE1bFVManRNR3NpT2ZDWHBMeE1ydzV5MjJz?=
 =?utf-8?B?Zlp5LzZycSsrUzdMUDBtclNTWXRTbmdsWHBXcFp3eHB1UUJVZ3MwMFpJUEc0?=
 =?utf-8?B?d1JyMjlBSFBRK3JTVXVlZ3NkblFIVGFQRTRVR1MzWHBpNkNWMEtwUXM3aXpO?=
 =?utf-8?B?dmd5aGN0aE9Xei9MZ05YaFFOVjF2MDc2ci9pV29WcTdVYndUMXAvT1ZTdlhl?=
 =?utf-8?B?dllpTlFMbHYzRC9PS3JFeHhMVkFTTUhBb0htQlNhSFlIU2pLSGEyTFB3VGY0?=
 =?utf-8?B?VHdNQ1d0aFpnRCtqcGlUWXdheEtCdXpqQTlQZURGanlEWmRHcXQrbUhjQWJu?=
 =?utf-8?B?c3VtNjNDNU8yS3o2SlZuRUNFb09md3oxL0hsdFB0cXpRc09VNEtoWVh5Y3Ra?=
 =?utf-8?B?TTYyNUg5dW5jek12QmpTVXlzL21nMmZNR0hUUVVSSUtFWEt0ZUhFRUVnMFRN?=
 =?utf-8?B?eitjb0dYWGRNKzgrNzRQZGtiOTZIQVVNRWx6S1Y0UnJaelZoOEdpR1g5SHht?=
 =?utf-8?B?am9CdG9rUjJQMGhURXcreHk3SlVZOFBEa08xcmFZYUdSWHIxcERmNnVqRTVk?=
 =?utf-8?B?SGZUd3dkRlc4em5mZTFnZlZXalp3QnFPcGFsSklPajEvdEZLdWdWc3FXZGY1?=
 =?utf-8?B?WUZXd0JXUERiQXRHc3pEWFd0NWJiWDZJRnhVdmlpaWpXclg3MjdIUnBqTlIz?=
 =?utf-8?B?QkRaL1h5WWhHY0l4RU16bmYvQ2t6TVBOR2lBdVRZc2xmMFJhYnU4elRWUEpw?=
 =?utf-8?B?OFRpVExQUEs4c09QMVIzd2dVdGdMYUZKSGZzYzRLM3E5Mm9pNlB6aEZNRTU0?=
 =?utf-8?B?WGNuS3lFYlB1MytaTFgveis0aGhVT1VrY0pHOVM5T1Q4MmlMdjM3Mk1pSmUy?=
 =?utf-8?B?bFM0c2Q5RDZlZ3lFcEJCL2Viem1qSkdZdFY0VkNVSTlOOW04QnFCUEZwNHBq?=
 =?utf-8?B?S0NOWExHQ2R5enNicGhXRXhmWUdJbDNHU3NLLzRSTmt3UnhPQ2J6Y1FjR29V?=
 =?utf-8?B?MnZEelBLUjcydHZLdmpHWmd6b1RrYnJxWkF0YWJtQmJGZXphekpMUDJIZUFQ?=
 =?utf-8?B?MTJGKzV1S3plWTRTbjRXR1Y2SDdKNnBJS25QK2p2MEJRWjdHY05CMjJKVzFX?=
 =?utf-8?B?TlFqYngrNXRGTUtpUmt0QTdCT1FaSXdlZXNOOWp1U1VEUzQyM1FzRHRzdDRI?=
 =?utf-8?B?cXFYaWVKb0kxQVFCbFV2MUtvYlh1aW1kR00rb2JlS2p3Vm1pYXlnNkNFd2VJ?=
 =?utf-8?Q?pSgPNuE7yoh1/z+ub2zqJuV8B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5ae4ea-b93b-4633-c4d3-08dbb39c4fec
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:26:54.2255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UK20Ga+4U2MY3/90vBsNnMqKU1/wKN74Zfu4uNhf2bdOHWMvlLgDnVdLxONuQBi2AfdzCBIMSzrYqVsXdSoyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 9/12/2023 6:02 PM, Chen Yu wrote:
> [..snip..]
>
>>> If I understand correctly, WF_SYNC is to let the wakee to woken up
>>> on the waker's CPU, rather than the wakee's previous CPU, because
>>> the waker goes to sleep after wakeup. SIS_CACHE mainly cares about
>>> wakee's previous CPU. We can only restrict that other wakee does not
>>> occupy the previous CPU, but do not enhance the possibility that
>>> wake_affine_idle() chooses the previous CPU.
>>
>> Correct me if I'm wrong here,
>>
>> Say a short sleeper, is always woken up using WF_SYNC flag. When the
>> task is dequeued, we mark the previous  CPU where it ran as "cache-hot"
>> and restrict any wakeup happening until the "cache_hot_timeout" is
>> crossed. Let us assume a perfect world where the task wakes up before
>> the "cache_hot_timeout" expires. Logically this CPU was reserved all
>> this while for the short sleeper but since the wakeup bears WF_SYNC
>> flag, the whole reservation is ignored and waker's LLC is explored.
>>
> 
> Ah, I see your point. Do you mean, because the waker has a WF_SYNC, wake_affine_idle()
> forces the short sleeping wakee to be woken up on waker's CPU rather the
> wakee's previous CPU, but wakee's previous has been marked as cache hot
> for nothing?

Precisely :)

> 
>> Should the timeout be cleared if the wakeup decides to not target the
>> previous CPU? (The default "sysctl_sched_migration_cost" is probably
>> small enough to curb any side effect that could possibly show here but
>> if a genuine use-case warrants setting "sysctl_sched_migration_cost" to
>> a larger value, the wakeup path might be affected where lot of idle
>> targets are overlooked since the CPUs are marked cache-hot forr longer
>> duration)
>>
>> Let me know what you think.
>>
> 
> This makes sense. In theory the above logic can be added in
> select_idle_sibling(), if target CPU is chosen rather than
> the previous CPU, the previous CPU's cache hot flag should be
> cleared.
> 
> But this might bring overhead. Because we need to grab the rq
> lock and write to other CPU's rq, which could be costly. It
> seems to be a trade-off of current implementation.

I agree, it will not be pretty. Maybe the other way is to have a
history of the type of wakeup the task experiences (similar to
wakee_flips but for sync and non-syn wakeups) and only reserve
the CPU if the task wakes up more via non-sync wakeups? Thinking
out loud here.

> On the other
> hand, if the user sets the sysctl_sched_migration_cost to a quite
> large value:
> 1. Without SIS_CACHE, there is no task migration.

But that is in the load balancing path. I think the wakeup path will
still migrate the task. But I believe there might be very few cases
where all CPUs are marked cache-hot and the SIS_UTIL will not bail
out straight away as a result of high utilization. Probably a rare
scenario.

> 2. With SIS_CACHE enabled, all idle CPUs are cache hot and be skipped
>    in select_idle_cpu(), the wakee will be woken up locally.
> It seems to be of the same effect, so there is no much impact
> to wakeup behavior I suppose.
> 
> [..snip..]
> 

--
Thanks and Regards,
Prateek
