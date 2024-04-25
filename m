Return-Path: <linux-kernel+bounces-158257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F098B1D95
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1121C23BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D7785929;
	Thu, 25 Apr 2024 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="Qi0PpHxd"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307284DFC;
	Thu, 25 Apr 2024 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036558; cv=fail; b=t1O6n6W0tyRmq8jxFOHccx4PIId71Es6rhXzR5GPv090x73xWO4glrr9pF+4RJNf1QiYpA14BZiQ1d//H5ckasi+qRaRf/wNxDs57+3k8lzD+rcbIHdxQpDu+oPF3iiI8ZpGAKlrdd3AEjE+ud0sorrLP21ZBl4TLaJZQgNaj+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036558; c=relaxed/simple;
	bh=XQuemze18hL5WJYul/UFirwwpMQBlraJyUm2g7AQnf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ANuijtUL5wlyPSsw1j0KrMkKcwAsFtS02oc8ZwKDP8LxVMLxntD21tjQ1EV/rvMETOXPx4fH2w+nQ8AKUg+o4UPSm6+66Z5IU+9oI9aIl5ymTaIJIFFTSucTkf6tHxh7HdfOfBGGMb65hxLyJmBu5rAJhBgELjDDU18BpoTPdMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=Qi0PpHxd; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P9FFaR011736;
	Thu, 25 Apr 2024 10:15:21 +0100
