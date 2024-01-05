Return-Path: <linux-kernel+bounces-17571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06278824F7F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC861F2294E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB920338;
	Fri,  5 Jan 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3ismFYYL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C6120310
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6JD+FOfaCnMyfNIq2VirXuxp4QSiYZW5P/xxOVetfFN5Nfx+uWNValeT009h/BZ2Sx+jsf5dviinDGVVAp+uiH3mqp5LovkxCuuRv0F3B/k395cW/VdmFQJ/+8ehrabDVYJ3pxG0UYPyV8OiLu33+wgBe0kQKzIa1a9PNFRlq3r4pHiqtj2VB9qtxkVzonBWEsIjRWIY4RusN+Mum/K2nAidw6Z94UnqPNliP3AuNzf8Cade5aX8R2Ut9TNbiYRq1iv2DzKf/X8svABq30TWgcuOAVGhzGpX423I49MeFPVUl7sabDAf4NpGoPSk1A5nvQ4+n2zhtWJvc4pLaVaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7q7/fxCt7v5+44uSzIt82Al53/r2GxODBBASIP4y8wM=;
 b=I3ctnl5i9WCREBoKoxelT0uXL3q5+HfWTd3tTTPo3ZagRS3XsXaUyVo7meLod4eL4xccmHnBLhpaQx+yvpLfu+H4WA4iVGiHJAsObiMOXsw/jRU+eC9j6UgugPPRvkrwVqTT38wc8g3foj/6svzlE2Jr3ek/cfPUyjnGcrsSQULx7jvecvR51yfQyoymKCPruYDxvAXUJiGjKRpb+IraDVIPZ7d71to8f6OtAoQfrjySAqfYjwLQTbMDfAJ4sXSlV9gMBUBFAxqfsyGHq0uPiY7jlmI61J1QF3tbW9+13G5BjJvu9WjkwG9115u6IJiD7GT+jkUI/6Z1FDpwMUJf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q7/fxCt7v5+44uSzIt82Al53/r2GxODBBASIP4y8wM=;
 b=3ismFYYL1Zsgr8BihngAUWAFvihBy3YL+ePtB8tyMU8pIUfolCYT4oZXih5YxDou5Kfkx0ZkURJ2zhZOj8KRd957P2bVvCqXa302pTgYD75Z5wi/t416n6eHWbWcaT3jKWmyRGMIyUeZ1ZEkvzTEWqtvZpIj0uleFPLVjehZMr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 08:10:51 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::f630:ed7b:bbd9:1d56]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::f630:ed7b:bbd9:1d56%3]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 08:10:51 +0000
