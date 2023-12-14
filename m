Return-Path: <linux-kernel+bounces-217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FAB813DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2631F22952
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B010E6ABBE;
	Thu, 14 Dec 2023 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FIwjLWBL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1A66AC2;
	Thu, 14 Dec 2023 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alxHPWEg9arXJQPmPIV1mDfJc0huTp9cn+3HemxA0iNT+fsmoyIZmYgDtwi3H4vwC6f9S2uM6F7V2uR3yXGPeotaxLNHpnAt9uG9b8ylx4N9i5zXAfj5j27Uhq+dTHl7QWnccy5STnpPGiSfki58541+ctc8Dxe8/4Xh0MVxHfpknJhEdOmj9puX7P50xnKAfyxncu9UB77GqR/diP+x4s+Md86qDdpmAwqMysbt65GYZMfCnYoGwbibOcAG0twNM5TUSRGekE30VhHoTs/dGIAW8AOxTRf5seDkEGXR6EEYIS5Pcrd1BiDChexoYZEQjvToCcBNm9ncw52E+KWfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uu5sQ9wOK6hf3xgbNsVhkN86qb3LgFmzqsexeEp+ws=;
 b=copN27ivj47SCMMVsr5NzwxLsURvaApDoLJHzxzwgRTQRhtxqk9EMOR/pFrGYGpxD2cKbSczhFcI3TL28dktL8m+NPPbyS5EZO1sVd5Q88pD9RZ4xQZvua2oS2Rai4DoOxZm7d08cklUGEvY3xs1spt4/WY3y5pfGsgn1dh+CEONlSxN76Pte0YZpe1QVmmyjOBpv+Veuz/Z0qSjMVeJs+/sF28bZqhSlCynubG36G+HTsnZ8Si0mxn73e7W3k7KcJNPvinCwZPR+ipS1iwelJS4D67+daIwefmKay0Amnh4zBQjVjdWEZKfscG8xrbMhCfhk1u/x3hZH/1tT3gN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uu5sQ9wOK6hf3xgbNsVhkN86qb3LgFmzqsexeEp+ws=;
 b=FIwjLWBLpDDEes0iCAmId5ow/IA1FnFm282mrgLJ94ZLDOTmut70Wx/intI/Reg0+NEB+5DOmApjS/q+J1Xb8nvAqiPFEbfTGbZpGvgenvH9xQtrZc1tPC66zv+spDLGFrSOqSKgySeT36suqo5A4IAbUXZ2GwdUO40xsR6T36k=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 23:05:07 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::ef2d:51b6:463f:846]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::ef2d:51b6:463f:846%4]) with mapi id 15.20.7091.030; Thu, 14 Dec 2023
 23:05:07 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: Francesco Dolcini <francesco@dolcini.it>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, Pete
 Hsieh <tsung-hsien.hsieh@nxp.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
Thread-Topic: [EXT] Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
Thread-Index:
 AQHaKjAcb/i+pQpnHEy+2M8UmgtSVbCoEGkAgAADiBCAAFflgIAAQzrAgAB574CAAEXpgA==
Date: Thu, 14 Dec 2023 23:05:07 +0000
Message-ID:
 <PA4PR04MB96387683672C8C39CD982711D18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231208234127.2251-1-yu-hao.lin@nxp.com>
 <ZXpjjmD5Se7axJju@google.com>
 <PA4PR04MB96383A106724AC1CE683112BD18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZXqwP7NscRtE1uGL@francesco-nb.int.toradex.com>
 <PA4PR04MB96380AA7B60AFD73491FF53BD18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXOHQUnruWqsN0yTbKzVD8+7hcafLFhhv6jq7cdUzTY5ZA@mail.gmail.com>
In-Reply-To:
 <CA+ASDXOHQUnruWqsN0yTbKzVD8+7hcafLFhhv6jq7cdUzTY5ZA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB8638:EE_
