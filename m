Return-Path: <linux-kernel+bounces-168405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A42DF8BB838
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE1BB239B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ADB85284;
	Fri,  3 May 2024 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJ3Bfsdg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EAA84DE3;
	Fri,  3 May 2024 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778781; cv=fail; b=mJsglsnCpaeQC8m5NHOVi7SU8P6G1+xHADIu0gu1TwtGglhfXUx/WtRwnlYfw6dURec6VJh+QhKG/N58UxTV85UTIhlMP2kTdu79PouveqwpwgG4BrZAKbrtm9GERSCte9ySqAoYsotYxO1/y1uzKAGrqGFnjAlFmWUFBuJuY2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778781; c=relaxed/simple;
	bh=Fikiofv1fNHGKxOXno5lwOXHRRqKWiOZ9mddGde2vgs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bTxje8xNdwh0gGb4QMVcK7AHLxjKgj+CwQZHMvpyqlWTS0QFRT+0PLH99PZ+hfETd4XH2Avtq4zFFstsG7IkURKnMgJsnLUddNmSDPRmxB/lA/WmZfl9/P3br/64ARgJU9otwI9NoWTxfCxtDpBpDhSKzSGY2ZdZkZGzPAkCXOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJ3Bfsdg; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714778780; x=1746314780;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fikiofv1fNHGKxOXno5lwOXHRRqKWiOZ9mddGde2vgs=;
  b=nJ3BfsdghInUWHDeGhS07PIOSjGij76RmpX5yx+RcPfk4mPj43MoIcFb
   /17tJwPSFYtiE/MDX+gk68YgVWU3OaV8qJ18yxNS0ia47Cf8X0g0eAR1Z
   zumUCryYddCj3Ku4fzmY3p56gFCxE5oF2z0tV4tod7+6mSN9rHcpsg5bg
   +T/6H+CPOgRsb8tTLen1XqJ9ceUXLyYXfCqUm7nAv1w8Zywe1h/4he8i3
   Mqaq/FGWChjZZqvg7AfJBVr0TB4pwbUWeAjM4aKxCMKt/B0feLEf1Az0t
   dfij2ZdL9J5C5ay6Ti5UXeT45HZ5ZDa29u1N6jkbYSNtdW/LOm+6p5Lwq
   w==;