Received: from ma0pr01cu009.outbound.protection.outlook.com (mail-southindiaazlp17010000.outbound.protection.outlook.com [40.93.131.0])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xnxsfs3k7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:15:20 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWWCuKZIng2V7G9/J4IcpIpq+ILBrFdExwwC+LKqnpiwVt9fkkZQG+XpXXtGwdwJBZCF70WbUwXRGRPge26Ed9cVGVwKzEOVOur+Z3g60yEaGSVU0vMUa0UXW8Ne3tSkfhivMyAtpyqWiWdys2Z7fNTNDqubUVgmhvDfFW5UA/3zsvZALXwb6+wfbRjxEMvdrfdYYoX5cRCVYMohRNl6lKmDCUZun+fqCEBU2rKD7Aot2XL3ZwTzn6NPt1jeKr5tq4pQL3WE+gFcG4IC75he9CLBrK+dTZZOWbqgte4JmGam8xft2Hp19lujCCuTSzb0jErxvA5eVkVZYuM9514ssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF0WyQ4JYjWoLDkS4wCJY4/YhZqIeP4Tad4yCLMjZrI=;
 b=Wo/Wn7JwNROIskuDXJbQlZQaSF2u/ITjPOxt9NfJLif03lwdRln0o9hc/YMXuyx9c7ZXt5nY26kHzlRKZWnBXUvexxxTP8lx+ltMrO0mXSKY5QmpB5fwE1dduY3E8mNneGs5v7ATzfFbayzf/jr2Icb9ksCcvqdTL2HNMEqB5Y6HgQkPMKdxfUq/Uv+4f47x/7+PUeoUrPoiIw0Xw+cqZWugnIinI85/wPL97xvAryttUHojpvBg5KzwNQyihyi2NWLqwGS2q3aBnsw5ZfyUbRit/hB5V53CvyyHd+X+8sTgf105QWgHvwU+LjB3L90qL/2fUXVsAVHr96L3l/orxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF0WyQ4JYjWoLDkS4wCJY4/YhZqIeP4Tad4yCLMjZrI=;
 b=Qi0PpHxdmfunFeGur28m56UjzlmyaHrPwA6WnO3zEG7odU6hRpHjRA7uj3xLZBcnMWNIMw71y9YtlM8p82CSR93yt0Mf1HBLcEp6/P1H5PNIx+Mfy5v5ZJ1KddVsLGvu8MmY4SIvhdNITH7VVDW4nRPXY3xpnurv8AwIi2Jh3Nc=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB9905.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Thu, 25 Apr
 2024 09:15:05 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 09:15:04 +0000
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
Subject: [PATCH v3 3/5] arm64: Add Blaize BLZP1600 SoC family
Thread-Topic: [PATCH v3 3/5] arm64: Add Blaize BLZP1600 SoC family
Thread-Index: AQHalvEPfozL11ntbUuuDRV40b2+fw==
Date: Thu, 25 Apr 2024 09:15:04 +0000
Message-ID: <20240425091403.17483-4-nikolaos.pasaloukos@blaize.com>
References: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN0PR01MB9905:EE_
x-ms-office365-filtering-correlation-id: cea17869-9360-421f-ee6c-08dc650831cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?c8x6vXxOMrDIwD/wCQ/YkWKsMJwgoAyUiUzCFlh6V9ezHF5ItJjNszzX1X?=
 =?iso-8859-1?Q?P6/mk7lJjkFKBrnsVz5FjoApkT4vHOAARbs8GyPyKcrreBUQi0AGSaVY8K?=
 =?iso-8859-1?Q?p9iGBP3sS2yabw5LZ6gLgFnxzsErIrlI2ApHcw/yhzytPw/diPkMw7uSyf?=
 =?iso-8859-1?Q?Y5FN56ufa9uUsQUJ0MA3nk5ayRU41aoYVVVQHn7lZ+saHEfI9e0AB3Dys4?=
 =?iso-8859-1?Q?CxJ4YX+yAPRJp/PCDFrpS0aE5qJkckxJYWdddzogcF2wbre03cQ8L8XrEi?=
 =?iso-8859-1?Q?U0LWRVatplpEJ3XtrONiqW/E9PbIemSdXb5oVX4x/VE7O12WWQcabYnvgZ?=
 =?iso-8859-1?Q?Vafbgy2OEu7y8O34RW5+x+mtKmqFkRdicQLuKgLXQqu2BvdFddOl8Lg3sy?=
 =?iso-8859-1?Q?Io9XdwpjSdJCnBi8FVqqgHOXqzHwfkr/34gZQOflxx+tPHqA/nV4m1w6PH?=
 =?iso-8859-1?Q?r8bFIbGJjWH3ugmiG0FXR7DDH2VqobsB56R7qT29rguAvSaJZArwCU2rq0?=
 =?iso-8859-1?Q?725XVB6LefCY5hQybfoQ+2egE8BIhp4nh1eg7XavRYAiBxL/LybQDQGotm?=
 =?iso-8859-1?Q?LYlsXNDrUuTd6lRiASMyusueZUwPa8XWrfpSOdXM6fGppJOZGKZpP5Tpdp?=
 =?iso-8859-1?Q?Ni1L8ZgdOTc4D2VAskIUozR2tyoQy6rIgEwlaPEil2iv4R1+vq6G4ioAUP?=
 =?iso-8859-1?Q?GBd8SQM2nvO4+7iNBaQKj6R5LjLhX3a1kk8yd3QUhxzMm7PLNi1crkGUQx?=
 =?iso-8859-1?Q?YphG/is5c0YeBhATLEBKNlCpKYKCuq9Q8W+cCd7YQqxI7KDnczFyrxyhG7?=
 =?iso-8859-1?Q?CRoDQNSxDHKTlxxmEUz9GL8uih+POLfleR31vHxnlCgNX5VrVccU4IkwBQ?=
 =?iso-8859-1?Q?eFVGQfQ5L1ywVeiU8ROPmfpaON001eXEf+JJ/JUqz5kN+P4KEuOPrVB1q6?=
 =?iso-8859-1?Q?klY3wgxlqcarMZoJwJ5fRgJCn873wZLnBlwe/EYErQwDgaWgqWmXhez6zy?=
 =?iso-8859-1?Q?p8lJc/wlIXWQRBUx1t3pC8xrNcuIfxfG9hIbDiuCJnmkjGAAEKdz4GLTo/?=
 =?iso-8859-1?Q?hGldCq7iKaZPaym5lOKJPBIZ81DHjRjP44+JHKdIXOPKJ3qRxgHX+cOo4/?=
 =?iso-8859-1?Q?qTg344WyemS0wC7s+xIzBLrLNfiAwL6HjPXJ7UP+eR4m4HM+3Ac9pl04Nw?=
 =?iso-8859-1?Q?zt+ybkSdyQ5fPHjQ+Ayk5DbgsGGH/rBhPhyD29NK3e3EQUELPEF33rly6/?=
 =?iso-8859-1?Q?hf8g5017Ing/Ss46DGLHJYTJ+eribOzHHqqqLv2T52cVqJPdBS2QWWukFO?=
 =?iso-8859-1?Q?1ZQdxQarrsUA5ftSJdQQLJ2f4weWFFdZgfAidYP4L5/74OQismar9sxTUr?=
 =?iso-8859-1?Q?CxBfsRrX7NeqtdI7zzM77l9FQRfS26GzR7oiPKBaMQ6onwtqJaiKk=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?2AChYhJ77NP3Et1bmPeCU/q6pEZiVX3+8D1+UGlgAD3sUXdqmpOm7lyjAl?=
 =?iso-8859-1?Q?Oqj393m8DYwjAyGFbsQG6M7hwUs69kS2DtdnL/C2UmEsjEFTet6HwMV2Ze?=
 =?iso-8859-1?Q?lAJ1+x83rY+fBfwuPmBgqwmoxQJwBhdlIQnGEaVrNUUSxxjI2mPgMfF4pq?=
 =?iso-8859-1?Q?4vu1/Vl7HkbKQFY5LWt+9Ez+XpIJnXS/oGdvKJyiXRzioCk1BxJ1DNkxjH?=
 =?iso-8859-1?Q?iaMl9ld4vpvR5LUlfd1kBvxw0QdYCV9vvRYq4vnSyfWpwRJgteKXOvFy2N?=
 =?iso-8859-1?Q?+9/i2K4S1ASS1AA79BaVeF2g7Iid1ywhk42lRyPKGDLj9YCHtSVXbiTTJH?=
 =?iso-8859-1?Q?OHV4f2a0zUspHFFMYzZOA+8PtVuICyJYaY1f9XnwJK3X8BQfDt81ysln2Y?=
 =?iso-8859-1?Q?zDAKM5c7oDygaUrmjigjLEWCulagkzp/++bc32tYKIpRaXG5Rb3W/h+CDR?=
 =?iso-8859-1?Q?LD92sma90qhMPyM6FHhCXKEauFjeXeXyMF6T0NJfDEVLg9ObhG5RcaElx8?=
 =?iso-8859-1?Q?9OxBK26Y8KBYzOEfUcW9kuuxBHm2RTOlv194k3wPNX7AJM9/guJx58qd5g?=
 =?iso-8859-1?Q?Hj4t4X88GZwvHPLSC1Oc57SphkcdeYmjpYP49X0kZvsgln69HqKUb4tNm6?=
 =?iso-8859-1?Q?ltpeGWAC/FQiMQNSktPzRWa4TBCCfvoz1D3u3tlw4H506ogJJddm8tc1qa?=
 =?iso-8859-1?Q?oayp0sdBBAGhOfo2zeXMbb0GvPRUsBrcyzlDlXRX9RSQqsMtNqA6BwdQx4?=
 =?iso-8859-1?Q?pi3BHjAtJXXam0tRLDtdLWA+nnEoj7cQfy7jAMSB+cCd6gjlpGf19yFsTx?=
 =?iso-8859-1?Q?+wkHAxsx+6WvD6vy0NkwwcmPrXinbsEZTHy8w+fIvvYwr9HQ2ZESAYP0zC?=
 =?iso-8859-1?Q?5G/WbS1C8zSa6GuFum8dWG2Jh/OHjYQkzyUMnu6k+b53WRnoKTa54AWT3r?=
 =?iso-8859-1?Q?gXfABzf6tPzBiq2qQjp+P6qQJuQQyUIOoT1TFAIjufszRdNbE5ZhU/NexG?=
 =?iso-8859-1?Q?mv8CiXB9arxaBzLVPAi9xWhH+m6vjT+93WCZ9celPyUHU81L1G7wEeAjwY?=
 =?iso-8859-1?Q?NLvZtKFk3sjNYCYKU2OaKcp13u2Ik8DOwsqXnROk1wOk3GoR75J/hNyKLN?=
 =?iso-8859-1?Q?rjHGKbvOmYVE/vqYvgexP3XDA3/qxbsPpaepaN7+uH9NHMLBl5eeA2MSzF?=
 =?iso-8859-1?Q?FY7HNmn9T33Hi1/ISqzgvf7HRIIBAABCaxEXZ/ZRok0sePaNfuP8X4QDUU?=
 =?iso-8859-1?Q?eZm4xrGzEka5GYxUQFlUjwTec/859W9WPHfnMVSEtws3BkKkmlN71DSMvr?=
 =?iso-8859-1?Q?c4Ruukn0NmaXlzLezFIUCTFo2EVMnLoaYQVm3G8zx5uZc6wllaoSAWi55b?=
 =?iso-8859-1?Q?jpM84DJsi2UNY65O1TzBmF6gZzvR1VVfuj9UPk51wnynI3IeN4nTUafqWS?=
 =?iso-8859-1?Q?ROlBeMbxvLpYGSLA0+07jaGRCqg0QRGM30tNVDQEhVkeAPUstUmUNJZa3p?=
 =?iso-8859-1?Q?LmRsqVgXxRNzjL2M29dP4LUj8JnzstI4/t7AqMvxBqUpc/f6p1AaNcsOF5?=
 =?iso-8859-1?Q?UH8P91IOXy4aWFqhe6tw2EB6AL9qv5Ie+r32tQLB8N75/5bPWhcu9mtqh5?=
 =?iso-8859-1?Q?uH4tyJUsbI4yNsfmJAm1tp6MMlo/A5QuIIfKQ6eDhVjPbrJb7NbfVdyw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cea17869-9360-421f-ee6c-08dc650831cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 09:15:04.9340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FdJrSA4GOxbz4Bi30GxFkoxaDpt+Z0TKrV0ghwemdTr8RgtdGveyLua7tlJfE/GFsj2us6hH7IH9Ich+xNH4RmO+IlUM5F37GuEgyczzRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9905
X-Proofpoint-GUID: aLlWzh8oSOcNcqw1Q6CfeyLNJJxRjgRK
X-Proofpoint-ORIG-GUID: aLlWzh8oSOcNcqw1Q6CfeyLNJJxRjgRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_09,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxlogscore=976 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2404010002 definitions=main-2404250066

Add ARCH_BLAIZE_BLZP1600 SoC family to the arm64 architecture.

Reviewed-by: James Cowgill <james.cowgill@blaize.com>
Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
Reviewed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 24335565bad5..c2a523637b23 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -94,6 +94,11 @@ config ARCH_BITMAIN
 	help
 	  This enables support for the Bitmain SoC Family.
=20
+config ARCH_BLAIZE_BLZP1600
+	bool "Blaize BLZP1600 SoC Platforms"
+	help
+	  This enables support for the Blaize BLZP1600 SoC family
+
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
--=20
2.34.1


