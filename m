Return-Path: <linux-kernel+bounces-147396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D08FF8A7353
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3648AB226B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B436134407;
	Tue, 16 Apr 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvQveNGa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672122D60A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292645; cv=fail; b=c0nls068ea6Tsh9+iK/CG8YTiCmUWlpXi5ielHHI0nNVNPuqp90Fb3peSxogLuRrz4sP0JkrxyHlgi57M5o1qjuBP/xq0EySjBPfQav0Q3AnFvu0BBS/NgeUmNlvOVT2au7wodotRjsM06VaFSJxIP1V6hDya8zwBR+AEMoo9V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292645; c=relaxed/simple;
	bh=VrfZY5F5WlO0g9yFHRWDb9U1D/vqNDnKKm8sSpvA3fU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZVcQ+45CZ3JdfLG//T8D5OGgaRLQJ5sTL5dRuK5TlovCxuEf0Koo2/knF45tF107S12857h4AfxywADpKrEnXKJb4i0BF5hWrgp5GKNfMFM2W0vvfq7RkfkLoJaTU0cCiUV5PVtqCDGzUfiml2EQwkePmuMwwu2rDqaMVLHYCQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvQveNGa; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713292643; x=1744828643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VrfZY5F5WlO0g9yFHRWDb9U1D/vqNDnKKm8sSpvA3fU=;
  b=FvQveNGaELvsxovbJ5gFKCMVY1s3uZHhjDPGkLUSEGoDY8eApOdLjvmg
   dF5IRoG6PXLapCFO0x++MF1n6HXPqVm/Yj1c51h3SGWoAkzn06GYgTsAB
   5mxsNfgC0C+MVB9DGnS5QBG9jvugFjndQUnoJ9Mcb35YHp9tPmPMhVlw0
   RyJloIvcOWoqkEWqVor4HlgmwCfd1o0H91we6IqCI7Ia1CTUmTSurjQOU
   D5YK3oZhPAJXi+D1bBX/QevzD8REktKYHpDrsAIClWroETwh3WYiq3kG4
   qv7x/AMe2SG8cMFcIMJCpdP04V+x+b2jLmkwKvBMtQJOkZaanDpN7FShM
   A==;
X-CSE-ConnectionGUID: yv/nji3vRl+AdQ92l92cpw==
X-CSE-MsgGUID: YTuTpRWeQvCGLPiJ1Sl85w==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8613779"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8613779"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:37:22 -0700
X-CSE-ConnectionGUID: t5DwWFHYS8iWS4GodgClCg==
X-CSE-MsgGUID: iQRKTPWdShCK7KkknFqHig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22367666"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 11:37:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 11:37:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 11:37:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 11:37:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 11:37:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BihrJUXRkKpunhMAH7ilsVSnXPitNouBLkJ1EhZRn3FLo4uLUp0F6AOvXjaCa8WPMA6O/roTRKuKz/APOPHmnLHMLKMiEULmc+SQPQWHKOgmkzVnAJfoa1Qi7YUNwh2pzVt3itKQhS3O8eplsW2r2RoWLYmsiT8YSyRsMiRvjtYl3JhET9SVrS/3hAuLCoqNQObr1CBZhv3S0SbhsI0/14Wgel499dQw6Ix3XHqDMCsXCS8we6fGL4lRdtp1RNtIXjLvbi60ccfwA+X0XE01mFugd9GCzktD2YWNN4ESC/Fp/aVrB/eDzWAzmIJGPdFYFRELAZGxT+nnX8LhAq7LJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrfZY5F5WlO0g9yFHRWDb9U1D/vqNDnKKm8sSpvA3fU=;
 b=R/F/QaLUtPuksukexo//RxIcMA39i1jXHjOpOwT8oeKVxw6WzojUX4OuqeReeYNjJTRdVXqT4YYC4KFf2ZsMwEJ8R4e0BzJDPxJggEUoHUFKs4YcRnzcnveBMWDnetomcHhY71A61P5EAVF+cNoIMctAlc2+bhdWbwqWYhHtvhL3J/ONMPWyh0lUW6nSQZfBySN1rkLXSSjiVl0Q2uQGK6TEav0kBR8749mkSxIRWyqsP4C4VDTcd8k6nChKcY84oeDayczWn53XlfQQRTOB8UNmY8+Eh2swOZRIcFJrLl28sgOADlMWFHeb3w3z+XQmBsZyoauk9sUaX3P2z14E6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MN0PR11MB6182.namprd11.prod.outlook.com (2603:10b6:208:3c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Tue, 16 Apr
 2024 18:37:18 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 18:37:18 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to struct
 cpuinfo_x86
