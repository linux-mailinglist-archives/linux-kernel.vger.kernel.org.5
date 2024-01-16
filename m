Return-Path: <linux-kernel+bounces-27419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513E82EFBA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B942A1F23C43
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3831BDC6;
	Tue, 16 Jan 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="PDWeMjNM"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2081.outbound.protection.outlook.com [40.107.14.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF81BC5A;
	Tue, 16 Jan 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4eAf8Xed8knpB2Pbwn6hwxOHY3U+51TdP9dLZkQuZsn8kPmwZ7MyqU3u7Uz907DoWLuDrcVAtCOLPvTzI9Sz58V5Mesk/s3zeQtF9HrM6PrEqkiXB8SDoe25oAiYFgF6VWwHwnKkM2qpi7fwW22pQIQoFGFDi3/UWPT2znDTUDeb6JBjAOMQ4qAKxLCBcQzSott78lbmshf4PAWxOliyVAlVadpXBPjBFlSwQKP5E1OZ7kUlaaZnCwErR1VJ/glqp5qCILGmMpY+b99rP9uF3gRnDXCyKXIHUWWg4IYXttm2IcmEdN1jYDZ0eZ0Pffn+cyBpUy0haP8IItYRmipuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkg5eFLHLfAjFNzUumo2SMlsohxBdmtdvqANKe8Z8G8=;
 b=b06jfDuL3+WECvVHjTVk34NzsK1RpHBPD7YSRpTDdhD4/xra85ZccF4ywtvY2w30eMYf3XwB9fThg5Da3xmYL6M8qnHMa3TTx0Qbm6SrwJwV5jTNXqfV0NQJEX8CoACh5AbuB7uY0fAxtlHQPdGaYqWX0MF5qVyzI+rYenBV44ZQZ4Al0Xnl7cErXTlB26OdANSQQK0AD9CRrnNCv4B0dH9hOTrqiK18lI512snM9TJzeiLZG71DBuHWprEZA3EVYWiF3zxak9urMjywCtukGwtS1nLp+bNm0s0n5W2ATy5JKSTzQDsMtq+9eD9SjJCyx+wxTOvqF9QPWEcTyNKu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkg5eFLHLfAjFNzUumo2SMlsohxBdmtdvqANKe8Z8G8=;
 b=PDWeMjNM2b3WxJodOqOtBlYQJ5zPLM8Yms1XXW3eWQxUZJ/gOozbws8S9pOt5nzBJ5QpdOnmzwDZT2Kn7KMb0weuuXilYBKkVCfaIDpVYprju3BtscQHCBlIQadIHM91oisOs/2mgfJOpUYU7sr+H5h0JPmJgf4qBhx28qZxxwg=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM9PR04MB8241.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Tue, 16 Jan
 2024 13:29:45 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.027; Tue, 16 Jan 2024
 13:29:45 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] arm64: dts: add description for solidrun am642 som
 and evaluation board
Thread-Topic: [PATCH v2 4/5] arm64: dts: add description for solidrun am642
 som and evaluation board
Thread-Index:
 AQHaRXqNRxBDBTIBFEOB99P14tzvurDWbMUAgALwy4CAASCFAIAAK9IAgAAEN4CAAANTgIABw72A
Date: Tue, 16 Jan 2024 13:29:45 +0000
Message-ID: <2cd24d3d-40a2-435e-bf60-bf6af24128b8@solid-run.com>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
 <20240112-add-am64-som-v2-4-1385246c428c@solid-run.com>
 <60d78882-0ec5-4cd1-b68d-f75b73cb6cdb@linaro.org>
 <1656bf68-c3b4-476d-984e-f231541058f6@solid-run.com>
 <0b03af70-7dc4-4a4f-b9dc-218ef365c237@linaro.org>
 <2879689e-5a4e-4242-a23b-d2aa9f004b1d@solid-run.com>
 <a6a02c39-8c7a-41d6-b751-5a230ac7e785@linaro.org>
 <5e0e6a28-58bb-4f28-aee7-28b05efe14b3@solid-run.com>
