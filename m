Return-Path: <linux-kernel+bounces-90485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D9B86FFF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA0B1C232CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8627939AC2;
	Mon,  4 Mar 2024 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EgNa+tC0"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81246AD;
	Mon,  4 Mar 2024 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550674; cv=fail; b=irRXFk632RhJ62BTCZTPo1VA2oD2WHM/F6F6XA6I1JJQ/z2SiynVyTIEwFc0uyctJSWPkQrSNYvZBx4Gc5taDpCaorD8ElBEuMcPmMLugFNwcd51HwuzATo335V4lSx8IHmdnRS7PBfgxzYFLePLl2Sgr9smS7Yb1/nt3frCnpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550674; c=relaxed/simple;
	bh=+LHNtzM/ClSZEArj3a14WuxFd41a5PHEC4Axvn9wjCY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hKEobQqsOsAYqhUJjhdaIyZGGZb2Tmh1NaLw+T4IuwROklcNv4Z+mYyvw+3gby50OcJCngMwfvzAe8dsvj73x7ZXtIgbmDF5BEwD2nA1WOaTjSKpVRpMgzh8JXJnm8hYMVO/J2JSaiGsLy99bUJu/R2EoDVfmlvaFmXh6pgtKKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EgNa+tC0; arc=fail smtp.client-ip=40.107.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL4lsMznBAG6qg60zZAbhlCSAZ7i06xbkE5nEPSe07AcpmXqqg2DQ5Of7imtT/rBAvbGUQJo67UEQZLzZlqbhuTgQ/XlFOLGMp9ME7Z2tLtHR1RrOE5zKzvmTWnh/WVfEwGdPmCyCpJ5FMhyRCZt1k8UrffA4U/XU2BfTJFHGl6dDyfr7nM4cbVZ1ZUoyv/GFy6mn3QLWFqJ1GyKnTf3a1qc/MsPrdB2EwEaLWrZLalMws0EmeNnmd/UfFFtuG+bd8IqNSzHmo6B98n6XV83D4b5q9IgF86kVs0fizQCPD4QhZMy8zOgj9/kBgWv3GRCbSUTYhNRBUu/2QuKz0W3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LHNtzM/ClSZEArj3a14WuxFd41a5PHEC4Axvn9wjCY=;
 b=Q6vhOPHjxHYWlz4nMFyosn+yvSGH5L+h2v6RBLSrJqKjhq+JbW0R71nFUAxxpdmJ1VSxIHJl21IR/H9z5VF3RFjp4/oPkY4/M6fFvUy34MyftUsvQ9iyKg52Lc5KfXirN9EAIUO9zD7PYx9c0nlUj+1u9bvxD84yKq6pDdCToK3izN/lgoObm4JC6ojYueQPhX4QuWQzU5eAmC2YtPkDDJ6WI4slFhQKMlSAdVgDd+npAnTa2SC1qFb14tsdkOxnFQO8+oA6T9HB2x0bYaNZGDd8v/asJUoAgQwlXtRPk6BcJwiSoCUclfaLECY0jmWN1N1hwYry5gmWQY7+I1CktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LHNtzM/ClSZEArj3a14WuxFd41a5PHEC4Axvn9wjCY=;
 b=EgNa+tC0q2I7wYXv10DWqFGuspeMbwcgo++a0zJDpjw5rvJkn3nR/lGVGi+TA8CD+c4iy53BZ+VdUIIwnRKdanxOi/VpO8aWBt6QKfqGmvuX/iPUCaoYLhywVMFsVfhmB1HhSDNV3hR1y63qYFIYBMYeuLRaknu5WK/Imr9/NTc=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PA4PR04MB7677.eurprd04.prod.outlook.com (2603:10a6:102:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 11:11:09 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::643f:faca:24da:e9aa]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::643f:faca:24da:e9aa%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 11:11:09 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"robh@kernel.org" <robh@kernel.org>, Shenwei Wang <shenwei.wang@nxp.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "robert.hodaszi@digi.com" <robert.hodaszi@digi.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: avoid idle preamble pending if
 CTS is enabled
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: avoid idle preamble pending if
 CTS is enabled
