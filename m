Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10EC79A5E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjIKIVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIKIVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:21:39 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2129.outbound.protection.outlook.com [40.107.113.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946F8116;
        Mon, 11 Sep 2023 01:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKuawR2O/X/1Ss6dysYVv9EO7pp0TtdYdro/S49zBk/6AAEEuGFPl8DHW3V/1gaqX6skN3Bkj4pRCZQImwLnN60HlKA58uDVDf0DA88ihhuvqZWvm5LLS5VMabfYL1CLm0tfxkGpy7al7cIEqOMeA9xDztlee575j0ZGCcsDvy9yQYi6YbrIRgNG/F8L2l4vVupByQU2JkXvlNN+5ImPg27B6o0cAODrNb4oHhAM4UOX0jimz6AQEU/uvUf77YAWuFu0lyITJq5v96y0c0PbE8eOmAyKbhY5wl60W86eUMO8/z4ZlYJccKkREJrQrymZyIlnfP3u5L54S12558wLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09+k1ma3jiqGvM8cPFnJNbJw9AyFSit3NgtZp+uSCy8=;
 b=PfT8O151W35gMoUtHTb6kB+Em1KSCkNZ4TDVQZoPp+cGeaPWIgKKxclfxbomleoHOiMEqV54N5MxH4UXZiKKeMEuNf2KcyRDSXdAamzPXMLoatJ9rPdXbp0GuXnEdcUAuHq72z1iVQeMURbt8noTtHXloHHGL9K2Flrql/2RimOhs4d7/ndgayB/HmYss9+11Qu++WMiyiWnIcOzRtGbVIS1TAlnhpDf1Z7KCLP8ZXkp4s3Xci7ca/SMQ5F2u2P1CrNbBX1oDEaYBuqcd1a0FxQTtDDV+GNAryuEql785tIkuViY7O+QVAd74o6dvld/kCXgSjcM9+Cy/kSog+shEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09+k1ma3jiqGvM8cPFnJNbJw9AyFSit3NgtZp+uSCy8=;
 b=pBKkDvTS0cIgucxE21QiDhrr4S9L0kEvKf6FuNv2i4BmJbBkrJ6X0RHDikWY/IP8Yj2c3kogVT6pZ1UPyx9sLw1sy6C36f74fft83V3p0HZRC1zDTKaMnQrsTVdF3b86vnm866U/VaUv0hvQ+Eg53wXDbae55edNfUBoiIOsupc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8064.jpnprd01.prod.outlook.com (2603:1096:400:101::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 08:21:31 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 08:21:31 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH 2/2] media: i2c: ov7670: Drop CONFIG_OF ifdeffery
Thread-Topic: [PATCH 2/2] media: i2c: ov7670: Drop CONFIG_OF ifdeffery
Thread-Index: AQHZ4/eUnBqh4SMXg06pN1OiKbuW/bAVR9sAgAABXbA=
Date:   Mon, 11 Sep 2023 08:21:30 +0000
Message-ID: <OS0PR01MB592209D46D000F80997D9CC786F2A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230910150033.50596-1-biju.das.jz@bp.renesas.com>
 <20230910150033.50596-3-biju.das.jz@bp.renesas.com>
 <2ix6sdl6eqhin6l4crrfxyv27pxhhleuq2brbv3qaiwketdau2@a2katkkorxte>
In-Reply-To: <2ix6sdl6eqhin6l4crrfxyv27pxhhleuq2brbv3qaiwketdau2@a2katkkorxte>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8064:EE_
x-ms-office365-filtering-correlation-id: 72383720-27b3-4c5d-b578-08dbb2a01a5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ohv7i14tV6YXRmDLpadQewv8+rVMosOEDMoqOFPx0y9j1tShSWtfwg5P9xW9LipxMa9oJYR+5EhZrMsQQPf2nSxUNXE0m8Y9IGRdq4Eh5uQ0rBBzcQsZegUDkjktjGgUZ5bhTZ3/vaizau1q6LdkYa5ZG85Btrmk1S/WBT01eoTe4alBJojU6a69AiwzcYPpGs49sWiMt4Rlf+V2ugabE7cYEQ/PaTgvitpfyS0GCvttXQRSdeXisGzG8VZI53KeCtDuwrzPkM3o0rDeGJyZhISnl9j4aXQbdDuCyq99YaqLBWR4KhAS7cX26Ol3jX5DpMdmvfAlD4K4y0gGwDBP9Y5FxVmliHlD9vM5pqI1gt4HRW3sf3kW09PuYnbalw0lmlqpDwPbEUOI+JELOJ/0Zyu69wq8lCb7zpcfdmffH+hkoIDEJt/Jalnf1op+OdrGCysdnyr5FvY3TsLSNP/yL8f2U5dHQV0Eh77Vh6anUl5mexFxVXVPnxVNYWON6BOP3BZdncjFoiRYz2JxcBZ3JVke4WQSlbNJy4nMwOGxt5wqGH7p9BwTXZ8v/N+xo1kRcMjCmuT6iAYWYL2WZ77Fb0xC1XFMEHOx1sI1VgS2cfHfF062jqHsXq7ZohwYgrNN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(186009)(1800799009)(451199024)(7696005)(6506007)(71200400001)(9686003)(478600001)(83380400001)(26005)(66476007)(54906003)(64756008)(66446008)(66556008)(66946007)(6916009)(4326008)(76116006)(316002)(52536014)(41300700001)(2906002)(5660300002)(8676002)(8936002)(33656002)(86362001)(55016003)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm9CdE13NzVJWCtmLzZjN2ZNeGptdWtwWGlNUFlSNWdTdWNMUnpNVHZSRExz?=
 =?utf-8?B?MHZISzRPR3NTMTU1SGF4OUc3TzlXSWhHVmhlUDQzcjhpM1JOVWRZVURWNnM4?=
 =?utf-8?B?cFJIdWxGdEVwSWM1aHNHN3Evdzd0S0R3cFBLMXgvMmlVL0JSb1RqL21oS1lR?=
 =?utf-8?B?VXFvLzhUVFd1dUppZ29FeWpRYlZlNi9FVW1IVFkxV0hpdHBPY3k3K1lJOUVZ?=
 =?utf-8?B?L0lHODZ6cXVRVDY2L2g3bnpJa2t4MzQ3SFRaY2txdkQ5WnVvNGVxWldpNlgv?=
 =?utf-8?B?Z3czOFhQQTFucHlhY2VtVUdQRnBqcmNhYmE3Yk9uTlNkRldQdjZyWWxmcjF2?=
 =?utf-8?B?VGN0R3RUWitBWkg5SXBock1FRkU1QW95ZmJuakRKN2ovbzFEVWN2QlZtRWpn?=
 =?utf-8?B?aVc4TEhOYWU5VC9LU21PUXEvTmQzT0IwTUFGa296enJRZDViYlpiTHF5dzVs?=
 =?utf-8?B?aWw3ZEFJNmhQdkRUbTIxRjJtR0xZdFNsZFR2ZmZaRzErdXgxUkljcEJMYlZC?=
 =?utf-8?B?d1FpaklNcTFqcDUvQ1FLZUhxR2RDV0xNZFlmeGdtd2FGa2pTaTJZQ3ovUm91?=
 =?utf-8?B?UUVsNTlHeGdsWHdHTUFWWHg2M1ZHZWZETEpaOGlJMk9OUjBVZGN5R1dJcUpv?=
 =?utf-8?B?dE9vQkpXNUx6ZitUdElhZGRBcHZBenQ3VWcvVVByRUtrUGxWNktkVyswVGF2?=
 =?utf-8?B?L3VWOGs1R3VrTGFHTGVpUXJmbHIrejNqM05UdG9MVG8wKzd3UUxUcy9ZcDhZ?=
 =?utf-8?B?K0VremlHSWx1V1NYbWs4Q3lEREZ3UHJWMFNpc2JDOE5zaHo1ZDV0SzV4b3J6?=
 =?utf-8?B?MjBVbDBwaThRU21wNWZUdEFHYUxxTFA1YVREQkZSU296OHNXeFZMZnd0NG9N?=
 =?utf-8?B?TXkwVkUvTHkxZDhUYWF2YmF4eWxEQ1gxRGdtSVMxbzhRRldKbW15VGNaekVB?=
 =?utf-8?B?bnRrdkFuZXNiNFZFdGVqRUw2UmlnV3BIL3pFTG91bHdwRlRZMSs3bGZvVTBk?=
 =?utf-8?B?VlhpZklkK3pzbHBDaVNuVG1aejhua0FXanRDMmhHT1NjdVo2ZSs0bVhQWTBU?=
 =?utf-8?B?dEZUeUxwMmlyZnVQaUtUa3ppYy9ybzV5VnRkemluRU9BQWtXQ21RNnI4cjNm?=
 =?utf-8?B?bE9Qam9rdWlwUmg0QXZhcXVWMSt0dDdmazZHbG5XMkVoalpyZ1MvY1R0NDk1?=
 =?utf-8?B?VDl2Y1NHSGZqRVJzeXgzc0k4bWQ4RWxyUE15SDU2VExnVjJvMGJMNDl3SjZV?=
 =?utf-8?B?MlljeTlLamhrdm5SUm5RMGZ4WHhlOWQ0RUVOb091U0hDQ1g2NFlQMnhJMDd2?=
 =?utf-8?B?Y1R6Q1ovT2pRcW1wY1JVTHBTTnVNank1SGxzZ3c2czB1aStzd20vTjlhQ0Z5?=
 =?utf-8?B?NDBESWk0Wk9SL1Q1a2R2QS9Temt1V09qbUNRN2lvYnJTQnMwNk5EL2ZqN3F0?=
 =?utf-8?B?SXdlT2ZROFF4YXgvYVFzWWtRYitvSXJTd0ZmdG4yK2lRZGtGNWdwNlBBRzRs?=
 =?utf-8?B?ZUNHUkxkV1RoaDZXSHFyUjY4OTJucWRDWWVHMUFRcFJwUnJyL1lhQWtmRjdN?=
 =?utf-8?B?MUlpVCtoZVNERG1wNmlpVHNWa29oOEdIaDJma1F4M0w1TUxTNm9mc0FjWkla?=
 =?utf-8?B?TTVXOFUxOVZvWi81Vy9mOXJOUjJuZnZvMkxCeGhCdFBJeHNnWFVWSVBiNXVX?=
 =?utf-8?B?bFJDVS9ONnZOdHN4QVR4ZnoyenUxRzNlSFRPT1lobkEzdCtjaHM5Q1RRZ2JY?=
 =?utf-8?B?bjI4RWpWR2RqU3NsZW9Ed3VIVStpTWt3R2luMTlQdEs1Kzc2WHlxQlBVZXhp?=
 =?utf-8?B?QUZoTTFNcWozL2ZTMUtaZE1FcVVmNWg3SUFkblIvY29jaHBGMG8zcFE5KzBk?=
 =?utf-8?B?K01zalUxRGU0TjdZMVFMbzlyRTNFVlRrcWhWc3RNY1JOc2RrTk5jdGJSNXBM?=
 =?utf-8?B?eEpzMzJxTFdZazA1bEE4TEZnbXNtaW5RZWdCK05rYVNPdFNiY05aenJZRUhO?=
 =?utf-8?B?eEpYK3JzMWhrTE82eHhuYTVLS0ROZDBDMm4rZitCMUlHNmlSWERVMmNxWmVY?=
 =?utf-8?B?NWJpWTRpQ0MwUVlwdVVEeE1xZ25xQy9waTliYnVvNVY2QXBRL1dENEZoQVFp?=
 =?utf-8?B?M0N3YkFDSi9tUWpIVm13SHJ3Tm9HWjFQOGFqWnZIS1EvRXFEU3ZnNTdiM3pV?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72383720-27b3-4c5d-b578-08dbb2a01a5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 08:21:30.9514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IPLdGduCpsQNefnPqgmEFKDQztVX1tcVJTGDzZ+87xcm1BISQBktlT3SKbOvHafk43rC6pf1FW9hehmdfcmGhiqjJsZhTap6dNF4a5WDhrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFjb3BvIE1vbmRpLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDIvMl0gbWVkaWE6IGkyYzogb3Y3NjcwOiBEcm9wIENPTkZJR19PRiBpZmRl
ZmZlcnkNCj4gDQo+IEhpIEJpanUNCj4gDQo+IE9uIFN1biwgU2VwIDEwLCAyMDIzIGF0IDA0OjAw
OjMzUE0gKzAxMDAsIEJpanUgRGFzIHdyb3RlOg0KPiA+IERyb3Agb2ZfbWF0Y2hfcHRyKCkgZnJv
bSBvdjc2NzBfZHJpdmVyIGFuZCBnZXQgcmlkIG9mIHVnbHkgQ09ORklHX09GDQo+ID4gaWYgY2hl
Y2suIFRoaXMgc2xpZ2h0bHkgaW5jcmVhc2VzIHRoZSBzaXplIG9mIG92NzY3MF9kcml2ZXIgb24g
bm9uLU9GDQo+ID4gc3lzdGVtIGFuZCBzaG91bGRuJ3QgYmUgYW4gaXNzdWUuDQo+ID4NCj4gPiBB
ZGQgbW9kX2RldmljZXRhYmxlLmggaW5jbHVkZS4NCj4gPg0KPiA+IEl0IGFsc28gYWxsb3dzLCBp
biBjYXNlIGlmIG5lZWRlZCwgdG8gZW51bWVyYXRlIHRoaXMgZGV2aWNlIHZpYSBBQ1BJDQo+ID4g
d2l0aA0KPiA+IFBSUDAwMDEgbWFnaWMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWVk
aWEvaTJjL292NzY3MC5jIHwgNSArKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVk
aWEvaTJjL292NzY3MC5jIGIvZHJpdmVycy9tZWRpYS9pMmMvb3Y3NjcwLmMNCj4gPiBpbmRleCA2
NDQ0NTdlNjk5M2QuLjQxMDMyMzk0YTQ2NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlh
L2kyYy9vdjc2NzAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvaTJjL292NzY3MC5jDQo+ID4g
QEAgLTEwLDYgKzEwLDcgQEANCj4gPiAgICovDQo+ID4gICNpbmNsdWRlIDxsaW51eC9jbGsuaD4N
Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZF9k
ZXZpY2V0YWJsZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gICNpbmNs
dWRlIDxsaW51eC9zbGFiLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9pMmMuaD4NCj4gPiBAQCAt
MjAxMywxOCArMjAxNCwxNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgb3Y3
NjcwX2lkW10NCj4gPiA9IHsgIH07ICBNT0RVTEVfREVWSUNFX1RBQkxFKGkyYywgb3Y3NjcwX2lk
KTsNCj4gPg0KPiA+IC0jaWYgSVNfRU5BQkxFRChDT05GSUdfT0YpDQo+ID4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG92NzY3MF9vZl9tYXRjaFtdID0gew0KPiA+ICAJeyAuY29t
cGF0aWJsZSA9ICJvdnRpLG92NzY3MCIsICZvdjc2NzBfZGV2ZGF0YSB9LA0KPiA+ICAJeyAvKiBz
ZW50aW5lbCAqLyB9DQo+ID4gIH07DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG92NzY3
MF9vZl9tYXRjaCk7IC0jZW5kaWYNCj4gPg0KPiA+ICBzdGF0aWMgc3RydWN0IGkyY19kcml2ZXIg
b3Y3NjcwX2RyaXZlciA9IHsNCj4gPiAgCS5kcml2ZXIgPSB7DQo+ID4gIAkJLm5hbWUJPSAib3Y3
NjcwIiwNCj4gPiAtCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIob3Y3NjcwX29mX21h
dGNoKSwNCj4gPiArCQkub2ZfbWF0Y2hfdGFibGUgPSBvdjc2NzBfb2ZfbWF0Y2gsDQo+IA0KPiBX
aGlsZSBhdCBpdCwgYnV0IHBvc3NpYmlseSBzZXBhcmF0ZSBmcm9tIHRoaXMgcGF0Y2gsIGFsbCB0
aGUNCj4gDQo+ICNpZiBkZWZpbmVkKENPTkZJR19NRURJQV9DT05UUk9MTEVSKQ0KPiANCj4gZW50
cmllcyBjb3VsZCBiZSByZW1vdmVkIGFzIHdlbGwsIGFzIHNpbmNlIGNvbW1pdCA3ZDNjN2QyYTI5
MTQNCj4gKCJtZWRpYTogaTJjOiBBZGQgYSBjYW1lcmEgc2Vuc29yIHRvcCBsZXZlbCBtZW51Iikg
dGhlIE1FRElBX0NPTlRST0xMRVINCj4gc3ltYm9sIGlzIHNlbGVjdGVkIGJ5IHRoZSB0b3AtbGV2
ZWwgbWVudS4NCj4gDQo+IExldCBtZSBrbm93IGlmIHlvdSBpbnRlbmRlZCB0byBzZW5kIGEgcGF0
Y2ggb3Igc2hvdWxkIEkuDQoNClBsZWFzZSBmZWVsIGZyZWUgdG8gc2VuZCBhIHBhdGNoIHRvIGZp
eCBDT05GSUdfTUVESUFfQ09OVFJPTExFUiBpZmRlZmZlcnkuDQoNCkNoZWVycywNCkJpanUNCg0K
PiANCj4gRm9yIHRoaXMgb25lOg0KPiBSZXZpZXdlZC1ieTogSmFjb3BvIE1vbmRpIDxqYWNvcG8u
bW9uZGkrcmVuZXNhc0BpZGVhc29uYm9hcmQuY29tPg0KPiANCj4gVGhhbmtzDQo+ICAgag0KPiAN
Cj4gDQo+IA0KPiA+ICAJfSwNCj4gPiAgCS5wcm9iZQkJPSBvdjc2NzBfcHJvYmUsDQo+ID4gIAku
cmVtb3ZlCQk9IG92NzY3MF9yZW1vdmUsDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
