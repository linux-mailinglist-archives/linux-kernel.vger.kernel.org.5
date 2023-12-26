Return-Path: <linux-kernel+bounces-11506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A3081E766
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4B3282EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087204E632;
	Tue, 26 Dec 2023 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CYmtrD9f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2026.outbound.protection.outlook.com [40.92.18.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3619B20307
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUEC9zz+4znDeG2cPL6c310s93HnOEzrXDztpEkK4uWvrntAYBOnL8Tw7OD8Ni/3/7TzoA2ZZegfUoWcpFtCKepBFvvr8ioTETs1gVYDJrBDQ47RVCMVGrtQFxx1yxRnpCC2sYloIcBGLz9Xmq40pF9F3IirWaL/HIoG/rAUnqZzeJFvh2tKLogF8+bbrEcOYFOi7IhdQmqItGqYnsqXlZ6BtWMAytkmjsmMMVHJh/dYQDc1fyAj/rCTruU6Qko17wZfjo5nfrM7wpe9udi8oI+P2PvttkTkNB0YJXH/CjRIjXXbNULD9ZZNQ+zt1BDVgH1I7EH3DYPffQaxiLSISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf3dfUP5jc6eqch0PxZ6daDABCxv1gDtkdXYtzp4Cec=;
 b=WV9lNBuOdOb9gM9a+Sl4XO4Gnp60LgM3ltLyJzPbuCIBv7PDwpp7xS9NmLiCYbdwFhj+v/J6PBKPYpuVpJq9dIOa+3TG2S4wNZkSiWRwrUgYEs20O35lRYtAaREL+K3AZKDyG5ecJRaJ/04no/p+924B1rQY44b2+caBeOOuK7BK9yDt6VrR+Rck2kLkqAgn7pYfH427PM1Z9hlEH6ot8HAIuDOFLAdwsCDm8E1RBastfmjkGiBJMhPS6CbQOBjZRxNWzDxwCmzf0IeB0mUubfSj08mhTMb5BUmRqGX8EHF4sTeOJ2112e6YM2lzVsIe5ZH1nCjJCM8BB/wa6i2GJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf3dfUP5jc6eqch0PxZ6daDABCxv1gDtkdXYtzp4Cec=;
 b=CYmtrD9fOLmfP/34VzQ66wCa8hGs2h5OSvDvynHBMHffzYKGbZOLHrrW3FSVJGaMirO9+WGAU/O/9leszNKWQ7UE9MqyF/Z+03QbaFueo9n7Ij3LaCbdPuvcQsVYp0ydXOJSQACLputeGpnJccfz8uWRPtZCG4qUhgBlvGf81FScNp1NjJeN+NPUPQ4Di23uAEvBtnCoAogBN9ihsvMnA8yuQ3SaupRtLqdqZWi557FzNYNOQefiO4CPa09jRrvQNLm5qSb/EcfDYapYQXjeKnvIdX5NF/l7fsVAlOnyofL/sNidOdCNsRHd0mIT2cGJsC1g4vHTGyztTlj0Izh5ag==
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e1::10)
 by LV8PR84MB3605.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 12:31:26 +0000
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6]) by MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6%4]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 12:31:25 +0000
Message-ID:
 <MW4PR84MB3145CC0AEAA83C47A3C0B49E8198A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
Date: Tue, 26 Dec 2023 20:31:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] LoongArch: use generic interface to support
 crashkernel=X,[high,low]
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Youling Tang <tangyouling@kylinos.cn>
References: <MW4PR84MB3145311E8DE893E89119FAFA8199A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
 <CAAhV-H6Qka0yNMRwtk5aFOqBQchU__myZgH4EzNnKBwur86oDg@mail.gmail.com>