Thread-Index: AQHabder1X9YMJ50WEuZehMzhpFcmLEnKz4AgAAEAoCAAD4IAIAAADiw
Date: Mon, 4 Mar 2024 11:11:09 +0000
Message-ID:
 <AS8PR04MB840424FBE77BB3A910FFA92392232@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20240304020712.238637-1-sherry.sun@nxp.com>
 <2e1b1eae2e9d3cedcd270e35cfcf8086b914b7ff.camel@siemens.com>
 <AS8PR04MB8404FEA637E51E3B258BC28C92232@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <CAOMZO5AUFsC87fivJ7UhLGpoqy+-rfSx8Jipp5QGjQ9uGOngTw@mail.gmail.com>
In-Reply-To:
 <CAOMZO5AUFsC87fivJ7UhLGpoqy+-rfSx8Jipp5QGjQ9uGOngTw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|PA4PR04MB7677:EE_
x-ms-office365-filtering-correlation-id: 509b3c6a-6e71-4fad-a797-08dc3c3bcba3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Jc6yNEbgxTfVVt+rWVslHrcYTWcPRbkEyAI3E33JzlCYInRPQLqkvvjbaLHVHDHHyH9ypYLZpB7+Y0pLsBTtCa9LGeEPFRxEqyEbCBmZ6Fa+igFM3JRKdqk1JitHY7LjmLE+WQvGyFMWd0NKIOgHgo4DRwxdi51Nk+nSRLAx48r3zEKRrzzYbGicB2K51AaFbQTX9JyeITFualjyPNVsaQxUCo1VPZipywyqZUavxJ3NI9eutWP9TZ2Rq/OUHTcjflUP5VRDb4IKg7Z37uGGwhriUsgMuQd9mY3y0u3NHA65RwmUwUFNQOYPtD7IDJr6dZxPXgn1/dRufM53TnBhPBKObG0Bgf+lTLObe3J7AA3exXdAZ1Nt7dg3GG7tiddkIRbLg3HoxDORc009nsYQ+BtD8PzKSPZqERdA9Efw9FdXI6zyKZf9UlRQOFUuZwKsg5bkJOicUdaOhP/2102sFYKx+xqwkgLyHgQZ1MI5nUUD6b9EQ/4HEqTbt+xyqou3UUvCHKITJbTGvhEpD1n91Vl9MsJR87gwtxpxLWwDFwLVt0GMY3Ts3Y+U4FGY2wiyX8S5EzH+T6aGjnboChXfup+Z5n18O8yfF2184eMNVKv/vkBvvQO6jZyUF7uVivLbEEUbqOju+iZevfYLk1eXT97gASD+gB48OXTu3F+vy5kxG6bvoyB8kdpbkf3x2AnEgOIvZqwkkRXUcMjsuPVHUchUB0AGL08587ZmgvLy/8U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWx1b3VvOGdIcW9BWDR3bjk0eXgxcmdFSmhjdFFnblRqVnR2V2dYM2dUeVRn?=
 =?utf-8?B?UmphbXRUZVpzekQ1VjRoWmZZOEp6Z2RrQnByMURrVEtoK2I1M01sSzVHak1u?=
 =?utf-8?B?NVN0bnNOdm1JVUZWSFN5RWZzYmNKUzJLaFhXV1RTSThEbmwyQk9kKzFnbTJo?=
 =?utf-8?B?c1BySUtWSzl2NlBVNlNFSXNlZ3l2UG1SU0YvRTUwN0dwZzVkQndBejI5TFpn?=
 =?utf-8?B?cXBIT2VFM09ZQWl1bDVkWkFFTE0zNDRGcng0c1M4amhJbG9zc1NTbXVldUpG?=
 =?utf-8?B?dzZINlBDYVhQWUkwa3RLQ0FoQStHbjZkcVpGYkMxUXFKdE5kZmhOTVE0bE5L?=
 =?utf-8?B?SlhUajQ0enYzam1NSUNNZDZiUGZyVW1zd3ZCTi96NGxFQjJEUzUrOENMMkt0?=
 =?utf-8?B?bnd5SGx5djEvQ1EzYkhpQU1WaFlwUFA4bXgrZkFRZWVLZHFpa29tWTFFSUJZ?=
 =?utf-8?B?aFBITzg2WjM5VDF6eGpzUnZBTUpLTXcxQlgzcWIzVjNUUG9NTDl4ZnJuMFl5?=
 =?utf-8?B?UXhSWlBsSERybjJLNzE1MEt0dGVkQ1FNL2R3dVNHdjZ6MDcydEdUMkFGTEdP?=
 =?utf-8?B?NHVWWjNhMWRSdm9oc1p4cHJxdStHaEJNeUhobWI5eEdmaWtvSCtoaHR4U0py?=
 =?utf-8?B?LzBRZXdVVlhlKy94d2NiQ01ubnVXbEw5YTdWVkhuOGhrYk9UcjJmSTM2Y1ZG?=
 =?utf-8?B?R3JnUXF4TGs4S1MvMXE0a0VHZ2N6YU1SQnE3KzA1U1NJS3JMeVQvdGpaN0Rp?=
 =?utf-8?B?a1ZxNjNiKytvTzEwc3FjUlExb1ZwOGt3T09ydGNoOFVTSWF3akxxYndlT0Iy?=
 =?utf-8?B?OTg3Z0x3RENJQUpza1ZjNjJuKzF2L0tQTGtmblFjNUhhejBrNjYweHFMRWw4?=
 =?utf-8?B?RGt5MVRPY2xma2RRazlFUitkRno4TTY4VnIzZWxXMlk3dEdPRW8vRmFlZVJJ?=
 =?utf-8?B?VHBxbktxT2NjelJwZDJ5ajNTNVNkaG1SdGNJUGVGbzhUZmZZdnZoZHM0aU1K?=
 =?utf-8?B?NDlWTndqZFB4ZjEvd1JrdUNCYzQzc0pnTDIrVDRMK0pLYWd6VWt1aVpHREVS?=
 =?utf-8?B?MjA0TkEzVkx4T0ZVdUtxTEtkY0l6NG9HK2hkVHdQM2FLalNsM3JjdVpkMm1t?=
 =?utf-8?B?d3VRT2JwNVk3SUhiTFFWYUF0WFg0ZkIwc1JyL3luVmhNZmNKZHlPYW1WbVBY?=
 =?utf-8?B?UDNaVkhSMHFRNi8raDROK2pvTWkrTmhtMFBjMm40SXpOMThvQXEyOUFvN0JS?=
 =?utf-8?B?NE5WbnhxUUh4dHkvb2p6TGdyZE1FUmJFK1J0ZGxqeVVKV0hPNjlxdUo1eXNz?=
 =?utf-8?B?MUFCRHdsbUdyNnlzcHFEYWMrd0tBeHBWUVcwanUrTVFDdFBFNlJXSUdrZm9j?=
 =?utf-8?B?amV1ZnRDZDc1b0ZicU5yM04wS2dNWkVZUFBnQTh1alJ2eUF0dDA0M2RTMkwz?=
 =?utf-8?B?c1JMMDF6VWNWZmVBNnVXa2RXdDhWclFOeVlwdFU2UG9DZkYzTFpqU21FUDN0?=
 =?utf-8?B?Nm5lVDd6WUpGZ0hTQ285VU1oN2MvakRYOUtib2NETko3aWR5aUQrM2dsTHhY?=
 =?utf-8?B?WFNmRWE2ck1rYVI3VnoyMVE3YXNUOE1QZGJYTmdOMHkrZ3Y3aVNZVTc3ZHNX?=
 =?utf-8?B?QWJqckg4eWZKK0pmb2J0cnZKTkYwNklRODFJKzNWOG52azFaZnV5WkZSb2g3?=
 =?utf-8?B?UjVydzkxZ2VvNDJXWHBNbGxrU2FuZjdFSjBVREdycU5ndlF3ZUhXKzFxRnNR?=
 =?utf-8?B?bXhNQzB3cnFkRExIQmpwV0JqM21FQ2pJQS8zSkRpNGNVNlk2KzZQeDNtQyti?=
 =?utf-8?B?dndJYkJLdmhNMGsxZ3ZsTVlWemlhMmNTZ29OVDMzWHlNbzRSNzE5bUVuRlg4?=
 =?utf-8?B?UHVINTZkR1hTOExqMFhuRTBmcHVaM2NMeHBPVWFOZ3BLUDBFQlI1cnBTUitq?=
 =?utf-8?B?VUpXNkNwMlNEdXc5LzdWZVNrSGxKZTVmTE1XaWMxc0o0N3dKU1RKc0p0UnpQ?=
 =?utf-8?B?VU5CSHc1MGQ4NFFzL3QyUDNXOTE0aUJrSDR1TjZ4TFdOc3lXbFdndHgzaU5v?=
 =?utf-8?B?ZDA1SjFoeTNzT0dzS0VueFA4ZnRIazUvaGhvZz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509b3c6a-6e71-4fad-a797-08dc3c3bcba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 11:11:09.6694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXU+39XIev8SsQ9tIcB6zM5tfBSIUt2o95+RIeZlB+M5eT2Vm/AyFz7rx/GyPAwhJe0h5aKAibl58xeV1eXwHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7677

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSA8
ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDQsIDIwMjQgNzoxMCBQ
TQ0KPiBUbzogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiBDYzogU3ZlcmRsaW4s
IEFsZXhhbmRlciA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPjsgdS5rbGVpbmUtDQo+
IGtvZW5pZ0BwZW5ndXRyb25peC5kZTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7DQo+IGls
cG8uamFydmluZW5AbGludXguaW50ZWwuY29tOyByb2JoQGtlcm5lbC5vcmc7IFNoZW53ZWkgV2Fu
Zw0KPiA8c2hlbndlaS53YW5nQG54cC5jb20+OyB0Z2x4QGxpbnV0cm9uaXguZGU7IGppcmlzbGFi
eUBrZXJuZWwub3JnOw0KPiByb2JlcnQuaG9kYXN6aUBkaWdpLmNvbTsgbGludXgtc2VyaWFsQHZn
ZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBhdm9pZCBpZGxlIHByZWFtYmxlIHBlbmRp
bmcgaWYgQ1RTDQo+IGlzIGVuYWJsZWQNCj4gDQo+IEhpIFNoZXJyeSwNCj4gDQo+IE9uIE1vbiwg
TWFyIDQsIDIwMjQgYXQgNDozMuKAr0FNIFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4g
d3JvdGU6DQo+IA0KPiA+IEhpIEFsZXhhbmRlciwgZ29vZCBjYXRjaCwgSSB3aWxsIG1vdmUgdGhl
ICIvKiByZXN0b3JlIGNvbnRyb2wgcmVnaXN0ZXIgKi8iDQo+IG1lc3NhZ2UgdG8gdGhlIGFwcHJv
cHJpYXRlIHBsYWNlIGluIFYyLiBUaGFua3MhDQo+IA0KPiBQbGVhc2UgYWRkIGEgRml4ZXMgdGFn
IGluIHYyLg0KDQpTdXJlLCB3aWxsIGFkZCwgdGhhbmtzIQ0KDQpCZXN0IFJlZ2FyZHMNClNoZXJy
eQ0K

