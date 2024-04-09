Return-Path: <linux-kernel+bounces-136178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C30389D0CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60ADC1C23EBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8DF548F3;
	Tue,  9 Apr 2024 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="baM1Hln3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DCF548E8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632495; cv=fail; b=OdBSw8tvp6pCibnH3omFopy5AUeW/oeuFN8MYdkW/0esPp0Sgdn1CjkyeAed7xBZu/D40dUvl45OQ5QO/rxDYV7A0Ae3AlakWIiNL/THC/TpegsrWU46gmSwUZ1JQMrQrpaZM2Lg5lyjJxSrTUURkOp6SDefQwoAfjFFsNo0fTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632495; c=relaxed/simple;
	bh=SkDtoQJ2agEbeD5GZ3mOCrdH3BQ5rni/wMBIfyq/x0o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gg0I9AsvMEgDrCXVaI0iezWDTJgek+KTiJri7fZAS9R8PsFigCsTNNbHY+pcyzYVIB9K1w4rs8y+fWFG20cQ8wFPAPdz9zvWCGwBAaKPckub/0hEEHBKXqKQ7/NJxb+8bMp2TQcLDWc89aIIisgzipxfDLpXX7uwx7xKUWAJV4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=baM1Hln3; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632493; x=1744168493;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SkDtoQJ2agEbeD5GZ3mOCrdH3BQ5rni/wMBIfyq/x0o=;
  b=baM1Hln3J6hMFrTiS2TLCmVgZoFBSjrbyQk/alxhxnvuSJSST/2h8rRZ
   QSOifV9U8OodQMIoI1KEthr8pDe7w1YikN/FNysMdNx0v4Ea4j60zAOPW
   NptqwMo1HYoVPH/slTVTe87S9Y6wwkh2ktUCIw4B4xAPJok3se08+PsS4
   qS3vYNDCuCJ3wg5M6cf9T9AT6ES2m5nF9ZylFYVjVB3AnvisJbagRut5M
   mTqnyIKKHOZ0oR3ZFrhw+L+eSRZ7Yw1bWlNVJJtO2rdaqG52tAXInFg7p
   rsrZCH++QKYF73LZN+lk0lgfVkKeCqA8fCNmlKj7AuJ4AYhKOiCLRyXLK
   g==;
X-CSE-ConnectionGUID: fWtYmOjmSkOoqS7t+LZOlQ==
X-CSE-MsgGUID: SpLfccwhQI2qt0da7w0o/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8511015"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="8511015"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:14:52 -0700
X-CSE-ConnectionGUID: neDhkVdtSXuZl109Ri9LCA==
X-CSE-MsgGUID: btgd5yAKRBCFP+0ENlopXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20002667"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:14:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:14:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:14:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:14:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Stm7BG+JZIiRhsV/K+dGX69eZoro2N8qQaVaz3E9HrwMizFysZKcghc8co0JUaYcsq1DoMvs1sKiLkByBjoQ3h6afgjI2L/ALUQ3SaNmhGz9mWSKkdFUwP9Gc6K0Q1gOjjGgqiNn7EGusHfeSFKQaHY3Qls5/Z+pdTD5GLoWhqn53G9YuuZ3agl8rQk++fBcn13kEQq9wl0p6vn8q8FQ7yiTNJu5M7SFOJtKI8nMDPJo6vN6CUyoYLlK2oe++XDI3EM9OG7kZp8MB6Z6ZYmB7XIRuvPtbtNncCYBb/qhxgt9/ZV4xL8qkFj6Mzdu84MzjDmRZFNSGiDllxisX09LoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDPXAaeCQ476saAlughbcDuQHeG4c5em9pQdifoYX30=;
 b=BV/csE3tnsntmIE6n9NJxkPd4aXZlmZQv4qo6BT/XDDKaNW7UWm1rtWuBJqZPxz3Lmw1RWSTZTeB7PxqYopRPHid0cwt5dJKr9U4cXa5aL2/NiTaOvFVmXaYu8uDGu9BhD+rH5DvqeK42Anc66iknPE5fyaL8qUv7K62jMsqcLmE7cfe1+6LfNQmilHSHgA0nmVt+85J+enuNQzmQJCpXf1N2odkhIKK57m8cVy60nandZ076G0qoFJvbT1hU7dcV5Ecn++mXsZF0BeV9BVDMy4EP8Ttd8ubhmum4UZW7dnVbYtIEQ5x7bpCxjjyzyaeOgieaJWcrQeyfEBVW+rEjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.23; Tue, 9 Apr
 2024 03:14:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:14:49 +0000
