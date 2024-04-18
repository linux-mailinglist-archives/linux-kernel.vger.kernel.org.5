Return-Path: <linux-kernel+bounces-149520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 673458A9253
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EF31F22914
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEC954BED;
	Thu, 18 Apr 2024 05:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQVhbyks"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481D1EB46
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713417537; cv=fail; b=OeHFH3zZ2gkOwzEAQuFwWo7Jbp6IfuwZc/SGnWbN6l7QW7KH9M6M4BW8+mYLa0DaNi+IZKRW6yXSqRqPvyCBjLrdq++0uq3rLX+bL0d5nsFXW3vjCiBXREntymU9r0l8wgZmjVuvO07fWYfiNK19t1jrvZ4xXfy9LJsKt9fCmKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713417537; c=relaxed/simple;
	bh=PoPKSMh/yjEfRBaMYpqO2Z8/R8NM9T9Mi4UCpKP+rAc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IKtNkK0DJT4Ntlr/HlytHdWW2G+j5J4/5lSe6xf9WzsyjF3THoLdWGOw8daogACBYlTjKsIOogzt1ZhsUT2lLilJPbf5yzvl+vslgYUIXCin6jqADa0JShQF1qb0ibh5GZXGPDV5yaeUw0bEiJMhxgjGlwja9V9q16GbQ+No154=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQVhbyks; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713417536; x=1744953536;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PoPKSMh/yjEfRBaMYpqO2Z8/R8NM9T9Mi4UCpKP+rAc=;
  b=fQVhbyksbK//kVloLNs9iYLt0tX2Sbtn0spGTPuQ4AS4UVf2gVy5gtqi
   VpNXSIRj/vo9LH7NrI5kxxS2LjZ7TRuYnXnYoEKPp+Ck9V3NqK7UBwAf5
   ++lT01X+J1hVyWCld9j3k3duqkHKS+mQYw3NoD0ByzUDlGj5MioexuuUv
   w/0h3fF1SBNe7B2MmJLJSxlnccL5ZyCAvcIIPuNVTd/qT17mrlIQ4DA/7
   C8JCjs3GmdsFeysC2GRWrUN7xm7LHgYxYBWvzvVrMCBT+bXZjszKY8pPw
   bDSSF6i9K3Cdd8kGZFM0Kuezq6eHR9Vt5MJBKxJWoMUOHZX6EsOo7xXHA
   w==;
