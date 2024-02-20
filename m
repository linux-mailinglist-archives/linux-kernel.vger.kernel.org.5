Return-Path: <linux-kernel+bounces-73074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC9885BD2A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D150D1F22FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A570A6A33E;
	Tue, 20 Feb 2024 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="D5oXF7xa"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2102.outbound.protection.outlook.com [40.107.8.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E469E05;
	Tue, 20 Feb 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435839; cv=fail; b=SUZZlAN7bRKEkE3n6gyuzy6QjpyPzsENe9yQm/4LFcAeX6FhlthSIz7TascS9nLZbZyOlCMnBdwxjN7I/AMSQQMfQT+3bkbuEWyC46Y4cIcR3Kdue24sH/+ZcXAmiSJvE50SaW+6pcwow2slUlMXMkb4ifs3x9tJ7u5XwxcTWi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435839; c=relaxed/simple;
	bh=kMhkotITgP+j3P/i3SQR9yxeeogCKMDDsi5UV+8jilA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8ZjdVDBECecsR3h2w4OXyr1AJlmGpnQf6rncCj+xgtA4OS6T1m5TbD/nIGp91h9PIudbw6pdkb88van+hC3JIbcDG6ruOTVbAb4nBm/mHTs2wN7NA/c1wyoXwMBlbw+asyyjxrUPwPorP8sWTnvtXOw2UQpOFGEKgykliStBKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk; spf=pass smtp.mailfrom=bang-olufsen.dk; dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b=D5oXF7xa; arc=fail smtp.client-ip=40.107.8.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLu4Ki3qgri0TL57t5f7yem/DPrErIUCctPIPb+fSD9KgVXlOveFh0L2F6FhJZfi9WEBjNynqVZdZr2aE9MfIDJUkYHlppvnzDIs+thyArg0Hgc9+mIfhK7L64prusFYBkAvUre/aiwePvASDCUmCPx/fRoCv3gcH2Wo796oiRzaLPmeLVXI4zWlQgUWqOcPwmHFUoT1v2AMotx7xCTdRhqtw9EfUFmsSE7yVvZ+9hCSVEu5GvWOVx+6p6uhqutDiicJJL8I45QHCc/63DPMg0A1fEIOJbcOoBEApmH2n2THVuQmeL2BUqkMlwCAANVJxYoiRfWqRiGcipCHmBxV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMhkotITgP+j3P/i3SQR9yxeeogCKMDDsi5UV+8jilA=;
 b=jDaRYXJX6ZjnBRC/3Ib3OXi8W1nXNdvE7G1wTle4wc223ImTvCNXawj9WYluqZt0PM2ZfIKepR0SHlqawHKa12d5TpIwJMcWY1S/5Q/9QpWJ/GkYhIxQz1BUhMmtNGQxw2x+aR5ek0D4/wIhq40T6VwBhW5LpIxl0wSgRbZV8NEGLjBq4Ep5GHD/5YX22M1gSE2xLPfpEGzbxT0sCtInZCbhBJ7mZrWt3CqlXHPbTEM/2doTyhRYVGz1EhfqKRhSD8C7mp87ZDSNLoBoKwqS+jSDLDstlBFAwWKW5A0iznKfvWiMSlbBCQltO1UK1XBypuCVp4UP3taNgH6KQlSFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMhkotITgP+j3P/i3SQR9yxeeogCKMDDsi5UV+8jilA=;
 b=D5oXF7xa3Nu3fFGTwLXrOV9G9F3twlePVbayj1LxhNKZEVfyU4e7rqh9Y+1145IxibQ19RrtgqlIQCFcwbd3VTLXWe2XOsz5bAG7DWlpAVnhOUr0TApEQU+4LUoKE7hejKTADibexPRF56P/plzdMapfJfFED8y0C9XOHrCNVO8=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by AS2PR03MB10138.eurprd03.prod.outlook.com (2603:10a6:20b:5ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 13:30:33 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::3c77:8de8:801c:42a7]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::3c77:8de8:801c:42a7%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 13:30:33 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] net: dsa: realtek: support reset
 controller
Thread-Topic: [PATCH net-next v4 3/3] net: dsa: realtek: support reset
 controller
