Return-Path: <linux-kernel+bounces-110981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A873B8866A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE6C1C2231A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6D3C2C6;
	Fri, 22 Mar 2024 06:16:31 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2134.outbound.protection.partner.outlook.cn [139.219.17.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342C91A38FD;
	Fri, 22 Mar 2024 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711088191; cv=fail; b=YH2Dx98Dl8dVP69nV/urvHNcJBPZOaNGW2G23AI9G21nKVm+woDwqCm9tOM6ipZRc1eb63SRZ+5Vm4zDZ0DNtmXFquWb6q1K9xvsu2/FJAJfSEZSeQM0ZFa1L8667rtrCWKGGNBjgwesjH0nsTUjvss/NguBP4e00kA8YMy+6yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711088191; c=relaxed/simple;
	bh=vvnnpZ3T7YWC/9/HgkXHvBh2skTnzDORRxgvrmLm97g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OA1a4Buh17vH/W1hFlqx+GWYnnhLSf9Id9GtRsLadmARFHSlo6Kh2KP8NhXh7n7eTv7qEjKjuIv/5WN0IRG2QjOSgOepUIiGUc9KvsKT2C6M+q9PU4VwLE+Z/Qcheq6Y2W2nkKZ8a+RPxALjO48n4XkIR4bx/zPgNIYEX5w4K0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcBJvyQYSwKdW2NVJKZZKLIfsAo2tzz6MWW+Yy34Zqqn6ep76+/ny6efvCHAGZ78b0Dt/+D3YRgslYnHFgxDyJOarM65Zqfp3HUu8Q3rUWvOENlSDPS8nOhwOVjd3IK5Nr8cX7J76zhtdjtmafVziene9bUXNZSe/t3V4ydvBywBpofW2fEcptntiKRrh1h7Y64T3JRiAoFDng26u+KMual02piH9i2Vt4jzHJ+XioKEvB/DdgKdXW3dqXfDGeIXzZDT5Vt+zmchV01o4brTnPwLG1WSHKE8cckgpvH2jy02K6ne/PuGQsdw/PIrwNMC8hvclQntFLOgYyawQYxj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvnnpZ3T7YWC/9/HgkXHvBh2skTnzDORRxgvrmLm97g=;
 b=igK2d+nC7ocLK+mA93jrPh0YF9F8HkFoMIwvQxYI7wxFOvhq5b9+QC7wOwrjdzZw/+NAvZXk6UQqO+a1JiR6kURRSedUkLcUfscdsM/AUl8ufw+81WlPsBg6Fj29qJ6Nzh+aBFuIG/EGSNm7Tfcqty9X5duZeW1KVd3Za3HzvuI+dIMNgbLJJFeOEfn4MG6IW2SwBQqx81JzyWkIhiVTkOqBVWKEKbmNbV29WDk12mWWoGg2PUYZk1CObnalNGljcw1PZYlDJAtjSqJ9Jw1afRdbpuMi4F2us1F+ChLNqHo2a/TZ0g/NvTG8QHtOf8v7RB/W4w1LaHqu3s5Wla33rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0762.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:23::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 22 Mar
 2024 06:16:21 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7386.031; Fri, 22 Mar 2024
 06:16:21 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>
CC: "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "geert+renesas@glider.be" <geert+renesas@glider.be>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "alexghiti@rivosinc.com"
	<alexghiti@rivosinc.com>, "evan@rivosinc.com" <evan@rivosinc.com>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "heiko@sntech.de"
	<heiko@sntech.de>, "guoren@kernel.org" <guoren@kernel.org>, "uwu@icenowy.me"
	<uwu@icenowy.me>, "jszhang@kernel.org" <jszhang@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>, JeeHeng Sia <jeeheng.sia@starfivetech.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 0/4] Add StarFive's StarLink-500 Cache Controller
Thread-Topic: [PATCH 0/4] Add StarFive's StarLink-500 Cache Controller
Thread-Index: AQHaddaSJEIIPVgxR0SxXGC7jf4tALE8DDGAgARDxYCAAwMvIA==
Date: Fri, 22 Mar 2024 06:16:21 +0000
Message-ID:
 <SH0PR01MB0841F41082D1B638C6CDCCD1F931A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240314061205.26143-1-joshua.yeong@starfivetech.com>
 <20240317-viral-handcraft-12b2519ff1be@spud>
 <20240320-implement-finishing-136eae51d659@wendy>
