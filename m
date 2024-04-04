Return-Path: <linux-kernel+bounces-132242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6C58991EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056C41F22A9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F1D548FE;
	Thu,  4 Apr 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4qKRdA5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD713A41A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272307; cv=fail; b=T+qOIlgUW/tz6CH/ZtOESDqYL+XftqsRp66yq9Sfip7yagI4GSLIMSVVA6HXDEtM8S1u2CwlEAz/i3MJcq3F8V05RUH1katkt5YXSoFQm3QD+oMYZDbSYZ3TYm5aVPUyCPTGvbPzZpJ4cnongkQNMrVDZir0DpTwu/qBcyzPLA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272307; c=relaxed/simple;
	bh=Vh6TOQFySf2F0nfKyY1qjXxi7P0H9zr2LWScNlzCj38=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=awIiuZ/YERz4rdYT1fUCvrNzIzhYjZfNRY5YYnwk5OdyMeMgbIo0vkNg8ywarcl4W2tjiRcTR7TClH2XglbWGc+nIlIYyle53jwejtdByToWu0j0jRQbMyz61OiaMSifnyU5a6Int9+9CZX3C6PFAQCUnNsVEVh7oUFxjWoPWhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4qKRdA5; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712272306; x=1743808306;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vh6TOQFySf2F0nfKyY1qjXxi7P0H9zr2LWScNlzCj38=;
  b=L4qKRdA5aHS6yL2om9GH1oQzu9WvlwUirwv/4DrrpilleV7jIfkMJVAJ
   Cu8frkNpCWvX7/v7hEpigG1Cn8BCls/laAHYHCQ2xiCEtLULwv0ABb2rO
   Mb5ITN9+epRMkLN0sn4+fbfMzU6/M1rSEY2e4jxAuNHcuV6MBae0vIR42
   9XSIzjWLpqNkSJvwBrBGuhuKCcEoLHZtzPkPs1KokT6H2YY7BQFCVgcFq
   qJaWLe4QliNhjVuYoo8/l7gzifg8smZRxPqoCcP2FlbJvnr3M39Xmj4nq
   8KF0Ljir0IM0L5RbtGQ2R3DW9RA2yB8wVFLPcu+9xRVMJwRHvmskD0qSh
   Q==;
X-CSE-ConnectionGUID: t44H4PzyQie72HfT8kwCaQ==
X-CSE-MsgGUID: +XrDfJsmTyCcyX0+MxwXJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7748899"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7748899"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 16:11:46 -0700
X-CSE-ConnectionGUID: AiUEv4jGSy2o6L+rNRfViQ==
X-CSE-MsgGUID: IgwYU82KToS76Ro9pm0lxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18894770"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 16:11:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 16:11:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 16:11:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 16:11:43 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 16:11:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KV7MLhuUUxXDnIA6blb2/FqduO/+LxAv3pezHv/nFRs1/Es+KTyKAiXcKk9px20PBTSswJfJZAXPW/9rFzEj9ZEvcb48UCE/rKXZfJDIJszz7aOmGdQib1TuW1jqdGD0yJHivLuqEPuHwDtmuiI5kqNE+jgsLiIb9zGbF4mrk3IAKiL/B8kh27KeofviZ0vzVleRt7VLcn6SNPY9exMqUTtZJrxl1UptP2SFQe/5xG1HjSURNqxRPrXeixDs4va/DbaRzCZtu9tLJMvYD0tLI9IgqA2zsv/0cEJQLflTTcYts/SBa7/V/jpEvH4opkCBkorwFHF6CA9EFz/KdEyd9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7Qu8O/jOtQztBG1ciB6xuO+stWw+9oWjXwUVr34OOY=;
 b=MuysGpI5quFMVTgXUfKfM5vwe5+12ypOGiW6MJCA68v7HwauXMibAoTrgZ73XrITmXYcKU1YcO0aZCC73xwD3T8RK6G0ZhH2JAAieZRiZvIwofuz95qpAzDDCa2wHkMs+/BN+BmrkoGat/wQ8YqF5S5e8hZg796Y7V1f76i2P1vqBlEkI0hnvx6i8SuUIZrFdgC684tTH2NXtoSLFIzuOTK1Co5rUyjLp7Vvix2D9Npn5XnistRmw+5+7vP6I4msbJQVP22NY36OEBR8umFfD5CwXjUsIlHJw6N+Ygm7KwzVBGfrLESFuKEOHRVRliyM1mrMam0SKrhjxiOMhW9hgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 4 Apr
 2024 23:11:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 23:11:41 +0000
