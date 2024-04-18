Return-Path: <linux-kernel+bounces-150176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7868A9B52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6A11C23254
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7310815FD16;
	Thu, 18 Apr 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0H0yVrz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B953AEECF;
	Thu, 18 Apr 2024 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447141; cv=fail; b=ljMUTHlae0ahAhtLPXpsLCfa93BVlwF862RyTyKOjcFMuYcFzP3qDJVMgb6HTBYl5cBjR0iUHs4ALeAqyEtH9Gf/jrHE2agcmbxvzPFStmKtUAYcN5FGpD/mGrZnnW8ssfbRyBybJMY7frLegDmlZmL4XANHCbo9bzYFaGthLRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447141; c=relaxed/simple;
	bh=09bXZ/QKxY9hrMjqRVCjiCmbylq1eoGxg3rmK3H7REw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i5tl2C0bt6Mcz7diBcQosa8YA2Sxm3cVYff9lFriRGK7eKOz/2GAZqQNQN0/KhwKBXO55RUdWnQ91/n+xSpeWVYMoTHHATPcxghZLf2/CyoOOn2RWvT0sldYy5K2IzlsKS0LFZY0GwBKIyjzFW/jrAjBNdTSn9pkYJDfIdgmYhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0H0yVrz; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713447140; x=1744983140;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=09bXZ/QKxY9hrMjqRVCjiCmbylq1eoGxg3rmK3H7REw=;
  b=Q0H0yVrz0NJEGLh7Logq87DwQ65tBMiKZ2QoExYEZnL2GiFatgo4vQz2
   Ukqut63w16+u9NUqJJQuknvJyH8/UxcNw5T1of3+MZgOp8D2+Yk3OTEv5
   dhSXDuBrEuQAH1OSfOuiNRhDlB6WL2lyUab+NAr/eDI/+KzdCOIq6Ssac
   Y2dxSHu4dQiEFfkOlF0hfm1PBlFXbGlUurf4CjcOQHQii5VGbDrm7RqCi
   8CrcrfMqZawzYlsi7SnMJH4LdOElmTxvhPCqY4WHcp2VkziiWYiCsGUMo
   XkXEZIRH+YI7ZC0T1He9pVQ/5bzY5Y2d954+xCop+UX8y5czYTH2rTr7r
   Q==;
X-CSE-ConnectionGUID: EflES16qRXOaeldBYUA2FA==
X-CSE-MsgGUID: dQch4f/MRmKaXo8SVUv6Xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8827848"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8827848"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 06:32:19 -0700
X-CSE-ConnectionGUID: 70dyG8l1TN6iGsXoxat3AA==
X-CSE-MsgGUID: fKRRbGAzQrKylw4KAaPWkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27649782"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 06:32:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 06:32:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 06:32:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 06:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeQDNyZZoFTYrDH0+t76SDqWDpCcQPL1U1etiS2BNIcBuw6PPu3wBjAuMv+3Z6jYmPWy0FQli98WXboAnSAXJRAbj2xFq8aR9kX3q8S/muyd15F5sxts2MYrK1SJTDKAIWswurlA1PZ87XWUkZSSWtgROQlLuPq4cM7Ls5VNMVYqaxTekS3r0qwpkp+CDtnd1SmwUnDGGF7x3cKY1AeCctIJLMxoY1X7nIfbQ3bZItyJqniGonwC6ndajiY1AkHfQ9/hkbmu60pTuk7WI6Ky9nGM7Txc+eA49AucCsTBzTeqg1OwFQ3guhiJKoBwbpYlMej5d5IuyjuYzepYtrdOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09bXZ/QKxY9hrMjqRVCjiCmbylq1eoGxg3rmK3H7REw=;
 b=ULY6rypnXZ1ruADeQfAT8xV8iZl0rXsd7TpOApViRhwJPKvEDFksorDsd92AisEs8INVFz3jhPW8USstl2e+j9JOhHu8cXm1TAfX3tmDGzlgrOGXQ9ARvYWztei9FDOB4OOCKrim1CxBGmTQx2oVTsZlXvGvmLdaz+FQ4sf6uF+FY3S16zRakXnBRceefq+xE6MQymLMO88RvtC5K+leM4scvq8U/5x6lj3wVIku7/at6b72NOXTMKH3wfwmsTiSeZZWzTcikSBL5ssYwWtGw2Nh9NACknFIToKZF083uFIcHFOX6wTp2IBVjKjgsPyOwyh0a8exQP3HTbVY7ToihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5330.namprd11.prod.outlook.com (2603:10b6:610:bd::7)
 by DS7PR11MB6296.namprd11.prod.outlook.com (2603:10b6:8:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Thu, 18 Apr
 2024 13:32:15 +0000
Received: from CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::5627:e6de:5e36:aacf]) by CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::5627:e6de:5e36:aacf%6]) with mapi id 15.20.7519.010; Thu, 18 Apr 2024
 13:32:15 +0000
