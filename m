Return-Path: <linux-kernel+bounces-166867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C60568BA115
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2726B226D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FBC17F37D;
	Thu,  2 May 2024 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUrhOytu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6342AB6;
	Thu,  2 May 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714678386; cv=fail; b=k5hGhDZbwE7JQJa12mBPBZEdJGsbSFNErFxNyp+mx6NBgCcZ3q4d/4e7ioWQMNgkTXacbiTSdWHbSYq8w6vDDnAOIk7j+pdahLYJ19HZj173al9Pi1KlEGBkRH7FfeXuwpkIZmxkoXzueZIi9Ubia23DJIP31xYAJd7R0YqmuhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714678386; c=relaxed/simple;
	bh=Ga69ksN/y6dazMgjAeZvk8+xqf/IKByzgCHXMVOGzqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KPpRxxQPYo7KefgJySJQJpolxZhGSs0zlXJWhMuxHBPNWplAFq3dUQPfOMe/0N68y3FLzVnSU22emYDidycY4JcJj0YKNDOvnl8UX+7D07gq1lPdLDCszahI1oFHu0vbUAYISfPaVzq5KVMozhSRR1JKITOkLf1MczZRctzYMJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUrhOytu; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714678385; x=1746214385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ga69ksN/y6dazMgjAeZvk8+xqf/IKByzgCHXMVOGzqU=;
  b=XUrhOytuSo1cmKdBtNwjh7vYgQ6wHYiOohn0DCwF3yGTYGoBxcR0Yeij
   8KwLmFZBXZrL21hKhW2iqGgB4l3Bbm4hx8GJRW85GCFQEtq+IoDiu584r
   5OAFSg7ksTxXHw3pKN4I+JOpaJJ1PiWMJSxvVgjTss4FrVXFCL0A2Gta8
   F+TwO3NrEtoATFYKNj58TJ5Xu9hqC+unJvbpdPL+fYAAZv4kAsQa30GEM
   rQTFUljuo0yaerRdvOwOORGwz5Q8zP5eXrMZf6Mn2f8gApZdrAxBKYM5I
   gQsqJLXj/1w6JffC4BHWj4Y1R3R1PjIQ2tuSjNjtwIqXIXkTUvsN/Djgq
   Q==;
