Return-Path: <linux-kernel+bounces-149525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6638A9277
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693B41C21878
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB4355E6C;
	Thu, 18 Apr 2024 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRp9DPbb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB2C54BCC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713418512; cv=fail; b=BwjNtJZSC/+j5l3bJq4s7Qz750lceKD4I8KS2xJq260hlWf6RpnvbE1ZoTmCt5jhWqZuDjU8Hss39tY9rdIwSC4KYcTskAH1k28d4mDuZOc0kamIFaLb5tqnU7eIhkgzh0Bfqa7juzrohI8sAYnFgxZA4iW9ytnEvDr/YBEGGFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713418512; c=relaxed/simple;
	bh=OepM/RyQwb5sdf9ikhy16Xn84E4GDkr4eZzCce1/spY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CriVXdgvrch8HgcYzfO6A1LZagSpVT/n0hBmD7jnSLC2OpjjUzMvxPkvfoEzcJ2oA0kSZFUiL+0EdHVOxWcLaD7R3BIBVG46JgQrwHAs3rcPPyXsTWMRzKgMFqQrZoQ8/w1VRnRaDJUMpithQao8QhjO5QtPFFb+dRECMbcLkTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRp9DPbb; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713418511; x=1744954511;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OepM/RyQwb5sdf9ikhy16Xn84E4GDkr4eZzCce1/spY=;
  b=kRp9DPbbSzkMH+ZmICMHz0wUce/HWSsQUYjyIe6DxiRQPqXm64e2fxXN
   n9R40kOMk43SUQOUlTVpTJqJIAN61NndzfZA7lWBK8wZGgnVTyYJWTztp
   uEI3Jr+0TRQIOmgv0ZIZq3BML7EeCKHQKx1zVbwRFeF1hq2HsW/wBgIgf
   WmK1Umlisnj5jfyDiQ8jVAOMgHQWYSWBY0HZ/TsZ8yjaFIZOVBAGwFrrH
   DjxXMs5Nwp/RAPCPLUsXNHPv330W/TYWFobUjunz5lFBdxJr3LU57C7Ak
   aYSqdBp7/EQQ5uiScmZQINbplh/yIxiWAlInBqc1WRj8Hae1YVjz9KwDc
   w==;
