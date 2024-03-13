Return-Path: <linux-kernel+bounces-101147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4007F87A31C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640511C2143F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE2D14A93;
	Wed, 13 Mar 2024 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="xo7Kf9dj"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2059.outbound.protection.outlook.com [40.107.255.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95DD15EA2;
	Wed, 13 Mar 2024 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710313054; cv=fail; b=lA17hQW08jHuh/p8LXyrX+KRZZa3wju4M6FYsgybuOIGC9fNo7EbyF71mKOfyPT1CVT3Kfv+11mqcYCBlGeVl0MPuekL++ZywDim1TESbgM1343rQTC14MHsvhdTWd/yLISvvXd6hsL1oI0lXlTRzSmH8ZaakFgHJjOC+XFwFS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710313054; c=relaxed/simple;
	bh=0mFGQ01dBiqip0fUSuh9ZYHCUjk/sIAr4jRkLgEo89Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nGnAIgO2halkT2h4HSxpFpPILacEo8YqvsxtQ/8iOPJaUiVPBbSgUvikNkZoYQHbkTZ326qNlA+AR7duULiNF/n+xsho6cRGFzgDctl23sMOsarg6LAg1oTxVOphjuaqBPZNbOdHNaj3bjX61RaWg21amgP/xur6HC3AlnzOOUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=xo7Kf9dj; arc=fail smtp.client-ip=40.107.255.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuEHIZLy5eLWrA/0rp6DzM5WmS4hloQqetTNDo7gaNZt8l2i3Otpv5INQXP5E6pDqCYxzBBcsdaIN6ctgd2JguEfBqPc3gNxEaNPMdtnlcB79X+jPBpjNm1k10MK7m0+eqpnA+IjzBZQgK5q/UvL39sSr0s4D/pOOHHV/ap6h6TAsVqMRpWBbmIDhHMHDq3+KWFa4GZPO/E3TiylroVxzrPp3y9rPchzbjN04H8g8bUB5JqkjGDjqJV+LDzx9/ZJwDlHS1aKQob9xKdPzJ4kpUt18UETDsLU8PcJuCDrNJK/WhUSa7hVvUoFmP+Uzsm/jnW/heGHTvf9YcyCs05fSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mFGQ01dBiqip0fUSuh9ZYHCUjk/sIAr4jRkLgEo89Y=;
 b=hspIXZfptsjSDSn67b2FTLR/5ftUGB/JrVkt3sds6OJ+ifeiEeLCGTm9I5TL0vX3w80MRzlDrTndK3D2if6biieUe7WvgyI2Wk6lfuNz6K6LfSr3zB2qwSo3FC9eL0IThszf4EerbKUPBM6XnvB7FcRbE5FVQlJvwUtFzEwAhSNjoR8vclHfNlawFhdpSoNIFTVyS8p3QRHB4nOsArnzRMdd5FjB7Xqn+f+ej5P18+2Kg6Nvs/wgKj0pdAx1txJO8kbsnLjI+fycRDeukzuZBHfcLhps+nXoLYdO/xsLhDE62kqyAWSWAfrkp7NdAopJ1CTWaNiTvsimgW8LVhDlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mFGQ01dBiqip0fUSuh9ZYHCUjk/sIAr4jRkLgEo89Y=;
 b=xo7Kf9djjvOX2hNRbfgbembQTBsOhAJ7N1qpLH7HnXlWVD7soWSLf8VdYiOKuy9K9D6NFQbi2FhZydcs0oX2rPVg/Ajow1TbR5ROCf5L3U+Fs7qnoEaKFjrnko0U5MO2WNr91jf+OxzZNtU7mdw8dQnNbmXbemsXUBUD1PgyKSO0uoFDqwpvz9rSM8yAg4XpkLF3SlWwKYrQ/4KqGY96mij2IG7H/Buc0gsTrsroNTOJJSGYBfsbcTXBrCXqvVtOdIqwgKJaXwmSd7W7MY2LZwp3HKgBj37vH+0HI+mHsJIDCoOBcJJvGv4pk1IIktBISDmWCnma6ag0RKU0xxcYJw==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by SI6PR04MB7925.apcprd04.prod.outlook.com (2603:1096:4:24f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Wed, 13 Mar
 2024 06:57:26 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::7cab:4c63:26d2:5f1b]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::7cab:4c63:26d2:5f1b%4]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 06:57:25 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>,
	"patrick@stwcx.xyz" <patrick@stwcx.xyz>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Linus Walleij <linus.walleij@linaro.org>, Joel
 Stanley <joel@jms.id.au>
