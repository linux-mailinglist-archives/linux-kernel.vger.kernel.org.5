Return-Path: <linux-kernel+bounces-134706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC7289B5C6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE1E281759
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A7617C2;
	Mon,  8 Apr 2024 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5bMWAv2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71961860;
	Mon,  8 Apr 2024 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712541720; cv=fail; b=hthDM0HcX2jyIJqL0NydgJw4eDYk5uWx08EB8bxjUaN/d419G+Wy4mKEpt9aOlXUMpCd+2NEQoidpsdRHr0iYcibP9cdc5GNZD+9OF4TRqT/VRvz4I6Qg99iGH4BMGQmtxuB4N/MXlLjcM+J6gj2naZdSwWBzwLRPuZqaqVXNvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712541720; c=relaxed/simple;
	bh=hmNd/l+jL2tQxuUia4ODZ9DqPzkjOb3bQgarGizr1mM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AyGvbfF+4Sin5LiFKM4gJiqaRWHAcBi1lR29U/9BETwg6C+/vk/fMBeJ7ISGW7/4eIedbcWVzfnvGLKmuSnLcekZm4VddfCMVO8Jpc6xKfBLoKTqF5BlQts3MnCjONCIFRQIwUmv2fFjDcmLNEHQ59fLC2XKiu7r1ExxNvrbelQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5bMWAv2; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712541719; x=1744077719;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hmNd/l+jL2tQxuUia4ODZ9DqPzkjOb3bQgarGizr1mM=;
  b=c5bMWAv2jfiqOqhykHrz1ahiO8zQh+btjJEkbaLuFcEM/LR2MuiPb4xl
   gWU4bPf8ACOKJ9InnWXDpe/1NUJ0qIo/ynfuaOPgWxuz2k2uI+dn2QjeJ
   lxkY5vNptk0sQE0rNSEURnpBs7o6RjgFx2GIu9na8aRGmi25Dg5qUWHid
   k76Glj22H3m/38ZKNXCcP31cVyFg4MhwP3h9Mski8+Lrj3R96xdP6myrZ
   8hIVBx61tWXujgpCyBo7V97zEPGw7BaoYSdjJ4X7VL5RKGNSrkkc28QUS
   bcbFxWQTyoCpEUzxLsvjobdBFXRLuw5FyDPkoavo2EB23XqgfbV4JO9F7
   g==;
X-CSE-ConnectionGUID: evzQRJvpQ3iv6BnXe7RSow==
X-CSE-MsgGUID: /tipiJQrT5OTRoLsxV+gGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7638630"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7638630"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 19:01:47 -0700
X-CSE-ConnectionGUID: qL4+27tJR32nYCO7JdwfZA==
X-CSE-MsgGUID: cp5qLcGzQ6uX5KXCiML4OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="50935257"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 19:01:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 19:01:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 19:01:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 19:01:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IusL87h5FLRbSFoFI86D581DTD85FNtCMZPXGQPMs8TBDBXecZvKCwP8i32btPGapm2NZdRMLn0+YXnNFwGDwDPxOkUNmuNIiQ/muFHt6BKuFqNTQtzH5V2A3khIcvJvfyfgrCd+7PalBqwmoH2ccFwoHt23axZLIlc6E0S3E8QzANiBv6+A0Vk9dgh6ayTDZbD8MlyDxO0CBLpk9sGD+1NqKO5/zQVqRhgICy7JiUFWzoljrAh4XUQ/gE2ElGM+3mI0Fk9zGUhqAtGO66LBp5Vo92UtO3Hg2OZtL6YvTs/BLnFVD4v7e8ohjo7XSsmSlreqMjJi35vt0ICCLEQZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmNd/l+jL2tQxuUia4ODZ9DqPzkjOb3bQgarGizr1mM=;
 b=UYCsSQAsulbDeU00PnaCE2ac7NvIvcEzPH0+0ztTn9aUnUILY3oI9z4tTDVGoQKEQC0fNTYdF2rth/6dpOMki4NjSoKXd+FKlBgUR2M2BtQdbIZv6GMUhbDkSsmnWvpNTm+KDYSiWQO9raGSlX8yBz6US7YltgZGNVnyRb0iaom9e022dOpMpusaSW3BMeEXdB7rtFwtLvN0Kod/o72Xa8DABWvvmT8ZuoD82jkHnpJCfNp+NTIIGzoGKYg09fCGPdq74Wyr1K53tfZvoLhQyar31Qj9MK0d9uJfJO88F2JHie4OYIL4esvLFid3P397+S3s+eHopVXa4Z+KKISphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 8 Apr
 2024 02:01:43 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 02:01:43 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "peter.laszlo2@gmail.com" <peter.laszlo2@gmail.com>
