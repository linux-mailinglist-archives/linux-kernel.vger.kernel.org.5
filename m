Return-Path: <linux-kernel+bounces-139528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520F08A03FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C781C204F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC00335DB;
	Wed, 10 Apr 2024 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQMumqPP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593963E49C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791442; cv=fail; b=QqPYpFXqo5HvKRbkPqERw4rOFxxzsOvoXccojhhodz7PbpihPOCWKVtDiqpeBeU63WxaPUCHC6iIy1lUsxlCpSNzowYB6GLeXiAIJFWl77liCJOYBTvx0vavWRHVAfXGtpyU7t0d+UGG64vyh+tcnBEc82HyU+vwDNGrV9nSLOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791442; c=relaxed/simple;
	bh=vLPXyw0C2MoXtk74OvnqpRRKkcaSTsI0sgzkJp1XTIk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DZKMDGvDTUsMeJ0SMO9xesORvU0dJjl9Hp3ftxnBNs+nMxB3Ya/KUMBAGP3khxxoTA6+SfTdw9mU4GEDP5G9ACmWIufiE8pZ+oJ4r5E9EnT1djstURz5wlzFCK8THPQtoUQYcgd3uBvNuhvVB/ZiLbM2fJl6OIHNG2fHbLe+Yr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQMumqPP; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712791442; x=1744327442;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vLPXyw0C2MoXtk74OvnqpRRKkcaSTsI0sgzkJp1XTIk=;
  b=KQMumqPPYdFMo/e16rlyRXNNMZL3FNk962z5w1cmgQAqxkXA/uZy5twy
   C+dT2VctKy6+B3djarTlJwaNgdu2HwdZOguTKUw/tfzcoTf7u1/sDNGmp
   CYR900RPHa3qzZfPHSZv7Zxn7HK7iKhcNk+tsLBSmjWAYTBUL4Nw0KA+Q
   K1zbzMmHOLXgaf2MVYU4brcyzBJdxrHg68s99ehCJKAwle5OKLtJmOJXe
   qgdjN5+GkXVMDjK6AnX1MWCEalOstNxWcvbuaMhtXp0/+b7acLeNdcovH
   xukh1KYkftr6a8/Rv99K9MmD8KYTRS2bv3DBtg9xU3eVq+E4YzJUtKBC6
   w==;
