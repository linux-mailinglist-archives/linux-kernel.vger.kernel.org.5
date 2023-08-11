Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20659778898
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjHKHw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjHKHwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:52:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2109.outbound.protection.outlook.com [40.107.243.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364751FDD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVdkPXZD0jHtXpYRhzz47wSAso91Nmn+9g0cpiBTuGGLtL72eIIbPd60Id6EjKpm2vwJLpZY8/WT+oMezBYjyt1AKh0S/9bK0NNyzvBQdGGMz4WaD7Nm/PSvQL9pM2oweAZ+7Hg7Qn5qlkGpne+78PuVx2kVMTFU9vLEN/cq7Lej+7vTynGNRkXBJSIm5RNmJuCs4gv9Ty36gTMmeLVcpBB5rExaTvh+x8meQHlMvxSkdq/kS39t4EKGa4Eu3hKwJIM7p2D5qDKYR5LhYirUxdUW9CzmKhKqW+n+t1il3cQHewoVm8op5lKR2ZhLglMWIEDz7MKWWEQJutlQO32T8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBotl6EzSf41ZyKhY6xlikFLd544HC0vYLtcqFGjdO0=;
 b=mHywfdkwnjVVZbrAranGUR0qen4xj1feJ9odx/7YQ5GoUP12aBt6lj1Z/XaoAk98/oFxl28emldOA1YomJibgnI/D9Th8uoRWRae3Uy6K/BmCJViO7+znTAWKNaBEFFqOzRzKxZBIjsrCuVOJJMJr1IJ+S9owt42e6zQPjwdbdoPKT9/Lg7bl6d9ManFhxd8cdvsqNRmXbqdV5DijBNBnhHDikFI942ZOgC3XqOBWnEOD5RyzzGe5rnBw4R0lWjcr+TCOj1MoIYaTE+0W1IZ9CBjBnUXm/U9yEpn/49M6zeQ6cJ7hRewaFL1yjCna8WzjlxqKjcGooWOMRPvMG/rhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBotl6EzSf41ZyKhY6xlikFLd544HC0vYLtcqFGjdO0=;
 b=Dz3BVwkcY3jDAH1qW0Da/bHtkWdwxxrVA4IEnxvInJMVjE1Zz/5osGYjxNScXmakwGk3RhhmzSRyZnqtqD33el9IqRnIMN3XCvLaDbLt8NpxSki1GO/nSVUpYeRyd7VKoPmF47Pc4oD+q23Ubzr8JueNsXwcbpvzJNBknJ+TX4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 SA1PR01MB8109.prod.exchangelabs.com (2603:10b6:806:326::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 07:52:50 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 07:52:50 +0000
Message-ID: <4a08ecd1-49e8-4fda-3614-276ab20f3b10@amperemail.onmicrosoft.com>
Date:   Fri, 11 Aug 2023 15:52:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] KVM/arm64: reconfigurate the event filters for guest
 context
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huang Shijie <shijie@os.amperecomputing.com>,
        oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com, Mark Rutland <mark.rutland@arm.com>
References: <20230810072906.4007-1-shijie@os.amperecomputing.com>
 <87sf8qq5o0.wl-maz@kernel.org>
 <95726705-765d-020b-8c85-62fb917f2c14@amperemail.onmicrosoft.com>
 <87r0oap0s4.wl-maz@kernel.org>
 <fb7b3ebd-4731-4de7-7c39-ac4b0b0b2bfa@amperemail.onmicrosoft.com>
 <86zg2yf2jd.wl-maz@kernel.org>
From:   Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <86zg2yf2jd.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:610:4e::30) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|SA1PR01MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 28277e92-f35a-47b2-f8f9-08db9a3ff5a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPeqDTbGq4Sbcqmhr1ZJnVqz54PhjccXr8KZD1KjQl8Pc4fHQVIRytViTwNArWQoaFwmIjHks8raFup0EHiwryK2XFaZvIfKk9TykNmVhoj7eDtfxpU0RMnKTijGm6dOsZ+Axt8trbpoaIAQFVtY9FXwpTX31UZLwzUJEqTWMob6jGiOE3woTsvr2YeFNmmwIeht0LvHFlf3efCs8kLTOxUcr11V3zUPyf9cF82sq+oZL+aRPukTAV/Tq8nmH63F+spSJeT0ofjATHSHwyEzZAxcZFU73SCgFIsT++hqWfGQ/kW5tU8RxPxdvsHVFTKHwxCXPmV6cGNH6zD7hqJtVRtJlWLl99c+zkrnZxuz0tlpFlTO+9YCodsaDHRC/1AhbqdjtPtmCnYyUboP8+xgiLvcoMyj/xHiwzjaK866p0T9wmj9xODXSqcZ3//FAiuDfiisAO7Degpr7m2XEvjRyTSZic7ah6UGtCNiAjBYJVTl1FRszuupBx4+8yGKyhTNkItzRN/aBgg5e6WiNpo//XLd27wxyJP8fXypv5n4CoJUrR9hwPgkyYbPuMWOed/W1BiWbe/DkYlVZ/VTYvCV3j2p8FuISwWjHyoSevhJasXPRhttzkvnXQ+0c+tgxjUE14c2Eo1nxkLZJNjFPLSAs+GBsFLSwQ21eGvQS9j8tE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(136003)(376002)(346002)(366004)(1800799006)(186006)(451199021)(6512007)(66556008)(66476007)(4326008)(66946007)(478600001)(966005)(6916009)(52116002)(66899021)(31686004)(54906003)(6486002)(5660300002)(316002)(6666004)(41300700001)(8676002)(8936002)(38100700002)(26005)(6506007)(31696002)(42882007)(83170400001)(7416002)(30864003)(38350700002)(2616005)(83380400001)(2906002)(21314003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N282dnNXZlExWW8vWlhrUmZoZWxoSjF0UGlpYlNPT3phVHVaUTVtZStXdklw?=
 =?utf-8?B?TlV1b2lsQ3VXN1JnQlc0ank5ZnhaUzYxUVByRDJIUGhJaHVhNDh0NmxIanJx?=
 =?utf-8?B?a2FpSEpVVjdIcTBkMlZlbVYrUHp5S0V4QjNCbk0wOC9YKzM3eTY2cFQ5MTZm?=
 =?utf-8?B?dDhrS3huYXpiYndFcFY5T29lWEIzZXdGS2NXa3FYUk93SWhtbEttNVV0QzBy?=
 =?utf-8?B?N091MGlUckM2b3drbTY5Q1FrMmRxbGJ6aDFhQUo4cmpSM0NKS1p3elZ6a1ll?=
 =?utf-8?B?QXJmdmcyR3ZRM3dGeHdYZWNrQlZvZmhYVXpGK0hodjVxVWVWYzFtMzJ4YWYz?=
 =?utf-8?B?WngzdHp2SWN6c2RTblp2dlBxZUlYVmZ6UGFKajlUOU8yMnRpQ2Q0WEpPbFBU?=
 =?utf-8?B?THY3TFVpVlVlZDZ5TXVHU0Y2VlMxQmNESWovYUNERUx1UVJneHJoS2RzdDhV?=
 =?utf-8?B?eFUrRHJVbUt6d2RwUjc0L0JycFF0RklvYWswcHI3YXhEeVZtQzVFcDMwMjEw?=
 =?utf-8?B?M3RGWExYbStMeGxEOU1scHNTV1Z5ZHF1NUUvKzdFdTRHcjJtWTRVdWJuN2NG?=
 =?utf-8?B?OWNDUzBiWm0zaHlveUp3UFVOVzhYaFdIYlVYM3F2ZlVMY1Fwc3o2SHRuL3Mz?=
 =?utf-8?B?TTJ0b21ubFRVMkEyYkdyUHFVaGlvUWhMSkZDY3E0ZTVVaEhyeFEzYkN6bG9I?=
 =?utf-8?B?aUtWYlM3TlhBSHpHRW9wdFROTStraXRtcCt2ckV5cmgrSEp2NFI3YVViYy8y?=
 =?utf-8?B?Vm9QbVQwZzNodDc0c3pISXoxMmlXT1lWN1NmV1g0MXdyVkhzOUZPZFdKbVZO?=
 =?utf-8?B?QXZNdWQvNzBXcTlUZWlDVGI5bmNQUlM4Wkh0SDltM09HMzBjZWtzTnpPME1V?=
 =?utf-8?B?azQzbDRrWWZaYnNPcGNnWkRYQ1dEdnh3NnRFOHJrNi9TYzNHTU4wWnFRNmgw?=
 =?utf-8?B?TkhyeXFmOXBuUjcrT2tLMW5tZzVTN2ZKV3lDMTY4RmNncXlkbHFSbnB3WkFk?=
 =?utf-8?B?Vm9JUWtZbmFzVHgwS1ZVdkVJNHFXelJHVUxsY1RQSUxKZno0ZEZjYW1IMzMr?=
 =?utf-8?B?UTJDdnJpZ3VaN2Z3WlJReE9DQnBXbGJWeWpHajN0NW9aQjk4Q1d6UVY1Ukwr?=
 =?utf-8?B?WElXdXBjekczcy8xblZ3d043b1NqMXdJVlZKTGJaN0poaU1rZm5rbk0rSWJY?=
 =?utf-8?B?N3BYbk4xM0JLczBQQVRwOWRVVmhUMkk3N2VyQTd4VWYxeFlLbGdRd3FXNW96?=
 =?utf-8?B?d0J5UVFXYVUxYnJSMFU4QTNBWlBYMUhPNnVVTG1WR0xUaVJXQzFYZEFOeEpx?=
 =?utf-8?B?dWNkSDVnUE1uUlprNVdmL0VnNnVGendMcmJIVi9kcGRSYzNib0hkdzBzaENQ?=
 =?utf-8?B?ZDlxL29UOTcrNDl2VUlvQTFKcnhNalRHNmJEWGN0U3JIdVhhQllPdnNQRk1K?=
 =?utf-8?B?Wm1PMDN0VlcvUEtHR0FhVS9CMVFZdXVhSTFJQkNGSm5JS0xnNEt3K2wxTExl?=
 =?utf-8?B?MkJCNTZ2aDdZdEhEeGN2YVFHMU1aZDdmdTdrbU5NVmJkZEMrWjhXT0RSTDk2?=
 =?utf-8?B?dG5EQUF4UVhzTVdlVUJLM21NaisrRFRlL0dLVGNQemtRT25HV2ovb1VIL0xJ?=
 =?utf-8?B?WEYxRXVwbDAvemhNY3FkRVZFSmtUSUFRbEwwYVl1SXFCOGtCT2xtMWpLc0U0?=
 =?utf-8?B?ZHNTSHJYWnNFWFdvSUxkT3BjZTdzL1hvNVBmUy9WQnM2VUowb1hZQ2JRTU0w?=
 =?utf-8?B?ZDZNZ01XQkc2RGRIVTM1MlJGU3hSRmtWb04rWnpCeE8vTFplOGd1RFV3Z0lB?=
 =?utf-8?B?Tzdna2Q4VGRqaWxncjVzNFdFcjFyQ1RYdUZ6NE1ORzhtS1hLekdIYmVpVnJO?=
 =?utf-8?B?UkVyQnVZWGMzbTduMlU0eEg0N1dSNkNpZGV6N00xVmlQTnRLZ2N2TVR3Y1Nw?=
 =?utf-8?B?Z1dNR0cxbU91d3NRSktEYk5MWDZKcGRLV2pCS1RNOEtILzhoSWpVZGRabDVU?=
 =?utf-8?B?YTBZUzRYVDlQRklCSFhDbk9GR0lJYWhPOGhhY0VLR1p6UHd5ckRHR0NaTEdZ?=
 =?utf-8?B?clpNWU5sVjI5M1RzdEJ4SHpKK3lYd1pjQTZ3UVdkTFBQbmlMWjBja2UwRzdq?=
 =?utf-8?B?a2Q1U1dobHJtY2J0L3BlZ0dBYjRxdVpFanFLSHdiMGJPTkxZMkh5anBrazJu?=
 =?utf-8?Q?5JEkso6cALYxpW3h6x1azYo=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28277e92-f35a-47b2-f8f9-08db9a3ff5a7
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 07:52:50.0412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elk1V7gAI4ZDIhNw04nZxhlWQkeOqG6qIJ9qSh8yl/LqVyJt23IanZbC/y6WQE+GIfzjV6f/G6dDu6OI2bJX3+xbWu9zTT7H/KY+t/Q2uPUoY2/P4HxtSfQ9ur7cjXHT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8109
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