X-CSE-ConnectionGUID: R4wGk590S8+B2XlBcRoUiw==
X-CSE-MsgGUID: DWGVlNhkS3q2DffHOGmQFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20089771"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="20089771"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 22:35:10 -0700
X-CSE-ConnectionGUID: OiJMsZzUQhiJ+/JqFml6FA==
X-CSE-MsgGUID: 5N0XB/deRrGouwbYUkr1Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="27520514"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 22:35:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 22:35:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 22:35:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 22:35:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxRw7S+CtE1OUy5T9aUvAFQnc7SddpxNBrw3XE3zKnj84Q3R00g7VXMtUREbagdAIzZeEfd55wGy1EIAkfaUu0Sh914Uhhu8ma4DZuGsUQXBfEuK218YkbDohnhvY99KeXq/13fV1WWwTsMslSsoSglbcz+5geE8ae/S/grn+4dFshxXOPRXzfkZWQuMMwx36CcSKEp54fODrH71syjHFVSA3np71hnWNX5nVSwkQdUJi5nSGp04gSH9wQsCW1hBBOiBVxb5ZNSi9hjrC3FWyU6sXdq8t5/7UjMtPZvsGOMemAURSps4WfGsYN1sUYztQfHKLG2UXBZb9mB5c24Y5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxTvXEM/JUquWLMl4LVL6RtYVEmLDL59vbno9sTcFoY=;
 b=ecx2MTFijxVeou9pNu6lRypw90KhaE/N9O7JTJVOR7l0+5qEhUFaTj8hIv51AF7wWknNNeaDm5GpRQTqemEQKzPMleoG+F97hchjAs/0jZBTX0evlHepDdBXSUdckS0s8jcLQ3OBMUJaf4cgoNra4SinUv0T4Bt2zXilPM80g+FlrB1gMkDlLx8y/l2fL22oWnaa1tkLHLoVd1OU7H3bZ4fAwSaUCo+UoyAMEWZn+7g4IYTj0dEqgBUDAdHqfxCB0bk5KPoYmFBeq2gsIUOQtAzzU5a9jSsG9+t3Po5MXuWJIrGE3VpTzudZEgVEtjMf295GJaZ9m6HCH5cGWOYnLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6220.namprd11.prod.outlook.com (2603:10b6:208:3e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 05:35:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 05:35:01 +0000
Message-ID: <b2595743-c7dc-4946-884f-ff159bc4865e@intel.com>
Date: Wed, 17 Apr 2024 22:34:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/31] x86/resctrl: Move ctrlval string parsing policy
 away from the arch code
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
 <20240321165106.31602-4-james.morse@arm.com>
 <e85e7786-7995-42d5-a5ac-1e08a84492fe@intel.com>
 <ZhleZ2q60ysIRapv@e133380.arm.com>
 <9daa5c12-c43d-4069-b2a6-c505217e2387@intel.com>
 <Zh6kRMkqVpu0Km4l@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zh6kRMkqVpu0Km4l@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: f740789e-7ec3-4b32-3714-08dc5f694a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBgFxSgPndLGnlU7jg4j7Q6asXPa4eubojpObJOAfLOnn11uCcIw4KPTScACgEgUXgT1oTKybmM5/tCmH32rjvv1vup4GnqP/GAhWpYHAUGBE8FnYmzdFpWLp9U5qvbfXZyOWC7PydDB03LOkP8WUQQLNMwXZqoh5KY3Q66QZJgNyf1AkGV6BrptQ2lFPZkXoEj3JMhEDW+MyhzKbbrB+aX2RZSpElW73fwo7cjeSehZ+vNgg1knSW+e7Yy81Llt3ZIyIzVYYzU52hRSDXCVHwcya9cZIaSJ3gKB+kuYRalFYa55kq+F84NF2DbHlSGqeyZcCRyS2kzdzQP59uEMLKpu8H7yK2+b1yy11mMMTt5x/hVfQZyqgciVmyMRqjqiAS9Q/ZEgtjVEoAjNNC5xpbbiQsijsXFeflUht++Em/G2gd/m8hV6LmzmqxokwfIBBiGE3y/lseRA+uZ+HOJJXYQH5L+XJt2Y5TImAWWgkW6VgHItCiT64J2BLf9K4wSdngMOhTIsZTedRnGf3UsviW+Q/kNma2obkOshRjB5n1g2bZPfM4rha8MY0FTXaldm49KYl83gTYW7staFCEYQp+gvbdOKjZGnV/j/D6ImRF7YhVTRk7QHArm1pQ3Dz1bAq8EyXcVa5P7MdtjJQzBX8TRXjgYZxHCkA0YZAolktpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2czSGIwUWtqQXVqTWFCWmZ0b0lPMkRLVE5keTVqYmNmR3FZemdnbWRadkhR?=
 =?utf-8?B?Q2wzakVZdmhjZWZOSVgxaHE4ZlJTUzNwT0pnNEVCc2o3UXJIRlF5N3NwZm9K?=
 =?utf-8?B?Y2o5ZURBM3V3a25HOEwwVWdadjN3U01nckc3TEJFMUZUZDVQdnhIRXpJUSt0?=
 =?utf-8?B?SnlxU2RMRVRKeGVTYUJ6WVVEZXU0TXV2UGwxTDc4WG5TWVg3T3NldnQ4c080?=
 =?utf-8?B?Z3pLdGRlNHFESG9OckxIdlprSG5vUEJFbDFiMVp3UHNmV0FTYk9GZFRIY3dQ?=
 =?utf-8?B?VXNNZ1M2Ym1TUllDcnA1S2hIc2h0R2hkd0UzOUlsOW1uZkJwRzR6N282cnFM?=
 =?utf-8?B?RXBZN2x4c3J2UzgyTUZUa21kL25PQkF3RlZLTGFFc3dPOTZOUUEyaWNuS055?=
 =?utf-8?B?TlluZCswaEs0L1FNRzJCQU9HaWE3NW9kNGw0ZXJCR3hFUDdLYTMzQTZIMjh2?=
 =?utf-8?B?cmRLUTRFZDJvV3c0OTI5WlNjZktmUDFuMUtTQnJ2U1BpTjFtUGF1U1JwcVN1?=
 =?utf-8?B?eUc2QUNyNU9aQmxnd1c4d3hxa0dsc3l6Y3M1SlAxdFlPYmZaZEdyWUZOUEtk?=
 =?utf-8?B?SHVOMjJRUy9MNVI5SW5PekhMTjhwOG13TzMwZHRkTUZUWldOc0hMUnhlRm5p?=
 =?utf-8?B?ZWJVVEJPR3NudkIxWUhNV25oUWIwOUZxVE8rMkpVWGkyaGtsa0dyWE9VNTU4?=
 =?utf-8?B?RzZBYVRicDF2ZHFQRHRoclYxdkxoK29uTUVQR20vNUpIaGc0ZG1YMzlKUG1r?=
 =?utf-8?B?ei9SRHkyOWhkb1dMUVNoNVpXcnRidTJ5QlhSOUoyVnRwMi8xL3ROdnJJekxr?=
 =?utf-8?B?OFBjcTU2bVZFOFdXandhL0xIYlBlU0hvQ0FhNWo2RmFNZDJWS2UyRFVKd2ti?=
 =?utf-8?B?L0tsS1RKV2laZkZDNGtTbkV4VHhla0U1MG9vRk1jYVcyRjVWaWhPS2RrTEhv?=
 =?utf-8?B?SWlDcEVNUGdNUkdJeDZyUGpLOGI2WTBBQzVWWDNjd3hLWXlJRWJYZzZFZHMv?=
 =?utf-8?B?bkZsRVNiMUJ5OERvTUZxeVhaVUdmc0FUODlyaTBJZVFTS0hxcG9RSUJWSDdT?=
 =?utf-8?B?MnJoM3UrL2lCaE9lL0l4WWRGNHA2Q2R4RGZ3R2x6aG5PUDQyN21KZml0OHRD?=
 =?utf-8?B?TFVXMkxLVXBuQ2Zuek9Kb2xORm5uMUI5VDI1YTVhNDdrMGk3ekhXaWdhU2dQ?=
 =?utf-8?B?N29ZQkhoZDhHZjNFcXFoVWJJcU1NT04vbUkySTcxMmlwK0NPb2wzQTI1VW5y?=
 =?utf-8?B?ZjFkYlRrZXZEcFUrWGx1WkVDT0ZaSnlJVThtSGVaUExVMm4wbjBPVDFsVXpl?=
 =?utf-8?B?b21Ia3pseFprQlJOdFBiYjRlNnRtM2cwekcyblBXc2RTKy9ITkdJNFQrSHha?=
 =?utf-8?B?ZkRuc2ZWVWdhTVpRQWYyWmJyNERjdmlZbzlaSG1wYnJIaHBRQ2VlVWxPU21m?=
 =?utf-8?B?VTRrMFNCcTR5bWJSR1NqMHdJOFhobkNFY1JMRmdVUEo5OU1tcm9abXc4bWFj?=
 =?utf-8?B?b1pSRmdrYThnMUFGakVIZ2wyS3ZZc25xU2VQV2NWRzhaV2UxWGhmSGtNQkhn?=
 =?utf-8?B?QVdMd2xCTWhDVng0QzZJQ2U4WCt1d3pCNUlrYUdZdDJuZ1BWaDRvQXM2ODlp?=
 =?utf-8?B?N1F0NlpOa3J5S3RIemZvUVh0bUU3OXZYLzlZcHFKTjA0VEJMQTNNa2xiWjRj?=
 =?utf-8?B?TVV4d1FqanJkYkRuNzBvY3BXUUlNYVJIMmJCdWV3MUhnSWxQSjNJcENNVFFP?=
 =?utf-8?B?N1pXVDh2QTlpR3dZQ3RJcXJLOVJDd05yYzJoZmFJRTBMdkgzbHZrbXRodWN5?=
 =?utf-8?B?RU40Z3FhSU1YQWdRUTRPSDlOY09lV0UxZUwxWEd6V1JCeFl3S3pNRUJpa2JE?=
 =?utf-8?B?ZkFxVXpOdWFWTy8vYURGS0pUbEJRcU5IYmlYaUNGU1pPTUJ1TTU3aUNJelo5?=
 =?utf-8?B?UjYxZ013N0xib0VDeEVSRUVjTi9iWDZhK1FtK2UrLy8wS0ZUbCtGd0V0S1Fw?=
 =?utf-8?B?L05OU1l2K3ZzNUE1eW92KzJRTXdFeHNia25Od1RUb1cwOHh6MkhYR0JSTE10?=
 =?utf-8?B?Sm1YNjNXYU1kK2U5c3l3eU1hY09yNmFSenlISm5pYjAvVGpHUUR3ZWh2SW12?=
 =?utf-8?B?MjJYbDRCeGlKTWhoUlNTendoNWpVSmx4bzE4V2pia2llNDRtOXk0L2lYVkFj?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f740789e-7ec3-4b32-3714-08dc5f694a99
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 05:35:00.9590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6BNxU8hYQxo6XInQ4RfwF2re7fkhuWB83mvct+NCQPunzdpkMFaUHo3KC9DRx2X0EHcPGHLzSD/Of4rP3FstH3rTx1Ch11l/6TQBzExAZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6220
X-OriginatorOrg: intel.com

