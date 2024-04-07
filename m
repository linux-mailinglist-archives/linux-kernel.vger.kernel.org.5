Return-Path: <linux-kernel+bounces-134626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22489B3CD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 21:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3595C1F21B03
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F173F8D4;
	Sun,  7 Apr 2024 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oz9qSPlR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F53EA62
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712517710; cv=fail; b=p+72g6p3PELSLJuzjwphCuFWgXSeTlYbcoc54Kq4V5ArQN4KRWcfvuGqsvhuTkNZp8a9i8SNZP6HP26DBCenmn+lXNSsrlIBBjMiEE0GBDsLpJz+rM1E/7QsZvpl17qFCdEuq+1KyGM8mAhAVDktlHVteIns4zVFFOwcb8EzW0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712517710; c=relaxed/simple;
	bh=nL+lTTCv9UFjHib3pzrrY8PxuHEr8GPtmSChk+fK63o=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WgQDKSW7o4E5l3ZnFFnxehrnfTUY7psDu5i7+faxabxdzfs9zY3iVu2DO3TcgFAJB3yqjdkRdCyzwZLVvXd6dBlj6tDHCvZ1ytXqtar7ryJGqNSY4pfwFRE2aX0IDZbdHQEfjxsAUkS6n5Z8I1ff1BJxdb2BprdJde5tyXEfgio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oz9qSPlR; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712517709; x=1744053709;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nL+lTTCv9UFjHib3pzrrY8PxuHEr8GPtmSChk+fK63o=;
  b=Oz9qSPlRrd4OsI6iMRj9yS4IPU1mXEPYpl64wBy3xdIetphVpdqaoDbc
   cRC7Ntvci4WbSeBEWT3q34h7OCfpKyY7bbu8Ek25m6Cr9xLLJ2FSgyp2a
   teVkptkEdWyUdUbIWus1StwoHNblD3OcnMn8EGfrCiXRxBlN1+O3KSWQW
   z9JbJmyrt4NiCZgzm5Qt5PLTwLdOmit1LCHvbB3L0Q6PJggM1iS2lZ2ab
   AcICGl5gydXW+JmOZ8HoihZ+hn7o5kgkqYTJt+1BreLosplnnWfbLIva7
   4jJgfDYXypBFRvn+mA11tviyZl2XtWGPHdI6PcmUDPT1EAja6CmNGYoVw
   w==;
X-CSE-ConnectionGUID: mO+h3B6HQnKBfhj4kVccEA==
X-CSE-MsgGUID: mGNXIiGoSaKOI4fenW2pmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="11565144"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="11565144"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 12:21:48 -0700
X-CSE-ConnectionGUID: zlP7gb1rS3+qFw7O/t3J8A==
X-CSE-MsgGUID: WNKfcgbNQBemauYEJ/dbZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="19763691"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 12:21:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 12:21:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 12:21:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 12:21:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 12:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkC31cnkBWerZYepSrpDSkW33yLngGj471O37Q644qM5XdfJXLV75dZrtVBK+PlSB2DQ8pcHLcW+RGBXLrVf34wTfZcmUdkSi2HtIWQxUljPVimGa6S4gF+QuipcZCzgQXrEparw33FF8X87wMqT+YNQLZv8R/qoBBCpkrNk83DXmRK8HOE7YqcQ13ulit1He5rTDwHrJvy8P1H4ftwVxbsv7M7SRapziKDZXn+yB1Nrjq73BnJF36gmh/7rW+wglUIz/KQLyLOyGQ8fAYiUNxoJ+enc8gTPHrztmwr/nZusMhOb264jJ2VvfL8sIhNtbYgasfyQZ0IYPiFYc2PdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7buSdbp8711QYfbLhekP8+7t9HqxPNzEicZ/yH2KsI=;
 b=YX5F0nMxqoSMJs2tsLdXLOpsmNvrcpq5EhEfN50393d8I3Ofyjtf2YYMgSs05oC6Snsu7LHkXDxqilKDWzoQo+fWPCnRwsFO5D78+6TxXF64/6l3JacX1ncVUCbztKS4tRGkF2Cw5q0tMT9ycgyhjp3xjpwkyu4c+V9H/C4yVBUOBJDapTgWaq8P/y7r+63MpcJAYdpK9++zXcFPLPSz2GkBgaPVI0yw4mpLDYtGUc6npRN0SG/S046dD0UxzaW0Ys14CmMdPJQXiQCKr/fYCfxAyAO6hCAFEY/kOtsK4yU/fxkbfjkiVcCQ30VxRiX1pwNiaauhcTKnxwJkJcyhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4743.namprd11.prod.outlook.com (2603:10b6:208:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Sun, 7 Apr
 2024 19:21:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Sun, 7 Apr 2024
 19:21:42 +0000
Message-ID: <a3bdf335-48f4-4658-bdcf-52affb60b5af@intel.com>
Date: Sun, 7 Apr 2024 12:21:39 -0700
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v1 5/6] x86/resctrl: Abstract PQR_ASSOC from generic code
To: Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
	James Morse <james.morse@arm.com>
