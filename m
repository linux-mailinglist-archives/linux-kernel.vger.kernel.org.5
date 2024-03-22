Return-Path: <linux-kernel+bounces-111221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2305D886951
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC81228AD6C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1267620B3D;
	Fri, 22 Mar 2024 09:33:30 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2135.outbound.protection.partner.outlook.cn [139.219.146.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93B199AD;
	Fri, 22 Mar 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100009; cv=fail; b=MVE7XjpyHpoa5ZIrmecBfOZHppo4pONcmRIdltWGN+QkFtThPiKMqQOKCOhJKvmeq9eev5AwqC09mPsOLv+eVmk1fifstvWX2kEb5KuI6TYLvhYT0xgXw8oJqgRDD1LQ0Zx/7JZNkRE7gItk0iSxCyVtWMIBd0d3Z7cdWs3Jgio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100009; c=relaxed/simple;
	bh=gxhut695F8esbhX9LHz6cc1aFEmLRIlROucXU+v3gHU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KlsYD8kaPzzRK9xiqJxz6M6Jeo73aVoJoBSuOa87oSUb6iXMBl/r94nUJXp0F8m3kxQ88cVqWtrtD79SclBVBiQNcb3x9FB+JFvJUo1O4fW3fH/2A0SVarBEMDKOxSPqatRKVpGrQmd6NAlPxb+pueMDp6zO/r1baiwepiwdYTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAPzSXCRl/ru6/XMtGs2ElENDrREVdd8x/i91rBkPR7ikyPdRbXTA+oAiysZ44r7r3U09+hs7RCc5ym1HUNtd5xM5UCnYm4hykrXu6o/j9i7z2NoSltWPiU9Y4qLbrJM8sghcZCXp175aY/Mwc2VpINzv4uykgnMGMCT2BIIhxgXp6zRkpF5+3U1Pz48D6NDXhXiu+HpJQHogOzFaoipG5G6kF32puEDmM8SU/w0dbMDv1+Z66NoeKbj94Ocqnb7S6Oq9a0GW5o39ZPK2TK6N7C8gO2PkLWe4dT7BzNkDQechSn3isgzLk8jTBy5IDYO7yr2Pn7qZL06e+FiZnCPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxhut695F8esbhX9LHz6cc1aFEmLRIlROucXU+v3gHU=;
 b=KSUh5PNGRYyE2W1Uf4Cl+J5LSdfkjGpPaDzraTOzteD+JNR+NEG2YMRZ6rISiTZ7e6yR5PfvLZ6BNRpA3utuaw8Wli9ld6VlNb4133P8eNoHEizvg6cA2LHAw7OssZnibrMIeIl6i7gSInM268KP/GTmK/BAHnPXST1jNWY8Fmcsd+jsYchwWAtsoxBaMflGrGluXMKvKPoQP15jwwcDybcqAuU2qYjfbQtZwNuZ6VCIyHgQbD1t6THuZuhUPmMt6RGuXDe5xt7eqCvCXsJ1rCPG8lkYQh6+Yi+AGD5xxILyo3Wh0wOoxPtVjD4hkTJcGMMQ2p48e7b/rDLTxj8oXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1241.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Fri, 22 Mar
 2024 09:33:16 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45%5]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 09:33:16 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: JeeHeng Sia <jeeheng.sia@starfivetech.com>, "kernel@esmil.dk"
	<kernel@esmil.dk>, "conor@kernel.org" <conor@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>
Subject: RE: [RFC v3 02/16] reset: starfive: Convert the word "jh71x0" to
 "starfive"
Thread-Topic: [RFC v3 02/16] reset: starfive: Convert the word "jh71x0" to
 "starfive"
Thread-Index: AQHaQ8ld9K0U0x50EUeXbB8eniMmabFD7KaQ
Date: Fri, 22 Mar 2024 09:33:16 +0000
Message-ID:
 <ZQ2PR01MB130701FF146FB6922B7ACD59E631A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
 <20240110133128.286657-3-jeeheng.sia@starfivetech.com>
