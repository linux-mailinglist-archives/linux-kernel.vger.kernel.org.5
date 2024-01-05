Return-Path: <linux-kernel+bounces-17358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1451824C3C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458731F23298
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1225185B;
	Fri,  5 Jan 2024 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="mCBilYAL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2113.outbound.protection.outlook.com [40.107.102.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059FF1FB2;
	Fri,  5 Jan 2024 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crjtG7idQPjhztNm5q2rKmm/vmxWfbWMOPWyMkEikeu7Dh9TOm9CYx7PvDMYg75SXr4v0XB80JHev4Cf37axfrrBAKS8LIwjPusiCfuVa9VRs+uHNAI/yDgbVnUx/qhcn2wa2YfGb0MlRHhqf29HjNBqn7P46RNnm9uX+34DHihV70Ppx8jgvUTSvODNFjUpaeurjIVUKCGxWaLsMLnelKbyww07DPfKoFEJ1IDeS9/bUCKGChE/LtfRxQ/IIfcbv+SM7A/QBJAbsQqDUsD1swELFfg8D1gBsxGooyTmtpj5s47jXtNEw0hL9YqfAsTfILTA+LSe5wTNfkdlE5/cnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UNiLuYWMpBpCraaSVTzJ6XG0Ont1vj79z8Gc+fmveo=;
 b=ejBo+5JNCTW33AA2Ll8hkeqneEAEWB9laiZh8NtNxYEC2ZfOFcxQ0Ao94oMbBXkI4C4WI+wny/Iz9Grsu0s1DQGnuScINcLwko+X5ZmbQJ6yrN4tL/ENZoCM3A/588z97Bpm+t5dHNoanVNRYgbtfGwhE5mUA09vAqaxyzIcRSrgGsE/1ZJBtknDolPx97cqFDBdECLm6+6ZM0MFuLUvcV0YIzB0RG5QCxxp9ZSSjpGFau1DNlKQsNSLg34dCzo7Uso5Y0xZ3WmAXnROf+yjzZjjwwkZ1FrntGhbc7qKIejoK9ULiKDMK1nMqtlCnURCDOoaZZgA9K894Zq9ZonYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UNiLuYWMpBpCraaSVTzJ6XG0Ont1vj79z8Gc+fmveo=;
 b=mCBilYALlKbF8y9r+LmKRKsvj6pTlakUufRSLtCBZJ561Lk6xMxZZArWNNeCOl9RT2ybZp/uLeSXidMaxjQOj/Ykt5lkOFfWKgTX6uk28/B3B7p3XvMw53Hi87dB/4dPAOMkmE0l0dZmT/xidb0vkb6WVdkS3BS3JEt0Hv0/p5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 DM4PR01MB7761.prod.exchangelabs.com (2603:10b6:8:68::13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.29; Fri, 5 Jan 2024 00:48:04 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::7c00:4415:9732:a74b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::7c00:4415:9732:a74b%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 00:48:03 +0000
Date: Thu, 4 Jan 2024 16:48:00 -0800
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rafael@kernel.org, beata.michalska@arm.com, sumitg@nvidia.com, zengheng4@huawei.com, 
	yang@os.amperecomputing.com, will@kernel.org, sudeep.holla@arm.com, liuyonglong@huawei.com, 
	zhanjie9@hisilicon.com
Subject: Re: [PATCH] cpufreq: CPPC: Resolve the large frequency discrepancy
 from cpuinfo_cur_freq
Message-ID: <lnocwcitdbmgcyhd2dlczgdlhtfw4pfot2br2i3hqscnvr3xgq@nuxlauxum3nr>
References: <20231212072617.14756-1-lihuisong@huawei.com>
 <ZZWfJOsDlEXWYHA5@arm.com>
 <9428a1ed-ba4d-1fe6-63e8-11e152bf1f09@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9428a1ed-ba4d-1fe6-63e8-11e152bf1f09@huawei.com>
X-ClientProxiedBy: CH2PR14CA0012.namprd14.prod.outlook.com
 (2603:10b6:610:60::22) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|DM4PR01MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: bc143487-4ec2-4d65-e4f7-08dc0d87f94c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dJiO/O5y/UU27B/Wtf4wa13H3L/DNnD8DiXed1NfBU1DVKUqnHxz8P0Qgfhv2QMfLD5e4AqeL5MoZ3Fmk8KoUIxxZI75LuZlq24mockMcyEmGoViQdHlaEvxwp/bZjU8uKjRe8ewBW78x56Ala/X2+kwY0LsZ/VgbZ5PORcTZPdBJiEeWhwILfj2IIpcuBCHCROMThfIVC5XK4niV0PkiUUNvXkLsDLujZyOLtZdQKcPG4fSqgYuAtKxo4UGwBIutMjQOd3WhRCFEkvsJm0bOPq1sZTzVIdVi5x5M07A+r+ZTqY3uzhEItZR1Eo1BTOjEz+XXxoCplFsJg5ggYdjh7tCt03IvSYiqjf+QnTdCX8M0r0LUbhffpOqgBApGfWMhMwSPeXb1eE/g2Scm4Tql8sYA+3T3luBElo/3DpV0cDG7L7TvNov4aR+Td8mELmyGMSxhoTtkWvX9EcwErRdpFdkGZAVNboU8fB1yOTdR2h4QvUwcPLn+eeK4nKd+VDhQp5jbiP4pB3vLgCub5k6UiAAY/LCvZsW75YKopE3KiQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(376002)(396003)(39850400004)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(7416002)(4326008)(8676002)(8936002)(41300700001)(2906002)(33716001)(478600001)(966005)(9686003)(6512007)(6506007)(83380400001)(26005)(316002)(66556008)(66946007)(66476007)(6916009)(86362001)(38100700002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejZTclUyRGFVZnRFVDdXdStJWHFvZHBMdlE2SUM2R08xbzJkZWhLbzVjcVBv?=
 =?utf-8?B?M2Rwc0hib0kvaXBJdGZMcE5SNGE2bGlTUWV6ZnRQYldnWHNLbEZyOGFDVFhn?=
 =?utf-8?B?UFY3UkE0a2xOVFhVUUduZ0trakdjRXE5MFZvVU1WV3ZHTU1aVHpwUEIwWkdT?=
 =?utf-8?B?ai9hOTAxZ0VXQVdNS3dqUUNjQVM5SUt0SEFXS3p1SnNXR0FkTlkvUnEzYU45?=
 =?utf-8?B?UlNqeisxM0tvalVoYVZ4dEhTSS80NDNLVHZsQnpjN0d4SFJmU2F3bnRyTE9W?=
 =?utf-8?B?aVFxem5BZzA4RU1DUlFsUTdBT3d3RjlFVmpvZS94N3ZsM0NVRmZaUDVPWTU1?=
 =?utf-8?B?eXFuYStNUDZEMUU2dUhGOFBMdllmWnpZOHlTWURPd2E4Ny9KeXB6YVpsMnJK?=
 =?utf-8?B?MHhPMm5nSE96LzQ5RGthbmdQdkEvdGVFQ29Fbm9maVhZYi9BVGpodU9JSG0r?=
 =?utf-8?B?WGNqaXM4eEJyOTM4T3kvb3dvaUVTTkdnNzlkMlZQYnBCQzZpZzlobHA3a0pS?=
 =?utf-8?B?bFhXUEhTdkwvWjVXZVdSYy9sblJzVDhuVGROT3lSSnd5TUNYMkVuRkdnWjNQ?=
 =?utf-8?B?cSsvdHZuL1kvbXFUbGpmWXhRZDN6WS8zUXFyR0JyVWlvR0VHU0VzdEFqSFJi?=
 =?utf-8?B?MzJ1aFBtb09wUDRUM3BmaisyY2l1dTJtOUZXNEFpWmhDWnVlTVl6UDhNQVB3?=
 =?utf-8?B?NHppS3dQd2YyeHQwbGpDanZvTjF3M3hmQnp1K2NVcG1BNGVYVUdPRFZod0Fq?=
 =?utf-8?B?Y1BIRkNEQWRvN3g3Q3pTN2E3ZEJpYS9XZGVxVG9GYUlFL3NOQ0srYlhUZGVl?=
 =?utf-8?B?UlArWjBvYU8xYVExOW9hQThYbURXN0tYSGRZcDlGdnhRcEJWalJqVXZDUi9E?=
 =?utf-8?B?eDhtS3FEYktuYk5hWWxLaDU2RzVxNkZlYy92YmRoZ050UEc4OVVuaGlpUnNu?=
 =?utf-8?B?Z1YrdDFYRDhVRytPdGxBbHEwNklaalV4b214ZHhiSnI0THlhOHJoS1p3cnpq?=
 =?utf-8?B?SFdBMmtZYitNNVY4YWsyRGJoQjZRTGZKbjNkMGhBTVUrVlgxWkc3b1B4dzdS?=
 =?utf-8?B?TGlOcWtNalprd2xoMWpCUzQrbjZDMnVKbDRnbU55dVg2U2dkYzdvZ0svLzZ0?=
 =?utf-8?B?Q2FVMlFvMnRWYzZhR0o1YlhUWFA1Y2dMTjk0TWZieG9lMVZjNkxFZFdlbzNZ?=
 =?utf-8?B?TWNEdnE0TWRlR2JhZ2NnTy9US3RQMTdTaHRCZGwzKy80K0x3RTRIZFZHM25N?=
 =?utf-8?B?aVZEWjgwN2FRbm81L2o3SkIxeFBmTUZKRzNrczNuU2VLaC9lSHFIbUNLNmQ1?=
 =?utf-8?B?Y1FVcjFiMWR5UURCZTdGUFdkVkJOalNpL2lrNFkvOUJEenRzMFVyOFFvSHRY?=
 =?utf-8?B?b25OVzZ6MGpYY1cvT05pSDV2cGxHVHRveVZXYUxwNzdlNWl5M3UyZDZBc0hN?=
 =?utf-8?B?ZjNHQit5ckNxZlRZR2U2RUNSUjkwSll0SFhDTDNSL24yZjN3eWViNlJSSFhR?=
 =?utf-8?B?NE8zeHByeDVkUThlS2dDZGluZC8xK0ppYzJMWFBBMUd1UkZzUGZCUHJRNnlz?=
 =?utf-8?B?eE9EZkVTb2NHbmRwdXBFT2d2OHd5d2RzdmZxWUNMbG5JUmJyZXVTREtFTFpq?=
 =?utf-8?B?eEh4RTN4ZjZpbjVWbzI1eVcvdGxsOHg5Z0g4d3hxUkIwcnJkTFdMUnZEK2tN?=
 =?utf-8?B?RnR5UkN1anJkTlcxZ2pJTHVyRVh5RjFuWm5BR0czOUMvbU5FbkZXdy9VcVRa?=
 =?utf-8?B?aXF1cStRRzdienpYL3pFc2hpMEVVekhpNGR5RVVWZGl5MEdobWxGYzl6RjdZ?=
 =?utf-8?B?eENvY0dCaEZhYWNwV2s3MUJBZXl1RURHU2hGOCtEN0ZhY29Id0RaMlo5Yk84?=
 =?utf-8?B?VHF2S0srLythQ01ob3VYNW03UUsyZHV1azBNc1JSbER0WUFlNkV3SUVZa013?=
 =?utf-8?B?VGYrQk00MlZod3o4aGl2djFxOGFEa1hrNk91OU00cWhzQnpmd1Bva2RLdDAx?=
 =?utf-8?B?RGp2eHRTWXBLUXp2OU5FYXUwV3BNRzRkeFJ5bnpHSWN4ZFBpWnE5cW00Zm16?=
 =?utf-8?B?d2F2MGpCYTVrV3lSZjV1UmRaNnZxY01WM3h0cDh0Z3RJcXpZZFJ0OUt4TjlO?=
 =?utf-8?B?VVRkTkFUMkhFYkV4RSs5KzlWZTE2TFh4bCtybkZ1QktVLzVPV0ZHOUt6RElJ?=
 =?utf-8?Q?6dZaSHJpLiDWWU5ppUQ/uHKq5yreQqYbdnpFmLbpINir?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc143487-4ec2-4d65-e4f7-08dc0d87f94c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 00:48:03.6279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPyhmPCnDPKtsyrS0p7GWqbr5RveO+92aWiLrkaLSx87u+h7ctXZjSwU1K7K9lvshcEY1M1IcVl3WpgBaAS5i82X5U6Hahz4qcjDpnR7VlXYVuZ0kDzVanbPS717+gtY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7761

On Thu, Jan 04, 2024 at 05:36:51PM +0800, lihuisong (C) wrote:
>
>在 2024/1/4 1:53, Ionela Voinescu 写道:
>>Hi,
>>
>>On Tuesday 12 Dec 2023 at 15:26:17 (+0800), Huisong Li wrote:
>>>Many developers found that the cpu current frequency is greater than
>>>the maximum frequency of the platform, please see [1], [2] and [3].
>>>
>>>In the scenarios with high memory access pressure, the patch [1] has
>>>proved the significant latency of cpc_read() which is used to obtain
>>>delivered and reference performance counter cause an absurd frequency.
>>>The sampling interval for this counters is very critical and is expected
>>>to be equal. However, the different latency of cpc_read() has a direct
>>>impact on their sampling interval.
>>>
>>Would this [1] alternative solution work for you?
>It would work for me AFAICS.
>Because the "arch_freq_scale" is also from AMU core and constant 
>counter, and read together.
>But, from their discuss line, it seems that there are some tricky 
>points to clarify or consider.

I think the changes in [1] would work better when CPUs may be idle. With this
patch we would have to wake any core that is in idle state to read the AMU
counters. Worst case, if core 0 is trying to read the CPU frequency of all
cores, it may need to wake up all the other cores to read the AMU counters.
For systems with 128 cores or more, this could be very expensive and happen
very frequently.

AFAICS, the approach in [1] would avoid this cost.

Thanks,
Vanshi

>>
>>[1] https://lore.kernel.org/lkml/20231127160838.1403404-1-beata.michalska@arm.com/
>>
>>Thanks,
>>Ionela.
>>
>>>This patch adds a interface, cpc_read_arch_counters_on_cpu, to read
>>>delivered and reference performance counter together. According to my
>>>test[4], the discrepancy of cpu current frequency in the scenarios with
>>>high memory access pressure is lower than 0.2% by stress-ng application.
>>>
>>>[1] https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei.com/
>>>[2] https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
>>>[3] https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
>>>
>>>[4] My local test:
>>>The testing platform enable SMT and include 128 logical CPU in total,
>>>and CPU base frequency is 2.7GHz. Reading "cpuinfo_cur_freq" for each
>>>physical core on platform during the high memory access pressure from
>>>stress-ng, and the output is as follows:
>>>   0: 2699133     2: 2699942     4: 2698189     6: 2704347
>>>   8: 2704009    10: 2696277    12: 2702016    14: 2701388
>>>  16: 2700358    18: 2696741    20: 2700091    22: 2700122
>>>  24: 2701713    26: 2702025    28: 2699816    30: 2700121
>>>  32: 2700000    34: 2699788    36: 2698884    38: 2699109
>>>  40: 2704494    42: 2698350    44: 2699997    46: 2701023
>>>  48: 2703448    50: 2699501    52: 2700000    54: 2699999
>>>  56: 2702645    58: 2696923    60: 2697718    62: 2700547
>>>  64: 2700313    66: 2700000    68: 2699904    70: 2699259
>>>  72: 2699511    74: 2700644    76: 2702201    78: 2700000
>>>  80: 2700776    82: 2700364    84: 2702674    86: 2700255
>>>  88: 2699886    90: 2700359    92: 2699662    94: 2696188
>>>  96: 2705454    98: 2699260   100: 2701097   102: 2699630
>>>104: 2700463   106: 2698408   108: 2697766   110: 2701181
>>>112: 2699166   114: 2701804   116: 2701907   118: 2701973
>>>120: 2699584   122: 2700474   124: 2700768   126: 2701963
>>>
>>>Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>---
>>>  arch/arm64/kernel/topology.c | 43 ++++++++++++++++++++++++++++++++++--
>>>  drivers/acpi/cppc_acpi.c     | 22 +++++++++++++++---
>>>  include/acpi/cppc_acpi.h     |  5 +++++
>>>  3 files changed, 65 insertions(+), 5 deletions(-)
>>>
>>>diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>>>index 7d37e458e2f5..c3122154d738 100644
>>>--- a/arch/arm64/kernel/topology.c
>>>+++ b/arch/arm64/kernel/topology.c
>>>@@ -299,6 +299,11 @@ core_initcall(init_amu_fie);
>>>  #ifdef CONFIG_ACPI_CPPC_LIB
>>>  #include <acpi/cppc_acpi.h>
>>>+struct amu_counters {
>>>+	u64 corecnt;
>>>+	u64 constcnt;
>>>+};
>>>+
>>>  static void cpu_read_corecnt(void *val)
>>>  {
>>>  	/*
>>>@@ -322,8 +327,27 @@ static void cpu_read_constcnt(void *val)
>>>  		      0UL : read_constcnt();
>>>  }
>>>+static void cpu_read_amu_counters(void *data)
>>>+{
>>>+	struct amu_counters *cnt = (struct amu_counters *)data;
>>>+
>>>+	/*
>>>+	 * The running time of the this_cpu_has_cap() might have a couple of
>>>+	 * microseconds and is significantly increased to tens of microseconds.
>>>+	 * But AMU core and constant counter need to be read togeter without any
>>>+	 * time interval to reduce the calculation discrepancy using this counters.
>>>+	 */
>>>+	if (this_cpu_has_cap(ARM64_WORKAROUND_2457168)) {
>>>+		cnt->corecnt = read_corecnt();
>>>+		cnt->constcnt = 0;
>>>+	} else {
>>>+		cnt->corecnt = read_corecnt();
>>>+		cnt->constcnt = read_constcnt();
>>>+	}
>>>+}
>>>+
>>>  static inline
>>>-int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
>>>+int counters_read_on_cpu(int cpu, smp_call_func_t func, void *data)
>>>  {
>>>  	/*
>>>  	 * Abort call on counterless CPU or when interrupts are
>>>@@ -335,7 +359,7 @@ int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
>>>  	if (WARN_ON_ONCE(irqs_disabled()))
>>>  		return -EPERM;
>>>-	smp_call_function_single(cpu, func, val, 1);
>>>+	smp_call_function_single(cpu, func, data, 1);
>>>  	return 0;
>>>  }
>>>@@ -364,6 +388,21 @@ bool cpc_ffh_supported(void)
>>>  	return true;
>>>  }
>>>+int cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered, u64 *reference)
>>>+{
>>>+	struct amu_counters cnts = {0};
>>>+	int ret;
>>>+
>>>+	ret = counters_read_on_cpu(cpu, cpu_read_amu_counters, &cnts);
>>>+	if (ret)
>>>+		return ret;
>>>+
>>>+	*delivered = cnts.corecnt;
>>>+	*reference = cnts.constcnt;
>>>+
>>>+	return 0;
>>>+}
>>>+
>>>  int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
>>>  {
>>>  	int ret = -EOPNOTSUPP;
>>>diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>index 7ff269a78c20..f303fabd7cfe 100644
>>>--- a/drivers/acpi/cppc_acpi.c
>>>+++ b/drivers/acpi/cppc_acpi.c
>>>@@ -1299,6 +1299,11 @@ bool cppc_perf_ctrs_in_pcc(void)
>>>  }
>>>  EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
>>>+int __weak cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered, u64 *reference)
>>>+{
>>>+	return 0;
>>>+}
>>>+
>>>  /**
>>>   * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
>>>   * @cpunum: CPU from which to read counters.
>>>@@ -1313,7 +1318,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>>>  		*ref_perf_reg, *ctr_wrap_reg;
>>>  	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>>>  	struct cppc_pcc_data *pcc_ss_data = NULL;
>>>-	u64 delivered, reference, ref_perf, ctr_wrap_time;
>>>+	u64 delivered = 0, reference = 0;
>>>+	u64 ref_perf, ctr_wrap_time;
>>>  	int ret = 0, regs_in_pcc = 0;
>>>  	if (!cpc_desc) {
>>>@@ -1350,8 +1356,18 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>>>  		}
>>>  	}
>>>-	cpc_read(cpunum, delivered_reg, &delivered);
>>>-	cpc_read(cpunum, reference_reg, &reference);
>>>+	if (cpc_ffh_supported()) {
>>>+		ret = cpc_read_arch_counters_on_cpu(cpunum, &delivered, &reference);
>>>+		if (ret) {
>>>+			pr_debug("read arch counters failed, ret=%d.\n", ret);
>>>+			ret = 0;
>>>+		}
>>>+	}
>>>+	if (!delivered || !reference) {
>>>+		cpc_read(cpunum, delivered_reg, &delivered);
>>>+		cpc_read(cpunum, reference_reg, &reference);
>>>+	}
>>>+
>>>  	cpc_read(cpunum, ref_perf_reg, &ref_perf);
>>>  	/*
>>>diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>>>index 6126c977ece0..07d4fd82d499 100644
>>>--- a/include/acpi/cppc_acpi.h
>>>+++ b/include/acpi/cppc_acpi.h
>>>@@ -152,6 +152,7 @@ extern bool cpc_ffh_supported(void);
>>>  extern bool cpc_supported_by_cpu(void);
>>>  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>>>  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>>>+extern int cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered, u64 *reference);
>>>  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>>>  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>>>  extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
>>>@@ -209,6 +210,10 @@ static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>>>  {
>>>  	return -ENOTSUPP;
>>>  }
>>>+static inline int cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered, u64 *reference)
>>>+{
>>>+	return -EOPNOTSUPP;
>>>+}
>>>  static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>  {
>>>  	return -ENOTSUPP;
>>>-- 
>>>2.33.0
>>>
>>.
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