Thread-Index: AQHaY42tH0aJAWy/AU6VqyhRW8ot+rETB3+AgAAgaACAABLxAA==
Date: Tue, 20 Feb 2024 13:30:33 +0000
Message-ID: <s4r5fdkrci2thuv4o6pstdxwkh7vfsd3w63rlcke3qqz6pdqne@t5jvkqwpgy7r>
References: <20240219-realtek-reset-v4-0-858b82a29503@gmail.com>
 <20240219-realtek-reset-v4-3-858b82a29503@gmail.com>
 <lvt7su5mmf7b3w4gbxd6vlt25klsyziuuaznfzjy7d4oxz46qx@4dzc4cgmfkbc>
 <CAJq09z5ak_S3iFnGw+rw0JQwoxf=x69=Ync3Xg5AQ0hx_tsGXg@mail.gmail.com>
In-Reply-To:
 <CAJq09z5ak_S3iFnGw+rw0JQwoxf=x69=Ync3Xg5AQ0hx_tsGXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|AS2PR03MB10138:EE_
x-ms-office365-filtering-correlation-id: c7fbe951-daf0-488d-bc3a-08dc32181d8c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2+avN6Crp5lX9j+qFGbRMM2aqUUHKA2l4vkc3hZbmf8v0SqyhoVB49eVF6Ov13JhTPNZ1FOvI7AnX5NsXnxx08uS6IFpoxs6koLi/odB5a3nTZSUBAgaui8UcK1UUQzRv+f6BzUkdDgOnDIDd5eHanK7wzsyLyyfsRuDjq5bBr3wIpoMjG/AH2ixjhdX7D/ZhbEHbwTF33UbORG3TWU5QdXxu5jzr6w4kBHGAEfuV5mu5pmD9NsyFfwviqsAGgm7U+RNeD9nNrAcIrz9rLpAX5PtO3xwhNgN7Exmc4/CFuSpOcpgqcQf/quRdgjuqGCinCUCYnQeHWgdh7nwO6urf/3mvyGvZ9eA+miH7hLWr5fOd6Jd0FG3b+UoKOGahc2VxOH0QhUs5MQnnoPKXBAZK/MrTiYJ6dXDZ2BUMYoKz4Dz67hvNZO5n3XzsvleycCbi65zjdl2NJX6SgESnSpWBhfRjPKzgzf5Pze5M1dGQWw7CwBgz7x5CMLSz2RQdMgbcKmIrcZxNgBn5a03VSMKWdZJAj3Io98cyg5sfUlyWFh1WM0/icDvPc2d0p+RBYN076J3kYeb7y5qbOXrgeFeQfEG+toID7TYo44Qp42zCq+0TTHWwG5k1VbMjAkOscOs
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjRuZEh0c2ovdTRHK09Wb1JocWI4R25lZmNwNHNVYUNNUi9iTitOUGVyb3g1?=
 =?utf-8?B?aWtEK0xqMitnRW1RQzN3SWNoNUpUWWJGMC9PVlJQSFhibk5BVzJuQnRydGlM?=
 =?utf-8?B?ZVlVdUUwNjR3MXFiUkJ6L3MvZ0pMMVBCK3BIekZPRGFvc042ODJLcDEzVkJw?=
 =?utf-8?B?UDkvR0xQWGJTZm1VSWl2SzJUc29kNlF3bEI1bEk5NWFzVjJzb1NwZTRHUEpM?=
 =?utf-8?B?c2VldXBtUWM2ajlIVkJwODRqVEhYMnAxUzVYajl1WGtxdkdrTlNSZTdwWTZ3?=
 =?utf-8?B?WnZFSFRtdzhWTnFkSVNiTEtlTkRXUFpTcm80VXB6U1lJVExPY3picVZVU1pD?=
 =?utf-8?B?bThOUks3YnJrZGhMK2tHb1ZDa0tOSTFyMFlCQkxscE1taW4wUFUvSmQyelQw?=
 =?utf-8?B?R0JjZjFCVmdPbjQxcGNmNm1sdkQwY3JvWHMwSEc1WFN5V3Q0SFRDUEJEMVZn?=
 =?utf-8?B?bW42NTNjN0ZUM0wySEhUazZDM0NBK2x6dmhpY3Nrc0NxSHQyTzhJU0Q0UUJh?=
 =?utf-8?B?VGhCdDRGVG9odWJQbDNNeW9Tb1haRW1zcGh0M2RPZzFPeU1xRnByYlQzdWJa?=
 =?utf-8?B?TTJDR1BtOWJQdnE2a0ZVQm1uSE9pSGpqb3FCdlVLR0VHL3RJUXg2eVVURDhS?=
 =?utf-8?B?dVFCc1NRM0c4YVQ4UHl1K2YrNm9QQ2xoM241MkpSd1pPZ1o4Q010a2tuR1F0?=
 =?utf-8?B?UDBvR2lES0tSQWswZkZKNjlBUnVYNlJqRVNaNzNla0MwS1p2N2wrcmRESU5N?=
 =?utf-8?B?aUFhODNnTzFQMGIydXRXYTlkejE0NU9WTmxGclJhaG51VkJmZjRVS3QyNHVo?=
 =?utf-8?B?a3Z4cloyNXFmMFBkTGdpaXIwaDBkWjRNNmFVdlBlakVId0tzakVsQXRKZzkv?=
 =?utf-8?B?aTh6N3BSWmNTeTJQUitQTExsV2ZISVpzSVhMendNRnMxYWxVVXpVOWVNVity?=
 =?utf-8?B?N2QvV0tVVkZHQU1rUGFhOTdwRFZzVEFKTFV2dVhIdWE4L0Y2dGpKTWNKNktz?=
 =?utf-8?B?ZVV3UXAzZGJJd0dtanVtYXU1a0s3RjBsY3dBc3dBZmsyNmE5VG14TlNQcDVN?=
 =?utf-8?B?MGRwQ1NSMURXc1AwN24vaURzd2kwQmJ5SVgyQ24yZ1ZWWGhlcmd1WTdGTGh5?=
 =?utf-8?B?aGhtaGpmUVNrNmluOE4xUDRsMUhmU0toVDN0MUFMQWxld0xlS3VqM1dLTGRs?=
 =?utf-8?B?bHRKcjNIMmpUK0VCUXpVNzBWUzBtVnNoeUdMRERUbitvWkQyNDJOaVJRVXhj?=
 =?utf-8?B?TS95cWZ3SitOSHk2Z3NSS0NZUzlKbnF0RW5rakVNejRoY3ZwRllGV1htNUZX?=
 =?utf-8?B?aDIyeGNZc3kwNERrWVQ1TXJtd3BJdzZyS2FGVUpEUFN2cDlvT2JvMUtRc3V5?=
 =?utf-8?B?RVkxc2c3RklBTnJpNDhUT2lGTjQ4OFhBaDhjeXp5ZXZDbUZpRWlzK2VKQzFv?=
 =?utf-8?B?Mk5waUd2MjBzOVpZRENUdFdOcjFVY3I5TURCcG1zRHpldmtncjBFYjEzb1NM?=
 =?utf-8?B?SnJOOHFqRHRlSGlBVkE5WUZCOGdOcVd4MUlUZGVKTlNzSTRBT1ZNdHNDM2R4?=
 =?utf-8?B?UUxtVHNPQUhwbUhIYUZnK3Q0WlZ1eUhDTUQzZjcvOXZXVTl2TTg1Q0xXaUZi?=
 =?utf-8?B?YzB5Mjhiek9WMFRGbjdPRE42Z2ltU3ZRSTlyV2dEVlJTa2YxL1ZCTGpOL2pk?=
 =?utf-8?B?eVZzVDE3NW9xcnM3TytJT3RwQm9Hd3FrSHVkdFVsSVpVSXNHWGRyRnpCY0N4?=
 =?utf-8?B?RG4yN1VCbi95NnZWUFN6N2tnTERhVk1vaHVrTWM3ZWkyWk91dHpQUjFGMzBn?=
 =?utf-8?B?QkZaUExiNnFJSVNlUWFJbGlabGRKMUt4eVFFNEdZZHF3emVoYUlBb3Y4ZUdM?=
 =?utf-8?B?NG1VbXhrYlV0VUpSZWI3Zlg2M1kwRUlhTWh0L2VzdWt2aU42Mk0vRWNaWHZw?=
 =?utf-8?B?ZGVPVkVRSURDOVhqMHBRY1Z3Ylp2VXNqNHNUb0RCWEdMdGlNeDlRRU1FYnNx?=
 =?utf-8?B?MGZHeUpSVU9RMk43YkFpTzErcUdwY21FM2NKemswSEFNbEgyTUFqNWxCbGY3?=
 =?utf-8?B?WmRDMnk1ZGRjU2F3MHMrcXJmL2Fhb0xGOTVvT2JZMFltSUVlRHA1QlJ5Ykhm?=
 =?utf-8?B?d2hFR3ltM01DWXhna3FqK2IwdENMZG9xYU1NOFNScWh5OWtzRVlpbUQvMXZh?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFDFE82116DB8C4C90BDDE15A419DC22@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8805.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fbe951-daf0-488d-bc3a-08dc32181d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 13:30:33.5896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTmB8/iZa2SnvnbrXzyHaLOHSMKk9Bh2Bw7qFF58VvoFFZ7kGG6LBDxIMJcupRB3NdnFVDIEnAzLBuSUEWickQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB10138

