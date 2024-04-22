Return-Path: <linux-kernel+bounces-153700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEB28AD1D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627581C20B24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31603153806;
	Mon, 22 Apr 2024 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLyXb78H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03FF14F11B;
	Mon, 22 Apr 2024 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803004; cv=fail; b=PXn4CWfgy9qfnIoPIX4J829q4OjuJvDXXE6x6genbaTCCTIscqyXZ6FSrgWKrIVwYx0iCHkEhJ0hkVei4zkNS00hxKxRCcqK2LPgIlfh+THOpBdzCmVY5UotSUIID4uI79RdDeHWvw9q7gDqO4UktR07TL7JgVqcbuQtHCBC5es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803004; c=relaxed/simple;
	bh=OpQzuk54aC5r4xnOk2pSoO+uTbQQ2dr+Vzecychc7dY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pd1qAx931S3FA1Bir710vTW9G3Tw8o4QMrpwKenACUoY+wjJfE4Vhk9UEMh0pq1i0Ry15OFM6rXzxPkejX+AriAtF0Aglef0lLSZHC/Yx87k10YWZg04YeSaL8t23/y9wa11iMk6vhvAlQ+ExIRiThsJuG4iwyVpO9c3slTNq0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLyXb78H; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713803003; x=1745339003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OpQzuk54aC5r4xnOk2pSoO+uTbQQ2dr+Vzecychc7dY=;
  b=JLyXb78H7Mx9nMD63t6B5ks3sqrT/p2WqIe0x5OmeQEkVD77HcCghZPD
   UVHT6lmdpnD2oFve/wTtLqStdPtsRaanXgSERVrMzX+NINWTefpGSvHkL
   Q4vim0Qw1DlvsgY6Tr1xL61Naxry6Y0wOoa47lL2B91m8F5oq20UiQKNh
   iENLiqzJ1gfUTWBYJoHYy7nQ2zAs6RePpTQa1A5qoQKVodVHoVWjfKX70
   5hn8xaYALjLd1vsDiUJmvLf0wPgsLJU7tmGnupjJTn7Zmsv3XOyxw8IZZ
   1tFKq3xzE2YWnoCzgBt1a1FOjYYVPj1dpvaKjiMXgLR9I16WTqMGGR2Lr
   w==;