Message-ID: <e85e7786-7995-42d5-a5ac-1e08a84492fe@intel.com>
Date: Mon, 8 Apr 2024 20:14:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/31] x86/resctrl: Move ctrlval string parsing policy
 away from the arch code
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
 <20240321165106.31602-4-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-4-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:303:6b::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4783:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXz83CETKk46lyrjT2tCr11mX7eDttp3H1lWEttbP3eEdG5f0+xcqxoO/OQIdGrdjknj/8UVlGrxuzxwDo2FnWAfrlgWTAATKY0TvSpNaBZDSUmCb8IPKdO4FOyabIL/uatqZFVD+nSuk3ow8wdeLDrIuDkOcc5Z4kqXT3sX9kAE5SkGJGu//oRLRp1Z64eDTgEIcryW4MLMvDbLbvQ0X4NdtBbvvY3ci+EEPFWbdQJMlO8yDOfvmUyO9JlgK7Q5p35uOgZ6DqUxUUh9y21qnLf3TNvGq8SzebquO6HQhzevatFLZpeNkwSM90CiYzw3Rki1gUTRBIJG2xrDV0CuYkBU+y0/yqDD7LbjEK5quWRKHows36zjCpNKZvisYWRnruzphT0LXqDU7GeVPh/M94AcsLcni/rX9Rr9V4C2KM17lSWwBHiUYnnjCUILFHsJwNyWp6fJv5005LrVHb2WByQPWfhTfHFg2rKfUF+xiX27XG0BDUoVRor2Rp0Xvleh7oyjOJzEPVwRFEQR+WHOACOhGJgfdQq1HCZncangX86NmA3aYyc83BM+/CjWGfa29NvHtD93hd2YW+UrAvtnGkzDffqFI7ojj1lbUqlxT52yig/lR9K1pxHf+Atve9UpldeJsEWqjkS0IXBPX7y7AmY1rtNvVS+FyudsSjLWqeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TytZRDB4UEVSWGZvTEhSYW1LR1d4UGx5aU1YVWNmSDlwQVhXYmpqSVQxanZL?=
 =?utf-8?B?ajhPdFp0MjdPaDIzSXVJcTc0anEyaCtoVUVPbHJjTkwrdG5wRnk1cGtiTmR1?=
 =?utf-8?B?ZWlOeDhCczgxQlZJMTVHblN0c04zK2xzaXdhRjlyVzIxOG5pZnVHNWROaDM1?=
 =?utf-8?B?TWhMWXRSSVpmOWNQS2JuTlJWeThQVlhTMm11WURRS1lneUJtYUNySm51WVhM?=
 =?utf-8?B?VmJpYkxVYkFmSmQzNTJBU0drTWNhdUZxdkh0ZEk0aUEzZzBLOVp2MjErY0dy?=
 =?utf-8?B?am1wb1VEekw2OXVBdzFZVlhqamlDNklyYVp4ajVKNk9Ib2VDSjZhbnM4Yllq?=
 =?utf-8?B?ZmEwSE84aTFRVXVPVWxKOTUxeEhxQ1ZmT2VlUWdqWkV6cStKc2xFOEJxRXdS?=
 =?utf-8?B?VzlYRVFUYllsenFLODBxaFNEZmFJZFFCcnJlSTYyODFJNzVveWdCWG1kU3Mw?=
 =?utf-8?B?K2NHQTJEMUVIa2I4MDg5YjZLMXNabVVqRGs2Y3RueUZobEhJT0dWSjVnU25H?=
 =?utf-8?B?dU1VWTF0MUF0M1BXNDBuRVhJUXJRSTZkcVJXNUMybXJEQytBWWNpT25uYS9p?=
 =?utf-8?B?eGRjSTdWTW1nbFRJV004cG1qWHZzUmtpajlrSzlDUGxsUGgwcTh3WE9OelVr?=
 =?utf-8?B?WDJFL1p0MWlwK2FOQ2FvRFNxUEVzaDN2STNERm5MMDNVcm5Ra1JQb3dNWWJP?=
 =?utf-8?B?cjlGYnNhYzlRRkh2c1IyVW9pOGNqTXdtTDR0ZnRDeWJpRW9oKzhjRGFOWUcx?=
 =?utf-8?B?RVcwemtTYWRlcUJ2SnFJTlVQZlBTZHExS1Y1R1psUHhMNXJENTdQMC9UUzJD?=
 =?utf-8?B?NUJicVBPTnFETVIxb1RTVXRKdUtXd25VUGxsMHlhaS9mclJ3Tzd1eW95N0JI?=
 =?utf-8?B?dExOMStpOWcycEFneldDSG83aGhTSVRuWVRiWGtHbFpnWnBiUnIwaHZSZnFJ?=
 =?utf-8?B?MlN4a0FMQkZBQTF2cTRyaXJhV1ArNVdyQ0tkbEU2UEt2OCs4R0g5M3ZuWkxR?=
 =?utf-8?B?cm9kbld2QTVzSlpPWGNjMzVxV0kxeWtjNUlqQTdadDN6UzdDd3ptbUZ1OUhF?=
 =?utf-8?B?K0ZPSlg5QUZyTFZTb0V4M1Y5YVlPMXZ0bDZ3dmMvbjJ1Mml6S1Z3Q25lR2Mr?=
 =?utf-8?B?aEhkd0t5eVR0ZUJTRXpwaFF1VFQzOEZjcWxHTFpxbEZRdk5vbS9FUmd5YTlu?=
 =?utf-8?B?dlZSSnZGb2lrYWZvMlI4L1ZPb2VSeTBYdkJDUU0reXFCcjBpZENwOUpFUTB1?=
 =?utf-8?B?eVVyL3d3UjFyMDhuQjdtVk40emVUU2lVS3psMXR5OVQ0ODlNQkpTZ2RKMXlH?=
 =?utf-8?B?WDZVOWE1akVhRjFNTkpiaHZMb3c4RVBTM2FicDVsckozZXQvQ2s0aGJYa2tQ?=
 =?utf-8?B?UHA1OEoraEE2OE4wNDFnc0xRSGV0bU9qbWpPeVJTSmEwRFhCY2F2T0pTemU2?=
 =?utf-8?B?bm5TbmlTUGJ6dFZRd1ZYanBHQkNSMC92bE5NQ0lWY1JuMmVEeXVzOUs2ZHJO?=
 =?utf-8?B?T3F4MEhFNjM1V1pVM2QxSENNUWc1L2hGKzFKV3NlZkhuSUFPeGltSWt6M0xV?=
 =?utf-8?B?RWx3K0RSSVpZeDhxTStDTzdYMUVTL3JITThtY2xiWjVOQis2c2xhMTY2T0tq?=
 =?utf-8?B?dnZGTE00SGkvdVpRUHBQdThWaVZBODBpb3VJTnQ1YUhKU01nZ1cvamh1Skp2?=
 =?utf-8?B?M2VldlVYTmdyQzVVTkNULzYwYTdzNlZERlVuMjJPVE01Q1d3TythNEdjQXR1?=
 =?utf-8?B?VWFCaE0xTEhQWGJZNUV1UkRwQWtBRlI3bHFoaS9YNnZ6S1JVQytuSWFJcFNI?=
 =?utf-8?B?R2hMcnp2Qjd3VUxzaTMxRk02K0pweXZYYkdnOWdOTUVybEtRQndPUWVoVU10?=
 =?utf-8?B?UE9HaHFFRDN1MG90RjZTOWRPN2UwOHNjVmZQL29ReFhWOEQ0QWJOc0doRk1D?=
 =?utf-8?B?cFEwVXlmeFNPdS96eFZEQUlrWExMaW41ZVRLTUdmV0VXM1M1cUp2UXRTVFVF?=
 =?utf-8?B?QWZicmQzd2xOckVWMGlPZ3N2SHFocjlFQWVQdjEzdFc3TjVvZDJEK2JEdVJx?=
 =?utf-8?B?MTAyUE10Z1hDeFFwTk5aNm9HclNxMHI4TFFDdnRXR1JjK2hqdVdET0FmQjY4?=
 =?utf-8?B?QVcvaUhhaFp2REhXWEdTc2d3K1I4SG9zM01EYTBOZFNvSm9PelhPUkZ3MlBQ?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b92b6b-1048-4f4e-ecc2-08dc58433775
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:14:49.7458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgqkFIAal2cuUU8XuPC5swcNvgjnCMRL8A5KnehtjNIy3xeWS/QrSWbrVTdugznBpblE5vdzuLA25nAYnsw8V5jkA4SRSTaJ8lgim/lnZq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> The policy for parsing the configuration values as a string from
> user-space is specified by a function pointer the arch code specifies.
> 
> These strings are part of resctrl's ABI, and the functions and their
> caller both live in the same file. Exporting the parsing functions and
> allowing the architecture to choose how a schema is parsed allows an
> architecture to get this wrong.
> 
> Keep this all in the flesystem parts of resctrl. This should prevent any

flesystem -> filesystem

> architecture's string-parsing behaviour from varying without core code
> changes. Use the fflags to spot caches and bandwidth resources, and use
> the appropriate helper.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

..

> @@ -195,6 +204,14 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>  	return 0;
>  }
>  
> +static ctrlval_parser_t *get_parser(struct rdt_resource *res)
> +{
> +	if (res->fflags & RFTYPE_RES_CACHE)
> +		return &parse_cbm;
> +	else
> +		return &parse_bw;
> +}

This is borderline ... at minimum it expands what fflags means and how it
is intended to be used and that needs to be documented because it reads:

	* @fflags:		flags to choose base and info files

I am curious why you picked fflags instead of an explicit check against
rid?

Reinette

