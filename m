Return-Path: <linux-kernel+bounces-96602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1297C875ED0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFD1284EE1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779E94F61C;
	Fri,  8 Mar 2024 07:49:20 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42C4EB43;
	Fri,  8 Mar 2024 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884159; cv=fail; b=P6my+Z9efqib587nQkj2T5p1b4dUml4NPSA2l+z52c1owmVl4PKFjgXUT1FmGUVbC7H8YQ23FXrOva7jC4D7/wXZAj84lJc78Eg6A/8AKY/xfBBgMws1pvVVESJwHkoN7IB2YrDzSfk8zGrKY/O1SoRRwgDv37EeEkFuiXHBh2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884159; c=relaxed/simple;
	bh=N8TgvrfBkIFsl5FQLWt1cMce6ac/UMaWKJZgZQg9R9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=onUhgKkuv7fsJOHeu9CJZPEDR9/w8U1nodYl2C0zCAvGsITTveiNoRVnqTnSrkCIOUhYrEUfWgFLkQKlvUiSsyDlNdLLf0eW3wwcQrLkKINDpO0VOmmBQLmKnXlX5TzHeSzw+c+wdNzsfmgjUsUB1rDXaEOvAB2chuVvfsHzPck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/pluIahImGERTcBvfHD51Ck4Io0lH0xNrizrS9jGkr0EaQT5RFj5Q8tQPuoLOgSaWTWna/A4KT0RXDNbzvCNWUUhBHyepibgNQuqdV5hvZHYxE8Q7K05Oj3UON1DmQ55WAXEVCxJoiSYkhA2Aii2knhy6uRvrZ/g3lOG8qq7yC9JIwaOJRjb2h+otOUUBjv4xWg2dq+eXGi/KS04VfxMn3s3UFnZuBGjwMS2u/jWBs2ssx89jWlOXP6FUVrzpvUdxxqu7xvnoKMGuSPdygXHDPG+WCNQvfrMDAIDE6YkJgo34JvSrGig4m2njxVmrAV37FDapND53kpK2eLQep9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8TgvrfBkIFsl5FQLWt1cMce6ac/UMaWKJZgZQg9R9E=;
 b=RvS+DQNdvHdG06DlxRlu8sR6p7+JAS7Vq8cuie/VV7nFAHmXM9ApDmwXk2fMQm/IGrAWVSnxz6Tl5cATktHUBktIKowps4w7TdepnCpBsmjJ3FIKI5Byiywmi6ja+Px+FR6qnDNufxWFYobBGgFR9qFE/R503/hUC00K8rkil0zRNTdjV1HzG57UEcXvLhbAgaJpcUfctSRbDiQlAWrQPyrDQ+Fq1NNF06oAp7fuV/37vNkmNvawL7QGSnWJxOmDV1Lk82OjYwqpQ0+lsxIbWZobkHVgjhmD3LcXhRcrLiCMkoevDcIoly5CUEpgXarydEbGG4/BXgMnq2PvNXbwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1084.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 8 Mar
 2024 07:49:05 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::20e3:6cc0:b982:ae95]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::20e3:6cc0:b982:ae95%3])
 with mapi id 15.20.7316.039; Fri, 8 Mar 2024 07:49:05 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai
	<tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>
CC: Walker Chen <walker.chen@starfivetech.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMS8yXSBkdC1iaW5kaW5nczogQVNvQzogQWRk?=
 =?utf-8?Q?_PDM_controller_for_the_StarFive_JH8100_SoC?=
Thread-Topic: [PATCH v1 1/2] dt-bindings: ASoC: Add PDM controller for the
 StarFive JH8100 SoC
Thread-Index: AQHacEDAGfG0pG/sOEqzgeaavlmQAbEr6kOAgAGEjIA=
Date: Fri, 8 Mar 2024 07:49:05 +0000
Message-ID:
 <NTZPR01MB095618FAFF22BDC301F69A0C9F27A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240307033708.139535-1-xingyu.wu@starfivetech.com>
 <20240307033708.139535-2-xingyu.wu@starfivetech.com>
 <0b92700a-cf79-4f1c-986a-d18fe0151bb8@linaro.org>
