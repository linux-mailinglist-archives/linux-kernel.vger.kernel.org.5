Return-Path: <linux-kernel+bounces-68644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8895857DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F68E281D54
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDDD12A16B;
	Fri, 16 Feb 2024 13:34:17 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2114.outbound.protection.outlook.com [40.107.239.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6F1292E1;
	Fri, 16 Feb 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090457; cv=fail; b=dvLNBN3LyAb7ygxpYb1chQP2Ji4NOEvGIGvyKEpHzNi2KvWJdHfi6CmLnfhX3pNX+ppCBp8S4F/7Fvirk5MBUNC4kLegHo5vKsH+w43kdNEQN2pHyGFtEcKecr0ib1dPn6SZe13vXVb7xO2eIlhCHht4OSw6x+uN1i3/IBrijVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090457; c=relaxed/simple;
	bh=+Es3fDMuhDHNThNqpV3oOYjECsP6ud+HrKzh5m6H4kA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pfx+ZzLQKvslk34Jr1zggPJHX0yed8Ex6EpVWdSAv+sLXLq/cwPj+jgDan1JGbkBiNH2qxheHQC/U5FLlA/5y3Ijevm5wJySohMleLST8K7Zx7+CdaWFYuieduoZFMgLmLbqsCF/pUGc5uE/dBcdtO0xzxZ+5DN0WrDnu5+jDBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLTgFyRe348nDJy870eXkTO1S6vMA4tgN/2u0aXaocgxUYogYCNCdBg68ATDChhCvfzqH8X8t1sXeCjc1RcCPk3h+EDXasOxQLIJDHhgloRQm05JKFJR43hBtWM7Gjdpk4YY23RPjxGx+vDmvKjHUqBP8wU6NQcY5xlAgOi9pn6mMStHFWBH1sVO446MnSiyc4oAv4O8KiN+5Esz+tQhMhydVJL17Yj+1hekan1Wbei4Xj+wNRuNf0I4JIZR8waIPdod0DgXYZhvd+snkt5+IJl/FrZkdy/NXWM7mpfxWTnlTdcz1QiEbnkJC8xl9U8jk1BUI2bCE3rEYDF0rz+Oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Es3fDMuhDHNThNqpV3oOYjECsP6ud+HrKzh5m6H4kA=;
 b=JPQXKWAkGaFTYMmdwOiFpJYANq45xmDnMhqeArBBrbpINX7l0JzyR99G9aZ2EKMCy7nKYEBOaK8MctxdXFO18iIm2ApsN4IaO/Ja3otSWmzMyhVRdKOWynwdqAvdSMiRpw4t+4G53bsDgrCA8AO8aVZQ+2Q0jwcIdtU2gPBdawfDjLSwcBgIC7pjuLWrnkHHFFneqbPne1aPAYN3qfpULqoaOdVJQUclZRI4eHMs0e4WNj7RgbNzrYBgCepaHb8epo/PnEZnS9grD+qDxxlAvgdtdbWKARTX6TgonS7B6TyWwVH7027y/dssiP2a3++vxpqr+eaDvtvvhBu25WJ27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by PNZPR01MB4448.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 13:34:12 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::72b4:8a64:2d93:7cc0]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::72b4:8a64:2d93:7cc0%4]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 13:34:12 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Hardevsinh Palaniya
	<hardevsinh.palaniya@siliconsignals.io>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] power: supply: Add STC3117 fuel gauge unit driver
Thread-Topic: [PATCH v3 1/2] power: supply: Add STC3117 fuel gauge unit driver
Thread-Index: AQHaV/IXnFbpZ+c/F0qcNLK93OyLCbEF4RgAgAcoUVg=
Date: Fri, 16 Feb 2024 13:34:11 +0000
Message-ID:
 <MAZPR01MB6957FE701F89D83DF57F7402F24C2@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
References: <20240205051321.4079933-1-bhavin.sharma@siliconsignals.io>
 <eccj4u6ewr33mlp4xqwx5medeysrjuwof7ntwhm6vypmmkss73@qjbpyw5hj3t7>
