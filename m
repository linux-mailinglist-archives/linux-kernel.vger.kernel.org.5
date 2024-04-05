Return-Path: <linux-kernel+bounces-132643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0A28997AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2851C21300
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1421146598;
	Fri,  5 Apr 2024 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z4ezQqS8";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gY/lK/rd"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639CA145B15;
	Fri,  5 Apr 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305112; cv=fail; b=ZXLf6/9OuJsGW4ymqNkJigGPQXE0z4qDVM/uwOWWjFgepDwYv6luapxfg9jM1givxScsoEbgW5y1kfmUqEqXxszPSKJ39l8np5SgMva9LzsXOM7DwC8c/+U4dIfX60+wqt8sZSgreztNVVJTWzvIEF1eQ+VyR6gbyr6xAZFaI9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305112; c=relaxed/simple;
	bh=8Z41WmS7lYt9MsKhoTM5JVLaAfmj8+fweLkHH0TT668=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CGF4c/ZGkxp7zJPbXsUK7S9KWLaJ+mLcVviIgfsB1X+p/jDhn6cQP8bqxtLVxZ+UQqLeuvYk37GIMIxPwp6L3ydSNIavm/OKbhgO5ZFtqUxEZ3RdunUMcadb0tWKD4PU6hTcQX1y5vnTr+HkPOMghO//Vf2Ncvo7kgol31dlgpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z4ezQqS8; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gY/lK/rd; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712305109; x=1743841109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Z41WmS7lYt9MsKhoTM5JVLaAfmj8+fweLkHH0TT668=;
  b=Z4ezQqS8ifcBAp9SX/swAjfHLwBG/mcQnglkUQDCCJPzOp0emAB3BK+i
   y8Pmg4hvLuMrIYjF82s5w0CNbzBF2dIYU0R0ZL14BZCl2MY6FbNWxkaLy
   6SuJhWfmfMvHYt9AqVFUKtn+Aby08lFiu2vpSiGXQwnE3ozOcM3pX3Qxb
   uXttrgYbf7weIfyBlQrPvlFqXzOlBISj+RD+n8hR5yJWMlpxJJCZd/Hhp
   k9xXH0T1GtvXYGhTVfLiSaarSZwubJ2b4m9CO16bXc0NPP50MPSr3ad7g
   a4MCiikdPPNGIdBW9aObStFKh4gykMTfsvGt7kOp6EuzfyK6FK0dgvx3Y
   Q==;
X-CSE-ConnectionGUID: 66cgzrRTTke9wO578nAGpw==
X-CSE-MsgGUID: E9lFTJ6ATWCD3XLRrqF0sw==
X-IronPort-AV: E=Sophos;i="6.07,180,1708412400"; 
   d="scan'208";a="21555148"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2024 01:18:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 01:17:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 01:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4fC2R2MiONcRo0hIuwEehEE12/UMopggpFec1cPcdXO5qfCpIKqy5We8Jf+wNh1z/CV/K+H1kRN2vk+XlkUhBumRGgSvcUje2gOvMUuJMhLMzESYf00RpnoDkMATKgdCLecPRiBH2qtYrvkDmXjstHp0ZWR3e94e1JbPaHTxujVYWJ1+hPXon5Mt0VSSXb97342aFzOQCVwiN1O/OPi5dAGBla6SXTdQtCTF9r0qhY0SkwEoN9L8lyF+KWWth4CC/VIQfQd8DbHw2/DM5pcDJG/676+AG1g2dyeCQcZUrjoA/dupwNBNw4E8yFmaDYGOtCIcvO4xYUogKNmhAOBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adMizNLbHtA265lMI09U+R/UVL//QQ84Ny2Wt8i/uhc=;
 b=BjYv44btoj0TcLqhCfzPuY33NYNqerUEHCLGA5Cx4K4mC0TMT+soUh/sIdnSrdtsulOKcByUPw+/B4nxTY0xwTPJwwZAu+L/UukEYICU2klPTLd9RYG6WyQWJTKTS/Oaf7rH3Zc+gKVbx6lSELJkk3Q7GZqfLALyMBsdrbB4oqImHCEdNsAQWCJt0DA8Y72vP4+e/DVOBeCyK91EB9nIM+02e7mTzAhLsbtCqus5IDWV2HFc5Nj0QOftL/AGt3FHJ8Cti1hxZ48ivthCNYWtwT3tJAZDvuNxpeJJz/cMsNabs1rYq3ikLmiClXZ4UUDHQF28+IuPHmkfBPr0Z4aAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adMizNLbHtA265lMI09U+R/UVL//QQ84Ny2Wt8i/uhc=;
 b=gY/lK/rdWqYikksKuoGyikr9ag0b0G2J6F7rTs9jKrzcLpe116IX7Su+wQH/MJjtsNibf3LiRQlAF/GM/uUePGa3quyZO7FvuJz8Y+cpv/w8Rp+6p98ykt26NL8DWoofO/tAXMEVLR1bHah7w7ayRtrsJFi5alL4+WU70VriXsNdT2ZmHrmG8Azm9nyccq/hyiQuDzMgZdM0K+/KqE/fKwAEe7wbqVmFldlgrTnsXu2ljZU31u2ZjBcQvil4qRxSX188hksN/zTDsUP07+EK7LLMZKVOlH54Qo4iWYtdiiP1w8bCXILpdM5rHKFJWuvMIvK94rJ/+mwFCPUU9QFiOw==
