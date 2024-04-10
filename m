Return-Path: <linux-kernel+bounces-139517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8FA8A03E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31822866C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DE0249F7;
	Wed, 10 Apr 2024 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsMkWtrO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9046B5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712790881; cv=fail; b=j7NB4wOLX4MfD90BBLXIguDGI2rUpHXf6JwikeJCWsDpR1KonzA9trw1fzfYlssYKaHMi1NpOLSOqH3p4UWiKoy3y1o62OvaZzNMMMhb2/rHjgKTrpbleAmNiB4HlMUneLeSuHCRI0OacQRsSewhdbNpzXRT9q2waaUlqy7q8u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712790881; c=relaxed/simple;
	bh=+14CaxYP2DgzFLFRg0idvLw+JLARkJo8aPM+jmOOQBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t2EZEBqEub5ToirkispdI5gSl/b6g2SeBRv3CZT86od9uA7CyQKlk8heIjMVZ64nI0uy6luf8aBAB+WN4WwyTV5JoxN6hUkcpGUjXbh/Va5vHcSsm2dtsXwB7mXxHsp5whRr3P7xTqyrpbyg+f17k9zgKyKteCqCPqG1I0GG35k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsMkWtrO; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712790879; x=1744326879;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+14CaxYP2DgzFLFRg0idvLw+JLARkJo8aPM+jmOOQBg=;
  b=FsMkWtrOPb/pTN4Ti7j/ZVH5AMNtoAltdQ38RTSbf9w+4pENtwC1S2D7
   c9ugyxTBUaYytoX4aRuKTV5ncJSDkP/lC3YRchX4sN/2uX96cmjMxQ/8D
   zRF/pcCGe5hk5XUSKq3DLNemZkWeWaH3ljsYFdVPEHyQi/z5RzuvYKAiU
   uV7Wy9YDhcxUSjyvGpS7qbO8T7kGWk0ftbLl8zKI7LG6GgouFeCLCld0r
   jm84WqfVoDacHqj28m0Dts9tJsDxhMJmWJTt/NysxzjfJUp3BkSlBkBxZ
   0rocsuuzE6eTnTdV7Ws5v/4hccLBW0IqPjRJf/CP+Q900GWPp4K5XXpwF
   Q==;
