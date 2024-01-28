Return-Path: <linux-kernel+bounces-41483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F21F83F293
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BED1F22CDF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435351362;
	Sun, 28 Jan 2024 00:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D4YfpczP"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2076.outbound.protection.outlook.com [40.107.249.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694EE1109;
	Sun, 28 Jan 2024 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706401980; cv=fail; b=SoQPn/bz2CCLyh4WrMMPOl9wclOtpyFKVR7SBweZ8rig+U1UqqrwDgYCwlsMqkIAivDoAdRGji2nTQW4DuegfM7HqhOaW1T7Q4J9MTH2xBwNKOXHxq5ULFc90Ca5IPHbukIuTcYsVi1aCv2HnXsxpEfJlSzFyZUM0PiCPvmJnRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706401980; c=relaxed/simple;
	bh=9T0fkFYETNgtaggbLr7QAH1vMrB3JKplfM3RxizjhC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=utLvAvghOg4v3XsC0Ya5siX0jfvXByuXmI+LrA+jerXm6UP/IYQi5/EMki4efaKups9lZJXN+9lIS5RrtpnD2Z6Lsto+DxPUAZu3ROPN5vSN2R9Ntp0F3luHPkHq513i60ZYP22ZpRmaMP09IrKD+Qf3NY71EBdcBy0uKLwc2GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=D4YfpczP; arc=fail smtp.client-ip=40.107.249.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQfrY5Hvwov4psArMaz6c3i4VxVdMPy2/pC9I/jQblV0kLi5Qb6td5N/IpmrQ9dIqdyEaDpb5h2NeZe5CHmakMASjtm9MIZbqoTerRZTdDPzPxmR3sCLfKGvz2pZfApgND/g1EOQix0S12uNisHw97PjKe8b/a5TYaygvdZ54bdWqhUtQ2gk0FYTpncVmetBEi82l4mm0mzUz+jG7gDIV7dThuUAcpkUS9B6RRCTNIWUa0lDfZczWH02sjvlCxnhsT2hBwYw8b0cDz/wiOPlVUZE9qpho8I8pfAC9K1HJfbV7lEUI4vGf8uFfMGxTw1m2JR15z0AQ4sYJYup2q/Udw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T0fkFYETNgtaggbLr7QAH1vMrB3JKplfM3RxizjhC0=;
 b=LG0qCxFHjoWtbubz5nUHABuB4iOEaPXn1BPEfjr50ZhF/3cNY/RCiCk22xvcOFNDznoNO1eGd/2a8HmlIskIeN/wRaU8AvRVperarDgrr587PbPuyoesvgYpoReffAPGZXHcsXgeO2+dGiqLiSrpxyKF6EmmpWnr7L7QZNWaJY8uZF1KY9+erlTauPX43D5Tdslxx5G/kqGf+1U/XMxjVLVywMehxV1DnI7EAGsCP6N7uk6QDhrJUTmHHlrlpLSW8CWiMk2rVh60oXP5eel+hNTrQx31HyZIncgsFT7xxhVrCElTub2ZVSIYJXWIYIm4i+IjzBKAs0vD3R053Pm5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9T0fkFYETNgtaggbLr7QAH1vMrB3JKplfM3RxizjhC0=;
 b=D4YfpczPgPxjpczHED2Z2LT2MRQuu75oUF6E8Yau+McIWs/+rBeRMJWLHBvhGRy0MdIQIzfzHthKuFi4his/KNM0xXzvX/RSC9uZN7Cf/qtaAvupbY0Qz/55dIOdJNmZwtGYSuKdJwqFN4lGi6S9tLPQsLAUwnuIm2ekuNhc6Nw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9387.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 00:32:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 00:32:54 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: RE: [PATCH NOT APPLY v3 6/6] pinctrl: scmi: implement
 pinctrl_scmi_imx_dt_node_to_map
Thread-Topic: [PATCH NOT APPLY v3 6/6] pinctrl: scmi: implement
 pinctrl_scmi_imx_dt_node_to_map
