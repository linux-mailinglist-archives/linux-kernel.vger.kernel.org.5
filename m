Return-Path: <linux-kernel+bounces-158255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734BD8B1D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C8C1F248D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068384E17;
	Thu, 25 Apr 2024 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="VJf7B6JE"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7A83CBD;
	Thu, 25 Apr 2024 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036556; cv=fail; b=awE0dBePdh0KVY3rHPZGB3xXFqYRi+8cZFnEdGZopPraajmsXFEttvFv+T5IJyp89kn/pSLzP/X88LkP3aBtQdv6eA7KVbh7f+te4tPJSKRnKNCs9OzFZlvL2N8cYNJwDM8EIavSwjtzWOUd3hlFVFW53KAyWXwRSaHeXKMpGe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036556; c=relaxed/simple;
	bh=O/3lKcXKfMib4ZzXKQ7LXw5VQ9jPJ4seRooZBf6bCMU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kxHK9AEFI0JIHRrdFSEf2TXrLwqC3uionM4rBH4d3ix8BK6Cu7I03CEFG6kvajI0NB8qBWwTQtInrXrE2U46lzpnDfeL7xOAcHnmDj0o7/Vw0qWXFj/va/sfCx37N3Nic3YvEDJStsLqlGMDO+dTbxVrnvFsg90FGBEoiOvnq1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=VJf7B6JE; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P9FHIQ011746;
	Thu, 25 Apr 2024 10:15:17 +0100
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011007.outbound.protection.outlook.com [40.93.132.7])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xnxsfs3k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:15:17 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwjJ5k7EmYaw89MJfFB7tQrBL0m/qb6NVsQM12EF7eZ2hH6I4JAd1wlJ/xFzkY9KZQrY81owwS3Dco6nDVKuJbVj1LRxQxNj9BTxhZaQKBMiWIuaZMx+irSxH+HMihhVfjmCSU7cpX5PVkTUGDxn6zKnBRAqzJzkeoohxvDZtpfjnR/Blxb9T9ar9kSEc+8zo9vDZqQ/M1/RUpRxDZR4OBHoJlmL+cgGvXqVY43brCoBn5/zCsiot+k1ew3wBAca/z5MNWYwqYgdyB7UY/9xe26xDiDrtFHa4wgyeYFSKov5LADGaH98JMGp+SjXKMu0Ki8ZXrGrJcwW+ooPneKX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BG4zghH1G9D1hBeXwBwp4hC0//HqEFy3/vMiCBzKj+Y=;
 b=EiclmpfKo1pkjA98phH+ULjFMndfjiVmAlE/0n1IYwibr2Jd8OTimAcshwF3NpGa3uQXG3UQjwhZWSV52flKQ+zGaFltZc20cSxwqF1FVCAoi5+OBZPLX4P5px2bkh160a9F8rAdeysI/vpkkdlzGcdJ4jJq4G2AfIFaYqWv/cQ7lexM7g35d+E/VGTMnk42sCGFc0Fs6zE9l5tdiEJG44OVSg0XFnnORuvxLKqnKkUBCr3vsOcPH7vCzOFq6BFTusWjLOjVaq901VTMyAP7DuWZkrrp/pb45lbfxhZbGyX8pfSflxiPG+Bd+fAnR/6Bd2dE253jk3iDnaykf0pFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG4zghH1G9D1hBeXwBwp4hC0//HqEFy3/vMiCBzKj+Y=;
 b=VJf7B6JEYqFw39G0p1yVlx2XayTCutDunljfTEgXZZ600hylhTfv1u9FiQ1gw1BwK5lgktYITIO3JYP5bzQTesJfQhYqD9g+1Fu2RO7RtZEvK09VR3Bdvvm5W/kuO+l8/ejP2fPKIWc3xe7d+HRZ0dG90JEpc3Hd3CUbGddYUGY=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB9905.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Thu, 25 Apr
 2024 09:15:02 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 09:15:02 +0000
