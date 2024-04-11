Return-Path: <linux-kernel+bounces-141647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 060CE8A2129
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895741F21AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0731E3AC2B;
	Thu, 11 Apr 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2Ch28c8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760DF9DF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872538; cv=fail; b=fFTzskDbojgiu/ShHFC6nx5HFTXtSpMsSP2J9wwwqZ5ziqhSt3o6OuCRsJaKGmBl9Ue4GDw8tYVS5hoH4aqDnnPltZdBL7IEsPe9qYp9uj5+s//YrBKyRFczlkMTY7UURnPn4WGUcWvjiS51rHXlwYhPKkuGWDq08VsmRLILVVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872538; c=relaxed/simple;
	bh=rhsRvU9IeLMkKeuZ13xjDfTizFU8mbHOIhSOzRxAD+g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RBbyBUEo+e0Oljf6PoF1in0zXSAYVrZHBg6NcyIHkj54I7ybNxMampywIBhzi6GiLZQYYowWtG4ZlTIlNU9vzK/kRHDZQGdY90nD0cEcbmNRMMtYNYdvrQnztQDP64va32b3a71uEWS5IOTFtvU59eqE5JOVAOdssynoLl4t1F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2Ch28c8; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712872537; x=1744408537;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rhsRvU9IeLMkKeuZ13xjDfTizFU8mbHOIhSOzRxAD+g=;
  b=A2Ch28c8QcRhPUI0m8QjlFsU48R+un0QaoZCLKXtau8kpmAO3rHgEAXZ
   OS2WU12jbwatP8QEWW583J9QyA94jTIMFVYSbTD8DlpK3TO2h65JOIgWr
   JiJZdZERFstAKUHJ/lD5S36BTPCzpU4yG6QSfm+3aVFUfHwsudSal8IK1
   tzs7NeIczj4nqhzNlDlgAlBFAjM3lBYg5L2IwccVi+PjGVgtspQaARTDH
   xcohc1dhNciogaboz/ayS1uYFVLLKNXNKpX+mdlwJSunw5yNyoPdNL1G7
   tIRqfGaR4i6xs9xsiNddDn7nVA9k/q2qWCg7ponbbRFeKijWJhrJS2uYT
   g==;
