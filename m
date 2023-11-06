Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8067E1AB4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjKFHGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKFHGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:06:44 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F925CC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:06:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iejtw4/GAWjYEXB80bdbGJR+8O1wnHoPwD4/Pm4qYMrOIIm6Wxl0qRKcnqhmn/yeBzD56iby2aYnYuvT0WZAJjh6jXaoj6EZx91pDFrVRKr5CH+LjnYxneDEW289zbaWiG/AcK3BpxuwoF+yjXXZ4eVd+u3IEsC3NbfD0/+YwG33J7Ic+DLZVcbwMuQsUH0LR3etXGbaT0Yd8lc1shr07pXiRKTHmRw/vVZciVippiabPgnQzN/UXEs1Ab4SlC8ccgaRKeahCZu4j2UDG1kd71KrgQxCfjX8c3mF/D4eRJEH8NZrVCvvZi1FFExNTadXVDRMpQ6+UmjIUrjaBge9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZORgl0CvoNncozR8MqS/8I6W8xAhebnTR7ig7UTGUs=;
 b=a7kFqCuYVmjEgURCS/DG4U/k/4Jx+eNo/cNLzhdw3Ujp+gXRToA3YgjWQvpw2RZkesDVEn/VcSv2eUhDRCBD+bxmq6qaPp+nv7bciR09ww3x1SgyUcwpwbn+OEWDfK9m9phm3YSVH1G1wxYprD9qv6MI1w8+GDL35bFKu2pORnKb4QthhmE2Kr/pGI5fkcqr5/vgdd3ic7LDTfSJxZ0ZyGWbRWj3P147ZuDa4fuk+tQ+U8u3CYKAUGXyETzHp65HbM+VZhUelmgS+5HQ5hxBo1pLYM4RRcMA3h6KndP27/3/1xYLDDaeNHrRFRaADXQCMJ3DX/+m1UnIJcT3DMH4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZORgl0CvoNncozR8MqS/8I6W8xAhebnTR7ig7UTGUs=;
 b=a1N5TvmH4l4xyeFeVG4kgk1uJYfzhpmwxZEpXHsltgHRbJBSynCRrEnAMZWoOab5WxkzyE6UHf1FeJC4sCFntBfzNSzuPXVCOpAGET1kyokHSRTrusgh7zQezJwGkU4E/EoscI1kNt2CMELUMimsd3qhgDLNktpYI1VGHNMBmhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Mon, 6 Nov
 2023 07:06:39 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::90ac:49b0:329:8bc8]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::90ac:49b0:329:8bc8%6]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 07:06:38 +0000
