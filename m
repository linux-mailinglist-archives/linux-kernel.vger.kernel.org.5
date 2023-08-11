Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFB77787DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjHKHKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjHKHKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:10:42 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2101.outbound.protection.outlook.com [40.107.101.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F275271E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLKlTPdgiRVpgUO7MBSaj7kQySLRgRqlHRpKHUoE+Z4jE86uPXyagxNVk3JulbHNWubzmqsFjTDzFH8CNalA1BChIuEF2lxjmKnMGzYf8ou/2QV7DW9SJVt/ghlZrNtp/3WH+jbxO9VjLYtk1Zl8MyOcfvaHpWcNkw+Xk/sm+uMmDDXzncn1hCz3MjENYdIqH8C3tnyyZ68rsQuhtVB7I7F/DE1RbZHA/ZC/7cOE8Wi0UevkDAsxmV8Qn5o779s345cp4yZ+mHVGGw9GPcIF7kVjDiUKxmdr8UMDwBMco6nJQNl8uN4kX5rWWMHwtq3mXeTe/bgnXZ5fLMJaJFWbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbsIMPLlvBqSjbv8pfLqRDA5oCNxLO2ggHd/U8+qUZI=;
 b=e4KxyT8+WWd73HdHC8vBj6uhqlxWR0ipo4TpqBLjSkY26PBIKI6cOHGW838HFhcwlSTjjC+dHpH+WT5BF06raNsIfD83bQgGRbJ0/FnPw9LPlgJidHhFcEMDLuIIgjx98KOS4GffsVZLPaGdiv/bIamzat9r6TrfeiHlbERM+YBE1430vqLoFz56szrJQ3SjFWzvV0uLbj1n1IAATdhbuwLdqay+cftCIFGWqxRCghSJiH6JwWbGYkSlZcOovwvPkEH5sM3hAl7hgoRXaS2bxHsZeTF4nVuApCwZo09M/QMt+J7MyH0bmpAKPsDPgoQxXSncyqCof4Ks+USatv1k5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbsIMPLlvBqSjbv8pfLqRDA5oCNxLO2ggHd/U8+qUZI=;
 b=0NqxdOL1aEx1XoV5hwkjrKwqLCf9ibJILCe1yslsXtWfCTQGCdVPnKIv3+aFUnUp6Aw71vrrG6EK+8G/1rC4T4tnDCe8nACsLRN0fDx5/OfwBsOr02HtF+jV+9BOxBelxPwPSrqX3s6NAYwY1FNAzaa0lCWUuwO5xChMdyslWa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 BN0PR01MB7038.prod.exchangelabs.com (2603:10b6:408:164::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.20; Fri, 11 Aug 2023 07:10:37 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 07:10:36 +0000
Message-ID: <fb7b3ebd-4731-4de7-7c39-ac4b0b0b2bfa@amperemail.onmicrosoft.com>
Date:   Fri, 11 Aug 2023 15:10:26 +0800
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
From:   Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <87r0oap0s4.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:610:b3::21) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|BN0PR01MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: c684d2e0-cd75-4056-0783-08db9a3a0fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eNSvLFdyk9ltY/qY8wLbeWzFyBnK0mmEpXSH1HIdnojbaCIegCtHWCEkUzCZ5glGkwVRwhD/blWCiyNRz7eDET7Ropdykd5hpP2ZdUiQM+bgTPgIZYkIqM0ro+EoV2siMrpkDnVuVoJ3ka3hB1X+yPEJPgJZ9P8Scl9gRRAUmfJemLO8gpG/dSmmm3CVmW7Orl3yVv4Ogsp78TJSDUXx69Gue/FjPgnT7J+A1EOCdF3UTsEJafVioQe1lEHP91q3RYhQiX/f6EwUFNfcRM7NrOiVSkGp/hktrrqCN7Z9yM35rBrNAom3XeLl0GG6+HN5qE+sgtCoQcvwn+pPXJZZ47AZUintf5C3af3AwXHftvPfdyDNSwDkdK7+pg2DgLRVsm5MrJJ9/niu1OWIzl23hA43YAVowGIPBdO8DN+JZtnxYJRisWSV3EkRdqmZqe/C2FkNdF2MCDVLFHDqq38QkilqopHouEMVaVVWrDLPlTVNXHW0UQx34TPnttCeQ393rG3Vfb12Re9s4eka5mvQFcPzvO/5Ro+vVvX0LYyIcABzSWvVOuKzaxCwwgfuvbO5TXc1lGx/VPEtcG4RLMPn1DB/bkb+JBXhMhRO5w2slHmdffv9KfPBu2EsSCxh/WOBAF0tXGXvL1umDqw7I7WG7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(366004)(346002)(376002)(396003)(186006)(1800799006)(451199021)(31686004)(83170400001)(66899021)(966005)(6512007)(52116002)(31696002)(38350700002)(38100700002)(6506007)(26005)(83380400001)(42882007)(2616005)(478600001)(54906003)(6666004)(6486002)(4326008)(6916009)(316002)(41300700001)(8936002)(8676002)(2906002)(7416002)(5660300002)(66476007)(66556008)(66946007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVFZczdMT3RzakRyaHBPd3BpVkQyZk5NbWUySUZJZmlXT2ZoMnJ5ZEY1Wk1q?=
 =?utf-8?B?MTlSSmxySEl4UlpETFpkTTNlSlBjNlFIZExCZjN6Slo0dHZWU29zZVVFZU1F?=
 =?utf-8?B?aVgwRlduQ3R5OVhYaUcvd3orM29xeThIUDI3ajQzekRWUHRuQTQ4QjV1YXpL?=
 =?utf-8?B?RlFBVFdYa0taUUZlZnM2SkFoS1RBRmhaZjdmQjViWXdtS1dJcCtaTWhUZVZX?=
 =?utf-8?B?VC9kbGdKVkNvTU5ZbEMveGNsUUtmU3pJUlljU2dxNzFqR2ZFU1dRdFNtWTlu?=
 =?utf-8?B?SXZBWlM3MC9EVWxvK250TWJKa2ZmQ2JZZ2RnT0JZMW1acEJ2YThDNUJyd2Qz?=
 =?utf-8?B?K0R0QS8zdmYrSGRGekNiSWlCTDIzU2JrUVBaU0gvYVNIOGNwWFEzZ1M5VGxP?=
 =?utf-8?B?cC83UFg2RjQ1aytZT3c1cWVwTXU0ckp1NjJ2NU0xZ3VmVGZvdWZiVmZqWllB?=
 =?utf-8?B?ai9CNisva3ZBb0orUTcxNEhQUWlXOUZrMTM1T1g3clZ6OHRyVGhLOUswMEZq?=
 =?utf-8?B?VUxpSWVtWWlENlZGRURwZ1I3aFZhdmllamFacm1xRjhuWnZIa2E5c0hkTFdN?=
 =?utf-8?B?NGVlWTQ5aWYvYXBnMmpObXEzcEE5dnM0YmlSSmFjQWpOVDRvaWhqZzdZZ1VR?=
 =?utf-8?B?TEplbmZHVHV4NXg4MTJHRkVhNzRyQlptQXBuSm5kVkg4K3ROK3A1QnRiOStx?=
 =?utf-8?B?Zk1vaFJyY3IwOVBPTEM0L1BtMHJyWU01ZWhCOEI5RnpKd1JHMElxSGNpSXBk?=
 =?utf-8?B?R000Q3BjS1QyekZNTUtYU0trTDN6a3BZRytpS1JPaFlNTTRpTHZ2Q0xhTUVL?=
 =?utf-8?B?OVNjOXNnaTIwNHd3TS9xTWQ1NjB4dnNFMmQwY2c3eno3bzdQOGFDNGlSVFp1?=
 =?utf-8?B?Qk8xRTgraFdpYm1XVk9FUXlTVWxrTVQvdGExY3hzNkVwS0t2V0VPNnJKRXVr?=
 =?utf-8?B?UllTQS9jRzFXMW8ydzdwN1FycW9XQ1lFeEZHSmw4YUpnckVQQjdMdnNLVEJP?=
 =?utf-8?B?UXQrQ1RRRWVpTElEZDB3QWtWZllhUEdtNWZZS0lNZjArUVJ1bHhnVEtzZXF6?=
 =?utf-8?B?RnRyY3RQS1hDelRYMkpJOXlwOTJscnU1SzBxa2xuQzE3T3dERzA0Vkk3MmpZ?=
 =?utf-8?B?QVpVWVpIMFp0RWMxc3ZZSXFSaHJVb2svdzhaTUIzZnEvZm1IdE9SMUJidU0v?=
 =?utf-8?B?a3NEbVU5YVJaOE53WkVBUUxWYkhQR1ZEMjFXTFFMaitxcDQ5MUFCblR2bnJv?=
 =?utf-8?B?WXIxV3ZsOUY2ZEtOZGcwUllNcHdrODhmc1N4RlNiQThSOHFXcW1DU0JTcTFl?=
 =?utf-8?B?RERWaE5MNWMzYVc1b1pmZHR5U0hkWDVsKzQ5cHA5SWUyekN4dkNTRlR1L0Mx?=
 =?utf-8?B?NXptem1vdHBLQVQ5TVExNmJsMmw0OXlqaS8yVnF5TlIvZ25kbThuUnhtYmNH?=
 =?utf-8?B?c2hNL21HQ1NsaFMyTjVMcndSWDBmR3AxczhlWWdkZjhucVM0cjRRWjhHdW9a?=
 =?utf-8?B?L1UzQXhmNlI1RHFVK0VtdWd2enYwcnRscHBCYWQwTW1Hcld4SUpJUlp2a0Jz?=
 =?utf-8?B?WTdMYUl2Zk5KUjJWZHVMSk5WcW15dEhnSGtOckFDanJDaDEySEluMW0wbmpM?=
 =?utf-8?B?WkdJRDhvQytlVTdTQVZYWHFoMEZlS1FRKy84SVdNc0tuYklhT2RkejM2dHpo?=
 =?utf-8?B?MUhuV3U5cVJ6Y1pGbW9jb1MwNnRYVmY0VGZEZXBjeVk2QzRwV2xyV1dtQVpC?=
 =?utf-8?B?SVlhRjZwQmRVZnlPZnZwT1ZkcjgxQXg1aG9NVW9aejdrWGJGck96VEdqd1pS?=
 =?utf-8?B?SS92K0w5UTBvcGx1SVNvN2FpS0xGQ0dkM1ZKeXpmYUQ1U29oYmQ0VXY2QStv?=
 =?utf-8?B?RityS0E4b2lKYzJmTjhrZDRmZm5ZY0tpUXAxWUwyV0psUXZ1WFl5YWc4aEsv?=
 =?utf-8?B?cmpKVWpmUVlCSXFJcnFDeElUdW9KaG1WSW10Nyt0bS9PNHNpQ0dFbDhSU0NO?=
 =?utf-8?B?ZlhsMVhNSnZ2VXZkZy9wbzc2MTE5eGluUTYyNFBybjFtZEMwUFp5L2toSlZr?=
 =?utf-8?B?cXJ0WHZoZzFReStQdXhYeTk5bGh2bUpMYkgrUWVWZUVUTjZtWmsvaFNrM1lY?=
 =?utf-8?B?aUtCKy9nOTY2QWNyai9FSm1CR0pVNU1CVkEwbEcvN3M1eHE1bUtlV2g0aFlV?=
 =?utf-8?Q?qvY9HBkjspmUCpgrytnu64o=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c684d2e0-cd75-4056-0783-08db9a3a0fa4
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 07:10:36.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpFuj72tLtl7sMjIHuZQ/FRX02+bVM0r/ET+P1PANA9n9yDfe+vYtjXhh/vUUy6R2jUPxYa6H0IDMxwXC2v6ep4GZfth7GpbyLqL+2A4Jr+yOp2vGGKeONAAAVdBwpbn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7038
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

在 2023/8/11 14:10, Marc Zyngier 写道:
> On Fri, 11 Aug 2023 02:46:49 +0100,
> Shijie Huang <shijie@amperemail.onmicrosoft.com> wrote:
>> Hi Marc,
>>
>> 在 2023/8/10 23:27, Marc Zyngier 写道:
>>> Huang,
>>>
>>> Please make sure you add everyone who commented on v1 (I've Cc'd Mark
>>> so that he can shime need as needed).
>> thanks.
>>> On Thu, 10 Aug 2023 08:29:06 +0100,
>>> Huang Shijie <shijie@os.amperecomputing.com> wrote:
>>>> 1.) Background.
>>>>      1.1) In arm64, start a guest with Qemu which is running as a VMM of KVM,
>>>>           and bind the guest to core 33 and run program "a" in guest.
>>>>           The code of "a" shows below:
>>>>      	----------------------------------------------------------
>>>> 		#include <stdio.h>
>>>>
>>>> 		int main()
>>>> 		{
>>>> 			unsigned long i = 0;
>>>>
>>>> 			for (;;) {
>>>> 				i++;
>>>> 			}
>>>>
>>>> 			printf("i:%ld\n", i);
>>>> 			return 0;
>>>> 		}
>>>>      	----------------------------------------------------------
>>>>
>>>>      1.2) Use the following perf command in host:
>>>>         #perf stat -e cycles:G,cycles:H -C 33 -I 1000 sleep 1
>>>>             #           time             counts unit events
>>>>                  1.000817400      3,299,471,572      cycles:G
>>>>                  1.000817400          3,240,586      cycles:H
>>>>
>>>>          This result is correct, my cpu's frequency is 3.3G.
>>>>
>>>>      1.3) Use the following perf command in host:
>>>>         #perf stat -e cycles:G,cycles:H -C 33 -d -d  -I 1000 sleep 1
>>>>               time             counts unit events
>>>>        1.000831480        153,634,097      cycles:G                                                                (70.03%)
>>>>        1.000831480      3,147,940,599      cycles:H                                                                (70.03%)
>>>>        1.000831480      1,143,598,527      L1-dcache-loads                                                         (70.03%)
>>>>        1.000831480              9,986      L1-dcache-load-misses            #    0.00% of all L1-dcache accesses   (70.03%)
>>>>        1.000831480    <not supported>      LLC-loads
>>>>        1.000831480    <not supported>      LLC-load-misses
>>>>        1.000831480        580,887,696      L1-icache-loads                                                         (70.03%)
>>>>        1.000831480             77,855      L1-icache-load-misses            #    0.01% of all L1-icache accesses   (70.03%)
>>>>        1.000831480      6,112,224,612      dTLB-loads                                                              (70.03%)
>>>>        1.000831480             16,222      dTLB-load-misses                 #    0.00% of all dTLB cache accesses  (69.94%)
>>>>        1.000831480        590,015,996      iTLB-loads                                                              (59.95%)
>>>>        1.000831480                505      iTLB-load-misses                 #    0.00% of all iTLB cache accesses  (59.95%)
>>>>
>>>>          This result is wrong. The "cycle:G" should be nearly 3.3G.
>>>>
>>>> 2.) Root cause.
>>>> 	There is only 7 counters in my arm64 platform:
>>>> 	  (one cycle counter) + (6 normal counters)
>>>>
>>>> 	In 1.3 above, we will use 10 event counters.
>>>> 	Since we only have 7 counters, the perf core will trigger
>>>>          	multiplexing in hrtimer:
>>>> 	     perf_mux_hrtimer_restart() --> perf_rotate_context().
>>>>
>>>>          If the hrtimer occurs when the host is running, it's fine.
>>>>          If the hrtimer occurs when the guest is running,
>>>>          the perf_rotate_context() will program the PMU with filters for
>>>>          host context. The KVM does not have a chance to restore
>>>>          PMU registers with kvm_vcpu_pmu_restore_guest().
>>>>          The PMU does not work correctly, so we got wrong result.
>>>>
>>>> 3.) About this patch.
>>>> 	Make a KVM_REQ_RELOAD_PMU request before reentering the
>>>> 	guest. The request will call kvm_vcpu_pmu_restore_guest()
>>>> 	to reconfigurate the filters for guest context.
>>>>
>>>> 4.) Test result of this patch:
>>>>         #perf stat -e cycles:G,cycles:H -C 33 -d -d  -I 1000 sleep 1
>>>>               time             counts unit events
>>>>        1.001006400      3,298,348,656      cycles:G                                                                (70.03%)
>>>>        1.001006400          3,144,532      cycles:H                                                                (70.03%)
>>>>        1.001006400            941,149      L1-dcache-loads                                                         (70.03%)
>>>>        1.001006400             17,937      L1-dcache-load-misses            #    1.91% of all L1-dcache accesses   (70.03%)
>>>>        1.001006400    <not supported>      LLC-loads
>>>>        1.001006400    <not supported>      LLC-load-misses
>>>>        1.001006400          1,101,889      L1-icache-loads                                                         (70.03%)
>>>>        1.001006400            121,638      L1-icache-load-misses            #   11.04% of all L1-icache accesses   (70.03%)
>>>>        1.001006400          1,031,228      dTLB-loads                                                              (70.03%)
>>>>        1.001006400             26,952      dTLB-load-misses                 #    2.61% of all dTLB cache accesses  (69.93%)
>>>>        1.001006400          1,030,678      iTLB-loads                                                              (59.94%)
>>>>        1.001006400                338      iTLB-load-misses                 #    0.03% of all iTLB cache accesses  (59.94%)
>>>>
>>>>       The result is correct. The "cycle:G" is nearly 3.3G now.
>>>>
>>>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>>>> ---
>>>> v1 --> v2:
>>>> 	Do not change perf/core code, only change the ARM64 kvm code.
>>>> 	v1: https://lkml.org/lkml/2023/8/8/1465
>>>>
>>>> ---
>>>>    arch/arm64/kvm/arm.c | 11 ++++++++++-
>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>>>> index c2c14059f6a8..475a2f0e0e40 100644
>>>> --- a/arch/arm64/kvm/arm.c
>>>> +++ b/arch/arm64/kvm/arm.c
>>>> @@ -919,8 +919,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>>>    		if (!ret)
>>>>    			ret = 1;
>>>>    -		if (ret > 0)
>>>> +		if (ret > 0) {
>>>> +			/*
>>>> +			 * The perf_rotate_context() may rotate the events and
>>>> +			 * reprogram PMU with filters for host context.
>>>> +			 * So make a request before reentering the guest to
>>>> +			 * reconfigurate the event filters for guest context.
>>>> +			 */
>>>> +			kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
>>>> +
>>>>    			ret = check_vcpu_requests(vcpu);
>>>> +		}
>>> This looks extremely heavy handed. You're performing the reload on
>>> *every* entry, and I don't think this is right (exit-heavy workloads
>>> will suffer from it)
>>>
>>> Furthermore, you're also reloading the virtual state of the PMU
>>> (recreating guest events and other things), all of which looks pretty
>>> pointless, as all we're interested in is what is being counted on the
>>> *host*.
>> okay. What about to add a _new_ request, such as KVM_REQ_RESTROE_PMU_GUEST?
>>
>>
>>> Instead, we can restrict the reload of the host state (and only that)
>>> to situations where:
>>>
>>> - we're running on a VHE system
>>>
>>> - we have a host PMUv3 (not everybody does), as that's the only way we
>>>     can profile a guest
>> okay. No problem.
>>
>>
>>> and ideally we would have a way to detect that a rotation happened
>>> (which may requires some help from the low-level PMU code).
>> I will check it, hope we can find a better way.
> I came up with the following patch, completely untested. Let me know
> how that fares for you.
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

