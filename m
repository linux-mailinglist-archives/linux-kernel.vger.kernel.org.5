Return-Path: <linux-kernel+bounces-168411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D9F8BB847
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB29282B4C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FE284A52;
	Fri,  3 May 2024 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nG+YhkUd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E27290F;
	Fri,  3 May 2024 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779048; cv=fail; b=C1qIhQcUabEWpiC9N7UXIQivJIIAuKNT3Kvtcgl3ddSkWc6DTr4vDodSXkusgZKLkOTFJv5VFURyZbS05nSDMKmOrr7Nf3yvrVBCJ2DBUMQ70cFTvu6eUirVAp2N9IEhb0LkUkNoe1IlohlGmZVKg57eRbuGyv1b7sTtZIHvnkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779048; c=relaxed/simple;
	bh=evbXqUwE+4rUD+yH4hdfAONsZMcBzs0j25FbnoZAhL8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vs/wYbGpeZ2+R+pZfGitI4S5FKmQDagl5d5QmPaOywhrM2zfJlEA7OIhNLAeLymMAUsG9GVQo/nojk7kw3TyxPCQI733Ai5rNAf+1CSZ0DpeEzUe64O5G+ix/oTpj/Dv8kzEo/w1LlhbibEhTX7wkSTuoByzq6QFpDZW7q6+7DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nG+YhkUd; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714779046; x=1746315046;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=evbXqUwE+4rUD+yH4hdfAONsZMcBzs0j25FbnoZAhL8=;
  b=nG+YhkUd+qk34v5NJT96joP4QIOIYvLDFlA75qDrIC4qgo4Q3noZumxO
   k79gQyly58n+sgk38XnOOh42ePf4uHEKdJgLWj7H02bYbJ8Do2fpPOwuH
   wv3Cxeq4Sr9BkhRFqKv2adnezvGXQcYBMT7DBAj69mq+NoThUesP26ytf
   y3mUHR1P9nirJSdFJQBq/ek3XEVgOfnspPNgCUgzRKjbLm1IfNIigGyLs
   /tKSerB/52fSdV5o5owLr5oRL5tofQgfFAuO8v+e0Fg92fnh7jab2I7Or
   QNFTuq/C/w9NgqU+KzpEzkq244GnvJbuyvadpgZcQRMHrjlHO5Awv5JqV
   g==;
