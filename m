Return-Path: <linux-kernel+bounces-166809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050018B9FD3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF03284D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A9E16FF27;
	Thu,  2 May 2024 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1griXCa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955761553BB;
	Thu,  2 May 2024 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672350; cv=fail; b=CyqQ0oPrlaZ3uo+JrobBLBfteuXx6I/i+SEBJosNEoqR07fjuCTjOo5v/xXFY6RV4CTeBWXcgTDtRWeXZIcga+7da2z7f4NNaEsc7rxNa7ynRvhr9Cy/yWen62aQIil8WjTockM/uxo+y0ChVifXfDJajdsAFqiQ9PltIWLN3YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672350; c=relaxed/simple;
	bh=aYYrvLOVBM6HC4nalLySKqnN6P1zHAVDFy4cdTN6d7A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IxVel2ycjlmK8iI2eIshCG7HZF/1r4AIecaUoHJ4uBOubXdb2P6xve2tW+lBjhvlPZDdQQdVZtR4nCWegtn3OlEAdv+QsszUoaRMqBprKwp2Oes6QTyHqYkQ5crIHF2UwNQIRzXd79FesddUm6DTjF5SnAb+NSdGGbc+BbnuoHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1griXCa; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714672349; x=1746208349;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aYYrvLOVBM6HC4nalLySKqnN6P1zHAVDFy4cdTN6d7A=;
  b=h1griXCao9xNEOWf0ahfGPXQiu+MWqVRS3fTkCOwiRwK8udt8nKv2naF
   BS2XHMLmCtPuHBgfNikcaOUO7GpvWkX2X7yS6cs6cjPyA7xup07QHlxwZ
   MAnKql62ueytMWtrsclrpli4S9NTMX5lryO/K8HbFP85i37MKaIJTOJ4J
   dG0oDFZmDx9ZF8AYZvuUwCbr3YKj/OYkxR4nBELoxY5RuyQUJNmIgHpKl
   9uYeBLh17sKA+YwThu1SJAge8+VSvs3ndO+DZSy3R91IAR5r+i23I2jtf
   vhQki+oRYvcYRqL8x5rE3T5MaGiuQd4Yb2FvjxwzICfNeSyOGcYlpQriF
   Q==;