Thread-Topic: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Thread-Index: AQHagS5KoaFl1e6FLU2YPMaZiCLmO7FNXROAgAABToCAAAEjsIAABDsAgAASPNCAASNagIAOGFGTgAHr5+CAAQ4ngIALqHC/gAACIbA=
Date: Tue, 16 Apr 2024 18:37:18 +0000
Message-ID: <SJ1PR11MB6083F189AB9AB47D3DF74B19FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
 <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
 <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>
 <Zgr6kT8oULbnmEXx@agluck-desk3>
 <20240407105407.GAZhJ7T0fEhzow2MN2@fat_crate.local>
 <SJ1PR11MB60837E437DFA0595DF5B25D0FC002@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240409082217.GAZhT6uW7aELQCHOwL@fat_crate.local>
 <Zh7AZY5X8_uyHrjz@agluck-desk3>
 <20240416182336.GHZh7CKCE7ApJ5OSPC@fat_crate.local>
In-Reply-To: <20240416182336.GHZh7CKCE7ApJ5OSPC@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MN0PR11MB6182:EE_
x-ms-office365-filtering-correlation-id: 4e552620-d575-49fe-9cea-08dc5e443ecb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c3NC1iTzFOYiab1QE/s2YqgxE52LWHzp/UKwzKOfqhSsGfFWtKKSGUGQjrglFI6Ly6Hd21NgWa+IKTnVXsm2R180ABYP9lswBOVe45gznGCw6VBUh2kEuq39rzlBDjI4WxtckqeOXS+zo7LTIzNrE0o7qrw1O3EwKXtguiQkrsb4ahB6/7DCVmFdXEPzBLFXTSRwWTR9yQQ/Ztq/jebJCbBuGuuqIe5y5CH4VLhDhpX2gf6+kicjJECF5+7EDJBQbnx1XY+YVBgKFGpOojzU81fUfMv562NnfZJUbSA91jp3UGuqZjI+/mAVFwHZUAoU2WVS2S3uqfziUJqKtxs95Yi3OvKU2KZ66NBtkSGJN7zMJfi3xsI6mZpblcKVz22vSqpLkrwxWYcbo6kY8YK1f9s5a7G9EQo6xLslLR5+2ljQHWZZODEKw0CAhAu5SqwsvMpAO6QU8TBsQivpnJpIG58/aCXYnJMb2Qq8pPqEevSgaotgf/jUPsBI9vklRZgubDVMqWUA17ZLepf0Q8xrYCJ1Bm/vApaFL1zcQF0YWOSTQqfB2OgoMVz88Ql+h/zvUyUo0YivTOvctgDGnGloKznfP0HDobQFTi1mLEerTrQVsw8CemMEhSpfkDPsac4Ye26G6bid7t3YmAXEj80Iy6XJHx1mMkv5j3vIfq/HJy6g1TcgQwx6FX66HWjWk9sEQp+F7l0WYudQNyft8m6UtRuriRFdHFXsAivy37wcMjc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3p4SytGN3hiVysxTDJjT3Q1VWRYRHBqc2lXUi9WUGdHSVZHRmdkQjU4bDhS?=
 =?utf-8?B?S2h1QldFdnd4QWdvakZkcXBoWFllYzFmTDV2L2ZiaFFlMGNjWW9yT2lYdTJL?=
 =?utf-8?B?czIyNS96RmErSnZ2NFJUdzU4S0xlODhTN1Era01JZHdDSm5LWXRsWjdGcTFO?=
 =?utf-8?B?bERRVHgrVU5Cc3VEVEY5RmlNSnBRSkExd1pxWEhvUmlEL3IzUWFDUEJhM2Fx?=
 =?utf-8?B?MW1DY1dXNjltMVRBN3diMWg4TUUzQ0xXSCtMR0xKNStIYVRpSExRQmd0RENH?=
 =?utf-8?B?UlVyWlhPby8rRTBmY0tONW94QURnQnJCalhlUCs4amJTdGxMMFlDbE9DR0xC?=
 =?utf-8?B?aFZRNjdKL1V6MmR3YXl1b0thQ0dlYnRLTjNmdVROMkFVSEQ2RHV3MmpORFhs?=
 =?utf-8?B?bWx6TWVhMm1HcFBieDhkY0NqOTd0T2dsb1pCazFuaUFLNFl6UGZkczl3b1hN?=
 =?utf-8?B?TElPVTJlaUptVWdsblNCUTdQK2E5Y2F1YmNsY1V6WkY5dlVVYTQvQjJsbmxY?=
 =?utf-8?B?RlFrKzVUczVNUklzS0RpK3hWS2FYWUhXVGlUcDNBSGYxQWYrSUJhWTVqQ09L?=
 =?utf-8?B?VFRXMXBzUlo4a1FKbXZLWVpEMU9LSXQwU2ZJSSt4cXhGcEF3WGVBSHpES1hN?=
 =?utf-8?B?SnRWQWhLbVVsSTdvcVNWSWJKbmpaSHRxYlpGak9GVzVkYWxEZCs0djh1SVZE?=
 =?utf-8?B?bmNtcUVFTUFqZnQ1TzdrNGw3SWxOMDZ6NVBtd24xWis1S2NMejZjTTRuZHV6?=
 =?utf-8?B?MUpBU0RPQ1lyeVg1RGlaS3RwV1pLa1ZndWovWUtJa3NRdXUzb1pjSXpBZS9K?=
 =?utf-8?B?Yzg5UVJxdklwOUd2aVU2aFJZZkJyODU4cjdHcmhEWjM2NTVMSThObUNaTzQ1?=
 =?utf-8?B?bmZTNlhUckxmS0ZKUjRpS0JyR1VHaWlGcTM5WmI2Zm42eTJieTZ4ZXp0UjI1?=
 =?utf-8?B?QmxwZXVYTzlZTnM0VmZhb1kxT3NCcHU2eTB2cGRWS2gwNVJ6d25rNElncFJV?=
 =?utf-8?B?Smt3UUJKeERML0ZvczF5WlN1aWltOHJZZ0w0YkRnRjRoYk9mV3AwQVlXdzdo?=
 =?utf-8?B?SEt2S2R4TVhkN21ianZ0SkYwTExpVVFtSHVzczU4TzRMZ1ExZDVicDBUSzhQ?=
 =?utf-8?B?dUlGQjc2WE9Ed0hCOGpSRkx4eEhVSTJmZWh3a0w4dTBpdHpjSkhHeVgwTDJM?=
 =?utf-8?B?Q0wva0cvTFJBUWNxS1Jid21qK0cveno0Qklzbk95VDR5Ti82ZVRkMlFFMjla?=
 =?utf-8?B?dmk2Q09sd21CSWFNbnJGenI3OStpUGx4Uk81REpVQ2hZem51cVJDb1hpOXda?=
 =?utf-8?B?MzM4dm9ZQkRHYTA3M3F3M1VNYTk2TmpJYUxISFlIK2hsU0ptbFBxaGtiMnFa?=
 =?utf-8?B?eksvUTdmZ01Mb1MvODZ1SDFQNGZ3aFJEZHVBNHpLTHhITGFxOFRRbE8xdTVY?=
 =?utf-8?B?UGxpVlEvSzlPUWhMZTRoV0VRanIrS3NoZUJqdFJoUm4vVWhObElNTkZDc05j?=
 =?utf-8?B?WTBibnNaWUxJS054L3JZY0puUnZCVEltVW1jV1dmR3NsOTk1YmtQY0RoVXpt?=
 =?utf-8?B?ZHI0MlMxWjQ1MjNnT3lGYTRJMGRDTVZkQVNVTXlXbE82THhrbC9qM2hGSkg0?=
 =?utf-8?B?TmhmYWprZTNrampzb240WGMzMEVOYzBvQ3pmRTUyMHhqMEowOEZBUStYRHN1?=
 =?utf-8?B?L3Z0K1hZV0lTVE1xZzd3Z0o5elN1K2tZSGo5eThlWm9uNURSRWhuQ0Q1dXc1?=
 =?utf-8?B?eG0rYy95ekhJNFF4YXVPdk1JVHVydC9PN01JS1JWd2hBL2J0UlZoTnl1WGVN?=
 =?utf-8?B?dDVLNWsrbGpDY2tESkt5NHFvUzhrY2hMSlJvV2ZZOGZ6RE9qWDNiVjlCbldp?=
 =?utf-8?B?a1IzOEkyOCtKdGhGaFAzK1VZL0ZZVnRLMEJ6UzhrVUROdkNLSDJXdVcrT2la?=
 =?utf-8?B?a2hNcnhYZUxuS1pHVGRXNGdvaVlVRWVXNlNjaFluL0hzeDhzVWJpODdnalpr?=
 =?utf-8?B?WkR2S3BPOG9QTnArRnpNM2RYcmRtdDl3b2t1VW5SRzdDdWhRVTF1aEJYWGUr?=
 =?utf-8?B?a0U1dnl5NU4wQURIaUptN1kzSUtzY0N5ZkVLSFhKaHZrS1F0N2JWVnNJVjRZ?=
 =?utf-8?Q?+73l05qCCjnzlmFggzxwcPBpL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e552620-d575-49fe-9cea-08dc5e443ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 18:37:18.3648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gks8enqKFjWBsEKLiNZTqaZukWgsQjji2YjEsh0HirRJU7cm3/PA3WSQeMwI37UnZUi+pP7Pv/AoIHADn3cMwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6182