X-CSE-ConnectionGUID: pW2M8ngnR3G8L40AHybIsg==
X-CSE-MsgGUID: ejNQ6Kr7QFaZNP0s0mY0+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18893471"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="18893471"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 16:14:39 -0700
X-CSE-ConnectionGUID: hXeyZuIJRfiTW7AfCaDr8w==
X-CSE-MsgGUID: TLpKZIl/Q2uN6Sh8OFhuIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20670833"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 16:14:39 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 16:14:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 16:14:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 16:14:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZKHUuRtr0k9TqLeQ5AFz70LSqZob+kZubl7ODXTSh5+BvUWacz/wB7BsifKxqjnQQVFjQXQJegoCstJPZnfo+nyXIwiE6WYNlIF49CTRRqSWiObx3geZtfiXDwS2vV7LAn/u+3JArZKR+27t+dGNDTYNoZfL7LOkXfpGyoGaDd+dUj/b2lx2xuKlcfZdhiNecs13dqJ7jNAujffr2MBvq5uEZPmJaZb5vPSd7hodHf52MoNDvJ1kBGF/6zIs20yUPib8Sfb8kaI7FVZEBd7eynNYOIbuaEaLkf8TbSSYXqvbiQR2ki1KSu0mUwvbfcEFmngDEkRVWNLWPduuFLKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mddcrbhtaaymfp1F1ElFi7vnI7Hd0T6QLMup+rZTesw=;
 b=K4cOHrH7uWxk0REiOdvhunzU9DFfNz9h3+nolzvLaGKfU/Qk/2Dn2oQCxW4hTbBvm8YnKz48oGn7qew1VRM+ICall+cffF2Kjv6LB/49qDJw7CemwFjOP+eCIrarTiThPtNKkBYaDGJMOwanQbWZFjFVyutqx1MPZIb9Bn9dPU0qz/1KDp6Mn0Dg+39jOsOpf1kjr5YqT8oC0taXEP6R0EOX4oh28ikOBe0OI8g/9ker913FqEV4jEDFjveQ81AhO5h+pxYinqPb4iOmdsKGw70qT6hBGO8u4Ogq+wjy/G6YG3PVXawOlbtyrkfuOkht3JUtEjHuNZNfh3JXocYF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6055.namprd11.prod.outlook.com (2603:10b6:510:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 23:14:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 23:14:30 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "Zhang, Tina" <tina.zhang@intel.com>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
Thread-Topic: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
Thread-Index: AQHaflqwfTup1ArZ00iKq9wT+H7xNLFhvmwAgAB9uOA=
Date: Wed, 10 Apr 2024 23:14:30 +0000
Message-ID: <BN9PR11MB5276B57D6E72870C9B1798838C062@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-2-baolu.lu@linux.intel.com>
 <20240410154134.GG223006@ziepe.ca>
In-Reply-To: <20240410154134.GG223006@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6055:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tjRfQ4fZ4x7AWUmawpDv7UEK1hgUTyjifOUi67P4vobl4KrdavSnANsSCjF/RFyf4Kdy1NsCBzSEqBeqEfdYl1FMWaH2feu8QN4J+8GFDbbVDsZerHvY1n8U1ufzbd1HZHbo6xppdhrsfNd2ylby2+NRiBpSDkaGfeCX4gGT1ZrwzyfdtX3UzNaPbAHsrf2KAAbkLp9A3U04cHv+Bgt4Zdeoz4UEkLxG1BaaXnTPTr1VL7Z/61nqHeMc2zbP12uCCtOlEtEivk+FTjtwixP/lLVohkxGfqkD85zXSmqyt7XS4pS9eDzgNb8bEMrXDK32DlfNQVJHfSG/NDvV6lsZAaGHL9+PPIdkKAelezArdYx6z9+QxqeIJpdd9hRT0gc1AurMcVUQD9pEp1HYmrZi04iAUDxQRohp9Cudn4f7TsUILdg3B2HR2dgnTLntrxAp7fjeFhkEC1iezNr3XYIhxZRJJbXSuMk5VecXttY637Jn5ZzY4fCqCzk/pRnxB9JpAEIyyn1GKQA6eBSUdG7mxcXCHAVVmPsncqUaNSwgpnkltcD9XHbCzJCehMyddL05UimxL6qgD17faTfhT1ylST4DSqrq/so4tyWDMN4y7/QydHvP0LKnQzhFUkLrE55GwVJob9g/WpnXkZM9glK+b8o920XljDdiH0iaiZ550Lg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NKymwp7GUjjU+Co8xaOqxGoKx8Jlo+GxVZh2FH2h2nmnMpzRLy0IdmpAoPtE?=
 =?us-ascii?Q?0LhxjUnZOa9DNZIuCRvQgAL0mmmH+mTNABgLIr/e2wMZHV1U2GEPElgNU5FV?=
 =?us-ascii?Q?EscphslA161wMnM5nntrmPw3llidUrpvmfsfTU9zWZavAn4AwN6hxIdgNs3D?=
 =?us-ascii?Q?TifwG9Bvf9PJ/kl01crE5xcDy3K/cPHMlnGpu4HUvguBuQHFs5mwRBLz3QFp?=
 =?us-ascii?Q?/z/yQLFBG1P6GGtl/YWY76n1pq8AbFotjYe07haYe6ONn0FvpGiWR6cn7Kyp?=
 =?us-ascii?Q?L4r2KiTYF+v6cYkQ/lQzxYp5EG6f5GsP7kvQ3K+Yzk9UCmOyEHVviLQk+/iw?=
 =?us-ascii?Q?k9lt+2QBrqKLRVjFMc9X9kgdNXdjzLuy9Q1egiPDbNLhDvxeXFjGUBIJVpfs?=
 =?us-ascii?Q?5vp6vmC90OGNVbmJNLQeehxhgFrdwukvy/JDPC6nLI4KnI9gWvt4L5kYhU7E?=
 =?us-ascii?Q?FO7dt9F4IQb2q8yuTye5LVDPxwCw7p8bhqzRLY0Q1d+sQZBbGtJ+PVV1wxwe?=
 =?us-ascii?Q?2HyfezyKxn0qsoNHhss1QblvGdQevEN+nylGrLLMnSKfAMCQYEq/ymD5U0zy?=
 =?us-ascii?Q?1hK7AydfE9uS7jTWaqrXVAlHPyM+sWgNBUf/cgQRvWZ+CbKTX5fI7WHuAx8R?=
 =?us-ascii?Q?EEn9z+jae/BYrUYdyF3viGVnwe6Hsxws+JtnH3uu1jtASDgxPCnQb23onpvi?=
 =?us-ascii?Q?Y6tarrAITl0ZsVCHTmSMtM9PJb4tOP7HYoMaDZ8GtMBT/Prb6zvoNLeGgZS4?=
 =?us-ascii?Q?1pQy5poGvk6jZsZjqbzw8OOo0HVxh+voxlfquqwswH8jMIQw9puII8dEI5jj?=
 =?us-ascii?Q?k/a4T598IYKkrQO1Gxt8Z998EM2gsqqgKeOEjlXAU0AHPQVrtwdDJnxSzklg?=
 =?us-ascii?Q?GfrgFqMowSNGa6cIezbxh2MRczwK5bOCsLW/UtadNFGlgbHcYJiJZ/A5loFg?=
 =?us-ascii?Q?LjKVfRv8tENBVZZXFZexAH0bvG/MJgr6Gdp6+9N3csvkDWzuFOXVeOkLnuoS?=
 =?us-ascii?Q?Y1RpEQDYAM3qMEQ7ugd4h2GQHT8lMCae/vyqjk9ZBBqAoCze1HsaUBnUmvXZ?=
 =?us-ascii?Q?gosfdWY05bu1xXkN+iCpZPf0QL7QZYQFvHqv4WqF+L3CLEWGC1TQuzVKr5OQ?=
 =?us-ascii?Q?lMUMC6AtJsE69yHJiqt/Ww2U+puIi1+d8m+T9njVBe4OeiFmKoGS/x5NSzfn?=
 =?us-ascii?Q?veJLynZeIFaeUaQj7ykb9GVBmnNX2vBN1ShSxMTj765DVqnrv4RdeskR8tye?=
 =?us-ascii?Q?im78GCbBSL/C7RHldDgwvSB8s5bMYaqNvpEieU2xW9sM1Hz4rgdFjq6Wj1kc?=
 =?us-ascii?Q?d9gRLhsHJG5zxXYZqhykZ6G8+LMV7yiKvLe6A4hH2sYG7Iui/ScdQNic/yGJ?=
 =?us-ascii?Q?Bz1XRjp4n9c7Q5HqJKyi0Sqvu5pDDF/eY/SS+kJA30YSKsXmtkgHCx3JzKek?=
 =?us-ascii?Q?lMFBWh81UoPXARVjaZIlW5Ch//ECf7WQgYXmHvXJQsKTTmqIXH3LQqRjVO+C?=
 =?us-ascii?Q?Pwz1vX80jPteu7XkYbzO/c6M7mhvAZw+gOaEHCdkX0AyxqHKj9WD2jSkOhjZ?=
 =?us-ascii?Q?bc/cacnCW79QnY85nvbt1x1ndLUPi8CZQX5rLHnz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 271356c8-0125-4d93-15d2-08dc59b3f9a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 23:14:30.1917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wH+V5Vb3EnhmDjLLcSK7zyPeSCjPUwQ4dczbRQn6HSKkyWFu/72c3S5k1a9HsNpwH+jSwZ1AxQK80Zu3DfDZ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6055
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, April 10, 2024 11:42 PM
>=20
> On Mon, Mar 25, 2024 at 10:16:54AM +0800, Lu Baolu wrote:
> > +static int __cache_tag_assign_parent_domain(struct dmar_domain
> *domain, u16 did,
> > +					    struct device *dev, ioasid_t pasid)
> > +{
> > +	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
> > +	int ret;
> > +
> > +	ret =3D cache_tag_assign(domain, did, dev, pasid,
> CACHE_TAG_TYPE_PARENT_IOTLB);
> > +	if (ret || !info->ats_enabled)
> > +		return ret;
>=20
> I'm not sure I understood the point of PARENT_IOTLB? I didn't see any
> different implementation?
>=20
> Isn't this backwards though? Each domain should have a list of things
> to invalidate if the domain itself changes.
>=20
> So the nesting parent should have a list of CHILD_DEVTLB's that need
> cleaning. That list is changed when the nesting domains are attached
> to something.
>=20

probably just a naming confusion. it's called PARENT_IOTLB from the
angle that this domain is used as a parent domain but actually it
tracks the child tags in nested attach.