From: Youling Tang <youling.tang@outlook.com>
In-Reply-To: <CAAhV-H6Qka0yNMRwtk5aFOqBQchU__myZgH4EzNnKBwur86oDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [m/bbLbSlySCb661AunYLUFhCXYoGA1eIsY7W+OUDhC8=]
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e1::10)
X-Microsoft-Original-Message-ID:
 <deb6a9cb-c81f-cd15-313f-f96c2fbe1bf5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR84MB3145:EE_|LV8PR84MB3605:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c4c56c-896d-4293-9071-08dc060e938a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KAvm0oG2ff4wCHqY/I5hB+vXo1rAy2ftHQCY3z0w/l9l13JgZ8aMJbiBL2GLTBMYRb2BkmbpgWSBFqbFYit/In05TXULVXc50xOMFZj04c70MyBI9wouPKiZNMJk9ULrrGCTAEq0B/aRpPorhoDNx8N77WoK4Ef6Rlsytr5pGZayjzYr4ptL9CPbI0wxsmr2x1U4Xl31/+NREDj5Nxr3h0NSHAmS1WG2MirF6K2r48eMzy4F2ukAnB9IRBOMzS9M0V4pXDjK07a8P007nUnCGjMU9GRyZmV3JNdNR7OoyGBILa6YWntANFCqznf7ojNlyFLkveSxFznn5E5u+/P4KgYMH3W1s7xpVu1b9y6CwYysWYc4KA1UtmJPVEZ6QzbFFRthkXJL02j2lQUznsP6wmjPO16cTDd9lUw2mB1iIooxy127Jy/NuDoynq/aycW8aw+E+YFoDL2WLgX6kMv/ccxzaYswUUkqGsviEHLFbdrGCh+YIgGoecpKtlF0hndEQltqpehHBeJAbhewTo99H36RCt7UDYeYYj9m6OwD8Z7mS9mOBMG81Eyy54kERusa
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjRaRzcwMGRtZUlCYzkzNURaQlFJVzlYaUJ4L3R5ZzZHN256SmMvbUxrNUhj?=
 =?utf-8?B?V2tyeGxMQWFIdGtOYWVFb2F5dVVMRHNTSlJBbVVqNlhwRnlPUmJGckVNV0Nm?=
 =?utf-8?B?NHRQb0FYMWwreVNpd1FlQzY2RnRJckNQMG5CbUtLMXZQUXRNR1hSUDI4L3dR?=
 =?utf-8?B?dDB6ZWUvNUlJWVo2NWFXdERJT0MyQ2ZGYTVDejdzNlo0UkR4eWZYcDZ2cGVO?=
 =?utf-8?B?QytTZkJVQkUzY3B0dTkxdWNQSVBjc2IzTG5JWFRlMHA1WnQrRFQ5QW5jaUZF?=
 =?utf-8?B?N2RRQ1h3eVJVNE40RW0yZDFpZVlEMzNyamcyd2JmMGQvTXFibk83RDVBaXBD?=
 =?utf-8?B?RE1heDMzQ2hjVVI5a00xZUlsbzhhc3IzdHVZWWhJaDZRNGtnQUZOZEs1QnVP?=
 =?utf-8?B?SEE0eXZJNm8zV2FQVlptMUFIMzYyOThsK1RYNUZmZTBCSVpWOXIySW8vbllj?=
 =?utf-8?B?RlNNbFAxVzFPeTk0Z21kZEdLb0ptdkJXa2U5Q1Y5MytXU0lNb01CY0xIbExW?=
 =?utf-8?B?bXZNZzJlaW9XbSszQlpHa0VqYVhzb1FFZmdJUG9BS3A2Vm5TSXBjeE52Z2I4?=
 =?utf-8?B?UTJyRDByelo0OWdreXpFZ1QyYVlTa0FiN2pac2czMHdPdnNwbFFiR05mbHFk?=
 =?utf-8?B?dFhDZC94VTMzVjlhbjgwb1pMUU1nQmtJTjlrTno2RnZObkluTmUvWnUzYUs1?=
 =?utf-8?B?T1ZPejZYemhLN1d6cjVLR0JmK1NCMURDQklmcGloWmVKdnkyUjJHVTR5Qktr?=
 =?utf-8?B?RllIVUNXVkNXS24vVEd4enF3VmpZMnhCWDRRSU5JYm5vamZ2M09ORDc2cVFL?=
 =?utf-8?B?STBnbUdoeDRjUFdoSjFqdm1FWWMzTkFCdGthTDFVOG1zTjVYcnFxM0c4V3Rq?=
 =?utf-8?B?eXJEdlg4REZZQVdiNm9EOEp6S0FnZm9hckhYOVhoMEZQaTdkV29WVnhnbEVh?=
 =?utf-8?B?dlZ2bGkrdVBvWkgwalVRZlZiRDUrRmlxdjcxWDhncXhpT3UvVmE0RG1sN2ky?=
 =?utf-8?B?OWIrZjJBdmhEbkdRdjdCOFl6YUpVQUZxY3FObU1uc1VsSHNTaGw2Vm5QaVZG?=
 =?utf-8?B?UTFST1BVanU2b00xc1FXMUtlamFLOUFodEFwNmVSVjNjSjFPQmlBOTlESXRt?=
 =?utf-8?B?K0tsU1JRREUvbzh2a01BS3lHcDNrOXl5RFdBRm56OUcweFgrdG00TlM0bGha?=
 =?utf-8?B?Z3J0UnB6SGpvY3RIZEV5OVZSbmRtQkdHRC9pWkdPZkY3VUczVi9pSDZIRHlM?=
 =?utf-8?B?WUU2Y1A1MUlnSHdUa2VHTC9NRnpZRy9vbkV1S0RvRzB0TVM5VmZWS1JrdzhD?=
 =?utf-8?B?NG9DbkQ2V1UxSGtCa2o0bnM1emNxY1lIbURUYjBvVHRLS2FtY1RCN3oxMTFr?=
 =?utf-8?B?cEE5RXA3VDNTamFYUWcvNFh0eXJnNnpBY1VYSC9sZi9lMGhocndQSWEvN1k4?=
 =?utf-8?B?RXJFVnJJUnZZUXlvZjllamdaN1V2VGJxNmd6WTBxZXRrejc5TTZpcTZQMHhH?=
 =?utf-8?B?QUpRVldzMk11SGIwOWxLYnREeXBsZEJZS2VrTTdCRDNhRFlGU1p2VDNGck5P?=
 =?utf-8?B?MjZqQnVqQ1lzK1h5VCtSZEVWenhhRmFna2Q3MUE2bUtEanhPd2NFMFRVNk52?=
 =?utf-8?Q?qx02RmwCA5grOTFKCKmHwCH6qOYNvdzerTNlxGjluQ5A=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c4c56c-896d-4293-9071-08dc060e938a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 12:31:25.8359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR84MB3605

