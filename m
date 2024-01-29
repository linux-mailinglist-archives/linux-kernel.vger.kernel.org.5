Return-Path: <linux-kernel+bounces-42328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C64E83FFA5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BDF1F22008
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED46537ED;
	Mon, 29 Jan 2024 08:07:56 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2066.outbound.protection.partner.outlook.cn [139.219.17.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DBF52F94;
	Mon, 29 Jan 2024 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515675; cv=fail; b=d5xJ3PsKzst9JYpeqgtdMOcJp84EGVwOfREg0y7EcMwlAbXC/MA0VXOXPi1B4B0KQPuqs+RzjqafeMOXW2UV+bSwdNakSATl7Hlitde/61Bg2zuuutyEnUj9jUzgA4iIVfn8fLgNe0glhWooDCfoT8K8EFX9YpouKKhN4CAHWAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515675; c=relaxed/simple;
	bh=+yU6wCtYlo4M8AK5uRx8SOC8YQKR9QULT0b4IvRM/Sw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLBTO38cd7WlbpGLRnXAvO5fEHWYImYcXMHMmMAi44KiGlmYNKnAAroTnk37jXG3mh/vfh0HJl1h8gChRhXW+4EET3hbulJlo4a8fvLtgAqWX0Rt1AYkNeIkRRAdqfJRX+Oho6OMK4JnVc/E0UD6h+syv0SLhwJjttmXla7eQAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjzjaM+kJDAgnYfi6osyfrdL6jJrHIBMYjZcuSQj2AEPx2Z8JnoJr1aFgnqONAb5hi/4spCz8Aeqlj+LKs5ROWevYiE2qYcoW/IRLHec2C9EJXSbs22+Z+SSMItokxi6HVF5SKSKOcJSRL0imyFYITktqpZaILAZjDum600/D4cdavT2L0wuaoxZ+C5rKGGJIztdtpmZ6n1Nef3O8HWGomnHCeHzAZcolKllCINs1dv8gUkHJj+SKTukCFElIgR+AMzXaFPI2iRJ0Rec6FZQKmIj7nmZEKGJrH9FA5XFpI3vJdeycQEBWWeuxSQBbn+LpwwXXZ5wku7LQgj0RYEPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yU6wCtYlo4M8AK5uRx8SOC8YQKR9QULT0b4IvRM/Sw=;
 b=lwRGxs5JwZhX+9gT9bE9z/rZhEkgysr6zNsYSH0c5cx424gHR8Mu6dUSQtSAYlY0oGA9e2rSIS4JWc5UiitDJlj5N5wTo0RHA1b34q21yI9T7ioJVVF7SUYmDBhQws9jYgWC4bEdLNrmb3Syw5VuAxo0jmwsTw5zMK4nfDDLNqzNVa8sLeEM8R8HMnpNUlhsfr9IP8qCVcYekWg3IFhwBCXqnbeazDpyK/pwjCUL5V6mZyu6Syrv6T1zeZ1+WFo1ebSFXHgouK+Nvh8SxIzCXACx+S/lHK7mG68KPEMuYxmbdwTpNbFkr68Q35kpSryr9W4nyeDWJKWFuZ7imrCBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1304.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 08:07:50 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::a5c6:9ab0:d20f:cb78]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::a5c6:9ab0:d20f:cb78%6])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 08:07:49 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Emil Renner Berthing
	<kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, Wolfgang Grandegger
	<wg@grandegger.com>, Philipp Zabel <p.zabel@pengutronix.de>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: RE: [PATCH v1 0/4] CAST Controller Area Network driver support
Thread-Topic: [PATCH v1 0/4] CAST Controller Area Network driver support
Thread-Index: AQHaUmEJuS1ELIQV10Sl2BziVX79G7DwbOcAgAAAc/A=
Date: Mon, 29 Jan 2024 08:07:49 +0000
Message-ID:
 <ZQ0PR01MB1253323CA8F8173D98BDD3949F7EA@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
References: <20240129031239.17037-1-william.qiu@starfivetech.com>
 <20240129-gills-excitable-01213b5b28eb-mkl@pengutronix.de>