在 2023/8/11 15:42, Marc Zyngier 写道:
> On Fri, 11 Aug 2023 08:10:26 +0100,
> Shijie Huang <shijie@amperemail.onmicrosoft.com> wrote:
>> Hi Marc,
>>
>> 在 2023/8/11 14:10, Marc Zyngier 写道:
>>> On Fri, 11 Aug 2023 02:46:49 +0100,
>>> Shijie Huang <shijie@amperemail.onmicrosoft.com> wrote:
>>>> Hi Marc,
>>>>
>>>> 在 2023/8/10 23:27, Marc Zyngier 写道:
>>>>> Huang,
>>>>>
>>>>> Please make sure you add everyone who commented on v1 (I've Cc'd Mark
>>>>> so that he can shime need as needed).
>>>> thanks.
>>>>> On Thu, 10 Aug 2023 08:29:06 +0100,
>>>>> Huang Shijie <shijie@os.amperecomputing.com> wrote:
>>>>>> 1.) Background.
>>>>>>       1.1) In arm64, start a guest with Qemu which is running as a VMM of KVM,
>>>>>>            and bind the guest to core 33 and run program "a" in guest.
>>>>>>            The code of "a" shows below:
>>>>>>       	----------------------------------------------------------
>>>>>> 		#include <stdio.h>
>>>>>>
>>>>>> 		int main()
>>>>>> 		{
>>>>>> 			unsigned long i = 0;
>>>>>>
>>>>>> 			for (;;) {
>>>>>> 				i++;
>>>>>> 			}
>>>>>>
>>>>>> 			printf("i:%ld\n", i);
>>>>>> 			return 0;
>>>>>> 		}
>>>>>>       	----------------------------------------------------------
>>>>>>
>>>>>>       1.2) Use the following perf command in host:
>>>>>>          #perf stat -e cycles:G,cycles:H -C 33 -I 1000 sleep 1
>>>>>>              #           time             counts unit events
>>>>>>                   1.000817400      3,299,471,572      cycles:G
>>>>>>                   1.000817400          3,240,586      cycles:H
>>>>>>
>>>>>>           This result is correct, my cpu's frequency is 3.3G.
>>>>>>
>>>>>>       1.3) Use the following perf command in host:
>>>>>>          #perf stat -e cycles:G,cycles:H -C 33 -d -d  -I 1000 sleep 1
>>>>>>                time             counts unit events
>>>>>>         1.000831480        153,634,097      cycles:G                                                                (70.03%)
>>>>>>         1.000831480      3,147,940,599      cycles:H                                                                (70.03%)
>>>>>>         1.000831480      1,143,598,527      L1-dcache-loads                                                         (70.03%)
>>>>>>         1.000831480              9,986      L1-dcache-load-misses            #    0.00% of all L1-dcache accesses   (70.03%)
>>>>>>         1.000831480    <not supported>      LLC-loads
>>>>>>         1.000831480    <not supported>      LLC-load-misses
>>>>>>         1.000831480        580,887,696      L1-icache-loads                                                         (70.03%)
>>>>>>         1.000831480             77,855      L1-icache-load-misses            #    0.01% of all L1-icache accesses   (70.03%)
>>>>>>         1.000831480      6,112,224,612      dTLB-loads                                                              (70.03%)
>>>>>>         1.000831480             16,222      dTLB-load-misses                 #    0.00% of all dTLB cache accesses  (69.94%)
>>>>>>         1.000831480        590,015,996      iTLB-loads                                                              (59.95%)
>>>>>>         1.000831480                505      iTLB-load-misses                 #    0.00% of all iTLB cache accesses  (59.95%)
>>>>>>
>>>>>>           This result is wrong. The "cycle:G" should be nearly 3.3G.
>>>>>>
>>>>>> 2.) Root cause.
>>>>>> 	There is only 7 counters in my arm64 platform:
>>>>>> 	  (one cycle counter) + (6 normal counters)
>>>>>>
>>>>>> 	In 1.3 above, we will use 10 event counters.
>>>>>> 	Since we only have 7 counters, the perf core will trigger
>>>>>>           	multiplexing in hrtimer:
>>>>>> 	     perf_mux_hrtimer_restart() --> perf_rotate_context().
>>>>>>
>>>>>>           If the hrtimer occurs when the host is running, it's fine.
>>>>>>           If the hrtimer occurs when the guest is running,
>>>>>>           the perf_rotate_context() will program the PMU with filters for
>>>>>>           host context. The KVM does not have a chance to restore
>>>>>>           PMU registers with kvm_vcpu_pmu_restore_guest().
>>>>>>           The PMU does not work correctly, so we got wrong result.
>>>>>>
>>>>>> 3.) About this patch.
>>>>>> 	Make a KVM_REQ_RELOAD_PMU request before reentering the
>>>>>> 	guest. The request will call kvm_vcpu_pmu_restore_guest()
>>>>>> 	to reconfigurate the filters for guest context.
>>>>>>
>>>>>> 4.) Test result of this patch:
>>>>>>          #perf stat -e cycles:G,cycles:H -C 33 -d -d  -I 1000 sleep 1
>>>>>>                time             counts unit events
>>>>>>         1.001006400      3,298,348,656      cycles:G                                                                (70.03%)
>>>>>>         1.001006400          3,144,532      cycles:H                                                                (70.03%)
>>>>>>         1.001006400            941,149      L1-dcache-loads                                                         (70.03%)
>>>>>>         1.001006400             17,937      L1-dcache-load-misses            #    1.91% of all L1-dcache accesses   (70.03%)
>>>>>>         1.001006400    <not supported>      LLC-loads
>>>>>>         1.001006400    <not supported>      LLC-load-misses
>>>>>>         1.001006400          1,101,889      L1-icache-loads                                                         (70.03%)
>>>>>>         1.001006400            121,638      L1-icache-load-misses            #   11.04% of all L1-icache accesses   (70.03%)
>>>>>>         1.001006400          1,031,228      dTLB-loads                                                              (70.03%)
>>>>>>         1.001006400             26,952      dTLB-load-misses                 #    2.61% of all dTLB cache accesses  (69.93%)
>>>>>>         1.001006400          1,030,678      iTLB-loads                                                              (59.94%)
>>>>>>         1.001006400                338      iTLB-load-misses                 #    0.03% of all iTLB cache accesses  (59.94%)
>>>>>>
>>>>>>        The result is correct. The "cycle:G" is nearly 3.3G now.
>>>>>>
>>>>>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>>>>>> ---
>>>>>> v1 --> v2:
>>>>>> 	Do not change perf/core code, only change the ARM64 kvm code.
>>>>>> 	v1: https://lkml.org/lkml/2023/8/8/1465
>>>>>>
>>>>>> ---
>>>>>>     arch/arm64/kvm/arm.c | 11 ++++++++++-
>>>>>>     1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>>>>>> index c2c14059f6a8..475a2f0e0e40 100644
>>>>>> --- a/arch/arm64/kvm/arm.c
>>>>>> +++ b/arch/arm64/kvm/arm.c
>>>>>> @@ -919,8 +919,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>>>>>     		if (!ret)
>>>>>>     			ret = 1;
>>>>>>     -		if (ret > 0)
>>>>>> +		if (ret > 0) {
>>>>>> +			/*
>>>>>> +			 * The perf_rotate_context() may rotate the events and
>>>>>> +			 * reprogram PMU with filters for host context.
>>>>>> +			 * So make a request before reentering the guest to
>>>>>> +			 * reconfigurate the event filters for guest context.
>>>>>> +			 */
>>>>>> +			kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
>>>>>> +
>>>>>>     			ret = check_vcpu_requests(vcpu);
>>>>>> +		}
>>>>> This looks extremely heavy handed. You're performing the reload on
>>>>> *every* entry, and I don't think this is right (exit-heavy workloads
>>>>> will suffer from it)
>>>>>
>>>>> Furthermore, you're also reloading the virtual state of the PMU
>>>>> (recreating guest events and other things), all of which looks pretty
>>>>> pointless, as all we're interested in is what is being counted on the
>>>>> *host*.
>>>> okay. What about to add a _new_ request, such as KVM_REQ_RESTROE_PMU_GUEST?
>>>>
>>>>
>>>>> Instead, we can restrict the reload of the host state (and only that)
>>>>> to situations where:
>>>>>
>>>>> - we're running on a VHE system
>>>>>
>>>>> - we have a host PMUv3 (not everybody does), as that's the only way we
>>>>>      can profile a guest
>>>> okay. No problem.
>>>>
>>>>
>>>>> and ideally we would have a way to detect that a rotation happened
>>>>> (which may requires some help from the low-level PMU code).
>>>> I will check it, hope we can find a better way.
>>> I came up with the following patch, completely untested. Let me know
>>> how that fares for you.
>>>
>>> Thanks,
>>>
>>> 	M.
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>>> index 93c541111dea..fb875c5c0347 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -49,6 +49,7 @@
>>>    #define KVM_REQ_RELOAD_GICv4	KVM_ARCH_REQ(4)
>>>    #define KVM_REQ_RELOAD_PMU	KVM_ARCH_REQ(5)
>>>    #define KVM_REQ_SUSPEND		KVM_ARCH_REQ(6)
>>> +#define KVM_REQ_RELOAD_GUEST_PMU_EVENTS	KVM_ARCH_REQ(7)
>>>      #define KVM_DIRTY_LOG_MANUAL_CAPS
>>> (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
>>>    				     KVM_DIRTY_LOG_INITIALLY_SET)
>>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>>> index 8b51570a76f8..b40db24f1f0b 100644
>>> --- a/arch/arm64/kvm/arm.c
>>> +++ b/arch/arm64/kvm/arm.c
>>> @@ -804,6 +804,9 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
>>>    			kvm_pmu_handle_pmcr(vcpu,
>>>    					    __vcpu_sys_reg(vcpu, PMCR_EL0));
>>>    +		if (kvm_check_request(KVM_REQ_RELOAD_GUEST_PMU_EVENTS,
>>> vcpu))
>>> +			kvm_vcpu_pmu_restore_guest(vcpu);
>>> +
>>>    		if (kvm_check_request(KVM_REQ_SUSPEND, vcpu))
>>>    			return kvm_vcpu_suspend(vcpu);
>>>    diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>>> index 08b3a1bf0ef6..7012de417092 100644
>>> --- a/drivers/perf/arm_pmuv3.c
>>> +++ b/drivers/perf/arm_pmuv3.c
>>> @@ -772,6 +772,9 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
>>>      	/* Enable all counters */
>>>    	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
>>> +
>>> +	if (in_interrupt())
>>> +		kvm_resync_guest_context();
>> I currently added a similiar check in armv8pmu_get_event_idx().
>>
>> The event multiplexing will call armv8pmu_get_event_idx(), and will
>> definitely fail at least one time.
>>
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -882,6 +882,8 @@ static int armv8pmu_get_event_idx(struct
>> pmu_hw_events *cpuc,
>>          struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>>          struct hw_perf_event *hwc = &event->hw;
>>          unsigned long evtype = hwc->config_base & ARMV8_PMU_EVTYPE_EVENT;
>> +       struct kvm_vcpu *vcpu;
>> +       int index;
>>          struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>>          struct hw_perf_event *hwc = &event->hw;
>>          unsigned long evtype = hwc->config_base & ARMV8_PMU_EVTYPE_EVENT;
>> +       struct kvm_vcpu *vcpu;
>> +       int index;
>>
>>          /* Always prefer to place a cycle counter into the cycle
>> counter. */
>>          if (evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
>> @@ -897,9 +899,22 @@ static int armv8pmu_get_event_idx(struct
>> pmu_hw_events *cpuc,
>>           * Otherwise use events counters
>>           */
>>          if (armv8pmu_event_is_chained(event))
>> -               return  armv8pmu_get_chain_idx(cpuc, cpu_pmu);
>> +               index = armv8pmu_get_chain_idx(cpuc, cpu_pmu);
>>          else
>> -               return armv8pmu_get_single_idx(cpuc, cpu_pmu);
>> +               index = armv8pmu_get_single_idx(cpuc, cpu_pmu);
>> +
>> +       /*
>> +        * If we are in pmu multiplexing, we will definitely meet a failure.
>> +        * Please see perf_rotate_context().
>> +        * If we are in the guest context, we can mark it.
>> +        */
>> +       if (index < 0) {
>> +               vcpu = kvm_get_running_vcpu();
>> +               if (vcpu && in_interrupt() && !event->attr.pinned) {
>> +                       kvm_resync_guest_context();

xxxx.


>> +               }
>> +       }
>> +       return index;
>>   }
>>
>> IMHO, it's better to change armv8pmu_get_event_idx().
>>
>> But if you think it is also okay to change armv8pmu_start() to fix the bug,
>>
>> I am okay too.
> But that's doing work each time you rotate an event. And if you rotate
> a bunch of them, you'll hit this path multiple times, reloading the
> stuff again. What's the point?

In my code, I just put the kvm_make_request() in "xxx" above. Event 
reloading it multiple times,

it just set a bit in vcpu->requests.


>
> My take is that we can hook at the point where the PMU gets
> re-enabled, and have the full context once and for all.
>
> Unless of course I miss something, which is very likely as the whole
> perf subsystem generally escapes me altogether.
>
> In any case, I'd welcome your testing the proposed patch.

No problem.


Thanks

Huang Shijie

>
> Thanks,
>
> 	M.
>
