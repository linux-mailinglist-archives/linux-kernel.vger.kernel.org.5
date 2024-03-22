Return-Path: <linux-kernel+bounces-111274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC108869F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A05F1F25F50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB222E822;
	Fri, 22 Mar 2024 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="R42FV2ZY"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2122.outbound.protection.outlook.com [40.107.6.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA4E24A0D;
	Fri, 22 Mar 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102127; cv=fail; b=hbKloZiMydfyBId6055kzuzCL27/qGP+/n7KleL87dmknDbd/ats0l1lxXemperaWW6BFIQ+HRFbGgXBbc90oxfSQ2Y8cYitIbn65Gq636NSxdRnKYET9EsSnp68e7ddjVI4rx58iX/4v5s7IGxYVRf1D7E80yxhn7klK79EdO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102127; c=relaxed/simple;
	bh=46i0Cikq13LNgms1036L2RL0Qw08yw5fkPPtbQvp2hs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jlW8H1UHz8zqGb5dzNELvz/ctvdzTShcUuuRMZ/nUOZ+/0dNtvGNS72ZuTsNQi14KM0aKeT7ZfHiuxrMeTNU4Z3a2FDkRdOIOS9y166kVcfs4JoRREIS8Z0gm+zu+Yu+RN/rRU4jmFJMYZqW8ge7vwVKK8fcwb7CGwsehMWm7H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=R42FV2ZY; arc=fail smtp.client-ip=40.107.6.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVA10XUcnd4VtfWTNYk5DVYoUYTLmJrvPcm0pQAsqOjjRyGAwrONb6YeX5T3CiBa78cqXgvtpUGh8ZmITd0CranvWA+JwyHzsL0WZFMXrf8NXnW/aNAhQWdpjM8GoUeg6AmUWFD+QZ0fGmz7H8BWbI/uWmCxxSXKzEkdYo6ZVTaiAU9H9+/OBmFfs0+s3CxaTMTKiJVe+UplfLRsFa0JRabDoL5kkuQu8vXZlFSR3vQt1VPP08UzGztifd8tQ+Uv9iq8AH+SaWQ6EiasEtaEXhFlG0Nslq7+oS8PDnsCPj+2CavkSaArlg1ywvQd78y5l9JabDOqB5ze4ivtfhVqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46i0Cikq13LNgms1036L2RL0Qw08yw5fkPPtbQvp2hs=;
 b=itRBND2VfHI9MQ331QQi0wX0QpbHfyHuWwxg9a7FM0Ms2Jj4Bl2Ka8VEAgkDy7UwR74DwOzJY/Ba9bItYZKlCPxTlaiNMxCU9d1urAouIG7Gj3fKb8T63rCHn9pmrdJ6VxvEwu4gG2O1t/QtpKyDw32YhJV2Gh5sLi4XSLdAKgfoc5tp0heRgkD/tadGjY3zSPd4Jei1de3UCe43tzjlgr2hosfG7nKismhiVaVvuMPUDiD7SiaiJ6iBxONAriYlKeTISBtIf2sT95wxsdLyDxO7yP05JdBQZ2Jq1Z6gU2GpMbUq2pEXwyHlVKbyvyN36sgyrjy+fERaPWAXAs9QRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46i0Cikq13LNgms1036L2RL0Qw08yw5fkPPtbQvp2hs=;
 b=R42FV2ZY8IDtuzh02IOn0NKHscLcx+hM+l6aEKtMjX4pSxilyowjfnutV6ZQ9yN4gICeuwq2rnt5lHuFYommi3Pze/0Q1Cs55Wo0vS6pMbXY4o+cRAZ4fVFEJ3ayuoxDE7xsItIe3ikjAdKtPs0qV2X4bzVT7Uk3BjfFr+bE3kU=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB8PR04MB7147.eurprd04.prod.outlook.com (2603:10a6:10:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Fri, 22 Mar
 2024 10:08:41 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 10:08:41 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	<gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
Thread-Topic: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
Thread-Index: AQHae9lZw/gIYk6zDE+73DiBF+lb+bFDiiAA
Date: Fri, 22 Mar 2024 10:08:40 +0000
Message-ID: <0f7ca0ed-a1c1-41d2-a1fa-27431d14c056@solid-run.com>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-1-711127a409ae@solid-run.com>
In-Reply-To: <20240321-cn9130-som-v1-1-711127a409ae@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DB8PR04MB7147:EE_
x-ms-office365-filtering-correlation-id: 829453f4-860d-4257-9073-08dc4a580ca8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Cy1jaWvd2IHu6CaECJCE6Zy+EXYlqR5Hg9uq7aEp/xveIONXjyPtezw/Lsu5iXak8mnCF04aA7IkFA0I4iCcgAtXhfoXu5Xn+2L5cuZKfSXzV+a2fMXUU6wb+pJwxe19qbo56j1FrwRIqhAEkkYVpCAwoSfoxUuLupOyXe1J1E+bTuohizA8ETgM/QBD8QW3+lgR8r/a2F+1UKP/PGywtGV1/7m3ktf4/tIQxVViyKn6Vz6I5MgaYIGrKtQcI1uVE2oLhzjeGyO7DHK7NnBhRmHZTWnpMd3pxYkWmJ5J29IT/UknWOqhMcWpQfMofXhe7zoTFM8PhL57OE5qFvaqdb3aACwLF21rYqd2UDHDRo5T45aU5OLzOF3KAd1Fi3easrQIVNDdGS1Y2hqW2fZUjRMctGPQoEbEwOE+xq2EQuWrdgzu8ZmBp1mb9n4FrJntZlWq+/wgH2JYsOeSEtWidWaxHen0DbuSIQZZt3UiV9qtImPt3rqryGmOT5VsEzvVOFhphXa3Xy9JbdXRJuwXRDRmQWNTUuDeb4Xi3zdJRCwnZuvMjxnsIxJvB+jr8b93D6G+QiPHgs6A70kWq/S0of8HjUgxJhoBW8BnogKl5bOiRXEbdYAGii1suGPd4LPh4rWlfr6S+VEGvt9QHzJHQ/bGnZkdkkFGwjMvTknMOa50Y7Dt2jvjYnS8J1GiOo4/qy0wlmT5vpI2kQkcSWaDCg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnF4SFdRSFkxK0prMHU4cHFhSHQwMHB6bmM5T3lKV3BBKzcrbGdjdGpQSE1p?=
 =?utf-8?B?bitsbkR6aEV2Qlp1anFnUStRQ1V0V0RDN1pOMG5GeElaZFh3cjdvbkFLcmRY?=
 =?utf-8?B?czJacFFjdWZORTkvZmZ6emFIa3BNK0ltcml5cGR2QWJxa2pFTDlRdFUyZkM0?=
 =?utf-8?B?dEpRSDNqSDd1cFd5b3VoRHJZLzhNK1hNSStuZWZXWDJaY21wY3Y4WjJQcTBp?=
 =?utf-8?B?Ly9HQ3JYK1RCcjY5cDdUcmFDNEYyN3IvSldzcnl0OTNIYXd2QjltNEdIY2NN?=
 =?utf-8?B?R2NTVjR0bkVQTEFhVkxjcnlkalZwWk9hODd2RWM5OTkvK1F2Y1kyNHJ0VUZR?=
 =?utf-8?B?NStNRW1mQUo5WTYvemRQMjZ0TWhJM1VVT0hMUlYrZ1RkNEhEc3Y1TW5WaC9w?=
 =?utf-8?B?a3pMS2dFUWs3ZmNseEFyTzcvMnpsQVFCb2NuakNCN0UyRmNaWFlOQi8rTEVx?=
 =?utf-8?B?ZkUvUEllMDcrWW5WMXJJVktEb2h0bGJUOG11bERRaWdWa29ZVjNvVTh3ME9h?=
 =?utf-8?B?UDBjK1ppcTF0Nkp2emZTQlhIc1h2Y0JwUGZtZlUrS0swRktMRStiMDVwOGVU?=
 =?utf-8?B?N1FhR29SMDA2alZmaVpYdUFsd3U4bmpkUWtlVDhPMDE3SlZGd3JkQXNteEtD?=
 =?utf-8?B?OVVRNG1ZbXhOeUdpdlJvRDV2N29vNGlGZFF4QVlJQzlBSnBQZDVHNTNhbHBR?=
 =?utf-8?B?RDNnaUwwOXROR0NWZHpyRGwvTjhmbENPSlIrY3RSRXZDUWJodUtURXJQbUUx?=
 =?utf-8?B?N1U5L0luTXRGbHNSV25LcGR5dU9GYmRPRGo5ZHVtVi81UG5zenhBWXNIbkhs?=
 =?utf-8?B?dzhNUHBwUW5lWGkyd0ZCc0JKTzhGa1ZCQXlxYVJ3aGp4bENKbGJsNmVsMEZM?=
 =?utf-8?B?d2R6ZUgxRmpETkJmTnRHSzhxbW80UlZxdysvei81VDF6NVdxbUk0N1dCMGVt?=
 =?utf-8?B?Rm5tRzNJdUE3TzZXM0d4TzRYeFlPeWVzb2pmb2l5d09JMm1BSkxueVFJdnVr?=
 =?utf-8?B?WXNrMlp2RGdHSE1pYXpkRzRZaVgzRFNWL3ZxTEt5L2MvQWk0MG9CTlV3eFJv?=
 =?utf-8?B?T0s4UXRTUGVEVGx2eS9jbGJEU3pKMGkvaWhjYzBKN2RmTDFQTzdvZHRKRnNy?=
 =?utf-8?B?OHBKeWRZbHQ5TXBoZFFGQXdvWUNZeVV5MFkzSy9xTy9BbzdHanR4ZnFwc0ds?=
 =?utf-8?B?UlN5NXVWVm9wM1ZGMUc0UlRYSmdVUGl1R2lScnp2T1VmLzZjMFBOZUs4ZGZW?=
 =?utf-8?B?WTg3REdQWk9QQVlPQkk2RVQvYUMveHlHMEtyS09hRmJCOWxYTUU3eFlBcUdu?=
 =?utf-8?B?dmdQQ2ZpVWVFQ0FDbDZOaWZkUUczalhFbXJRN08wSThiRjZ5VE14aFdXYzg5?=
 =?utf-8?B?T0dTeHR2Nzc4Qlg2T1FYd2szTzlJd09TVnM0VTJSb2J5RDMxOEUwUmFVN0JZ?=
 =?utf-8?B?Q1hud3hpZEhwa1VsR1JRaElMQlNGUHpmaTN4UmNPcUNCMkdpdzZKZTMrakl1?=
 =?utf-8?B?YmVSSUdMVUd5a3ltTWNabHIrQU4yK0JmZ2pRUlBZZXcyZG5zOGlSYndUUE81?=
 =?utf-8?B?RzVLUjVaWWZ6VE9WS25wZ0NFbm1sTGk3ci91UjZ3WC9rWmZYeHFQZjNsZklY?=
 =?utf-8?B?M05PVkZqRHBqc2JXaFFTZmZxdEdDQXl5a0JnYjE5em54cGNodTBRQXRDUyt3?=
 =?utf-8?B?bmh2a0RVN1NGeDBKNW9TWlVNU0toNU1JUFhyTVVPdGpJenJDOTczQmwxOWpn?=
 =?utf-8?B?dlVGRW13bFNYRXZqVkhncW1KYWpIWXk2c2w2VXdHZThJcjR1VHg3a2JVY1hE?=
 =?utf-8?B?YjFaN2FrcXRObmExYWVRRHF6R1VFNTFiYU54V0YrTU1sY2Nvb3pHTFlvUi91?=
 =?utf-8?B?bmprVktNVCt1UTNvNytKU0Y3WjhIdFdTZWQybUFKcVp1MkUrZTdSSVBTT2ly?=
 =?utf-8?B?NGNiUEV2RXQ1aVNJQTBnTUtJb2ZHNGw3cGVYZ2FRMStSWnNXdXdjYWtpc2hY?=
 =?utf-8?B?L29rWXFCVk5icTJoajVjci92L1lreS9GOTVpMy9qb0d4Wm96Ymk4WnVDR3Fu?=
 =?utf-8?B?UGlUd0VoOEt5d1U3NmJHTVRMbzNoQmVkb3U5VGRzbWxML1V6dmdKM0FzTDR4?=
 =?utf-8?Q?eZkc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF48447403A8244993F7A765D5D1040A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829453f4-860d-4257-9073-08dc4a580ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 10:08:40.9287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQkERuPi2uS+wj7iuvgBsrXpxUMP2fg2GdgSbgErG7p1ocdhK/Ftamah+kYWEXwBiQtgpDHZLLl7l1D6TdFYvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7147

QW0gMjEuMDMuMjQgdW0gMjI6NDcgc2NocmllYiBKb3N1YSBNYXllcjoNCj4gQWRkIGJpbmRpbmdz
IGZvciBTb2xpZFJ1biBDbGVhcmZvZyBib2FyZHMsIHVzaW5nIGEgbmV3IFNvTSBiYXNlZCBvbg0K
PiBDTjkxMzAgU29DLg0KPiBUaGUgY2FycmllciBib2FyZHMgYXJlIGlkZW50aWNhbCB0byB0aGUg
b2xkZXIgQXJtYWRhIDM4OCBiYXNlZCBDbGVhcmZvZw0KPiBib2FyZHMuIEZvciBjb25zaXN0ZW5j
eSB0aGUgY2FycmllciBwYXJ0IG9mIGNvbXBhdGlibGUgc3RyaW5ncyBhcmUNCj4gY29waWVkLCBp
bmNsdWRpbmcgdGhlIGVzdGFibGlzaGVkICItYTEiIHN1ZmZpeC4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+IC0tLQ0KPiAgLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTdrLThrLnlhbWwgICAgICAgIHwgMTIg
KysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tYXJ2ZWxs
L2FybWFkYS03ay04ay55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9tYXJ2ZWxsL2FybWFkYS03ay04ay55YW1sDQo+IGluZGV4IDE2ZDJlMTMyZDNkMS4uMzZiZGZk
MWJlZGQ5IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL21hcnZlbGwvYXJtYWRhLTdrLThrLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9tYXJ2ZWxsL2FybWFkYS03ay04ay55YW1sDQo+IEBAIC04Miw0
ICs4MiwxNiBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgICAgICAgIC0gY29uc3Q6IG1hcnZlbGwsYXJt
YWRhLWFwODA3LXF1YWQNCj4gICAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFkYS1hcDgw
Nw0KPiAgDQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOg0KPiArICAgICAgICAgIFNvbGlkUnVuIENO
OTEzMCBjbGVhcmZvZyBmYW1pbHkgc2luZ2xlLWJvYXJkIGNvbXB1dGVycw0KPiArICAgICAgICBp
dGVtczoNCj4gKyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAgICAgICAgIC0gc29saWRydW4s
Y2xlYXJmb2ctYmFzZS1hMQ0KPiArICAgICAgICAgICAgICAtIHNvbGlkcnVuLGNsZWFyZm9nLXBy
by1hMQ0KPiArICAgICAgICAgIC0gY29uc3Q6IHNvbGlkcnVuLGNsZWFyZm9nLWExDQo+ICsgICAg
ICAgICAgLSBjb25zdDogc29saWRydW4sY245MTMwLXNyLXNvbQ0KPiArICAgICAgICAgIC0gY29u
c3Q6IG1hcnZlbGwsY245MTMwDQo+ICsgICAgICAgICAgLSBjb25zdDogbWFydmVsbCxhcm1hZGEt
YXA4MDctcXVhZA0KPiArICAgICAgICAgIC0gY29uc3Q6IG1hcnZlbGwsYXJtYWRhLWFwODA3DQo+
ICsNCj4gIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiB0cnVlDQoNCkJlZm9yZSBtZXJnaW5nIEkgd291
bGQgbGlrZSBzb21lIGZlZWRiYWNrIGFib3V0IGFkZGluZw0KYW5vdGhlciBwcm9kdWN0IGxhdGVy
LCB0byBlbnN1cmUgdGhlIGNvbXBhdGlibGVzIGFib3ZlDQphcmUgYWRlcXVhdGU/IEluIHBhcnRp
Y3VsYXI6DQotIHNlcXVlbmNlIG9mIHNvYywgY3AsIGNhcnJpZXIgY29tcGF0aWJsZXMNCi0gbmFt
ZSBvZiBzb20gY29tcGF0aWJsZQ0KDQpEcmFmdCBmb3IgZnV0dXJlIGJpbmRpbmdzOg0KwqDCoMKg
wqDCoCAtIGRlc2NyaXB0aW9uOg0KwqDCoMKgwqDCoMKgwqDCoMKgIFNvbGlkUnVuIENOOTEzMCBT
b00gYmFzZWQgc2luZ2xlLWJvYXJkIGNvbXB1dGVycw0KwqDCoMKgwqDCoMKgwqDCoMKgIHdpdGgg
MSBleHRlcm5hbCBDUCBvbiB0aGUgQ2Fycmllci4NCsKgwqDCoMKgwqDCoMKgIGl0ZW1zOg0KwqDC
oMKgwqDCoMKgwqDCoMKgIC0gZW51bToNCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gc29s
aWRydW4sY245MTMxLXNvbGlkd2FuDQrCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogbWFydmVs
bCxjbjkxMzENCsKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBzb2xpZHJ1bixjbjkxMzAtc3It
c29tDQrCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogbWFydmVsbCxjbjkxMzANCsKgwqDCoMKg
wqDCoMKgwqDCoCAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFkYS1hcDgwNy1xdWFkDQrCoMKgwqDCoMKg
wqDCoMKgwqAgLSBjb25zdDogbWFydmVsbCxhcm1hZGEtYXA4MDcNCg0KwqDCoMKgwqDCoCAtIGRl
c2NyaXB0aW9uOg0KwqDCoMKgwqDCoMKgwqDCoMKgIFNvbGlkUnVuIENOOTEzMiBDT00tRXhwcmVz
cyBUeXBlIDcgYmFzZWQgc2luZ2xlLWJvYXJkIGNvbXB1dGVycw0KwqDCoMKgwqDCoMKgwqDCoMKg
IHdpdGggMiBleHRlcm5hbCBDUHMgb24gdGhlIENPTS4NCsKgwqDCoMKgwqDCoMKgIGl0ZW1zOg0K
wqDCoMKgwqDCoMKgwqDCoMKgIC0gZW51bToNCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0g
c29saWRydW4sY245MTMyLWNsZWFyZm9nDQrCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogc29s
aWRydW4sY245MTMyLWNleDcNCsKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBtYXJ2ZWxsLGNu
OTEzMg0KwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IG1hcnZlbGwsY245MTMxDQrCoMKgwqDC
oMKgwqDCoMKgwqAgLSBjb25zdDogbWFydmVsbCxjbjkxMzANCsKgwqDCoMKgwqDCoMKgwqDCoCAt
IGNvbnN0OiBtYXJ2ZWxsLGFybWFkYS1hcDgwNy1xdWFkDQrCoMKgwqDCoMKgwqDCoMKgwqAgLSBj
b25zdDogbWFydmVsbCxhcm1hZGEtYXA4MDcNCg0KDQo=

