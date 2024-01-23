Return-Path: <linux-kernel+bounces-35059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79764838B45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19FF1F267E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A19E5A78C;
	Tue, 23 Jan 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="CnrqCCH+"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C55A784;
	Tue, 23 Jan 2024 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004003; cv=fail; b=mjCmrFFcXqnawGb33vrRAk7O8n2mkdh6UTwgkmiAtJ2CCV4s7DJ3ZkQSLCIT0Y1l7D3cU04UpE0zVitzWoABBWwrTCKfN+6K2Hk4dXzVgjryjW2/YBosSqVbrAgGFCP6F6J42jNDYmWCFJTW5Z/vQsr+EdXZUVQzTR0IWjdCThQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004003; c=relaxed/simple;
	bh=3yOaUG20m26G/AN9Mb8MIFIbbhoKrKYeZhW+6gBKTEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GeFLySlsNJAuaAUP1KdLPpS2k0kQK8XzUEegn2GErQTBOxKqr/S7+mqqslNJmrqC6tdWyFsxnOmKy1WHHgabmxxsZa/nuHDI4DZEyoP/9i6pL8meC6FaOnCjkzukexdfJK08lqYHrOMAa6NiAhaHQe4JlEdgHaRLufQOi8mcWMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=CnrqCCH+; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N1FEGD029110;
	Tue, 23 Jan 2024 01:59:49 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vrejnh0fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 01:59:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhKF7ubwUqX91/pOrGNOarygtXef9GJkV0LqA0uxZz5HdLG4XWsbVD5X2i2TW4tF51ctZCU6nYVZEdpEtUYc/WUuMB+mAxeWdhRyUh8+AwgyF4cFwitFy82zRkEbLlcb5cFxXzNQbKjwVrNN8v6LAQNxG5QPDFOzYjg+9IzCjnZWOFiiNcZWo6mZBAF8/08xXVk1vbyQEjchY94LSHr54eUfv94lMbgPf9raLdXLKOrmBng5/9zlQqf1gdBWcM1Yvp2ZxfAgzhc2YJZuHqQ/pMFGKAV6hC9Kbo1dDV1gkNpCaOw8aOM803/7CQXEfyR4NaOpdF+rxsh2NpQJ9NKJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRJoCeNNYToJOcMzaNaMmbtOSxhL88tAGm0ue3E46IY=;
 b=ZsZJ1SS+r8RsT13NAhifgpV/xCcG9HPpYgO2sS39k7ktjB+Wucp1vEcVUmDcnTpiMSSD2CEBThirL7qnW2/OtCFZ1550NTg3naG2Z0SXI48tTtLsestp4ernQujZUEbvDVTDAlp9GjLh+5AkVJFHLwwxq/RlOxKGREDKhWTLVMOQ3++SXws9g0QKWihIWbriexJtkWO3CU5VQ+VIaYvZ+bbwa11xRbf600ZHfFDhRW1qtbIGgSCCluHxSEI1ogYJse4RJys61zV3B5nPgSx8/0J1/MIMzFA16qRPO2oGzNxJbfckpdon+c35dBgQIVjAMlVLrKZ6Ul6lxCHmRTzowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRJoCeNNYToJOcMzaNaMmbtOSxhL88tAGm0ue3E46IY=;
 b=CnrqCCH+O/W/RdyEv7tYkQd+j3wVxT1dMC8S06CJlcEgsetw2KB7KoW3sBXWg2RSJu7rFg58VYWS5nVw/XU7cj6uCGH8J7cXujmQnmqQBaP/e8KJPRmmll+9WNFWZsiaE9aOMbrQqrD7e2D/sjO6qgWvag7NpYup8x6WNJdM/E0=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by SA0PR18MB3536.namprd18.prod.outlook.com (2603:10b6:806:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.16; Tue, 23 Jan
 2024 09:59:46 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::9b7a:456c:8794:2cae]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::9b7a:456c:8794:2cae%4]) with mapi id 15.20.7228.020; Tue, 23 Jan 2024
 09:59:46 +0000
From: Elad Nachman <enachman@marvell.com>
To: Rob Herring <robh@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH net-next] net: marvell,prestera: Fix example PCI bus
 addressing
Thread-Topic: [EXT] [PATCH net-next] net: marvell,prestera: Fix example PCI
 bus addressing
Thread-Index: AQHaTWjekYS38TgPe0usgBWB/YnaQLDnI/lQ
Date: Tue, 23 Jan 2024 09:59:46 +0000
Message-ID: 
 <BN9PR18MB4251944C1AE34057DACD7556DB742@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240122173514.935742-1-robh@kernel.org>
