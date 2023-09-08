Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017DD798074
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 04:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbjIHCSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 22:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbjIHCSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 22:18:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259311BCD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 19:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haG9y6iERToxXj2iXlN9dr0hRU3cafGVo3nJ82HOwmcY5kk/nn5oZkFpdl+frAqlpbz5Bp/oC6d7OmT4Xk1puuBzyKywTj+3TZS1jo8Pc5wfbMoplPCo5AaXdQnkLRq7dDXK2AxJ2HnjGuXGzjZ/n0u+1OxkOgphcCj5lIIcranq0HkZcczRdl+5uUgAUMovWLO5/dd1ve50pK0uTcXVaFbWWcSftN93vCEjxAp6pXNHMqC/8gloPSn7BaWgcnFKhRoKod9UDQMrAfeubGWEsO64GXffnM1EpWTig3CL6vUm5wi5JL1kJMSoRngYmXHjrTTcA5seOdJbHO+UJsiaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7SlUDIKIzYyQuujmFue3LVBIq1egWpUd78bVbnRdNk=;
 b=ifg4aGjw1ZnSGxwljwpgkAaIsdc+atPPxui0cqd4od/8dIU6XqzlrRJVNzqzYsOo67FZfNDz2iQk1OBLb3mym/yA01CSMVDTpCgHkoN9Xyzp8msJ1nEeWsiKqrZNwQH1KPseOnpQHQekZncL5O655cCY6etBd9p6m/nhSNCnHYuu1BgPu94K6YGJvkdYX5YrRGjqSVUmnPignNUfteILUrjw5HL0rFCBGz/xMkPv6+3U/YhbPJ0lotaCEoRFtrgsu4sokQRa0F2tiUe5xy+/7apOPQtjuuriRKH8wE101ZXmiOWsTL6ekplHqL0Ym7VY02cvks2CwSwHIbZHobYKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7SlUDIKIzYyQuujmFue3LVBIq1egWpUd78bVbnRdNk=;
 b=wYMPEaBkCmgXkVJrGddM9k7ife/wcDajEYUNVEuWvfz3iFi4G3ZFfgcT5kSVyIXRDoklBOPnw8TGxan7jhONKddwmvocFQBlVkZSmWd/J8ZmlA9Q+VBMhweWeBNJZnejNUbIuYbAhqiC3LJuz7n3NMJmF+qedlUlmG+CntgAmgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 02:18:33 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::1ddb:13ad:2eae:53cb]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::1ddb:13ad:2eae:53cb%3]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 02:18:32 +0000
