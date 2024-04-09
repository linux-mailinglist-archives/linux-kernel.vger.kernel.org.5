Return-Path: <linux-kernel+bounces-136191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B9C89D0F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9241F26B83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849F176037;
	Tue,  9 Apr 2024 03:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CW4ao9ks"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE3757E7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632763; cv=fail; b=hwpGh/eb9ps8/rlWF53FtgI/+i1llGkhyMrqbqIjuzVEHL9cmb0lnR6IS4EcPpbKnfqk2NSgTvtuqZHG/11/P5sCDhs7UM+QuMl+H1lMxEtRmaJmzA7ucM3h9lTnFZ8aDx05FdBTOuB1Q9cJzzBCDmq6esun/SkgRcAdaaVFwzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632763; c=relaxed/simple;
	bh=yUH+40wOXxuywofxp+taeOu7mRz0kLDsrSAD1qcv7JQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RA6d+am6wsGPaSqy9CyL2sV3YIn1pgBQ5b4+YKBfRS3JDJ0C+1Wvc/RzMJN1+CsFv9T2QrjjPq7P41HYLicqtxC2HafEBcaW+nZr14DRzAUwWtKBinL/7gLBStSTs4gc7EeC1qkPK9dFfEjRrLRvIlJMOsGtZL6W9+kHCLgnudk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CW4ao9ks; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632762; x=1744168762;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yUH+40wOXxuywofxp+taeOu7mRz0kLDsrSAD1qcv7JQ=;
  b=CW4ao9ksiCAskBQ3+tKVuIHLjFlRMbXpNGKzvCzJRLNdIedBiOw7cG8M
   rfwGc/VYrOvcEvbCWq6RhtM8AgVQn74hmMXvds/qPKgPufoiIRaPmtdRy
   DazrMBVVaCNzVbdBt4w1Thd+29+oyaGF+/rRNVB82oRi69qJD5bwngClK
   DY1vTJdFmnzOSdYxFnyS/YpH8CoJ19S+9zB7Rkxl7p4IQd2r6wf6O8Zix
   /Dc/2mcWPa0WV4bIHOErxU/0/1+d9TQqhIyrlo4/evtL+1mlYh+OPvCKy
   HtE4z5QIlKM42CWa7fAlLMApbCFpxStZa8NCAuM80uPhSj1cw4YsDEfxt
   Q==;
X-CSE-ConnectionGUID: tD4nSU/eQBeFED/CpEHpEA==
X-CSE-MsgGUID: 3ac2mGSHRZyNc/6tjv1sSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="25435987"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="25435987"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:19:21 -0700
X-CSE-ConnectionGUID: ul3gC5EdS8WbMQudW316zg==
X-CSE-MsgGUID: Gzm1dDeKT8WcbFUGM3PTHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24576016"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:19:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:19:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:19:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:19:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDNzQiqxWKsLV+I0dHOPfVacwy/kyXkQ2ari7GTKH3T984QEmJHYP7dfN1zYhCeARPZDLlZHRoETnB0GRPFcJKITirNBBjV3gGargOMQy+NCnhdU42Kb21OjZ9gwRANshUWbJSqmfWf2VbA442CM6QeKGMcZyYIkbpUfWaMRSAtMsKesi3THqL5dMM+Fv4C37gTCeYoM4vnaKNUD9ON0x8WmWSwD8z0bqhKJAzQ3S7XpalYZATZ56py44OYgG4fDr7k8MfsXzG7Pwa/CBBmpQpfSofmlKmv9yfesCmjeEtfLdPh6DpS3gtk5Q97INfb1IR/hWCGif76IKC4k+l4HHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXlbH+5+zt7NhgEPJ6JcQXrNm+YJ7Nd5N8NPWagsdMc=;
 b=Scwsg4U/rUBqGcocd4/OF7yH4V46zrPyWQJSb9frDCbH00MmleI2llTWc1mHGS28MRX1IfWC65ZmxIlrfC/o0agBQW1Gl5B3NqwKbAR8QzptUgxbeSeWuwiOxGa6uSExJqev/sG3LGIi2scB16kxlMGqt10dkt0lSaBvdChMFSw2kY2mr3zY73IrHNYXlaujKo3Ori8yJcKeF1/Gdt/eZNbE+6usYbxUcjWPN3sBWEwKkuTl4SjnEoOOPoSKYMmUV32HK4wcWqi+XWzhUIVLfsUD+HKeAZPn47PcxnhfqvPzjLgznGc6vG49djDrlkz9m4ROUdvwxkUDFLxn9OqwZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:19:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:19:17 +0000