T24gVHVlLCBGZWIgMjAsIDIwMjQgYXQgMDk6MjI6NDRBTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gSGkgQWx2aW4sDQo+IA0KPiA+IE9uIE1vbiwgRmViIDE5LCAy
MDI0IGF0IDA4OjQ0OjQyUE0gLTAzMDAsIEx1aXogQW5nZWxvIERhcm9zIGRlIEx1Y2Egd3JvdGU6
DQo+ID4gPiArdm9pZCBydGw4M3h4X3Jlc2V0X2Fzc2VydChzdHJ1Y3QgcmVhbHRla19wcml2ICpw
cml2KQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgIGludCByZXQ7DQo+ID4gPiArDQo+ID4gPiArICAg
ICByZXQgPSByZXNldF9jb250cm9sX2Fzc2VydChwcml2LT5yZXNldF9jdGwpOw0KPiA+ID4gKyAg
ICAgaWYgKCFyZXQpDQo+ID4gPiArICAgICAgICAgICAgIHJldHVybjsNCj4gPg0KPiA+IElmIHBy
aXYtPnJlc2V0X2N0bCBpcyBOVUxMIC0gaS5lLiBpZiBubyBEVCBwcm9wZXJ0eSBpcyBzcGVjaWZp
ZWQgLSB0aGVuDQo+ID4gdGhpcyB3aWxsIGFsd2F5cyByZXR1cm4gZWFybHkgYW5kIHRoZSBHUElP
IHdpbGwgbm90IGJlIGFzc2VydGVkLg0KPiANCj4gSSBtYWRlIGEgbWlzdGFrZS4gSSBzaG91bGQg
YmUNCj4gDQo+IGlmIChyZXQpIHsNCj4gICAgICAgICAgIGRldl93YXJuLi4uDQo+IH0NCj4gDQo+
IG5vdCByZXR1cm5pbmcgb24gZXJyb3IgKGFzIHlvdSBzdWdnZXN0ZWQgYmVsb3cpLg0KPiANCj4g
SSB3YXMgc3VyZSBJIHdhcyBkb2luZyBqdXN0IHRoYXQuLi4gSSB3YXMgc3VycHJpc2VkIHRvIHNl
ZSBpdCBhcyBpdA0KPiBpcy4gIEknbGwgcmVjaGVjayBteSBicmFuY2ggd2l0aCBhbGwgdGhlIGlu
dGVncmF0ZWQgY2hhbmdlcy4gSXQgcGFzc2VkDQo+IG15IHRlc3RzIGFzIHdoZW4gcmVzZXQgaXMg
bWlzc2VkLCBpdCBub3JtYWxseSBkb2VzIG5vdCBtYXR0ZXIuIFRoYW5rcw0KPiBmb3IgdGhlIGNh
dGNoLg0KPiANCj4gPg0KPiA+ID4gKw0KPiA+ID4gKyAgICAgZGV2X3dhcm4ocHJpdi0+ZGV2LA0K
PiA+ID4gKyAgICAgICAgICAgICAgIkZhaWxlZCB0byBhc3NlcnQgdGhlIHN3aXRjaCByZXNldCBj
b250cm9sOiAlcGVcbiIsDQo+ID4gPiArICAgICAgICAgICAgICBFUlJfUFRSKHJldCkpOw0KPiA+
DQo+ID4gWW91IG9ubHkgbG9nIGFuIGVycm9yIGlmIHRoZSByZXNldCBjb250cm9sbGVyIGFzc2Vy
dCBmYWlscywgYnV0IG5vdCBpZg0KPiA+IHRoZSBHUElPIGFzc2VydCBmYWlscy4gV2h5IHRoZSB1
bmVxdWFsIHRyZWF0bWVudD8NCj4gDQo+IEJlY2F1c2UgaXQgZG9lcyBub3QgcmV0dXJuIGEgdmFs
dWUuIFRoZXJlIGlzIG5vIHdheSB0byB0ZWxsIGlmIGl0IGZhaWxlZC4NCg0KQWggb2ssIG5ldmVy
bWluZCB0aGF0IHBhcnQgdGhlbi4NCg0KQlRXLCBwbGVhc2UgdXNlIGdwaW9kX3NldF92YWx1ZV9j
YW5zbGVlcCgpLiBXaXRoIHRoYXQgSSB0aGluayB0aGlzIGlzIGdvb2Qu

