Return-Path: <linux-kernel+bounces-144605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B918A4851
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42A11C210DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772DF1DA32;
	Mon, 15 Apr 2024 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6uq7Kra"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF4620315
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163569; cv=fail; b=J8Aw00ZdwQCW9pYIu5Gk9rTfNIisfSRS24qoAJOSiKaZBIimfCQ++YZz+F0raCzxkW7nRHYBzrxmYx92pQb9mnd2slhi4ih73nNVwfS0XjLR/y/VvBEz43hdDz3tck71aWaWThyH81GnHECFzPWyvKSQuCmIlgtF9jW79EVsbvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163569; c=relaxed/simple;
	bh=Ff+AyLF++KwkyytnqRbp181nd6hUwIGDi++VmdM0nCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MfIcWbojLp40/EGxk/glGtHrZi41B5cwvua5FyV0JcRLGxMYeukqGDCcy1oHDwNIX6c+53cp/99GzevkjL+Za+XnEh4EJ/3jw+AhbUnXNdv9pDxehf2wNq/eAF8BGIbN6veqHIR8WiTus2fa4mVFAwtYRWudbnCQ076oy3k2eOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6uq7Kra; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713163567; x=1744699567;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ff+AyLF++KwkyytnqRbp181nd6hUwIGDi++VmdM0nCo=;
  b=h6uq7Kra714cxeX1DG5eJkXA5Bxt3pdLH04okcq7OTWTyCSWso5qaOu+
   yZ1eDnSs/RWRGup76aApX50ldF6O9rlJqqka2TAfvkXlPUbJk+FGehUXx
   1IEZKeqPnhfiFDn2vU0QbcrPzLOrxhe6Maj8QbiEXmN/Y9gR82hDkNywk
   ba1s4U+MtqxwzUR3Rp59Wt5PlHPo0yIyCV5lZxiiYRDZ8sTu//OeXXwkb
   76mebQNEcct9ECGHs4Q7mA3HmKrcBuLJ5bXm+cq5EeFVp6ClZb9ABoyKW
   8U1rvJ3P77+zmmge8E8OswZuO1Q6xQm5GYynFiiT38mdxe5lepTaTtW04
   A==;
X-CSE-ConnectionGUID: smWp05KaQOmkzZJSTYNEQA==
X-CSE-MsgGUID: WkiIuPhcSzKE3oTu2NZZkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19959014"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="19959014"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:46:06 -0700
X-CSE-ConnectionGUID: BCOpJLKrS1CBnVDFd0DA2Q==
X-CSE-MsgGUID: Ox/gTVAHQIuuRsVB5mvZww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="52756783"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Apr 2024 23:46:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 23:46:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Apr 2024 23:46:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Apr 2024 23:46:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdCdYVJ9YWOh/G93juO1yYVBI6OrtQETjfh18k/vSzmaXTcxqsuWhOy95kt6ez2EOMqT16B1EyJJwOKaGyVWo3qp61D98BWfDsAenXIKrL1gWmF9jwud+8NjLfTg7/+tqkfNMiBCt6AJyg3HVl0P8hfUS/1SFeLFjjKPMO0pdYvi4WnPxnXxZyhbhH5DYbIXrMnBMiSLz8L3NWdL/6iwyGd29SCF229kZsj4nh8r2N+8j1uvvGhzLCRwJwBOSHOzCmgvymqk/QrPTQdMIagrsLPWE3A1m9/KA89ZaGDxtss3Wvt2KzZgmYCY8yf769PXbyeMU2a2K6b/40QtmTSvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ff+AyLF++KwkyytnqRbp181nd6hUwIGDi++VmdM0nCo=;
 b=NX1+TS8BKTNhy0XDWS4aTThDaERhJMS67ayrzyquIHNI7rDW1wpAF/MJuGabBA2aZz0fbwnfzJfpB1xbZ9Zliq3rJ7Z+53mhwiCaWpYaTsPsFXqYg9Eo0B+MLq0FKgYgzq9j6j5i/PHJR6m/zJ4wO0GNPwlfDwyHnSjfbqn/Uw+sg0U15K+kyW7jmLDBfCkjXIDyHAHU5ipwedubf3O69/epDZNerwkcGazvpgiZ/UOGG4Q/tI22Q7/TDVxNaQzaBlQ61hTPmVwu/jr23+o6RiaDrebS51143RGijVR94VfaAgJ+6yVKGt+bp3QKXAr+e1HNRkSgba7lQj2mWS65eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Mon, 15 Apr
 2024 06:46:03 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::5d0:a6da:a53e:e990]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::5d0:a6da:a53e:e990%6]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 06:46:03 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Tian, Kevin"
	<kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 02/12] iommu/vt-d: Add cache tag invalidation helpers