Received: from LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22)
 by CO1PR11MB4770.namprd11.prod.outlook.com (2603:10b6:303:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Fri, 5 Apr
 2024 08:17:22 +0000
Received: from LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda]) by LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda%6]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 08:17:22 +0000
From: <Raju.Lakkaraju@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when PHY
 does not
Thread-Topic: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when
 PHY does not
Thread-Index: AQHaen5pA5HIVZmbdE+YwqVuzvYGF7FBPcYAgBgZppA=
Date: Fri, 5 Apr 2024 08:17:22 +0000
Message-ID: <LV8PR11MB87003ABBCA98F00F3EEA9AB09F032@LV8PR11MB8700.namprd11.prod.outlook.com>
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
 <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
 <22089299-a3e2-4cbd-942a-65ea070657b8@lunn.ch>
In-Reply-To: <22089299-a3e2-4cbd-942a-65ea070657b8@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8700:EE_|CO1PR11MB4770:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bKZQeTkeDo3hzE+eJT+EG5pIczqhiB0E7o9/HyS48viZuOsP7xwpzU1GpkZ9Z9/qEm4ucR/W+SyxuS0fGfU1AA3lwD8jeRCR5ibjdSjTlyIVm+txIbndgoixInUhG43isk2vo6yDmmUyfSxnNhXuT4hn1Nm8PfRoyTgZYc/XaGQot+V8P90ho4IBcb6aFGubmgm/PVJY/ViH93dVKyGlyDkAloqsNBpmv/a4lcJIRegvTyAQXx5c/NoXHbj5drAwLtx2nJM7Lu6uFnovS4rdoPL6S+u1fQHVy3IGATQJ7Dz78I9a+kuBGIrDhAJDWo8ChX4x+wDfQ0IsupHicvhX/KbYdbMaqBhHmSA6ZF6F9/6etKAhHgR1H6d8zxuzlPYDZ6GVVRNICS7vdTXmX85a6FGMbwWK1W/Yfcwx9IQ3jSyLc5604XX49UwhZy1nbdUwK18pLjW6y4YpWcRFqIWv3jND0JUBMlSGsGJ5m5NnCuaAjJ70IaCONFAWzWEnWpLGy5YUHWh0dv7/HzQOApTkTSilRJvMEt4qOSgrrqK9TCOBwFpf4iIbLT7PZ6YThYPe/gxg35wvbghA7CkGL594wrC4WyR4vdXVBKRgnIrx7uDMVKYfhP6AzuAcypfVy9s8mVNOGK6uFqKLMIZkn7yOYlJZdQTNzLOYjL++qinbrhQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8700.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2C1G5LQmtcY5AcXFBtPdNsMJx4EuucwGbgoCBqMFdoevDfkDnMURFbBX2rWi?=
 =?us-ascii?Q?VBLX86AcSkpSj+l+9fbbAb6DmFwAtSoKuHbznb1tQk/oPnLGpV0jxX7qPBVk?=
 =?us-ascii?Q?J1ZdJrg7xZbCW/JDDCksyZiatLjvsaHYa1f2aTm4gHi1Po8xNDNLM9cv6Jg0?=
 =?us-ascii?Q?Mb2ZKhjGQqR3xdRjGYZoN7Bsc+RLHs595TUvXz9zHdFcIHq2XXqScvha3Gau?=
 =?us-ascii?Q?Ypx/sv8vrLloKCwIey3ZtqSsZlrO9fobgJQpcf/SsrlfV3gGVQJ4eHF4WIvD?=
 =?us-ascii?Q?y49O9Xo0Alw6uKO4ClsOxtEmN8ulfsYGoPdS+SqH666kcmqnAIaC7XHx9oVe?=
 =?us-ascii?Q?23pIMFl27VH0zmj1y9arpkROfC7WIxrDR0qtTCY7Gx2IZwO2zlU9HC89KTJ3?=
 =?us-ascii?Q?ymV6rOCK7RHF5JKSgbztK5g+xRqNlK7p6RhjBbg6W4il5H1tP1rb4nSs4/zl?=
 =?us-ascii?Q?HGCWjlP8USsWb9VYMHpbfnbUbmvNeycC2dyceRh80h9U0UJO7MmnD8WprR42?=
 =?us-ascii?Q?mj0MX4RFGN69zLUp4RUnkD1mNkLd5CpAIocjRod7gEwjpmpPKECwbywnkRHU?=
 =?us-ascii?Q?MSBkG0vhhM1hKudG67ew21s2DSMdh99K7Wj5ypPhNZkR07J42cp6sp45vEhl?=
 =?us-ascii?Q?21/sF0MG4BB0kTAB288XyNjg9HtdRui/dADI7LyC0H5mDIwTx90ucki4rn30?=
 =?us-ascii?Q?nBuHt04MAMUNLqUP+IFvDLIswAXbkDSGJGUxcy+a937VfNgZQ5AQmAvCTi77?=
 =?us-ascii?Q?tlvX0cwQ2BiS8rY+CGXrAU8d4kWnYGG9QkQe0U6lNxoME6FxRCq+zTkYC5FS?=
 =?us-ascii?Q?09S15m2LPl/RSRigOgGbZ/OY9MOwbEN3KERRxmI8n7zNM1+PrqJmvED1Qg5a?=
 =?us-ascii?Q?6l53H4zXNAW6kXGO8GS3z3Zs2VNvTR2h6gdRilldLE+ij3pRLxsriVuQaB7A?=
 =?us-ascii?Q?5oYmw7QlN8lywueaeuW7xf7ljVIi9RUTkgev3vJ0HTPGZ7UCUAqtWTLzk1pg?=
 =?us-ascii?Q?q3ZDM7AkxSINS48jbxj/2bi4rgl4n5Xy5KzAR2EItj3IEGr0qLr8/18sGSGm?=
 =?us-ascii?Q?g3fjl47sxdGpge5NoTHSGFmj11203HSJOLU+rMp69ZUAOO2g82GHkCq8rsrf?=
 =?us-ascii?Q?+mIPWzkk12ejSyLHr2IRw7hi8bYh9CAi1nA6cXhvYmTOo24Wa1l2Vt27+WLO?=
 =?us-ascii?Q?xGAeQhVglPILuOuvtlfNZkLZERWeJYFUcFeR4rt+U2R8EWriDTkzsPAQXZAY?=
 =?us-ascii?Q?lm5BBwc9t0CUvJUR66OHx1TZa8KcD2uIRrTxcBenI4bM5fUzqzId5KqFWOq7?=
 =?us-ascii?Q?R/r/8W3CypyYwCnT/b1Fwps00VLupCndGSr7uwz5YZI+IgnlI9uATXSxqTvR?=
 =?us-ascii?Q?1iInNu9CAc1HKgvX19HSviMf4kYC59SyvTq+Nw0d+5OYM2TZI0hD1bT8kbqI?=
 =?us-ascii?Q?SpOXvkRLhPxWaQC2FwlpOakiRgwuoLNtidLwvaqHWVMlLRnEU0aybxa3M0aR?=
 =?us-ascii?Q?Bh3iRItIlP0E3t/XGGKdewv1yn76LzhPi/fu1u2XDy8gjVBhHQSwYapeh1a4?=
 =?us-ascii?Q?n8idcDgA3Cc1Ka0hgAIG9UDfG2HqTN0YaY8BSAcRfew161pqgZzJ4DwLMwnu?=
 =?us-ascii?Q?Wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8700.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95e7813-8568-4a46-f854-08dc5548d190
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 08:17:22.1185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sffs6XGMsSZkiTrHfc9SGv2nQ0VLxzrHLa0y0QnyxuaXvrYeZ4GUZEL0wOBb5qQY2N583yaqJU9JiZ0l4AXv4fDIvQvd9BZrR5kK2SvhuQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4770

