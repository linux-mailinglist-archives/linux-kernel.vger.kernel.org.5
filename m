Return-Path: <linux-kernel+bounces-20768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBB48284F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44AABB24833
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B99736B1B;
	Tue,  9 Jan 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rJfdCFiS"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5563536B02;
	Tue,  9 Jan 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgehU71nOdAscWl13wVBt2DfbJo8d3J/YI55JPB/lIn+YylKVFXOW82nST/NblcYDeNE2dzrFRExyHoRKIbRIkTmecbUVv7JyZ/W7b6PqQ+PduOfXxmmlm2spLj4QHGwhictoDkCVSAxVW5NMF0JtvLljPzxfPyIG6B8BnGnVrPyG7DKoZ9ZMPXeHlyQ4FLB66826oVxR19Qo+JbiN6J3tWOXk1pes3gHcZziMFLdfVrwHGNtY50hyzzmYgohpffWiUW2QL659DsvO4Nc1K9e3TBfxk++IbFoP3s3is7sc1rRYC5X1iYDwPqNl53iJTDRNNAgZv17NnZNQ1p0XkSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bgc62aEBTZ0sDP8KBG/40vtwmOyWOGP/e3Uozlcf3hs=;
 b=lzz+bQ+JHLfHp50g7ct5ekJKqrHvOKBbzyqyIReWBKdN/RRAouxELfMy9tGy1AK4N1SGZcb3O3JIktnePcIyDtcMdhGB/1d8J70ZZi7TW3mDugVrIbYOEY7CpH1QS+HBioNxh99TF902cY4EUgp5oJ2lai5NXQHxkjIRoA84g1SIoB+rFvywE1nXfaynaVE06a2tyMWmQS0DbmRUhya4Uql6WBP+8y9B+Tlc/pAOW0jx/RR40dLq5QohYWE6H7JmFoh6Ozm3VTzez7uyspDQL9VXanMKL63eZRK2n+9zoXVMgQ5Waj+LAGORc7VdDFS1e7emnzjQ7W8t0n2Ml7Tshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bgc62aEBTZ0sDP8KBG/40vtwmOyWOGP/e3Uozlcf3hs=;
 b=rJfdCFiSOUOsATOCsr2aF7TVRAWluketQ7M1Z3Nc1pal0kJafcvNDajI3yxrmh66Q7ElzuLCgdGmFytJsNmzGtP7uPrfVgCKtB0M1pJZS+2gNzcgX9zmE71FrHEXOrISDE47s+Gj17BNxx0uoVoIhM+Byh+wpCuXhuOlmshKjvE=
Received: from PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 9 Jan
 2024 11:24:37 +0000
