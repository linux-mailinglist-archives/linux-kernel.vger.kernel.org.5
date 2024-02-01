Return-Path: <linux-kernel+bounces-47533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E669844F0E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9741C2381B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0569A171B1;
	Thu,  1 Feb 2024 02:15:44 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2110.outbound.protection.partner.outlook.cn [139.219.17.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1851079B;
	Thu,  1 Feb 2024 02:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706753743; cv=fail; b=nW7eQDyoY1mOA54esJ4t72AGQMY9EFSyqUbVvtmryuazbVH5O4LKLrH902iw55cCshzYudz111aXU6fFwNRmr4+qu6SnIYns3RT/pQts2Fja8xKZqDTzY129woHbyznhf3jOjSyRwy//C4s2x+0FlyKsp4vhrwJQpAeE5523OTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706753743; c=relaxed/simple;
	bh=zjJXMUpZGVhjiYlhAc9XLjPlTdVKSNpEgKtsR2ocXOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W5u6n5SkmVaBYCmEOQaR84r1r1zeCyFfyj8MN6/mD/AjzHCnDo9oln1UwhnFm3VaEbgbmci7iiWDOk3i95Uq7IJ56ivZ/4qRP67lPfqEB/f76xBSET7qQiNqqU0hvZqksqigdFkjrVn6Pgwmrnvx0kAhucOZOTjIhBKfI6/1IIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMCh51rwP1Zn6Gf+xLIRy5QLTkOMkUlAnwqPPDGR410FH4yoIimHA7BirFIEZi7VliERwYyulo03R4c9emotzQ8JLB2xWgj2jDw1m2RpEN7OW/SFQzSjjRZqCLIhEHz4ABuxOevqe9j5/GerS5mi/8LnfMsknuCBX0BDJff9BOz50XZhea9+0vPKPPn/hYudpBxI2vjdhabuz4R1K5Nc4i5LW5WvjOmA6FxzOVkwh27LCRVY5Lp/3Wo7DtL0MXF+AAMIjVLRk07iog20C8FUlgV1wo9HNOX8IFEfY+ThlMQM3n7x9y2rMcxJgG7y0tBXiAP4D+QhB58fZnEhahuUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjJXMUpZGVhjiYlhAc9XLjPlTdVKSNpEgKtsR2ocXOk=;
 b=CNvoIXNFctbPpOrB+D5Gg4TZ0UUeo1VDnLQxvFY9G3RH3rlMSl4KpP43Bx3fS4pJHuCRHB+3UQyh6Ejc809hffFNh7HL94LcCPeNh7m2AWDMO8LQR0VQzKK88JkRtuolv8co6TB5i7OdbqqxSYDH29ynlUYQjOh2vtWc4cHzUEF6RUEj9BJmspd23wRPPusrhnK84aZMBh/QkIsFXlTkbbEIZnOPxwcwkTRKhtpWrRaeAe1M5oXPq5W+qkfA/yNQjyfs7BpVXOkYqpKTEHOlrjRyuCVNOZv5QFAaESMlWAm6zwNAyoyh41ktFOLYsr4sfOJ4gMrN4cjpzqIe89jFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) by SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Thu, 1 Feb
 2024 01:42:14 +0000
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 ([fe80::a812:2d74:cde5:d094]) by
 SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn ([fe80::a812:2d74:cde5:d094%6])
 with mapi id 15.20.7228.029; Thu, 1 Feb 2024 01:42:13 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Emil
 Renner Berthing <kernel@esmil.dk>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jack
 Zhu <jack.zhu@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW3YyXSByaXNjdjogZHRzOiBzdGFyZml2ZTogamg3MTEwOiBBZGQg?=
 =?gb2312?Q?camera_subsystem_nodes?=
Thread-Topic: [v2] riscv: dts: starfive: jh7110: Add camera subsystem nodes
Thread-Index: AQHaU1XbC4h2Cxa8Q0qBcekBfbY08LDz/xMAgAC4KBA=
Date: Thu, 1 Feb 2024 01:42:13 +0000
Message-ID:
 <SH0PR01MB06675EF7ACD1452C4DEBE45FF243A@SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn>