Thread-Topic: [PATCH v2 02/12] iommu/vt-d: Add cache tag invalidation helpers
Thread-Index: AQHaiuw7gyA3rCRQvUattkDbYgfhd7FosdxQgAAdt4CAABkQgA==
Date: Mon, 15 Apr 2024 06:46:03 +0000
Message-ID: <MW5PR11MB5881811A9C51D34255618B6289092@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
 <20240410020844.253535-3-baolu.lu@linux.intel.com>
 <MW5PR11MB5881FE21211FCED9B9BCBAB189092@MW5PR11MB5881.namprd11.prod.outlook.com>
 <285d70cc-f65b-4d76-81cf-c9da2952dcf2@linux.intel.com>
In-Reply-To: <285d70cc-f65b-4d76-81cf-c9da2952dcf2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|PH0PR11MB5045:EE_
x-ms-office365-filtering-correlation-id: 10f11830-39d1-44ba-f6bf-08dc5d17b80e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 43kxx4f1Q7z5F7Bbm41BMR5Dd7HGKDgOX/KKyVrjWBlm8sgQNk30FqzImn5Ud4HNrS6k/gGXtSNzgcSWbGozDN1PWIjr+DreGOjDcV+BNXnMWCfTGVAs85cnbhXBcv07x6imdrTi0Wi5bqOWIQ/us8RTRpgQKCYzQtX95PCd5vnQ05XXtg9OmRDAGBKcle9MpKOc47XAimfBbMJ2oee7jsIqqvo/6y/35lsyug4Xusa/jdIXSPYMtPsSxekQs0VK0a+wTEKBg1DqUI/YpI4K9jHZMj8xynZJBN8yImxRaON4CeQKNWnS7ZLwfJjk8w/rTAdMBAz7OwSTotI12UlldN3iRyKvMXgQuO+BfxU/uX5rEXBA6MZhOylH7apPu2pKtFJ41gb1qTfli6OntiZKxdb7kGDUkHJczyUaCjlF4DjzqnMmfqglavLodPiWSnA+GdBu3nnpEdirj0grlYSR11fWqe26SWzWYvVNjfUivXKCmfRSQDOWc+ekjjvnkrklMK8mElLl5u9I7oyrp5urxZAcYpOjYhXGuUOer0uARwMx2p2SE8Zpx3T02AMxKXzhY6CvD5/xWiKNdFXeqA00Dgi4CXoKFe9OdMomPu824q9qALfQwWZwHbX7CebpTFB8l2brLHyJLPyLJUg1ZHDukb4P49+r72v3x82i8abcGh3lzm/ZYGmXc/m7bDP8MNqjRgutxa4rc3yC7pxcM9Y8Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGlhWVZqUi9hYVo0cEkwOU8xUUtscXlFZmE0cjMwYTB3SE54QWFieXVDVjFP?=
 =?utf-8?B?bEZDYi9raytYSlVDZkdXL2VsS2p0N1NTb0lmR0RmVFZzSzJIeE1ZRk85NTNR?=
 =?utf-8?B?Qm9EZ1NBd0taeTJ5b0JqNVFNaXBNN2FWMkNGeFo1KzROTm9WU1RpeTRESU5a?=
 =?utf-8?B?Um1JSHhweHdkL0VMaTJCcC82N3JrUjQzVVRESUJPbUJoeVowMWFpTGxBYlhR?=
 =?utf-8?B?MlZoVDM3Z2dBRlVsZEEzVmVKSC9WbWZCcEg3UDlJZzgvdnVtV2dHRUFnT0xa?=
 =?utf-8?B?MEUxcmh0dy9aYmg4S25Ed1Y0dEkvUXBnTzFsNjhoNVdhdHhZdUFrdDQzRVQw?=
 =?utf-8?B?RVdQTDlTbmFrOUM5L3AydTBJZ09RZHpYUHJUenlMT2pySGpvYlJ4bG5nY1kx?=
 =?utf-8?B?VTRYcUlVTHBKTnQ4L3RLaDZWUE5wZ3NtUWNZREVuMG5GK2NlOFRxK24yOXZt?=
 =?utf-8?B?aXd5N0JhajJQQkVnTG9TZUpmMWJXNnZrNnZNT1hjd2haYml0NFgrSkNleEJB?=
 =?utf-8?B?Nll6THpuemZCNi9IaDhzSzZsdzYzc0lERlFFNDRjbUZvVWU0WjdySnNaK1Zr?=
 =?utf-8?B?OCtLUzJPa2haMjZIcW5IZU1mN3ZMbnZDVG9zVEV6WGlaN01jWE5TNEczNWpa?=
 =?utf-8?B?ZFpETHRxWW12TDlKOUZJWExZS0VqVkp5VnBVVlZJM0NWYldWc0JWUit5elZn?=
 =?utf-8?B?aW9VVWsxOEcvV21Ub2JxaE9VME5NbGJCY01BQ04xMWdJcFErTzAxS2Noa2xW?=
 =?utf-8?B?OW94VDB4UHVXWkp2WER6QkVpOEJ0Y1l2NHU5Z1dHQ082Sy9kamNZVS9DdFFx?=
 =?utf-8?B?WU5SQlBGQTZaV2NxMUluTHZHa3oxWHVxcWN3Y3FLTEhLODBmUC9PM01iTmg2?=
 =?utf-8?B?TlFQZzlsSHNmTEFXUTE0K1JXeTFJU2ZyRW5xbDNuZlQ5YWpUVjRoSnRpclNC?=
 =?utf-8?B?OUxvYmFoRCsxbmUwVXMvY3JHcUpyeElTa0VrZVFWVkVPNUdMOUE3amRiZkEy?=
 =?utf-8?B?RGtvRURkakUxaDE3bUI2SlY0aklrWCtzVEwxd1JkeDgvYi9PVENRU09tVWV4?=
 =?utf-8?B?UkxHVzJGaU10MjFYa2VQRmYweE9jMTVQTUt0VkJVdW5IU2ZGdzdlWEZZazVZ?=
 =?utf-8?B?NXV6VUVYTHhRVnFmaEFVQkNKS0RjZUcxWkhBdElJcVFJNG9wc1UvUW9YREV6?=
 =?utf-8?B?U3g4STJTRzZqa0FsS005OWJZTkMzeUk0OUZzNXl2eDlpSlRkRXdZOWRmSGY3?=
 =?utf-8?B?cnVVUStKdHpiOVNSampneG94aTFzYlVqL0JDT3N2ZjBScmgvWUFPdkcvZWxC?=
 =?utf-8?B?OTE4NThwU3dESEZEaUxwTElUa2dqcllERUdkOHFnNDg2TUdpalV0blBKSHdn?=
 =?utf-8?B?YTR1cGxaeVBWd3llWFZQcVpsbGpib2ZpYkVpK29BTWNJOEFqbWtoOThHdkdm?=
 =?utf-8?B?R1BZSWk1RllrYm9iWU5BVnhTNWhQTnhDWUZqTEtKNm9iamFSVmxpVllLTUFz?=
 =?utf-8?B?b0lIN0oyeTRFL2JXaEtvZkJ6b2dOQ2dlUE1nbUloUWVTVkY4TEdrVnJOdklL?=
 =?utf-8?B?a3NJSnRwR3RaNTNOeXp3c1VaczhNbUMvZmVWaFp4QmJBNnlzMXFiVHgwUjVE?=
 =?utf-8?B?KzVmaGJSWTJUcDZIcHhXU1NMQlpQSk1GK2ZPWmtSRzk4eFAvMGJjUnQrVUNh?=
 =?utf-8?B?czd3dHhXb1ZpZ2gwODVML2lOcDFLZkVmMjN1emFXQWZQQzJwc0IvN08wZWFl?=
 =?utf-8?B?UEJ2dVcwUXVZeUdiMHhFUWhhZjJXNmtIZVZoRW9QSGxSMUM3RU5welZPR3V6?=
 =?utf-8?B?RVZpQnUwWldEZ2NmYU1PTXNnMG1tVTJ2QlVuaG04OTcvaXZpN1c0NmdzZFpP?=
 =?utf-8?B?dENSZGppU1dubFJ0S0dHbWtQZ0QyMjFDeUZnK2VtT3JXNnpnQ2pJUDJscWpX?=
 =?utf-8?B?WUl3c3NMM0pXYURTaGR3OVJHRUZRbEZ2Y3hHaXYxbDFPOVV2S1B0S1c4Umpu?=
 =?utf-8?B?aW8xVEtjSGZVcDZvTlJuN2tXeXh2RHdwWUphc2NycUYrVkpwbDFRL1pjVUxU?=
 =?utf-8?B?YUxneTVRZlNlZWFLczFQRjFueWFnejA1VlhNN3JObzhqdTN5bFN5bndhL1Mr?=
 =?utf-8?Q?Ue3shgvYglKQISliiMfIpGnr8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f11830-39d1-44ba-f6bf-08dc5d17b80e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 06:46:03.2789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JfOLk+GbMv59aV6nP3diYIfwrAuIIlyOAtoeGOvMi1MeZ12jtQDZVcHkb3H5VQK+6xB096Uy9cjzqt8mgzRgcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5045
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUgTHUgPGJhb2x1
Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBBcHJpbCAxNSwgMjAyNCAxOjA3
IFBNDQo+IFRvOiBaaGFuZywgVGluYSA8dGluYS56aGFuZ0BpbnRlbC5jb20+OyBKb2VyZyBSb2Vk
ZWwgPGpvcm9AOGJ5dGVzLm9yZz47DQo+IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+OyBS
b2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPjsNCj4gVGlhbiwgS2V2aW4gPGtldmlu
LnRpYW5AaW50ZWwuY29tPjsgSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+DQo+IENjOiBi
YW9sdS5sdUBsaW51eC5pbnRlbC5jb207IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPjsN
Cj4gaW9tbXVAbGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDIvMTJdIGlvbW11L3Z0LWQ6IEFkZCBjYWNoZSB0YWcg
aW52YWxpZGF0aW9uDQo+IGhlbHBlcnMNCj4gDQo+IE9uIDQvMTUvMjQgMTI6MTUgUE0sIFpoYW5n
LCBUaW5hIHdyb3RlOg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+
IEZyb206IEx1IEJhb2x1PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPj4gU2VudDogV2Vk
bmVzZGF5LCBBcHJpbCAxMCwgMjAyNCAxMDowOSBBTQ0KPiA+PiBUbzogSm9lcmcgUm9lZGVsPGpv
cm9AOGJ5dGVzLm9yZz47IFdpbGwgRGVhY29uPHdpbGxAa2VybmVsLm9yZz47DQo+ID4+IFJvYmlu
IE11cnBoeTxyb2Jpbi5tdXJwaHlAYXJtLmNvbT47IFRpYW4sDQo+ID4+IEtldmluPGtldmluLnRp
YW5AaW50ZWwuY29tPjsgSmFzb24gR3VudGhvcnBlPGpnZ0B6aWVwZS5jYT4NCj4gPj4gQ2M6IFpo
YW5nLCBUaW5hPHRpbmEuemhhbmdAaW50ZWwuY29tPjsgTGl1LCBZaSBMPHlpLmwubGl1QGludGVs
LmNvbT47DQo+ID4+IGlvbW11QGxpc3RzLmxpbnV4LmRldjtsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBMdSBCYW9sdQ0KPiA+PiA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+PiBT
dWJqZWN0OiBbUEFUQ0ggdjIgMDIvMTJdIGlvbW11L3Z0LWQ6IEFkZCBjYWNoZSB0YWcgaW52YWxp
ZGF0aW9uDQo+ID4+IGhlbHBlcnMNCj4gPj4NCj4gPj4gQWRkIHNldmVyYWwgaGVscGVycyB0byBp
bnZhbGlkYXRlIHRoZSBjYWNoZXMgYWZ0ZXIgbWFwcGluZ3MgaW4gdGhlDQo+ID4+IGFmZmVjdGVk
IGRvbWFpbiBhcmUgY2hhbmdlZC4NCj4gPj4NCj4gPj4gLSBjYWNoZV90YWdfZmx1c2hfcmFuZ2Uo
KSBpbnZhbGlkYXRlcyBhIHJhbmdlIG9mIGNhY2hlcyBhZnRlciBtYXBwaW5ncw0KPiA+PiAgICB3
aXRoaW4gdGhpcyByYW5nZSBhcmUgY2hhbmdlZC4gSXQgdXNlcyB0aGUgcGFnZS1zZWxlY3RpdmUg
Y2FjaGUNCj4gPj4gICAgaW52YWxpZGF0aW9uIG1ldGhvZHMuDQo+ID4+DQo+ID4+IC0gY2FjaGVf
dGFnX2ZsdXNoX2FsbCgpIGludmFsaWRhdGVzIGFsbCBjYWNoZXMgdGFnZ2VkIGJ5IGEgZG9tYWlu
IElELg0KPiA+PiAgICBJdCB1c2VzIHRoZSBkb21haW4tc2VsZWN0aXZlIGNhY2hlIGludmFsaWRh
dGlvbiBtZXRob2RzLg0KPiA+Pg0KPiA+PiAtIGNhY2hlX3RhZ19mbHVzaF9yYW5nZV9ucCgpIGlu
dmFsaWRhdGVzIGEgcmFuZ2Ugb2YgY2FjaGVzIHdoZW4gbmV3DQo+ID4+ICAgIG1hcHBpbmdzIGFy
ZSBjcmVhdGVkIGluIHRoZSBkb21haW4gYW5kIHRoZSBjb3JyZXNwb25kaW5nIHBhZ2UgdGFibGUN
Cj4gPj4gICAgZW50cmllcyBjaGFuZ2UgZnJvbSBub24tcHJlc2VudCB0byBwcmVzZW50Lg0KPiA+
Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBMdSBCYW9sdTxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+
DQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuaCB8ICAxNCArKysN
Cj4gPj4gICBkcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMgfCAxOTUNCj4gPj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+ICAgZHJpdmVycy9pb21tdS9pbnRlbC9p
b21tdS5jIHwgIDEyIC0tLQ0KPiA+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMjA5IGluc2VydGlvbnMo
KyksIDEyIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9pbnRlbC9pb21tdS5oDQo+ID4+IGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5oIGluZGV4
IDZmNmJmZmM2MDg1Mi4uNzAwNTc0NDIxYjUxDQo+IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJz
L2lvbW11L2ludGVsL2lvbW11LmgNCj4gPj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21t
dS5oDQo+ID4+IEBAIC0zNSw2ICszNSw4IEBADQo+ID4+ICAgI2RlZmluZSBWVERfUEFHRV9NQVNL
CQkoKCh1NjQpLTEpIDw8IFZURF9QQUdFX1NISUZUKQ0KPiA+PiAgICNkZWZpbmUgVlREX1BBR0Vf
QUxJR04oYWRkcikJKCgoYWRkcikgKyBWVERfUEFHRV9TSVpFIC0gMSkgJg0KPiA+PiBWVERfUEFH
RV9NQVNLKQ0KPiA+Pg0KPiA+PiArI2RlZmluZSBJT1ZBX1BGTihhZGRyKQkJKChhZGRyKSA+PiBQ
QUdFX1NISUZUKQ0KPiA+PiArDQo+ID4+ICAgI2RlZmluZSBWVERfU1RSSURFX1NISUZUICAgICAg
ICAoOSkNCj4gPj4gICAjZGVmaW5lIFZURF9TVFJJREVfTUFTSyAgICAgICAgICgoKHU2NCktMSkg
PDwgVlREX1NUUklERV9TSElGVCkNCj4gPj4NCj4gPj4gQEAgLTEwNDEsNiArMTA0MywxMyBAQCBz
dGF0aWMgaW5saW5lIHZvaWQgY29udGV4dF9zZXRfc21fcHJlKHN0cnVjdA0KPiA+PiBjb250ZXh0
X2VudHJ5ICpjb250ZXh0KQ0KPiA+PiAgIAljb250ZXh0LT5sbyB8PSBCSVRfVUxMKDQpOw0KPiA+
PiAgIH0NCj4gPj4NCj4gPj4gKy8qIFJldHVybnMgYSBudW1iZXIgb2YgVlREIHBhZ2VzLCBidXQg
YWxpZ25lZCB0byBNTSBwYWdlIHNpemUgKi8NCj4gPj4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQg
bG9uZyBhbGlnbmVkX25ycGFnZXModW5zaWduZWQgbG9uZyBob3N0X2FkZHIsDQo+ID4+ICtzaXpl
X3QNCj4gPj4gK3NpemUpIHsNCj4gPj4gKwlob3N0X2FkZHIgJj0gflBBR0VfTUFTSzsNCj4gPj4g
KwlyZXR1cm4gUEFHRV9BTElHTihob3N0X2FkZHIgKyBzaXplKSA+PiBWVERfUEFHRV9TSElGVDsg
fQ0KPiA+PiArDQo+ID4+ICAgLyogQ29udmVydCB2YWx1ZSB0byBjb250ZXh0IFBBU0lEIGRpcmVj
dG9yeSBzaXplIGZpZWxkIGNvZGluZy4gKi8NCj4gPj4gICAjZGVmaW5lIGNvbnRleHRfcGR0cyhw
ZHMpCSgoKHBkcykgJiAweDcpIDw8IDkpDQo+ID4+DQo+ID4+IEBAIC0xMTE2LDYgKzExMjUsMTEg
QEAgaW50IGNhY2hlX3RhZ19hc3NpZ25fZG9tYWluKHN0cnVjdA0KPiBkbWFyX2RvbWFpbg0KPiA+
PiAqZG9tYWluLCB1MTYgZGlkLA0KPiA+PiAgIAkJCSAgICBzdHJ1Y3QgZGV2aWNlICpkZXYsIGlv
YXNpZF90IHBhc2lkKTsgIHZvaWQNCj4gPj4gY2FjaGVfdGFnX3VuYXNzaWduX2RvbWFpbihzdHJ1
Y3QgZG1hcl9kb21haW4gKmRvbWFpbiwgdTE2IGRpZCwNCj4gPj4gICAJCQkgICAgICAgc3RydWN0
IGRldmljZSAqZGV2LCBpb2FzaWRfdCBwYXNpZCk7DQo+ID4+ICt2b2lkIGNhY2hlX3RhZ19mbHVz
aF9yYW5nZShzdHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbiwgdW5zaWduZWQgbG9uZw0KPiA+PiBz
dGFydCwNCj4gPj4gKwkJCSAgIHVuc2lnbmVkIGxvbmcgZW5kLCBpbnQgaWgpOw0KPiA+PiArdm9p
ZCBjYWNoZV90YWdfZmx1c2hfYWxsKHN0cnVjdCBkbWFyX2RvbWFpbiAqZG9tYWluKTsgdm9pZA0K
PiA+PiArY2FjaGVfdGFnX2ZsdXNoX3JhbmdlX25wKHN0cnVjdCBkbWFyX2RvbWFpbiAqZG9tYWlu
LCB1bnNpZ25lZCBsb25nDQo+ID4+IHN0YXJ0LA0KPiA+PiArCQkJICAgICAgdW5zaWduZWQgbG9u
ZyBlbmQpOw0KPiA+Pg0KPiA+PiAgICNpZmRlZiBDT05GSUdfSU5URUxfSU9NTVVfU1ZNDQo+ID4+
ICAgdm9pZCBpbnRlbF9zdm1fY2hlY2soc3RydWN0IGludGVsX2lvbW11ICppb21tdSk7IGRpZmYg
LS1naXQNCj4gPj4gYS9kcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMgYi9kcml2ZXJzL2lvbW11
L2ludGVsL2NhY2hlLmMgaW5kZXgNCj4gPj4gZGViYmRhZWZmMWM0Li5iMjI3MGRjOGE3NjUgMTAw
NjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYw0KPiA+PiArKysgYi9k
cml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMNCj4gPj4gQEAgLTEyLDYgKzEyLDcgQEANCj4gPj4g
ICAjaW5jbHVkZSA8bGludXgvZG1hci5oPg0KPiA+PiAgICNpbmNsdWRlIDxsaW51eC9pb21tdS5o
Pg0KPiA+PiAgICNpbmNsdWRlIDxsaW51eC9tZW1vcnkuaD4NCj4gPj4gKyNpbmNsdWRlIDxsaW51
eC9wY2kuaD4NCj4gPj4gICAjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4NCj4gPj4NCj4gPj4g
ICAjaW5jbHVkZSAiaW9tbXUuaCINCj4gPj4gQEAgLTE5NCwzICsxOTUsMTk3IEBAIHZvaWQgY2Fj
aGVfdGFnX3VuYXNzaWduX2RvbWFpbihzdHJ1Y3QNCj4gPj4gZG1hcl9kb21haW4gKmRvbWFpbiwg
dTE2IGRpZCwNCj4gPj4gICAJaWYgKGRvbWFpbi0+ZG9tYWluLnR5cGUgPT0gSU9NTVVfRE9NQUlO
X05FU1RFRCkNCj4gPj4gICAJCV9fY2FjaGVfdGFnX3VuYXNzaWduX3BhcmVudF9kb21haW4oZG9t
YWluLT5zMl9kb21haW4sDQo+ID4+IGRpZCwgZGV2LCBwYXNpZCk7ICB9DQo+ID4+ICsNCj4gPj4g
K3N0YXRpYyB1bnNpZ25lZCBsb25nIGNhbGN1bGF0ZV9wc2lfYWxpZ25lZF9hZGRyZXNzKHVuc2ln
bmVkIGxvbmcgc3RhcnQsDQo+ID4+ICsJCQkJCQkgICB1bnNpZ25lZCBsb25nIGVuZCwNCj4gPj4g
KwkJCQkJCSAgIHVuc2lnbmVkIGxvbmcgKl9wYWdlcywNCj4gPj4gKwkJCQkJCSAgIHVuc2lnbmVk
IGxvbmcgKl9tYXNrKQ0KPiA+PiArew0KPiA+PiArCXVuc2lnbmVkIGxvbmcgcGFnZXMgPSBhbGln
bmVkX25ycGFnZXMoc3RhcnQsIGVuZCAtIHN0YXJ0ICsgMSk7DQo+ID4+ICsJdW5zaWduZWQgbG9u
ZyBhbGlnbmVkX3BhZ2VzID0gX19yb3VuZHVwX3Bvd19vZl90d28ocGFnZXMpOw0KPiA+PiArCXVu
c2lnbmVkIGxvbmcgYml0bWFzayA9IGFsaWduZWRfcGFnZXMgLSAxOw0KPiA+PiArCXVuc2lnbmVk
IGxvbmcgbWFzayA9IGlsb2cyKGFsaWduZWRfcGFnZXMpOw0KPiA+PiArCXVuc2lnbmVkIGxvbmcg
cGZuID0gSU9WQV9QRk4oc3RhcnQpOw0KPiA+PiArDQo+ID4+ICsJLyoNCj4gPj4gKwkgKiBQU0kg
bWFza3MgdGhlIGxvdyBvcmRlciBiaXRzIG9mIHRoZSBiYXNlIGFkZHJlc3MuIElmIHRoZQ0KPiA+
PiArCSAqIGFkZHJlc3MgaXNuJ3QgYWxpZ25lZCB0byB0aGUgbWFzaywgdGhlbiBjb21wdXRlIGEg
bWFzayB2YWx1ZQ0KPiA+PiArCSAqIG5lZWRlZCB0byBlbnN1cmUgdGhlIHRhcmdldCByYW5nZSBp
cyBmbHVzaGVkLg0KPiA+PiArCSAqLw0KPiA+PiArCWlmICh1bmxpa2VseShiaXRtYXNrICYgcGZu
KSkgew0KPiA+PiArCQl1bnNpZ25lZCBsb25nIGVuZF9wZm4gPSBwZm4gKyBwYWdlcyAtIDEsIHNo
YXJlZF9iaXRzOw0KPiA+PiArDQo+ID4+ICsJCS8qDQo+ID4+ICsJCSAqIFNpbmNlIGVuZF9wZm4g
PD0gcGZuICsgYml0bWFzaywgdGhlIG9ubHkgd2F5IGJpdHMNCj4gPj4gKwkJICogaGlnaGVyIHRo
YW4gYml0bWFzayBjYW4gZGlmZmVyIGluIHBmbiBhbmQgZW5kX3BmbiBpcw0KPiA+PiArCQkgKiBi
eSBjYXJyeWluZy4gVGhpcyBtZWFucyBhZnRlciBtYXNraW5nIG91dCBiaXRtYXNrLA0KPiA+PiAr
CQkgKiBoaWdoIGJpdHMgc3RhcnRpbmcgd2l0aCB0aGUgZmlyc3Qgc2V0IGJpdCBpbg0KPiA+PiAr
CQkgKiBzaGFyZWRfYml0cyBhcmUgYWxsIGVxdWFsIGluIGJvdGggcGZuIGFuZCBlbmRfcGZuLg0K
PiA+PiArCQkgKi8NCj4gPj4gKwkJc2hhcmVkX2JpdHMgPSB+KHBmbiBeIGVuZF9wZm4pICYgfmJp
dG1hc2s7DQo+ID4+ICsJCW1hc2sgPSBzaGFyZWRfYml0cyA/IF9fZmZzKHNoYXJlZF9iaXRzKSA6
IEJJVFNfUEVSX0xPTkc7DQo+ID4+ICsJfQ0KPiA+PiArDQo+ID4+ICsJKl9wYWdlcyA9IGFsaWdu
ZWRfcGFnZXM7DQo+ID4+ICsJKl9tYXNrID0gbWFzazsNCj4gPj4gKw0KPiA+PiArCXJldHVybiBB
TElHTl9ET1dOKHN0YXJ0LCBWVERfUEFHRV9TSVpFKTsgfQ0KPiA+IEl0J3MgYSBnb29kIGlkZWEg
dG8gdXNlIHRoZSBhYm92ZSBsb2dpYyB0byBjYWxjdWxhdGUgdGhlIGFwcHJvcHJpYXRlIG1hc2sg
Zm9yDQo+IG5vbi1zaXplLWFsaWduZWQgcGFnZSBzZWxlY3RpdmUgaW52YWxpZGF0aW9uIGZvciBh
bGwgZG9tYWlucywgaW5jbHVkaW5nIHN2YQ0KPiBkb21haW4uIFNvdW5kcyBsaWtlIHdlIHBsYW4g
dG8gYWxsb3cgbm9uLXNpemUtYWxpZ25lZCBwYWdlIHNlbGVjdGlvbg0KPiBpbnZhbGlkYXRpb24u
DQo+ID4NCj4gPiBIb3dldmVyLCBjdXJyZW50bHkgdGhlcmUgYXJlIHNvbWUgcGxhY2VzIGluIHRo
ZSBjb2RlIHdoaWNoIGhhdmUgdGhlDQo+IGFzc3VtcHRpb24gdGhhdCB0aGUgc2l6ZSBvZiB0aGUg
cGFnZSBzZWxlY3RpdmUgaW52YWxpZGF0aW9uIHNob3VsZCBiZSBhbGlnbmVkDQo+IHdpdGggdGhl
IHN0YXJ0IGFkZHJlc3MsIGEuay5hLiBvbmx5IHNpemUtYWxpZ25lZCBwYWdlIHNlbGVjdGl2ZSBp
bnZhbGlkYXRpb24NCj4gc2hvdWxkIGhhcHBlbiBhbmQgbm9uLXNpemUtYWxpZ25lZCBvbmUgaXNu
J3QgZXhwZWN0ZWQuDQo+ID4NCj4gPiBPbmUgZXhhbXBsZSBpcyBpbiBxaV9mbHVzaF9kZXZfaW90
bGJfcGFzaWQoKSBhbmQgdGhlcmUgaXMgYSBjaGVja2luZzoNCj4gPiAJaWYgKCFJU19BTElHTkVE
KGFkZHIsIFZURF9QQUdFX1NJWkUgPDwgc2l6ZV9vcmRlcikNCj4gPiAJCXByX3dhcm5fcmF0ZWxp
bWl0ZWQoLi4uKQ0KPiA+IElmIHRoZSBub24tc2l6ZS1hbGlnbmVkIHBhZ2Ugc2VsZWN0aXZlIGlu
dmFsaWRhdGlvbiBpcyBhbGxvd2VkLCB0aGUgd2FybmluZw0KPiBtZXNzYWdlIG1heSBjb21lIG91
dCB3aGljaCBzb3VuZHMgY29uZnVzaW5nIGFuZCBpbXBhY3RzIHBlcmZvcm1hbmNlLg0KPiA+DQo+
ID4gQW5vdGhlciBleGFtcGxlIGlzIGluIHFpX2ZsdXNoX3Bpb3RsYigpIGFuZCB0aGVyZSBpcyBh
IFdBUk5fT05fT05DRSgpIHRvDQo+IHJlbWluZCB1c2VyIHdoZW4gbm9uLXNpemUtYWxpZ25lZCBw
YWdlIHNlbGVjdGl2ZSBpbnZhbGlkYXRpb24gaXMgYmVpbmcgdXNlZC4NCj4gPiAJSWYgKFdBUk5f
T05fT05DRSghSVNfQUxJR05FRChhZGRyLCBhbGlnbikpDQo+ID4gCQkuLi4NCj4gPg0KPiA+IFNv
LCBjYW4gd2UgY29uc2lkZXIgcmVtb3ZpbmcgdGhlIGNoZWNraW5nIGFzIHdlbGwgaW4gdGhpcyBw
YXRjaC1zZXQ/DQo+IA0KPiBUaGlzIHNlcmllcyBkb2Vzbid0IGludGVuZCB0byBjaGFuZ2UgdGhl
IGRyaXZlcidzIGJlaGF2aW9yLCBzbyB0aGUgY2hlY2sgYW5kDQo+IHdhcm5pbmcgeW91IG1lbnRp
b25lZCBzaG91bGQgYmUga2VwdC4gVGhlIGlvbW11IGNvcmUgZW5zdXJlcyB0aGUNCj4gaW52YWxp
ZGF0aW9uIHNpemUgaXMgcGFnZS1zaXplIGFsaWduZWQuIFRob3NlIGNoZWNrcyBpbiB0aGUgaW9t
bXUgZHJpdmVyIGp1c3QNCj4gbWFrZSBzdXJlIHRoYXQgdGhlIGNhbGxlcnMgYXJlIGRvaW5nIHRo
aW5ncyByaWdodC4NClRoZSBmYWN0IGlzIHRoaXMgcGF0Y2ggYWltcyB0byBhbGxvdyBub24tc2l6
ZS1hbGlnbmVkIHBhZ2Ugc2VsZWN0aXZlIGludmFsaWRhdGlvbiB3aGljaCBhcmVuJ3QgZXhwZWN0
ZWQgYnkgdGhvc2Ugd2FybmluZyBtZXNzYWdlcy4gDQoNClNvLCBlaXRoZXIgd2UgZGlzYWJsZSB1
c2Ugbm9uLXNpemUtYWxpZ25lZCBwYWdlIHNlbGVjdGl2ZSBpbnZhbGlkYXRpb24ganVzdCBsaWtl
IHdoYXQgd2UgZGlkIHByZXZpb3VzbHkgZm9yIHN2YSBkb21haW4sIG9yIHdlIHJlbW92ZSB0aG9z
ZSB3YXJuaW5nIG1lc3NhZ2VzIGFuZCB1c2Ugbm9uLXNpemUtYWxpZ25lZCBwYWdlIHNlbGVjdGl2
ZSBpbnZhbGlkYXRpb24gaW50cm9kdWNlZCBpbiB0aGlzIHBhdGNoIGZvciBzdmEgZG9tYWluLg0K
DQpSZWdhcmRzLA0KLVRpbmENCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gYmFvbHUNCg==

