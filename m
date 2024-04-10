Return-Path: <linux-kernel+bounces-139433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAA48A0344
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F341F23747
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A63184130;
	Wed, 10 Apr 2024 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOAYagvh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6495F168DC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788028; cv=fail; b=KFIMXoFJzSmAMyuzoYIRkk9gzL/3Cg4jv8VoZqUUHN1mdG6uvYq9LNtHckPJZMHIeURhBeLPYnSTszJoUb/5bttdM46mE7DhS8Jo4xkO4lNeQ+xQgRCgm+GxQpylvJWN7etl3yWnZqQ2ad/BBwZ3yEyJbUNJslaM7fQKW++bzTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788028; c=relaxed/simple;
	bh=4/XS5JBY+dqMMFBTxa4ADxRsJSMJVbckMJ8sKMeYZes=;
	h=Message-ID:Date:Subject:References:From:To:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=TWvlacdGbFKsbLIjpQObzYy99r/Gj01R88UBbTW+DVNg8htS754pV80aM5O7u3ctu751Ku3ExYxvIjjfcCXOXeE1dVCeoG2oBLQDHrA/8GUKZz8KK3DRXC7p2EYUMaACN74FGf+MmtfNTQQIgoi2SNma/ZIo6Xjv4n6kNHkCeUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOAYagvh; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712788026; x=1744324026;
  h=message-id:date:subject:references:from:to:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4/XS5JBY+dqMMFBTxa4ADxRsJSMJVbckMJ8sKMeYZes=;
  b=BOAYagvhIAadBHfzLtdgQBbpsnjUiCshXX/d1EAS/n4B3hWDHzx8SiH0
   mdYXmImj/tBUuX0GSvEJE0qGw6ZQ3f/6npFpuzNzxyW8VMBp2zII28mdx
   fu0hBk8EOLHmy9DFbHfMJNVqVGh394p7qiKIqd0W+HjJ9cxdG30lgG6Vf
   MTWXsVagkoEXgdScbE/XUMzt+UkSCfNfQEoVmQFbJUUH14YMrCMF9mcgU
   mTCA/bdtb0Ceq2y9AFUP3WdnQMlPu0KfDAkSo5ZPgHCuTabs9fOD2GFk8
   pkTNfsLiRaSFVG1xZ96fiTL++P6+zA/8L11TBaBNLYqeSFwvWdwGfcMgK
   w==;
X-CSE-ConnectionGUID: 5iptrtOkQ7+RvC+hRDvesw==
X-CSE-MsgGUID: nXPSxDZwQaiwLQbIfmWDXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19571060"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="19571060"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 15:27:05 -0700
X-CSE-ConnectionGUID: DppDV+GfTSypKR6AhULDiw==
X-CSE-MsgGUID: 21U/At7RQo2aAVr3MmMEJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20740533"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 15:27:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 15:27:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 15:27:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 15:27:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go4SPHOWn2tOVC/+jhCnBww9LxI/7/H0i1D41HnL9iw7O/OLA+oBzdi63O2OoN3mNJuaaQ694Zszrix0ew4aPVRjuqN+IZcpuNitWFb3rI88PiKVCfShV5OkRpNI4N7s3vLDzpOremEIKuV+lc/QyCpRGRsopxYc5w++/jhtnYT9nVkgPeyL1PIAihNYZZoGDOt3eeERVoIe8uJosKXd2Ib5uH7A7j8VCZ+nuuAGyH2hmVvKYT+Mlw5IVfSUDShD4GQGlIRmTzn+5NwCetxV8uAHxlLpbfeJeoCyP9hRyXv4qv4Zo83MGrJenpaXY6mspRzk138NK3+czJv+LyiFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8qWiHm6nwC4mAOn7KSx5XZPfPljqW/bD7nFtVyInAI=;
 b=VHyw/q6LN/G2/58QkryvP9oP5tKlaJfeqFg7g083a04ZGsrbisMV1hy600JCFznWn2o41HoV4Ox2pdDMGFuuFQbu2miR3PCpvMSbGE9itBvE1XFln+g5/ENsIM0YE3a0NaylG7aMKgK0prnklnmWVIGMS2GAHge//Z5wELothl7zOv9ymQrZ3xGqYa4421PghBHXzWw5NX1GeHxlKbQwyci9sSzT6THsazaIRvnXHQNf6kn5Rx3jzENuryz+8PGZJ2BpWLWGcWuhx+0LnJAeHCp1jmCvqKe6/KGtOLIfkixFmeZ1Awp0PCs3h6qwSsjJ9P9nJXqGtfyxRMJGGA041A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB7013.namprd11.prod.outlook.com (2603:10b6:806:2be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Wed, 10 Apr
 2024 22:27:02 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 22:27:02 +0000