X-CSE-ConnectionGUID: o4YjBMvjQqSwdc+6NYebPQ==
X-CSE-MsgGUID: h05N0VJNSQOluGS9+XtDlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10452897"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="10452897"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 16:30:46 -0700
X-CSE-ConnectionGUID: Iyap0HABTmOSRvLUs7e57g==
X-CSE-MsgGUID: 1zkd6caITiarLB3s8MFO4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="58790899"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 16:30:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:30:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 16:30:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 16:30:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKfQDFFLxKLuf5pIhVv05PWHTrjAwopuKjQOG21Lb+MHAKgWPcz2NaIsw/AZnyQylLG+ew+A80eTGp3XK8fr9QSY8v6zy+HyIesrcscAEx7+/A3bYuGa2QAdZTP8HZdJaL13xDwn/HQaddKmdAO5EfO6b8o4txf8/QxPa8aCYNiF6udwAYpovKioMG7IhQMWfTSN5qvBWZGaVHLOQmr0fwrRMjdNhk7wIOwqS48HP9R6Gjs6D4lejpsSoK6BUf8efy3TorIp1ppr5SRY9LwSD1+dGGq8+h5PS9/q0s5E95L2RAic1O53jhiqtOvJ2Up56UZgGgD9ihzGI1H7GrdCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7H08lSTuo3G/Tzhv9SigNRSpqXN2i3kWN5cxKf9Xs8=;
 b=AVdjVD6IwgaHpqM3P/Ryanvk7hCBYumQfQOV74uQ5/els25pM3WLHTcbPcZphi6QsXvPpSHCfXrBA/7qoh+B+AU4In8Pj5kFSp5s3KyOItwZ8pSknmXuU3sN+YK82sC89AgIgjSIYnxnXag+wfbOF8ykeBat1BdDcPYMnZzadLnWSw3WD1Xr87WUPv/2bji1i4P6qdLJj6wFqXHXrwnroJJyx+GGE+DaFNPbaISK2gEP4pIjgkGs2T+pWpME/1GY+kb8vfyLiqVbYHZxa0qH8tKwWp1JOAycQUyq8vT8ibXWdCm2yAUUg7hYDZ7WWYM4XnO10ZUKbjqzdN9sK5vGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6618.namprd11.prod.outlook.com (2603:10b6:303:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Fri, 3 May
 2024 23:30:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 23:30:37 +0000
Message-ID: <54b1fe8f-13e5-440b-bb36-4100c1d283d0@intel.com>
Date: Fri, 3 May 2024 16:30:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 07/17] x86/resctrl: Add support to enable/disable
 ABMC feature
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
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
 <0db75c94886da62b8da498ef159d8fe27b0b3811.1711674410.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <0db75c94886da62b8da498ef159d8fe27b0b3811.1711674410.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0b8ac3-2b7b-40d6-d971-08dc6bc90990
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGM3Ynl6VTBHVlQva1Q2SlhtRk9CTUlVNWJuWFNlVnRFalcxaTQzblhmam1u?=
 =?utf-8?B?c1ZFSUx5bjdTTVEwSjVPc3FRTTFjWDQ5OERwN3I1cjFBOGsxemM1UFRkNTVG?=
 =?utf-8?B?QUhqeVRPMmFNRFlWdkdKZVdZNmF1d2Q3Mm5Fekw3RjlWeFNTdlVVamNETERi?=
 =?utf-8?B?bnBLZXJSTXN1N0NmZm5Jc1d4MGwyZDRZbFRUVFlCY1ZEMXFMQlBkYmZMVkhE?=
 =?utf-8?B?MThjMzFKV05xNlgvUE9LOWl6T2UyTnNad3FhNTltbVJwM3ExSHhyeDh4ejJa?=
 =?utf-8?B?bnZWbVhQaXREbWVIVGVtVE16Z3NKRlZZQ3NaTGNtOFhiUmtnOGM2UXlMN1Zh?=
 =?utf-8?B?enVIcWpDTndFU01vRGp5YnFrd2VWbitsVG5TRmNwZFFZdlU5SlBKdG9Uck9K?=
 =?utf-8?B?RzJnZ3ZuWXdKYW40c1kxUjhvVDBDYVVwTzA2bjhSYWNUN00zU0F0dUNPaW81?=
 =?utf-8?B?NVdKZnRUYkNHdGFzVFpRVUpRTWs0ZWdHMWhUUnRFMnQ3WjA5Tnp3TzdsVFNB?=
 =?utf-8?B?R2gwN2ZLdy9DSDRmckZ4Z0F2MUxGVTlMYnovaFRXNUU5NGR2U0UzK1ZIR1lw?=
 =?utf-8?B?dlA1bmlBajhiVUlRRTBuNEc3M3N1Zkp6cW1QdEl4b0R5LzNuZ0s3WHJDbFFQ?=
 =?utf-8?B?NDMwQ3lUNU9ONjlOWXUrVXVFYk1wckVmb0pjcVR4ZGNReVdMNWhGZ3JISVhK?=
 =?utf-8?B?Z1hyZkNxdkFRMzdteVIvU0hMckVyOXlOMDRVdnJGekkvZDFtRXJ4aHBLaGEw?=
 =?utf-8?B?cWwxdUdxMUlVL00rTjh4a3JCUjZVM3FaOFRiN09FUXg4Qlp6ckR6QTlaaThI?=
 =?utf-8?B?UEY4ZjVwb280aGJtbGE4NlBXYyszWEMzSkwyby9iV1NSSmpSVEFaeTMydjVW?=
 =?utf-8?B?TG9PTUV3MmowWFBOSCtHcDQvcENPNGtSTXRYNzdpejV1SEk1bU9UNlp2dTQ0?=
 =?utf-8?B?RWxOUlpNblBVV081UGlySkw5anRGckxkbjVOSTdDMXE5N0YvTjIwZGIyUDdD?=
 =?utf-8?B?OFQwTTNsaVlrKzZrUUh5QUNwNzVyeC91U2o3ZUN3c3JrM1dBdmR0WnYzOUNO?=
 =?utf-8?B?WWtnOW4vcDNEaHM1YVJGa01IaWdVbjJGZk9ObDhuNTNQNnRMMlJxZmhXL2F0?=
 =?utf-8?B?Skp1Z0dUNEtqcjZnbDhjR2crNnVzTk9xMEVCNlQyQmswK3B4TzFaOEdkdm1T?=
 =?utf-8?B?OVNtTDlOKzNuN3ZxdGZGNHZUamNNeVlHT3RmMG5ZQUFqMVczejNRUDV5Z0R1?=
 =?utf-8?B?M2phc1N3QXBhM2FaTUZlbUhTVlVCczdMczBjNHFLK3l3MzVleUZFUGtsMG5m?=
 =?utf-8?B?Y3dnZk1DdjJBaTBZWGdhN05ib0tvd05MejE5L2dXRTBRL2ZTc0l5TkZSSm1j?=
 =?utf-8?B?T0lXNXcyeUVWbVFvdi85cVF3N3hxNWk4eG1iTWExL2VXVWU2aUF5d1RjeDhW?=
 =?utf-8?B?Um5uVllLZlB6SklHTGpJSTBFZGlHT1VBb0RDNTlLQzFrQ0JKZnNoQmdYVTFm?=
 =?utf-8?B?dVpHRFVFbmd3OHJyc0FjZWpsWlRDVkNaOTVqNkhQdmIxSEJ4b1dmdzd5T2tU?=
 =?utf-8?B?akJQUHVOaklnTTh4VzZmNTQ3a3RoNFdoUGxaRVdnajFhS2RvbGpNdENpQWR6?=
 =?utf-8?Q?R7od7tge5YOR/BryaK2tIdm4GJHAA4XQJf10Hr3BTYlQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJ2WURNa3dETUN3YlpVeFVGS3QvWDMzdWdYQ3YrN2F0SSt0eHdWVnFodW5W?=
 =?utf-8?B?Mklod1BjRW1vVGszR0V4OEpZdTFFUkcwSjFsWmlpMk1ub05rNmNxcE9PRjho?=
 =?utf-8?B?amhWL1NaOGc4bXpMOSt3LzVaZzVmdkxNK29DbDhISzVuSlRkc21TVnJYdXJL?=
 =?utf-8?B?NXlVQ1p0SUhvS1BSM3hXMjNrZDdqeUZhQnN5YzNPQ3RTSENuT2ZraWZyL3Y5?=
 =?utf-8?B?WXZmRHdFY1ZJekdhMlRROG55UlZEQlhvZGdoUm01SEExS2wwT3hySEtyc1Va?=
 =?utf-8?B?VSs1Qzc0Z1B4UFJuV2pGL21Xc2dlbDFGcmU3RVVobi9rOUdzS2RPYjdyTHdX?=
 =?utf-8?B?b1l3M3JWd0pWY3orVFB0Vk53RFB1ajEweWNBUDVuSnczcVhrSzhjRXdpb2hn?=
 =?utf-8?B?OUE4NjUzcFgrT0liMEZraEF1WTlSV0dWRk9pT3RXVzJDSFdsR3BKM1gvR05i?=
 =?utf-8?B?SjRnZGJnaEx5RThpK2o1K1dOa3JqRWw2NVNwOWdVdUh1cmZxbnl6dHl6UUxu?=
 =?utf-8?B?VU5aZUtpVURoUkpML2lkOEVCckFhWVdOaGZaK0piVEZqcXUyNG56cjRDVVdk?=
 =?utf-8?B?Q3VMSGIvZzE5N1duMklBK2NmWlE0aTFBb1dCTXUrUHJqZDkrdlZZNllOQkFR?=
 =?utf-8?B?RFNZdjFUS1Y1dFJCM3pJbWx3UGRoNWttc3JYeGxtVUMvdDRVR1dOOE14NmFE?=
 =?utf-8?B?b1R4dmRzYlpJTTA5QVlPUHh0cVZ3SzhFTXM1UmRTQlNGcytpMy9PRWJsN0xa?=
 =?utf-8?B?RUhtYStvdTdKY1dlMG4yeDFVdm8zcXNnOTNnNDFXa3ZJWTYvYUhkblF2ZFdt?=
 =?utf-8?B?R2FrT0ZISm5DRk1GclYraG1rMnordE02WHZySVBzNHk2MVR0NDA0MjdsdFM2?=
 =?utf-8?B?QjlRMmZZbmNTUmlEc0tVbUZ2T2w5ZWd3SFhLa1M3d3ZnLzlLSmdmTHBzYXpz?=
 =?utf-8?B?ODdrbGd2UHpabDVVNk0yVmhqME1lMnIrVlpaOTNLdUxVa0prU0xWTnRNcTVQ?=
 =?utf-8?B?b25RZ1A5VlN2OVBYVVVnU1dwYmgxQ09weVZtYmRTQlhCZ0Jtc2U2VjE4QkVV?=
 =?utf-8?B?aTkwazI2ZDZuME1ISWlXNkpTLzFINjdWQnZqOWUwR0dYYlRCa3Bnd2JPdWNq?=
 =?utf-8?B?NlljZnI5TTNhODBwOHVpZVRkNy9sZnA1RzlPUSsvRjZ6ck1sREYvWXRYTVBQ?=
 =?utf-8?B?WXFkdHgzdUlXcEh6MzY1R3pUb2VObVI0dHpDSW5nSnkxNThLZHRtSEgvcU1O?=
 =?utf-8?B?REp1RzJTbTd4ZnRDN3RRMzZkSk5JOVhIOS9BdFlOWTVNaHhXQWcvSUtoQnFB?=
 =?utf-8?B?Y1dHU3NPK3BSTGNlRTIzQ1JDblFRNkttRjJ2ck04M2Z6eE5xTkw4SkxOVjBL?=
 =?utf-8?B?UmptT29UK3ZUTjYvUGJiNTZEcUJlZWljZSs5UGlENndObEw2bEpFSW5sTUZ6?=
 =?utf-8?B?ZkNuU2V0cXlUcW94SUc2SjdoQlBRMFdrRlh3WEFrOUJGamdHbTVWU1VwUlRp?=
 =?utf-8?B?aHR1TXEwSVRmUlBUbm54cUh4azRHMElkdDdJYnlNam8xNWExOGltSUNwc0hN?=
 =?utf-8?B?Y09acCsxK0dMeFdHK29pQXNQS2s3clZidkxmaTVXRlBKbkphT0UzdEtMcmll?=
 =?utf-8?B?V0srZGttT09MdjJJUnFua2NKdHRZRXBpZmlKT2xXdkdJd3BHY1NwdEQ4UlV2?=
 =?utf-8?B?azFKblltYkZSUlY4Rk5QZytQUkhpVlBOVmgvdkVqaVhiaFJldFVOTCtRdUsv?=
 =?utf-8?B?YnF5UU96RFR3NXpVTXF0dEpBQTFUN3IrVUZHbUlUNkFwZGdjUGNCYnNJTXlV?=
 =?utf-8?B?Z2xsNm9FenZzbVB1NFZOSDdkVUVlUTNMVTZ4a3RUR25LbGF1ajdmQng5WlJi?=
 =?utf-8?B?MzhUOWxhb1EzVWtLSFFWbGtnYitJQ1lKS2lkRStYOXNpZ1J1UmxMV3djeXh1?=
 =?utf-8?B?cFlyNFRSb2NNT0ZJSHRlZjNLd1lnVVhHbWJhT01SOUJlUHpvdFVxR29rdnFV?=
 =?utf-8?B?elJ4aG9NYUtJYUJWWGp2TGludS9WQ1d1aUNpV0s0TWwrV1FkbjloMjZGVHQ4?=
 =?utf-8?B?a3NoNWtOMW1qbjRLbnZOTUR3aHFQRTRmMEJ3ckt5YVlQdlVhVXZGV2RqYWlO?=
 =?utf-8?B?dko3dDVEaVpKTUU2b1pSclpWTEl0c21MOGtwYXdmTy9iMWduL0NKeEcwVkpk?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0b8ac3-2b7b-40d6-d971-08dc6bc90990
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 23:30:37.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAL8eDMHzrdfGqbePRi9D5p+Bup35bfkbMbrCVTe3qdoTqScjd+2jhHW6zOuJuMbIDYVYZ+x5sfDedDJgLB+a29ZcHDJAS/YsuvQf/bRd7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6618
X-OriginatorOrg: intel.com