In-Reply-To: <20240320-implement-finishing-136eae51d659@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0762:EE_
x-ms-office365-filtering-correlation-id: 5e7f5b3a-a17d-4c15-f0b8-08dc4a379813
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WMjjakDTnCB83n7cwwZfcYohkMudiK83WBXgfSMNNkJsDolKRRaRqtY/WOmQnHjA7lH/974e4MgtWTBUtnW8rDFAwsoI4xiQWMj4lXmCeensaMbr37VUCWDEzqVnfpMhTUZdmHh4iEGjpl7UNfwb2JfPkS6nrEo+ud442ksjNz5/zK6z/Xkksx/18fwsNJLbVpIsYQAu5ysZMoOEjcKMERMPpdK1+yw2OQvUOJTsMX7B+r7urfHtkDljVHM058pM81hDCRu0c96JyQexyyG/bbWFM2ixvp3+MspcxLM/9Zz4i6u9yhNygFYEA2ECH0tgVH4BgZHWTIJOQeDuuckUH103zhSjFEvfF0R6xTw1wLEZkHBpIGhl8EhK1kYwBloGQ9tvxPKpoxA7aZuS6L9kuJzTIGKUNaInf8RAUQcpQh/O0ATJ5j4k5JcB0k8/PC4sB1/m8qWYuFhrsbc2WQi31vaDLBTjnPe5y4iIBJgkl4IcLExHfljvr2Tw1GeJIWW8UtkB7bDWIEfINftbH3W8Q+PH8euqC80wRrOoCi5agFD6OcmnBlh0VnLOyhxgH8eJuTC40CL/EnY9pSWDyekWLZ8Dw6e+c/TmFJ4NQYjqpIVVgqitRg9m1xlbeXX8gKyU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/59rrD5xFJmH8GVBXl8lgrxd8UDf91Uw/VaT103Q/O0ktduLlWG4mEFN2QKW?=
 =?us-ascii?Q?pKqsdWDlJCoOB+VGG9e0rJK+EKOGb5+Nf28IhBD+8Wl9iiuDRaYHnYtTUWxa?=
 =?us-ascii?Q?PBFNLA5Y+0oJ/spL4TLukMOycOlKxac0+TPYWqXt6Bemnr8utmag5fOsxWdZ?=
 =?us-ascii?Q?mEwJ9eEMQ7++gFZAMQ4x5umbFWfw+wLRdZy9eZzyIa3eTqU8K6wBe8dXdkiy?=
 =?us-ascii?Q?jW725LyLMnR9G6vt5aIZvVWm49OeG32Scp54hY2ftrcJ4bJRSYApjWWdnZ8d?=
 =?us-ascii?Q?gaR4vuhMpoZYUrq89zUWX9JWOk61/FmZq45PjjPr1mGzvFFy0vNXS6vg9mZe?=
 =?us-ascii?Q?aDtVJOqfY2ZenYIKFBeVgg1OlK1VV607RISyK6Oen5WoJeJWwOBu8fK7moT3?=
 =?us-ascii?Q?1Y6jVf1ZvN5VD+U3M72wb4AN4ROfz6v0gO5HmetNg9XuS6i+5lGiBpL/HKmj?=
 =?us-ascii?Q?Yk5Q24Rn4uNt//cCgZMaeRMFU1Qubvn1tJqFstmnwI05IxQUzENHAw8IGXlx?=
 =?us-ascii?Q?De9Y18StpxOD6fVRrfnjuGiuCLCB6rIIw9JfsbIMv4hUrC5ySpKr3rGhE6hr?=
 =?us-ascii?Q?7yktny3EUvMn64CBiQk9TimfEnSsTKjGh4kGl9Euod0arZhoNJ48NfTBviWg?=
 =?us-ascii?Q?FRCS3yuAz+1PDRrz0W5I11wmLG3A01YologAi6JpbP+EOalkUh4mydC6D5IU?=
 =?us-ascii?Q?03T+iYWZhlh3cLYcFMKOB84WM4HiSR+l51SkbpowsOQSTzUys0WdBmYJI3W5?=
 =?us-ascii?Q?Q6xwDSh1hFFlMrburuj3SpdUEJ9bCcaosELO5YZBmMQjyWHoFhczX/2P5LQl?=
 =?us-ascii?Q?jrjpH1555WyfsdsyyLdhas6XlA3zHnY0CZCUvF7ltJm31FtRKIyHiOhlBdqF?=
 =?us-ascii?Q?/1jfwU/b1reqviETWghuSpLKCE8RTcqEt9/Jh/kPuwBYu8yF8lKC7MAxum39?=
 =?us-ascii?Q?Z134HYpRUqdRfi3W1wycesflO9Rk80pEY7hw1O4DsWCApBL+ZeXYwpyQh749?=
 =?us-ascii?Q?M/BK2PU6boxfz/RQ7qMoY/RP28CLGYOdKBgjmjjLb0UyGQq+Fcl5LmWt9byy?=
 =?us-ascii?Q?4pBMTkfbcVbJWmIKSkuL3G67rQARKEgJ6rmVwEj9Su7C0Xl6OemIc26e7NeD?=
 =?us-ascii?Q?V2lLfhVe4kF/FRKKqL1RTsP2AGNgLFCSt33WDQq/bq5MVpth2knigMHoYige?=
 =?us-ascii?Q?yBzJwvbMl1o2HZkT5+TGSnGNNF7Na01l+m2EtWQEQ0PZ4AEk+x6MO5012yQZ?=
 =?us-ascii?Q?l9wfyIbm13CJp5dpyYFjWYFaIJLbNmmpZBvsAHe4ugNfYlboo8Kcg2I1ZKeS?=
 =?us-ascii?Q?ClU1liGZY1bG9S7ZpcwmEKtBDofc2Q13TMbQAg2Fe5cUYzJjj8OCFUPRtAxG?=
 =?us-ascii?Q?ixJrL5LiZMVDICHv1wNVJ7XU99zQu//J1T6nrmDg9kvJ9lV806pWy+QYw4VB?=
 =?us-ascii?Q?bW778BairnQrORTiURK+Vjnf1aZoVKwc3dyLc1R3ZIM/APRrcveG49cGMEON?=
 =?us-ascii?Q?5+T+ApYgznzLEDJDc6HUMb7TVVLxUuPBnrC8wh7cyph1AzuNallugFxN+1oH?=
 =?us-ascii?Q?D3P8mqIr4WG7HuYvPgqf1opLVxk657fANf6jrzKHQM7BRN2PC0CquM1LphXU?=
 =?us-ascii?Q?5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7f5b3a-a17d-4c15-f0b8-08dc4a379813
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 06:16:21.4757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Tpe3vOz/Zo/HGPG7v/FTYslGaGBPl6u+jzvk3vB7LBf4a4/DOnT8+2tglx4BHxp21MwmmF99zC2u+m/RSFImT9gMZxetxbC6Iw6BCGAG8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0762

