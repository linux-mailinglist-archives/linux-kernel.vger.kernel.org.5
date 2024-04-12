Return-Path: <linux-kernel+bounces-143250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FFB8A364C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9751C220A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5474914F9F7;
	Fri, 12 Apr 2024 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ldi4/mVn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EBA142E78;
	Fri, 12 Apr 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949914; cv=fail; b=prvFXBOn9SoNxfBRRJODCE2GP0hp9N1FBms5oTKaRK/cfQ6r1vh/MNlItK7Szn+xjT0ZD+r7kAgcQWudI8Spg1hjNc5UuZfo7pOPyuKBAihj/oCfWDtClUtQT4/uotmqXEfPyiR5qVKSXwLRwp7bki09t/oX3Ib0N6IdSamtQc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949914; c=relaxed/simple;
	bh=WSCgMA+g7Oij0dl5PNqk0ATGxDEP/DIRnEdHdbGLv0g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y67UY/IgJTGFXRNKwMeCW0WMtW/tP6VSwqc1zVGRxHet3d2z3eWQs2QiM2vDjSBf9CfVG0jofVVhzNsj6N9n1udHJere9noZuluKGB0LqgZzPZOqXbrdYVO9zsa/+GBwQWHYO3GP29AXVYgs9VW+akIjKcBPUgTh28vvzzGXuuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldi4/mVn; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712949912; x=1744485912;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WSCgMA+g7Oij0dl5PNqk0ATGxDEP/DIRnEdHdbGLv0g=;
  b=ldi4/mVn+rTgosSXpkY7hn6slKHAas8VxBAfCgxo772dK0XxIsnqgCS9
   WlH9ykXBT9e2NwCJPKEdo51ZY2jVsuttUJpt1jPmX/fbAugcQ3tDxUq7n
   EXzV3iL6haHB92i24HSaVGllSA+qy9CXwzVdd6htEOU0Tq6PWww+bgRrO
   itw/KHCAtwgmKoHj+kzs8ulMH8ouPuazoVUtgr1PArBI404ACBCaM4SxO
   YAc2Q/ptth5/Nvs4DLGMBa/xaOIXPMdX4ggaiLIw1m6m6PrmKUGZdjSU7
   H8nhPWOU5KMM/d/jlthYHy6d8pompXBALCZoSLNEgCoUeurx5vk2j7VKR
   w==;
X-CSE-ConnectionGUID: E701CFlBT7W2jnAU05gNhg==
X-CSE-MsgGUID: 7jm2O+RaQOC21oZH84mkuw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8635270"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="8635270"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 12:25:11 -0700
X-CSE-ConnectionGUID: cTMnP3IvQyWz+R8j/8p76Q==
X-CSE-MsgGUID: iZjOBULgTRyaObbiaDBIDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="25746608"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 12:25:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 12:25:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 12:25:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 12:25:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 12:25:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibWco3AKvhF7I3C4Vv3W6kYxMk7SEF8aWPAeAsjzh9eCciwYlsP5aNgrPvEynqroZmG0piulzpZXeos1SIoQ+d/jOMR8HOFQyVanKbpIRnJpPYBRkGjmaebYmn4XgyzSyKr4SqXn5ZtRjrYK/LkearT96FFBaqs8Vi3nso7NjApiGqT5lhiW7KIX89wetTRsL4rBbzVJgQX5graNy8VjST2SLID/Q1+CbflZZqIKekGjURQy96zkLC+yefNbhAe4gL3A+Rtt5OHgRtDJlO0rOl9K3rn6t1+vgEQmsZCEYww0zmdBDuL/VoFHpX/N7CDVACc0N/7CBa3/Vk8I/CKvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0/nC5BO7k6XWHEqni88X4D/1cTOoZpyVu0yTMDaWA4=;
 b=lCRs8tNvbJMLQTLqvAN5qibnHerae/QBMcTihi8d85hCHzdkHkErm6YNy0/Gfaca1SjfLfAuDrpk9/Oe8UkjNUx/S4VTS54aHIbi2MhgvnCg/jjHyjL5GCFpQY4Us+NHcsll6rrKK/x8ylvaVbVLwsbS6eStFqa0Pnti7c4B4YAS9IG4HhfaAKFCXkqR3Wpa5B4FupWjco9ZQcJ4voPy5xg/iprnsRQV5n4ohfdfkQWqg0ZD5rkjtesM6k8mYuYYdxoNarmIPiGzPSGMhiwumfzYgfzoh8DnAlTUeJ9Qot6ZR6EVQU39IEr2smYYzJAWalFuINeCJrBKXdlkK8e/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Fri, 12 Apr
 2024 19:25:08 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::85d1:70d8:4c39:4599]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::85d1:70d8:4c39:4599%6]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 19:25:07 +0000
