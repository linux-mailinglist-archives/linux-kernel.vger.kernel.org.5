Return-Path: <linux-kernel+bounces-100961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3353987A021
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584481C222EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0793FC7;
	Wed, 13 Mar 2024 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EU30Eq7e";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="G8klFv/B"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB12F35;
	Wed, 13 Mar 2024 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710289355; cv=fail; b=LHW9dQwY3tjvFdJEJqWE5VSzTwi1rddtxinaUDgakjrKGpPpcc2jhpvVG6Cc3gPJdKhph+ASSFeCTdfvXy9WuCqZxduSo3VizJEZV219uzpkG560qFHl65WEPtVmw7TZCmlUC+30x9NvtSuk41LSAfehq49vl5jhIUblQzmSBIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710289355; c=relaxed/simple;
	bh=7V/qXz/Aq+OevAekFRZhXYymvndjpn6ZRdV4Q+xmxl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hv6Xd4QKMCSnjKLgufysjvJHD89rsE4KiVSl5T+w6N5D2J5ktglnU/KZTuzCtRf9a1JLOUNNEEvLJZlSCr6ISAAKAXIZkh+F2j9vKf1Ss59rUH4oZf8+vQkxbxfcNsk6BHkm1SHnMwUaqcnu7j7fNDDDboquVb5hmdeI6dsNvKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EU30Eq7e; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=G8klFv/B; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710289353; x=1741825353;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7V/qXz/Aq+OevAekFRZhXYymvndjpn6ZRdV4Q+xmxl8=;
  b=EU30Eq7e25CUO1dsLKpFiypM232vJyH89skcwg8jFAigsYgJkLWksKrQ
   o9oSRLCHX1jI0FegnjxmQzsksYVjGGxmtNg1x/6tVgCNcXUTniveKLPlI
   OLuo3ItEi4uqCJJ2YEi7rPP6CpMYPzDreDDd6x12V0u6TJYRPvoORTsfC
   SHRUduAccMhfUHdXn+Or+87n3SflCurE1Z94KJL5b0QeO1bi0yMpSzEbl
   EhI2KCYvC+Yi3h+ifr63iqGIYCZlm85fJ0+R6bdg6g+0WrJv4u9vYkfhz
   MGr/8/BRkPMXK0zzTguXAlm9i9lIX6Zy2btMw7HFlZ8eQz2m67Mjv3JXU
   g==;
