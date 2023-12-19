Return-Path: <linux-kernel+bounces-4862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ABB818309
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC6C284CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADCD101EB;
	Tue, 19 Dec 2023 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BsFlSoAd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73F7125B1;
	Tue, 19 Dec 2023 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9ZUDYfYS7XWYU0C1lPI+GNN4e0CjnugM2MLLTGIdQi+VTmJGIYYIpamnl1cDTMVPcYF0um4LRKsoG5uFLNnfHEZzXYrI0yZBSJVt291J/6ryBjTYyFXn9rj02gLr49VBJdXHbwaT8W+oCnGhvSpZZdMlsv9jnDOtgbV8NnLxgGchWfN9QqGyDLvhjDHummFf+aUnq9J12tVOgAuyKhCVvbd2bORePPyTTu5WwfDuD1CBeqAWsPhMvmkpth4LmcDZjYIRWEUa7E8mh8KAzatR6q5uJIOftN7a+tOIIH1pdcf4As1fZ5EJURISPXpcMrNrMg+3+Piz/49m1Q+JfeQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHSq8d2x/4ETEzH7zMUxvTwEb1rgi1X2GwLcco9+zvA=;
 b=ioD95gxgmSJC+Z26R/15bFs10ul4Mu0jkd8CRyrV630X4lqyEGkq3PFphxnZLGuff0p/iffkmg1k1OLen2sn7OAjdlntgMEcP6ZDjiy2lE6q51pmT6W6gygA/2MmG2YS2iZELxRgpqNw8PjGSnHIjk/+g0qoQdIY/WOwUEeo/FenYvoTec5HnPuUFZLjSAotslKRPTIOm/1zxLfbjwwuEkK/zt7O7ChQy9ZZfVo0AQ5a//aEsEhmWnlwv52WeWErWHtcIilLA3E+CjNjrMq+tDhQPuRl8lAJHs9Vt6kBAhVrXMH4G5wQuSROjzZ5h12l6/SMbKinAFhUqupsxkB8xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHSq8d2x/4ETEzH7zMUxvTwEb1rgi1X2GwLcco9+zvA=;
 b=BsFlSoAdnjw3YiE2aF4/2N5fa4brXrWnvSqLpuxT6vDSyitpuemhmw7LJWf0ZfEsZZ4vvyb719AmcGcmRvJyPat0YYmp0uTS5zVSn0hqjMXbH6Yjy8AanZNgr2/mybVHz/KNoKoABSNglJ47+YiSLweMWW2dj15/xuQTp6+9Mfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 08:07:30 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::f2fc:3e18:9e90:d060]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::f2fc:3e18:9e90:d060%5]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 08:07:30 +0000
Message-ID: <05bc5720-d066-42fe-a3f9-d933a88e5935@amd.com>
Date: Tue, 19 Dec 2023 13:38:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf/x86/amd/lbr: Use freeze based on availability
To: Stephane Eranian <eranian@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 namhyung@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
 bp@alien8.de, irogers@google.com, mario.limonciello@amd.com,
 ravi.bangoria@amd.com, ananth.narayan@amd.com
