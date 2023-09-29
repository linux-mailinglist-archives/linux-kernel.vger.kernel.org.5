Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955717B2A35
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 03:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjI2Bz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 21:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjI2Bz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 21:55:27 -0400
Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAD211F;
        Thu, 28 Sep 2023 18:55:23 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 38T1skwZ2658438; Fri, 29 Sep 2023 10:54:47 +0900
X-Iguazu-Qid: 2rWhdxlJIobQFzP1ii
X-Iguazu-QSIG: v=2; s=0; t=1695952486; q=2rWhdxlJIobQFzP1ii; m=PBIJNEx6t7JLFZC4/mxZ54JKvk2lRevtGLHagvmqqHw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1123) id 38T1siBI2156382
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Sep 2023 10:54:45 +0900
X-SA-MID: 7899059
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLO9GLeRSK5GbgLMpP6Dt861yPQ6qlsa5cHCxEzDBEp4ybDWRwMeeo6yzIFvWHouL3454jLcUT7jkszS39uZP8aJKnTq+v2BDT+CK4AIaw6MuM0D21v/TWMGYnjGio2eK2rLlNDDCFUa+58WC9HbaOhGjW2ai8UgT6EaSpo4K/oMch0qLcSB+ks1xMsUkvxTFmpVoc1tE+HCOmkco0ig5yE71zQmf+SE4isLuDHu4pKzeUzXMSBOsb+//kbj9TroFStAf9DIwT41nwhdz34IYjNfHfsqZ1RJbtvhRLZrkn4NZtvfOTeQECX/xf7MK7qRnSpnOCnx/4I3ozP0vDszSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vxKZ1m1GHMISxfbhQpewDKB/IfuohNawero+10gtJ4=;
 b=nUwVIp0Z6VwOTJnMr5+woDZsq1s1pfYCHgiwi0IipAo9kuv9Gs+2QTBE+4Cy9UxDk7wZgVweDjDEhhftuXekkKejYc5LdSFRpsyZdAy9GclhZrBMfZMxFwpQVJrWiwnm3l1NZ6ZpkXjGZzm5gqeLtvhbNrvJGmt7aTJUHYetxwLgUyZozCVdPJc/mo1aO4ABwJIzEQU5QuHQGDjQNnmze8nKpKHmwE90RKkuH7+1ZNdrE2ey8Z3oBrd8KPJX83rSeCnbFzXmNIsxfJ8AyRBAv2oqw1gxOy9zVc6xc7Iy2eqY/aUze4+6tSZ7U2N5Af4kRNbPY/0hOAsGy3IlqPa8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <hverkuil@xs4all.nl>, <laurent.pinchart@ideasonboard.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 0/5] Add Toshiba Visconti Video Input Interface driver
Thread-Topic: [PATCH v8 0/5] Add Toshiba Visconti Video Input Interface driver
Thread-Index: AQHZ8Agh+DPtNdvmn0yGlL3T1DivB7Auq6EAgADa9aA=
Date:   Fri, 29 Sep 2023 01:49:39 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB62012717ACB6D0C534DB559292C0A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230925232806.950683-1-yuji2.ishikawa@toshiba.co.jp>
 <035d64ea-2851-4b65-b7bf-fc1c852d47ca@xs4all.nl>
