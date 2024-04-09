Return-Path: <linux-kernel+bounces-136184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A0189D0DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B74B21ECD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD59E12D21F;
	Tue,  9 Apr 2024 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaZWaUOm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6968785943
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632598; cv=fail; b=WCi87NazkZc9MZRh2ObB7LL6M4XSH+7Lj0JykeEyu1o+Rl58fSCkDUBsnzYOmd1xR090XSLz7VTiUVev0FInCVjamXxmiRUhkyJ8INBRA1bxWgYSgwUaONefy7vQIBPo9I/OWTXuOJmyBa5x4mzhoVWyIBsz+I06//WucQPmXbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632598; c=relaxed/simple;
	bh=YHgiSgcG7F1cPFHSRFXXQiqVvBYGTpoKNvGJratiRVU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dJWz0wpw2LrR7Gs1hUwIIrYbwrSKJxGfa5LflnISozAUtkv60gL8O7lvtQXs3hYIHYOx3v+76NNskJPjR/EkfXyKVZH23QImdpXzEVNk+QJT/EaXM01S0BEJOVigUnsuuUuJLo9xEyx66VY/P3zH+eus+jf4uga24uXLkI+//j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaZWaUOm; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632598; x=1744168598;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YHgiSgcG7F1cPFHSRFXXQiqVvBYGTpoKNvGJratiRVU=;
  b=YaZWaUOmOEcsLMQhmidY2znBNknjjJYnuJSGosgnTbO4Y6QJk/aGYXo4
   v1o/6CZ02lpwkUH64IHByD6BOr5cNPXNfojHpTUrDa5//XB1ro9AJCR/x
   BOraYJDrruUZorhXeiLb6Ny5YKUMoZfoT4cfLOVI8GlsHmc6hAWxkh968
   Ae2sC9ggcecsq0AubTlN8I+QTp4m3/ESLetXy7yAXitUyd0kiZYUvMUjM
   QoHnXZeGKx5J3++xabNOP0HxuXVMI7VgpBiYXcg1nbcGcShhcudbDjnKy
   1wIV+4Xqm239v0eINdEplFFyoVnVpkL3BdZDd2fki5RRrcZr/hSBPgY4R
   w==;
X-CSE-ConnectionGUID: TKPIGQ5WRqeNRURp55EybA==
X-CSE-MsgGUID: EMF6JB23QuennjoGxW91jA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7801454"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7801454"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:16:37 -0700
X-CSE-ConnectionGUID: B1a9CKyxQ0aY2YiS1z1g6g==
X-CSE-MsgGUID: cR6hCopsRWeEr8H8WQX0zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="51098466"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:16:36 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:16:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:16:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:16:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Paqz8EIoHu9jhPQttoUZ3MkgzlF2F8sJX6SOQGPEv99d4xJGI7NnIjv8RuE+SqV7XyfGGw5MP651t9Y4p6iqbUqlyPtha3T3IJV4ujP11OL65Ua2NINEK8T4YrPRN3mrf8p9neM511gDDdDoeVkD1BIPt5NIg2UfINhHqQBAWcJNDYEMEsk1xbrvtOOj+VtHUuJQuaOpkn1bqKe269ctW3W3rMAhzV/Ma8qhv+3+n9kOIwGwgdRxzjyIzTRqMyOhoUaWrIsahW3vMPgg8gOyQqai5GCxtlsOJpN9D8hv5D+gUcVuIZLMS7IDol2chJcFAaTJUc1TbruPwQ8D17JNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTB5grV8Gz17mRwcwax5HzlgdEIgyF1T/4VhlpiOF8E=;
 b=EhTdYbaXTNS2alrIC2KBe4LMETMvxdWsq3ascsQlkzz7r9aEvN3rfTYzBpg+tfDQNAeHeUBtvaDzCMRIMa5XIGT1AVB+YDy1guwMNObl3usvovkfugouxaACMK96Yvm473zZa4FjRQXiewMSjPYci4XLPT23Mj6oUzRt0eA0urKHHNu9VOgCWbl4OT808z6xNW+CGERR6M7nHgBy1CM5IjdnEDBDS4o2PX0TObXah8ERz7oEZCmavq4abBs0u/eoIgcPdFFcK1uDz43NyrGQCcjRfrunE84tvZs2d/8g8dryfhJy49nEgK3joDhX4M3rQpZk/VVshtuxpf+W7ZZrVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.23; Tue, 9 Apr
 2024 03:16:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:16:35 +0000
