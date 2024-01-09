Return-Path: <linux-kernel+bounces-20387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B1827DFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AEAE2858B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D921371;
	Tue,  9 Jan 2024 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XPME6Utr"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7B139B;
	Tue,  9 Jan 2024 04:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtUkWlnKoU583X3jxXO85MUPh+xcPpKGCsjSlToTbZHXenJKmH4uAIdmDaryZs6giE6YTaZUFaA4PKSm7DniHhQC17uJGj0SQ21uvcKTK8rTzw6Tdkne0VLDi6zxzjYZQaN34c10xH38K3Lm00Z2wRIolrE3rhPHrX5UIxhNhEC8WF62FdlXcoOS/fQ0CGxdxV9yrNWGi5+goNgtj2dkFP5/Fbt7dyWzXKT5ZaARdxbTDrfbXcDWJWdLwr7Cny9JlOAvGvSTovBtW3MhCJVBgtfaK9ZPTZhNVLvzYdTz5qi78GQF4kfS/HD7JZKYHQ8GT2XBTniaHwePOJrUP70DNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD+TTd+blqVKAJJufgHnwRB2x+Pw+HUuxwvrNwMGFqE=;
 b=A4W94fJ6uGOWDxv77IEPoYkBSkXPrShaEFYXM37dthI8I6YafIddIX80dArR1Q09++cZk8FAEnZI410zOGpFTD2sHInxXw9j0NuavJsBMTFKWTC26C2svCERuKtG9VCwc54YmwjP6C2pxYEhREK/Dw4bNeFgDckMKMrOUAMTo2onhcMfDQzoyuSDV5cQJGW7+hVQrjy0aMlpiFZu2ybtqLxUfi50ff2AOZe+axtINHu8GX2ueShlX8LictrgimA35p4ttVo9ABOMet8+0W4lk1QgoKmcf+PAcZ0lQc8cmRS9+9SSG1H7wXo8IiR6pl73R4+bROEVoUfbdQbgy5ukjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD+TTd+blqVKAJJufgHnwRB2x+Pw+HUuxwvrNwMGFqE=;
 b=XPME6UtrKRY7TWseLeh+esxt7tIo0JvdS8qfAQbm6HC5uEdinPBVkLM7Q8I2ywjapp2fK4kWgfR32pjBpqve9DV35wjLlJs2EwS5dqCF4LfkVwQC6n7SFhpd4VgSu266e2bcqbXCH+DdUAnhVzfkwIJsJ1adJHFD0NPNJwvBCa4=
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by DB8PR04MB6906.eurprd04.prod.outlook.com (2603:10a6:10:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 04:54:09 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 04:54:08 +0000
From: Frank Li <frank.li@nxp.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Boris Brezillon
	<boris.brezillon@collabora.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>
Subject: RE: [EXT] linux-next: build warning after merge of the i3c tree
Thread-Topic: [EXT] linux-next: build warning after merge of the i3c tree
Thread-Index: AQHaQrYJgo5t43x8sE2K+QT9ZIyRTbDQ6hXg
Date: Tue, 9 Jan 2024 04:54:08 +0000
Message-ID:
 <AS8PR04MB7511B9EE936DDD99FF9AD559886A2@AS8PR04MB7511.eurprd04.prod.outlook.com>
References: <20240109154046.71ad80d2@canb.auug.org.au>
In-Reply-To: <20240109154046.71ad80d2@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB7511:EE_|DB8PR04MB6906:EE_
x-ms-office365-filtering-correlation-id: 8326f944-ab59-4caf-50d4-08dc10cf03a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vnO3tVs7UtObJCzbjDfndi6yKb9in4qFfK+9ZiIO8W3v/lbM6qeqL9mVM9GMKpwMKm+5ELvdk0OYXMAk/YQgKLev91abRH4nK1KIC91V2m009GxRHRgVTOcj8ecAJVBOG0P9tQBLlc6it0zzvH5j3KfeMbZ/D68D19csxWwrjMI5cRgbeNktuyetpsOxpF2QHipi5XUzHxbPp5xfn5TM93eoo9WUMR1o+VQIjaacYNTP0xC8qU6cXgbyKLlLfVKM4lN0/GAW/QDbdthaGlP7nbYXXnK/MPi9IyFOKeVRH8y31PESeS5BXSD4TqGMGFOtqjmwnSQVNVSGuODHHDmA5dmLzg8jRycQQHp/J9SvTCC9+65CKeXtE7MZnDbvl8VaghVl94eN+i7Kbl1miX+I5BmsoKjJSpT3wkPBY57Gxm9008ihEx3WmKSfPLovx/elUvmoqPNjx5AEdyMCH5pV6WR/f/Bc197HOoI4JQAHdmUeQQeJwxG8Kq1RRGqO53mdti9sgKTGwh4pURetbgyKe/i/mTIZjwU06Bc1QxDL0xeMfPO9WEqsUKUH5pZvLobITq7qrVjwbSa7EGeBlgUcC2YkVYMaaDG8UFebA/vGqVGU396w6c78uudMil+1xjHrT64dWlwN85RTtQc3ztqzXZ9Mu7ea0UEF0h+Y2yKqF1FwlgK57JuF3Ubl3a34GsSL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(136003)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(52536014)(44832011)(4326008)(2906002)(5660300002)(86362001)(478600001)(33656002)(6506007)(7696005)(38070700009)(71200400001)(83380400001)(26005)(9686003)(122000001)(38100700002)(53546011)(41300700001)(316002)(54906003)(110136005)(66946007)(66446008)(66476007)(66556008)(64756008)(8936002)(8676002)(76116006)(55016003)(42413004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3Q+cbTthAbeqnghO8Go1z7grEQW4XkIGupR39yIQZSTjUkqSnSgAAHkIORqL?=
 =?us-ascii?Q?gSqSbdlPadlWAAW5DytdDErjUSxWh0CA7M3jka6AD/jEy/T3znT0r+XXq8wv?=
 =?us-ascii?Q?ON2cgq7YoS/bvpIi7zYyTEe6rCb7Sj0dvgWuAv6IjgEVR74d3ysSMK6GPv1F?=
 =?us-ascii?Q?ByAa6HSPTtajg7mHAsAJtkyGjoidXuxY+K2V9AadUngx8yxQQneIUnwh86L/?=
 =?us-ascii?Q?7e6oR3jU3fJS0AJVZsI90UruOicOEr8ekDZs42nrzpmTYPUXYLtPYcoft9jg?=
 =?us-ascii?Q?L3bUAkoqVIz6uF+r1GpIB2Qb7uw2dzUAPkGcCkYUseokG6vj2PdkqpV5AiUF?=
 =?us-ascii?Q?ijq0gM1KtFrFO/Gag12fjiDTk6l1frEjNKusxF5sU2NplEEGFps34JmVAeL2?=
 =?us-ascii?Q?m/x4r55ML4i3ads105a1Q1Fz47obTdp/8dS5/tzIoxC32HwaASYHTFq7g7J5?=
 =?us-ascii?Q?spXZdFqiNcW7h+z14jr5pX3x/DwOdcymmZJFt0fpZ73pkL42wAushrDuMUW1?=
 =?us-ascii?Q?uKGOZq7HLn4esmwp9DBlGDJg8rADNrEHUFd8kIH2O+C2jJFHL1UPcButWM7b?=
 =?us-ascii?Q?ylOSnrIvHB7/xKXXww4naQfs3AWOhit50eb04n/lQ7Jybiwoqv9KElGuzKyZ?=
 =?us-ascii?Q?bLN8EJapctTP2hDF4ihv5yQsvS4bsqJFEn5QvLaYPQI8dvOPtRWWfP2kZvTq?=
 =?us-ascii?Q?mVy4TqIRCEnmlDyBj1fPSFwEumDKUrm5JohiMoJYuLCaA/fjq1QkXEvHFkl+?=
 =?us-ascii?Q?4+4lPPbxAi5LGBAgYAaGq9A735gW3DrwZCHMWqFhdIBBIhaqqcKXOIhxBsQ7?=
 =?us-ascii?Q?6ucUEiyVGNTql2n5R+Cx/baUZY3Vautin8PdohI7jr7HT0s0mu0KStsWjJhF?=
 =?us-ascii?Q?DNzXDwMCbSh0fSJO4a13O8OsQGf5S7orYw2hrSaa5RWWVX4UB5rBNDmnC0Lk?=
 =?us-ascii?Q?5eO64z2Avt87jXJSeFFPID4kq+HHvhAjmVAZr4WdZUBT9hXgS+/Avdk3YqRc?=
 =?us-ascii?Q?+E9e7x8bHJEdakxVBCV345QruCAwCBHYaZI7sh2rqveXqlpqc3D8tmupa0L9?=
 =?us-ascii?Q?NPEFmmoxA2725wzkexqJR9QLklRhRxNzxs6c91whw68w30d/VxZ9ZimSyICM?=
 =?us-ascii?Q?b2tdi+7bjVjsnmj6b2mTG0mwIGuc8KjV8AT3Sg8oQF6y9EQ3uklDImmEiPMD?=
 =?us-ascii?Q?qs4rD4Ss5N5t3OfiIzKmBwrkjxHJNaW1vVkj6s0sr3j9jqaXOQisYSKxdLMK?=
 =?us-ascii?Q?oIvXDCEQDQjEB28cZ1fYTg9JfrBMrrro4Xt83fThe9H4CcT6+C8WqWCDkayt?=
 =?us-ascii?Q?JYCRsI7XFkCGrwNdHm0gHca6MhumdeZSOGDmebtSQFI8XGQTA8PxOj3m3nsr?=
 =?us-ascii?Q?STdxZJN4QPJqvikz5pcSZbiVYzd1oSPj9v4gnbN/sbnR6cVWCZ1qh00oemrc?=
 =?us-ascii?Q?qMb784hmM166SucbbBZ3a0JX6GImODf9Tg0b7g0qpe4HIQhGkkSpQcJS+Cvf?=
 =?us-ascii?Q?yF45jLt1WSULFiszHEv4gboPAhmD5OlgwyuL0A1g/cO4EHgSJiIa2y1P24/N?=
 =?us-ascii?Q?cf4ODxezAVTqaFrwqGU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8326f944-ab59-4caf-50d4-08dc10cf03a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 04:54:08.4746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a0R19BDX68dAzFwpKDfn93eGs8SuQW8ILbRm43+cg/WviIG7m6tYHAJkTpL5TlApeuA+JeE3V0RWTD1+Jizm7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6906



> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Monday, January 8, 2024 10:41 PM
> To: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>; Frank Li
> <frank.li@nxp.com>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Linux Next Mailing List <linux-next@vger.kernel.=
org>
> Subject: [EXT] linux-next: build warning after merge of the i3c tree
>=20
> Hi all,
>=20
> After merging the i3c tree, today's linux-next build (htmldocs) produced
> this warning:
>=20
> include/linux/i3c/master.h:464: warning: Function parameter or struct
> member 'enable_hotjoin' not described in 'i3c_master_controller_ops'
> include/linux/i3c/master.h:464: warning: Function parameter or struct
> member 'disable_hotjoin' not described in 'i3c_master_controller_ops'
> include/linux/i3c/master.h:506: warning: Function parameter or struct
> member 'hotjoin' not described in 'i3c_master_controller'

Let me work a fixes patch today.

Frank

>=20
> Introduced by commit
>=20
>   317bacf960a4 ("i3c: master: add enable(disable) hot join in sys entry")
>=20
> --
> Cheers,
> Stephen Rothwell

