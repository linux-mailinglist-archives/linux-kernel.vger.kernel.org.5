Return-Path: <linux-kernel+bounces-82997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A6F868CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C0CB23DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A713137C54;
	Tue, 27 Feb 2024 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aHKIxhf/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iWP6eU0E"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447F138487;
	Tue, 27 Feb 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027922; cv=fail; b=Zlrd9SR3X0JuDVw+4eqreiciwOtWF8oEiZYJDcFSC0/ZVbPk2NjZY7Aq8A3cIlpAvR1ReoMqEj0PebzKxvI8FylUV7DwpM6FhJSPDKmse4YUg+yWJV/28n6M4tSRE8TluWF0AatxqwzSmy4LsqaYkEv/49G4UXppKlrH6neVzDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027922; c=relaxed/simple;
	bh=GHV87ifJdWAx1NDPU4N+OnmXdR5txpwxQuAfvjXmn8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S4aGWZPM/U4IKtELTkOT9UjFb1NVoJQdwMa9qLvDSj6C9IZukwZsQ7qytoOKgOS+VL/BHs//ENZnzJiq7JUc4AaotzqfWLAOscayQb6Bo3Cp0nmUGWpb0E2h0mSsFj2VF7jsI+mzu+X+U7JD+bNCMeoTw1xKJRdAYB37x6zaCe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aHKIxhf/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=iWP6eU0E; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709027920; x=1740563920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GHV87ifJdWAx1NDPU4N+OnmXdR5txpwxQuAfvjXmn8k=;
  b=aHKIxhf/nPYruH7CpK4Uk8gcm2d90V7A0V1YEu6ZBu3Y+4NwveAScknh
   0z1/+T3NjAIz1Id6oaNCYoW2RF+J0g1t/BkiMEWI5owaQvKgfI0mz/e66
   yDDiAMPj9+DfVT5gX3un4r1YQoZZoFA8MZKV8xkuVYtm0+6t0yllki2u0
   WjqkF4h6VIFhr3l0zBrw85dZWGeMWpUXwk3B6/o4aaVlzvv/tW9zXrKEX
   B+4o0U2EFjm5WHkwXOHiUuIHgLvYjjBFcN5WgB6QgK4xBcp466+de9uNu
   xKxhpuSDzJnJX7ho+miUakMBeSW6TFhZPSgnUU8LV0fvd+4Yq4mTQzKwy
   g==;