X-CSE-ConnectionGUID: cSdZAAMyTNuHNxoH2+5GKw==
X-CSE-MsgGUID: qX07ljR/SjeXozzphpCpDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="34748951"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="34748951"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 09:23:22 -0700
X-CSE-ConnectionGUID: dtiuqTZTTf6lxSF9q/V/Jg==
X-CSE-MsgGUID: fEyFk0TDRXyDmwoHl0C1Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="61509697"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 09:23:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 09:23:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 09:23:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 09:23:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMToCzFDOf8HuJVZakV3nycwlsm8TWdxxU1zn+4444BcCkE1WG8oGAhVoxSZph4Z5bQ9ry/bBWB95RRzEERnfdF74+2j6CrtffwRonBrITk1pNaKrYibLxyQsmQtCCamvB/YbfWKuQvdNSoojo/uBs09kOrXnGYx14LnyjSEwKSUYL+PjxLMyHciYiYBphFCA2f01Sk/IpnzTEQjHTp+KonDwfjFOsxVf5Wmky2ohIB3yjfhhh/eTTbxIC4T73suXlGRJkdpTZ1aWGOGhEA3ahIxYFPwjVJ2cOh84HqekGDfkM/7A6nue1o8U8w0jRe/liQP9q1ET9gbrGS8N7r91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpQzuk54aC5r4xnOk2pSoO+uTbQQ2dr+Vzecychc7dY=;
 b=kzoyLgkenDnP4Ewfm/kEdKWJHdRY+8zo2qxM+LFfWqlAXPiAVLVXZOnBiutuuXxaeLXP4q81FCMA3DuciFR92Xw30DrlVJ2g2FUdFoOOXPa+lRWn2cPeML9ub3Yt88rSmNBfrmO0UCz/s63vD5gJ9fJ1usOAinawO7Z8jmlOuJxun82OlhplWlVU4K8Hh5fZMW0ub8+HPXxxdcand6042Jeib8A2s/JyPnMEDQ6Y69NTEV+rZ5hV2rFwSa9/YDQOq0plWzcgU4/Tw2MWs/dBz7P55xMGcEd0auyC2x1LsGtNpLAzD8QJKr2IIRx1vuT4JbYDez72loXvCtKkOrcZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB7544.namprd11.prod.outlook.com (2603:10b6:510:28d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Mon, 22 Apr
 2024 16:23:17 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 16:23:17 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Pandruvada, Srinivas"
	<srinivas.pandruvada@intel.com>
Subject: Re: [PATCH V2 2/3] powercap: intel_rapl: Introduce APIs for PMU
 support
Thread-Topic: [PATCH V2 2/3] powercap: intel_rapl: Introduce APIs for PMU
 support
Thread-Index: AQHaiWg0oypv/wNTnU2s511hM6NRXbFq+X6AgAEDQACACJMygA==
Date: Mon, 22 Apr 2024 16:23:17 +0000
Message-ID: <ea096c2ff7699beb3a9a2ad1742653dbbe12a0fc.camel@intel.com>
References: <20240408035141.248644-1-rui.zhang@intel.com>
	 <20240408035141.248644-3-rui.zhang@intel.com>
	 <CAJZ5v0hDdTS++iWLYDnoVotV3=e=Vn2di4EjUBJzHiNLzrbaig@mail.gmail.com>
	 <0e345bdd91f90d1141e4114f55a8626fd0fad212.camel@intel.com>
In-Reply-To: <0e345bdd91f90d1141e4114f55a8626fd0fad212.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB7544:EE_
x-ms-office365-filtering-correlation-id: 9d1c9f16-8c1a-4a6a-d775-08dc62e88454
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WkMwenBKUGNyTC9say9McmgvOVVwRlJvc2cxbXNsckErUlk1RVY0amxoeDEz?=
 =?utf-8?B?M3c2YmorSFVGcUVqcVZIaCtzdWJRZUlWYnp2a0gvTG5YNUkvNnBuMUdrOExW?=
 =?utf-8?B?V1RQSlJJVUZibStuMlI3dmNya1g1dDhraEp3RU8yRHlrU3BtcDNMd0gyRjBO?=
 =?utf-8?B?aERSdUZ0MTdha3FWTytTOEFtc3lGYlgzaGsxNUIyUERvYUdDL3luR0trTTl6?=
 =?utf-8?B?aXJNNlpVbDA3SlIzQkJqQThWQmQ4SStCNk81STlFdENGWGcrMmZBSzBMTHdk?=
 =?utf-8?B?ak9lZTcrZDR4bXFqRTBtMkpxV2llcEVkbExyVkkvRHpmZ2VDR05ONm13Vlc2?=
 =?utf-8?B?TUgzMDNMWXpQcWhqdGlQWjhyY3MvZC95TmMvNjdmZDBURnVRREFBVkUxSnBY?=
 =?utf-8?B?TUxiSWZ0SGhKU2pnZW4vazY2SEVWVXRDSUVFbjlvVEZVK1ZsNUpZOUV4aW5T?=
 =?utf-8?B?Uk1xS1FvRUlZd1V0UUJTVC9OSXNRTmJzZDlRMmlrWTBxUFl4Tm1WN2dJV1Jl?=
 =?utf-8?B?dVBDNEgrWkVIYXN6M1IrZ2Q4c0ozSkdvM1RFMGdYNEVhZmU5MDVWSGFsSzRV?=
 =?utf-8?B?KzNEQ3VhenJKbGRXWnJlajh5c3FLb0pZL3EwekhhRnY0MGpSZWdQNVNqN0JG?=
 =?utf-8?B?L3hiNmJ2WVk3NGdZVjhyMUFJVWhJcE84WDhONzEySXU1RzgranA1WmFNV0xB?=
 =?utf-8?B?NHlaNW03OUpmM2NEbnBUYjhJR3ZmVy9zRkhqTHlramdYbXg3cm5XNHA2Zmox?=
 =?utf-8?B?enJNWW5FRzg1Sm5PR2k3SGFaNnprTWUzZUpCeXZZVlVyVmhWOWhUMzBEbEdS?=
 =?utf-8?B?U2tOeWFrMWlidk1WSWhnd0FTSUJlU1J3YkdpSit0ZzJlR2t2MVRRUENuRm02?=
 =?utf-8?B?cVZ5K0Jyc0VZdnplZzFPNTFNa1NFa0tNMkdFTFZRTnpKZTVuUXpvVE9Ebk9N?=
 =?utf-8?B?NXNxdm9BUFlsSU5welhCbGtlUlpPcGNlRkhXOVVQS3hKYkhuUEtkSnJYU3dr?=
 =?utf-8?B?SlcxK0ZlU2Zuem94VkNGQytJMnB3UlVYcUtqakVZckh2Mk9CVnVCNEdCTHkz?=
 =?utf-8?B?czNEZUNZRmJ1cmkvdjVaNlNaYlFsbTNjbGtnSWJJUGRSNFduY2tFWmtHd0FH?=
 =?utf-8?B?UW5IWEFNcHZxL0YzRWdxeUNIWTMybm5QeEMvL3ZqREhaY3A0UDZhb05sZ29j?=
 =?utf-8?B?ZU1PbEIzaTNtWVJBaUdQYThrY3F2a2RXSW1EVk1oRlR2elovTDBlVnlyNXpP?=
 =?utf-8?B?aFM5WTNnbmFYazZpaDZlZXBwcWdVUzk0TU93NHNKUUh2bzA3T1FybmJ2MVhs?=
 =?utf-8?B?cEdXMENBUWNMM2JUTU8rZURHVG1jakJUcWN3cTUxbno5aitFaERwWENGdEZG?=
 =?utf-8?B?WVhqbXRKd3l6QkJGNEI5dFgraUwvWktmaTZGYklHTUsySkpUSlZQN3IzSUZx?=
 =?utf-8?B?a0wyNjg0Vk00aVRMbHFQK2VNS01mMmtSdTJmQmFvTURpVFl2aGxWU1hlS2dV?=
 =?utf-8?B?SFF1blhDejh1dkp6T1pDTnhnblBhcTBVQ21UdVFvc01BY2UxTGs1akVtTThJ?=
 =?utf-8?B?QlBXRmM2eEI4NnZibUVyVHJDZjNhVVVkMHpOS3NtMGNBSGlDWkJwWjJQNHdD?=
 =?utf-8?B?OWJabTR6R0s2ZTFoMTJTZ3UzTjRTYUxwb3pKanZkVnkwNnBVSjRUa1hZaU9I?=
 =?utf-8?B?ZjBUU1JFaVRyMm9NejZlLytvTWYyL0h1aHR6RjE2OXd1NkdZLyt4RWFucXI2?=
 =?utf-8?B?a0NRVE9CTHR0S201bVNpNTZkeEZZZS83dE5vaEl2R1lnREVsMFN1VDl3VEZZ?=
 =?utf-8?B?aGY2MDJoS01pak1KTkQxUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDFnTHdKMUduRUlBYXdRV0Ztc3BzQW1wcHVuVmNTWXhFVW1WVi83RTE5UndW?=
 =?utf-8?B?bWZleGhNSUd2b1VqMkVOTEl2M2hySE1xczRFUWN0ZVQ2SGd5bmZjcC92cXdD?=
 =?utf-8?B?TXNlRHp5d3doVGl1N2RLTFhBSnA4anVBMmxtajFEL1RSY1A0bUkwY2dzSHU1?=
 =?utf-8?B?R1k3YVExVC9tK1NBS1RHN042a29ZS1J2UCtVMlVKTld6S1ZoWE0rYXQ3WEtF?=
 =?utf-8?B?ZUN2aUdqSE91a3dVNUw3dXBYY080SXViQ3dIekJjMVA1UGxOaktBUkhySW9j?=
 =?utf-8?B?cUZrRnE4bU5NL2NsWk1UV2JNUFFoN0xDN1poWmdValV0MWFXWDIxa2d0RVlk?=
 =?utf-8?B?YzNYTE5aRDgxdmhyN0VwTFg2VHRxOTFXZnJNTHNwc1hPS3l2bTVXQlcwRGxs?=
 =?utf-8?B?ak51RzRyVkNTVEdSMUw1cDRENFdsTGJ3V0VjNk5mTVBtT2UxUDJaN1JabXl2?=
 =?utf-8?B?b2RNdlZJb05MYTI2VkRHUWc1cFZMcnhIZmJyNVJqUnY4K2p3VFNlOWZ0KzZ1?=
 =?utf-8?B?enhmWjhVN3R3SzBNWm1sRDdReVNNQVA5S3RTVi9za0J6U1lET3d3Z0VNOFN2?=
 =?utf-8?B?dEdVcTV1UTA1Z0VnNHBFVlAwNmpOdllTMElPemtlcmFjWGlzdGVCRktKbzNO?=
 =?utf-8?B?bm9rZmZuYXBJTTQ4RGlNaENXZmJqWGhXemxRS0RsSndWVlRpaFp0MUs0MWVk?=
 =?utf-8?B?bE5IUm9ackRXUk51MHpYd0VOZmZhd2xtdU9SUkVhMzd6VTB3a2JLV2twZTFl?=
 =?utf-8?B?U0dBS2wrKzZBek1QbzE1R0FwM25wSHBHOTZ5Mnd6dDVXS01hclZLM1F4Rk9p?=
 =?utf-8?B?UEdjbE43ZzBFblR4Z1RJZk9Ra2Q5Q2NXQzkwQnM4MjBjOEVSamcxT3pYNzlS?=
 =?utf-8?B?blVRL3BkaTFQTVAxWWVPTUxBSkhMZW04MHZQQnViOUo0bUZ1clRCSUNjMnRX?=
 =?utf-8?B?MGcrdUlXV1M5YjVoZlB6V2FuNlFmd201NXh0YThUZm5wNWtvaDZ1WDVtQnhD?=
 =?utf-8?B?Z29GZ2p4TlRKYzdDVTVqK0JqSDFFVG1QWkJYM0VFWTlWSUR0Z1BCUDJwcm5q?=
 =?utf-8?B?TXB1NjRnUVc1clZaMy9MNitMRmxJSEJsYmZJWVlxTE1ZQkZnK2FnZTB1N0pt?=
 =?utf-8?B?Tnl2QkYzZHFxVGROZnIzTWhwa0dGZ3NwMHl0d0VQcmo1TXRhZW95eWpyeElE?=
 =?utf-8?B?RmU2UlFQR0djSmwzMnNTSEwyeGFVRVNXK1M5R2l2QjI1eENXZDMyUkY4NTMw?=
 =?utf-8?B?b2pFK1ZmYzhvUjhsd3QrZFNDZVZzNVNqdTk5TktRTXNQOHYxcWpYTGhCejlk?=
 =?utf-8?B?SDNtTURleGcrcStiMEp0SGJQZmNoSm4vNzc1S2tJM3FnM3BNSEFSTzNtYmlT?=
 =?utf-8?B?aGhSTzllZzVnU2xZdXc2cVFQaEtIcFJRVUE0NVl2Vmp3Z3oyZ2RJT0wzRkVY?=
 =?utf-8?B?YXJPanU4ZU9aMHBiSEROeWdYakdtZWNjcXNzUHdKanA3TzFMSmVNd05iQnR0?=
 =?utf-8?B?WUV6K0N1SG9TRTJaR2c5YWE3dXhhUkRFcy9oSFpMdWQ5M3JaUDRqVkpudkJZ?=
 =?utf-8?B?aHRKcUtXM01wRjhXRXMxejJ1Z2JlaC90dXVpN08zS1dWcCtJYWZ2dVVxdnY5?=
 =?utf-8?B?WUs2WE5vb3lKMFd3OEpNb3p0ZStTRkg1aC9vVTh1YXZxNFJYOGszSHpPM3Yw?=
 =?utf-8?B?bWNnZld3RVBIYU9CZFhrOUlUdU9hY2ZUdS9SazlHdlZNM1owcEQ5aktnQ0dr?=
 =?utf-8?B?K1QvUk44R3V6dUUvNTlCVlY0RnNjbEtJYlNwM1VyV0FFRFh2WGtweDF3N2R6?=
 =?utf-8?B?dEFTOUVwZlJJc1RUQ3dvQUhJZGRqZWNKelR2N1NRdXNCR1BsaFNEUGc3bUFL?=
 =?utf-8?B?ZXNxdG5nUWtieUpmRnNHVzNJc09iWDltSVVOTVlWVUN2eU15QzBWRG1pTXNp?=
 =?utf-8?B?eVp3M2NlYk5PT2lJVExZUGdJQUJVTUVDNkhjTEFCbUoweHhqdVZOWEg2RThq?=
 =?utf-8?B?ZnNpMVNGNlFnZkNGRDVUY1VmWXIrU1Jua1lBZ1p0MTEzMDRDU1gyZC9IQlNh?=
 =?utf-8?B?Q3dzR2wvUzNuVjhrME1GMlUwWExGbkczQW9zS2RnSE9xQURWYjBkemlCYW1L?=
 =?utf-8?B?ejMwdU9jZ0x6SmJ6elFBSVdSV0xQS3ZZbklMZlBreThrZUR4V0ZyMFpKUFF0?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9024F503DF108140831507CF40273882@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1c9f16-8c1a-4a6a-d775-08dc62e88454
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 16:23:17.1785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NePGte0FijUaG9Ju5l1F3QPKL4TlJs1Dtq0POC0/TgLk56OVnL/cw8NQnd8NRTm/tHmP5FyZCx5bSQbsvIpuZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7544
X-OriginatorOrg: intel.com

PiANCj4gPiA+ICtzdGF0aWMgdm9pZCBfX3JhcGxfcG11X2V2ZW50X3N0YXJ0KHN0cnVjdCBwZXJm
X2V2ZW50ICpldmVudCkNCj4gPiA+ICt7DQo+ID4gPiArwqDCoMKgwqDCoMKgIHN0cnVjdCByYXBs
X3BhY2thZ2VfcG11X2RhdGEgKmRhdGEgPQ0KPiA+ID4gZXZlbnRfdG9fcG11X2RhdGEoZXZlbnQp
Ow0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoCBpZiAoV0FSTl9PTl9PTkNFKCEoZXZlbnQt
Pmh3LnN0YXRlICYgUEVSRl9IRVNfU1RPUFBFRCkpKQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuOw0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoCBldmVudC0+
aHcuc3RhdGUgPSAwOw0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoCBsaXN0X2FkZF90YWls
KCZldmVudC0+YWN0aXZlX2VudHJ5LCAmZGF0YS0+YWN0aXZlX2xpc3QpOw0KPiA+ID4gKw0KPiA+
ID4gK8KgwqDCoMKgwqDCoCBsb2NhbDY0X3NldCgmZXZlbnQtPmh3LnByZXZfY291bnQsDQo+ID4g
PiBldmVudF9yZWFkX2NvdW50ZXIoZXZlbnQpKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqAgaWYgKCsr
ZGF0YS0+bl9hY3RpdmUgPT0gMSkNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGhydGltZXJfc3RhcnQoJmRhdGEtPmhydGltZXIsIGRhdGEtDQo+ID4gPiA+dGltZXJfaW50ZXJ2
YWwsDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgSFJUSU1FUl9NT0RFX1JFTF9QSU5ORUQpOw0KPiA+ID4gK30NCj4gPiA+ICsN
Cj4gPiA+ICtzdGF0aWMgdm9pZCByYXBsX3BtdV9ldmVudF9zdGFydChzdHJ1Y3QgcGVyZl9ldmVu
dCAqZXZlbnQsIGludA0KPiA+ID4gbW9kZSkNCj4gPiA+ICt7DQo+ID4gPiArwqDCoMKgwqDCoMKg
IHN0cnVjdCByYXBsX3BhY2thZ2VfcG11X2RhdGEgKmRhdGEgPQ0KPiA+ID4gZXZlbnRfdG9fcG11
X2RhdGEoZXZlbnQpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGZsYWdzOw0K
PiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoCByYXdfc3Bpbl9sb2NrX2lycXNhdmUoJmRhdGEt
PmxvY2ssIGZsYWdzKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqAgX19yYXBsX3BtdV9ldmVudF9zdGFy
dChldmVudCk7DQo+ID4gPiArwqDCoMKgwqDCoMKgIHJhd19zcGluX3VubG9ja19pcnFyZXN0b3Jl
KCZkYXRhLT5sb2NrLCBmbGFncyk7DQo+ID4gDQo+ID4gV2h5IGRvZXMgaXQgbmVlZCB0byBiZSBy
YXdfc3Bpbl9sb2NrXz8NCj4gPiANCj4gPiBXaGF0IGV4YWN0bHkgaXMgcHJvdGVjdGVkIGJ5IGRh
dGEtPmxvY2s/DQo+ID4gDQo+IFRoaXMgaXMgY29waWVkIGZyb20gTVNSIFJBUEwgUE1VLCB3aGlj
aCBleGlzdHMgZnJvbSBkYXkgMSBvZiB0aGUNCj4gY29kZS4NCj4gDQo+IExldCBtZSBkb3VibGUg
Y2hlY2suDQo+IA0KDQoNClJBUEwgUGFja2FnZSBzdXBwb3J0cyBtdWx0aXBsZSBldmVudHMsIGFu
ZCByYXBsX3BtdV9ldmVudF9zdGFydCgpLA0KcmFwbF9wbXVfZXZlbnRfYWRkKCkgYW5kIHJhcGxf
cG11X2V2ZW50X3N0b3AoKSBjYW4gYmUgaW52b2tlZCBmb3IgZWFjaA0KZXZlbnQuDQoNCkFuZCB0
aGlzIGxvY2sgaXMgdXNlZCB0byBwcm90ZWN0IHRoZSBwZXIgcGFja2FnZSBkYXRhLT5hY3RpdmVf
bGlzdCBhbmQNCmRhdGEtPm5fYWN0aXZlIGZyb20gY29uY3VycmVudCBhY2Nlc3MuDQoNCkFuZCB3
ZSBuZWVkIHRvIGRvIHRoaXMgaW4gdGhlIGhydGltZXIgaGFuZGxlciAocmFwbF9ocnRpbWVyX2hh
bmRsZSgpKS4NCg0KVGhhbmtzIGZvciByZXZpZXdpbmcgYW5kIHBhdGNoIFYzIGhhcyBiZWVuIHVw
ZGF0ZWQgYW5kIHN1Ym1pdHRlZC4NCg0KdGhhbmtzLA0KcnVpDQoNCg0K

