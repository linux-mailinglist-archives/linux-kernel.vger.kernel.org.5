Return-Path: <linux-kernel+bounces-151898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF4A8AB57B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E9A2816F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BF713C816;
	Fri, 19 Apr 2024 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENYOxAy6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895C77F13;
	Fri, 19 Apr 2024 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554198; cv=fail; b=RTB46kgIIWl0FrHcCq0mhcaZwO8ByzgFLDpz0/yMwREipLXENwqHM/NTL1Cmvl7IVnuyM02W2xGvEcdjhnJyEi1enyB6/ZwWfJJb66nQCTg4XNh2/mMsqj28mEVk9i8jbO2GrHldcCwU7PohySBmPZPQJF+axXIA1jQUsISKtJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554198; c=relaxed/simple;
	bh=65tk3iV2L5jpFx5ACIzbeYOhyfrVts2gd5Rjg6SI2GY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dyI0Rk+2u0fG3Y6tJGUHPdujxQ3npheVjCXBlCnPD+pjdQuds07BKmYa7cQkputU5fV8rngPGGo2oXPlSoBbivHjdMPRDYkozMzbV46DB0hi4yRmqz2N0zDl0/ERuOsaVPuhkv7ZvJrCEbQpiDIGXMWLxowsmAxFKvakdm78oV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENYOxAy6; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713554197; x=1745090197;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=65tk3iV2L5jpFx5ACIzbeYOhyfrVts2gd5Rjg6SI2GY=;
  b=ENYOxAy63TvdKEtKmL8p05VRtJZC+QFxhokbxFdFvJIBdlLW5/uKVOdI
   gZZnTKfq0iO+X9PR78+ATcxumAeyTM8eOmppWCxIq60bzzL6f9S+4sVO+
   JBEVeUzKP8Ya1GNvJmgloz1GZckj6Ud6kT0qWKtJd2L4zvKbHW50OJJ2f
   H3fOUwb/U6GBzimCEA/5b0KvuRcmbmyukXkrFh5xv/ZAgCXqt+KIQwtBu
   F7rEpeRVyhwJY+Fcl993okw3QDnbRBbKX3KX5QRdK+uFT3dvoGyqaV7c9
   Z46z67Pw57XjCHKZ/96ipLcv24K5PErGof8zXrP4pQIUUfMw0BiaUalnF
   g==;
X-CSE-ConnectionGUID: SJXjhB3AQ4SuYZzFKyEZmg==
X-CSE-MsgGUID: NQ5ljcpwTvyOQzQG4TzisA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="34570932"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="34570932"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 12:15:25 -0700
X-CSE-ConnectionGUID: j6mYwOW9TBCm9LEVI7wkWg==
X-CSE-MsgGUID: tpQwuf2mSbWlQ/S7y2HRgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="23862044"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 12:15:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 12:15:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 12:15:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 12:15:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdXoQAbnhM/uNaPyJYDSyH8WHdAJPoJOTQB4L3mD74jYqOo1oFTQu/oKg7eca+rNn3XVdSATUzspBMULqud6DgunqeUpv211CL4nHmuOed07T+jkso9/7IUrtjfJpX01y4bhj99aw4CTQ4jtsjEWeD86p8L8e1Jl93N8pXDYWIQLWfD/CDsAbdMaZAT3T7J2Abi3GzdxwamjcHhuwhtdVwEG3iiddVpC6cBVmvurvSa5XAYJIR3XDRS/K9e1kx8+8HPLSH+LBRa2IuOn/jroPG4eXkTcfzs3m2kILdJ/hAS9PqLCVMjlC77tx462dIyAXIwf/Zvsqi9B+tAtFitf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65tk3iV2L5jpFx5ACIzbeYOhyfrVts2gd5Rjg6SI2GY=;
 b=T0fAqI4FAqGmrAluzFH1lhLtD+hph2DfesIYEAGkkFHX8EeSx87WYNrf2neHVUsmPs83RebMS3aa1myJcx0eeDA9SzJ/Gz2B/OuOPQhvf1/nMuidP8M7AMGIsfJS7T86+dIrEMdpC4GbAa4uUv6WDLmS/hTLow1l1PXqHTCENkPlRAqChG+KFJlj5FPiwWfvXOdLJPwwkbH96s90edjkMVSeA/Ep8Oh8nE16iQdus4FVQ0eBKtMYJrgizAgaW+IVTsoZb6w1KuZecxGqF2RDiZqibnu+eAiszkXhNBGGrO1xx3Mc7RiN+Pdtj1GTaH36LGqgOneQ7Ph7UB3SEyFnxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by SA1PR11MB5780.namprd11.prod.outlook.com (2603:10b6:806:233::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Fri, 19 Apr
 2024 19:14:59 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::f454:78c6:2602:4a6b]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::f454:78c6:2602:4a6b%7]) with mapi id 15.20.7519.014; Fri, 19 Apr 2024
 19:14:59 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "Wu,
 Hao" <hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>, "Rix, Tom"
	<trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH RESEND] fpga: dfl: omit unneeded casts of u64 values for
 dev_dbg()
