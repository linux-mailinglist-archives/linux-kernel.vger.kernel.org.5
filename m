Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511FA7B224D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjI1Q2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1Q2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:28:49 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C7BBE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKzBqxX5l5bKW35nbF5OV7bBP8Wpk+2q0mUsRE/ECqPVWkUCcJy8qpWAGVAQJU7aka5ddazoIRpkkIUYbxfnYXHQ7rAJK9RRbINLdK8A++uI0ZjWgXhVsMxhK7G4hU6TmaiwC190T9Q93wKjW1iGfLC2aQzjV/JIjheez8YLHBv5c52DTXmFZRQKvTNVdpVNGceKzTAi9JmCDoMI4FwiRRZxgzlMS3wz5PDZ3yPur6ogenuOd/yI+Ckya9fqHAQ4zs4lkrZTVx+KalrTPS/WBn5VAKgTg0ZDUdL0ufETbYS7RataBrC0ONXtuGALZi1mu+B92bSOXhJ42VFT5Dl97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC7kiMioeCu3S5BReciTSAl2QvN+urVQDSpV2/Tasyc=;
 b=KVHumo8xJgQezryJQWpI1ebsgUo4yxFW/eJ+QMk5+4GTZqVkT4eNj75mzKmrD0qVzDXsL19stIoFmcnigiZhv40f3TgNlMxG8YPA5fTGReGnp3mZVXDv2gBPVeHOpnhA9CSJrRqdAV+HANFVwshbbpUPuWhMhK+x5UEUc5ebRONgu/svwuj8hKYpZmGw9UisUDaRLDUuid3OLoJFLGB9xR6DEiEIDTg7G5GRvCcVYy+IqzAf6uFRAXeMNlXF3tHpPRFZpyLi0NsMQ11yZ5fz/mPSaQK6Fda1eOepRN4eK/z7kfSZ1u9RWmnDzRwGtKIoZnoQq5NMHkIODVm4Swygqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC7kiMioeCu3S5BReciTSAl2QvN+urVQDSpV2/Tasyc=;
 b=A/fzERdpzeeAAzmF0021Hm9pcMffoeWyzlMlMDCr3o3l7o8/td6Zg7Ct8+pmz5uRKys7UnuEZd+iuxoUeDHgvypqEu5n4t/4ZajT1TmzALF1dFdxJphnxXvSf9NzYc7BY2yMT9FWSp5wGOpayYGJVpNS7/AOetH05jnAYdK8slc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB5421.namprd12.prod.outlook.com (2603:10b6:a03:3bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Thu, 28 Sep
 2023 16:28:44 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 16:28:44 +0000
Message-ID: <92d152f7-d7f5-0a41-b933-008f0fd03754@amd.com>
Date:   Thu, 28 Sep 2023 11:28:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 1/4] x86/resctrl: Enable non-contiguous bits in Intel
 CAT
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
 <918e147601697b1d4b8f8589f5751e05d6ceccdf.1695371055.git.maciej.wieczor-retman@intel.com>
 <9751cbaf-8653-d32a-6058-13c251c59b3d@amd.com>
 <4sxjxe4cgvookcobwbrmsoeszjordi3bpjg22zxut3lanjc46j@xpqt6nblx6uc>
 <13b360ac-4292-5056-6d00-6eb1d4186b11@amd.com>
 <8a5d1211-8acb-762d-ae36-bf508b082ef4@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8a5d1211-8acb-762d-ae36-bf508b082ef4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR01CA0014.prod.exchangelabs.com (2603:10b6:5:296::19)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB5421:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e5c5b3-40f1-4ceb-3273-08dbc03ffc01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: We8Ty07xnWFfJhrPWkm2MNw7Pv/Jlnh7afIFAxum0oZmJegI+oWghO/gAPYHp2gPJS5n39P3pJQiZvTjv5tYUuSO5zlrOpiYDq+8WO4E1xoLPhRa3CFvRfyjYwehpaz+/sWLBzUxwtN+YkjjN7oI4QdYv6wzTfwwqrFFN7gcIQ3uxnc1x/FfnDOtFVOGr4Lc3yZhRuKlEwFf/ll9gyNjeX34k9+S2fVDwYyv/gQY2wBZhhMt+pWHzbQYUnIXq2yJcyOFL+kSNkD2W/cobpubI855rGbJ50BW7mutu7XO+7NXbHhdAZgm2ZilJQGDFlu5QAXbakolFeook6XCzTmBP2DSIKOW30p0ZGNpe0OlccDJquZ8AFM97mMKQbn8eQvEf6sk1N4sOSpLn31xv0VTgJLF46skcw8H3jSevoRQGK+9p9zvA+VFINGIu2YRrhgWClB92p+YLjLGU+E6bSvmcksdtsjPHCNF0G+DbFzNoemXTpYbRB/88cPZwR/lNXzSx7YECUvPQDm65zDDEhXpeRK+umAY3t06mZgk4rrtn3Za8Uooz3HuJF1UtSPZMBiVfzmGsfrCaufdvHNcfY8w/iJJeVG6ue5XjO15/LWT4VN/wgppTdwZiNW3A2/QZctq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66574015)(6512007)(6506007)(53546011)(83380400001)(86362001)(31696002)(38100700002)(36756003)(2616005)(26005)(2906002)(5660300002)(316002)(7416002)(41300700001)(54906003)(3450700001)(66476007)(66556008)(66946007)(110136005)(966005)(6486002)(31686004)(8936002)(478600001)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzFFTXhLaEZpSTlEeGlRU0habkhOMFRTVGlFTzN2dEpKMFoxdHg4Wk5NdHY1?=
 =?utf-8?B?dVNrUVNGMWwzRzJJYSt5N2ZuR0hqclBkMitKL1E3c1dBYUtJcUJPQ1VnaENO?=
 =?utf-8?B?aUV5ZjJFQ2UxRmZWRXpLUXIrYWpvaUxJUy9nd0c4NGs1Q3VwcXJTS05HSnh1?=
 =?utf-8?B?N1BkdWNZUEVOYXQwbVJpaTlvUlI5U0UraitMSmFqdGo1NG1ObXhJTkFoQ3c0?=
 =?utf-8?B?VnpXM3NRdmZzQnVTc2tBVXRWLzhjTmhtc04wSWE1ZmxKeUU5a2ZnYTQ4ZWFX?=
 =?utf-8?B?cWkxK0FROXFYdlVTMmZRWm9oNWVTcmV4MnB5OVY0aFgxSkk4aWNERmNUZFZa?=
 =?utf-8?B?blN2VHhxaUd1N0RUTFBVVUdsK2djM3pqdmJiQjdiZmNSeGdyTGZTWFdBU3lS?=
 =?utf-8?B?aFJkREowQi9XK0VXQlZEZ0h5N1RxemJjblVLVWtNczZPaG8vL3BqZFdwSEll?=
 =?utf-8?B?Ymg2TVpvQzJha0RaMldhUDdwK0l4cmtFa0tDWi9FQjNLSDUxbTBORjlpUWp1?=
 =?utf-8?B?QjFLUnBZNVYvb2NsR2pkdk1iZUhwVGVMYWhuVGdYZGRHbDhWelZCR1VweXlo?=
 =?utf-8?B?UllKTWNtZkdsVStod2RxUmdYU1JzMWJzYzRndWY3bkEyelFJOGFuY2ZkTUxS?=
 =?utf-8?B?ZmpSK3NYeldRVGkzUjE5WG1VUll0Rkg3Vlh0NjJTWHhHU2daMnNCWmVhQXhM?=
 =?utf-8?B?UzUzZFM1SmdkZE1mdDBKMjRzeU1SaGlGVUxpMC81RFRvbmRRNVFFYi8zeWo4?=
 =?utf-8?B?d2JPazRQL2FJMnl5eTVCYVRhd0VNMllCWDdJZWx1TXFHaHU3ekdJWDhmVXMw?=
 =?utf-8?B?d1BVVHFJcmk5ekN5c0pRNEFDSDRsSjNXUEZMclNRTFJLUGZYajJqaVhZaCs2?=
 =?utf-8?B?LzRmMnhJWTVhbjlxZXR5Y2U0WUoyQzBYcHVCdTQwRlN6SGZYcmhCdlVjd1o3?=
 =?utf-8?B?OTNrcm5XOVNNdklZUVd4TC90REhqR2Z1enJFK0p2aXRPcm52MnRVZkNDdlZa?=
 =?utf-8?B?VFlxL2tXdGxQVlRLZXo0Nlh0MnBPYjFqSm44QjdWS0pxSjNpVXZpU0FsZ014?=
 =?utf-8?B?d1NKYy96OU5kdktsb0s0T2hpQVJ5MUhCSk1aN2JRZzczQTI5ZWFQTnVITE01?=
 =?utf-8?B?emlZb1MzL25DbGpDaWZDdmdlUlFSK3U0QkpncTZWZThZbkd3NmRxQTZ5VEVF?=
 =?utf-8?B?bm1JVmNjOFNGb2tMWXBlNlJmdU5YUkpJT2RERGMvV0FBNksxaU9KUzdHMzdp?=
 =?utf-8?B?NFN0cjBkS0hJR1JkNkp1L29NWkRidktTblAwdEZqSEFpQ3RKUGkzZjR2K2Vr?=
 =?utf-8?B?RFhlbGI1T0d2enRYQm8xM0h5YTJJN0hZUG1GYWlmT0JQQ1RDaDNmelFOQ0lC?=
 =?utf-8?B?cUE3cG9HWnpSSEt6SldkcFdqekcwaEdKUjlHOXpHVEJ5b2MwUmRCS1RKNzVW?=
 =?utf-8?B?T2FudUN1WCtVWDdvMkV1a05BYWRIVUI4UmpieCswcWFxZTM4TGVLV0NTekV2?=
 =?utf-8?B?R3RpTld5ZzMvaldBK1UxN3kyZCtteFB3WExmS0t3Mk9BaFV4UzRGZGpkMWNP?=
 =?utf-8?B?Ykk0KzBlWXZacC8yZjNQTkh6c3RtRnNuczhaNHgvNUx2WnJ5bWgrRm5rc0xq?=
 =?utf-8?B?MTNPMGp3L1Z3VDFidk55MjdrUzR4bGJsbjJSNExRaXBiaVJmV2JZREhlMkFV?=
 =?utf-8?B?a2xYUFlIVHR1clY1c3NQMVV5MWgzalMyYVhZdUluZUlaM2VyTFV0TmFOTk9T?=
 =?utf-8?B?d0RtWVZyd1lzelgzOVc2Yk9QMStDbmRXSm1ZVUgrZ25GYS9wajhxNEtlaW9T?=
 =?utf-8?B?ODEyaDdMTTBGaXh2M2NtanZlSXJFeWJsZzdoYkdoeHlVMG5mbHVoczJNTkx5?=
 =?utf-8?B?RVZSSVg5VEo5dHFVUHA3NkcxalNzUTdLYitQUUVWQnUrV0VFaXh1NjJia09Q?=
 =?utf-8?B?blJWUmorbitjeFdjZkptRmxOeHl0dXBXeERLMzk3TkJJK2s4bjRBajdwTFFX?=
 =?utf-8?B?UXh6NXVpYWZRR3NaR0UzKzJWRVhYUDRVWDJDQkRGdEN6bDQvK2x1d212V1dQ?=
 =?utf-8?B?Rm8yRHIzVXlqQy9KdUZmSm5yS1RFSkp3bkw0MCsreFF2Wm51K1NoR1E2ZEha?=
 =?utf-8?Q?o2vrm22FmHzgTjMrc3wkl9LLM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e5c5b3-40f1-4ceb-3273-08dbc03ffc01
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:28:44.7508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGPq8VlWVappjQkBZ7Z31yQdURX/HhiyzQRsB/Az7m6r/Rr9wDcEYFQkHb4/ZIqN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5421
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 9/28/23 10:53, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/28/2023 8:08 AM, Moger, Babu wrote:
>> On 9/28/23 02:06, Maciej Wieczór-Retman wrote:
>>> On 2023-09-27 at 17:34:27 -0500, Moger, Babu wrote:
>>>> On 9/22/2023 3:48 AM, Maciej Wieczor-Retman wrote:
> ...
> 
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>>>> index 030d3b409768..c783a873147c 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>>>> @@ -152,6 +152,7 @@ static inline void cache_alloc_hsw_probe(void)
>>>>>   	r->cache.cbm_len = 20;
>>>>>   	r->cache.shareable_bits = 0xc0000;
>>>>>   	r->cache.min_cbm_bits = 2;
>>>>> +	r->cache.arch_has_sparse_bitmaps = false;
>>>>
>>>> Is this change required?
>>>>
>>>> This is always set to false in rdt_init_res_defs_intel().
>>>
>>> The logic behind moving this variable initialization from
>>> rdt_init_res_defs_intel() into both cache_alloc_hsw_probe() and
>>> rdt_get_cache_alloc_cfg() is that the variable doesn't really have a
>>> default value anymore. It used to when the CPUID.0x10.1:ECX[3] and
>>> CPUID.0x10.2:ECX[3] bits were reserved.
>>>
>>> Now for the general case the variable is dependent on CPUID output.
>>> And only for Haswell case it needs to be hardcoded to "false", so the
>>> assignment makes more sense in Haswell probe rather than in the default
>>> section.
>>
>> Here is the current sequence order with your change.
>>
>> 1.
>> resctrl_late_init -> check_quirks -> __check_quirks_intel ->
>> cache_alloc_hsw_probe
>>    r->cache.arch_has_sparse_bitmaps = false; (new code)
>>
>> 2. resctrl_late_init -> rdt_init_res_defs -> rdt_init_res_defs_intel
>>    r->cache.arch_has_sparse_bitmaps = false; (old code)
>>
>> 3. resctrl_late_init -> get_rdt_resources -> get_rdt_alloc_resources ->
>> rdt_get_cache_alloc_cfg
>>    r->cache.arch_has_sparse_bitmaps = ecx.split.noncont; (new code)
>>
>> The code in (3) is going to overwrite whatever is set in (1) or (2).
>>
>> I would say you can just remove initialization in both (1) and (2). That
>> makes the code clearer to me. I assume reserved bits in Intel is always 0.
>>
> 
> I believe Maciej already addressed this in his response to a similar question
> from Peter. Please see:
> https://lore.kernel.org/lkml/xnjmmsj5pjskbqeynor2ztha5dmkhxa44j764ohtjhtywy7idb@soobjiql4liy/

The rdt_alloc_capable part is kind of hidden. Now it makes sense.
Thanks
Babu Moger