X-CSE-ConnectionGUID: KhRUKrT3TA6Eg+gH2POjgg==
X-CSE-MsgGUID: kuHwPgwzSayTYzgB8WwNTQ==
X-IronPort-AV: E=Sophos;i="6.07,119,1708412400"; 
   d="scan'208";a="248349673"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2024 17:22:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 17:22:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 17:22:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/BLJ2r1JtBLdC2gyvM2iv4wiGOeKTTXEIBP2ymeSfajNma+BcAzVQJpX1zSK4/aMv3H7GmkpcFlrxEcrhGuJGrP468c/CaBOg9oAo9oF2kh3TMzUTzmXILrX+pGJED+r0wL7qkZcKno8rSTKV5cstGlmeuyT8Cfj+Cahjhcym/yWd8dDEG1/NSKt5sX2l5GVCNP46W2AxgvwjAw9KQJHMzV9JYZUaS7rMsWvqo+gXhlBgU3clJvXuw6URkpk7yXc7NWNlU7XcZDJEgbInctJRAgcdUtaGOP7mcHR1xGd+KvhDrZahthuRnUM5c2h1/9S5pvTtQQB5VNM6j0pby9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5Y2PelhGziS/gBZ1em0+JRIBX4fa00hNGZ0zI6popc=;
 b=lLJFum+iFS1dUlQDjnSu7FGf5MhDyK8WYpjh0zKIHE7T/nkC4K2BGovhaA7ZFWLgDgMtJpo8zILwgH2DBLa5EN04Ol6stttBpfp4eZh+Wy7SifFtPeUIWi1jpE7a5UglgvAhYCpUMYn9nKTbkVmc79yHHOVXBULhWrHLU0ddXY1M1YHYnY4gnv0Zttde9JWkml5SdVL4xyZmyONkYzC6HFD8bktC78BTiEVSOvO3IwokxrisgAB+3M29mGE5fNeBLQuDQtUuLHCvD4SJTlGB8QdiNcZDiom4NqdPZqEiqVeAMYbOBsYUnae1WRRZxql6rdtSQi0vJ12ZigGAQmbgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5Y2PelhGziS/gBZ1em0+JRIBX4fa00hNGZ0zI6popc=;
 b=G8klFv/Bs2e2aJ9pT2KbNXo/5MBGmBeA3Zg+OLj0wisYDQjE1Or0ZeO2D94SI3X0EIbpN1cY+T3wjbIvwcQQgE8EYOyzyA/vYYfUtUfFGyqbawqGfDv/0Xk08FeIqLWt5r45j5m17fUJ+GrpmfOwsRlQTwSxvbOgsNL/I/HxqQVA0iObjUTKn0RRqCk9FEOIJacO3PgdrLy6eQWxFEvC+PH8xpB0acq3QeqPt3WYkSzvNxiW/zuKghHczT17u2Zx4lYkK4v002R/O19QPO4FhbLurDK13BXM9K8JG9tc7b5jzuY+zhdD3khsaEJLIvKiBRCxMmW+yRqE/2JlEhZF2g==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by SN7PR11MB6775.namprd11.prod.outlook.com (2603:10b6:806:264::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Wed, 13 Mar
 2024 00:22:03 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::1a3a:422d:1406:cd7]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::1a3a:422d:1406:cd7%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 00:22:03 +0000
From: <Ronnie.Kunin@microchip.com>
To: <andrew@lunn.ch>
CC: <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<Bryan.Whitehead@microchip.com>, <richardcochran@gmail.com>,
	<UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Thread-Topic: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Thread-Index: AQHaaIt9/9VvJ3PDJ0OgsYtGoeCEQLErcdiAgAIgIYCAAJu7MIAGjQ6AgAAJaUA=
Disposition-Notification-To: <Ronnie.Kunin@microchip.com>
Date: Wed, 13 Mar 2024 00:22:03 +0000
Message-ID: <PH8PR11MB79655416A331370D3496854A952A2@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>
 <78d7e538-9fa0-490e-bcfb-0a5943ad80c9@lunn.ch>
 <LV8PR11MB87008454A629EE15B9CE14099F272@LV8PR11MB8700.namprd11.prod.outlook.com>
 <PH8PR11MB79656DCF7806D7390C7100DE95272@PH8PR11MB7965.namprd11.prod.outlook.com>
 <fd22d022-cad4-489c-9861-36765dd98a87@lunn.ch>
