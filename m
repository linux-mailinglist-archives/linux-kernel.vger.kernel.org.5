Return-Path: <linux-kernel+bounces-134907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F589B886
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95461281DC4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA5E25619;
	Mon,  8 Apr 2024 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaB9NXAo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2983F2561D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561767; cv=fail; b=QhksUq8wn2bWV1uC0fvQVD6FXJI/EDapv3x0DtGK5iDiaAPlyh4IsB2dEPgKzsb6FN2ysjs7HzYrmKgeFyhmWzpxwKu/w1uybErTzqbFMVPp4nG23URYds1jmJKwjtsdwuP5qhaMMJK9vP6/dZ4G8apRXPmcyO1hd05nnrUSU2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561767; c=relaxed/simple;
	bh=DBJI1RZsLdYoCJwPlbABDBiNIpYfcm9fv2vZXdL/sA4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DBU3QTuVBXj6EszkNuKUjPTGFuI34xJ/ovaHFA21LktbvJPNISsIgBNtgc48QpDKJE0zvpg5GPWkWPv3YpZZKOkUz/lYcLxT7tobdUFAvP/1erZWHnjEBgu+5zJKgbSHskeLn+j78QATvzZUZbJDc5WEll6b17/BbSfRP+iNwSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaB9NXAo; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712561766; x=1744097766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DBJI1RZsLdYoCJwPlbABDBiNIpYfcm9fv2vZXdL/sA4=;
  b=XaB9NXAo8V8Zlm0NKUKVuWdFxRhBntWpfRykFzpHjMv1GB34tL27241U
   xQv7StZAsBApgIcbRlnzv2Duk5i/8UYAN4fmxS8htZkb3YAB8RCQKqqak
   JiXQj5Fx14n/Q/MJtwNPVzvqBvjiRvm+U6UnQJyQKkZjqTgfPACam0ORC
   03qN+moS+Lm47VEc/BX5Le7ZIv2o+Du92bP87rZgXJIKOjhRgVCNugi9Q
   zX82gjTiC/BNwV+32kYjr9ykhacmpMnT3WDzApJHaBALNXppVfEPJ2xUg
   Xm6wuqkaXq+wPp3E/5fFrdxcd8oQPZQPIAnIcug1eAwjUqKp6kLDZe3gm
   g==;
X-CSE-ConnectionGUID: 4TFGST9cT1KDH6EpGegnhw==
X-CSE-MsgGUID: J8vML1y8S7uiTJawLkKbvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="25323280"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="25323280"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 00:36:05 -0700
X-CSE-ConnectionGUID: IE7tZUnLTjqdvehO3x0prg==
X-CSE-MsgGUID: 3ANsVI/TTeqOWKxNensG6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="24435595"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 00:36:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 00:36:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 00:36:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 00:36:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 00:36:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1VIACJNXwSuC6hupY2JeH37JcEYHq8aUleTAnh9Id31Nq/66I86yOGqSqJBjYmw56Z4gK1c3aBUKB6iCpBSpZ57JheXAcq2erUtKiSrCbBh/2CkU4dhOPJomfaa5DEv3MpdtH10TSvOX+WTlKGprGxNIwnTZaBBVG//dLHI4wOa9uY3qWgJlAGUbMajq1DZTkSUr2gmOo9+6e4251edlS4cDKIgIh9T1mzZ2X6hoHSUYsSr/qsnHFk8AeF9+zIlDXH4IZKVpaW8SoEP5PP6lWOnKbSYLQp6UmBbmdClBB1S9H+aTLsbDmpGUbl8c9uby9K2Lxu8PAmt1LEb2RS21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBJI1RZsLdYoCJwPlbABDBiNIpYfcm9fv2vZXdL/sA4=;
 b=Co6+6fK9wJfCjHra/oiVo2ykFZcSKVb326I6WwSwccJi3KQR0JblWbwg2L57ClyQ2qn1pcbz8SLkyNi/FXzaCXpPr1gq39ZtpyN8FvGvSKm+zpfWN735/Gjh/ncU4ej2YiPsbwqK9+C6aNQPzAmhLyJGuFUH70YUp5xmzKwJNeAxwx19CL0y7imI9W5S/qM8hjcrFGs6vDoD8uuc0w4A3nIu8GUSjlwYXSAVyxpaKK04zj149rXEJ/NM25HmjiUcMds4TvPXjOnBm0LQwCqO6qRUT5vVWUJpfgc+ncO7iDZJPp9oX/Oyu6RdEYhpTIbUevw1/XNAHvqQ9CMRkVSwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 8 Apr
 2024 07:36:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 07:36:02 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
	<joro@8bytes.org>
