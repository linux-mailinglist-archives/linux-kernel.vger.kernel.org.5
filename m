Return-Path: <linux-kernel+bounces-44007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84233841C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99DB1C2150D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A07B3F9FF;
	Tue, 30 Jan 2024 06:46:52 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2072.outbound.protection.partner.outlook.cn [139.219.17.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C04C38FA3;
	Tue, 30 Jan 2024 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706597211; cv=fail; b=HMlo+rIxZICBCJV0rn6o4DUtSRrz4yHxfXvjzUOd83II00fuPx4Bne2MgAvFKeKuhOmm8T46hLpG+piCK1iHkYcxnKCBrCvK4FgQGcHd0Lr2mj1AVgd9UpxseDlXR93KEjm6kjN/kkg9X6OICzA8QT7UMDwBw+4i6wOrlmGB13E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706597211; c=relaxed/simple;
	bh=S/kSFSUW55V/gVZ4eVSTE8QU2gGsnxdXW71aP01akHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lMP000F+rBpLFwOn/bzivCJtQLSErWdgTA5KY98YUNbAC+qa+DtaU3GDNReyRzGoytyBBK017ZrQm07snoz6AODJDNS5iAEE1iVrJdwic4JghONR4bOU+debmbVns3jpjVfeof4VJkbMRwVXJRwUvBUoMyiPmn6refVUdzNAGw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLkD7aLqa7EFfJ7Jg9QgL8/4xDWv+IAaqN0jyj8XdrRL7R5/U2VGKqwCF8WZEE8F+27zT2P7Zim4xvZHjpbYp+aqLqiZTbVQWGjsAEapZtvbCi/QSTrjc1bocpb5pXbFLARi38eX33tgERPhgNIyWJo7l3EybXxQSIIxmJBEML0yoqOvt6sT4Q8hAQ6abukPwGDs9Wao9ZWX6Q7F4QN693m9xK0uLDQYR3Md6cBUAmGCtLheMXoxNuXZkR7W9wbGAoF/J0o3izXi/lymxkGsJbiEitjC45lF51DuDqpnrvunmtr1Y3DUaLqHQ6pX8OQxABWsplfW63njuhpfTQ7Zmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/kSFSUW55V/gVZ4eVSTE8QU2gGsnxdXW71aP01akHQ=;
 b=gd7P8/YO4L2nZkAQch01QaAbVkuE6ybVa9QsKGQjbw82blVsN7ZIOl2ZKam3CWy8A356/QVc1QMcLG836hItUJjMMVX6ORcL6GVqkJin4AXVZvQ6a3tBa/I1IIltZrMuHgrk0rNbGGYsUjsMOK1wpDlEHBvqdyEEE9xrxktM1HSNSU+fngcLhY8iEGGs7YLZowtqd2wNTBarePkYnqnR2RUZY8CpWaEHmM58PMq0vAYmOcgtO9dHhwuZkx6rCNN5BXpPLGCeEnA2OU9ebUy8wpg05x5xej/HOLIEFv0rRAC8mqhQ9UYvntaNkBOp1Pbai3Mz6njNskVgnrGlrqbl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1142.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 06:30:55 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::380f:84dd:fec:a39]) by ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::380f:84dd:fec:a39%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 06:30:55 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Emil Renner Berthing
	<kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, Wolfgang Grandegger
	<wg@grandegger.com>, Philipp Zabel <p.zabel@pengutronix.de>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>
Subject: RE: [PATCH v1 2/4] dt-bindings: can: Add bindings for CAST CAN
 Controller
Thread-Topic: [PATCH v1 2/4] dt-bindings: can: Add bindings for CAST CAN
 Controller
Thread-Index: AQHaUmELMcBq8C1zDUelCC9DKSIHK7Dw7UcAgAD2fDA=
Date: Tue, 30 Jan 2024 06:30:54 +0000
Message-ID:
 <ZQ0PR01MB125387EBAB0E6883FAD077859F7DA@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