Message-ID: <5570c6b9-4abd-1526-cd17-ed45f7d51b20@amd.com>
Date:   Fri, 8 Sep 2023 07:48:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 0/9] x86/clear_huge_page: multi-page clearing
Content-Language: en-US
To:     Mateusz Guzik <mjguzik@gmail.com>,
        Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230903081404.hmkhnrk243h2nuoa@f>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20230903081404.hmkhnrk243h2nuoa@f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::27) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a9ab82-2b27-4f6f-eac8-08dbb011e5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avjoYq+/WgfgT2B/l4DlWq7IeBPLii5wbM5jrDdTXWDT4aPhbijeYziKvgBHbvKixUP4MvlM1uxelvwJ1MpAk0zH4qemWKo74vhupeHQXoHWblZmbk42yb9V5VlU8GpvKYrsPFz+To+gzzCPChjRDKkgPhaFriv/FzQs3Qs9oz7iVmnMTI3WMz6recyFQgzfDrix+V2CihE4EHANpwAmHVdVSWkvvb2TmVDMIN0UW//EslEcuHg2gViXQ+iLWYdSa1kwIDjoTVOpEhT1UxXgVDbMbRUZw7BBhBtdZLW5BKiSyvXVVJVeB17FF+iwCNcEsRPapi76XdEdC2jJNW+x+G9piN3YwOE7OuWDLp4tYU4dJsm9p6iiKRqk61/m3lP7NyE0G7GwQBEH852iNpPJfTCDS+he9VVQovyNTkIPgfON/7PD8eDZ4sKqw5N/bCVcuyIL9CqkEf7YfkT7+t8zr+cj8GwT6xP6zEzamKZAcZowxdmg98i2c2VcpnRWw9hgycmxAa1PpHlW8SjIMqQ4bStaIbS8CfScS7tY+aPtWgyhej659B1Ynn8EIigAxEuLkkqzwRjd67xnoYkSZdUN24ZBw8yVD2x7W532sQtK6Zvz0r79nqJeXmhCtnx8KX5ayr4Kacs09FKx9SaODITmSJXeguV3vO5z8onaxqu2vJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(1800799009)(186009)(451199024)(2906002)(31696002)(6512007)(53546011)(26005)(2616005)(966005)(478600001)(36756003)(6666004)(6486002)(6506007)(38100700002)(83380400001)(41300700001)(8676002)(8936002)(4326008)(7416002)(5660300002)(316002)(66556008)(66946007)(66476007)(31686004)(110136005)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0hUb3ZldHVuaXBkZ2UyRVN5NjczMlB5UDBET2RZbk85SmNzWnpXQXJjVy9U?=
 =?utf-8?B?U1RoWW1weUl5bVRHdWcrOVgrVTdsaXRFUk9Rcmdpb3l4NFROUE9KWUVsZzNw?=
 =?utf-8?B?UG1rVU9Vbm4vRDZ0UEdvY3lGS3FRa3FkUWUrR1FZZVZwQ3hCZ1hGUlNraWRh?=
 =?utf-8?B?L0N1M1l3ZUlzQVdzNWtVNmJnK1VZOFZVOTNEc1lSbHdhUS8xeXNHc3J3Rkd3?=
 =?utf-8?B?S3ZPT3RhTFN2OFQ0VXhrditTdEl5Z3M1YU5kT0N2cWhmTTdBLzF1S2R3T29q?=
 =?utf-8?B?dzNYaEZnSXdXR24wWGNqQ1hITC9WZVZKV0hkQWhJS3oxSTNHbW9PU3dhUXVj?=
 =?utf-8?B?TkdOUU9qR3BhK2hYNldTZ3k4QURYekNQa21kL2g4R2VjUWZMWVRSTVl1Qlc3?=
 =?utf-8?B?b09XWW5nbmRlQWU5aXRTcGF5V2tVUmZVTk5UTmV0Ykp4QmtCakVJK1AzYnp5?=
 =?utf-8?B?bXhVQndEbWVVRGN6ZGNnME1CK3c3WTlnTTcwc2NRVGZyMHo4MHRVVGhJTEJT?=
 =?utf-8?B?ZjFaVDU4Q0MwUXB5VU5GOEJJZTRUcG1WMGtuZk5aaDlZNytCYlYwZ2NGd201?=
 =?utf-8?B?bGpkUGVncUJMaE1nUHdmZFg2RkFXUUhRcUNkcEpuaTh5OHh3Qzc4MnEyMmFs?=
 =?utf-8?B?NHpEN09udWtMOEFuNXFtV3QxeGhXWmY1YVJpU0hQSW5lR2hZSGlLZ2RkR2NJ?=
 =?utf-8?B?SDljajlUOWJvbHZDTzNzdDVCamhVa1RtUk1LOWhUeFc1a2RYMjMvc2FyNGpO?=
 =?utf-8?B?WDdjYkswODFwR0Z1amRPZ2ltOFdDVXYzNEFua1kwNU8xRXluYktRQm5tNnJZ?=
 =?utf-8?B?eXpiVXJhV2JYN0JVR2ZHNG9ZVjJGeU8xa3FGUytrUjlhclNFSDlxL3dtMjdl?=
 =?utf-8?B?emliaHlkajBJVUEyVHpvVXlMSDdJU1NVdFI2QnQyMEJwY01PeTdtZkY0S1hN?=
 =?utf-8?B?NUV1bjNQU3RTUFVnUExIY3g3STk3eFpYYUNhejN1RU1mdHQwYnNBVm9HdWtt?=
 =?utf-8?B?QXJIZkJ1Qml4Tk9CdkhrNGFFL0hPQkpKU3ZIb3FlNmQyQjhBLy90cEQ0U2ZT?=
 =?utf-8?B?aTRuc2FRc3llYW4wbUQzMk45cnlpRzh0RzY2MWxtWU05TEhiK1lQMzdaNGNO?=
 =?utf-8?B?dnpXc1BrK0VxUjRNM0VGTE9qaUNBNkNyY0pCZkQ2a0ZkSFB1L0pmWkR1blJ5?=
 =?utf-8?B?SGhteUtXcVVVRXdoSTNlM0ZWYnN2b054dE1qVUJDbzBHTTJHaE1uRi9RT0ZD?=
 =?utf-8?B?T0V6UXdrdk9ubkxTcXl1eDEySFVKZVRBblJIR0J1UGJsYWVEM05QZFFsRnQw?=
 =?utf-8?B?S0Q2UHRqRGJHaUdQU3JpaCtaQkZCME1DQkNoOWw0dVdxK2Voc2cwYVp5S2xx?=
 =?utf-8?B?aXdtb1ZEcXg1QitiVkgvVWFtaU5maTI5T2pqMTdad1BjclhKZDJ1MUJYeUJH?=
 =?utf-8?B?eUR3WDloZFlSalZ5TExmWjZXaWxNM1huTnFPWGs5azAxK2x5MWZHMVA4ditx?=
 =?utf-8?B?N2RHZEZ2L0FuZHhWczBIcU93QjFGZzJobG91ZStoZWthNG1tekxyY3ZVVjF0?=
 =?utf-8?B?LzJ0R2MyNmlhSmJkK0VWSG5TbDZDR29ZZ2g0YU0wVXk4c09TQVcyamxXUzN1?=
 =?utf-8?B?RDBUY0xnVFN5VDBVVkFieEtRMDFNdHFieXZ1RzYwS3d2YlFrWWlFQzNhb25r?=
 =?utf-8?B?dnVpaEdsUnMxTXIxcmdOSkxEY0Q5aHAvRkc1bzVQNkVoWW1FS1BHcVA0N0ZT?=
 =?utf-8?B?RDdlNGh4QlRONUJZS2NOdUV3UG85dEs1NjRFWVZvM044ZmtBTlJBOEFOYkRS?=
 =?utf-8?B?R3NiN0Job285TFNpS3lrUC8xcHZyOEJHMzA3WGIyT25PbHJ3OW1YbkVPWm9w?=
 =?utf-8?B?MUFaRzZIMkUwWU5BU25XVGdFS0lZbUV1dG50YzNpUHltOGQ0ZUhBRmpHb0lH?=
 =?utf-8?B?WVdyL0lXMXhDZkRNK1ovRzZLWEFaWUdycS95TlhwTkZvQlNTTWVFMTdLMVVB?=
 =?utf-8?B?dVJkc1UwaFhJT09RM0UrSjA4WWpLVWdVQytvaE5EVWJNM05wL2k4TXk4Vk0w?=
 =?utf-8?B?dmVoMDMwSlRmS3FRdzg4VkZpZjN5TmpkQWRKeTBCY1dFcHhlWDh6MzhTS0ZI?=
 =?utf-8?Q?x2KDcJ/rEK2nkVc+bEZwzoVSe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a9ab82-2b27-4f6f-eac8-08dbb011e5d4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 02:18:32.3458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKuQr+j41QnOfcaJpNWA3eynXWwUu2P1We1jbOWJS2hvhMbK9rQUuVfc+brJZ9forH7t6xOIFbPxw9ewuZVUig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/2023 1:44 PM, Mateusz Guzik wrote:
