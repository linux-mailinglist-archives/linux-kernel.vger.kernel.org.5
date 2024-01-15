Return-Path: <linux-kernel+bounces-25891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC1282D770
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FFD3B2135C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3A01B805;
	Mon, 15 Jan 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="piCoZ6oN"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B0D101E3;
	Mon, 15 Jan 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN0M1qRUGWkPfodece28zmE64nN+FAqEPhwn/lTQsz1WKiZ8Ii0g/28r9+cJAJtE3gwK17/sVf5kV/aeNOGumG5q+Sc/4pNhMoMJPLKVE8pwFzcApjgGUznDb/TWKaze56kl+OF4j7oDI5qITpWU/5bgXU9VCg4IyGQdG65oUtJXgxTwOJwYtkqAyJm2t6ODVCjv6jStAuI7Jt16yEAlLjikEkuj3z01UjIhpgx6iSQawjcRK8EVqOj4tZDbQfTtPVEEodHBIprWDWi2hKOTg7IWHXrXkyt2sBeG1k2cGe94qRNVjSJjP3we47KvG+LpulmVcsHh5Fz1ndfekkPQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbVlkAobazHXz4N3igq5TRpj86O+x6+5f/ehArF2kHE=;
 b=caJuG5K+OSwPAm2BTo5ZmSrwkiFHuUFUzA/VJPseInerA6U1+qXOJT6mFZ0fEsNt0mVFO1IhaEmacNQnB66XSBI8cYBDsb3oz13kQ/52RQ9Elir8zH/iVJ6Wz+839c7Y4RD+ZgY+FkUOm1OlaVFKxdsrlSufM8eswUPqPW1Ea/NfwZ8enRKAiDA8Jgi9bXh+qs+m3aS1ZKXB8O6BDMMuLXCC5anXpcefFu4PwxC51c3WoxhvZEef5dz61qwC/zywfLV9uioP4PMVe1OCnvkwhs5i1rztswxUv5O74CopGqiic5mdrR6qheDTQqxAKFsmaRWRN2bD8wYSCeAGG8+wLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbVlkAobazHXz4N3igq5TRpj86O+x6+5f/ehArF2kHE=;
 b=piCoZ6oNfuKUklATMN1zmw1yqQTQQYjwYkN3/DEzEzZU4V3frF36v9Q3YpGHoZAjFFHK7N3wnrv3qZv8aIJfZQqXZP3yTbox/wZtJE9W6nA4V+hXCEhsuobGfi9Fdxn5IF/Tps2T8f6Bf/8wkjFmH3J+l4nfPrevmALGyh6gzsM=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DBBPR04MB7881.eurprd04.prod.outlook.com (2603:10a6:10:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 10:32:55 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Mon, 15 Jan 2024
 10:32:55 +0000
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
 AQHaRXqNRxBDBTIBFEOB99P14tzvurDWbMUAgALwy4CAASCFAIAAK9IAgAAEN4CAAANTgA==
Date: Mon, 15 Jan 2024 10:32:55 +0000
Message-ID: <5e0e6a28-58bb-4f28-aee7-28b05efe14b3@solid-run.com>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
 <20240112-add-am64-som-v2-4-1385246c428c@solid-run.com>
 <60d78882-0ec5-4cd1-b68d-f75b73cb6cdb@linaro.org>
 <1656bf68-c3b4-476d-984e-f231541058f6@solid-run.com>
 <0b03af70-7dc4-4a4f-b9dc-218ef365c237@linaro.org>
 <2879689e-5a4e-4242-a23b-d2aa9f004b1d@solid-run.com>
 <a6a02c39-8c7a-41d6-b751-5a230ac7e785@linaro.org>
In-Reply-To: <a6a02c39-8c7a-41d6-b751-5a230ac7e785@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|DBBPR04MB7881:EE_
x-ms-office365-filtering-correlation-id: c1c3cc16-f300-4d02-95b4-08dc15b555e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OlbV5upeHa007fc8HrtQnBlGbV/wOqggyEJVU9vDtIwuLAMeYlkGuJb1yVRXFT4kwqWbpBa4EiOmTlEXDheSZGE9om3wKC0jbFV2zvAD165Rcx77pkEy7qGHjSAxyDBAXu8neHCtsKPb6m57Hqz4FBBSBwGOozqbg/CbiBvFKUq+7ROIVCN6FFrzv3hBl/meenXxahauXe19lCXG6hfem10ucBAkrioWAFqt0GKzKQ39Ki5juZFYpmN3/L6b4q7VXluZLK52tFVHKPSLOgvpVIgyWXaq58RUCCHtCJztVZhxK7lp+pTrQ1tYOGbPjUOWRMt6RKynGcvKVwilGS645PA+zaxMDn2xZosKawxsCfBLcLOWaSQYzxHgQhSBcg1c/o8zhiupL5hyPtGIJPk33f0pS5fh1O6+RddgD1iGqM1jwthRs8LwkHOvf/Nveard/nqFlpIm+1gjErkq/wEJTPxOOVB5G2b94YCpWBUe4uoEOctBWdepFGLgncFFTPO6nvDnQEr6QDI5g/5izsPh80unqP3fMfRpI/gWP3xfw85POZVmF+SN0LW+BaMWdHJWqbdvtutyueRkjTVjtm8VUxs0c2Lg+akmLbVvUcrwW8pJlWVTdedABXLq6J3d4EMu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39840400004)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(966005)(6486002)(478600001)(53546011)(71200400001)(6506007)(6512007)(26005)(2616005)(2906002)(7416002)(5660300002)(110136005)(76116006)(91956017)(66946007)(54906003)(64756008)(66446008)(66476007)(66556008)(316002)(4326008)(8936002)(8676002)(38070700009)(36756003)(31686004)(31696002)(86362001)(83380400001)(41300700001)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1VIUk8yZnE4cWE1c1BYc3VMRFFhRUNocTl3WjUyQU1qSy9PbHhLSDJURjR4?=
 =?utf-8?B?eW9xdU80a1FVT0Y2K0RhTWVsRCtPMXU3OHVSZzNpRzlhQVVFUnpPaVliNHQ5?=
 =?utf-8?B?ODQwc0NyMjlKdVpsTjk5d0k1SzY3dlo4TDhTRUJPbkxpUVhiODVIVHpibFNH?=
 =?utf-8?B?REFpMzkwaUM5Ry93a1lVYjVRVFRxcENvRllLTW1mOCtMNWkrRUNuSjBVQjJH?=
 =?utf-8?B?cGNWUktrdS9oL2gyUDBRZkRMdGVwUkxTZ3VmQWY5SzZjTHJqWWRKQ2tWdmNk?=
 =?utf-8?B?cVE2SnI5cHM4aG1QSFFBNmcwUVdpbmFIbFEwc203ZXpXcUszVmhHbE9TNTUv?=
 =?utf-8?B?WENqeFRFMTNZejdBUFYweS9DRk4yNG1yU1p6aW9lcFRXUC9oRDhncmdoVjRm?=
 =?utf-8?B?TnlHV014T05sWHV3ZENlK24zYi93YlBuZFpuZzVMdk5MUlUydWxra1ZkK1FI?=
 =?utf-8?B?c0t1NGZZKy8wV3NMZncyUFIvcnV5RG96Vmk1clY5bEdFcnNIQUo4Ym90Ylpj?=
 =?utf-8?B?MjMvY281ZHIrc1ZhcEhQRFJUREhLVUFCSDN2UjgxQ1ZRN3U5MnpzNHlsVzdL?=
 =?utf-8?B?QTE0NVo0Wlc0eVZUbUJEcXQ2ME9xTzVrZXhjRjdlU0dmby93aXZ1ZU1iUmUx?=
 =?utf-8?B?NVUyZDRsb0gxM2hYM2owMmt0M3RTYktwNW41VEthbkp1dEpuUU5LenJqNGpu?=
 =?utf-8?B?cy9WSEFHdmFRM0oyMUQzVmNiZzlRanNMS2Fldk9JOTNwV2QrZVNvR2lEaXJN?=
 =?utf-8?B?ei9Bd2VSRTJIWDV0WnZCZWRXWit6REt6VHg0TkxIY0lQbS9rbFBjblhMQ2ow?=
 =?utf-8?B?SGVlTmhqUmNPcjRvZGc3amdZVGRzbC8vaXhxaVlXVm9TUjJuVzh1d3VBNnFP?=
 =?utf-8?B?SGZkTFhKc0NsZ2lwdmNpV3dyQ0tFdTh5NmlpTU5UTDNUWEdlaGNSWlErSUov?=
 =?utf-8?B?bXRYOU13WldCUXIzZms1bUZiNTVMU3JoVy94cHlSTDVRbEFjRUVmaGhqZi9O?=
 =?utf-8?B?a2didjhoSlJTeGhpdXgvL05OeG9pcGVnT0kwc2YzTnN0NGdCeVZVUXNMcHhE?=
 =?utf-8?B?VlhiVzNIQzBraU9FRjVwaGprNGdZV2NRWmFwR1poU1UrejltVTdNNHQ2dHE0?=
 =?utf-8?B?SXFzMm5seTlKMVplM2plWUQxcmg3WnplWlEyS3BDcjE1dXI2TjQ1K3ZQZDgv?=
 =?utf-8?B?RU4wNG5FbDAwSDk3eWx1emNyVWQwZDNIdUtJZXFRSEFQWjhScVg3SWI2M0F5?=
 =?utf-8?B?SFVFN0hJaWxIcW5NaU5kY3p2RFZUNUl0TkZpZGdTYTE1TnV4cU5SWUZzTzlh?=
 =?utf-8?B?K1pHL0xxQjFqWmNILzFSek4xaXI4WmpWcVk3LytJVEl4VmlNcEVrbFBvZDZa?=
 =?utf-8?B?ZmhPcFh4TTZtZEZOb2JXQmVDS0w5K0RqWkd1YnlIRE9lRC91SS9FYUFqVEQ0?=
 =?utf-8?B?UGFoNytnRjV6dEYrcTkyeTdLT0ExeUVHZk5qN2VvM09QMENJYmVzRFdOek9G?=
 =?utf-8?B?SUgxUkFRNWZpZmtzZlJ1Q3dic29abDNscjhJeWppaWpWdmpvR052VFdSazBE?=
 =?utf-8?B?RkZCN2RSMzhsVmZRQlJRWjZrRnhnclZ1UlI5VkhRbVBYVStvRHRjamlSczVx?=
 =?utf-8?B?d09pWnBUNzJPR3VoVGg0OEtJT1NYbG40QVB2M0pKZUxrTWFwZWhNRVk3UFh6?=
 =?utf-8?B?aFFOc2FQTHVlWTZuOUFJMU10V0lLWE52amhwSGRBOExKOThIR21LdEYvRlFh?=
 =?utf-8?B?cVJVTFhHVU05WGlNL2FoVXdkWURWdGR5QVFlRnFxbDAxd2tKSENyZTZ4dFJo?=
 =?utf-8?B?bVlTS1FBSjVNSkl3dGh4bVV3TDllek1aMVNjMjN3azdrdmU4MnhUQjhWOHJq?=
 =?utf-8?B?d1lHWlV1R0k2L0xCak02T1FlVnV3MUVnS0RsQjBLWnA2azFDMzhzRWxwek5Z?=
 =?utf-8?B?TTR4OTFWV3VkbkhlRFNSLy9Cc3BaQU91TFhNR3JKd1Vjb0drVHFZUW04R2Vv?=
 =?utf-8?B?d0R6MnRJRWFaSVFKYUJrYjh0SXhIeW04MVJwTXZzV1dMbnh0b0xXQWhpTUVJ?=
 =?utf-8?B?VHdHQ1cvbm1nUktWc0FUT2ptQTRUNjQvOCt4cXd6ZVh4QXQrckV6SjFDZmNU?=
 =?utf-8?Q?h9TmHo6TWLdg7daMkbzTlVvJY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD4913BD2D542440AD8095B141C1E31D@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c3cc16-f300-4d02-95b4-08dc15b555e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 10:32:55.3988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vrtMVcUV+P8p2cslpQx7FF5lX1/fs65WBG5t3iBVsyN43iA2uKJBJ3Sy4WBDZsllEM9KmeKrVgoWTFepoU1NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7881