Message-ID: <872e3687-8431-4456-9f87-13321c19ba17@intel.com>
Date: Fri, 12 Apr 2024 21:25:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Support clean reboot after hibernate on Arm64
To: David Woodhouse <dwmw2@infradead.org>, Will Deacon <will@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Robert Moore
	<robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240412073530.2222496-1-dwmw2@infradead.org>
 <20240412140515.GA28052@willie-the-truck>
 <1d7a7c6e73b4bf3f2177dca0e45d375e77e8388a.camel@infradead.org>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <1d7a7c6e73b4bf3f2177dca0e45d375e77e8388a.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::12) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|DS0PR11MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: ea19e04c-2d7f-40db-fdc7-08dc5b264344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHouIxvUi52/felck5YL8RkGPxOXVdRies4mFabUxWEIo4S+TKZ8B2W2DqfXHyCZ+qd+vVNMLcqT7zN+l4kHhKzTzcYuMjNqafWRbH9TTXZsZZnomPd3pKinuiEKR96aYvgJ3Dy7HZh68uO2PBPObGwX+1rOWcl7RQX1w1cmV+bhw8CZ3I7kipT0HzIH0dWbODEBLZn2BVZiLRwd5U96Q6hdeO3qUt4NzT6SVNgq3t5YUUZuP+bfg3KV7WDvODQpw6n1Wdqr7US+8MCYMhtBpUIspxd/mbxqGiLRHJ2iIp6VKQANsus8Rd+EBeI3wwTJ3Gg2RR0xMPkLrPiLD1D0jK7NYAAH2TvQ1gRIVfNSZ7+fovT1Mf6clPCC7QWrGT9ZqPnZcBx1LK+ihFdG9c4D6aJe+Mjy4KTtP7ASjunvNOv3l1WVLhTcSJBQdeBgJ/v8LuSOyyGdxpHCMDhW2/QMJMbm+2WhJTI8sHQlXdJylfVB/YdDW0JMRy3Y1WylY9rwUl9QzSMEl02dtpEXEciD0g6V1D8jZ1utK3K6fcsDzVKDih5VS72d0QZwI6x7/ptUMM01ul4EIG2Ygl+jbKmzBc1cAL3b/93l4fqOo3H2BPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1o3Sm9qQVkzb0Fpc0pjajNRczRlZEwvZkJ1aWdmU3JxdmV6dFBVMDJlQmR1?=
 =?utf-8?B?MUwvNklyQXZaSDhMNlo3ZmVUSkI5azBtOFQwMW1qYk00amFwSWpvQkFkeDRt?=
 =?utf-8?B?a0J1OHVRdEVsMHFUc0xXVnZqalEwL09FMHlrMjRUQVdVYSs5MHRnM0dvQlJW?=
 =?utf-8?B?L01xNnVZdUdSSE9IQ29MazM0cGNOaHk1VFBVZHJrNXJyMjB2bkE1QkZBT3Ux?=
 =?utf-8?B?T0pZMXk5blRZVE9USUVGdkxjQlVmaFVnWEE4ZVRleXlOU2ROS21uRTBQLy9t?=
 =?utf-8?B?eVc1cUUyOW9wYytwOTZPS1ZXcVFIT2x2bnVRMkplNjFIWmoyUzFHZDlMcC9X?=
 =?utf-8?B?TGhaQmRRMndVMzNLQ05GVlZ3UDlmcjhSUnFBZmtpeHQrbEhtM01ZRFYzUjE1?=
 =?utf-8?B?OFhyc2hXUVI0blZnTXNBak83RTZJanBrTmtEeGpBUG03RTliRS9lVHRBeDlC?=
 =?utf-8?B?U2w2RUh6N3JQS1FYZFRManRwenYzK2QxcnNyNkVjVm9DQXgveCs2OXZMZjhM?=
 =?utf-8?B?eUMrMkMzL0RyVVgvT2czSHEzcnFLREZMYnU4b1ZnSjlDRU9XV2ljd2IrMlN6?=
 =?utf-8?B?Q0lRdlhpTUZ6SXpkVktjVmFJNUJucEs4UnNSajhKeDhwYWZ3eDlSMTJlcGEz?=
 =?utf-8?B?OUxuM21KSW5BVEtjZkJUMFRpTFN6TnUwUkltWXpBYUVYc08zSzBjUWM4NWdV?=
 =?utf-8?B?MnAwZVhkMG9MUE43NHZsajZFVFJrcTJIR09qeFJCUFBhZHlJalRQNUR1M00r?=
 =?utf-8?B?NFNpNHZOY3NtbmFTWVJVSlRKMnA2bm9BeHVjb0xDVkozY2lSKytPLzZpZkpO?=
 =?utf-8?B?NERrcVhwUlpFQTFJcDFFc1ZmTGpKUzV0S3Z6MDdVTHh2RkprL0NsdTJ1dGJB?=
 =?utf-8?B?cmsrKzlsd2pBbVFoWER3dXlOcUxUUFZRNGs0QjNKSURnS1Q1bUpCMnczNVgr?=
 =?utf-8?B?UFFiR2FSeWUrQysxSWJ1M21DYTZRa05YQ1Vnb0ZvUFNQcHZlcWFkd2ZncFdw?=
 =?utf-8?B?ZmE4ZWxEdDNNbm5yNHY2MUlHeVgydk1ITkpyR0hocEtwczRTZ1dsQXNiWG41?=
 =?utf-8?B?VVNhRHI2SHVldFd4ajd5WG04U0FERExiVjVOYlRDNWkxOUJZYVBXNnBqKzlz?=
 =?utf-8?B?TGk1Ky9BL3RuNXdOYkgwMWUrUEdSV2hEV0VXNERSK1ArRXdYeFIxRDJJRG1s?=
 =?utf-8?B?K2x4dHYvYXc1YnRaVVU3WTYzV1ZjVW43Y3dsNmlneGZjVnlpZnBSaWkyV2t1?=
 =?utf-8?B?Y3FyVVlBQ2gvaTJweDlncVV4cEhBYm04VlY4Ky96TjJqaVE0c1NFV1VONld0?=
 =?utf-8?B?cDRVeTQ1djBWeUlvMW5GT1l4REVuM1ZHbXd1UE91MGIrNlIxUGQzWUpXQTBH?=
 =?utf-8?B?a0pqTXE3cUxvQUFSVE9hcTVpUVlLQTQva1FMQWdYRStlcklHRWozUnpyM2Rn?=
 =?utf-8?B?ajc4Rm94VmxWOFhuRnJVMHVVd1NFS2pOL2pUSFYxTjNNN0dGSERLdVNacVli?=
 =?utf-8?B?T283OWVBa2JTU2I0V2NMdEp6TngyRnlEdDJXNVFWVWhGK1lCeFR5VmljZVJx?=
 =?utf-8?B?cUpFdFRub0VuUXhFUkhsVGRsNkIwY0lXRnJ3b3BFWGE1cGNkN0I3UzZIQ3Q4?=
 =?utf-8?B?S1Baak5NOER5Q2VYbGVyL3FZQjJMdUtvTFJaNUlzczMrZlFEYnRlSFgxS2JO?=
 =?utf-8?B?M1E5cGl2N3FDTkJIdDFjUmZkKzVld214bDV3TnhKdTFzaEs3Wm5QaDdRWVZY?=
 =?utf-8?B?TlROV3o3czFHcVZYYVVvWnlVayt2NnVCYXN3ZXNXUDIyRjk2UUhKcTRvT0JM?=
 =?utf-8?B?RTZxZ09mWFlleTFucHhoSTdFRnF1V05BeldYRkJsbVhuU21DbThLalMyYS9m?=
 =?utf-8?B?eURDSmxDS2d4S0JEbDFJR21QdGtSQ05sZUxyd21zb1ZOZjRzalBzKytsYVBq?=
 =?utf-8?B?WXgybEU4WHRBMGJoREFJY3lyditERFlkckt4dmZhZTh1bjhkL2NIeEM2Tzhs?=
 =?utf-8?B?dENmMGRxSGVwdGRyd2JOeWVQSFlvYUxLaTcyeHdESUU4UEduMlJLZHlabWlI?=
 =?utf-8?B?OWRvZ2ZaOFJhZUViaFZHdWJVYXhuMUoyM1dVSGl6aXd3NTJmRTZSbFI4b3Yv?=
 =?utf-8?B?aTdpaGRRd2ZoZTJJUlRiZ0FyUEdTVXFRQVRpV2RTR2pxalhvT0kwOHYxMEh0?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea19e04c-2d7f-40db-fdc7-08dc5b264344
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 19:25:07.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0GBl6SspR+jRDWY0MamXSKiv6JDEoEWGiurISpRs6Qvh3s644SSoJMl6KdEq1uohXHtigi8wuHReIvv3bvCpqkbaSoTHoefw2c5TaId8m8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8134
X-OriginatorOrg: intel.com