Message-ID: <fc4ee516-54b7-47cb-b881-00ce10d311a9@intel.com>
Date: Mon, 8 Apr 2024 20:19:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/31] x86/resctrl: Move max_{name,data}_width into
 resctrl code
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
 <20240321165106.31602-13-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-13-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:303:6a::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDBqBFLC572s7vy8EK/XVO22xxBmxbo05xeIMPJJ22HeAc/KvN7iHD/v+nYyUvIgs1HfjrBSb5ESM8dhFJPoserlYFySa/U9nX2Lwqjs5ukGy7iYJ1KbtNgPAm/kkKiYi/4kxWL9u2x6yTePNOlJC+j6DrMtILcHoG6DHttqcZ04nbu5tBVYyjR0eiw+pSw+csWOX289hQ7Q33fkfKiljMLaHLMeC0aX3K+OpW5sC3o4xjX5VUjl4zoO6kptZTDLM+brkLJhA0QARCCDidUTS3bPdHfyA2nKiVcy815JlPXzD4fm1mBmI2+9S9u7+OAouLQMMvlR32ccTTrDF4rqR6IpLIB+LZvpu1hFEePH1jZzfvLxfRt28QR2r6QWYElWApATvYCVLSETNKmibIybFLA3DuyzI05lPdASiKcQZPl7MCqDyGQ9ffrk3XlPoLT3vsCZVzksIdT8zkUmcSqAFQP7/OZwzeN8WfYec4l8MokK9caLo1gt77cNRLdFKa96KILG0GvWmTugdeni9IISYOcvkV5Y+2J1jj0bGuOWd5v0NzZvNi5LvfRC9T5x7ryqvvJiknZLl7PlmspQL1YROV0Mr3TJXf7xVPaTnFzJb4Uo7KGjIHIJgGnwf7OOZaQyL7L3BD+A5edkhYrDfsw2fVCRpZX2l8E0r5klAijzf0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFdnenN0MXc3a2VRYm5tcnM5VEQ2aTFiZ1h5UjU4a0FrZzZ0YXV6YWFCQmMx?=
 =?utf-8?B?ZlFVdzRhaGloOEZMYVkyUG1ib0JBUGdUVHN1ZWcvVlJlbVJJcDI3SlFXQnIw?=
 =?utf-8?B?anpJMGdZR2RvcC9mQzNNbkxSaEFVZEVlekZUb2Z2RmlKc0NUb2o1RmpZRjVN?=
 =?utf-8?B?V1F6THdRQTF4aEV5T1QydE1zekxjZDRIQWpIR2swc1UxZ2JlRHozVXh5aVh0?=
 =?utf-8?B?VFFRZlkvMHlyVGJaTGRoTy9XN21QQzY2NEJ0cG1EUXJYV3lGeVFmVzBWdjRs?=
 =?utf-8?B?ejkwQ3Jod3h3WWJ5ZVJkSkxZWlVEVDA4Z1BRa1JZWWpxRng2WlduYnlrRkNh?=
 =?utf-8?B?NnNLWVVoQ1ZNMGxnUUR0RTdwNHl6U0dFaE9DYjM4SlVtbHU1VUpXSk05dnhX?=
 =?utf-8?B?N1ZzbjhwZEFSMzAxZHQ0WGlweHZyazhPY3NiWTlTUE9SRlN2eFVZdjFTT3Zv?=
 =?utf-8?B?MFRsQ2VSZWJ3cVpqcFNPSlkra2wwVnQ4S25aR0dheDc1LzVXZERjczM5WHBo?=
 =?utf-8?B?OXJ4SkNSQ25EMEFMckhHOUkyZ1NvVGEzRnR1NUdkZXY1elhQb2p0S0E4Y0RC?=
 =?utf-8?B?V2M4bGRkbEZEYXRjWSt3aFhkQ1dlUEM5b2QvbEtGTVJnUlRpNUx1UlFsSXcw?=
 =?utf-8?B?N0FxcTFpaEkvYkR0dlZzOHREL0FSbGh6dFlXb1lUMUVUOHA5K1ZDTElwR0lz?=
 =?utf-8?B?dkNjMHFxTXNobUNyTW9RQkYwL2tOUGttYTN1Ui9NZUdsR3kvZ3hNVUdPRWQv?=
 =?utf-8?B?Q3JxUWFhUXd1ZzhGOVZ5QTJobDFzcEx6ZGFYYVhHSHFtbFJYUU05K3NQYmFC?=
 =?utf-8?B?ZGNzelk4YXFxa2k3TWhLQWlBZ0dQU0l6QWdROEJwdjRmVUtydGV5ZFBxa2Zr?=
 =?utf-8?B?dkYwUnkzMng0UnVwN0lFQjEyT1V3OXdiNUN3OElJRXNjellkc1FOc3BHalla?=
 =?utf-8?B?Z1ZvSThTWW9IQUdqeWRRSjd0M3BQbENXOFBFSE5zZlBvaFZJMXZBNGJJa3Q4?=
 =?utf-8?B?Z1hCbVNwVjZJVTVSQVpwOHdac2lEdFFFcllRdS9WaWg5ZmQ0RnpaMk5DT0cw?=
 =?utf-8?B?T1Z2SG0wSitQYXB3K04xNGtNcTZ5T1BxTHR0WmxNTDcwalBOajh6c0REZXZv?=
 =?utf-8?B?b0tZSUl0Y21wWFhLZEJGV2gwazZUU3NCOUZ3ZjhnbERGaUNuWjJjbTZiTXJK?=
 =?utf-8?B?czFtNFRjSzR2QjlWRWlSdU5uOXVSZTliTmQ3NEovaTh5SkdDZUxreXBHa0E2?=
 =?utf-8?B?UXc0REl3cUxYSnZjbVlIZ3M0NCs5SUduaVpweUxoRzh6ZCtXRXlOSWoyR25z?=
 =?utf-8?B?cWtpNUhZVEVRekNtZ29jSXJHOGQ2c20vQ1RxTGZ6dHQ5OW84L1ZIb2pHSUpX?=
 =?utf-8?B?NzhGaUJmNmMyQUhxbkRuRisvU0FxemE4R0NJUzFCeWQycjV6N24zSytEOGJ4?=
 =?utf-8?B?aHlHWHB0Y2dISTNoamxRSkFqbm5UNS9yQU13NHdrVk5vNjA5eEZibG91ZHNi?=
 =?utf-8?B?eEo3dVNTVEdFVDk4RVNkOWlPY3M3cUFiY1M3MTFLdSt0MU4zeE1DQ1ZSQ3hS?=
 =?utf-8?B?cEhCQ1AzZU55dVdacmJhTlVvbmRyeGw0bzhYWG85UlhLcGNvMGhSeGVpcXAr?=
 =?utf-8?B?c1Rra1AyUEcvZVJQVnYyLzVZUXhNdVNObTVaa0NFNWFWOUk5MElBWldzSTJB?=
 =?utf-8?B?UkdpV1NXY0oyYTRWSFNRWlpOOWhpNk5uMm14dXpFSzFaejBjTkpjZ1BoYjlJ?=
 =?utf-8?B?OEpHQkNYUDNDQUgvUVVSek8vNU84a25JaWhBOXVmUWdrSWRmb2ltSFZkT2RN?=
 =?utf-8?B?ZTBxSFZ2R0NpdXJITVYvSG5JbkZRU3YwRnRLbWxVeWN1VUV0R090Q2tnNnJ3?=
 =?utf-8?B?U3JMZGdxak5ZRlJoN0FNOXZGNHhENG5XR2IzN3lucGRkdU91Vm5FbkhGY0JX?=
 =?utf-8?B?V2VmK3cyaGYzMjF1T2NyeEE1NDhEdDdMQWRLSERMUGVhNWwvSXU5RWhYS3NG?=
 =?utf-8?B?cWJhUWd6RDN6MENBWERvdXduMGV1UTVUa0I2WFA5SXRveElzS3lIbkUySHk4?=
 =?utf-8?B?NzBwc1g2MEdZYjVQYnNCVTBBcUpWYkxTT0IzOFcvcisyWVF1K3FJT1M1UTM4?=
 =?utf-8?B?UHlWbUZQUFk2YlplVnNabjhISEZiQ3NPd1ZDMldhbzAwS0dwN2NEZmpnTXBD?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e08659e-adc8-48b9-637a-08dc5843d728
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:19:17.6554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+AKMnTeo73P1L4tEbCTAV6BL6O9l/Yqjg/9SxULs3R7Fp4leJsTaJy+94YhVlieFd8ZexNLeElprJ57zs4ICJp/p7Fs3VRydTOHV6YCl/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> @@ -2595,6 +2601,12 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
>  	if (cl > max_name_width)
>  		max_name_width = cl;
>  
> +	/*
> +	 * Choose a width for the resource data based on the resource that has
> +	 * widest name and cbm.

Please check series to ensure upper case is used for acronyms.

> +	 */
> +	max_data_width = max(max_data_width, r->data_width);
> +
>  	INIT_LIST_HEAD(&s->list);
>  	list_add(&s->list, &resctrl_schema_all);
>  

Reinette