Hi Dave

On 4/16/2024 9:16 AM, Dave Martin wrote:
> On Mon, Apr 15, 2024 at 10:44:34AM -0700, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 4/12/2024 9:16 AM, Dave Martin wrote:
>>> On Mon, Apr 08, 2024 at 08:14:47PM -0700, Reinette Chatre wrote:
>>>> On 3/21/2024 9:50 AM, James Morse wrote:
>>
>>>>> @@ -195,6 +204,14 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> +static ctrlval_parser_t *get_parser(struct rdt_resource *res)
>>>>> +{
>>>>> +	if (res->fflags & RFTYPE_RES_CACHE)
>>>>> +		return &parse_cbm;
>>>>> +	else
>>>>> +		return &parse_bw;
>>>>> +}
>>>>
>>>> This is borderline ... at minimum it expands what fflags means and how it
>>>> is intended to be used and that needs to be documented because it reads:
>>>>
>>>> 	* @fflags:		flags to choose base and info files
>>>>
>>>> I am curious why you picked fflags instead of an explicit check against
>>>> rid?
>>>>
>>>> Reinette
>>>
>>> Is fflags already somewhat overloaded?  There seem to be a mix of things
>>> that are independent Boolean flags, while other things seem mutually
>>> exclusive or enum-like.
>>>
>>> Do we expect RFTYPE_RES_CACHE | RFTYPE_RES_MB ever to make sense,
>>> as David points out?
>>>
>>>
>>> With MPAM, we could in theory have cache population control and egress
>>> memory bandwidth controls on a single interconnect component.
>>>
>>> If that would always be represented through resctrl as two components
>>> with the MB controls considered one level out from the CACHE controls,
>>> then I guess these control types remain mutually exclusive from
>>> resctrl's point of view.
>>>
>>> Allowing a single rdt_resource to sprout multiple control types looks
>>> more invasive in the code, even if it logically makes sense in terms of
>>> the hardware.
>>>
>>> (I'm guessing that may have already been ruled out?  Apologies if I
>>> seem to be questioning things that were decided already.  That's not
>>> my intention, and James will already have thought about this in any
>>> case...)
>>>
>>>
>>> Anyway, for this patch, there seem to be a couple of assumptions:
>>>
>>> a) get_parser() doesn't get called except for rdt_resources that
>>> represent resource controls (so, fflags = RFTYPE_RES_foo for some "foo",
>>> with no other flags set), and
>>>
>>> b) there are exactly two kinds of "foo", so whatever isn't a CACHE is
>>> a BW.
>>>
>>> These assumptions seem to hold today (?)
>>
>> (c) the parser for user provided data is based on the resource type.
>>
>> As I understand (c) may not be true for MPAM that supports different
>> partitioning controls for a single resource. For example, for a cache
>> MPAM supports portion as well as maximum capacity controls that
>> I expect would need different parsers (perhaps mapping to different
>> schemata entries?) from user space but will be used to control the
>> same resource.
>>
>> I do now know if the goal is to support this MPAM capability via
>> resctrl but do accomplish this I wonder if it may not be more appropriate
>> to associate the parser with the schema entry that is presented to user space.
>>
>>> But the semantics of fflags already look a bit complicated, so I can
>>> see why it might be best to avoid anything that may add more
>>> complexity.
>>
>> ack.
>>
>>> If the main aim is to avoid silly copy-paste errors when coding up
>>> resources for a new arch, would it make sense to go for a more low-
>>> tech approach and just bundle up related fields in a macro?
>>
>> I understand this as more than avoiding copy-paste errors. I understand
>> the goal is to prevent architectures from having architecture specific
>> parsers.
>>
>>>
>>> E.g., something like:
>>>
>>> #define RDT_RESOURCE_MB_DEFAULTS		\
>>> 	.format_str	= "%d=%*u",		\
>>> 	.fflags		= RFTYPE_RES_MB,	\
>>> 	.parse_ctrlval	= parse_bw
>>>
>>> #define RDT_RESOURCE_CACHE_DEFAULTS		\
>>> 	.format_str	= "%d=%0*x",		\
>>> 	.fflags		= RFTYPE_RES_CACHE,	\
>>> 	.parse_ctrlval	= parse_cbm
>>>
>>> This isn't particularly pretty, but would at least help avoid accidents
>>> and reduce the amount of explicit boilerplate in the resource
>>> definitions.
>>>
>>> Thoughts?
>>
>> I understand the goal of this patch to make the parser something that
>> the fs code owns. This is done in support of a consistent user interface.
>> It is not clear how turning this into macros prevents arch code from
>> still overriding the parser.
>>
>> You do highlight another point though, shouldn't the fs code own the
>> format_str also? I do not think we want arch code to control the
>> print format, this is also something that should be consistent between
>> all archs and owned by fs code, again perhaps more appropriate for
>> a schema entry.
>>
>> Reinette
> 
> Fair points, I guess.
> 
> For the print format, I was presuming that this ought to be consistent
> with the parse format, so probably a core property too (until/unless
> someone comes up with a convincing counterexample).
> 
> 
> Would something like the following make sense, if you want a less
> informal approach?  (Modulo minor details like naming conventions etc.)
> 
> 
> /* In fs/resctrl.c */
> 
> struct struct resctrl_ctrl_traits {
> 	const char		*format_str;
> 	ctrlval_parser_t	*parse_ctrlval;
> };
> 
> static const struct resctrl_ctrl_traits resource_traits[]  = {
> 	[RESTYPE_INVALID] = {},
> 	[RESTYPE_MB] = {
> 		.format_str	= "%d=%*u",
> 		.parse_ctrlval	= parse_bw,
> 	},
> 	[RESTYPE_CACHE] = {
> 		.format_str	= "%d=%0*x",
> 		.parse_ctrlval	= parse_cbm,
> 	},
> };

