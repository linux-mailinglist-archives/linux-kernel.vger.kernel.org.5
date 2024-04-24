Return-Path: <linux-kernel+bounces-157434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFCF8B119E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30EE28C6CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43D116D4F1;
	Wed, 24 Apr 2024 18:00:19 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2093.outbound.protection.partner.outlook.cn [139.219.146.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9375F16D4D1;
	Wed, 24 Apr 2024 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981619; cv=fail; b=Cs/ywUA0RgJS/3xRfPleiaCCI3i6d0ZZw/luFX/usET1Nw+Huc/i5ijlXtaOUXjaIfB012sy+czn9oGJPekgwfQUlNh7T+x4GoS1b5bYcvNUchIITWD+jtW43esNqC6w/W7h7z/XZemOfYgdCTIL0DgGr249CE09nr0xYmq+CAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981619; c=relaxed/simple;
	bh=muNbbZwLJWpwhQH4CvoKj6jHRw7OCbXlavC/YbTmxX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PU0cQhKgFpGT5yfHCTpnN7jQ0Qrgwhu6ZSEHOpahCjMT+Li4iTRkvrw9DMBOWd/DBn60OBkN4gIl9Fp5p7B1AXRwF2311ZZijklG3U1ka/7/lYJjrxCnp5xEozKbKUWatDBSe8R7UPaarGelfAH0zYGJ23b2GSNSYuS/TUAnoHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtHLnIFc8hTpaPssMxfhRGhud1+4ISQLhzVBwUck9PCZKdpL6e483mRs667ZK0NmkezYj36rbKUM4dWs7RthgX29mrbfrLiKVrVASx3igI5iZYP04EvjuhKFG2swiAGzA0yJdlXr+U/cJ4IwA4fNlNZrkJ6ZeLFEBD4vrmQOL0ZNoGus0xuPnlCDZVg4bF8b4CWE031Kb7TzZw+2XaaNgFfNxmjscekvuceXETjj/MVxfiAHOi1tWcNUAtFQT+IcxxqDmIcw3a5d+jUjdnNtiQu5r3Bxn/7GVqsJeVOJFwdQUGh2HC2pXotNuaCWDhmj7EG9aCC7pYhKuY1kUnotZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muNbbZwLJWpwhQH4CvoKj6jHRw7OCbXlavC/YbTmxX0=;
 b=gNI3bxoAVEK2hrz1ahSObhD3ZaRsKaEMtnVfVYq263Yp0PFdpME83keNhaxCVPQmD/fUOH52DfGD7G0ZlmWHVclynY3ret0/h7uDBQc1jnmzbsRXCVDIqzJlx1PqkUwDGl9m7eGtvTMe2Dl8NmlOkiDN1H1P/VM+ZyCadGy+aL0tZIvQ8cajpj55gyr+/W/OAw8ycfC2HvT9upp+I8+iiHiJ7OiyE+SMrLFhMMbWSMsEwgELv31ZZk0LC6W1bLFc9LkAzIRmtms8fi+w30T2uPTPm9qjD/hiM/ffR6Fqx0u1VSi8PjEizp1x24zzJcMbfvTZh5OLyFLJc6MUj/thOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0570.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:26:52 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 15:26:52 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"conor@kernel.org" <conor@kernel.org>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>, JeeHeng Sia <jeeheng.sia@starfivetech.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v3 1/2] cache: Add StarFive StarLink cache management for
 StarFive JH8100
Thread-Topic: [PATCH v3 1/2] cache: Add StarFive StarLink cache management for
 StarFive JH8100
Thread-Index:
 AQHalh1PRoL0YjHNUEq+ss3l976a9rF3N0uAgAA4OgCAAAhagIAAAw4wgAAEmwCAAAByQIAAA08AgAAGZ+A=
