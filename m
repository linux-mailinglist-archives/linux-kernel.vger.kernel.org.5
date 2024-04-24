Return-Path: <linux-kernel+bounces-157567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9D68B1307
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C837B281FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4461C6A4;
	Wed, 24 Apr 2024 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIg2vLzP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF51BF2F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985081; cv=fail; b=l1QM6JsMqgcxiNBf3J16uGvEvrclqNGiI7HAPb2R8IDjddlK3Ar9Tp9MkQ5ShtiTUg7VtsG6VEvEieTq7eccvvtv6JZ3oy39wUm9l6s6jRpeNEgqaZG670w8uaNnN3tQk8MPAi6t5dDYJjIaw85WJPBU7A6zTaoY5ccAY+hiUC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985081; c=relaxed/simple;
	bh=JiOyDDo26iI+pAf3SliVpZF7OTWNL9ivNRvtQij29h8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dgI/hR5gliCFlp9eznjDecjvPCZCuJQDW39qd9zINwoTD/Y7VlXYOOuHrOiMaJFGDxvGcUoXJdqAA3WSjgC105GxhVl5PC9F2HhBAxkSi/wqz0bo//byXvWy3DRZl/Yd7VTuqgE6L94ENY/LupKjPIaMq+2BjTgRizO4FTvkibQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIg2vLzP; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713985079; x=1745521079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JiOyDDo26iI+pAf3SliVpZF7OTWNL9ivNRvtQij29h8=;
  b=XIg2vLzPF3CP4ze81evVxFmsHIq/G2w6bStAt2FIqJVLE8Ws9KDnvLMv
   kJ/vnBnfIUqlu8e+7BLsZ1clQXqLCnKPDjSztLU9W7XRON/nuWPELuKS3
   TeU1Fcdh3s//dxt48WEESZOwTR8qsaFoh17VLevg+tE/z+AuQPCPYN8W4
   aeXOKsmyVAl8mHjw2Msc/VWc7QNN8Q7wIar/QiqXF26MwICoOLhfQs0ZQ
   sQebd5kS/wqLgMA/F24nK0o6x2o9ImSXGr3Z4B6c0/PGDMU63zWA17V7c
   fdGuyidaUTWgRbAFnbQ7juwa+h8SB1OlYfJpltpTENv8VjaLbhxx9QKIQ
   Q==;
X-CSE-ConnectionGUID: wtENkBEXTCqkkVHEvcWxGg==
X-CSE-MsgGUID: 622I7li0QrSmGQdVECfD3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="27154668"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="27154668"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:57:59 -0700
X-CSE-ConnectionGUID: HzyFsHa5QAKO+oJuvs5/mg==
X-CSE-MsgGUID: z3+U4lyJTQeYA1QblGKmjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29443222"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 11:57:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 11:57:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 11:57:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 11:57:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 11:57:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAMqxa5sIp0xTvZunmm9oxGQPOoarkWKbJHMDGguJyU7Rh19KvO4CGuKwKxqfSNlckzy/0OjQhu6siMIYXkLCzO/TI+2fZOShxCt7X0ki6XwU36O86qkaFSu94DebWsOZN52s74gsfe74mo8UaG+gCqQGg06InITjV+/hDeMgtVisHtKC3VgAKrTbbVMZyY3b1RodPXNQCBu80LGNYTdrZLvnnVzeR7AZtQO65ovmcAotOnqtjx7PS3WJQ9u6SVPvfe8SWwfm2hlP5RRrEuT7WWGSJZ6Q/COIFbuAMeWIB+W+/1rkh/opqTZbwsqoVBLa4z8tTrVs+bdUzMquolr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiOyDDo26iI+pAf3SliVpZF7OTWNL9ivNRvtQij29h8=;
 b=ixfnXAfOVcgP+uBgjooBlG7ASvrpCSzvIKib20xuIgzrOvuRMbHuF1jhMG4UxY48p3UE1G48NLD6biNTFjrTieMgOz4Kv4CwVpbq8FXAz3eSoDLRL4dG/xBjnaZ+Wv3pH2vqmw4LSrjCFkkqdYn90jZBo3L95xlZgZDxRA0jCfMR3evqbR+Tl+B2TxfDwJ53LwVfJpuVhKGMWmFDfraOK9CVmnq9l83kJubW/ovSq20iTCTjzIU3pbx3qt/6BgsjUGMb/D3bAOV3Lp9n/C0W+iJEeYuVjxY6fgQ5G3Gf7QCZUqQUTWAzjL/qyPxpgQEvE72eqa6QBRUgzE11MHdGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 18:57:55 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.015; Wed, 24 Apr 2024
 18:57:55 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v4 00/71] New Intel CPUID families
