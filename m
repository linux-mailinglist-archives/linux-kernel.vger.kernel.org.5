Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28217A582D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjISDzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjISDzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:55:25 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68CF1A3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5nnQ6Kv6pYT9eApMae2ulCEKIDsshKO+gEUeFvo4hHcGh9RGL+L1CehL9fO7CW64K8ur40BisDzazKitHyuDAWN5G7GmxcOQdZIUx17CqCMZPvLz68IreyOY+/8dLdnVxnAXzv8X4dj4qZLJe1NoFKntQs6dXV/pMujPXZtuY3OWW91SXMMQ5Jz21IH0RggLQO5qRoM8KO8n+YZYO9snIKWKNf4mx1cBI8nwWqPKKHqaThzb7BhkAIXsGUl6zCh9yfwGFTg76BR9IViUCEboi92hiVjLY8ozuwH4qDYo1whREIjVGnXznuOzkdvaSZApVcb/WI5RAtmMws0Dyg3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jchnf+d9S5vV7W/BSjygxMr6Ejstfrgw8IfpORXET84=;
 b=Lh6QvyMmdnDlMVTSNHutbFC3clcxvX9uq48oEfYHVXu4cqzSDUwwNgms0WS0t8Kw8B2Aakhksr0PNeE5zngqnKxFcyc2SFiN6R6IBTinu46Q1jD0udz1roIMdIq/faaTOSlBjsIcaIe6SfpIPCawjBo/id17EPqP4kPBXEvnUa2HZL/2WgvXPi+0h+ZOOcHuiWemxQxIpwTEF9I0+chhsAAGRjkvIqhEOQ7hX3SbhxiWYsudDUk0xNeY4NlAcrh4hi5SAV97cUyqynXf9O7gUrr+Qc+yXTzxLRrck/nhkx8yYOb81azt8DHAwCnc1y8mkMc8vNxyRzEbajMjTsAU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jchnf+d9S5vV7W/BSjygxMr6Ejstfrgw8IfpORXET84=;
 b=KArB/pWGIAcWyDDyOv2n78M68OCMRJ69YU2mba+s60Zoop/NNnJFxJyJkmABgl/OeLJIUqJAR8zHUIfzl2/e+QkqoS+YIHT3qWlDenPgOXPUmzu38riGLOj4hnsHJ7KgxUccvSS4ehhIQdJ2YUWE8lUsSX2Uk8Iw6ETRByzV1E8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 03:54:55 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 03:54:54 +0000