In-Reply-To: <0b92700a-cf79-4f1c-986a-d18fe0151bb8@linaro.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1084:EE_
x-ms-office365-filtering-correlation-id: 5a91fb30-1577-4e03-11cb-08dc3f443a93
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FyXUJSeEJ8nvN6R1SfRi6rH7qfVHHvzXrhMONuUp1uom+qjHuPXi5a0A0ouXzsrfgxUSNP41ucq88S0w1T5Bh9hSmEpPHgIEobWh6YNhCai4bLktph1D3CWPCSfVeLGGJShCmzJciyA95T8Dir9nnMwK/UZWnfwtMaOLQsjEEZzCFKPBumit7PJ6FPft0/VgSQcs56jeKZpfNvx887NvlwmRZ8/fPIif+ZomYG738Zlx6Dqn8cfcPvPtmHzMQ39MRaQM+HqxdwiL5h8w2lCrY3Y4MeUC9OS47vJ/qc5ADJBmfCGA3p80CsQgHRpEr1wrID1vX1oR7xeduio/RRvyLBW47jvnBWeYaziImXBAdgakvC5IQeskw88NjiuTfh10PkcTCzbGnL41QH1CiceTYKbEOTrhbJ9pZkjIrl3QWRJ1yaFoBb1KZSyxQpvgcT/Dz8oOok9Nz2AVCu5XEYRxcMY565NU3S1W83bSMC8znS6d+ZU/MA57Rwr3LdrZ3LxTPq7oqrqQSo7ubHj8uisC7IX0UWl62dcw9VnvxN/JOPa0fHwRbTHUny4F2i7qmmrIVYLK4er0DvkCDFu+bbWcsd/2R9IRyvJMV365k/leMdlaDLbdwO8Uh0j4D/jgNXdn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ck4rOHh6SEdyZmkzcXdOZ05nSlRpTlhscHV4ZUFDakR2WlV0L1JERVhCRWVv?=
 =?utf-8?B?RmVUM2szRHI3SjU5UHFVa3NXRkVoODAveGZuV2ZxYWVNamhVVVRmRi95djE4?=
 =?utf-8?B?eDh5Q0EvYlRmS09odkM4S0xTaldNajJpZkhzZWwzR2RQUzJEOEE3YUxDSWlF?=
 =?utf-8?B?QTdSMVNmYnAvWFdCcDNKMCtPbkdIZ2ppWUczRFBxOXZVa1FMaHJGYkkrZktI?=
 =?utf-8?B?UkhKL3lDUDJCdU9sTHU0VU5kcTdrSTNDUmNQUW15NjU4VHE2OXl6aHRUcTcx?=
 =?utf-8?B?dEVrQS9LVEhqQkUyVDZ5YmxKNjNQRVdMTkg4ZytiaDAwT2tsNVZCTTkxa0da?=
 =?utf-8?B?OWpNWmUvQWIvSzRTb0YweW1FS3hpRnBtUElmZEhJeW9kZjdLNDZWOTdZYnpy?=
 =?utf-8?B?SG56V05SUzZlSktZNnpCL1BPbkIzbGxTbGhYVkJJNUNZSzAzdVg4OWwvZ3cz?=
 =?utf-8?B?WGFqeW9pZ3FoMTMyRWpPTVJHekZiY1QyYkd3TGY2V242cG5wUUNML1YrbEpo?=
 =?utf-8?B?dFFPSFNCalYwbWt1QjQ1ME0vV3dhNVNUTkhXcEhjelZhdCs4NUVweENzWU95?=
 =?utf-8?B?UWgvWFdWQ2tWVGVGRzRQNTdPdDNzZ1UzOEJIallpUHlGSS9UYWlHMzF5L1p2?=
 =?utf-8?B?Q29aT2c5ejRmZ1hNVkVOaGVhSCtHUnMwcENkV1A1ekhTYkladXRDUlRVSTl5?=
 =?utf-8?B?eWZtZnRYOWgrd1pIa05GUkZIT1hySGQvM2cyVmFHVzlBVTIvdjdTaWNmUXhH?=
 =?utf-8?B?VEJsRmRyeGE5dnFpR2RrQ0hzR3kxSGhKMUJPalM3cWM1UFEzOVp6VG1ZbTdV?=
 =?utf-8?B?WHNpbVdsOUVEWTBNa1h6amhjUzhkMVoxLzVGVUhZMDE4VE9Bc0d0emRpUzhx?=
 =?utf-8?B?ZER2akRDKzNqbkFsd25TNFFxbVhzM3I2UkR0RnpSTk9QelZhaUtkc1dteEdx?=
 =?utf-8?B?eXZvQ0NwUnVVMERkU1BqbWhnckgxMG9uKytTdEpHWUE2YUVacDUyLytQeGEv?=
 =?utf-8?B?YWhSaE9HR0tlZTVZZVRFWlFJMExob0MwQjJReEVCUnFoM3g0cnVxTVp6U3lp?=
 =?utf-8?B?ZllScXFXRkhLaktCL3dySXpaMkJzWjJRblZuSXlWbitDU0wxeFhxN2o4UjNK?=
 =?utf-8?B?RzRVci9uSzJXSGtZZllOOURSamhGNGJWS2xPRzkwcEU1dHEza3ZXSHAvWXpL?=
 =?utf-8?B?bWcyQ0Q3RUdCS1d2WTlVV28yMWZpOE5Wb1hCR1E4aGt4bi9xT1lEbE9BWFB1?=
 =?utf-8?B?SXd2QWYxK3RYaS9PdTQxRXpxQlVybXpia1RPc0J3VG1UM25BMmVJNHFkTDkw?=
 =?utf-8?B?akhCTjkwT2JEejFnbWhwWUdxeks4MFVKUzk2MGcxZFB4Z1BDelBiOWdqRVEw?=
 =?utf-8?B?akt0NjVxMUhONzBNK2VzYXAzU3BkemQwT1JjQzlHWGJ6OTZoUUp5YTBoQlhE?=
 =?utf-8?B?VEZ3SGdiMHdRVmEwNlJXd1d3bnQzRHRadHZmWkpjWVVLczM4ekJEK2k4NXkx?=
 =?utf-8?B?cndHV2h1UHZWbmluZm1taWhvUXVLVi9mUDFrZzliek1RaUg0M21kbmxjbUg4?=
 =?utf-8?B?TTU3WWsxVWsyTkEyMVlxZEpnRFFNVG54RUt6SlNnUVFxQmdsaDZRR2pWR2VK?=
 =?utf-8?B?My9SM1FWcVVMakVFcFNoVmFvQlMzUEgrMk9Dd1ZuRWVUYkZMRE9mYllsTUxq?=
 =?utf-8?B?WFRIbzJYbzRzcFBvYXdXTEpsTWxFTHZ5UnFPVTF1Z2Q3eUJleTA0TlBjbGtZ?=
 =?utf-8?B?dmN0Tkw3S00rQjB4MFlQd2VneCtlbWpZUXdaY2RTeWYyNURXSzFhRUlkN0E2?=
 =?utf-8?B?c2crellram41ZzJrMm9VQ1lVcUZaNjBCTmlydFNieGNCdXpQVWxZZzNwT3Zy?=
 =?utf-8?B?aG42L1RKeXV5RzgxNGhZLzN6Z2xERWRSS2JibllPc3NWbVkyOWVDckZta0Fr?=
 =?utf-8?B?blFpTENmNTFrZFZwRDllQVByY044R3djd08zMGNicXgvMVhLdC9vWGlqKzhM?=
 =?utf-8?B?azJMTm9Jc281T2tSejN1NU9ETk0zK0RLOUx3MVZXV2NwNDYwNUo4bHlPa1Ri?=
 =?utf-8?B?bHhCVzN2UndrVjZadFpWeGNnUmVvNjRpeStmU1hkNWhiNmFiUnJZUGZYbVlC?=
 =?utf-8?Q?9F8HRSm3XDkSMhK3C3CyD9noP?=
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
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a91fb30-1577-4e03-11cb-08dc3f443a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:49:05.2618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RSGliUOnzrOe73JZ6JVDhGEe2Dr9xy1BAPQqGltEM6cIelSwdYs+D4jNsarNJsIMtIL2cixOpPhGGFLaVJcvlPYj9WS+YUoFAN5nh7m4sb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1084