Date: Wed, 24 Apr 2024 15:26:52 +0000
Message-ID:
 <SH0PR01MB0841139F57DB0C3BB873094EF910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
 <20240424075856.145850-2-joshua.yeong@starfivetech.com>
 <CAJM55Z-C7XkFo4STk3rdLG4kvPfed-AfrHB1QJ-Tzt1LDoKw9w@mail.gmail.com>
 <SH0PR01MB0841F8C45091E4A08020ADF2F910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <CAJM55Z9NAeRb_3ZBJksXt+4fJMdcYw55bfAs0EpSnM8VWBKQag@mail.gmail.com>
 <SH0PR01MB08415B9CDDFB1A4FAB0FC4A9F910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <CAJM55Z_G5EKSjHztCQ+gXDGwfpziZTE=HsHmwydJWB-uorMOqA@mail.gmail.com>
 <SH0PR01MB08410B2FCAE1D9AA754865BFF910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <CAJM55Z-6vqSjL3GPT7GqC1k01zH8+zexSpcOFFUpuZELAQxARw@mail.gmail.com>
In-Reply-To:
 <CAJM55Z-6vqSjL3GPT7GqC1k01zH8+zexSpcOFFUpuZELAQxARw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0570:EE_
x-ms-office365-filtering-correlation-id: 82c554d4-b2a9-4002-efc2-08dc6472f7f6
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1TLfIxq7Lt/8d8R7qRoeEcb48oTuokfyhG+F9RsbQwLlgN3gjPcRUW77KYGHoDmcWgrUeUbxp8QYeIUNysXLyn2pGn48KtxnyGRkJq2wFZpT5tzSO0xSTMhNkT+baM1yTEx4vrnp8Yd5oqxbOOTOuWEzNyqM4FYtis9o1ZwOB/rLbTgPRBtQwIwoza4DlCgCZEJA17z8BOXYP8uc8USej79a/HTm9WsxW/D8fscNLzWVNXMjsBrBazvRH9RrzQVoTL1Qj+sZNwYKkpy0oeZHJN3jTnQT03/I7R1XyTCs8+BrSA4BN7fxGAGgY4QExLqwvLfshdcVVBb/B3ZGnuyZacaO2uPIFtdEJaV1yOA/C20DOw0cv8Tg0nWSOM6eKMkncwtKOjkUtFK57FpwgKMDONsbfPegZ8Fyg8EkKvfRd3MuObJ6Hgor95LWAFrMxEc0SO+/ODQkIVDj9MC6NdCVyoByKwNnhiZ70uBOOwAlrnGEiQ6C2Z2vpr4iXNWTq6iRPnKQch+/Dy55Ehwn/AxbJ++UM0sV2Ck32h5N1UVyWnenlRZYPVTwcOsLRMYGQBymTkW1amWWEnyasxmq4DTYgywA/mhe3KxJpE57iHQlgRX1xG+kM3Nump/IpLiioih/ScyLd0OpuWWId1Xqp421nw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(41320700004)(366007)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cldTWVllOTZMakIyMlJ6c0hvN3B2SjkwYTZJVEhnRDBLODdjMkZ4UUs0SkUy?=
 =?utf-8?B?QlNwc2tzUElaZzBLVUlFN091a3NRMUhmY2I3T3hSbFdaempxdm94YUFJcGk4?=
 =?utf-8?B?Rkk2K3FiNWo2WlFjN2NSMnNxditRcnhkUk90a2dYQ0hjUXlURjRPdUlOMkRW?=
 =?utf-8?B?REV2Q0FJN1hkZnBiWFZrZy9yVk5LbWl4d2NCK1VPb3hQaHN5UWNCNi9vZkRM?=
 =?utf-8?B?elVLRkVrTW1zRnhkQ1VmbExmb0w3djAwd0V1NHZadnJtc2o3bDV0TFBaYXdm?=
 =?utf-8?B?RGVpSkJZa2RvV2psOXpWa2p0eTdVc3dEdTNqQUlyVHM0OWVEN2pNbTdNc2xl?=
 =?utf-8?B?ZHZiV3J0Zzdwb0hVb2FRWVpseklVcTBVRmJIZnhFUUNPMUhOakl6aUJabmk0?=
 =?utf-8?B?NVVXSDVFQm5nN25iZE95dVM3a0NVdlpWVStpbitLd0M0MkJCTjh6bEE5aGV1?=
 =?utf-8?B?cjJhd3hXSnI3NlRTV0ViSnhoQUpZQWpmYXFqKzZrWTRNMTJITVRISkFROGN2?=
 =?utf-8?B?bGk4WXJPNy9WYzBUMDFsbjFLU1h0MzZ4bUNVRE0xQTdqVzZsaDJ1bFdENTNa?=
 =?utf-8?B?Sk1hVWhNaHM3czVvb2ZlZmFSWGdJTFdCQ0lVOU1SeEZiSFp2S1BLeGtNZjll?=
 =?utf-8?B?cDd6anhmMU0wL2R3RFhYcWVCaFJzUDhhUHBuUysvb3JvcDVNdnZXS3BselFZ?=
 =?utf-8?B?ektyUHFsM0lPR3ZMTk8zRC9zSklUaDIyWVNSVmFHRG1HemNobHRjU2ErMkll?=
 =?utf-8?B?ajl1dGVHWGtjR0xMKzVXbklXU3N2S3lveW1McnhISWt2Wk1KTkVoMWFOL0xh?=
 =?utf-8?B?QTBsMGt1S0hVQ3YzTE5ZbWhwaCtzTWJmdXpKK2g2WlBCejFNWWYraTAreDR2?=
 =?utf-8?B?QlJJZUNVWE43SWNmaFc2VlhNOHhITHY0YXBHd3c2NFpkYnM3NmtaNTdGemVW?=
 =?utf-8?B?Sk9kYVBScWNuVGlrRk5IdC9nNi84b0IrZHovbFpNdS9kTERSZ0c5WnZzTHNm?=
 =?utf-8?B?eDdRRGs3eENBdWpIRjRneU5jMTRKejh2RFVzbVMzeGRUa3NYN2k1MkxWVDU0?=
 =?utf-8?B?eDRFbjdYQ1REQnJJbTUxcjNkbUhsRGtHMzAwK09sRCtGaFdqOEp5MmlOREto?=
 =?utf-8?B?OUxjYytNYUVGa016MHR2V0I5elBCNHM5NnovaVJYVXpsVTVIaTVXNWc5Uy9j?=
 =?utf-8?B?bS9Nd3RSSXAvNmRKMEI2UkFMZ3YxNWI1dE9CcW9GUVdnNThtWkF6Qk45R1lk?=
 =?utf-8?B?YU5pU2NyK3dpZTRXMENOeGF3NEQxYkVkQTNDbEJtcHZXZC9PaS8zYmxVdERa?=
 =?utf-8?B?aXUrT0kxY3lMSjBrcFRpTWNGL2dIdlRFSlo2N2xDTmorcEJFaDZWUTN6aG44?=
 =?utf-8?B?TnhUdVFkdlZ5MVVzbGJPUGZiQVBXbGc5RGdHakFKc3lRdDJBK3hJTkl0aDRr?=
 =?utf-8?B?dTQ1L2ZJQjUvLzVJY2JLQlo5WEpxdUhBeXRQR2lNV1dEUERzVGFjS1FxWW4y?=
 =?utf-8?B?eStvT2lxQXF1MFR5TXU4U1VVY0IxYnU4N1ovc2pQTVlNbGtqQUtsSGw5UlB6?=
 =?utf-8?B?YTNOQ2REZm5ZaVZYcDgyTlBQU0ZTNmU5ay92NXFGRnBSdm53WlprcHg2Rjh1?=
 =?utf-8?B?dkdIVXpUS2tNNEZjQzVTdkhmdnhnTkVrcWgyOFNPOUFidkdwS3E1a3B3R1pF?=
 =?utf-8?B?NXIzdmlHL2lVbmQ2YXprQjg3SHVQVjM5OFBzQjd2TCtvc09yQmlOUlJjNXVt?=
 =?utf-8?B?cVdXUDFPOTFlT20zNkE4a1pJQzhEaUl5YzIyS0JhL0dvbG55OU91MjcyNWVI?=
 =?utf-8?B?N0FoMHhRRFVhZDQvSjlBcDBFLzNia1QrbFJyMTNWT01ZVndyYVVPMHJnbGVD?=
 =?utf-8?B?ZFZ3VkxtUWxxVU5zMW5pRHh6M2owUlJGb3FOcWxVc2N3TjlsT3RucjRBK2JQ?=
 =?utf-8?B?V3JyUURjWjU5U1pQbjNaZjN4Q0p3Y0pXdWlpWThiekxiR0t1NldkTm9rZmVJ?=
 =?utf-8?B?S2hVY0VFRWk0b2JrZWlFTmp3YjRHMTRMblltTnBaOS9TMkROVmVpL0RzUkR6?=
 =?utf-8?B?MjlLUlhLVmxJaWlwcGN6VXNaRWhCL0paM0YwOHFLZmFaekZNNTJDQWJhU2pW?=
 =?utf-8?B?MmIxZmp4aDlnbXUrWCtyZVdXS0ZjNFV4aUdoUiszaW1URUVlVG9MWTAwV0RG?=
 =?utf-8?B?UkE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c554d4-b2a9-4002-efc2-08dc6472f7f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 15:26:52.8469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0IduvzxDBKrH1+/dy6LN2w5SJPCtptpBYJ+ClvgX+piuQVWXiMEeye2Ofcdsa+D3zBVMonjPqf6Li/E39VhKSRbaSeIDtPYZ2tx3SjT/qNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0570