X-CSE-ConnectionGUID: jYevuLm6RG64cUYZF8VGBA==
X-CSE-MsgGUID: 0aE8/QviRsGPcq6qDr4S4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21884331"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21884331"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 12:33:04 -0700
X-CSE-ConnectionGUID: 0Tno2PhmR0eR31ExaDkQxw==
X-CSE-MsgGUID: wCkvwAtfT1WZwiKOEmWi4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31897756"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 May 2024 12:33:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 12:33:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 12:33:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 12:33:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 12:33:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyWjHoLXj2jFA3CFXGSyU7ff+BCDdtKmHmXGc0578gtTYKNtOjRakqx5Lwc0qxWYokPwkHAuTJnlEoaPe2S9rwhoEoN2k44OD6llGqHcTcctP2WMdhN3ESbbUQuJU2cGS05ctdCjJkr/96TfhPiWkAy03idZ6TUTAH5+O72nxfU23Gh5C0PXIYo/cVJkPGurC4BWsA5eGJ6TkWLs4xsNPOGj7yiPB+1ZxCJ/r+cpuznxKN4TthLfEMcR8UjzMWcdXEfan/suJDQmkm8xH/32gAg/TTFKdIQQdmwZHvlN292MrAqeIwM6/27qPzchpPB8F4cc7132bInz0b3LCFHpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga69ksN/y6dazMgjAeZvk8+xqf/IKByzgCHXMVOGzqU=;
 b=ilfjGVMXUvGkCMZzloUXveHeN2YiTMSaFMUoGY5iLPfz8Ktzld2K9Ly3FaSTqBk/Ag+fi1nKgcHSF20NH/CHailecsC7Uv+lpRXwSdMPWdbtAT4YhEGACqqp+kSJHOC8DbihWgYSSrRMbAC6w+gIlnH8DAwW+lFEHjy9QidWRiczasO96S6V/mm33RF57WGfccAfBXFF/DZO3ISEKoSxfj1XwXfkaBvg9Knx7f9WUx8IH2QXm7sqRj0fXsY+UmhpFMj5SujeqRGhJzyqkFzd2CsvrwO3Eopv1R/FSQtSnl9OkYPW20+x06kWvnPvRnkAKUl3YL+Mi0lrqHJyJdjffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB7159.namprd11.prod.outlook.com (2603:10b6:806:24b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 19:33:01 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 19:33:00 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Weiny, Ira" <ira.weiny@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/cper: Remove duplicated GUID defines
Thread-Topic: [PATCH] cxl/cper: Remove duplicated GUID defines
Thread-Index: AQHanMCHO2HsQw9pmk23uguMGpmcjLGEVLMw
Date: Thu, 2 May 2024 19:33:00 +0000
Message-ID: <SJ1PR11MB6083FB892A28C7872476C26AFC182@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240502-cper-fix-dup-guid-v1-1-283cc447c7bf@intel.com>
In-Reply-To: <20240502-cper-fix-dup-guid-v1-1-283cc447c7bf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB7159:EE_
x-ms-office365-filtering-correlation-id: fe8ca2dd-37ad-4cee-5645-08dc6adead99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bmwvT0paUWxibDFHdEMzNTIwaUQyc2w2SjROQUtxc0o3cjMwaVdPWjE0L3Qr?=
 =?utf-8?B?WkdLOFVyRWdVMFMwYms3ejNaN0tldnl1a2U1Sk1EWmdzdW50elVTa3lzRm9l?=
 =?utf-8?B?eEJnZStIZkdWYmd4c1lYd2NjOE9KOUN6MjZaKzFXVWh6NWxQYlh4YU10ZjZy?=
 =?utf-8?B?N2w3L2dwSHB4OGFnV2FKZExackVCanFZaXltOGcxTGpZVFBwZjJwR0xtQ1o5?=
 =?utf-8?B?Y2t4ZW9xN3pDNUVqVGpCVEd4VVJEWGNnUnRrUkJkR2ZRR1N4OVExQ3RuZ1lS?=
 =?utf-8?B?ajlHMkdzV293ZVo2b0FjZlQxdGhzSUdHQkpkL1JHR1FCK0s3VXhtaFJOTVc0?=
 =?utf-8?B?QjRkQ3dHd280dHUyWGk1WFZrMUVMdE44SUJiWlVaZzhXZ01NRXArT09nSmZ2?=
 =?utf-8?B?bVFEMTJmNTQrNEd0S3ZYc0FsOUdRd2ZsalVTeEs4Nno3WmFUUHpkS2xhTzFk?=
 =?utf-8?B?NTlsWlVZZzZSTkNFZU5EN3hRM2lIT2o2Z0wrRkJ1UXN3TlcweGlhdEtoSnVs?=
 =?utf-8?B?NGVna2NBR1VpTzNPR2piVW5rMndoVEltenBFT2Erc2F2ek1zejlUU0w0bXlj?=
 =?utf-8?B?MzlpWTY4aWp5UEx5eE9QMVJzTktFZWlxK3Q5SkNtdkE2NUpsRE5kTkdyZzBR?=
 =?utf-8?B?amJHQ3BVbGNwWFc0MmpJeFB4dnZlY0o2d09YWG9vVW1WZUF2bklCQ2hnMTQ3?=
 =?utf-8?B?Y1dFZ0hQOFhjcmlGM0ZZOGJQNFJtSW5OYjlXd3EwL2hhRFNJK21SdkU2MThO?=
 =?utf-8?B?dUFoN0JJWmNjRzdYUHEwQ0g4UlJHRytZNER0M1VEZkh2MDdXZjZ5QnBVdWh6?=
 =?utf-8?B?bmFJc1FyYkhsS0VFZkRjVTdrRlFsWW1pVzIrQ3JHWWtMemVvYkFWdm1xeFFU?=
 =?utf-8?B?OXNJRTc4UzJxcVZQazB1QklxUE4yWnVzMXk0aEw4WDlOSDBYdnFvbEJaeVNp?=
 =?utf-8?B?cFRoVlZhVWNJaWo5Nk5weVFKdXlGQklzUURsdWJ4ZDNjZmJRRENnQmdmZ0VV?=
 =?utf-8?B?UVVncG9OSlV1M0F3WGU4eFdjZjJEcGZUdXFkNDVyY2x5MC9ycXphdXprdS9Z?=
 =?utf-8?B?OEIxRzA3U1orakVsOU9JZEdsTVlYZXNkNzJIT1Y1L21Ka2gzSkMvMXZsRXlF?=
 =?utf-8?B?aTJhSWZjWWluTkpUOFpVQVAyTGJGSjNEUTZoSWZFMGY5MVdRZUlHTTlpZUFC?=
 =?utf-8?B?NE90RFpqUkxBaUhjVDdubnIvZmd2QkhXa0trL1E3dTFwaVM1Z2xsY2EzanhF?=
 =?utf-8?B?SUJIYmR6ZmpTVCtLS1I5QlZ4cjJnRXZpclNScDl1NjVxTS90MmNnR3JwVnBB?=
 =?utf-8?B?NFhYaHBuUW5IMGN5SWcyb1pRMzJoOXRoS1ZTN1JzVldPSDF6aFl0cmhtZ0VF?=
 =?utf-8?B?QWkwZ2pTeFB3ZXlmWmVtU3NJSkJxZEVxdklkTUR6U1V4Y0NEL2dNaS9PcXRt?=
 =?utf-8?B?T0ZNY2M2czNWTERTcFdHUkpudXB5SHVoNFgyK1pSUllJK0x6ZVlSd3k0aVNr?=
 =?utf-8?B?NjFsSXE5UzNjRG41K3haMDhZL05JWDdCT0tvSCtMdDFqV2NJVVFnYjZUVUE3?=
 =?utf-8?B?emF5MW42QUFWWFV5R3poZ2JJTStjam5oZExocUJ0akxXZzZySFB2MW92K0JK?=
 =?utf-8?B?M0JDelRXZng2MU9iUUFQRWRzc2lrZzNTK2ZtMjdSem5lbmNneGM0V3poa1pT?=
 =?utf-8?B?TmpHMGl3cTZmM2owZmRmbzV5cE1EK0pocE9TZjFoSkZacHlkYnJqZGNEMzhl?=
 =?utf-8?B?RUVhcU1PS092WGptaHdBZndQcTgweWcwbC9UM2FBSmZ1K2UvS2ptQTh0VlVn?=
 =?utf-8?B?QWdlVit3YjY3aFBLTnBRZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzcyT1owMXk1eU1zeHZOVlpFSzN0em95WmV6L3daSWZHREhNRm4vSUFkVU9Q?=
 =?utf-8?B?RFFXS1JJYmhrUlRxU2psOEFCdW1QZnVFSmFDNnlBWnRtcEFrVVlWc1N4aVdZ?=
 =?utf-8?B?THNrVXZzVWkxckRVcFV0RkQwY21hbytneThzZTBCazZzUG5hOEdwZGx6d0tR?=
 =?utf-8?B?dVJtQldCTzBOaVZ0Ny83cU5UbUpRLy8vQlJsV3RPNjZnQlJnYzB3YklVUXJq?=
 =?utf-8?B?dEFwMzlmRkxwL2xMSHh1ZlpnMXdiK1ZQbTdOcTByRWlJN1pNOVZ4RTZUV0tJ?=
 =?utf-8?B?MFVWODJ6QnNxZGhqQ2FVYlIyVXR4YW0yellZalBUbExmSGdkYmd6TjFzaVE1?=
 =?utf-8?B?K21KbEVnYW9hcUllY21YeThzdHBTNTBjdXRYMWZ2TmJsWE9VclB3MWJ6emtR?=
 =?utf-8?B?VlFJS0lYV216enZsOEdXOFVtbXVlRk1BZ21JeHdZVHdUNnJ2bDBsR1RGYlY4?=
 =?utf-8?B?MGJNMVJIRm5kSGRQcXpncHp4dDRTTWhpejRGSndaNWNPTmZyTnJHcnZBQThR?=
 =?utf-8?B?VWNBOUpFTlpmNmFmWDRPRHErV2hRbExlWW91aFFFN05nTFdlU2ZxdWxoYjVD?=
 =?utf-8?B?ZTFaWlNiNUNZKzlOWjBqU0EwMWtuT0RpQzZLQ0VPcWRacCtTd0xVb1FJQzNt?=
 =?utf-8?B?c2hGYmtLZ2l0cGtWYXNVRWZTYzkwWU12WkdmSlhkTVZPNXJEcjJ2dmZGUlpY?=
 =?utf-8?B?ZHFXY2kyZTY2OHlCSm5yN1dISWpoV0pENVVuU1M4ZHhEZExBV0hyQkdTaERU?=
 =?utf-8?B?V3dMNVF2eHIxZnJiWHlCR0g0VlN0Qndick1Rcml4VWptc1d5Z1BRK0hWZFMr?=
 =?utf-8?B?WkNwbkVtcUl6UGFNUGdXeENEekRQQmNQam5XTThTdmVCeGxWaWxKVE1DY3lD?=
 =?utf-8?B?UTc2bFRDajM1VmtpT1NSdHFjcDJXbkNFazNubktkZ0N5Sys1QmhxRC9iTFpF?=
 =?utf-8?B?VnFvRldXRE1OVC9LSWhVYVBPSlRRSWw3bE95NEcybkE1QzdMd0tUSEtXcU12?=
 =?utf-8?B?eW1mUWEwL0x0aE9qbWdVeGZpekFsdU1tdUhRSGczSGszMnRjcmloeUFRSTYw?=
 =?utf-8?B?NCtyMHlGNGpPcmJQTGZGTWt6K0NmTXR0eTh1UTRtbWoxVW00a21MVHFha3hS?=
 =?utf-8?B?cnpjOXl1UlhPdmZPZnRITnB1RHM2KzRBVTN4cXFOdHlMQVBtTnJWaGRHNHVP?=
 =?utf-8?B?REdsSlptNTdSdmpFVkhRTDU1aWdaajV5VE9UNWh4Y3F3QndBWmlXQ0dqb3VI?=
 =?utf-8?B?eDVNSEZ4M2k2Zy9mV2tNSWMwNzM4UjZjYjQ3elQ0Qkl4YXVOclNsWUk4WHY0?=
 =?utf-8?B?eGsrMzBkZVQ1RGdDYyswOGhiSFI2ZE5heHdYZkRyMFBQTEJSM2N5d0VWK25k?=
 =?utf-8?B?UG5ma1p5eklIUFBnQmE5VTM4Z2lQMHJSOU5mdWYxUURXd3FtNU1rWXRqMFhF?=
 =?utf-8?B?b0tWbXFKTHJUTWZHTnY2SDhucmxaZHd2ZFdaQ3JxWHVHdmFDK0dodWM3R21k?=
 =?utf-8?B?anNxdk9LVUpmQ2RpbVdqL3FvbWRDek1LNFBPUUZscmoxbEJIOC9sa3kxR29t?=
 =?utf-8?B?Mi9QcmVRM3RHQTloOCtpaCtGRmlBTDR3NkpvWXk0MTRZcUFoM3VDTTc4QW5E?=
 =?utf-8?B?a0QvcjVkUVdNRndKRWpxMWx3WWl1UDhuaEpwMWRkcERUVGZJUTNlM3lPcm1C?=
 =?utf-8?B?RHZFUGN4SnZrbmdqZGxlRVZXQ0xJV2ZUVnp3VFRyZzJIUHJLK2hRN0xNTlBo?=
 =?utf-8?B?dExTV3A5MGpCSnRzNGlKKzA2K241c3l0MGRzYzhtd3RpQ09Ja2F4a3JoUWFu?=
 =?utf-8?B?Y0pXTThNdnM3MHJNMVR1eDJ4SmR0T0Y4OU5zK3VZWGVZR2xpQVE1dHNnVk95?=
 =?utf-8?B?aG9tZTlQaDc4REZ3Uk5mTDZlZkNCK0d2T3hXcnZDNUFLbnN0YWNYM1hENk5v?=
 =?utf-8?B?WVY3TUttcU5oNnVBS3djSVNRaUdUZVhXeXowRWhuT1V4d21PRk14azhXTm41?=
 =?utf-8?B?ZjJUMFl3QTJWUmtPbXBsbWxtdkFxSVZLL1h4MkNhTDZKeWdrQ2ZDZjIzNFZC?=
 =?utf-8?B?UTJYd1ZPVFNxMUZoZ05paVR0MnFWM2dNZkZGV3RWam5hZ0pZQkhNTFVhY3Bj?=
 =?utf-8?Q?FecwEsViGXPLWCmcG0a8HB/ly?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8ca2dd-37ad-4cee-5645-08dc6adead99
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 19:33:00.7319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCHfwd3unD0jJ/d1kvHhWYkm0cwSEPj2hLqTNY7xpLAC4LbgKrez7+hoghsLzDlcOc95+uwR20Av/siQ6XEd2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7159
X-OriginatorOrg: intel.com

PiBObyBmaXhlcyB0YWcgYmVjYXVzZSB0aGUgY2hhbmdlIGlzIG9ubHkgaW4gbGludXgtbmV4dC4N
Cg0KRG8geW91IGV4cGVjdCB0aGF0IG90aGVyIGNvbW1pdCB0byBiZSBiYWNrcG9ydGVkIHRvIHN0
YWJsZS9MVFMga2VybmVscz8NCklmIHNvLCBhIEZpeGVzOiB0YWcgd291bGQgaGVscCB0b29scyBm
aW5kIHRoaXMgb25lIHRvIHB1bGwgYWxvbmcgdG9vLg0KDQo+IFRvbnkgY2FuIEkgZ2V0IGEgcXVp
Y2sgYWNrPyAgSSB0aGluayB0aGlzIHNob3VsZCBnbyB0aHJvdWdoIHRoZSBDWEwgdHJlZQ0KPiBh
bmQgcGlja2VkIHVwIGJ5IERhdmUuDQoNClN1cmUgLi4uIGRlbGV0aW5nIGR1cGxpY2F0ZXMuIFNl
ZW1zIGdvb2QgdG8gbWUuDQoNCkFja2VkLWJ5OiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5j
b20+DQoNCi1Ub255DQo=