References: <20240129031239.17037-1-william.qiu@starfivetech.com>
 <20240129031239.17037-3-william.qiu@starfivetech.com>
 <20240129-garnet-polar-65afd461a1c6@spud>
In-Reply-To: <20240129-garnet-polar-65afd461a1c6@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1142:EE_
x-ms-office365-filtering-correlation-id: 96879d0b-1dea-4fe4-49c9-08dc215d0333
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 t+AgFY0bwfqAdGahLYfAydBAMSdbRqmjO5Nb0vCRuyeHejp2fCu3ZjjdzW5TUi1mykqZhu315+e9IYPhDXEsjIsB6ch1tEy5l//0f0zFJOyGqaPWOjAE6hNJn9BwExu9WRdbSTJZs5VvYw5asrfJ8/chZgyFrXQfA921Qysl/pW/Rhdl18a9ue6OM5pq1YmSIEGV3hVMg+djCMGUNesq27MI9uq5TMjZ/pKZcvUT+w0Mte82q/XFBE3ii13jA9rvNQ9uXbh8HXhrTpRflaoRdhVdsHZmELOC7kpIfTv9y/34D/kQrC2t1VQIq4SwPKSbD7s6n5UnIgBudlBsnYG85RnHZS1Qebg9Ly+NB8hGQGFdOsvdOIPSheCSgekxVo7f49gpQ9XURgiZRuGnTOfeYyM59W4cJQzQDcLPUVJYjNE4UYVkdl0YvUoFBVtPAW+en1sO9tJjD2RljJz/+pGsXpk2o1uIkryUgsW55OxlZxcZz2ibP4KEefhQeM3vQeSNsBlgXy5zHEPZI4Aj5FiRkw7NYKf3Kaeip3LSiBJ7FDEZJoO+vDKaGbj6fbNUYwxL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38070700009)(5660300002)(2906002)(41320700001)(40180700001)(33656002)(7416002)(41300700001)(66446008)(83380400001)(54906003)(76116006)(64756008)(6916009)(86362001)(66946007)(66556008)(66476007)(508600001)(966005)(71200400001)(53546011)(9686003)(55016003)(26005)(122000001)(44832011)(4326008)(8936002)(8676002)(7696005)(38100700002)(40160700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bldWNVBLRHkrQUxwejdqVXpOczU1dmpTSnZsdVk5bTZYK0luTUZHQzI1RFFq?=
 =?gb2312?B?NjFKNWlFOFlwajNCYkNsZWVXVk5jWnpJMFN6Sng3ZFZyaVNQUWZEaFM0RDBQ?=
 =?gb2312?B?NksyeExnVk1zanRQMjd4aFBtQ2VicWNSZDVIcDg0UmJOTXNLeTNnOXpBYnox?=
 =?gb2312?B?VGp5UGVIM3FWT1RZM25xVzM0eisyeTZBMFpjR1RYL2NrZnpaQWZRaUtHMWZ3?=
 =?gb2312?B?TC9SUzJWWGxzV2ltWGtMN1JraStzRWZWZnBMRGx4ZWR1SnU3M1gzK2o4UTFD?=
 =?gb2312?B?Mi9rOWE0U3p1RmE0UGcyNDFjUEdqRlNiZkdCYXJ2K2VNWkZMSnN5dzQxODJW?=
 =?gb2312?B?aEx5N3JQdTA5UE9rMUpVQUtndUNvYitpbWRnSC9zRHh2ZFRVRWRMU1hlYmxX?=
 =?gb2312?B?WFYvd1gyMDNEcXZ4RWhScDlBRlpnRjBSenprTks2UnhqYkxQKzRIRWc1S0hG?=
 =?gb2312?B?ZVlMc1lzaTJhU29FOWNTZGpMS3FlbGdOU25Cc3R5RDBoVXR6cVZ5RVoyQjhB?=
 =?gb2312?B?WUE5amZzNVhGZ21yaHlzYjc5bjExYkFERVorRWZpODNDTWlKOHpuYmFrbHAv?=
 =?gb2312?B?NnFNUjRrZUk0VkVhMWthaUlQU2QxdkNqTlh4KzdFUEs4U09NenIyUDhFOHNu?=
 =?gb2312?B?YXhUbHJSYk80T0RQQkVxcFFUSnBNTGdPdHVDbVR3TG5obGNrYm1DVUxreTgz?=
 =?gb2312?B?ejBNME14anBQeFVQN2RiU2RxaXBVTE9UcW9hUzBCMGREbVNSSW1xM09HYVNO?=
 =?gb2312?B?Zk5NalR5REhjcUczT1NKQ0NqMVhPR2R4TWFFWTUzclU4ckQvVHZKdHBKV3hS?=
 =?gb2312?B?ZWhyVVlhZWUrVzI4NFptTWNLVCtxTGdRZXJuQklVZjAvVzd3WEFpenZnMFZE?=
 =?gb2312?B?MXZWRjB5SzFiQ3VwV2V2NVZISTBpN0pZRklFb0l4cUZEbnluWk5ZbzVQdDdo?=
 =?gb2312?B?d01HSDVHSmdxWnkvMTQ1aG9HaDA2MTVoWEh3dEh0V003ZUhVR2RJOVRLV1VY?=
 =?gb2312?B?NUVZdzV0T1kvSGFQUG9Vazc0bE5Hbk1IMlgya0pVUDhpSnZvSitneXhDaFpF?=
 =?gb2312?B?eG1QTFQ4RWZqanhsc3ZWckRrRVZMWTZZc2hRWjBvWExic0NXK0E5eDAxTUdM?=
 =?gb2312?B?aXQybWUzZGdNTE53ekkyZ1NzUnlIRXhFZ3pvYTZHWkMzZktMaUJ1TVNiSzZX?=
 =?gb2312?B?cUhka2xCS2pCMXZiTzR0TlgwZ3ZVOXZCNDFaRXhLd0tuLzN0T1QxdDcvWEhD?=
 =?gb2312?B?Q2U3dlROTThUUWhYZjQzTk4rTWZYNVA1RmFtWGNtR09LMmwzWlZFNmN3bEZZ?=
 =?gb2312?B?NS9SQTlzQVMzMjZPcWdyYVJvSjFkTE8vNDJtaFlXOFJJOEFaVi81QXBwc1Jz?=
 =?gb2312?B?NUhuTittdm1PZ3ZsN0VjR1VvWE4yZWZtUHNoNTdqKzd1V1JyaWIwc1psRjdK?=
 =?gb2312?B?amVqeWhCVzhnY0NIOC9NSXM4a2poSkVQdVRjTlhQa1RwRjNGQWNyMXpjd0lz?=
 =?gb2312?B?cjB2Uk9NNEJPTDljSm1BMnk1bXFFVEZib1JwLzJ3RHhlOEE0OHNPQWlJOCs3?=
 =?gb2312?B?SFlyZDRtV1czWVFxbHpVaWtUV3d1WkFsZU95eGtTaWRMV24rYmhjWTFCa3g2?=
 =?gb2312?B?cjhZL0ZSU3RDbDl1VXJDTE1QcjN2ZjFiai90OG0vOGl6QVNOZnNIM3AyR2dG?=
 =?gb2312?B?TUw4M1BpUDZ5aFlKK1drTlBrMS9IeDZZNTRuaFdIT0UrOUUwYThIMXAyR3VR?=
 =?gb2312?B?SHJ6Uy9xSFJmd3E2WnFySzE3OU9ZbnVHa0dybmlJY3BBWmpXWWxZREphVC8x?=
 =?gb2312?B?QWJzUjN0bEE4N3RidTEzbTZEdnFpZ3p2VXRkSlkvVzR3MjNrTmh4OCt2bFBB?=
 =?gb2312?B?eTBNcjJmTnFCMWcwODAzY2l5a3pDOWt1S2gySlBWN0oxcXF2bFVnNDRSVFNL?=
 =?gb2312?B?U0RHU0FyaWZ4V29UYnNpSkFtNDF2eVIxY3FRcmFVcHBmQmxoRU5CSmFYVkFM?=
 =?gb2312?B?QWV3cEVtaEZ0aFFhNTdsWVY2Y2puMllQdC9Db3JtMHdTa0YvRnpUSmdlbTlV?=
 =?gb2312?B?VnJkaDFRS0ZLalkzd21tSlV6bkVoNzhqUHVqYVJreXlGVmVaM1NUcExTWFg3?=
 =?gb2312?B?ZXFKTGNDcGlIVkN2YVYydDdLeHZhQTlscURBcmErYlVGNlRSZ01CYjZuSWIr?=
 =?gb2312?B?dnc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 96879d0b-1dea-4fe4-49c9-08dc215d0333
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 06:30:54.8860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RkHBqIEcVGctgNX/A70s4zSaqYWguOVN1AgTds+x6gaqEyEPdEeZ4NPCeayl6dXgyjNOiABFdfr2GjRvapoiMPvM9h2vTNEkxiI2GyvIAgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1142

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9y
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jHUwjI5yNUgMjM6MzcNCj4gVG86IFdpbGxpYW0g
UWl1IDx3aWxsaWFtLnFpdUBzdGFyZml2ZXRlY2guY29tPg0KPiBDYzogZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXJpc2N2
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc7IEVtaWwgUmVu
bmVyDQo+IEJlcnRoaW5nIDxrZXJuZWxAZXNtaWwuZGs+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBr
ZXJuZWwub3JnPjsgV29sZmdhbmcNCj4gR3JhbmRlZ2dlciA8d2dAZ3JhbmRlZ2dlci5jb20+OyBQ
aGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPjsNCj4gS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5DQo+
IDxjb25vcitkdEBrZXJuZWwub3JnPjsgTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25p
eC5kZT47IERhdmlkIFMgLg0KPiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1
bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+Ow0KPiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJu
ZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgUGF1bA0KPiBXYWxtc2xl
eSA8cGF1bC53YWxtc2xleUBzaWZpdmUuY29tPjsgUGFsbWVyIERhYmJlbHQNCj4gPHBhbG1lckBk
YWJiZWx0LmNvbT47IEFsYmVydCBPdSA8YW91QGVlY3MuYmVya2VsZXkuZWR1Pg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYxIDIvNF0gZHQtYmluZGluZ3M6IGNhbjogQWRkIGJpbmRpbmdzIGZvciBD
QVNUIENBTg0KPiBDb250cm9sbGVyDQo+IA0KPiBIZXkgV2lsbGlhbSwNCj4gDQo+IE9uIE1vbiwg
SmFuIDI5LCAyMDI0IGF0IDExOjEyOjM3QU0gKzA4MDAsIFdpbGxpYW0gUWl1IHdyb3RlOg0KPiA+
IEFkZCBiaW5kaW5ncyBmb3IgQ0FTVCBDQU4gQ29udHJvbGxlcg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogV2lsbGlhbSBRaXUgPHdpbGxpYW0ucWl1QHN0YXJmaXZldGVjaC5jb20+DQo+ID4gLS0t
DQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vY2FzdCxjYW4ueWFtbCB8IDk1
DQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOTUgaW5zZXJ0
aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9jYXN0LGNhbi55YW1sDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vY2FzdCxjYW4ueWFt
bA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vY2FzdCxj
YW4ueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAw
Li5lYTUyMTMyZDliMWMNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vY2FzdCxjYW4ueWFtbA0KPiA+IEBAIC0wLDAg
KzEsOTUgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5IE9S
IEJTRC0yLUNsYXVzZSAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL3NjaGVtYXMvbmV0L2Nhbi9jYXN0LGNhbi55YW1sIw0KPiA+ICskc2NoZW1hOiBo
dHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiArDQo+ID4g
K3RpdGxlOiBDQVNUIENBTiBjb250cm9sbGVyDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4g
PiArICAtIFdpbGxpYW0gUWl1IDx3aWxsaWFtLnFpdUBzdGFyZml2ZXRlY2guY29tPg0KPiA+ICsN
Cj4gPiArYWxsT2Y6DQo+ID4gKyAgLSAkcmVmOiBjYW4tY29udHJvbGxlci55YW1sIw0KPiA+ICsg
IC0gaWY6DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZToN
Cj4gPiArICAgICAgICAgIGNvbnRhaW5zOg0KPiA+ICsgICAgICAgICAgICBjb25zdDogc3RhcmZp
dmUsY2FuDQo+ID4gKyAgICB0aGVuOg0KPiA+ICsgICAgICByZXF1aXJlZDoNCj4gPiArICAgICAg
ICAtIHN0YXJmaXZlLHN5c2Nvbg0KPiANCj4gSWYgeW91J3ZlIGdvdCBwcm9wZXJ0eSByZWxhdGVk
IHN0dWZmIGluIHRoZSBhbGxPZiwgbW92ZSBpdCBkb3duIGFmdGVyIHRoZSBwcm9wZXJ0eQ0KPiBk
ZWZpbml0aW9ucy4NCj4gDQpXaWxsIHVwZGF0ZQ0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNv
bXBhdGlibGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIGNhc3QsY2FuDQo+ID4gKyAg
ICAgIC0gY2FzdCxjYW5mZA0KPiANCj4gSSBkb24ndCBsaWtlIHRoZXNlIHViZXIgZ2VuZXJpYyBj
b21wYXRpYmxlcyB0aGF0IGhhdmUgbm8gdXNlcnMgYXMgYSBmYWxsYmFjay4NCj4gQWxsb3dpbmcg
dGhlbSBpbiB0aGUgYmluZGluZyBvbmx5IHJlYWxseSBkaXNjb3VyYWdlcyBwZW9wbGUgZnJvbSBj
cmVhdGluZyBkZXZpY2UNCj4gc3BlY2lmaWMgY29tcGF0aWJsZXMuDQo+IFNlY29uZGx5LCB0aGlz
IGlzIHNvbWUgcHVyY2hhc2VkIElQIHRoYXQgSSBhbSBzdXJlIGhhcyBhIHZlcnNpb25pbmcgc2No
ZW1lIGFuZA0KPiB0aGUgY29tcGF0aWJsZXMgdGhhdCB5b3UgaGF2ZSBjcmVhdGVkIGRvIG5vdCBy
ZWZsZWN0IHRoYXQuDQo+IElmIHRoZXkgd2VyZSBiZWluZyB1c2VkIGFzIGEgZmFsbGJhY2ssIEkg
d291bGQgcmVxdWVzdCBzb21lIHZlcnNpb25pbmcuDQo+IFRoYXQncyBub3QgZ29pbmcgdG8gcmVh
bGx5IHdvcmsgdGhvdWdoIHNpbmNlIHRoZSBjYW5mZCBmZWF0dXJlcyBvbiB0aGUNCj4gamg3MTEw
IHJlcXVpcmUgc2V0dGluZyB1MF9jYW5fY3RybF9jYW5fZmRfZW5hYmxlLCBzbyBuZWl0aGVyIG9m
IHRoZXNlDQo+IGNvbXBhdGlibGVzIHJlYWxseSBoYXMgYSB1c2UgcmlnaHQgbm93Lg0KPiANCkkn
bGwgYWRkIHNvbWUgdGFnIHRvIGRvIHZlcnNpb25pbmcuDQo+ID4gKyAgICAgIC0gc3RhcmZpdmUs
Y2FuDQo+IA0KPiBKdXN0ICJzdGFyZml2ZSxjYW4iPyBDYW4geW91IHBsZWFzZSBhZGQgZGV2aWNl
IHNwZWNpZmljIGNvbXBhdGlibGVzIGZvciB0aGUgU29Dcw0KPiBvbiB3aGljaCB0aGlzIGlzIHVz
ZWQ/DQo+IA0KV2lsbCBhZGQuDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIG1heEl0ZW1z
OiAxDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+
ICsNCj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBtaW5JdGVtczogMw0KPiA+ICsNCj4gPiArICBj
bG9jay1uYW1lczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiBhcGJfY2xr
DQo+ID4gKyAgICAgIC0gY29uc3Q6IHRpbWVyX2Nsaw0KPiA+ICsgICAgICAtIGNvbnN0OiBjYW5f
Y2xrDQo+IA0KPiBEcm9wIF9jbGssIHRoZXkncmUgYWxsIGNsb2NrcyENCj4gDQpXaWxsIGRyb3Au
DQo+ID4gKw0KPiA+ICsgIHJlc2V0czoNCj4gPiArICAgIG1pbkl0ZW1zOiAzDQo+ID4gKw0KPiA+
ICsgIHJlc2V0LW5hbWVzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6IHJz
dF9hcGINCj4gPiArICAgICAgLSBjb25zdDogcnN0X2NvcmUNCj4gPiArICAgICAgLSBjb25zdDog
cnN0X3RpbWVyDQo+IA0KPiBTYW1lIGhlcmUsIGRyb3AgcnN0Xw0KPldpbGwgZHJvcC4NCj4gPiAr
DQo+ID4gKyAgc3RhcmZpdmUsc3lzY29uOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMu
eWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS1hcnJheQ0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAg
ICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBwaGFuZGxlIHRvIFN5
c3RlbSBSZWdpc3RlciBDb250cm9sbGVyIHN5c2NvbiBub2RlDQo+ID4gKyAgICAgICAgICAtIGRl
c2NyaXB0aW9uOiBvZmZzZXQgb2YgU1lTX1NZU0NPTl9ORV9fU0FJRl9fU1lTQ0ZHDQo+ID4gKyBy
ZWdpc3RlciBmb3IgQ0FOIGNvbnRyb2xsZXINCj4gDQo+IFRoZSBkb2NzIEkgaGF2ZSBjYWxsIHRo
aXMgcmVnaXN0ZXIgIlNZU19TWVNDT05TQUlGX19TWVNDRkciLiBEaWQgdGhlIG5hbWVzDQo+IGNo
YW5nZSBzaW5jZSB0aGUgVFJNIEkgaGF2ZSB3YXMgd3JpdHRlbj8NCj4gDQpUaGV5IGRvIGNoYW5n
ZSBvbiB0aGUgODEwMCBTb0MuDQpPdGhlciBkZXNjcmlwdGlvbnMgbWF5IGJlIG5lZWRlZCBmb3Ig
Y29tcGF0aWJpbGl0eS4gSSdsbCB0aGluayBhYm91dCBpdC4NCg0KVGhhbmtzLA0KV2lsbGlhbQ0K
PiA+ICsgICAgICAgICAgLSBkZXNjcmlwdGlvbjogc2hpZnQgb2YgU1lTX1NZU0NPTl9ORV9fU0FJ
Rl9fU1lTQ0ZHIHJlZ2lzdGVyDQo+IGZvciBDQU4gY29udHJvbGxlcg0KPiA+ICsgICAgICAgICAg
LSBkZXNjcmlwdGlvbjogbWFzayBvZiBTWVNfU1lTQ09OX05FX19TQUlGX19TWVNDRkcgcmVnaXN0
ZXINCj4gZm9yIENBTiBjb250cm9sbGVyDQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAg
ICAgU2hvdWxkIGJlIGZvdXIgcGFyYW1ldGVycywgdGhlIHBoYW5kbGUgdG8gU3lzdGVtIFJlZ2lz
dGVyIENvbnRyb2xsZXINCj4gPiArICAgICAgc3lzY29uIG5vZGUgYW5kIHRoZSBvZmZzZXQvc2hp
ZnQvbWFzayBvZg0KPiBTWVNfU1lTQ09OX05FX19TQUlGX19TWVNDRkcgcmVnaXN0ZXINCj4gPiAr
ICAgICAgZm9yIENBTiBjb250cm9sbGVyLg0KPiANCj4gQ2hlZXJzLA0KPiBDb25vci4NCg==