Message-ID: <e24e0de1-d984-474a-8b79-ea0934ac668e@intel.com>
Date: Thu, 11 Apr 2024 10:26:50 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
References: <cover.1712493366.git.kai.huang@intel.com>
 <33b985a8f4346f4bcf0944eaf37193a906b11af3.1712493366.git.kai.huang@intel.com>
 <e94d208e-964f-cfc0-60a4-fe70db52bec1@amd.com>
 <cbf171e1-a518-429b-fd07-3526a0b252bf@amd.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <dave.hansen@intel.com>, <bp@alien8.de>,
	<kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<rick.p.edgecombe@intel.com>, <ashish.kalra@amd.com>, <chao.gao@intel.com>,
	<bhe@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>
In-Reply-To: <cbf171e1-a518-429b-fd07-3526a0b252bf@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:303:16d::18) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SA1PR11MB7013:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIbEVPwQ8E1eo7T8rA5DWfbdiy6jaoXBUvOL/6JgGNAxVtK4oPM+ynnkcr32W+UNeK8qqMgGWO6jRUCi/wvdIaaK2FFrui78kSkm+7hrWIaZVsBZk8wtH/4TmatkAbmAahdlNJSguPNL13jlDLBm2ITeby0M/uaQyeVF/JgTL79shQy+FsBR/JTvbudL5HcD8bdjrB8jF3ITL3KWvO1CwtsGrK8QzfEeGbzORz6ZSKZa03AvDJoi7aS67B5NR3rGnIsDKFEtP2PjoKTw/ELEifdIDwZo6/el93On6e6M7x2FwmppRL0arFVLElul3yeGD9Gg3LFGgTGjGmUzSzCmNZOOuE25oZZSJ7N1z0zEFz96CdcjcJ0Mgjoe+O9lbLxfhf8/0swIglmlqSd782n0a09S7qz37ECq71PPCIyYmWeo5eeV8Vl9t/CPj9Lbw4fWyog3ojt4GoyMvVbFlWO1lEEN2i57HKui2pLbvaByh3Fa0JAhd3KpIr1in6+jMRg1rj/eCgmVMeWzFmdoOyyxEsguWhf1z2+xalfq2GJzlakJUQklNoDwAMXH7xo0+9mB3hOzS4zHJpavGB6q12f6LCwaXKur80I6SuJ5+gSI/kollfGJZSfXpDPG2M1/JyFw661B97MwM+regN1ZnkQ3AnBeXIeDpa07VdaPTnms4YU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3NJTEoydUtTb1IxQWxXVUZRWGpOZ1lxRlhFR21talFhdklqbVBScTlTd1dY?=
 =?utf-8?B?YzV6WWNPcUk2MlFaZ3VENGZpOVEzZmNTU2xkMEhGL0tYRkhlUkl1ZnlRTy9m?=
 =?utf-8?B?cWZwUWxzMkhrQUY5MHZQck43U0grN04wVE1aQ2hhb2hCWmZiajdSVnJtanNi?=
 =?utf-8?B?Y0lXVFkzTFpldC84NkJ5N3B0L0NWaEI4emV0ZXprM3RteG5Ja3dLTGJOcUVV?=
 =?utf-8?B?a3crSTNyRWU2MWl3Rm1YeFJkRUFUQ3AvYmJETDBHZzQ3ZytBelZtejh4eVpi?=
 =?utf-8?B?cHhyWnduTFV6eFNVS0lES29DMXI3MldBYmN2RnVzOXJIUld4Q3dwcnpobE1v?=
 =?utf-8?B?MjJHMUpCVkdyTWU3TUdWeVZlNStFOG5HbEpKUEYvNk5iall6djRodkRQMi8x?=
 =?utf-8?B?VU9hKzRGV1ZzbGh1V3JKQnNnN0ZWTjUzQWFRRFFMQ29zbC9YUS83VTF4dmNB?=
 =?utf-8?B?UWd2V1pPNmU0S3B0THRJdDRreGxaUTlid2Z0OVY2M0R4QUZ3UUY0NGhtNnFS?=
 =?utf-8?B?TDJNWWdhbDdLYnRqMERXeTZXVXd4Y3Q4dGtzeDNWdld3SFMrNzFHTWl5U0Rz?=
 =?utf-8?B?Tkl6dFFmdVhMenorR2ovVU8zSGtzYURsMGRHSUlyM0NpYlNZb1ZXZlRKN2hL?=
 =?utf-8?B?VmJFTlFwOWwwcVE3cWYrcUtGTzV2c29wVFFkNGFEQndsU1JyWjIxTmZYVzJp?=
 =?utf-8?B?SGZoT1NvRmVjcjEzZ3BDazNzc1Y0SlVYNnhlY1A2R0V3V2hLbXl0bFpJaXQ2?=
 =?utf-8?B?aDVZMWQ2bzJ1TUc2cThjbzNKb0UwMmdKcG1HN2l2RERTakFMQk0xeXBLcVp4?=
 =?utf-8?B?NmhvcHM4S1V3Qkc0RndnbE4rK0RPazhqbnpUTUxGT20wUWw0NFRGTGVrOVND?=
 =?utf-8?B?WVJ2cVJUUGZRVDU2Sk5OcEI2YjJQMG95eXoyQ0VLOEltbXBYNWFGbHJhcDB2?=
 =?utf-8?B?UmxDRzJEbkNjUHkrUzR4NEtxSFhJWkJsWXdRSTFtNXhrbHc0U1FkVEl6Tmlz?=
 =?utf-8?B?MkVKSVZmUHFrQWRsQldiU0J0VEtNSExQNFBwSEpyTDlxU0MzdVR3Tm5ueG95?=
 =?utf-8?B?dWMwdnZzZW1CNEoydkdPdHdveDNXcXlXdk5nRUp3ZWc4clZxWmxIRlRRZUdj?=
 =?utf-8?B?MEdabHgxV0dXT2hNNmtVV3Y4MmQrWW1qeGFramNLY2xMMFVGajhMR1dVWFlL?=
 =?utf-8?B?NklLdzFtczlYZEF5QS85N3NFZ1JoMURmT2QxRUJtT0dwTVREMytBZHFEMXYv?=
 =?utf-8?B?dW00U1BPMy9Fa0FBZUZNWjl1OFNvS2FlRGljSHVnOTBKL05seWQvT0hZYTBQ?=
 =?utf-8?B?ZXJaSDlrV0tDdW1LODJteEgydjlUWWJGNHFsaG9lNFUvSC9JOVU5dVlyenov?=
 =?utf-8?B?NE13ZnpCTGhZdWxMaTU4aEV3aTFpWEE3TjlPVnl1SWhONXpwNXRxYXZvMUMw?=
 =?utf-8?B?YUhXUDFMWjU2UUU3Ykl2bG1FM0hQMUtXbWtTajdiT0kydVZ2bFBkOEVoemJD?=
 =?utf-8?B?WTE1QW16YVBZdE9RV1NXS2gyeGdZa0tmak5uVzdxamxjbUpLL1lhRzB6bjk0?=
 =?utf-8?B?K3VCczJwbkhsYUFkbW5sUWpRa2NENnErdmFucFBBbWZoTWZmckVCYVR6K2JV?=
 =?utf-8?B?enBmV1pFSXlVTkRSSXdxR0VLRVRKbG8wTXpzTzZybWFjdlZHTHd1MTcyYVBk?=
 =?utf-8?B?Y0JYUlBNeFZqT1FSZTJYWCt2bVBvWCsyKysybmNWR3V0OTJzdU9lNG9mRWdm?=
 =?utf-8?B?czZZUDBicEhaNHZqRVI4eHZqNUlDSGpRUXM2ajd6bnJUeWNaK0pWamFBckE3?=
 =?utf-8?B?MnN1TkZReUpKZnVpZVR6WVFobitqY2N5a2Zhb1lIaDg0cjgyd3lsOTl5dkJS?=
 =?utf-8?B?U0NwcWxDY3BCRDlhTnloVWhPNGFnYmJyc1dMNjkyWTRaRmJ1d29ucG1nakE1?=
 =?utf-8?B?MXA5RnNkdUQrb0tYRHRKSGxsMGhFdFFLd2RPR3V1SFRydWozeGZFZUVzc1ZK?=
 =?utf-8?B?SC9VTTZTWEhhVWdiaVhSRHlSK3NjWGRDZk5RUktBWHFObkNCOWI2WjNuaFU1?=
 =?utf-8?B?cGpEb01sS2FOV1c4MnRsRkdNVTBhcDE3Z1cyRmpmdlp4Z21rM1pJVUJRblly?=
 =?utf-8?Q?MFb6JZPWVa+o3ByDuBWgYgCjS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2a7808-d511-4693-dbd8-08dc59ad5805
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 22:27:02.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32lI7a3ByhMrdCKTDgINT0w5yz6ahcJ3lBwpu8nC0S8XgKAjY2rwLe+4u9nruTW3nHLSL2HF7ZKuipGDXOf/TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7013
X-OriginatorOrg: intel.com