x-ms-office365-filtering-correlation-id: 47a5e750-b5c6-48c7-ae20-08dbfcf91d94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bg9qYsZawDs4siXT21zOYiru4pFGUfKnGVkfezlZWddiosxyxXFnf2A2GrUYUypXc/b0+8Xs+3qr4pqVoDWdTKe2baj0R7mt8lBQFSBJdqt+Z83q8malEPNhveOPErrr5g/9vOHdWG/gswo7NhAW9FJjRmM1gZtSyylm+HN3/kM4bDco5zrjuLsR4tLbMkgsIqVb1zzOwtWBLdWtj7MGkhzID9v5c4Stdx+TvkdhX4FYHaE+P22xF9nNsNbHeKPpgSGkRwMB+Q9OnNTUvNVohk2XlwBMo80whhFettKpvFvuby6ckfMdxwJiIYMPlPoW6Ht3MIzSgPm0MpiIOVUITEUM3iWdPKSjG0zvljR6WtnfWdAQScaMRaehU9dnoZPJUSqieDM+cvUkMWa7Q0JRJ5koEHsUrjtzucpoKWiV62URyMLB3x4E4XsPDaVwuOW+MzaYi+4fsCJHtzKk3E0zGP87EIa128ZZyMKgyq5IFCUiHzZBIndeJxB3FuZ96PWpFa3l+u91Lpe5G05s7/DRHcbUIM6TergShAyvwvQp13ZbPKTbcIYRhbVBCV7Ue17p1zU3Cb4kliJa5v3Agg+LQKQFZkeAucQdFjjUfkHmm2GVDbyTmxTOVGaghJaF7xbz762iMCKrfe5vfHS7DzZPKUGSyx9jkxt/hWTOiTn1tvU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(316002)(4326008)(8676002)(8936002)(9686003)(53546011)(6506007)(7696005)(66446008)(76116006)(6916009)(66946007)(64756008)(52536014)(478600001)(66556008)(86362001)(5660300002)(55016003)(66476007)(54906003)(71200400001)(41300700001)(33656002)(2906002)(38100700002)(26005)(122000001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0YxR054WDJ0TDBvbTRQa2lzY05UZlgyNDZDV0V6MkY5aHpCRXlzaTRXS29V?=
 =?utf-8?B?WmhLUktFNWgxT0VVd1NkbVhhcTl4N2ZlR0c0TzBIRFUvMXpRUm8rYlVBaWNS?=
 =?utf-8?B?MFJmN2hJMWlIRDE3M3pOMTAvNzhKSWpkTnE0Qi8rZysvcFNOYkZhMUFHS0pZ?=
 =?utf-8?B?b2xPbUFyaVErZXJDcHh6U1BlbDV6YkkwQXhyRkJtR2JrcDVqS2Z0RDdoWElM?=
 =?utf-8?B?dDV6MjRGbEV0Y3JyT21HWjNzTTBuL2UxdnpFVUdab01DV2U1UHhlZTdoT0dz?=
 =?utf-8?B?SlF0VnZzdjJjZXRwbGtpVGNhN2M5NzlxQlk1OE9XOWxuMGlZTExOZzVrKy9a?=
 =?utf-8?B?YzBySW96ZEVvZXg2TlpzR1J5c3BVVE5tbm9teXEwUzR5VGU1ZDhwNXRvQlZJ?=
 =?utf-8?B?am9KVm56T3ZHNWNySWNNVkI5SDNZUG5oS3BPU01pTWo1V2xJUWRGUW9WWmNT?=
 =?utf-8?B?Sm1QMjRuQVJrZGRHVWJGcXRVQTdwWXd1cWp1NGZmS2dvM0w4WW5aMUJ2WUJC?=
 =?utf-8?B?YU96TmcyM0x2NWRqS2JiVWV5ekpPdStLYWxEM0t0QlFsWnJnRnBWekx1blVS?=
 =?utf-8?B?V2dlQ01COTE2TWdBbS94YmRaQit0VWVTKzAzdW9hV25pN0NYNDJuMUJ4V3Ji?=
 =?utf-8?B?c3NGS3hoRllMR0lvQmhjczhNYmRZeFVoTDF0dGlEdytBN2QxMEFaRDU2Nk9v?=
 =?utf-8?B?cjMvTmJVUHFLaHpDdWUvb3VEMXY3UFkzUmk1by93azRqWDg4NWtxbSswVlo3?=
 =?utf-8?B?UFMxZzlnaG9wUHg3YWt3V2tpOVlnUkV2N2pxVVZTT1o1VUNLbjZyYS8yTnlO?=
 =?utf-8?B?YVhkbVFXWVQvUUFpV2t6ZWtSaWVYbzRJdGUrR0V4d2ZvWDBFaHdlSjlMSTNZ?=
 =?utf-8?B?ZE5UTCtjMituaVhzeHFKZ2oweERLMGM3eFBEV1YyRVlsdUpnREwvMWN5VWFw?=
 =?utf-8?B?ZUNkQW5VTWYxSTJoM2QwZ21sYUh0dzl4L3FwZzhNQmlXcGhUSjU0bm1Nc2Yy?=
 =?utf-8?B?eXY1amY3cXdaN2tGeXdVMCt1MXZlQnRrbDFodHQ2M3JYaUJCMHBud0p1NzJa?=
 =?utf-8?B?b2JiaFRIYk5DeWROaEkxV3RwMmFmYk1YODhUbGR4V05hZlB5eXJ3UXJUY3hj?=
 =?utf-8?B?ZVQ5bWtscTNwY3hqVXREdWVjaFJzR0FWbkZsY1NsV0dkNzlSNUFJSnc1a2dE?=
 =?utf-8?B?bHpVRDJrbUgrVzlZanBJelluZ1ZjTnZLM0ZuT2tIcGZOMFpSeEptZXBrcTBF?=
 =?utf-8?B?Q00rRWZ0WFM1MTZCRlhEcm9UMlczUXJFU0JmbXF0b05oaFFwNHlKK2FQKzdn?=
 =?utf-8?B?MEVaWndpVHhqcWdlTHAzVnkxMGdweUZOS01RanpyUmdJUk41dWsyYW9nU0tT?=
 =?utf-8?B?c3pJY0xNRlk4cHg0QTVkNUlEVEVOeGR2MjNXWlpveEk4TWp4TmtENW5ZNzNP?=
 =?utf-8?B?SUV5Qm9ZQkh5cFNPZ2xCMzh5RU81a2grTGlaVTZ3Qm5ZdG1DTDlweGJ0VXJ0?=
 =?utf-8?B?YXVaTFU3OEVKR0dSSjJrRlJOeVNEaUlzSE9nRTFuWkEvR1ZlTjJsbmoveTVF?=
 =?utf-8?B?MWJ2Wmh3b0lsemZ0UkhESzVBalR3WXRYaEdVWVNGRjhRbWNkRUxGaWlJSllI?=
 =?utf-8?B?NjlBamU1THFmOEVHK3JIMTFaV3NFc3BtYzVVY1BmV2hwenhic0tJSU5DMG5V?=
 =?utf-8?B?djdkVDB6YXBoaDAwRkNpVndFRXVuZGFlR2RWby8zWmZPWlU4RjROR0VNSkJy?=
 =?utf-8?B?ck1PKzlObTNTNUY3RmR4Zk9Bd2ZhRW8yTXY4TVJWUDJCZkhmZEs2V3pzT1Nz?=
 =?utf-8?B?ZUZEZ1IrcHc2TGl5V3l5NXJRQmFiVTdZSHlHNHAydFpQbTVUaUE3dHF0R3c0?=
 =?utf-8?B?cHNFSWx5TDB3eElMVWV2bGUxampUakxmWmFkVEZMWXNiNDZZOEpNNE5Fc1Nv?=
 =?utf-8?B?a2NTSUlQN0xoQ3o4ZVNacjlFSkpsZ28wYmRFaDFiNlhYaldDMUN5L2E0cGVR?=
 =?utf-8?B?Nm9MVW5TcEdMdmN6aDNrcWNhSUY5UHlSK0hzcFNaZjVrcDVTUnZFOHNvejVH?=
 =?utf-8?B?UGVUUG9XRWtzakt5T3BsdjNXN2JMSlNuSFFKbUorWWNMRzV1MTh6SjdnWXhW?=
 =?utf-8?Q?gWykWHsHt+QNPW5uTWz/nUPK4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a5e750-b5c6-48c7-ae20-08dbfcf91d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 23:05:07.5908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLkk4V/bhklNGVqhHVU/GoiUouP8Awd7ivGHOdztNSRxFawt92Q92RjAv8LaDbrtZ/KePverpaJAccHQx3GbZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638

PiBGcm9tOiBCcmlhbiBOb3JyaXMgPGJyaWFubm9ycmlzQGNocm9taXVtLm9yZz4NCj4gU2VudDog
RnJpZGF5LCBEZWNlbWJlciAxNSwgMjAyMyAyOjUyIEFNDQo+IFRvOiBEYXZpZCBMaW4gPHl1LWhh
by5saW5AbnhwLmNvbT4NCj4gQ2M6IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY29AZG9sY2lu
aS5pdD47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsga3ZhbG9Aa2VybmVsLm9yZzsgUGV0ZSBIc2llaA0KPiA8dHN1bmctaHNp
ZW4uaHNpZWhAbnhwLmNvbT47IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtFWFRdIFJlOiBbUEFUQ0ggdjJdIHdpZmk6IG13aWZpZXg6IGZpeCBTVEEgY2Fubm90IGNvbm5l
Y3QgdG8gQVANCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFz
ZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRz
LiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4g
dGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gVGh1LCBEZWMgMTQsIDIwMjMgYXQgMzoz
OOKAr0FNIERhdmlkIExpbiA8eXUtaGFvLmxpbkBueHAuY29tPiB3cm90ZToNCj4gPiA+IEZyb206
IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY29AZG9sY2luaS5pdD4NCj4gPiA+DQo+ID4gPiBP
biBUaHUsIERlYyAxNCwgMjAyMyBhdCAwMjoyMjo1N0FNICswMDAwLCBEYXZpZCBMaW4gd3JvdGU6
DQo+ID4gPiA+ID4gRnJvbTogQnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+
IEl0IHByb2JhYmx5DQo+ID4gPiA+ID4gd291bGRuJ3QgaHVydCB0byBzaWduaWZpY2FudGx5IHdy
aXRlIG11Y2ggb2YgdGhpcyBkcml2ZXIsIGJ1dCBhdA0KPiA+ID4gPiA+IGEgbWluaW11bSwgd2Ug
Y291bGQgcHJvYmFibHkgdXNlIGEgZmV3IGNoZWNrcyBsaWtlIHRoaXM6DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiAgICAgICAgIGNtZF9zaXplICs9IHNpemVvZihzdHJ1Y3QgaG9zdF9jbWRfdGx2X21h
Y19hZGRyKTsNCj4gPiA+ID4gPiAgICAgICAgIGlmIChjbWRfc2l6ZSA+IE1XSUZJRVhfU0laRV9P
Rl9DTURfQlVGRkVSKQ0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ID4g
PiA+ID4gICAgICAgICAvLyBPbmx5IHRvdWNoIHRsdiAqYWZ0ZXIqIHRoZSBib3VuZHMgY2hlY2su
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGF0IGRvZXNuJ3QgbmVlZCB0byBibG9jayB0aGlzIHBh
dGNoLCBvZiBjb3Vyc2UuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBCcmlhbg0KPiA+ID4gPiA+DQo+
ID4gPiA+DQo+ID4gPiA+IEkgd2lsbCBtb2RpZnkgdGhlIGNvZGUgZm9yIG5leHQgcGF0Y2guDQo+
ID4gPg0KPiA+ID4gSSB3b3VsZCBzdWdnZXN0IG5vdCBtb2RpZnkgdGhpcyBpbiB0aGlzIHBhdGNo
LCB3ZSBzaG91bGQgZml4IGFsbCB0aGUNCj4gPiA+IGNvZGUgdGhhdCBpcyBzdWJqZWN0ZWQgdG8g
dGhpcyBwb3RlbnRpYWwgaXNzdWUuDQo+ID4gPg0KPiA+ID4gSSB3b3VsZCBwZXJzb25hbGx5IGRv
IGEgZm9sbG93LXVwIHBhdGNoIGp1c3QgdG8gYWRkIHRoZSBjaGVjayB0bw0KPiA+ID4gYXZvaWQg
b3ZlcmZsb3dpbmcgdGhlIGNtZCBidWZmZXIgZXZlcnl3aGVyZSBpdCBpcyB1c2VkLg0KPiANCj4g
UmlnaHQsIHRoZXJlJ3MgdG9ucyBvZiBjb2RlIHRoYXQgY291bGQgcG90ZW50aWFsbHkgYmUgYWZm
ZWN0ZWQsIGFuZCB0aGlzIGlzDQo+IGRlZmluaXRlbHkgYSBzZXBhcmF0ZSBwYXRjaC4gKFlvdXIg
ZmVhdHVyZSBvbmx5IGFkZHMgb24gdG8gdGhlIGV4aXN0aW5nIGlzc3VlLA0KPiBzbyB0aGVzZSBh
cmUgc2VwYXJhdGUgbG9naWNhbCBjaGFuZ2VzLikNCj4gDQo+ID4gTy5LLiBJIHdpbGwgb25seSBj
aGFuZ2UgY29tbWl0IG1lc3NhZ2UuIEluIGZhY3QsIHRoaXMgVExWIGNvbW1hbmQgaXMgYWRkZWQN
Cj4gYXMgdGhlIGZpcnN0IG9uZSBjb21tYW5kLg0KPiANCj4gV2VsbCwgaXQgZG9lc24ndCByZWFs
bHkgbWF0dGVyIHRoYW4geW91ciBUTFYgaXMgImZpcnN0IiAtLSBpZiB0aGVyZSdzIGFuIG92ZXJm
bG93LA0KPiB0aGVyZSdzIGFuIG92ZXJmbG93LiBNYXliZSB0aGUgOCBieXRlcyB5b3UncmUgYWRk
aW5nIGhlcmUgYXJlIHRoZSBuZWNlc3NhcnkNCj4gdGlwcGluZyBwb2ludC4gSSBkb24ndCBrbm93
IHdpdGhvdXQgZG9pbmcgc29tZSBraW5kIG9mIGluZm9ybWFsDQo+IG1hdGhlbWF0aWNzL3Byb29m
Lg0KPiANCj4gQnJpYW4NCg0KVW5kZXJzdG9vZC4gVGhhbmtzLg0K

