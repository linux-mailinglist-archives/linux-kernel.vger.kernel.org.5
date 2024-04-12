Return-Path: <linux-kernel+bounces-141849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413898A2439
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FBF1C2159A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8AC14F70;
	Fri, 12 Apr 2024 03:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdQlTlw4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD4D17BA3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891618; cv=fail; b=JZHsbudoB39NYQ9PXrQ6dGPg2X4PIX61kuYfPyifkdZohOKIpqIXYjwSTi8t8VQ9mlIP/eXQHSeFTnDHIuRLCk1i60T/CtsxEPc1/eC4hsTBRaihIfiD928rybPhPrAc31tVD7opeIuYC8VtUDvaPgOU/mY+EHf8cnklBdWVmuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891618; c=relaxed/simple;
	bh=btbKmN3nB/BCl/MeYqRIxe8xkpWVBh9GUE/OPg5AHdc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MUjMeF/98+4JmX0b7vWlBXh6IekFeGj8iIm5p/VI+j86ooKXECYLq9WtkdvzK2h/svEYpSOW4ns+tTpxeWSM15deg4MTT6CkGcN9TNLVN2DDor4p2FD1jQpSVeBs2pHgQHP8HkTcaRgFP7Gv+f3dFXY6UZ3wT/W66/y4WKDyBlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdQlTlw4; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712891617; x=1744427617;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=btbKmN3nB/BCl/MeYqRIxe8xkpWVBh9GUE/OPg5AHdc=;
  b=ZdQlTlw4ZLqzj2ZgK9ZO5AzMoWe8pBLJThLh0Ja8oT/LGVGwcm6L0nOI
   POvncYhDRujWl1VGTVgEeN+IGfpjSiUq77CTZABbn0xUTNifGV6M+SiYZ
   CK+wcerh43xL8LhxdQzBXy6zkHmPoLdF/yUMkpKbY0gxfNXj2a1JcLlX9
   5gOzCRk9uGJEHO/gNvLW/s8uiwi6ZJLgxaycptp5K04hiVtnCbL0lqMqS
   zZd71SB7EoabTGn+3wrHUF58HXyHNiK2xuGMeyumFzRx/G53zsVPE1hTA
   u7FMn6yWGz3jU/UjvjKFV1HG72XYXE8oJcwTnHvEmB8zI3/ly/gfrgK3F
   w==;
X-CSE-ConnectionGUID: YlwgThUKT/mEqPevjj9maQ==
X-CSE-MsgGUID: VcM3En+QS26F2mUlGA2Vaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19045587"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="19045587"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 20:13:36 -0700
X-CSE-ConnectionGUID: 823GskEeTVqbAS2EhG9qAg==
X-CSE-MsgGUID: Atl1SvoQQcmPWe/uzRNAIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="25904959"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 20:13:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 20:13:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 20:13:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 20:13:35 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 20:13:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmZRttC45oa/vYU3BK67Pn1YLZ965X9D3RIw4onqgSzOp/Std4AWYEnHlH2WhhFegry7ie1ANI7x5obsrMBW5WSo8WBLPbNleexuhdcq9WLnMvJQNO7dM2ghdxYM44QqP7GOJWVQXF275KjAhRJpojImNK2EaMR32WzawEm4BX+XifZqc9aSBFRRMkZ2X7PmOT/hRXGaMp+7EEwhu36h6AKnerv2zlJuVjpqlaX+UYx35C5jKTDOMh2DhsUbyTE9vrCiu1okWAyTxUsONvLt9twF2z3IREQBRXtLoCPCn+O2NCajIeXXImqBogae894KbPNYswJJzZIKiOX/bxvwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD8XV25M7r4oXG8xpkx0mn2wuATlml1A7hmr97a3R2I=;
 b=CnIGVKHJocCW+OQoXI4hmW1PZBxD+ZvE38IonElt0XQ4YRtQLayKXPmbTzhSZReCW7HlKcfyoqMQ4WDDb+YMNpycerHwsUppRgXQEGSlyJ6iu/8QRrpP4Kjp2/SZ0n+5+OY9pju6y3JT9FysB0W6Ws3mmkfQLCeYQ668bRlCDxepgyjhtublvjeggjCQ4PhRED8FHhIkb4ExCB9BtZVvYjojRud9LGBSWf5ov4ZWv2TAjS4vcmvfaKCyKwrPYWWy8qK/842FEfuZfLM9eiHYm8BUzUMbC+WoFGQ05nK8hYFJ/RyI5ne3FFm0OOcLnC0Mo4MEsivj9s4AL9Bjz64cjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 12 Apr
 2024 03:13:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 03:13:33 +0000
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
Thread-Index: AQHaiPoC7RpD2axGS0qZEPwCpJ1HeLFe3nWAgABnDgCAAPAgAIAAdL7wgAEJg4CAAHVPwIABHHCAgAC2WnA=
Date: Fri, 12 Apr 2024 03:13:33 +0000
Message-ID: <BN9PR11MB5276A2DFFA8C523EA1C148968C042@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
	<20240407144232.190355-2-baolu.lu@linux.intel.com>
	<20240408140329.6290377f@jacob-builder>
	<aff42b8f-b757-4422-9ebe-741a4b894b6c@linux.intel.com>
	<20240409103146.0d155e45@jacob-builder>
	<BN9PR11MB52763F42ED6719E6D03D0D308C062@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240410091955.5c00e411@jacob-builder>
	<BN9PR11MB5276DDE04A315B1F870872468C062@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240411091749.20afae6b@jacob-builder>
