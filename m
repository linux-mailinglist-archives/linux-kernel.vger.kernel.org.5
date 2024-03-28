Return-Path: <linux-kernel+bounces-122256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16CA88F450
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C4D1C25260
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0CB386;
	Thu, 28 Mar 2024 01:06:56 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2093.outbound.protection.partner.outlook.cn [139.219.17.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6EC8E1;
	Thu, 28 Mar 2024 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711588015; cv=fail; b=lvpSbaOCT5DsNyoeJWkzLZ/r/4me14woXC0jvwDKuxXS9mq1evJFSvxbLd6tP6JrGlOPAxAabg7lcs4sDY8Pe8/Z5SAXPuer70ttEpg+A+4bEff3s6CUBpJh2k9UgJ0iTsgQLzBtPRecvbqt79Mamc8O1gihHEZ1VPKE12rBqy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711588015; c=relaxed/simple;
	bh=3+o3L9vuoy2YEyp1qdAf28R2PwpHKAapNnnTQV7bG2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VnSLE5farTo8tN2tb6XrdUo2M2+BkA8+6MXDDIGD2hIbJaDtcxnOGw/ZyV09f4KtYwxuqWJayk1rY6xyd+jbhU4pofe5Db7kHjhdlN77UZSgZDxL69hV6dYK0vvR1snH/R7hPaMKvLWE1lXUFKMAPkSZx+l018Vy5EBr8KkfEFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdYPonKcrJ7wqDS03s7rzxnwuK4sDLIHUO6qH/9wqEllc5IBD8wk1UN8EX4ZmVcjlW091+6Pz7dBsgCH88fdSlfWX2DMjxjVbEWuQpP63wJ/67F4/tVaKe9VdK6J3z6HYKjd4NhWAFzdo78u4QOB+D7fnhGNXBBcm4ffBbrgPrDnSQ+26Kq6VWphEEtUB5M5K058ubOVnkJsk7NGsiJx3PpNrT7BHvszpGdLJKjhCa87Fsprj02XM7FoxxXvPrLlKSmPw43NKY8YocTOugn9Cf4w5PsAACglxohWZFmq//f0hjtmPL1nehfb5UBffzLqTz8M3DInaPMZnihwmbUotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+o3L9vuoy2YEyp1qdAf28R2PwpHKAapNnnTQV7bG2Y=;
 b=OsTacSKTBWJcPptFjQeGvQqZJdq5rAvRgXbVWtvyn10wM1/3pa5XMgX34pDZfouayKnFV3ywqtbvNbOOdCDECrp1L+u5JbXrCYvJDbktmlrSH3khAXL+9zdQhBEIRHyiRcGS3qENS69MtqWKi+4N6/eP//MGjz/Nj2k+Q8DznucBMKeQMRiuaPaFl26lzRKjd4STXwuQ05b8cKW6mJHwXFrTDkV2287ugiHJ25vzNbL/g/SAYFCBjBd1Ymp/HTRGlFUyYV4uH1u2AHz7igLFCQPFZ54FEKnCGKCeQvdsVOM46ii7ujc1Z1QaYPNxsBLE6l3CC4ZMa9PTOY0dQUd7cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Thu, 28 Mar
 2024 01:06:42 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Thu, 28 Mar 2024 01:06:42 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Emil
 Renner Berthing <kernel@esmil.dk>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jack
 Zhu <jack.zhu@starfivetech.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTogW1BBVENIIHYxIDEvMl0gZHQtYmlu?=
 =?utf-8?B?ZGluZ3M6IG1lZGlhOiBzdGFyZml2ZTogTWF0Y2ggZHJpdmVyIGFuZCB5YW1s?=
 =?utf-8?Q?_property_names?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2MSAxLzJdIGR0LWJpbmRpbmdzOiBt?=
 =?utf-8?B?ZWRpYTogc3RhcmZpdmU6IE1hdGNoIGRyaXZlciBhbmQgeWFtbCBwcm9wZXJ0?=
 =?utf-8?Q?y_names?=
Thread-Index:
 AQHaSr81E8nk9BtrhUGN5g0sexXYkLDg67gAgAAseFCAABFwgIAD5i7ggABzo4CAZskggIAAdadQ
Date: Thu, 28 Mar 2024 01:06:42 +0000
Message-ID:
 <SHXPR01MB0671EA5AED87CE14113148E7F23BA@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240119100639.84029-1-changhuang.liang@starfivetech.com>
 <20240119100639.84029-2-changhuang.liang@starfivetech.com>
 <20240119-despair-festival-59ab2d4d896b@wendy>
 <SHXPR01MB0671E2150D9A2707F12E0901F270A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
 <20240119-preamble-calm-7724e17fcebc@wendy>
 <BJXPR01MB0662E6EEEEF888BD90A1FCE5F275A@BJXPR01MB0662.CHNPR01.prod.partner.outlook.cn>
 <20240122-uncivil-almost-631137081fd9@spud>
 <20240327-unlucky-bulge-2bf99a8649be@spud>
In-Reply-To: <20240327-unlucky-bulge-2bf99a8649be@spud>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_
x-ms-office365-filtering-correlation-id: 307197a3-e9fb-45a0-f70a-08dc4ec354c8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9Stkxo4GW3DiuPxof63XNUPufuurZOEoVpWCdSzeSMeaksXlRuiJDnnWvwOSVQZMzn/Ofyf2BM9cvCS7T9bxF0RUWJGbiKdlkqYLmnW/XmyU7luJtnzK5cfJECrtYt0L8pAuU/dvxS3gW0GOVVySVVtfOR6CUCPRWWZqi+bxfRjg/ITJnRVoXMVzijOr3QUdXCzTWpFzyDTqhv+hHM3TtFiB2GqKKFJ9t2sULens9cF4KYBhPsdLBYtqg9SOd8cnOR32qLRZ+Ij6tsM849GY009mlJ7usOqZUH84VE9AkkWqjacnnww6FFAnrV8Sm59pj3hgJcOmmSV5w9+2wZrsDuiDWKyvgWj4BFEgqSLFMYl2qN7NPM6I7GSqFCR4B3L8EZW0bh67ceDtQk+KKfYMzZpl8ZquL65JGy8/j5kfPAKXeyXSdGKR+MOVniZV9a1g5LsD1+8BNtjNdH+x15svx+Tqnzvnx3MNhdNyP0Tje8Km9jXNlW6Nu2GxMEwnj7neWjI33a6xIsZba6tUozEvxGTumNpm9XoDvwQMQXT1ogQgBeH4b+PdaZfsKM82AOe+LR7PtQzMn36vsjrzh+kcK6cYi1UwXvQUu561xWX1s3ezKq+Ynxik77XNpC6/aLsR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTUwQXQvTVdSa2pJVmplTVpiZEpWakR5UDJGdDVycU56dkJDM0hJRVFkanl5?=
 =?utf-8?B?OGdVcG1tVXFmY1VmdG5YbnhUTng2cW9CZTR6WWozRURVZ3A3ZlAxeGpvVUM0?=
 =?utf-8?B?MXdqUlNMMzB1NU1Gb1BiR1lqK0E5Rk4zZ29IS3Y3MTlEOW1jQjJlRzBRcE0w?=
 =?utf-8?B?V2lRZjNySDdiK3pFb05MblFVWWhUTm40RnQramRId1FYSlVtTEYveWhnRnhU?=
 =?utf-8?B?bUM2WHlualFkYXU5elJxKzh4TUFiaitWT3R1Z0ovY09VRmprNkxKd0RhaTZo?=
 =?utf-8?B?MDl5Z3NYdHlRNlZsMThaeWp2enRsdUNsNDMyQnVKVnBsbDIrMWEwNG5uVlps?=
 =?utf-8?B?WWxiSzJBdWE5T09abytDd25xRUEwOWZPVk5oejhDT2IzNHh2VTBGb0EvMnRK?=
 =?utf-8?B?ckJzUVNDSWMwN29OQWpJcFU2Q1Bac0xZcXdFdCsvT3M4QnBHYTZyNXROUS8z?=
 =?utf-8?B?bjdCRUlWQTJRMXJuSUVIK25OcUp4M0Q5QkowN0o3VEJLY05CanppNXEvblRt?=
 =?utf-8?B?TlhsbTZOYm1MTHoweVZxdjA4UjNuU1hQS2szdnZrd3pSN29IeFZyMTZZNUxK?=
 =?utf-8?B?NHhTcVM4VGExRUF2OG5ES2JoQzhIcWZTTlZmRG04YXJNdjIrOWJCVHJOVVNL?=
 =?utf-8?B?TmQvU2VUaG9qV3ZadU9yVEtRZmZSaDdjaW9mbk9DdjVjSUJrOXRXVGpYQzNj?=
 =?utf-8?B?a2tFQ2JHVkJSY2toeE1ET2NQaDU0ME90YTFoVjQxZEg4NnNTeGpLSjRKanlO?=
 =?utf-8?B?a2V2K2xnQlIxWER0bVE1VGxVRzU3VmxmSEhaN3Y0UW85alVORFRhTmN0VjdN?=
 =?utf-8?B?dlN1R0VTV0x5Z1VuVlNkQ0NOcDZHMTNrQ21QYW1nWVBKay8xK0VSZllLSENE?=
 =?utf-8?B?WjF1eHpyL0dnNTFuMlVCSzVlMHJkSytNZWpOaDdEV1dvWCtCeFNuTmIyUjlM?=
 =?utf-8?B?TEIwakJwMFNaYWw3UHc5c1BFSHBGeEFwcmlCMEFFVnlGZlBwVFg0RllGQ0dO?=
 =?utf-8?B?T0lRNkFVVWNpcTNnUTUvODJLRjhzcDJiQ2VuNlFTaUcyeWdsZmpGN3phMjRa?=
 =?utf-8?B?eTVMeFVnaDNiWUFTSTF5UytDUG5VVXFJOUNpYmVreFZXSXV5b2oyTEpZR3F3?=
 =?utf-8?B?WFBBSG1hYjM1NC90WWNHQ0Z2Mm8vekw4cGdYRThqQk9VNDZMZk9KTk96YWlZ?=
 =?utf-8?B?V3h3Yzh4djRvOUpNWUN2a245VlpXbXFwamZQUjNkTlZRZGZYb29CU0xJWkpO?=
 =?utf-8?B?cHRYemtBZnFJY05MUGxCK01nK0VobEZ6NzFKR3VPZ2VoaklUU0VNVy9SM2Zn?=
 =?utf-8?B?dlFZZ1daeE5IT3A4VEFnY3BreFJiTXZDOEJmVDd3OWhSRVhyMVRoQm80bUJ5?=
 =?utf-8?B?T1JwSVg4enphSkJLdzBZeEg0VGJ5T1hTVUY2REtxbnRrc0JNbElpR29VOFNo?=
 =?utf-8?B?RTIzTHF6Z0JSUkdhSS9KSUQxMVNFRzEzMzlsZGllY24wVTdmOURQZGtRcFJm?=
 =?utf-8?B?TVYwcjdGUHorNldkblZNUHlzSENsbjlPSUNTTitXTHNTeVlPNFl3VE1xSUkz?=
 =?utf-8?B?SXEyV2xZdHVlYVI3NkNpVlEyMkpnZEpMQWM3VHpvdyt3TDhwck5qR3MxZXJq?=
 =?utf-8?B?WUZ1NjhFRjJDNUd3cGxGTURpbGl3TkptVmdCUjNkeWxrRGtPWXJla1BZa3l6?=
 =?utf-8?B?Sy9iTjJHK2tjK3ExRTNDcFBHeFRrd1FRWVJScTVjeFpCZW9CczZZRWlnSE5k?=
 =?utf-8?B?QjQ1RDZ2dlAzV1dzdTA1bk1wNGVOZUdZYXhmZjgyOGJwUWxqdU9QamE2ZThk?=
 =?utf-8?B?MVk2RTFUOXoya2RkVHNRSWtJdmdiUUt3NlprOFFSTWxZVVRYb1dvL3haK1JI?=
 =?utf-8?B?cU53bjl0aE5EZmJNWUt3bHFMTFJJbllxejZPZU1ERDQrZlZGeXJjckxnMytP?=
 =?utf-8?B?QkJ4a2NLNUFsY3I3ck1KWnRmS3ZyQkw5Z0lVd0s4ZEpFUXdXeDlVd0xiVEJT?=
 =?utf-8?B?cmNPQjdnWEFudEZBam9NNTc2eUdxaDcyS3NFZUNCS0FnTnU3YUVrNEg3S2t3?=
 =?utf-8?B?RUk5UTZGYTVUMzJ1T0hPekpVUkhUZmw2MjJzNmdrZEE3a0doakk2OS9DcVZj?=
 =?utf-8?B?TmlUNTFheitPRjE4cC9nZUpvWDBYODRrQ0M1Wklid1hCdTBDVlRzS09DcmJz?=
 =?utf-8?B?L1E9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 307197a3-e9fb-45a0-f70a-08dc4ec354c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 01:06:42.7790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Da5nA0d05dg9ei2ncu0SQsPBgkQ4AlgMmcQua18HZtZ3AtpYu7JzgBzIYno9hKTm45K8lJZQACENELODvllPd9yX0P3E3bfVHyDNOgVQkZpr2ucWx2pOCVbzDfrUXW3L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0671

SGksIENvbm9yLA0KDQo+IE9uIE1vbiwgSmFuIDIyLCAyMDI0IGF0IDA4OjI0OjUxQU0gKzAwMDAs
IENvbm9yIERvb2xleSB3cm90ZToNClsuLi5dDQo+ID4gPiA+ID4gPiBEbyB0aGVzZSBjbG9ja3Mg
ZXRjIGV4aXN0IGJ1dCBhcmUgbm90IHVzZWQgYnkgdGhlIGRyaXZlcj8NCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBPciBkbyB0aGV5IG5vdCBleGlzdCBhdCBhbGw/DQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gVGhlIHR3byBhcmUgdmVyeSBkaWZmZXJlbnQhDQo+ID4gPiA+DQo+ID4gPiA+ID4g
VGhlc2UgY2xvY2tzIGV0YyBleGlzdCBidXQgYXJlIG5vdCB1c2VkIGJ5IHRoZSBkcml2ZXIuDQo+
ID4gPiA+DQo+ID4gPiA+IFRoYXQncyBub3QgYW4gYWNjZXB0YWJsZSByZWFzb24gZm9yIHJlbW92
aW5nIHRoZW0gZnJvbSB0aGUNCj4gPiA+ID4gYmluZGluZy4gSWYgdGhleSBleGlzdCwgdGhleSBz
aG91bGQgYmUgZG9jdW1lbnRlZCwgcmVnYXJkbGVzcyBvZg0KPiA+ID4gPiB3aGV0aGVyIHRoZSBk
cml2ZXIgbWFrZXMgdXNlIG9mIHRoZW0uIE5BSy4NCj4gPiA+DQo+ID4gPiBJZiBzbywgaG93IHRv
IGF2b2lkIHRoZSB3YXJuaW5nIG9mIGR0YnNfY2hlY2suDQo+ID4NCj4gPiBCeSBhbHNvIGFkZGlu
ZyB0aGUgY2xvY2tzLCByZXNldHMgYW5kIGludGVycnVwdHMgdG8gdGhlIGR0cy4NCj4gDQo+IEdv
aW5nIHRocm91Z2ggcGF0Y2h3b3JrIHN0dWZmIG5vdyB0aGF0IHRoZSBtZXJnZSB3aW5kb3cgaXMg
ZG9uZS4gSSdtIGdvbm5hDQo+IG1hcmsgdGhlIGR0cyBwYXRjaCBhcyBjaGFuZ2VzIHJlcXVldGVk
LiBUaGUgYmluZGluZyAoYW5kIGR0cykgc2hvdWxkDQo+IGRlc2NyaWJlIGFsbCBvZiB0aGUgY2xv
Y2tzIHRoZSBoYXJkd2FyZSBoYXMsIHdoZXRoZXIgb3Igbm90IHlvdSBjaG9vc2UgdG8gdXNlDQo+
IHRoZW0gYWxsIGluIHNvZnR3YXJlIGRvZXMgbm90IG1hdHRlci4gQ2FuIHlvdSBwbGVhc2UgcmVz
ZW5kIHRoZSBkdHMgcGF0Y2gsDQo+IHdpdGggYWxsIG9mIHRoZSBjbG9ja3MsIHJlc2V0cyBhbmQg
aW50ZXJydXB0cyBwcmVzZW50Pw0KPiANCg0KWW91IGhhdmUgYXBwbGllZCB0aGUgZHRzIHBhdGNo
Lg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMjE5MDMyNzQxLjE4Mzg3LTEtY2hh
bmdodWFuZy5saWFuZ0BzdGFyZml2ZXRlY2guY29tLw0KDQpSZWdhcmRzLA0KQ2hhbmdodWFuZw0K