Message-ID: <e74077e1-3c5b-4126-a567-4b4b04f5367d@intel.com>
Date: Mon, 8 Apr 2024 20:16:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/31] x86/resctrl: Export resctrl fs's init function
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
 <20240321165106.31602-7-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-7-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:303:b4::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
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
X-Microsoft-Antispam-Message-Info: p0qXmTP129dXnRokHWCPESWiX4AkwibujM1hLeN0duDu9VbZKNjcgb/QLWUOA7YDVNKCoG/PJ/iE41Vk0BWIuAi80AaQrJQmbVsu/JNv1baQrxEavoGv+1OMbArLvyX4NCpU/d6UyS0bkbHFNpPtB2woXNwUt/7wtkFZZ8uoBjzThKPsGJ6MhJI77HQlIomsesmnp4GEmBSDkdtcCABSeVrvswldGbLVMz0/xz2JqOfCGhYsso0mCxRtPF5htB4Hklohvb2ubW8crGf+snWKfztTidcWTSkAOrrf1tVVkDubGDohog1yNTBfGY0JLyHuYYm3PPZb9AbTKLlckIns7qxL8ZB3SLUqbhb/UbI74LHsqTbbD272pd0JRPNR7BSAsUS4pqDzrpMM8frXCetDqo002wYCD/Ho+2jdCRgmzxXNRbHy0L+RlecGHgAl+hEI5GRjImEYZWNPeGyH1GNSCZYW+Pg2GrS2qr3bLhd6fgq2kgG2wy/c2wTWUHqOncXkROlQzsLK6C7+FPtimOyC5JpBJ/XVpkxGKdmjeEO9z2B+pVirqcDxMAXtxgitakv66pJ9d8/rCGmYJpE2RWaTpQqA4XdQmV+9w5xFgzGCG453h5wSSnia4d3AUw0SBgGM3LjdsB8bMribB7lG9yR5c2MpMjjtXkp1umtIimXso9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zy9hb1ZlV0Zyd1JaM2thREsxNGlVUHJOVmIxaFEycHh6S0MyZTVnTkhwdWo1?=
 =?utf-8?B?WkxrSCtDN0I3VWR5WFFRQlhEYVZkc0hFVEUzSnpMc2tPTEl4aklwYlpoVUFW?=
 =?utf-8?B?ZjZQR25zR0JuT0syKzlkdlpuUEh1V0xTNlpDa0swcHM2K3J2ZWZLMkcxcmVI?=
 =?utf-8?B?NTFIaC9RRDVLV3ZLVTZyMS9vMnN5bFZ5bm1vNzNOeGExVzk1RG5TTDd4OC9L?=
 =?utf-8?B?WHFjVE80K1VuWlZuWjFibWJ3MUhKWkZPVzRKZFUrRmlZOTVudU9QYVZQTkNH?=
 =?utf-8?B?NUJ1SGVSa0RsdVE3dmxWRzVuZlVaeURSNkhVWDRzZXFUNFJZTXk0RTdiSGNG?=
 =?utf-8?B?eVpzODNZalp1QmYybFB4S09yWHZvNkI1REZDVnpnZ01BR1pJeEtscmFFSDUz?=
 =?utf-8?B?TVlDaHFSUEs3ajhvYTNOVUlWSEg2OU9yS25BelV3SlpNTTM4am9LZk5PcWJN?=
 =?utf-8?B?RlFWVHNnWjA1YmVUVEkzVkNPUXVvOVlubytYRUZhYWtzSENHSkpDSUhlVUdE?=
 =?utf-8?B?NlFvMllteFE5UktPVFp1QWN2QWlrY0ZpWjllQWRDaEZ6TUZTVHdqUytZNzV4?=
 =?utf-8?B?TmpyVnVIUHQwT0FHdi9VUm1sbW1pbmUvSVhybmZYOXNQQmk2dFIvdy9JQ3BE?=
 =?utf-8?B?WDlWcVppZWVsSm9nZ2ZXc3RsRS81WEl1UXBxbjIwVWUzbVJaOHlFV3ErMWtt?=
 =?utf-8?B?SUU1b0RVSUhGT2ZtclpmcFpEajVFWFVvRWpDVVdzM1lublpISkt2YTFOZXRi?=
 =?utf-8?B?TVFyemw5amxQVnVUdzdjMUIwNWZ1YjdEdUpUSHZwckdiWlQrM2o4WmMyUml2?=
 =?utf-8?B?bENRd3BRZ2c3cWlaVDBOUGtsOE1GSXFYTVFYSEFqdjI4VXZSK01WdFg1T1RG?=
 =?utf-8?B?Y01lVERZWGtRZ3h4OTkzbEUxRncySmY0bDB6RkZKK1o1SWVSWWRkMzVCbmlH?=
 =?utf-8?B?bG1TTDhFU1RKWUdYeElSQ09VWWpJak9GV2gvWDlvd3VWdVFsSU9BTzBKNUFQ?=
 =?utf-8?B?U3RVT1Z1OXZjQmVHK1pxMTExY1g0QUxKUGMvcUJoMS9pU0F5M0VEL0V0OVNZ?=
 =?utf-8?B?dUJCSkYwZUV4Q3U3eStQa2Rtd2RzS3RLSGFCMW91R29Vc0tsaEkxaHJmV3FK?=
 =?utf-8?B?WmRReHFtVEVWeE5RbFNrQk93blBRc3NvdkFMcGc3eXBvYWx2bk5pcDlIRHhv?=
 =?utf-8?B?S0loN3FBL0NTVi9KQ1F1ZzFJSVBtS0IzaFVYTkp6ZHNmU2ZYMkxiNm9hMTQ5?=
 =?utf-8?B?bEptQVlPMFYxSFE1clBUL2ViOUdFQmZKR3lsOFlkdnVUQ3N3R0h5MDRmY3BQ?=
 =?utf-8?B?WFo4VnZ4WEdJbXl3UHZTMXZzUWdaU1UzbDVTaEs5MUlsdW9obEpJNW1RazVt?=
 =?utf-8?B?Ri8wSjZKakQvMGp0TzVHZW9PMFE1T1Bja2kwWjYxclZGVUhaRG00UVdZSjhM?=
 =?utf-8?B?WVJWWTA2Mnd2bnhTVmYvdG9jK0MyNElIS2l6OFUvd3ZieDlnQ1YwUGRFNWx2?=
 =?utf-8?B?aitnVEVqT1g2N0Q4WmYxR0U4a0taNkd0eiswMy9qRUF0bkk0c2Vjek9JZGl0?=
 =?utf-8?B?bjVlU241WFFka3N1eTJ3VDlFQ2cwZHlPbnZYcTlMTVRVM3hOQ21lOU9EMHNX?=
 =?utf-8?B?Y0x1MWlOY0IraHY5VXk4bFVxRStiSGV5VHNzNnBtM3R4MENKZ1BKZ3ZPQUx5?=
 =?utf-8?B?L1kwRTJYeDRaMU81SXhBUC9kRk5UTWNiUmVLQmpYcDB6b1N0bkxVSVJZTVRM?=
 =?utf-8?B?MzRRS2ZQVkE1TXdQOXZydWpTeFg2MVVqb2tyd1BkSFMyZmYvd0pvZFRKQnFa?=
 =?utf-8?B?WXBVOGgyME5vZ1pQSnBrMjkxVlNrcEF0TkhRcCt0RUNxY3Bmb0kySWs4U3Nj?=
 =?utf-8?B?bkJIano3TjRSYkxLc3ZHbmt2b3RNK1NqRTVvUnVEejY2S3IyZ2RIZUw1Vlgz?=
 =?utf-8?B?SmZIa3JENnVWZnpIMHlxdk5QSVV1azB3aWlDWitOZ3U4aVBhQTFUdXRTSXlr?=
 =?utf-8?B?VjNCbFhyWHI0eXJ4Y0lrUTNQU05qWjN1MEJTR041dzNEU1I2bkZFL3BGL0RU?=
 =?utf-8?B?V3NGVnNQK291ei9od1RzWEhiZ3FYYm9iTDM4cHJlUnk5eE83cUVpbkpoQS9I?=
 =?utf-8?B?ZURhT0tMNHo5MmdGT0Q5SUp3YWQyMVhJT1lsT3laS0dsNFpHSEVZeUo0Z3pM?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9156d4f8-18ff-43e5-2249-08dc58437630
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:16:34.9662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulEh/bFIZlBEf2qWeryMu86GtCw4Z2hRSws+T9YH5p8semNIbZIksPdbKbCFYMMJtgv/EJKjiC/s/xHJXAp6iHqjGje5Jx+p8C5KVMbcbH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> rdtgroup_init() needs exporting so that arch code can call it once
> it lives in core code. As this is one of the few functions we export,

Please do not impersonate code.

> rename it to have the resctrl in the name. The same goes for the exit

"to have the resctrl" -> "to have resctrl"

> call.
> 
> x86's arch code init functions for RDT are renamed to have an arch
> prefix to make it clear these are part of the architecture code.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reinette

