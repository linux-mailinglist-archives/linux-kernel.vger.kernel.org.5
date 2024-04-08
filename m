Return-Path: <linux-kernel+bounces-134717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 829D889B5F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099781F214B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23198184D;
	Mon,  8 Apr 2024 02:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UX3u+i2i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89112364
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712543636; cv=fail; b=k295fZ8bDNRN5/FcKiroK5Tq7ir7/vpoliD0jzSDrvIjk7V4oGbsG8yBn5V5vOzFzy3cl5t925tLhqbdhqoU0zS5uJNk9Zg/BTvLweQU/Zf7zvltQhWNempQX60KgHHgKke+L5sWnpFdRg0wM4IHQTS1GSUuT6oJyTlhUHlyhXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712543636; c=relaxed/simple;
	bh=sZUcP/Iu8+LkJNeHh3ydX80xthldo79i1fl4IRhSEB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cnvZQ2Mi5RIAAurhUXMEhBeiGpAYkjdd/8fHd/lpogX0b6p6CthHIvcLouoQZD7matsig+jYI8ClXK/Ma4jEThz5kkU4qbtnkv4Idw7a4XWSXD3UQcFTVOni1L8DEKKvpj594dKM/8lHqaktmkEne0XA3q6ZJ4Dc+Wqae6OKMsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UX3u+i2i; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712543634; x=1744079634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sZUcP/Iu8+LkJNeHh3ydX80xthldo79i1fl4IRhSEB8=;
  b=UX3u+i2iV4Q8lZuJUWa3H4GENLNB6vXyQfITAjTeacASsduZX9DQVcsw
   1W/e7+81QfU67OHE3ELkyNpJah6j808NqvfauUVKsm4yOXOxWBwbZnlUf
   5FoiRDyVnurBphmeeAjWZsyKK8RHyzjWeAFrmrRcm8S6KiUh/bkYsDX1f
   a/5kVU5aJYGcJk4zuNKbuANqd8ulrWjkSClno3CSBRsauiCYKUwnolKk4
   NDggsyOT1EB0r2TBmD+8nKd2YW+KBvUljxSmOkC3BZgWtVcOjxBcGavxv
   Q+mqf5ywaYYzzYU6yrVT/xz0hQTs0+mACWnHwnqNwiVRttJIq16KeusV9
   g==;
X-CSE-ConnectionGUID: /8Z5wtVtR9+rU2hDOCjAEQ==
X-CSE-MsgGUID: 8KTPYfVeSQuUcWJyWacZ/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7667504"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7667504"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 19:33:54 -0700
X-CSE-ConnectionGUID: SJntLUGLRqyHhhES72BTzg==
X-CSE-MsgGUID: E7U1SUQFR1aKao5eg7PB5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="42915107"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 19:33:54 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 19:33:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 19:33:53 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 19:33:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZKjPrG9yGYAPyjr8cPd1oAFJyaOJlB/tmDgUrkqyHHL2iW0ppzeXCZ4s1ediIhUScOl9a1Lm4i6hPgrkydZkLW/8ztmFztRl4d3zbFuz1qNVLq9LNU4o4Oe/lZdqFRqdn/b3Dxgf1ExeGJbntFn8cTsnW7aNotsh/0+4IKB24PLT1ao8iGAmryT6myBKFADtAi4gcNa6PXibke+/COqOs5x0axK5X5EtpCDxUSpYOsZJh2i9BoB/hc6Ew6kN/vDfdqwUA3wUv/teciXVaxfvivqs+XrJc2RHANXHiooj+0S1MzM9yPaheW7fErEUMo+2jmD4RUb0+I6/b4FFUrY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZUcP/Iu8+LkJNeHh3ydX80xthldo79i1fl4IRhSEB8=;
 b=WmVAwEnX0D3Gs7JB0MGQfYaHakjAYnMQISGqNTcD+vzC8CAwBUdK3DNtQlh9/8ukAyH+CdHrmCnTVpomzyBZ+WUu5Vo0eWqaDf9WgcB4bBiLdaalaQPT/HcrgdKwhsWDYej/wUSa1g3qQrThQ6NueIbnZGJuKklFSxK90XN6l8CHOWRlZtUIq798E1LEcQMM4mWsSEBMDqyKazrKpoNl6qKy9orqeVp3MoTcvIaIdPW9XPdHy46xpk3afv1keYG7LWdQkWJ4fgc6WJQNn/3n5a7jPnmANXiMPoTsoMJXOXlW2LE/bSY6sfwsobGmNogFBrynAhgyOnfHppi6mmg0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6846.namprd11.prod.outlook.com (2603:10b6:806:2b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 02:33:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 02:33:51 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 02/12] iommu/vt-d: Add cache tag invalidation helpers
