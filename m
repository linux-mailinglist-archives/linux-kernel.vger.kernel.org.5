Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D087788D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjHKIQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjHKIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:16:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2107.outbound.protection.outlook.com [40.107.223.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BC5E40
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiFTcuFZ0eANTfB9nyl4Um6r14DCCjSeBKJFPvcw0YD8u3hHYlHUtT9DhdVOO4nyUb0XpfARC+4Rax9Th8JwRe5rqdlKg2Qen6ZxFyBBZ3260hRLWx4jykksrssWj4YYAnV6sIWg2Z0e32wmUzl6XbNh6b6EuAAi8T4Ih33lqgTlMFWSEKjEn14+6EOVZ9JYidP+AIyr9e/EE08uj0r9gEZ+7e+r35eh6glQ7yTVz8YXWz7A9quWmh2GH1dOSbeli9RZVd6bEbMbieLqdbBbBvyaH6a14Kh1AA0F8NnBVB5ZavZIHmeSeK1lTRM3vGMmX9Kyl50GqCVExMehBg7aHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06lNX7ge+1BtpLD9ZolkEA87i1wL924fUombukU5ZMI=;
 b=k6m2S4aK4sNwKYg7QZhqMgeguhfLApWcK0gj5ergyGQmCFIhGtY55sE+opJuj3YMAJR4AzcbDiduej41A9FkUbNufx1WLfQ3vxpMm8o3ngEwuqqgEhFvZHfCIf/J94ofzmolc+C/zgaGu43JZlfthBFUuQDkWEu0i/+D77WN0YI1VN6lwu8Lq5d+gHML1tvBe/LUWpnyjGYdPSnJYXcwuBEKurEYfZuTcKzNEYty13QixoXZLgJNXwFnqKBJAX9ByenWm6VDMF8ev3RAjT/iUsGSrcmkh1yGdMKBJFNMebWWMqn2J4SiCccIgU/MogtXtvc9XqmEgnTzAEjzb9nPeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06lNX7ge+1BtpLD9ZolkEA87i1wL924fUombukU5ZMI=;
 b=ss1Gl1frMOoDwhOiCqYrXz08w0qXdy8e3VJCa3PUbTJu5bA0sh2l67TOJqLMY/6vly+L3FZtPOX8VFVOwokgJJcoVmkYHxJmWAFmpo9JcItB2MsGHhjNof6/MMF+ItyEO6CLYjB2dKhCGK4OLFACA+aweAjV+JpJE8wurtm70To=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 PH0PR01MB7457.prod.exchangelabs.com (2603:10b6:510:f0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 08:16:29 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 08:16:29 +0000
Message-ID: <725283ce-8378-c928-df79-6968fc7a1c8d@amperemail.onmicrosoft.com>
Date:   Fri, 11 Aug 2023 16:16:20 +0800
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
 <4a08ecd1-49e8-4fda-3614-276ab20f3b10@amperemail.onmicrosoft.com>
 <87pm3uovuy.wl-maz@kernel.org>
From:   Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <87pm3uovuy.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:5a::21) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|PH0PR01MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 3420759e-8b32-4fe6-871d-08db9a43435b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkRUNwUBt6l/fKhRH+NVaRMUhDlSvbjZNFeZkR+uedt9/KJ876FJqVc1BS7KzNrtwBFJj0JWNX/mLy6WOHCH6uzmCvbjqGSFv1XPKbkLrkJnEGzawOVvB4v7WaDZQ+g9dg7Yd1x4CQpitwrGbfakwSj+Uqp3gGIK25wC+mUqysCYconeioNCeY2CXyGalEgn55oYIXpmiDrL9vb/9dCndcRCpwiGRCShs0ZjN66Sigp3mfVhdjUWVH9E2noIZlYZkSXGDhG2VooO7HILYVVucQ3BsEeYqJEJrD+NCyaTIfJFSnE5pc05PLQB3Rc5UgwixahH0ZV8ETEgYY3FbqavY8rLFV+KHCA/heyKi56N/rE2eW7KRX3a7PhMIr08ehwGnBwv0jtQeOwi9Ji2Eh1njtpSzhcuLp6g3qxRUT7zDC9PODXQWoRB2KCixPGr0swPMIT5U+3y2wZUlatLcqyyrAwy9s7ie/F0kOuGOP69SszG3+YNbjRPXUAr7KrjCCSI+DdGZeF5aI936wQBDDN6UNAaQHRXC1aVDFkkwy3tjHJwuS5pyG4+290MQvGeLNAfL8Q7kL/m7x/FiXer1X+WHpjxzRpJ7z4DjFYc98CGy2lMZPLU7MVp3y7Ts7kNSvG1hWcKFZhiHB8Xxqj2M4hNH8XL5UCV+Kx3nwWRzCl0HUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(1800799006)(186006)(30864003)(2906002)(66899021)(41300700001)(316002)(7416002)(8936002)(8676002)(5660300002)(31696002)(38350700002)(31686004)(38100700002)(54906003)(6666004)(2616005)(6506007)(26005)(83170400001)(6486002)(52116002)(6512007)(966005)(42882007)(4326008)(6916009)(478600001)(66476007)(66556008)(66946007)(83380400001)(21314003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEQra3QrT0VBdVlTdmhJQklrL2YwbUhhTkpDZWpqTC80RHloMGFIei9VTm5T?=
 =?utf-8?B?WHM0d3JZcG1MZGpPanpTRGF4eGs0dklxQmRlbHJLcWFhb2EzZDd3WlVzbVVz?=
 =?utf-8?B?T0E1SGFOQ0lFTDR2aUFFZFhYdytTSHVzQWo4UHZvbHViTFdlUVVWY0VEZE1K?=
 =?utf-8?B?KzBSYlhtVFVWY1FqZTNTZS9QSnpLTklBcklobUd3Tk4wajBGa0M1RDhNVzA1?=
 =?utf-8?B?QlZ4dTBVNG9lbUxMOG1CdXllNFdRaDBsK0tBL0NBVUZXLzFQeUZXK2dzNG56?=
 =?utf-8?B?bDZ1UEhHbkMzdGlaZ1FUczJKTlVpak45UXcrRjU0U3BKcVV1S3BQa3hCSGow?=
 =?utf-8?B?R1h0eFRacnVhRUVCT2lGOUQ1SWRrZ1hwdW5ZQzQvWlJmUUFOQllZVXNEQU53?=
 =?utf-8?B?ZmdQWGw0bFp2dDJUOVZ6MURJQWhhamVHc1JkU0xqM0diMHd4Sko3TzhWaUZN?=
 =?utf-8?B?ZHBmL00zTXk5WXFQbTlucWU2dEFCQXpmV2I1dm1aOFphUFRGNjNXaDZISVlq?=
 =?utf-8?B?a2xKQjM0NjZndGk3QmU4bUsxeitKRjl0L1U1cVVXVHdqWnAwMkpDci9pT3VD?=
 =?utf-8?B?U1pVRytiR2duSkFqdk5xRy93OTlhYXVNWWpNdHZ4VWJOT3lPZzlzRHlqcmFG?=
 =?utf-8?B?VXZtZFBHTHZGcm93eDBSYjlHcWxSMFE5L2N3NXYzUHF2SkhVRFdYSGIwcVc3?=
 =?utf-8?B?TEZMbXZGeGExdmZtb28wV1IySXRJQUtBNmV4bjFyRnQ2UVpGVTBidVRrdkVa?=
 =?utf-8?B?VWIxZm1WWDdHajhvaTBzMUdqTzVkMU9aNE9VWXdKY0VIWDVGS3c3V3prbU10?=
 =?utf-8?B?dS8wZmxUWkVic1JZeXJBOWIwVE5aMmdOdFlaWXQvV2JSdDRFb3dQdzVFWXlO?=
 =?utf-8?B?VTBDd2h1OE1aSk9oZFUvdlN1bmc0dlllclBISUtXUnBOYjRZdXF5V2Vkc3lx?=
 =?utf-8?B?RDk2WWxGN3diVEczaDRucDJLMFNvR1RCNW5OSFViQkpzYWI0Ny8ydWIwYnB6?=
 =?utf-8?B?cmFQdDJ4WjMycENoVDRvb1ViRmY3RUZiREh0bzJTZ2w2S1liZml5UUdTNkNs?=
 =?utf-8?B?SGp2aitBMzVHT2thNHNwK3hENE1TaWlLTm1rZ3Y1cHpBeS9ETUFDSnMzVTND?=
 =?utf-8?B?OG85SVZNZ1BqaHdCeEJKeEtHK3ZzaVFqN3FxYnMrY0h0Q0JzVUhhRWhWZmQr?=
 =?utf-8?B?ZXo3dm1CM1ZTdGpKOWYycEpaQmo2eklZVm9iV3lUODFRc1hSSkVML3M2dHl2?=
 =?utf-8?B?WmZvZk9nZlJEZmhwNXJYQ0FLWG1zaElWMm9YeEs4Zjk2OW41aHp6QTYzQ3Vx?=
 =?utf-8?B?OFhPSHdBV3p5ZFRvMWVkNEZKMkNnTW54ZTdUbWF1Q3VoUUtjbUw2T3NnZTJH?=
 =?utf-8?B?TTcwaFRNNy9LT1FsbXdvcXNpWlU2VFQ4KzQ0VlBVYU9KNG9rR2g3V1RsRXB6?=
 =?utf-8?B?aXduLzFNZDhZTGR5Y3JjNDljY29zRE9HV3d4ZUJPT3ZadE1WR0NjMDVnL1Ry?=
 =?utf-8?B?Zy93OUlmTXg1c3FBdEVwc1YySWFZSDN2RXFETFJQZmh2dXBOSFQ5SGdCR1Jp?=
 =?utf-8?B?V3pxUE5aT2IvUVJJbUxGWEM3ZkNJQjhOZkVFT2didTJWR25icG10OGtySlNN?=
 =?utf-8?B?ZFFGZGhSbVpaM1JlZXFUREV1ZnlsTllieDExZThoVmVCemxHTnM1TFBLR0dZ?=
 =?utf-8?B?ZmpHQ2kzWWphbUdmMTEvZDVpeG8yUFZkVmw2cm9vTEczbU10S1JwYU9oeEo5?=
 =?utf-8?B?V0FaSHdYc0NQaTc0TmRCS09HOWhNa3orTExkdkxVeGd4akx1ZnhGQmVSYmFM?=
 =?utf-8?B?ZlVzanozbjRBS2lHZy9DREpDalZkbzZab0M0Qk5aNmdLc2dIZk03U05XbDRQ?=
 =?utf-8?B?MmxoeENlV2NVQVBLNzA2OXl2TlZ3aHhNaE84bW5TWDNyaU1zZjlTS1FyTll2?=
 =?utf-8?B?Q1hmbWFQMXEweUNmTW1YdjZ3Q1JLRWppVm16d0RoQXl3SCtKYnNockNtaEhM?=
 =?utf-8?B?djVYTTlPZ2Q0c203b3hvRzlORTB1OWxSNStkWTcrb1hCc1crdWlpT3VlQUFq?=
 =?utf-8?B?OTBaVFNPdUVVVSsxMFp2VlY2aDloMDUyeHZ2UEp6OVZRWEYwaFpYZUVvYTNq?=
 =?utf-8?B?QnQvc3NyVTFRYXVqS24rbnJXbXFVYlpyNXl5MzJEUVZKUDBVMzZNNFBlSzRJ?=
 =?utf-8?Q?LX07u13TSJoed4k+OMuq6CE=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3420759e-8b32-4fe6-871d-08db9a43435b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 08:16:28.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Tq7K4D19PPoc7BbmcSUjZ8YcM5W+YNEmabjfQBZWIwkxqtuVFLZKefqa7GOIlwWb4VGSs1RMTPGBa/4TaYS9FML2kMqOSXxe1bCyQyWpfFS32zeR+MEw70RocW7DH8k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7457
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

在 2023/8/11 15:56, Marc Zyngier 写道:
> On Fri, 11 Aug 2023 08:52:40 +0100,
> Shijie Huang <shijie@amperemail.onmicrosoft.com> wrote:
>> Hi Marc,
>>
>> 在 2023/8/11 15:42, Marc Zyngier 写道:
>>> On Fri, 11 Aug 2023 08:10:26 +0100,
>>> Shijie Huang <shijie@amperemail.onmicrosoft.com> wrote:
>>>> Hi Marc,
>>>>
>>>> 在 2023/8/11 14:10, Marc Zyngier 写道:
>>>>> On Fri, 11 Aug 2023 02:46:49 +0100,
>>>>> Shijie Huang <shijie@amperemail.onmicrosoft.com> wrote:
>>>>>> Hi Marc,
>>>>>>
>>>>>> 在 2023/8/10 23:27, Marc Zyngier 写道:
>>>>>>> Huang,
>>>>>>>
>>>>>>> Please make sure you add everyone who commented on v1 (I've Cc'd Mark
>>>>>>> so that he can shime need as needed).
>>>>>> thanks.
>>>>>>> On Thu, 10 Aug 2023 08:29:06 +0100,
>>>>>>> Huang Shijie <shijie@os.amperecomputing.com> wrote:
>>>>>>>> 1.) Background.
>>>>>>>>        1.1) In arm64, start a guest with Qemu which is running as a VMM of KVM,
>>>>>>>>             and bind the guest to core 33 and run program "a" in guest.
>>>>>>>>             The code of "a" shows below:
>>>>>>>>        	----------------------------------------------------------
>>>>>>>> 		#include <stdio.h>
>>>>>>>>
>>>>>>>> 		int main()
>>>>>>>> 		{
>>>>>>>> 			unsigned long i = 0;
>>>>>>>>
>>>>>>>> 			for (;;) {
>>>>>>>> 				i++;
>>>>>>>> 			}
>>>>>>>>
>>>>>>>> 			printf("i:%ld\n", i);
>>>>>>>> 			return 0;
>>>>>>>> 		}
>>>>>>>>        	----------------------------------------------------------
>>>>>>>>
>>>>>>>>        1.2) Use the following perf command in host:
>>>>>>>>           #perf stat -e cycles:G,cycles:H -C 33 -I 1000 sleep 1
>>>>>>>>               #           time             counts unit events
>>>>>>>>                    1.000817400      3,299,471,572      cycles:G
>>>>>>>>                    1.000817400          3,240,586      cycles:H
>>>>>>>>
>>>>>>>>            This result is correct, my cpu's frequency is 3.3G.
>>>>>>>>
>>>>>>>>        1.3) Use the following perf command in host:
>>>>>>>>           #perf stat -e cycles:G,cycles:H -C 33 -d -d  -I 1000 sleep 1
>>>>>>>>                 time             counts unit events
>>>>>>>>          1.000831480        153,634,097      cycles:G                                                                (70.03%)
>>>>>>>>          1.000831480      3,147,940,599      cycles:H                                                                (70.03%)
>>>>>>>>          1.000831480      1,143,598,527      L1-dcache-loads                                                         (70.03%)
>>>>>>>>          1.000831480              9,986      L1-dcache-load-misses            #    0.00% of all L1-dcache accesses   (70.03%)
>>>>>>>>          1.000831480    <not supported>      LLC-loads
>>>>>>>>          1.000831480    <not supported>      LLC-load-misses
>>>>>>>>          1.000831480        580,887,696      L1-icache-loads                                                         (70.03%)
>>>>>>>>          1.000831480             77,855      L1-icache-load-misses            #    0.01% of all L1-icache accesses   (70.03%)
>>>>>>>>          1.000831480      6,112,224,612      dTLB-loads                                                              (70.03%)
>>>>>>>>          1.000831480             16,222      dTLB-load-misses                 #    0.00% of all dTLB cache accesses  (69.94%)
>>>>>>>>          1.000831480        590,015,996      iTLB-loads                                                              (59.95%)
>>>>>>>>          1.000831480                505      iTLB-load-misses                 #    0.00% of all iTLB cache accesses  (59.95%)
>>>>>>>>
>>>>>>>>            This result is wrong. The "cycle:G" should be nearly 3.3G.
>>>>>>>>
>>>>>>>> 2.) Root cause.
>>>>>>>> 	There is only 7 counters in my arm64 platform:
>>>>>>>> 	  (one cycle counter) + (6 normal counters)
>>>>>>>>
>>>>>>>> 	In 1.3 above, we will use 10 event counters.
>>>>>>>> 	Since we only have 7 counters, the perf core will trigger
>>>>>>>>            	multiplexing in hrtimer:
>>>>>>>> 	     perf_mux_hrtimer_restart() --> perf_rotate_context().
>>>>>>>>
>>>>>>>>            If the hrtimer occurs when the host is running, it's fine.
>>>>>>>>            If the hrtimer occurs when the guest is running,
>>>>>>>>            the perf_rotate_context() will program the PMU with filters for
>>>>>>>>            host context. The KVM does not have a chance to restore
>>>>>>>>            PMU registers with kvm_vcpu_pmu_restore_guest().
>>>>>>>>            The PMU does not work correctly, so we got wrong result.
>>>>>>>>
>>>>>>>> 3.) About this patch.
>>>>>>>> 	Make a KVM_REQ_RELOAD_PMU request before reentering the
>>>>>>>> 	guest. The request will call kvm_vcpu_pmu_restore_guest()
>>>>>>>> 	to reconfigurate the filters for guest context.
>>>>>>>>
>>>>>>>> 4.) Test result of this patch:
>>>>>>>>           #perf stat -e cycles:G,cycles:H -C 33 -d -d  -I 1000 sleep 1
>>>>>>>>                 time             counts unit events
>>>>>>>>          1.001006400      3,298,348,656      cycles:G                                                                (70.03%)
>>>>>>>>          1.001006400          3,144,532      cycles:H                                                                (70.03%)
>>>>>>>>          1.001006400            941,149      L1-dcache-loads                                                         (70.03%)
>>>>>>>>          1.001006400             17,937      L1-dcache-load-misses            #    1.91% of all L1-dcache accesses   (70.03%)
>>>>>>>>          1.001006400    <not supported>      LLC-loads
>>>>>>>>          1.001006400    <not supported>      LLC-load-misses
>>>>>>>>          1.001006400          1,101,889      L1-icache-loads                                                         (70.03%)
>>>>>>>>          1.001006400            121,638      L1-icache-load-misses            #   11.04% of all L1-icache accesses   (70.03%)
>>>>>>>>          1.001006400          1,031,228      dTLB-loads                                                              (70.03%)
>>>>>>>>          1.001006400             26,952      dTLB-load-misses                 #    2.61% of all dTLB cache accesses  (69.93%)
>>>>>>>>          1.001006400          1,030,678      iTLB-loads                                                              (59.94%)
>>>>>>>>          1.001006400                338      iTLB-load-misses                 #    0.03% of all iTLB cache accesses  (59.94%)
>>>>>>>>
>>>>>>>>         The result is correct. The "cycle:G" is nearly 3.3G now.
>>>>>>>>
>>>>>>>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>>>>>>>> ---
>>>>>>>> v1 --> v2:
>>>>>>>> 	Do not change perf/core code, only change the ARM64 kvm code.
>>>>>>>> 	v1: https://lkml.org/lkml/2023/8/8/1465
>>>>>>>>
>>>>>>>> ---
>>>>>>>>      arch/arm64/kvm/arm.c | 11 ++++++++++-
>>>>>>>>      1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>>>>>>>> index c2c14059f6a8..475a2f0e0e40 100644
>>>>>>>> --- a/arch/arm64/kvm/arm.c
>>>>>>>> +++ b/arch/arm64/kvm/arm.c
>>>>>>>> @@ -919,8 +919,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>>>>>>>      		if (!ret)
>>>>>>>>      			ret = 1;
>>>>>>>>      -		if (ret > 0)
>>>>>>>> +		if (ret > 0) {
>>>>>>>> +			/*
>>>>>>>> +			 * The perf_rotate_context() may rotate the events and
>>>>>>>> +			 * reprogram PMU with filters for host context.
>>>>>>>> +			 * So make a request before reentering the guest to
>>>>>>>> +			 * reconfigurate the event filters for guest context.
>>>>>>>> +			 */
>>>>>>>> +			kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
>>>>>>>> +
>>>>>>>>      			ret = check_vcpu_requests(vcpu);
>>>>>>>> +		}
>>>>>>> This looks extremely heavy handed. You're performing the reload on
>>>>>>> *every* entry, and I don't think this is right (exit-heavy workloads
>>>>>>> will suffer from it)
>>>>>>>
>>>>>>> Furthermore, you're also reloading the virtual state of the PMU
>>>>>>> (recreating guest events and other things), all of which looks pretty
>>>>>>> pointless, as all we're interested in is what is being counted on the
>>>>>>> *host*.
>>>>>> okay. What about to add a _new_ request, such as KVM_REQ_RESTROE_PMU_GUEST?
>>>>>>
>>>>>>
>>>>>>> Instead, we can restrict the reload of the host state (and only that)
>>>>>>> to situations where:
>>>>>>>
>>>>>>> - we're running on a VHE system
>>>>>>>
>>>>>>> - we have a host PMUv3 (not everybody does), as that's the only way we
>>>>>>>       can profile a guest
>>>>>> okay. No problem.
>>>>>>
>>>>>>
>>>>>>> and ideally we would have a way to detect that a rotation happened
>>>>>>> (which may requires some help from the low-level PMU code).
>>>>>> I will check it, hope we can find a better way.
>>>>> I came up with the following patch, completely untested. Let me know
>>>>> how that fares for you.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> 	M.
>>>>>
>>>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>>>>> index 93c541111dea..fb875c5c0347 100644
>>>>> --- a/arch/arm64/include/asm/kvm_host.h
>>>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>>>> @@ -49,6 +49,7 @@
>>>>>     #define KVM_REQ_RELOAD_GICv4	KVM_ARCH_REQ(4)
>>>>>     #define KVM_REQ_RELOAD_PMU	KVM_ARCH_REQ(5)
>>>>>     #define KVM_REQ_SUSPEND		KVM_ARCH_REQ(6)
>>>>> +#define KVM_REQ_RELOAD_GUEST_PMU_EVENTS	KVM_ARCH_REQ(7)
>>>>>       #define KVM_DIRTY_LOG_MANUAL_CAPS
>>>>> (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
>>>>>     				     KVM_DIRTY_LOG_INITIALLY_SET)
>>>>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>>>>> index 8b51570a76f8..b40db24f1f0b 100644
>>>>> --- a/arch/arm64/kvm/arm.c
>>>>> +++ b/arch/arm64/kvm/arm.c
>>>>> @@ -804,6 +804,9 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
>>>>>     			kvm_pmu_handle_pmcr(vcpu,
>>>>>     					    __vcpu_sys_reg(vcpu, PMCR_EL0));
>>>>>     +		if (kvm_check_request(KVM_REQ_RELOAD_GUEST_PMU_EVENTS,
>>>>> vcpu))
>>>>> +			kvm_vcpu_pmu_restore_guest(vcpu);
>>>>> +
>>>>>     		if (kvm_check_request(KVM_REQ_SUSPEND, vcpu))
>>>>>     			return kvm_vcpu_suspend(vcpu);
>>>>>     diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>>>>> index 08b3a1bf0ef6..7012de417092 100644
>>>>> --- a/drivers/perf/arm_pmuv3.c
>>>>> +++ b/drivers/perf/arm_pmuv3.c
>>>>> @@ -772,6 +772,9 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
>>>>>       	/* Enable all counters */
>>>>>     	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
>>>>> +
>>>>> +	if (in_interrupt())
>>>>> +		kvm_resync_guest_context();
>>>> I currently added a similiar check in armv8pmu_get_event_idx().
>>>>
>>>> The event multiplexing will call armv8pmu_get_event_idx(), and will
>>>> definitely fail at least one time.
>>>>
>>>> +++ b/drivers/perf/arm_pmuv3.c
>>>> @@ -882,6 +882,8 @@ static int armv8pmu_get_event_idx(struct
>>>> pmu_hw_events *cpuc,
>>>>           struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>>>>           struct hw_perf_event *hwc = &event->hw;
>>>>           unsigned long evtype = hwc->config_base & ARMV8_PMU_EVTYPE_EVENT;
>>>> +       struct kvm_vcpu *vcpu;
>>>> +       int index;
>>>>           struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>>>>           struct hw_perf_event *hwc = &event->hw;
>>>>           unsigned long evtype = hwc->config_base & ARMV8_PMU_EVTYPE_EVENT;
>>>> +       struct kvm_vcpu *vcpu;
>>>> +       int index;
>>>>
>>>>           /* Always prefer to place a cycle counter into the cycle
>>>> counter. */
>>>>           if (evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
>>>> @@ -897,9 +899,22 @@ static int armv8pmu_get_event_idx(struct
>>>> pmu_hw_events *cpuc,
>>>>            * Otherwise use events counters
>>>>            */
>>>>           if (armv8pmu_event_is_chained(event))
>>>> -               return  armv8pmu_get_chain_idx(cpuc, cpu_pmu);
>>>> +               index = armv8pmu_get_chain_idx(cpuc, cpu_pmu);
>>>>           else
>>>> -               return armv8pmu_get_single_idx(cpuc, cpu_pmu);
>>>> +               index = armv8pmu_get_single_idx(cpuc, cpu_pmu);
>>>> +
>>>> +       /*
>>>> +        * If we are in pmu multiplexing, we will definitely meet a failure.
>>>> +        * Please see perf_rotate_context().
>>>> +        * If we are in the guest context, we can mark it.
>>>> +        */
>>>> +       if (index < 0) {
>>>> +               vcpu = kvm_get_running_vcpu();
>>>> +               if (vcpu && in_interrupt() && !event->attr.pinned) {
>>>> +                       kvm_resync_guest_context();
>> xxxx.
>>
>>
>>>> +               }
>>>> +       }
>>>> +       return index;
>>>>    }
>>>>
>>>> IMHO, it's better to change armv8pmu_get_event_idx().
>>>>
>>>> But if you think it is also okay to change armv8pmu_start() to fix the bug,
>>>>
>>>> I am okay too.
>>> But that's doing work each time you rotate an event. And if you rotate
>>> a bunch of them, you'll hit this path multiple times, reloading the
>>> stuff again. What's the point?
>> In my code, I just put the kvm_make_request() in "xxx" above. Event
>> reloading it multiple times,
>>
>> it just set a bit in vcpu->requests.
>>
>>
>>> My take is that we can hook at the point where the PMU gets
>>> re-enabled, and have the full context once and for all.
>>>
>>> Unless of course I miss something, which is very likely as the whole
>>> perf subsystem generally escapes me altogether.
>>>
>>> In any case, I'd welcome your testing the proposed patch.
>> No problem.
> As Oliver pointed out offline, I only have posted half of the patch...
>
> Here is the whole thing below.

I tested it just now, it works fine.

Can I create a v3 patch based your patch? or you do it yourself.


Thanks

Huang Shijie

>
> Thanks,
>
> 	M.
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 93c541111dea..fb875c5c0347 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -49,6 +49,7 @@
>   #define KVM_REQ_RELOAD_GICv4	KVM_ARCH_REQ(4)
>   #define KVM_REQ_RELOAD_PMU	KVM_ARCH_REQ(5)
>   #define KVM_REQ_SUSPEND		KVM_ARCH_REQ(6)
> +#define KVM_REQ_RELOAD_GUEST_PMU_EVENTS	KVM_ARCH_REQ(7)
>   
>   #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
>   				     KVM_DIRTY_LOG_INITIALLY_SET)
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 8b51570a76f8..b40db24f1f0b 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -804,6 +804,9 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
>   			kvm_pmu_handle_pmcr(vcpu,
>   					    __vcpu_sys_reg(vcpu, PMCR_EL0));
>   
> +		if (kvm_check_request(KVM_REQ_RELOAD_GUEST_PMU_EVENTS, vcpu))
> +			kvm_vcpu_pmu_restore_guest(vcpu);
> +
>   		if (kvm_check_request(KVM_REQ_SUSPEND, vcpu))
>   			return kvm_vcpu_suspend(vcpu);
>   
> diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
> index 121f1a14c829..7bd1facc8f15 100644
> --- a/arch/arm64/kvm/pmu.c
> +++ b/arch/arm64/kvm/pmu.c
> @@ -236,3 +236,17 @@ bool kvm_set_pmuserenr(u64 val)
>   	ctxt_sys_reg(hctxt, PMUSERENR_EL0) = val;
>   	return true;
>   }
> +
> +void kvm_resync_guest_context(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +
> +	if (!kvm_arm_support_pmu_v3() || !has_vhe())
> +		return;
> +
> +	vcpu = kvm_get_running_vcpu();
> +	if (!vcpu)
> +		return;
> +
> +	kvm_make_request(KVM_REQ_RELOAD_GUEST_PMU_EVENTS, vcpu);
> +}
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 08b3a1bf0ef6..7012de417092 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -772,6 +772,9 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
>   
>   	/* Enable all counters */
>   	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
> +
> +	if (in_interrupt())
> +		kvm_resync_guest_context();
>   }
>   
>   static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index 847da6fc2713..d66f7216b5a9 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -74,6 +74,7 @@ int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu);
>   struct kvm_pmu_events *kvm_get_pmu_events(void);
>   void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
>   void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
> +void kvm_resync_guest_context(void);
>   
>   #define kvm_vcpu_has_pmu(vcpu)					\
>   	(test_bit(KVM_ARM_VCPU_PMU_V3, (vcpu)->arch.features))
> @@ -171,6 +172,7 @@ static inline u8 kvm_arm_pmu_get_pmuver_limit(void)
>   {
>   	return 0;
>   }
> +static inline void kvm_resync_guest_context(void) {}
>   
>   #endif
>   
>
