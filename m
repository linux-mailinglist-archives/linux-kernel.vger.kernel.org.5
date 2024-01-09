Return-Path: <linux-kernel+bounces-20488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EDC827F99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BDE1F26E36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EEDBA28;
	Tue,  9 Jan 2024 07:41:19 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2048.outbound.protection.partner.outlook.cn [139.219.17.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA99D22063;
	Tue,  9 Jan 2024 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoUbD19AUq7kaiRqYLrbMxQvsadG/r6FeHrxfaz3pLzwFC/uwdMwOsM+mOCsN8tKgdUWFhyS4mQmGaDzqYMwHxcNmae9bBo8qmnIFpyOeA6PphUmt6KdiwKWiR7gFJwF5Wb054wBtnbVnX+ot5+rdcV+nBFw5F+9FBeU29nWcSNFntRev5tI/g0GtzB3yvrhp4TF+QGY79GljkXw0j9Mf+Ip0OxRpMb9LOAJkc0aYHOhwncglUvX669gltT7SEGICagv7WmrjlTzCfK4AjI70DozuwCS1nRD+518Ql3KJiaiLaHGiCU2QT7PI9lpVZlV8hXiEdIQK5Vy931gbC5i1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vyq7Q+mAltzqMLqBGXH+cOLZ0J3YphmfcQo0OiCMFo=;
 b=crquw/xCLs/FQO8VuDEsMTKk8+KIESXu8t8NuBkbDC5XryNXgKyRp7tN2WZ1JYiNlV5yjfrsZCs6FGdvKoNUe/OT1B1xr3/MiEZIonezYci9RWaEn2g68BB8Dzqw0K2lBUmfFyN2Py0Bcf1X0sPcFhZ7HGyZ28zRLBbeyxaN2+X8GtZYxA8E6krwtnw0nsA8uhoiGmEwVVQ5Mqvww886lfXpwIxkpam7x6v7m9iMDK6ONhE0o2NNR+DadLVevzpdx5kblD9SPRi+CMfcqcguqczmBaz/3jdVnEYVH0Z7pj0xTqLH/u4+6ZYX9Ie85eqH1ARW30E1IveyvTRSe1nr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0529.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Tue, 9 Jan
 2024 07:25:44 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::aaac:167d:8e0d:3acb]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::aaac:167d:8e0d:3acb%5])
 with mapi id 15.20.6933.032; Tue, 9 Jan 2024 07:25:44 +0000
From: ChunHau Tan <chunhau.tan@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, Andrew Halaney <ahalaney@redhat.com>,
	Jisheng Zhang <jszhang@kernel.org>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Russell King <rmk+kernel@armlinux.org.uk>
CC: Leyfoon Tan <leyfoon.tan@starfivetech.com>, JeeHeng Sia
	<jeeheng.sia@starfivetech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/2] net: stmmac: Add StarFive JH8100 dwmac support
Thread-Topic: [PATCH 2/2] net: stmmac: Add StarFive JH8100 dwmac support
Thread-Index: AQHaQgh2nf3c4aA7dki8/ENX7FGoorDPoBmAgAFzoYA=
Date: Tue, 9 Jan 2024 07:25:44 +0000
Message-ID:
 <BJSPR01MB05950484841C3D104EC91DEC9E6AA@BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn>
References: <20240108075810.14161-1-chunhau.tan@starfivetech.com>
 <20240108075810.14161-3-chunhau.tan@starfivetech.com>
 <1c0474d3-e182-48c8-8ec2-12847c84164b@linaro.org>