Thread-Index: AQHaTFMqAPkIBcX0tkCmqwlZQjMx6bDuZbeAgAADvvA=
Date: Sun, 28 Jan 2024 00:32:54 +0000
Message-ID:
 <DU0PR04MB941773E509C09F9C951253DC887F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
 <20240121-pinctrl-scmi-v3-6-8d94ba79dca8@nxp.com>
 <CACRpkdaoBgcYToh2Za9k6gek=MX5Q1YZEoy+MrE-oL3t0UhJpg@mail.gmail.com>
In-Reply-To:
 <CACRpkdaoBgcYToh2Za9k6gek=MX5Q1YZEoy+MrE-oL3t0UhJpg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS4PR04MB9387:EE_
x-ms-office365-filtering-correlation-id: b77ad1e9-06ac-4c3a-f679-08dc1f98ab18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MN8LI4CeUo89HVymrGuggfqpzCcsmspj+wMs7s9sc6LVsJXLbNmIzWqJgeb3VbJxDJpAt6JWPvT57C/c4+3uQRPhv4uj6I/HZNA7OEKIbyof5HS58XkT1XFqYTPkJlFvnEPUe55mkM2GjfXIVDveR6S4Ae7+1x7mt1rfe7puks+nP8I4AV9XzCnw1eke7WbNFs8s6pkKdmd+WOxuyDe37hlftCWdPek8o0Gjisw32ibaa7H4Lk088mLqdWHR4NS+mcRqIuqwVB10Y4o7DPhN6kg9HYNePm28a7Zyopi7eQNUtwkQOR4iGJ83OusYgJw84sVMruKHMI+lQyaArbnpMEKHMZ9W2A1K4+4wAN7eVf8Bld5tv1SmjVkT5lJqIe5wPEe5eDuNsDCyXpmlJZNusiK100Kz/pKyMx8e26EUcP5ZbNYvKF24XEKez+ATWkxmoSWAmWgMP+bD2iAdDp0DkUhUXcgcfD8wP8Hodp74cE74R5a/3Z74iY6uBGFEkBx/9bSakouhofo5uDX6BCeTFG9lbCh/lgwS3KKpDQdKsyAZ0sy+JkgUw/GPTlv/H2ikJ4/g2dK+MBCsaGGZvil13MVkzkpWfFhvqkimI1v7CXrTAwQnbEHvxen7OC25O0K4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39850400004)(366004)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(53546011)(6506007)(7696005)(9686003)(38100700002)(122000001)(5660300002)(7416002)(8936002)(8676002)(4326008)(52536014)(41300700001)(44832011)(2906002)(4744005)(71200400001)(478600001)(316002)(66476007)(110136005)(54906003)(64756008)(66446008)(66556008)(66946007)(76116006)(33656002)(86362001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVVtVEt0ckFQeHkyT3NHOGduUGNINXhNUENtZitrYUFybHZYS2lqWFBaNkI2?=
 =?utf-8?B?c1dCa3dsWXVvdjJtcVJHanpiNWpKS0x0Vy9uRGk2ZGdqamU2REdOSnlONExD?=
 =?utf-8?B?OWpkbXNLS3VkSStxellXS3FkOHQvTFB5cDVRZ0pqZ082RFR0VHYwNEp0Nmt4?=
 =?utf-8?B?WVg4M3V6ZzJuemZBMDRwaHkwbnJFLy80clZ6WmVZa0p1cmV2bTR4UG5JMERk?=
 =?utf-8?B?Z2dqT0o1c1R2dUZQUktrYUE4VVpKUkIxemVEM3pBa2lYYVJVSEl6bmtzaWRN?=
 =?utf-8?B?cVNMVFlEK1ExZDJXUjBBMjRZbGkvYnlSUmhXS3Vsd3hySGZlanljck1ta2dX?=
 =?utf-8?B?YTNzd3pLV1dzYnEzMTJoekh5VCtwSW1QTm1uMnluZTJPeXlpN041NjI3dG1h?=
 =?utf-8?B?ZFQvMW00bVJ0ampvTWR0M0ZpT3UzTVdlUGtWam5XRUtlQ1VkSXh2UVJReE1P?=
 =?utf-8?B?akQ4R3plQnZDTUtMRS9QMXZMaTdzQ09PZ2hPZDNkMHJZVXRvcGhwZzh2aDlH?=
 =?utf-8?B?WVRpY3NSUmNEdzFIRDMybWZHemNlZHF4Z2txaWFqY1lveGpvbktSdWdVMHBL?=
 =?utf-8?B?b2dpbG1EbGk4TkVhYm91M3Z2V1Ura1psZG5XeDM1NVlDYW5EaUlrdGpJN2lQ?=
 =?utf-8?B?QmZ2c1JwWFBQWXRBcU9IUURmN0M5Zzd0c0huRTRLelJYMmw2enJxRCswbzYw?=
 =?utf-8?B?aGgwNEhnOWxrMDN0Q2M1Z2ZlQmNrWHV5b3pvWmdkN0JNRGZ3SDdPeFI4bS9W?=
 =?utf-8?B?WEdvNUI1UGw2Z1Rla3ZDTTlpNUk5MTRhZktsZmdxS21FNGsxWUJsci8yME1n?=
 =?utf-8?B?VFQrWW9LNHIrcGFDU1QvT291dmxxWHhrR0FPWU04ZjNZYitMNHBCbUFncUFI?=
 =?utf-8?B?RTRyVFRBRVZhdlZqZWcrcHZHU09qcG52d2I0VlU2dXNuKzl0NEtzL2ZmcSsv?=
 =?utf-8?B?VkdKWlJjbVhkY0g3SitNMGZ5ZCtJSmQ1ZE9FeWxDdVdHZCtHaDVNS1JmMjJp?=
 =?utf-8?B?VXgrMUhmL1BMN3o2Z0FFOThyZFp2S1ZORE8vMVFpM29Fd1lUWHZaMWtoM0NG?=
 =?utf-8?B?d0RzYmYvZ255K1pXbWNtOTlqaUExV2JaTG5tVmRpT0x1NFVXb2Y4TlhQWFJF?=
 =?utf-8?B?MWlmdXJLRkdPTE0xNThLMHJsT25LMVMyR0lBNGNjdEg0TXRXUk4wdTlFcVFq?=
 =?utf-8?B?U1VrcHVYUkM3dk42NkNwTlpWS2tDMlFjaU9vaFdzemZmemFIbm53N0FEcW1W?=
 =?utf-8?B?V05ueVRiYTQ3MGZabTlJWE9nYXNHamh0WjVNcHdVR2pyV3FDY0MycXNlUVEz?=
 =?utf-8?B?RDdLS1dlczI1SEdMWnorZ1pUWnBKZGdVYjliUDBYVDVka2VkL2c3bWtLRGtM?=
 =?utf-8?B?NTE3U0JWcTRDS21uWnFsaXltSmdTTThLMDhzSXJGWWJUVnFhYjBqdDEyRGg2?=
 =?utf-8?B?YjRnVVBOU0tnUjlaZzc3OHkxVHpPNGorbFNJTFpYTS95UldoTVlSRzhBOUpT?=
 =?utf-8?B?a0FSZ2VPcEhneVRXT1M2cXBOWXhCeGxQWGRON05uYzJNMTVVNTNGSjJwejRW?=
 =?utf-8?B?VTZkbkh0VmRRck1POFlWdE1TUC9TQVpNTlI0MGt0ZzlEcVV0VW96ZVpqT3BB?=
 =?utf-8?B?RWtDcG8zSkthWUxRWXdkbnJwUXp3SGp6QnBYUUt5R3pTNWEwOHZ4eVhKK2xY?=
 =?utf-8?B?VlA0a3VrYk50YlhrVmZ2WUkxNlVVeTVJMTVYZ2duNGRwd3lGekN1aUVoMUU5?=
 =?utf-8?B?K1NEcTFveng0cjBGZU1sQ2xWWCtQbnNkenUwYnFxdGg2ZVdaTVRNMGtnQita?=
 =?utf-8?B?VGFxTEtLV2hvbGpBNWk0aTEvTzdsbG1sb1dXYWVaSEdGTmdRa2FrK1JGOGxk?=
 =?utf-8?B?dy9ldTZUR2VNS0ZiSDEyaDI5elI1cGNkbnYxcU9TSDByWnJFUGxqY01pcWZh?=
 =?utf-8?B?M2NEd0c4YXlHN2JWRHByaWNNWUlpY0VUUStOZTNwcnAyanV6dFRLUTlHWGhC?=
 =?utf-8?B?MjBDYW4rQ1cyKzh4ZzRyUmRrWUtMMFdzWUloWUlaMXdZaHQ1SW5qTlI1M01j?=
 =?utf-8?B?YnZYTHFoNk9hV1pwWEI2eGpTeU0xcEtYcXVqamF3Qll2NTVqRGZPOTF1WGhN?=
 =?utf-8?Q?X0TQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77ad1e9-06ac-4c3a-f679-08dc1f98ab18
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2024 00:32:54.5552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F740IObw96yQAR2Y1TylbZxcumyjL6yKVXlKL0asFEfxAMhUxatGm+4m+sQa9e+89HCBTs7ONxM3bICbZ7/PRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9387

SGkgTGludXMNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIE5PVCBBUFBMWSB2MyA2LzZdIHBpbmN0
cmw6IHNjbWk6IGltcGxlbWVudA0KPiBwaW5jdHJsX3NjbWlfaW14X2R0X25vZGVfdG9fbWFwDQo+
IA0KPiBIaSBQZW5nLA0KPiANCj4gdGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gT24gU3Vu
LCBKYW4gMjEsIDIwMjQgYXQgMTE6MTjigK9BTSBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3Nz
Lm54cC5jb20+DQo+IHdyb3RlOg0KPiANCj4gPiAtb2JqLSQoQ09ORklHX1BJTkNUUkxfU0NNSSkg
ICAgICs9IHBpbmN0cmwtc2NtaS5vDQo+ID4gK29iai0kKENPTkZJR19QSU5DVFJMX1NDTUkpICAg
ICArPSBwaW5jdHJsLXNjbWkubyBwaW5jdHJsLXNjbWktaW14Lm8NCj4gDQo+IEkgdGhpbmsgeW91
IHNob3VsZCBwcm9iYWJseSBjcmVhdGUgYSBzdWItS2NvbmZpZyBvcHRpb24gZm9yIHRoaXMgZmls
ZS4NCg0KWWVhaCwgZ29vZCBzdWdnZXN0aW9uLg0KDQpCdXQgYXMgb2Ygbm93LCB0aGUgbWFqb3Ig
aXNzdWUgaXMgQ3Jpc3RpYW4gaXMgbm90IGhhcHB5IHdpdGggYWRkaW5nDQphIHZlbmRvciBjb21w
YXRpYmxlIGZvciBzY21pIHBpbmN0cmwgd2hlbiB2ZW5kb3IgaGFzIGl0cyBvd24gcGluY29uZiBt
YXAuDQpTbyB3ZSBhcmUgc3R1Y2sgb24gaG93IHRvIHN1cHBvcnQgaS5NWDk1IFNDTUkgcGluY3Ry
bC4NCg0KUHJldmlvdXNseSBDcmlzdGlhbiBzdWdnZXN0ZWQgYnVpbGQgZXhjbHVzaXZlIGZvciBn
ZW5lcmljIHNjbWkgcGluY3RybCBhbmQNCmkuTVggc2NtaSBwaW5jdHJsLCBidXQgdGhpcyBtZWFu
cyBhcm02NCBnZW5lcmljIGRlZmNvbmZpZyB3aWxsIG5vdCBhYmxlDQp0byBpbmNsdWRlIGJvdGgg
Y29uZmlncy4NCg0KRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zPw0KDQpUaGFua3MsDQpQZW5n
Lg0KDQo+IA0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K

