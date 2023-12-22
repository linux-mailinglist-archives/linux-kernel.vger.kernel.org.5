Return-Path: <linux-kernel+bounces-9473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7473A81C629
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E331D1F25C10
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860A7C8F7;
	Fri, 22 Dec 2023 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="h7/EIfzy";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rA/1xf7/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13DC111BB;
	Fri, 22 Dec 2023 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ac445592a0a011eea5db2bebc7c28f94-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+fyODwomjIUB7Ht+kzgtBLTezhEcW2jnF/5u0u588Qg=;
	b=h7/EIfzyJboNbXl8ViuqwMZnc/7H6Krd/piYChXVXZrs+24CVy76qRMEkCEctnCnR43JT4Bz3HqBBeIn0BSCTMW7VsvLy/Er51kg531BNdeW0z4zlXDD2V0OR6Q+3SHl+hH6O7O0vSSJtr/03AMD3+d2lCkjrqLxEPWZmMXCZVk=;
X-CID-CACHE: Type:Local,Time:202312221604+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:62c5b8f2-35fb-4de1-950c-d37ddfc04571,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:c8b88e7e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ac445592a0a011eea5db2bebc7c28f94-20231222
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <william-tw.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2136853858; Fri, 22 Dec 2023 16:04:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Dec 2023 16:04:02 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Dec 2023 16:04:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8HUeC/In3vRnsHXmHGIJWZI0de8VXf/DaxLUJLGFfCXC0bWw2/Ub2h+pAeU2ihYncpt8wS846DDOKlU5eWCX4IqUiO9X3tbCJ9HjtidnF3DET2+Wu4si/eFYZykNQKNd+k0xKbaPwpXLUkNwOSOWDyRvpkWPsDALIdxx7EIluChQVTZYgp3UtrQH8fy/7Eb1i9+1hT0SxbtMmIUJO24IVFo+xxTLzaZKIsGlTi7QgLmkUgrwHugT3aWI0Vg+YvoKYFVIEnqqdo8F0NZIjqcBz7aQcgo05w1SdbFEI/vT6rDS/UnSNbGQX9AkMOxP+XYEmPzzXOUcU1lecrVnaNHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fyODwomjIUB7Ht+kzgtBLTezhEcW2jnF/5u0u588Qg=;
 b=f0kXRWk/m2AVlOmYRkvmzYEln0lzRqbBGcGQNqcsGHTWnBmbHV7zvHBw1vE+4J018fnDBpoZ+TxuancpWFe2jXQiHGbhPjB9b3uC6F9yTlTuR7qNXLH2WS3fgIvjiNmZ7NVh7d7k52IynTidmi66iVwCrYdV3hnuvwTf2DzWY2Q+eXJwc7JzEI87CqBdE1nqAWjBvrI3iKjqlyLdBblkeQgQUywCQjZImVeqpAf7Sr1+mG0cpnOZXClQXESomxbRnhJRg+DVdLa4eKgKdsg3eUYAvuHGU+3++FhaITV46aGdl0cY163zrej65pYMVAg90z69onGvO+3OC4NWapkVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fyODwomjIUB7Ht+kzgtBLTezhEcW2jnF/5u0u588Qg=;
 b=rA/1xf7/Z8whCVMJa80NfgH/ijR4XJ/KZvrPRNtSgBHjEGJXGbQ8rDPsqvN+Ub9RSI1vM1qqoYCHFOdBic3+U5g9QVchnsS+c7CIHDkcc5b/NhEOkLO+BUkD7oXIcrqS9gE0x2pVf4jc1WBx8HUBtI85Amz/sTkM0WcldGqri+E=