X-CSE-ConnectionGUID: 5CF5VbJCQxW8MGDc4swc/A==
X-CSE-MsgGUID: R4Qq9uYaQRSlNYS3+qsNPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="22012802"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="22012802"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 16:26:19 -0700
X-CSE-ConnectionGUID: ajrpeueBT0OyKgxPxm7Bbg==
X-CSE-MsgGUID: W6fH+5/4TlC2xq/wHz5hfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="27475195"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 16:26:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:26:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:26:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 16:26:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 16:26:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC2dwEkgOKFM97fX+C3azPPuCNAd+4+7eSdnL31i5D6Xi43A24eLg2OQW9CawNV519HiMVT4durWqtcU3inBvmoB1xkDuZqHdC8DNSMvRQu6jtRXWJ36HLgAFBMK0Pun96smBCe0rptnhz5D6G5EQeVP6PEifo0qw6CGOOjQskHX7J99BkBS8FZ1D3RUQvjf/wlKI9OmrYYhyDX9aacqyoNqQsC3e8fNZ0kH6ES19v2w1giSxCaJ6n9qi+qt1M+bezGJvziaL8sRIw9Y0k7JaeKX4prPVq6W0lMDnTHo28F3yGZ/qfENHNreTkSUVcBqPVf2BxYilgqzXzkPOXwdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJQ3ckOvodxjSjPF44TSQZEw+ApQI4Ng1BgROqtbQjc=;
 b=hNJF5R13aJt1GSbLM4o8v1RwnNOvw4scB7BrSILj/gAxGH2+rfETVPf5NS1G1OesVcyX3tGr+iXQFbdtAjyrA2X/17eUuo/YlAJOM8jmX5LWDvk+p2BNgdib9vrPvPtcTzzx3Is1tsLMefVkPb2Sd9l3TVY3mwft1NhiI2p8zMOBnBa79RqY5kPE2VDq/Yz6jD5TYm7aIZVRZ3sTwUWtlPJstrc7/esrRBk7px0Iry+y5NRDj5vRQpQCDJWC38scHzBM712Fhm43iAmDTCNBVFMIm/bp2/sjyjDs+4begu1gS9jqo/fFu9oO68ZfO2XZAJ7YvVDzclSrui8hFlVjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8607.namprd11.prod.outlook.com (2603:10b6:408:1ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Fri, 3 May
 2024 23:26:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 23:26:07 +0000
Message-ID: <ac22b96d-c4bb-42d9-bac8-22b9e032b59e@intel.com>
Date: Fri, 3 May 2024 16:26:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 03/17] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
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
 <63134ddf18208bbd11bcec0ec75c33ef6e5635b2.1711674410.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <63134ddf18208bbd11bcec0ec75c33ef6e5635b2.1711674410.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0287.namprd04.prod.outlook.com
 (2603:10b6:303:89::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: b70eed23-9608-423f-ff1e-08dc6bc868c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2ZQczFpM2F1d09EQTA0N1ZsUDJIdnpTWTYyOVhOOXg0NE1oK2UzZDhRZnAw?=
 =?utf-8?B?b3FobFFUSnNoM3AvcWtCU3hDS3pody9ONnRHcEJqODkxb3lXRjlybklnNGpt?=
 =?utf-8?B?QVdXNGtWM1ZiQ2xjQkUzd2lNcGRoZnNxT2h1YVY3ZWhrVDFIR040dlpCNDNF?=
 =?utf-8?B?MzBlZWo1SVlvRTA1SFZaRTEwN0RmdHM3bkFkYytaaGRzeU9lb0I3elBUanNl?=
 =?utf-8?B?S21mMitxbjhuclBsbFREL1Iwbk5zbTZrbUcwTEF5bXNDQmJ2QXdHdWV4NVlr?=
 =?utf-8?B?SEJac0FtVFl5dmNYZ05SMFBCT2pvcUFuTDd6NWFGckhkMTQ2QXFBOXVhVEg5?=
 =?utf-8?B?MW1ETFlnem5YS3hpK2h4dll0STdZcWJHelErbXpheXJEZi9uRDc2bDVMZGJm?=
 =?utf-8?B?MnNWbVh6QkJiMUcxMmIzTDFjeG9FQi85ODNUaVVPdE51NGo2VHRiT0d1aXpo?=
 =?utf-8?B?RzVPczZ4TnZGL2dXNTk3OFhQaGp1NTBjdjRKdjJCODMwNElLSUVSV3RIc3du?=
 =?utf-8?B?WGg2djVhU0FMb3lMTS9LeWtPVkYweWlQa0l5TE9RbGgvK0k2ekVzWTBpS3Qz?=
 =?utf-8?B?RWlCZENpZXZPdFdhMTN6S0gwWlNMbzV6U0srWllPRkxpdEFBTFVVbWtUeGJD?=
 =?utf-8?B?NEhUWjBDcVZIM1JIL1ljNGdUVlQvN2lCQlBOblhLY1NRZmlndXVVNjJaT2ov?=
 =?utf-8?B?bENJS1Vzb3g5Sys3R25vc2VkM3p1MmlRNVRDbGY3c2NueXAxNSs5TjNMdnJJ?=
 =?utf-8?B?ZGx2eG8wRjV0Qng0THNKWVJKTXhuUStsc290Z3pDT00zZWhOZ2VwUiszdzFy?=
 =?utf-8?B?SFhFWitzdld0aHV2SUlEREtEVGI4VXl2c1EvK1p5WUVFWElUeVd5RmlUSVRI?=
 =?utf-8?B?aE5qV0I5QnhnV2h6bjJTdXpCOFEzN2ZPMmVmMlc2NEJaQzJYZjIvTVJBalBy?=
 =?utf-8?B?ZXhGY2FzTDRVNDY1UHFtR2szZkRjOU44Wm1HU0JzVEhtTWlVcFZQZ2x5dGZy?=
 =?utf-8?B?Q0c2VEI5OHE0SkVvT0FlOEhWRjFxeGpPUldkRWJWandOaXNiL1NGeE1MdFl3?=
 =?utf-8?B?NXZHR0RsZ09WaWlFbzRHNkRNWTNSK25tcGtmK0JXSWRsdFFRQ2pxaWVKcEo1?=
 =?utf-8?B?RUlyaVVsYjl3YzB1TjUvdEZ2eVcxZHJ0ZGtKL1ExNDNXVWlCYzZKNGpSRTVL?=
 =?utf-8?B?NEZaenZabmZZbm0rNGRxWFdsbU9lSEVSOE5VdWk5LzZMN2tTMmt0TUwzWDlM?=
 =?utf-8?B?RFBkdEJyUDlaVnIyWnpjY0Vqdkt4RzNsMUM4UXNGV0tydCtvZnpTN1paa2Rs?=
 =?utf-8?B?bXQzYVZIcjNYaFFtL0NONjFzKytTamFzaDcxSFdDeGw2bFR2NXJER3NSVlNU?=
 =?utf-8?B?ZkZoTmhBUUh3dkhKYVJtZ1dqWk9BRlY1ZmYxcWN5b3N4VlgydUVYU2xNNXZl?=
 =?utf-8?B?UzdQRVRDU3Y0eWhLbWJvSVQ1MmVTOE9EWFEwOCtBM3JpWlpSYm83OWIyL3Fm?=
 =?utf-8?B?NEZoUml5anNNYVc3ZUNtakNQSDh3RUFmdkpURlhhd3hZcG54THpwWUs3QlBk?=
 =?utf-8?B?UHQyalpyR3BYTTVLN082bWNLRTJQb1hEZWRaYWJkcm01RTM1aTZHVlhrSFZm?=
 =?utf-8?Q?h3qYMz2nICjmcYwntPbYOibH3Db62FUMouPdz31xZWxo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW9YWnMyY1BOTlUxaFJxZjFrYnRzY1hVakFKTkJqMERDVWg1eWJXT3A0RUNM?=
 =?utf-8?B?ZWJ2S0o3aGQvNGhrYmlFSnhDMllpbjl5WHhRak9LN0tteG92UVVJZUJWdldj?=
 =?utf-8?B?aklvZlEwNWNubHVLV21YNHNHRTI2YnVHejBSeUpteitRcVRwRFNWY0I4VUVp?=
 =?utf-8?B?cVdMY09uZm1ycEY4aEtNMXpNVE84Zi9SSGdaTzJQK1BTVy9YMS96eVppT01o?=
 =?utf-8?B?OGdRZXpMNzZsak5ua25Pa2xoZnR2c2N0UEJ4b3IwUEtabllac3pjUk16TDM1?=
 =?utf-8?B?N1B3aysvZVFUbzFMS2hCN1ZHN2hPbWhiUEMyL0x1cHBVNlFsY0czSWpUTGs2?=
 =?utf-8?B?dlh1VmZ3V2ZCK1BGOUg1cUhzR2dMdVlaTTA2Tyt4Vm1xMkkraEFvend1cVJP?=
 =?utf-8?B?bjRNRlY3UFJWazR2Uzc2aTFBNnVRblNlWWJZR2FoNmZtTkMzRkNpc25sek4z?=
 =?utf-8?B?QjZZTGNUbG5rMzZnaVFlNlJFc2s3RVVTU05DWmxFSXl4K250UjUrMG8wTGhp?=
 =?utf-8?B?QlNQR1FtaXNjREF5YkJNKzFLVnU2Q0RheVowKy9qZU45VEMzN1o2NDdhSkVh?=
 =?utf-8?B?RTNnU09lY3FVellEUXFaVXF3M3BGNG1lNk9JOHI3ZEtYdnUyUkJ2QUtjWWYy?=
 =?utf-8?B?KzNkZ1RzVDdCZlJlN0JBcUJIMEpENy9QUWtZNjEzWnNXQWJIRVZUSFZwZUJH?=
 =?utf-8?B?UWp4T3p6b2NodHk4a1MyM2hwdjZWZXNFNkFhM2RlRmdzejdlcnVvbnhVVEp0?=
 =?utf-8?B?dXBweHNZa3lIbFZIaXpPaXBjTEk2Qk5GS29ITXE0aGFscGJFSWpuN2Fna1Zk?=
 =?utf-8?B?U1dNR0ZHWk9TYS9NZXYycWN1aFhrSWcrTVhLdmwrZHlKdnh2dkhISUZLMUJS?=
 =?utf-8?B?Y0FnTmJrTlVpTDdzb1IrRWhwaGd4WE1XNlNFV0dySk9TTndVeWYrTDAxb1hD?=
 =?utf-8?B?Vjg0QXA3SjJjQTkvaW0ycFV1N1JtcG96a3V6QWVoN1RrTjBiSC9vbXJqVzE3?=
 =?utf-8?B?S2RUK2lib2dsODQzZThZRmRPMDJPYUtTUWlFb1NsMVNsVGFUUGlzdDM0aElE?=
 =?utf-8?B?M1FlL0g2Q1RqeFFwbEVvbFgwMWNIM2NJVkFvOEY0Y0hwUmYrd3UwZjBIbGhD?=
 =?utf-8?B?VDdHb2NrZ2xXRE5kRFh5SWNmL3Q0TitTbFBaY0F1c3lLdXZ6bXhIcll0SHBC?=
 =?utf-8?B?WFhKa05uVzNwTy9MdlZ6WmJhWno4M3kzdmp0WHNhc25scVBKV05MRWluOTVL?=
 =?utf-8?B?dGRiSEVKNkdKNTgzd2NmNGo3N1RHL3BtNlNMd0U0N1U4NWh3eFZ1clRwVFlK?=
 =?utf-8?B?OHhKKzhpVzFTY1AxZXlWdDh2TzJJVFpFZG5sdXRZRWd2OFkzZXQwVEgvY0FP?=
 =?utf-8?B?QzdaZGcwQVVnbGg5bW9ldWJ3MUd1K3hTTmpQR2E2MVhWSnFTczdNandDaWo0?=
 =?utf-8?B?ckp5Zm96c21UZnFQUTlHT01DMkRqVDZIUVNVLytwRzAyMHR1amxhd3BFMEo0?=
 =?utf-8?B?YkhSNTVzRlAweWdoK1BxWnFTbzkrZlhaaDZnVlF4WWdUTkNrYjlEM1dZQ0ZG?=
 =?utf-8?B?N1BMcHA4c1c0QkorNE16Wm40bSt4NmNvR1phaVVlTDZpS05ydmptVEYrVzBP?=
 =?utf-8?B?aU8wYW16Q3JSYTJ3VUtXL2NGWlBQeVJZK2Y4Q0I4S01qUWJZL2ZBSlpqNzBM?=
 =?utf-8?B?OEFLK1lXOGFDbmZqTURNOEs3anpPNHA2NlVwdGo5eGxXRW1YcXFqUUdYTmVR?=
 =?utf-8?B?ajFaVldVNFM2bnlUTkZtOHk4QkJXSWM5M0FIN0owZVZQa0Z1QS9sajZkem50?=
 =?utf-8?B?cUJOYm85bDVQYjNDOGhXVDlJWTR2eS9ERkJOTHo2WklMYWppdmg5TVo5NGw4?=
 =?utf-8?B?SXh3ZkllRyt0NXd1Tm0vTG1SUmN1ZVhKbEdKNDdzRXdtVVBwaGxWRTFHcndQ?=
 =?utf-8?B?WXl1QVNNdmtkNFd2cjlTM21EeXJNcHgvbkNVdVlPcWVoL0szdS9YakVvMU1h?=
 =?utf-8?B?VDlCSWliMjRUQjRjU0daOGQ2UGpRM2NMaU4wMjV0OURCb1hDWm1SV2RSMEVu?=
 =?utf-8?B?TG8rMEx1T0U5eTJ1aVBjWnZYeUJRVVlpTjByYjFJV2RFWDI1bnpFbmtQWnJu?=
 =?utf-8?B?VmErQjlxeUU4eFBINmRXU29HZTJQUGZYQ1FycERUVDQ1bkdsZVUycHNwbHpY?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b70eed23-9608-423f-ff1e-08dc6bc868c6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 23:26:07.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wbsLW6/VGdX0T7nX//xjFwDETZa7xiLdU0xMjyZFd3Qfv+6qa0+Hq3Vf0V4cHOZxPaLblSAqaWAOQguA3GXQBUsdqMwSUWKA5nAYDlDFWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8607
X-OriginatorOrg: intel.com

Hi Babu,

On 3/28/2024 6:06 PM, Babu Moger wrote:
> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
> Bits Description
> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>      Monitoring Counter ID + 1
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
> v3: Removed changes related to mon_features.
>     Moved rdt_cpu_has to core.c and added new function resctrl_arch_has_abmc.
>     Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
>     rdt_resource. (James)
> 
> v2: Changed the field name to mbm_assign_capable from abmc_capable.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 17 +++++++++++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  |  3 +++
>  include/linux/resctrl.h                | 12 ++++++++++++
>  4 files changed, 33 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 57a8c6f30dd6..bb82b392cf5d 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -740,6 +740,23 @@ bool __init rdt_cpu_has(int flag)
>  	return ret;
>  }
>  
> +inline bool __init resctrl_arch_has_abmc(struct rdt_resource *r)
> +{
> +	bool ret = rdt_cpu_has(X86_FEATURE_ABMC);
> +	u32 eax, ebx, ecx, edx;
> +
> +	if (ret) {
> +		/*
> +		 * Query CPUID_Fn80000020_EBX_x05 for number of
> +		 * ABMC counters
> +		 */
> +		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
> +		r->mbm_assign_cntrs = (ebx & 0xFFFF) + 1;
> +	}
> +
> +	return ret;
> +}