CC: "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH] iommu/vt-d: Allocate local memory for page request queue
Thread-Topic: [PATCH] iommu/vt-d: Allocate local memory for page request queue
Thread-Index: AQHahg7nUUsdzXomSUekhTNuGLg2T7FeAmeA
Date: Mon, 8 Apr 2024 07:36:02 +0000
Message-ID: <BN9PR11MB52760B3710E7DDFFC458A35B8C002@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240403214007.985600-1-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20240403214007.985600-1-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8018:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z0v7M6DqN4WONb4eT1jn/qwlLqkngU5xmjQ4CMzJ3j93ebeH8YcQOrB6UG545SOqO+k+xLMo2x6AF/WGLunUH4i68270k0Fs6gIlhsBWUPDbkBhD74XmGSa/YhjsY4vZJk3NC/gkHeaqikAjZJakruvekXBktiUt4nzJ4y94omXSU+qdasAEeGaQFsDr632QgBrpPOHaBbkiFZHk4Z0hZIVnL46Wb5tsPLkFUOYV/f4EdbY95IzV8XGApKVUdOoA4cfBNl5amVXMMORDzs7XT+3ePhvEo6KLM8Y8Dozk1NvOcwPfjojyWp7fZt1xQLF+tOhifw9ZcfBOMu6Qs4chwpYj3mzJ/xODSjOvPOxPsBiB5MAAjH8Qx4CvGaJxXIeApE3N0s3SrKPg43+fs5gr9KGlWMJEyZCAZgejzPn3Z8obOd9G3dthtlx/kXLSna/t2j0dIOt1iP2LgRhzVe5WXoAk/p0CtcakCM+7iGgHJQREP+TuLAFzo6SkiIXuAr75lxPQtaHVoMrx8yuzsoTjmTgHAWwjhBw2u7bfPQDFcSzxj99HMprnrTrnNUsl/2vyh38Wl2lrlJf1kMPf7vyPR6nvTsPCyXwLQkTngiX41duRdl4DJERXn10jb5YIiIiqAvRhhIGdOgE9FWmZwOFwj6O2SdHKJ5smOl8Jl56M9v4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jvJWroTDckohOqQPKaVJm5EIo+Yv3D+c1E012RNIMcWU3KA9MSSSeX/42qc1?=
 =?us-ascii?Q?DTC1XMHdkvKr+nptnVm/o/igFJd0P8cOSIS0Snly4rvbRge5exRx9eOjCqc9?=
 =?us-ascii?Q?FemtZ9DvbCbyT7EqQq6R9W7Xeg9Kv3jkhoCyCKxOUWwEtDLwYXppcV5e/eCo?=
 =?us-ascii?Q?OzFKmqLlesOcQV2yylkIwLSKX3OR/H3fSa2yd1RMX6wDwO2ung3A2ef/u6+I?=
 =?us-ascii?Q?a89RbsYwOvDSgN0hX+YeLVadCARDj3suUyFBvd9d/Tyserfb6Mjd3RRzrpI3?=
 =?us-ascii?Q?gOfSArlfFcuOY6Pl/TwNho8abHd9A83cEZaFHVseWfKCt491RWquWAzqXjMD?=
 =?us-ascii?Q?3Q6pzfr2SuFUy2RoWiD5yxz9Y4GaJb7JcNoUH2TZnHF2lWQAWUSDQNXgJWzX?=
 =?us-ascii?Q?w28qG+tX5EN0tbAb+VKp6R9b90IKNi0FBQKeJJoj/13roPTaUuWerCZyLAs1?=
 =?us-ascii?Q?sakwDVCLZNCZFoW/XUHRuauQRnNRiAA98rQl0guEYecVe3bsqp9SxMjAOuKN?=
 =?us-ascii?Q?AXvgYQyPs6/zbZKTVg7BMYx3/bAM1wYh3SYIXEzr4lc3ydrFUPZawv6W5YGk?=
 =?us-ascii?Q?M+ODmwkoyRu955cxUvbZ5kpv8ARGGX1MfqwAMLOCNgSfY7MlOUtmYjNyh/Xn?=
 =?us-ascii?Q?L6roN+zLH0keITYrjitcHi1egp6V/Kkq6gzrki4qkByKIrICScJy0fRne7Qj?=
 =?us-ascii?Q?NMwsbDKpGsaGtowlbolvTRz4nZBR4BpGLTfFImVjT8CIX8tY3gW45bZ0UgbW?=
 =?us-ascii?Q?UuPM9+Y1Qd1F8n/iL1JfP+JafBhXBA+IFExtbEE4eTmXVwT/EnRWA27xGK3V?=
 =?us-ascii?Q?PzIhkcFprKjHrk4SGWFaXjBcK4Sm8HaTDdsjRbhyXx9Sj+Yw0SwID9Rv+MaU?=
 =?us-ascii?Q?cS1y7ise3uCTErQ01fAr3NEiUQrqoGfG0e4sS+R6c4GqzBP4dkOE7HAAdFS5?=
 =?us-ascii?Q?qca6f/ZKOZoSaJ5jXBbGbUEX/0/0IaQdnb7mKSXawax+Y4IS+M2Mnd8EZLV6?=
 =?us-ascii?Q?oJw4lLQ+8Hc+x1Wwj+HamFf7/scb7PymtCNIHV+9Zo+hUg5T/Vu4+gAIbK6t?=
 =?us-ascii?Q?A+uyXC/TDKNr4EE0mUOtRf/dCwlwhgEAKqkhldDuaMiQCv/xhPDo5mmTiyho?=
 =?us-ascii?Q?OILECUabWyHSL+JbRuPmlfMpP5mtHbtlAIW6u3XJuGy+C7YSAZda1ndKHvAQ?=
 =?us-ascii?Q?b3L3pMG4USJxHUtbDQvAzFjetOrftCm50Mr3sL8Xcp1jSRLfWedtww0autOg?=
 =?us-ascii?Q?zOE/kCimRfQMMQteCJEkpsIORpUAoTzOChmCYxFedFklWKKYbjm7UUVRkdPu?=
 =?us-ascii?Q?5Z72FnL1CcQ6nw+hQNKFGEg6P/9sPcIzaOm7qQCG+x8bkxa15ocYT5Gv2gJG?=
 =?us-ascii?Q?SG7v8Zb/ofk8T7NXmocYbIzhI8NQs2obhvcyRvQbVq8YNGc+ODIkxSyMRl45?=
 =?us-ascii?Q?PX5R9L0UvSHcaRaflRBl05JPpzXAWZgz1SITBB56pwNRYuxpMCv/y6h6f0dB?=
 =?us-ascii?Q?HMxger4NtpZkeoGVe2IdIwXIkuo4lbCpRTXIxOLh5lJhEfUdTRqjp3aYAszg?=
 =?us-ascii?Q?u0h4Oft4nfqCCIlqxnSRO/6gfc4BZDc6AX8NX+93?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103658d9-6b26-49c7-c3aa-08dc579e8af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 07:36:02.7033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PsHfq/lXCWkPryN+hLpogSIF1qZNdnvfs1aebywEkYoScET1p+4mF2DaES5LP8PsypL0q/3N4xIFxUNACw6i2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8018
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, April 4, 2024 5:40 AM
>=20
> The page request queue is per IOMMU, its allocation should be made
> NUMA-aware for performance reasons.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