On 11/04/2024 4:14 am, Tom Lendacky wrote:
> On 4/10/24 11:08, Tom Lendacky wrote:
>> On 4/7/24 07:44, Kai Huang wrote:
>>
>>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>>> index b8441147eb5e..5ba8a9c1e47a 100644
>>> --- a/arch/x86/kernel/process.c
>>> +++ b/arch/x86/kernel/process.c
>>> @@ -813,18 +813,16 @@ void __noreturn stop_this_cpu(void *dummy)
>>>       mcheck_cpu_clear(c);
>>>       /*
>>> -     * Use wbinvd on processors that support SME. This provides support
>>> -     * for performing a successful kexec when going from SME inactive
>>> -     * to SME active (or vice-versa). The cache must be cleared so that
>>> -     * if there are entries with the same physical address, both 
>>> with and
>>> -     * without the encryption bit, they don't race each other when 
>>> flushed
>>> -     * and potentially end up with the wrong entry being committed to
>>> -     * memory.
>>> +     * The kernel could leave caches in incoherent state on SME/TDX
>>> +     * capable platforms.  Flush cache to avoid silent memory
>>> +     * corruption for these platforms.
>>>        *
>>> -     * Test the CPUID bit directly because the machine might've cleared
>>> -     * X86_FEATURE_SME due to cmdline options.
>>> +     * stop_this_cpu() is not a fast path, just do unconditional
>>> +     * WBINVD for simplicity.  But only do WBINVD for bare-metal
>>> +     * as TDX guests and SEV-ES/SEV-SNP guests will get unexpected
>>> +     * (and unnecessary) #VE and may unable to handle.
>>
>> In addition to Kirill's comment on #VE...
>>
>> This last part of the comment reads a bit odd since you say 
>> unconditional and then say only do WBINVD for bare-metal. Maybe 
>> something like this makes it a bit clearer?:
>>
>> For TDX and SEV-ES/SEV-SNP guests, a WBINVD may cause an exception 
>> (#VE or #VC). However, all exception handling has been torn down at 
>> this point, so this would cause the guest to crash. Since memory 
>> within these types of guests is coherent only issue the WBINVD on 
>> bare-metal.
> 
> Hmmm... actually it was the other WBINVD in patch #2 that caused the 
> crash, so what I wrote above isn't accurate. You might want to re-word 
> as appropriate.

Yeah that's why I used "may unable to handle" in the comment, as I 
thought there's no need to be that specific?

I tend not to mention "memory within these types of guests is coherent". 
  I mean the current upstream kernel _ONLY_ does WBINVD for SME, that 
means for all non-SME environment there's no concern to do WBINVD here.

Here we only extend to do WBINVD on more environments, so as long as 
there's no harm to do WBINVD for them it's OK.

How about below?

	/*
	 * The kernel could leave caches in incoherent state on SME/TDX
	 * capable platforms.  Flush cache to avoid silent memory
	 * corruption for these platforms.
	 *
	 * For TDX and SEV-ES/SEV-SNP guests, a WBINVD causes an
	 * exception (#VE or #VC), and the kernel may not be able
	 * to handle such exception (e.g., TDX guest panics if it
	 * sees #VE).  Since stop_this_cpu() isn't a fast path, just
	 * issue the WBINVD on bare-metal instead of sprinkling
	 * around vendor-specific checks.
	 */
> 
> Thanks,
> Tom
> 
>>
>> And you can expand the comment block out to at least 80 characters to 
>> make it more compact.

OK I can do.  I guess I have to change my vim setting to do so, though :-)