Hi Conor,

> -----Original Message-----
> From: Conor Dooley <conor.dooley@microchip.com>
> Sent: Wednesday, March 20, 2024 4:09 PM
> To: Conor Dooley <conor@kernel.org>
> Cc: Joshua Yeong <joshua.yeong@starfivetech.com>;
> paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu;
> geert+renesas@glider.be; prabhakar.mahadev-lad.rj@bp.renesas.com;
> alexghiti@rivosinc.com; evan@rivosinc.com; ajones@ventanamicro.com;
> heiko@sntech.de; guoren@kernel.org; uwu@icenowy.me;
> jszhang@kernel.org; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org=
;
> conor+dt@kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; JeeHeng
> Sia <jeeheng.sia@starfivetech.com>; linux-riscv@lists.infradead.org; linu=
x-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH 0/4] Add StarFive's StarLink-500 Cache Controller
>=20
> On Sun, Mar 17, 2024 at 03:01:05PM +0000, Conor Dooley wrote:
> > On Thu, Mar 14, 2024 at 02:12:01PM +0800, Joshua Yeong wrote:
> > > StarFive's StarLink-500 Cache Controller flush/invalidates cache
> > > using non- conventional CMO method. This driver provides the cache
> > > handling on StarFive RISC-V SoC.
> >
> > Unlike the other "non-conventional" CMO methods, the jh8100 does not
> > pre-date the Zicbom extension. Why has that not been implemented?
>=20
> Stefan pointed out on IRC yesterday that one of the main selling points i=
s the
> ease of operating on large ranges.
>=20
> > How many peripherals on the jh8100 rely on non-coherent DMA?

JH8100 integrates in-house matured/stable CPU but it is a bit dated today.
However, our newer generation of CPU should already support this extension.

Most of the peripherals are coherent except mainly multimedia peripheral.

Regards,
Joshua

> >
> > Cheers,
> > Conor.
>=20


