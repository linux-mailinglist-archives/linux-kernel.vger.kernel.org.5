Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6CC7DEB67
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348396AbjKBDak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348352AbjKBDah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:30:37 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D098126;
        Wed,  1 Nov 2023 20:30:29 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A23UEWK02322783, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 3A23UEWK02322783
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Nov 2023 11:30:14 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 2 Nov 2023 11:30:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 2 Nov 2023 11:30:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 2 Nov 2023 11:30:13 +0800
From:   =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Andy Shevchenko" <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] gpio: realtek: Add GPIO support for RTD SoC variants
Thread-Topic: [PATCH 1/2] gpio: realtek: Add GPIO support for RTD SoC variants
Thread-Index: AQHaDG9Hk0D/m9zpMEiXHZM9KcVyR7Bkh3iAgAHUOsA=
Date:   Thu, 2 Nov 2023 03:30:13 +0000
Message-ID: <8e4c8676acaf4ba6bf3f57451b2eab40@realtek.com>
References: <20231101025802.3744-1-tychang@realtek.com>
 <20231101025802.3744-2-tychang@realtek.com>
 <e18a7ee0-a5e3-4180-9f8a-99b21d1303e6@linaro.org>
In-Reply-To: <e18a7ee0-a5e3-4180-9f8a-99b21d1303e6@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.181.166]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antivirus-attachment-filter-interceptor-info: license violation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+T24gMDEvMTEvMjAyMyAwMzo1OCwgVHp1eWkgQ2hhbmcgd3JvdGU6
DQo+PiBUaGlzIGNvbW1pdCBhZGRzIEdQSU8gc3VwcG9ydCBmb3IgUmVhbHRlayBESEMgUlREIFNv
Q3MuDQo+DQo+UGxlYXNlIGRvIG5vdCB1c2UgIlRoaXMgY29tbWl0L3BhdGNoIiwgYnV0IGltcGVy
YXRpdmUgbW9vZC4gU2VlIGxvbmdlcg0KPmV4cGxhbmF0aW9uIGhlcmU6DQo+aHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMTcuMS9zb3VyY2UvRG9jdW1lbnRhdGlvbi9wcm9jZXNz
L3N1Ym1pdHRpbmctDQo+cGF0Y2hlcy5yc3QjTDk1DQo+DQoNCkkgd2lsbCByZW1vdmUgdGhlc2Ug
d29yZHMuDQoNCj4+ICtzdGF0aWMgaW50IHJ0ZF9ncGlvX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpIHsNCj4+ICsgICAgIHN0cnVjdCBydGRfZ3BpbyAqZGF0YTsNCj4+ICsgICAg
IGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm1hdGNoOw0KPj4gKyAgICAgc3RydWN0IGRldmlj
ZV9ub2RlICpub2RlOw0KPj4gKyAgICAgaW50IHJldDsNCj4+ICsgICAgIGludCBpOw0KPj4gKw0K
Pj4gKyAgICAgbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPj4gKyAgICAgbWF0Y2ggPSBvZl9t
YXRjaF9ub2RlKHJ0ZF9ncGlvX29mX21hdGNoZXMsIHBkZXYtPmRldi5vZl9ub2RlKTsNCj4+ICsg
ICAgIGlmICghbWF0Y2ggfHwgIW1hdGNoLT5kYXRhKQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCj4+ICsNCj4+ICsgICAgIGRhdGEgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwg
c2l6ZW9mKCpkYXRhKSwgR0ZQX0tFUk5FTCk7DQo+PiArICAgICBpZiAoIWRhdGEpDQo+PiArICAg
ICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPj4gKw0KPj4gKyAgICAgZGF0YS0+YXNzZXJ0X2ly
cSA9IGlycV9vZl9wYXJzZV9hbmRfbWFwKG5vZGUsIDApOw0KPj4gKyAgICAgaWYgKCFkYXRhLT5h
c3NlcnRfaXJxKQ0KPj4gKyAgICAgICAgICAgICBnb3RvIGRlZmVycmVkOw0KPj4gKw0KPj4gKyAg
ICAgZGF0YS0+ZGVhc3NlcnRfaXJxID0gaXJxX29mX3BhcnNlX2FuZF9tYXAobm9kZSwgMSk7DQo+
PiArICAgICBpZiAoIWRhdGEtPmRlYXNzZXJ0X2lycSkNCj4+ICsgICAgICAgICAgICAgZ290byBk
ZWZlcnJlZDsNCj4NCj5TbyB0aGlzIGdvZXMgdG8gY2xlYW51cCBwYXRoLi4uDQo+DQoNClNpbmNl
IHRoZXJlIGlzIG5vIG5lZWQgdG8gZG8gZGV2bV9mcmVlLCBJIHdpbGwgZGlyZWN0bHkgcmV0dXJu
IC1FUFJPQkVfREVGRVIgaGVyZS4NCg0KPj4gKw0KPj4gKyAgICAgZGF0YS0+aW5mbyA9IG1hdGNo
LT5kYXRhOw0KPj4gKyAgICAgc3Bpbl9sb2NrX2luaXQoJmRhdGEtPmxvY2spOw0KPj4gKw0KPj4g
KyAgICAgZGF0YS0+YmFzZSA9IG9mX2lvbWFwKG5vZGUsIDApOw0KPj4gKyAgICAgaWYgKCFkYXRh
LT5iYXNlKQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4gLUVOWElPOw0KPg0KPkJ1dCB0aGlzIGRv
ZXMgbm90PyBXaGF0Pw0KPg0KPj4gKw0KPj4gKyAgICAgZGF0YS0+aXJxX2Jhc2UgPSBvZl9pb21h
cChub2RlLCAxKTsNCj4+ICsgICAgIGlmICghZGF0YS0+aXJxX2Jhc2UpDQo+PiArICAgICAgICAg
ICAgIHJldHVybiAtRU5YSU87DQo+PiArDQo+PiArICAgICBkYXRhLT5ncGlvX2NoaXAucGFyZW50
ID0gJnBkZXYtPmRldjsNCj4+ICsgICAgIGRhdGEtPmdwaW9fY2hpcC5sYWJlbCA9IGRldl9uYW1l
KCZwZGV2LT5kZXYpOw0KPj4gKyAgICAgZGF0YS0+Z3Bpb19jaGlwLm9mX2dwaW9fbl9jZWxscyA9
IDI7DQo+PiArICAgICBkYXRhLT5ncGlvX2NoaXAuYmFzZSA9IGRhdGEtPmluZm8tPmdwaW9fYmFz
ZTsNCj4+ICsgICAgIGRhdGEtPmdwaW9fY2hpcC5uZ3BpbyA9IGRhdGEtPmluZm8tPm51bV9ncGlv
czsNCj4+ICsgICAgIGRhdGEtPmdwaW9fY2hpcC5yZXF1ZXN0ID0gcnRkX2dwaW9fcmVxdWVzdDsN
Cj4+ICsgICAgIGRhdGEtPmdwaW9fY2hpcC5mcmVlID0gcnRkX2dwaW9fZnJlZTsNCj4+ICsgICAg
IGRhdGEtPmdwaW9fY2hpcC5nZXRfZGlyZWN0aW9uID0gcnRkX2dwaW9fZ2V0X2RpcmVjdGlvbjsN
Cj4+ICsgICAgIGRhdGEtPmdwaW9fY2hpcC5kaXJlY3Rpb25faW5wdXQgPSBydGRfZ3Bpb19kaXJl
Y3Rpb25faW5wdXQ7DQo+PiArICAgICBkYXRhLT5ncGlvX2NoaXAuZGlyZWN0aW9uX291dHB1dCA9
IHJ0ZF9ncGlvX2RpcmVjdGlvbl9vdXRwdXQ7DQo+PiArICAgICBkYXRhLT5ncGlvX2NoaXAuc2V0
ID0gcnRkX2dwaW9fc2V0Ow0KPj4gKyAgICAgZGF0YS0+Z3Bpb19jaGlwLmdldCA9IHJ0ZF9ncGlv
X2dldDsNCj4+ICsgICAgIGRhdGEtPmdwaW9fY2hpcC5zZXRfY29uZmlnID0gcnRkX2dwaW9fc2V0
X2NvbmZpZzsNCj4+ICsgICAgIGRhdGEtPmdwaW9fY2hpcC50b19pcnEgPSBydGRfZ3Bpb190b19p
cnE7DQo+PiArICAgICBkYXRhLT5pcnFfY2hpcCA9IHJ0ZF9ncGlvX2lycV9jaGlwOw0KPj4gKyAg
ICAgZGF0YS0+aXJxX2NoaXAubmFtZSA9IGRhdGEtPmluZm8tPm5hbWU7DQo+PiArDQo+PiArICAg
ICByZXQgPSBkZXZtX2dwaW9jaGlwX2FkZF9kYXRhKCZwZGV2LT5kZXYsICZkYXRhLT5ncGlvX2No
aXAsIGRhdGEpOw0KPj4gKyAgICAgaWYgKHJldCkgew0KPj4gKyAgICAgICAgICAgICBkZXZfZXJy
KCZwZGV2LT5kZXYsICJBZGRpbmcgR1BJTyBjaGlwIGZhaWxlZCAoJWQpXG4iLA0KPj4gKyByZXQp
Ow0KPg0KPkFuZCBoZXJlIG5vIGNsZWFudXA/IEl0J3Mgc29tZSByYW5kb20gY2hvaWNlLg0KPg0K
Pj4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICAgfQ0KPj4gKw0KPj4gKyAgICAg
ZGF0YS0+ZG9tYWluID0gaXJxX2RvbWFpbl9hZGRfbGluZWFyKG5vZGUsIGRhdGEtPmdwaW9fY2hp
cC5uZ3BpbywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZpcnFfZG9tYWluX3Np
bXBsZV9vcHMsIGRhdGEpOw0KPj4gKyAgICAgaWYgKCFkYXRhLT5kb21haW4pIHsNCj4+ICsgICAg
ICAgICAgICAgZGV2bV9rZnJlZSgmcGRldi0+ZGV2LCBkYXRhKTsNCj4NCj5OQUssIHRlc3QgeW91
ciBwYXRjaC4NCj4NCg0KSSB3aWxsIHJlbW92ZSBpdC4NCg0KPj4gKyAgICAgICAgICAgICByZXR1
cm4gLUVOT01FTTsNCj4+ICsgICAgIH0NCj4+ICsNCj4+ICsgICAgIGZvciAoaSA9IDA7IGkgPCBk
YXRhLT5ncGlvX2NoaXAubmdwaW87IGkrKykgew0KPj4gKyAgICAgICAgICAgICBpbnQgaXJxID0g
aXJxX2NyZWF0ZV9tYXBwaW5nKGRhdGEtPmRvbWFpbiwgaSk7DQo+PiArDQo+PiArICAgICAgICAg
ICAgIGlycV9zZXRfY2hpcF9kYXRhKGlycSwgZGF0YSk7DQo+PiArICAgICAgICAgICAgIGlycV9z
ZXRfY2hpcF9hbmRfaGFuZGxlcihpcnEsICZkYXRhLT5pcnFfY2hpcCwNCj5oYW5kbGVfc2ltcGxl
X2lycSk7DQo+PiArICAgICB9DQo+PiArDQo+PiArICAgICBpcnFfc2V0X2NoYWluZWRfaGFuZGxl
cl9hbmRfZGF0YShkYXRhLT5hc3NlcnRfaXJxLA0KPnJ0ZF9ncGlvX2Fzc2VydF9pcnFfaGFuZGxl
LCBkYXRhKTsNCj4+ICsgICAgIGlycV9zZXRfY2hhaW5lZF9oYW5kbGVyX2FuZF9kYXRhKGRhdGEt
PmRlYXNzZXJ0X2lycSwNCj4+ICsgcnRkX2dwaW9fZGVhc3NlcnRfaXJxX2hhbmRsZSwgZGF0YSk7
DQo+PiArDQo+PiArICAgICBkZXZfZGJnKCZwZGV2LT5kZXYsICJwcm9iZWRcbiIpOw0KPg0KPk5v
cCwgZHJvcCBhbGwgc2lsbHksIHNpbXBsZSBlbnRyeS9leGl0IG1lc3NhZ2VzLg0KPg0KDQpJIHdp
bGwgcmVtb3ZlIGl0Lg0KDQo+PiArDQo+PiArICAgICByZXR1cm4gMDsNCj4+ICsNCj4+ICtkZWZl
cnJlZDoNCj4+ICsgICAgIGRldm1fa2ZyZWUoJnBkZXYtPmRldiwgZGF0YSk7DQo+DQo+TkFLLCB0
ZXN0IHlvdXIgcGF0Y2guDQo+DQo+PiArICAgICByZXR1cm4gLUVQUk9CRV9ERUZFUjsNCg0KSSB3
aWxsIHJlbW92ZSB0aGlzIGxhYmVsLg0KDQo+PiArfQ0KPg0KPkJlc3QgcmVnYXJkcywNCj5Lcnp5
c3p0b2YNCg0KDQpUaGFua3MsDQpUenV5aSBDaGFuZw0K