In-Reply-To: <20240110133128.286657-3-jeeheng.sia@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1241:EE_
x-ms-office365-filtering-correlation-id: 28513295-9dad-486a-91eb-08dc4a531a81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BK0M4PKffo+QnsFQat27fXgxl+RpcRGzZgtREzfkm/ugJ8I1PQZLX+/bHFtKnKRfrhRcztuv7y5tGeqpn5bR8aXNaXjwlU9A/AqO+ZvWWcBtbjRRNRn4eHiXdz4x4rwdd9d+77qfne3QexXbsS4maKtn9P7BJS4qP3/7Z17tWrU/35PlyWVfHhV3ZVz64sn9P8/9Ff6uJdaRc8whYT6FrJz8O6a8V9SkMNbSCJjeqOdttxLDv1Ozcb+S5xyoGttDVtKtBjojbirlnOy5GyRLTPfZgbIbdu0DesuyabqALl/hMaToH571RGY/KmVzHcJ+aS8HYH5LuiBUNXiRorq4wb4uuk1Wrl1HYQyzQ9ZHSh0i6rdahGFGreKObWOpNEc9fryQtCQ7EZv2CA06OMv5mmDNJkFqvaFvoq5pMHvX4UgXawJk3+6j3S/vqmTCnQBWJzW+G747TNm6YNhYxrTiHHc87Xpq2TuA57N/eTmND/bTsKc7zhePiVKxPiTOrqUhJvY58oVV1EkPCeS0zqyAvqDNMuGE1QlGdTH+kaEfCi7XgNJ6o2rRF8JP620htYaPXsBogy0oNbhhl+XpXrHhTWCQg8SHUZ6TL6rIzTLhLRp0zjgEN7TK5o2jVZkc3BOE1EvUZmMXn3SQ3FRKn0v0qw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8T2UsewSpQ9iaxi+thpzWq/bbkUwrrf+9NCek+opxqX6S2RDxsXr0M8Xh84A?=
 =?us-ascii?Q?/AlcLTmE8WOfCVx02ZbLk7in918kAHuVirfgq9AkYUSVE5Jux8z4Q0xT6vOz?=
 =?us-ascii?Q?wHrf+dR7yJcLNtsFBZJD6n02H/Xbc2iFP/fL5Avzt50kQpPzJLEZh9e/9zGX?=
 =?us-ascii?Q?xaGS/eAD9WRP8lmnzU/zijfcgVqTfMa7FjxvSCt7Du0Obt944njjeUUpRaCu?=
 =?us-ascii?Q?B6lybIAPT2XKgSK9EDBNvV3rZ7Amz6lQpa2SopWHHzRSDywxBOi8PMOnU/I9?=
 =?us-ascii?Q?47YCskZ2yPkDyQL659/9+bC44iiQ1yVgAtvD4O3QHere9uNbucbRWgMaOPIB?=
 =?us-ascii?Q?hHm40rt7eUsmPjXdI5XEF+1LoD524v9VXvCh28aSRXE3L8ZQdZqJkq/rFCGL?=
 =?us-ascii?Q?akfSzyYey+XMERKhlr9N8WLQuREp+jutXt8TsusuafFas038S4+Vt2ZANOpV?=
 =?us-ascii?Q?eMbxUAM2myEPtWRFF0mM6qgd8+yPcA8azdiGrP46PCJBmyaInd9gPSz2JGEl?=
 =?us-ascii?Q?AzmJtGqzawJMbLq+0/WJi1vR/5NkFvKNIMo0adVZ6r+8sQcKDu1rWodZikDN?=
 =?us-ascii?Q?0pOENNBY/j9PDsyICN5pf9AGMGdNOVnNOYOhyo5RH5JdlvJcjL5kfaaSeJgK?=
 =?us-ascii?Q?q4+jcQ701Qgjx5cYXp/muIkhjmawqGCJJk4Rn583y4wZFPH/sIxNuj29Dq2e?=
 =?us-ascii?Q?mBOXJl1wyYNfgkunr3IrTUmk2AKQmZ7Cby0p8JnVSggKW8PgVW1SULdgYMUl?=
 =?us-ascii?Q?mS4qMRrh+pIMge/xJb4qOLP4UjTCovYNXdKeneFoEAV5IviJPYp00mNQaMfV?=
 =?us-ascii?Q?YY1TKERls4Hz6vQJ7epH9RXaCYJaHyWiRTcNdsS/aBpZlieVpCTUwbeWIS6S?=
 =?us-ascii?Q?eNtEQXnXVZIdzQRszioN2zWKRJIIkmUJgnznZXiZcvbj2kQ+Ph/SEMJA4tXN?=
 =?us-ascii?Q?ylUoCJfRksKQYu5Vq1qkMoFHxmZuUpw4qw5HWhCNaxJnE/WspGSC1GlM+yqx?=
 =?us-ascii?Q?26Mp1+xRZomtFoph2tQc4JiyqCVwQ4gSEgugTkm+Tn7s04fagjJeVrJ9POOl?=
 =?us-ascii?Q?NFC1xioum5fR7wjrUJ3bB2t+eg4+PUxJR3z//jpp8mC6oT8nSRPj31jkQ/ZK?=
 =?us-ascii?Q?6/Ytk8/5yXy4iYEqrjLKjw6F+GN8xYCUj4JIyIdXKgesw8faqA/GGPADqYSB?=
 =?us-ascii?Q?sTiWJWEgqSOMTVQWm1jwK6Z5sUMMJNg5NbLFsI0vCEMlp6/12jgneQI8w7sY?=
 =?us-ascii?Q?FE9URzct/zhx4G/KkAaL5aMN/Nee+YjulGSfueU+J7m3ozJ4QO4oDDohiRRc?=
 =?us-ascii?Q?9Pr9A6Qq1NWl73HpuORkytBm19RozC4icbKrZcKtWTK17nRit+NGxwighskd?=
 =?us-ascii?Q?l4otQuUEVE6q9guO+d5SsZ0bRLRStdZ43aVzU0TvHaH1d/KgdEU889fqWSS8?=
 =?us-ascii?Q?o+P2G/TrPESdZyvSOuIGJdWuxKIg8dZdHFoIJnitCmwwtvPkVNlWa097nzWh?=
 =?us-ascii?Q?ce37ETuykI/aeGECAWFRVvXbCcVYw7uGWBdrntGt9WYmP55dhrvrbaLewsdv?=
 =?us-ascii?Q?Yb9EDqHfIq+2TLaiaLBRXBfzqFb6eE/XM6lVwH/s?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 28513295-9dad-486a-91eb-08dc4a531a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:33:16.6952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1sq2bAkZdvN8c0re2gYBrSDSyULUfPtKIdNoBjnUcLGUyHkQ3BHDijGTN6b7y2w9iQmaVOsoMGs9QvM6CTO7pqNes6rSw17bg3W2mt1Uh6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1241

> On 10.01.24 21:31, JeeHeng Sia wrote:
>=20
> Function names that consist of the 'jh71x0' naming convention are renamed=
 to
> use the 'starfive' wording.
>=20
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>