In-Reply-To: <20240122173514.935742-1-robh@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|SA0PR18MB3536:EE_
x-ms-office365-filtering-correlation-id: 1d8463f0-ff27-4845-251d-08dc1bfa0788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 roLAz8snjw3df5c/V9D039EJwi7E+nkiuZ8sBo2xZlqgPxEBMnipCqFR8p2tQMVM6ivjszm6le+fobzgoOkOQV1Adr5CIh1O8AgVnQ++bDPxyTn7m5tll1gn9ldI5Oel5ufkQu4gyfzvYY0OsaBKplipmvRhhJFQMXkWiq0b5qyOMws4NqmH+xqOqBFD5YX82mXK8WCfYzDz2MYcMx5gCWjD4a5LaY30G8QYvi9y6rkETEzZd2SH5fZ8q/1gUta9QMHMX9BdcvH2z9xrRiVxB/BBi9kZlOFy/u7+JYTj77RsaL1qx5th/ix8ZIaYidVpVrV3yoeh9K4JCUhwyLuzfS4dfeD71b7QFD8BMguFs3P8mEAHlARWEWkmaqb38hmy8SdSw2Df+54CtFHgtKB2w3PPLwku3Wkr6+5PW6Yrs4Cm6VZdsTcAbqZsLKIxvj8UBzIL71fsKe6xrAGBuF85tDR9x2N+t6M7qRfyx2/bTPjl2+6S9B3WajduPzFCOf2rvkIUTjahW7AVGhCgBZesBxIyN8HMT2wkKBZ1EFH0l+SXT0uPOwcHhB9e9pGoubaHMszNo2UG9poe9vq5f66qy8g8z4YxgaoHLlVlpYpdWy+rBFu2rcwsmLT34f/RUTJ3WZfFy2ua2ymWoo6WVCxlZg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(2906002)(478600001)(33656002)(41300700001)(122000001)(86362001)(83380400001)(38100700002)(7696005)(6506007)(8936002)(71200400001)(8676002)(4326008)(64756008)(316002)(66556008)(66476007)(76116006)(9686003)(7416002)(66946007)(110136005)(26005)(966005)(52536014)(54906003)(5660300002)(66446008)(53546011)(55016003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?qjhs1+cGGdhozVv6vlPvpDo9Z5+8Lr8SB6SsbN9/eCKZuyVig1aao8s0OpKi?=
 =?us-ascii?Q?4npiFYED+hQQO6+qjPKclR0ooCyaixjJelbigQBy+4zXbYkq82Pwt5ognHPm?=
 =?us-ascii?Q?VywzY632ctp0gpkOkoWW+ZeJOxaDeMNgn9gTzQv9dzuMHvA3wXBoBVR052xO?=
 =?us-ascii?Q?duZeepciTobIMEr4G/uKuV4Bs3PlWBPuRBkKBFW9OZ0qE6jM8j5V6obvdFgB?=
 =?us-ascii?Q?bxjbLdOD6hQLrCyiMqiEyCzJwtoyaDlnqCjj2cyEskt0tvTysjGTTESEOLd3?=
 =?us-ascii?Q?uToReMx10/HlO3l1rz1MCna7ntxARzKAQ+76qspW/JcNf0PAi7FtY6ap5x6H?=
 =?us-ascii?Q?stgkanzk7N1b7tPMtE5uSGFdSAAv1aeCUVtA/+T+Nj23vo2dmWnFbTvkJ+ym?=
 =?us-ascii?Q?2S5FQEBuwB53jmQzZW3iUBmD4kDp6Q+F8w7pJAqJpj57rZyzMB1glfX8q+Q9?=
 =?us-ascii?Q?tV6rGPwxapDNI92xGRYCgxdAB6qLRfPKGk4bzPl3QlkLjuBnvarM1oZpjPTj?=
 =?us-ascii?Q?NyEnoukc/IO/QpXmMuPBMc4HtK1zLH26Z/2RsC0Qw5uUP7aPRH8nBtYTf5jV?=
 =?us-ascii?Q?NeCohAKWoKOiJB6zclFrrdpMU/MFqX/T7zZaRnCflggXPmhVbEstbUpNPaGj?=
 =?us-ascii?Q?Gws/q6QAPDnepOrbfioCZvS7fM0dJ7aYMiRy6l9HU1XR0rciEOdZ4KwJ3bpl?=
 =?us-ascii?Q?t+yyVsfpmMKjsdr5hb28gqj6x0OCQp0MolxJwllO2y8GnViH+dz6q4yxoxV9?=
 =?us-ascii?Q?a52Thvj3/lvvXLqoGyZhcS7iAMjJcBWS/jZH2xO+UrbryQvgUL/Zb0NMG3Uj?=
 =?us-ascii?Q?1qgiQRhItlsKsjbH0qmfIgZii1EhRdcXmRmXMs2WX7L4/UeKONgQMwNjL+n1?=
 =?us-ascii?Q?LqveN6kr3W45fSzlSOEf8dJxesnWXorgK8Pabv2Tvjk8uU0YZhNp2tSmJcNz?=
 =?us-ascii?Q?EnxYQTdshIeHK8Vow0HQkDgBDhKEz/aJnt9aCfBhZ5Da3pDfIgYSlqBBR30a?=
 =?us-ascii?Q?xbi6kZ3SSffKaBNPgkz/IY5QKRt3ZDX1WToJ9zkMYWe8eydJTV3cjZEDZtmh?=
 =?us-ascii?Q?z8cXA9A0sLQ+x5j2fQCFmXzRNFTsqhsrrovsphCCo0wX7U7/DC+wvDHRd72t?=
 =?us-ascii?Q?a2eW6Kahhp7nWMVqIX6SquhYU7EnaSevArUzHOP20sX2R/E96SVvmJwcG996?=
 =?us-ascii?Q?kK2rRRuUMb98OjQXyypPNSg/3cpizitCfLPcVAXWAAeVvYp+TrT6Zq62vkm3?=
 =?us-ascii?Q?LYHKeadCiLOko2/I6XFwtM7cjhYKztSqr1Bn3ENSPGoKmVNBPkyY3tPKqsHq?=
 =?us-ascii?Q?ZBueqjorehyDhJWl3lgxG22UgbaAY9W9FTs6Pe/bivvKwoDU2xoVm96hiVdf?=
 =?us-ascii?Q?uSuQr4xqb3Db4sDWVkm7eGXsp0pUuTmrcCRD/eCJSRHiMCeWGdRhAIcbooC0?=
 =?us-ascii?Q?hxMJMVMI5oZFPgV/X+jc8L1av/LiFPH/ONPnac37kpOsiJxVK3RXeKO8yacx?=
 =?us-ascii?Q?Gq/RwwDIldVVQ1TFNy2FK+1HOQ7BFWaFbpLBqTU7QcIVTkLleT/lDDfrdjlK?=
 =?us-ascii?Q?AULLcon8iFh6L1PR5+jR/cDgt5pcQLxnFLzMfT4l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8463f0-ff27-4845-251d-08dc1bfa0788
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 09:59:46.1472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWi7LXmk8ekuoT7KfNJowD/jWuZ3azb8EltADIcs4A5brL5eCoonuwPLsJ2iyT4PZC6gh/FVPAe7JBymQv21Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3536
X-Proofpoint-ORIG-GUID: kofLRl3dciAvnwhGNGbz4u6HPKEUs9Nh
X-Proofpoint-GUID: kofLRl3dciAvnwhGNGbz4u6HPKEUs9Nh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_05,2024-01-23_01,2023-05-22_02



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, January 22, 2024 7:35 PM
> To: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [EXT] [PATCH net-next] net: marvell,prestera: Fix example PCI bu=
s
> addressing
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> The example for PCI devices has some addressing errors. 'reg' is written =
as if
> the parent bus is PCI, but the default bus for examples is 1 address and =
size
> cell. 'ranges' is defining config space with a size of 0. Generally, conf=
ig space
> should not be defined in 'ranges', only PCI memory and I/O spaces. Fix th=
ese
> issues by updating the values with made-up, but valid values.
>=20
> This was uncovered with recent dtschema changes.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/marvell,prestera.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> b/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> index 5ea8b73663a5..16ff892f7bbd 100644
> --- a/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> +++ b/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> @@ -78,8 +78,8 @@ examples:
>      pcie@0 {
>          #address-cells =3D <3>;
>          #size-cells =3D <2>;
> -        ranges =3D <0x0 0x0 0x0 0x0 0x0 0x0>;
> -        reg =3D <0x0 0x0 0x0 0x0 0x0 0x0>;
> +        ranges =3D <0x02000000 0x0 0x100000 0x10000000 0x0 0x0>;
> +        reg =3D <0x0 0x1000>;
>          device_type =3D "pci";
>=20
>          switch@0,0 {
> --
> 2.43.0
>=20

This yaml has a mix-up of device P/N (belonging to AC3, BC2) and PCIe IDs (=
belonging to AC3X, Aldrin2)
Looks like a part of the yaml was updated, and another part was not

There is a reference here of actual usage of prestera switch device:
https://github.com/dentproject/linux/blob/dent-linux-5.15.y/arch/arm64/boot=
/dts/marvell/accton-as4564-26p.dts

So actual ranges and reg could be used instead of made up ones.

But the actual real life dts places the prestera at the top level of the dt=
s, not under pci.

I am not aware of any dts/dtsi using such kind of switch node under pcie no=
de, similar to the example given in the yaml file, and did not manage to fi=
nd any under latest linux-next for both arm and arm64 dts directories (plea=
se correct me here if I am wrong).

So the question here is if this pci example really necessary for the preste=
ra device, or can be removed altogether (which is what I think is best to d=
o).

Elad.