Hi Babu,

On 3/28/2024 6:06 PM, Babu Moger wrote:
> Add the functionality to enable/disable ABMC feature.
> 
> ABMC is enabled by setting enabled bit(0) in MSR L3_QOS_EXT_CFG. When the
> state of ABMC is changed, it must be changed to the updated value on all
> logical processors in the QOS Domain.

This patch does much more than enable what is mentioned above. There is little
information about what this patch aims to accomplish. Without this it makes
review difficult.

> 
> The ABMC feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
> v3: No changes.
> 
> v2: Few text changes in commit message.
> ---
>  arch/x86/include/asm/msr-index.h       |  1 +
>  arch/x86/kernel/cpu/resctrl/internal.h | 12 ++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 76 +++++++++++++++++++++++++-
>  3 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 05956bd8bacf..f16ee50b1a23 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1165,6 +1165,7 @@
>  #define MSR_IA32_MBA_BW_BASE		0xc0000200
>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>  #define MSR_IA32_EVT_CFG_BASE		0xc0000400
> +#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
>  
>  /* MSR_IA32_VMX_MISC bits */
>  #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 722388621403..8238ee437369 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -96,6 +96,9 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>  	return cpu;
>  }
>  
> +/* ABMC ENABLE */

Can this comment be made more useful?

