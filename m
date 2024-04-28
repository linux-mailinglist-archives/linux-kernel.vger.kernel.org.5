Return-Path: <linux-kernel+bounces-161249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909178B4992
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7C4281518
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 04:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35E83D75;
	Sun, 28 Apr 2024 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvJ8tVPH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621A2905;
	Sun, 28 Apr 2024 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714277865; cv=fail; b=k3RX8CrAFCYRW095Fp/i8A2qrQaj7uXk3draMFU1yqhHbR8UROyiqNK8XReRSA1BbYFPMBgewvg4K96vP4aLlG+RatAoksQNy+CeXsAq9vBzGUQOJNO3h6tqwmqJWJDC3rmMGhTccICC+DE2JNnyxgWgAhFp+Bo3X+WE4w+gPSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714277865; c=relaxed/simple;
	bh=MJn/izRnzHO1JweDz8whytVnPYtTQD51PikyzXpLfgQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aZbmBW9jNUavsEzXRAU1Unqm2uBUdGmU9caT8oVqFXx9Agxz1KfWOkW5jmKs4LCBemK6KzJA3H5tfyzxQkDxyL/3pLFrd9BgpfNynRPqo8+cZDqo1WU6EtKwZ903emlTq6iaq/8aKGauKIts44xmu3lNLqPka0oYs9PMNNtULNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvJ8tVPH; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714277864; x=1745813864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MJn/izRnzHO1JweDz8whytVnPYtTQD51PikyzXpLfgQ=;
  b=YvJ8tVPHg1pC8HaIZHwvitT1Xqm61/A9OZQ64J1LuLgvHi8nQfokEHuV
   EGte2CFMCsW/0Q9VQ7wS4zvgVDFyqFI1Bv8srDoqAd8zrGPkjUNboGKvY
   iyMv0wh72mYKNmeS3mguZ1G6GhPqh9bL49jAF+zyHYMnSj5KS+UokDWdC
   TTrdc9nIQc9TgpZMKqjXYIkx5NzYITZyg1D39SuU2cewiJoU83HQ5Qwvt
   bwDwm+rLUO1ZunIA6df4NFCk7aK8+7R/pX/MEBvQCdjHmtY60LqfxsfaM
   ALVvxAIQIniSTr6U7YuQ5VhwbLPBuL8msUj35dFrKaby5/iI2cZ0j+r46
   w==;
X-CSE-ConnectionGUID: TwAuE2cEQGGafxWO9xj6Hg==
X-CSE-MsgGUID: buaYLFH7R4SRIChQQY6rOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10130679"
X-IronPort-AV: E=Sophos;i="6.07,236,1708416000"; 
   d="scan'208";a="10130679"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 21:17:43 -0700
