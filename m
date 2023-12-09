Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BA780B347
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbjLIIbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 03:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLIIbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 03:31:21 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2977B1AD
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 00:31:27 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B98UPHe035396;
        Sat, 9 Dec 2023 02:30:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702110625;
        bh=AK/m0l/XwbcANi9JnHnK/JJmhGqgtHRgsOwqS6W/z4g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=dghd+PLvWnOCEGZXymEwaDkVUNNyhl5qJDHUL18AjVR9hLrOxxmKF9DZkG3wZ4Qhs
         iwh6O0uI5mJ0Y7RxjU5apxJHglBBThoggPDq23klABA21Kxz0d1HS/tL92Nfe43v6G
         Rk1GcLbvGNlA4QEDfiMypzEtn9t7YragTWg3oPT4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B98UP6e090543
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 9 Dec 2023 02:30:25 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 9
 Dec 2023 02:30:25 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Sat, 9 Dec 2023 02:30:24 -0600
From:   "Ding, Shenghao" <shenghao-ding@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "soyer@irl.hu" <soyer@irl.hu>, "tiwai@suse.de" <tiwai@suse.de>
Subject: RE: [EXTERNAL] Re: [PATCH v1 3/3] ASoC: dt-bindings: Add tas2563 into
 yaml
Thread-Topic: [EXTERNAL] Re: [PATCH v1 3/3] ASoC: dt-bindings: Add tas2563
 into yaml
Thread-Index: AQHaKnbUUMfgQZAzjkyE8w/j8//IPLCg/ryA//+f6dA=
Date:   Sat, 9 Dec 2023 08:30:24 +0000
Message-ID: <5cbb8824b4d443e898b23c3d08b8a4ea@ti.com>
References: <20231209080742.1290-1-shenghao-ding@ti.com>
 <20231209080742.1290-3-shenghao-ding@ti.com>
 <9dc6ff91-d28c-4e94-9ec7-f39aa1555bda@linaro.org>
In-Reply-To: <9dc6ff91-d28c-4e94-9ec7-f39aa1555bda@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.163.83]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBTYXR1cmRheSwg
RGVjZW1iZXIgOSwgMjAyMyA0OjEzIFBNDQo+IFRvOiBEaW5nLCBTaGVuZ2hhbyA8c2hlbmdoYW8t
ZGluZ0B0aS5jb20+OyBicm9vbmllQGtlcm5lbC5vcmcNCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9y
ZzsgYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOw0KPiBsZ2lyZHdvb2RAZ21haWwu
Y29tOyBwZXJleEBwZXJleC5jejsgcGllcnJlLWxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29t
Ow0KPiAxMzkxNjI3NTIwNkAxMzkuY29tOyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IGxp
bnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaWFtLnIuZ2lyZHdvb2RAaW50ZWwuY29t
OyBzb3llckBpcmwuaHU7DQo+IHRpd2FpQHN1c2UuZGUNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBS
ZTogW1BBVENIIHYxIDMvM10gQVNvQzogZHQtYmluZGluZ3M6IEFkZCB0YXMyNTYzIGludG8NCj4g
eWFtbA0KPiANCj4gT24gMDkvMTIvMjAyMyAwOTowNywgU2hlbmdoYW8gRGluZyB3cm90ZToNCj4g
PiBTdXBwb3J0IHRhczI1NjMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVuZ2hhbyBEaW5n
IDxzaGVuZ2hhby1kaW5nQHRpLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvdGksdGFzMjc4MS55YW1sICAgfCAxNyArKysrKysrKysrLS0tLS0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQv
dGksdGFzMjc4MS55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c291bmQvdGksdGFzMjc4MS55YW1sDQo+ID4gaW5kZXggYTY5ZTZjMjIzMzA4Li44NGUxOTdlMTVk
ZjQgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nv
dW5kL3RpLHRhczI3ODEueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb3VuZC90aSx0YXMyNzgxLnlhbWwNCj4gPiBAQCAtMTEsMTEgKzExLDExIEBAIG1h
aW50YWluZXJzOg0KPiA+ICAgIC0gU2hlbmdoYW8gRGluZyA8c2hlbmdoYW8tZGluZ0B0aS5jb20+
DQo+ID4NCj4gPiAgZGVzY3JpcHRpb246DQo+ID4gLSAgVGhlIFRBUzI3ODEgaXMgYSBtb25vLCBk
aWdpdGFsIGlucHV0IENsYXNzLUQgYXVkaW8gYW1wbGlmaWVyDQo+ID4gLSAgb3B0aW1pemVkIGZv
ciBlZmZpY2llbnRseSBkcml2aW5nIGhpZ2ggcGVhayBwb3dlciBpbnRvIHNtYWxsDQo+ID4gLSAg
bG91ZHNwZWFrZXJzLiBBbiBpbnRlZ3JhdGVkIG9uLWNoaXAgRFNQIHN1cHBvcnRzIFRleGFzIElu
c3RydW1lbnRzDQo+ID4gLSAgU21hcnQgQW1wIHNwZWFrZXIgcHJvdGVjdGlvbiBhbGdvcml0aG0u
IFRoZSBpbnRlZ3JhdGVkIHNwZWFrZXINCj4gPiAtICB2b2x0YWdlIGFuZCBjdXJyZW50IHNlbnNl
IHByb3ZpZGVzIGZvciByZWFsIHRpbWUNCj4gPiArICBUaGUgVEFTMjc4MS9UQVMyNTYzIGlzIGEg
bW9ubywgZGlnaXRhbCBpbnB1dCBDbGFzcy1EIGF1ZGlvDQo+ID4gKyBhbXBsaWZpZXIgb3B0aW1p
emVkIGZvciBlZmZpY2llbnRseSBkcml2aW5nIGhpZ2ggcGVhayBwb3dlciBpbnRvDQo+ID4gKyBz
bWFsbCBsb3Vkc3BlYWtlcnMuIEFuIGludGVncmF0ZWQgb24tY2hpcCBEU1Agc3VwcG9ydHMgVGV4
YXMNCj4gPiArIEluc3RydW1lbnRzIFNtYXJ0IEFtcCBzcGVha2VyIHByb3RlY3Rpb24gYWxnb3Jp
dGhtLiBUaGUgIGludGVncmF0ZWQNCj4gPiArIHNwZWFrZXIgdm9sdGFnZSBhbmQgY3VycmVudCBz
ZW5zZSBwcm92aWRlcyBmb3IgcmVhbCB0aW1lDQo+ID4gICAgbW9uaXRvcmluZyBvZiBsb3Vkc3Bl
YWtlciBiZWhhdmlvci4NCj4gPg0KPiA+ICBhbGxPZjoNCj4gPiBAQCAtMjUsMTYgKzI1LDE5IEBA
IHByb3BlcnRpZXM6DQo+ID4gICAgY29tcGF0aWJsZToNCj4gPiAgICAgIGVudW06DQo+ID4gICAg
ICAgIC0gdGksdGFzMjc4MQ0KPiA+ICsgICAgICAtIHRpLHRhczI1NjMNCj4gDQo+IExvb2tzIGxp
a2UgZGV2aWNlcyBhcmUgY29tcGF0aWJsZSwgc28gZXhwcmVzcyBpdCBpbiB0aGUgYmluZGluZ3Mg
d2l0aCBhIGZhbGxiYWNrDQo+IGFuZCBkcm9wIGRyaXZlciBwYXRjaGVzLg0KRXhhY3RseS4gRG8g
eW91IG1lYW4gY29tYmluZSB0aGUgdGhyZWUgcGF0Y2hlcyBpbnRvIG9uZSBwYXRjaD8NCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