Message-ID: <106c0cef-2cde-7330-7a18-31db92c5b04a@amd.com>
Date:   Tue, 19 Sep 2023 09:24:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-US
To:     Arjan van de Ven <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <20230814085006.593997112@linutronix.de>
 <20230814085113.471353147@linutronix.de>
 <934072fe-eca2-44df-94e7-9fed1dc8b502@amd.com> <87r0nn8ots.ffs@tglx>
 <4a4d5a89-b024-ea49-8740-1f3aef412c15@amd.com>
 <abb65e60-4e8b-7036-4401-d21b273b6d67@linux.intel.com>
 <6f101718-7ee1-1c3d-3e0a-3aa708928ecd@amd.com>
 <20230915115428.GD6721@noisy.programming.kicks-ass.net>
 <9ffe31b0-a6ff-991d-85ad-97306abfc684@linux.intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <9ffe31b0-a6ff-991d-85ad-97306abfc684@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::17) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: abba08c0-59fc-4f17-d372-08dbb8c42e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3RL5p3qoGpJ6PhMTR8b1+NY7+i3YZsrZBSoKvirnpEsK0zqFk9FjNVd0wjwzquNgD0u9ADxyuyExko4o4q43uLO9tf4SNZowpvmSkiG09meyc6/fNZojuKz3qFFLqPZGUykWHwgMv63Ck1Yg9wj2q1DpNihdIg2ttSMHq5kedKv0jDKT9yS5Ble7uSpbe/qGXpJBnyOc17d84Hb6fI8m3eQeehuDDe7AAT4/P65sq8Y2TAf2S/nVg97mkq+bnV9DmkuOBFZc3ByY3dSpn5R5WycwDZzg+uPWXu0e+y5pjU6qzSGq0CJ8hklZTlGUmTxJU2bPiU7FIC8sRVClW3ffYkdpvG4Wki/a+jt3IoHeeppOVbBz7pM4qkbWS0RAEfOrZK/rQ0L3qlIMObCa1bjQZHgQo+U8q9x75NBaW9y0+jOl+1kQN2C5tJ0fMErQLn8rin8TWReDuso4nwzToW7pXB4j7NAc/S0dJYizV2uJtWb0uGav2nfRj4BhT/QPXWBLxC01DkIVKNyAzKtM6BRBTXWWqf/dOSjXV2mrBrOmHsPpL7uiDtBgFtreiZBTUbf/jSic5Yfhs9vcvcxH+OMhiFD3Lp58trdQBwfknNLKB6leHdy1FZ+z9Z7pTaZACYdHwQzqAuCFr4qV1ec5D1BDsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199024)(186009)(1800799009)(66476007)(53546011)(6486002)(6506007)(966005)(66946007)(54906003)(66556008)(110136005)(6512007)(316002)(41300700001)(31686004)(478600001)(6666004)(8936002)(4326008)(8676002)(5660300002)(26005)(38100700002)(83380400001)(36756003)(2906002)(2616005)(7416002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUhKOG9UMjZ6azBKZk94OUZyZ0lGUVlwaXg3T0ZMRnRJNTNoNXN6VXI0QUE5?=
 =?utf-8?B?cndRem5HSWVlOERPNUhFTWpObG1UUjZoZVA3VUdVVGhoNEh1RnIwQm5DREl5?=
 =?utf-8?B?cG5tOUU1eWFpRmdXdXArRElNWkUvQWNYMndTbnJMcnJ4RUZWUEtJdmtUMFdo?=
 =?utf-8?B?UFp4UlpJckVQeWlFeFY5Qnd1Y3E4cFd4b2pEYitDRTdlbTM5cExsbEI4Zjlm?=
 =?utf-8?B?V2xBdEhaVjBYcTJQVWEraGhGTEdKek5PQmpNaGtGTmJmSlEzOElGYXRhMTNK?=
 =?utf-8?B?WTUzTzBXZlVVOE8xUG5QdjlWRUNQVlBYQjk5QjhYZ0swYy9LUDFNYnZjbWhB?=
 =?utf-8?B?NnZZSVVWR3pUR1UwSm1NN081YWxmZXlQVE9jclpyc0xJM0YrWkJSeUwydEpp?=
 =?utf-8?B?WXBvS3lMMFlReGM1RDE4NmJhU0NQeXV4aGtuWEVkN1JKdG5BMnBOS0NGN2dz?=
 =?utf-8?B?Qk9aT2JjRUlidDBBc290TXdGbGpBNFlRUlIwSnJwbklDNVlSYVlnTW5zMDlV?=
 =?utf-8?B?RjZ4elZZeENzSVFSNkdiUjZYOEl2SG1GdkpIZTE1UXBUSzlqSUdEYVgva3ZF?=
 =?utf-8?B?S1VqNXZjU2tYa2JzVWFya3JidU1GV0lTd3RLUHlPRW1lSjNwWnZjVFVJcWNh?=
 =?utf-8?B?ZkxJazMwSmU1L2RiSUYzY3BhcVEzK3gydFdjSnQ3OEtGWFBJYllFVllvSTdY?=
 =?utf-8?B?cFNNQWhjRXVFTldrM1dTTGIvczBqN0dSREN1WFJDWkd4TUQxNGNqdnJTU2ZX?=
 =?utf-8?B?L25SUW45VDFDYno1UDBwSUxkRnV5YVdyalpuSHRrL0dQWURnVjU0UnVrclQ3?=
 =?utf-8?B?NzQ5T3ErUDNUTFNacW45K2lWaHNENXgvVzFSUUx4MWFEem9Hb2k3dEpQVjQz?=
 =?utf-8?B?RlNZeGhIZ2VqZFdyMENNWEc0UHBIY2dnYWQ1VUl1cmtSRDJrS1grajZqK04w?=
 =?utf-8?B?akdteWdKSGxjVDRsNCt0UzlZUFhYQmJCdG1KU3pDRi9qamhBSlJjL1I5aVNW?=
 =?utf-8?B?NkhqeXMzZ0hTYVJQTEpRUjVVSFFmNzdpWnBicnU0MlhDa0ZGanVUdFd0QXph?=
 =?utf-8?B?aEFSeTBibVNXQ3VEbit1NHRCODVQMXNXMysvQnFNQ2VXcnI5TS83dm5lOWgw?=
 =?utf-8?B?VTFiTjI0ZFZsSzM0UDJ4cUlGUVZZUXF6eS9YaEVVdmtPYjdSdkVoUEVsNTZq?=
 =?utf-8?B?R2JBeTNPaVpNcXZ6N3NJSm12L015RTdiYjFLRDJIOGdzam5PWkowOERZZFha?=
 =?utf-8?B?MVVjblZTc0Fqd0dIeFRGdi93RjQyZ0l2eFVkanVrSFpRRnlSRmRCZm1YODlv?=
 =?utf-8?B?OWRjQTRsSFc5N3l2dklvNXhDYU9nS25jOHBRVnp3QjZmaXF6dkVGb1hIaHBy?=
 =?utf-8?B?ZUkxemQvOUlCaG8raVZITFl1VTNlbHJNanFUejVmUGhkb3pVdkdRUmluREhD?=
 =?utf-8?B?OGZ3dXlHT3BsT05ZTEVEc1NsUDFoeTZHVXZXaVhHWFN1cjNnaHVORVlxS2dU?=
 =?utf-8?B?RUhjNnlUdTJVT3lhNVBuRFE5OWE2UlVxdHhsNkg2YlR0MjlIUVI1UU9JS2Jh?=
 =?utf-8?B?UEJOZHJFQ2tUNGh0U2wxU3BaYXAzNmtkSjE5U1BOOEx5T2dDdUNMWGVpZUIv?=
 =?utf-8?B?cFQ0b2ZWK1hCSTl4UWdQUXBob0pkRmdJUDcyOW9wNy9tUFhyUVRGRlRINlJZ?=
 =?utf-8?B?UjJJTzlHVmFKcnhFQVZBSWhQc1YvL0p5RnVPc1pRTXUveE1PSFBwUTd6NUhj?=
 =?utf-8?B?aURsYmNFOEwxbVkwQVg3ZjJnUk42QkxqYm9aVEJaT0MzMHl5aGkvS3RiQmVP?=
 =?utf-8?B?R1JGM2VrN1lSQnd6U2UrUzBtUlg2WlFGbXZWYlZVbitETHR4UUNGcytuOG51?=
 =?utf-8?B?QnM5Y3UyQlp6Vy91MzdCMVc5VG1GUUlGbHBURHJqaVlPdW1pKzBvd29SNjFh?=
 =?utf-8?B?RmVzWGp4Myt0T1Z4NStvUUFNNk15V0RFOVNOM2ROR1JxUkpzNWh5U3kzYkZm?=
 =?utf-8?B?aXVqdjR2VnU3ZUwyVExsSWtIcjdpdHBySVpVNm9YTHhIa3lhRnAwOExrTGtC?=
 =?utf-8?B?L3hJdU8yU0h1YlROakUrUXZZbEgybEJmVUIrdVV3eXV5RjdDZVVMYUJoVUJM?=
 =?utf-8?Q?Vlh1nSoKiNVfIBsjI4ApQ7xI2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abba08c0-59fc-4f17-d372-08dbb8c42e7e
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 03:54:53.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taySwjuBjkjkQNohjkADKwIPoK9OJM+YLjZ5QKo+FHi1TmhqD/f47JIh77ocSFiCIqjawcgPQFEDASyosPnzvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arjan, Peter,

On 9/15/2023 7:34 PM, Arjan van de Ven wrote:
> On 9/15/2023 4:54 AM, Peter Zijlstra wrote:
>> On Tue, Aug 29, 2023 at 08:46:14AM +0530, K Prateek Nayak wrote:
>>> Hello Arjan,
>>>
>>> On 8/28/2023 8:04 PM, Arjan van de Ven wrote:
>>>> On 8/28/2023 7:28 AM, K Prateek Nayak wrote:
>>>>>>      - Are these really different between AMD and Intel or is this some
>>>>>>        naming convention issue which needs to be resolved?
>>>>>      They do have different characteristics since, on Sapphire
>>>>>      Rapids, the LLC is at a socket boundary despite having multiple
>>>>>      tiles. (Please correct me if I'm wrong, I'm going off of
>>>>>      llc_id shared in this report by Qiuxu Zhuo -
>>>>>      https://lore.kernel.org/all/20230809161219.83084-1-qiuxu.zhuo@intel.com/)
>>>>>
>>>>
>>>> Sapphire reports itself as 1 tile though (since logically it is) as far as I know
>>>>
>>>
>>> I believe there are some variants with multiple tiles, at least the
>>> following press-release suggests that:
>>>
>>>    https://www.intc.com/news-events/press-releases/detail/1598/intel-launches-4th-gen-xeon-scalable-processors-max-series
>>>
>>> specifically "... combining up to four Intel 7-built tiles on a single
>>> package, connected using Intel EMIB ...". Perhaps the one from Qiuxu
>>> Zhuo's report does not contain multiple tiles.
>>
>> I think what Arjan was saying that despite them being build using
>> multipe physical tiles, they describe themselves, in the topology leave,
>> as being a single tile.
> 
> and more than that -- from a software perspective, they truely act as if they are 1 tile

If possible, can you please elaborate on the "software perspective". Say
CPUID leaf 0x1f reports multiple tile, would the data access latency or
cache to cache latency see a noticeable difference?

I would like to understand what the characteristics of a "Tile" are and
whether they are similar to AMD's CCX instances discoverable by AMD's
extended CPUID leaf 0x80000026. That way, in future, when the generic
topology is used by other subsystems, the data from "TOPO_TILE_DOMAIN"
can be used generically for both Intel and AMD.

> (you can do SNC to break that sort of but that's not default and has its own list of downsides)
>  

Thank you for giving the basic clarification of the Tile instances.

--
Thanks and Regards,
Prateek