In-Reply-To: <fd22d022-cad4-489c-9861-36765dd98a87@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|SN7PR11MB6775:EE_
x-ms-office365-filtering-correlation-id: ad6a9c98-bd35-45a8-78d8-08dc42f39bb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TkLOC8Pk+YRR38nFB5B3HajrEg3lYUEQPGBblnihPci+YY0l7DWZV6ODkkNis13aa3qnDVThIe4YtolZBGgY2r1roExLIbW2VTLioOjITKpQo+XYNTG/nOHQM1NkFdaJT+yU0bkar5Gm+n8q6ocqiTGO9E+ZcR4qD7aV04430EzySDKr+hteNUZCz8bMQdd7W9/f8KoCCIpy+7f4Z7gKVCa4lFY/Oudp2FJ9sKfChzppQif54iUtk0S2U6iFutgyX1YgmisnyZpF0aYOFn0b0d3uhNW53idRSlDmVHO/AHPcO2RJcn1W739XjlhXWViZSg0v3M9ffXRZjiHrolthch5BIZ/DbP0vvmO8mqcoqTDwIuGY7w0KcEVdzvGJfFFin6ivZ17cGG/63k66RiessDHGVInw/H/pBglZvoRG1Nr4+HoisvV/HFOgH9f4uG6kHSwUzwfhpPegUsKu8rdP6F5zCmCEX4zcZsRyC4alZGRhUz0PWzX8w4ufXTMR9h/KpvnG04Tx+3o0Ur0fmQ4t+5VWa62SNeB3qFpm24UrOdy/shqQU12AGFdp4LUSxwoSTCEPMc+0GhdAm2e+QWsoQdMvHYSjUD6wR9i/LSXml4zUyj7ufjLxcSHDQqCIRkA0WVfP1rR9rExPj7wUAJWlxsK6qIUIsKbMvhqbFeZGhuk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L8zeplNdxKXr74rznsup0BHtLcXWEsnZ63UihnoCgk1ChM5nPjmy6tLEZzlg?=
 =?us-ascii?Q?zHMPlG+AknY8tR1UDLIStDelllJsc1rr8W6tTtVxfJ1Yb+IdKle1wdQ5uYnM?=
 =?us-ascii?Q?ltU3lf88uwlGU69lxG6op3GFlL0hpXgZb4AUh5D0YxS0a90oFNRXxVWaJkMC?=
 =?us-ascii?Q?rkin4CMdKqSXJ7NIzOOIfioN62w/UUK9p8RrO9GSOZ6mlRv4nFflrJ3wWbvz?=
 =?us-ascii?Q?O+gauF8cLV/TQd9fg0zvBrnaDKWDeYIdQ9j/1NsHnDh+YIluduk7yrBNg6bB?=
 =?us-ascii?Q?o8LG48rrzU1T8TpxvVkpqP/M3xXQhM36vkXIELTOXbk5h+ZLom+riBZ29Mgr?=
 =?us-ascii?Q?a8iX5PLJFgAa4YJx3cY5ptRdpJ4VA3411vNfuhum5FkBgyR5VPHndzCMirdN?=
 =?us-ascii?Q?WhyahJs3oKEJj6NDFq1QMMQ/bXYET9UEppcNzmfEHtCW5DoKF5KoZEQbgKch?=
 =?us-ascii?Q?TKRnnGszEnOkslf8nSwP6tcSjKboqVy98uxVMt3t8XNoFDVqCPeKoYASfbBm?=
 =?us-ascii?Q?G3KwX1kPAeyYOgnkw6gsK+duC8wUL1Cf7W8IN7BiUL0k2nwogDm4RQ9H85MQ?=
 =?us-ascii?Q?o4SqBM9yHX83RjVu1l6oIMmtmkuf03+gRI/FEQJpMGiQFuTdPsTKSyRPCScb?=
 =?us-ascii?Q?8pKfh5XOZpasgXycIGB9ZH4sFmkbLRGLjDWBzvenqDFIZokRAyrHuAFnILl7?=
 =?us-ascii?Q?oEkpU8wRf0QKZ5Vtshx0GdqQFM+mgPmUguFwCy79VuwhFgTjA6aRKuoJpWWX?=
 =?us-ascii?Q?YHAS7zBnePsellYD5sQW9K4UG9vmA8S4LVo6QQz6mmmAYam2AH06qnAuAMbK?=
 =?us-ascii?Q?dQUP0RsdOHzIMbKtpiVRR8yOo0Zgp6KubuCABXACep5WKM39IiWTgY4tiQs6?=
 =?us-ascii?Q?NKMptNSz/fsWq3WZo2IYCstAKnOZuWJGsupLFIpJhnGnt3wSYFfpQovy5vfK?=
 =?us-ascii?Q?6la7vRoXhuAiGjiYSDcBztKkmnErOWTd4T9f9/kHxTQlvapOel+m0T5J9fD8?=
 =?us-ascii?Q?oRTyJcvePX99kKJjY4Tyzyat6Szj9b5FifKNrBVgWxqnk2qd5r9v75EM1Z6D?=
 =?us-ascii?Q?bKu+3Xl5rYD8O1mWMOd971UXIrhePFvEH+q1qIJhtTssuR9rF8/UB1jtMx+S?=
 =?us-ascii?Q?ppQcuwnKgjflPOdHSH6MO7C6BRdRNDxfiSOqueD+qk3bZCB6rFbMauY1pKrT?=
 =?us-ascii?Q?P6bADEKIUb3jW9t058wsAfZ6TFNQ3TdsAz4C5WHX8flNk/7LKcfmmOWiLdeD?=
 =?us-ascii?Q?e+KxnKzJoKR2pCwGcsl7dz8bHu4g/aLab4JlKgZGKZJUKPEbOFbmoArT5/8T?=
 =?us-ascii?Q?VuRvpMpKhuSVReGx7ntvim3TZlll1xdNzBKEnY4fyEXzUavRquU6Z8Pshlkc?=
 =?us-ascii?Q?WZtffrBIqMHWaaX8GbG5JTr37mgDMOrNy+CXLc6zW4Bxl1GseP1R19WUr4np?=
 =?us-ascii?Q?nKwboDX2ncKfEuq663t8cTfRmkaRYf6rbP1iUSaI/khULPdrIguMPK+eqSPy?=
 =?us-ascii?Q?F/S2g1rk/VVXXk1gamNcmgF4XLd5s5aIx6rXF9ow74BcbiBb8oP0Wx37gMJx?=
 =?us-ascii?Q?qSBuzYnugw572pjparRcYiLEVSaHgwHDMJHJY6ag?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6a9c98-bd35-45a8-78d8-08dc42f39bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 00:22:03.6408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBVe+qRYEZNgmvNvhx3I+W0OP0ZAhFB3TOICiJnPOYo/jOUy9GEySg93jnSET56QW5qa2TcAMH2baKkK4NKkfzbrm9I4Nw3grEffleIrvro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6775


> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Tuesday, March 12, 2024 5:41 PM
> To: Ronnie Kunin - C21729 <Ronnie.Kunin@microchip.com>
> Cc: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>; netdev@vger.k=
ernel.org;
> davem@davemloft.net; kuba@kernel.org; linux-kernel@vger.kernel.org; Bryan=
 Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; richardcochran@gmail.com; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>
> Subject: Re: [PATCH net 3/3] net: lan743x: Address problems with wake opt=
ion flags configuration
> sequences
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> > I understand that the TI devices give the *impression* of supporting
> > both, but based on what I explained above, even if you accept
> > WAKE_MAGIC and WAKE_MAGICSEGURE on a set and report them both back as
> > enabled on a get; whatever behavior your hardware does will not be
> > fully compliant to both specs simultaneously anyway. I discussed this
> > with Raju and what we decided to do for our driver/device is that if
> > you pass both WAKE_MAGIC and WAKE_MAGICSEGURE flags to us we will
> > report them back as both being enabled in a subsequent get as you
> > suggested, but the behavior of our driver/hardware will be as if you
> > had only enabled WAKE_MAGIC.
>=20
> So i agree having WAKE_MAGIC and WAKE_MAGICSECURE at the same time seems =
very odd. So i see no

To me it is not just a little odd, *strictly speaking* as mentioned before =
it is an impossibility, since no=20
hardware can do both at the same time because they have mutually exclusive =
requirements=20
for some frames.

> real problem limiting the driver to only one or the other. However, if th=
e user does ask for both, i would
> say silently ignoring one is incorrect. You should return -EOPNOTUPP to m=
ake it clear you don't support
> both at the same time.
>=20
> I would also say that silently ignore the Secure version is probably the =
worst choice. Things should be
> secure by default...
>=20
>      Andrew