Message-ID: <f515b323-a932-41c9-8d06-5310c8eea248@amd.com>
Date: Fri, 5 Jan 2024 13:40:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: arch/x86/events/amd/uncore.c:941:52: error: '%d' directive output
 may be truncated writing between 1 and 10 bytes into a region of size 8
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
References: <202401051554.teOdw8yt-lkp@intel.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <202401051554.teOdw8yt-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::21) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|BL1PR12MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: 365215aa-7337-48a1-31ff-08dc0dc5d504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vwVgZJ1P45LpifVQ+OvhsK2/Ky6lVucs0cCBJyO6XmKD5+X1V5TkLaA6FWjBXfNmv7gkJPUTKb1/WC/490jX2UY0aqIEAEsBsXqksfnl0XgIRhNjTzxepivMp5c54JyYDi3MGg0N4bGozmAWtWe9IYB8uPQwlc5AVq0AIb6IJFSK7CmQeM/UygWVdCxgZl4FrYRtG/5p7Y1n2CLZU/BeV7XpIxIvjFFsX3gpnbzLS+PToAEQFl0PuGEqstM599Vclw1rNfpJAosqIi03O0D9xnujW9Wq1IHaAv20wN1fy6m/VQIoSxM9/Sr956hh+Je5OGh+8S7JZA1vR7jRp5aiN1UHzcu0sz3rdYcUmxJfROzR38LiHyXNRdkYKiqnvRCsO+uKoY027fI4szVAYFlEvRmvbIUq4djfq/UeokxFCKzRwzC2YzdS29JnWWuHLImPNtHpx0byxpkGfElbaW9jT4j3hp522RyVQiE7wlmsl7b0OGe+RpVRAUOC3rhcvYPL3rM/ZwE3SuYRQ6Og0cWWLx7FUP8Vn8Ga+rB53+kI/M6sc8YnQC+leL6vVIXy5cq/mZcgH3y8eos/zW3D+KjKo2OUj3IyRmZE1Ztu3QBQvymv+/hH6gc/u82D5Aw6jBi9pRvs/kCXxiewyS1VX6etmOJh/UHRMvlyVMgbzQqOqtU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(31686004)(86362001)(478600001)(966005)(6512007)(53546011)(41300700001)(6666004)(6506007)(31696002)(44832011)(2616005)(5660300002)(2906002)(6486002)(316002)(6916009)(36756003)(66556008)(66476007)(66946007)(8676002)(8936002)(4326008)(38100700002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OC9DRU10cEJVNkFrSWd2SmV2M0kwU3lTNnBQdis5c0tSSzdPVVdkZVdMQmNT?=
 =?utf-8?B?NXRRYy9JZHA5QjdBZXBtazNDdFZydHdOM1lLZEZtSCtqVmsxaDRxcmo2dkk1?=
 =?utf-8?B?NXQvRzBUVGFLWlZvb2MxV0U2MEtrZzZJSzdIUGpWV0dTZzA0Tnk4SHd4Q1RD?=
 =?utf-8?B?UVQ4bExHWWtQSGZDcTFOVW93VFJodUV3bGxJWFZ4Y1JObWRwT0pwSE5mbGor?=
 =?utf-8?B?SEo2eHRjVjRBVTZkOCtaVk5NcEwrbkhhb2R6NnpjZU1lcUdNWG90TGNuOXY5?=
 =?utf-8?B?ZGoxNks3MHE4bGZ3dktOSTlYY3ZENmhJT0dNa1hKQllrVFQ5eWYvVlBCUWpR?=
 =?utf-8?B?eVRGOFJOWWw0cWlNbUI0QWk5OHJBM0tzVDQ0czJ6bFllMmdjR3l1b3J4Qmxh?=
 =?utf-8?B?cURsL2dIT0ZXelVwYm45ZkhoMjJDNFl3enNad3ZocEIxTlVlUnQrTmI3Z0tu?=
 =?utf-8?B?dklBWWFpSGg5a2dXcHpIOExnQmZYUHRnR1pqSVAxV3YxanJlU0R4OWpmcGg5?=
 =?utf-8?B?MEIxM2YyUmkrZllOWFN5OFFGYThJSUZVYzR0c3daalVabnVUM1hPMTA1Vm9K?=
 =?utf-8?B?bGlTNVBYTm41MUNjQmh2cEd2Sm91ZlRpcnpTdjZvcENidFlWQVBIYjltWklh?=
 =?utf-8?B?bmxBSzFVbEJ6c3VaVXZsVFF3ZWZoYkhiN2xjOE5GeXpJd0l2WFdzOWhaSjVm?=
 =?utf-8?B?K3NVbm9WbGtlbUpYd1o5S2NVVENoazl3a3RlV3phdG9nZmR1MTRzaHVlZFl1?=
 =?utf-8?B?dE9sRXR2YmRaMVZLMUpWOE92TjgyejZuUmlXUDIzRUh3eDA5UDhVemltLzAx?=
 =?utf-8?B?c3huNWc1U2JESnRmWnRPQUdqY21wejdFUDRwTjZGcVlEWHM3YTVOa2k4UENt?=
 =?utf-8?B?R1I5Y3hUclpTUTM4Rkp3L0luSVJUSjZvVnpDcld5Y1E4Y1NKcjM5QW1nTUdm?=
 =?utf-8?B?WEVqRVN0YkRjUW0vYUxYeUx4SEJZcmg5STBnb1BOajYwdENsR3AyNGtyenZB?=
 =?utf-8?B?V0QrTWl1bGhXZHhVUUk0UHdBNDlKQTFRQXp4dkhmMEhzRFhubktnZXJoellU?=
 =?utf-8?B?M1d5cG5rUENVdUdWc05ubWkrWGxmUjJKYzg1dldFdjREd05XS3VlejFiYnNE?=
 =?utf-8?B?elczY3pZd1NvTlVmRDUxc2V6d1lDaEVSVDFQclBZR2FpMVI3bDFRSlFmQ0tm?=
 =?utf-8?B?VXZVTzRFMGoyM0F6WEYzVjBZWmk0bTFYMzVHYTdJM1NMOTRlZnc3Rjd5b0hu?=
 =?utf-8?B?cEVTdjl0MXdHTmtrSmM4aGR2d3RJbE1HRnFsODd0cFJPaDhXQUwrWGlhc1Ft?=
 =?utf-8?B?NkdadmZVZVdjYW9WVnZkTyswV3VZYjZFZ01zcERiQTZ4RCtIdWZNbm9uMXNP?=
 =?utf-8?B?OW4zYmJVc2s4QUEvRGZDQ2tCWW9RbW9YYk1jOVpwTy9QY0xUNVhIQnJxOWZQ?=
 =?utf-8?B?cnFudld2cnZaOFdwNlpaNy9EdktIUzRXWVY2OFVHSlZ2K2RPU2lSTElqQ3pW?=
 =?utf-8?B?U01PVldwSHFKWi82MzFyemJucTYvSXM4NThyQk84V21yc0dKdFBFSUNBOWI5?=
 =?utf-8?B?LysvbGc3SVhUajJwOWcvRkFEME5UMlFBSGFOSnRZLzdDVzVLdld5Sk9xcVBz?=
 =?utf-8?B?bE56ejl3cytLRzFrVHpsZ3BoR2RqZW5UY1lwM0JhUEdGeEd6QVV0dXdtbGo0?=
 =?utf-8?B?bWd1Y2xTTnpUN2laTGZiN3JSd0FvYmhnaE1GZHJyYnd1cmFFbFphNzNjc2dI?=
 =?utf-8?B?blFMUVdwR05ZSmpNMFdOWFVCSXg3L0ozN1hiNUV5VU1FOWpuakV2elZpN2FF?=
 =?utf-8?B?N3VWMTlLOUR1alNHZjBheXBnb2hxanFIWGVETURQQ1EzT0ZkRmFYcDFpWFhz?=
 =?utf-8?B?elNETjVRR2VKTVFUYkl5VTlwNHhFWnIxRzg4ckUzV2s4T3BKU1lmei9pWitI?=
 =?utf-8?B?SjRKcU0vdVJGemVMakN1YjgzcHJEclgvdUtkRzh2VFBQb1E3UHEyTDJSUTc5?=
 =?utf-8?B?WkJ1Qkx3UHlPOE0zdytZWkJ3SUdvak8vOUJXcDhnVGJLZHNWeW8vVE9KeTBD?=
 =?utf-8?B?OExDQzEzYzN4SE9RelRnT1hGck0rY0ltQit5M0Z0aEV1MFJWcll2K0pwcTNL?=
 =?utf-8?Q?+JSeGDJoDqkaeXd1Fr00iTr98?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365215aa-7337-48a1-31ff-08dc0dc5d504
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 08:10:51.6791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RywVsfptkGKgqn4EXbTsDKjKpD2nujw3qNGmrOhtaMubxXyVJW0S1DZaviruPX4N+ErOezr60Lw8UImJ6NF+Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190

Hi,

On 1/5/2024 1:20 PM, kernel test robot wrote:
> Hi Sandipan,
> 
> FYI, the error/warning still remains.
> 

The active UMCs in a socket are represented by a 32 bit mask coming from CPUID 0x80000022 ECX.
Since there are at most 2 sockets in a system, the maximum number of UMCs will not exceed 64.
This fits in pmu->name. While there may be SKUs in the future having more UMCs, the number is
not expected to be larger than a 7 digit integer.

- Sandipan

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1f874787ed9a2d78ed59cb21d0d90ac0178eceb0
> commit: 25e56847821f7375bdee7dae1027c7917d07ce4b perf/x86/amd/uncore: Add memory controller support
> date:   3 months ago
> config: x86_64-sof-customedconfig-avs-defconfig (https://download.01.org/0day-ci/archive/20240105/202401051554.teOdw8yt-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240105/202401051554.teOdw8yt-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401051554.teOdw8yt-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    arch/x86/events/amd/uncore.c: In function 'amd_uncore_umc_ctx_init':
>>> arch/x86/events/amd/uncore.c:941:52: error: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 8 [-Werror=format-truncation=]
>        snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
>                                                        ^~
>    arch/x86/events/amd/uncore.c:941:43: note: directive argument in the range [0, 2147483647]
>        snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
>                                               ^~~~~~~~~~~~
>    arch/x86/events/amd/uncore.c:941:4: note: 'snprintf' output between 10 and 19 bytes into a destination of size 16
>        snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> 
> vim +941 arch/x86/events/amd/uncore.c
> 
>    900	
>    901	static
>    902	int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
>    903	{
>    904		DECLARE_BITMAP(gmask, UNCORE_GROUP_MAX) = { 0 };
>    905		u8 group_num_pmus[UNCORE_GROUP_MAX] = { 0 };
>    906		u8 group_num_pmcs[UNCORE_GROUP_MAX] = { 0 };
>    907		union amd_uncore_info info;
>    908		struct amd_uncore_pmu *pmu;
>    909		int index = 0, gid, i;
>    910	
>    911		if (pmu_version < 2)
>    912			return 0;
>    913	
>    914		/* Run just once */
>    915		if (uncore->init_done)
>    916			return amd_uncore_ctx_init(uncore, cpu);
>    917	
>    918		/* Find unique groups */
>    919		for_each_online_cpu(i) {
>    920			info = *per_cpu_ptr(uncore->info, i);
>    921			gid = info.split.gid;
>    922			if (test_bit(gid, gmask))
>    923				continue;
>    924	
>    925			__set_bit(gid, gmask);
>    926			group_num_pmus[gid] = hweight32(info.split.aux_data);
>    927			group_num_pmcs[gid] = info.split.num_pmcs;
>    928			uncore->num_pmus += group_num_pmus[gid];
>    929		}
>    930	
>    931		uncore->pmus = kzalloc(sizeof(*uncore->pmus) * uncore->num_pmus,
>    932				       GFP_KERNEL);
>    933		if (!uncore->pmus) {
>    934			uncore->num_pmus = 0;
>    935			goto done;
>    936		}
>    937	
>    938		for_each_set_bit(gid, gmask, UNCORE_GROUP_MAX) {
>    939			for (i = 0; i < group_num_pmus[gid]; i++) {
>    940				pmu = &uncore->pmus[index];
>  > 941				snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
>    942				pmu->num_counters = group_num_pmcs[gid] / group_num_pmus[gid];
>    943				pmu->msr_base = MSR_F19H_UMC_PERF_CTL + i * pmu->num_counters * 2;
>    944				pmu->rdpmc_base = -1;
>    945				pmu->group = gid;
>    946	
>    947				pmu->ctx = alloc_percpu(struct amd_uncore_ctx *);
>    948				if (!pmu->ctx)
>    949					goto done;
>    950	
>    951				pmu->pmu = (struct pmu) {
>    952					.task_ctx_nr	= perf_invalid_context,
>    953					.attr_groups	= amd_uncore_umc_attr_groups,
>    954					.name		= pmu->name,
>    955					.event_init	= amd_uncore_umc_event_init,
>    956					.add		= amd_uncore_add,
>    957					.del		= amd_uncore_del,
>    958					.start		= amd_uncore_umc_start,
>    959					.stop		= amd_uncore_stop,
>    960					.read		= amd_uncore_read,
>    961					.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
>    962					.module		= THIS_MODULE,
>    963				};
>    964	
>    965				if (perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1)) {
>    966					free_percpu(pmu->ctx);
>    967					pmu->ctx = NULL;
>    968					goto done;
>    969				}
>    970	
>    971				pr_info("%d %s counters detected\n", pmu->num_counters,
>    972					pmu->pmu.name);
>    973	
>    974				index++;
>    975			}
>    976		}
>    977	
>    978	done:
>    979		uncore->num_pmus = index;
>    980		uncore->init_done = true;
>    981	
>    982		return amd_uncore_ctx_init(uncore, cpu);
>    983	}
>    984	
> 


