Return-Path: <linux-kernel+bounces-136206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 755C589D112
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A535BB23490
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9203C54BE2;
	Tue,  9 Apr 2024 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aj8asn8G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8B52572
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633569; cv=fail; b=jBEuiTU5Lp/44ceyXO0gdh02REncU0D4ENKyCDhkDd5lMw/UifVFJlrDsCul99ex8k7lEMyXbPMGSEiLRrFDX7bgOEOZZmBtYkk5fFEbz1OufbsqUNqjBHRTPNBvuYKOKV1m2hAzTfgY9pcBOSeOm7jWv1lZ3LtpaIbx1vhPP3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633569; c=relaxed/simple;
	bh=+GjgRNvvXazgcEtqq3ywKu/8PGSjLsR09YJHeYAkoc0=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HSXnwo62LK0ifInesUCQI7TCJTunBMAghZRYgqQCzbgW3dLhhFxRxzRbgUEY0p6IRCm7lkgQWws9W/f7S6hmBZBWEzE3lj3aBDuejbEnqRxFmxd/RdcAKOwjbYg7MS8ZId3eFqPIJkHdM+zrBjgIoGmSU/HbRBIV+e+T749S+VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aj8asn8G; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712633569; x=1744169569;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+GjgRNvvXazgcEtqq3ywKu/8PGSjLsR09YJHeYAkoc0=;
  b=Aj8asn8GZCHmC/M2A/VvB3m+acGQbGK8RRXc4qYa+jNA2F2I0Rrb6RDF
   aU0790I0umYLbqAr2weBmd//m4cTRlO1n/57VK3fyzPmDSJyed4a68NTW
   mgX/weWYMusAmAiXDbsj2y918QCNYsG8/R69ga7BjnvILx6As0QxMV7QU
   c0/FnuYuDa3f8PvCM1a/6PoNgWArlRpB/KYJlzWFw92/wQZMvBCFReAxi
   PvfyF4wZTpKxqrBr2QgiCvi/nY1DBLj6lXh3/x15ehV0V7gNxNIjuQZN4
   BED+2hCwhC8ldmCLxL1mZO1KYk+RnmzHaWgwBvv0yw9reHTglpkE9uK5G
   Q==;
