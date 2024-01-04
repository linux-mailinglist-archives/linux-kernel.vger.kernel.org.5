Return-Path: <linux-kernel+bounces-16475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D413C823F1C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D845B1C21622
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82D020B06;
	Thu,  4 Jan 2024 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="YOAZMOZN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A171208DC;
	Thu,  4 Jan 2024 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR6RCIThRKXnuLppnLDoWLwinw/MLVrdoW4qkr2DjlQRq6DV8Bnjn/uioxgQi8qfFv2NsC8Y+Ig8wbG7gQOQNxm1mYs+2Itjda8f4gU5S76yvi0MZc3XjzHcbpFFbEdH+6vTzumjwaXtsRrq2qdu2mkjeWMTq3SA0kUfH038+D9/R9/NHrAL4Kr99ruCht2u/CJy/dav2xOsLi/dkYsTEJwVx4rOvD/zLxqvBHleWe7MuRgz1nHWxPLvXYrbyxfAX0wUlh1OaablQoO2s2VZRwqTHC4eDF9e7MW5bHQUi9ZMBKMYPziBDSaZ37ZE2zbKwsWz+Mm/NNo/bm4PRzwS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcSStzVXS0eeoEhqCv972dImqJOIdLWPFcyfuWpZnY4=;
 b=FwXfZl9NtwSNTMXu3JMS1IO7Vu0IGAQAkBBYxdGOCcQXFzY+eS/cpIdsHP9n9UL3DVg/S7nIPyscj51lI4W72nKjJ8V2fj9Dg7q7NZcsas3AFD18JRRcOa2Y6lvTgCmwkR4lFszir14AEJm9gSSUIKlJK9fquy9pUq1NAjEcmyehH6hdXGG23GQYGyYuacB7iVPMQxiJd112g7eSXX1HVe9luuBs6GtUi51dv2+6SXLp+Im2jQbR116sBEsRuTW3jAVGn2qYtcz2ElYGnF6ikCBmyGYOfYPMmEwAy+GvXGVDPbOzz0cQ8URPj0TwcW5l6kLfaBXpBB+371ILcxNCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcSStzVXS0eeoEhqCv972dImqJOIdLWPFcyfuWpZnY4=;
 b=YOAZMOZNkMp9vW8AnHs33/GCL4GzP6CALwYOVsnIo1nHft5omIxjxGbi7cfCFGQzgX/Hj8BG4Jb5hubifWa/JtfjLYEukux6V0k3a7z0A9YISxX2HGIHoupIWfhfDekR0SquiwAQvr7b7XBZvzpmedcd3EVb9+8r0DJutDrajMA=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DU2PR04MB9113.eurprd04.prod.outlook.com (2603:10a6:10:2f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Thu, 4 Jan
 2024 09:57:08 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 09:57:08 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] arm64: dts: ti: am642-sr-som: enable iep for pru
 ethernet ports
Thread-Topic: [PATCH 5/5] arm64: dts: ti: am642-sr-som: enable iep for pru
 ethernet ports
Thread-Index: AQHaPjfRoZLwfzdb90akAoBOiBF63rDJSjaAgAAiG4A=
Date: Thu, 4 Jan 2024 09:57:08 +0000
Message-ID: <515550cf-cd28-4a68-b7db-7d4ea9f26fc7@solid-run.com>
References: <20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com>
 <20240103-add-am64-som-v1-5-dda1f9227aef@solid-run.com>
 <121b9310-3008-48b0-9393-26033250201a@linaro.org>