RW1pbCBSZW5uZXIgQmVydGhpbmcgd3JvdGU6IA0KPiBKb3NodWEgWWVvbmcgd3JvdGU6DQo+ID4g
RW1pbCBSZW5uZXIgQmVydGhpbmcgd3JvdGU6DQo+ID4gPiBKb3NodWEgWWVvbmcgd3JvdGU6DQo+
ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEVtaWwgUmVubmVyIEJlcnRoaW5nIHdyb3RlOg0KPiA+
ID4gPiA+IEpvc2h1YSBZZW9uZyB3cm90ZToNCj4gPiA+ID4gPiA+IEVtaWwgUmVubmVyIEJlcnRo
aW5nIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBKb3NodWEgWWVvbmcgd3JvdGU6DQo+ID4gPiA+ID4g
PiA+ID4gQWRkIFN0YXJGaXZlIFN0YXJsaW5rIGNhY2hlIG1hbmFnZW1lbnQgZHJpdmVyIGZvcg0K
PiA+ID4gPiA+ID4gPiA+IEpIODEwMCBTb0MuIFRoaXMgZHJpdmVyIGVuYWJsZXMgUklTQy1WIG5v
bi1zdGFuZGFyZCBjYWNoZQ0KPiA+ID4gPiA+ID4gPiA+IG9wZXJhdGlvbiBvbg0KPiA+ID4gPiA+
ID4gPiA+IEpIODEwMCB0aGF0IGRvZXMgbm90IHN1cHBvcnQgWmljYm9tIGV4dGVuc2lvbiBpbnN0
cnVjdGlvbnMuDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBKb3NodWEgWWVvbmcNCj4gPiA+ID4gPiA+ID4gPiA8am9zaHVhLnllb25nQHN0YXJmaXZldGVj
aC5jb20+DQo+ID4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvY2Fj
aGUvS2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAgOSArKw0KPiA+ID4gPiA+ID4gPiA+ICBk
cml2ZXJzL2NhY2hlL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgIDUgKy0NCj4gPiA+ID4g
PiA+ID4gPiAgZHJpdmVycy9jYWNoZS9zdGFyZml2ZV9zdGFybGlua19jYWNoZS5jIHwgMTM1DQo+
ID4gPiA+ID4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gPiA+ID4g
IDMgZmlsZXMgY2hhbmdlZCwgMTQ3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4g
PiA+ID4gPiA+ID4gY3JlYXRlIG1vZGUNCj4gPiA+ID4gPiA+ID4gPiAxMDA2NDQgZHJpdmVycy9j
YWNoZS9zdGFyZml2ZV9zdGFybGlua19jYWNoZS5jDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jYWNoZS9LY29uZmlnIGIvZHJpdmVycy9jYWNo
ZS9LY29uZmlnDQo+ID4gPiA+ID4gPiA+ID4gaW5kZXgNCj4gPiA+ID4gPiA+ID4gPiA5MzQ1Y2U0
OTc2ZDcuLjkxODFjZDM5MWY1MyAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJz
L2NhY2hlL0tjb25maWcNCj4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2NhY2hlL0tjb25m
aWcNCj4gPiA+ID4gPiA+ID4gPiBAQCAtMTQsNCArMTQsMTMgQEAgY29uZmlnIFNJRklWRV9DQ0FD
SEUNCj4gPiA+ID4gPiA+ID4gPiAgCWhlbHANCj4gPiA+ID4gPiA+ID4gPiAgCSAgU3VwcG9ydCBm
b3IgdGhlIGNvbXBvc2FibGUgY2FjaGUgY29udHJvbGxlciBvbiBTaUZpdmUNCj4gPiA+IHBsYXRm
b3Jtcy4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ICtjb25maWcgU1RBUkZJVkVf
U1RBUkxJTktfQ0FDSEUNCj4gPiA+ID4gPiA+ID4gPiArCWJvb2wgIlN0YXJGaXZlIFN0YXJMaW5r
IENhY2hlIGNvbnRyb2xsZXIiDQo+ID4gPiA+ID4gPiA+ID4gKwlkZXBlbmRzIG9uIFJJU0NWDQo+
ID4gPiA+ID4gPiA+ID4gKwlkZXBlbmRzIG9uIEFSQ0hfU1RBUkZJVkUNCj4gPiA+ID4gPiA+ID4g
PiArCXNlbGVjdCBSSVNDVl9ETUFfTk9OQ09IRVJFTlQNCj4gPiA+ID4gPiA+ID4gPiArCXNlbGVj
dCBSSVNDVl9OT05TVEFOREFSRF9DQUNIRV9PUFMNCj4gPiA+ID4gPiA+ID4gPiArCWhlbHANCj4g
PiA+ID4gPiA+ID4gPiArCSAgU3VwcG9ydCBmb3IgdGhlIFN0YXJMaW5rIGNhY2hlIGNvbnRyb2xs
ZXIgb24gU3RhckZpdmUNCj4gPiA+IHBsYXRmb3Jtcy4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ID4gVGhpcyBpcyBhIGJpdCBtaXNsZWFkaW5nLiBUaGUgSkg3MXgwcyBkb24ndCBoYXZlIHRo
aXMuIEl0J3MNCj4gPiA+ID4gPiA+ID4gb25seSBvbiB0aGUgSkg4MTAwIHNvIGZhciwgYW5kIGhv
cGVmdWxseSBsYXRlciBTb0NzIHdpbGwNCj4gPiA+ID4gPiA+ID4ganVzdCBpbXBsZW1lbnQgUklT
Qy1WDQo+ID4gPiA+ID4gc3RhbmRhcmRzIGZvciB0aGlzLg0KPiA+ID4gPiA+ID4gPiBTbyBtYXli
ZSBzb21ldGhpbmcgbGlrZQ0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiAiU3VwcG9ydCBm
b3IgdGhlIFN0YXJMaW5rIGNhY2hlIGNvbnRyb2xsZXIgb24gdGhlIFN0YXJGaXZlIEpIODEwMA0K
PiBTb0MuIg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEhpIEVtaWws
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhlIFN0YXJMaW5rLTUwMCBjYWNoZSBjb250cm9s
bGVyIGlzIG5vdCBkZXNpZ25lZCBleGNsdXNpdmVseQ0KPiA+ID4gPiA+ID4gZm9yIEpIODEwMA0K
PiA+ID4gU29DLg0KPiA+ID4gPiA+ID4gV2hpbGUgaXQgaXMgdHJ1ZSB0aGF0IGl0IGN1cnJlbnRs
eSBleGlzdHMgb24gdGhlIFN0YXJGaXZlDQo+ID4gPiA+ID4gPiBwbGF0Zm9ybSwgQ1BVL1NvQyB0
aGF0IGRvZXMgbm90IGNvbWUgd2l0aCBaaWNib20gZXh0ZW5zaW9ucw0KPiA+ID4gPiA+ID4gc3Vw
cG9ydGVkIHdvdWxkIG5lZWQgdG8gcmVseSBvbiB0aGlzIGNhY2hlIGRyaXZlIHRvIGRvIGNhY2hl
DQo+ID4gPiA+ID4gPiBtYW5hZ2VtZW50IG9wZXJhdGlvbnMuIEkgdGhpbmsgd2UgZG9u4oCZdCBu
ZWVkIHRvIG1lbnRpb25lZA0KPiA+ID4gPiA+ID4gJ0pIODEwMA0KPiA+ID4gU29DJyBoZXJlLg0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gV2FpdCwgaW4gdGhlIHByZXZpb3VzIG1haWwgeW91IHNhaWQg
dGhhdCBmdXR1cmUgZGVzaWducyB3aWxsDQo+ID4gPiA+ID4gaW1wbGVtZW50IFppY2JvbSBhbmQg
bm90IG5lZWQgdGhpcyB3b3JrLWFyb3VuZCwgYnV0IGhlcmUgeW91J3JlDQo+ID4gPiA+ID4gdGFs
a2luZyBhYm91dCBvdGhlciBTb0NzIHRoYXQgZG8gbmVlZCBpdC4gU28gd2hpY2ggaXMgaXQ/DQo+
ID4gPiA+DQo+ID4gPiA+IElmIHlvdSB2aXNpdCB0aGUgY29tcGFueSB3ZWJzaXRlIGFuZCBsb29r
IGZvciBTdGFyTGluay01MDAsIHlvdQ0KPiA+ID4gPiB3aWxsIGZpbmQgdGhhdCBpdCBpcyBhIHN0
YW5kYWxvbmUgSVAgdGhhdCB0aGUgY29tcGFueSBpcyBzZWxsaW5nDQo+ID4gPiA+IGFzIGFuIGlu
dGVyY29ubmVjdC4gQW55b25lIHdobyBpbnRlZ3JhdGVzIFN0YXJMaW5rIHdpdGhvdXQgWmljYm9t
DQo+ID4gPiA+IGV4dGVuc2lvbnMgbWF5IHV0aWxpemUgdGhlIGNhY2hlIG1hbmFnZW1lbnQgb3Bl
cmF0aW9uIGZyb20gdGhpcyBJUC4NCj4gPiA+DQo+ID4gPiBTbyB0aGVuIHRoZSAib24gU3RhckZp
dmUgcGxhdGZvcm1zIiBwYXJ0IGlzIHdyb25nPyBPciB3aWxsIHRoaXMNCj4gPiA+IGFsd2F5cyBn
byB0b2dldGhlciB3aXRoIHRoZSBEdWJoZSBjb3Jlcz8NCj4gPg0KPiA+IEl0IHdvdWxkIGJlICdv
biBTdGFyRml2ZSBwbGF0Zm9ybScgd2l0aG91dCAnSkg4MTAwIFNvQycgdGhhdCB5b3Ugc3VnZ2Vz
dGVkLg0KPiA+IFN0YXJGaXZlJ3MgbmV3ZXIgY29yZXMgdGhhdCB3aWxsIGhhdmUgWmljYm9tIGV4
dGVuc2lvbnMgc3VwcG9ydGVkLg0KPiA+IFRob3NlIENQVSBjb3JlIHdpbGwgbm90IG5lZWQgdG8g
aGF2ZSB0aGlzIGNhY2hlIGNvbnRyb2xsZXIgZW5hYmxlZC4NCj4gDQo+IE5vLCB3aGF0IEkgbWVh
bnQgd2FzIHRoYXQgaWYgeW91J3JlIHNlbGxpbmcgdGhlICJTdGFyTGluay01MDAiIElQIHRvIG90
aGVyIFNvQw0KPiBtYW51ZmFjdHVyb3JzIHRoZW4gaXQgd2lsbCBub3QgYmUgcmVzdHJpY3RlZCB0
byBTdGFyRml2ZSBwbGF0Zm9ybXMuIFNvIHRoZW4NCj4gIlN1cHBvcnQgZm9yIHRoZSBTdGFyTGlu
ayBjYWNoZSBjb250cm9sbGVyIF9vbiBTdGFyRml2ZSBwbGF0Zm9ybXNfIiBpcyBubyBsb25nZXIN
Cj4gdHJ1ZSwgcmlnaHQ/DQoNClllcywgeW91IGFyZSByaWdodCBvbiB0aGlzLiBBRkFJSyBKSDgx
MDAgaW50ZWdyYXRlcyBTdGFyTGluay01MDAgYW5kIHdoaWNoIGlzIHdoeSANCndlIG5lZWQgdGhp
cyBjYWNoZSBjb250cm9sbGVyIGRyaXZlciwgSSBkbyBub3Qga25vdyB3aG8vd2hhdCBlbHNlIHBy
b2R1Y3RzIHRoYXQgDQptaWdodCB1c2UgdGhpcyBJUC4NCg0KPiANCj4gL0VtaWwNCg==