In-Reply-To: <20240129-gills-excitable-01213b5b28eb-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1304:EE_
x-ms-office365-filtering-correlation-id: 153effd9-3d58-4c8e-5497-08dc20a162c9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 44pOvGd56g7FLYoNsiD4lv8AfUqRQJOPx2LUX0NuV9EwpLjJaMl3q3dnubAlMioEuPvaANBpdh9CoJHIkdHvMfQv66deLqdokcmIbwv5dBq3Fqh7iRKc8dq51E4Zy5tUwU9CDPPz22viW38e9dcG0k/iS4tAttBMb+cgkEO0S2z3zMmQeMyxFbbSTqINh0hgol5LfUH7OAkkXwcIC7In4FcuizQBzolp6bxcpTSFO7mOXTbISsVIV21/Ua7vFWFPFn0Hs3OePFyDiIzSAzCB/zp6dkoO22DsckA8+DnU/Cx5xuMb7plJpjPQXDMcIsCHhpC6FvuEztyDXjObs6hL6BJ8lj1JDEdXKqLSGNMenJPmXguPJ8Ul24+FuOd4ndDnKYqyWxClx7ULszIi4qnr6p9Jaq9yFHpd7bQubPNxnjZTlUeNbCJb3l4k16FURCz0NbeWdve5JUz+rFzgvqMmhm5Re8ddoVkXJbF9dUTbl6/eoB9SiTRN2ZemGcwBE79zgEy/N/0NvhXqvisqoBrwC9F9BczFHZraVeHYWGQvShXJxLcjKk/g+n+fQJ6LLlgm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39830400003)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(55016003)(41320700001)(38100700002)(122000001)(33656002)(2906002)(41300700001)(40180700001)(83380400001)(71200400001)(26005)(40160700002)(9686003)(7696005)(508600001)(53546011)(6916009)(66446008)(64756008)(54906003)(966005)(66476007)(66556008)(66946007)(76116006)(38070700009)(4326008)(8936002)(86362001)(44832011)(7416002)(8676002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjNKSGFXejg2dkxFVmJPT1lmNzdzRDcyaDJOemRONW1lV0tNb0dFWE9jWmtI?=
 =?utf-8?B?T3BUK1N0QXUvaVc3bDNBa2hiS1dEYzRUNVFCbWZiS0U2eWlHT0JBVG8wU3pt?=
 =?utf-8?B?RDVtaTNjN2JkYlczRitWU3VxbjA1V1RaY2NHNUFHWGFZNE1ZSkNjVENrbVEy?=
 =?utf-8?B?bFJXUmhkTy9jRnZDeG9heis3NURDMHR3b2lkUmpGSEZ5clpFNUtydGFVT0ln?=
 =?utf-8?B?eHd2NmJMWjZyWVdnc3NYQ3hDMEZnVmtWK1NnWTMxT2E4ajQrRitSYnhLeDl2?=
 =?utf-8?B?c2tUb1VjVGJiNjZpNjMzM1AwcEs1YjhWOTBUWTY2QWRBemhPaUdKOHdLdUdh?=
 =?utf-8?B?OUliNGs2NFlJdDhwbmxaZ1lvSnpUZzdoSnoraWVTU1ZkeUlqQVJGYmc3WEZk?=
 =?utf-8?B?NzJFRDFyWE9vQktOM2hoYXVDSjZFUngrZGZHbzFRZGVUZmJVUkJrbkhPdjRj?=
 =?utf-8?B?TDJtTVBuK0hoTFpNU0UvaHczREFOOGU3cUNDSXhDSzhWcWlMTXp4QTNrb0xG?=
 =?utf-8?B?b1ZDT241QnUxYUR4eEtxNHh5aUExM1dhQW1HNVNQNlhqVFVkZ29LYW1TbE4x?=
 =?utf-8?B?SXc3bXYraVhhNWR0SWRrMy9oSG9SZVJ2U3lUalEyNEJsVWovNVR4c05TZFN3?=
 =?utf-8?B?Y1FMRmlQMGEwUFNWWmNMaUorcjRMYkZjVXhZSE55dmUzNTBRZzB6amIwdGxP?=
 =?utf-8?B?RnphSjBVbzhiOE9mN1ljeURxc2JVRHRlOXNlYnd2NHJtLzlJd0NHUCt3Ull2?=
 =?utf-8?B?QWNLRGNWREJlYzZuN0ZYaHNmYmRZWmlqeUVNa2gxa2F2bUFPQjUvdjVGR1Y0?=
 =?utf-8?B?MjJEK2wvSXdnS1pIYlI2ZWV2am50UjFCblZkVGdKc0xYNmJ1Uy9wa01DTnlr?=
 =?utf-8?B?SUJrYnprTmhaRzE3SkZyQlFIUDVPSWRYeWZ5b0hNTDBzVW5kb3d2dUdSaERw?=
 =?utf-8?B?ZXQ0YXE1ZUJkRGN1a3VVdUtOOE1oS1NEaCtBRmlWNlI4MmlreklmcXRMVXN2?=
 =?utf-8?B?d3hSa3JPT21aa2MxS2tEbWY1UFJDdklCeXdhN2phV2xYNFJIaWhTeGNVUHFi?=
 =?utf-8?B?Wm5UTUZFM1lUdEcvYThwdHNiRGc1dUUrcER4VStPWW5vSTduQWJueHdHZmIy?=
 =?utf-8?B?UnUxL2ZveW51TVZsNVd0VGdRRjZrSktTQzNZNXpJNDdHRE0zLzQrR1ZOQlls?=
 =?utf-8?B?SWIyczUxQ3ZxekhmcE9JLzNGZ0pZTnhMK290eXovelpCOTl2MXBvNElqaWZw?=
 =?utf-8?B?TnF1akVsRUUvVGNrZ0RkSU9nbk95dzg1cHZVMzlFR3h0Snd1UWlDUERsVlV3?=
 =?utf-8?B?eDNvMGhaYWZiaDF4am1BRFBHd2pqNnlhNnNYcUI0Nm5zc05IS2pobVFHdXNK?=
 =?utf-8?B?dnZ4cGJJeHBNbVI5VExRWDBGKzd0ZFBaMGdpQ2N6SGpoR2gvMFpVUE9NK05T?=
 =?utf-8?B?TW8wK2cxRFdDS2YrbGxGeU02MVNyUTVMNDlpRERHblo5QU5iQ3p0YjhGTWxQ?=
 =?utf-8?B?b2RyZkJDV01VWER5RlNhYWtKbkJqNDlLeWV6NXdweUhuZ1lxQllGL0tJSW9M?=
 =?utf-8?B?V2djSWNmbXdTeHhpcWNJSHdiQ0toYnRGV3BoSDloSjB2MEVTOXMvY1EzaER0?=
 =?utf-8?B?Vk5KQUhkT002NEtxV25hUUhxbXZYb1Z6MjAxcFFPYi9ESjNxUHNSRFhaaVg4?=
 =?utf-8?B?ZWZ1TTZwUTduR2FhV2Nzc3FNM1FmY0JWYlVTUWZoQk94MiswMjZ5aklMME5p?=
 =?utf-8?B?cUlKaG5TRHlES2VwUndOT25ZZWdJbEJxUlFFTFlzNVBXUFhrdDRVb2FUN1Fn?=
 =?utf-8?B?RjQ3eWFmVDNJc3hUSnptRVdJNC9IYmFhSUMzOW9uOUtzaDM5WjI0QkpqWm5s?=
 =?utf-8?B?WFQzd3R1elpTVzVNczhvV0RabWhjS3pXM0gxYnhSTmVXVnd4ZmhUR1J5aVEr?=
 =?utf-8?B?NTNZVmdXcXErVHJ3b3ZqT25aeXN2VXcrRDYwMkdEUVVTTkFqblArUGhLM3Bj?=
 =?utf-8?B?WHVsN2NlWUF4Q0tWTlBOUSs2THlNYWZ5WWxIMmpNR1FaVG0weDZieXZnSkVh?=
 =?utf-8?B?ME8rS2pWNCtaa0xQTUxGVTRMdXRTQ1BPcklQNElwVkVha002S2lDSHFBeU15?=
 =?utf-8?B?aFFsT3QxbU5DT3VqQ214MFROZEtsMmRoaUd3QjJxeGlGS0FVMWFnb2hLeFpX?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 153effd9-3d58-4c8e-5497-08dc20a162c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 08:07:49.8801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZbmsOF4A1vmSNzHg8jVBoGnrWHdM5xX0niDJj9aWctlZjoL/z0yZdbdgfVM2DpH9dDlGtoQe0urJOid9Hy+LYWtY1VdUFD9QP8I3IQZtjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1304

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjTlubQx5pyIMjnml6UgMTU6NTgNCj4g
VG86IFdpbGxpYW0gUWl1IDx3aWxsaWFtLnFpdUBzdGFyZml2ZXRlY2guY29tPg0KPiBDYzogZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5v
cmc7IEVtaWwgUmVubmVyDQo+IEJlcnRoaW5nIDxrZXJuZWxAZXNtaWwuZGs+OyBSb2IgSGVycmlu
ZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgV29sZmdhbmcNCj4gR3JhbmRlZ2dlciA8d2dAZ3JhbmRl
Z2dlci5jb20+OyBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPjsNCj4gS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29u
b3IgRG9vbGV5DQo+IDxjb25vcitkdEBrZXJuZWwub3JnPjsgRGF2aWQgUyAuIE1pbGxlciA8ZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMNCj4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47
IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbw0KPiBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+OyBQYXVsIFdhbG1zbGV5IDxwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20+Ow0K
PiBQYWxtZXIgRGFiYmVsdCA8cGFsbWVyQGRhYmJlbHQuY29tPjsgQWxiZXJ0IE91IDxhb3VAZWVj
cy5iZXJrZWxleS5lZHU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMC80XSBDQVNUIENvbnRy
b2xsZXIgQXJlYSBOZXR3b3JrIGRyaXZlciBzdXBwb3J0DQo+IA0KPiBPbiAyOS4wMS4yMDI0IDEx
OjEyOjM1LCBXaWxsaWFtIFFpdSB3cm90ZToNCj4gPiBIaSwNCj4gPg0KPiA+IFRoaXMgcGF0Y2hz
ZXQgYWRkcyBpbml0aWFsIHJ1ZGltZW50YXJ5IHN1cHBvcnQgZm9yIHRoZSBDQVNUIENvbnRyb2xs
ZXINCj4gPiBBcmVhIE5ldHdvcmsgZHJpdmVyLiBBbmQgd2UgcmVnaXN0ZXJlZCBjYXN0IGluIGtl
cm5lbCBhcyB3ZWxsLiBUaGlzDQo+ID4gZHJpdmVyIHdpbGwgYmUgYXBwbGllZCBpbiBKSDcxMTAg
U29DIGZpcnN0LCBzbyBhZGQgcmVsZXZhbnQNCj4gPiBjb21wYXRpYmlsaXR5IHN1cHBvcnQuDQo+
IA0KPiBJcyB0aGVyZSBhIHB1YmxpYyBhdmFpbGFibGUgZGF0YSBzaGVldCBmb3IgdGhlIElQIGNv
cmU/DQo+IA0KPiBNYXJjDQo+IA0KDQpXZSBkbyBoYXZlIHRoZSBkYXRhIHNoZWV0LCBidXQgSSdt
IG5vdCBzdXJlIGlmIENBU1QgaXMgd2lsbGluZyB0byBtYWtlIGl0DQpwdWJsaWMuIEkgbmVlZCB0
byBjb250YWN0IHRoZW0gZmlyc3QgYW5kIHRoZW4gcmVwbHkgdG8geW91Lg0KT3IgeW91IGNhbiBj
b250YWN0IHRoZW0gb24gdGhlaXIgd2Vic2l0ZSwgd2hpY2ggaXMgaHR0cHM6Ly93d3cuY2FzdC1p
bmMuY29tLy4NCg0KVGhhbmtzLA0KV2lsbGlhbQ0KPiA+DQo+ID4gV2lsbGlhbSBRaXUgKDQpOg0K
PiA+ICAgZHQtYmluZGluZ3M6IHZlbmRvci1wcmVmaXhlczogQWRkIGNhc3QgdmVuZG9yIHByZWZp
eA0KPiA+ICAgZHQtYmluZGluZ3M6IGNhbjogQWRkIGJpbmRpbmdzIGZvciBDQVNUIENBTiBDb250
cm9sbGVyDQo+ID4gICBjYW46IGNhc3Q6IGFkZCBkcml2ZXIgZm9yIENBU1QgQ0FOIGNvbnRyb2xs
ZXINCj4gPiAgIHJpc2N2OiBkdHM6IHN0YXJmaXZlOiBqaDcxMTA6IEFkZCBDQU4gbm9kZQ0KPiA+
DQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vY2FzdCxjYW4ueWFtbCB8ICAg
OTUgKysNCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXByZWZpeGVzLnlhbWwg
IHwgICAgMiArDQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgIDcgKw0KPiA+ICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC5k
dHNpICAgICAgfCAgIDMyICsNCj4gPiAgZHJpdmVycy9uZXQvY2FuL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgNyArDQo+ID4gIGRyaXZlcnMvbmV0L2Nhbi9NYWtlZmlsZSAgICAg
ICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiA+ICBkcml2ZXJzL25ldC9jYW4vY2FzdF9jYW4u
YyAgICAgICAgICAgICAgICAgICAgfCAxMjE1DQo+ICsrKysrKysrKysrKysrKysrDQo+ID4gIDcg
ZmlsZXMgY2hhbmdlZCwgMTM1OSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL2Nhc3QsY2Fu
LnlhbWwNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L2Nhbi9jYXN0X2Nhbi5j
DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo+ID4NCj4gPg0KPiANCj4gLS0NCj4gUGVu
Z3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAg
ICB8DQo+IEVtYmVkZGVkIExpbnV4ICAgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVu
Z3V0cm9uaXguZGUgfA0KPiBWZXJ0cmV0dW5nIE7DvHJuYmVyZyAgICAgICAgICAgICAgfCBQaG9u
ZTogKzQ5LTUxMjEtMjA2OTE3LTEyOSB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAy
Njg2IHwgRmF4OiAgICs0OS01MTIxLTIwNjkxNy05ICAgfA0K