Message-ID: <4a6b1645-c72c-41dd-a455-bdf0ec57d4c5@intel.com>
Date: Thu, 4 Apr 2024 16:11:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] x86/resctrl: Disallow mongroup rename on MPAM
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
 <20240325172707.73966-4-peternewman@google.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240325172707.73966-4-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4847:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sa3cPHr+r+A1bfhti9XwhjeJ2NxIe4I4ogl4DVyGR9HXwq34SxUUFAknHu4pthiXwu3sVhzUksHxfEVYMqiKPfgLqtcmAFB4cbRCUIHGEoimkcLNWqKpsPsOsQ4qsix6Ty+GZgqaDTL+ecbb8EgKqs0lnCk6a+rNxcZdG/eEeUR/ItGoZO1ze0STc5UQB4iJqkeAx6TZjHYGvqfqe0sc11nSI9+n/VJtN91LWYumDLV4PJFaMmPOIsmcthklhCDX8mWcEuFo9+/Lb9e41srlHwatSNc1QOPf6dOQWEbLoi7cKtd2rWMbwvsetlstBf2WUmPKRCDxX9TUT8thX63xjjSu8Htr9CfSruTw4PYqfkh45LNIETqlyplbddwVALmGT4KnHuN0ouwV7z418i936bZ3diBUwPnXnByTTRS+Mp5CiekzJrQVVlfT8zaJuKKSzUQOKK+/2cyF8n4TVMdk+yEUjz6NTjOlywkyhbgpRHlrIG01MBmePSbbflmXk/M4FdA7lHiC4KOjv+P9RmnfHft+FJ2XHDLJ6PtLSuBJv4/6Po9u3HKUU9+NoQtzGPkS6jF2BvHF8U63QzmErOHlJGy5a3zfzwegifJpdR9sFq+/3dl7rz65PV4WtKJaZFCn5+MrIoAG5Lv1HaJbDlMMz4Sc+6/Mq6/oU7E3b9rx4Lk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZERkYnEvOFprOTJtNmYvaUVUdEFwT1o5aUNSclZVRUJYajF0M0l2Z2Mzb2k0?=
 =?utf-8?B?SmRsUkd1dklmNGpLd2RDUFRFWm9MU2RKOTFnUFMvY2FEeEJ3WFVxRDVlUUFX?=
 =?utf-8?B?VHRUT0RZcWZFQzlKSzZTckNReE9ucUtVUUp3d1dMQ0xueFJzeUJFbG1jWUh3?=
 =?utf-8?B?b2U0NnMxWnpxc24zRE9EbFBBcEE4cDN2d3VwcjIvdXhiNjJpc0E3S3BUTU1h?=
 =?utf-8?B?SHIvYkl0VVVHdVhUUzVNM1pzMERsOTZqV2x5R3pNMG90cVRCM1NxSnl5bm9Q?=
 =?utf-8?B?eG0rcEFFYkVadGp1bmcrWng3VStpTVo5VmNnYkFqdnI4OWdRV00vS2FBSUw2?=
 =?utf-8?B?WmdaSlFrTmp4bDBVOGk5bExnRjFoazRLdGVSTlZkaXViWlh0djhmYmRlSzB0?=
 =?utf-8?B?b0R5bzJOOVQyVFNaeXFZN3lrYjE4bGJKVy9OUUVkMHhmcFAzZzAySURrZ2VV?=
 =?utf-8?B?VVoyNTEzek5Eenl3bkI1ZnNnd1lEZHFsZWcyLzg3TnVEQzVxWU44UkJ2UWU1?=
 =?utf-8?B?OWM3cEpqekJ5VFp5QkZWMjg5YjRKSUc1ZHArU3JLWHJLc216UytCYXQvdmJq?=
 =?utf-8?B?MVpBRGI5RlBhMFd2VXpvWUVwQXFoN3RCTGQvVVNmeVNGdmJPYUJ0WXY0bjNG?=
 =?utf-8?B?dGRaNmtyMEFlcDhIQUlsRWRBclMrYjVMaGh2V1RyOFNtd2RNRzJCNWdvdHhp?=
 =?utf-8?B?MkVKcTJtc2hTVjdwbEk5QWRBMU5OalFWQXpmV1M1b255cXRic0lDUllscnpr?=
 =?utf-8?B?bkxNQStCaXh5SnZXbVJnRzYwZ0xNdFV0NlgrcXlVTVpVSS9rZWkvSWdCdnhV?=
 =?utf-8?B?UXRsZU5lRiszNHdOWlRFT3F5ZVg0dDlUZVZBN1FUVFA2SEdzbkREWXR5OW1M?=
 =?utf-8?B?K1piUmJxUmMySVh6NlF1d082ZVd3eGU5NFJrWi9yRkJDTWhiWlZwclFpTmdG?=
 =?utf-8?B?clR5NysyOFlzM2NxR2k1T0szTVZMbmFlVUY0MElndFk1UE5LaGkrdXFQaHYv?=
 =?utf-8?B?TVVPaTNtUU8zdmZ0cHhYcURJWmlhWFN4ZVNadXl0UlNoVURwSkpGTndMN0Vn?=
 =?utf-8?B?VktmaUpoNDg4cDUzVUdQdW9vYmtrQVhubld4b3I5VG5wMHlPRTM5SDRKMTFj?=
 =?utf-8?B?TGZJeUdyeGhkeHZ5ZHhWeUVsUHd4TUVDK0l1WWwyb3p5YTRySWRnbEc0dzIx?=
 =?utf-8?B?R3hKcytLbzNtV0xUTENFc3FjOGdkZllhVklXeUp1anFPQVBGOHFxV3RSN0pQ?=
 =?utf-8?B?R3JRU29XeGoxSVY3NkcwRStMKzgxamU5c3Mrc3RUdFc2eXhOdGl5dVBDQXJq?=
 =?utf-8?B?SDJvcWJ4dFZVZ1p3ZnlERVJ4NE9GV2RvZms2UDVEakg3eHR1RWY4UmQyY1lE?=
 =?utf-8?B?RjBYZEVHSjVsc2h1U2x0a1VUZGQvbWUzTm9uWTJtR2FnZnc4SXM1WTJlNGNk?=
 =?utf-8?B?MHF0MS9LU1ZvREJEa0FqeUNmOWZ2aTVWazc5ZlRJSVAvL0VhL2dEbmx1QW9k?=
 =?utf-8?B?cFpweHdsY2xPWEpjL0c5dEdzNE9nSU5IRWJvekJNd004OWp2NHN6cmVmSlBz?=
 =?utf-8?B?M2JEV3FvSzYxN0VqVE9Xa1VKdzFOQmk4c0FUdFhzTEtkNlBBeEZkS01zMi9H?=
 =?utf-8?B?TTB3MVVSMTFoeFNKdHdqVHNrdHlHWStXMkQxYkVEOFQ1WGtZaTBuaEtETjJr?=
 =?utf-8?B?bldOeEZhclo5Q2Z1blRRR1pLUzJ3RXVkMHZLL2xGc21iYnpnb1lTbE40THJF?=
 =?utf-8?B?R3lIV2dzeEttUGprZjRxa3g1N2l6Q0pIT0l4eDFqZ3hjREwrQ3JaVGhieXVI?=
 =?utf-8?B?Vmptemhjc2lCVXlDK3puU3JNRkpqTk1JRGVXMWhjVGhNY0g3U3JwSGVzYW1D?=
 =?utf-8?B?OU5ZMUM2QlFBUlZnM2tXWjJJY0l1bUJRbUJKWFY5Z2tkTkR3UVRldXRENWdj?=
 =?utf-8?B?VzF3M240cUJ0TFJ1cEIrYzhtTTB5VzhISElFWnhhUVBIZVUwVVI0Tm9ycms4?=
 =?utf-8?B?ZHh3ODJqelhQc2ZreEkzU3lsQ2dxdkRXY3FKbWFHSWRTTVR1TWVhL0E5bkRQ?=
 =?utf-8?B?OFduN0ZwSHN1YnZlUXlMMHlKVDRiYW90OFFUSllaUUMwWUJrU1ZMekhRWFVC?=
 =?utf-8?B?NTdlaUgyVWo3bFpBTk94RE1FMUJIWmg4UTJiRUU5SXNvL3FsODNlR3I3alBU?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a4cb15-3464-4258-915f-08dc54fc968d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 23:11:41.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Py/GIXeurSYioApkJdaSJZoKRxsej6AlHQ+zvES6Vbgr+XxBySEU2ugZjoOp6SCxT9AJOtFEVcyjiNBvXnKRGALg4h//4drOwHkGVcdnF24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com

