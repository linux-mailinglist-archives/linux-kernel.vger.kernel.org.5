Return-Path: <linux-kernel+bounces-93091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B571872AF7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56A7281F74
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99A912D21E;
	Tue,  5 Mar 2024 23:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="k2d1o7a7"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19011003.outbound.protection.outlook.com [52.103.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05517E581;
	Tue,  5 Mar 2024 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681056; cv=fail; b=NWlF75FY9Bpkc/bUuIPM/INZSvgnRovMhULYfw9WyU2PmGfABldDKaCUzCESbPJiOpP9keUbvDY97KKPyiQOK6OVpikQ5oSjhwb9yy9gvrLwXHugd7p7VV+kqln0yz6l1TnAEoEr8vknaCEdODRYQ4bEaWDXPNPZwyeUbs6Zl64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681056; c=relaxed/simple;
	bh=mG3qZ0NSU54f0iqeqUGV3cjeAENa7Lb4JokdEsWEZrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W/v26WsdD6yLv2dNQbd5BWAXPvJ7LSpCUGx4c/md2vzy1kVsCnYsUIRTnSMTkxDWNPMEzrQ9/78IVhMcHOq0xnZ/hbecFtaBv96zwAf+KSI2zNefhpdwih6tPS+7urG/UTjotKB8TK3Qw73wgBQW/qhOc/dXN4XskID7/1JLmkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=k2d1o7a7; arc=fail smtp.client-ip=52.103.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrUF0BBGiiyYmFNk8qdJWe4MJR9xEYMxraV8h8Rfy8pQ2ka9JfG4unQKmZGon88L/BMgm3gBPhzrOhJ/zUdic7DbgX603+PmJu8+/HK/eS3AEtRA+XZPUwjKXQtt1LU5JLvMR5ZfmYV840tox8Jix8sDRKDVaHJEmzX40P2qHnDOzjYTjUeZvojjvQt/Gk2LOQ3EpLNX4EcwYZFQmgXzfpHdl2g6Puu5xkGZChRRegZ4r6Lq7DbdfBhUlT5vz8xD1GXEjWAqbcRBwKaA85I0nURolGmIhCIIgdXc/f0nBdtYGantjbM+f+WkvyTg41IkJTuzuTOLtTXd2bnrmdw0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mG3qZ0NSU54f0iqeqUGV3cjeAENa7Lb4JokdEsWEZrc=;
 b=oIGM3QNt7oBHw6++y4xi6Bn9VkRQ3MAxs8BonATzhtaomUjE6v118t3iwrcf78RagQzndZc74OubvxOJo45vvJGbSzBd3XRYdOOV7JGVe3sez6Qyl2KtQ6E0KQR0ciLmVqYX1Zv3vFgCRO7rKaU782tSL591PXB5FNRJfH1/H0rXEl7lXWz7BOYmaXomNnrrIbGyLYcqxAyDaTzSXDN6VLDj0T7CAOM298Ctmal2H3scGiUCtBUgfheKk78PaYk2jYKd09ttvVKAVmFPWzrGE4YJ5QDMlPw4JElW5FfY1uwu7PcGHzcIKuyM/bWUZ/f2qiDN5w9RCpOsW/Golz8DjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG3qZ0NSU54f0iqeqUGV3cjeAENa7Lb4JokdEsWEZrc=;
 b=k2d1o7a7dut+NSwA4V91Kp0r1mu7JhFzcTeMRMeQe0M7PvLV80BqSMNobQ9ywAUU62ku6hqUvcKPcQetzhIxssbZWIJPPErirF4+2Taii4jXVTXPXRAV+Ar9WSZXZdYsLPOTm+nYnxjTs2wTL799KoyFdr66+KBVQ006NdxiNEQg84HLD6T4T6S7zx9YNHT3OcNDWNcyzzixsJ1SWyNbP0gYl9YarbG/eg6l/nJkqMyhyW/+/pbazRBWBFOyqs6A9o3Kn1sdE9CBQFk7wC095LcoF6iuKTEfXTWBgEDuhXoIQeYmXQXuN9WtCd84LxPOj0ZTUZ9yn84nJVVL5UkPNg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYVP286MB3166.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 23:24:10 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 23:24:10 +0000
From: Qu Shengyu <wiagn233@outlook.com>
To: Conor Dooley <conor@kernel.org>
CC: Qu Shengyu <wiagn233@outlook.com>, "ganboing@gmail.com"
	<ganboing@gmail.com>, "kernel@esmil.dk" <kernel@esmil.dk>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"lee@kernel.org" <lee@kernel.org>, "andre.przywara@arm.com"
	<andre.przywara@arm.com>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v1] riscv: dts: starfive: Remove PMIC interrupt info for
 Visionfive 2 board