X-CSE-ConnectionGUID: 1W2O27lZQL+i8fvo8Sh8rw==
X-CSE-MsgGUID: S8e55/dYTDWNS6OpM3s+cw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12100623"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="12100623"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 14:55:35 -0700
X-CSE-ConnectionGUID: OY5HDYlvSLGX6HbKOrRClA==
X-CSE-MsgGUID: C+rhowzhQdaXd/cGrS600Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="25830808"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 14:55:35 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 14:55:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 14:55:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 14:55:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Txb6BZtUTDadv/Ra071LVNAVZkzKN8lCyxax1WCIBS4bfsIKtcFnlDr39o2x/EnENJZytOc+M+ei69NiuuQpI29K+isfs1evWe/aQpiHN3Xjc1/fa8CLF4xZLN9FKLpNqgi3lBnOUA/nc5GhLOLkLoGgj2tIxZ3Zg51VlKnQv7iJ4yUAsQw9fpxMDDOz4nkLpuL2Yq+CrgVeyImBg+tZaWUIF9dNZuHWrqY7qzr6qdFxVXaRJyTWfn1GOLtedJU8vEYFwaAD2LGYfA2PQAxNW1HOcqYmz9CwoDb6H5Wsqexddn/l5E9RNfJxcJkRlCYRSCo5PKEXWQkcs+xO2Eg18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdDe4kk35V50ivuqfYmkNrTWU/Ls/8DUU0gM7O4/O9w=;
 b=Ka8qXOR96GgQGR2PCfNw3BdzphGCfNClLiUmokzb5veCLbC5P4GEfCEkVk5giEF87gkSptLZTnTEEt6wcsE8kQryjedWPEd4kaukr1mpXuOxLNIRcVMNwjgC01/4VDxkHimfIdD6E8PZeP8zBodPr6Vq692H+fjX/nCVbi5rUnDjWi0AmOgydasIdW2vQJfugohTZ/Q5/ffs0CjkcWnca/j5lqOj4AuCY/lZv3cnddgl/Sko3H9KH7SB4FO6FpJGRAKWjTHTMfhUiNFKpl8YnwGW2CuwoQiHpl/1n0+4XS0WOPlBBsY9uaGpWfUXGhh7i53c/8wQJvCEwx0uJzzJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6118.namprd11.prod.outlook.com (2603:10b6:8:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 11 Apr
 2024 21:55:33 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 21:55:32 +0000
Message-ID: <224a0aad-077b-4830-8e63-3a42a86120fa@intel.com>
Date: Fri, 12 Apr 2024 09:55:19 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
To: Tom Lendacky <thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "Gao, Chao"
	<chao.gao@intel.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
References: <cover.1712493366.git.kai.huang@intel.com>
 <33b985a8f4346f4bcf0944eaf37193a906b11af3.1712493366.git.kai.huang@intel.com>
 <e94d208e-964f-cfc0-60a4-fe70db52bec1@amd.com>
 <cbf171e1-a518-429b-fd07-3526a0b252bf@amd.com>
 <e24e0de1-d984-474a-8b79-ea0934ac668e@intel.com>
 <3ad70c7a-a2d9-c7d9-4921-13000240c086@amd.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <3ad70c7a-a2d9-c7d9-4921-13000240c086@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:303:8c::13) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DM4PR11MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: b500be94-05d2-4410-0f7f-08dc5a721c5c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3zf2DpV9abhPKcTIzH8QB1dxoSiUBTirb43t6dlAQLW4QUy3ee6uAMz1HbRr4skEYOUYe40jAKMvKzlvb/KMZ/HFDoN3jWcd/qgLxSs7LePnYItXmEXHn9QhVJ6WYDBoLluAuty6RK8MarGrUoAue2KF/zO7/uTPov6LPswuz4YF7tyJpYEDF3uzSghgropzZmKDLiSBhVsmqb6n7X1u9+YIOT/hbHxQJe4iPGpmQ3KFKaCSCFEWxhCWB4+iT+zOACaowBA4N4UfRyqBuLeaB8Jn28ZCT0PpJmwe8hN9CnZ22uN7Fl4FJAKpAWdLBokfgOMMI3aqM72DURhf7+fJipkI6TVA4Y5H2p2v3JoBfbsUceR/b7mJt2kCaVNRWxUNK8Io7SUrNUjjU9eWAjNKNXJrXoQvrumvnBUfSfSnf84YQrnfmofHbL/mOtmo1G9K5ZTqR1bXkz8yblYNk9H7hgD5oyHcYtCQX0o7v0smTrguH0rx0BIr4YkP78q6xNRhSYHj0RztPa22YaH2dWrXUkZyrhos11SoyONLQOhHrGJoIZxJ59JrjaT9XZPgUGYhDeDRerDCsAVVNP2kDwmEhEVWfvpAjeOalrahkXVunPtSCK1EqjFkuiQBr43KXP4IMlWDOgZk4QdrsCF6wkRkRv74TnhbiRnsl8uWszMWIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0QrYm94MXl2akVFcjBJMkwzeEZyVlhyY0hvSTN2WE81Mm9yZTdkM2owQytD?=
 =?utf-8?B?Wm84ZE5zMGdUMGhrVWZhenJzUUFlUFV0K3dCWi9ZUmVpR24vbnl3NEJ0eXht?=
 =?utf-8?B?Ulk3eUVDaENZc3Qwb0hNQnNiTkM5cWdpdU1uZjJXcDBLdy9Dd3hWRW5iSWpl?=
 =?utf-8?B?ekpROEZ0QUVoY3dNUUsxM0JCaGt1SUp4OUlkaWkzOEhuQVFpRnA2RHhxcDgx?=
 =?utf-8?B?OWh6YXVVWnlVUVhWSmNCcDF5NUFqVllnRmx5MWY2ZHdRekhuUjBZL2MxdkZ2?=
 =?utf-8?B?OWtOMGc2QmJZWkJTWTlGVDVKcjg4Q0VLUGN3RUhMbFo4TEhReWZLU2tydDd1?=
 =?utf-8?B?MytnY2tmVy9aUGRsRG96OUpzQkZSMmRFRHlCWlRWandUa0g0N1pjam1TSExW?=
 =?utf-8?B?SkJ2R0hhTDNkWHNuQjh2UEdMVy9YV29UNUhQQjA3UWorWURIQ0R4WVA5OVpN?=
 =?utf-8?B?OWRRUEFiWEtYU0FQN1M1c2hhY1dZazJ6aG1qbkRZS0dNNVk2SmIwRHlybTZU?=
 =?utf-8?B?V08yQWFuSGw4QXBYTXczN3FnYUpIT0QrOEtYTUNwRmFtYWMzajY2ejdac3kx?=
 =?utf-8?B?UUN2VUJ3L2hLY2MvWlZYVUY3WFRvVy91VjFITzZqZ2QxZWNrMGt1Ry9ueDMw?=
 =?utf-8?B?Q3J2ejJZd2dzRUY4bWttSW04WmlkMXFTT3I0eEpFc1p2cTI2MkVLZ2ZIc0JE?=
 =?utf-8?B?MndVWVQ5RTNvSEsxbjZFbWtmS0lUZmVkMUNQbk9aakd3WjBEM2FFcklkTFNr?=
 =?utf-8?B?VDlEMXRBY3hTaUw1dTZPMmFsN3VrS3owTTk2bVJQZ043K1I2ZEQ1R21zdEFa?=
 =?utf-8?B?d09iQUh1L001Qm1LTlh3TzNESTY5cW1qY2VZTk9ORTdwQkFZS1hnZ21rUW5y?=
 =?utf-8?B?cmtPTGFYeFdSRGVrYnpMeUFwZ3NkOXpuRjF2b21EckVDSzNoTC9PVVZUcVRY?=
 =?utf-8?B?NUlBMTJscDc1RVM3cnIxMlRNNlZ4S1lYQjlnU3VNOVY1b1JQNmlwU3J6bGxs?=
 =?utf-8?B?M1dobjFFRkVPNVZGUGNNT0RwWDdZQ3dGR2JFdDc5Z0tyWm82UmorcFBON0x2?=
 =?utf-8?B?MnQ5STJ4eFV2RFRLRGpuWVFKeFBXL1FQemVYL0tTVlVNMkZUTnpQL0ViU012?=
 =?utf-8?B?VTZQOURTdEUvd1BUUzFEOGRIN2R3a3NtOElMYmQ0cWdnUDZUUElDbVczUzF6?=
 =?utf-8?B?aVUxVmJhSjJSU0NLL084QzltMWF4OHNkK3RGdTEyNTRBZlM3OTROSUVFdklr?=
 =?utf-8?B?UjBVS3JxM3hESFVRQTUzQVlzQzBUbkRndWk3WStrUnpzNGNZRUxEZTRNcGtL?=
 =?utf-8?B?enZDaTk0Q1pwMUtUZVp5OXRnODJjSlp6VVBVbFB6NHJrTkxlOUNlOVlPcW1r?=
 =?utf-8?B?YXkzUEdaaVZMTmhOcWJrc3lLQmdPaXpiSzRtWTd0UHJKUS95QmFROVNoOG1X?=
 =?utf-8?B?TDM2bEJpeU0xYUpQSWpyaDZkWTh0dzhwV3IvendodWRyQzlQaHF4SDNTL2tp?=
 =?utf-8?B?ejMzS0xXMm5QUjVQVFhtR1NaS3d5bVo0WEFxalRTZ1E2dExpSm9OL3JNZjFS?=
 =?utf-8?B?RnVoZUw2dUYyVmdiT04weHI1UVcrS0JwTmgxelZ1RnJocHRGdHorU0t6ZS92?=
 =?utf-8?B?QXM5YTg1emlnRkpxcSs0eUpScVluWFR6SUNKblM4UFBGNS9HekJLRUk2STg0?=
 =?utf-8?B?bHRKVTluRkYxNkFxeVVseHJibDNOWnA0Wkp6eGQvQWFUbHpqWnZEcWlnRkxm?=
 =?utf-8?B?SUliUlhOcjF0U1JKazRtQUNWNHdvQ3I1OFJTYkdjQThGT3p2TkNIczkyNGRt?=
 =?utf-8?B?QTJ3YXErdWJSSmlheXdBMmliMEQ3a1YrR1FnTG9xdWdIOGdVSzR6cCtoQlV1?=
 =?utf-8?B?bUJGV0l0SlJWTDBpelZUaUFLODRxU2I5dVVWS2EvbDZUMDF0RkVBd2VhY0tw?=
 =?utf-8?B?TzRiN2NxcUVBMGxTVnhLZnRtSnEwbVhGUXNJUElkOUFmUGtDUUlQWWRaa1NN?=
 =?utf-8?B?dFhkVmw0bDVHVU5CMUJCVFJxblZLaXV5aW1yTkZuZytVcDRKZk5paFNpSnlE?=
 =?utf-8?B?TXMxR0dMQ3U2NkREY2QwTVozVGpQUDJGOVplY3dObjNrUHFwb0ovbnlpZ2xn?=
 =?utf-8?Q?OHSZ3vhYNT5+RvI+A0qMWZo26?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b500be94-05d2-4410-0f7f-08dc5a721c5c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 21:55:32.9353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhlVusV+3toFnxg8akX0P+A6jddjIcVoccRr04sTgzvBgB9aGhHIPsYVXlSsG6GC931sWcrkSHC3fodr91xcnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6118