X-CSE-ConnectionGUID: KZNOcVW/T2utWm03qTjD3g==
X-CSE-MsgGUID: oq6H9hN/QSmDpCvp5rbgow==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20330990"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="20330990"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 22:18:55 -0700
X-CSE-ConnectionGUID: n2Wx2FfVRBCsizgaIkl6Nw==
X-CSE-MsgGUID: /34gEWG1RqyjJ8bKECqvrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="60289544"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 22:18:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 22:18:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 22:18:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 22:18:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm708JPKCbdS59QlEsUMS6BO/fmev08kDpUNSB2EqL7cuEG2gSi6Pd27nm40QN3aRB97mkEfoYfz+z75hWa9NeYAcINWVOLuZ2MGrv4lKRvoUvJQuw1pRcKpslf5KR9Rkx9/a0qRHQFrZAwLlZmxBVC+5cjr83NV53umtQykmb1ICbjkz6c6j8nYXoFqBC9yIRVBq9wnc3lA2FiCxJsQ1FH+ulXqB3GGc72tjyaVfCwg4wK4bgLouw7itweHOLlhqi46R1IZ1jP02tnrhDM3G6Y7MKrDYoE/qy4STOSm4lOA1mnvPn/ZkfY394EYatBAf2YoPE/5UMzx+VI9Qu8TkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrXDj0ABx9F4yVke82avzkAAjJeaDs0TxfA6kAWJgfc=;
 b=OpzH7pcl+Ub+3CbIAXvkhUvjtjlRQCvkVVmhIdzxMiAqc6dDfg4Fhn/YJDZQYZa7JlvRnSM366bW63Co7OyyWJPMR2D7YalXLMUFN8UEqXlIg7qYZ3INb6cjP1w6rYDDYUy85niPm9kPN09I4KUhw70jMA895/SZR60tn/gz31ClD1Lowtv5miQtgnWkFdajDUScV3aIsmO+iFtMv207lWUtdbw7z3E6adBxZlHotWDSfR+wY8FaEd+bf/H5E2SbwtTrcbOfYGm9qVmPknHpDzdeR8VD/AonlrzpE3a71F/SxRhG+yn30ItRoPVUuMiwNCS+aG23xGCVW2kh/0ISXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8004.namprd11.prod.outlook.com (2603:10b6:806:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Thu, 18 Apr
 2024 05:18:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 05:18:51 +0000
Message-ID: <9e57c086-ce5c-403a-9134-9e2aa5124535@intel.com>
Date: Wed, 17 Apr 2024 22:18:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 17/31] x86/resctrl: Move mbm_cfg_mask to struct
 rdt_resource
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-18-james.morse@arm.com>
 <966b7b32-6600-4b1f-9535-0298fedd57a7@intel.com>
 <Zhfwzh4sHvTYyTJ1@e133380.arm.com>
 <c96cdf6a-02a8-4ee2-91f5-e4329015e276@intel.com>
 <Zh/fqIFJDjsb1jYT@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zh/fqIFJDjsb1jYT@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:74::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0f87a9-69b6-4f6f-a295-08dc5f6708c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfL6DGSWmGSUVQ7dgygmDsC8z5nWnJ8SmWQfG4uGMGhWm/Qeg/wLD5KhdFbOk+q4/HolX+cnx4fv90gFiblPNWvib8A4ZgrokjS2jQTB7B7qNDQrdnqvA+xZTe0bPeQcTqTK4EJ6XCla3yiFT6+hXc7OR0pp0d5tWiXkWpC4I+LWGYdqEN45oGtTJu3kGZNYVSZTvENxhn595n3Go+Ba1TtxhFiFSKluCcAogsTyNP8iL0QKCxefRaQr0t1sNE8Wk4USmx24h2WoNa+dXdz1t4ZekgYDxRmNZW2XBLQkYuBvIkzH64pRiWaUvP5z/8k1N6T51mM0iyV0BTNJcCdG2hNAupGZjyQVuTyjnkZXfRJsbR+tFpBbrXmmZZxmwqanYA/QEqPiO0QBO3ewv8LJo7y8r1KiYiZ0lnDGv1+jA8dc6qlzvLTPROzuCuDpgXcBPYAyk9CXucJPzOUEGCMawWtw0mOMbV+mp3JaN1oQ7etzewdvmTff3UStnSZ2L0W99m5qddisL2vOwRDKgIWhFVSSNXuHL5387rt7EMYd5kviODeaszP+HCaDhMpWVzUcX3jn9QGrn2HQVQ1Giz0uc+LmhGO7QAEqF/wpLUA86v0lK+LztFNyKK1vXcHG//JTBUXl55OOXuemwTOGH2L/Rdaga+EmDAR+UqFZKVHrKTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkZKT2lOeitnaFUreFU3RjR1UzVSTW5JODdXSmxZa1NGc1dXbmVSN1VCWkI5?=
 =?utf-8?B?ZVp3ellNbnNUcXZMc0tNK3FKMG1iOWVsVlRjZFdSOW9vK1NncWFiRmhnQVVz?=
 =?utf-8?B?VWRQWk53b2tSb2JhYk1xZDRHWUdzWVJtSXBwY0pEVlozUEFOOGw2UkI5d0Rt?=
 =?utf-8?B?ZVAwLy9Tc1l4OWExYk5hbkczV3JuY1Zsb2xqeVpHZHBDaWVSMHZxZ2JZTTZE?=
 =?utf-8?B?R084Wlo4aWRaWWI5Sk1JdElDdXVPbXNncDNuR0Z4cnkxUXNES3hVVG14Zk9i?=
 =?utf-8?B?QUtBWE1rY1FRbFo0R204S0kvemdOd1pJUTlYTXAxNWtiWU9IQmRldGRvRzFN?=
 =?utf-8?B?ZVIzZ2pmS2VZU2FVb3U5VEd5dXRpSGJHdFNnZ2ZxOVB1TkNGOVJFcHBETFZJ?=
 =?utf-8?B?RHozamJNaVNFRVU2NFZrZmVrN3lLUjFWNmlXWVM4Z0RSWGx5VGFnM1BzQm5C?=
 =?utf-8?B?RTBxalY0VkJnM0tPVGZYV2tjeGJWbnZzSk5HUmFYbG9VY1NYRjBRd254eTM2?=
 =?utf-8?B?Q0tCL2d3UFlNU1hnS1hBK3gxNUZhc2w1THFZbkxJdC82SUZQZ3BkZnlwQWU5?=
 =?utf-8?B?TlhCS3NrMU8vcDZqSjJIbDc1eHBVcS9qN1BiNmNLV0E0SER1Q1ltd2dGWkpE?=
 =?utf-8?B?MGh3UzJtNzFERCsyMWl6YWJ3dUJ3bFRJQVcvdlRUYWViWmlRSEFVZzdEUUZj?=
 =?utf-8?B?OVlhK2FTbld6bVA0YlE0N1F4ZG1jNk9lNERaVGlIMTJmRmRxYVhnNjJ6QzFq?=
 =?utf-8?B?bDRIWS9LVHdpZjJ3T2VtY0tSTHB6bndKc3JNbWZDaTU5SzY2enRJWjNyOVVR?=
 =?utf-8?B?a25CN3liNnlUWklLR3J2S2R5ZTlqbTNOME1ldzNURTJ1UVJJTHF5TWRSRyt5?=
 =?utf-8?B?SlI3NkVETHBxZTV4N0J0MEdBVW1SZXBVVWVCRjhYREtpV0l2VHhaa0JhazdW?=
 =?utf-8?B?MitrRURhZVozeGhsbS9zY0RzeXZtUHVaMDJJWjlzR1ZZM1ErbDhoUDFmamIv?=
 =?utf-8?B?eHpYa1pxazlXQlJpRnNxM3Y1UG9sYlVmZC9SWkt5R29yUmdLbFBnaFhZL2li?=
 =?utf-8?B?QmtDdWRyVzZnRFFGWTZ6SUZ5U0NzR3l6NlBXMDNWZGQzcnZ1aFRBNTUxM2Rq?=
 =?utf-8?B?UWM4cVY5bVZVYi95YXZmN3Y1WHQ3RnVKSW8yK0hqQ0NldklQV25qYW1yejI2?=
 =?utf-8?B?T0ZjRG1RaUpDUkZ4KzRETEpyZ3liN0s0QmwzS3U2MkNDeW8wTjVkTHJzWHQx?=
 =?utf-8?B?RDhwUjFiYkZOS3owenhMaE94RC8rRU5tZjN5WDJaN3diTHVUV2ZhMDZYWGtR?=
 =?utf-8?B?OGozbnQ5Vm5RVkdmOHdJTkFnTnlUY3N5bmkxV09xUzNzTFphNm12alh3c3Fy?=
 =?utf-8?B?U0puSEZWTXlYWTU2K2JwVUgyUkVPbkNlb0puTUVNbDVIWDVFaVZ0Z2hLK3h1?=
 =?utf-8?B?TlVSL2NkNmlkNUpINWRaV0o3M0FZT09VOEMyUWZFcXRqYVpsM253a1NZdnBK?=
 =?utf-8?B?R25PS3VGWmNNT3VnM2VuL0N3cXdNNTVWd1ZzODB0TkZVVDJ2dW5Pbis3bGl1?=
 =?utf-8?B?a2hPNFNrRUhGbnZoejRTMy96WWlmQ21GU2c3NTkwUmdDdXBYU1VFUDJQLzZY?=
 =?utf-8?B?eGhnQXNNUDd1MHRseFdSNTlwbjF4NEdhVEF6SW05dkVidUxRVGlLSXF0eElO?=
 =?utf-8?B?ZjFtTTdRM1FMckhWeTNZYWxCUVE1UkROSzNpTE9TM1BGWkpuUkcvT2kvblNZ?=
 =?utf-8?B?cFNxNG9hYTl6QU9Vdm5FVkhmd21Pc2d4REhNczQxdVBZc1BwM3p6ZlR2L2RW?=
 =?utf-8?B?cHpQUnhFQy94Skp5bVVxcWthejNPanNETk9vZlpnQk4zeFIybVU4aEp5Q1lM?=
 =?utf-8?B?cnl6ZGVET1lobGFwbDRGcUJrM0tsMjg3Q1lPWnB1aW5paEpPQVZxd0xaVUx6?=
 =?utf-8?B?YkVzc2lIdzZlZjZjblY4RWNpY3MyS0taLzJkQ094c3FpT3JHQ05BV2hqL1Bp?=
 =?utf-8?B?dXo5UXdzSmgyS01mclUyaVpMYjd3QjhZMjNDNW1pVG14LytHZDJrb2tuNDA1?=
 =?utf-8?B?RW5mRTRCY3FoUWFTVmk4YVBXNXpqdGNtTHlKNVBjalFqOC91dk9teGx6clh2?=
 =?utf-8?B?OUlmNEFNWWZSYm9rZ0VkdEllVXh0SDVsRk5VQXZCUWxWK0Y1dEhtWHlhQU9H?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0f87a9-69b6-4f6f-a295-08dc5f6708c2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 05:18:51.4217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXqRNtiB3mtIn8hSVOUzl+lb0ucrVJ4FCAkilt09gYZRxu8ZIMtBhHlLBqBN/xFk1KjXp0xW9rNvQPKAVsEBthC9zevKNfp68o5WVUzcKd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8004