Hi, Huacai

On 2023/12/26 18:56, Huacai Chen wrote:
> Hi, Youling,
>
> On Mon, Dec 25, 2023 at 10:18 PM Youling Tang <youling.tang@outlook.com> wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> LoongArch already supports two crashkernel regions in kexec-tools, so we
>> can directly use the common interface to support crashkernel=X,[hign,low].
>>
>> With the help of newly changed function parse_crashkernel() and generic
>> reserve_crashkernel_generic(), crashkernel reservation can be simplified
>> by steps:
> It is better to refer the commits introduce those changes.
ok
>
>> 1) Add a new header file <asm/crash_core.h>, and define CRASH_ALIGN,
>>     CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX and
>>     DEFAULT_CRASH_KERNEL_LOW_SIZE in <asm/crash_core.h>;
>>
>> 2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
>>     reserve_crashkernel_generic();
>>
>> 3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
>>     arch/loongarch/Kconfig.
>>
>> One can reserve the crash kernel from high memory above DMA zone range
>> by explicitly passing "crashkernel=X,high"; or reserve a memory range
>> below 4G with "crashkernel=X,low". Besides, there are few rules need
>> to take notice:
>>
>> 1) "crashkernel=X,[high,low]" will be ignored if "crashkernel=size"
>>     is specified.
>> 2) "crashkernel=X,low" is valid only when "crashkernel=X,high" is passed
>>     and there is enough memory to be allocated under 4G.
>> 3) When allocating crashkernel above 4G and no "crashkernel=X,low" is
>>     specified, a 128M low memory will be allocated automatically for
>>     swiotlb bounce buffer.
>> See Documentation/admin-guide/kernel-parameters.txt for more information.
>>
>> Following test cases have been performed as expected:
> It is better to group them into "Recommended use cases", "Valid use
> cases (not recommended)" and "Invalid use cases".
ok
>> 1) crashkernel=256M                          //low=256M
>> 2) crashkernel=1G                            //low=1G
>> 3) crashkernel=4G                            //high=4G, low=128M(default)
>> 4) crashkernel=4G crashkernel=256M,high      //high=4G, low=128M(default), high is ignored
>> 5) crashkernel=4G crashkernel=256M,low       //high=4G, low=128M(default), low is ignored
>> 6) crashkernel=4G,high                       //high=4G, low=128M(default)
>> 7) crashkernel=256M,low                      //low=0M, invalid
>> 8) crashkernel=4G,high crashkernel=256M,low  //high=4G, low=256M
>> 9) crashkernel=4G,high crashkernel=4G,low    //high=0M, low=0M, invalid
>> 10) crashkernel=512M@2560M                   //low=512M
>> 11) crashkernel=1G,high crashkernel=0M,low   //high=1G, low=0M
>>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>> ---
>>   arch/loongarch/Kconfig                  |  3 ++
>>   arch/loongarch/include/asm/crash_core.h | 11 ++++++
>>   arch/loongarch/kernel/setup.c           | 48 +++++++------------------
>>   3 files changed, 27 insertions(+), 35 deletions(-)
>>   create mode 100644 arch/loongarch/include/asm/crash_core.h
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index ee123820a476..02060b2ac3f2 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -575,6 +575,9 @@ config ARCH_SELECTS_CRASH_DUMP
>>          depends on CRASH_DUMP
>>          select RELOCATABLE
>>
>> +config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>> +       def_bool CRASH_CORE
>> +
>>   config RELOCATABLE
>>          bool "Relocatable kernel"
>>          help
>> diff --git a/arch/loongarch/include/asm/crash_core.h b/arch/loongarch/include/asm/crash_core.h
>> new file mode 100644
>> index 000000000000..1f7040d8ed0f
>> --- /dev/null
>> +++ b/arch/loongarch/include/asm/crash_core.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef _LOONGARCH_CRASH_CORE_H
>> +#define _LOONGARCH_CRASH_CORE_H
>> +
>> +#define CRASH_ALIGN                    SZ_2M
>> +
>> +#define CRASH_ADDR_LOW_MAX             SZ_4G
>> +#define CRASH_ADDR_HIGH_MAX            memblock_end_of_DRAM()
>> +
>> +extern phys_addr_t memblock_end_of_DRAM(void);
>> +#endif
>> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
>> index d183a745fb85..2a69a36419da 100644
>> --- a/arch/loongarch/kernel/setup.c
>> +++ b/arch/loongarch/kernel/setup.c
>> @@ -252,38 +252,25 @@ static void __init arch_reserve_vmcore(void)
>>   #endif
>>   }
>>
>> -/* 2MB alignment for crash kernel regions */
>> -#define CRASH_ALIGN    SZ_2M
>> -#define CRASH_ADDR_MAX SZ_4G
>> -
>> -static void __init arch_parse_crashkernel(void)
>> +static void __init arch_reserve_crashkernel(void)
>>   {
>> -#ifdef CONFIG_KEXEC
>> -       int ret;
>> -       unsigned long long total_mem;
>> +       unsigned long long low_size = 0;
>>          unsigned long long crash_base, crash_size;
>> +       char *cmdline = boot_command_line;
>> +       bool high = false;
>> +       int ret;
>>
>> -       total_mem = memblock_phys_mem_size();
>> -       ret = parse_crashkernel(boot_command_line, total_mem,
>> -                               &crash_size, &crash_base,
>> -                               NULL, NULL);
>> -       if (ret < 0 || crash_size <= 0)
>> +       if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>>                  return;
>>
>> -       if (crash_base <= 0) {
>> -               crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, CRASH_ALIGN, CRASH_ADDR_MAX);
>> -               if (!crash_base) {
>> -                       pr_warn("crashkernel reservation failed - No suitable area found.\n");
>> -                       return;
>> -               }
>> -       } else if (!memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base, crash_base + crash_size)) {
>> -               pr_warn("Invalid memory region reserved for crash kernel\n");
>> +       ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>> +                               &crash_size, &crash_base,
>> +                               &low_size, &high);
> This line can be merged with its above line.
ok
>
>> +       if (ret)
>>                  return;
>> -       }
>>
>> -       crashk_res.start = crash_base;
>> -       crashk_res.end   = crash_base + crash_size - 1;
>> -#endif
>> +       reserve_crashkernel_generic(cmdline, crash_size, crash_base,
>> +                                   low_size, high);
> They can be in one line.
ok.
I will synchronize the description of LoongArch in the crashkernel parameter
in Documentation/admin-guide/kernel-parameters.txt.