X-CSE-ConnectionGUID: RKsMfZCnQs2y81u5rOINAA==
X-CSE-MsgGUID: ywgwZomuRkehMopzG7PEaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10331128"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10331128"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 10:52:25 -0700
X-CSE-ConnectionGUID: GWyyQEvbQDeAHN75/EKUrA==
X-CSE-MsgGUID: 5cGvKc57SVqTwnU/Qm3gmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31994626"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 May 2024 10:52:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 10:52:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 10:52:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 10:52:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 10:52:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDnNIk1hGWg2sThBCZ2djP/n2hLmMjyzV+487e5tCevpNDBlKN5ze5e1YsrorGgQAgD7uSUouC3B8rqXogYcI6CG5j8YMwBrSL9QeVj5cRj8Z5IxXRuPakmRtya4qoRW3lKkMrpvserdIGk0MnuzLAWNSuftQrTtuQM6+9EtQL2ZGHbK06HGiHDB7JFxOFiCW9yT8/0BM1PEqGb/FSkkymsz+WM7g7sZ8jZqQMOPDMpFIafhhYahT16Bxw8PDgmOkbLJYhGtP2s2ovIbwIjlqDgadtaUBl7v+s9lWZtsj55yzsQNjd/pld47C/1FGTG5eq6h5/JFa94d5dbO5Q6elw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q2/rLIERLoRAjd8ItVU+tH2rAcmO6151ufCjf2DRnM=;
 b=c9bir+mf7kJo1OtpJpWJj1/IW47ga70EApSXQnK8lRyDuyzL1mf+ksaWKtz7AEqvb3pYH0f+o0na2B+gVQFwBhuOxvC/Wr24LJJlDxPEN2OaZHEGEvlIEyUBuaUn/JjkD99cUt8L7EfFAv25Zz6/I7GaqelGNVsU9sq2Ni1yTdcId/15As7NAonZ+v04W+pmHHHpTxN0GZg2fpxEuJ+7n05wRcm/eMsNUe0u5M47gBcRY/H1zgn6vDeGqxeCANSRVokCzHO1BN3lsOzafm+dFg4YMVkyzTZPHfchcXiFWLjEa75k5Is/+WXHIoUuy0LZkY8b6h5dGveboWaUrG6JFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7133.namprd11.prod.outlook.com (2603:10b6:930:63::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 17:52:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 17:52:19 +0000
Message-ID: <4875492c-13cd-4a77-a42f-243fe0f868a2@intel.com>
Date: Thu, 2 May 2024 10:52:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 17/17] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Dave Martin <Dave.Martin@arm.com>, Babu Moger <babu.moger@amd.com>
CC: <corbet@lwn.net>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>
 <ZjO9hpuLz/jJYqvT@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZjO9hpuLz/jJYqvT@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 001af304-0e5d-4185-1a4b-08dc6ad09cd7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWFJYmFRTXMvZVA1NWJOS1Y0aDJPb1F2ZnJNWjJwQTdZTmlyOXkxaEM4VU5w?=
 =?utf-8?B?UVM5VlpNeTg3enRXak95TmhkaXZqUE1iZ0pZc3NMd1Q0N1gxcUlEVjFNYmJQ?=
 =?utf-8?B?cXkxZ1hISzJrbUIyRmFvMUt1UmkyVzQzUnBGL292ZTVPUHVPUGpMTW5VcTVO?=
 =?utf-8?B?Z3JXS1VLRGt6SXJ5c29HcStPdnhnTHR6QURxSUN6ZDQ5UWxUUlA4V0huZjF3?=
 =?utf-8?B?SXAvQXFDRFhwQ2tiRnlJRUJxMGlkTGIwSld3S21Zc1AzM3Yyd0E2ZFBKb1Ay?=
 =?utf-8?B?UE8vek9Jenl3WkRVdGI3czRibmc3c3dIa04xb1dTNkdrc29xekhPaWFObm1Z?=
 =?utf-8?B?M2hpV0VqRU0yOGNIUmZtalIrQWRJbW5pa29ZTUxSQU9iQkp1T2VYSTM4V1hD?=
 =?utf-8?B?RXNCZmxtVnZIK2p4c21HN1NGN1YzSzRsNHRpTmEyd29qTUlyMzlGbUhiVThH?=
 =?utf-8?B?UXFBSFBIOWlDanRpTC9uYjBSWjdSeXU3T3c4czd5YkE0YjgxbUlTYVFOQTNm?=
 =?utf-8?B?VDJMUzJNYUE4WUlDc2FNMVNaU1poUWxpL25iZ2Nyei8xZVRaR2JYQlNRVHFW?=
 =?utf-8?B?NzBQVXBZWHJJVWtITmhBcW4waGNHbTFGaVgxM0J5bFlkSERROHpkSEVKUFRn?=
 =?utf-8?B?enR2cUlPZWlsMnFuNzZ2elllN25UdHNuVTRpVnFsN1FoSlFTc3ZqTUc2KzYz?=
 =?utf-8?B?V0doMUVIeFpzbkY3TlZCeGg3bUdFN0tnbUpJRCszbG1RYVU5NkdaOE4wSU13?=
 =?utf-8?B?b1RtL1BQZ2dhT1crTk9lUGN1ZWxpOXNDZ1ZLUW0wS0U0SG5DSkZ3cnlPUWZn?=
 =?utf-8?B?cVpyVlpjWiswYlBCUGdoQzMzT2V0cFBCN25NclRUbHV4Y1FsendNL3JOSlhp?=
 =?utf-8?B?VjNPT1IxUzUvcEVxTGZYVXRKNjVmV1ZCS2tDTUphdnNGcitkZXJ6S2dPRk5I?=
 =?utf-8?B?U3dkQWpEVUh6cGpVczFjRk5QRzJ6MTRGRW90RGxMOHFGK2JhWXJySlhKT2lN?=
 =?utf-8?B?Q3BzNUtHQ2d6VmVyUlhCaTFvb0hQL25lajZWUENtdUJPTFdPdUhJRGdPSFRK?=
 =?utf-8?B?cEYzcGhjMnBTaXEzZ0UzTG5qWlEyUWlkTUtscnN4Ym1wc2hKc0c0Z0RQYlMw?=
 =?utf-8?B?WVNQdVloVUQ5ZERmTyswTnNDaGlhZEEreXM3OHloTE1VT0YvbjhpclZ1OUVi?=
 =?utf-8?B?SHBvYWJnc3FETVZ3a2c0UFVhcUlDWTZoK2NBYlBiNGhKOWNHaG5uMXlHUTZw?=
 =?utf-8?B?YXNGcFlMRkdzMTdRL0V5dzh2TWorTjVycU85ZFhMNTB4OG54MlAvTVNkeXM0?=
 =?utf-8?B?OGlkWG5vcmhaS2lleHRFT1lzbFdYd3ZmWnJOY3RNdFZ2T2ZGT1NnNWVzSEFF?=
 =?utf-8?B?RnFIZ1ZJejhEelZ2MnFhZ1lJeHRmMDQ4TFphekFuU0FaWmVJWGtlMGR3bXlI?=
 =?utf-8?B?ZnR5dGVVVW1LS3lCNkI5UXQrYkVLUkZMaWFJUnMrNW5zUnFmOWZ2MjYxQm5x?=
 =?utf-8?B?ejZGQ0FsUFRjV1FXL21lZFhlalhLeUtnTU95TkVaVFBkTDVMVjhXQXN6cmZo?=
 =?utf-8?B?ZldYQ2ZYR3JydW9LTUpQVWJuR0oxL1RvWmo5RlkvNGM3TEFIWGFDTFROM1Zt?=
 =?utf-8?Q?wKcX9H2sgI+AX6MmjdHIEkPPyhXt7tI+3tVwrUXNzrwg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlJLd0IwUlNFam5QdTN3QVpMbWpzUlFIOUY4M1k4Qjd2ekphK2xiWWdjMDlQ?=
 =?utf-8?B?eS9xYnFaYjhES3NuWXd2OTVLQ0FENUkrM3F5YXpLLzhRUEozZGNMOGNTUjd3?=
 =?utf-8?B?LysvRUJXOFRydXJFQkloOC9scDFPYThyZTlURitMQ0ZSREQ3dEJmTktTYTZv?=
 =?utf-8?B?QUZVQkc5dTh5V05LYkdBUHF1MEZzWFJzbC9ydHkzWTdYZ3h2UmVCbDAxaGF5?=
 =?utf-8?B?Z0RCZ1NFeFFOZW9zeFF2MWZNbHpZNDVWeGl1SllLVlJhU1VEckNaVnZKK1Az?=
 =?utf-8?B?WEJ4WWY1N2dISWpiZEpNcExLSUR0Vnh5U0RWWmw5dzVKMHVhVWd6YWlidWdj?=
 =?utf-8?B?U1doWnJhVWtBQ3hrM3UzT0k2V0FnMlpFWTZ4UWRqeXF5TnhIa0NaWG93a2ll?=
 =?utf-8?B?M1ZDb1cvR1JPMitveG9kY0V0TzBnamx5a1JLbyt1Wi9pZkxzRzFaUTljUTBn?=
 =?utf-8?B?dXJmWEVMSXVjZi9TNTlGQjBJMGFNVDBVZUZrWlBLTVU1aENhbjgxbkZkc0d3?=
 =?utf-8?B?N2VnTzBFbyt0ZFIxUGUyNzdBNzY0SHVicHZuYW01ZlZ5MFc1UXM2QU85QnM3?=
 =?utf-8?B?VHFSbk13cUdMcEJIZDc1eng1UmNVSjZHSG9wZ1Q3TVBuK0tRVFRhN3NxYjJt?=
 =?utf-8?B?bktCNERYTnA4R1UxUUxkTHpwM1p0REZJWWdSWnZTSmRWT1dQdGZZZnpIUVEy?=
 =?utf-8?B?NTZZRWxnek83aFhrUFlLSnNpa0JQWU1ndEZjalluK3B5UllTS1FrTkJwR1F0?=
 =?utf-8?B?dXduWWRiSmdTRlBheU5ZeEttNXp0ei9ORjYyalJUVFhRRitocU1DQVA2KzVk?=
 =?utf-8?B?ZkY0cTVZZjdEelNqRkVBTEs2RHV4bERSUjRLbytnVFRnRm9YYzZjNndreEp2?=
 =?utf-8?B?MXFqKzJwaWZXQVlCQzljSHVpbW9iWU1wNTRBblVTeEE2eTVFSHY2dDlFRllR?=
 =?utf-8?B?cUkwZ0ZhTzd2OVJtajdXT0dPRTlHY1NNUUNYMS9XR2RybCtNb2JYNzAxRzRh?=
 =?utf-8?B?N0xqK1dLZGIrQ3ZGM2l1eHhpd0tzMERBb2t5L0Y4MEFWQWFSa2VxTHViVFFJ?=
 =?utf-8?B?b0VZTVJ3dkIxSExnV0lJWm5rMGthRjJaVG5tWlR3TmFrL21PK2pjRVlJcmgr?=
 =?utf-8?B?empqTlhxU3hBUnB1bUF5Z0VrMjJLN0xOcXVGWVNJMm56ZzgwcjdTblM1eG9t?=
 =?utf-8?B?OGpaR01ZbjZORVRlREtIWXFrOWJoZ3FLRThiLzloazRhV1BxNXlINFhqeFNM?=
 =?utf-8?B?Qk5vbEsrRG5tNmVDU09oemcwSnk4R2lBeUtrbEVtR0F4akhhWXZUTmxrNDEy?=
 =?utf-8?B?czBvUEwvOXFzY3U2QnA1MU9yM2E1UEgzMFB2RTVKTkI1a1Y5bTVldHRvSi91?=
 =?utf-8?B?cDdaM0FiRE8wVEd3NkE3elpTQ3FGakp2QjhNTlhIMHplWGNqc2h0K3M5cEtB?=
 =?utf-8?B?QXJpYVplRDN0QzdWeVFxTC9nVzArS2FkMzZOSkxJL2JsMmNURGVzNCtjVm5S?=
 =?utf-8?B?RkdVTlptYkhaVkk5ckw1enpjNXk1bll3RjkvdFpHMEp4aDNqK0g3UDBpSnFB?=
 =?utf-8?B?Q3ZtU0lTSkwrMndxMlcrUDBydXAxckEyTFk0WFNXNzI4SjVmMU8va2lQaTdD?=
 =?utf-8?B?TFRucE5vTVYvMGRiNHVTNmZKY2NMbElqK3ZyRlljZVIvSlQxSi9LUEVKM1I1?=
 =?utf-8?B?bHVtS0JkZHJJVVhKd1d4WGVYOUNZZ2t2M2hmWCtWWnRZQjNLVWlxVG11WDh5?=
 =?utf-8?B?TkRFZ0g0d2U1OFl2dE41dVhmQWZDOWJpSEFLRkozRmZ6RFlsK2hPYk02cHpP?=
 =?utf-8?B?b2ErS3JBR0p4eGdjS0hGZG1BaW9hKzNxMzFtZGU2R3dzZ21sM1ZlWVpPd1Rv?=
 =?utf-8?B?SXNlaXQvM0dYNU1HM2owcDNqZFc1NjB3a3dTbUN2cmNoYmF4N1diRTg3a1pK?=
 =?utf-8?B?a3pEeG5CLzIzM052Uktyc25iSEJ6a1FFUGRmNkMrMGdEVUQ4bkxBQmdBaWgw?=
 =?utf-8?B?WWtldDY4QkozcS81bnZVTHNnS0orWG5VS1pLUitoV2tHNkV3dGZYZjk0QWt6?=
 =?utf-8?B?Q3ZoOVdmeW5BVXRFRU5HRjhoMS9zaGhtVFk4azhpbzNweis1VFBNb0poelY5?=
 =?utf-8?B?cUFVMjZOZUNHb1FIMFkzODhPcDRqN29nYVZISHlFOHprOVp1VEJQaG5RbVpU?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 001af304-0e5d-4185-1a4b-08dc6ad09cd7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 17:52:19.8141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgr1Z1iMJvVKwtoijXccDeVNz+P4DJePYzHBhwHVuuxm9yg32JC54kbOQ9bVcyjWJOqx115XoXNA9fr52TjpomqWtVc1ns8iOwagj3nUFnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7133
