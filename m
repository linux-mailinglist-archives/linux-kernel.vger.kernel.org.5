Return-Path: <linux-kernel+bounces-136201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3601989D102
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B712B21988
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A3854902;
	Tue,  9 Apr 2024 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lyYtIX7F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8B62572
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633155; cv=fail; b=AjX0AZ/IBgb2A+fL2bjIxP+gLzUNEqDggjl5RoJ1Jzemw68IyAfMSxWE++UpMUZpkgzlvZL1JShoT9hXtqamgeQu/wHToci3sWZOQ2plF66q6s6NhL29JwIaw3DJRUmuztjeg//wTNeiXtRYWQGVyV8CXJDk0D4QoI9osRL4UWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633155; c=relaxed/simple;
	bh=StdbNsyFVZ9+k/9AMYTvXL/osAAfA1YrLST7m4KgWhY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gDWaGTMcfR35elod3hbLXlQ/pZPzzqQ69rIA7x7gKqcLg2Z0py2tQyXw1jl2NoQXQsH7Z+5weKbdHvUDQRRW0gHeCu+8GgEGQQWvel70obk8z9RqCoXPTK2o8gj6oSaS2vhsj0T1TMbcM2kDelrlVt4i4VU/vdnun7B3iDL/cG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lyYtIX7F; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712633154; x=1744169154;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=StdbNsyFVZ9+k/9AMYTvXL/osAAfA1YrLST7m4KgWhY=;
  b=lyYtIX7FZjHG/KbrIm+0gz5voTWn7GOR2wg3yy1qQYadqrPMok64AK6v
   f4+L+g1i2Zhv7+eUxP0c87tzKs4NiqCtZt2uy4mKXy/oioLkTkfzrONAS
   M+Jg6wPBGg56mNEafrn0NjqSPc4u3bMcXHZbwpAljalgtmLHhIATTBi6y
   krI66bAuTNtjfvdsClil3ps7S47RQM628C0mCLbyfQ8c+5y7A73dYvgQG
   K/Pa3jHp9TMAC+WaZUTuHRd1P9htPAF658t40rGPEVs3zN9uYnUryH6br
   7598cPWmQEC3v/Z2ox/oNWBQPG3FPI54fe6kxe5GkN1mE+cG6SywE/54Z
   A==;