References: <20240130082509.217683-1-changhuang.liang@starfivetech.com>
 <20240131-recycling-entering-b742e0e835eb@spud>
In-Reply-To: <20240131-recycling-entering-b742e0e835eb@spud>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0667:EE_
x-ms-office365-filtering-correlation-id: b781fb56-fd2b-4495-1499-08dc22c703b2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 k8+fKsN/huevOrOJtopgnHF8pQwOkPHJZcSgun1SH0SogiYfsDJYWB/A8Ha8fW368Li1bI81Vv0ywq2xchjhKgKRWubpQWoQdWNkKgm3/mJfIQdu4lDZngfZ8Lq5ZOQvZk6PYvylIspqlpawCG5iixMMP+2EvFtC0q7xjrln73eWoAERiR11C5UvhWOFPey4ruTEoqfU2c1bqsvH0sIGosqPbLgIOPv6XQNZfJHq7G8S44+1p3BrdlM1IlNZAffVucvGatdfDROmCx1GaJQMbfwcO9ds2mDCNHJsOdQ9RdVS+OfxBpvtTXuTPla4Vqql7ad2YghMpBCo1qURkuE1qRkXymAGPw9zbk7FkUIhVNm4FaHUcGCvncDghDf/Q2vUl9TrGd2qwrreBxKvK485IjeRk3iX+A+93IyDldNdEBiiS7HUMYbwy+5TLJBDrTQtiS0kPcucuTYGj3vF42sYWg7XFH4NzGTkD0gS0hcsFC+MpBK7wd6j2t08lXpWv7S+b+9G6f2oBKSYr4hj/p3N5xaeKsD5+IgUk/VR4xDFJ0kuenmeag/oOQqJcNTu6bj7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(396003)(366004)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38070700009)(41300700001)(40180700001)(33656002)(2906002)(5660300002)(41320700001)(7416002)(26005)(7696005)(83380400001)(66556008)(66946007)(66476007)(66446008)(6916009)(64756008)(86362001)(54906003)(76116006)(508600001)(71200400001)(55016003)(9686003)(4326008)(122000001)(224303003)(44832011)(38100700002)(40160700002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZjlXYlZCZlMvUVorS2lPZms5VzNKVldBYlFRaml4UlVhc3orTXZWM3J6WTQ3?=
 =?gb2312?B?SmZGcERlVWI0cjkzYW1tbnE5ZGpCRWh2UTArYmcwOURiYWFxWE96YVlFdjVq?=
 =?gb2312?B?Y3FQVmhMSzF5YitlNUhCTlh5N0tmQ3RhNlJmSHdQYU5aSFdTVnllcC8xTDVs?=
 =?gb2312?B?RDdsNG51WVpFU3NwQ21xek5EY0p4dUhTTVppN1Zib3YweU9naWRCOFo1K3ZT?=
 =?gb2312?B?SFk0MzZCS2lIck53d3Ivc1QxbVJyVzVESmJkNU5rUXMyTm9rbjM4dThST3lD?=
 =?gb2312?B?WXhLMmlJakRyY01wUkN5bXhsdTR3TEVuSWEyMXFqVCtrY2t3ckRsVEl5eEkv?=
 =?gb2312?B?U1V5WjJrME9SanpobDFlTG5tWDRyUmJyeGJwcnhZeUYwYW5QY3llUCtnQWRB?=
 =?gb2312?B?SytwU0hkeHA0cDIrYjVlcHdjRTdzTGxRbkI3VlpwNVpyUU8yUUpmNStkSzBY?=
 =?gb2312?B?NSs0S1N1Mk01Y2ZFYzFGRURkVXB6TDdkWEMrWnJxa2RodmhGbTR1Wks5Y0Ew?=
 =?gb2312?B?OVZsSzc0dkhmMVREVXZ4cVlWdFJWUGN5NVhadDdrazFYNUVpSnU1cFR3V0Ji?=
 =?gb2312?B?QmRiM2dEdnVZRi9zWkNDRjR6ajhBWStDcnlxckh0ZHdTWDJ0akQ4OVFKbmhr?=
 =?gb2312?B?dG90R2EwSmkyR1dOckR5VFlUbC8vREh0RFdmbjRHZ3lyRVlwUFpuQ2phcUF0?=
 =?gb2312?B?QUdGbThDY3BuSVl6a1dFOFd1bDRGUWRjRGd5RkpXWDRILzJDSWh5blFDTmFi?=
 =?gb2312?B?QmRvdW81R1o0bTlrSGRmM2d5RDh6VGpWbjZnN0ZSdW9OeDgxNkVYTmtJZDkz?=
 =?gb2312?B?b0hIak4wbytqYVRaMGRrNldHb0t4MFMzcEx5d3VSakJldFBqSEY5aUJhTGN0?=
 =?gb2312?B?ajBhaXBKYy9YMXdjdm9CR3dNTWt2SnpSek40d0x4TENIQnp5ZUx3S3ExZEM0?=
 =?gb2312?B?MThKNG5vMXk5RWhyN1dRaWhzeFdBVTlwbkxyNEJRMU1ubG00UFdzZjd2RlNN?=
 =?gb2312?B?c1NRT3JQU1pnYi84d2huNWEvNzVtQ0R4d0xDenpsRWxRZkZxczNScEYrRGR6?=
 =?gb2312?B?V3NUTW93VXhhajdvd1V1OXUyUWtUcnI3YUtRVWQ5dmdPa2g5dHZPcDdUclVp?=
 =?gb2312?B?RlpWaFJYVCs1UXBsc3RMQ3BhMVZRa3pIVU5TSjFGMEtlbHR6SjF5ZkNvY2cz?=
 =?gb2312?B?V01uVE9MTXdsSDlwNDNOVDd3SnFpVk83TnpYQkhNZ3QyY3ZrQ0hvMDVIclA0?=
 =?gb2312?B?Tm1jTXZ4dWU3Slk0d1AvSjlwLzRSRXhzR2JBQ2FxdjNZRks0SFZEZ3g1ZndS?=
 =?gb2312?B?cmRZVzF5Z09oQTRKTitySFFIY1Q1VHNhdGZBSkxZUmZVdXpRMTNFclAyWEow?=
 =?gb2312?B?QitackdKNGhHa3NDeHVtdHZDTTVydXdHdTcrSWV6NWNyVlk2bjlyWGpqOTZD?=
 =?gb2312?B?Um9xeHptT0NwczRwSGt3VHordUJra0Exb3lvV095b3d6Qmlqdkp5RitGandF?=
 =?gb2312?B?WXZpMStuMGtTZlZYcDhtUGpNS0tqcVVDZGRXbzBCMEloM09kZmljTkErbmww?=
 =?gb2312?B?Zys5YU1tQXN0SWZrMkVhNysvLyt3ZXNqSERyUnVPWlZWRHlocHo1VzZ4MmJU?=
 =?gb2312?B?bHRUcTJOKzY0ZGVYQmU4SjNBNWNTWjdyOFl1SzJXRXRrNmxoZzVqY0UrQUd0?=
 =?gb2312?B?MkthSnhlL3NSL2s4ZWNUcUYvMzVBOTBnY3p1bkJuY0NpaFRMWkhwbFNlU0k0?=
 =?gb2312?B?OFBQVjRWbjNnNzRvOUZndnNSU25sSWtvS3Vvb01PRFZaNXBEd2lrblRCMVlY?=
 =?gb2312?B?SWFuWk8xTVNad2FqYjJmK0pEcFU4YTFuTVN6ZUZJQmV5T1EvYmNMdFBnK1Rh?=
 =?gb2312?B?VmQwSHNtQU8yQmt0aCtBdzZxYldsWEc3b3dEOTJuNnh5MG1DQnF1SWVKcGZu?=
 =?gb2312?B?aUFQR0RMTUpRdXdKcVU0YU04eit2MDJONVh5ZGwvN0orMEQxNlhiVjBGSjZT?=
 =?gb2312?B?N1JUWU5tdkVSZjFab1cwUmJjd0hjdVBUaDBXV1pUZFQ2emlpUGVWYyt4WUZs?=
 =?gb2312?B?L2p3Ri93bmlqRk5GTUdraDRJZ0F2SGJFcWJMREc0d1BjcmdDTEF0UFpOZTZn?=
 =?gb2312?B?SFcydHdTQ2ZXZStZZmNnMklpdFY5ZGVMVkM4RWErOW1UMnIxVHF0ZzNzSXFo?=
 =?gb2312?B?a1E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: b781fb56-fd2b-4495-1499-08dc22c703b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 01:42:13.5524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDi7fcF0XfAwjLCrD5SexH0kihNM2509AGShcEQOiQ9GWUt/yLGW/otjW77BClmSab15Ai1tzJ5kAdMtzdygCGnDhYX6ybTy4a+l4LHVZfHbAcztJsmtl7EGD8gsZA9s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0667

SGksIENvbm9yDQoNCj4gT24gVHVlLCBKYW4gMzAsIDIwMjQgYXQgMTI6MjU6MDlBTSAtMDgwMCwg
Q2hhbmdodWFuZyBMaWFuZyB3cm90ZToNCj4gPiBBZGQgY2FtZXJhIHN1YnN5c3RlbSBub2RlcyBm
b3IgdGhlIFN0YXJGaXZlIEpINzExMCBTb0MuIFRoZXkgY29udGFpbg0KPiA+IHRoZSBpbXgyMTks
IGRwaHktcngsIGNzaTJyeCwgY2Ftc3Mgbm9kZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBD
aGFuZ2h1YW5nIExpYW5nIDxjaGFuZ2h1YW5nLmxpYW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4g
LS0tDQo+ID4gIC4uLi9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLmR0c2kgICAgICAgICB8
IDEwMw0KPiArKysrKysrKysrKysrKysrKysNCj4gPiAgYXJjaC9yaXNjdi9ib290L2R0cy9zdGFy
Zml2ZS9qaDcxMTAuZHRzaSAgICAgIHwgIDY3ICsrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNo
YW5nZWQsIDE3MCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9hcmNo
L3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTIuZHRz
aQ0KPiA+IGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlz
aW9uZml2ZS0yLmR0c2kNCj4gPiBpbmRleCBiODllOTc5MWVmYTcuLmUwMDI3YmIzNzllZiAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC1zdGFyZml2
ZS12aXNpb25maXZlLTIuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZp
dmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpDQo+ID4gQEAgLTMwLDYgKzMwLDM3
IEBAIGNwdXMgew0KPiA+ICAJCXRpbWViYXNlLWZyZXF1ZW5jeSA9IDw0MDAwMDAwPjsNCj4gPiAg
CX07DQo+ID4NCj4gPiArCWlteDIxOV9jbGs6IGlteDIxOS1jbG9jayB7DQo+ID4gKwkJY29tcGF0
aWJsZSA9ICJmaXhlZC1jbG9jayI7DQo+ID4gKwkJY2xvY2stb3V0cHV0LW5hbWVzID0gImlteDIx
OV9jbGsiOw0KPiA+ICsJCWNsb2NrLWZyZXF1ZW5jeSA9IDwyNDAwMDAwMD47DQo+ID4gKwkJI2Ns
b2NrLWNlbGxzID0gPDA+Ow0KPiA+ICsJfTsNCj4gDQo+IFdoeSBkbyB5b3UgbmVlZCBhbiBvdXRw
dXQgbmFtZSBoZXJlPw0KDQpUaGUgb3V0cHV0IG5hbWUgY2FuIGJlIHVubmVjZXNzYXJ5LiANCg0K
PiBBbHNvLCB3aGVyZSBkb2VzIHRoaXMgY2xvY2sgY29tZSBmcm9tPyBJcyBpdCBhbiBvc2NpbGxh
dG9yIG9uIHRoZSBib2FyZD8NCj4gDQoNClRoaXMgY2xvY2sgY29tZSBmcm9tIGlteDIxOSwgbm90
IHRoZSBWaXNpb25GaXZlIDIgYm9hcmQuDQoNCnJlZ2FyZHMNCkNoYW5naHVhbmcNCg0K