X-CSE-ConnectionGUID: 9PGUDi+xSEuu73ltuvpnQw==
X-CSE-MsgGUID: yNN2r4IFTPOENWQ1Syh5tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,236,1708416000"; 
   d="scan'208";a="25859637"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Apr 2024 21:17:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Apr 2024 21:17:42 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Apr 2024 21:17:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 27 Apr 2024 21:17:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 27 Apr 2024 21:17:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkgAim8FXi/NU5Rx7uo0uNghVfuEtbBjvfAV7u7XvaGoKU6mtf+SadMdUWjqXqGP4+dHE39UsuIWmWdGtwvciMiRYopbDOUZuNXMk5xM7UD70e4uCpdxSd7m4Gu025fYgMSUMb9Y5ndiqJz6pjnNDmoZqZXk9AxehWwDfswz2b5HJSoTcEx8Er2+nuoRbgqbWWlSoa+P+tyLBGYOBs1d8SoRP+6vEgrsY7w7E3A7+QdBTLvHQNB5geRd5nOEgQv1zZdvZNLEoD0MgGbva7Pklgi2TMIOn4/F/cK+fHeTDdGw4nBh1O+13ZQM88blLAIt0RZCngnM7sjMTI2MzeKA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJn/izRnzHO1JweDz8whytVnPYtTQD51PikyzXpLfgQ=;
 b=Nx1q8WIVbu/apw1val70jCD4P7qevCT6pikaJkgZhgQatftZ/dhEDsqanCXtvNCC3yokkb5qD8gUvU4xso85boCjnwZhj9ZVp2iYY81i5QGhTUCJ2yZ1ypaVEHYC95TFpOXgUTJfErT6qcVOB8ExOYcQ208EMNs3R4q1xh/cqYPIEUw+Edq0wgnQigRKokqWO+JxvJais9lDN2EJP87sGVkyZxKRZbFT+sclcf9uLGwLEjgOxG7aOWmmF/+GA7d+4wTbFHHorKabqgXUmDalgod95G+LcouSp0yHRC/rLMsWYvTx76fKzi6NyHolByI7/v+MbNF2pt84lLtbGl9gIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW3PR11MB4746.namprd11.prod.outlook.com (2603:10b6:303:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 04:17:39 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 04:17:39 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
CC: "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: scan: Avoid enumerating devices with clearly
 invalid _STA values
Thread-Topic: [PATCH v1] ACPI: scan: Avoid enumerating devices with clearly
 invalid _STA values
Thread-Index: AQHal/rEvYr4YALfg0ik+n9h9UnvILF9FgwA
Date: Sun, 28 Apr 2024 04:17:39 +0000
Message-ID: <278b47946efd7f67229e26335c419570871427cc.camel@intel.com>
References: <2741433.mvXUDI8C0e@kreacher>
In-Reply-To: <2741433.mvXUDI8C0e@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW3PR11MB4746:EE_
x-ms-office365-filtering-correlation-id: c0ad1298-840c-409d-0da0-08dc673a246b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TERmUXlHNzlLQ2JTVzZIT0xqMGN2U3ltdGVudHptYzlSbURPckxZK1ZZL0FQ?=
 =?utf-8?B?RG5hOUNKY2hRZVR0bFRjanFPYzVDai8rNjN2R004SXk0aTkzNXFFOEtub1Vm?=
 =?utf-8?B?YktTWjBrZUVqU3RBdjF6Y0tMLzVkN2llV0FNV1dmTS84b1VQc1duSUtEVGl1?=
 =?utf-8?B?a2dGNmZCVkxHeTNONUMyY1NObFAwb01iVXVHeFJ0VVdIbUkveWN3NzlpekEz?=
 =?utf-8?B?S0VoaGF2cmYyQkJYUC9ZMWE4RWd3bGJRRU1scW1nSDV3QmorQVFrT0N2ZUxX?=
 =?utf-8?B?bi9sRDhRaXkxc1FaWGRpeVYxUTFYaDZWUnUzTkFKNmJQQ1pFWGwvQTEyRUx3?=
 =?utf-8?B?dTVzT0ZuSTFkQ2VRVmVvM0h0RVB3TDE3cGIyejJUTlpYbDdaLy9zMWszYWF6?=
 =?utf-8?B?eEdBQ1M2SVJCL0pVWTJYcXhhNXBUUlMxWFNkTUZROHQwUTdOWmxRNmNvQ0ZJ?=
 =?utf-8?B?VmFCYk5nTXBDZXpGcjE1RWlOWDdKYmZsQmh5c3dPd3MxbXBiVDV4MVVVWnlU?=
 =?utf-8?B?S0xaVmYrd0dNMDlxMjU4aEVRelIzRmo1dFJQdldqMis0VXhaQTd4aGw4RDYx?=
 =?utf-8?B?Ly8vbk9qT1JFQTMxdnNSL3pZS2ZXVTBzUGtMM2YxNGVjRkZJZmI3ZHM0REE5?=
 =?utf-8?B?WjIzcjdWZXNQeThVT0JPVlRyM20ycW5vcFEyUENVdWoxM2NFcWUzOS9jeVFN?=
 =?utf-8?B?YXljeXdUWnM2UlJBdnZJYWtwME1EcXQrbGxpOVV2elZxNDEreXBoVFJZTnc0?=
 =?utf-8?B?MFIvWVdsZ2FvandHbW5qM1JyTVlzVXhnTG00L3UvZE5QZm9kVkRXZGVEZlNH?=
 =?utf-8?B?U0ppcGRrUzhxNnd1N083WWxhM3FmRkQvVFRpRi90c1JVdWdxNDV3VlEyTEk3?=
 =?utf-8?B?TyttdWZXZkR6N28yaXJzR2VyS1l1WmNYNnpBZmsxRGwyNXF6VWMrYlJUWlRl?=
 =?utf-8?B?WVlHRllrVWlFRmJ1Si94L3FRSE9sSEdJMVF3SEsrOGRjUUFJMjVyYWx0MXZS?=
 =?utf-8?B?YjIzYnRrZnZhaWZpenVia0kwbVdmcmhRNVk1SlJpcHlqTTdUZHUycmVLMitt?=
 =?utf-8?B?RERLTkxxY2tTM1o2T0ZpZGZLSkwxM0V4YnZNNElZZnJ5RFJURTNiZGtuTzJS?=
 =?utf-8?B?eU5SamFtSHdNN0JvVm1YcmdNMEt4aHEvNk5FS2hWYnBOS3VxdkVaU0E3RVE2?=
 =?utf-8?B?SnRQazNTV1hYMVgwYXhIR3EydmFuNnhXa2xrR0k0UGpZOGlQWFROVnBSRCtO?=
 =?utf-8?B?OW1yTzVFblBmM0tTNjJodG0zcGZ6d3ZYTUUyQmJJdWNURlVwYjA4d1IrdHdl?=
 =?utf-8?B?NnNVbEFsT0lNSDBhQTNuYTRLd0N4WnVwZitySzlMdkcyYUpJZ3lkMkZnU2Rx?=
 =?utf-8?B?YXV0R2VnMXZyR29qM0NPYndaWWs0RTBIa2JoTERPYXc5NjdlYUtDQ2lvYXN4?=
 =?utf-8?B?Y0d6azFrRkNzbnpkNEZyMWdqZ09pNW5LaE5iNmRqMDZNbWVuYUV1UFJkY1FH?=
 =?utf-8?B?QlUrVDFibXl0R1orei9reGVlTW1Nb1lKYmNFWHJZd0VxS2tGMDNBUndJbnNG?=
 =?utf-8?B?NlB4Y1JleUlVMEdBNG5jb245OW9hd29MS2lUTmwvbGt6cEF2cVRta2ZHdVln?=
 =?utf-8?B?NzdHT0pQSUkyVVBCZlY0SFpzK1lwQUtNNVgyOTEyTUNLUFlsYklJaHd6U1dS?=
 =?utf-8?B?cmhHMUY3QStIUERlMXFjOGNpY2RNOWpnei9oWDlyOS9mditsY2xzajJnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFlsdXRQbVBGZjlJVVRmYS8yZzYzSVE2NnRKbEdrdGVIV0ZmbWNpL0hSTmhw?=
 =?utf-8?B?cGVSWEs2Rk5wTmovRUd0RHIzUGllUVBsc1ZHaGd5UmRIS0pBVG5OdUUyRTc3?=
 =?utf-8?B?a1Z2ejEwdlRVd3ArSUtPZWxhRndXejhxdytHekxKYm1hSGRNRjdPZCtsNzg4?=
 =?utf-8?B?Y2d2TmVCZVRDZGhvLzY5U28vL2xQU1ZsTXRsV0hRTmFkbEhsYXpQSWd3ZVpK?=
 =?utf-8?B?MkdGQVV5WDNWeEFTNkwvR21rc0hvdlNIRkVCWjZZMnhXTFRBT1hSeXg3VzdM?=
 =?utf-8?B?YVlxYmlaZGRsQmdRUlpuUFArK2RGZVBjVkJZa3FsK0VCTEZBZkl3RXY4U3JB?=
 =?utf-8?B?cFhudHpWeEQvNktFUEVMRng2ZDZPRDdOZTYzdWp1ZTRSVDJOT2NtK0ZRVC9S?=
 =?utf-8?B?NStwSldtYS9kaGRaYjFqM1Zhb1haUnVaTHAzN3UxdE5QeHo3bXBKQWFnV3g5?=
 =?utf-8?B?SlVuK3RXMEI0QjB3Z0NaWDZySUdkU0dDNlczc3A1dE1uVUN2TjZPNXJlTWlY?=
 =?utf-8?B?YTJDNndvUnRPRzRkbEg2bjhLeFdhVm80V3QzSlJHM0NtTjVXM0dkUXdNeWdU?=
 =?utf-8?B?Q09tNnlHUkZ1RHhOYlZ1QWxXWDdnK3hPUjlZZFpUTWdoRjB3NnZpMmV2QXJH?=
 =?utf-8?B?aWpWdW5WVVhlK2hwV2ZDWEZnMms3Y21UbGtxZVJ5ejVhWWFlV3d0TFVwejRF?=
 =?utf-8?B?Z2VRaFl6TmI4NFc2M0lMbTQwZG16dURYejhOclIvOS85YkZRZDE5SFoyVU5W?=
 =?utf-8?B?QUFDMmdZakh2RTFRSVRET2ZyeUNQNVVlSVNTQVQxblozUVVPaHkvcDNCbmVw?=
 =?utf-8?B?RkRFWkVMcDc5WmowdG9raFJud3BNc0NrNkVXQlZwazhMNjF6eDlRV3AxY2lD?=
 =?utf-8?B?T0Q3cEkwaCtwOTd5eVZDdzJCK2xBRzNSQXc0U1pDTitMZ3lYd3QxSDJYci9X?=
 =?utf-8?B?b2hLeml0REwzWFE5d3AxVWhkNTlJNHRidzR2VmMrYXkvUWZFTHVhT3o5RUFl?=
 =?utf-8?B?M29oKzJuL1Q2M1ZySG1FRk03VFZxak9MUngrQWR0d1dQSytXS1dCYlloQTBz?=
 =?utf-8?B?ckhRQktBbDczTCtudWNYR203N0hrTzIyRCtYNUZ1UG00a1ZGNDhHbGwrVzU1?=
 =?utf-8?B?clJjUjFFemtUMEV4VzFob3RJSmRwcnlFc1F4dzNubUttb29TKzVuRGhzTXVQ?=
 =?utf-8?B?NnA4OEk5V0FObnA5LzJaaDF4b1NNalN2Y3ZWdWUzQk84a0dOaFRjZGdrUys1?=
 =?utf-8?B?akx4dkNUYUZYYllGYzZDem9USnFnbkQvMy92eVpseWw1Wm9TTk5NTjR1Y0tC?=
 =?utf-8?B?Sk5weFdhQWduQmR2akFmU1pVU0ZUaTA3ZytvenJVdWVtemFjWHQrYUxqdVI3?=
 =?utf-8?B?Y2hIK2dsUG8yV2w2bnh3Z2ZtYlN3NnBnYWVDMlFPekxpYjQyMmhKUlpkQWVC?=
 =?utf-8?B?L091T3RVZU5lQjNCM211TGlGN3lvVUhYdTdOZXZNZWJIS09HbWY4TVAvb3Zs?=
 =?utf-8?B?NDhmS2dRRnFhYml5R0xubldWRjh1QTJjNklacGVNQnN1YmxlQ0tNaGZlNFpZ?=
 =?utf-8?B?RHA4YStvZXM3eGhKSVJRVGFuc0lSZytaRHlsQ1QvL3FGQkJoTjZmamljSDIx?=
 =?utf-8?B?cmhHdTE2TDVsUVIwYnorTllaRW5EQkt5c2Y0dGt4Y24ybFg5ODJUNmlza25l?=
 =?utf-8?B?UXRRcGVMVWVyNDlJa3FHbGFZbDRMb0RXVzROVVpramhIc1IrODBCTkkyWjJa?=
 =?utf-8?B?RlpYYkE5VVpKdnViSkI4bUM2amNwSDdaSkVlU1RoNzA2MzhSSTVpc0cyczZn?=
 =?utf-8?B?NnEzeWZHZlBMRkNua1V1UXE1aFhIZHN5eERpWEs4M1hUaGhxLzZOUWJuU3Ri?=
 =?utf-8?B?VThNVUt0aDNVTGtnU09mUDNvZ2ZaNGplbnZ2bUdZWktnYzgwMmozdkZOR3Nz?=
 =?utf-8?B?UFF6RG9ZdjBWazFuQ2sva2ovSDFSZ1Q4UVd1MjVlUURJUldrZExnclBEWENl?=
 =?utf-8?B?MVkvWTNFYkFYZzFCYXlBcy82TkVTOS9WdXFJYUdrb0JNcWFJSVFSNUx0Mmho?=
 =?utf-8?B?cjRadzRMbE9WMTZWV3Z3RzRBYWVhaGk5c216MlQyWFByVEF6TTFpbHFBZVFn?=
 =?utf-8?Q?3B9ZKEhPO2OfKUyoiKFRjmoCg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F320A58BE57F1B4BACDEB85D9BB9E607@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ad1298-840c-409d-0da0-08dc673a246b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 04:17:39.6109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3MXq2ZfD4sssd9WGV0aNoOwanqMypBo7Y21XYx1zrPDQrrMMugOKgYLGa6VFqMjMkHjszWIyeKLrgbVzToRzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4746
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA0LTI2IGF0IDE4OjU2ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gVGhlIHJldHVybiB2YWx1ZSBvZiBfU1RBIHdpdGggdGhlICJwcmVzZW50IiBiaXQg
dW5zZXQgYW5kIHRoZQ0KPiAiZW5hYmxlZCINCj4gYml0IHNldCBpcyBjbGVhcmx5IGludmFsaWQg
YXMgcGVyIHRoZSBBQ1BJIHNwZWNpZmljYXRpb24sIFNlY3Rpb24NCj4gNi4zLjcNCj4gIl9TVEEg
KERldmljZSBTdGF0dXMpIiwgc28gbWFrZSB0aGUgQUNQSSBkZXZpY2UgZW51bWVyYXRpb24gY29k
ZQ0KPiBkaXNyZWdhcmQgZGV2aWNlcyB3aXRoIHN1Y2ggX1NUQSByZXR1cm4gdmFsdWVzLg0KPiAN
Cj4gQWxzbywgYmVjYXVzZSB0aGlzIGltcGxpZXMgdGhhdCBzdGF0dXMuZW5hYmxlZCB3aWxsIG9u
bHkgYmUgc2V0IGlmDQo+IHN0YXR1cy5wcmVzZW50IGlzIHNldCB0b28sIGFjcGlfZGV2aWNlX2lz
X2VuYWJsZWQoKSBjYW4gYmUgbW9kaWZpZWQNCj4gdG8gc2ltcGx5IHJldHVybiB0aGUgdmFsdWUg
b2YgdGhlIGZvcm1lci4NCj4gDQo+IExpbms6DQo+IGh0dHBzOi8vdWVmaS5vcmcvc3BlY3MvQUNQ
SS82LjUvMDZfRGV2aWNlX0NvbmZpZ3VyYXRpb24uaHRtbCNzdGEtZGV2aWNlLXN0YXR1cw0KPiBM
aW5rOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hY3BpLzg4MTc5MzExYTUwMzQ5
MzA5OTAyOGMxMmNhMzdkNDMwQGh1YXdlaS5jb20vDQo+IFN1Z2dlc3RlZC1ieTogU2FsaWwgTWVo
dGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFJhZmFlbCBKLiBX
eXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9h
Y3BpL2J1cy5jwqAgfMKgwqAgMTEgKysrKysrKysrKysNCj4gwqBkcml2ZXJzL2FjcGkvc2Nhbi5j
IHzCoMKgwqAgMiArLQ0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9idXMuYw0KPiA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQo+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvYWNwaS9idXMuYw0KPiArKysg
bGludXgtcG0vZHJpdmVycy9hY3BpL2J1cy5jDQo+IEBAIC0xMTIsNiArMTEyLDE3IEBAIGludCBh
Y3BpX2J1c19nZXRfc3RhdHVzKHN0cnVjdCBhY3BpX2RldmkNCj4gwqDCoMKgwqDCoMKgwqDCoGlm
IChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gLUVOT0RFVjsNCj4gwqANCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFkZXZpY2UtPnN0
YXR1cy5wcmVzZW50ICYmIGRldmljZS0+c3RhdHVzLmVuYWJsZWQpIHsNCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHByX2luZm8oRldfQlVHICJEZXZpY2UgWyVzXSBzdGF0dXMgWyUw
OHhdOiBub3QNCj4gcHJlc2VudCBhbmQgZW5hYmxlZFxuIiwNCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZpY2UtPnBucC5idXNfaWQsICh1MzIpc3Rh
KTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldmljZS0+c3RhdHVzLmVuYWJs
ZWQgPSAwOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyoNCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRoZSBzdGF0dXMgaXMgY2xlYXJseSBpbnZhbGlkLCBz
byBjbGVhciB0aGUNCj4gZW5hYmxlZCBiaXQgYXMNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqIHdlbGwgdG8gYXZvaWQgYXR0ZW1wdGluZyB0byB1c2UgdGhlIGRldmljZS4NCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLw0KDQpzZWVtcyB0aGF0IHRoaXMgY29t
bWVudCBpcyBmb3IgdGhlIGxpbmUgYWJvdmU/DQoNCnRoYW5rcywNCnJ1aQ0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2aWNlLT5zdGF0dXMuZnVuY3Rpb25hbCA9IDA7DQo+ICvC
oMKgwqDCoMKgwqDCoH0NCj4gKw0KPiDCoMKgwqDCoMKgwqDCoMKgYWNwaV9zZXRfZGV2aWNlX3N0
YXR1cyhkZXZpY2UsIHN0YSk7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoZGV2aWNlLT5z
dGF0dXMuZnVuY3Rpb25hbCAmJiAhZGV2aWNlLT5zdGF0dXMucHJlc2VudCkgew0KPiBJbmRleDog
bGludXgtcG0vZHJpdmVycy9hY3BpL3NjYW4uYw0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IC0tLSBsaW51eC1w
bS5vcmlnL2RyaXZlcnMvYWNwaS9zY2FuLmMNCj4gKysrIGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9z
Y2FuLmMNCj4gQEAgLTE5NjIsNyArMTk2Miw3IEBAIGJvb2wgYWNwaV9kZXZpY2VfaXNfcHJlc2Vu
dChjb25zdCBzdHJ1Y3QNCj4gwqANCj4gwqBib29sIGFjcGlfZGV2aWNlX2lzX2VuYWJsZWQoY29u
c3Qgc3RydWN0IGFjcGlfZGV2aWNlICphZGV2KQ0KPiDCoHsNCj4gLcKgwqDCoMKgwqDCoMKgcmV0
dXJuIGFkZXYtPnN0YXR1cy5wcmVzZW50ICYmIGFkZXYtPnN0YXR1cy5lbmFibGVkOw0KPiArwqDC
oMKgwqDCoMKgwqByZXR1cm4gYWRldi0+c3RhdHVzLmVuYWJsZWQ7DQo+IMKgfQ0KPiDCoA0KPiDC
oHN0YXRpYyBib29sIGFjcGlfc2Nhbl9oYW5kbGVyX21hdGNoaW5nKHN0cnVjdCBhY3BpX3NjYW5f
aGFuZGxlcg0KPiAqaGFuZGxlciwNCj4gDQo+IA0KPiANCj4gDQoNCg==