CC: "lenb@kernel.org" <lenb@kernel.org>, "jacob.jun.pan@linux.intel.com"
	<jacob.jun.pan@linux.intel.com>, "smarter3@gmail.com" <smarter3@gmail.com>,
	"Kumar, Vinay" <vinay.kumar@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "noltari@gmail.com" <noltari@gmail.com>,
	"Bityutskiy, Artem" <artem.bityutskiy@intel.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH] intel_idle: Add RaptorLake support
Thread-Topic: [PATCH] intel_idle: Add RaptorLake support
Thread-Index: AQHZK9QM69Ctt/8BWU2kz43rXhq0Oq6l6maAgU1oRgCAAOTNgIFrlVmAgACM64A=
Date: Mon, 8 Apr 2024 02:01:43 +0000
Message-ID: <76cac4882fe1444bb381825e18224592656f10d4.camel@intel.com>
References: <20230119070205.90047-1-noltari@gmail.com>
	 <c79904e98b86b68c87add286aa1487b3f81712b6.camel@intel.com>
	 <c7d1eced-d77b-aca7-1422-6eefaf704f3e@gmail.com>
	 <7e2c1da24b48217045e8ad95b739ec96cdce5931.camel@intel.com>
	 <BCBB0027-F0E9-42EE-BB43-D50091D9115F@gmail.com>