CC: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] pinctrl: pinctrl-aspeed-g6: correct the offset of
 SCU630
Thread-Topic: [PATCH v1] pinctrl: pinctrl-aspeed-g6: correct the offset of
 SCU630
Thread-Index: AQHadPAQCNfRzKU/REGwDwaoATPZ9LE1PK5w
Date: Wed, 13 Mar 2024 06:57:25 +0000
Message-ID:
 <TYZPR04MB58539A1D94340F330CAF3CF9D62A2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240313024210.31452-1-Delphine_CC_Chiu@wiwynn.com>
In-Reply-To: <20240313024210.31452-1-Delphine_CC_Chiu@wiwynn.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|SI6PR04MB7925:EE_
x-ms-office365-filtering-correlation-id: 1c48da80-071b-427f-a14c-08dc432ad73d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iRdNo897R8BEFQ6YQNFvGzI9rwTICAwMHNFyCG8PMIaUEK6jDE2eR2kq7CC+JsWea2omBrLdEFe9wwBk4NmLVN5XoSX2Zl2NLXNVzvF9zHcZ751ShIwP2CCpEUcSru+5rL4bHsp5byhyCcj0xZcTuf/uHV16+movE0cd4XFzcx2nTFPibOzQGqoZKElFcT778SXlmoNa4G2XgEg+prwIpfziD0IOlYx+U4x6Of4b5Tc7BmI6xeEZPaLTYmOP2+1FQa6ySElmdFoVwE/Adqj/Rp3syEzcaTViWcm9nD/ihZbf2icXnaT96FCbunzTE0IzOa1M3adLiLH3vHBjQ26Wg60zGWCO8puuBaGDTgq5lF+IWG5EmsM/mkADDLQ6fpOvFMunzxtEx4JSz9pXqljYtJpRTWNUXNfjXz6NcFiR0Me/EK1Vz0U5hfcA9vmxJaSrJH2Vqh80EPXMUbsbPxbs67o38eNH4KzoZpLjdypnguOsJf5/tiSz174XdYwf5+BiGmWLVnHuwXt9vPqUg82f4YcFF5xYck2P6Te/J1/Gih0eYld7ngYJPamZdG0ehucKXOA/qU7mxvzuvgqxt8oBpUQv2dXeFSfyKNZcysYo2dVXWz9aaYVSUsbkrJsnQPf1fRtIIAC/p+WUu8h3XPrpz96IgNfebCRQZ8ac/RnsVAv8fw2JW3MZEB3AcZhOZNe6o1Rs8hTm1Enom3xH+JWM34lyrUBwOjWM49xGZ0c45JA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XvmiVp5pEvPWb5FdCu6pRUW1hf0LXLbXSAXbpJVnLQ9fNJFWLidYuP5lsrCP?=
 =?us-ascii?Q?jTrMAIvCFFB2EvPDIrxOtvIwuU6ZCaZPUk2XwjVl34ip+uvuMcGMPxet4OHX?=
 =?us-ascii?Q?Lj458dgcEubu7IpMaWsFxgDUW58mkACY99q/4SZgeXTb6vvfJ1l7qWstXBOR?=
 =?us-ascii?Q?4VvblzAaTjE5ie6L32Eea852+vPUE0S0om7DsmBcoqGFruwmCrL6A4Ilce84?=
 =?us-ascii?Q?tn5Tj6yzPxZbpyzKg/DxQnV+tjH+YtDG5sdLOCgrcnQxuqaX7WDQaXNENV6u?=
 =?us-ascii?Q?30eu/RNLxzQoLVH0sIEI7OWcbHHq7fefYTDWRJX88wDDc6wbQwH1r23yNBwZ?=
 =?us-ascii?Q?w9TOXah/3JjZI+pwq7Pnd1gT8haWguLZODEACqr7OAGPaJV2VTBMKuT1ZAIn?=
 =?us-ascii?Q?V2TPib3fBxxioopoKX4TKjSnMgGhm9oYvfZyxYq9BRAMrov3NZfwQOBcCYVJ?=
 =?us-ascii?Q?fgd1TDavL7OlYjgL9ZyxNxNyzlNVIhj4Pk+3o5FEAz94n5LzfuNtqO9pxLpL?=
 =?us-ascii?Q?Zyq4coEFmUVnWYtNgoVDs3uMQd0A8X53phRFlCWRkCW4XJekEh28W1qwBRbh?=
 =?us-ascii?Q?ZF/ncNRDPRy6J0zUUrOWjShQeID6MEBVuQsUD24e+ymZEY/OQCN1ktFUJZQh?=
 =?us-ascii?Q?0je/ts0zfmVgxgO//yaIv5TYBFbVZsP7x3c4kLqE1ZipshUHfGxuB+cHiqnC?=
 =?us-ascii?Q?Po1WOloyYLdvchu08whomvotuO6KvWmuaVdd7wMCRqUeVgt0IJLDxM4QH92U?=
 =?us-ascii?Q?pEGh8sPctw9uExsUGr9Pjb9voXPFqbWT6rqYq3TzD3C2rkdrz385xuGSiWiz?=
 =?us-ascii?Q?718aBVvF3oQSRiBHHsApwkTOcS1JwH+FQpfv2C7UCPepnwVnQ1H9IzwA6V/n?=
 =?us-ascii?Q?4jeAXWmTb4yTbYWjB1z9ypFKNft0b739jCFJAzVK628zvxdG7ZOGrnCYlsAP?=
 =?us-ascii?Q?TkgeFs+HmIDPQXDgkdTof805A0zir4P/m3lGWsfsbMOBez2LylCNaIpOphK0?=
 =?us-ascii?Q?KoD7B7aaoN0l6rCQDOoTERiwsk5SwTXrZfa0qoILREZUWXI20wbvEQueisAm?=
 =?us-ascii?Q?aUqSWSpUcQ3SXHsQfkCyn92ao320wslYlFb878P0hR9pslgkKhI93phgnBoL?=
 =?us-ascii?Q?QDE1KUQnHGTCya1M64Ujwrj3Gjuj88+HSANanH+8OFa7WDwLEiET8LkJ0gOD?=
 =?us-ascii?Q?3LZ4QcMXxEtzDHlbU8FVajmPrl+gn8cDV0vERf5/69kKUIQbMCDIfVmbL0tR?=
 =?us-ascii?Q?z9rOW8XbaZ4S0TmoFXDrEzo/6afpNAhn2u6Z726Sw4o64iK4KcUboJqE5lly?=
 =?us-ascii?Q?FoYrz8uWp1Xfp3dER3hQ1Vp0UMk5p7xBS9NltNVZMAhrv/q5SSUHaNypmIjh?=
 =?us-ascii?Q?vrecS9wk8KPaq3wyFjR/M3iBZ6aoPZRI1uAInc3P3NRslyTUkAgzwCv68Whi?=
 =?us-ascii?Q?v7ADDyTBgi22RxNxY6w3UAhAo3WtlRRFU/FwJ5sBHgex3L+xVdkOVQX6zaaF?=
 =?us-ascii?Q?Nq8fy2oPRx/Uuq6kgZuAshCk8nyNgQ/qXyC69TpnoHtfnA/8u53SFYl01nNt?=
 =?us-ascii?Q?VIuPfcgwBZKHCT98bw0B+TlJW7wiLIeBw8q62xc3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c48da80-071b-427f-a14c-08dc432ad73d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 06:57:25.8537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bxDKNn4jrPk+knTjOR4mZqk7YFrCRAWraEQ9ViIFt4VeFD2Niq0tSkVtzpOzmCCC8NjFFwL8HS3R0ocxwE+UGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB7925



> -----Original Message-----
> From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> Sent: Wednesday, March 13, 2024 10:42 AM
> To: patrick@stwcx.xyz; Andrew Jeffery <andrew@codeconstruct.com.au>; Linu=
s
> Walleij <linus.walleij@linaro.org>; Joel Stanley <joel@jms.id.au>
> Cc: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> linux-aspeed@lists.ozlabs.org; openbmc@lists.ozlabs.org;
> linux-gpio@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v1] pinctrl: pinctrl-aspeed-g6: correct the offset of SCU=
630
>=20
> Description:
> Correct the offset of "Disable GPIO Internal Pull-Down #4" register that =
should
> be 630h according to the AST2620 datasheet.
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---

Hi,
Please don't review this patch since ASPEED also provided the patch to
fix this issue.
Thanks!