In-Reply-To: <1c0474d3-e182-48c8-8ec2-12847c84164b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0595:EE_|BJSPR01MB0529:EE_
x-ms-office365-filtering-correlation-id: 8d60b560-33fb-4ee9-c77a-08dc10e43170
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 R4BEhqMyY4y8/FsROFZRTX4FBQ9P2ny6gmHA2uuEo/g80HJhzocL3DFTBD4n3DjOFRAoZ/W4HuPiKykUVf47Yk9LDOZq0LsNSm05AbJ4PRCL//tIq2EQ+0nAGX5ejA2MlISNMqHEMiaop9pj5MfFw6x669W9yvwO8rfFCSts56MSZC+5V6RNQBZQ2mACgZAdqN/nGmR7/TJUz0gwZtVkrdv5ImfMOLqh9M+3dvQHjlp2uszXzUDY/J2Pwvl3rhvKntt3WFNFnXvk+ETU0vo2f4W9aaxN9AU4qnYqwGc8noY2J8QcWHs2pxfY8S2zCFs+9/AsT/KgcLC0JMGOkuChSmNxdgCw64+jz2rjd4hKWcm+VuH+wbfkW+V55YN0rQwb6YxgSNHtZN/wOBa5dMOEd7UolK5EMPfVZh17UOAZpN9UionrpXNerI/neW+XFUTb2+VEBDAebOvdATIDfnqqEu3Whe3BxXNhMnXx731ga+va8SVcgiuLRBfOtnxo1nUahwg/SyN0ujTajkG4y/eGX33Gb2gYZLbf0Kjq+lKYKJb9smgYteoDKQtGKfxlYrIfw/XuROmLrFa5p90YTeMvaw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(346002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(41320700001)(921011)(71200400001)(7696005)(53546011)(55016003)(9686003)(508600001)(40180700001)(122000001)(33656002)(86362001)(40160700002)(83380400001)(38100700002)(38070700009)(7416002)(2906002)(66476007)(26005)(110136005)(8676002)(8936002)(66556008)(64756008)(66946007)(54906003)(66446008)(5660300002)(4326008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnBsOHVOb1NxS29yQ3FsbnBWMFlvU1E0TVkyZTgrRHI2dVJySTFMb1ByQmtt?=
 =?utf-8?B?Wm1RL0N4M05sQmVIL1VTVFpTSVZjSWU5VHY1Q2hVb0cybGw5eUFicUFRMk85?=
 =?utf-8?B?WDl4NUlhS1o1SW0wZVpOV2NjbVVDQ0Q0NDN6dThoWmU3Uk5qT2xWN25vYzhI?=
 =?utf-8?B?TXBqV1dyVGo1VDF4akhaVnBiMDVXUGc2MU52b1BNNUFMR1RzVVEvbU9ucVEw?=
 =?utf-8?B?VEZwQkM4OTc3NlJXWHNwVGcwY0R1UGxSTmVUWkwxOS9xbzI1U1B4VVQrVWdP?=
 =?utf-8?B?RmpYUnE2b0N1WjJGQWp3dVBCZE9OQ1pQM1FFc0tuckk1dDhmMzhxWG1mYkZm?=
 =?utf-8?B?dVpQMWpQQVk4K3VkdldSK3o0d24vaEM0d1BJTE5sZTFNNjE2eW11Zzl0UEtD?=
 =?utf-8?B?SXZmZXdCaFJEa0p4Nmt1TFQvSDJ2c25BczlRSjh3Y21kcnQ4eXRiRFBhQUNx?=
 =?utf-8?B?cnBvQkNPTzdTUnZKb29xaFQ4WDFDa0o5K01OR0tyT2Z5TTJIaEVXeEpxU2NN?=
 =?utf-8?B?V3ZIRE15ZGIrYlB5cjNwYUE5RHI0YVRYaE1Ec1RaOXJxeG1panlQZXNoWERn?=
 =?utf-8?B?MlcxWmZKWXg1ZjhTdWQ5YWlIUmlNVnJNV3MzR2JlSnFVdU5WaE1GdmRjcUFC?=
 =?utf-8?B?UGt1anorMUFVdUhBL25BUWVDNjk5blVyWmRqTTU5UjZ5UkRLcGRvZUplb0RS?=
 =?utf-8?B?TnlpMGpKeUl0cENpaHdnS0hEcWtnZEhhOUJYS2pZbHc5cWZOSFZjNEtxaDFh?=
 =?utf-8?B?T2lYNmRHUXlqVmJhQ2lESlZnZ3FtWWdRaFF4NEZ6QUljQmRqZUpBZzM2T2RB?=
 =?utf-8?B?VDdlWFBrSTE5L0ZaSU1wcVczcmRKRFF3RzFQcHVqSmh6OG1DYXNmbCs4R3lT?=
 =?utf-8?B?Nzl1NTA1U2ZnekxsVjZMb1A2bTJIK2VXNFZldzFXRmJGWnBLQVB0dC9Fa0V0?=
 =?utf-8?B?UWVuMzlXbi9hcEtJZStwOXB0citYUzcrWmhtd21ZT3NxZ3BvR1J6RVB6S0lO?=
 =?utf-8?B?cVBHSmExN040QU1naU1xR2pSdlplT2VrYXQrUnNtS2psSVlEREpBaW5JdE5n?=
 =?utf-8?B?dXZXMGpGNFJURTNPUHFhQVdLdnVpb1ROeU1iNEVVc0tDdzBCZndVTmsxY0Fi?=
 =?utf-8?B?Z0Q4djQ4Z01PSHVpejZUemQ1VE11ZG5sNHdhbllWdUZVM0VOSXZuMTFDY0dN?=
 =?utf-8?B?RlhtaGtsNnFFeU1zVWZtcWg5N0xXN2tSak9Ud2JJUENZTjJOYTF6cHpOV3Ns?=
 =?utf-8?B?R3JDc0VNYlNiN0JzMC9YclBPUDhlSjMvcWtyQ044MkFZU2t3SGVibktsdWlU?=
 =?utf-8?B?c1oyaEM0QmIrTlBSTWwzNkFOM0JtQnBWL0JRdy9KNm1HT3RpRzNsNUlDMVhM?=
 =?utf-8?B?Wm9Ib2t0RlVTSnlMc2E0azZ5RGJqcXp6dUtyQlJ3UkFrallodDc3c09YU3ha?=
 =?utf-8?B?OFdzNUJhdmhzTkk4Tm0vbTUzR0VMRWt6Nzk4QUNlcGw0REFXU3YwWlNSM2xZ?=
 =?utf-8?B?TStObjRteDNoMnM4UWVpSTVKaHdMMHNkNkRvcWJyaS9BbW9oc3hwMFBjZ2c3?=
 =?utf-8?B?RW5hbi8wbGw1MnE4bWwzREFQK2JiaHVqUE54bGJnRGhiNjBkQWoxSXZEd1hv?=
 =?utf-8?B?VlA2SThNc3k1ZmJLeExEWG41RFhCMHpBRUcyOVErR0JzQjN2OC9CNTN5R0tB?=
 =?utf-8?B?VFpXekRvZDJESndlUFBUcFRBaHpzZm1zT1FxZjVEUS91Z1lvWG44QXpPNWh4?=
 =?utf-8?B?dVo1eGErM3lHNlpCak8vQlpyZWJQdEtMRnhpd1VhWDhPeTFoRDJHd29kU0JP?=
 =?utf-8?B?aDdTTU9UMWxCWXhJV2ZoVFVFMEViclVRWHVMNmNqZ1IrR0x4UVRld2lqeENK?=
 =?utf-8?B?Wk9iRkl6ZE9tWmxKc1N1SDZ4UjhnVnYyNklBR1Z6Q0pqaHpPK1NOdGVJQjQ1?=
 =?utf-8?B?N1pQY09ZUDRPVmNQOTExUktxWnVkYm9wVkkzVmFWakpMZzVHSGFLQTlzQ3hH?=
 =?utf-8?B?RGhuZE1LNG45WlZNalpLQ0RRSlI2Zncya0M1VkZ4MkhUaXc0UXBJL3IwTUti?=
 =?utf-8?B?Um5UZm1FQzdKaGh2N2hSNk4xTWJ4emsvTTAxaG8wUWkxUXEzWTgrdEVxRGs4?=
 =?utf-8?B?c3MyT2NOVm12bFZUWDhuek1VbUJvOUN2VXFFNVN3OW03Nk9xVmthTWhJZ0tG?=
 =?utf-8?B?TEE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d60b560-33fb-4ee9-c77a-08dc10e43170
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 07:25:44.7227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqkYrpwsJ/DFnySfUtUoOSKNqaGVuXwPfAH78vA6ZKdmoXBl60JKATOa8cOT4IRuNAmY8ZLyQLJi3qPX404w/8C0aWTFI4EQQ5t+OCNsA+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0529

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIDgg
SmFudWFyeSwgMjAyNCA1OjA3IFBNDQo+IFRvOiBDaHVuSGF1IFRhbiA8Y2h1bmhhdS50YW5Ac3Rh
cmZpdmV0ZWNoLmNvbT47IERhdmlkIFMgLiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+
OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNraSA8
a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgUm9iIEhl
cnJpbmcNCj4gPHJvYmgrZHRAa2VybmVsLm9yZz47IEVtaWwgUmVubmVyIEJlcnRoaW5nIDxrZXJu
ZWxAZXNtaWwuZGs+OyBSb2IgSGVycmluZw0KPiA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsNCj4gQ29ub3Ig
RG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgTWF4aW1lIENvcXVlbGluDQo+IDxtY29xdWVs
aW4uc3RtMzJAZ21haWwuY29tPjsgQWxleGFuZHJlIFRvcmd1ZQ0KPiA8YWxleGFuZHJlLnRvcmd1
ZUBmb3NzLnN0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz47DQo+IEJhcnRv
c3ogR29sYXN6ZXdza2kgPGJhcnRvc3ouZ29sYXN6ZXdza2lAbGluYXJvLm9yZz47IEFuZHJldyBI
YWxhbmV5DQo+IDxhaGFsYW5leUByZWRoYXQuY29tPjsgSmlzaGVuZyBaaGFuZyA8anN6aGFuZ0Br
ZXJuZWwub3JnPjsgVXdlDQo+IEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRy
b25peC5kZT47IFJ1c3NlbGwgS2luZw0KPiA8cm1rK2tlcm5lbEBhcm1saW51eC5vcmcudWs+DQo+
IENjOiBMZXlmb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT47IEplZUhlbmcg
U2lhDQo+IDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPjsgbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LXN0bTMyQHN0LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb207DQo+
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIDIvMl0gbmV0OiBzdG1tYWM6IEFkZCBTdGFyRml2ZSBKSDgxMDAgZHdtYWMgc3VwcG9ydA0K
PiANCj4gT24gMDgvMDEvMjAyNCAwODo1OCwgVGFuIENodW4gSGF1IHdyb3RlOg0KPiA+IEFkZCBK
SDgxMDAgZHdtYWMgc3VwcG9ydC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRhbiBDaHVuIEhh
dSA8Y2h1bmhhdS50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWMtc3RhcmZpdmUuYyB8IDEgKw0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21hYy1zdGFyZml2ZS5jDQo+IGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWMtc3RhcmZpdmUuYw0KPiA+IGlu
ZGV4IDVkNjMwYWZmYjRkMS4uMzczNzE0ZjZlMzgyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjLXN0YXJmaXZlLmMNCj4gPiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21hYy1zdGFyZml2ZS5jDQo+ID4g
QEAgLTE0Niw2ICsxNDYsNyBAQCBzdGF0aWMgaW50IHN0YXJmaXZlX2R3bWFjX3Byb2JlKHN0cnVj
dA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgc3RhcmZpdmVfZHdtYWNfbWF0Y2hbXSA9IHsNCj4gPiAgCXsgLmNvbXBh
dGlibGUgPSAic3RhcmZpdmUsamg3MTEwLWR3bWFjIgl9LA0KPiA+ICsJeyAuY29tcGF0aWJsZSA9
ICJzdGFyZml2ZSxqaDgxMDAtZHdtYWMiCX0sDQo+IA0KPiBObyBkaWZmZXJlbmNlcz8gVGhlbiB3
aHkgYXJlbid0IHRoZSBkZXZpY2VzIG1hZGUgY29tcGF0aWJsZSB3aXRoIGVhY2gNCj4gb3RoZXI/
DQpUaGVyZSBpcyBhIGRpZmZlcmVuY2UgYmV0d2VlbiBKSDcxMTAgJiBKSDgxMTAsDQpKSDcxMTAg
aGFzIHR3byByZXNldCBzaWduYWxzIChhaGIsIHN0bW1hY2V0aCksDQp3aGlsZSBKSDgxMTAgaGFz
IG9ubHkgb25lIHJlc2V0IHNpZ25hbCAoc3RtbWFjZXRoKSwNCnRoaXMgd2lsbCBiZSBzaG93biBp
biBkZXZpY2UgdHJlZSBmaWxlLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