Hi Peter,

On 3/25/2024 10:27 AM, Peter Newman wrote:
> Moving a monitoring group to a different parent control assumes that the
> monitors will not be impacted. This is not the case on MPAM where the
> PMG is an extension of the PARTID.
> 
> Detect this situation by requiring the change in CLOSID not to affect
> the result of resctrl_arch_rmid_idx_encode(), otherwise return
> -EOPNOTSUPP.
> 

Thanks for catching this. This seems out of place in this series. It sounds
more like an independent fix that should go in separately.

> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 9b1969e4235a..8d6979dbfd02 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3879,6 +3879,19 @@ static int rdtgroup_rename(struct kernfs_node *kn,
>  		goto out;
>  	}
>  
> +	/*
> +	 * If changing the CLOSID impacts the RMID, this operation is not
> +	 * supported.
> +	 */
> +	if (resctrl_arch_rmid_idx_encode(rdtgrp->mon.parent->closid,
> +					 rdtgrp->mon.rmid) !=
> +	    resctrl_arch_rmid_idx_encode(new_prdtgrp->closid,
> +					 rdtgrp->mon.rmid)) {
> +		rdt_last_cmd_puts("changing parent control group not supported\n");

Please start message with capital letter.

> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
>  	/*
>  	 * If the MON group is monitoring CPUs, the CPUs must be assigned to the
>  	 * current parent CTRL_MON group and therefore cannot be assigned to

Reinette

