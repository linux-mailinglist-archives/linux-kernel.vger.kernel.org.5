Return-Path: <linux-kernel+bounces-136346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7EB89D2EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521251C224E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204DF7BAFE;
	Tue,  9 Apr 2024 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hc30wti4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDD977F32
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647300; cv=fail; b=tgWj5hu1yF///Wooic+Hp8PYXB7cvBqJ5V+GPlfghJzY0mXWtOOUA20p1PldqGTq4FkNKNHn47WWpsy/dQ4ptXA3lBGs1XjlxW8JVPaFeZGp1wDUVSP13XRGpl1ChYd/UVQkRSUqUlz9ApSuBW263KhjPZKSSO770G6F3fdkfaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647300; c=relaxed/simple;
	bh=BDwVCLaoZJd5zVJzA8wwXpjJwy4MEOaFs+Ar5iIfSOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=afaAnPmfPzLhULsDAWuMp+yUeDSgFhIzOI3Xgjqs6ZUS2EMdFQCVs9wm5Mq5iQO1XdpYw+XA7v5MEo/zXSKejgA5WPbKwqKWz0yGfX1fG+WZL4Tuy2m1IwC4kGx+Ayx90FsbTf5JUzZLDEdUnYlLi6M+mhs8hhMEu+1KqvMDiHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hc30wti4; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712647299; x=1744183299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BDwVCLaoZJd5zVJzA8wwXpjJwy4MEOaFs+Ar5iIfSOI=;
  b=Hc30wti4XvX4aYQnd2t0QMAZMQ9JmjBqt0PmBwhyKrqKMta2TCO90qE/
   EcmCkDgZ0cfYKLeIcO7IUBiSpTycmNG43hRZINeXuxJW/7fw7/I6vLMDH
   eBvji2PDWdHODiBa5fdtLvjshmIg7bB0GcaTMX9AZccWy0T6WqyGRinw/
   xvx0dMxDMIvWAhOpM2Vw3Ikr+w1g9L9yyA1NExQxeHF8ZAz2d+4CPjp+3
   337IWswrY6fnFDR8id4oiOiCnYI4jTu+JYV9RinEv5k6GdAfEKC62xAU9
   bN70uuKgYKZM9Blt9VRKDUZMEG6GU2667lGQ0Mpk9Szigut7vPWjr1yvF
   Q==;
X-CSE-ConnectionGUID: 2Bl1vGLrSqiYZwaacWe4zw==
X-CSE-MsgGUID: XHps4roVQJec/WTSeKTmCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="25450678"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="25450678"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 00:21:38 -0700
X-CSE-ConnectionGUID: AHfuhQsRT9WOPpeEvN3PXg==
X-CSE-MsgGUID: wy5rXLdaTsarA9Yy2yPYVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20099629"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 00:21:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 00:21:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 00:21:37 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 00:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiMSzW64uh/WimPslORZ0LKQ+v3ybNgaKkOzriTtDBY2AY4/V2kOTTsk11s7maaHT8/LgLbbUUYOv6x3fgnxWKtJPE7hXjgcz4vbgiCvOg48fXRAGeJzG7n61Loelic5eC++w0uaeWadNRJ/v+ceVA1uaLtmlBF8i4Y1udtE18x2MKGcNfn4sc3F9uNcRPGoO2meEmMI+u+oGz6GF7Xk3+q5bEhI26e0BlenXRJ/VJAst4exeS8myznOlj8Xi+K7f0VNNkT4lyovtt8yGrSmvJX9xCXP1pccqo2ApSHlX6N79bKaKkDLg23bM/rzRIWrTcws8NbxLDqwqDhyLYBwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDwVCLaoZJd5zVJzA8wwXpjJwy4MEOaFs+Ar5iIfSOI=;
 b=RoVVdcZZ/7lK7pkXpX9gcKX+CWkXiz6Q4yFZxr2qsfDkEiYQ782AgAO5W1p7A8k5BUSD40XqbotO/6Tb1AR4T69Cz8JHlOekpW8aenlOftFU3n8r8tbzCdytvmGDson0mjN+0ShhKaz2W7q07ysSJUwbQ9rJGLh5hgkg4UA9P6Rkb/Vaww6H1FSGqQBafj53sDFZpNFO+k3TBX3BWdG4Hf1e7OQ6D9j8j9Za5yyXJ1RfcDnjRO1T74hyBqbTE71u0dH1O5XngHQnMRZlLvlvmRYeltiGxLTSj8hCkM3kNMq64lfM8CDz53I7PciUHuYDWmzJgjjOnYLQe5GRL9w5oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6608.namprd11.prod.outlook.com (2603:10b6:510:1b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 07:21:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 07:21:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] iommu/vt-d: Avoid unnecessary device TLB flush in map
 path