QW0gMTUuMDEuMjQgdW0gMTE6MjEgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPiBPbiAx
NS8wMS8yMDI0IDExOjA1LCBKb3N1YSBNYXllciB3cm90ZToNCj4+IEFtIDE1LjAxLjI0IHVtIDA4
OjI5IHNjaHJpZWIgS3J6eXN6dG9mIEtvemxvd3NraToNCj4+DQo+Pj4gT24gMTQvMDEvMjAyNCAx
NToxNiwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+Pj4+IEFtIDEyLjAxLjI0IHVtIDE4OjIyIHNjaHJp
ZWIgS3J6eXN6dG9mIEtvemxvd3NraToNCj4+Pj4NCj4+Pj4+PiArCS8qIFBSVSBFdGhlcm5ldCBD
b250cm9sbGVyICovDQo+Pj4+Pj4gKwlpY3NzZzFfZXRoOiBpY3NzZzEtZXRoIHsNCj4+Pj4+IE5v
ZGUgbmFtZXMgc2hvdWxkIGJlIGdlbmVyaWMuDQo+Pj4+IFRoaXMgbmFtZSBpbnRlbnRpb25hbGx5
IGluY2x1ZGVzIHRoZSBuYW1lIG9mIHRoZSBpcCBibG9jayB3aXRoaW4gYW02NCBzb2MNCj4+Pj4g
cHJvdmlkaW5nIHNvZnR3YXJlLWRlZmluZWQgZXRoZXJuZXQgY29udHJvbGxlciB0aHJvdWdoIGNv
cHJvY2Vzc29ycyBUSSBjYWxsICJwcnUiLg0KPj4+IFdoeT8gVGhpcyBpbnRlbnRpb25hbGx5IHNo
b3VsZCBub3QgaW5jbHVkZSBzcGVjaWZpYyBuYW1lLg0KPj4gSSB1bmRlcnN0YW5kLiBXaGljaCBp
cyB3aHkgSSBpbWFnaW5lZCBpbiB0aGUgb3RoZXIgcmVmZXJlbmNlIGhhZCBpbnRlbnRpb25hbGx5
DQo+PiBkaXZlcmdlZCBmcm9tIHRoYXQgcnVsZS4NCj4+PiBBbHNvLCB3cmFwIHlvdXIgZW1haWxz
IGF0IHByb3BlciBsZW5ndGggc28gdGhleSB3aWxsIGJlIG1hbmFnZWFibGUuLi4NCj4+Pg0KPj4+
Pj4gU2VlIGFsc28gYW4gZXhwbGFuYXRpb24gYW5kIGxpc3Qgb2YNCj4+Pj4+IGV4YW1wbGVzIChu
b3QgZXhoYXVzdGl2ZSkgaW4gRFQgc3BlY2lmaWNhdGlvbjoNCj4+Pj4+IGh0dHBzOi8vZGV2aWNl
dHJlZS1zcGVjaWZpY2F0aW9uLnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC9jaGFwdGVyMi1kZXZp
Y2V0cmVlLWJhc2ljcy5odG1sI2dlbmVyaWMtbmFtZXMtcmVjb21tZW5kYXRpb24NCj4+Pj4+DQo+
Pj4+Pg0KPj4+Pj4+ICsJCWNvbXBhdGlibGUgPSAidGksYW02NDItaWNzc2ctcHJ1ZXRoIjsNCj4+
Pj4+PiArCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPj4+Pj4+ICsJCXBpbmN0cmwtMCA9
IDwmcHJ1X3JnbWlpMV9waW5zX2RlZmF1bHQ+LCA8JnBydV9yZ21paTJfcGluc19kZWZhdWx0PjsN
Cj4+Pj4+PiArDQo+Pj4+Pj4gKwkJc3JhbSA9IDwmb2Nfc3JhbT47DQo+Pj4+Pj4gKwkJdGkscHJ1
cyA9IDwmcHJ1MV8wPiwgPCZydHUxXzA+LCA8JnR4X3BydTFfMD4sIDwmcHJ1MV8xPiwgPCZydHUx
XzE+LCA8JnR4X3BydTFfMT47DQo+Pj4+Pj4gKwkJZmlybXdhcmUtbmFtZSA9ICJ0aS1wcnVzcy9h
bTY1eC1zcjItcHJ1MC1wcnVldGgtZncuZWxmIiwNCj4+Pj4+PiArCQkJCSJ0aS1wcnVzcy9hbTY1
eC1zcjItcnR1MC1wcnVldGgtZncuZWxmIiwNCj4+Pj4+PiArCQkJCSJ0aS1wcnVzcy9hbTY1eC1z
cjItdHhwcnUwLXBydWV0aC1mdy5lbGYiLA0KPj4+Pj4+ICsJCQkJInRpLXBydXNzL2FtNjV4LXNy
Mi1wcnUxLXBydWV0aC1mdy5lbGYiLA0KPj4+Pj4+ICsJCQkJInRpLXBydXNzL2FtNjV4LXNyMi1y
dHUxLXBydWV0aC1mdy5lbGYiLA0KPj4+Pj4+ICsJCQkJInRpLXBydXNzL2FtNjV4LXNyMi10eHBy
dTEtcHJ1ZXRoLWZ3LmVsZiI7DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsJCXRpLHBydXNzLWdwLW11eC1z
ZWwgPSA8Mj4sCS8qIE1JSSBtb2RlICovDQo+Pj4+Pj4gKwkJCQkgICAgICA8Mj4sDQo+Pj4+Pj4g
KwkJCQkgICAgICA8Mj4sDQo+Pj4+Pj4gKwkJCQkgICAgICA8Mj4sCS8qIE1JSSBtb2RlICovDQo+
Pj4+Pj4gKwkJCQkgICAgICA8Mj4sDQo+Pj4+Pj4gKwkJCQkgICAgICA8Mj47DQo+Pj4+Pj4gKw0K
Pj4+Pj4+ICsJCXRpLG1paS1nLXJ0ID0gPCZpY3NzZzFfbWlpX2dfcnQ+Ow0KPj4+Pj4+ICsJCXRp
LG1paS1ydCA9IDwmaWNzc2cxX21paV9ydD47DQo+Pj4+Pj4gKwkJdGksaWVwID0gPCZpY3NzZzFf
aWVwMD4sIDwmaWNzc2cxX2llcDE+Ow0KPj4+Pj4+ICsNCj4+Pj4+PiArCQlpbnRlcnJ1cHQtcGFy
ZW50ID0gPCZpY3NzZzFfaW50Yz47DQo+Pj4+Pj4gKwkJaW50ZXJydXB0cyA9IDwyNCAwIDI+LCA8
MjUgMSAzPjsNCj4+Pj4+IE5vbmUgb2YgdGhlc2UgYXJlIHR5cGljYWwgaW50ZXJydXB0IGNvbnN0
YW50cy9mbGFncz8NClRoZXNlIGFyZSB0aGUgbWFnaWMgbnVtYmVycw0KPj4+Pj4NCj4+Pj4+PiAr
CQlpbnRlcnJ1cHQtbmFtZXMgPSAidHhfdHMwIiwgInR4X3RzMSI7DQo+Pj4+Pj4gKw0KPj4+Pj4+
ICsJCWRtYXMgPSA8Jm1haW5fcGt0ZG1hIDB4YzIwMCAxNT4sIC8qIGVncmVzcyBzbGljZSAwICov
DQo+Pj4+Pj4gKwkJICAgICAgIDwmbWFpbl9wa3RkbWEgMHhjMjAxIDE1PiwgLyogZWdyZXNzIHNs
aWNlIDAgKi8NCj4+Pj4+PiArCQkgICAgICAgPCZtYWluX3BrdGRtYSAweGMyMDIgMTU+LCAvKiBl
Z3Jlc3Mgc2xpY2UgMCAqLw0KPj4+Pj4+ICsJCSAgICAgICA8Jm1haW5fcGt0ZG1hIDB4YzIwMyAx
NT4sIC8qIGVncmVzcyBzbGljZSAwICovDQo+Pj4+Pj4gKwkJICAgICAgIDwmbWFpbl9wa3RkbWEg
MHhjMjA0IDE1PiwgLyogZWdyZXNzIHNsaWNlIDEgKi8NCj4+Pj4+PiArCQkgICAgICAgPCZtYWlu
X3BrdGRtYSAweGMyMDUgMTU+LCAvKiBlZ3Jlc3Mgc2xpY2UgMSAqLw0KPj4+Pj4+ICsJCSAgICAg
ICA8Jm1haW5fcGt0ZG1hIDB4YzIwNiAxNT4sIC8qIGVncmVzcyBzbGljZSAxICovDQo+Pj4+Pj4g
KwkJICAgICAgIDwmbWFpbl9wa3RkbWEgMHhjMjA3IDE1PiwgLyogZWdyZXNzIHNsaWNlIDEgKi8N
Cj4+Pj4+PiArCQkgICAgICAgPCZtYWluX3BrdGRtYSAweDQyMDAgMTU+LCAvKiBpbmdyZXNzIHNs
aWNlIDAgKi8NCj4+Pj4+PiArCQkgICAgICAgPCZtYWluX3BrdGRtYSAweDQyMDEgMTU+LCAvKiBp
bmdyZXNzIHNsaWNlIDEgKi8NCj4+Pj4+PiArCQkgICAgICAgPCZtYWluX3BrdGRtYSAweDQyMDIg
MD4sIC8qIG1nbW50IHJzcCBzbGljZSAwICovDQo+Pj4+Pj4gKwkJICAgICAgIDwmbWFpbl9wa3Rk
bWEgMHg0MjAzIDA+OyAvKiBtZ21udCByc3Agc2xpY2UgMSAqLw0KVGhlc2UgYXJlIG1heWJlIG1h
Z2ljIG51bWJlcnMNCj4+Pj4+PiArCQlkbWEtbmFtZXMgPSAidHgwLTAiLCAidHgwLTEiLCAidHgw
LTIiLCAidHgwLTMiLA0KPj4+Pj4+ICsJCQkgICAgInR4MS0wIiwgInR4MS0xIiwgInR4MS0yIiwg
InR4MS0zIiwNCj4+Pj4+PiArCQkJICAgICJyeDAiLCAicngxIjsNCnR3byBuYW1lcyBtaXNzaW5n
IGhlcmUNCj4+Pj4+PiArDQo+Pj4+Pj4gKwkJc3RhdHVzID0gIm9rYXkiOw0KPj4+Pj4gRHJvcC4g
RGlkbid0IHlvdSBnZXQgc3VjaCBjb21tZW50cyBiZWZvcmU/DQo+Pj4+IFllcywgYnV0IGFnYWlu
IEkgY2FuIHBvaW50IHRvIGFuIGluLXRyZWUgZXhhbXBsZSBvZiB0aGUgc2FtZSBzdHJ1Y3R1cmUu
DQo+Pj4+IEkgc2VlIG5vIHJlYXNvbiBmb3IgZGVzY3JpYmluZyB0aGUgc2FtZSB0aGluZyBkaWZm
ZXJlbnRseSBpbiBkaWZmZXJlbnQgcGxhY2VzLg0KPj4+IFNvIGlmIHRoZXJlIGlzIGEgYnVnLCB5
b3UgYXJlIGdvaW5nIHRvIGR1cGxpY2F0ZSBpdC4NCj4+IEkgd2FzIHRvcm4gYmV0d2VlbiBtYWtp
bmcgbXkgb3duIHNvbHV0aW9uLCBhbmQgdXNpbmcgcmVjZW50bHkNCj4+IGFkZGVkIGFuZCB0b3Bp
Y2FsICh0byBteSBzdWJtaXNzaW9uKSBjb2RlIGFzIHRlbXBsYXRlLg0KPj4+IFBsZWFzZSBwcm92
aWRlIHJlYWwgYXJndW1lbnQgd2h5IHRoaXMgaXMgbmVlZGVkLCBub3QgIkkgc2F3IGl0DQo+Pj4g
c29tZXdoZXJlIiwgb3IgZHJvcCBpdC4gT3RoZXJ3aXNlIGl0J3MgYSBOQUsgZnJvbSBtZS4NCj4+
IEkgd2lsbCBhdHRlbXB0IHRvIGltcHJvdmUgdGhlIG1hZ2ljIG51bWJlcnMgaW4gdGhpcyB3aG9s
ZSBub2RlLA0KPj4gYW5kIHJlY29uc2lkZXIgdGhlIG5vZGUgbmFtZS4gVGhhbmtzLg0KPiBXaGF0
IG1hZ2ljIG51bWJlcnM/IE15IGNvbW1lbnQgd2FzIHVuZGVyIG9uZSBzcGVjaWZpYyBsaW5lLiBU
aGVyZSBhcmUgbm8NCj4gbnVtYmVycyBpbiBzdGF0dXMuDQpTb3JyeSBpdCB3YXNuJ3QgY2xlYXIs
IHN0YXR1czogYWNrZWQsIG15IG1pc3Rha2UsIEkgbWFkZSBpdCB0b28gbWFueSB0aW1lcw0KbWF5
YmUgSSB3aWxsIGxlYXJuIGV2ZW50dWFsbHkgLi4uIGhvcGVmdWxseSA6KA0KDQppbnRlcnJ1cHQg
bnVtYmVycywgZG1hLW5hbWVzLCBub2RlIG5hbWU6IEkgd2lsbCByZXdvcmsuDQoNCj4NCj4gQmVz
dCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4NCg==