Hi Andrew,

Sorry for delayed response.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, March 21, 2024 4:23 AM
> To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org;
> pabeni@redhat.com; edumazet@google.com; linux-kernel@vger.kernel.org;
> Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even whe=
n
> PHY does not
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > +     if (netdev->phydev) {
> > +             ret =3D phy_ethtool_set_wol(netdev->phydev, wol);
> > +             if (ret !=3D -EOPNOTSUPP && ret !=3D 0)
> > +                     return ret;
>=20
> I'm not sure this condition is correct.
>=20
> If there is an error, and the error is not EOPNOTSUPP, you want to report=
 that
> error. However, if the PHY can support the WoL configuration, it will ret=
urn 0,
> and this function should exit, WoL in the MAC is not needed. And doing Wo=
L
> in the PHY consumes less power since you can suspend the MAC.
>=20
> So i think it should simply be:
>=20
> > +             if (ret !=3D -EOPNOTSUPP)
> > +                     return ret;
>=20
> Do you have a board with this MAC with a PHY which does have some WoL
> support. Could you test PHY WoL is used when appropriate?

Yes.=20
We have external PHY (Max Linear GPY211C) attach to MAC of PCI11x1x (PCIe E=
thernet chip)=20
If I don't register the Ethernet module in wakeup source, WOL is not workin=
g. Ethernet device power state shows as disable.
i.e.
/sys/devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:03.0/0000:09:00.0=
/power/wakeup   <--  disabled

PCI11x1x is PCIe bridge device between PCIe and Ethernet along with other p=
eripherals (i.e. UART, SPI, I2C, USB and PCIe devices)
0000:09:00.0 - Ethernet device
0000:05:00.0 - PCIe Bridge Up link=20

When I test the WOL_PHY option on setup (PCI11x1x MAC + GPY211C PHY), obser=
ve the following:
1. When enable WOL_PHY by using ethtool (i.e. ethtool -s enp9s0 wol p), GPY=
211 PHY configure the WOL. After resume from sleep, GPY211 WOL configuratio=
n vanish. Observed that gpy_config_init( ) function reset. Is it expected b=
ehaviour ? In other mail thread, we discussed that Ethtool configuration sh=
ould retain after resume from sleep.

2. when WOL configure with ethtool, Either Link-down and Link-up on CLI, WO=
L configuration vanish. Is it expected behaviour ? Due to this, every time =
we have to configure WOL through Ethtool.

Based on above information, We need to check for return < 0 condition and r=
eturn the error. Else enable the wakeup by calling "device_set_wakeup_enabl=
e( )" function.

>=20
>         Andrew

Thanks,
Raju