References: <cover.1702833179.git.sandipan.das@amd.com>
 <1d9106579c7781746ca39860bda8061c56d6dc48.1702833179.git.sandipan.das@amd.com>
 <CABPqkBQ0Zn_orR_9FnHA7Y1pNHAzG0E=86MkdMjOtGfKXDp29g@mail.gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CABPqkBQ0Zn_orR_9FnHA7Y1pNHAzG0E=86MkdMjOtGfKXDp29g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0197.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::6) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 78df9e48-c0e4-4714-e327-08dc00698c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qiNbXSZX2RiMl9uLWB8AWov2RT6/6jHgoUSJ69OmCVjCicU/2qFFoQ7Ic8ikopkXE1tRXlwGHk5vZ3s68rh7OZLkrFtYAvOD9Ca9a2Oswr9AiGuIuXOS6qyZ4n6Yrx4lm8Np229rmuWht+Hy8dusO6+fkjQ7yo6rjR91cvE+xkbqvPjSWwSMDOcWFlMaLbDr6TKY3D6E52kEBXlKYorTUvqlL0Bb7sE6t6/EeOFLbZg45X31BRe23z2ZAs4sAG+Lnp0cZ142oBJnbSA9hZpHSsm++Sm7oa6Tn+AQyI11PkQVlX/SBKLOfQC7VeaBFB+KqC8MeP7hf/xbHgApjET7grlf2juJ1ZceJwELNs58IgyepsADG/qQ6kE1mYiycpNzhZqOQC+LiNKb9BErye9otxfdpXUzYtKseqPITqDDhcurIL/XgbuewICN4uGZsuaEf/3aY0mdoQ27qZUlBB0FWdGzTRbJm86GT5yhsNJLmDwhALJWOsBgV7RTMWupFOgLSYCcKWyrq/bCHVdSnXdVIfjyqMDNg8ll+pHB3mX+gksXzhI23W1OiEWlJvg1AFYmiRXKzS8pOEe/psQnvcMUPspByaeeqBMgFCPIPxON9HIhNS0oGAjoawdVyNWzzx/Fv6sl8iyuTSbCvuR5IEoGrg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(6666004)(2616005)(26005)(36756003)(38100700002)(31696002)(86362001)(83380400001)(44832011)(5660300002)(6512007)(6506007)(53546011)(4326008)(66946007)(8936002)(8676002)(66556008)(316002)(6916009)(6486002)(66476007)(7416002)(41300700001)(2906002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkVva2QrWU8wbXFvU0dHWll4NzdqeWhLaHRDTnRpSkk1aTJoNml6cGxFMjVE?=
 =?utf-8?B?TGU3Q2FPOHJCQlBIRGZDc2s2eDJ4aGdnbW5PL3A1MEd4bGd1RUlSS2ZuSFEw?=
 =?utf-8?B?MDg4YTFZT2NYOWFYbEpxVnY2VFhMSm5VV2VxSkxhL1hGL05Rd0RuaHhLcjAw?=
 =?utf-8?B?NTRDemlQT1VhcnAyUTJHZWNiZHkyVHZVaFZwRG1Mai9Fd1NXV0xCeXB2Q1Ri?=
 =?utf-8?B?dnZmYVBYWGlHOC92a2VhdU1uNTdjWWV5ZENRK3hxOXV2RUFwLzRkV3BucEJY?=
 =?utf-8?B?QzlXNUxIcHQxUm5jZFJrN1h5RkRZZlNQODJIUmgzcHFkNm83T04rZjUzTjNK?=
 =?utf-8?B?cmpVQ2Q0V3ZlUlE5UlJHelFoSk96VGlKT3ZTU2J2Z01Ka09hZkdUaTR3ZFZ4?=
 =?utf-8?B?dVpHSzNrNlV3WWNOWHdDeTFHWmphdkZFRFNJL2Fjcmw3NHRnVkFPQWxCNlh0?=
 =?utf-8?B?MWNZSEl2aDZFTFdNZzJjaFhzSU5iRXFrc0hONGkwTnRDQ2NPWWJUQ2tSMTN1?=
 =?utf-8?B?bkxMOGZoVWwxNUplS0ZVUDAybmtHWjNlZlpNMzI5cmxCVG8wcng2RXJGUnpM?=
 =?utf-8?B?RGNUYTdRRnhvLytyY2Eyb2g3aThBUXFxZk1lbnl6dWJ1R3QwYmE2TWdXbHZj?=
 =?utf-8?B?aUtPMnN2bzM1NitKSWk5YktndVBSVklCK1F3ais3VldURTI0KzF5cTdXZTlF?=
 =?utf-8?B?U2NQNTdSMmdMVTlqc2FYVzlxbXpEZHpJM1c4dmxvZGRmcHk4SDUwcjU1YjJZ?=
 =?utf-8?B?K08rTHc5eG8rVldXUG1uaVZNNkJxZjFVZlhvekxzRThGUW1vc1lUSytjeVBI?=
 =?utf-8?B?NHNyMW5QakFhWTFKSjlHSU10SE5yc3UyQ1NuRHNvNVBJZmdMc1R1TzJVZUhq?=
 =?utf-8?B?cjdzcHVtSE5rWm5jMURiUWFJTUF1OCtHbUF4MnJ1Z28xaWZhemEwdk9OWjJU?=
 =?utf-8?B?VHpGY05Qck43SzhTZ1hnc0swVzVWMzF0NTJxSXo4N3FDMUhMOHRjV2lDdnow?=
 =?utf-8?B?aHR1UEtlc2VrVEJRcjYxNFpMVGx6NlQwdGIvemtJYStEWjg4TzhSWmx2QWF6?=
 =?utf-8?B?OEJqR0ZWRnUwT0JtRXVucEJsQ1c3WVROLzdNVkd5bUNVRW5heEtTU21FZHpG?=
 =?utf-8?B?MlJlTGtkQklnQzBGc3pBdWE3NmJwQUlOenBMb0ZjTjAxbk4wZmFSUmUrZkNt?=
 =?utf-8?B?QXI3NTJDTW0wVkgxYTd0b0JQRzRGczVmajJSQlVzVFpFUG9scm9tTzJNQXUy?=
 =?utf-8?B?cWZsTnd0TGJqWkdtcEtzYURHTVlveWdjbHZiS1JodzZyQjNUcUxIUkFmdDdM?=
 =?utf-8?B?dTRWeHgvZ0JWanQwRC9CRkdiSWRHTTllQVMvRFpka1hnYitVLzczaTY5dFlR?=
 =?utf-8?B?RktJeWV0Y0NmWjExc09POE1tT0JuQURLcUh5RDNseGlMTkVGZkVQdDdWaWdt?=
 =?utf-8?B?VWtJaU5XMURKYUtjTkkvWERXVm1FR3BKVGZpTGtjRnlldzNHM1pYMm9QR3ZF?=
 =?utf-8?B?d3JXR2RpZTVEeDJaUk1MRVpDdklqRG1pbFlHeGZyVHUrTUlGYVRxeDE0QWY5?=
 =?utf-8?B?N3kzTEFPbnMrU1NuNG9DNVFzV3Rpc1U5UDdSQjBWN3BKVWJuMkJaTkxZaG5G?=
 =?utf-8?B?dURtRy83V1greldJajFERSswOTIrclVHZGg5RGJ4MHNzaCs1WXFIVlJzYStE?=
 =?utf-8?B?UlcwYkZ6M1RSaS95ZFlaVkFjOVIzdTNOWFpqL3Myc0UwZkFKaEpVYjdnT0JL?=
 =?utf-8?B?UnVDZGxTZ2ZiT1lyU0tGWHE5c2xtN3VmVFlGczBoVnJJeVNpR0lqOFo4WHUv?=
 =?utf-8?B?bHRzVnR1S3ByZnVLWEo4c2cvcnMvQXZGVEpsSTZWaXFtSnViZTc0Rm5YODlo?=
 =?utf-8?B?OFpqT25POFZNNnBCU1VYRDhnaW9WUHQ0ZlgwVTJzQk1xT1l2RUpTaFBoYklX?=
 =?utf-8?B?YmhGY0wxd1ZpMVl3OGd6OURhZm45U2dWMWFtdTl1ZkVad2oxUU1taGYveXRT?=
 =?utf-8?B?eTMvQTlCd3JJN0RRRWJMSkh3alJCT0FVckVsRjZVYWZvcXFXVkxYZ0orRUhT?=
 =?utf-8?B?cUJPdGdFc2dDZFJ0VWR3NUQ0VXJzaXdJeHhJTFZFOUxmRmhDeDNxcUMySzlv?=
 =?utf-8?Q?3yMNEt6KIpP9L0vC/5QE3dNla?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78df9e48-c0e4-4714-e327-08dc00698c02
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 08:07:30.2073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVNV2DGF/VwmbH8g5Gve9u8dpoiLP+k9KJJt9WPUcpJ7fHc+/LLU+4b0k2c5xbRyIyv8pky04Z6yKeVoe/+KnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546

On 12/19/2023 2:13 AM, Stephane Eranian wrote:
> On Sun, Dec 17, 2023 at 9:26 AM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> Currently, it is assumed that LBR Freeze is supported on all processors
>> which have CPUID leaf 0x80000022[EAX] bit 1 set. This is incorrect as
>> the feature availability is additionally dependent on CPUID leaf
>> 0x80000022[EAX] bit 2 being set which may not be set for all Zen 4
>> processors. Define a new feature bit for LBR and PMC freeze and set the
>> freeze enable bit (FLBRI) in DebugCtl (MSR 0x1d9) conditionally.
> 
> 
> Is this new feature bit visible to users?
> I think it is useful to know whether or not LBR freeze is supported.
> Imagine I want to do kernel FDO, then the user-only LBR trick to freeze LBR
> does not work and I need actual LBR freeze support.
> 
> Thanks.
> 

Agreed. Will make it a visible flag in /proc/cpuinfo.

- Sandipan

>> It should still be possible to use LBR without freeze for profile-guided
>> optimization of user programs by using an user-only branch filter during
>> profiling. When the user-only filter is enabled, branches are no longer
>> recorded after the transition to CPL 0 upon PMI arrival. When branch
>> entries are read in the PMI handler, the branch stack does not change.
>>
>> E.g.
>>
>>   $ perf record -j any,u -e ex_ret_brn_tkn ./workload
>>
>> Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  arch/x86/events/amd/core.c         |  4 ++--
>>  arch/x86/events/amd/lbr.c          | 16 ++++++++++------
>>  arch/x86/include/asm/cpufeatures.h |  2 +-
>>  arch/x86/kernel/cpu/scattered.c    |  1 +
>>  4 files changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>> index 4ee6390b45c9..ffdfaee08b08 100644
>> --- a/arch/x86/events/amd/core.c
>> +++ b/arch/x86/events/amd/core.c
>> @@ -905,8 +905,8 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>>         if (!status)
>>                 goto done;
>>
>> -       /* Read branch records before unfreezing */
>> -       if (status & GLOBAL_STATUS_LBRS_FROZEN) {
>> +       /* Read branch records */
>> +       if (x86_pmu.lbr_nr) {
>>                 amd_pmu_lbr_read();
>>                 status &= ~GLOBAL_STATUS_LBRS_FROZEN;
>>         }
>> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
>> index eb31f850841a..110e34c59643 100644
>> --- a/arch/x86/events/amd/lbr.c
>> +++ b/arch/x86/events/amd/lbr.c
>> @@ -400,10 +400,12 @@ void amd_pmu_lbr_enable_all(void)
>>                 wrmsrl(MSR_AMD64_LBR_SELECT, lbr_select);
>>         }
>>
>> -       rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
>> -       rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
>> +       if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
>> +               rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
>> +               wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
>> +       }
>>
>> -       wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
>> +       rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
>>         wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg | DBG_EXTN_CFG_LBRV2EN);
>>  }
>>
>> @@ -416,10 +418,12 @@ void amd_pmu_lbr_disable_all(void)
>>                 return;
>>
>>         rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
>> -       rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
>> -
>>         wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
>> -       wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
>> +
>> +       if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
>> +               rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
>> +               wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
>> +       }
>>  }
>>
>>  __init int amd_pmu_lbr_init(void)
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index 4af140cf5719..9790e906d5e5 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -97,7 +97,7 @@
>>  #define X86_FEATURE_SYSENTER32         ( 3*32+15) /* "" sysenter in IA32 userspace */
>>  #define X86_FEATURE_REP_GOOD           ( 3*32+16) /* REP microcode works well */
>>  #define X86_FEATURE_AMD_LBR_V2         ( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
>> -/* FREE, was #define X86_FEATURE_LFENCE_RDTSC          ( 3*32+18) "" LFENCE synchronizes RDTSC */
>> +#define X86_FEATURE_AMD_LBR_PMC_FREEZE ( 3*32+18) /* "" AMD LBR and PMC Freeze */
>>  #define X86_FEATURE_ACC_POWER          ( 3*32+19) /* AMD Accumulated Power Mechanism */
>>  #define X86_FEATURE_NOPL               ( 3*32+20) /* The NOPL (0F 1F) instructions */
>>  #define X86_FEATURE_ALWAYS             ( 3*32+21) /* "" Always-present feature */
>> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
>> index 0dad49a09b7a..a515328d9d7d 100644
>> --- a/arch/x86/kernel/cpu/scattered.c
>> +++ b/arch/x86/kernel/cpu/scattered.c
>> @@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>>         { X86_FEATURE_BMEC,             CPUID_EBX,  3, 0x80000020, 0 },
>>         { X86_FEATURE_PERFMON_V2,       CPUID_EAX,  0, 0x80000022, 0 },
>>         { X86_FEATURE_AMD_LBR_V2,       CPUID_EAX,  1, 0x80000022, 0 },
>> +       { X86_FEATURE_AMD_LBR_PMC_FREEZE,       CPUID_EAX,  2, 0x80000022, 0 },
>>         { 0, 0, 0, 0, 0 }
>>  };
>>
>> --
>> 2.34.1
>>