Message-ID: <a95bab2c-7f7a-18a2-6307-ffcdef4e2726@amd.com>
Date:   Mon, 6 Nov 2023 12:36:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH v2 0/2] sched/fair migration reduction features
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <85b710a9-5b26-b0df-8c21-c2768a21e182@amd.com>
 <ZUh/LK4iy3ukVaCn@chenyu5-mobl2.ccr.corp.intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZUh/LK4iy3ukVaCn@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::14) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 2075d211-2e87-4b60-5940-08dbde96eb9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGhfsOtfx8pcOcAr9tkHvwkHcpT6nNu66Sz/oiBt9Ec99ofA3108+0hnvAhte6y9vwMWT36iOPqgvgYIvZblZ3btLsz2xC75M5qQ0RhqU/IbEMC/AGfr7wqTbxOHjnNvQyRsQ3AuBHX0aptmX5Mb1SyNitQALkTCKNtQh9tqMUDmSAWrqGcfnnfGN3bqKpcMdOR0+kKmAUPARHsF+xBHbIaL0thLGuAWKm+H1M5Uvk+wj26/EsXqwza+4OtCBDP7RFsVKld5OqwdKipg7EQ08u6XDmhbr56jJcK/9RtiDEgebPz7EP9jxAMI30oiInMkKwEJQl21R4zmTY3MDepme1vgEZVVuWQp6VkSEWIfR0OrOM+S70jILulVmOmCk/EN71xWa9GszU48AYzzlMtPmIAzi8E3W42Yn/ouTf8Fg5DzXFukgKfaTlBcfb73z96+yJxKQ9Ed3YQ+gqDRkRnKz+UDTZaOitmd7Kvw6ZNE7WmRJPx0uHBzmlgGEaJNzxdrqlN18xda7tbk1PBhkj7rTCmXA1N/SSj05G2FPUS5gSGnQ+gLkzd1gNGbSMnYVPAxBRpCYufcCWSKH86EWMnd/tZi1nOXEzeWEk6oIQDmC6upgLkSXUus2PNTNqHpBHXXd7sCv5chgMsRfVsT+Lp7TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(83380400001)(66899024)(53546011)(8936002)(966005)(110136005)(26005)(38100700002)(54906003)(7416002)(66556008)(316002)(66946007)(5660300002)(6506007)(6486002)(4326008)(6666004)(8676002)(478600001)(2616005)(66476007)(41300700001)(2906002)(4001150100001)(6512007)(31696002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkVjejRSL1h1VnBtYVM5K3NIT0l4S1J5d3AxdFhTWEYzalMvTnhiQWY2RitT?=
 =?utf-8?B?akRwQk9hYVZDK0NVUVMrL1NCQjJhcW1EVXdnbnowVWZIQldyN1ZKbVptZU5y?=
 =?utf-8?B?KzBIanFZNlZOeGN2a3pZSEpZZGhDSzhGWlc2Qy8xK3dOcExSN01iVk04RlBK?=
 =?utf-8?B?UHBUeE5rZmJrczhwZHRDc1FIUHZQajZPMzJVWGoydDdud3p2VTQ5V0tITWFp?=
 =?utf-8?B?b1BFQmxta1IvaEVuTzBXY21oTVIrRDM2M3ZLOWZqWTRlOHhNaEI5dHhORFk5?=
 =?utf-8?B?U1g0STZyb1ZXSTE0akJUaDBtZjl0bUZyU2tyUDRUM2hSZ0g0ODd2YVo5VjVy?=
 =?utf-8?B?NUR5aW44NGx3QUtmTWRjdG9jdzZWQ09YWFdBek1wczU2OHpGZDVjMlMrempx?=
 =?utf-8?B?OGp1Q3pjNHJOT3M4WnNRTTNocXBydXY5bGx2RVlkODZuK1ZUdkpHOG1wRnZK?=
 =?utf-8?B?VFlERjE5S3JMS25LQVFuWCtkRTBQbktlVDgvRXNEQ2JtQUJBd20ybEIzVFJG?=
 =?utf-8?B?cm5BQWVmR3dseWc4QlhGK21SdllPd2V6TXZ5Tit5NzdTS3czMGVJVXRHeVU2?=
 =?utf-8?B?WklXM2IvbEhPYkZwVDYrTnJ3bzFkUnl6ZnlhbjJZa0lzTDJ4VThSUVZudzNC?=
 =?utf-8?B?WXFSMElGTC9DdjRpVXpYdU03cVpJTHNQbHZlRUV2UjZsNy9sNU0vbk5iWW5P?=
 =?utf-8?B?OWQ1RGdmWFJnQkdKUXJWeWRkUG5FaGJUaVd6d2pMWjdvNU1jY0U3SXQvaHJB?=
 =?utf-8?B?NVVHZ3QvZGR2R1o0dmN0L3lGMXZoM0JxaTFvcllGeW1IY3NPYUppNFdHOVhh?=
 =?utf-8?B?TXJTdUE5ZHJROHRaVURNOWFBS3VMSnBFeFNJcUxwSzZKTWYyZjlCQzRZaENG?=
 =?utf-8?B?TlU2Ni9odGxUU2FjRlRscnJWY3l2TjQ1U1ZjLzh5bm1QMWdFNUtlNlR0Z3k3?=
 =?utf-8?B?UXlHQVhmWDZscUVSdUwvSG1QbEJIa0pRbUlwQXUyeTY3NnFVME81Z2JuT2ts?=
 =?utf-8?B?SzJNQnpqSGd3QUJET2puZ1pCZzBoQk9NYnphd0pGa3A1NlV4YTJFdDBTT0Ri?=
 =?utf-8?B?bEhOQklXNnozOG45NGxKNUdYZkw2MHJOeWxRMUZ1dCs5N0NQM1Q1N3IrblI3?=
 =?utf-8?B?azA5aGVMamc4MkhFUjF2V1V3V1N3MUNMclhra1hOV2x0Qjlac3hKRUpNM080?=
 =?utf-8?B?UzFWZVNpMHhtUHB2YmhjT0JBNHppalhIUDhPamdHaDVybTJhaDMzUllYUzB2?=
 =?utf-8?B?K0xNaUJDZFN2N1l3TTZqU2RyU0k4ekVUbEQ3bmdyczBsTVhOQnlyQ2Q0SXNp?=
 =?utf-8?B?Nk9tMHNwZXVpdjI4TXorSFRMSTVSVVlwU1FJRnJ1eHp1eXpobjgxL3lTUzFV?=
 =?utf-8?B?YThud1ZCc3ZIcWRpdnRTN3U3bnVrckhOZ1dOcTRUOTNHWUZ4eWlCVVBwMWFI?=
 =?utf-8?B?MG9vZmNwemoyM2JTOERvVUpxVEpOSHJaZy90SDBDUjlvaVVOUzhEZ2VOSi8r?=
 =?utf-8?B?Y245WU41dnFSRGVQL2d3SGlycXkrUHc3YXZGM2VPKzJnY1o0MTV6cFBRdnFq?=
 =?utf-8?B?OVlUbElDTzExVlY3WWpPNkFoRDM3UUd5SDdHZlQ2bU1VUFhRdldrV0Vhb3Bu?=
 =?utf-8?B?elp5ZXdJajJ6U1prelBEblB3cTc0R3BuZjFWclhFVVh6Q1ltZGlERWloUXBR?=
 =?utf-8?B?VGZTL0dzTFBHZzVjRFN4S3lTUVVUWlNpamxqQTZubFdMc0ZKRUlleVZkM0J1?=
 =?utf-8?B?TnYrdU1YTnk1ak9BZy9xZjlEUmJEV0N6NnJUNmM3N3JndlZRUk5TaXdubnBm?=
 =?utf-8?B?cHRuWHhOOG5nNWNodDdETnE0KytmSTRhRkZqbkk5NXBWdFJjZU9vanJ0RkF5?=
 =?utf-8?B?WVM0ZzV6R0tKaFBSdXUxY3o2akhSOHFNR3FiT0phVHdLL3ZlemJqMDBSS0dm?=
 =?utf-8?B?QzJzZDRoWTU2cittdlBhZkd2TGp0VUljeTJZYkpialN1ZEY3a3BEbXp0cTJh?=
 =?utf-8?B?b3FNNVI0bTJEbk9ocmNkR0ptUTdKS29QdUJZampmNEg3WlNzaXdKVTNDNXM1?=
 =?utf-8?B?REpxcWs1MHlhcGsvK0NaRTlVeUN2OEhPYjJBbmlVZVpZKzFLeXlBUkZ1MWJF?=
 =?utf-8?Q?hdPtwhBmKVRLhcNhysNEJN9Ws?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2075d211-2e87-4b60-5940-08dbde96eb9d
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 07:06:38.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JO113acW/QJlrNByWBlOotZgW7WrZu9N14F5oJVf9SYVAx6BvlxJXF6rZ3qAwwYzqBnx/V/IAmGaByy25nmblA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 11/6/2023 11:22 AM, Chen Yu wrote:
> On 2023-10-27 at 08:57:00 +0530, K Prateek Nayak wrote:
>> Hello Mathieu,
>>
>> On 10/19/2023 9:35 PM, Mathieu Desnoyers wrote:
>>> Hi,
>>>
>>> This series introduces two new scheduler features: UTIL_FITS_CAPACITY
>>> and SELECT_BIAS_PREV. When used together, they achieve a 41% speedup of
>>> a hackbench workload which leaves some idle CPU time on a 192-core AMD
>>> EPYC.
>>>
>>> The main metrics which are significantly improved are:
>>>
>>> - cpu-migrations are reduced by 80%,
>>> - CPU utilization is increased by 17%.
>>>
>>> Feedback is welcome. I am especially interested to learn whether this
>>> series has positive or detrimental effects on performance of other
>>> workloads.
>>
>> I got a chance to test this series on a dual socket 3rd Generation EPYC
>> System (2 x 64C/128T). Following is a quick summary:
>>
>> - stream and ycsb-mongodb don't see any changes.
>>
>> - hackbench and DeathStarBench see a major improvement. Both are high
>>   utilization workloads with CPUs being overloaded most of the time.
>>   DeathStarBench is known to benefit from lower migration count. It was
>>   discussed by Gautham at OSPM '23.
>>
>> - tbench, netperf, and sch bench regresses. The former two when the
>>   system is near fully loaded, and the latter for most cases.
> 
> Does it mean hackbench gets benefits when the system is overloaded, while
> tbench/netperf do not get benefit when the system is underloaded?

Yup! Seems like that from the results. From what I have seen so far,
there seems to be a work conservation aspect to hackbench where if we
reduce the time spent in the kernel (by reducing time to decide on the
target which Mathieu's patch [this one] achieves, there is also a
second order effect from another one of Mathieu's Patches that uses
wakelist but indirectly curbs the SIS_UTIL limits based on Aaron's
observation [1] thus reducing time spent in select_idle_cpu())
hackbench results seem to improve.

[1] https://lore.kernel.org/lkml/20230905072141.GA253439@ziqianlu-dell/

schbench, tbench, and netperf see that wakeups are faster when the
client and server are on same LLC so consolidation as long as there is
one task per run queue for under loaded case is better than just keeping
them on separate LLCs.

> 
>>   All these benchmarks are client-server / messenger-worker oriented and is
>>   known to perform better when client-server / messenger-worker are on
>>   same CCX (LLC domain).
> 
> I thought hackbench should also be of client-server mode, because hackbench has
> socket/pipe mode and exchanges datas between sender/receiver.

Yes but its N:M nature makes it slightly complicated to understand where
the cache benefits disappear and the work conservation benefits become
more prominent.

> 
> This reminds me of your proposal to provide user hint to the scheduler
> to whether do task consolidation vs task spreading, and could this also
> be applied to Mathieu's case? For task or task group with "consolidate"
> flag set, tasks prefer to be woken up on target/previous CPU if the wakee
> fits into that CPU. In this way we could bring benefit and not introduce
> regress.

I think even a simple WF_SYNC check will help tbench and netperf case.
Let me get back to you with some data on different variants of hackbench
wit the latest tip.

> 
> thanks,
> Chenyu

--
Thanks and Regards,
Prateek