It is not clear to me why this function is needed. I went back to
read James' comment and it sounds to me as though he expected it
to be called from non-arch code ... but this is only called
from rdt_get_mon_l3_config() which is very much architecture specific
and will remain in arch/x86 where rdt_cpu_has() will be accessible.

> +
>  static __init bool get_mem_config(void)
>  {
>  	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_MBA];
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c99f26ebe7a6..c4ae6f3993aa 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -584,6 +584,7 @@ void free_rmid(u32 closid, u32 rmid);
>  int rdt_get_mon_l3_config(struct rdt_resource *r);
>  void __exit rdt_put_mon_l3_config(void);
>  bool __init rdt_cpu_has(int flag);
> +bool __init resctrl_arch_has_abmc(struct rdt_resource *r);
>  void mon_event_count(void *info);
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg);
>  void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index c34a35ec0f03..e5938bf53d5a 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1055,6 +1055,9 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  			mbm_local_event.configurable = true;
>  			mbm_config_rftype_init("mbm_local_bytes_config");
>  		}
> +
> +		if (resctrl_arch_has_abmc(r))
> +			r->mbm_assign_capable = ABMC_ASSIGN;
>  	}

This is confusing to me in two ways:
(a) why need different layers of abstraction to initialize r->mbm_assign_capable
    and r->mbm_assign_cntrs? Can they not just be assigned at the same time?