Received: from TYZPR03MB5406.apcprd03.prod.outlook.com (2603:1096:400:39::8)
 by TYZPR03MB5469.apcprd03.prod.outlook.com (2603:1096:400:39::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 08:03:36 +0000
Received: from TYZPR03MB5406.apcprd03.prod.outlook.com
 ([fe80::7bc3:66:4e44:6c12]) by TYZPR03MB5406.apcprd03.prod.outlook.com
 ([fe80::7bc3:66:4e44:6c12%5]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 08:03:36 +0000
From: =?utf-8?B?V2lsbGlhbS10dyBMaW4gKOael+m8juW0tCk=?=
	<William-tw.Lin@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] soc: mediatek: mtk-socinfo: Add driver for getting
 chip information
Thread-Topic: [PATCH v3 2/3] soc: mediatek: mtk-socinfo: Add driver for
 getting chip information
Thread-Index: AQHaMzDO9/93g4Oh+0uLsEeB3cLSlbCx/xyAgAL1O4A=
Date: Fri, 22 Dec 2023 08:03:36 +0000
Message-ID: <0abd8bacbc61a649af125f6ff1a0ac5fc4841e34.camel@mediatek.com>
References: <20231220103901.22180-1-william-tw.lin@mediatek.com>
	 <20231220103901.22180-3-william-tw.lin@mediatek.com>
	 <508c9b5a-61d9-4e42-8faa-c6f48f453235@collabora.com>
In-Reply-To: <508c9b5a-61d9-4e42-8faa-c6f48f453235@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5406:EE_|TYZPR03MB5469:EE_
x-ms-office365-filtering-correlation-id: 72f0bdaa-1223-433f-a460-08dc02c47fe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bjCF3dt+q/YcYhnmDWZdfhiQdADQ5DPaWJdJd7eJDXY/KSCmzr/RNH1UNh6Si3iMj7i3/iD3Zc5BuYL8s1W27ptGlBb92E0MxkNeE1qqOC5SSPs/a2OFn2g+0nwpDix42ceS51LcthOcgW7DK4z54ixmwhxRCD4uCZzPI2sr3H8SqwSfAAxmH7GwpCzBHBA/d+i9yJ4CyF2SINhayORzNT+LmhQr+uTpIP2b/rKNjGAtWeGz21O23zMpCqYj58m3JM9BpUpECaK/C6LoPNBNx1CxW6hhu6cOCyb6NQMBlLb94XRuMbHbPkPK7ZRPX5s2I2sotP7iX8Mt60Gh/rmkhaHW2CH9qhMyCrGM80ssAjWwhmkRH7py0fdq8PULSxiFZehTvmF1jXUAAs2/3SNIV7hO3ru9KXS6u0harHDlDMR7ipWt1f/5DYcshBWlhCe792Oua2sat2F2zk7Li0EF9VwMaQZIbMr3PDT0hXjdnh/v9Jg3So+PYZYyt6KNTJ8beemSMffXZMeGXhM5uldpD1vk6iZy/07S/NkD2pd14CT8VyqvZGkUxawLYjSNJHGUOn365Gy+JUuH2EomBfXfOhelzlz1NFQi4eHG9SOAobzk9D/0K4YXrepr/R8pUdb0ikbuJ004Rj2PPBrLsrx3QskftkNDDIABeTM5Xg2m8Uw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5406.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(478600001)(6486002)(4326008)(38100700002)(122000001)(5660300002)(54906003)(110136005)(66476007)(316002)(66556008)(76116006)(66946007)(66446008)(8676002)(8936002)(64756008)(26005)(83380400001)(2616005)(71200400001)(6506007)(6512007)(85182001)(36756003)(41300700001)(86362001)(2906002)(38070700009)(4001150100001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STIyTkIxbGtQbzJIT3B6aXF2R0dhN1lEMHFyWEhaODEyN2MvZ0F4Rkp6OEZS?=
 =?utf-8?B?cjNVN09HVi9US3pGU1ZlNjdrUmRVakNrcm13SVRReHkwS1lINi9FMkpPbUov?=
 =?utf-8?B?S1NSZkhyQnd2bkFpWHlFU3BZUlg2am9pOStSaTRNR2xUZ3p6U3RMV3VzQnVG?=
 =?utf-8?B?dUVwT0wzQU42QTZmSnp6bjNPS1JGNGlQbUd5ZWVZd0UvZ0NQTXByOTM5aWpK?=
 =?utf-8?B?MUhLL2MxbXRqM2JhNVJwdTRpNHNuNHpZQTJsOVhZdUpxUHJHNTZrWGwxMkR0?=
 =?utf-8?B?Wk12dTFWYmpiZUVyUmZzTDdjTzFNNGdHN2ptZVF2cmxmMncvaFJCcnNmaWZw?=
 =?utf-8?B?U0dnR01JdTR2RGcvSTVjV21iRTNxMlRFZ2lUbFd2VmpxZEhLd3VSRlNrQWJB?=
 =?utf-8?B?aWMrTDVERzNpU0hBYTVsWVp1UzVrb1EyRDZ5WjlrdHh2Rmw3US8zOUFpUUxx?=
 =?utf-8?B?d2hPUUplbFpKMXRRRnNiTGR1T1ZvY2RRblJJNXVkR0J1T0orVFNYdGpxMkJm?=
 =?utf-8?B?aXpiVFN3TldxelVoaHFpQ2VGMUN1dXF3bVBaSms2cFd1UGJmbUs1M1BNZ0Jl?=
 =?utf-8?B?NzYrSlcycWIrRk9KVDBOYVVncUFQY3BsdHZLclBRazJVL3oweldjRDMrM2Ew?=
 =?utf-8?B?N1dGU2R5VytYb1p4aklZWDBvTlFLUnhWZi9FRkFmV05GZ0JsTHMzQkRlWEpz?=
 =?utf-8?B?bWNWdUVKWFk0NGlWZm9UMTBzazdsKzFxZFAwdnN0a09HOTYwQVpZN01pWXgx?=
 =?utf-8?B?dlZCeldQTVB1UmcyUHAxc05aenBJMTZsVEc4a05yOTFzV2NXeGdBdHFNaFBW?=
 =?utf-8?B?bXh0ek4waUpyNmdIUXowR2d5WW56dGZWWExrQ3RMQkVGL3Y4YUpiVXZtZ2U3?=
 =?utf-8?B?YkVaTzBXK0N5cjBzeU9yOGJtTEtUbnIwb3ZzeEorTWtIdFpjN0xzR0hSbkdL?=
 =?utf-8?B?TVo5c2ZQR1dFd1kwYmxucTBJSGI0Q1NHdnZSWXNoQ2xIOFNWS0prSU5uOXVx?=
 =?utf-8?B?clNJU25BRE84cVJ2ejRJeGNZcDBrcUVGUlpLWEtMSm8yVGVhcDl1MnZ1Wkth?=
 =?utf-8?B?ZVVBWjNWREZVVlJ2aWJWcFdVTWN6aDRhczUxWktvT1NTODl2SUZneFliNm5h?=
 =?utf-8?B?d2hPcDd5N3U3SFhHU0VtNy92ZEpwMmc2cTA3S1RxZTRVVkdNak5WWCtIQTZD?=
 =?utf-8?B?ZTllclZsbXB2eVJkMFBaRTMyY3VhWjE5WDVqcnlxU1Z4bUk2bEtnaHZYODFu?=
 =?utf-8?B?Vm1rcHpBanNLSjFPQkY5SVFBL2xobWx0eXVpbThLOUt3b09QQ1NaallZcGdm?=
 =?utf-8?B?eXBPQjdiRzJYaUViQU9hQlR0Z0ZTaTJMZ250U1FTSkFvNDVyUmRuWU5EYkxa?=
 =?utf-8?B?RHlFdDRLdU5zWnJTb3NTVDFPR0d1VWlHbjRRRzVyZU1HQWEyN0psdXIxbDZv?=
 =?utf-8?B?WWhjbno1TmdhVFR5T0hEcnQvcVZ3aXZMWUVKMHNKSEM2SjF4ZXpRbERiV3l5?=
 =?utf-8?B?emVLVzh6d2VJVGVwYzdUREUyS1o1Z2U4OG40R0VwdEZsQVBHU0lEeHFJWjhz?=
 =?utf-8?B?dFVtZTFEZ2FTaHVRcGU2NlJLYmpMMU5uZ1Q0U3o4eGxZM0paMnhHNHpiY01h?=
 =?utf-8?B?R21maWdOUGZQRTBOdm5kMlFsdk9VWFRldmM3TGg0VlVKMlJaeHlnUjBNNWtj?=
 =?utf-8?B?YjlRUVdxV1hPb2Zqa0RNbkRkSTRuNTR5Mm45a3hYYXNxTmhIYUdJNUZxQVpD?=
 =?utf-8?B?cjFhRzN0MTV2UFdWQWpqbGFYR2RuWG9nY29ZN2NGSFZSdkg2cXc0V29qTlRk?=
 =?utf-8?B?YWplUlVPWDZkeVEwbDlVT3hFa2M1S1hZWXJYR0R2Z2RuTDZTNmVIZ2xaUHRz?=
 =?utf-8?B?cEx5dXVUS2Q0QkJXbCtjVmRaSFc1bDAvTHZ1b2kvcGVEci82VmQxdVhVRmJm?=
 =?utf-8?B?S0w3Zy92WWVwclE2WS9lOVpkRnpLc2w3cnRiK3UzaE5PcExEMEtsQkd6ald4?=
 =?utf-8?B?aVRuVUlIVEh0SmJ0ditNaDk0K0paN25SS3BIWmFSS0o1c211eWhGMUtzRkFx?=
 =?utf-8?B?bmxRUzcrZlBua3EzSWNvcW5QVzBTM21sYkhZTFRxeXVBRWg0dXlTRzhsNVNF?=
 =?utf-8?B?ZEMwRnhNaHJNWThka0piamZ5TlRwZW5XZjZCZHJKVDRGWEFOTUtrcHlLS3o2?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <574C4D085C60914AAC2DE43E499152CB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5406.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f0bdaa-1223-433f-a460-08dc02c47fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 08:03:36.2032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YsIiHyZbcOrx9wKxpX9vraG59NAm8US/HuLaZ1BUns3+e/BrS5Jt/l4QcLV8/nL3JcW6j+hjDVtaqDS19UKl9ZqDW5BSa+cJ7HT//Ys6xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5469

T24gV2VkLCAyMDIzLTEyLTIwIGF0IDExOjUzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjAvMTIvMjMgMTE6MzksIFdpbGxpYW0tdHcgTGluIGhhIHNjcml0
dG86DQo+ID4gQWRkIGRyaXZlciBmb3Igc29jaW5mbyByZXRyaWV2YWwuIFRoaXMgcGF0Y2ggaW5j
bHVkZXMgdGhlDQo+ID4gZm9sbG93aW5nOg0KPiA+IDEuIG10ay1zb2NpbmZvIGRyaXZlciBmb3Ig
Y2hpcCBpbmZvIHJldHJpZXZhbA0KPiA+IDIuIFJlbGF0ZWQgY2hhbmdlcyB0byBNYWtlZmlsZSBh
bmQgS2NvbmZpZw0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFdpbGxpYW0tdHcgTGluIDx3aWxs
aWFtLXR3LmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3NvYy9tZWRp
YXRlay9LY29uZmlnICAgICAgIHwgICA4ICsrDQo+ID4gICBkcml2ZXJzL3NvYy9tZWRpYXRlay9N
YWtlZmlsZSAgICAgIHwgICAxICsNCj4gPiAgIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zb2Np
bmZvLmMgfCAxODYNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMyBm
aWxlcyBjaGFuZ2VkLCAxOTUgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zb2NpbmZvLmMNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZpZw0KPiA+IGIvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvS2NvbmZpZw0KPiA+IGluZGV4IDA4MTBiNWIwYzY4OC4uZjM0ZDkzOTc3YmE2IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJz
L3NvYy9tZWRpYXRlay9LY29uZmlnDQo+ID4gQEAgLTY4LDQgKzY4LDEyIEBAIGNvbmZpZyBNVEtf
U1ZTDQo+ID4gICAJICBjaGlwIHByb2Nlc3MgY29ybmVyLCB0ZW1wZXJhdHVyZXMgYW5kIG90aGVy
IGZhY3RvcnMuIFRoZW4NCj4gPiBEVkZTDQo+ID4gICAJICBkcml2ZXIgY291bGQgYXBwbHkgU1ZT
IGJhbmsgdm9sdGFnZSB0byBQTUlDL0J1Y2suDQo+ID4gICANCj4gPiArY29uZmlnIE1US19TT0NJ
TkZPDQo+ID4gKwl0cmlzdGF0ZSAiTWVkaWFUZWsgU29DIEluZm9ybWF0aW9uIg0KPiA+ICsJZGVm
YXVsdCB5DQo+IA0KPiBBZGQgdGhlIGRlcGVuZGVuY3kgcGxlYXNlLg0KPiANCj4gCWRlcGVuZHMg
b24gTlZNRU1fTVRLX0VGVVNFDQo+IA0KPiA+ICsJaGVscA0KPiA+ICsJICBUaGUgTWVkaWFUZWsg
U29DIEluZm9ybWF0aW9uIChtdGstc29jaW5mbykgZHJpdmVyIHByb3ZpZGVzDQo+ID4gKwkgIGlu
Zm9ybWF0aW9uIGFib3V0IHRoZSBTb0MgdG8gdGhlIHVzZXJzcGFjZSBpbmNsdWRpbmcgdGhlDQo+
ID4gKwkgIG1hbnVmYWN0dXJlciBuYW1lLCBtYXJrZXRpbmcgbmFtZSBhbmQgc29jIG5hbWUuDQo+
ID4gKw0KPiA+ICAgZW5kbWVudQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9NYWtlZmlsZQ0KPiA+IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPiBpbmRl
eCA5ZDNjZTc4NzhjNWMuLjY4MzA1MTI4NDhmZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Nv
Yy9tZWRpYXRlay9NYWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL01ha2Vm
aWxlDQo+ID4gQEAgLTcsMyArNyw0IEBAIG9iai0kKENPTkZJR19NVEtfUkVHVUxBVE9SX0NPVVBM
RVIpICs9IG10ay0NCj4gPiByZWd1bGF0b3ItY291cGxlci5vDQo+ID4gICBvYmotJChDT05GSUdf
TVRLX01NU1lTKSArPSBtdGstbW1zeXMubw0KPiA+ICAgb2JqLSQoQ09ORklHX01US19NTVNZUykg
Kz0gbXRrLW11dGV4Lm8NCj4gPiAgIG9iai0kKENPTkZJR19NVEtfU1ZTKSArPSBtdGstc3ZzLm8N
Cj4gPiArb2JqLSQoQ09ORklHX01US19TT0NJTkZPKSArPSBtdGstc29jaW5mby5vDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zb2NpbmZvLmMNCj4gPiBiL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1zb2NpbmZvLmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uNGEyNTdiNWM4ZWRhDQo+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zb2NpbmZvLmMNCj4gPiBAQCAtMCww
ICsxLDE4NiBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+
ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjMgTWVkaWFUZWsgSW5jLg0KPiA+ICsgKi8N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9k
dWxlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgv
b2ZfcGxhdGZvcm0uaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L252bWVtLWNvbnN1bWVyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9k
ZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2RlYnVnZnMuaD4NCj4gPiArI2luY2x1ZGUg
PGxpbnV4L3NlcV9maWxlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9zdHJpbmcuaD4NCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L3N5c19zb2MuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ICsNCj4gPiArI2Rl
ZmluZSBNVEtfU09DSU5GT19FTlRSWShfc29jX25hbWUsIF9zZWdtZW50X25hbWUsDQo+ID4gX21h
cmtldGluZ19uYW1lLCBfY2VsbF9kYXRhMSwgX2NlbGxfZGF0YTIpIHtcDQo+ID4gKwkuc29jX25h
bWUgPSBfc29jX25hbWUsCQkJCQkJDQo+ID4gCQkJXA0KPiA+ICsJLnNlZ21lbnRfbmFtZSA9IF9z
ZWdtZW50X25hbWUsCQkJCQkNCj4gPiAJCQlcDQo+ID4gKwkubWFya2V0aW5nX25hbWUgPSBfbWFy
a2V0aW5nX25hbWUsCQkJCQkNCj4gPiAJCVwNCj4gPiArCS5jZWxsX2RhdGEgPSB7X2NlbGxfZGF0
YTEsIF9jZWxsX2RhdGEyfQkJCQkNCj4gPiAJCQlcDQo+ID4gK30NCj4gPiArI2RlZmluZSBDRUxM
X05PVF9VU0VEICgweEZGRkZGRkZGKQ0KPiA+ICsjZGVmaW5lIE1BWF9DRUxMUyAoMikNCj4gPiAr
DQo+ID4gK3N0cnVjdCBtdGtfc29jaW5mbyB7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+
ID4gKwlzdHJ1Y3QgbmFtZV9kYXRhICpuYW1lX2RhdGE7DQo+ID4gKwlzdHJ1Y3Qgc29jaW5mb19k
YXRhICpzb2NpbmZvX2RhdGE7DQo+ID4gKwlzdHJ1Y3Qgc29jX2RldmljZSAqc29jX2RldjsNCj4g
PiArfTsNCj4gPiArDQo+ID4gK3N0cnVjdCBzb2NpbmZvX2RhdGEgew0KPiA+ICsJY2hhciAqc29j
X25hbWU7DQo+ID4gKwljaGFyICpzZWdtZW50X25hbWU7DQo+ID4gKwljaGFyICptYXJrZXRpbmdf
bmFtZTsNCj4gPiArCXUzMiBjZWxsX2RhdGFbTUFYX0NFTExTXTsNCj4gPiArfTsNCj4gPiArDQo+
ID4gK3N0YXRpYyBjb25zdCBjaGFyICpjZWxsX25hbWVzW01BWF9DRUxMU10gPSB7InNvY2luZm8t
ZGF0YTEiLA0KPiA+ICJzb2NpbmZvLWRhdGEyIn07DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0
IHNvY2luZm9fZGF0YSBzb2NpbmZvX2RhdGFfdGFibGVbXSA9IHsNCj4gPiArCU1US19TT0NJTkZP
X0VOVFJZKCJNVDgxNzMiLCAiTVQ4MTczVi9BQyIsICJNVDgxNzMiLCAweDZDQTIwMDA0LA0KPiA+
IDB4MTAwMDAwMDApLA0KPiA+ICsJTVRLX1NPQ0lORk9fRU5UUlkoIk1UODE4MyIsICJNVDgxODNW
L0FaQSIsICJLb21wYW5pbyA1MDAiLA0KPiA+IDB4MDAwMTAwNDMsIDB4MDAwMDA4NDApLA0KPiA+
ICsJTVRLX1NPQ0lORk9fRU5UUlkoIk1UODE4NiIsICJNVDgxODZHVi9BWkEiLCAiS29tcGFuaW8g
NTIwIiwNCj4gPiAweDgxODYxMDAxLCBDRUxMX05PVF9VU0VEKSwNCj4gPiArCU1US19TT0NJTkZP
X0VOVFJZKCJNVDgxODZUIiwgIk1UODE4NlRWL0FaQSIsICJLb21wYW5pbyA1MjgiLA0KPiA+IDB4
ODE4NjIwMDEsIENFTExfTk9UX1VTRUQpLA0KPiA+ICsJTVRLX1NPQ0lORk9fRU5UUlkoIk1UODE4
OCIsICJNVDgxODhHVi9BWkEiLCAiS29tcGFuaW8gODMwIiwNCj4gPiAweDgxODgwMDAwLCAweDAw
MDAwMDEwKSwNCj4gPiArCU1US19TT0NJTkZPX0VOVFJZKCJNVDgxODgiLCAiTVQ4MTg4R1YvSFpB
IiwgIktvbXBhbmlvIDgzMCIsDQo+ID4gMHg4MTg4MDAwMCwgMHgwMDAwMDAxMSksDQo+ID4gKwlN
VEtfU09DSU5GT19FTlRSWSgiTVQ4MTkyIiwgIk1UODE5MlYvQVpBIiwgIktvbXBhbmlvIDgyMCIs
DQo+ID4gMHgwMDAwMTEwMCwgMHgwMDA0MDA4MCksDQo+ID4gKwlNVEtfU09DSU5GT19FTlRSWSgi
TVQ4MTkyVCIsICJNVDgxOTJWL0FUWkEiLCAiS29tcGFuaW8gODI4IiwNCj4gPiAweDAwMDAwMTAw
LCAweDAwMDQwMEMwKSwNCj4gPiArCU1US19TT0NJTkZPX0VOVFJZKCJNVDgxOTUiLCAiTVQ4MTk1
R1YvRVpBIiwgIktvbXBhbmlvIDEyMDAiLA0KPiA+IDB4ODE5NTAzMDAsIENFTExfTk9UX1VTRUQp
LA0KPiA+ICsJTVRLX1NPQ0lORk9fRU5UUlkoIk1UODE5NSIsICJNVDgxOTVHVi9FSFpBIiwgIktv
bXBhbmlvIDEyMDAiLA0KPiA+IDB4ODE5NTAzMDQsIENFTExfTk9UX1VTRUQpLA0KPiA+ICsJTVRL
X1NPQ0lORk9fRU5UUlkoIk1UODE5NSIsICJNVDgxOTVUVi9FWkEiLCAiS29tcGFuaW8gMTM4MCIs
DQo+ID4gMHg4MTk1MDQwMCwgQ0VMTF9OT1RfVVNFRCksDQo+ID4gKwlNVEtfU09DSU5GT19FTlRS
WSgiTVQ4MTk1IiwgIk1UODE5NVRWL0VIWkEiLCAiS29tcGFuaW8gMTM4MCIsDQo+ID4gMHg4MTk1
MDQwNCwgQ0VMTF9OT1RfVVNFRCksDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10
a19zb2NpbmZvX2NyZWF0ZV9zb2NpbmZvX25vZGUoc3RydWN0IG10a19zb2NpbmZvDQo+ID4gKm10
a19zb2NpbmZvcCkNCj4gPiArew0KPiA+ICsJc3RydWN0IHNvY19kZXZpY2VfYXR0cmlidXRlICph
dHRyczsNCj4gPiArCXN0YXRpYyBjaGFyIG1hY2hpbmVbMzBdID0gezB9Ow0KPiA+ICsJc3RhdGlj
IGNvbnN0IGNoYXIgKnNvY19tYW51ZmFjdHVyZXIgPSAiTWVkaWFUZWsiOw0KPiA+ICsNCj4gPiAr
CWF0dHJzID0gZGV2bV9remFsbG9jKG10a19zb2NpbmZvcC0+ZGV2LCBzaXplb2YoKmF0dHJzKSwN
Cj4gPiBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghYXR0cnMpDQo+ID4gKwkJcmV0dXJuIC1FTk9N
RU07DQo+ID4gKw0KPiA+ICsJc25wcmludGYobWFjaGluZSwgc2l6ZW9mKG1hY2hpbmUpLCAiJXMg
KCVzKSIsIG10a19zb2NpbmZvcC0NCj4gPiA+c29jaW5mb19kYXRhLT5tYXJrZXRpbmdfbmFtZSwN
Cj4gPiArCQltdGtfc29jaW5mb3AtPnNvY2luZm9fZGF0YS0+c29jX25hbWUpOw0KPiA+ICsJYXR0
cnMtPmZhbWlseSA9IHNvY19tYW51ZmFjdHVyZXI7DQo+ID4gKwlhdHRycy0+bWFjaGluZSA9IG1h
Y2hpbmU7DQo+ID4gKw0KPiA+ICsJbXRrX3NvY2luZm9wLT5zb2NfZGV2ID0gc29jX2RldmljZV9y
ZWdpc3RlcihhdHRycyk7DQo+ID4gKwlpZiAoSVNfRVJSKG10a19zb2NpbmZvcC0+c29jX2Rldikp
DQo+ID4gKwkJcmV0dXJuIFBUUl9FUlIobXRrX3NvY2luZm9wLT5zb2NfZGV2KTsNCj4gPiArDQo+
ID4gKwlkZXZfaW5mbyhtdGtfc29jaW5mb3AtPmRldiwgIiVzICVzIFNvQyBkZXRlY3RlZC5cbiIs
DQo+ID4gc29jX21hbnVmYWN0dXJlciwgYXR0cnMtPm1hY2hpbmUpOw0KPiA+ICsJcmV0dXJuIDA7
DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB1MzIgbXRrX3NvY2luZm9fcmVhZF9jZWxsKHN0
cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgY2hhcg0KPiA+ICpuYW1lKQ0KPiA+ICt7DQo+ID4gKwlz
dHJ1Y3QgbnZtZW1fZGV2aWNlICpudm1lbXA7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5w
ID0gZGV2LT5vZl9ub2RlOw0KPiA+ICsJdTMyIG9mZnNldDsNCj4gPiArCXUzMiBjZWxsX3ZhbCA9
IENFTExfTk9UX1VTRUQ7DQo+ID4gKw0KPiA+ICsJbnZtZW1wID0gZGV2bV9udm1lbV9kZXZpY2Vf
Z2V0KGRldiwgIm10ay1lZnVzZTAiKTsNCj4gDQo+IEFyZSB5b3Ugc3VyZSB0aGF0IHRoaXMgaXMg
c3VwcG9zZWQgdG8gYmUgIm10ay1lZnVzZTAiIGFuZCBub3QgIm10ay0NCj4gZWZ1c2UiPw0KPiBM
b29rcyBzdHJhbmdlLg0KPiANCj4gRXZlcnl0aGluZyBlbHNlIGxvb2tzIG9rLg0KPiANCj4gQ2hl
ZXJzLA0KPiBBbmdlbG8NCj4gDQo+IA0KSGkgQW5nZWxvLA0KDQpUaGFuayB5b3UgZm9yIHRoZSBj
b21tZW50cyEgSSBjYW4gY29uZmlybSB0aGF0IHRoZSBub2RlIGZvciBtdGstZWZ1c2UNCmlzICJt
dGstZWZ1c2UwIiBzaW5jZSBudm1lbV9yZWdzaXRlcigpIGF1dG9tYXRpY2FsbHkgYXBwZW5kcyBh
biBpZCB0bw0KdGhlIG5hbWUuIFRoZSBjaGFuZ2VzIGZvciB0aGUgb3RoZXIgY29tbWVudHMgd2ls
bCBiZSBhZGRyZXNzZWQgaW4gdGhlDQpuZXh0IHZlcnNpb24gb2YgcGF0Y2hlcy4gVGhhbmsgeW91
IHNvIG11Y2ghDQoNCkJlc3QgcmVnYXJkcywNCldpbGxpYW0gDQo=