It is not obvious to me that another layer is needed here. format_str
and parse_ctrlval can just be members of struct resctrl_schema?

> 
> static bool is_resource(const struct rdt_resource *r)
> {
> 	return r->fflags & RFTYPE_RES;
> }

I do not see the usage of is_resource().

(I think we are now discussing both this patch and patch #30 here)

Here is part relevant to #30:

What I was thinking about was something like below that uses the
enum you introduce later and lets the RF flags stay internal to fs code:

rdtgroup_create_info_dir()
{

	...
	list_for_each_entry(s, &resctrl_schema_all, list) {
		r = s->res;
		if (r->res_type == RRESTYPE_CACHE)
			fflags = RFTYPE_RES_CACHE;
		else if (r->res_type == RRESTYPE_MB)
			fflags = RFTYPE_RES_MB;
		else /* fail */
		
		fflags |= RFTYPE_CTRL_INFO;

		...
	}
	/* same idea for monitor info files */


For this patch the resource type can be used to initialize the schema
entry.

> 
> 
> /* In include/linux/resctrl_types.h */
> 
> +#define RFTYPE_RES			BIT(8)
> -#define RFTYPE_RES_CACHE		BIT(8)
> -#define RFTYPE_RES_MB			BIT(9)

The goal is to not have to expose any of the RFTYPE flags internals to
the architecture. RFTYPE_RES_CACHE and RFTYPE_RES_MB stays, but is
not exposed to arch code. I do not see need for RFTYPE_RES.
All the RFTYPE flags can be defined in fs/resctrl/internal.h

> 
> /* For RFTYPE_RES: */
> enum resctrl_resource_type {
> 	RRESTYPE_INVALID,
> 	RRESTYPE_MB,
> 	RRESTYPE_CACHE,
> };

(I find naming hard ... note the names changed from the beginning of
pseudo code to here where RESTYPE changing to RRESTYPE)

> 
> /* In include/linux/resctrl.h */
> 
> struct rdt_resource {
> /* ... */
> 
> -	const char			*format_str;
> +	enum resctrl_resource_type	res_type;
> 
> /* ... */
> };

Yes. With the above architecture code would only specify if it is
cache or memory via enum resctrl_resource_type and need not know
the individual file flags and can pick how to format and parse
data based on the resource type.

> 
> 
> (RRESTYPE_INVALID would just be there to catch cases where .res_type is
> not assigned.)
> 
> 
> James might also have other thoughts about this when he gets back...
> 
> In any case, it might make sense to detach this change from this series
> if we're making more significant changes in this area than just
> splitting the code into core and arch parts.
> 
> (Note also, your suggestion about indexing using rid may also work;
> I tend to assume that the mapping from rid to resource types may not be
> fixed, but maybe I'm being too strongly influenced by MPAM...)

Reinette


