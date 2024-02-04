Return-Path: <linux-kernel+bounces-51420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E95B848B05
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589FC1F241DD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851386FA8;
	Sun,  4 Feb 2024 04:36:31 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2110.outbound.protection.partner.outlook.cn [139.219.17.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C615E5C8;
	Sun,  4 Feb 2024 04:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707021390; cv=fail; b=GEbVvUXUJh7et/0JxSZSHcHfZzOrL9coNN9yYdg5jIO4lHueKBQ0rIKul4CpykU+gySdS36zAU4DtVylQLDsc7ZbR0OJ54xhrhNk3gKzTFt/at3VzPapenxtz1TCTCVQWRN3FlgNGDjXQdhucrGF/T41fBUeEWlTK4W4IUSdyIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707021390; c=relaxed/simple;
	bh=xM0rQQqpdXIeXMTyOrJSDM/ll7BB3p58wx2q8HkvxK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kAt+QwBRTu0MmdSjHvnJ+A28Clt4prfaZgRtZaESlNbnyjyROHRlfRl/8SSqEr/74gvmWysqvX96WdwdTu5b3T2QryfSMWQCpZwD1wUKT7eUuf8GwSVHWlwU3dpvcSYEziYWAJOdyG1/xNMYUagkETpOoC/OmUw9v5LrFyF5uxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DB8bvlEyV8v4AklccW1zZ9niNzxNux/cph26O+sNMShZ2GIUBcjOZoprHRNYUugDBAmgpE0Pkfdz+MpdVkxOn6RjwFWXWNYTlAFGoVVkIw1U73rHf56ZiLtfHZ4xR6UynSBTzG9DT/h4aOt1eFq5M8t99CtmhTCpIisP3iJadFg6bDvzTK+21wp4PyReiZeDJL1h4sHlmu6+wmFE91bRl4ZgimFCQD+Z4Fq2mHswU1nB8VlnzMSrRee9vF4/W1jO1pP/p07TI+I/FvJBKytWkN3/9pN6v5YOMRJqkLZJtDRjVpj4dKsM+9wY8Ic87+Zy0T8cFibszS4YEicC7lqCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM0rQQqpdXIeXMTyOrJSDM/ll7BB3p58wx2q8HkvxK4=;
 b=LlAOPOq/j5LA79SLGBMBDEmEHEo2eTcj7xzqwmmYrT3dJLYM6j6bzImNnywNG37xgRXh0BpgAQY1RcAJYx72WNmU3KKApPxhqM5fHA3jaD4r7UBqhbBVzneNRvB2D3lln2TXKKWzHSIw5F7kBmWKYGNymFKqkHPHLoN/kWAVChlFgjpZGlqq3fXecfKU/8Uu3tRs9QMpPP5fmxHj9GPiMEYGGIdUorj8popmIr1mIf2WkxUv9kjoYFHg/V0+tX2zO8bVHdI6UnTOyeMgiSxxTOVj9vkuP6A8pWmiQmRvSY3fPPaxVV0s36OM+amlJJAy4FXSutSNBhcFMpDK5odrwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0880.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Sun, 4 Feb
 2024 02:01:04 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.025; Sun, 4 Feb 2024 02:01:04 +0000
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
 =?gb2312?B?u9i4tDogu9i4tDogu9i4tDogW3YyXSByaXNjdjogZHRzOiBzdGFyZml2ZTog?=
 =?gb2312?Q?jh7110:_Add_camera_subsystem_nodes?=
Thread-Topic:
 =?gb2312?B?u9i4tDogu9i4tDogW3YyXSByaXNjdjogZHRzOiBzdGFyZml2ZTogamg3MTEw?=
 =?gb2312?Q?:_Add_camera_subsystem_nodes?=
Thread-Index:
 AQHaU1XbC4h2Cxa8Q0qBcekBfbY08LDz/xMAgAC4KBCAAR2gAIAAguQQgADwi4CAAixdsA==
Date: Sun, 4 Feb 2024 02:01:03 +0000
Message-ID:
 <SHXPR01MB0671F4FA0292CDF3034FEE48F240A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240130082509.217683-1-changhuang.liang@starfivetech.com>
 <20240131-recycling-entering-b742e0e835eb@spud>
 <SH0PR01MB06675EF7ACD1452C4DEBE45FF243A@SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn>
 <20240201-handiwork-excretion-36aa2eea0709@spud>
 <SHXPR01MB0671975B6B2455E43A5C7D86F242A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
 <20240202-spoiler-deceit-0e9ac720fd2c@spud>
In-Reply-To: <20240202-spoiler-deceit-0e9ac720fd2c@spud>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0880:EE_
x-ms-office365-filtering-correlation-id: d07fa423-eb82-46b5-1623-08dc252524b3
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6ZGrGks22nVeZuArXZuw3aKAJEhp+WztYrsA8Y1MK+VQ14kj+CYe44JUioPGeLnMmo7YM6G/eoKfpjKD/xJjps30JMwis+o8P92cUE8LYB53s6wpgvC87uOsV0Pj3ow5ZpPWP/yxCssomCg6YJmX27ZCdsENrhiqtOSpaBLs1OjL1ljbqHOVK53Rc6j8Uh/FTfvb78WiXE/dkLtoaYD5/nRadBFnlmIDjtzAajZYng42DnRq1f76bn2yKZ3bUh78OYRo0Jbq+cShRIIeHgFB8ss+3VTdnam8FuRlkTLte01170nJRKvEJIXdxlRiQ5vk6SsIxEpl5QomUHted26ZUA6JB/icmW3oN/WQQ12mKf0SG9SESSpvgHFyrucMdF29ul9JJkXp1+B92mjwk1qwSOU8IY1o3/FvCKZR4aJ40zhf/bS7ZELclJQaQ6CzWvj74Ny8CoIMY9QhPuhmeLUhHVaRA1VWuyMN+XS5bMz26rZAwezOolNe9Gwsjz0ZZbx1dps9zp3AYXvwOri92V1zMlOMqtn/WU+MSXSDzr6RIEK0VtaJcYLhFivHf1sCNZQs
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(396003)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(508600001)(64756008)(6916009)(41320700001)(38070700009)(224303003)(76116006)(8936002)(66446008)(66556008)(33656002)(4326008)(66946007)(44832011)(2906002)(66476007)(7416002)(86362001)(7696005)(9686003)(40180700001)(38100700002)(122000001)(5660300002)(40160700002)(83380400001)(966005)(54906003)(71200400001)(41300700001)(26005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dk85Y1h2YzhHY3ZmZ1FUT1NnK09zdlBLVFpuZVJ0c2VOenQ5NW1oZURwNkdB?=
 =?gb2312?B?QnByUmFvbFpoVWxhM0NNaVRlS1hMM0RvOFdPMjZpUEhycXU4ck83d0xIZVJ5?=
 =?gb2312?B?ZjR2QkZwN3V3UU04VEJ3aXp4bGhjc2cvRmd1dlFIVjU0NTRPb3ZPY2pIeEg0?=
 =?gb2312?B?NWRBQjFVeklYa1l4dWRKU3J0VEp1dWZzd0FoQlFmNk9BaFJOQTVwMDd0L20y?=
 =?gb2312?B?bE5yYzFGT0g4S1M1UTBpQWJZcGp2cFFYZ1YvZFIvUE1mUll6N1BlYlZiT2Rp?=
 =?gb2312?B?MUV3alo1Yjk0a1F3UTU2a3lXZFM0Nk9zcUxCYThoNjdzT28rWEJ3Y3p6OC9V?=
 =?gb2312?B?Smc3aFVIQmRWa1JNUG8rVWdobGZmTTE0VXRseUdOVzJzb1E2MTNRL05EY2Fj?=
 =?gb2312?B?T2t5QjFhTHRUd1hFckFBVU1rY1Q5VXpiMktkVkgzY1JxTG9zRU1wTU5tcnZ4?=
 =?gb2312?B?VnpHdk1oVG9POTF5TUttOWtRc0I3ekdHS2Z6c25tOEo5WDJ4Wi96Y1hHZHhZ?=
 =?gb2312?B?QWR4V1kxbHNOVDhsSy9RWEdaTzJOaDdlNG5RdE9aemhUVGNVRktqeWR0MGpG?=
 =?gb2312?B?MjVXVUJXQjFZem5yS3Z1bGhzZm9HWnU4bG12bnNGSVMzSzdmcm1peGpleHFs?=
 =?gb2312?B?M3VEZk9vNllTWHE3Z0pvSmNCeGNvNWYrb2poM3p3Tmxnc3F5S1dTTTlubDVn?=
 =?gb2312?B?N3N2ZE5haXZBVTBuT2E4VTIrTUV5RGthNkdKZkpHeXJvRnBOcHdrdXhWZ1BP?=
 =?gb2312?B?Uk1uWUg0dUpFOEk2emZsUVVvaFFyNVh3MHJ5bjRnOXliVy9HeEdjWEpLdktX?=
 =?gb2312?B?Nit6M0htZ3VxdUdzUUt5bmd6RXVpQ1dyL1F3MVFEcTIvdk9PS3IyTDVJV0lj?=
 =?gb2312?B?cVpPUGRGeUMzbWdnRlFhZDcrNjlCdytxZXRORjZ6UXZvcVJ0Wk5yQzJVR2Rt?=
 =?gb2312?B?UER0MHo4UHlxK2xhY1drb0hKSjNRdjE2NThWN1JYdERiVC9tUjczaFpkdU9B?=
 =?gb2312?B?eExYSGhnVjJSd09IS3dwQWlsZURkOUE0R0o5NkRWOFRGekp6c0RLWVREdnZX?=
 =?gb2312?B?cWJ1L2l2a1I1OUtUSEFHQVVyd0lnWmhUN09kdkVsMFFCazdxUGc5Nkh0RDFX?=
 =?gb2312?B?bkd5dHhaU2tDT2xoZEtoaHl6MUE1WUlwRStRMFpId3IxOXFOT0Z5dEdnUFhW?=
 =?gb2312?B?U1VrY0YrYWRCWHU0N3RxQm80QzBoRE42aXQ4a2l4THBOTEYvNVBBRXA3RVR3?=
 =?gb2312?B?aUVOV3VGYnBCY0hoZGtlMWR0VjZ0c2IzQnFRVmxmeExTUHVBU0FxNi90K0Nw?=
 =?gb2312?B?OVVvYUwyM0F3ZlZMUktwdmNKK3g2b1BuZUM3RXZWN1B4MExVQ3daclQxamFa?=
 =?gb2312?B?a3RZbkFnKzM3aVNFSjBrSEZjdUlmV3lJbDVXMUZUYks4VkJmbG00MWk3bkc0?=
 =?gb2312?B?aEh1RE8rR0doR3ZFQkJWT3cySmpud3d4SWZFaVUxc3lidUMvNlFjbUplK1ZM?=
 =?gb2312?B?c2QrMXFCMVZMSmdzc1BlV2VIaFI0ZjZxcVFCWVFwd05nMG1lVmw4SGc2YVJC?=
 =?gb2312?B?RWFrKzg1SkNvaC82dmtuWmRqL3JpT1ltcjdYSytYRTJ5cU5Ha0JZTHNZKzRG?=
 =?gb2312?B?dWkzRnN0L0dCSm1QMllMN3ZqTVJMQ0ttV2t4Rm1PQ2lBbHZjRjZWMWhGNFpT?=
 =?gb2312?B?SHFmUHRlK1BDMXlscitOVE1naTBuaHFOUmJhUHVCa1RkbE5MR0tweG9jNnlT?=
 =?gb2312?B?aWFOWTh3RGJ6RlZKa1BTczF6MWRzcTAvTmZVWCtJY2lhWnhRNjhSTy9BTHdF?=
 =?gb2312?B?S05zamMxN3BKeXUweU1XUzVnOHFrUzhOd0t6ZXdWQXFUQ2lKYnVxN0pEVWx3?=
 =?gb2312?B?bjUrNUwvOFU0aExML3hoT1NWb3lVdkRNRittTW5ibGNxV1hJeThwMXhZTGNV?=
 =?gb2312?B?WWc1U0M4SUQ3SmpGRjc3ZmtySXk0N2dWV3hzUGhaVVRZejNkYzFmaEFneWc2?=
 =?gb2312?B?M29qaHFKUFdyLzAzZVQ4S2o2R3NTcU5OY0NyZTJxc21jMjBqU0NCaHIwYnRR?=
 =?gb2312?B?T0xnMXptZ0hhTHZoY2Q1NVZJMWJ0QVYzN0ZobUFVZzNnOXkwWXRvc3ZCSG5p?=
 =?gb2312?B?ejI2Ti9IU1JqR2JGaU83QVI3K3NDZnNIbk5VMlQrdmNXUkR3dGxzOTBMQlZB?=
 =?gb2312?B?S3c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: d07fa423-eb82-46b5-1623-08dc252524b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 02:01:03.9248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHWwIRNVGyw+zNkdofUDBRhi3kvapoN4NIL1ztv16dFFdA+rNz8K69KB8d49AabzFOE79T/eVZ3cv+evINja2l05WQIgyuc+lGGXrO4D9YA1+tv0QdoJ6GxwHgAGSJV4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0880

DQpIaSwgQ29ub3IsDQoNClsuLi5dDQo+ID4gPiA+ID4gPiArCWlteDIxOV9jbGs6IGlteDIxOS1j
bG9jayB7DQo+ID4gPiA+ID4gPiArCQljb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsNCj4gPiA+
ID4gPiA+ICsJCWNsb2NrLW91dHB1dC1uYW1lcyA9ICJpbXgyMTlfY2xrIjsNCj4gPiA+ID4gPiA+
ICsJCWNsb2NrLWZyZXF1ZW5jeSA9IDwyNDAwMDAwMD47DQo+ID4gPiA+ID4gPiArCQkjY2xvY2st
Y2VsbHMgPSA8MD47DQo+ID4gPiA+ID4gPiArCX07DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXaHkg
ZG8geW91IG5lZWQgYW4gb3V0cHV0IG5hbWUgaGVyZT8NCj4gPiA+ID4NCj4gPiA+ID4gVGhlIG91
dHB1dCBuYW1lIGNhbiBiZSB1bm5lY2Vzc2FyeS4NCj4gPiA+ID4NCj4gPiA+ID4gPiBBbHNvLCB3
aGVyZSBkb2VzIHRoaXMgY2xvY2sgY29tZSBmcm9tPyBJcyBpdCBhbiBvc2NpbGxhdG9yIG9uIHRo
ZSBib2FyZD8NCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGNsb2NrIGNvbWUgZnJv
bSBpbXgyMTksIG5vdCB0aGUgVmlzaW9uRml2ZSAyIGJvYXJkLg0KPiA+ID4NCj4gPiA+IElmIHRo
ZSBjYW1lcmEgaXMgbm90IG9uIHRoZSB2aXNpb25maXZlIDIgYm9hcmQsIHdoeSBhcmUgeW91IGFk
ZGluZw0KPiA+ID4gdGhpcyB0byB2aXNpb25maXZlLTIuZHRzaT8NCj4gPg0KPiA+IEl0IHNlZW1z
IHRoYXQgSSBuZWVkIHRvIHVzZSBkdHNvLiBSaWdodD8NCj4gDQo+IFllcy4gRldJVywgdGhlIHNh
bWUgY29tbWVudHMgYXMgYXBwbGllZCBmb3IgdGhlIHNvdW5kIGNhcmQgV2Fsa2VyIHRyaWVkIHRv
DQo+IGFkZCBhcHBsaWVzIGhlcmUgdG9vLCB1bmxlc3MgdGhpcyBzaGlwcyB3aXRoIHRoZSBib2Fy
ZHM6DQo+IHwgSSdtIG5vdCBhZ2FpbnN0IGFsbG93aW5nIGluLXRyZWUgb3ZlcmxheXMgZm9yDQo+
IHwgaGF0cy9jYXBlcy9kYXVnaHRlci1ib2FyZHMgdGhhdCBjb21lIGJ1bmRsZWQgd2l0aCBhIGJv
YXJkLCBidXQNCj4gfCBhY2NlcHRpbmcgb25lcyBmb3IgYSBoYXQgdGhhdCBzb21lb25lIGRlY2lk
ZWQgdG8gdXNlIHRoZW9yZXRpY2FsbHkgaGFzDQo+IHwgbm8gbGltaXQhIFRoZSAic29tZW9uZSIg
aW4gdGhpcyBjYXNlIG1pZ2h0IGJlIGEgU3RhckZpdmUgZGV2ZWxvcGVyLA0KPiB8IGJ1dCBpdCBj
b3VsZCBiZSBhbnkgcmFuZG9tIG9uZSBvZiB5b3VyIGN1c3RvbWVycyBuZXh0IQ0KPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi8yMDIzMDUxMC1yaXZldGVyLXJpZGRlbi0zZjA1
NjI1MWU2MjNAcw0KPiBwdWQvDQo+IA0KPiBJIGZpZ3VyZSB0aGlzIGlzIGEgc2ltaWxhciBjYXNl
IGFzIHRoYXQ/DQoNClllcywgSSB3aWxsIGRyb3AgdGhlIElNWDIxOSBub2RlIGluIG5leHQgdmVy
c2lvbi4NCg0K