X-OriginatorOrg: intel.com

Pj4gSXMgdGhlcmUgYW55b25lIGVsc2UgdGhhdCBuZWVkcyBhIHF1aWNrIHBva2UgdG8gbG9vayBh
dCB0aGVzZT8NCj4NCj4gSSBkb24ndCB0aGluayBzby4NCj4NCj4gQXJlbid0IHlvdSBnb2luZyB0
byBzZW5kIHRoZSB3aG9sZSBzZXQgZmlyc3QgdGhvdWdoPw0KPg0KPiBPciB3aGF0IGlzIHRoZSBt
ZXJnZSBzdHJhdGVneSBoZXJlPw0KDQpJIHRob3VnaHQgdG8gZ2V0IHRoZSBmaXJzdCB0aHJlZSBp
bnRvIFRJUCwgYW5kIHRodXMgaW50byBsaW51eC1uZXh0LiBUaGVuIEknZA0Kc3RhcnQgcG9zdGlu
ZyBwYXRjaGVzIHRvIHRoZSBpbmRpdmlkdWFsIGZpbGVzIHRvIHRoZWlyIHJlc3BlY3RpdmUgbWFp
bnRhaW5lcnMuDQoNCk9ubHkgYWJvdXQgaGFsZiBhcmUgYXJjaC94ODYuIFRoZSByZXN0IGFyZSBz
Y2F0dGVyZWQgYXJvdW5kIHRoZSB0cmVlLg0KDQpCdXQgaWYgeW91J2QgbGlrZSB0byBzZWUgdGhl
IHdob2xlIHNlcmllcyBpbiBvbmUgYmlnIG1haWwgdGhyZWFkLCBJIGNhbg0KcG9zdCBpdCBhbGwu
DQoNCi1Ub255DQo=