PiBPbiAwNy8wMy8yMDI0IDA0OjM3LCBYaW5neXUgV3Ugd3JvdGU6DQo+ID4gQWRkIGJpbmRpbmdz
IGZvciB0aGUgUERNIGNvbnRyb2xsZXIgZm9yIHRoZSBTdGFyRml2ZSBKSDgxMDAgU29DLg0KPiAN
Cj4gUGxlYXNlIHVzZSBzdWJqZWN0IHByZWZpeGVzIG1hdGNoaW5nIHRoZSBzdWJzeXN0ZW0uIFlv
dSBjYW4gZ2V0IHRoZW0gZm9yDQo+IGV4YW1wbGUgd2l0aCBgZ2l0IGxvZyAtLW9uZWxpbmUgLS0g
RElSRUNUT1JZX09SX0ZJTEVgIG9uIHRoZSBkaXJlY3RvcnkgeW91cg0KPiBwYXRjaCBpcyB0b3Vj
aGluZy4NCj4gDQoNCk9rYXksIHdpbGwgZml4Lg0KDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBY
aW5neXUgV3UgPHhpbmd5dS53dUBzdGFyZml2ZXRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4v
YmluZGluZ3Mvc291bmQvc3RhcmZpdmUsamg4MTAwLXBkbS55YW1sICAgfCA4NCArKysrKysrKysr
KysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b3VuZC9zdGFyZml2ZSxqaDgxMDAtcGRtLnlhbWwNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9zdGFyZml2ZSxqaDgxMDAt
cGRtLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9z
dGFyZml2ZSxqaDgxMDAtcGRtLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uYTkxYjQ3ZDM5YWQzDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9zdGFyZml2ZSxqaDgx
MDAtcGRtLnlhbWwNCj4gPiBAQCAtMCwwICsxLDg0IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkgJVlBTUwgMS4yDQo+ID4gKy0tLQ0K
PiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3NvdW5kL3N0YXJmaXZlLGpo
ODEwMC1wZG0ueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEt
c2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogU3RhckZpdmUgSkg4MTAwIFBE
TSBjb250cm9sbGVyDQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ICsgIFRoZSBQdWxz
ZSBEZW5zaXR5IE1vZHVsYXRpb24gKFBETSkgY29udHJvbGxlciBpcyBhIGRpZ2l0YWwgUERNIG91
dA0KPiA+ICsgIG1pY3JvcGhvbmUgaW50ZXJmYWNlIGNvbnRyb2xsZXIgYW5kIGRlY29kZXIgdGhh
dCBzdXBwb3J0cyBib3RoDQo+ID4gKyAgbW9uby9zdGVyZW8gUERNIGZvcm1hdCwgYW5kIGFuIElu
dGVyLUlDIFNvdW5kIChJMlMpIHRyYW5zbWl0dGVyDQo+ID4gK3RoYXQNCj4gPiArICBvdXRwdXRz
IHN0YW5kYXJkIHN0ZXJlbyBhdWRpbyBkYXRhIHRvIGFub3RoZXIgZGV2aWNlLiBUaGUgSTJTDQo+
ID4gK3RyYW5zbWl0dGVyDQo+ID4gKyAgY2FuIGJlIGNvbmZpZ3VyZWQgdG8gb3BlcmF0ZSBlaXRo
ZXIgYSBtYXN0ZXIgb3IgYSBzbGF2ZSAoZGVmYXVsdCBtb2RlKS4NCj4gPiArICBUaGUgUERNIGNv
bnRyb2xsZXIgaW5jbHVkZXMgdHdvIFBETSBtb2R1bGVzLCBlYWNoIFBETSBtb2R1bGUgY2FuDQo+
ID4gK2RyaXZlDQo+ID4gKyAgb25lIGJpdHN0cmVhbSBzYW1wbGluZyBjbG9jayBhbmQgdHdvIGJp
dHN0cmVhbSBjb21pbmcgZGF0YSB3aXRoDQo+ID4gK3NhbXBsaW5nDQo+ID4gKyAgY2xvY2sgcmlz
aW5nIGFuZCBmYWxsaW5nIGVkZ2UuDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAt
IFhpbmd5dSBXdSA8eGluZ3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+DQo+ID4gKyAgLSBXYWxrZXIg
Q2hlbiA8d2Fsa2VyLmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiArDQo+ID4gK3Byb3BlcnRp
ZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGNvbnN0OiBzdGFyZml2ZSxqaDgxMDAt
cGRtDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+
ICsgIGNsb2NrczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBE
TUlDIG91dHB1dCBjbG9jaw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBNYWluIElDRyBjbG9j
aw0KPiA+ICsNCj4gPiArICBjbG9jay1uYW1lczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAg
ICAtIGNvbnN0OiBkbWljDQo+ID4gKyAgICAgIC0gY29uc3Q6IGljZw0KPiA+ICsNCj4gPiArICBy
ZXNldHM6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBzdGFyZml2ZSxzeXNj
b246DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFu
ZGxlLWFycmF5DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiArICAg
ICAgICAgIC0gZGVzY3JpcHRpb246IHBoYW5kbGUgdG8gU3lzdGVtIFJlZ2lzdGVyIENvbnRyb2xs
ZXINCj4gc3lzX3N5c2Nvbl9uZSBub2RlLg0KPiA+ICsgICAgICAgICAgLSBkZXNjcmlwdGlvbjog
UERNIHNvdXJjZSBlbmFibGVkIGNvbnRyb2wgb2Zmc2V0IG9mDQo+IFNZU19TWVNDT05fTkUgcmVn
aXN0ZXIuDQo+ID4gKyAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBQRE0gc291cmNlIGVuYWJsZWQg
Y29udHJvbCBtYXNrDQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgVGhlIHBoYW5k
bGUgdG8gU3lzdGVtIFJlZ2lzdGVyIENvbnRyb2xsZXIgc3lzY29uIG5vZGUgYW5kIHRoZSBQRE0N
Cj4gc291cmNlDQo+ID4gKyAgICAgIGZyb20gSTJTIGVuYWJsZWQgY29udHJvbCBvZmZzZXQgYW5k
IG1hc2sgb2YgU1lTX1NZU0NPTl9ORSByZWdpc3Rlci4NCj4gPiArDQo+ID4gKyAgc3RhcmZpdmUs
cGRtLW1vZHVsZXg6DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy91aW50MzINCj4gPiArICAgIGVudW06IFswLCAxXQ0KPiA+ICsgICAgZGVzY3JpcHRpb246
DQo+ID4gKyAgICAgIFRoZSBtb2R1bGUgeCB3aWxsIGJlIHVzaW5nIGluIFBETSBjb250cm9sbGVy
LiBEZWZhdWx0IHVzZSBtb2R1bGUgMC4NCj4gDQo+IFRoaXMgaXMgYW4gaW5kZXggb2YgdGhlIGJs
b2NrIGluc3RhbmNlPyBJZiBzbywgdGhlbiBpdCdzIG5vdCBhbGxvd2VkLg0KPiBPdGhlcndpc2Ug
SSBkb24ndCB1bmRlcnN0YW5kIHRoZSBkZXNjcmlwdGlvbi4NCj4gDQoNCk5vLCB0aGlzIGlzIGp1
c3Qgb25lIGluc3RhbmNlLiBUaGUgUERNIGhhdmUgdHdvIGludGVybmFsIGFuZCBpbmRlcGVuZGVu
dCBtb2R1bGVzIG9yIGNhbGxlZCBjaGFubmVscy4NClRoZXkgY2FuIGJlIGNvbmZpZ3VyZWQgYW5k
IHVzZWQgc2VwYXJhdGVseSwgYW5kIHRoZSB1c2VyIGNhbiBjaG9vc2Ugd2hpY2ggY2hhbm5lbCB0
byB1c2UuDQoNCj4gQW55d2F5LCBkb24ndCByZXBlYXQgY29uc3RyYWludHMgaW4gZnJlZSBmb3Jt
IHRleHQuIGRlZmF1bHQ6IDAsIGlmIHRoaXMgaXMgZ29pbmcgdG8NCj4gc3RheS4NCj4gDQoNCk9o
LCBJIGp1c3Qgd2FudCB0byBkZXNjcmliZSB0aGF0IGlmIG5vIHRoaXMgcHJvcGVydHksIHRoZSBk
cml2ZXIgZGVmYXVsdCB1c2UgbW9kdWxlIDAuDQpJIHdpbGwgbWFrZSB0aGlzIGNsZWFyIGluIG5l
eHQgdmVyc2lvbi4NCg0KPiA+ICsNCj4gPiArICAiI3NvdW5kLWRhaS1jZWxscyI6DQo+ID4gKyAg
ICBjb25zdDogMA0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+
ID4gKyAgLSByZWcNCj4gPiArICAtIGNsb2Nrcw0KPiA+ICsgIC0gY2xvY2stbmFtZXMNCj4gPiAr
ICAtIHJlc2V0cw0KPiA+ICsgIC0gc3RhcmZpdmUsc3lzY29uDQo+ID4gKw0KPiA+ICt1bmV2YWx1
YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+IA0KPiBUaGlzIGlzIHdyb25nIHdpdGhvdXQgJHJlZiwg
d2hpY2ggcG9pbnRzIHlvdSB0byBtaXNzaW5nICRyZWYgdG8gZGFpLWNvbW1vbi4NCg0KV2lsbCBh
ZGQgaXQuIFRoYW5rcy4NCg0KPiANCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0K
PiA+ICsgICAgcGRtQDEyMjUwMDAwIHsNCj4gPiArICAgICAgY29tcGF0aWJsZSA9ICJzdGFyZml2
ZSxqaDgxMDAtcGRtIjsNCj4gPiArICAgICAgcmVnID0gPDB4MTIyNTAwMDAgMHgxMDAwPjsNCj4g
PiArICAgICAgY2xvY2tzID0gPCZzeXNjcmdfbmUgMTQyPiwNCj4gPiArICAgICAgICAgICAgICAg
PCZzeXNjcmdfbmUgMTcxPjsNCj4gPiArICAgICAgY2xvY2stbmFtZXMgPSAiZG1pYyIsICJpY2ci
Ow0KPiA+ICsgICAgICByZXNldHMgPSA8JnN5c2NyZ19uZSA0ND47DQo+ID4gKyAgICAgIHN0YXJm
aXZlLHN5c2NvbiA9IDwmc3lzX3N5c2Nvbl9uZSAweEMgMHhGRj47DQo+IA0KPiBMb3dlcmNhc2Ug
aGV4IG9ubHkuDQoNCldpbGwgZml4Lg0KDQo+IA0KPiA+ICsgICAgICAjc291bmQtZGFpLWNlbGxz
ID0gPDA+Ow0KPiA+ICsgICAgfTsNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoN
ClRoYW5rcywNClhpbmd5dSBXdQ0K