X-OriginatorOrg: intel.com

Hi Dave,

On 4/17/2024 7:41 AM, Dave Martin wrote:
> On Thu, Apr 11, 2024 at 10:39:06AM -0700, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 4/11/2024 7:16 AM, Dave Martin wrote:
>>> On Mon, Apr 08, 2024 at 08:21:24PM -0700, Reinette Chatre wrote:
>>>> Hi James,
>>>>
>>>> On 3/21/2024 9:50 AM, James Morse wrote:
>>>>> The mbm_cfg_mask field lists the bits that user-space can set when
>>>>> configuring an event. This value is output via the last_cmd_status
>>>>> file.
>>>>>
>>>>> Once the filesystem parts of resctrl are moved to live in /fs/, the
>>>>> struct rdt_hw_resource is inaccessible to the filesystem code. Because
>>>>> this value is output to user-space, it has to be accessible to the
>>>>> filesystem code.
>>>>>
>>>>> Move it to struct rdt_resource.
>>>>>
>>>>> Signed-off-by: James Morse <james.morse@arm.com>
>>>>
>>>> ..
>>>>
>>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>>>> index 975b80102fbe..8a7367d1ce45 100644
>>>>> --- a/include/linux/resctrl.h
>>>>> +++ b/include/linux/resctrl.h
>>>>> @@ -140,6 +140,8 @@ struct resctrl_membw {
>>>>>   * @format_str:		Per resource format string to show domain value
>>>>>   * @evt_list:		List of monitoring events
>>>>>   * @fflags:		flags to choose base and info files
>>>>> + * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
>>>>> + *			Monitoring Event Configuration (BMEC) is supported.
>>>
>>> [...]
>>>
>>>> Reinette
>>>>
>>>> BMEC is an AMD term. If MPAM is planning to use this member then this comment
>>>> should be made generic.
>>>
>>> MPAM can (at least) filter reads and/or writes, and it looks like James
>>> is expecting to support this.
>>>
>>> However, it probably does make sense to keep the comments neutral in a
>>> common header.
>>>
>>> Would the following work?
>>>
>>> 	* @ mbm_cfg_mask:	Arch-specific event configuration flags
>>>
>>>
>>>
>>> I think that's broad enough to cover all bases, but I'll wait for your
>>> response.
>>
>> Since this is exposed to user space, ideally all architectures would use
>> the same bits to mean the same thing. I assumed that is what James intended
>> by placing the existing (AMD BMEC) bits in the global resctrl_types.h.
>>
>> Reinette
> 
> Maybe, but the bits as defined by AMD BMEC look rather architecture and
> bus specific, and I am suspicious that there is no guaranteed clean
> mapping between MPAM's config and BMEC's config.
> 
> MPAM currently just has "reads" and "writes" (or both), though as for
> BMEC, the meanings of these are not fully defined.  I suppose finer
> filtering granularity might be supported in future (at least, it is not
> explicitly ruled out).
> 
> James' current approach seems to be to pick a single BMEC flag that's
> in the right sort of area for each MPAM bit (though not equivalent) and
> translate that bit across to drive a corresponding the MPAM bit.  But
> I'd say that this is arch-specific configuration masquerading as
> generic configuration IMHO and not really generic at all.
> 
> See "untested: arm_mpam: resctrl: Allow monitors to be configured"
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.7-rc2&id=db0ac51f60675b6c4a54ccd24fa7198ec321c56d
> 
> I guess this needs discussion with James, since there will have been
> additional thought process behind all this that is not captured; either
> way, I guess it could be resolved after this series, but it will need a
> decision before the MPAM support is merged (or at least, before MPAM
> exposes userspace support for event configuration upstream).
> 
> (If this has already been discussed and James' current approach has
> already been agreed as the least worst option, then I guess I can live
> with it; I just find it icky, and it looks odd to have AMD specifics in
> a common header.)

I am not aware of such a discussion.

Sounds like a motivation to delay this portion of the changes in patch #8.

Reinette

