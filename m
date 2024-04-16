Return-Path: <linux-kernel+bounces-147655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF058A76F2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EFC1F21E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E5B6BFC5;
	Tue, 16 Apr 2024 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VIK0B9Do"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121DF6BFAB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713303954; cv=fail; b=r1nYF8gLLgMCt6NB2m3snirUv9APTFGE/TO6BYiTX9ZTE2XFFyoG1Weh5VOczFPqne1e6wrE7PleA+/MR1yuxphIfHaF7WClIBD94Zio3++kp0i29AEU1qfRIk6HJzGnU5gFYvGbZzSBzBRd8qxqa94ouQG/WjnpsYDt88PpTAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713303954; c=relaxed/simple;
	bh=udJmhCxDKYg4g9cQh3qC4rEZr/Tl1YfcCJHi1iLEtTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nUFALGNgV8nWLH2z9ZTmb8SobVt+UCiyGV3llx7z+XS+MCAjwT9W/0uTIjwLoUpQVxvt5IQm6kUdXf5CpomLeC3DyWOsdG/xbc+9o/B9zykJR6X/2P9katu7EVrg0KDxCU6rWkaiO3PoBaO/MeFA93r6SpiBeHkMvnaXfOe+JI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VIK0B9Do; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713303953; x=1744839953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=udJmhCxDKYg4g9cQh3qC4rEZr/Tl1YfcCJHi1iLEtTg=;
  b=VIK0B9DoR3uulYD5M6g4lfYAs3TBeqAoxlir+9Se8NYjNKOWqragWqAQ
   msxHx+xyEpKqUMzU44ETPzdT9isyEBkGN3y70mVajGgrRKZn4W1jvSRJ9
   e0qCiGhnRXZ9gVk6Pg/stwfyUFt+aafsmf5Vfocddlh5IRTIDltBJChDi
   LmM2s+nev8ponDRTEb/F6BUUN7uXh2Hz0nnYamCu1lyR0wPgTG4Iyub0m
   Sae2G32/SPsPtzHgRjcqGkJBni5ViwGFv8Gv3tWrGLubVy5AcykIhPX6D
   lmWDlN7/O9/4jW8Ol5pFZbUFr8Sp/s23rrl73uEqlv0VihHceC1t/Ai4m
   w==;