In-Reply-To: <5e0e6a28-58bb-4f28-aee7-28b05efe14b3@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|AM9PR04MB8241:EE_
x-ms-office365-filtering-correlation-id: cf651152-b361-4ca3-c73f-08dc16973451
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9Qf43rCVWygFfV88Yp21hSc1yBJpA0WkqmEeLB2QDLzHzpMz6lmrf/G8NJg7jyOSMx1+Q+7MfrGx804cOMrXUcfpbM/IK8cpM6ZbRMI8DQFCBFsbiibcLkbDmtnv8ViF9+XbcygbuD6F55ZzobuaNyJFnT89Wk0A8ilr804FkxireYsx3nuYj+CmZgxWuuJpl90DE00vuGyXTGRvCDMNQwzeL4//TdOD1jRV74W3poluo6CXId5rMwK5l6//QPiG7+rFzSP7SSxN8nI/t3ueikDAOPz2QY0N8uuOvZHTx2VMaGd/3kBBvJwq20EieErHvRbXiSY8jkhqm5dN+tWD5PIfcAAg+M24cp64RkPzytz74j4iRvSBLZxYrBYBpGAc4abLszKd9Mf1E0PdhKONXLJxaw1BrLPADp2qhg66GHs7vQHKxmTqdz5Z0WHcM2Dk+3YNL2D39mjBnjqXymqx0CO0197wvEJA65KYjkYvxz1rjaGONcf/81TwTTyj3y7Ys76KJX7QLIzefIuQEHcqhiLlCXcwCFY/vkI0fVv17YilJ8C8UFmQrX2JRRNUDk7nZYCB77D8ZJMIXzw6vPxZK2P0rFJ4Yo4bkutV7Xly8Ei4l2Z4iLc089J0WYS1CdDK01WQ8czok/1G+GMSDBRLuQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39840400004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(122000001)(38070700009)(86362001)(31696002)(6486002)(91956017)(36756003)(316002)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(54906003)(110136005)(478600001)(6512007)(53546011)(71200400001)(6506007)(2906002)(5660300002)(7416002)(8936002)(8676002)(31686004)(4326008)(41300700001)(2616005)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmZEakk2alBYSjlxcDVscXJLQzZaZ2htK1p2STNiOE1wWk5yVTlwdnluVWdR?=
 =?utf-8?B?TGpleVRyQ1ZxdkRVdC9vSlNkWnIvVWhEV00zd1R0RjI3bWxiK0R3cFV2ajdt?=
 =?utf-8?B?ZWp6WEtYOUZacEtRTEFoc2k2SDBWaEMyZ095bkFYM25vVHlHeFNQWW9XdjJF?=
 =?utf-8?B?T1FTQW5zV2R2OVlCckRsdjNadGo0azFSM3ZUc1JoakpnaEwrakdJeHlEbkE4?=
 =?utf-8?B?V09FcVhPNWRXdGpOcnEraXNoQ0lKLzYvV2N4Vit5Z3hmdnBMT1pMMmtiZ3c5?=
 =?utf-8?B?a01MNGllaWZpMU40ZU5qMkRtOVBSN1l0WEJEb0RYaXdTeTlGK1dMQ0xJdGFG?=
 =?utf-8?B?UTZES1BZTVdJd0dNZjE1QzZwYlVOUUF0QjJlRSt6SFFhckFoWk44ckZPZVRS?=
 =?utf-8?B?RU40NUw3NUU0ZVY5RFgvdFVJUXNXVk45TU4vNHI4ZnlDTG40VnhIZCtjczdq?=
 =?utf-8?B?VGFSZll6blJOdkdJUXlmblVVTXJyaUpnREJTdUxUbnZoNXRISzVDV1NxMVNi?=
 =?utf-8?B?M0VHcDVZRHo0T01Uc2NqVEkydXkwWitqOEFwS2U0ODV3KzhReFAwZVhXRmpm?=
 =?utf-8?B?R1FqdWxTTEdzc1krTUtvOE9TT3lKcDZkTVpSSWNqQTNtdnFJNmFtYVhySTF6?=
 =?utf-8?B?SlBSRWljMjRxUExNbUl3U25BNnA3QnBtTWZhRWFFZmFlRUhxTEdIMzJWKzY4?=
 =?utf-8?B?NzF0dEVnT0puYkdaS0RlUkxnRWNDcmRyalZGa2xkMHFsU1VvMWZnd3VSRmV5?=
 =?utf-8?B?L1BZZjZ0eDBDSzRjVzVEbDJLMTFvbkhsQ0w3WU9MS3UrTnNRSmJldXVWT0hn?=
 =?utf-8?B?cDFqcTRzcjQ2d2NsWmJERU1XMzI4RlNmTGxNdUdrMXY3VWdoSkI0R3hXN0Jy?=
 =?utf-8?B?VzQ5dnBJNG5BVTZJNWV3R1FyTUF1ZkRvVjE5ME1VQTNBUlIzWmtYajJQb3VT?=
 =?utf-8?B?UUFCUUIyRENsU3NCempka0ZRWlZobzIrbXR1T29PTlNvcDhWamg1YVgvS2pP?=
 =?utf-8?B?VytkempLR3hydGZIZWZkcmg0c1oyc213WGtYOE1KRnE4eDFuSFI1b284YXZw?=
 =?utf-8?B?K0dhSHJGTTMzN21FaXVpdVZBdUJienE3Y09UR0NmcjdDaE1LYjJleXFxNVlF?=
 =?utf-8?B?ZzEwVk4yNWsxWnByZlc3a2Nxc0svMUU3cE91cUwxM1BDc3Uvd1VQdU43bTZt?=
 =?utf-8?B?UXo2QW50bFc0TVduV01KNW9jd0I5SWdvajF4dXJUOWZ6NDBmQzZGMG85bE1r?=
 =?utf-8?B?aXhPenM0aVJWUUtKTGt0Y2NBaU1EcDBZdkFlMnV6SzFiQnh1SEtQVC9OYnU0?=
 =?utf-8?B?TzdtYk50MExTa003bUw2NWpMZGZyS3BFcG5HUWViK2pUREt4cTRwbjFlWmFI?=
 =?utf-8?B?RFZwOFVwWXZTdngwRGRyelhoZ0pWVDQxbjdSTk1JcHl2VjlBQ0dRa2hBOG9j?=
 =?utf-8?B?NzlrQ1pCTHcyTnVhbStLZ0NtK0ExVWZKdjh4MDNiNWdBTDZzWWhPZ051YVNO?=
 =?utf-8?B?M0NGbkcyTW5COHh3b3hjYStOM0hUc0lkYm5ldlQvSU9nZ2xmazlJZ2hqb3FP?=
 =?utf-8?B?MkU2a09QQU1hMmdJS2ptSWFFcUFkb1JGVDlpQ0d0SXJaaEo5djF2WnVHRjBi?=
 =?utf-8?B?ZVM5L2F2elRpUGkxOW9pVnhqUzVraEdpcEQrNXA1WXJLTlArV1g2a005YTRU?=
 =?utf-8?B?WVA3a3UrS3dZK2I4Vkx1cEgwN2VSNTVhWjI4K25ZY1RGcGlKcDZNSWJpYm1q?=
 =?utf-8?B?c3NZRXpoM2JURFFDMXRNUHZBenlmTEJyK1dBUXB1SkoyYjhYQXZNVm85amNl?=
 =?utf-8?B?Z0lQK05vcWt0dHJFV1BsZGx2akVUUy9JTGNQVXRLVllyODgyVEN5OTZZMWRq?=
 =?utf-8?B?Q2VVREkra1NiNXNDeXFwOFY2SnIrbzgwSWx6bEJQaG1NUC9NZVRiQ1RjWnNj?=
 =?utf-8?B?a3FERnIwb25mTGtIRDJlc3NXdVZjNHpsUEdPdlVXTmJrcjlMVUNPbjB0azNE?=
 =?utf-8?B?U28wVCtUNThYM1R1N0tadFlFaUpzMmFvdGtUQ1hiTzZtTmVMWUxNaUk3bkNs?=
 =?utf-8?B?Umduc2hmWEQxcG1ZY295SGZ5S09hTXNSajhPcjc3STdSdFZIRjRjOTVLRzFW?=
 =?utf-8?Q?rS53U61gDSq9MPPjng/mID70d?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAD8273A545E4B4D9C192FDD07F1BE42@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf651152-b361-4ca3-c73f-08dc16973451
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 13:29:45.3059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkusBQacHl26u2T45wJzm7V2d7Ht5HCLy3tr9k+6dOVRSgQK3ChR2E0f8e45pH5kvcmIfFv5sYi32mq26ZsakQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8241