X-CSE-ConnectionGUID: VswRn0MYSZKYTWKBw/8BIw==
X-CSE-MsgGUID: paZS4kQaRDudkpp9qafTXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19368893"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="19368893"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:32:48 -0700
X-CSE-ConnectionGUID: pi7K4rTvThmRAwaVmpptxQ==
X-CSE-MsgGUID: zy3ks+CQTiKdNX7Bv/3Qcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="51284048"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:32:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:32:45 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:32:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:32:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:32:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2oHkox+J4Twkq8lzjObPFCJBsGzi/mGStisI0C8TatGjSL6EGrjJziqLDktdKQON/QMPHlUtjBM06CWXR7iPoVqcIqpxTi857akcCev/u6LYzD8qcchR6MY8fO/BjSCQN0JKuGUyXvQrlj8GEnGgcIp5f1Jv/f2RlL4hEZFPOw/RDWJnYnUQUybhCceORG8X+SmulSQ9PkqAat1TeIgB2o5kgjWIQTifwwu46CFdQb7HkH5vMcAIr2DX/3yJUfg8eq+Kl7LXV5cLBxPUY/7BnAiDMmAZiYBEhd4dfyh7gJSBsZt5mpJJHM15Ton+6HqS8sQqk8otDcMysEpsmI64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2p9KpQe20G2ueThEiPMMktpy4VOl0D3lpJ+MMEuoyU=;
 b=W96++YwoEihbDLFxiqc9tkT1FIfIaE980SRUSYKj84yQGZRtQLfYJKxsNsm06UWMwJHeZ3/J7DOzYQ35rW/7YiOnfFKL7UVsdJkpUnyxoRGs9u5RcMp2713rwyBjDKRvrk4S4mdym9bwmbwdp18nE72Fe/HWI0aGrWGNk8aX8SUGDPh9Q1HkE/igJF+ysisMdLJv0jC6fQ3aEc3VWE9BKPc3FbUXuWeUP3nwqJdd+1T+3Ieqgc0GiIBYCrmwmJJ6HvmZVZ6g3LBNevluKbtPP+e0o/yY6AYNfMF9muG+G3XjpYtD6L3EPb2BEubskjPz1Hei3w1nt85anXtZVTY3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7506.namprd11.prod.outlook.com (2603:10b6:8:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:32:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:32:42 +0000
Message-ID: <c27c7813-5744-4363-bb7b-f9fbe80fd549@intel.com>
Date: Mon, 8 Apr 2024 20:32:36 -0700
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v1 28/31] x86/resctrl: Drop __init/__exit on assorted
 symbols
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-29-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20240321165106.31602-29-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:303:8c::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7506:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ongI8DJgnCY/2auSU2JudoJu1LiBeGWFZukFGSzINMP0y3PtvZqWcZtPd5Oia0cITcKWRZlOfCtAqGYZqEwA6EZ9oAfosawBLOlTJ9iclf4UELhWO6fnmMZlFFz0qjRvGSOMj6pgcEQKAmt4NA1j0nsw2mFUqMnQH+vJnbuddnBoskJ/YOfWywn8tA5+czIZpPAUsJzPVNAKv/aQdOkPA9w/V49ykGxNo1lR0jnxgNcnZToKL3rJ3lnLPof5Ns8sAVkC9kfxqP1YWvSEYi0kMjJkkwMravpE9FspyN6cmF5Vxao5Vs0RUuXiNDyFbI88owoxwpBsFtVFVKJjyuJv/kZj0Sy7CUk0rzQDbaNcvKX3oAiPq5yhU64vXoMA6EQPk528ttOhCApGYOHqxl3YlCeP0u6hEN8C43s3/GMHRH0Ez97kApagp+ue0qEtW3SZOpFuVqczJl8A4BNJ/EooPRyekru1eAhYkDhwtAfmTpZ340WBO4YJTBxJY4Bj6aOXN2QtWVXBJ2JjQFstSkROlt6axN97B1D0yMBn9QYHNhWvyr7dPJaTMW0rjnIwKYbTrCwqNoChsMTPNEBo7LXuJcHALTnHPymIGOZnvI/dfYERF7PsxyZgC1XG2T67JAn/yyzw8zaSQz0RZkL6lTlC74HFM152WWIHn60VphobCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVVocHdyb3JkekxnZDVJU090eFBmNS8xZG0xNC9maXhHbEhBRXEwYTh2VEFT?=
 =?utf-8?B?VW1NeUo2d3JJRlFoQzBPbzhpL2k0c1N0YVFPT3Y4VGcvajZSWDRzc3ZxKzVS?=
 =?utf-8?B?WnVPdWRvVDQ0T0ZqTlR6aU96OU8rcjY2VENBVzRaTVhqNlBKUDMvMmhnSjh3?=
 =?utf-8?B?bUZGK2Q1NjhqY1oyd1V0a1ZiaFdDMFRWaU1Tckx3bWEzOWJFbjZYRklMaG9U?=
 =?utf-8?B?T0pET3ZuTUJ0N1hqak5lSEhyZE9kc1RUQ3Y3Q0hXS0VBbjdqN1FIdVBRaU1p?=
 =?utf-8?B?UFBwK0xSaFVCbUpubGhvZEdvVlpqRzhjNCtwQWhoYXZaNHczbmpFOE4vWTBH?=
 =?utf-8?B?QTdpWTJyL0JxWVJBbzVQa1cxSHQwdEVVZ2ZIbDUvY3lZWFdXTlVxbTE5REY0?=
 =?utf-8?B?cXU1YXFaREhONlgzM1N0QWs0YTNHNUFodVV4L2hma2VoaWlSbjlmTjVkMytq?=
 =?utf-8?B?OFdsQVRSUHVhUUJNSUFXSVFkY3BmYkdyajVRN1lyeldBNThNVjZMa1hWaU9S?=
 =?utf-8?B?S1pvL3lUL3hOVHlHdHNlKy85UXVHdFpxRjF3bFFDVG9vTHF6aTZSTjh6QWht?=
 =?utf-8?B?amVFcmQ4cnZqMTRvdkhVb2hNaEYzYWN5OG81cnA3TnpzMTdES1cxUG1GaVlK?=
 =?utf-8?B?Nldibk5PNVZCYmdiRjNQTEFFS3MyVTBDVU13MmdQcklIaE82YWRoeVZxVU5a?=
 =?utf-8?B?NElvRjBhQ0FJMVpRenJ1VVVLYlIzOVpQMVF5R0lCK0Z5MFBKUC84VDRPVTZu?=
 =?utf-8?B?RGlMU2lIazJLT3FyOTExczF0OW13Y0Z3b0hSUG5mZUg5V0ZVZkxQWUp0VXl3?=
 =?utf-8?B?WlVBWWwyRm1TVVVaRkVHVXVHejQ4UXBOZWxYbnVWaTF0d0IzZmduZmFKbUFV?=
 =?utf-8?B?MWd1VTk3eHc2TmYwSjZIeE5JTmwwcXgyb0pGODBTTkFZL3YrU2JQaHBtSFNS?=
 =?utf-8?B?bklKdUx3RE5KbmF5N3BId0xpciszM2ZIWHZxZldKVlhYajRFWUFFRHNidEp4?=
 =?utf-8?B?NUdLcWlTbEJwZ3hYM3FhNWI3eGR6azR0MlNVcEVqQmFWTGMwOHJ1bkJqRkx0?=
 =?utf-8?B?SnNybGc4dTZnYlZFRWYwa1JxUFArZm1vZzk5K0JNUUN3aEdYUVRVbDhQUWxR?=
 =?utf-8?B?enNBbDFIR3JkRUZPOWRKTkNmT3MwY1FJcWIwWHJRTHVGWnlZVkhuaUVYZCtp?=
 =?utf-8?B?ZTh3Z2dHS2M0bExMbmVGUDFiWVJkbjB6eXBMeCtVbzdycmZVdDdwTWtoTWtE?=
 =?utf-8?B?VUVlOUdrZzdHcjhGaE9LVnJxVE1NQU1BZ1BkTVI3N3hCemlheVA1eHoxOFJo?=
 =?utf-8?B?cm5pRmpyb3lFbCtSdUNEcXdnTWp1YW5QU1A1YlFWQmIwYVhVK1dSaTVYVVFj?=
 =?utf-8?B?NkJnTVdxd3pidldzRE56WkdsUXZid0E2YlJvNDY3SlI0M1IwUW4yVWNHV0pP?=
 =?utf-8?B?eFAwYVpZY1FFVGJZbUdZWll0Y2R1OGFJWlpNbGJFL0hlZ3EwbmMzMmlxRVA2?=
 =?utf-8?B?Rm1FVUhLOG1DY3d0UERIb2gwSFd4V1FjamNmMmI0cGluaHdzRXhHN3JpOG54?=
 =?utf-8?B?Q2RGVWIrZSszdXB2WWR1Y3VVTFhjSVFKSUR2WjlweEhDdFdEMnVhQ0E2MHhk?=
 =?utf-8?B?cUdHNzk1d0xhMjYvdmloRHVMWU9UWDBZOEhXMzFXSXNFblJVSlREb3M5YVdN?=
 =?utf-8?B?eWs0cTdOTVV3TjMydGV5SSt5cmFFR1ZWMjBsWHEzUzhqT0Zxb3Vra0lFRWtD?=
 =?utf-8?B?OUZ4TTBkVWE0SlZ4N1V6T0xaZGxGWHM1N09aTjdEdVJVWWVNaFBjeEttZlB2?=
 =?utf-8?B?NDM0cy9YZEJCWjhYMWtxYitnQ3NSbHpUUEEwelhLOTl5SzNkY1F4QitQaXcr?=
 =?utf-8?B?Y0VVZ1VHd2pTQ2d0Q3llOWFLNkJUQU5FdUFTMmdSM1FpZHUvNjhnaDJXbjhs?=
 =?utf-8?B?ZTgycitidk1ETkV2ekxNWWhzdDM2RFZRV2p5RnQrTWVxWkxrZ280ZS9nMHRK?=
 =?utf-8?B?d0NNWURXSDNEWTNPZDBJY3FJMVdNN0FNVE1lc0RSdjlod2VNODBmN0V5UVh4?=
 =?utf-8?B?NXdKbXFPVjFsQ01iMmFJSHJCQzVsWEdwZVhsZWt4TTBVNkg2SklrWW5ub0hQ?=
 =?utf-8?B?aTRudlBmbmxydnRFVkQ5clFlakdZeEZsTXFZZ00xSWdvcXQ3NXBjbUdQYlhB?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c24d67cf-57c0-46a9-0f2e-08dc5845b6df
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:32:42.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLfe1u1A07h5HAroTCMUURkh0qHVkXUOLb4lvoaNQQ3kic+bQRKAv8mH2MWhROPOeQUvCCouBwR3cXDs0afFhLOxFxfhpyWdX9RfoIaUzKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7506
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:51 AM, James Morse wrote:
> Because ARM's MPAM controls are probed using MMIO, resctrl can't be
> initialised until enough CPUs are online to have determined the
> system-wide supported num_closid. Arm64 also supports 'late onlined
> secondaries', where only a subset of CPUs are online during boot.
> 
> These two combine to mean the MPAM driver may not be able to initialise
> resctrl until user-space has brought 'enough' CPUs online.
> 
> To allow MPAM to initialise resctrl after __init text has been free'd,
> remove all the __init markings from resctrl.
> 
> The existing __exit markings cause these functions to be removed by the
> linker as it has never been possible to build resctrl as a module. MPAM
> has an error interrupt which causes the driver to reset and disable
> itself. Remove the __exit markings to allow the MPAM driver to tear down
> resctrl when an error occurs.

Obviously for the reasons you state this code has never been exercised.
Were you able to test this error interrupt flow yet?

Reinette

