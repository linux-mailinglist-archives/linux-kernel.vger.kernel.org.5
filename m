Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4295778518
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjHKBrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHKBrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:47:11 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2098.outbound.protection.outlook.com [40.107.93.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F9C10D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:47:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ev5+lEb5XPoT1RT1XfYsIW4CR2iDN9PthNXfIifUmwWF6t5zMc09zJ7nE+uh0lnPOdVt8Ltk/kdyAaAA/KnwR+OL2sdcExB2lxQMZ7w+Yy9wPEo9TdQ1e1YO7T8lrrKAzGWsmarbXhI/kbsjUOtNJTVOHUa4cVz/0Q1PvZSK68ItoTAwwNAPt8L0yWRiuJmkG3Aqri6q50mXOShijeDMV0UBy+rzkN4Aor6oaDgUiHA8KtNR9suVWzrbKfhigjeeW2uyzrshKq2oi9ip/dzTxf+EAXHNvoH4rFW/afWIgQXOichdTtGjWoUsUHC9ZIY9dMYGcdsSRc2ragqVZLXU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYPtmPUM8AsEfuswl0cpYJMcl+OCxnB6rY6fy07KTcg=;
 b=BHyZrMH8hEmEFVo793HzyWEyGy+DEkvTIJCvgEQE9C6SEpAyq5z5KjjDBap+NDeJdnIffGOUyYCTMqu1eWQwXFbDhMg4L8/XLx+JCEtJChLRFHyMPo9Cq7WEg8Ez4BSFEKDPahseVwY/1TbhaGeQW1cZ4vhDQc+T6Wm+aj1Z7kftju9LZ5NI69JJ1/qdVaaK98IS3ctsLGCwJWZk/f2DEJSyFfWsFnF83Y4EVLUDhQr/066BvcaIg/tvX9d5Svu4GgZjotaxzDHdOetO4caMnm4BEAdCg3eR7X88K/odiZ3WUAZkIgvvDzNgnNeBrFUyTSzCyLyUoHazctMno2SGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYPtmPUM8AsEfuswl0cpYJMcl+OCxnB6rY6fy07KTcg=;
 b=m7/0Oa6lTpmo3imIhzO7I5gLSlI7A2l2IXxGHJIH9+aWahfdpU+NPeL9juRpkkOKY/Zw/NS3FI1dThYT8gMe4adNpKu9PfOuN1/TmbfK6ajRG26GgrmMED2OypppS9YpjYGPXzKMpW0kJwiPkB6n9EQq5bjdNdBj1DDINwE/kbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 PH7PR01MB8197.prod.exchangelabs.com (2603:10b6:510:2b8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 01:47:01 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 01:47:01 +0000
Message-ID: <95726705-765d-020b-8c85-62fb917f2c14@amperemail.onmicrosoft.com>
Date:   Fri, 11 Aug 2023 09:46:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] KVM/arm64: reconfigurate the event filters for guest
 context
To:     Marc Zyngier <maz@kernel.org>,
        Huang Shijie <shijie@os.amperecomputing.com>
Cc:     oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com, Mark Rutland <mark.rutland@arm.com>
References: <20230810072906.4007-1-shijie@os.amperecomputing.com>
 <87sf8qq5o0.wl-maz@kernel.org>
From:   Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <87sf8qq5o0.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:610:e7::6) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|PH7PR01MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f8fbde-e333-4cdf-7b00-08db9a0cdb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXiknQEGVCuM1qstXPSeL3iHzwmzp7DApEDwhoQtTOpeTsEN+qRyaEhsa2FnPIk30bvmjaqjdBweC7GmxDogvMVv5lLYrvDAZHi5g8GjkBzVVctmLCqXJRiXiL+CekbRS/3XBoD5vXr9gUOAjP6XMESCN5g1tK1Xl7dCJXt8wNB1UQikHR5gnxXznUtDc1JDJ7Y2HI6OsTT2VGrSoUj6MpSRSb5Ltd4LkXa4SpQk9zmRxXNph32HK/FXC9TVqjNG5ktSE4gV8T766ND/FtmwisDrPOUouTzqN/Eaugo7FFiwyYiWOIjZSDoIfqtZv0V3V60V4LjXoNfOdHH8J+QX64F30a0IQ1zpGBz2i7HnWOWMHfgBqqMdAVZ38qbeZm6d1SZg0ZEFt+KyIfFdVhD8takjM6gY4kGiFxLosN+FdacDLAdYUo2J8CqawceB8UWZA6CXaxB8b62Nd8rd3jFoW7ic0hx86T8zn51qkB0T8o1EJ8i1jR4Kb22uWw2GW9zkcrMMSaCgQtU1927z2jOP6abqvqbvPaCYRcLbAy9QCUOuxDFTQ3iEIS5YSClYewc0w/EG94C2J3lQLzZR+P0sV3vJ0J7UO0LiPwvJJOONZp+eXawWOcio8GqTAe9QHeu/n9mSsBkVbGK929nlEEQ3PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(396003)(39850400004)(1800799006)(451199021)(186006)(66899021)(31686004)(66946007)(66476007)(66556008)(2906002)(31696002)(38100700002)(38350700002)(83170400001)(2616005)(83380400001)(6506007)(26005)(42882007)(52116002)(478600001)(4326008)(41300700001)(110136005)(6666004)(6512007)(5660300002)(6486002)(966005)(8936002)(316002)(7416002)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzVNcWNFWE5DVkdDd3kvaVpLRnJhS2pjUFN6K0tFZ0pWTWJ4QVI5VGszU2gz?=
 =?utf-8?B?c0ppYUNST09nRkdwS0cxd05PSkhTeUp6VC9FK0NLT0hIVEoyVzBoK0prV2pa?=
 =?utf-8?B?NzA3WTdJblp3dG03bU5SNGowSVM2VlozY0pINnR6ZCtobFYvWWRIUXVsN2tu?=
 =?utf-8?B?TUQraGsvQk1ISUx1TlFBR2tHZFFyQmdYb3QyUkJSU2RzWHhkZ2JNQWpSdTNk?=
 =?utf-8?B?ZHhmeUJEMzFLZkZNTlZaUmNWOUtMVFI4REN3TWt2N1pmb1pIZE9kUGQ3YUg2?=
 =?utf-8?B?Sm55bzRPMnYxb1RpVjJ0TWVwR3dTOUtQc0xqOVhTZ29IQWFzTUk3SEFJTGRh?=
 =?utf-8?B?b09WbW4vVTBBa2VmSW1xWVVrYjNmdHF5UDlCWnhEem0xWkNWNXRoajVPaWI1?=
 =?utf-8?B?TFVXSDNkNFJZV2VGL3hzN0tyQ25SN2ZBcmdZRHRrR3daaUp5c1p2WkhyM0h3?=
 =?utf-8?B?VTJ5ZVlkZVRPcUkrNlgvVmhKQTNGVi80dVFkU05UdGNOUkdjbFhKeU94T1dI?=
 =?utf-8?B?N0ZLZVEyTWZyaXVKTWo1OElNOW5DWlVWQnRUWHo2V2hhdzFFT3NvOXcyMUhs?=
 =?utf-8?B?cDlwVytUOTZuYVZKd2pqQUlqN1hSNk1HOFpta0RkYlRLYVA0ZEd2WEVEalhV?=
 =?utf-8?B?K1IyOG5Zb2hkb1l6RzVsMzdNQlVBaWFhUExSWTh4amZETmU2K0RuWW9CdVZ4?=
 =?utf-8?B?cjdnRUIrY0o4WWNET1BJNUk0Zzg2RHVKUS92WkV6M1RTVXY1cDhyN3ZFSE9u?=
 =?utf-8?B?YTRDQkxpTE5pS2tNZGkxbmlPdFd5SUEvMnN5d0NuRDI2eXM2a0c5dFVtN3Ry?=
 =?utf-8?B?QXYvK3F0ZkN4RGYzTGVaNFFUSXdVaGpNamljWjZVdkN2Y3RvRXZTbk9HWXJj?=
 =?utf-8?B?ZU92MW8vbmFDWVZNeGlLNzJkWnNPdVg3UXUxRUcyaFJTOGFwRVJFVUJNbU95?=
 =?utf-8?B?alV5bWhOQ2F2NXFiL3BVaS8vTWJBTysxNXA1eDlIaCtvWlZEU0dIcVFBT0JQ?=
 =?utf-8?B?azlwU1FFZENBeFlHc1kvSTJiUkwrQ00vSVdXL2UxMThHVGV4TjVsN05DME0w?=
 =?utf-8?B?SFgvZXVnaFQ0cEFIMWVaRXRsMDdXcm9ZNmVweWRLdlhVWHlRKzN6OWg5NjF4?=
 =?utf-8?B?ejBYSk9qVkdZbFFqVndHZnZCU3NkZEQ0anRyNndkM1ZtZW5MelJUVC9DblZv?=
 =?utf-8?B?QmRzdUt4Mi9YSnI4ZThwVStwcU1pMkJML0tUS3B6bC9FSUxjbjNMK1EvY2R0?=
 =?utf-8?B?Q1NtU05sRnNnTkNZS3p6M0JYUEM2RUs4c2pTMlVqZUxhMFBramgvY002bEl1?=
 =?utf-8?B?WjJkRDEwZ1hQMWhxRGxMazBxbEFla2xzTE84MWw5M09lb29vWXpaTjNJYXBi?=
 =?utf-8?B?UUZzakRscjdwWWpnRzVYUVNMSjRSeEJCSXBTMEhhdTVmUjduNU5jYzF5M2Jr?=
 =?utf-8?B?MWFUUkVIL3lPVWgrLzg4SnJPaTZQNnIzNEZVeUxpT3NsQzQ2bXlQVVo2VFhp?=
 =?utf-8?B?ZUxBbzE3OFpveUVib0JHbzRpQmxOWGlNb0sxVTBSSEFyblQxU0VWZjlOdW92?=
 =?utf-8?B?T3BQczNDU0dMdldIZGNrVHNYTmxtWkxvOW9lNkpiNXZ3aUNWUGYzVjFvOWM5?=
 =?utf-8?B?NWMwajFTYXJaTFk0dWU1OFRzUE05eDRzSmNVa1dyTXVPa2JSTk9sRnVXS0dX?=
 =?utf-8?B?SEFXZ0hDenNxaXhFZWRuQk9lRlM3QWV3MFhDUHdlMm5xMUhkb2RZM2FYNWdL?=
 =?utf-8?B?NFZDTWNCM3U5a1JFc1NybFZHTFR3U2tua2xMWk44eU80cE15d01sUEVIT2Yr?=
 =?utf-8?B?QkcrSmE5Q1NBdjduMnZuNmgvTENIWkk1U1FVcFNoOFhYS1BlbEpacFdCU0U4?=
 =?utf-8?B?dFhBL280ejJuQ1lxdFM3MjVFd1dJQ3haZXpBT2xvRFFIc0tsbnBYT0hqYW9y?=
 =?utf-8?B?WC9hOVByTlpvTEF5STZQbDVRN1JMNE0vSXFsTHZrSWVSbnNRQjVVRjdGQnhX?=
 =?utf-8?B?WTdPUk5JMFdtL2l2WXpZWS9LRm5YNjRIRjJRMHB4QXp0bjBwNHBOc1p4Njlp?=
 =?utf-8?B?dWx1enJXMG1abmhaVVMzYTQ2NklVWTRPd1NWQmtYYjRyNGpuNldPdjZQckVp?=
 =?utf-8?B?czNJR3ZYQml0NkxrR2dkRmdWUG1GZUNZb0lwTVdid1NROS9mRHdiQURpbTZR?=
 =?utf-8?Q?mAXxG2uARt0XnBt6N49dmc0=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f8fbde-e333-4cdf-7b00-08db9a0cdb2d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 01:47:01.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAtuG1zqbHA5C/6y45U3j+mc3L1Aq61PL1B1nzfexEoKU5Ib+38mKVynOMVQyR7esQK2cSVt4jErYqYOKZcmZ0VZ18ZbXsVRLZpWihfHYUvoEzE7hjqfr7YmvHTxnRUD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8197
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