In-Reply-To: <eccj4u6ewr33mlp4xqwx5medeysrjuwof7ntwhm6vypmmkss73@qjbpyw5hj3t7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAZPR01MB6957:EE_|PNZPR01MB4448:EE_
x-ms-office365-filtering-correlation-id: e3eaf670-62e7-4849-64e3-08dc2ef3f601
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mMn7CJIjTQ8InyzcxRBkYRaa2zR4mVlE/lnPiGcRApiVaTO1I7gzw5I6xZH8JzN7ubENMU9ywouY0j2R9bHmbtsEmYd6RZKmjKlPBI47Y1TxOIiGMZn8Q5WHv3dZH2+fW8a7+sRZjBG4fsSr2eczhD8EKZ3SRD8O+j+7tei9zzi6YJUiWaVwb0GzOkNkMTh2jINS26RAh1awpR0oNTC9auRiNzWVM0GL1kG7K+PgEysrm1A9zvGwJL6PucUSLttR99jE+LQN6DaGeO14RlKay5t0XnYMHUJdD02yQQcTLUJiS4VmZsOGuY8sncV10XGrcq4haoSAdVjME2YHwJSqMLxIqu41EZstp/r2PVdxDAkD/7vHS7LxPv9plyBZHsZ4qfkVpHztC9s9bVbtRiq6/6F1W6XLvVgfbWObmuoy63aK0lwCrCT1FckONB32wM8GdukeA/2xLag6mK53vamlrz4UmXyZ1i7q0VVvkxEd0hXVbwlnxHJA+Ne6DMF07z7KMXDz+zrQ3pc3vNNNEdJlu3VeGfHas7XOOJaIZFIWFDO5hy5sanREq+UsjV2ToqjVwHUrhJ03UZsGLTpX9FRmHNegp7D+Fjpr/j6ZEQgpyrNL241vNCB6rZ0Et7neS/Gq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39830400003)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(122000001)(83380400001)(38100700002)(64756008)(66476007)(66556008)(52536014)(76116006)(66946007)(91956017)(66446008)(8676002)(4326008)(8936002)(2906002)(5660300002)(478600001)(316002)(71200400001)(54906003)(26005)(6506007)(7696005)(9686003)(41300700001)(44832011)(6916009)(38070700009)(33656002)(558084003)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lqlsQf2kpFo85y+mB1bxeO8g308FId0sHqbJhAROn+jOVScSxbZSjyx5By?=
 =?iso-8859-1?Q?+aQlkqZ1WgBdHzMHhdbhHkJqKxTYt9S4kgxhR/sAS+7yJqYVUh403zRBPE?=
 =?iso-8859-1?Q?/aqzMgh3dhppmeWZpB11Mj6gWjMc/IUSAjJ2ppKpPhpKGaQ1UihWaTm4qz?=
 =?iso-8859-1?Q?uSEwZUdA4dKa3RWnG6WnxXfygzXq91trOO1r427b3kv8PJIb6MdTb7MgVT?=
 =?iso-8859-1?Q?A9oWau4o3PxZ+fMvlVWoSUm14G+oJg6zEOfwbeFElprTmKuynJVcS92ZwH?=
 =?iso-8859-1?Q?lt87ercWc8WCK+DUkEmCZdA4NijkoUuIUjFo9kaSaGKhqQOF2HktaSX9lx?=
 =?iso-8859-1?Q?Dcxl54+HtCyIzZr19xK6piOAPKDNNgaiC59QoRu7fOr2cFfEgSxPbQJnrR?=
 =?iso-8859-1?Q?cQK5RPPdFEY2yWMlZltyQZwSSnhWrVnkef/VYS5EvETOxkxmv95kKtiOYA?=
 =?iso-8859-1?Q?rVXZqZP/QS6UO834LgwSnBv29JFnayhiIAUiGTRkB0kq3wpGYsBl3z2FIA?=
 =?iso-8859-1?Q?ER61sAJws9EkXH55KQSHZP5eaS7lp2Fyg7AqVCgaIqmFnrgypxXvbRKYvQ?=
 =?iso-8859-1?Q?eC6JoMMB1hMiYurJewzkmbLVtd54IE5G1aj+nN2XkeySjBnVtj3R9qEK/q?=
 =?iso-8859-1?Q?kTFsdfeBRnROmY5QxCgjZTW0tsWqyjFJM4hisJCM0y/5oyt4ooLwNsLUDs?=
 =?iso-8859-1?Q?0MVuzIppzTnpzqOK7S2f2LlU2Ng8NWFUYzOdo3rAwVAIOSHDmYXEpRjm4a?=
 =?iso-8859-1?Q?VODqRsVSkdcTj31ENpDli2sFO4NkBnPPiUhXMaDmsErnuBd/pZ73UmiSO/?=
 =?iso-8859-1?Q?Xbfs0kCl/+ziu/uox5hAZsHbUQ//fLZh42poOQkRX6McB/mDZ3r/bTC/lj?=
 =?iso-8859-1?Q?fI/BV/seneFIZ+Bn4hm7CpTUT5/1J2LbcEFCNaYKmj3T5wrbQu5aJYUrph?=
 =?iso-8859-1?Q?znQBPYxjfcKQAzw2SgFk5hc8YoUdZhqfIQ6show8sUTcIuVPevgQpzB5AB?=
 =?iso-8859-1?Q?iXIZYqOjjoNAvVWutbKqTH19SIv/cOyavi/04doa3pnLaiIZ4N1bW8lbf4?=
 =?iso-8859-1?Q?ivAnAgQMCIHMU+81qWx9LjgkUlzkJ7A+RBbsPRHW3K1k4MI2GjqVGaHTtL?=
 =?iso-8859-1?Q?IEkakQblwl8FzKQ+jj+iSnMaQxVl7H2x+2CHpZKoTun0Xsu2GAhc+d442o?=
 =?iso-8859-1?Q?IKr2xButA0qAhKJ1A/Vgc+5ICkID7qRoFtY5C+iD9lbwllayO7PTy9yxAm?=
 =?iso-8859-1?Q?ieclHBq83XRtrI4DawMTcgtwzTtofwsq3YnoUrCIXLPVuCHd6lwSHOhV05?=
 =?iso-8859-1?Q?qcTEAIqBaKG0Vn729F2coojFas5/pUTwNkWJ8xr98G0jFoIppIhhaHJ3mi?=
 =?iso-8859-1?Q?zM0bvC2caVym6hVAFtEnnIeN47BCz81X+MxafCvMpFDrwOhN0uoQv7aWVt?=
 =?iso-8859-1?Q?WXOMO86T2T7ZhKRg+I7m+t1Dml47TFgJo1DkUZUbe5lNXrbU6Mru+olro1?=
 =?iso-8859-1?Q?ivHeeIA9j24kE0DZv7JJXFoi0I93w7h5EDQ1iV/6GUabpuylfxMAn9ZuWb?=
 =?iso-8859-1?Q?31cKOY6Cw+fSwZbHNr5d9kmkT8hpuYfsbsPwarlQtdX9iteItU54v7QQ8c?=
 =?iso-8859-1?Q?8gKV1IEAKWVjbEZs25yNnPhT4b8zP9zt2bxr0W5IoFN2PkxvRMeMk0NA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e3eaf670-62e7-4849-64e3-08dc2ef3f601
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 13:34:11.8627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tsg5AdBMoxbzJ9F6MAOtGOoyAjUYREC2+HpEroh8t4tg59m3zHEP7gINnudHxAg1OZxjMTgk/vuuTTn0bSfAP5gZlOL9tWgfYdgH8sAxE7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4448

Hi Sebastian =0A=
=0A=
I apologize if I'm mistaken, but I noticed other minimal drivers in the cod=
ebase. My understanding is that using a minimal driver shouldn't cause any =
issues. Additionally, we can easily update this driver at any time, as we'r=
e actively updating all other drivers.=0A=
=0A=
Regards,=0A=
Bhavin Sharma=