> On Wed, Aug 30, 2023 at 11:49:49AM -0700, Ankur Arora wrote:
>> This series adds a multi-page clearing primitive, clear_pages(),
>> which enables more effective use of x86 string instructions by
>> advertising the real region-size to be cleared.
>>
>> Region-size can be used as a hint by uarchs to optimize the
>> clearing.
>>
>> Also add allow_resched() which marks a code-section as allowing
>> rescheduling in the irqentry_exit path. This allows clear_pages()
>> to get by without having to call cond_sched() periodically.
>> (preempt_model_full() already handles this via
>> irqentry_exit_cond_resched(), so we handle this similarly for
>> preempt_model_none() and preempt_model_voluntary().)
>>
>> Performance
>> ==
>>
>> With this demand fault performance gets a decent increase:
>>
>>    *Milan*     mm/clear_huge_page   x86/clear_huge_page   change
>>                            (GB/s)                (GB/s)
>>                                                                     
>>    pg-sz=2MB                14.55                 19.29    +32.5%
>>    pg-sz=1GB                19.34                 49.60   +156.4%
>>
>> Milan (and some other AMD Zen uarchs tested) take advantage of the
>> hint to elide cacheline allocation for pg-sz=1GB. The cut-off for
>> this optimization seems to be at around region-size > LLC-size so
>> the pg-sz=2MB load still allocates cachelines.
>>
> 
> Have you benchmarked clzero? It is an AMD-specific instruction issuing
> non-temporal stores. It is definitely something to try out for 1G pages.
> 
> One would think rep stosq has to be at least not worse since the CPU is
> explicitly told what to do and is free to optimize it however it sees
> fit, but the rep prefix has a long history of underperforming.
> 
> I'm not saying it is going to be better, but that this should be tested,
> albeit one can easily argue this can be done at a later date.
> 
> I would do it myself but my access to AMD CPUs is limited.
> 