Thread-Topic: [PATCH v4 00/71] New Intel CPUID families
Thread-Index: AQHalnMT6WCmmSJgLUKSajERYA9DpLF3wJ8AgAAD6cA=
Date: Wed, 24 Apr 2024 18:57:55 +0000
Message-ID: <SJ1PR11MB6083E2D7B7108FA491C46157FC102@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
 <9a9ca7a4-e302-40f9-a112-c92bf9c720e7@intel.com>
In-Reply-To: <9a9ca7a4-e302-40f9-a112-c92bf9c720e7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB7704:EE_
x-ms-office365-filtering-correlation-id: 301164c6-7a06-474e-9810-08dc6490733c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VG9jWHJ2czBFeSt1ZHIrMGI4L2pWc3JyTS8xV295ZkllSUUyK09CZVRrZUJn?=
 =?utf-8?B?MmFwYS9EZzJiVTlPaUhYajE2Y2thYzdnUlZBZVpGTTA3aFBLckl6eUg4VmRl?=
 =?utf-8?B?N25aaDE0a1FYckZuZ3ZlNDgrcUhaZmRTN3RDWXlsbUMrSTdCQStwNnR6VERt?=
 =?utf-8?B?Wmt3NU91MFRkbFlsdUhIbDE4NDNRbUNEZVZHbHNWOTd3d2ZSUFpOZkJId3hG?=
 =?utf-8?B?VGhxUElNbjdCTXhIWlBlL1k5ekJCUDU5RVNCNGNBN3VKWFNNMFlxZEtSU0NF?=
 =?utf-8?B?WGl2SjBWUnVGbWNhOEF6NzJLbGVNUnFrbXRMbGRhMmQ2SlI4bWRUZFN1Z1Jv?=
 =?utf-8?B?NmhtUnZhMGtzTVYwV21WcThQNVVoQXFKZFY1NEJlcTJuQnNMR3FGL0NzR2Zt?=
 =?utf-8?B?clFaeUt3V0UvK1VxNWgxRzVnU2NkR0xIZFc3YVU0TFpFSzNrSzBucUtXL2tk?=
 =?utf-8?B?UXF1WXFtZEp4WWlXS25VSnJkbzdSbTRlSTJ0N2VSZTQ2ZGxqTlk0UkhoSFY2?=
 =?utf-8?B?L0NwczlZc29nTERydThsUytpMkNUZ3NKRFZBU0xOVTZidkxIemFGck8vYUJw?=
 =?utf-8?B?MEZ1eTdHM1IyQ3NwRHd6VjhlT3k3aFRLUHFTOHdHQzVpcUpwbHZDOFIwMVRT?=
 =?utf-8?B?Z2xlc1hPUjFNekVFWW1LS3JhcDhDRHdTUGVWeng5dVZqQ0FkS0xDK3pNSjJ4?=
 =?utf-8?B?UXdsWDBQdTNBOVdmeGgwbW9jT3hNZWFOUHBTSC9Ldjc1c1FrWm8vMHVjM2Fn?=
 =?utf-8?B?VnRlaXU1MGk5S0JzTjVMYUM2eUY4bVNVSi91aGZnNFl6UWVGU01laFlhYUFK?=
 =?utf-8?B?Q0pnSm9ZQ2diVk1kUWtPdlJ3K21EckJ4azNyOUZkUzhUUWN4WC9sRlN0SHRU?=
 =?utf-8?B?V1dmcldBQTFkZ28xc3dUQTlkL0N3QXEvSVAwS2plUEg0bWVXM0FTNWV5M1RZ?=
 =?utf-8?B?SFgwbFFOSkUreWgzL3BHMXZUZk9QTTY2dGphVFRJamFvaDY0dTU3QUlnQXgy?=
 =?utf-8?B?RFhwUjZBOHhSV0swaUppQWlSWkQzRTlBQzhlVHhmQkh4Z1k2a0p0OHJ0eVYv?=
 =?utf-8?B?NmdkVEVERGp4NDBWOURGdDNCSUl3UjEvc1BsenVzN0ZUcGdIRWtPTkFtTnhZ?=
 =?utf-8?B?QnRPTU1QYWlkM1pHbnVQQjA3YzA5MlVjNUJFMFhQYlFYVDhQYnBWZll4bTJD?=
 =?utf-8?B?aDUzSjB3Y013bjV5MFdFdENjbE53OFJCOXB5cUtNZDFER3NDa2QwY2NvdHZm?=
 =?utf-8?B?YTFGY3p4emNYR1ZsRWRNQXN1eTlIb0I2Tk9kVGR5VTJEcXIxUzhYMitWNlVG?=
 =?utf-8?B?czRObDl4TVZqeHRjVlhvYXlSbHNxNitHdTZmY24rcndBSlkyNDd6TEVjRnpz?=
 =?utf-8?B?elNKZW1xMU80TEIyQ3p4VUJOdmJJMEdDczFXMkdGOG9zWFFaNUpEcFlzeFZi?=
 =?utf-8?B?NWJnWVVWUmlVNjg4bjFaUWtWVlYyeDJkRkFUNGFpQ1JRVXFMK09jdVpXNXR2?=
 =?utf-8?B?NlV2MDdVYU9zd2ttanBJVTd0RVBkR3A1OTRSRGk0Tm1DUjRsS2tEUUVGMTBz?=
 =?utf-8?B?d0dxYmlQTUYxVW01eDZGaEg5WXI0TG9uUEE3bDRENjVQd1NaWGxoZ2k0NkFu?=
 =?utf-8?B?T1VsaVdESjE3M21tMjByR3NtcFFncGk5bVFhVHpBM09yR3ZlbFluUHhtTkxX?=
 =?utf-8?B?KzQ2RXhUOCtueGJHMHdoZitPQ1IwRFQ2K28yMG5WaEZzYW9xMytxRkIwUlFB?=
 =?utf-8?B?NGlDYzNpKzcyTEo2M2tmUk95OXUxUjFiWjVEWVpzOFhxQ052UFhtK0VaNlow?=
 =?utf-8?B?NExRVmJoRFhhWjBOZzFiZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVFYVUhRdFhMaUlTZVIvV3JYdkVoOVM3ZTFTNzFqWVhtSEJ2NEdISTBYUXdS?=
 =?utf-8?B?UDM2Y2lyWU1QYVV2VE1Jamg1K0Y5a3BZMnEybEZPK2F2ZGROYW45MktkZUJP?=
 =?utf-8?B?MThGSzZpVGw1Ri8rNnFpQmgvUVZuZ25DL0Y3ak0zK0gxeDd6dW43cktUZkQw?=
 =?utf-8?B?ODdidDZkSlJTREFCbGx3Wi9seUxaN3J2cE1qNnNKMCtLQXg2WUZaUXc0bHo3?=
 =?utf-8?B?MmpTYWQ4TDZGeDZVVExkcm1KNG5HMVRlcUsxb1ZSWnk0aXp3UUFzSjFBU3Qw?=
 =?utf-8?B?YVFBT0RMMnNiK2NtVEdSdkRsSDdtVWcvZHg2N0ltaEZHdHJ4YTFYNnYzVTdL?=
 =?utf-8?B?cEhUMTZDblhpUmlvRlpaOWd2ODBETFduVzFrKytnaXpyejhVbjFwektaRHVp?=
 =?utf-8?B?REVTbXpmUmNoemk3bU5GM05VOUY2MzdWYnVUdC9HL29KclNBUGJpNjZQQUdD?=
 =?utf-8?B?VU9DanVWS2Uyc1dKRml2UUxWQWtIbWEzYXRKSUZEdVp3SWNIbngwRVRCSUhq?=
 =?utf-8?B?MzBjbnlZNjNyb1p4cGNXci94eE50YlF5Zk5NNFZlUXVndHNHak9jVitlajZq?=
 =?utf-8?B?TndsWEFlSW9kM3ZRUnRCQ0FKejM5R1ZEbXUwejd6Tks2eEY3ZFVJNldUTEVR?=
 =?utf-8?B?NUIrNUF5Rjd0TERyVk1GSk9TSGhXekJhYjA1T2lvbVhXVUpqUlhkN3BVQ0FX?=
 =?utf-8?B?cFhYYkM1N0kzSHBIc0RvUWFvd25LR2JqYkk1NE45R1Nva0c5L0pkM3QvNHJl?=
 =?utf-8?B?OE9udlVIZWkxT3hMZWVjYm5pZmQwNUU5ZlJlQ3NDRnlWWXdKRlRxc0pzL1k1?=
 =?utf-8?B?Y0JCZ2xzS0E4Zm9OWlR4ZjdQUmgwQndKOW5DZ0sxdnNvelcxQkJ0a3RKbVFy?=
 =?utf-8?B?bW42TUNVZVBpQjBnd01GUmhXOFhmSUZFczVYUzlZUzZKQ3ZsNjVONnNBR1Bi?=
 =?utf-8?B?WHYzcENYbE1wMFBRbTh4WjlXTUFPTk9tZVVvODhHeE9iU2FHM3FoWmpJRU9Q?=
 =?utf-8?B?STNQdjlua1pWcmM4U3lZQk9hM2FUQTVKU05UQ0ZEbHJLVlBrTTdjNHhHTjJE?=
 =?utf-8?B?cGkwS2ZnUFlpRUJ6ZythM2VpdnBaak9vaUc5a1p4M1ZjeTcwemFYR0dKa21z?=
 =?utf-8?B?US9BdEVQNDZqdmd3NjVMbXBXQzc1eENMV1dhZy8rQjBMbWtnNHZlTU9NazJ2?=
 =?utf-8?B?UVZwYmRqK00yTDVTS2ZxOExUOHlOanF5TDJoVHJEWlVBY0pwWTFUNnJxT3Nm?=
 =?utf-8?B?L044bWI3ODNmUkZxQVFQdjQ5MVdsV1l1Tk85VzBucWZkd1o1OERhTkpYeGho?=
 =?utf-8?B?VW5QQ1VhMCtQZWEzWkpFYkcwcUpDY3ozSmZyTDVZMTZoMTRhZmsxUXlTRXQw?=
 =?utf-8?B?bENhTzNCTExtdHgrTnpXUG1pc3NVRGo3QTQ0RWpPQnpqdldzNEVDT2IwOFFq?=
 =?utf-8?B?clRQMm1HR1NGSVhHTTBUSzh0emVvejdVMmtybStUYkZIVUdUR2ZoSWhaWVli?=
 =?utf-8?B?RXdqUy9PRTY4bDFxWXNIbURIdFRxU1BVL0lKU1VsQmhmMDdnU0d1RXlPdktE?=
 =?utf-8?B?QmdRRDM3V1dERzAvZkdsK0RLVXQyMVcrazhGekx2aFFRbmFmb2ZKQXVlbGwz?=
 =?utf-8?B?ZDZWbkc0UnBCbzBuSGFqREN0VmRDdldyQnJUY21ua1V3d2VFVTNRNzRpK0g2?=
 =?utf-8?B?eS9JbGxmUC8yeDZ0RUJkbE95cFhUMWhQbjlLbkxGVzVaY2ZUbDZsTmFZRjg4?=
 =?utf-8?B?MCtCN2ZuOWZFWDJKQllqNzdJL0h6ZTlSMG9MVE5RQ1p1MGhDY2hvLzI0Z1F2?=
 =?utf-8?B?clpFdFp5MlZ2dWdoSU5jTjh6QzVnZExBZ3pyeStNMkgwU1NxdnNFelNUSnpw?=
 =?utf-8?B?cUxGSzJWVGlaWUxOYkVpc0dnVUUreWtsTDJRb0hJZmhGRVVyQlFGcWNEVFhn?=
 =?utf-8?B?c01JZHNYOWErOVJSTzlwVmdtUldxY3BtTDQ3VHRFTFJZS3U1WGhGWC9pTVo0?=
 =?utf-8?B?NTFqYUpZVW5mckY1c2FPSjNtUllIQXNsOGF5cW9sSlU5djdPR3RqUDNyOFN5?=
 =?utf-8?B?QTJTMHQyOHUvbWFQMGx0c1ZNcEh0VGpCdERoT3BYWWp3bzFsU0VPZWJqSlYv?=
 =?utf-8?Q?im6Kd4XUm39qKePHPgA3/FWpT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301164c6-7a06-474e-9810-08dc6490733c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 18:57:55.1155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2lUTqAqSf2TNNhHKTXBoH6pUea5A2CskTVljhORf6LhHX3sHszaIFwFkSdmdVaQ5osCgxS9roDy2LXOz3sBHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
