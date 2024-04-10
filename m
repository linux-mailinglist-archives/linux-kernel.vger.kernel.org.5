Return-Path: <linux-kernel+bounces-139441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A678A0365
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4AAE1F22100
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A15B26ADE;
	Wed, 10 Apr 2024 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EM9E9wsn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0EB1E535;
	Wed, 10 Apr 2024 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788264; cv=fail; b=dRdWztfGeJRvnxiCZ6wt+Bodmd9Do/rpID+JY1fr1vnj9UUKHbtdn2i1+esXbs66I/puSVKxeRm00Chw0Ga986Zm0GJE0Wyw0dZZx6Lpy27GgxfApmfG8ZVyQcaB9+AcF5OTMeNhQm8JDcAnFpRMQXioL5Uv1tYhNQ7Umq9uuVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788264; c=relaxed/simple;
	bh=7XhiIXzmhYaJ6CgfZAGwNUyaVNbdVmaJMFmJPEs3wLQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pznaEqilxmX626v7qctZqUcLVLylM6IvhJwqPzGQn5F6Ee3BMfGhHPxh8wKibmzv+dalyKavMvSAnsNiV0YCL8+GbD1ewzGGDFK5x3NFV7C23bSMZUqh7dKxofFUoTuJ+c3x4PDRwHlnZmL1u+6Om6A+qd+HipFMCfgcL1wnddI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EM9E9wsn; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712788263; x=1744324263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7XhiIXzmhYaJ6CgfZAGwNUyaVNbdVmaJMFmJPEs3wLQ=;
  b=EM9E9wsndKK/a4CtUaeDmzwHW1SKtnWL6AZJMaFe+pAfvjYrJAnzQqvd
   eFzGHQmIalcYAENU/SGkOkAn/Y8nEJZ22ZOol/lGkChal58yjYsAstMIl
   deWQ9ZarRFqN7c6RyP5TglWAmwRp0quxfHrBr8wfepXG88cBMzGG6D3rZ
   foUrv5fkSJalo8vepXYsNTGzU54TAfXtHB2V3bxgnxjvHJt4L0j/UpCTM
   TXIw5In5PWlumg58WJbFvg0MCDGgbICyOwGuaNjApTMCcfQG6tSJCfbda
   mBfQ4e+v29Ewz5+o5naghIz20C/qHFh2JH4rFCirBtnisCgHQ0L9hfJeN
   Q==;
X-CSE-ConnectionGUID: JHyfDhpFShO5ZS4O00E99Q==
X-CSE-MsgGUID: 03CmltPmQqOuugXFmxm/CQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19571551"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="19571551"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 15:30:59 -0700
X-CSE-ConnectionGUID: 4OjEnG11TEOuzW7prnRhxg==
X-CSE-MsgGUID: sWGHmA2PSVO9XM9Vuwvb1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20741485"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 15:30:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 15:30:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 15:30:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 15:30:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjpF+FGR6K+oE0Cz4CMVXCid4LfsspGoqJrupzBh37h8Hoa/3pKzfoSbaVNBoCGAwpTNSbeVhEs/GTKxaG/BNmJraGKz63Gqgk7mIaLZ4Xj2wwGt4utjL13K5rDpx53fWIHv3D5juUHonOgc+cd475QrdbzQSpXoQ4gwcOVojCJnA2WrSoS/FeDrjQAGUt93rH406izMNt+s5YnRE7NclGqTGNrv9w01O7D5ftZ0if2WPrBTX85px70CrFyzmcc7seSm/+FwjIG8XfVGxJ042wTRA31PwF/TokozPqqIU+yF1hdvc6aPN2e6vLFW+kgJ8OdLogChvCmua6IOWD3dSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWMfip+6onqIC1xpQOdXIHUDj/HL/r6NOizC7Yjfbr0=;
 b=M4L57iwJE3PvUaUKY2vp+aIPYjFOuaEtYJYKn5I06KWMydxXYxGvdat8RqX7x5Wb10BPo0FLXgMnJ6inBFdAkj++aV6vBgxJWaGBFS1FeCFkyYdJRg8LlA7XDAcAVf708dyft/GKZ+2RU2YSoRfm3X6HEXA4CK+KS17IGs+ykKZavtRCgmzxV+gAtU7SswFCTIaTx9WuMtL6xgDHkmLez93NgNo+FULUcXdm6TMCYKfHoG6Fl5bfBJJ8BFj8our2gsFllQREO3RTNip9lcXg1/ggsSrwzjq/aGNVJX/OCvfMFQhpdX52X2Ihlzn9AUwHk2Yf5o35eRNmvAquER2/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 22:30:31 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 22:30:31 +0000
