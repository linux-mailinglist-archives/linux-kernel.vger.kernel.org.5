Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BDA75A40B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjGTBfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGTBfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:35:04 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2180.outbound.protection.outlook.com [40.92.63.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A992109;
        Wed, 19 Jul 2023 18:34:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTQ7toHLwjv1Dsz33+/kFYmUAahXFXgQHj3GzLF9yqj1tilGzBFB7VyX6ZaKrVs/44axdv8QhUZI61GYFgJVVMRvucRvE5fDkg006yx8mKt2M+LzXBuOOSsaiXjuUrqXOKfVcaHXFEjB+QQYzzoMx8RShVemnbNCsDIcNuBii9Dj5wnSZE+DsuT1Q1QAuwoTSLVlnko/lmBuxdfEmlcN162nbnKpZRuWPSlOxK20M7xN7xaREuaO1+lt51vFbz2t7azD47d+F59bci0lGaUdNtmvv1OgMNI047+Dzzwcn79UbiECensOeqH8BqiXL3DTvbufuyChcnOfdnHO+6ePFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BCCMGIvSp5kTq7MMn+EQWFVBF6a1f3qUFxS5cWi4ME=;
 b=gKoZklQ9p5wOdqamZy+ZXyikJG6q4j5UC4m6zw6Ru+ThH7FTOd4Nk3ZgRc8M0ohnU54/DZD76j3PuNDuIBkp1E0y9Th/pYofkVnPPfUV1PJYwx+WvrSiwjx/R0c69X4SdIkux+2O4wuvK8+iDVa8C/AU+2epmYIgz1t9YvBDmqbIBfbkr1++ylOjYOu/ZoQrLhcXmHrzY7Krfuv3qFyvMNGzY7dx3tobgBPSJ3b827hLytTZkccb6kR/H6+U+s8/TmByeuZuWueKit+QnojdvFGGmBO8u509cpECBygPauJQw+QgxZqBE0PTHQGVcOwdWfS0uwkZ6E6Q5WYX7OllWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BCCMGIvSp5kTq7MMn+EQWFVBF6a1f3qUFxS5cWi4ME=;
 b=AeEwHqzTnWUglBhD41nHDC/CFFXRwMBsrhwzPx1xlBzdbtpoSqDSG7rybuPxyJhx7vZYnUIMn1rJkSXYpXVJQFE+2mmnheMG+pOIy09i23RNudf5cJF4GFQjk1yOqeT0tCJwnCSRabparLyBJ4IAQqm5J0bYAOO7MTV6IhFquAf98QDTtCU6Wyfr7ryPfd+tY6czKdcmBxtb7FT4r8fn+4P/t2e5dif6BnOyzH2tKJGIV11l/2y/8nhQwMobP3kP/7MSONc9qI5EOnwTDN51aokOtW6IZUl/FYX0bNcM82LF1ebZmuHz2rwh1LgHMeaBou1cUhacr+wO/yufzsVy8g==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by SY7P282MB4012.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 01:34:55 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f263:312b:1b6c:512b]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f263:312b:1b6c:512b%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 01:34:55 +0000
From:   =?utf-8?B?4oCOIGRvbm1vcg==?= <donmor3000@hotmail.com>
To:     "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "kernel@xen0n.name" <kernel@xen0n.name>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "jiaxun.yang@flygoat.com" <jiaxun.yang@flygoat.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "chenhuacai@loongson.cn" <chenhuacai@loongson.cn>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "lixuefeng@loongson.cn" <lixuefeng@loongson.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "loongson-kernel@lists.loongnix.cn" 
        <loongson-kernel@lists.loongnix.cn>
Subject: Re: [PATCH v5] LoongArch: Fix CONFIG_CMDLINE_EXTEND and
 CONFIG_CMDLINE_BOOTLOADER handling
Thread-Topic: [PATCH v5] LoongArch: Fix CONFIG_CMDLINE_EXTEND and
 CONFIG_CMDLINE_BOOTLOADER handling