In-Reply-To: <20240411091749.20afae6b@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5163:EE_
x-ms-office365-filtering-correlation-id: 2820d640-800a-4c54-3d10-08dc5a9e8979
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EiBrddSM2rpiofExDXP91pMuftHwu5tKaKOk84QgRrRD2DBPvzuueBEak31CVF8ds5iCVVGZj0XFV6j3nUHauYhWy5Rt+u0J1mI49kTFOuvmiHVBhjJloRPkpGAeTf1LqsEHKmscyrL4AXi23lwNGI49tDolnLkq398pqJ1hpDDx6/0FkbmlrOIW/8PHKZwYioQ7Oe9/hRppTyxI3++DChsY9HwPmJd7sjbhjdrxKY9qdduVNIJg1EGQTcLc10L/8qg9xj4zpLXN8TBLpTF70iPJRtxwK/KOXser86VOLhy7vo4sz+n0PbcY1HCy1VgnKv3WqiLZ9RnkLjnhdIw38m3CjwWbadDjy/4hG7o/+f5cfgwC8yZ+o7JKB5mycQ9KrPuwE8RLjZs+CczNSvX5UhRmkkMrlAUqEyFVvestLmEoYqfF8Fkp8nW5AS0rqCOZII7QZMA3Q4Zn3S55YWQC5ubCb3fdAZOJVS9eUnFRr+o3CR3intqASaDOH6YC9TCuNJg/aSfmSYAn7OJLqv9mPmxAvFe2ltP3D94dxjUrVXfkqEQcLBI+2pvOignWtxa+EbYnqRrl4zGV0MIxHIbcF8p3IZoDcZSwu+iI5+KSojfBYxB4Q3+63d9kprq7Ks+X9v8Ven9G5dTGZEvbcsU2t9HlW2jYLhTIyLD+1o+4EyZGPvfGfpYGO9r42pnaSfzNP7XJ5l8roCHqY7kxJNZV6QbRkz6ZlaPpSh423i3QxIU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RI8y1iYZ5ebyn8ukQRbqa+lWTExenkoVtaCarkV9svGtGmS9ntw2Iu5vTiUe?=
 =?us-ascii?Q?uWIsA1AYgjhwxyxBllkDM3Ftj3vBXBOTqXPGzDhWYAvCeQt1TCBCOK8GdMKo?=
 =?us-ascii?Q?BjHSAev08K+vX5OfREUKbMYMnyvfNMYqZjgnrI7LEiOO26KGL3R/KidyQka1?=
 =?us-ascii?Q?Vhu3aE1ICN3OzGt4qfNDXerOeaqd0dSeIQjx55AWx6QjgeUXkPzSyKRdMhM5?=
 =?us-ascii?Q?gHwyQxI1zLAAHdVDUrHfksDVKbvJ2L4GkNXPNmBvVeusBUdb8RH8iisMrZA4?=
 =?us-ascii?Q?yjQCZ46a4xGlrLIDI+6AwNO5YpRsM7bfrAKNvKpeulk4huJ2ZBpDkv7Z/QsG?=
 =?us-ascii?Q?g2GE6l/PNJ8vynKr11RkP2zfFq78YxDH2LEijFJL4RVC8AiS7svS46aHzc1V?=
 =?us-ascii?Q?a/IbgzaimGWS445unf6sgD9exP6zlUJQdSTqXEqDvIAI9z/cmfSRsfR4rKc+?=
 =?us-ascii?Q?M1NfAp/xXNjTOI/CQz2ZTrmL7/mXa2Gs57n3xGVAFhcJe3pLuczMiY34h8Ad?=
 =?us-ascii?Q?KKI1sbaIMJObBRbFFzr5NUCUHta78z1peBDafcZP8E593C6X1rP3dJYC4cJg?=
 =?us-ascii?Q?7yErHBB/ZNTLkNQWaxvb2FLr8VuMFqVauD1ke8UFIKRbDYyCEreWJ8rpmYeB?=
 =?us-ascii?Q?PWrvSoJs3C3ocBfeP/clcp29wGE0kzqPocP5KRnbJvmtFWVxjMCAzY939XJt?=
 =?us-ascii?Q?dVRor1eM8BujD6TDE7mMmm6nbe73rF04xqyghu2e8uRd9CspO3sF7wM6zx+8?=
 =?us-ascii?Q?L+cT2kLyS2Gr6AJQQT6uJFHhOqTmsgHaDuGWlrLZf1x8SZxm381q/RYRu9IR?=
 =?us-ascii?Q?hsDy4AXkbzotEWnUok8WjbqMTBe3waci47SqFy9nN/fq5nd3Iev5kc3dULxe?=
 =?us-ascii?Q?JY08zzJzpsl4U8aTkUUjkPcaKwPnukCCDEVkeJRpWHE2lsNTj7vKK9PS6AoL?=
 =?us-ascii?Q?GypBAfzyjKbj8HbUNhxj+OFNZV5JVR3dFCA+xgctqbvy2p2IQ9u8It/GAHIM?=
 =?us-ascii?Q?u3RZfiofIyT3kOezmXUJQI38cdEER+m3S1tCyGZb8FS7S5q0pw41d27Wxc/a?=
 =?us-ascii?Q?mAFqRsuY9I+ByVEqsA5wtIEglpIVnBQpsKDiNbiLvzCm0tDXSubYGM3K1pit?=
 =?us-ascii?Q?MU4Qlb+rmap7HqIg3rwh6jfXCfWxMtaJoMB4IX7V+2DLXEC310GSFuFDQlqM?=
 =?us-ascii?Q?MKGqt+0T71rfw0uYK+OirT5Ggg4FQdLYG9/GdrGoOsn8uhKu6ffDaAKgzMVb?=
 =?us-ascii?Q?Um/xzqxBTFjkTDavFMnrzt0RjvvOJfoSowXTOhFfK/nP4822QiMHx+tmcfy1?=
 =?us-ascii?Q?L4u/pAzcgNp0Av2YEWN/fRLhs7M8eLSJFSCTp+76uMEemXShFq+pDOagQ4Ej?=
 =?us-ascii?Q?qSQ7nzPJfY5w9wmzJOmzrfUGHZBVn/rrDoZUC28D2zZnTpO5/OE/+dBpiDSI?=
 =?us-ascii?Q?dInofMrQvuUax463kLmrWqwkf6ff9vraSl45EQPPF1k/6Jd5fuWwXwXTeDaI?=
 =?us-ascii?Q?hnhT1VN42eXKhLdSQbjQMazb1u/pKhg70US141nC4rOePSXq5hwa2hCz2G/L?=
 =?us-ascii?Q?xuoQsKoMpI3yqtaMSG2nLONlqqzhaDH3lggp8KyE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2820d640-800a-4c54-3d10-08dc5a9e8979
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 03:13:33.7196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cFzg1lOBNd6F9ReqVigGCXAVLRaLIelTQNOaZPnMC9rmuPSBcqT9FWfqjbd3z/p1Y45yoidCnHtim8JtAUqktA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5163
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Friday, April 12, 2024 12:18 AM
>=20
> Hi Kevin,
>=20
> On Wed, 10 Apr 2024 23:23:57 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> wrote:
>=20
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Thursday, April 11, 2024 12:20 AM
> > >
> > > Hi Kevin,
> > >
> > > On Wed, 10 Apr 2024 00:32:06 +0000, "Tian, Kevin"
> <kevin.tian@intel.com>
> > > wrote:
> > >
> > > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > Sent: Wednesday, April 10, 2024 1:32 AM
> > > > >
> > > > > If the guest uses SL page tables in vIOMMU, we don;t expose ATS t=
o
> > > > > the guest. So ATS is not relevant here, does't matter map or unma=
p.
> > > > >
> > > >
> > > > ATS is orthogonal to SL vs. FL. Where is this restriction coming
> > > > from?
> > > For practical purposes, what would be the usage to have SL in the gue=
st
> > > and ATS enabled. i.e. shadowing SL but directly expose ATS?
> > >
> >
> > ATS is about the protocol between device and iommu to look up
> > translations. Why does it care about internal paging layout in
> > iommu?
> >
> Maybe the original intent was missed, I was suggesting the devTLB flush
> should be based on ATS cap (as you said here) not map/unmap.
>=20
> -       /*
> -        * In caching mode, changes of pages from non-present to present
> require
> -        * flush. However, device IOTLB doesn't need to be flushed in thi=
s case.
> -        */
> -       if (!cap_caching_mode(iommu->cap) || !map)
> -               iommu_flush_dev_iotlb(domain, addr, mask);
> +       iommu_flush_dev_iotlb(domain, addr, mask);
>=20

We need check both, as devtlb doesn't cache non-present=20
so the invalidation is required only for unmap.

Here just the check of caching mode is irrelevant.