In-Reply-To: <035d64ea-2851-4b65-b7bf-fc1c852d47ca@xs4all.nl>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|OSRPR01MB11457:EE_
x-ms-office365-filtering-correlation-id: f47eefb6-2724-4d7c-fd0b-08dbc08e5807
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8Y0Lv5NbvHd9UTeKvI0e/e13vcYKiy89eW+LiNHb8pm3w0KwYW4A219KKqQ6h6S86/e20v+4KkJta88+n6h4hTCLPiV1kToWIEpAHB4IOD0DfQWHJL5pGKHKUmtdDF7WL9sVAb1VMhxNi1OkM2+FL5D1xXmWtjQx/VCyu3JkSdiHZ6W4DFiLcq/53dc8MP0Dq8AfQZcoBJKEC7IofC46rV14ieyj8n4uCbT/TwsigH6SrPHM5xYrYFPElaa+vTc3D2fa9tc9rJGfzPTpLujyTx+Xa/EpTC8AMrx1GaeMEW8jis19QIL7kQtU4ziLa7OGeCaqKs7uXWl1lDnQiuJwe0hy83Wsczl5dznUZRB4v/I8vSCQWQ58o7uX6SSf9ak9A+BWi7ima7XthJvnXI2JPxmPP6iSXTylYWJr77S+8Sv+tuH3MAhWXsf1bbourtpvdF4k7zHrjtOLBfcOfr2zbYNJ1MoE55CzhS4aVuPNUWwq1PGPxpGUfZ32c/eUU3hNhPRTWGY7B8ShUgG2BcX72SHVXDBKdHN6fEEeIiLwJ5TsNQZRwtwho8+A4JMwVfFSpzYoMPMB0geFFLPzeLPM1WDgE0fT+37JKOwMu5aaxTtAcapLUT5djtaN0kiY6p8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(83380400001)(38100700002)(38070700005)(478600001)(7696005)(6506007)(26005)(86362001)(71200400001)(9686003)(53546011)(33656002)(55016003)(52536014)(41300700001)(5660300002)(8936002)(66446008)(66476007)(8676002)(4326008)(66556008)(54906003)(64756008)(122000001)(6636002)(76116006)(110136005)(66946007)(316002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0NwMXRuMVRSV2NMaXZ3cm8ydkxMQWVTUERMWUZBSzFXMjUzbElsQ2orMkFC?=
 =?utf-8?B?N1ZRd1prSzI1cjlpTFpDSUQ3RGI3R3I1WnU3Q2JLdUJyYWJrVnNqNWpiNTNR?=
 =?utf-8?B?cjNNeDVKWkFQRXh6RFVrOHNlVTVaQWtKb3g0UmdWeC9BTHdLN09UWTBoa1Rz?=
 =?utf-8?B?c0xYNTlIb2JSRlRSZnorczcyNW94QXlWL0xPYWFKaWFnRGh4UnlqTWdycm5F?=
 =?utf-8?B?eWkxQUNybGo2emtzLzZZZFloZFBIZjBVZ1FnYUJVV0l6Vkg4eEIrMndGTFFp?=
 =?utf-8?B?bWNrMGZTZmR2TFlwbGtFQSt1Tm92bHVzTGc5b2RRR05GRjNtUC9zSWxzYjJH?=
 =?utf-8?B?STBEUUNwS0p1R2h0bGFtbW5BMkpQYlV0cGF2by9IWGdMQXBVZTk3VitHUStx?=
 =?utf-8?B?M3hOS0lDa3hjVHNWRm56N2FnVkNOL09ISm5GazRSWHpqNG5YQ0Jnem9tTW5F?=
 =?utf-8?B?dHFzYXNMRkxITDkrdXlFdzBxRnJ2ZGorcnRaMXZnZVpyOFBRZEQybUc5WU9a?=
 =?utf-8?B?T24yZGFWbVBGdVp4VmtXZlVTeFp6KzhLZC9iUGh0VGJaYVlva0orVmplalg3?=
 =?utf-8?B?U05iNnhFaHhaZW9sNEpUQVZPdDVhbGpzQ25wOVk0aFNrZHVsdzF0YWZBM0tT?=
 =?utf-8?B?TWNZaHg4YUQxYnU5L05SUC9YUjhyM1R4OFBYTVFSNEJVdVlVa2ZBeHJicFZm?=
 =?utf-8?B?NTEvV0hWU2hHU1l3ZENmOVVsaklGb2g3dUk0WjZ1YS92Y0JWRFZsYmFkdjVF?=
 =?utf-8?B?ekpqVDJRakF6b1R3a3VsL3NOOTgweHpLV0FYYkk3WmVFOHJlMG9UQ0lYbitG?=
 =?utf-8?B?YzhiU0dzK3ZKRjdTZjJiY2orYzRrZXoyazVGalduTHhwN1NUZUR5Q1AyQnN5?=
 =?utf-8?B?N2RJVGFYMHZseEZGQ0lrYkZOdEZoTHR3R0p4WXMzUXJYMzRueUZFdTFHYTE3?=
 =?utf-8?B?TGpnbnBzWGNhUjk2NzZMbkgvRGN4VUVUQUcreTV1V21IMkkxWlZKSWE5WkEw?=
 =?utf-8?B?U0J2T1Q4c3Z2ZEVWY3BadTIrdWR1bmw1eDBvb2t1MTR2UWk4ZkhLRTc4eEhK?=
 =?utf-8?B?czhUYk04V2JVLzhqaS8wS09SY20ydFFGVW5Vejc3dEdCQ0VmT1BjeWFueE56?=
 =?utf-8?B?dHdhSkhHWk5saWlQK1FQeDc3dzdUU21PZ0xEVFVYcTVNVXVoMDA3ZSt1OXJj?=
 =?utf-8?B?TGdOSmowS0ZHT21JTy9VZ2Exc1JUNXk4Y3ZickdMRzkxOGhNQkNSTEg4RDZM?=
 =?utf-8?B?MjRUQTV0TXJqOXJ6cGszT29XLytSVzFtOGkxeVk3VlZhUHZVdGRodStKOCtV?=
 =?utf-8?B?WmVOOE9uY0RBZThtK1BSM01sNXJpK3BMbTJwbnF5bjBVT0d5NGdkZm85VUIw?=
 =?utf-8?B?enNnR1VTam1HZlI0ekJuenc3TUo5OGk2TFFGUklZcTUyL1BGRGIyQ1BQajZZ?=
 =?utf-8?B?QXBEeGJVM2pkMmtJODY5Rnd5aVRqY2hNTnlXUWZRY3o0MDJjMUkvQ0RDNWJD?=
 =?utf-8?B?N01teXZlNWltQlZqaTNldW01SEh5b1FxcEVPV2t4NHAvTDBRWGM0MXpJMTVq?=
 =?utf-8?B?NzYzSHg0bkZJVWtQTExWSE1La3pFa0lRQ0pZQTlFVTd3cTNrZVRjRkoyL2JQ?=
 =?utf-8?B?NXRvbldKWitYbER2SEl6VFdWcDEvUWxDMWNVWWhWSmFLVVNVQUxNTTNST241?=
 =?utf-8?B?NU5hSVZvbkFyMnZ2RklUM1pDVFM0ZU4wdW5oN0o3MHZCNEl6R25iMExHM1kz?=
 =?utf-8?B?SDVXQUZPdG5OMWhHS1pUbE4rVlZoWlVNMyszTWtxMFVzRDdoTGRFelBpU2Ft?=
 =?utf-8?B?RWl2ME84Mkhwem1pbUpQRG1XbEhOTEp4cUFld3NERzJBOTh3K3pEWVViUzR1?=
 =?utf-8?B?aHlUby9yQmRnVEJKTFBXYXgzOFVkbnovbUxjYnJoNTJaeENaV1ZNNTc3SHVQ?=
 =?utf-8?B?V1pWamowU0pCTlBpMGdsQVMzV09CSVVDVnhzbGMyaXY0ZUFKeWZzekpsOWpX?=
 =?utf-8?B?MGJWN2k1cHZWa0ZJSCtwMXFmQmhiODJ4UlY1cHdNQzJKR20ycTRVWkNFSXQ2?=
 =?utf-8?B?NjBYWmFCV0dKWWhkei9UQzRzb0NabHpxbjZIVGpIdlFCOS92elhoN2FvT1Zu?=
 =?utf-8?B?OUliem5kdHF2MkdLYVZSdE0yRXFrNWZ6TTBxcS9EUVFIWUxkbExlT3hTSFRq?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47eefb6-2724-4d7c-fd0b-08dbc08e5807
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 01:49:39.7780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xz3hcvRVG1j5XlM1uxbZY3p+ibgodG5D915dZ75812jcuZKR19CAML7RRaW8TBohBdI19l+ee/TmeWfsP7no7AG1702x9HB+u+TgUVCcI78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11457
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSGFucywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5z
IFZlcmt1aWwgPGh2ZXJrdWlsQHhzNGFsbC5ubD4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1i
ZXIgMjcsIDIwMjMgMTA6MjQgUE0NCj4gVG86IGlzaGlrYXdhIHl1amko55+z5bedIOaCoOWPuCDi
l4vvvLLvvKTvvKPilqHvvKHvvKnvvLTvvKPil4vvvKXvvKHplospDQo+IDx5dWppMi5pc2hpa2F3
YUB0b3NoaWJhLmNvLmpwPjsgTGF1cmVudCBQaW5jaGFydA0KPiA8bGF1cmVudC5waW5jaGFydEBp
ZGVhc29uYm9hcmQuY29tPjsgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiDQo+IDxtY2hlaGFiQGtlcm5l
bC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IEtv
emxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5
DQo+IDxjb25vcitkdEBrZXJuZWwub3JnPjsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0
iyDil4vvvKTvvKnvvLTvvKPilqHvvKTvvKnvvLTil4sNCj4g77yv77yz77y0KSA8bm9idWhpcm8x
Lml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IENjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5v
cmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2OCAwLzVdIEFkZCBUb3NoaWJhIFZpc2NvbnRpIFZpZGVvIElucHV0IEludGVy
ZmFjZSBkcml2ZXINCj4gDQo+IEhpIFl1amkgSXNoaWthd2EsDQo+IA0KPiBPbiAyNi8wOS8yMDIz
IDAxOjI4LCBZdWppIElzaGlrYXdhIHdyb3RlOg0KPiA+IFRoaXMgc2VyaWVzIGlzIHRoZSBWaWRl
byBJbnB1dCBJbnRlcmZhY2UgZHJpdmVyIGZvciBUb3NoaWJhJ3MgQVJNIFNvQywNCj4gPiBWaXNj
b250aS4NCj4gPiBUaGlzIHByb3ZpZGVzIERUIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiwgZGV2aWNl
IGRyaXZlciwgZG9jdW1lbnRhdGlvbg0KPiA+IGFuZCBNQUlOVEFJTkVSIGZpbGVzLg0KPiA+DQo+
ID4gQSB2aXNjb250aSBWSUlGIGRyaXZlciBpbnN0YW5jZSBleHBvc2VzDQo+ID4gMSBtZWRpYSBj
b250cm9sIGRldmljZSBmaWxlIGFuZCAzIHZpZGVvIGRldmljZSBmaWxlcyBmb3IgYSBWSUlGDQo+
ID4gaGFyZHdhcmUuDQo+ID4gRGV0YWlsZWQgSFcvU1cgYXJlIGRlc2NyaWJlZCBpbiBkb2N1bWVu
dGF0aW9uIGRpcmVjdG9yeS4NCj4gPiBUaGUgVklJRiBoYXJkd2FyZSBoYXMgQ1NJMiByZWNlaXZl
ciwNCj4gPiBpbWFnZSBzaWduYWwgcHJvY2Vzc29yIGFuZCBETUFDIGluc2lkZS4NCj4gPiBUaGUg
c3ViZGV2aWNlIGZvciBpbWFnZSBzaWduYWwgcHJvY2Vzc29yIHByb3ZpZGVzIHZlbmRvciBzcGVj
aWZpYyBWNEwyDQo+ID4gY29udHJvbHMuDQo+ID4NCj4gPiBUaGUgZGV2aWNlIGRyaXZlciBkZXBl
bmRzIG9uIHR3byBvdGhlciBkcml2ZXJzIHVuZGVyIGRldmVsb3BtZW50Ow0KPiA+IGNsb2NrIGZy
YW1ld29yayBkcml2ZXIgYW5kIElPTU1VIGRyaXZlci4NCj4gPiBDb3JyZXNwb25kaW5nIGZlYXR1
cmVzIHdpbGwgYmUgYWRkZWQgbGF0ZXIuDQo+IA0KPiBCdWlsZGluZyB0aGlzIHNlcmllcyByZXN1
bHRzIGluIGEgc2V0IG9mIHNwYXJzZSB3YXJuaW5nczoNCg0KSSBzZXQgdXAgdGhlIGxhdGVzdCBz
cGFyc2UgdG9vbCBhbmQgcmVwcm9kdWNlZCB0aGUgd2FybmluZ3MuDQoNCj4gZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS90b3NoaWJhL3Zpc2NvbnRpL3ZpaWZfY2FwdHVyZS5jOjIzNToyOTogd2Fybmlu
Zzogc3ltYm9sDQo+ICdvdXRfZm9ybWF0X3NwZWMnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBp
dCBiZSBzdGF0aWM/DQoNCkknbGwgc2V0IHN0YXRpYyBxdWFsaWZpZXIuDQoNCj4gZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS90b3NoaWJhL3Zpc2NvbnRpL3ZpaWZfY2FwdHVyZS5jOjUxNzoxMzogd2Fy
bmluZzoNCj4gY29udGV4dCBpbWJhbGFuY2UgaW4gJ3ZpaWZfcmVnYnVmX2FjY2Vzc19zdGFydCcg
LSB3cm9uZyBjb3VudCBhdCBleGl0DQo+IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vdG9zaGliYS92
aXNjb250aS92aWlmX2NhcHR1cmUuYzo1MjM6MTM6IHdhcm5pbmc6DQo+IGNvbnRleHQgaW1iYWxh
bmNlIGluICd2aWlmX3JlZ2J1Zl9hY2Nlc3NfZW5kJyAtIHVuZXhwZWN0ZWQgdW5sb2NrDQoNCkkn
bGwgZXhwYW5kIHRoZXNlIGlubGluZSBmdW5jdGlvbnMuDQpUaGUgc2FtZSBzZXF1ZW5jZXMgYXJl
IGFscmVhZHkgZXhwYW5kZWQgaW4gdmlpZl9jb250cm9scy5jDQoNCj4gZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS90b3NoaWJhL3Zpc2NvbnRpL3ZpaWZfY3NpMnJ4LmM6NDU4OjE1OiB3YXJuaW5nOiBV
c2luZw0KPiBwbGFpbiBpbnRlZ2VyIGFzIE5VTEwgcG9pbnRlcg0KPiBkcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL3Rvc2hpYmEvdmlzY29udGkvdmlpZl9jc2kycnguYzo0NTg6MTU6IHdhcm5pbmc6IFVz
aW5nDQo+IHBsYWluIGludGVnZXIgYXMgTlVMTCBwb2ludGVyDQoNCkknbGwgZml4IHRoZW0uDQoN
Cj4gQW5kIEkgYWxzbyBnZXQgYSBEb2N1bWVudGF0aW9uIGJ1aWxkIHdhcm5pbmc6DQo+IA0KPiBE
b2N1bWVudGF0aW9uL291dHB1dC92aWRlb2RldjIuaC5yc3Q6NjogV0FSTklORzogdW5kZWZpbmVk
IGxhYmVsOg0KPiAndjRsMi1jdHJsLXR5cGUtdmlzY29udGktaXNwJw0KDQpJdCBzZWVtcyB0aGUg
bGFiZWwgaXMgZ2VuZXJhdGVkIHdpdGggYSBzY3JpcHQgKGtlcm5lbGRvYy0+UmVTVCkuDQpJIGFs
c28gZm91bmQgdGhhdCB0aGUgb3RoZXIgbWVtYmVycyBvZiBlbnVtIHY0bDJfY3RybF90eXBlIGhh
dmUgbGFiZWxzIHBvaW50aW5nIGF0IGxlZ2FsIHRhcmdldHMuDQpJJ2xsIHRyeSBmdXJ0aGVyIHRv
IGdldCBhIGxlZ2FsIGxhYmVsLg0KDQo+IEFsc28gbm90ZSB0aGF0IHlvdSBuZWVkIHRvIHJlYmFz
ZTogdGhlIHY0bDItY29udHJvbHMuaCBoZWFkZXIgY2hhbmdlZC4NCg0KSXQgc2VlbXMgdGhhdCBt
ZWRpYS1zdGFnaW5nIHRyZWUgd2FzIHVwZGF0ZWQgYWZ0ZXIgSSBmaXhlZCBteSBwYXRjaHNldC4N
Ckkgc2hvdWxkIGhhdmUgcmUtY2hlY2sgYmVmb3JlIHN1Ym1pc3Npb24uDQpJJ2xsIHJlYmFzZSB0
byB0aGUgbGF0ZXN0IEhFQUQgYW5kIGZvcm1hdCB2OSBwYXRjaC4NCg0KPiBSZWdhcmRzLA0KPiAN
Cj4gCUhhbnMNCj4gDQoNClJlZ2FyZHMsDQpZdWppDQo=