From: "Winiarska, Iwona" <iwona.winiarska@intel.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>, "Luck, Tony"
	<tony.luck@intel.com>
CC: "patches@lists.linux.dev" <patches@lists.linux.dev>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>
Subject: Re: [PATCH v3 50/74] x86/cpu/vfm: Update drivers/hwmon/peci/cputemp.c
Thread-Topic: [PATCH v3 50/74] x86/cpu/vfm: Update
 drivers/hwmon/peci/cputemp.c
Thread-Index: AQHakEQwGnZ4qOKG40CUyk3on+cyGbFrfA0AgAAIgICAAAjkgIAABZ0AgAJ2DoA=
Date: Thu, 18 Apr 2024 13:32:15 +0000
Message-ID: <7cb09d67409c94284928243d8ffb1f8a3128d849.camel@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
	 <20240416212216.9605-1-tony.luck@intel.com>
	 <5869d164-25c4-42e5-bf87-c4aeeac57388@roeck-us.net>
	 <SJ1PR11MB6083D0DFBC7DE286F986A453FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
	 <8690bcea-3ff4-49f1-a671-16583b8d241e@roeck-us.net>
	 <SJ1PR11MB6083C8D12885057BF3A0A6AAFC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083C8D12885057BF3A0A6AAFC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5330:EE_|DS7PR11MB6296:EE_