Thread-Topic: [PATCH 1/2] iommu/vt-d: Avoid unnecessary device TLB flush in
 map path
Thread-Index: AQHaiPn/q4hRm40VZ0qfWlbJiHpMrrFfivLw
Date: Tue, 9 Apr 2024 07:21:34 +0000
Message-ID: <BN9PR11MB52762DD848C6E3B64BCEC6F38C072@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240407144232.190355-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6608:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3b7V3akL0gQ3OzkNUOe2PedU6EYBV/K+0Ii761fZigA7oPpL/+1sD36BTFUlEc9z/Z1e3/T551pmVqdoHYTqyb1us2YB2xOU4wcOUWmcjvc++EDtZ/avnxcUMGEPxRebO4CitIgwk5gaoyLY6MKEbdBG+Cnu0S383R3/qC55PCK40r6Q1yAFDuNAd39aspOQnWtTXYb/DJH4IE43GAClKCS+B/TXOMCrTQJ83rpCBDWypSzsGQtJfyPj7nGz/zpJsbfq+JlVs7jas4555ZK1mwZArRTwVCMMB8lO0ah8jXwnHcr42P83IJWCeEsBvy1u5y275smWsQ8CVUo92bNczL/uHg5T1swMHb4ZZQ8iFr39jahP2/lahNXxLAegMj4u9xqT9nKZqG/minW8jTL90emwZoolwelU6cacCBRpTKLWW4+SC5gM1kSqvZLeCjwUCNRuBuOHx7cjOPD98VUqOXFajxj9j6zYGTitn2rDg0j6HolcSgdm3pV5iLXG7lPX5OQqQ8a28SRLXCifxgoZKLb5SVG6QOy+6qtTjfTbtnYogeUlDuZuPiTrwkd3/uVeu98+icj5g4/8ZQWvOZgWPyWCjTrTp8z9Un3op3LM855v6lDQJC6cXID23o5wNrmvIyC5DJOnqzNNpSDP7cHtEghg+ied9ORP4Cy8NnGnpUM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bxLI3fCfwmHBznja9WobYuFTkLWA7+DE89BCTv18WJeorcgFOoInXXlBOUDG?=
 =?us-ascii?Q?ghBcPGb13o0bmPkZLdD9WvaqaKh5654sBfXMphU0hPAS/aN5aa5ELCXvTM8p?=
 =?us-ascii?Q?HJnluiRM7ABnBA7agckCUCi4lMz2A0L5Tu2Mm/75E1iOPiuevsUPrK9LdSLU?=
 =?us-ascii?Q?f7GpqpWT6uAu8/1P3BKDjsopFyp3uxJ1TssojhE/o7rh5ZeQkWXd9xgWyLhO?=
 =?us-ascii?Q?MvKuAuSoJ2hJr3CSe+6Rvtf5OULxpAPZPRkR0LcQht/rIG3U0Bp89oc135KW?=
 =?us-ascii?Q?MJ9XnRg5CVM4mPsZWlot+tTuS1ef1vjKUWs3CCdo0TaxlYfBZx8vaka1Cgmi?=
 =?us-ascii?Q?jAE2hC4R5ni5t0fuvQE23UZfWCBrVHebUo6YgZvk0KuiDPVpfpAUNpEW6caS?=
 =?us-ascii?Q?ZLfev5lViLB/urXxGC8DjA1BcSrIFPO0rRYtVccoRicbmQngcfjdgpycE5LF?=
 =?us-ascii?Q?so0Fncyrzd+84lgLcGMxy3Txc/ESUeH9wEem+4p5EdSZ9tzU37VVCpsUHjgr?=
 =?us-ascii?Q?sBvoHfbaLnWBA9lkJPN0CdzqLe44CEQGhx+2OkSefzUGxFnhAwEh3F383Hg1?=
 =?us-ascii?Q?fC86jtNml15llbjS1uhVIbWF+DezbyVdVOgSxfVyNjnyqhg9fJ2x19J/Avab?=
 =?us-ascii?Q?B4ehpnmLcSOw6r77MdYX2Z09z2mHhpZoo4WfyLuFWNrH3l896G2eoE5/eyoi?=
 =?us-ascii?Q?38bPMKYtTpY1veNg7j8KmrIVWgc9y4nJPZaa6fu2aRhFm2IIV4bb7NJT08xd?=
 =?us-ascii?Q?JF5SbzPCFrfBsgnqTzw1Bt3soTmLJYgTaAfTGPGWZE3UxlAfU4vc1XOYnh58?=
 =?us-ascii?Q?XZM8yFRX/BlWrNuJoLYcCr6NlteaZJPhOsREOmrKDE2vV8Tgl/sDx/15exuo?=
 =?us-ascii?Q?1s5EVDMBUmL3myAyHZs3dZkG17o6KzOyZ4Q/9+SLXMZ/QeNuN1SoNrnOy4wl?=
 =?us-ascii?Q?AEG/JdFEiuP1HJilHxNU6/vXDPmA+PIw/XXfLV/bCWgoZV6iMF4OdHpiGe4v?=
 =?us-ascii?Q?cGBzS/T7/de46xEISnJELuUGrrznNuLWzrXTAny5JVTKFkzGSZ+S80CRfPG6?=
 =?us-ascii?Q?f+tc44aa3gqQQ0RyrL3j3pwn0Zw9gJf+Nc0RlD+E7VtwHRsUPblyyqhSU1Ut?=
 =?us-ascii?Q?8YfzoAJ2J0aG/CCH0EwXKFkg+iFH9DuJbJhfmTzp4k2noyQYJvL2TBYhpNtY?=
 =?us-ascii?Q?qSCHVIrqzqalOxKmNgFTDKCjZx0hz4vj5XN/Qjj4My9LsL/OhwBH07hVxvd3?=
 =?us-ascii?Q?nfoqtM7gkjMx2p0N5HEzMtO4T4dxrBtyb0rVWs+e3BNuXppDdQTCPS5l/K0y?=
 =?us-ascii?Q?pE5+PBxrJ3iVujFe0Tvr8uEeCt7LNcQNJA9XMssMjWzXKwmlGyk4AD8+a7JY?=
 =?us-ascii?Q?x/Tveaeu2IJtGTXTD2NZZLbs8LX+bfU5Le02JtUkZAPqIHUrpw+HafWxqK0r?=
 =?us-ascii?Q?LeF045Hwulh/QShouU3kuNrJBIm2CNx6fMcCL2cP+xHpUSSl22CbJySZ7Nqn?=
 =?us-ascii?Q?Wrn7Wx/1pYz1H9pdelJwCz75aRlXCG8C1tM3kQWTF4EoQuyYUnHK8KRW3NND?=
 =?us-ascii?Q?jNV0pTf8JFcnb/ycADK7/3dqvTu5d4uyGODJ7SXW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9894cc1a-94a0-49da-de9f-08dc5865b02e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 07:21:34.9963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERAs4YJ6bdUqIE6RLTV/PyaoDYedqiJeFrFisXVgF2DUYdcj8muOU0MWLNP5xejFqMo1x1REI8VUcxKPEbiAtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6608
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, April 7, 2024 10:43 PM
>=20
> iommu_flush_iotlb_psi() is called in map and unmap paths. The caching
> mode check before device TLB invalidation will cause device TLB
> invalidation always issued if IOMMU is not running in the caching mode.
> This is inefficient and causes performance overhead.
>=20
> Make device TLB invalidation behavior consistent between batched mode
> unmapping and strict mode unmapping. Device TLB invalidation should only
> be requested in the unmap path if the IOMMU is not in caching mode.
>=20
> Fixes: bf92df30df90 ("intel-iommu: Only avoid flushing device IOTLB for
> domain ID 0 in caching mode")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

and given it only affects performance then not qualified for backporting?