X-OriginatorOrg: intel.com



On 12/04/2024 2:13 am, Tom Lendacky wrote:
> On 4/10/24 17:26, Huang, Kai wrote:
>> On 11/04/2024 4:14 am, Tom Lendacky wrote:
>>> On 4/10/24 11:08, Tom Lendacky wrote:
>>>> On 4/7/24 07:44, Kai Huang wrote:
>>>>
>>>>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>>>>> index b8441147eb5e..5ba8a9c1e47a 100644
>>>>> --- a/arch/x86/kernel/process.c
>>>>> +++ b/arch/x86/kernel/process.c
>>>>> @@ -813,18 +813,16 @@ void __noreturn stop_this_cpu(void *dummy)
>>>>>        mcheck_cpu_clear(c);
>>>>>        /*
>>>>> -     * Use wbinvd on processors that support SME. This provides
>>>>> support
>>>>> -     * for performing a successful kexec when going from SME inactive
>>>>> -     * to SME active (or vice-versa). The cache must be cleared so
>>>>> that
>>>>> -     * if there are entries with the same physical address, both
>>>>> with and
>>>>> -     * without the encryption bit, they don't race each other when
>>>>> flushed
>>>>> -     * and potentially end up with the wrong entry being committed to
>>>>> -     * memory.
>>>>> +     * The kernel could leave caches in incoherent state on SME/TDX
>>>>> +     * capable platforms.  Flush cache to avoid silent memory
>>>>> +     * corruption for these platforms.
>>>>>         *
>>>>> -     * Test the CPUID bit directly because the machine might've
>>>>> cleared
>>>>> -     * X86_FEATURE_SME due to cmdline options.
>>>>> +     * stop_this_cpu() is not a fast path, just do unconditional
>>>>> +     * WBINVD for simplicity.  But only do WBINVD for bare-metal
>>>>> +     * as TDX guests and SEV-ES/SEV-SNP guests will get unexpected
>>>>> +     * (and unnecessary) #VE and may unable to handle.
>>>>
>>>> In addition to Kirill's comment on #VE...
>>>>
>>>> This last part of the comment reads a bit odd since you say
>>>> unconditional and then say only do WBINVD for bare-metal. Maybe
>>>> something like this makes it a bit clearer?:
>>>>
>>>> For TDX and SEV-ES/SEV-SNP guests, a WBINVD may cause an exception
>>>> (#VE or #VC). However, all exception handling has been torn down at
>>>> this point, so this would cause the guest to crash. Since memory
>>>> within these types of guests is coherent only issue the WBINVD on
>>>> bare-metal.
>>>
>>> Hmmm... actually it was the other WBINVD in patch #2 that caused the
>>> crash, so what I wrote above isn't accurate. You might want to re-word
>>> as appropriate.
>>
>> Yeah that's why I used "may unable to handle" in the comment, as I
>> thought there's no need to be that specific?
> 
> Yes, makes sense.
> 
>>
>> I tend not to mention "memory within these types of guests is coherent".
>>    I mean the current upstream kernel _ONLY_ does WBINVD for SME, that
>> means for all non-SME environment there's no concern to do WBINVD here.
>>
>> Here we only extend to do WBINVD on more environments, so as long as
>> there's no harm to do WBINVD for them it's OK.
>>
>> How about below?
>>
>>       /*
>>        * The kernel could leave caches in incoherent state on SME/TDX
>>        * capable platforms.  Flush cache to avoid silent memory
>>        * corruption for these platforms.
>>        *
>>        * For TDX and SEV-ES/SEV-SNP guests, a WBINVD causes an
>>        * exception (#VE or #VC), and the kernel may not be able
>>        * to handle such exception (e.g., TDX guest panics if it
>>        * sees #VE).  Since stop_this_cpu() isn't a fast path, just
>>        * issue the WBINVD on bare-metal instead of sprinkling
>>        * around vendor-specific checks.
>>        */
> 
> I think that's ok, but maybe just adding that the WBINVD is not
> necessary for TDX and SEV-ES/SEV-SNP would make it clearer. Just my
> opinion, though.
> 

Yeah can do that.

Will add "WBINVD is not necessary for TDX and SEV-ES/SEV-SNP guests" 
before starting the "Since stop_this_cpu() ...".

Thanks for the feedback.