Thread-Topic: [PATCH 02/12] iommu/vt-d: Add cache tag invalidation helpers
Thread-Index: AQHaflqwAocS3d3S90WqoPDmpOE9v7FMwc/QgA+blgCAAV70cA==
Date: Mon, 8 Apr 2024 02:33:51 +0000
Message-ID: <BN9PR11MB52760554D81E96A9AAFD964A8C002@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52769F48D89273B0CCAA0B7C8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9aeb7dfd-e8af-4da8-b67e-274f3227efa4@linux.intel.com>
In-Reply-To: <9aeb7dfd-e8af-4da8-b67e-274f3227efa4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6846:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DdYph8v8WI/Hr5csJnTy+Hj0G7/MOb2F3G8c+isg1w00DSMDDoPNh1KFMAui1iyiJ99Ajjx5+KxLBw8RsQcMr03w3WOsqNL9pY65dxGV3nn4BBdutlMpMDbc/9se23lGVWowDPSaY+8WEtADzVtEw5HekhQv5WW+EkfAuWLY8N+ZULjV7VemDc/PWtp+RXPzHVtCdZvBkeCOhmHhCMQ6NzT16qd2El/s+MHp08fv7LCeMp3YqrJzHH886YdVeU8ILtMOUiZlj916Z6tUQthiH1kKTLP5DcG38Qh9lBLr7h+Gv8xAU0dHAKqyK5FCYUT0fpBuxVrj6VNh+2Xxo+czglZn2EmfeXlTVG1EgQ+RNlK/WggYL4SLtugiF7qJskH6tZwIkYTButGLiVQ/G4JnpVohfMiBFurJiMBWH4s19rrx+1KdbAo26keAD0b7ROGObayEwnlyBcwVu1ZPsMFt9iBttFpXTQTk0nybb/ZnD2toQJWYx8RnhLodEQ/ZKm1/tDme/hggg9K3jsS4O2aur1dvTx+k62l6n3o56xqPYtIBeo0/u/Qq2rXBk3L1z+16GJEQQutRFndew/dAoQHJQZqK1B5U3FGqVsqTc6IcYQKxt01uIfiK+YmfPw6JjnbX0kE4CV49F1R7t+0yufeYrqIPuoYuRFMjzaq37T7B+g8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1dTd0ZGaHFVTzZ6bDZ0K3Yxcm40WVNFbXNIVk5QOUozWEJIMUZsQ3hqYXRz?=
 =?utf-8?B?clE3U25pNjJNdlNTM1hZM2dZZjVJMFVyT0FtU0NwN2gxWVkrVFJpT0V5dzBY?=
 =?utf-8?B?MklPNitIZ1IzRGFxTzlmNUEyeEpBcHc5MVFJMkhxOEFjYWJxQzQ2RlNRcWpt?=
 =?utf-8?B?UXBTUTg1WFdGVHE0b0F2WkgrQUY4aFVCMWF3YTdHRStGMXF4UytVUEdMWVNv?=
 =?utf-8?B?QnF5a1crbjBYWGVOdEhrQ0lvb3lwVXpHZnVpNytFbUU2Q1pMTERNY2tpRFFO?=
 =?utf-8?B?Y0ZpT0dIR3NwL2F1cFk5aWNuV1hGNlRFazVQSmsxVEVhTmhlTVpuK08vWkxo?=
 =?utf-8?B?ZjhlRi9ZWEV0MHkycFMxcll1bTY5N1MvMlNncTVKUHZRcTE1aGJNci9jSjVR?=
 =?utf-8?B?VUd5TlRmQzV6bDlKL21pMlBvaExGaFFMT3IwL1ptT3lzK1RkZmpCNC91ZmxQ?=
 =?utf-8?B?b3NJT1J5TzkvUFdvbnFIYVl1SUYydGlBL3ZKd3Fya2I2ZVYvcU16NzJSSEQz?=
 =?utf-8?B?RE1rRytGdEN0REwzQ1dxYldJRDA3SnZUV0M4YytvTWV3NXNXT1FxZ2lLVjBm?=
 =?utf-8?B?TkhOak04Z0JXYmpzS3dNNHdsSWluR0w4NXVjUVI5SFlCZTJDcHpYb3FCd0hX?=
 =?utf-8?B?K2NwNlVZbytWTXFrM0RYLzRud1h3a1Bmd0JXdHlTSGxOazN6QXozQlpOeGlh?=
 =?utf-8?B?dVZkZVRjT2ZGcjRycjVWUG1LTkIybEFrMHhDcFlJdHRGVnZpV0VFUjUvampI?=
 =?utf-8?B?ekttWXpYRjlRbWtVZ3A5NWVMRGRjQzgxcTl4TWVTQ1RWbzl5TGJvald0c3Vj?=
 =?utf-8?B?Wk1ESGRmZmJMQSszcTg0M1I3MFlKOG9pb1BwSTl5Zm5pTURvM1JOdDNDVmRY?=
 =?utf-8?B?dWxxMFMrdlRJbURBSFNCbkwrR29Rc0F4TFNEdEVlYUVqK2hlbjFPVVRJd2Vn?=
 =?utf-8?B?dUlOWlV2TXg3dGNCZUxtS0FGM1VzNGZIU1MrT0s4aWdIeHE0MERVTnltT2p5?=
 =?utf-8?B?YlV6aDRuQXp1ZllzcEFUVDRxNVBISkdlNUt1a3JyZ0FqeEt2V1lDcmVDaEw0?=
 =?utf-8?B?SDJxUHFiUExlSWU4N0xjNlZzRUc2UVAxUEdROHFPQ3liRjdRNWhoWDA4NjdW?=
 =?utf-8?B?SzNQNE5BWWdyWTRVb0cxQm9DNGc1Y2dmYUxtNEtMNEZDb0NyWDcxL3ZoOWVl?=
 =?utf-8?B?dXdlSWF5a2kyYTlodzNZSXFBT3FjN0pRWGtZY3pBaGxOZUtHVktrMUYraS83?=
 =?utf-8?B?NkJjdGpFZnIrakd2a3ZZM013M1FmNFJPamUvTWlIdmQ5L3RvYW02bXlFK2R3?=
 =?utf-8?B?bWJHNSt4M3Y1cUUwSjFzOHNtZzE2bkgvSE95MWtBOGJCY3FsQTMxR3YxekFn?=
 =?utf-8?B?U2lhU2ZBaWxPMVAxaGJvdWljK2YwU0NRTXVoaytXUVo2cmRQYUI5MWFhNERh?=
 =?utf-8?B?SmxJVm1OUDRMWTN1aGF6UGtZUnpwRjMyRnd1TE9adkdrVUFpeDZnbGdmQmxw?=
 =?utf-8?B?M3VHRGUrcmlTUlFLUExnVTc2NVpSTjl6eTV0RFBMTk04QU1NcFMwaDVrZW1T?=
 =?utf-8?B?bnZTN2t2ZFpMM0RnbG44V2FjemdyTDBxWVVjRVlib3F5Zlk2d3pYZUtsbXdS?=
 =?utf-8?B?R1VnRlZJL0c4V3hiTVJtNXJnMUdGOUcydUZRRjM4NU9rUFEwU2hDcjNnM1lK?=
 =?utf-8?B?bWpxUmdVYndoU0kwZy9paDlVczhrNWRwTjhpR3laOWpITi84R0lxeDdWQUdP?=
 =?utf-8?B?NTAxQnNYQjJ6UE9IL04vS2xTZkFxdTdtb2Z5KzdhaDhpWXE5WmxGUUQ4b0d5?=
 =?utf-8?B?eUFhcDYxaG9FZkJyelBYSmtvWDZrZXFoUHJWbzRxSXZDcjlpcGtoWi9CaTBJ?=
 =?utf-8?B?UXFibGRZUTRTRDgvRHVuWjFPU1FadGgxL2hKcUx5bTFpTU1JMEt1VkxSVlg4?=
 =?utf-8?B?bXQzc3hLRjdZcXZFOXlIaU9LeEMvbVRyRzZITjRsb3U4UmhOM3BGLzd6TkZy?=
 =?utf-8?B?ZFhZbyt1d3M0R1l4RFBHUFRyc1FkUGpGUExyUmNtaU01K0hCQURiOElzbkdW?=
 =?utf-8?B?cyt2MHFJUmRZNk5XN0dOb3dpdGdTeXVoN3ZUaHptRUlRNUVHci83M211N2kx?=
 =?utf-8?Q?98LsT8l6jxATKQFOP8nJZEw9F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e54603-ad47-4cdf-6f5c-08dc577453a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 02:33:51.0199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8uteiAKNZZczKMUormenur/1LxVSG4oNGjGofRQSZnTeXk4IY9C/f5+KXJdTtkIkS1duci1OlGU8dttaCXY3mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6846
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIEFwcmlsIDcsIDIwMjQgMTozMyBQTQ0KPiANCj4gT24gMy8yOC8yNCAzOjM5IFBNLCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBNYXJjaCAyNSwgMjAyNCAxMDoxNyBBTQ0KPiA+Pg0K
PiA+PiArLyoNCj4gPj4gKyAqIEludmFsaWRhdGUgYSByYW5nZSBvZiBJT1ZBIHdoZW4gSU9NTVUg
aXMgaW4gY2FjaGluZyBtb2RlIGFuZCBuZXcNCj4gPj4gbWFwcGluZ3MNCj4gPj4gKyAqIGFyZSBh
ZGRlZCB0byB0aGUgdGFyZ2V0IGRvbWFpbi4NCj4gPj4gKyAqLw0KPiA+PiArdm9pZCBjYWNoZV90
YWdfZmx1c2hfY21fcmFuZ2Uoc3RydWN0IGRtYXJfZG9tYWluICpkb21haW4sIHVuc2lnbmVkDQo+
ID4+IGxvbmcgc3RhcnQsDQo+ID4+ICsJCQkgICAgICB1bnNpZ25lZCBsb25nIGVuZCkNCj4gPj4g
K3sNCj4gPg0KPiA+IEknbSBhbHNvIG5vdCBzdXJlIHdoeSB0aGlzIGlzIHdvcnRoIGEgc2VwYXJh
dGUgaGVscGVyLiB3aHkgY291bGRuJ3QgaXQNCj4gPiBiZSBtYW5hZ2VkIGJ5IHByZXZpb3VzIGZs
dXNoX3JhbmdlKCk/DQo+IFRoaXMgaXMgb25seSBteSBwcmVmZXJlbmNlLiBJJ2QgbGlrZSB0byBz
ZXBhcmF0ZSB0aGluZ3MgYmVsb25naW5nIHRvDQo+IGRpZmZlcmVudCBwYXRocywgc28gdGhhdCBp
dCdzIGVhc2llciBmb3IgbWFpbnRlbmFuY2UuIEZvciBleGFtcGxlLCBpZiwNCj4gaW4gdGhlIGZ1
dHVyZSwgd2UgbmVlZCB0byBhZGQgb3IgZW5oYW5jZSBzb21ldGhpbmcgZm9yIGEgc3BlY2lmaWMg
Y2FzZSwNCj4gd2UgZG9uJ3QgbmVlZCB0byBjYXJlIGFib3V0IG90aGVyIGNhc2VzLg0KDQpJTUhP
IGNhY2hpbmcgbW9kZSBpcyBhbiBhdHRyaWJ1dGUgaW4gbG93IGxldmVsIGlvbW11IHdoaWNoIGNh
biBiZQ0KaGFuZGxlZCBwZXJmZWN0bHkgd2VsbCB3aXRoaW4gdGhlIGhlbHBlciBieSBjaGVja2lu
ZyB0aGF0IGF0dHJpYnV0ZS4NCg0KaXQgc291bmRzIGEgYml0IHdlaXJkIGZvciB0aGUgY2FsbGVy
IHRvIGtub3cgdGhhdCBkZXRhaWwgYW5kIGNhbGwgZGlmZmVyZW50DQpoZWxwZXJzIHdoZW4gYWxs
IHBhdGhzIGp1c3Qgd2FudCB0byByZXF1ZXN0IHRvIGZsdXNoIGEgc3BlY2lmaWMgcmFuZ2UuDQoN
Cj4gPj4gKw0KPiA+PiArCQlpZiAodGFnLT50eXBlID09IENBQ0hFX1RBR19UWVBFX0lPVExCIHx8
DQo+ID4+ICsJCSAgICB0YWctPnR5cGUgPT0gQ0FDSEVfVEFHX1RZUEVfUEFSRU5UX0lPVExCKSB7
DQo+ID4+ICsJCQkvKg0KPiA+PiArCQkJICogRmFsbGJhY2sgdG8gZG9tYWluIHNlbGVjdGl2ZSBm
bHVzaCBpZiBubw0KPiA+PiArCQkJICogUFNJIHN1cHBvcnQgb3IgdGhlIHNpemUgaXMgdG9vIGJp
Zy4NCj4gPj4gKwkJCSAqLw0KPiA+PiArCQkJaWYgKCFjYXBfcGdzZWxfaW52KGlvbW11LT5jYXAp
IHx8DQo+ID4+ICsJCQkgICAgbWFzayA+IGNhcF9tYXhfYW1hc2tfdmFsKGlvbW11LT5jYXApKQ0K
PiA+PiArCQkJCWlvbW11LT5mbHVzaC5mbHVzaF9pb3RsYihpb21tdSwgdGFnLQ0KPiA+Pj4gZG9t
YWluX2lkLA0KPiA+PiArCQkJCQkJCSAwLCAwLA0KPiA+PiBETUFfVExCX0RTSV9GTFVTSCk7DQo+
ID4+ICsJCQllbHNlDQo+ID4+ICsJCQkJaW9tbXUtPmZsdXNoLmZsdXNoX2lvdGxiKGlvbW11LCB0
YWctDQo+ID4+PiBkb21haW5faWQsDQo+ID4+ICsJCQkJCQkJIGFkZHIsIG1hc2ssDQo+ID4+ICsN
Cj4gPj4gRE1BX1RMQl9QU0lfRkxVU0gpOw0KPiA+PiArCQl9DQo+ID4+ICsJfQ0KPiA+DQo+ID4g
WW91IHNraXBwZWQgZGV2dGxiIGludmFsaWRhdGlvbi4geWVzIGl0J3Mgbm90IG5lY2Vzc2FyeSBi
YXNlZCBvbiBjdXJyZW50DQo+ID4gbmVzdGVkIHRyYW5zbGF0aW9uIGRlc2lnbiBhbmQgdGhpcyBw
YXJ0IGlzIGluY29uc2lzdGVudCBpbiBkaWZmZXJlbnQgcGF0aHMuDQo+ID4NCj4gPiBidXQgYXMg
YSBzZW1hbnRpY3MgY2hhbmdlIHlvdSBtYXkgd2FudCB0byBmaXJzdCBtYWtlIHJlbW92aW5nIGRl
dnRsYg0KPiA+IGludmFsaWRhdGlvbiBhIHNlcGFyYXRlIHBhdGNoIGFuZCB0aGVuIGRvIHRoaXMg
Y2xlYW51cCwgc28gYmlzZWN0IGlzIGVhc2llci4NCj4gDQo+IFRoaXMgaGVscGVyIGlzIGRlc2ln
bmVkIGZvciBtYXAgcGF0aHMgd2hlbiB0aGUgSU9NTVUgaXMgaW4gY2FjaGluZyBtb2RlLg0KPiBD
YWNoaW5nIG1vZGUgZG9lc24ndCBpbXBhY3QgdGhlIGRldmljZSBUTEIsIHNvIHdlIHNob3VsZCBu
b3QgaW52YWxpZGF0ZQ0KPiB0aGUgZGV2aWNlIFRMQiBoZXJlLg0KPiANCj4gSSBndWVzcyB0aGUg
Y29uZnVzaW5nIHRoaW5nIGlzIGFib3V0IHRoZSBjb2RlIGJlbG93Lg0KPiANCj4gDQo+ICAgICAg
ICAgIC8qDQo+ICAgICAgICAgICAqIEluIGNhY2hpbmcgbW9kZSwgY2hhbmdlcyBvZiBwYWdlcyBm
cm9tIG5vbi1wcmVzZW50IHRvDQo+IHByZXNlbnQgcmVxdWlyZQ0KPiAgICAgICAgICAgKiBmbHVz
aC4gSG93ZXZlciwgZGV2aWNlIElPVExCIGRvZXNuJ3QgbmVlZCB0byBiZSBmbHVzaGVkIGluDQo+
IHRoaXMgY2FzZS4NCj4gICAgICAgICAgICovDQo+ICAgICAgICAgIGlmICghY2FwX2NhY2hpbmdf
bW9kZShpb21tdS0+Y2FwKSB8fCAhbWFwKQ0KPiAgICAgICAgICAgICAgICAgIGlvbW11X2ZsdXNo
X2Rldl9pb3RsYihkb21haW4sIGFkZHIsIG1hc2spOw0KPiANCj4gVGhlIHJlYWwgY29kZSBkb2Vz
bid0IG1hdGNoIHRoZSBjb21tZW50cywgYW5kIEkgdGhpbmsgdGhlIGNvbW1lbnRzDQo+IGRlc2Ny
aWJlIHRoZSByaWdodCB0aGluZy4gU28gcGVyaGFwcyB0aGUgY29kZSBzaG91bGQgYmUgY2hhbmdl
ZCB0byBtYXRjaA0KPiB0aGUgY29tbWVudHMuDQo+IA0KPiAJaWYgKCFtYXApDQo+IAkJaW9tbXVf
Zmx1c2hfZGV2X2lvdGxiKGRvbWFpbiwgYWRkciwgbWFzayk7DQo+IA0KPiA/Pw0KPiANCg0KeWVz
LiB0aGF0IHNob3VsZCBiZSBmaXhlZCBzZXBhcmF0ZWx5Lg0K

