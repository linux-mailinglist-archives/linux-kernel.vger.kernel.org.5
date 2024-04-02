Return-Path: <linux-kernel+bounces-127520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CB8894D01
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3001F22879
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DB43D3A4;
	Tue,  2 Apr 2024 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BqcSuJ0H";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zOn4B06k"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769C2BD1C;
	Tue,  2 Apr 2024 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044537; cv=fail; b=BnOzqbRKs5QTcrbWZSMeAt+ecslM+25F0Y6cowOk1laje80s6ltrWbLP2riwDWFlzeOYJxT9/j8TyUj3A1PDeHS/dFUigtz19u4SbfWm3zOujEn5ve8HPz1vL1uEWjCmvufx0+x1ssqt/E7OOmz00uqxfO2YKWOvTJzEjqHB43g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044537; c=relaxed/simple;
	bh=CUT8y9a+ZmqjBeVkLT0Lo/M+liVo7sfi+G9vKL3dRUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MOslUQ1Dy8U8IRmm8evrRK0TkGOdk8HQe0P9ZA1n9Kid3Nu6s7eo06+sPtwedu/1zgEaKsSXhfbZf/rdBe1FL2c1rbHoN3S/9EtUSBpkWxHbh0O79S8D9PLqAN+MuIRc+Z2fUrLyYx+q8f3LlrRSmlz7op6qJ86mM+E5PfYeBXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BqcSuJ0H; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zOn4B06k; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712044533; x=1743580533;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CUT8y9a+ZmqjBeVkLT0Lo/M+liVo7sfi+G9vKL3dRUg=;
  b=BqcSuJ0HJpllW4nHh4ceameiO6Hxjti7N/jPdXPHcr81RC1c7Kne8fK2
   PRVQcAXzfQByIMs1IHh5YWEzuUx6gvWyh+0udEhkcCjIKVhLCjRdT5AE8
   LeSmOLTzD2az70m9g1sm7Ftd2yrH1sh0Eu4coFf+LkTQQF31up4Zf1DbX
   RoZgiHOJWozKT6I3rNy+2Fd5nXtYFPZegkLzslA/CMol50OGRQzSkHAW2
   4Ig44zF2Ex/B++1INEdx6YKIi2upvry8K4Ogb7BEtdyfletHL7/NERSm9
   L3+xsUttbIH5AGpDVYQVO+srB88JF6vztSyfGNyS27Fv6j3fe0I1yVqYa
   Q==;
X-CSE-ConnectionGUID: zTpmlH8IS7yeCTSxsJrX6Q==
X-CSE-MsgGUID: 0sIfiOMIQL+YbbxRmIqAbw==
X-IronPort-AV: E=Sophos;i="6.07,174,1708412400"; 
   d="scan'208";a="21014844"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2024 00:55:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 00:55:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 00:55:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Um4Jw54mQs3KD+VNhb7M0XGd0OhmeuHyJ9qybiEc5UVoTwp9WFVpvvCS6wVXVrb7bi1Z4THkkNAHfHSkdG5rtuxW9R1k2HZcmvv0UrfcE8C+49kecuWx2HLK4JJVrvrZ1c4XLW0RizAgSYyblvKShcfDTUZSZL3FM1B9o8kSs51le1BjPrzOZBOahSVAAttTVKPkPm1mufTT/BJi8qvDgbUx7cBSvtoJ7nFjavEB7o0TfdBAAwmKUt2d5+U4f3l6PuAmvHZ9w1WTWsSlAmSJg92QfhQZLGNaJw2fvkMRBqHpw6OtN51CPOSgVYtbqpX1sZDZp6sOdc2fKug5PDM6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3LK6VyDAmCslwott2KyvemwXQnaEfmPkZxYtZbKyjQ=;
 b=Dr4LI41ElYJNoFUgjOSlJsV+TEuZaKCvYkGjRWcFoGOoFLm5l3qsQgpHiKEPj/YKXaUn5hFkaB/gM59i1YVmmPPqAkFKvG6l/SfQPcJ6IJORPvdjwVB+629QEeMK+a3Cy16tfIK5GbSuO0VypBxH1N4Pn5mowUErH00InyCBh+xo/VFI5x3JX2StHcc1sjw74OL4hfnLZbTDHBExKYXxdCfQJnBhil1mxEIY+EEwTuMM8vI/HmLhjv6NiXCVpEBAT5Lx+HL3Mdhb5TmA/ZMKbkEekZ7bxyRHMoBpQ1owd0uwQB4bKtR+47RsCfF/COVzXVtTA4AyPcqK4liCa/bpgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3LK6VyDAmCslwott2KyvemwXQnaEfmPkZxYtZbKyjQ=;
 b=zOn4B06k/FrRq/a5ZY1LmrbxsUa1L748g2VxcTIfDV5xCLPdz79lpR6qBJwpgjuVMqlFLU9cYltO02SRIktYglyexbgUA0BvXEtvU5mmgfSyW4+s9szuV20AnJ/h9Ib4lxNN1+1QAdP+ZYVd1Uq9cmKB+/VfWZTtzbgSNjjRvF8PbNFrLmI4fmADQbETcOi+iJ0AYLCxf0UWrnq/zuHZnXcoGu7ipyoNkyyMUNccjbjvunFloZFaMTvjiiw1hM8H0Q1w4vAQnjnRBtqRNtF1VL1259uks539yOxUhVihBL8sA2Xofpw2d+FF7I99hfZK30TB8dtjSP6FNI5c/OLFaw==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by DS0PR11MB8116.namprd11.prod.outlook.com (2603:10b6:8:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 2 Apr
 2024 07:55:28 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::b78f:e89c:89a:842f]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::b78f:e89c:89a:842f%6]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 07:55:28 +0000