(b) r->mbm_assign_capable is a bool ... but it is assigned an enum? Why is
    this enum needed for this?

>  
>  	l3_mon_evt_init(r);
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index a365f67131ec..a1ee9afabff3 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -150,6 +150,14 @@ struct resctrl_membw {
>  struct rdt_parse_data;
>  struct resctrl_schema;
>  
> +/**
> + * enum mbm_assign_type - The type of assignable monitoring.
> + * @ABMC_ASSIGN: Assignable Bandwidth Monitoring Counters.
> + */
> +enum mbm_assign_type {
> +	ABMC_ASSIGN	= 0x01,
> +};
> +

Either the resource is mbm_assign_capable or not ... it is not clear
to me why an enum is needed.

>  /**
>   * struct rdt_resource - attributes of a resctrl resource
>   * @rid:		The index of the resource
> @@ -168,6 +176,8 @@ struct resctrl_schema;
>   * @evt_list:		List of monitoring events
>   * @fflags:		flags to choose base and info files
>   * @cdp_capable:	Is the CDP feature available on this resource
> + * @mbm_assign_capable:	Does system capable of supporting monitor assignment?

"Does system capable" -> "Is system capable"?

> + * @mbm_assign_cntrs:	Maximum number of assignable counters
>   */
>  struct rdt_resource {
>  	int			rid;
> @@ -188,6 +198,8 @@ struct rdt_resource {
>  	struct list_head	evt_list;
>  	unsigned long		fflags;
>  	bool			cdp_capable;
> +	bool			mbm_assign_capable;
> +	u32                     mbm_assign_cntrs;
>  };

Please check tabs vs spaces (in this whole series please).

I'm thinking that a new "MBM specific" struct within
struct rdt_resource will be helpful to clearly separate the MBM related
data. This will be similar to struct resctrl_cache for 
cache allocation and struct resctrl_membw for memory bandwidth
allocation.

>  
>  /**

Reinette