In-Reply-To: <121b9310-3008-48b0-9393-26033250201a@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|DU2PR04MB9113:EE_
x-ms-office365-filtering-correlation-id: fcfa8590-77c3-4649-38ee-08dc0d0b8367
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 l/2sI9GEfm5w6NZizO7QqxUhDXX0yLy/UzbFKLcvdcdyuI2yrGDjrkQlB78sq92kAfQanSzlMIv8C6pQ3KDPBlClTPcwDC2aDMHgbeD3+fYl5LBiB5oGGIg6YoMTVf4US21JFN6fd4q1siAJknRmkoI5Eq44y/4UE81FjLyACM8k8+kFdY6bpYERquYmVsTlRwVSR1kljq0SLDioN5iPI5PF8lcJ+1lxqSk7IV8UfhEj1S7OcGaHnA3n68rokFMStYQbtPG9mHHOLLYDSdg+DIaTA+M6Z9/8MCyhGNS1/Jo6CKCV+lscVpZONewFQ/sa9R/1lX1GqrQqq8FsdRJsUu7sCmtrh2hcNN++tS91CSn/62Ku/TJXdgIhB80PzAaqvfbyicZ9Tu2HJ4iY8roLlYxaRWDjoKCQ4ftszRGC/OVYUzkymkyedfMCrp2MWF/CA0HGpTVLpIe6+7ODCGke6vLSfIN/Hqp7Ru3W8mk6SqJVSki2ONTU0EBQNG1UBEnNQeiRXvdT1AJkiChDCCJG1USXlHIRcqgypO9gy2runuRSWQNQrpRgneQoVw7XgM+cixd4RudE0BPaGi3WfRkwPoajEaOb93zMu7iNYkxFYi2F9Qwe16v80HmYy8r0Uf3axktmMk1B8iv2gg8Ui6Aqyg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39830400003)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(122000001)(38100700002)(31686004)(36756003)(83380400001)(2906002)(5660300002)(71200400001)(6486002)(53546011)(6506007)(4326008)(6512007)(38070700009)(478600001)(91956017)(66556008)(66446008)(110136005)(86362001)(64756008)(76116006)(66946007)(66476007)(41300700001)(316002)(2616005)(31696002)(54906003)(7416002)(4744005)(8676002)(26005)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnBpNVU4ZmNIamhwZmVvdS9jMVhJcXNpZjZYdHB2MXVzUFlGc2ZTeGlIZmx6?=
 =?utf-8?B?MHhLSm8zWE9nSFp2dTBvUytoaVJTZmJ2RXlqTXl5aUsrQ1RQakQzdTdjRXo2?=
 =?utf-8?B?anZnTTgrV1hwQ2VnVVU0dHRaN3R6eERaTGJ3S0l3MUJZOVVCZnZPekpsT1BF?=
 =?utf-8?B?UW9YWUR5VXZRUzNWL082NktFcUhpeTJnUFNkaHpEMmFvL2VVWjNVZGtlbm1P?=
 =?utf-8?B?NkZRN3RFTXR4Z1owNG53SXR6TitBUlFwck9rYVRSR2JiY0pqTmJ2cDhDVVox?=
 =?utf-8?B?ZlpEQ0xvL3VMWC9wNjNtaVJ2OStPdG9YTk9LY0xWSXZoSlpUK0dSZFUxTWVs?=
 =?utf-8?B?YzZuaG1mVm4rM1J5RTBZZVNhZVNqMFh5cnpIUW5yeVNhSEFQbjlsd21LaGE0?=
 =?utf-8?B?em80L1RtS0xIN1VhcTdGOUV4MmVZMEFtZ3QrOVZqaDIxRC90aXZuZGlTUVB1?=
 =?utf-8?B?L3IwOU1GQzdYZlZLaWtlTjBzK3REaVRiQjRHd3BKcVFDdDhJUUlzZU1EK0Np?=
 =?utf-8?B?VHl5bHp5NEFJYk9IR3JiOG1aZVlOVWhVT3k1SXpjSFdSUk5OaVg5WjV0K3JG?=
 =?utf-8?B?SVMwYWR2OXJDOTJMQkEzSEZ3bHdqVHNJaElqZjZGOGpXU1FMT2NtcWJLOVNJ?=
 =?utf-8?B?eVFCdDUrMUFtRWVQVzJiSTJaOWlXeVhoQTFxY0paa1hsM3haMGMralY1cFJU?=
 =?utf-8?B?Z05sSG1YemFPT2VtcXpNaTFmb04remZUK0hwSnpkZjBaNnlvQTdvUHJvbVZ4?=
 =?utf-8?B?VEdLa3EvWUxTQ1BtS2pJZEJyZzdlT01VLzlqSlk4VXgweFNZUnBwcStMbDd2?=
 =?utf-8?B?ZXN1Y3MxTkJqc2hJQXF1Y01PY28rV3U1VEpDSVNFaGNNVkd4V1lsTjUxRmF5?=
 =?utf-8?B?L0FzRDRzNjZ6eW4wM0tPVHVGNW9YRGJjTXk2NUdDcUpWYy95Zmgva2YxR29z?=
 =?utf-8?B?MG5XK0Via2FGTHdrL0xteUFCajZzU0pEZXBOT0RXdWNEUUVQRVFBTmVNL0M1?=
 =?utf-8?B?dUFoWkg5N0JrUWlMeWsyNEtzTS8va05oZnRXaXFQTXVXUHBQMGFnSUY3eFh5?=
 =?utf-8?B?TmQ1a1dYdWViOFE4cUlvUlA3NURXc1g3V2ZaNk0zWHRydEd5OGU0ZDdkU2tq?=
 =?utf-8?B?alVsZDlPeW5RTFZDRjVnd3owYnVhZTVET0U3WG5vaFBBQXljMEg3WFJpaWcv?=
 =?utf-8?B?VnB6S052a2lSSVNoMGk3d1NsTzBmMWdJVEpOazNvUlFvSWJ4amVwbWt3NSt6?=
 =?utf-8?B?MTFiY2pOaFNlY3Q4NE1zRCttczFmZjZ1OW4yYXZ6NUdwUHVucGNVSFR6Q3Ba?=
 =?utf-8?B?TlBTcFNTNE5TN252MXgvbE42aUY0OTN1OWVuemJZaUZ0L2hxWnhEY1M0RHFi?=
 =?utf-8?B?WXhvN0xxL1dOb0dsSVo4ZllrUU5NT05mTUFyajAxUmc5Vmt6NDR3d1ZXUGhT?=
 =?utf-8?B?QzdPempZeXg5bGR6M28xb25nVXNybG5BWU1rbmw3ckJMY1M2N0RVaXlwT0E4?=
 =?utf-8?B?dlFLWC9nUWhzTTlpRGFGNnRJSmpwQkJCeDZwaVg4LzdSNFB0Q0Nvc1RNcW5Y?=
 =?utf-8?B?akE1ejcxMUUzVlFESlVPaEJQODRjNzBCTWpZcndTWWpPVW4rRXMxdHVVS3dG?=
 =?utf-8?B?cTAyYmpveFdJdk9zVGNGVWUvSkp0QWpiM05aTUtLVERnSzZWSG5PaXBrVWRm?=
 =?utf-8?B?RnZwbHJqVm1PSFhHU1JvNE04NjJjYVlQTVdnbVJReDM4Y3BEM0tKSndXbCtp?=
 =?utf-8?B?UEFHQmVLUzRDTTNpZGdHY3dUZEE5REw5dzdaUjlrV0ZhYjVIQTdUdmdHdjFv?=
 =?utf-8?B?eGRWR1lILzRMTS94S0d1T0FLTWozRm1yK1l1K3hRS1hZL0s2Y21WeGpRNU5o?=
 =?utf-8?B?aEJORlFFcHhReDFLNEcva1V4YU85NGl3cGdwclRGNHE1MVB3VEZoNE5LOFJw?=
 =?utf-8?B?Ym5jeGNaUnRCemYzOFhPR2l1QjFndUlHSjhkYWNOT2IxRWFiKzNHNW9UMmhm?=
 =?utf-8?B?UHltTlNPc1hLWjc4SHR6ckpXOW9TZlBnOHd3MkZER0tpMTl5UUlUTys5aXNF?=
 =?utf-8?B?NEFSaXNJenJvR2ljMGs3d2w5R2NpN2J0T25JZ095RXBuY0hHRXhGQmRERDZv?=
 =?utf-8?Q?bX170vdE+kbu2Jz8kI0GRU8jV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54CE41BFE7CBBD419568F7ECC957EB92@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfa8590-77c3-4649-38ee-08dc0d0b8367
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 09:57:08.0133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KnNDTSwdawOSJXBOkep6brqIzNwyTnwvHmbHMnXVcnQw4O5tJZkQ/7suybq7xSpAnyryR5skLbvjWx/L+V64g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9113

QW0gMDQuMDEuMjQgdW0gMDg6NTUgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPiBPbiAw
My8wMS8yMDI0IDEyOjI3LCBKb3N1YSBNYXllciB3cm90ZToNCj4+IEFNNjQgU29DcyBoYXZlICJJ
bmR1c3RyaWFsIEV0aGVybmV0IFBlcmlwaGVyYWxzIiAoSUVQKS4gTGluayB0aGVtIHRvIHRoZQ0K
Pj4gaWNzc2cgcHJ1IGV0aGVybmV0IG9uIHNvbGlkcnVuIGFtNjRzIHNvbS4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4+IC0tLQ0KPiBX
aHkgdGhpcyBpcyBub3QgcGFydCBvZiBvcmlnaW5hbCBzdWJtaXNzaW9uPw0KDQpJdCBkZXBlbmRz
IG9uIHBhdGNoICM0IHdoaWNoIGlzbid0IG1pbmUuDQpJZiBJIHdlcmUgdG8gcmVvcmRlciB0aGUg
c2VyaWVzIGl0IGNvdWxkIGJlIHBhcnQgb2YgIzIuDQoNCnNpbmNlcmVseQ0KSm9zdWEgTWF5ZXIN
Cg0K