> +#define ABMC_ENABLE			BIT(0)
> +
>  struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;
>  	bool				enable_cdpl2;
> @@ -433,6 +436,7 @@ struct rdt_parse_data {
>   * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
>   *			Monitoring Event Configuration (BMEC) is supported.
>   * @cdp_enabled:	CDP state of this resource
> + * @abmc_enabled:	ABMC feature is enabled
>   *
>   * Members of this structure are either private to the architecture
>   * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
> @@ -448,6 +452,7 @@ struct rdt_hw_resource {
>  	unsigned int		mbm_width;
>  	unsigned int		mbm_cfg_mask;
>  	bool			cdp_enabled;
> +	bool			abmc_enabled;
>  };
>  
>  static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
> @@ -491,6 +496,13 @@ static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
>  
>  int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>  
> +static inline bool resctrl_arch_get_abmc_enabled(enum resctrl_res_level l)
> +{
> +	return rdt_resources_all[l].abmc_enabled;
> +}
> +
> +int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable);
> +
>  /*
>   * To return the common struct rdt_resource, which is contained in struct
>   * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 05f551bc316e..f49073c86884 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -850,9 +850,15 @@ static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
>  				    struct seq_file *s, void *v)
>  {
>  	struct rdt_resource *r = of->kn->parent->priv;
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  
> -	if (r->mbm_assign_capable)
> +	if (r->mbm_assign_capable && hw_res->abmc_enabled) {
> +		seq_puts(s, "[abmc]\n");
> +		seq_puts(s, "legacy_mbm\n");
> +	} else if (r->mbm_assign_capable) {
>  		seq_puts(s, "abmc\n");
> +		seq_puts(s, "[legacy_mbm]\n");
> +	}
>  
>  	return 0;
>  }
> @@ -2433,6 +2439,74 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
>  	return 0;
>  }
>  
> +static void resctrl_abmc_msrwrite(void *arg)
> +{
> +	bool *enable = arg;
> +	u64 msrval;
> +
> +	rdmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
> +
> +	if (*enable)
> +		msrval |= ABMC_ENABLE;
> +	else
> +		msrval &= ~ABMC_ENABLE;
> +
> +	wrmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
> +}
> +
> +static int resctrl_abmc_setup(enum resctrl_res_level l, bool enable)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
> +	struct rdt_domain *d;
> +
> +	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */

"all the CPUs in cpu_mask" -> "all the CPUs associated with the resource"?

> +	list_for_each_entry(d, &r->domains, list) {
> +		on_each_cpu_mask(&d->cpu_mask, resctrl_abmc_msrwrite, &enable, 1);
> +		resctrl_arch_reset_rmid_all(r, d);

Could the changelog please explain why this is needed and what the impact of
this is?

> +	}
> +
> +	return 0;
> +}

I think the naming can be changed to make these easier to understand. For example,
resctrl_abmc_msrwrite() -> resctrl_abmc_set_one()
resctrl_abmc_setup() -> resctrl_abmc_set_all()

> +
> +static int resctrl_abmc_enable(enum resctrl_res_level l)
> +{
> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
> +	int ret = 0;
> +
> +	if (!hw_res->abmc_enabled) {
> +		ret = resctrl_abmc_setup(l, true);
> +		if (!ret)
> +			hw_res->abmc_enabled = true;
> +	}
> +
> +	return ret;
> +}
> +
> +static void resctrl_abmc_disable(enum resctrl_res_level l)
> +{
> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
> +
> +	if (hw_res->abmc_enabled) {
> +		resctrl_abmc_setup(l, false);
> +		hw_res->abmc_enabled = false;
> +	}
> +}
> +
> +int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable)
> +{
> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
> +
> +	if (!hw_res->r_resctrl.mbm_assign_capable)
> +		return -EINVAL;
> +
> +	if (enable)
> +		return resctrl_abmc_enable(l);
> +
> +	resctrl_abmc_disable(l);
> +
> +	return 0;
> +}

Why is resctrl_arch_set_abmc_enabled() necessary? It seem to add an unnecessary
layer of abstraction.

> +
>  /*
>   * We don't allow rdtgroup directories to be created anywhere
>   * except the root directory. Thus when looking for the rdtgroup

Reinette