X-CSE-ConnectionGUID: tfupFdW7QZqkQH/nMjcZVw==
X-CSE-MsgGUID: X4tghjmsQuGR5YbTYjrRrg==
X-IronPort-AV: E=Sophos;i="6.06,187,1705334400"; 
   d="scan'208";a="10870191"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2024 17:57:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHSwBTEYJteBK+FDqbpmE7vNzR7jZMYYwOwY0pTsMaEOAPsvJ0LjwXOdRE69XtEIM3qIEcFA7v34xeYAwTRqmlrHxlXjDGO2rPo5vo5z7g8wYISZh/3yOqBCh3+cg28Vl4izV1n3/fwqT3JtFVYgHKQRlfXJgrGPK7iPX9aOfCCa9zkpDI3p4k7AEYJI+vwPfe7/31kQKg37f9Uo2Wa92canX3RtRDaTY7PZ4OBQBaKmRGD4gnJeuYXSI/pLDKkmPMoqJ0SzDsB8owGd/TH4RXyWhj36AzkQIwqx2YT5RtMjlv3Q0mAgVe0Bf4mXmVNX7/+9N5MiGj34ULWuC2BGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DY8rQHFiLGrIMONGp+e0lhstgP4OxdG4GI/HSCWNeEY=;
 b=lKfbEXqIxmbjXvQYplMPrN5cXcIslGVhT+N1ng5ytqp+1ak0PStrQ4RVtqxQ/nEBH33T/w3jMtb6ftX71nZJtIY4JK6c3+GyCUpAiCiz/p2GoZunUbvNV/euTUPTQt2k/mdMJJLVKdZVTpziGPMzKzinXGar5B7+HFFXtzbuTF2OA/3qde5xutzGeI+KXQoOu35EFGEvQz2jd4JIfzF15QwfwTu3I3Guu/eJvt/fmljkcPhEqKA6lGy4ZcHdBlocLKR6Hg2N0N+tTL37mZ1ZYynemKJ3DPoSGFZlqxPMSvjgxicUlelg7c8q7cvJjsAbRnt5p4nCl06jMNyo5FvByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DY8rQHFiLGrIMONGp+e0lhstgP4OxdG4GI/HSCWNeEY=;
 b=iWP6eU0EluLv7kJhGm/yXMkPZIaWlP+vSFensXE51kSrDm+I5AFEZ6XPl0iFqpl2ErgLcnENo5jKn2BtpLLI0BVG7QpSKlZUKm3j/5hCypMmH/xIAQv+0KeG6K6dmBTJpK5qIeTiXu5+jxjbKFO/nEokGozB5fi7OVsLvWeQens=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7167.namprd04.prod.outlook.com (2603:10b6:a03:29b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 09:57:28 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7316.037; Tue, 27 Feb 2024
 09:57:28 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux x86
 Platform Drivers <platform-driver-x86@vger.kernel.org>, Linux Regressions
	<regressions@lists.linux.dev>, Linux Stable <stable@vger.kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Klara Modin
	<klarasmodin@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
	"danilrybakov249@gmail.com" <danilrybakov249@gmail.com>
Subject: Re: Fwd: Continuous ACPI errors resulting in high CPU usage by
 journald
Thread-Topic: Fwd: Continuous ACPI errors resulting in high CPU usage by
 journald
Thread-Index: AQHaaVYdGLK+hvmWCEOd4DEwa6IszrEd9BCA
Date: Tue, 27 Feb 2024 09:57:28 +0000
Message-ID: <43nj7od4luzqjmto7tddhtp5kqi5gbqgeq5v5qiqijydkjgma5@li525a32nds3>
References: <Zd2bsV8VsFJMlbFW@archie.me>
In-Reply-To: <Zd2bsV8VsFJMlbFW@archie.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7167:EE_
x-ms-office365-filtering-correlation-id: 80d6c41a-b833-47cd-d232-08dc377a8207
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uuK3hPt8lNmvNJn9+kFMdoejBn0Sv3M+439qPs4t+ajrDiZ1365DVahjBRzi7l88dX5LH6ewwV5MusqYj+s5AARfuEgmicTDf3P0k5X7O++bo/Wmy/x+Rm5zEbOR2z47umcASGrpoUB/I5k1/x5etvfeVdyXQfREymQIwGC8CYNYsJOQQDUbNuABaVVNjpV7pDTByvsdHlBlNKmAynMEmothy+/0lVqShlfo49rBN0L0Hym+5Er58cBQ4jpfFHtVrDpggA8rBYYofzRjxMZvDN/lI3MUnPG3SD23zkZEOwiHzCfAOUjBXEUgDDjjl3vbPNcckzAkrW35Hh+6L6o9nISUrse/I9oPKa0HiQKcmS9d6FRZnfKrPslcekU2ztSt34XIi9QzrzGENsxdFjuxYeJE2KxvtLj3g68DiuqjWZJp4hksVHGbDcTsn58WAgpym8/y6ZcnOehVph4cmmCsPa7pF39e/Ktlv4WsE7qudA4zG0hXDwhgTZXtyzJVPy7E7HBHh7AYoM4Eu6u9X1OAJISa1bvNpzEhQtNCP6p+2E59w8nLtdgNVG3A95Gffr6yoMFkUfIymO69gvGn7M3ij7uL5Tr4dnA6EaElp5B+HkHXbTvEjljvLYzCxNCchvvmMmpVmyWrvwYVMcjTIHvrgexrAQI+Boon4Jh9NRGQQnQLQ86L2iZseNnsRBANQtiXrt3FmeCkb+/RXCcH7d8XSw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ocFZ5AGdM0y7yHzBYDUWP8jkzhvHTA6x+9pitLOY11rtaKQAR8cjVs4+s2?=
 =?iso-8859-1?Q?rDLSaOBhw1j7QIn9uV4Z0jSOw/Rw6oxml+HtvH8+7RtKG8hM+V845C415+?=
 =?iso-8859-1?Q?TuhetwtqjsyaoDmtgCWxE6R5A6nQB8YknMvgx2Wu6GnYwT2fJwWdHLPoXv?=
 =?iso-8859-1?Q?nDikhMT/P2h1/U5vXalj4ZVS3obEY0HZsQVRvOBWrt0sjQE2iDM6UHl+sc?=
 =?iso-8859-1?Q?L6G7SOW5rHqTCPSf/tPSIzg/p5ysTygCNoMS9ZbuQ+4jCyi4swbYzf1e2b?=
 =?iso-8859-1?Q?yz7arkSGXqkSftUz+UTlqxvk9P5vxiT8j336zbYMW3p+iRidllKoicem6s?=
 =?iso-8859-1?Q?vKOqB/y3l1EC2eGCH1Ty0KchjXHJugdhMhbFo3U31YvDwjK5wSzuHAnL8R?=
 =?iso-8859-1?Q?kON3gtMS20v+FLtKiOGAzxZEMm7+IO8qsk64b63uW77U0vuUmul9OPqU3v?=
 =?iso-8859-1?Q?MA8GNogpdNfW+MNQSJ+qD/1hpk6CpIgpyHFssC4k6TYVEL+eehN83GQFYh?=
 =?iso-8859-1?Q?4NUIcyMtG0iIFLpMx3s2i0/L2s0c2GLK8OGTUe9ImLi8KuurBi33byt8XG?=
 =?iso-8859-1?Q?Z7A8TrIkFpGGpksRvgBXi4BzankYj4pzMYRW3Nd2T5AiutyL1+Kpmf12iZ?=
 =?iso-8859-1?Q?YavF3G6l9kPjeKcK5cHLyG0xZzdpX0x1Qex3mt2L59I8mIhK02W5e1SDV5?=
 =?iso-8859-1?Q?iBEt2VzC8SpYooAHxsXdCck+oVzFoouPVwZOQ8sbMpEjAzKFJ4GxDbX+kE?=
 =?iso-8859-1?Q?QfSa8oW7LZiwBIj5Q7XF3Ny4BZfyi4+AzQUgSvH6JKtwkj+i4xZVg8NagZ?=
 =?iso-8859-1?Q?t4L75mwyGpzhAxKR7N3zNFyGc6LEjJg/ZUeb+woMjg/LbXxkvyvMQ/kv45?=
 =?iso-8859-1?Q?NPSWGVe17VyFDr3LKrEVoAcNDO3r/6BKOAYRS/MGzDdKkNp2Q9SP15uIcx?=
 =?iso-8859-1?Q?uhlgK0lfK1q9zP6d44cVL8z03Oxd3eoWg1WaswhoPD2g1woetam02/ZuXC?=
 =?iso-8859-1?Q?TghJU/iSS7TWx7/6HqAjw3LT6OsTtCxgOgRofjBb36s/DMAiaO8O4d7Ro3?=
 =?iso-8859-1?Q?C65+lRwCwaVjvfvuj4c3g9gKV64HiiNKBbUVPnOyv94cjo1xw8vvAAxtI+?=
 =?iso-8859-1?Q?kVQpRlrUtakK0iquuas0oYbgkwaUnXyxfJw8v/f/FR+L+Etd9rQQoW/BEc?=
 =?iso-8859-1?Q?wunJ66iAl3oy/re6jk26kDbAQcBmb0Pt+2aoLQEqlwWJM1Zrj2ueqml6aA?=
 =?iso-8859-1?Q?ktSsDAr3UUqAugtmpanSQylNqHKN2+y/F52ugLhcsSDhtccstDkcKuOTWy?=
 =?iso-8859-1?Q?FiJwuWRn3pGzekIW3vu/jRX2LbxDc3UxaCn0Ncg9mx9nnbn36+FVd8dCW9?=
 =?iso-8859-1?Q?FTcanQug9boZj0kzPiu4lV5UQXLPazabiDqwmeCYjE15Lh8egddeC/wB5W?=
 =?iso-8859-1?Q?rYfcRiOwacJjBNFDb/9DP4KCY/e2AhjQ+ZaIPdkXPd3azGt5W0oKrBkQ5g?=
 =?iso-8859-1?Q?zGzHzDdGmi/5fMefYOaqg9FIerz/yif4dwMmAwxWJ5nhoPek4Isj0ajpH+?=
 =?iso-8859-1?Q?BZFGJUYiWpeU8k9EJ4BOnt2ZbwmhHeA+kDH3HK94lincDWtuQWXpirlTJw?=
 =?iso-8859-1?Q?GN6BEZac5dBTxgo2yP87szkorlKCg7zAOELMY4ZmN0qFKNciTqKQpaUPQj?=
 =?iso-8859-1?Q?DK50K/yEl+P4uTj84Vg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <751806F60873D642AED7905FA73021A8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3ybK4OYVv9j0zVt4xzIx8yOG9SqLeSb22vJLvlvvtIS9chItf49+NoWCfJdZeXQMK8v+2Ffqa9kk9zmoj5zhwvdMizMrGQLULXoepF7R/Ew6jZec3stTBgdwPNTdd1yjNI9Srzj8vsFlDRzd8jJACFLYeqfFZcEs0Jj6Tj6oVr+hj03xVekG86BmJ4l/TgwyDlG406MGedDXFDjBXWyTj3bmdTZ8l93eoF+YQ5QguzzRI97YAOmypVGuL5S2WwV5mLoTkuUgLJNQUchmcI8E6LtaN2dxH5V9KL/kC+1RuJbZgOZ1+xsczuyAwYz7JtM4OyF6gdHFIM6VUkIrag/oDfsj6h5mb5g3mSkIaE02FXwM8C1jEo5nELKcO7jsYj6U7vw8B14Ghe2zXrmNhDgM5YVEr6XoNXmpyr1rnvJUpwUMFvvyEd9JsdsQKYi7w0Zk9MnLqF5K4VxdwJgm0363Q64YLXExJSj5gyqWXDrzpBItdThowYqilZOG/kTTkviq0x6uQOtbuu+yJowHrLMaxrF+2V3FFehjXGF8eNLD+1v4BapvgpefodgLx5CTBoMp6NaDTT3wSiZU19llqW7KVcG2CX5wRxR4Hl6/Vn6izJaWqLICd0evys0y7CFzzca4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d6c41a-b833-47cd-d232-08dc377a8207
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 09:57:28.6504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WzTxUB300x/GnWYCzP8DMQcbxVkJECWuf2GiM2AkNbJ0REIre/v0Jl1F4Mn2KKzys0mooc7w6Hwlusr0SeEM0JSERV2YPNFClFM7zGoTZ4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7167

On Feb 27, 2024 / 15:22, Bagas Sanjaya wrote:
> Hi,
>=20
> On Bugzilla, danilrybakov249@gmail.com reported stable-specific, ACPI err=
or
> regression that led into high CPU temperature [1]. He wrote:

Thanks for the report, and sorry for the trouble.

>=20
> > Overview:
> >=20
> > After updating from lts v6.6.14-2 to lts v6.6.17-1 noticed high CPU tem=
perature and lag. After running htop noticed that journald was using 30-60%=
 of CPU. Afterwards, tried switching to stable, or lts v6.6.18-1, but encou=
ntered the same issue.
> >=20
> > Running journalctl -f gives these lines over and over again:
> >=20
> > Feb 19 21:09:12 danirybe kernel: ACPI Error: Could not disable RealTime=
Clock events (20230628/evxfevnt-243)
> > Feb 19 21:09:12 danirybe kernel: ACPI Error: No handler or method for G=
PE 08, disabling event (20230628/evgpe-839)
> > Feb 19 21:09:12 danirybe kernel: ACPI Error: No handler or method for G=
PE 0A, disabling event (20230628/evgpe-839)
> > Feb 19 21:09:12 danirybe kernel: ACPI Error: No handler or method for G=
PE 0B, disabling event (20230628/evgpe-839)
> > Feb 19 21:09:12 danirybe kernel: ACPI Error: No installed handler for f=
ixed event - PM_Timer (0), disabling (20230628/evevent-255)
> > Feb 19 21:09:12 danirybe kernel: ACPI Error: No installed handler for f=
ixed event - PowerButton (2), disabling (20230628/evevent-255)
> > Feb 19 21:09:12 danirybe kernel: ACPI Error: No installed handler for f=
ixed event - SleepButton (3), disabling (20230628/evevent-255)
> >=20
> > My system info:
> >=20
> > Laptop model: ASUS VivoBook D540NV-GQ065T
> > OS: Arch Linux x86_64
> > Kernel: 6.6.14-2-lts
> > WM: sway
> > CPU: Intel Pentium N420 (4) @ 2.500GHz

I think this CPU is in Goldmont microarchitecture group. The group is handl=
ed
in a bit unique way in drivers/platform/x86/p2sb.c. I guess the commit affe=
cted
handling of P2SB resource on machines with that architecture.

> > GPU1: Intel Apollo Lake [HD Graphics 505]
> > GPU2: NVIDIA GeForce 920MX
> >=20
> > I've pinned down the commit after which the problem occurs:
> >=20
> > 847e1eb30e269a094da046c08273abe3f3361cf2 is the first bad commit
> > commit 847e1eb30e269a094da046c08273abe3f3361cf2
> > Author: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Date:   Mon Jan 8 15:20:58 2024 +0900
> >=20
> >     platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe
> >    =20
> >     commit 5913320eb0b3ec88158cfcb0fa5e996bf4ef681b upstream.
> >=20
> > <snipped>...
>=20
> See Bugzilla for the full thread.
>=20
> Thanks.
>=20
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218531

I do not have access to the hardware. As I commented on the bugzilla link a=
bove,
I would like ask help for debug.