I currently added a similiar check in armv8pmu_get_event_idx().

The event multiplexing will call armv8pmu_get_event_idx(), and will 
definitely fail at least one time.

+++ b/drivers/perf/arm_pmuv3.c
@@ -882,6 +882,8 @@ static int armv8pmu_get_event_idx(struct 
pmu_hw_events *cpuc,
         struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
         struct hw_perf_event *hwc = &event->hw;
         unsigned long evtype = hwc->config_base & ARMV8_PMU_EVTYPE_EVENT;
+       struct kvm_vcpu *vcpu;
+       int index;
         struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
         struct hw_perf_event *hwc = &event->hw;
         unsigned long evtype = hwc->config_base & ARMV8_PMU_EVTYPE_EVENT;
+       struct kvm_vcpu *vcpu;
+       int index;

         /* Always prefer to place a cycle counter into the cycle 
counter. */
         if (evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
@@ -897,9 +899,22 @@ static int armv8pmu_get_event_idx(struct 
pmu_hw_events *cpuc,
          * Otherwise use events counters
          */
         if (armv8pmu_event_is_chained(event))
-               return  armv8pmu_get_chain_idx(cpuc, cpu_pmu);
+               index = armv8pmu_get_chain_idx(cpuc, cpu_pmu);
         else
-               return armv8pmu_get_single_idx(cpuc, cpu_pmu);
+               index = armv8pmu_get_single_idx(cpuc, cpu_pmu);
+
+       /*
+        * If we are in pmu multiplexing, we will definitely meet a failure.
+        * Please see perf_rotate_context().
+        * If we are in the guest context, we can mark it.
+        */
+       if (index < 0) {
+               vcpu = kvm_get_running_vcpu();
+               if (vcpu && in_interrupt() && !event->attr.pinned) {
+                       kvm_resync_guest_context();
+               }
+       }
+       return index;
  }

IMHO, it's better to change armv8pmu_get_event_idx().

But if you think it is also okay to change armv8pmu_start() to fix the bug,

I am okay too.


Thanks

Huang Shijie


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