X-CSE-ConnectionGUID: 04zJn/enQLqog30kvxDeZQ==
X-CSE-MsgGUID: zBzA/NJ7S+ShTOVWwVHujQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="25436626"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="25436626"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:25:53 -0700
X-CSE-ConnectionGUID: aLLcL4IcSYW0D0oQc4r/tA==
X-CSE-MsgGUID: Y6o724R/RJeXqq9HI0yWsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24577565"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:25:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:25:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:25:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:25:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZivzc36lxK5Np6hjbwWE7CNQDUKqOBmgx6pyAk1bJYCqH+1pmv7jUK67Mfpqd28qgCtFLVUReLxFKomziTWomuDDU6iXemRZmPIJGvop10Z5Z18bTVxigxM1+X8nnn00ZvMeUjDMj0zfs9cfT6jvPHWGg+2FrnoJxU7+q1mmP9JY7Ut09bSv/tZDrwEPsrjiLvLchDg9IeJxAuxFa9LElm8De7u3c3NE7LMGNTNXutrlzdab+zV+Znm5PhEID+3QyKTNvG1y1fejDnlTJ95xvxVl1P5O/1bf5PfSfuZWkVLFl2ofM0t3qf5bIwsvNyKN3L4KpM7b1tZtqlaRNdCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qK2MUlRaZpMi2AVpdK1PB/YgtnO0jHjowe87hf7Xe5A=;
 b=W2JbBpBw5WvLHEXhAQKTnofo62VMCOijJ60d4LxoFvozE+vVYho18gWYl6S7G6+rH1oAgS0lmyo6P/Dm98VGhsPv0HNPqDIuCm3G5JN7bV7qDSd/MZr3jhKhAUfptj3M4ttcgowGCNdvuwF0LwKgx2u8enWK8r98YEtw/JdXBhKUYcYNzfxENq+4Ct4OKbUWgJhuwnSczjLh3YdnD5LnjEXRg4aug4RyfYy3kQ6RZ2WeCwCA3nFtdlmIsErugNR9C8p8GC+XSyUEMSTXNAH9vKX22GQIXcN3I2qLSkqG5RiGAbyidDD+0Nb65gPIWVXFm/4E1WqQjxdL3udHVxlvTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7506.namprd11.prod.outlook.com (2603:10b6:8:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:25:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:25:44 +0000
Message-ID: <bfc39b79-b3bf-4187-ba63-56db1ed6d565@intel.com>
Date: Mon, 8 Apr 2024 20:25:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 24/31] x86/resctrl: Move get_config_index() to a header
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
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-25-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-25-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:303:b7::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
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
X-Microsoft-Antispam-Message-Info: vwv7G3ifrU8SEWGkR3DG29zWtinJZL0sdndbShP2i5NbSmORodpSGauQiw/sVoVWKdRUlqKH7AHq9UTqW0l36NRRVV6OBk2RrsRvqRhza3JLvlhmK4BNTFplcuKI4NyfMFo3i5iJzlB+E/QnkUcJBqO9KqReUidbqr1cRro1KUJb1CLrkawDsbsyVfIWVds0Ra0j+fBnNLcEdcuidYuRUO+Gc8HY5biwGl5m3uuA+BrmtRTP1aXUASS/W8XbOBiGQeIor4GKYwlARc7mloiDsUN6D4XKy1Z2O/lq9c8qnpC9pjYVspnugVhpRVCdG7nfwRVoGilHSuaupx1DIHJ/uffTqRD104vp5JFPgQro9OD+HvGFOcRj+qpRxly30QRQOVcPGUhwSqLXT3fVnyAuF5UZEPV2AR8zHRg0VST1rj6hzTF0odC9bL1vGbcDOS2sX7wpZVp33NKX1gEiPOTBzsneIG+DBem5cgRh9YL/0J/kUriAROjYld36iwa8vW4DIw9MzYj4M95uAG1n5hm+RT/pOeEVjv52U4k6ZNso6BILUz1glQhUDuvQdGtat5DR+jd4UqcqT+yI1ZsP/qy4zoyO2/+Ww/isxXMe1RuVVgCq7DfAVjyIf3Hk/HvyN/VIcbgOW9Y+9uPTBvgMbd4MVi6r8yJgLT+/DaPVFTbi2MM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUl1eEZSd1loQWdCa3R4YnVyYUU1YTJqK1lDQmFaZzE4ZmlhTGJIOHppb05T?=
 =?utf-8?B?NE9DNXdxNWFQanA1ZklJbUROWGFjd2F5ZFN1UGdHeTJ6R0JWMUJpcGpjdEVt?=
 =?utf-8?B?MDVuZnlMSWk3R3hYWEpLcU9HbkJwYWdZNUZiVEFFN2hnZEFXVithbXdJdDhv?=
 =?utf-8?B?WFVHRkxESlZyNFZGajRiNUJ2UmRaYSsvZWYzM2JQYXBPMUplcFVBOVN1RUY3?=
 =?utf-8?B?Wld6ZFM5NzhuVWxWSUJrU0tUT3IzSjY0N0dBa0FpT1hqUmtNcFVVL1F0Rnc5?=
 =?utf-8?B?NHRONEljblpvajhod1ZVMFN1cm11c01vNFlYWnRnWjlTcEhvd0VVN0Rmb2RN?=
 =?utf-8?B?TVBjbzBDTWNEdEtTN2QxV3ZUbVllOHZkSlJWOGRWQWZpTE9YbjZ6bmQ0eEVq?=
 =?utf-8?B?Q2c1ME1ucG9tc1BsY0xjYm5RODBXMGJ2MjNDTjNObk1CRjFjWVkrRmR4Zmkr?=
 =?utf-8?B?aWgrMFFNemZ5T0F3emVIV3hKUmxNUTR0SjBjUmxuM2pzRGN0c2pSQURoUDVG?=
 =?utf-8?B?WWp6NGNWcHlybWNscXo2b1BwRDRkelpvM0Fnd2NjR040UFBvd1gvM2tabkNw?=
 =?utf-8?B?aXdPa1RSNkd4UEFidS8wNGVsNDBIN1BYZ05UaHBDVndZdEp5NHZGYmVDVmpt?=
 =?utf-8?B?bHdmbTNtVjJ6RDNuZkRLeHhkWmp2TlBlazVSNVoyaDhMQVlzVHA3N3NqSXRr?=
 =?utf-8?B?NzJWbjBkcVZGZWhzTE1vS0J1NzhFVGU2SEI3OGp2eGxFVGYwbER5enk4VmRB?=
 =?utf-8?B?ZG5LcWZSOGk2YWxWWUx4clJyT0lMajA0QjE5dlZNT1VzQUJUU3hqYm9WQzY2?=
 =?utf-8?B?UW0wSUpLM254K1pJTVpEUTdTNzR1RnJxWnYrNU13eFU2L2ZzMmFjODNEZXZT?=
 =?utf-8?B?ZDhqQVZyMXhmd2dUTHpNR2wyU2l1cHJNYkVTTldRMCtBcDhodWdlYWtXNTQy?=
 =?utf-8?B?czYwU1lEL1RGUzVFdCs3cXdZRnNPRWNqSkZHTVpKNEtFNmRvSm9iWHdZQ1NG?=
 =?utf-8?B?SkhMZW9GeFVDbHFlZndwL3Z0YXRKenVxZXl0c3lyTytkSno5YVZZU3lLZERm?=
 =?utf-8?B?d2J0ODRpWWdLUzAycGhpT2ZwK3A5NVMxOTI0L2ZISjFHNlhHd0Iza04xdmlz?=
 =?utf-8?B?ZTBFR3F0TG40TTJVRmRxcXNyRVAva3FySDUxL21pUWtyb0k4RGVkOWZYWk9j?=
 =?utf-8?B?RWJEVkkzc08xK2ZDMVBrT21mTy80djRxSXdFZUZHcEY0Q0dLWmFyUHFxVEdE?=
 =?utf-8?B?clU3R3VQdTlrY3l5eWtVbytTL1lLVlg2cE1rbmlRN1RjSFFzd2NPSjRRMTBH?=
 =?utf-8?B?OFJBVUhMeGVVaEVrdWRWMlVpOFlDT2hzMnZvanNteFQ4UnhaS0htQy80ZExG?=
 =?utf-8?B?Q3MvT2JjMW5LOFcyVUQvcGxsdHFlbU56L3FTWUU2bXNmUEdRSkZmOGs5TVlS?=
 =?utf-8?B?YmxEbGkxK3F0cW54ekJpMXdZd1M4bjBDN2FxK2p6VnVQS1NVcWNFSmtmVUFQ?=
 =?utf-8?B?ek9ncllHMXhBNmR6WCs0Q2RocGFwMFBRZmoxdFp2WEwvL203T0xpcmxZdGs0?=
 =?utf-8?B?WWxOSjJWTVc2RmRqZVlPTzhna3ZFNVBXc1VhdmRqU2tnb0pMU2h6cytET01S?=
 =?utf-8?B?dEY0Mnd2QWJ2c29saVliYjJYdktEWWhtR2l1cU9ZaUIrYTlpSXdGRFBMSVIv?=
 =?utf-8?B?OXgvY25tVkVJSXpRc0JsdVdua1V0TXY1cHp1U1o2eFNCY2dUdi9SQUo2SERK?=
 =?utf-8?B?ZFNZOGN6cnJPcTFTbU1QVytrd3hjNTVnRVF6Vk5hYTJCZHpScG1TYWcvRS9h?=
 =?utf-8?B?Q05ZbTJHOUU5MDNiOWEyc2Y1SUFSWnNuZ3lxTjZzQkNvT1NnTzAwMFpkSkJt?=
 =?utf-8?B?d2JzdmFOc1o2NVV5VEJKdFZHZTg3eHFpL01kbklPTGs5L1hNNkJ4eDRoWE1s?=
 =?utf-8?B?WlkzWFE3UkFwMzZPSUQ3R0FXYk1xajdHVnVSTXZmbmJoZ3hsZndlSnc2emJN?=
 =?utf-8?B?K0tWcTdSMHVtSEE3bm9RQzhiRnBpbFg1OXFoRGN0aGt3eG5URWw1NEQ1U2pF?=
 =?utf-8?B?ekdLdmY0SDA2WEhzVjA3QllYT0dnUTNzSzZEUTJrUG1MM2FqQTRJaFpzY0c5?=
 =?utf-8?B?T2FNRElFZkVsT0RKcUZKOWVadVFIb3hPN0VnM1NOT3F0a1dOa29ndENCL0lR?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7de31ec-86f6-4684-98f5-08dc5844bddf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:25:44.7328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tD52rFlxpKWAcvn3y1GkG/bdcYSh1XOt03qfcC86QlQ1/A+U+r1xEDjwT4PhgQLyYP2wRymN7Jztw7Fzw1fuBll8Q7axnnViZo1fxwzw8gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7506
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> get_config_index() is used by the architecture specific code to map a
> CLOSID+type pair to an index in the configuration arrays.
> 
> MPAM needs to do this too to preserve the ABI to user-space, there is
> no reason to do it differently.
> 
> Move the helper to a header file.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 +++----------------
>  include/linux/resctrl.h                   | 15 +++++++++++++++
>  2 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 3603ade95f1d..b4627ae19291 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -277,19 +277,6 @@ static int parse_line(char *line, struct resctrl_schema *s,
>  	return -EINVAL;
>  }
>  
> -static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
> -{
> -	switch (type) {
> -	default:
> -	case CDP_NONE:
> -		return closid;
> -	case CDP_CODE:
> -		return closid * 2 + 1;
> -	case CDP_DATA:
> -		return closid * 2;
> -	}
> -}
> -
>  static bool apply_config(struct rdt_hw_domain *hw_dom,
>  			 struct resctrl_staged_config *cfg, u32 idx,
>  			 cpumask_var_t cpu_mask)
> @@ -311,7 +298,7 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> -	u32 idx = get_config_index(closid, t);
> +	u32 idx = resctrl_get_config_index(closid, t);
>  	struct msr_param msr_param;
>  
>  	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
> @@ -351,7 +338,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>  			if (!cfg->have_new_ctrl)
>  				continue;
>  
> -			idx = get_config_index(closid, t);
> +			idx = resctrl_get_config_index(closid, t);
>  			if (!apply_config(hw_dom, cfg, idx, cpu_mask))
>  				continue;
>  
> @@ -476,7 +463,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>  			    u32 closid, enum resctrl_conf_type type)
>  {
>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> -	u32 idx = get_config_index(closid, type);
> +	u32 idx = resctrl_get_config_index(closid, type);
>  
>  	return hw_dom->ctrl_val[idx];
>  }
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 3de5bc63ace0..73c111963433 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -258,6 +258,21 @@ bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
>  void resctrl_arch_mon_event_config_write(void *info);
>  void resctrl_arch_mon_event_config_read(void *info);
>  
> +/* For use by arch code to remap resctrl's smaller CDP CLOSID range */
> +static inline u32 resctrl_get_config_index(u32 closid,
> +					   enum resctrl_conf_type type)
> +{
> +	switch (type) {
> +	default:
> +	case CDP_NONE:
> +		return closid;
> +	case CDP_CODE:
> +			return (closid * 2) + 1;
> +	case CDP_DATA:
> +			return (closid * 2);
> +	}
> +}

(please check the tabs)

This change is unexpected to me. Could you please elaborate how
MPAM's variant of CDP works?

Thank you very much.

Reinette