From: <Divya.Koppera@microchip.com>
To: <Horatiu.Vultur@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Horatiu.Vultur@microchip.com>
Subject: RE: [PATCH net] net: phy: micrel: lan8814: Fix when
 enabling/disabling 1-step timestamping
Thread-Topic: [PATCH net] net: phy: micrel: lan8814: Fix when
 enabling/disabling 1-step timestamping
Thread-Index: AQHahM3zwhdD08oLdUe6JysjzcSjGrFUm6KQ
Date: Tue, 2 Apr 2024 07:55:28 +0000
Message-ID: <CO1PR11MB47719CB09438652F66E084F9E23E2@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20240402071634.2483524-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240402071634.2483524-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|DS0PR11MB8116:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QopjRoHMWjwJASbfIBeF7uvHraDd88ECKVz7DF82nfHto/ypqQj9IdKmEG2D2f6AGCjG3fqPZPb6/NBeENLZGaXm6ilhlWc1aUz90JAGMmoLjXS76dV446JXjNRsxEmZsdu3meRvxYJOEzMy6PG9bKLIfL9DzFqo7TBzbrEmQAxhAdcWed/bwkLr9weHxyJs/N+0iGO4eipksYDa7szENeREVcTlhbBjoMK+O7MTuvZH7t6TTSeQNM8iXpW3zh0SJYZWiV0GXwga5t3nfxWbIf+spr+Wq+DK9VqTJhRV76XqR9yLeVpoAtSGr/TPY5+rbrAng2V3Db2qUugE5aRqnqgLeS5HT5gcvCkW8WcXSZiUGC+6G0JUgxlIIzsCIu3XoKArit5fvtk8SLcxd2OdCiCzKRW99UnfX+7gCkyqk4QNsfzIi21ZieY6OjO5+Ny7aFoj94PI3okL6OePymPgRDssW9Q5XQql6Yl/w2eE2UoBYuyCOumZAisOQmbE6sqvRe/f5R3PKABEhFF6ihnb84Ql1kTmqQl3Dvdrw8qFGsLyD2KAoukwvuWToEMZQMLLyCidab45Hm1JfCBoSjHjrvoncmz8Al1h/E+T46Qxyqj5yMQpHRhJmNRAg9Slq6NbNsQ0JK/IPvU9qYYjQpBeh6DIqlE69B248j+7zic36Ow=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GS2Z3HBxhsSN2CKvaK1cVvbLLXKdVeYMvG7WutpSyvmSS1D2cswNP0GZMlWC?=
 =?us-ascii?Q?RW55DNfNXj6Cl/XexdOcv2VA+Ev5L2GJ+cBBndVCjuSGYZ+z54Jkm1xvsc3F?=
 =?us-ascii?Q?cbKm7MxuBQGCMwiEozyNsGYlKELzdF6Io3+uuyz40AveEc3oYNy3UUYZeB7A?=
 =?us-ascii?Q?Dqtd8u8gdqC4eElXTpbh1RsnPUJpI8DRgWOyYdv4hXGBtpZQtoRYKEfiW/LQ?=
 =?us-ascii?Q?uIKzOz208k5SLDNhrGCKHiaAr/j48TLp0b04kFx2vBHJIbIu0TXxv0hF/fBW?=
 =?us-ascii?Q?XxXH/KzfaMNUJf218Wtad4y0T5aV1k5r6Qs+Fbfn4zYo+kgzjYp7v9f/4Lqn?=
 =?us-ascii?Q?ufnB4gcKR8XdFQw7DNFT2xOSpuzQR4AfkQHnl4yGFXTMxt99+QRzRXwJdbN5?=
 =?us-ascii?Q?2iIfq9h/AepiR+0xtHsj2LPkpFsOrGL0qmMQj40CJgJ6J1jwNKkxAsy9D14d?=
 =?us-ascii?Q?6F6FavxMMB+guoDwEIlLcgUR28xnYfjV6SRyvIsqaaSu7FJTMiddzijNRKJ/?=
 =?us-ascii?Q?qyWxsa/yszvbPUyDLJmRw0i5/S7SrjCIr5vlxcEfcaQ4a+dVV0g+8XK19Gpg?=
 =?us-ascii?Q?RwDMz8HRCN70Is/RdlLMvIRLoADfwXYGYnTqcagwvS3iVH4QeqJByltrM5UB?=
 =?us-ascii?Q?9WaljukURNbDLWBtVkFOWs92TY5wHwVd/QFLrj+EKdOQocpw083jMMelmIo5?=
 =?us-ascii?Q?5cNOxLmrruw3P/lOD00RjjxB59QK+1Sq7DldV1Fwx9sg4jlVpE7/2ejI//r4?=
 =?us-ascii?Q?vTjX8eqMpIfzwi9KvwIDgCrWoYitNGmSyNFbAxj5NDsPs/Wq5TDAlXhVmSFl?=
 =?us-ascii?Q?Jak2P+sa0CaJfdnHaUSoAHjI+O0UkiXr6vAm5z/j4halicaPdOsOQ0TLjvU4?=
 =?us-ascii?Q?OSrCfDxk+00AHeYVlWg4WIUNYZVqVI1oXtoVXoyEczJIDpHGTKwAXNRYVJyV?=
 =?us-ascii?Q?ryzralgdfd50Yb3E9gD/hI/1H2mNTLx8xssxr/+HVbc+31G38RhiBuRiZoCW?=
 =?us-ascii?Q?/H9IKbrveb0KM8SiRMqk93BwUL14VNhieFSfO14BbPCEo361vwvl9tClhIZC?=
 =?us-ascii?Q?jGuSr1h/eUCo+AhTZnwXpdU+As/jvLCRj9e/OY0o7moRSHsoXFQJIqSDsKl3?=
 =?us-ascii?Q?vmVugM3TxK1OpCWjwsPSAylgcAxy1PD6cq08swDnYD24rdOQvqAiHgBYMuQV?=
 =?us-ascii?Q?E/vJEWbRCAB1ZQBIwjGl0R28grJ7j+vePmz/66BLCx3F0TSiqVm3d7mUysd3?=
 =?us-ascii?Q?Dw2BZxgf1nfrNPLRU342dBHHIFBeFJ77Cr/mPEm9VzGlFtSnY4yBFAMIjJ6O?=
 =?us-ascii?Q?n8CYYYef189r/u+mp+CtKlci7KYE6Du+ZfXDnIgjETpRERGYzs0Y1VTpIOuz?=
 =?us-ascii?Q?ya1+MgH62b5RiuVV5L+CmsvV3XL9xJtQB5ghoWM1M2ig328eJCFPXJtrK9+d?=
 =?us-ascii?Q?+3aIJzR8Ze0mRldaNefrGfFySQ2n5IOCl9pl+aVqnbrrzv2NxhOZGjM1yUEF?=
 =?us-ascii?Q?Rk7yTBtbQ3qE4+JZIkQP3VaOSgMx1YTZhGPqIyk0hW6r4aB0K1kcqtDQXHgj?=
 =?us-ascii?Q?tjK4b8MCEXxH+2tmVE7UDB/JKsyYAMflYkiKndewyY0pMS6RquK7/fz976vc?=
 =?us-ascii?Q?PA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969e49fc-077c-47f2-8ab7-08dc52ea432e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 07:55:28.2191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gc2qYVdJxnO+NUVUZaII9+8lx7H/tnuryNwpdjoWZP/EdN7pMRG7LbFIcr9nK9vyXoS7+MDFCnTIIe1JyRiDbSa3A7sy4PLLaQ5qbEbpf5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8116

> There are 2 issues with the blamed commit.
> 1. When the phy is initialized, it would enable the disabled of UDPv4
>    checksums. The UDPv6 checksum is already enabled by default. So when
>    1-step is configured then it would clear these flags.
> 2. After the 1-step is configured, then if 2-step is configured then the
>    1-step would be still configured because it is not clearing the flag.
>    So the sync frames will still have origin timestamps set.
>=20
> Fix this by reading first the value of the register and then just change =
bit 12 as
> this one determines if the timestamp needs to be inserted in the frame,
> without changing any other bits.
>=20
> Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/net/phy/micrel.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Divya Koppera <divya.koppera@microchip.com>