X-OriginatorOrg: intel.com

Hi Dave,

On 5/2/2024 9:21 AM, Dave Martin wrote:
> On Thu, Mar 28, 2024 at 08:06:50PM -0500, Babu Moger wrote:
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 2d96565501ab..64ec70637c66 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -328,6 +328,77 @@ with the following files:
>>  	 None of events are assigned on this mon group. This is a child
>>  	 monitor group of the non default control mon group.
>>  
>> +	Assignment state can be updated by writing to this interface.
>> +
>> +	NOTE: Assignment on one domain applied on all the domains. User can
>> +	pass one valid domain and assignment will be updated on all the
>> +	available domains.
>> +
>> +	Format is similar to the list format with addition of op-code for the
>> +	assignment operation.
>> +
>> +        * Default CTRL_MON group:
>> +                "//<domain_id><op-code><assignment_flags>"
>> +
>> +        * Non-default CTRL_MON group:
>> +                "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"
>> +
>> +        * Child MON group of default CTRL_MON group:
>> +                "/<MON group>/<domain_id><op-code><assignment_flags>"
>> +
>> +        * Child MON group of non-default CTRL_MON group:
>> +                "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"
> 
> The final bullet seems to cover everything, if we allow <CTRL_MON group>
> and <MON group> to be independently empty strings to indicate the
> default control and/or monitoring group respectively.
> 
> Would that be simpler than treating this as four separate cases?
> 
> Also, will this go wrong if someone creates a resctrl group with '\n'
> (i.e., a newline character) in the name?

There is a check for this in rdtgroup_mkdir().

> 
>> +
>> +	Op-code can be one of the following:
>> +	::
>> +
>> +	 = Update the assignment to match the flags
>> +	 + Assign a new state
>> +	 - Unassign a new state
>> +	 _ Unassign all the states
> 
> I can't remember whether I already asked this, but is "_" really
> needed here?

Asked twice:
https://lore.kernel.org/lkml/ZiaRXrmDDjc194JI@e133380.arm.com/
https://lore.kernel.org/lkml/ZiervIprcwoApAqw@e133380.arm.com/

Answered:
https://lore.kernel.org/lkml/4cd220cc-2e8e-4193-b01a-d3cd798c7118@amd.com/

You seemed ok with answer then:
https://lore.kernel.org/lkml/ZiffF93HM8bE3qo7@e133380.arm.com/

> 
> Wouldn't it be the case that
> 
> 	//*_
> 
> would mean just the same thing as
> 
> 	//*=_
> 
> ...?  (assuming the "*" = "all domains" convention already discussed)
> 
> Maybe I'm missing something here.

I believe have an explicit operator ("+", "=", or "-") simplifies
parsing while providing an interface consistent with what users are already
used to.

Reinette