Thread-Index: AQHZuY1TS+nbXmX/tkirEP9agq0NVa/Ap7YAgAAIqYCAADREgIAA/QIA
Date:   Thu, 20 Jul 2023 01:34:55 +0000
Message-ID: <281c5d5e51488ce51497072c1e4304d71af141ec.camel@hotmail.com>
References: <20230718153348.3340811-1-chenhuacai@loongson.cn>
         <261edc6c-e339-faeb-3045-bfe6604d1aef@web.de>
         <CAAhV-H5nNMmYZQXvoog85cgMUd+gM2QMaG3cUhYk_iGzjB=B4Q@mail.gmail.com>
         <f9e7fb54-a76e-a9b0-1b9c-8c9251f4af20@xen0n.name>
In-Reply-To: <f9e7fb54-a76e-a9b0-1b9c-8c9251f4af20@xen0n.name>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [RJ/WdeY2nv1zRrJiZFWwpr+klWzEbsvJIifjssMkilrGqHST8XKzEboFhPGhDAoG]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2597:EE_|SY7P282MB4012:EE_
x-ms-office365-filtering-correlation-id: 1ce16e8b-ffee-4b9c-5f1a-08db88c1856c
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N0yAwI+XasAR8BMs81JriN2ZnXHOvEyaRlIOdxA05dg3ZPXUj/3yrcmbgcdQgmnhfNxXPGWe3IaCgF9X5fPd5zMXy9xhMw/vltoWdy177NE+fDI5Ok6F2EmqtrRbkaZ4ZLQyrKMy1Yeihm1Gos3W323c4eNZ2BG15Q6hXn03gKP6+4bANSppJGUbKoR2RcxU5IGavghmi3SFmLEw/4SoBDPjmi1ssHNJAwQm4I3hnoIShHbTSdXIjRoheU0nl3UNvEhBxCZBIqgqGzbTHEZOpSsOgYAG/JVMe59+wXq1o8WdQQr6Eq6/aj1GixINU6ywf7YQjmh/vPVW40FbuY9INv/TeYCeyzb4WyvPKg1spawv6GFBjF2sXUefCaDKQ9kuJa+a29eIk4G8BzbkQK7qAd0bdR4syqzfyY7ggKJ/rdeLNlUOyVWQcZX3QHoT+h+tnYdEQ2g0a/op7DhoMYe8VeAokmzFQq/xNIyQ1uJrVIeBBfCydZJgGEHRRfPWHftnfYj+pR59ZqJIM/q7al8Z/xqHzUazSvI1428uv5O2PhkqRNJRMIc/O4e0+vD3fr3t
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE1melZ1Vk5zU3B2alIyaERkeXBGV3BXeXpnOW5NcTVOQnJZTlNpb25scmJr?=
 =?utf-8?B?VlE1TFhxZGozdzQxYnc5SzE4MEd2bi9zSkptOTlOTDlhU252Q3MycXdTKzRh?=
 =?utf-8?B?VFBuNW9BZVF0NTZyVHRYeEM4NklVWDlZaW9wVFNwRU9JUlBtRWh1ek1CWnM4?=
 =?utf-8?B?aUNyZmJ6akRqNUNrMjFRTTJYVzN2MGhTWHZXeFJFRkJBVHVNVVc1QzN5U2k3?=
 =?utf-8?B?RHpHMDUzUllRNHdFVUk4Y1JucFlQbk9VRG16cE5pbkVzSWhxVDNFRzdLKzho?=
 =?utf-8?B?N2U1Tm5wM2ZNRktaRkNjcnpkUFRtL2g1bVpEWXRmNjJmWFREekp5UU0yenFp?=
 =?utf-8?B?RnlHNEtjeWYzaGtYa0xvanJ0TW9YTS8xMUVLY1pXK01ueTAvVU1EenFlTzRi?=
 =?utf-8?B?OHdjTHJ4MWJnRlNDRmtNVjZWcWtJbHlEcmIwNmdDQ2QyT0JVWDdIZG9yTVI0?=
 =?utf-8?B?d3RrSGl3a2c4YUorYUI5ZXByb0JqaklMemxzN0Y0SlFieWhYdXlwZm1kMEdy?=
 =?utf-8?B?S1NWUXZyWFVXNE1aekZ2RUYzeGxxMUJucDNaZkFENjNNdG5iVGJiMjNsMDAx?=
 =?utf-8?B?Wi80dFVFMW55TE0xaWVsamE1bGpGT0JkQWNYQ1pJSVV0K01CaGFiWlNNd3pr?=
 =?utf-8?B?SEQrSm01d1JHall1RnVxRytxbDRIWFhGR0J0SzlGWGhzT1FrMUxoK1VZV1Fk?=
 =?utf-8?B?a0MvY3EzS1lod0ZXMS9yMFUvWjJKMXlnekJXRVhyNWkwaGNIZE9VRk1qcHli?=
 =?utf-8?B?WWlhNnNuenE2Z1JOWFkvODBPbE0rQTJKR014QVUxcm1QcFppSzhqdXh4N0Iz?=
 =?utf-8?B?WUhMNHEvMkcyK0JDdVNrTjFyQU1Kd3B4aDBPdUF5NTBaNG51KzBoQkpUcVRI?=
 =?utf-8?B?OEhRY3c5d1NwS3o4TG83cnNTNGdKVXo4ZzF3WnIrak1VaHZDRzRyclVQcksy?=
 =?utf-8?B?Tm16aGVjV04vaFlZYXZUZTVjVzU5NjlUaDBPRUNBMERHbWxRWDNXL052bThU?=
 =?utf-8?B?Ujk1RnRPL0d5cXUvVEx4Z014czhPV1FNNVRrRzlGWFNlQzU3TC9UN1RnQm5k?=
 =?utf-8?B?OGQ5YVBMY1ZzQk1QUTM2UExPYytkVFh2a29pVWhFRmxHTEhGMTE4V1N1YjJV?=
 =?utf-8?B?N3pLS0cybjM3SkduOHJWTzhtc1gvV3h5MnZ2MHZaeTk4Y0NRcC82MTE1aURr?=
 =?utf-8?B?Ty9OQVVEYjZkNHRxenhuZEtpMFI4R1VHK2xmQ0NhRktzREZKa3d0QmZsK2hF?=
 =?utf-8?B?bklzNmJoSDdRRzhFdjJwWDU0NjdQR2JIUGV3ellaYUlVQnZnN0VNMEtGSytW?=
 =?utf-8?B?cXVXVER1MUNzOFJ2LzNKTU9GTThjV0lFb3dDcmY4aHN4cndwNjNRWVhwWHBQ?=
 =?utf-8?B?V043WENwYU15MzNaSGp3Ukdua284R2xKZVRaLzlwM2FWL2lFai8vcktUc0Jn?=
 =?utf-8?B?d1ZJaFJ1MHpWS0g4bVNnbHoxS2M2NTVQMkM5T0U5QnY4QklwN0NzaXl4eFJF?=
 =?utf-8?B?blFTQlQrVlJKMkQyazMrczZrRUMwZzZlVjltWkcrejA5UHlYT0tBaC9iNUZK?=
 =?utf-8?B?WDlqNktLbDZsblgzdjZJeGl5L1REcnA4enU5RmMzVi9IQy9tR1krY09xdzVI?=
 =?utf-8?B?MXFXdzZzaTAyUDFCZXlBdFhrZHRUdlh0WFVDTnRLY0Vaam8wc1ZvNGhHaWFY?=
 =?utf-8?B?bXVMeTZ1TmlpWlZyNE4ydHRtcGNDOU10QlRQcG1yZ1VvMzNxRmNTK1hvUGRQ?=
 =?utf-8?Q?i4OOk4nOx8hZMKCx78=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26A1AA44CA688840B7906A82E4ECA709@AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce16e8b-ffee-4b9c-5f1a-08db88c1856c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 01:34:55.1161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4012
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjMtMDctMTnmmJ/mnJ/kuInnmoQgMTg6MjkgKzA4MDDvvIxXQU5HIFh1ZXJ1aeWGmemB
k++8mg0KPiBPbiAyMDIzLzcvMTkgMTU6MjIsIEh1YWNhaSBDaGVuIHdyb3RlOg0KPiA+IEhpLCBN
YXJrdXMsDQo+ID4gDQo+ID4gT24gV2VkLCBKdWwgMTksIDIwMjMgYXQgMjo1MeKAr1BNIE1hcmt1
cyBFbGZyaW5nIDxNYXJrdXMuRWxmcmluZ0B3ZWIuZGU+IHdyb3RlOg0KPiA+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDigKYsIHNvIHRoaXMg
cGF0Y2ggYWRkDQo+ID4gPiA+IHNvbWUgY29kZSB0byBmaXggaXQuDQo+ID4gPiANCj4gPiA+IFdv
dWxkIHlvdSBsaWtlIHRvIGF2b2lkIGEgdHlwbyBoZXJlPw0KPiA+ID4gDQo+ID4gPiBXaWxsIGFu
eSBvdGhlciBpbXBlcmF0aXZlIGNoYW5nZSBkZXNjcmlwdGlvbiB2YXJpYW50IGJlY29tZSBtb3Jl
IGhlbHBmdWw/DQo+ID4gVGhhbmsgeW91IGZvciBwb2ludGluZyB0aGlzIG91dCwgYnV0IHNpbmNl
IFpoaWhvbmcgaXMgdGhlIG9yaWdpbmFsDQo+ID4gYXV0aG9yLCBJIGRvbid0IHdhbnQgdG8gY29t
cGxldGVseSByZXdyaXRlIHRoZSBjb21taXQgbWVzc2FnZSwgc28ganVzdA0KPiA+IGZpeCB0aGUg
dHlwby4uLg0KPiANCj4gQUZBSUNUIHRoZSBjb21taXQgbWVzc2FnZSBpcyB0b3RhbGx5IHVuaW5m
b3JtYXRpdmUgZXZlbiBpZiAiYW4gDQo+IGltcGVyYXRpdmUgY2hhbmdlIGRlc2NyaXB0aW9uIiB3
ZXJlIHVzZWQuIEl0IGJhc2ljYWxseToNCj4gDQo+IDEuIHJlcGVhdGVkIHRoZSBwYXRjaCB0aXRs
ZSwNCj4gMi4gc3BlbnQgb25lIHNlbnRlbmNlIG9ubHkgZm9yIG1lbnRpb25pbmcgYSBmdW5jdGlv
biBuYW1lIHdpdGhvdXQgZ2l2aW5nIA0KPiBhbnkgbW9yZSBpbmZvcm1hdGlvbiwNCj4gMy4gbWVu
dGlvbmVkIHdoeSBzb21lIGNoYW5nZSB3YXMgbm90IG5lY2Vzc2FyeSBkdWUgdG8gc29tZSBvdGhl
ciANCj4gZXhpc3RpbmcgY29kZSwgYnV0IG5vdCBleHBsaWNpdGx5IGNhbGxpbmcgdGhhdCBwYXJ0
IG91dCwgdGhlbg0KPiA0LiBmaW5pc2hlZCB3aXRoIGEgc2VudGVuY2UgdGhhdCBib2lsZWQgZG93
biB0byAid2Ugc2hvdWxkIGRvIHRoZSANCj4gc2ltaWxhciB0aGluZyIuDQo+IA0KPiBNeSB0YWtl
Og0KPiANCj4gID4gU3ViamVjdDogRml4IENNRExJTkVfRVhURU5EIGFuZCBDTURMSU5FX0JPT1RM
T0FERVIgb24gbm9uLUZEVCBzeXN0ZW1zDQo+ICA+DQo+ICA+IE9uIEZEVCBzeXN0ZW1zIHRoZXNl
IGNvbW1hbmQgbGluZSBwcm9jZXNzaW5nIGFyZSBhbHJlYWR5IHRha2VuIGNhcmUgb2YNCj4gID4g
YnkgZWFybHlfaW5pdF9kdF9zY2FuX2Nob3NlbigpLiBBZGQgc2ltaWxhciBoYW5kbGluZyB0byB0
aGUgbm9uLUZEVA0KPiAgPiBjb2RlIHBhdGggdG8gYWxsb3cgdGhlc2UgY29uZmlnIG9wdGlvbnMg
dG8gd29yayBmb3Igbm9uLUZEVCBib3hlcyB0b28uDQo+IA0KPiBXb3VsZCB0aGlzIHNvdW5kIGJl
dHRlcj8NCj4gDQpYdWVydWkncyB0YWtlIGlzIGZpbmUuIERvIEkgbmVlZCB0byBtYWtlIGEgdjYg
cGF0Y2g/DQoNCmRvbm1vcg0K