Hello Mateuz,

I plugged in CLZERO unconditionally (even for coherent path with
sfence) for my earlier experimets on top of this series.

Test: Use mmap(MAP_HUGETLB) to demand a fault on 64GB region (NUMA
node0),  for both base-hugepage-size=2M and 1GB

perf stat -r 10 -d -d  numactl -m 0 -N 0 <test>

SUT: AMD Bergamo with 2 node/2 socket  128 cores per socket.

 From that I see time taken is:
for 2M:  1.092125
for 1G:  0.997661

So overall for 64GB size experiment result look like this:
Time taken for 64GB region, (lesser = better)

  page-size  base       patched (gain%)    patched-clzero (gain%)
  2M         5.0779     2.50623  (50.64)          1.092125 (78)
  1G         2.50623    1.012439 (59.60)          0.997661 (60)

In summary I further see improvements for even for 2M base size (2.5x).

Overall CLZERO clearing is promising. But we may need threshold tuning
and hint passing as done in Ankurs'
Link: 
https://lore.kernel.org/lkml/20220606202109.1306034-1-ankur.a.arora@oracle.com/
on top of current series.

I need to experiment with different chunk size as well as base size
further. (both clzero and rep stos)

Thanks and Regards
- Raghu

Run Details:
  Performance counter stats for 'numactl -m 0 -N 0 map_hugetlb_1G' (10 
runs):

             996.34 msec task-clock                #    0.999 CPUs 
utilized            ( +-  0.02% )
                  2      context-switches          #    2.007 /sec 
                ( +- 21.34% )
                  0      cpu-migrations            #    0.000 /sec
                212      page-faults               #  212.735 /sec 
                ( +-  0.20% )
      3,116,497,471      cycles                    #    3.127 GHz 
                ( +-  0.02% )  (35.66%)
            100,343      stalled-cycles-frontend   #    0.00% frontend 