Message-ID: <7064ab28-a780-4a6e-93f0-5dc26c62e72c@intel.com>
Date: Wed, 10 Apr 2024 15:30:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PatchV2] octeontx2-af: map management port always to
 first PF
To: Hariprasad Kelam <hkelam@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
	<gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
	<sbhatta@marvell.com>, <naveenm@marvell.com>, <edumazet@google.com>,
	<pabeni@redhat.com>
References: <20240410132538.20158-1-hkelam@marvell.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240410132538.20158-1-hkelam@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:302:1::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5257:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nem9qcj5qEFVfKtJ94QpMkOVMM21ccR1YHHRbsET8TWKAvIu4HqLldstt2tL/mfJNg1SnM0778EyDoMhIUiyBBq7sNUzc+yXgWOhaLRn2VOfCrYRUfee88oZs3xLY6AD29bmfOJaIfJKkwJGGJXc9aUV5xGXQkoSjGoOzZmQ9zs1Ojri8pEzHetHB5QpUM7okFsILE5jy4S8AY9l8wNheuDHQLMn9gm0DQoRy+6qhvzQaEJ3mPshHuKMAN3VKhS8sCWPLLwiDfATSDMHUUPPLPGlzx52+HPefwhQ+Ikg3d/NuXsoCqN3CyNSMWsxoBFP5mBxpgVYWlsTXHjbqkpPWQuXa5kBxeo7fxtEE0nhcCNn+nCM1hCqNeUeZjKirBrlddWaRaCPK7jMT4R9N0dtjnVbr5NBCAgD1yVJBoIuHNWV9UqFJur/a6pHko3v9Y9DaxMPzGRHE8TNP3Vv6Uv/HiWDpvFZumfRg6vqNvVsCg+hf7Lg9GDbtxHJqRzHCPV3xBa4xTdJhnB6qvq/8dffGCxKHOTOWJ4HsA+VkoPqz1LvzV9OURwuaxvQXuE/bLmZ5++JU1q4N5J8ITk7JnkD58aaI6g8ydub0dFTnpFRsn0ku9n807Zod+rR/adElyR77jgrZZXUmIu62hsN/q41tDshtqSwMlWz2uD62lheOYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tld2T0hCeGUzWXBhTGpMZmVPenFUNXlFbUJKOHAxc0tYYnRobStYbTllSkhx?=
 =?utf-8?B?d3NCa29IcFYwSG9MOVpIclYxd1YzMHNPV3RmZCtjelcvaDdicUM0MW5tWWRv?=
 =?utf-8?B?eDZEU3JBUkx5bWZZUmt5b3YwUE16cVFJSkVmWVFMSzVTSy9HWVFGeWVGeWI2?=
 =?utf-8?B?ZUZNNCs2bXhHbU14elJ5cXJNU1FNdzlleThHbStSRVI3TkhKWVl6TkpjdEFX?=
 =?utf-8?B?U3VNSW9OQXUveTdWREI0WGMySjFJbHhCdFUveGJpaENpUmxTZEk1bTRkOFNJ?=
 =?utf-8?B?cVlxWWVxL09Zd1BiNXdLY1c5a21WNzk3UXZITkh2eUZCQ21sS3RVSUQvUkhO?=
 =?utf-8?B?NWJ1Ky9ycjZvVXFGbGZwbnl3bnNwTkNGK2llMmtsZC84Z1hQUlNaUkdDRGFH?=
 =?utf-8?B?c1NuQm1ldmVhZDkvOUJyMnpNUmZsbW0rbjh0dkFCVTVjNU9lZjRwMVZHV2NC?=
 =?utf-8?B?MzZvZVkzMTlpNUppSDRXM0wyTVUvckhWTXFvNDJUTkVzdFZzbzV1RmFCcXlt?=
 =?utf-8?B?ZjczNExQT1p6djhSc1JJS0RHMlVJYS85ZmNKWlUxTlMxVjFhUnpVWEcwdFZq?=
 =?utf-8?B?MDVuQSs3dmhBUm8rVUgxSmxieEZjUlh6SHIzbi9FNnFKQzQweWxxcTlyYzJx?=
 =?utf-8?B?UDE3aDhMZmd6cGJtb1FmazkyWUlzQTM4aU9xTW1TcjFYajRGclVsVzRnQzVi?=
 =?utf-8?B?cnJ1VEsxNExtWWFmRXhJZ1Q3RTAyQzg3Nlp3cmRUQXhKcE9vRUNZenB1K0xu?=
 =?utf-8?B?M2l1RkhzNVFnbmhKM1N0YlU3VFFQMnJlVnp2OHVnR2dzRVBjMGhkMXkvZytv?=
 =?utf-8?B?dVZRNlUrbWh6WDkzUlpvVzBSeGh0NWZpS1pqeFNBek9YUkR3LzUvT3luRFFh?=
 =?utf-8?B?OGl4ekRzRGgxWFpzdldlWENtSXQwOUJXOFN5eWpGTGIzVGNweTBGaGdlcjRJ?=
 =?utf-8?B?bHBISG85VklXRWs5VGt1L2RKdXM1Qzk1MnFZcjk4SllsVTZJc1ZWRHEvcHVN?=
 =?utf-8?B?WFFuN25RamRvVzdHQXVEZkxzTCtpVEg5UFBadjFqU2tnRHVYWGlMM00vM2Ir?=
 =?utf-8?B?MFhVaXN5UGMycGp4TCsxU3hIWGFvMlVQMUh2TTZEWDJGSGFLMXJwSDl5Qk8v?=
 =?utf-8?B?emlhdkEwSkhGaTdrc2ZWcUFZcVRoL2NZakFPQXNDQU1QZ1MybmpMdFZwYmhy?=
 =?utf-8?B?UDVieUN4Zm1NOG04Qy9mR1Jyd0h2azliWWZlbnZMYTdJM3pOem53MkdlSUdk?=
 =?utf-8?B?MFJCMWJaU3Uzd1dibTVva0kvaG0xSFd3L3doSXZIc1UwQngycXJ3V0dja0hi?=
 =?utf-8?B?WkwrTDQxcFVhQVh5VUlyNHlWOFQvMlNjdzVXNmtrQ2oyMFl0SWZKOTRHaUxJ?=
 =?utf-8?B?dm1Zb1JXdGJLZEN0NVVhenlHdjRqdTJlK1NHTGlSaURSZWpxWER5UHNWTFkx?=
 =?utf-8?B?R2VISldRczV2VjlIbU1nWDZpUkdrRUxETFdWQ1NlK2NuMWxka2NMbWFrWXg2?=
 =?utf-8?B?bHk2aG9OdmwycERlaHVUa0lQU0JMSmJCa0VvZHYvcHZXWldCaVY1U1lPeTFt?=
 =?utf-8?B?SXpheE1uWmF3UXFkeGxrdFVJZWU0ckZXbGlNZzdaN3p3ZDcxcklzTzFjRlhR?=
 =?utf-8?B?UjAzYWNSZHFOWUt4VUJhakl1QVY5eGRCOFdWSFAxRUVGZXBaZytNVVBsSTFH?=
 =?utf-8?B?WVYxOGw3c1lJZnFtV1U2UnREVnNRakFoZE5zZDZXR2VHQkNjNVp0ZDJNL1NS?=
 =?utf-8?B?M0ZXemlYd1NFakJ3STh0MUdqb3hQYmNoUWhoRHZGVE1HYytKY0c4Ti9ZWVlY?=
 =?utf-8?B?c2J4b2RxS3ZtMlY2M0V4eGNqSk5RdDNuZ3RwdWVsZjB5Y3gwTU5PZ296Sm42?=
 =?utf-8?B?WVNkZDljNnc5OFhYYVYrbXlVSUxUY1FneS9zcVdJVytwbUZ2OUlwZW56ZWZ6?=
 =?utf-8?B?VGZrRGNvOW9Rdm1qRTVFTWNFN2E5ZnN4UFJRaHBXWVJXWGtXald3Wm1LWCtY?=
 =?utf-8?B?Q3psQ0lGQzdoUmI0Z3k3NXE1bjlpS0FqUFJTeVd4U0cwQmI2aUl5OW9ZOXht?=
 =?utf-8?B?dzY2VW1ha2pIS3hiamc3RlhxOUh6MDA5T1dLSFFmSWpleGtDRWFxVUhGSjJs?=
 =?utf-8?B?SFA3T20xbnVueE4wdWxtRnd6OFF6VU9CQXNPSHBUMWh2NlhHSXFxV1FYQW1t?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 317fa0be-14b6-4fd1-4e4f-08dc59add507
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 22:30:31.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVBLUmaPsDbIEpYGhEn5Tl7gNoTsrBbVxXzsly+i7NVo/oDGkjUisNbw2kVRSQIdir92V1LKnttE4nW2hQKBU9yloW8GGIQdm+34yw6Z2Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com



On 4/10/2024 6:25 AM, Hariprasad Kelam wrote:
> The user can enable or disable any MAC block or a few ports of the
> block. The management port's interface name varies depending on the
> setup of the user if its not mapped to the first pf.
> 
> The management port mapping is now configured to always connect to the
> first PF. This patch implements this change.
> 

nit: it's generally preferred to avoid "this patch.." language in commit
messages, as it is clear from the context.

That being said, its not worth a re-roll just to fix this.

Reviewed-by: Jacob Keller <jacob.keller@intel.com>