X-CSE-ConnectionGUID: EU6HAl/gRIWW2O520PcpIQ==
X-CSE-MsgGUID: axY1prEqS36jDr3/kusmPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8046858"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8046858"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 16:24:01 -0700
X-CSE-ConnectionGUID: sGiscPKFS7qMz7a+sUB8yg==
X-CSE-MsgGUID: XGwVx5ONSpyGcg/c/AGHEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20796980"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 16:24:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 16:24:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 16:23:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 16:23:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 16:23:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nyv79NSXe2clUTLEYGA/ShbL0gQlHYXMHYGTm2AbyqaEzButSPE1hUfvdh2GiiV9pazSTqgdefXXb8bpyA818GN/uJOqfcOKqGo7jVpgouplDJ2p/rMzSaA8A1Ukl4If/daIV8DQY3mC5hTOuDBNAriIXN+V7BFkf+jW1OteA4rb6FVwrH+DuQxMTMlTssZwrd6z8AVOYjtIs2BjzkExboI7VoPRo6EaPa7wKzfcxm550CsaU60fDRG1Hpg/BTzc/ZRpOrrCdctc2U6+DZ96o71CU0P/KayUBdcOvaf8hfg6vA1by8OjbLnzqJVWmVXi2brStokQ67OXQtlHQFm3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLPXyw0C2MoXtk74OvnqpRRKkcaSTsI0sgzkJp1XTIk=;
 b=H3R3DC8fLVGzufdhO0mS6bBNENfXX0u58A8kiC9nVWmcT9UvKfIQBQmj5tFSgkLAL1e+RNfdovmdGM59zzvxB33x+YP8AOUgrV/3NXCuDUTvTbXyeGCswXRCFVENPPrkCxmqWEMUcetzdg3Owi2J36J/P2bOMvztnRBn60vf7T+n/naS4NmClKcQ77/8ir3YlRwE3LjpstAJSfiAfSpZfpaGFpZS6Nr9GfcSjn5+ixAZ2z5MCDUNOqM6tgRYRVT9pKirja2bnRu07nArDDrjJ+yl0dfei4ebBz6gJ+sQ/rWVhvmJPIKmbMUS2F0wWhr8EaJKV/e3hsEMkyKuWF3iyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB7400.namprd11.prod.outlook.com (2603:10b6:8:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.23; Wed, 10 Apr
 2024 23:23:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 23:23:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
Thread-Topic: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
Thread-Index: AQHaiPoC7RpD2axGS0qZEPwCpJ1HeLFe3nWAgABnDgCAAPAgAIAAdL7wgAEJg4CAAHVPwA==
Date: Wed, 10 Apr 2024 23:23:57 +0000
Message-ID: <BN9PR11MB5276DDE04A315B1F870872468C062@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
	<20240407144232.190355-2-baolu.lu@linux.intel.com>
	<20240408140329.6290377f@jacob-builder>
	<aff42b8f-b757-4422-9ebe-741a4b894b6c@linux.intel.com>
	<20240409103146.0d155e45@jacob-builder>
	<BN9PR11MB52763F42ED6719E6D03D0D308C062@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240410091955.5c00e411@jacob-builder>
In-Reply-To: <20240410091955.5c00e411@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB7400:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: svXRULpKcNhth+z8BdV5gE1Rfb/gg63lJs9aW91jiCuja6XGyqbtEX1nFef6etSVrT0N/vnsTrWPOqQvlR2pZiSBDv4Howv4R2IZxwgajhsGg1uz/BncC7+M0h0YAz2IwKObS3kJc1e+WgCRjTO4i1JEAWbblE2Nk1QpQeiW1i/6m2IMv7NPnUOkg/XERqpech0EH8fLeP+v66ssBsf4S/d/najECdDkwV178IBvbj1P7yDAxDylSrGEaEBC2dUhzBcL+MAtyrSfQDYToR4/gazpWBINBs2D85CZrpCD4MdcwqDA0jjjGPg87W49Hli6/ceWoSHl4RwVdKZyNP0+q7Q9sdHukj231xDmQyw6wBd/WpbFhRMkw0z9LarzZIlUhctYLquH5OkCKx9Gfkjvc0cneDSlbNvpLkeMGaSKMHpUz+FR8D3jlHHFNWADNsKjX07nkypGUCyPXmXVOKVJARKdQ96tlvTA9/LYJa3QhIdpFXkQpONLEaBtnLC0Nzoa38F5AlX78S/O2JfsTmKWuux+a0DL1gdSsecf5wLygUXsNPG4S7sTrdPVS8KErIdp1QZzflJneGbKISYXk2enT49NGyD+O1Ue2QDuQn1mFlwkU60WV/KmUySLSUHQT2bvMEfeLYjv1evJEk+Dp8md43Tk/LqTmCNY8jy9d6OvnhQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LhzJrAEFHYII4T9AaTWd/PQWUuLlhSsyb0c0uWiWNzJE5eWCVg2qCcZo5L54?=
 =?us-ascii?Q?4NTw4jnulwCUp22+ESbvy57LhsGc8t2/CghzX+x7/vuPLrlDVn2Cr7Rs3Ods?=
 =?us-ascii?Q?Mort37IOowNNe5ml2NQ2ELXUXk6D5njQkmDTc/50EOMXHkl5OSl5RQcwP1oj?=
 =?us-ascii?Q?BCiMdOBHdsXV2PNBRAdp/nz3iiv0/HGV+bdwD8Pt2BJvfxjrg3cwh8nkLLwM?=
 =?us-ascii?Q?V/T2Kfp/n3TpMy2YFi39YTkL1qE+52KcZZTcXryGtT24JzZ2k6cWHUlMwKMm?=
 =?us-ascii?Q?FG1MTSuYOdscg0AP8xfZLUf2scQUaBBV44HDzH7FnI6V9EtJaORB1YVaCMuL?=
 =?us-ascii?Q?dgbO3i43fEI8PnDiddmDj3kdLxjnOVq/BJhIOy1L52r/ZpOTmhdi2lzLaVVv?=
 =?us-ascii?Q?pyivIDKtJYq13D2xaWcVskf00mNtc2cSdztUjcvws+jxjGsjxd3ToaxIGRuV?=
 =?us-ascii?Q?9IAig60cgeYcoTjllK5OqF+6oSP9m1KEN0WWJ+xv8FW8nheQpyfwOKlExIwe?=
 =?us-ascii?Q?NpZyi8lxnoe+yrtl6yp01qNnrJJqQ2DkvnrxmJuvleCX4Tk2mc4om0N1KfNP?=
 =?us-ascii?Q?1JfkcD8do/mQLeQgFa+39X/bxw0grnXuTJ6mBFLqkRPzNb0p3LIoS1NwiKzV?=
 =?us-ascii?Q?BqVroojYRsXcesHPqrOySzJS60mxnFuURJhOfsm260A4lm7XluzdOhsZY6O0?=
 =?us-ascii?Q?4y/qdLpwKAO6xSO9DBGIqeY/V38nG2Zl0h6lcUQsTTf//TjGdHr1f3MHJ3y+?=
 =?us-ascii?Q?WDD5wAGF44VRtScDdq5XA/1o/Au1Ht+mHqBhsbj7juIb57I1Zsh8oAqafiyA?=
 =?us-ascii?Q?bi+47OmYSK3Ndsbapq3NrdXmHiUZ42jputui3pvz6ACH5xuCmAbsEa+Xy1Yl?=
 =?us-ascii?Q?r2VnO6ma3WA7Ib7N3KU5fBVFO59V4YYt6enGnRB7te6QTAl/Yxz4CZmTpXuL?=
 =?us-ascii?Q?QyBZIfAu6wda8nji90/vp6TBhBBGDD/8QTwxkNUOUMR4+Nbp7v1b12U5qf6N?=
 =?us-ascii?Q?NEb5+WgXO4r8827BFh9LD0lJBe3r0SBttCXq9lEEKJqxb4WIY9dNuHTTHRxE?=
 =?us-ascii?Q?u2L4k+qw8e1imBnTR0pcmFhT/TrvslPCN3zMF95hoBMuhKUBVsMicI6r0KtK?=
 =?us-ascii?Q?UKKAYGSR7HW9ufD62Fs4dwvChUJHzChXr/rwGXCONxGg5JEKmsMdPIfDhu4D?=
 =?us-ascii?Q?kbU2cJMC9xQAPFlRQ/ih6kXYrspS4QVqxlj2R+2pyejYG7QOReY4yjufZGI7?=
 =?us-ascii?Q?QFEqV0btqo/WbfiWRfzFE/vGdhUsFFq0blEJTAUFlUx4HqMwTW7Sv1WZ+l53?=
 =?us-ascii?Q?/N4lR7+kJ0tq9m+YY9D1nRihxMHrYdJtBzB4W72i2zpwBjC2n7L6/xO4/A1A?=
 =?us-ascii?Q?sf4tvgBfkO+gzm39LkxL9tCfuyeSLrGXkMXyzi1CrPmRRN0v2kfPLeGh5UnF?=
 =?us-ascii?Q?APGTCEdcozo/RY2T5cOp5kA9X8L3K4a6QUuqD39J2blMMHs4MNaEwveax+zf?=
 =?us-ascii?Q?CJBTT66DfprPwR8ZCOMFi/sDZlW+wKer6rm13FjZjKvm2kKPPiaxCsGI+TkH?=
 =?us-ascii?Q?AiWJODZcGMbg7zzzC1mUOojBO89aH6ZkN/0AgDTb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9478f2d7-d06e-4cf0-c14e-08dc59b54bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 23:23:57.7851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4en4186Zdn5LG9lMoPwTN1HrZhf48Ex9yNq5sOiTjUDxcM9zsZUn4miFP7X9krEBz5zZLqvvCoHXiBbjimBHAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7400
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, April 11, 2024 12:20 AM
>=20
> Hi Kevin,
>=20
> On Wed, 10 Apr 2024 00:32:06 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> wrote:
>=20
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Wednesday, April 10, 2024 1:32 AM
> > >
> > > If the guest uses SL page tables in vIOMMU, we don;t expose ATS to th=
e
> > > guest. So ATS is not relevant here, does't matter map or unmap.
> > >
> >
> > ATS is orthogonal to SL vs. FL. Where is this restriction coming from?
> For practical purposes, what would be the usage to have SL in the guest a=
nd
> ATS enabled. i.e. shadowing SL but directly expose ATS?
>=20

ATS is about the protocol between device and iommu to look up
translations. Why does it care about internal paging layout in
iommu?

I'm not sure which spec explicitly states such restriction.