CC: Stephane Eranian <eranian@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel Gorman"
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, Mike
 Rapoport <rppt@kernel.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, Babu Moger
	<babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, "Maciej
 Wieczor-Retman" <maciej.wieczor-retman@intel.com>, Jens Axboe
	<axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen
	<tandersen@netflix.com>, Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave
	<beaub@linux.microsoft.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-6-peternewman@google.com>
Content-Language: en-US
In-Reply-To: <20240325172707.73966-6-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4743:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pANEFS+XbBTAlCAu8xEC0T9LudDhVQ0tIonKNAxD0lCRFOelraedfaSvavkTs0Vwf6S5ghn9HrgYroC9I6B4z8eGn+hE44X6QW8Hboq65kVuMtiEhDYxPwqOMTmeGr0Q/EcBTgNOtTe5o01MJ5bTsmwQ7GtXnWB+YHLSJGMdAtPE/V9uneQ9nZFRVYdE4DcqVkm1LeCpg9KY91gtuWDtLnQBrsLNKl7wVeh1JslKOE0RbMJw69v2LUdEH64IjVQ5WF+MWd1FZ6u6yVTLGFyvTB/UulZCbYnWiQ/qtnU8JAIFDkY6jjjHFBihH42QRhhR/0pxfzhU84UksIQd/U2VaSaJ07E2tgxd91YojV6qc/E3/rJpFmS49nZSFpDtrle2r5jpxWzCcJnlgsQnP0jSAiqYhdcJF3vG9NlH41eJ/fwHTFxBumCBkIZljkI+9vM+OFtTPo0dBx3PCSib/yl8e+iboaGHV6nDGIGBx5OdrNNXRmBUPhnEubS4v1VlLCBjALTB1BVCfIZYwF5PTkER6zDorspZe0iZSbnANrc0MX61B3sSGazT1nu3Lads8C0SJ+yccxGugDJWsCvc+lRik/oAWTjvnqI/+zfIl/8Bu/DJBqhF5qomjkiD0dzBPYeaaj0aOkKFeZiLpt1zrMJiNjXKWFAH5wSKPE3EgfucXOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGRQa3JjN1BWZzdwNjRaTDhEanZ2dC9mMTFoblNJYWxDRG1XbFpMY1JKVEQ2?=
 =?utf-8?B?SjBVR0J6VWFrTWNoRXBBaE1qTVpnMjVNOUtTOGxLcGVDNnlEdFdSKzhaYWRL?=
 =?utf-8?B?OVRPa2l6c0hoSmNRbXExVm00VHpJWGNIVmV6ZkdUbUJVRUNPUTZXTmdvTERh?=
 =?utf-8?B?YzJWeDFJOHNxd3BQNVpDdkhFNTljTHFKbHFXUy8zcXJUU3p4dU9UUmpmSExF?=
 =?utf-8?B?RHhhcmhBOTM2cGx5NkdjeDJ3bG1Rd2luc0VSbTFUYnR2dytwcWVySkVmQVFz?=
 =?utf-8?B?UEVhTDRncE9zT0JJUHRLYW5adXg3UFdGRTJvekg3UnBvZ0RZUGpCNHhoYU1Z?=
 =?utf-8?B?bFJTOFhuQkE4a2tXdVZybkQ0SjBLcUE3bWpuc29SN0hxREhMUXA1dzZlUE8z?=
 =?utf-8?B?blFZQVBWbm5QUUNYSmIxVm9OL2VmV25qNlJkZnN5ZVp1Ky9BNUxYcmRYaE1U?=
 =?utf-8?B?SVExbzErazhoTlNVekhFM3FCSG1uVW1aUXFKOUtVWnFYK1hLYjRKeFhyeHpQ?=
 =?utf-8?B?T3pHMXpka0VmY0xPV2JtandnMW9wckVFcCs5RVJsVnBEakwzVWxSR0I0bTFh?=
 =?utf-8?B?MFNCZW5EZXgrWkFWVzB5L1ZKMW1KTFdSeE9zc0pTenB5Y3lGSnJac2NXeXpu?=
 =?utf-8?B?N0lTR0w5ajdkZCsrT0NJKzRQZ3YvWHFtTklwRzNnZWx6ZXFOV0c4dG1TaGdJ?=
 =?utf-8?B?M1NZNURUS2JMMGlScWlNZVVMRWMxZUczNkgwNkxhR21hRURyTFZXRXd1TXdF?=
 =?utf-8?B?MkJXUkRIa1IyWjdxTzV5SVJYMWJSMFFicVhicVdpdHZPaHJnYVhtSEUxZlRH?=
 =?utf-8?B?bWQ0azZrRmVGeGtndFViSlBqQjhaM2R6Wm5QaGNPV0RWMUhzZDhrZnlHMS9G?=
 =?utf-8?B?TEN1L09qcXFaTWRtK0QrMldDZEJMa01KQzRIcEk3d0ptSmhSaWNRcFF2U0hP?=
 =?utf-8?B?ZUc5M2VtdzZiUlJiMkhyVWQrNXdZcVE0dXpDNWZCdFRFbnIrYmJwRXV2MmNn?=
 =?utf-8?B?dlRFejRtNmo0NVF6ZFhLaXEvWHNlNmxmVDZNTkdTVkJwOE54MFB3VEVPMHZQ?=
 =?utf-8?B?VDJtWGNHdHpWVVlHT0wvMklDMVFXLzh3d2ZIYStJaFpCc3pQS1JKeWN1Z2pm?=
 =?utf-8?B?bi9HZDhkcWd5YjN6eGpXbGJMb3BENU1UQkQvbDN4V3RHdXpUZVBOOW5mZzg5?=
 =?utf-8?B?aVFSTUdrbVZITTcyR3lMa3JxbDFjdTNjaUl3UHVsUHJhZ1c5Z1ZhWW14UEw4?=
 =?utf-8?B?Ukp3RWN1T00rb21MV3F1Z2xtZ01pZWdpOWtyczZKM2dNa3lKTy9Rb2ZNTFlE?=
 =?utf-8?B?NG5GTHhpWGpPZ0lOMkprL2RoZXYwUVRZL3lFa041U2U5L2tKOVFzNzBlb1kz?=
 =?utf-8?B?b3BvU0s5a3V6Qkk0MElnWm4xTVkvS05hL0N6RFpQV244ZVJSMEptQUtkWVVJ?=
 =?utf-8?B?VTIvdjJreVBsUEI2S0l1TVFWT2V5dzJVNmVqQjBxWmkzd1lRWGNaZ3ludVNy?=
 =?utf-8?B?ZGtPcEcrU3pEOTVJZ0o1S05lRTJWQkEvNUwxb2xCeStuU1VmaGtTZnVxT2Nn?=
 =?utf-8?B?NEMrUm8vYVRkbWpKN2hVUUd5K1lweEMvNnRicWt4TzhFUTU2cDM1NkQwTytl?=
 =?utf-8?B?L2gyWkpQY3BWWklmNTJ2QlJEU3kzMC9XbUlNVEhGZ2UzcnpORzJuYmU3Zy9p?=
 =?utf-8?B?Q25vb3NLNE1nZHRyVUlCbGowYVNqM2tQVnMrSXhXNU5LNEpyMTh0ZFBUeG10?=
 =?utf-8?B?UHpQclQ2TVBlOE8xR3oxZXVVYmpLNDJCMUNIWitrL3QybzJYS0x3V255d0ZJ?=
 =?utf-8?B?YVJ2VmhuMG96cXZ5OXNYbStHVTlHT2RlZkRXeE55WkRxNzQ4cjFlM3B5cmxk?=
 =?utf-8?B?dzhMVFhLc05BWEJVUEtUTEY1OXU0L1dHZnEvbVhlZTAvTjVXQUt0UlF3d2d6?=
 =?utf-8?B?OXV2K1YxNVN4Rkdvb0M0Vk5kYTBoVEQ2TVdrNHpzZ3JJNmwvbE9SWXUrYVYw?=
 =?utf-8?B?Sm85N1RnV2RpWnR0bE5GNlFrZHQvazFmb3MxbEdYeDFZM0cyWllBdWNWRUt3?=
 =?utf-8?B?ZEpJU0FLZ0ZTQ0t4djZxVDJBOUZVSjZ1R0k1VDJUQ1NLT29NQkR4V1h2djFr?=
 =?utf-8?B?REpsREE5TVBUZnVIdzhIK250c1U5R01MUWx6bkw2eGlLVERBZVZKWXRVQmRZ?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 993e14fa-095b-45d7-f3a9-08dc5737f518
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 19:21:42.7728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrnGvcTZRv8OWYptOc12oSeG4L5/u+JwouxxsCYIUF7dGjFDehtEWydYDKp5YUzok3u/WFsJ9MYWMS901BWIsEyYNz/TFgXEMAYwpxya6Bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4743
X-OriginatorOrg: intel.com

Hi Peter,

On 3/25/2024 10:27 AM, Peter Newman wrote:
> While CLOSID and RMID originated in RDT, the concept applies to other
> architectures, as it's standard to write allocation and monitoring IDs
> into per-CPU registers.
> 
>  - Rename resctrl_pqr_state and pqr_state to be more
>    architecturally-neutral.
> 
>  - Introduce resctrl_arch_update_cpu() to replace the explicit write to
>    MSR_IA32_PQR_ASSOC in __resctrl_sched_in(). In the case of MPAM,
>    PARTID[_I,D] and PMG are a simple function of closid, rmid, and an
>    internal global.
> 
>  - Update terminology containing explicit references to the PQR_ASSOC
>    register.
> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        | 11 ++++++++---
>  arch/x86/kernel/cpu/resctrl/internal.h    |  6 +++---
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 ++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 18 +++++++++---------
>  include/linux/resctrl.h                   | 11 +++++++++++
>  5 files changed, 33 insertions(+), 17 deletions(-)

Looks like __rdtgroup_move_task() still refers to the PQR MSR in comments
and it eventually ends up in fs code.

Also found in arch/x86/kernel/process_{32,64}.c:
	/* Load the Intel cache allocation PQR MSR. */

Reinette

