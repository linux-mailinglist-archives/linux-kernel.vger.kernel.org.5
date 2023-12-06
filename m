Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BB38071C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378805AbjLFOH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378713AbjLFOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:07:27 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47514181
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:07:33 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-7-5G7ujnPPMmWNFdy5sMVPRg-1; Wed, 06 Dec 2023 14:07:30 +0000
X-MC-Unique: 5G7ujnPPMmWNFdy5sMVPRg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 6 Dec
 2023 14:07:16 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 6 Dec 2023 14:07:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bjorn Andersson' <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [PATCH] soc: qcom: stats: Fix division issue on 32-bit platforms
Thread-Topic: [PATCH] soc: qcom: stats: Fix division issue on 32-bit platforms
Thread-Index: AQHaJ91idnM3hlhTbEOITLQ741XLZ7CcR/PQ
Date:   Wed, 6 Dec 2023 14:07:16 +0000
Message-ID: <e59bb661054945f7a77b2f67c70d30f7@AcuMS.aculab.com>
References: <20231205-qcom_stats-aeabi_uldivmod-fix-v1-1-f94ecec5e894@quicinc.com>
In-Reply-To: <20231205-qcom_stats-aeabi_uldivmod-fix-v1-1-f94ecec5e894@quicinc.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQmpvcm4gQW5kZXJzc29uDQo+IFNlbnQ6IDA2IERlY2VtYmVyIDIwMjMgMDA6NDQNCj4g
DQo+IGNvbW1pdCAnZTg0ZTYxYmRiOTdjICgic29jOiBxY29tOiBzdGF0czogQWRkIEREUiBzbGVl
cCBzdGF0cyIpJyBtYWRlIGl0DQo+IGluIHdpdGggYSBtdWx0X2ZyYWMoKSB3aGljaCBjYXVzZXMg
bGluayBlcnJvcnMgb24gQXJtIGFuZCBQb3dlclBDDQo+IGJ1aWxkczoNCj4gDQo+ICAgRVJST1I6
IG1vZHBvc3Q6ICJfX2FlYWJpX3VsZGl2bW9kIiBbZHJpdmVycy9zb2MvcWNvbS9xY29tX3N0YXRz
LmtvXSB1bmRlZmluZWQhDQo+IA0KPiBFeHBhbmQgdGhlIG11bHRfZnJhYygpIHRvIGF2b2lkIHRo
aXMgcHJvYmxlbS4NCj4gDQo+IEZpeGVzOiBlODRlNjFiZGI5N2MgKCJzb2M6IHFjb206IHN0YXRz
OiBBZGQgRERSIHNsZWVwIHN0YXRzIikNCj4gUmVwb3J0ZWQtYnk6IFJhbmR5IER1bmxhcCA8cmR1
bmxhcEBpbmZyYWRlYWQub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBCam9ybiBBbmRlcnNzb24gPHF1
aWNfYmpvcmFuZGVAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zb2MvcWNvbS9xY29t
X3N0YXRzLmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL3Fjb20vcWNvbV9zdGF0
cy5jIGIvZHJpdmVycy9zb2MvcWNvbS9xY29tX3N0YXRzLmMNCj4gaW5kZXggNDc2M2Q2MmE4Y2Iw
Li41YmE2MTIzMjMxM2UgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL3Fjb20vcWNvbV9zdGF0
cy5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL3Fjb20vcWNvbV9zdGF0cy5jDQo+IEBAIC0yMjEsNyAr
MjIxLDggQEAgc3RhdGljIGludCBxY29tX2Rkcl9zdGF0c19zaG93KHN0cnVjdCBzZXFfZmlsZSAq
cywgdm9pZCAqdW51c2VkKQ0KPiANCj4gIAlmb3IgKGkgPSAwOyBpIDwgZGRyLmVudHJ5X2NvdW50
OyBpKyspIHsNCj4gIAkJLyogQ29udmVydCB0aGUgcGVyaW9kIHRvIG1zICovDQo+IC0JCWVudHJ5
W2ldLmR1ciA9IG11bHRfZnJhYyhNU0VDX1BFUl9TRUMsIGVudHJ5W2ldLmR1ciwgQVJDSF9USU1F
Ul9GUkVRKTsNCj4gKwkJZW50cnlbaV0uZHVyICo9IE1TRUNfUEVSX1NFQzsNCj4gKwkJZW50cnlb
aV0uZHVyID0gZGl2X3U2NChlbnRyeVtpXS5kdXIsIEFSQ0hfVElNRVJfRlJFUSk7DQoNCklzIHRo
YXQgcmlnaHQ/DQpBdCBhIGd1ZXNzIG11bHRfZnJhYyhhLCBiLCBjKSBpcyBkb2luZyBhIDMyeDMy
IG11bHRpcGx5IGFuZCB0aGVuIGEgNjR4MzINCmRpdmlkZSB0byBnZW5lcmF0ZSBhIDMyYml0IHJl
c3VsdC4NClNvIEknZCBndWVzcyBlbnRyeVtpXS5kdXIgaXMgMzJiaXQ/ICh0aGlzIGNvZGUgaXNu
J3QgaW4gLXJjNCAuLi4pLg0KV2hpY2ggbWVhbnMgeW91IGFyZSBub3cgZGlzY2FyZGluZyB0aGUg
aGlnaCBiaXRzLg0KDQpZb3UndmUgYWxzbyBhZGRlZCBhIHZlcnkgc2xvdyA2NGJpdCBkaXZpZGUu
DQpBIG11bHRpcGxlIGJ5IHJlY2lwcm9jYWwgY2FsY3VsYXRpb24gd2lsbCBiZSBtdWNoIGJldHRl
ci4NClNpbmNlIGFic29sdXRlIGFjY3VyYWN5IGFsbW9zdCBjZXJ0YWlubHkgZG9lc24ndCBtYXR0
ZXIgaGVyZSBjb252ZXJ0Og0KCWR1ciAqIDEwMDAgLyBGUkVRDQp0bw0KCShkdXIgKiAodTMyKSgx
MDAwdWxsIDw8IDMyIC8gRlJFUSkpID4+IDMyDQp3aGljaCB3aWxsIGJlIGZpbmUgcHJvdmlkZWQg
RlJFUSA+PSAxMDAwDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