In-Reply-To: <BCBB0027-F0E9-42EE-BB43-D50091D9115F@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB7856:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQ9SrYZnyJiT88rQfHYri8gyrxQGhmt9m9xei4LMEWxeTzNczFkarWK+5Pe9L5Eph//CSTP8mMfW3IzcLZXoNfKvsHJxA3e9UZMLCWibEYAuY91VypFbH+0+WYe99NroGwbRAFpx6NgyDllVr0A/Ih/CiEpMqGykWM9I/eYS3aXRWdN042fcAAvbk7q7ZXlAEG5nUcR9HweTMXUH5Zr+FlYsDu2yRG+mqUzoBbC4v6r02SBSROt+Hllkj0Bxb4xspKvOy1iHwn5kLIaOcHqiOF2/Vm9vz08nq5eyjLy2CyZRGaGtjBFF6aVdfoJ06m/KQ2suVLymUMnW+aMfFpcx8M0DBKy2zHcDNuCD6EN2Q6eAEQDr2qw7KuYyDN02WnoyW9Molj85uP6hxQ+zDVxAbQ8CK+Qp7GXPegJejMLRygrUnavkHmbQLJw/p+IcpRBbh/gK9bM7cW/GM22nIV/iYtEycue9of2TF+G3qzQDttLto1pHgA6F+SF1dma7rXL3T23i7PI463M5tN5RFeoQnu9qlHBdegZlYX7IYbs1Lyk4rkWPsoBImAUBbZfIXOeZjbJ4oWV765qlyaA32UcQpMHC6Uc0Rp0L/U5t4COvcF4Abfvt3uXekn2Ops3AK3FeGS9l0navJ/ktCCiY4OxBcJrChXfReG9R4fXDQbCY0tI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0ZVQWowbXhmdEtybGNQalg3dXlITERGL0J1V2tFYk5kWitSeE5BWXByODdk?=
 =?utf-8?B?VWdhWGUzcjFGLzR5cDZQMkdDb29zb0xLNG1yNFI4ZFlSMHJ5T05KL2x1cU00?=
 =?utf-8?B?ZFZ1R0ZNbTJKejNEdTN1S0NlQm1KbkdSTm1pcEJZeldmeXpCS3JrcDVlRHBk?=
 =?utf-8?B?YVF4dHBidVdibUQ1b0ZOTVFhRnpYdi9laGxaNWJXWlY3aW83NS8wVmdHMFVa?=
 =?utf-8?B?RTVLRzhoQU5ERkxVRmxhZzVndU53R2lnM01HMktXSFNpTW4yR1JjbXZSYnB1?=
 =?utf-8?B?Wit2Q3dJZWJCMnEyZHdQVDRXUllDV3NGWUNlYitPUGN0YjY3WkRiQVdnNGdx?=
 =?utf-8?B?SmxvaGd1QVFMUHQ2S1BaM0tvNmZWa2NCUGdldERNUk5rSzRORHRHamIzMExF?=
 =?utf-8?B?Y05yVVRLNVN1REtBVXhKM2dRT25PUW5CMHZCSTA4MVUzOW5vdHlZdUhWZkFi?=
 =?utf-8?B?aFBVWitUWTJxZng4emYrL1lwNXphR28ySXBuUDcvZmkvTU16MC9aM3p4cUk1?=
 =?utf-8?B?eThiVWpmNVd3YUk1bDJKWHBYVHJmblU5V21UMnZSemFRODlmRCt0REFrNU5D?=
 =?utf-8?B?UWZ4M05reTBmRlVCU1h6Ti9VY0I5M3NaUDNReTBoZXdlMlNFdmdMS00zYmx5?=
 =?utf-8?B?WWI4SkZ0VTlzK3ZuN3pITWtBTG9xTlVBYjhsTEE0M1NqeG5KSWc5OWxPUmlt?=
 =?utf-8?B?S1p5Q2I2K0RjVGxabWo1eWlkaVNGVlJmSGhCTFB4SzVQc1FQYkNoVnNDRldE?=
 =?utf-8?B?SDNJeTJxSjFBUE00d3FrV3p6M0NBQWl1SnBHSlkvU1pNa21HMkJyWkMwMUVq?=
 =?utf-8?B?WjczNnRpV2poNkpiNmV5TW41Ujgxa2pNTFhjZldESUljYVgwTlhiUFYrMy9D?=
 =?utf-8?B?cnEydTFMZU5WM0VQcStvbmhuR2orZldyVmJUbm9IZks0d0dJMjFGMkk0SGU4?=
 =?utf-8?B?M3RxRmpyak1pZmVhR0p5MVJuam93VG1pdkVKSmV6aERYbVAyUzRGQm5GTGJZ?=
 =?utf-8?B?blptUlhFdVp2Y3o0a3U4NHVNSXVONkJHK1FkUStib1JiQnpLU2FrZG1GRkcv?=
 =?utf-8?B?aWZQUkxyZzFrdS9UQVZjKzB1cS9zb3FzK1RLU3FTZGVTV0hvWitqNGhJTXpE?=
 =?utf-8?B?eDJ6ZEd0NHI0TDBLVFYrcFN5OG5YNDFGLzFmZ2RodHFydmtMVmNkUEVUdmVl?=
 =?utf-8?B?MmhZRGhtR09sdnpFL2xwTCtmMEorcWhabWtXdTVCVXl4bG05UzRFbVNEb1Y0?=
 =?utf-8?B?ODZZNVljM0NPZXZ2Q3Y5VUx1NGNkSURkVmNPQ0pqRmpTbGdZY09BUzZPS2Rk?=
 =?utf-8?B?c0ZsOVhTaW9oT05sVXk0QVFFSnErLzJQR2MyNWVKZWhqSDIxQWN2eXRqOVlZ?=
 =?utf-8?B?Z1Vod2QxRndmMXdQb0NOSFNLQStxUmRjWDdtbEtsbHZSdjZSM0hNb1lRRy9W?=
 =?utf-8?B?bWFMTzJoVFhhUG9IbjRGRXQ4b3JCeWxtODVNeEhFTzB3T1V5V2lQckF6azA2?=
 =?utf-8?B?RGdGMFg4ZWgvQWNEdVVEaFhOcFhncXZCNHpFRUZUandnSHFvMnBKaWVTbWtL?=
 =?utf-8?B?M3ZXOFNwSU84czV3cGliMGF1UUcrMDltb1N3dDRET1JVN1VpWE9OaEkydHBz?=
 =?utf-8?B?bG1NazR4dzd5U3BydFpMT2kzK1k2ZWNqTmhZamJ1d203VmRVNDlkMjBZV2tn?=
 =?utf-8?B?c1RoVi8yS3hmUUJGTHZ6VkdRaHFVTlRwWDl3NmtGY3J5Qkh2SXMrdGpMc01l?=
 =?utf-8?B?MjhLWUdxb2JPeTJJWTNHUXp4US9MblBHS2RML1lQem53WEM2d2JhL3gzNTND?=
 =?utf-8?B?SVp1VUFBcjhybVQvT3FreXYrQXJFY2tYd2JZQWJvYnA4VFFYbmpiclZ2cGEv?=
 =?utf-8?B?TitXUElPOGg0RjAzem9HTzFqZGNNYkZlWEMzWWI1RkVmdmhSSHdveW9Sb0tn?=
 =?utf-8?B?djRONGM3UGpaVlpHY2hCNGJ2d2hCTU9YRHhDajFEVzIxRkFOWTlDVkx0OUdq?=
 =?utf-8?B?Zk00N3NNWXF3Q3RNWVlwbm5yZzZXa1p2S3NvbE5zbFp4a1hsWDBORmVXdEh1?=
 =?utf-8?B?V2JLYURid2I3cTl6cW50OS82RDFVWDR3MWg1UTNVS1pHNGZqN0dtVEJrSW8x?=
 =?utf-8?Q?stBvp0w+6tcHS4bORUQrzO8rq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8107F9B1FE3612419332668FA5A61CC9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3d82e6-3360-4309-851e-08dc576fd6cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 02:01:43.5666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQi9EtUMrNHL2ZyTzM3m7PIcgJp2czbohM4iRg3fb59pM/T9mHD+AVoBoESTYl9N/JEeZveKIOAe4XN/zZcdDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI0LTA0LTA3IGF0IDE5OjM3ICswMjAwLCBMw6FzemzDsyBQw6l0ZXIgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiAyMCBBdWcgMjAyMywgYXQgMTE6MjAsIFpoYW5nLCBSdWkgPHJ1aS56
aGFuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IFRoaXMgaXMgc3RpbGwgd29yayBpbiBw
cm9ncmVzcyBiZWNhdXNlIHRoZXJlIGFyZSBzdGlsbCBzb21lIG9wZW4NCj4gPiBxdWVzdGlvbnMg
dGhhdCB3ZSBjYW5ub3QgYW5zd2VyIGZyb20gb3VyIG1lYXN1cmVtZW50LCBhbmQgdGhlIHRhYmxl
DQo+ID4gaXMNCj4gPiBub3QgZmluYWxpemVkIHlldC4NCj4gPiANCj4gPiB0aGFua3MsDQo+ID4g
cnVpDQo+ID4gDQo+ID4gDQo+IA0KPiBIaSwNCj4gDQo+IEkgYWxzbyBqdXN0IHN0dW1ibGVkIHVw
b24gdGhpcyBwYXRjaCBzZXJpZXMgYXMgSSB3YXMgd29uZGVyaW5nIGFib3V0DQo+IHRoZSBsYWNr
IG9mIHNwZWNpZmljIHN1cHBvcnQgZm9yIFJhcHRvckxha2UgaW4gaW50ZWxfaWRsZS4gVGhlDQo+
IEFsZGVyTGFrZSBzcGVjaWZpYyBwYXJ0IG9mIHRoZSBpbnRlbF9pZGxlLmMgY29kZSBtZW50aW9u
cyB0aGF0ICJPbg0KPiBBbGRlckxha2UgQzEgaGFzIHRvIGJlIGRpc2FibGVkIGlmIEMxRSBpcyBl
bmFibGVkLCBhbmQgdmljZSB2ZXJzYSDigKYuDQo+IEJ5IGRlZmF1bHQgd2UgZW5hYmxlIEMxRSBh
bmQgZGlzYWJsZSBDMSBieSBtYXJraW5nIGl0IHdpdGguLi7igJ0uwqDCoA0KPiBXaXRob3V0IGEg
cGF0Y2ggb24gUmFwdG9yTGFrZSAod2hpY2ggSSBhc3N1bWUgd29ya3MgdGhlIHNhbWUgd2F5KQ0K
PiB0aGlzIGNhbm5vdCBiZSBjb250cm9sbGVkIHdpdGggdGhlIHByZWZlcnJlZF9jc3RhdGVzIGtl
cm5lbA0KPiBwYXJhbWV0ZXIuDQoNClRoYXQgaXMgdHJ1ZSwgYnV0IHRoYXQgb25seSBhcHBsaWVz
IHdoZW4geW91IGhhdmUgYSBjdXN0b20gdGFibGUgd2hpY2gNCmV4cG9zZSBDMSBhbmQgQzFFIGFz
IHR3byBzZXBhcmF0ZSBzdGF0ZXMuDQoNClRoZSBkZWZhdWx0IGJlaGF2aW9yIChpbnRlbF9pZGxl
ICsgX0NTVCBjLXN0YXRlcykgZG9lc24ndCBoYXZlIHRoaXMNCmlzc3VlLiBXZSB3aWxsIGp1c3Qg
Zm9sbG93IHRoZSBzeXN0ZW0gZGVmYXVsdC4NCg0KPiAgQWxzbyBvbiBteSBOVUMgMTMgUHJvIGk1
LTEzNDBQIHRoZSBsYXRlbmN5IGZvciBDMTAgbG9va3MNCj4gc3VzcGljaW91c2x5IGxhcmdlIGNv
bXBhcmVkIHRvIHRoZSBBbGRlckxha2UgY3N0YXRlcyB0YWJsZS4NCg0KRG9lcyB0aGlzIGJyaW5n
IGFueSByZWFsIGlzc3VlIGluIHlvdXIgY2FzZT8NCg0KV2UgZG8gaGF2ZSBmaW5pc2hlZCBhIHNl
cmllcyBvZiBldmFsdWF0aW9uIG9uIFJQTCwgYnV0IHdlIGRpZG4ndCBmaW5kDQpvYnZpb3VzIFBu
UCBiZW5lZml0IGJ5IGludHJvZHVjaW5nIGEgY3VzdG9tIHRhYmxlLiBUaGF0IGlzIHdoeSB3ZQ0K
c3RvcHBlZCBzaGlwcGluZyBvbmUgZm9yIFJQTC4NCg0KSWYgeW91IGZpbmQgYW55IHJlYWwgY2Fz
ZSB0aGF0IHRoaXMgaW1wYWN0cywgaXQgd291bGQgYmUgbmljZSB0byBzaGFyZQ0KeW91ciBwcm9w
b3NhbCBhbmQgdGVzdCBkYXRhLg0KDQp0aGFua3MsDQpydWkNCg0K