We were just trying to accommodate your previous request to accept both "if=
 the hardware supports it".=20
And even though I didn't like it, this was an attempt to answer my previous=
 question: "what does it=20
mean to support both magic and secure magic at the same time ?" in some way=
 that might make sense.=20
It is not that the purpose was to "silently ignore" the secure flag (that's=
 why we would still return it as being=20
set on a subsequent get), we just took the interpretation that both flags t=
ogether meant the user wanted=20
to do an "OR" of both matching conditions (secure and non secure). I see yo=
ur preference would be to do=20
an "AND" of the two matching conditions citing security concerns. Honestly,=
 I don't think there is a best or=20
worse way, in my opinion the user does not really understand what he is doi=
ng if he Is asking to enable both=20
secure and non-secure behaviors simultaneously, so security is probably dow=
n the drain already anyway.=20

In that sense I would have agreed with your recommendation that the best co=
urse of action would have=20
been to only accept one flag individually and fail with -EOPNOTUPP if both =
come simultaneously.  And=20
being mutually exclusive at the definition level that really should have ap=
plied to all drivers and hardware=20
(not just Microchip's).=20

But then I looked at the actual definition of the flags themselves in the h=
eader file and I see this:
https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ethtool.h=
#L1993

#define WAKE_MAGIC		(1 << 5)
#define WAKE_MAGICSECURE	(1 << 6) /* only meaningful if WAKE_MAGIC */

And even the ethtool manual says this=20

                  g   Wake on MagicPacket(tm)
                  s   Enable SecureOn(tm) password for MagicPacket(tm)

So the "only meaningful" comment seems to imply the original intention of t=
hese flags was that=20
WAKE_MAGICSECURE is an optional  modifier for WAKE_MAGIC. Since as Raju sho=
wed the ethertool=20
application always overwrites previous settings (does not preserve anything=
) then you can only use=20
WAKE_MAGICSECURE *simultaneously* with WAKE_MAGIC and not in a standalone m=
anner.=20
The ethtool manual seems to me to reinforce this since if says "Enable Secu=
reOn password FOR magic=20
packet", rather that "Enable SecureON MagicPacket", so the 's' option is so=
mething that enables the=20
addition of a password to the 'g' Option.

So back to the beginning it is unclear what should happen...=20
I'd say we seem to have 3 different approaches. Which way should we go now?
1. Follow the definition of the flags in ethtool.h and ethtool manual:=20
     - accept WAKE_MAGIC standalone and wake on regular magic packet matchi=
ng=20
     - accept WAKE_MAGIC and WAKE_MAGICSECURE simultaneously and only wake =
on secure magic=20
        packet with valid password matching.=20
     - reject WAKE_MAGICSECURE standalone
     Note that this is not how any of the current drivers work and does not=
 follow the conclusions from your=20
     last email either
2. Treat WAKE_MAGIC as a request for magic packet behavior; and WAKE_MAGICS=
ECURE as a request for=20
     secure-on magic packet behavior. Since they are mutually exclusive onl=
y accept them individually and=20
     reject it if they come simultaneously. This does not match the flags d=
efinitions or documentation, and=20
     it is not how any of the existing drivers work, but it has consistency=
 to it and it is the way you were=20
     leaning in the last email based on what we knew by them.
3. Follow some of the other existing drivers' code behavior (Broadcom,  TI =
or MSCC), which do not seem to=20
    match the flag definitions (because they all accept WAKE_MAGICSECURE st=
andalone) and we do not really=20
    know what the hardware exactly does in some of the flag combinations / =
received frame stimuli. I'd rather=20
    not do this since we (Microchip) will probably end up behaving in yet s=
ome different behavior from=20
    everybody else for at least some frame stimuli and not match any docume=
ntation either.

My opinion with this latest info from headers / man is that we should follo=
w #1. What do you think Andrew?

Ronnie