From: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "olof@lixom.net" <olof@lixom.net>,
        Niko Pasaloukos
	<nikolaos.pasaloukos@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        Matt
 Redfearn <matthew.redfearn@blaize.com>,
        James Cowgill
	<james.cowgill@blaize.com>,
        "heiko.stuebner@cherry.de"
	<heiko.stuebner@cherry.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "macromorgan@hotmail.com" <macromorgan@hotmail.com>,
        "sre@kernel.org"
	<sre@kernel.org>,
        "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "rafal@milecki.pl"
	<rafal@milecki.pl>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org"
	<konrad.dybcio@linaro.org>,
        "geert+renesas@glider.be"
	<geert+renesas@glider.be>,
        "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>,
        "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>,
        "nfraprado@collabora.com"
	<nfraprado@collabora.com>,
        "u-kumar1@ti.com" <u-kumar1@ti.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/5] Add support for Blaize BLZP1600 SoC
Thread-Topic: [PATCH v3 0/5] Add support for Blaize BLZP1600 SoC
Thread-Index: AQHalvENke//ZUoLCkKFp1wpsKgs6A==
Date: Thu, 25 Apr 2024 09:15:02 +0000
Message-ID: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN0PR01MB9905:EE_
x-ms-office365-filtering-correlation-id: bbacbaae-cf89-4e9c-ebc2-08dc65083067
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?VuhFnFNHEETvlZQp0KaG2FT7BvhymfLkEePFDU21fI4f3ktA0ptl2uY/68?=
 =?iso-8859-1?Q?xITcKlWWCzVjJxHEV/qO2M/vUpJzHKMvDB11ScuzEMKErbVsVSIbR07MVG?=
 =?iso-8859-1?Q?EI0xZWEHLl7rNj8TlFTbXqOU3zu4dHlAnTs7asP7H03IgeU0rfVhH/P5V8?=
 =?iso-8859-1?Q?8uqBvNt1LDU1HMTpcBJmjRAASxHNaJRFAWnMrSJ+Td0vV+Rjv++8sH4B4O?=
 =?iso-8859-1?Q?DhB+CYpUd172v4GfY/3AtrWMTz+EkrRKXK9+RSaA5VrOJO1wYWbcilSYXO?=
 =?iso-8859-1?Q?foibUh9dQ9Jt9Jno5omXKFlAXy2I05Y5mPyfDmHS430Z0xtNC1WnGL4SYN?=
 =?iso-8859-1?Q?UrRAJeur8xa2du4iAg3e80H4G1fUZV4PX+akMnLyyb0ufMLINjaC7MENy/?=
 =?iso-8859-1?Q?/tstgWrKS4YV6iOGU7mZesPQR089u+YNfzp4pmGZ8kjrHtqpAkE0XVBv0q?=
 =?iso-8859-1?Q?yYz5OKy6fco4UG9ErxjrNuEa4CM+pHW6HsC701cY2URVWS1JcWcHf/67gR?=
 =?iso-8859-1?Q?XekE95HFP7dgRz+VKCiHaZIbIwFN0TP8r/Dx3ngVMWxZN9+ZgF/b5HjDot?=
 =?iso-8859-1?Q?2uc0j+gj7EJwv/r0MWoQ0wVBbmWm3nfU18+O/wliCw7uV/O21HxRFNWcKf?=
 =?iso-8859-1?Q?Vs/NkpWxaYLB7N5lx4VWbVMdjsfw5CHBUO9DjLpZayxLaBKslM08RDhuL+?=
 =?iso-8859-1?Q?EfCZjZD4V5MZxBQD2wIeSFBhl0CjlQisreJhNRlJBTXe+rVGd7nYX39Uvj?=
 =?iso-8859-1?Q?Xt6nOjvEmaq3pu63X0jly2/e7VA5Cjwi9UIzJXOZXDabyADJOxY9s9okRZ?=
 =?iso-8859-1?Q?mzz5NQAKavpNPlWVkwjHIfnWzuIw3QwQZLaAAwQm5iu68L127iyZnpWxcC?=
 =?iso-8859-1?Q?181CcpJ7TtCHld6q+Nx30ghUi9KNClcleplE+JesYmZVDhzkysl1fCkxXN?=
 =?iso-8859-1?Q?QGDtsCzaWztfK/lcHobLXiEGJOYxoSqrTAsgM8rAaxW91pCO2qghNRR8HM?=
 =?iso-8859-1?Q?/mMCrdzAju7jthReY4nBpO7UPsivRv8VstdTq8PPVdP+7YPLU2uclaW8On?=
 =?iso-8859-1?Q?42TLhW+WSJO9ncZmcMQK8zPWaxrFh3hBds+cqFSGeZiPW6oEB3ATjlHIrt?=
 =?iso-8859-1?Q?qNHe07HmSiMzHRJ3eZXlcZLHVfry/asSOy9CCKUwRsWsdO8s9nZqvR16gx?=
 =?iso-8859-1?Q?dZFRzLas3BPvM4KZCFG81bsZRT290PaRwhYFp1eXwheJB7vLjBHRxNVQd5?=
 =?iso-8859-1?Q?9ZPWuBrV+McKzAPBrAtsRCf9qzx2ML+/Jrt0owKglMxpVaD31bdaDAw1uX?=
 =?iso-8859-1?Q?TBFrKqamEMrZONwrgOz9OtP5Mt0+pNG7afnEbIM0Jpzle14P91oV7U+P//?=
 =?iso-8859-1?Q?osMs4ux4Sl5SJNOMxnqPaoHIHLjm06GzMcyZu0uat1+HnsLcH8uC8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?hkBXA0p63YHgpvKAxKOfbv5KfTiqOnvEFg+0n6mD5VTrHnjfP+gb2DFHd3?=
 =?iso-8859-1?Q?lug+eW/djyZaOqwGohDrurAWpZ/KZndzB51tT7I7V7LAZYz9Uz1TxWnd5Z?=
 =?iso-8859-1?Q?4nkljRkAssGrJzejYFJa8CDKvwxmekwaxAvZ3FAPRhq5FNzN0Bh2E5MBB6?=
 =?iso-8859-1?Q?vNDAurrEoi0y+5bKPBbd5/4QIsDk76NB3IX7vabJuv45JXb4pZPeZnezwC?=
 =?iso-8859-1?Q?iFo7fEkT2ubH2wRgZDq1Z9HFzk4fB2NKm0eduJl0D4zhrKbK+Eru0NviD6?=
 =?iso-8859-1?Q?kNVbDb3QVkImezCoM+8VWV2fqKUvHTjeA3lXl6JeAIo/O+FKEfdulrzI/e?=
 =?iso-8859-1?Q?F2CKSM1vkpgk3Mr8mOj0ov9sa5544maRMX1sve2OdFniSds/rE+YbTI/tC?=
 =?iso-8859-1?Q?kMwKY0uFo0W/+BztYQhOUq20qjvDS1uDW0xNeN3bFtL6Fpfc++GfGGbzbA?=
 =?iso-8859-1?Q?UyPITVKN0+PR/D2S5dggakuWstFNf9b/IahVq7xbqwg1lIxTKtsMQY2235?=
 =?iso-8859-1?Q?Sm2KjsvISRok/dBbCKJT8HIlBDtFLnNL0LY96neahWpwQBJ/v5zsuTdsB3?=
 =?iso-8859-1?Q?XpyrCeKI8rk/oAxDWUij0vn77LiCALJf26GWC1oYskBPq4QoTacP5lPZGt?=
 =?iso-8859-1?Q?nl9ySO3+0kRy9NZpvDJY4brg8lDtLz5X0JlzXdN5rjQuhIO27/7C2iLwpR?=
 =?iso-8859-1?Q?bfxJpBGcY4ulv5JgarAXsLwmjczu5iLa7rzLCezJrg0As7gE38H61VBYUR?=
 =?iso-8859-1?Q?VsIVd2FYoQvERigOMNWPTrxOiOEKsbpFpRkjJPs1YKkGNmxQCeu+Y4IlDR?=
 =?iso-8859-1?Q?SD2M9Hs9FKaM5KoReqxWusbNXfGXTVq9kYV/bWcfmjz0Aovo2qOGA513XE?=
 =?iso-8859-1?Q?GOLPu+o3aea5ySZHu8RmJaKv+R1GyhA+JY+krg1f58mvrgX1ZIkP5RD+wF?=
 =?iso-8859-1?Q?Fk63NaaYP9Vcbe7FrqM8QLN7fPg+hyyMYmE5pyJix2ysEOZRinZUEcdPYD?=
 =?iso-8859-1?Q?ZXQRmcelmS5RQ29a8zQh8Be7Q2C+AQrujCno8g3NL6ON9jqhFjlrSUihRi?=
 =?iso-8859-1?Q?qcAg593mRGVWCVtdUTK0VLIfiTz4FzkOuKEzSkwirx4xZwJmmpflKYcBGD?=
 =?iso-8859-1?Q?B7RF31QinRsgocJPr+sl0OcBa/dlW/whMW4YugNssSPVbGAg21Zv1aAbd3?=
 =?iso-8859-1?Q?4KlLyjyERrvtQpvCCoX2qsxRb3228SWKT2JN1JQ9C38ZaFZoAOl+sbrgd/?=
 =?iso-8859-1?Q?MUTKJJ2/aIZPl3sEl1mZHwxeI/iVtLtteFSADow/KqoOJWyl1nXJ22HhXP?=
 =?iso-8859-1?Q?b/iD5HUozvGGncjihgVRLnLFuxVDYxNMAN2ns+B+3FU/NcxOocf4xlw0YY?=
 =?iso-8859-1?Q?z/TFQ39FeURhgL9ISICBqJ0XqkGYYNfiquNgppRqabHW3iaYEMrmz4sM14?=
 =?iso-8859-1?Q?pHIJ4PGT7swkLu4R2XqyRdjXqUcOKyDlhQqzg6n4wNiz9gTsVuw/hopG1w?=
 =?iso-8859-1?Q?1uTWfsUHZjOpw2a8cK1CvzZzL/X+KMqHus87da8koQ/bWLY4zagBy2rOXV?=
 =?iso-8859-1?Q?Peyad0OxC5BcYw+bMSjO2pHJHaJEimGTZAGgV7Fny55WS4NkENOS2b4p7h?=
 =?iso-8859-1?Q?4S4MnXZSuj0tJae+PsgVUPupBe4dtAzoc2tf+tFFdo1xDYW3fkQFH1uw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bbacbaae-cf89-4e9c-ebc2-08dc65083067
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 09:15:02.5662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fywGipQWOoRRcbW/tsg1yQagffRonEaPxVLcnpMhgLk4/rP8gQ73UpJqasCBbEWz425cjBZlKdiXmFfUvOLZK/1AGyqtxV2R+drG+COGPmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9905
X-Proofpoint-GUID: 7A1PHE9FuFtbUGrvWOmMwXVUIG6uug5X
X-Proofpoint-ORIG-GUID: 7A1PHE9FuFtbUGrvWOmMwXVUIG6uug5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_09,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxlogscore=663 malwarescore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2404010002 definitions=main-2404250066

Adds basic support for the Blaize BLZP1600 SoC.
This SoC contains two cores of Cortex-A53 CPUs, one Blaize
Graph Streaming Processor (GSP) and several other IPs.

V3 changes:
 * Removed unnecessary dt-bindings
 * Update SoBs

V2 changes:
 * Update SoBs
 * `make dtbs_check` has no warnings
 * Fix dts names and removed dead code
 * DTS is separated from anything else

Nikolaos Pasaloukos (5):
  dt-bindings: Add Blaize vendor prefix
  dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
  arm64: Add Blaize BLZP1600 SoC family
  arm64: Add initial support for Blaize BLZP1600 CB2
  arm64: defconfig: Enable ARCH_BLAIZE_BLZP1600

 .../devicetree/bindings/arm/blaize.yaml       |  40 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/blaize/Makefile           |   2 +
 .../boot/dts/blaize/blaize-blzp1600-cb2.dts   |  84 +++++++
 .../boot/dts/blaize/blaize-blzp1600-som.dtsi  |  23 ++
 .../boot/dts/blaize/blaize-blzp1600.dtsi      | 209 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 9 files changed, 367 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/blaize.yaml
 create mode 100644 arch/arm64/boot/dts/blaize/Makefile
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi

--=20
2.34.1