X-OriginatorOrg: intel.com

Pj4gQnV0IHRoZSB0bDtkciB2ZXJzaW9uIGlzIHRoYXQgc29tZSBzdXJnZXJ5IGlzIHJlcXVpcmVk
IHRvIG1ha2UgYWRkaW5nDQo+PiBDUFVzIHdpdGggbmV3IENQVUlEICJmYW1pbHkiIHZhbHVlcyBl
bGVnYW50Lg0KPg0KPiBIZXkgVG9ueSwNCj4NCj4gV2l0aCB0aGUgZXhjZXB0aW9uIG9mIHRoZSB1
bmF2b2lkYWJsZSBQRUNJIGdvb2ZpbmVzcywgdGhpcyBzZWVtcyBsaWtlIGENCj4gcmVhbGx5IHVu
aXZlcnNhbCB3aW4gaW4gcmVhZGFiaWxpdHkgYW5kIGNvbXBhY3RuZXNzLiAgSXQncyBsb29rcyBy
ZWFsbHkNCj4gbmljZS4gIFRoYW5rcyENCg0KVGhhbmtzIERhdmUuIEZlZWwgZnJlZSB0byBkaWcg
aW50byBhbnkgb2YgdGhlIGFyY2gveDg2IHBhdGNoZXMgdGhhdCBkb24ndA0KaGF2ZSBBY2tlZC1i
eSBvciBSZXZpZXdlZC1ieSAocGF0Y2hlcyAwMDE2IGFuZCB1cCkgYW5kIGdyYWIgYW55IHRoYXQN
CmFyZSBpbiB5b3VyIGFyZWEgb2YgaW50ZXJlc3QgaW50byBUSVAgdHJlZS4gIEknbSBleHBlY3Rp
bmcgY29tcGxldGlvbiBvZiB0aGlzDQpzZXJpZXMgdG8gdGFrZSBhIGNvdXBsZSBvZiByZWxlYXNl
cyB0byBnZXQgZXZlcnl0aGluZyBhcHBsaWVkLiBCdXQgaXQgd291bGQNCmJlIHZlcnkgbmljZSBp
ZiB0aGlzIHBhdGNoIGJvbWIgZ2V0cyBzbWFsbGVyIGVhY2ggdGltZS4NCg0KLVRvbnkNCg==