On 4/12/2024 4:18 PM, David Woodhouse wrote:
> On Fri, 2024-04-12 at 15:05 +0100, Will Deacon wrote:
>> On Mon, Mar 11, 2024 at 12:19:14PM +0000, David Woodhouse wrote:
>>> When the hardware signature in the ACPI FACS changes, the OS is supposed
>>> to perform a clean reboot instead of attempting to resume on a changed
>>> platform.
>>>
>>> Although these patches have a functional dependency, they could be merged
>>> separately. The second patch just won't *see* a FACS table if the ACPICA
>>> fix isn't present.
>>>
>>> v2: Now that the ACPICA patch is merged upstream, note its commit ID
>>>
>>> David Woodhouse (2):
>>>        ACPICA: Detect FACS even for hardware reduced platforms
>>>        arm64: acpi: Honour firmware_signature field of FACS, if it exists
>>>
>>>   arch/arm64/kernel/acpi.c      | 10 ++++++++++
>>>   drivers/acpi/acpica/tbfadt.c  | 30 +++++++++++++-----------------
>>>   drivers/acpi/acpica/tbutils.c |  7 +------
>> Rafael, how would you like the handle this series? The arm64 part has
>> been Acked-by Sudeep, so I'm happy with it.
> Thanks, Will.
>
> Similar question for Rafael on the guest side of the PSCI SYSTEM_OFF2
> series, in particular
> https://lore.kernel.org/kvm/20240319130957.1050637-6-dwmw2@infradead.org/#Z31kernel:power:hibernate.c
> which sets the entering_platform_hibernation flag around the call to
> the standard kernel_power_off() function when invoking it for
> HIBERNATION_SHUTDOWN.

In both cases, please feel free to route the patches as it is convenient 
and add

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

to both of them.