cycles idle     ( +- 16.85% )  (35.75%)
          1,369,118      stalled-cycles-backend    #    0.04% backend 
cycles idle      ( +-  3.45% )  (35.86%)
      4,325,987,025      instructions              #    1.39  insn per cycle
                                                   #    0.00  stalled 
cycles per insn  ( +-  0.02% )  (35.87%)
      1,078,119,163      branches                  #    1.082 G/sec 
                ( +-  0.01% )  (35.87%)
             87,907      branch-misses             #    0.01% of all 
branches          ( +-  5.22% )  (35.83%)
         12,337,100      L1-dcache-loads           #   12.380 M/sec 
                ( +-  5.44% )  (35.74%)
            280,300      L1-dcache-load-misses     #    2.48% of all 
L1-dcache accesses  ( +-  5.74% )  (35.64%)
           1,464,549      L1-icache-loads           #    1.470 M/sec 
                 ( +-  1.61% )  (35.63%)
             30,659      L1-icache-load-misses     #    2.12% of all 
L1-icache accesses  ( +-  3.30% )  (35.62%)
             17,366      dTLB-loads                #   17.426 K/sec 
                ( +-  5.52% )  (35.63%)
             11,774      dTLB-load-misses          #   81.79% of all 
dTLB cache accesses  ( +-  7.94% )  (35.63%)
                  0      iTLB-loads                #    0.000 /sec 
                (35.63%)
                  2      iTLB-load-misses          #    0.00% of all 
iTLB cache accesses  ( +-342.39% )  (35.64%)

           0.997661 +- 0.000150 seconds time elapsed  ( +-  0.02% )


  Performance counter stats for 'numactl -m 0 -N 0 map_hugetlb' (10 runs):

           1,089.97 msec task-clock                #    0.998 CPUs 
utilized            ( +-  0.03% )
                  3      context-switches          #    2.750 /sec 
                ( +- 15.11% )
                  0      cpu-migrations            #    0.000 /sec
             32,917      page-faults               #   30.172 K/sec 
                ( +-  0.00% )
      3,408,713,422      cycles                    #    3.124 GHz 
                ( +-  0.03% )  (35.60%)
            982,417      stalled-cycles-frontend   #    0.03% frontend 
cycles idle     ( +-  2.77% )  (35.60%)
          8,495,409      stalled-cycles-backend    #    0.25% backend 
cycles idle      ( +-  6.12% )  (35.59%)
      4,970,939,278      instructions              #    1.46  insn per cycle
                                                   #    0.00  stalled 
cycles per insn  ( +-  0.04% )  (35.64%)
      1,196,644,653      branches                  #    1.097 G/sec 
                ( +-  0.03% )  (35.73%)
            196,584      branch-misses             #    0.02% of all 
branches          ( +-  2.79% )  (35.78%)
        226,254,284      L1-dcache-loads           #  207.388 M/sec 
                ( +-  0.23% )  (35.78%)
          1,161,607      L1-dcache-load-misses     #    0.52% of all 
L1-dcache accesses  ( +-  3.27% )  (35.78%)
          21,757,775      L1-icache-loads           #   19.943 M/sec 
                 ( +-  0.66% )  (35.77%)
            165,503      L1-icache-load-misses     #    0.78% of all 
L1-icache accesses  ( +-  3.11% )  (35.78%)
          1,118,573      dTLB-loads                #    1.025 M/sec 
                ( +-  1.38% )  (35.78%)
            415,943      dTLB-load-misses          #   37.10% of all 
dTLB cache accesses  ( +-  1.12% )  (35.78%)
                 36      iTLB-loads                #   32.998 /sec 
                ( +- 18.47% )  (35.74%)
             49,785      iTLB-load-misses          # 270570.65% of all 
iTLB cache accesses  ( +-  0.34% )  (35.65%)

           1.092125 +- 0.000350 seconds time elapsed  ( +-  0.03% )