Thread-Topic: [PATCH v1] riscv: dts: starfive: Remove PMIC interrupt info for
 Visionfive 2 board
Thread-Index: AQHabyBCK3akJNOj+km1UpRZx4upRrEpjAeAgAA+LGg=
Date: Tue, 5 Mar 2024 23:24:10 +0000
Message-ID:
 <TY3P286MB2611ACAF9F648ACA2BE157FE98222@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References:
 <TY3P286MB2611C5F5833F3E3E1AE838CA98222@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20240305-macarena-fiber-f2460d371150@spud>
In-Reply-To: <20240305-macarena-fiber-f2460d371150@spud>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [xYMP4Tm9vBkRUVeWtzAHGEK1k1R1Ds0nonLzW7u+H36bo8rssxhDgHC2xFBL4an6GkDjyezOvtA=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3P286MB2611:EE_|TYVP286MB3166:EE_
x-ms-office365-filtering-correlation-id: 9a7047b1-54bb-4b0b-1693-08dc3d6b5ca9
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mosxes1o2U/qQRr2zm57uU3z43OF3uA9DArt8Ne4TeyHWrfOArInGzl7hGMCDfjNwOK2nMh5m5vbtkFLlWMs/d3JWkA/AbFk2JjgmZo55IL2qZjU/zAADhbcQ8fz+QgPqtoG4eiCChzWuKHFEiB0Hms018f1atwuOOoHuNZ+MMswBxehqLqzucGp5YETy9efNnlrKxRVNBFc/fmJ5Agbfcj/lboPsdgKL9lbZ0jwngBLMk9e6Ba5M8qO8Ce9y6kLzb3GISRke/Q9OdRyHPlVfVjlzc68Sk89FCrNoz8NCSnCX6AzgzkRTKRH3d4b1yBUSmDyrp+4k5T5rFVxJOH5DlKhZPjTVCs2HwuFndHk4G7I0W8/stCq6y7k9aicl/+fGG++CG7Vi64fzNtm9tyOrTe5D1aRoE21WCW29HaMiW/gXV5CQZOsXH+Hwl4qbJFw9TSXPinKOxux3kunGi2ReNIRfjXx8a9XCVLgtdraqXEp5Irg0Cd0j0lqrMHQokaQTfu0FiaP5AbFX4+HY8Nq7qPvdLKAivr4J4Tstr/ps/j7lSiIYFFG3LB4BLLQnpoJQm2X/LKdme1ePtzqYmaU0sy22Hnq2c1XewnzI+k95swL/dag75rrhdAz5tAFnHfRogiw8qF9GVDql7MH9/LkXy/fgt/YVPrxQ3V5zz3k+Seg3ZSW0i7Na64HdItQNt4V
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGlJZWYvUmVLdVFoK3FuL2JWeUxWWFQvQk80VXFFMjAzSERLSVlHYmhidVFj?=
 =?utf-8?B?ZnNabGx4R1IwTWd0b1NZT1FwQ2kva0hCVVE1ajYxOStyamlUV0YrNmM3YmNk?=
 =?utf-8?B?UWRxM1c3R2RtMXFCV1cvYStIQ3VNeUZmRVFXbE9hL1lRV3lKbjZ6eTh1ek9C?=
 =?utf-8?B?enVrK3dnNlBJMXo5ZEczUDdvNi93SzkrdmpLMkNIOTdxRUVNck5YQzBBdmRw?=
 =?utf-8?B?QXFDNkVuMmZYWWJnQzE3WE5HV1poQzhzYUNQd0xFUkxINytoOHMvMnNPaWt6?=
 =?utf-8?B?OFJERU9mVFMzbi85cTJwRlFYYkxVRDdKOHBFWGhwSm93K1haZEV1SklqQ2Vi?=
 =?utf-8?B?QXhCamJVcnNxTGRjdmRGaWlIbzZ5b1pSTFMvUHFLUXh0blNpdTN1dUV5Kzhx?=
 =?utf-8?B?QjBEcURpdTlqbzhjVjBpVFhyancrQVd1OGZZR21wYXk5eWFxK3JCUkY5YSs2?=
 =?utf-8?B?aEE5aE5PekVqNWpyNkxuTUNaTmJJZWpmY0dMd3I3OUVDZVhVaGxtQWdEMndh?=
 =?utf-8?B?L1BkUzF0TVZMR2U4ZysvR213OUxCNVRvam5lVmM3UmhUT043V2MvSUQvcFhI?=
 =?utf-8?B?WEs1aElmRnZ6VHUxWUhiODhxT2lWbDd1WTBuRGJYb0RGTUlqTHVxNlR2WU1h?=
 =?utf-8?B?MVhUTTZteEQ5aVBYaVN5eG5OTnhzbndqbnJITSt4RFBZaVJpRzM5VElYUml4?=
 =?utf-8?B?Mk9ib3FqY1d6OFh6M2NkYzlzWG5rekN0Z3J4dVBHS29BTHJRTGpXa1ZTdVF4?=
 =?utf-8?B?eTlnYVdjMXNhcnFtUUw3UWNYSmRtRVdxWk9KMGVSMTJzRWNxL0drRVE0K1BM?=
 =?utf-8?B?dXhSRzNPRW1HelkvZzA5NnhpdFZNazA0b290RVczY0JKUUh5SU5pN1Q3QnVx?=
 =?utf-8?B?QlpDa0VUU3ArSlpyVU51aXF1RmFDQ2NPb3NyVDUzTEhoZWlRL3NSczRYK2Rp?=
 =?utf-8?B?UU80U0N2bVZkZldwTWJzUGVlTDY5bTZWYWhYcVMyK3ZUUG5MTHVGQWROaUZF?=
 =?utf-8?B?cEYrOWRieFIxcnRJZEsrMnl1eS9ESTlRMkJXNGluQWxDcjcrckxnYmEzRGlJ?=
 =?utf-8?B?QXNnMkxSVnN0NW5BeFdSeUE3R2kyZ0dsa3VWSGlUNWgrMmtRRkhubDE5WTZq?=
 =?utf-8?B?Zm9RVWU1blhMVldaQ254ODNRT1ViTW1Kd1Nqd1ZVOFZtT2VWYnVmZy9ZcXB5?=
 =?utf-8?B?cVFhUDF1QUNpSkdzdGVEeFNVUEtNQm9KMGpUdE9jSjM1SVVHNTF0bWR0Uzhz?=
 =?utf-8?B?blk4MytTMVdIMitSVk85YWpWM1Q2VkxOa05IalY2YlBycmxGb2xlWlZHcFQv?=
 =?utf-8?B?T05UMzVNZk03SURVV281di9idW96ZVNQcGZPSlhIK1dPc1FXOHlrRHNmeUhL?=
 =?utf-8?B?T2s2L3BQSGhROE45K0JTYStwRktGRjRZUW9VeUw5cXdLaUxTSHZISmRWMDNK?=
 =?utf-8?B?L2s2ZkRjbmFXbGQzcmFKYmJOUHhGR1M3aS9zYkE5WjJDeVpFRC9EbVE2cGJl?=
 =?utf-8?B?bzdPRFVwWVNpQ1NkNFJzK3JKazA3eGNvV1h5UjRhLzlPdk1kRjI3MEFhbXVD?=
 =?utf-8?B?MUxMRUJhR2VOekg5TVhxQS80dml3V0JXMSswS1RYNUplNUhCM1lKT2ZQcjJx?=
 =?utf-8?B?aS9BZXIyQ0k0WFBCUUg3Q05PTTMzMnFGRjVGeXZ3Tmp3NFpWc0Q5UzNNV1Yz?=
 =?utf-8?B?SXJSVjhEMGRMekh3T1JjY2Q2NDJmRFJFWGd2cDYza0dDVFI1djNDUUlyd05x?=
 =?utf-8?Q?iM+8+yngdfXsT5QDMY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7047b1-54bb-4b0b-1693-08dc3d6b5ca9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 23:24:10.4854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3166

SGkgQ29ub3IsDQoNClRoYW5rcyBmb3IgcmVwbHkuIEnigJltIHNvcnJ5IGZvciB0aGlzLCBidXQg
bXkgZGlzdHJv4oCZcyBkdC1zY2hlbWENCmlzIHRvbyBvbGQgdG8gcnVuIGR0YnMtY2hlY2suIFdp
bGwgZml4IGluIG5leHQgdmVyc2lvbi4NCg0KQmVzdCByZWdhcmRzDQoNCj4g5ZyoIDIwMjTlubQz
5pyINuaXpe+8jDAzOjQx77yMQ29ub3IgRG9vbGV5IDxjb25vckBrZXJuZWwub3JnPiDlhpnpgZPv
vJoNCj4gDQo+IO+7v09uIFdlZCwgTWFyIDA2LCAyMDI0IGF0IDAxOjExOjUwQU0gKzA4MDAsIFNo
ZW5neXUgUXUgd3JvdGU6DQo+PiBTaW5jZSBjb21taXQgYjJjYjJhZTIyMjc4ZjE5MThmNzUyNmI4
OTc2MGVlMDBiNGE4MTM5MyAoIm1mZDogYXhwMjB4Og0KPj4gR2VuZXJhbGlzZSBoYW5kbGluZyB3
aXRob3V0IGludGVycnVwdCIpLCBpbnRlcnJ1cHQgaW5mbyBwYXJ0IGZvciB0aGUNCj4+IEFYUDE1
MDYwIFBNSUMgaXMgbm90IG5lZWRlZCBhbnltb3JlIGZvciBTdGF0Zml2ZSBWaXNpb25maXZlIDIg
Ym9hcmQuDQo+PiBBbmQgdGhpcyB3b3VsZCBjYXVzZSBrZXJuZWwgdG8gdHJ5IHRvIGVuYWJsZSBp
bnRlcnJ1cHQgbGluZSAwLCB3aGljaCBpcw0KPj4gbm90IGV4cGVjdGVkLiBTbyBkZWxldGUgdGhp
cyBwYXJ0IGZyb20gZGV2aWNlIHRyZWUuDQo+IA0KPiBpbnRlcnJ1cHQtY29udHJvbGxlci8jaW50
ZXJydXB0LWNlbGxzIGFyZSByZXF1aXJlZCBwcm9wZXJ0aWVzLCB5b3UgY2FuJ3QNCj4gZGVsZXRl
IHRoZW0uIElmIHlvdSByYW4gZHRic19jaGVjayB5b3UnZCBzZWUgdGhhdCBpdCBjb21wbGFpbnMg
YWJvdXQNCj4gdGhpcyBwYXRjaC4NCj4gDQo+IElmIHlvdSBqdXN0IHJlbW92ZSB0aGUgaW50ZXJy
dXB0cyBwcm9wZXJ0eSwgd2hhdCBoYXBwZW5zPw0KPiANCj4+IENjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnDQo+PiBGaXhlczogYjJjYjJhZTIyMjc4ICgibWZkOiBheHAyMHg6IEdlbmVyYWxpc2Ug
aGFuZGxpbmcgd2l0aG91dCBpbnRlcnJ1cHQiKQ0KPiANCj4gVGhpcyBGaXhlcyB0YWcgY2Fubm90
IGJlIHJpZ2h0LCBhIGR0cyBwYXRjaCBjYW5ub3QgZml4IGEgZHJpdmVyLiBUaGUgZHRzDQo+IHBh
dGNoIHRoYXQgaW5jb3JyZWN0bHkgc2FpZCB0aGlzIHVzZWQgaW50ZXJydXB0IDAgaXMgd2hhdCBz
aG91bGQgYmUgaW4gdGhlDQo+IEZpeGVzIHRhZy4NCj4gDQo+IFRoYW5rcywNCj4gQ29ub3IuDQo+
IA0KPj4gUmVwb3J0ZWQtYnk6IEJvIEdhbiA8Z2FuYm9pbmdAZ21haWwuY29tPg0KPiANCj4gQ2xv
c2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi9jOGI2ZTk2MC0yNDU5LTEz
MGYtZTRlNC03YzljMmViYWE2ZDNAZ21haWwuY29tLw0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IFNo
ZW5neXUgUXUgPHdpYWduMjMzQG91dGxvb2suY29tPg0KPj4gLS0tDQo+PiBhcmNoL3Jpc2N2L2Jv
b3QvZHRzL3N0YXJmaXZlL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTIuZHRzaSB8IDMgLS0t
DQo+PiAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBh
L2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUt
Mi5kdHNpIGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlz
aW9uZml2ZS0yLmR0c2kNCj4+IGluZGV4IGI4OWU5NzkxZWZhNy4uNmJlYmFiZTNmYTM3IDEwMDY0
NA0KPj4gLS0tIGEvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUt
dmlzaW9uZml2ZS0yLmR0c2kNCj4+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUv
amg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpDQo+PiBAQCAtMTg5LDkgKzE4OSw2IEBA
ICZpMmM1IHsNCj4+ICAgIGF4cDE1MDYwOiBwbWljQDM2IHsNCj4+ICAgICAgICBjb21wYXRpYmxl
ID0gIngtcG93ZXJzLGF4cDE1MDYwIjsNCj4+ICAgICAgICByZWcgPSA8MHgzNj47DQo+PiAtICAg
ICAgICBpbnRlcnJ1cHRzID0gPDA+Ow0KPj4gLSAgICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7
DQo+PiAtICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPj4gDQo+PiAgICAgICAgcmVn
dWxhdG9ycyB7DQo+PiAgICAgICAgICAgIHZjY18zdjM6IGRjZGMxIHsNCj4+IC0tDQo+PiAyLjM5
LjINCj4+IA0K