Thanks,
Youling.
>
> Huacai
>>   }
>>
>>   static void __init fdt_setup(void)
>> @@ -357,7 +344,7 @@ static void __init bootcmdline_init(char **cmdline_p)
>>   void __init platform_init(void)
>>   {
>>          arch_reserve_vmcore();
>> -       arch_parse_crashkernel();
>> +       arch_reserve_crashkernel();
>>
>>   #ifdef CONFIG_ACPI_TABLE_UPGRADE
>>          acpi_table_upgrade();
>> @@ -467,15 +454,6 @@ static void __init resource_init(void)
>>                  request_resource(res, &data_resource);
>>                  request_resource(res, &bss_resource);
>>          }
>> -
>> -#ifdef CONFIG_KEXEC
>> -       if (crashk_res.start < crashk_res.end) {
>> -               insert_resource(&iomem_resource, &crashk_res);
>> -               pr_info("Reserving %ldMB of memory at %ldMB for crashkernel\n",
>> -                       (unsigned long)((crashk_res.end - crashk_res.start + 1) >> 20),
>> -                       (unsigned long)(crashk_res.start  >> 20));
>> -       }
>> -#endif
>>   }
>>
>>   static int __init add_legacy_isa_io(struct fwnode_handle *fwnode,
>> --
>> 2.40.0
>>