Thread-Topic: [PATCH RESEND] fpga: dfl: omit unneeded casts of u64 values for
 dev_dbg()
Thread-Index: AQHakdeskQoReb334EG4W8nSL0W2eLFvTagAgACqYwA=
Date: Fri, 19 Apr 2024 19:14:58 +0000
Message-ID: <7821f14203b8c6974ec2af6c071096402ae6657e.camel@intel.com>
References: <20240329000429.7493-1-peter.colberg@intel.com>
	 <Zgt7fA/Jfks/iKYi@yilunxu-OptiPlex-7050>
	 <61cf643fda9b983b8a78b9f66c46290becf4f537.camel@intel.com>
	 <ZiIzwjggxFmXvau8@yilunxu-OptiPlex-7050>
In-Reply-To: <ZiIzwjggxFmXvau8@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|SA1PR11MB5780:EE_
x-ms-office365-filtering-correlation-id: c77120e1-9a0c-4aa8-b9ee-08dc60a5018b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K9CBA0QhWx5VZlOvlyY5yiJaBhqbU5z8kDhensa1Es7KQwE5HL2RpRpPT/QJJXufDdeEm3iiGHEX/VZuaZ7TE4sD224NPsi23iY7TMlhJ+v8Dzfi5bI+71WwP+LqoZB7AIhUQbjY45fV9uWQmjLRVeMMTtqqmC6WY2p2jtJUm9Oa3cAGqZzFJazT+HNNhraoIGngUnu2At/yQyCjeCSCS3exG/HA2fn7sBMFkGCv39Nf0n6x8xt+hFWK9fgxhZDR97zXILSc7U26G52MwPbiLabb4QYEaXUbaRCi0eExMWMZDNXP8tlNIJcy0L6G7Wu03f3Ox4SPoHRI/dJqpVmTpRXOBcJFE1pbS7zkDN58GwniY9cX3LXpWdjwSydxKDCf/YL7LzPH4B/QU8pFrwIX7xRBJw0KRLSOj9dyi3Y01hZhBfAhQgu2P9UzdfvqZK6AIplN4nUejyFVViL2Nh9tKs8eayO4ZncBFg52e85zluR2XNQOS5Utv+ty2Zi55xJsDbhMWNhB72Ume1Sg7uITzdlPrRw7kDcdmFdZUpgRtHXT+/H0wABnLWIm9SbdHSez9DoCYXcYEtDXBaLgsyYHwv0jBbpnOOIrJz8zz85kkqrJWRhyCeKJVmvEbepYkTUDiWwW7SB7kmTq5LZiS7i9IGMG+EDd0Egvq1EIgvZvRRZSv1PPOg3OHPSf02teuACizbp4Ug2yinTrIwHtCJwwKKbwNAmWkCow2UgQMnmWO9E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTNnVlUrS0toKzl5NVlRb050QWc2L1h4V0tCMHJZSHF6TW9pK28xa1pkZEk5?=
 =?utf-8?B?S1lPaDBPOEFKb0RpQlhkZ2hiUVNpNFQrdGxDU0xQWmlVMTJuZnE1dW04bnZz?=
 =?utf-8?B?T3JvZnZyaUpKRnpXb2lHa29icUxrODBWUnlqM0hibVVXN1U3UktVbWR0YitX?=
 =?utf-8?B?aVIydHdCQkJaamNvK3h3SmphQ1k3M0UyUThIanZIc051MUNrcFQ2RHNHWmJJ?=
 =?utf-8?B?SWhOazZIT1NuUkZ2dCtlZ0xyOEJoSzhPTEF3bFZTd0JLcTM1ZnloN3Y3QUZN?=
 =?utf-8?B?a2VHRFZJOG03Tjd0Z3YxOWJJbWpwcmNPaEFpQ1lXcU1SN0hQQnNzc2ErSjRK?=
 =?utf-8?B?Zml6QU1jUGVMZDF0cFZNUk9LSlN1eDM4QTh4UXc1ZlFyNEE2SVQxZlFwcCs3?=
 =?utf-8?B?OUc3VjFtUkxvL2ZsOElpcVpnclUyUDlDTEpoSzZ4bksvcjlQUmY2UGNST3VM?=
 =?utf-8?B?bFA4eGtuVERUZFZSWFVmTGI1aXZOR1pGeDErQ1BGMzlhT2VSQ2paWDVxVEJ0?=
 =?utf-8?B?Vi9qVHhhTnYxTXFoNXVwYjl1L3BNcGx0UlptVWJDcURFY1h1TTZhL2U3VFRh?=
 =?utf-8?B?cG00ZHFIWWsybUhvcHBUVzN0NkxtSEREQkE0QXpqZlg1VkxZVTg4MlBXZzdE?=
 =?utf-8?B?ajBVQXd3OEY1QTJmOEJBVUp6RUd1bTRqZkVTbmVYbHQ2bitZVkhjV0U2emJl?=
 =?utf-8?B?TmNWY3loT0hWaGhKK3hRd2pYWk42bmk1Y0t4UXh2Rk9MdVU4T1l6NWRFeHdq?=
 =?utf-8?B?aVpnRUdGNWNxM282WjZnQkZuV2dIWU5UaDR0V2FSa3BNQmJyMG5RVnFCVXU4?=
 =?utf-8?B?TUxZckUzMklyUHZpV0ZBZk92RTZzTDF6YWVMN2l1dFFJck1lcjc2RzBVZUFm?=
 =?utf-8?B?ek11aEc2VU1CamVHcEUweU9qcDhQTFFEMnpRZ3lQUXEyZDJQckJ0R1N2ZnJu?=
 =?utf-8?B?VUthTWVySEpUWlZ4RU9mOGZmVXFwRm9UK3NZMWsrYk1GWGduUEZQT3ZqUEJy?=
 =?utf-8?B?U3loWkV3Yk5jN1U2eUZqSkVzVmlRQ2JicENVdmFWYlhGalduZTFGY3YxWGpZ?=
 =?utf-8?B?TmFPTWFtY0QyYkhxSEo0TkIxcGhIRjcxMGRxS293WklqZGpLcTBZeXpNd1Rv?=
 =?utf-8?B?K1cxRmpnNGowQ04vM1VibHo1MDJYNHo5UHJOZ2NQdTZiM1UwU2FHNEtRL2tH?=
 =?utf-8?B?QnBuS1ZEaWoraDE1ejdCNmRyMi83d2t3V3V2QmFnSmlmSmE0KzBxTnJKWXpH?=
 =?utf-8?B?YXcrQnpZRzJjNHN3Q2hPUisxUlR5QWdiK0NVNlU3ZlZpNHlvOUpBVjZUaHFx?=
 =?utf-8?B?K1l6a1VzcGdjVy9Gb0d1YlU2blY5YnZYK29DUWhmdVFNZzBLUlZZVlZIZGIx?=
 =?utf-8?B?dG5OR1EvbWtvc2g5V2h2dmFQWDdmR3JNdk1vTVdWOUcwT1d3NGxxNTZURUNO?=
 =?utf-8?B?c3R4TEhxRVhaN29qZHZGOHN3TURSSXMwanloNldkelVIWi9NWWdhaEJ3MDRz?=
 =?utf-8?B?U2J3NWNIalhpMDVhT1dJNFZla1YySkR1bVRwNTAyb0diZ3JrSnJZbkdyaXJC?=
 =?utf-8?B?SHVCbUtWN3QwSEFBbi9nbHZlcUZxWFZ2TVZOY2hrWjVMdDVlZjMySXhOVkpx?=
 =?utf-8?B?bGlBV3hwTFMzUWVOdDNPdlNrWGNpTURNdGV3cjB5WXdNWVJ4MW9wdmdpbzZB?=
 =?utf-8?B?TkFSV0dNQXZSeVZUNCtDbXlySnE5a2VPRlpYMjh4Y09DVE9EZHNIMTN2Qktk?=
 =?utf-8?B?bDdwb0lweDFsUUlFdDF2bWZIK1UwY1dzOEFFVzJtRTRienF2ZE1HMTN4aVkx?=
 =?utf-8?B?YnVUdHZHSFZ5RE9oZDZtdlV3QUtpVFFTajhsaEVMTG5LUjRvVk9YbTlmU2ZO?=
 =?utf-8?B?bFRvOStzdXozTmoyUi9HVWxHeUxlMXVVblhrK1hKL1NWT3U5MDZDQTlIZHJk?=
 =?utf-8?B?enRXU1g1WldKVDFSLzJ4aUFtdmhIbGI4SU1zem9tS1A3NUIya1NWdGNrUkdD?=
 =?utf-8?B?YmJhaFQ2V25rbm5KWkNUWlNUNllmdFVIQkI0Z25sQk9YbkhmZkNwZXBNWmhn?=
 =?utf-8?B?RHZLVFhBamIrbXNZWjNGV1RsSmdUdEUzZUpFK0l2S0xOc2p5Z0Y3dCs0N1oy?=
 =?utf-8?B?T2tXZG1VbGxZL0s4SUNDTWpDaEdUUDZaUW8zWElxY0RBY1ROWlViZlZURThk?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56DAD2E06DB39243823C333E475BF52C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77120e1-9a0c-4aa8-b9ee-08dc60a5018b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 19:14:58.9743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bc2SAsbC6lXBJkxcrMZ4AL6caspN832+T8a74Wpvu0MpDUc+XtFm/nnSMV2Qbmgrq32ybwL1P3ZIKzX7x1Ov3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5780
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA0LTE5IGF0IDE3OjA1ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VGh1LCBBcHIgMTgsIDIwMjQgYXQgMDk6MzA6NDhQTSArMDAwMCwgQ29sYmVyZywgUGV0ZXIgd3Jv
dGU6DQo+ID4gT24gVHVlLCAyMDI0LTA0LTAyIGF0IDExOjI5ICswODAwLCBYdSBZaWx1biB3cm90
ZToNCj4gPiA+IE9uIFRodSwgTWFyIDI4LCAyMDI0IGF0IDA4OjA0OjI5UE0gLTA0MDAsIFBldGVy
IENvbGJlcmcgd3JvdGU6DQo+ID4gPiA+IE9taXQgdW5uZWVkZWQgY2FzdHMgb2YgdTY0IHZhbHVl
cyB0byB1bnNpZ25lZCBsb25nIGxvbmcgZm9yIHVzZSB3aXRoDQo+ID4gPiA+IHByaW50aygpIGZv
cm1hdCBzcGVjaWZpZXIgJWxseC4gVW5saWtlIHVzZXIgc3BhY2UsIHRoZSBrZXJuZWwgZGVmaW5l
cw0KPiA+ID4gPiB1NjQgYXMgdW5zaWduZWQgbG9uZyBsb25nIGZvciBhbGwgYXJjaGl0ZWN0dXJl
czsgc2VlIGNvbW1pdCAyYTc5MzBiZDc3ZmUNCj4gPiA+ID4gKCJEb2N1bWVudGF0aW9uL3ByaW50
ay1mb3JtYXRzLnR4dDogTm8gY2FzdHMgbmVlZGVkIGZvciB1NjQvczY0IikuDQo+ID4gPiANCj4g
PiA+IFRoZSBjaGFuZ2UgaXMgT0suIEJ1dCBJIHN1Z2dlc3QganVzdCBkZWxldGUgdGhlIHVubmVj
ZXNzYXJ5IGRldl9kYmcoKQ0KPiA+ID4gc2luY2Ugbm93IHBlb3BsZSBub3JtYWxseSBkb24ndCB3
YW50IHRoZXNlICJIZWxsbywgSSdtIGhlcmUhIiBpbmZvLg0KPiA+IA0KPiA+IEhvdyB3b3VsZCB5
b3UgbGlrZSBtZSB0byBwcm9jZWVkPyBTaG91bGQgSSByZW1vdmUgZGV2X2RiZygpIGluIGFsbCBE
RkwNCj4gDQo+IEkgdGhpbmsgZG8gZm9yIGFsbCBERkwgd291bGQgYmUgZW5vdWdoLiBVc3VhbGx5
IHlvdSB3YW50IHNvbWV0aGluZyB0bw0KPiBmb2xsb3cgdXAgYW5kIGRvIHRoZSByZWxhdGVkIGNs
ZWFuIHVwIGluIGFkdmFuY2UuDQoNClRoYW5rcyBZaWx1bi4gSSB3aWxsIGluY2x1ZGUgdGhlIHJl
bW92YWxzIG9mIGRldl9kYmcoKSBpbiBhIHJldmlzaW9uIG9mDQp0aGUgU1JJT1YgcGF0Y2ggc2Vy
aWVzLCBzaW5jZSBpdCB0b3VjaGVzIG1hbnkgREZMIG1vZHVsZXMgYXMgd2VsbC4NCg0KVGhhbmtz
LA0KUGV0ZXINCg==