x-ms-office365-filtering-correlation-id: 7f297a18-20b4-4d05-cb02-08dc5fabf642
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 566CY89UfhoZAJfyoqOMntUei7Gl5QJrs2LsicUYbG6m5UMuNkpRUs8Brhbf/2EEM/KDwcB/nHqS09bk/cONN4YrKuqiDkqLmy5C2A0UrLaClYpZkTR1IzJjN9vwVd3B9Ug3/p7rBVMIJVKEU1y5APQMxETNaA4b2TWnvdISvWu/bloMbkqgxx9tDhemjj/D7dbgkesHFKwO3o6jqGgvyq4+MqM3Oio+41v2mm4Mn/f1A8Sg5QLAb1EeUhLN4F0ltyJF4AaisH6d4+2A9YbAX3a78HjD/+7lGUFjmGDiEKG2iCAQIJ1uTw7cyF9jtolZLnCuNnu00egemF/hQElt+/AIt9HZvn4IZU4BPjlaSREVqPaP3aEq0QgAeWKPx4QYsIbHIq9ReRY6iupk7H0sVlRkTCp8PkD1vvdtMoutFwc5TK068OQL672zOskjlnqJRBvSv5yyNPWcB+zDRVJ2mEUJXCrbjDtS4bThiL7epfTKAN/4u4Qy8iP7eQiZDRb+o7+45AyQJ1hWjWDhIBOjVRWttmcqhtWht7vyLGHY1WlVE1R01NoQqDcYCcEYmmjUMdXKXI9+xSTAA7xtdkCvYDZphDs+VTtlm0ddujWJYgCMoOQoKBE4wlMyNjAqvTNLKcJL1oq0ibcy76Kl1zWw57GXvu8DnnkN++mpObvwMX2HHP0/HTBH8oK59LlwML2fByQhG1rRQEnsIP4GuD/qNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5330.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2czczBxckliTlAveGc4ektvd2E0NGxUUmxYMGRCNW9ERFdQQUdjYm5mUUpK?=
 =?utf-8?B?RytVMXpEUVFvb3IxMGVmTE1IZ0RGQjZ0OVZhOFk0V2FBMFpXVFp4dndnZzZv?=
 =?utf-8?B?WE5jTTgxNmVhczkxTEUxMThUTzNFQlVkOGpXd0NFZ2ZyeFNlQUU1UUhVa3pG?=
 =?utf-8?B?RVNpTzVKMElPdFdCeFI4NXJ6OC9mbkpEMFVjM2NSU0xGaE5XSUVWdFkvYnJn?=
 =?utf-8?B?MHBFQ0FzUzg2ZHFDSDNqWDZwY1ZOZmx2bWNWT09zTjE5RitoZFd6a1pGLzJ4?=
 =?utf-8?B?MmI3Z281MGNDNEZFNXk1WUJ2Vzk5SzFmdEhUZzc5Y2NSN2RiUE5FbldMei9p?=
 =?utf-8?B?TEQvUzU0YTFCd3NHbEk4SHJ1SXR6UHJteGZiQmRjSVhISUZ3TXplUWhkUGFx?=
 =?utf-8?B?TXk0MUlVNTlkQ3lwTklFWWtITGZTRjh5YXYzb2c4YVZLTU4vL3M1eWFZZFNw?=
 =?utf-8?B?aU1sQ21TRTNkU3RyWHA2anBicFFyZmx5MVpacTZ6dFFzNnhJS1FoeWNiOWsz?=
 =?utf-8?B?dXRRb1dhcWZGeDFQUEFISERQb0VsWmE0akthY1FRWElXWVZ0eW4xR2xPWDlJ?=
 =?utf-8?B?akdRRHR1QVZRRjM1ZUM2ZUNueTBxN3VDenNRL1JqYlRWUElHMVlYQll6NmJO?=
 =?utf-8?B?eit2ZEpCU2Rramhya0R1WVgrWGtoeUhwWHdvR1V6T1JSdUtzNWtPZUliMk81?=
 =?utf-8?B?KzlLbUdtSUZ0bmZEVjRwbFZsdW9HL1pPTlgrU2tWeG1qTWJYcEUwT2swejRp?=
 =?utf-8?B?ZUF1TU9hTDZpd1pYcHVLT2RUSm54NzloejBhS01hYW9abzBGZWRVVGY0RWcr?=
 =?utf-8?B?djc1a0l2NjIxQWh0R01wSzZtYTJMVUR0eUtWREhtQ29CeDZVWFNKNjY5a3Nv?=
 =?utf-8?B?djR6RW80b1ByUkkvZTE0UEZqa0tpNVc4RlVSWjRscEp3a1N2U1QzWUZkRXVo?=
 =?utf-8?B?bWVZcWY5T3JPa0tJZGd0akxXMitwR0V0NHdTbTk0a2xXOHFJYWZXVVBsdUF4?=
 =?utf-8?B?b1hxOFVrOVZPV1hLYWg3Uzh3M3JSWExJSTJySXdYVGdGbEpQWUNuMzBDQnlX?=
 =?utf-8?B?cjBMdU42K1ZUZm16K1ZLWVhMam9uRTdwakdDdVJJV3BPRzI1ZU9rY1ZXbEYv?=
 =?utf-8?B?dHZYc0FkdmNUcjJXKzd5NjB5dnhuR1RjbmRxSzJ6YW1ZaFg4ZmNUdDZHMUQ5?=
 =?utf-8?B?c2xkdDg2QzNwdDc3eURTSDVVM3NGUWhIZzVXVFhSRm9sMWp6SUljQms4UlA4?=
 =?utf-8?B?UFNWa2lXK3lhSWlDS21zcFVBakxVQWZXYUxzMVM2cHhrRWUxZzJDR1hVVDlR?=
 =?utf-8?B?ajFCR1Z0RXBsb2FDRnNDOTBiNEZlN2w4ZTRYNmtjcWxUMDVBV3d6aU1LMjZN?=
 =?utf-8?B?WEQ5WVpjTVBzU1VSZUNYUTRSZjFXaU5rSlhweVpYMG1kZjNxSE1GQkNWWEt2?=
 =?utf-8?B?RGJud1VJTnJjOEEweXdEMktlWEhVelN3akN0Z1dIbStUMHBiL1E0Z1AyVlV5?=
 =?utf-8?B?dDlPd29ycmxWL2xmNkZTemdKeGJMeklCaDNYTEtHQVROV2dDamZCdDJCWHpv?=
 =?utf-8?B?U0d2YXRCTHRFZ1N4TTE4V1pZdi82Y3UvSnNhazBpbU00dlM3aUNxZmxDU3Qw?=
 =?utf-8?B?NThscmdZU0RGWGI4Z2JGc2U4OU00eGw2cmkwRWh0SGpCZ0FCejc1UW81Wmpl?=
 =?utf-8?B?UERIUnF6cTFDNHhLd0FDdUxxSUZ4QTl6elBLQ3RMWHFHVEh6WTZXV2pnODVL?=
 =?utf-8?B?MlBuRlFSUExoYmlwUkVRM1hSeUR0eXo0TTlzQ0phL0k5c05ZdEVaMFFmUFRP?=
 =?utf-8?B?cWpGcUhiUW8xNXBEL2w5YW1HTHlNd1UvVTQzYWpvc0ZtRGRXNllqeWpxS0Vq?=
 =?utf-8?B?aFgyajFMSTVsaUwrQzZMenV2Y2JBbUpEOG44allXelc5ODhtSCszZmF6Vm5h?=
 =?utf-8?B?ell3Vmc0SFZoVFVIY0pvZm1WbFVHK3JqNytjT3kyV0N2OTQ1ZHZXYXZOYWNF?=
 =?utf-8?B?RmFCMFdzaGN0UEpkNlVnU3dSTzN5TFJBTmM1VG9CaTN3clVMRFdVYkJDT3lQ?=
 =?utf-8?B?V3dFcTlJa0xVeStFcXFlYnU4VHVqdFJRdXFZckhKc1ZyVGFBZ0dyUjZIR2Jw?=
 =?utf-8?B?dzUwekEwVHBBZGM3c1VGV3g1elJ5Sm1iam0rY2poYXErZWcrZmZhZTJEL2w2?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <762B1589573C7544ADA431A79BD3C9A7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5330.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f297a18-20b4-4d05-cb02-08dc5fabf642
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 13:32:15.4810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfN1HK/cQCNivKo9q/PWtJGjQTFJZcNIvlMNIuaGajdayx2AgsU7EqnbbwWKngrx+OetDJda+kcPhxHXiLMGLV2xPAmvH0+XYkj5BvBxKgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6296
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTE2IGF0IDIzOjU3ICswMDAwLCBMdWNrLCBUb255IHdyb3RlOg0KPiA+
IElmIHRoZSBDUFUgZGVmaW5lcyBhbmQgdGhlIG5ldyBtYWNybyBhcmUgdG8gYmUga2VwdCBpbiBh
cmNoaXRlY3R1cmUgY29kZSwNCj4gPiBtYXliZSBpbmNsdWRlIGFyY2gveDg2L2luY2x1ZGUvYXNt
L2NwdV9kZXZpY2VfaWQuaCBmcm9tIGxpbnV4L3BlY2kuY3B1LmguDQo+ID4gVGhhdCB3b3VsZCBu
b3QgYmUgd29yc2UgdGhhbiB0b2RheSdzIGluY2x1ZGUgb2YgaW50ZWwtZmFtaWx5LmguDQo+IA0K
PiBHdWVudGVyLA0KPiANCj4gTG9va3MgbGlrZSBJIGRpZCB0aGF0IHRvIHJlc29sdmUgb25lIG9m
IHRoZSBvdGhlciBwZWNpIHByb2JsZW1zLiBCZWNhdXNlIEkNCj4gYWxyZWFkeSBoYXZlOg0KPiAN
Cj4gI2luY2x1ZGUgIi4uLy4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdV9kZXZpY2VfaWQuaCIN
Cj4gI2luY2x1ZGUgIi4uLy4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL2ludGVsLWZhbWlseS5oIg0K
PiANCj4gaW4gPGxpbnV4L3BlY2lfY3B1Lmg+DQo+IA0KPiBTaW1wbHkgZGVsZXRpbmcgdGhlIGlu
Y2x1ZGUgZnJvbSBjcHV0ZW1wLmMgYnVpbGRzIE9LIGluIHRoZQ0KPiBjb250ZXh0IG9mIGFsbCB0
aGUgb3RoZXIgY2hhbmdlcyBpbiBteSBwYXRjaCBzZXJpZXMuDQoNCkhpIFRvbnksDQoNCkl0IHdv
bid0IGJ1aWxkIG9uIG5vbi14ODYsIGFzIGNwdV9kZXZpY2VfaWQuaCBpbmNsdWRlcyA8YXNtL2lu
dGVsLWZhbWlseS5oPi4NCkkgdGhpbmsgdGhlIHNpbXBsZXN0IHdheSB0byBzb2x2ZSB0aGUgaXNz
dWUgaXMgdG8gcHJvdmlkZSBhIGNvcHkgb2YgVkZNXyogbWFjcm9zDQphbmQgWDg2X1ZFTkRPUl9J
TlRFTCBpbiBpbmNsdWRlL2xpbnV4L3BlY2ktY3B1LmguDQoNCi1Jd29uYQ0KDQo+IA0KPiAtVG9u
eQ0KDQo=

