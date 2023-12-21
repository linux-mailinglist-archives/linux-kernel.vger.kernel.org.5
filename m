Return-Path: <linux-kernel+bounces-7742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B0B81AC7F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3691C2337D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AE41864;
	Thu, 21 Dec 2023 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oA2lBVgR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888817D9;
	Thu, 21 Dec 2023 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGUIVCXjonmci0DAQl8SzjjXIJbSuYwrXUpNpAhQaancN4vG3Nevu5s3Wi8DpuuAY9cpmLGBXxq7ZXS9gadmOAQ1iAVNoXRY7rNsVsB1ZPsxTgxYmxkmrePjRFPRy6vYHq2RF/KUjXyCqPf/jLlX0A5mpbvVbCGBLa653xwJJg/XQsATjvC2svLjzh7X18/EZyy2IG6KRpdfAucm0VWaC1+rOb9mnOss80juqqI2+zY+he7blHE8DSFNKcakeh8koZTblwTC8Pg/YsOyE1vXsm5b7gOun2j9vc5L0B9AzlcKEGAYTLOgBs/ImE4aMnnqJ7WmEPsnLXTKWgqnNpxFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbFbbl8+tomK/oqOJUI/5s15qA4dfPiFr9d9i2QgQFc=;
 b=Yf9Kfwh2OzY5BE8cig4vWA1V0gX9gMpulm5ltpFcrXi0bThjJtkySFURuhJFBuWdHXQnPOYqaGvQUIU9nAUnrCj6Ds/h9p7IulwHlEdVwsDSVKGtZrdy47Ip44YzysMiedFDr8wrqPwTNdkNh+6XiA/eWM7QEC1Hi7yEXIX5KesEt6/hM7OPp2oevFLcVCj/Zzqcsp4HEf0nIy/nKqYWz9BJeZlq46nIKUHjbbEZADSc0n9b/CKvvzmorGR3pYpk9aJyhsY0NTnIZPlCKpdXCoLv6z2GGrZWL9dJkG06D4yok9jrCoO+oSOamVBm/i0n6TEBFOCt6lEJu2pA6woSGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbFbbl8+tomK/oqOJUI/5s15qA4dfPiFr9d9i2QgQFc=;
 b=oA2lBVgRVMFzomYcf3mwRbZ/2/scPnZ70s1QwE8yu96eybenrf9ZZbdPfmFxHMsSqgvRDC4AWokbbJxPzRoXepgDytWxAtDXT+PQbPHc1JTsxPZYy6zIUdNe5gzWtFpflbVt33GMafl/r2ydzZ0+R1bezOQhFVVvYU8dkhlfEg4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7449.eurprd04.prod.outlook.com (2603:10a6:102:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 02:05:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7091.034; Thu, 21 Dec 2023
 02:05:08 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "S.J. Wang" <shengjiu.wang@nxp.com>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: pll14xx: change naming of fvco to fout
Thread-Topic: [PATCH] clk: imx: pll14xx: change naming of fvco to fout
Thread-Index: AQHaMzWy4uVAMs5zxUKHLot9Sv4Ov7Cy/azg
Date: Thu, 21 Dec 2023 02:05:08 +0000
Message-ID:
 <DU0PR04MB94174727ED9DA25B57FB5EA88895A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <1703068389-6130-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1703068389-6130-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PR3PR04MB7449:EE_
x-ms-office365-filtering-correlation-id: c93a39eb-05c2-426f-1b08-08dc01c9421c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 38VcFgIWpOiapVU7X7y3klFOhdFZgCTOPQnqQnK5/IGhxsnpBtAfhjPBQtlStilQ1fJVDWPsE47CHXBB6E5NouXr6aQX0TQub6NvEL1Zh87jA5LQZLhQItEu0vN/HSnCuJLdXc7Oy+hWrr6Ggwkj8Weg+Gwm9RyIEtVENa3SpIxgK6sS53oj+GuM2Ftrj9L4IAgD6bBIJBTv7CtW+lG5KvrVZttS4/EADvTLsUJYsSVN8/ZSnhkXo21wx4tKeFW7vS5wmSKlzD3u/Zqcb/FUnCvohjgJ1cOBlEp+q5ZRctvXLnzsCtVuns1Z9Qjc4c4/voKP3SZj87bcfrnQT01mYZhODI4VoPXCCXT6voIcbVF2so519w9UIzDa1SY5Ns3HSc+Fvv2Tv+4mqN7x14AzeJkyIbWhVF/IGzfyoY/QhNReA3t6wiDqG0XjnFt73wEK2JecZjQgzCjxjurywQv4b4fud9Ay0sFDXqKlC+XQWM5KJVSk4ei8aAB0/0xH+OJH73rNMZAtCqj+eecVwoiCqvtMHstAdDN0jy4HkKKaoeZrJ85E+flmXeqQTFHn5VLPxNXzfyJKMoqVXjiSaTx33Obx44iffDwjpi4ptFC0E/uw8OTape6ijp85I9V0gjeedGGQqgEcYb/l2kFNQAsLsw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(55016003)(26005)(9686003)(7696005)(6506007)(71200400001)(558084003)(86362001)(33656002)(921008)(38070700009)(38100700002)(5660300002)(7416002)(83380400001)(4326008)(8936002)(8676002)(41300700001)(52536014)(44832011)(122000001)(66476007)(66446008)(64756008)(54906003)(66946007)(66556008)(110136005)(76116006)(2906002)(316002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pqO6Kl3bh3GTuGmBjYKqxyLvlhsME2EdDpNiOQ/9Hbk+YlACkkvnPIjGcKC3?=
 =?us-ascii?Q?uLgf2NskbX1JYzWnpuCjPQb/GxuOUdxYVOPkT5MWdkJXyLv7j18Ti8ouWJj3?=
 =?us-ascii?Q?n1TI11VfLFXeHf3+G4+yyF6/m4FTGf1Ki7Ai/VhhSDmDf+E+OE7BDK6FR8F2?=
 =?us-ascii?Q?lAhQ+HBiZAFBmnjMQHSrMaT+yClYIvifszmBEuuYgC5tL3/VNoYkGIuopRD2?=
 =?us-ascii?Q?0GzOjRRNGopBYnGCNFgmJM1ZS2DUrChEkeWiYB3MRPov3wcaIGR+LjgKnvya?=
 =?us-ascii?Q?fvOxo9MZnZ/nl3ZyaLiBHpydxe+JJb1c3p2QjjTCTbY248iDV4A8jV5xN4le?=
 =?us-ascii?Q?FbzMKvOHxw0TtUY/zH+f+ASiYytEtobCz6RbXtrYtct2wYucbIWxkmAB3RaJ?=
 =?us-ascii?Q?GbYBBg/Eg6EW108n9ZedyAeE9CqXO5Q5io2gBFkMA5TtguvvyKUWNUu+MaMn?=
 =?us-ascii?Q?3t75TPrQ4iPuoex9yOFG4w2D3DoVqZmXUNDbYae53jYBPvEmfWiA5/II8FNY?=
 =?us-ascii?Q?gOdWrlRYhvb5GAuGeo02yXM3kSzuwkt1nlpB6OZ7yl+wuIp4WDg0K/GL2dPx?=
 =?us-ascii?Q?D+jGwOzQB6QJkc9QRdKF8ZPwiUvVH3CIa0s1hycfQzwjm0o0l2B/6KmEK3y3?=
 =?us-ascii?Q?xrNw2fJMEF+Ln6ociBFWqyKZ/5eRUiGI7dr2QvhyZSRaBPdskEacgCjbHXfH?=
 =?us-ascii?Q?fkI2ygkOoMNgnXtizKe38IqigYDpw1msdXs9FuwiHoKpdIEHbE1z89gflERs?=
 =?us-ascii?Q?GmWF3rPYhAqd3aRyEeWfuZpVGSt5vtNGaxtqSscMU8NoeakV/urzeQw+jKfY?=
 =?us-ascii?Q?3kJSY8tFCrQszlyd61Z9oVrtke3UbOqmBK0zua8DN9PhxvBFatvUJiPZNr8Y?=
 =?us-ascii?Q?Db1elye0QjpdvN1MpLcyBsONto+cWZML2Ff6yr+sAvu+kq6rEb5M/oO+472V?=
 =?us-ascii?Q?hL6A4HLi7LXI11J9Us90Vj5rlAXctYAyQT+svCMd1CEiMg4ds7bvHUvsBw6d?=
 =?us-ascii?Q?PtdfKEhi0WGQEuv34igvxAjNtR+w68nlFp7+DRyJHMB59TUQ+ZE5bmYg6MTk?=
 =?us-ascii?Q?nQfRSGZ7kJh9u+Nw6XaRHPBr+gYl+Ju+USE/jVDuDXzPlcXxkkRhz4KSwJRC?=
 =?us-ascii?Q?254R29Y/Iwju8yS3GjYjkxf7dP71hfzBz0xIPEGRC6MB2/KpSSWe7ZDP6mio?=
 =?us-ascii?Q?qWYk+St2nlq8GOHMb/kUJSOYzfYKlLgnhPPbWo6aFVLqS5+9sSsx/gmj9MxM?=
 =?us-ascii?Q?7x5rSLu+E1ahrQn8JEZtArU8lKjIfWDJvy8wCHgX5RlRb9lXCnuSTHvdoHhb?=
 =?us-ascii?Q?Z/gW0Cgm64Qy/3HgQXBu0RfDcnnLq7HS3ueDSPsVw4WKlDdqlUPcx/DGXYzO?=
 =?us-ascii?Q?ijZ4bT+iQXiipl68uSAjUIGsn2pcOnKRFipdFU76kBHFQDzGLJASlfnTU374?=
 =?us-ascii?Q?BTdOKyJeTt2EcpNDgG4umy25EZ3ZKHRovYtQT18KvtxyFhHZytiPWihKWMt/?=
 =?us-ascii?Q?O8KOAtLyBJDdYTkC3ovi61uo3KBEVRt4OyVo0fTESdM0cN/KbVENi1NwjJqt?=
 =?us-ascii?Q?z/n4SLzLzsYI3jzwiVI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93a39eb-05c2-426f-1b08-08dc01c9421c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 02:05:08.8761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdUmvayl7zKu9wNAckPi1asYSF42B1iE7YrXKMiYdoGulapZTGJ+6ZNrUnO4A6+TG/rQQ2xz9gjuhp1jxUzMuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7449

> Subject: [PATCH] clk: imx: pll14xx: change naming of fvco to fout
>=20
> pll14xx_calc_rate() output the fout clock not the fvco clock The relation=
 of
> fvco and fout is:
> 	fout =3D fvco / (1 << sdiv)
>=20
> So use correct naming for the clock.
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