X-CSE-ConnectionGUID: UcyHijN5TRmvTYB7GHC8HA==
X-CSE-MsgGUID: ZuOqTHPMSpKW+pmOZ3fflQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12560025"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="12560025"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:45:53 -0700
X-CSE-ConnectionGUID: kj5fUQr1Q2KzzpB3uNSqLQ==
X-CSE-MsgGUID: pYK5edE0TJa7960UBGsSvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="45686197"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 14:45:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 14:45:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 14:45:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 14:45:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcnEkTNPct8I20zklPosyQ3NAO+s83sSdULmB0fi7l8Po1yc0lFkrvjbvJ52ocl7dzpmHu29N960g6Ch0MTenMRZDjR9ANxa7JYGdwktwGB1hEu6Mjg7CibB9EU5db7xjwlBirz3S4tFfmSQIvLRkFg5lk8631Wsi1mwf25bpudwCQmaZaAp2hWcs5xvGlpzCgyBA3fU4ERd6zHrjHQO+IzueuFoZLz1v/idJuv/+hvl0r3iUsv5LRW2kW1NbBOCe1fNZyvIRDcIqRBr575ffHIarXrinfAnkqRA+r2YnEF3OQ7L737/H2Pu+oA5H6zPIeEPaUlKMrZy1mT7cD3qEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udJmhCxDKYg4g9cQh3qC4rEZr/Tl1YfcCJHi1iLEtTg=;
 b=n3wJ1DVnzfvGgZKJPVtXOhs1rGOCLIuOL40QYJUzfgmfUratnY1o2/j48xGa0SOnhFsWq2qVa6rdMcT99B7buHrlo7dIHv5uPCY4j3C2hvQaKzmhiUQbQI2ZeLkyc3HfLMXs4691xt580DKAG46eL3/ELU3+xIHY96Zt7m3b0tBV3hCzirRQneTLD4pNk2luFpWOWSpqSMOtoKrZh9v5b3FsX3Gn9PLa9BohoZwBDScL1CEmADDOTOoLBeK29HZmeEtaEyiRwbQFpR+0BgOYABe/CTwF9qtti/YNhkXcKTKVIL8RZcnLcnftM2XCeHp+OctwIOUr3YAad9D0+9Vg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB7961.namprd11.prod.outlook.com (2603:10b6:510:244::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.25; Tue, 16 Apr
 2024 21:45:49 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 21:45:49 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to struct
 cpuinfo_x86
Thread-Topic: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Thread-Index: AQHagS5KoaFl1e6FLU2YPMaZiCLmO7FNXROAgAABToCAAAEjsIAABDsAgAASPNCAASNagIAOGFGTgAHr5+CAAQ4ngIALqHC/gAACIbCAABhfgIAAHE3g
Date: Tue, 16 Apr 2024 21:45:49 +0000
Message-ID: <SJ1PR11MB6083F100B4D957EC472AFF19FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
 <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>
 <Zgr6kT8oULbnmEXx@agluck-desk3>
 <20240407105407.GAZhJ7T0fEhzow2MN2@fat_crate.local>
 <SJ1PR11MB60837E437DFA0595DF5B25D0FC002@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240409082217.GAZhT6uW7aELQCHOwL@fat_crate.local>
 <Zh7AZY5X8_uyHrjz@agluck-desk3>
 <20240416182336.GHZh7CKCE7ApJ5OSPC@fat_crate.local>
 <SJ1PR11MB6083F189AB9AB47D3DF74B19FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240416195851.GJZh7Ye4eg_7VJrq8a@fat_crate.local>
In-Reply-To: <20240416195851.GJZh7Ye4eg_7VJrq8a@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB7961:EE_
x-ms-office365-filtering-correlation-id: c343ff8f-4c9d-4958-4352-08dc5e5e9494
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TkcrGhLm+xSO//ID81tAfkSegYtzNtow2NFW24fVvTJ6qv1QDQSvv5WSYnGY9f1jGbrZvy1SAARyZN5SbmHJlD1Nh8CBdqfDdYTOsNo93mTCG+IYvBQhQrPP8k0HOYkKvw9JFJSBc+L0U9+jr+B5RBip3G4Py6U1+zkujzGqULMclgJC9b6tlqOWxPOfxMZipowVQ26Ko20eVQeC7jdsVVebExsHB7PAOl/LT3bkmG/YLQxfDS8K+Len6URHWYXB0TPLO5qpudvRemsmuxgt/sVFhkaNSFT8msY8m2jez8mhInooLeQBc3CG2+uWrhAeeeBitlSZPwStIeACtgmC6YhIlc6jv7TKTQx7aPp9OqbaWF70Lfka+sdSQ16vMXNZXrkjSm48XrZvq6QRbsZJO0lKWg52ppR6FNwbGxM+HWCW7YIb+sYYau+F3w/WuRxT22f3jp4rZXf6AkD4GBQwsORT3bqK2scSyaMjzyMapyxtH8MK7nUzMwk+GhIOO0bK3uWzHLCCSaJbTP5OVqdHYGixV/u4DwQDEO19aN1AhsEzkU+fgRVBAfiBjUt+/mMcVc4Wg0sfVsW25wgSe2/nqWTyA5iQfLyj5zyEPG2Hx/mcGo8PZUgA4rB237xF19TOGDK2pShGxXLd15o642OpTFuettXkaZmpYQSKR38fspw2lQlxpCsfHWjmt1lu/vClZU6G9i/GhsZL7mIVQb1jRuSy4O0SPBlb8CVU9ZRwNDE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0RRL2c3MHNOeFNELzc5TU5VaVNhendXZWJMSUFxNDRPRnVDUUxpcnovdVJq?=
 =?utf-8?B?Y2Z5d0ErR29WYkRXOHE2ZCs5TTZsZTFOU1hFNTFYMWxYcmJFNWVhUWhlWVJu?=
 =?utf-8?B?NWFOZTdUaEdZcmJkdnBQUFQreXdQQXgwNnF5dzBkSjVZa3orZzdCc1crK1lw?=
 =?utf-8?B?R2VpU09OUXRNRmlDS3hETDY0V3ZPQTVTamxadFZvV3crYWRGVkQwdXdEL05i?=
 =?utf-8?B?REI3VnRsenEvdHRpcUVxS1k0djdrS2xDLzJLcXl4bDByTWV6Z240azhIYmlm?=
 =?utf-8?B?aXU1aUdMYlU2dFFuUXVQNTJaNTRvemoxdDlrZzNERDJpNTl1MHJieVBCVE9J?=
 =?utf-8?B?Qi85MDRwYmtQc1VYTjlFRDRLUk93UUtveEhGTlB3eUZoY3NYVFROVXRabnlj?=
 =?utf-8?B?UzI5YWtxMzZQcUhETXh4bUhXU0pnaytkanVSSnRzbHNyalRJUTIzdG9EMjJm?=
 =?utf-8?B?bnM5cEdFN0ZlS05SM1BiZlh6cnpQb3ZKMEpTcm84L0l5Y3FVS2FSSlpTRXpB?=
 =?utf-8?B?aGRaZExiSGhqN3ppNGJoWk1Ec1hpL1Y4UWVNRzB0QTV6eHJsUmQ3Wi9VSEtJ?=
 =?utf-8?B?VWZHNC9VOHJjL1B3MVFTSGhRTC96R2dEc3pTamxqWkhpWlVrQTl3d0wvb0ZV?=
 =?utf-8?B?K3VIMnpOOWhobnRyeFZpRDJGL2dNTG1QbHpIL3B3NkNMemN1eTVZeis3QlBZ?=
 =?utf-8?B?TkV3WUNIRFlQVXRyTkJ5aG1RSTNIUEtFTTJUUi9PL0xyWXRteStENDhZOGFN?=
 =?utf-8?B?WWtrRG8rMG5vOFVncTFkdGppdWE5SWpaK01jWEwvS0JINEc2dVprdE8vQWlJ?=
 =?utf-8?B?S3RyMDlvZ0hDMXNoM2doR3orQXU5Q2JaV0gzdXlhd2FUMVJMcEtUSVN6Tld3?=
 =?utf-8?B?dUppUDg2djdkOFRrVnprTHF3c1gyOTlFSGM0WHBBNzFWRXlJdXF6cTVtbi9I?=
 =?utf-8?B?WmNTQWZocUtOaktFYlp1TmcrR1FzaHA3U0QzMDRqUTJoUVIzMFMyTjMxRGVT?=
 =?utf-8?B?Q29vc2ZNendKWHFkSDJPZjdxeWFZZFBkaGh5L1dwQ0VQcVZ5eXlQbmp6ZFZH?=
 =?utf-8?B?V1B2dUgrNWE5Ui9oRFF2M0xTeTJKSXdEaHRaNHpET3VJaEliaUp2elkxdHBR?=
 =?utf-8?B?K0hPWExxNUorYlgrRlhnSGptN3lmNm1hMHU1WTZjVjFsdStYTVdxVlRhbnR3?=
 =?utf-8?B?S1U0cXFpdHlyYmpVMjF4eVV4QTFzYnREdGtFTTE0M1J5ckQ3M0dQbXZrN0Q3?=
 =?utf-8?B?QU5DYXF0S1FxRzdFTU95cWc1eVk3TUJMa09WOXFuN3NHb3BWaWQ3VFAwQlFn?=
 =?utf-8?B?WGplSnQ3aE1QUWlEdEtZOG9YeVhvQUMxd3djZ2NzRStYUHVUNkdRVE1peW5N?=
 =?utf-8?B?am81U1RwcDZ0bFpnUEpwbEwyeVAydzVYcFpSU3hXUlZjSWZhd1hqNklBckpm?=
 =?utf-8?B?dnEyUDNHN3phbkQzaEJFZUFUaUNESFJVMHJPVzcxZ09halhvTS9PWUNtRTZk?=
 =?utf-8?B?UHF1Ni9PSUdrNm1IQ04ySkkyenBrSXE5eUlXUC9FVVRrRG1CYzhyR0h6QktV?=
 =?utf-8?B?QXlsclR1T2pTdjR6aGJ4RXVFWEhxdm1hYkhvME83eUMzZTRLNFQ2UnRMeFpU?=
 =?utf-8?B?OVY4YW80MHBLY0kyZmRjeWp0aFV2cXMwNUJqdHk4aVJTSUdnc2RjQXo1RktE?=
 =?utf-8?B?RlcvQWhOYVpjY3R2SkxtenpYSkZ4aktsMG5DcWtrVUJHMEQ3bXVtQnh0RHNi?=
 =?utf-8?B?dEhTR2p0cjA5T2d1NFluS04yL2RIQWwyK2kvY1RBNk41ZTRIck8rWEY2VFVT?=
 =?utf-8?B?S2k0SWJQZ04zWkliMi9yaGFyN0loUlA3b2M5anZWQVFCUkNaVUR4VDVZK3Nv?=
 =?utf-8?B?MW9xcUM0Slk1dXZGMUF3NVQ0Z2pjeTk0RVNFbGsxUHRqYUREYnFaaHdQUkhl?=
 =?utf-8?B?VlRlNXRrZmN2VThZd3U4ZFdKOWc3NjZWeGFsamUwc0cwaWdKWnM2UVk2RVVr?=
 =?utf-8?B?RVBvNGIxVEZMRnNhK0VMcER2c1NSRVZZNzdSOXFiYldsTm5YU2ZPZlpTRSsy?=
 =?utf-8?B?RXdodXFtRVh6M3JOUWdGVUUwNlNabWgrS3UxTTdFSGVrQ0E4NTRUSUNwdHJ4?=
 =?utf-8?Q?3IPR8qn0BKEf0wgnvfOYAw23X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c343ff8f-4c9d-4958-4352-08dc5e5e9494
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 21:45:49.2291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: em7SxTWaJWp1UccqLnsZRdBasAsM7j/udlqfiV6k3A9E1KEU1b69Tm22tJC7NBuWr5jitOtkZzSa7UQUsNUjxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7961
X-OriginatorOrg: intel.com

PiBBbHRlcm5hdGl2ZWx5LCB3ZSBjYW4gdGFrZSB0aGUgYXJjaC94ODYgcGFydHMgYW5kIG9uY2Ug
Ni4xMCByZWxlYXNlcywNCj4gdGhlIG90aGVyIG1haW50YWluZXJzIHdpbGwgaGF2ZSB0aGVtIGlu
IHRyZWUgYW5kIHRodXMgbm90IG5lZWQgdGhlDQo+IGNyb3NzLXRyZWUgbWVyZ2VzLg0KDQpJIGRp
ZCBhIGJpdCBvZiB0aGlzLiBJIG1vdmVkIGFsbCB0aGUgYXJjaC94ODYgcGF0Y2hlcyB1cCB0byBp
bW1lZGlhdGVseSBmb2xsb3cNCnRoZSB0aHJlZSBwcmVwIHBhdGNoZXMuIFNvIHlvdSBjYW4gcGlj
ayB0aHJvdWdoIHBhcnRzIDAwMDQuLjAwMzkgYW5kIGFwcGx5DQphbnkgdGhhdCBsb29rIGdvb2Qg
dG8geW91ICh0aGVyZSBpcyBubyBvcmRlcmluZyByZXF1aXJlbWVudCBhbW9uZyB0aGVzZSkuDQpC
b3VuY2UgYW55dGhpbmcgdGhhdCBuZWVkcyBleHRyYSB3b3JrIGJhY2sgdG8gbWUuDQoNCj4gT3Ig
eW91IGNhbiBwb3N0IHRoZSB3aG9sZSBzZXJpZXMgYW5kIHdlIGNhbiB0YWtlIGl0IGFsbCB0aHJv
dWdoIHRpcCBvbmNlDQo+IHRoZSBvdGhlciBtYWludGFpbmVycyBhY2sgdGhlIHJlc3BlY3RpdmUg
cGF0Y2ggZm9yIHRoZWlyIGFyZWEuIFdoaWNoDQo+IHNvdW5kcyBsaWtlIHRoZSBzaW1wbGVzdCBz
b2x1dGlvbiB0byBtZS4uLg0KDQpBbHNvIGEgYml0IG9mIHRoaXMuIFBhcnRzIDAwNDAuLjAwNzIg
YXJlIHBvc3RlZCB0byB3aG9tZXZlciBnZXRfbWFpbnRhaW5lci5wbA0Kc2FpZCBtaWdodCBiZSBp
bnRlcmVzdGVkLiBTbyBtYXkgc2VlIHNvbWUgcmV2aWV3cyBjb21pbmcgaW4gZm9yIHRoZXNlLg0K
DQpQYXJ0cyAwMDczLi4wMDc0IGFyZSB0aGUgY2xlYW51cCB0byBkZWxldGUgdGhlIG9sZCBtYWNy
b3MuIFRoZXkgY2FuIG9ubHkNCmJlIGFwcGxpZWQgYWZ0ZXIgZXZlcnl0aGluZyBlbHNlIGhhcyBi
ZWVuIG1lcmdlZC4NCg0KLVRvbnkNCg==