Received: from PH7PR12MB7284.namprd12.prod.outlook.com
 ([fe80::cd3:fb61:5d48:fb08]) by PH7PR12MB7284.namprd12.prod.outlook.com
 ([fe80::cd3:fb61:5d48:fb08%4]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 11:24:37 +0000
From: "Trivedi Manojbhai, Naman" <Naman.TrivediManojbhai@amd.com>
To: Stephen Boyd <sboyd@kernel.org>, "abel.vesa@linaro.org"
	<abel.vesa@linaro.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "Simek, Michal"
	<michal.simek@amd.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"robh@kernel.org" <robh@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: clk: zynqmp: remove clock name dependency
Thread-Topic: [PATCH] drivers: clk: zynqmp: remove clock name dependency
Thread-Index: AQHaPhVjvmRGRPQ6SUKSkOvyusaGNLDI1osAgAiDI9A=
Date: Tue, 9 Jan 2024 11:24:37 +0000
Message-ID:
 <PH7PR12MB7284595E5D409486D91118768A6A2@PH7PR12MB7284.namprd12.prod.outlook.com>
References: <20240103072017.1646007-1-naman.trivedimanojbhai@amd.com>
 <55fd522918aa41f386e01432248933da.sboyd@kernel.org>
In-Reply-To: <55fd522918aa41f386e01432248933da.sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7284:EE_|PH8PR12MB7135:EE_
x-ms-office365-filtering-correlation-id: 64a7a518-5659-4fd3-629d-08dc1105907c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WV350zZb1YRuYO0NP598JSNW+wpNlpxE4sAmq+dVhWLtfSGE6XHWU8e1xu+nwdurQbyAUUumk6e2r4e8L1fbpc3lwKSpZPF6c59NqnhidwS5BC7iSZXl6M2wuyE88HngI6UhQQyCksbQuv+n/D4JDfaf9rcC14Xxh/eeENcFfmqN94xub84JK55ZlpInD4EQJXdPEN6I7Jg+5IEIFUC/YpfbKZfWdfC03XxT3WwbCROkk1aE1Uucx2j18KA2unQU21qy4JTbWT5o7svFHbGqvT1KBLNe06IISGht3Q/1qLIWkceORAbyLf8LKhxn0aG39g1o1iAYoQKTmOjxavWnmKExN3gyk/aAyn8RpN0Dc1AZDhyRwfLgLcLm0nlAyZNyPLtWZiVKeX84agu1kFEXG3FDJtOV5w3XOO/PDAL9Juu8sAerRwnMr7dmGgFqOa3LftuKBqwnV9W0TN2kwO2J2bRyZas2G8DamCgkqqMqjUX7N9orj22J74FR8wsCFISxSPYM070DaZjgOYRbegt4sauZjleerDmk31vizWRuJldB+3xj80bwUdapTkE3YfC5vdiOhehYjb22BapkAZpMtX5UsgH112+itDNnQEWRA9pvmOfrjpJF3kLTh89aG9GD+zcARwYLpGKidaFKG+ffxUQY56ENqVuvCvMWRf/BPyw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7284.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799012)(451199024)(64100799003)(55016003)(2906002)(478600001)(5660300002)(4326008)(52536014)(38070700009)(41300700001)(66556008)(66946007)(76116006)(66476007)(66446008)(64756008)(54906003)(316002)(110136005)(8936002)(33656002)(71200400001)(6506007)(9686003)(8676002)(7696005)(86362001)(26005)(83380400001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TU1SSFdHVk1SekxFQm5iSFdmWGhxNExIRGRkVnJoQXRHa0JwSlVkeVZQMTZr?=
 =?utf-8?B?OURveEtuODlNRENSWUNHZ21vUnhzZElUL2JQdWpQM3ptaFNaMStXMnQ0ejBz?=
 =?utf-8?B?cEhYZS9MYVJpYVBsODdNSTd0QURWT3ZmSTI0QkJsWmdKYjJLbmNzZEppZ1JY?=
 =?utf-8?B?N1VKMWdSNmZWZE9MMVVGSkcxM0ZvQ1lKb0M1d2J4bU5PSmloRHZybGxnRDdH?=
 =?utf-8?B?R2Q0dFNxVzVFNythaDhVSXk3YTkvVi80UllwNzlXUFJFQjNYenI2dEVoSkpu?=
 =?utf-8?B?K0ZwdUNaUzF3U2tFU0VJbzFoWFNiQkd3aGxjZ3kzRm9kbHVKRlN2QW53cFdG?=
 =?utf-8?B?STZ2R1NvWGxrSHBFd1Q1cHh5M1JXSDBacEpFQWk5MHdOY1drZjlUZlg2eEtw?=
 =?utf-8?B?WjhGeUExOTZqUVJja1k3Q0F5VzB3bHhkaHN4ZUtmaEJPV1Z1eUNiRncvakZr?=
 =?utf-8?B?cHhpRGlqbnNVUk5XejYrVGY4UU1lTmt2dkJmamlFeUhMMHlYV3dBV2ROMmNa?=
 =?utf-8?B?VS9hWXRUVzZTMlJwZnA4SVhkMWJHa0syMFZGTkxZRHBEYmI2QUtvRXl2a0dU?=
 =?utf-8?B?TlZNKzZMT0Y1UXdTcXE0ajdJWjgwRm1pMmVhMkRKZFBLa3NGQXdFTWYvVndH?=
 =?utf-8?B?d0pjTnl0cmFkTmhMQW96TFRGTHhaNVltRnpKb1BBLzZrSnd2dTBMSUJEMUJq?=
 =?utf-8?B?QmdGMUNMOFB4UzhhSmVLZkI4U3JoamNMVGx6Zm9NLzkrclhWZFRMdDlIb3Nm?=
 =?utf-8?B?bmhHM0l1UGtpRitnUmVkNU9XY1E1TUtRVG80UkxpbHZyYXZTU2dGV0s4ajdR?=
 =?utf-8?B?blcyUEo4VGJYdWpNZ2lvQ0J1VmdhejFkcyt0cHdWR1BUOUd5L0czZlBJVFZK?=
 =?utf-8?B?QjNndjdEcWFVVi9XbGk2eGppOTVwQnNEejZ3b3FVWkFkazNtY1hjV044UHhx?=
 =?utf-8?B?T1ZCdFdodXc2QUtsU0dkcGY3UURpNDZjRVg2dHk4OVNEb1JBRUNTeTVhQkpz?=
 =?utf-8?B?TkovYWxzUC9McHJFbUJwQk9vR3d2UjJ4cysvbHlFU1g3R3V6aVFkVURtM2Zp?=
 =?utf-8?B?WFJxenZvV1dpakxHMmNZWGJpZFp5WGNvd05FYXJzcVBWUmpxaW1NN2FKZW0x?=
 =?utf-8?B?RUdmSTJLTW9mR3J3TUg2WmxGNHFjKzBiUzY5ZjlTSGtyajM4L1Bna3RlWFMr?=
 =?utf-8?B?b3l1OGdYNnNOY2xoNUVZZ0tsY3BuWnZWdEFxNWtyZ2tTR3NrT292OFhSVVQx?=
 =?utf-8?B?WExUM01uQUdFQlRjSWZNRzVpc2dhQ0lha0M4WUpRMjdWYzhYL0o3VmZibC90?=
 =?utf-8?B?THFTbTFHcHd2VS82VTBZV3cxby8xZE5GUFd4VTlFQlI1cE10U0cvSEkvTUZK?=
 =?utf-8?B?b1Q4SHkvTDNUcTdobXJ5S1hQbk9yaDcxUEN5Z0ZLOFljZ0R0WlFPbHh6a0xS?=
 =?utf-8?B?cVFPNTZpT0lhZzVhanFST1hzVVNiYThFN3ZXbzBHQ3V0cEFjdTkxZ3p5NXow?=
 =?utf-8?B?R3Z6TERQaVZRblUyRitTRFZpb0Zwc2x6TndJcUV5WDAyYUdZSlZiblhLcUZn?=
 =?utf-8?B?SEUzL0RvaGVMRFNZY0hIYzN5dndXQ1Z6dzAwcDMxa1NaTStUUXoreGJtcDF6?=
 =?utf-8?B?WGJtdVlicUNuQWR4Zy9qeEVsSkRJcGt6Qy95c3QwRkI3NU95Rkw0dGdGOWNM?=
 =?utf-8?B?MzhGSklMOEtKdE9yOGZ5d1dPUXpZWGhIQXM1Z0drVC9SNEkxNHhXQnVFbDBm?=
 =?utf-8?B?czBTVTZ0Mm1aTjlhUVZrZDJSRVh0QTlYcTRERDBBYWRKU0UzMStGTFZGWHdq?=
 =?utf-8?B?OVhkY1B3enVROU5scTgwZjhKWjZkVkMvNmdqc04xb3JFS2lwWGpMd2s1cnJl?=
 =?utf-8?B?M3U1QXZoMjFpbEpjMWRDRU50UllBa094VEl5QmJXRDJva2syNHZIL3l5aXF3?=
 =?utf-8?B?MUhFRFhSYy9YdzFXNGt6aGRpcXplWUI5ckpiRVRXVFNtRncxcS9zcEM1WnVR?=
 =?utf-8?B?NjB6OWZEclArR1UxWjJiZi9vRENIYjk2SFp3VHNWekJOZloxVTUvaHdwdFNY?=
 =?utf-8?B?YkMwbXNWMlZwbWNjYzlPNEF1Rnc4R3AxTExuWnFHVUVQVkgyVk1aZ3BLZnpj?=
 =?utf-8?Q?CujY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a7a518-5659-4fd3-629d-08dc1105907c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 11:24:37.6319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYuWF3QZzoKc6lF1kVBw76kUuMbgQrX+f+03G2/upjFSPZt3msGPE65iu3YUrxsh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135

SGkgU3RlcGhlbiwNCg0KVGhhbmtzIGZvciByZXZpZXcuIFBsZWFzZSBmaW5kIG15IHJlc3BvbnNl
IGlubGluZS4NCg0KVGhhbmtzLA0KTmFtYW4NCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+RnJvbTogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPlNlbnQ6IFRodXJzZGF5
LCBKYW51YXJ5IDQsIDIwMjQgNjozMCBBTQ0KPlRvOiBUcml2ZWRpIE1hbm9qYmhhaSwgTmFtYW4g
PE5hbWFuLlRyaXZlZGlNYW5vamJoYWlAYW1kLmNvbT47DQo+YWJlbC52ZXNhQGxpbmFyby5vcmc7
IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbTsNCj5rcnp5c3p0b2Yua296
bG93c2tpQGxpbmFyby5vcmc7IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsN
Cj5tdHVycXVldHRlQGJheWxpYnJlLmNvbTsgcm9iaEBrZXJuZWwub3JnDQo+Q2M6IGxpbnV4LWNs
a0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZzsgVHJpdmVkaSBNYW5vamJoYWksIE5hbWFu
DQo+PE5hbWFuLlRyaXZlZGlNYW5vamJoYWlAYW1kLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENI
XSBkcml2ZXJzOiBjbGs6IHp5bnFtcDogcmVtb3ZlIGNsb2NrIG5hbWUgZGVwZW5kZW5jeQ0KPg0K
PkNhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNl
LiBVc2UgcHJvcGVyIGNhdXRpb24NCj53aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5n
IGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPlF1b3RpbmcgTmFtYW4gVHJpdmVkaSBNYW5v
amJoYWkgKDIwMjQtMDEtMDIgMjM6MjA6MTcpDQo+PiBDdXJyZW50bHksIGZyb20genlucW1wX2dl
dF9wYXJlbnRfbGlzdCgpIGZ1bmN0aW9uIHRoZSBjbG9jayBkcml2ZXINCj4+IHJlZmVyZW5jZXMg
dGhlIGNsb2NrIGJ5IG5hbWUgaW5zdGVhZCBvZiBpdHMgcmVmZXJlbmNlIGZyb20gZGV2aWNlIHRy
ZWUuDQo+PiBUaGlzIGNhdXNlcyBwcm9ibGVtIHdoZW4gdGhlIGNsb2NrIG5hbWUgaW4gdGhlIGRl
dmljZSB0cmVlIGlzIGNoYW5nZWQuDQo+Pg0KPj4gUmVtb3ZlIGhhcmQgZGVwZW5kZW5jeSBvZiBj
bG9jayBuYW1lIGFuZCB1cGRhdGUgdGhlIGxvZ2ljIHRvIHVzZSBjbG9jaw0KPj4gcmVmZXJlbmNl
IGZyb20gZGV2aWNlIHRyZWUgaW5zdGVhZCBvZiBjbG9jayBuYW1lLg0KPg0KPlBsZWFzZSB1c2Ug
c3RydWN0IGNsa19wYXJlbnRfZGF0YSBpbnN0ZWFkLg0KQ2FuIHlvdSBwbGVhc2UgY2xhcmlmeSBo
b3cgc3RydWN0IGNsa19wYXJlbnRfZGF0YSBjYW4gYmUgdXNlZCBoZXJlPyANCg0KVGhlIHp5bnFt
cCBjbG9jayBkcml2ZXIgcmVjZWl2ZXMgY2xvY2sgcGFyZW50IGluZm9ybWF0aW9uIGZyb20gZmly
bXdhcmUgYW5kIGl0IGlzIHN0b3JlZCBpbiBzdHJ1Y3QgY2xvY2tfcGFyZW50LiBJbiB0aGlzIHBh
dGNoLCBJIGFkZGVkIGxvZ2ljIHRvIGdldCB0aGUgcGFyZW50IGNsb2NrIHJlZmVyZW5jZSBmcm9t
IGRldmljZSB0cmVlIGFuZCBnZXQgY29ycmVzcG9uZGluZyBjbG9jayBuYW1lLiBDYW4geW91IHBs
ZWFzZSBleHBsYWluIGhvdyB0aGUgc3RydWN0IGNsa19wYXJlbnRfZGF0YSBjYW4gYmUgdXNlZCBm
b3IgdGhlIHNhbWU/DQoNClRoYW5rcywNCk5hbWFuDQo=