QW0gMTUuMDEuMjQgdW0gMTE6MzIgc2NocmllYiBKb3N1YSBNYXllcjoNCj4gQW0gMTUuMDEuMjQg
dW0gMTE6MjEgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPj4gT24gMTUvMDEvMjAyNCAx
MTowNSwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+Pj4gKw0KPj4+ICsJCXRpLHBydXNzLWdwLW11eC1z
ZWwgPSA8Mj4sCS8qIE1JSSBtb2RlICovDQo+Pj4gKwkJCQkgICAgICA8Mj4sDQo+Pj4gKwkJCQkg
ICAgICA8Mj4sDQo+Pj4gKwkJCQkgICAgICA8Mj4sCS8qIE1JSSBtb2RlICovDQo+Pj4gKwkJCQkg
ICAgICA8Mj4sDQo+Pj4gKwkJCQkgICAgICA8Mj47DQpUaGlzIHByb3BlcnR5IGlzIGRlc2NyaWJl
ZCBpbiByZW1vdGVwcm9jL3RpLHBydS1jb25zdW1lci55YW1sDQp3aXRob3V0IGV4cGxhbmF0aW9u
IHdoYXQgZWFjaCBudW1lcmljIHZhbHVlIG1lYW5zLnwNClNvQyBUUk0gcHJvdmlkZXMgdGhlc2Ug
bmFtZXM6ICJHUCIsICJFbkRBVCIsICJNSUkiLCAiU0QiLg0KSXMgaXQgb2theSB0byBrZWVwIG51
bWJlciBoZXJlLCBvciBhcmUgbmFtZWQgY29uc3RhbnRzIG5lZWRlZD8NCkFkZGl0aW9uYWxseSwg
dGhpcyBhcnJheSBiZXR0ZXIgdG8gZG8gaW4gc2luZ2xlIGxpbmU/Og0KDQovKiBjb25maWd1cmVp
IG50ZXJuYWwgbXV4IGZvciBtaWkgbW9kZSAqLw0KdGkscHJ1c3MtZ3AtbXV4LXNlbCA9IDwyPiwg
PDI+LCA8Mj4sIDwyPiwgPDI+LCA8Mj47DQoNCj4+PiArDQo+Pj4gKwkJdGksbWlpLWctcnQgPSA8
Jmljc3NnMV9taWlfZ19ydD47DQo+Pj4gKwkJdGksbWlpLXJ0ID0gPCZpY3NzZzFfbWlpX3J0PjsN
Cj4+PiArCQl0aSxpZXAgPSA8Jmljc3NnMV9pZXAwPiwgPCZpY3NzZzFfaWVwMT47DQo+Pj4gKw0K
Pj4+ICsJCWludGVycnVwdC1wYXJlbnQgPSA8Jmljc3NnMV9pbnRjPjsNCj4+PiArCQlpbnRlcnJ1
cHRzID0gPDI0IDAgMj4sIDwyNSAxIDM+Ow0KPj4+Pj4+IE5vbmUgb2YgdGhlc2UgYXJlIHR5cGlj
YWwgaW50ZXJydXB0IGNvbnN0YW50cy9mbGFncz8NCiJwcnVzcy1pbnRjIiBpbnRlcnJ1cHQgY29u
dHJvbGxlciBkcml2ZXIgaGFzIGEgc3BlY2lhbCB4bGF0ZSBmdW5jdGlvbiwNCnRha2luZyAzIGlu
dGVnZXIgYXJndW1lbnRzOiBldmVudCwgY2hhbm5lbCwgaG9zdC4NCg0KSSBjYW1lIHVwIHdpdGgg
dGhlIGJlbG93IGRlc2NyaXB0aW9uOg0KLyoNCiogaWNzc2cgc3Vic3lzdGVtIGludGVycnVwdCBj
b250cm9sbGVyIGNhbiBiZSBwcm9ncmFtbWVkDQoqIGZvciByb3V0aW5nIGFueSBvZiA2NCBwcmVk
ZWZpbmVkIHN1YnN5dGVtLWludGVybmFsIGV2ZW50cw0KKiAoZG9jdW1lbnRlZCBpbiBUUk0pIHRv
IG9uZSBvZiAyMCBob3N0IGludGVycnVwdHMuDQoqIFNvbWUgaG9zdCBpbnRlcnJ1cHRzIGFyZSBk
ZXZpY2Utd2lkZSwgb3RoZXJzIHNwZWNpYWwNCiogcHVycG9zZS4NCiogTWFwcGluZyBpcyBkb25l
IHZpYSBvbmUgb2YgMjAgY2hhbm5lbHMgLSBjaGFubmVsIG51bWJlcg0KKiBkZWNpZGVzIHByb2Nl
c3NpbmcgcHJpb3JpdHkgKDAgPSBoaWdoZXN0KS4NCioNCioNCiogTWFwIHBydS1pbnRlcm5hbCBp
bnRlcnJ1cHQgIzggKDI0KSB2aWEgY2hhbm5lbCAwIHRvDQoqIGhvc3Qtc2lkZSBwcnUgaW50ZXJy
dXB0ICMwICgyKSAoZ2ljIDI0NiAvICJob3N0X2ludHIwIik7DQoqIGFuZCBwcnUtaW50ZXJuYWwg
aW50ZXJydXB0ICM5IHZpYSBjaGFubmVsIDAgdG8NCiogaG9zdC1zaWRlIHBydSBpbnRlcnJ1cHQg
IzEgKDMpIChnaWMgMjQ3IC8gImhvc3RfaW50cjEiKS4NCiovDQoNCkkgZmVlbCBpdCBpcyBhIGJp
dCBsb25nIHRvIHB1dCBpbiBkdHMsIHBlcmhhcHMgSSBjYW4gcHV0IGp1c3Qgc2Vjb25kIHBhcmFn
cmFwaD8NCkhvd2V2ZXIgdGhpcyBwYXJhZ3JhcGggaXMgc3RpbGwgYSBiaXQgY29uZnVzaW5nIC0N
Ckkgc2hvdWxkIG1ha2UgaXQgbW9yZSByZWFkYWJsZSwgZXNwZWNpYWxseSBob3cgMjQgdHJhbnNs
YXRlcyB0byA4IGFuZCAyIHRvIDAsIGV0Yy4uDQoNCkZpcnN0IHBhcmFncmFwaCBpcyBub3QgbmVl
ZGVkLCBiZWNhdXNlIGJpbmRpbmdzIGRvYyBmb3IgdGhpcw0KaW50ZXJydXB0IGNvbnRyb2xsZXIg
aGFzIGEgZ29vZCBkZXNjcmlwdGlvbiBmb3IgI2ludGVycnVwdC1jZWxsczoNCmludGVycnVwdC1j
b250cm9sbGVyL3RpLHBydXNzLWludGMueWFtbA0KDQpUaGUgNjQgZXZlbnRzLCBhbmQgMjAgaG9z
dHMgaGF2ZSBuYW1lcyBpbiB0aGUgVFJNLiBTb21lIG9mIHRoZW0NCmFyZSBwYXJ0aWN1bGFyLCBv
dGhlcnMgYXJlIGdlbmVyaWMsIGUuZy4gSU5UUl9SRVFbMDoxNV0uDQpDcmVhdGluZyBhIGhlYWRl
ciB3aXRoIG5hbWVkIGNvbnN0YW50cyBzZWVtcyBkb2FibGUuDQoNCklzIGl0IHdvcnRoIGRvaW5n
IHRoaXM/DQoNCg0KU2luY2VyZWx5DQpKb3N1YSBNYXllcg0KDQo=