在 2023/8/10 23:27, Marc Zyngier 写道:
> Huang,
>
> Please make sure you add everyone who commented on v1 (I've Cc'd Mark
> so that he can shime need as needed).
thanks.
>
> On Thu, 10 Aug 2023 08:29:06 +0100,
> Huang Shijie <shijie@os.amperecomputing.com> wrote:
>> 1.) Background.
>>     1.1) In arm64, start a guest with Qemu which is running as a VMM of KVM,
>>          and bind the guest to core 33 and run program "a" in guest.
>>          The code of "a" shows below:
>>     	----------------------------------------------------------
>> 		#include <stdio.h>
>>
>> 		int main()
>> 		{
>> 			unsigned long i = 0;
>>
>> 			for (;;) {
>> 				i++;
>> 			}
>>
>> 			printf("i:%ld\n", i);
>> 			return 0;
>> 		}
>>     	----------------------------------------------------------
>>
>>     1.2) Use the following perf command in host:
>>        #perf stat -e cycles:G,cycles:H -C 33 -I 1000 sleep 1
>>            #           time             counts unit events
>>                 1.000817400      3,299,471,572      cycles:G
>>                 1.000817400          3,240,586      cycles:H
>>
>>         This result is correct, my cpu's frequency is 3.3G.
>>
>>     1.3) Use the following perf command in host:
>>        #perf stat -e cycles:G,cycles:H -C 33 -d -d  -I 1000 sleep 1
>>              time             counts unit events
>>       1.000831480        153,634,097      cycles:G                                                                (70.03%)
>>       1.000831480      3,147,940,599      cycles:H                                                                (70.03%)
>>       1.000831480      1,143,598,527      L1-dcache-loads                                                         (70.03%)
>>       1.000831480              9,986      L1-dcache-load-misses            #    0.00% of all L1-dcache accesses   (70.03%)
>>       1.000831480    <not supported>      LLC-loads
>>       1.000831480    <not supported>      LLC-load-misses
>>       1.000831480        580,887,696      L1-icache-loads                                                         (70.03%)
>>       1.000831480             77,855      L1-icache-load-misses            #    0.01% of all L1-icache accesses   (70.03%)
>>       1.000831480      6,112,224,612      dTLB-loads                                                              (70.03%)
>>       1.000831480             16,222      dTLB-load-misses                 #    0.00% of all dTLB cache accesses  (69.94%)
>>       1.000831480        590,015,996      iTLB-loads                                                              (59.95%)
>>       1.000831480                505      iTLB-load-misses                 #    0.00% of all iTLB cache accesses  (59.95%)
>>
>>         This result is wrong. The "cycle:G" should be nearly 3.3G.
>>
>> 2.) Root cause.
>> 	There is only 7 counters in my arm64 platform:
>> 	  (one cycle counter) + (6 normal counters)
>>
>> 	In 1.3 above, we will use 10 event counters.
>> 	Since we only have 7 counters, the perf core will trigger
>>         	multiplexing in hrtimer:
>> 	     perf_mux_hrtimer_restart() --> perf_rotate_context().
>>
>>         If the hrtimer occurs when the host is running, it's fine.
>>         If the hrtimer occurs when the guest is running,
>>         the perf_rotate_context() will program the PMU with filters for
>>         host context. The KVM does not have a chance to restore
>>         PMU registers with kvm_vcpu_pmu_restore_guest().
>>         The PMU does not work correctly, so we got wrong result.
>>
>> 3.) About this patch.
>> 	Make a KVM_REQ_RELOAD_PMU request before reentering the
>> 	guest. The request will call kvm_vcpu_pmu_restore_guest()
>> 	to reconfigurate the filters for guest context.
>>
>> 4.) Test result of this patch:
>>        #perf stat -e cycles:G,cycles:H -C 33 -d -d  -I 1000 sleep 1
>>              time             counts unit events
>>       1.001006400      3,298,348,656      cycles:G                                                                (70.03%)
>>       1.001006400          3,144,532      cycles:H                                                                (70.03%)
>>       1.001006400            941,149      L1-dcache-loads                                                         (70.03%)
>>       1.001006400             17,937      L1-dcache-load-misses            #    1.91% of all L1-dcache accesses   (70.03%)
>>       1.001006400    <not supported>      LLC-loads
>>       1.001006400    <not supported>      LLC-load-misses
>>       1.001006400          1,101,889      L1-icache-loads                                                         (70.03%)
>>       1.001006400            121,638      L1-icache-load-misses            #   11.04% of all L1-icache accesses   (70.03%)
>>       1.001006400          1,031,228      dTLB-loads                                                              (70.03%)
>>       1.001006400             26,952      dTLB-load-misses                 #    2.61% of all dTLB cache accesses  (69.93%)
>>       1.001006400          1,030,678      iTLB-loads                                                              (59.94%)
>>       1.001006400                338      iTLB-load-misses                 #    0.03% of all iTLB cache accesses  (59.94%)
>>
>>      The result is correct. The "cycle:G" is nearly 3.3G now.
>>
>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>> ---
>> v1 --> v2:
>> 	Do not change perf/core code, only change the ARM64 kvm code.
>> 	v1: https://lkml.org/lkml/2023/8/8/1465
>>
>> ---
>>   arch/arm64/kvm/arm.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index c2c14059f6a8..475a2f0e0e40 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -919,8 +919,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>   		if (!ret)
>>   			ret = 1;
>>   
>> -		if (ret > 0)
>> +		if (ret > 0) {
>> +			/*
>> +			 * The perf_rotate_context() may rotate the events and
>> +			 * reprogram PMU with filters for host context.
>> +			 * So make a request before reentering the guest to
>> +			 * reconfigurate the event filters for guest context.
>> +			 */
>> +			kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
>> +
>>   			ret = check_vcpu_requests(vcpu);
>> +		}
> This looks extremely heavy handed. You're performing the reload on
> *every* entry, and I don't think this is right (exit-heavy workloads
> will suffer from it)
>
> Furthermore, you're also reloading the virtual state of the PMU
> (recreating guest events and other things), all of which looks pretty
> pointless, as all we're interested in is what is being counted on the
> *host*.

okay. What about to add a _new_ request, such as KVM_REQ_RESTROE_PMU_GUEST?


> Instead, we can restrict the reload of the host state (and only that)
> to situations where:
>
> - we're running on a VHE system
>
> - we have a host PMUv3 (not everybody does), as that's the only way we
>    can profile a guest

okay. No problem.


>
> and ideally we would have a way to detect that a rotation happened
> (which may requires some help from the low-level PMU code).

I will check it, hope we can find a better way.


Thanks

Huang Shijie


