Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0027A5F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjISKVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjISKVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:21:38 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4673AF9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1695118888; x=1697710888;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gmhGDThIUommb+ftKTpel+Q35NvofcFtKWO4tgXHq+Q=;
        b=hQ/eGrWcWCpD931stGVaddLW4CW52ZsZdL8XfEIGNnbxqm8Lv3jYR8ztlVnqPW9T
        ytJ8PvaFcowcn3PADmT4+/ti1YjdsyVzuwzPJwiFRflQYJuOzSODqD1hGCRUOwsi
        WOwsNPpH7ol3hl0duJuCf+vCVK7cnIH4S1OK06r2QIM=;
X-AuditID: ac14000a-6d65670000001e37-37-650976282e18
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 09.B9.07735.82679056; Tue, 19 Sep 2023 12:21:28 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 19 Sep
 2023 12:21:28 +0200
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Tue, 19 Sep 2023 12:21:28 +0200
From:   Wadim Egorov <W.Egorov@phytec.de>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "mugunthanvnm@ti.com" <mugunthanvnm@ti.com>,
        "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
        "nm@ti.com" <nm@ti.com>
Subject: Re: [PATCH] iio: adc: ti_am335x_adc: Make DMAs optional
Thread-Topic: [PATCH] iio: adc: ti_am335x_adc: Make DMAs optional
Thread-Index: AQHZ5wTVP3tOGrcOcEWxWAi45YA9XLAeuLAAgAMd14A=
Date:   Tue, 19 Sep 2023 10:21:28 +0000
Message-ID: <f2b18c8b-97f9-49c5-a4a1-a3d5c1ae13eb@phytec.de>
References: <20230914121300.845493-1-w.egorov@phytec.de>
 <20230917114552.3f5cd081@jic23-huawei>
In-Reply-To: <20230917114552.3f5cd081@jic23-huawei>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C60DC7DB7F506E448CDA2B66EBA4C60F@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWyRpKBR1ejjDPVYO0CBYv/j16zWjxoWsVk
        sWTyfFaLeUfesVhc3jWHzeLqg3KLNz/OMlnM+viD1eL/nh3sFt3v1B24PDat6mTz6O9uYfVY
        8uYQq8f2a/OYPY7f2M7k8XmTXABbFJdNSmpOZllqkb5dAlfG2fc/2Ap+yVdc2DCHqYFxgnwX
        IyeHhICJxMlni5lBbCGBJUwSh7pCIOwHjBK7l2d3MXIB2RsZJV7sfcsGkmATUJeY+PcEK4gt
        AmRPm3GFCaSIWWAxs8TLpW9ZQBLCAg4S1xZ9BbI5gIocJVq7FCHqrSQa76xjBQmzCKhKHF9u
        AGLyCthIrHzrC7E2UaLryiJGEJtTwFji3crnYAMZBWQlNmw4D3Yms4C4xKZn31khzheQWLIH
        Ii4hICrx8vE/qLi8xIlb05hAxjMLaEqs36UP0WohceXbISYIW1FiSvdDdhCbV0BQ4uTMJywT
        GMVnIdkwC6F7FpLuWUi6ZyHpXsDIuopRKDczOTu1KDNbryCjsiQ1WS8ldRMjKKZFGLh2MPbN
        8TjEyMTBeIhRgoNZSYR3piFbqhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe+z1MiUIC6Yklqdmp
        qQWpRTBZJg5OqQbGVdt/9XIo9H1euDu8QKS7QCegPHqGTziPot7ixqRFC9+5NzHcZL6g1vz7
        RknWhEmTJn1fMUEx8c+0Gcl68nwNGi+K2zkW1iSe4Fx6Z5fROm2TC70lk8Q2MNZUn2Z+F7P2
        cZ78gnn7X0c8695Vpz9D953K/yfH9qTa7FtZl2DvOmvfe50A7RBWJZbijERDLeai4kQAHWsg
        pNcCAAA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCkFtIDE3LjA5LjIzIHVtIDEyOjQ1IHNjaHJpZWIgSm9uYXRoYW4gQ2Ft
ZXJvbjoNCj4gT24gVGh1LCAxNCBTZXAgMjAyMyAxNDoxMzowMCArMDIwMA0KPiBXYWRpbSBFZ29y
b3YgPHcuZWdvcm92QHBoeXRlYy5kZT4gd3JvdGU6DQo+DQo+PiBETUFzIGFyZSBvcHRpb25hbC4g
RXZlbiBpZiB0aGUgRE1BIHJlcXVlc3QgaXMgdW5zdWNjZXNzZnVsbHksDQo+PiB0aGUgQURDIGNh
biBzdGlsbCB3b3JrIHByb3Blcmx5Lg0KPj4gTWFrZSB0aWFkY19yZXF1ZXN0X2RtYSgpIG5vdCBm
YWlsIGlmIHdlIGRvIG5vdCBwcm92aWRlIGRtYXMgJg0KPj4gZG1hLW5hbWVzIHByb3BlcnRpZXMu
DQo+Pg0KPj4gVGhpcyBhY3R1YWxseSBmaXhlcyB0aGUgd3JvbmcgZXJyb3IgaGFuZGxpbmcgb2Yg
dGhlIHRpYWRjX3JlcXVlc3RfZG1hKCkNCj4+IHJlc3VsdCB3aGVyZSB0aGUgcHJvYmluZyBvbmx5
IGZhaWxlZCBpZiAtRVBST1BFX0RFRkVSIHdhcyByZXR1cm5lZC4NCj4+DQo+PiBGaXhlczogZjQz
OGI5ZGE3NWViICgiZHJpdmVyczogaWlvOiB0aV9hbTMzNXhfYWRjOiBhZGQgZG1hIHN1cHBvcnQi
KQ0KPj4NCj4gTm8gbGluZSBicmVhayBoZXJlLiAgRml4ZXMgdGFnIGlzIHBhcnQgb2YgdGhlIG1h
aW4gdGFnIGJsb2NrLg0KPj4gU2lnbmVkLW9mZi1ieTogV2FkaW0gRWdvcm92IDx3LmVnb3JvdkBw
aHl0ZWMuZGU+DQo+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9paW8vYWRjL3RpX2FtMzM1eF9hZGMu
YyB8IDcgKysrKystLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvdGlfYW0zMzV4
X2FkYy5jIGIvZHJpdmVycy9paW8vYWRjL3RpX2FtMzM1eF9hZGMuYw0KPj4gaW5kZXggOGRiN2Ew
MWNiNWZiLi5lMTRhYTkyNTRhYjEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvdGlf
YW0zMzV4X2FkYy5jDQo+PiArKysgYi9kcml2ZXJzL2lpby9hZGMvdGlfYW0zMzV4X2FkYy5jDQo+
PiBAQCAtNTQzLDggKzU0MywxMSBAQCBzdGF0aWMgaW50IHRpYWRjX3JlcXVlc3RfZG1hKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+PiAgIAlpZiAoSVNfRVJSKGRtYS0+Y2hhbikpIHsN
Cj4+ICAgCQlpbnQgcmV0ID0gUFRSX0VSUihkbWEtPmNoYW4pOw0KPj4gICANCj4+ICsJCWlmIChy
ZXQgIT0gLUVOT0RFVikNCj4+ICsJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2LCBy
ZXQsDQo+PiArCQkJCQkgICAgICJSWCBETUEgY2hhbm5lbCByZXF1ZXN0IGZhaWxlZFxuIik7DQo+
PiAgIAkJZG1hLT5jaGFuID0gTlVMTDsNCj4+IC0JCXJldHVybiByZXQ7DQo+PiArCQlyZXR1cm4g
MDsNCj4+ICAgCX0NCj4+ICAgDQo+PiAgIAkvKiBSWCBidWZmZXIgKi8NCj4+IEBAIC02NzAsNyAr
NjczLDcgQEAgc3RhdGljIGludCB0aWFkY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPj4gICAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgaW5kaW9fZGV2KTsNCj4+ICAg
DQo+PiAgIAllcnIgPSB0aWFkY19yZXF1ZXN0X2RtYShwZGV2LCBhZGNfZGV2KTsNCj4+IC0JaWYg
KGVyciAmJiBlcnIgPT0gLUVQUk9CRV9ERUZFUikNCj4+ICsJaWYgKGVycikNCj4gU28gdGhpcyBs
b29rcyBsaWtlIGEgbW9yZSBzdWJ0bGUgY2hhbmdlIHRoYW4geW91IGFyZSBkZXNjcmliaW5nLg0K
PiBJbiB0aGUgb3JpZ2luYWwgY29kZSwgd2UgYmFja2VkIG9mZiBvbmx5IGlmIHRoZSByZXR1cm4g
d2FzIGEgUFJPQkVfREVGRVIsIG90aGVyd2lzZQ0KPiB3ZSBjYXJyaWVkIG9uLg0KPg0KPiBZb3Vy
IGNoYW5nZSBzZWVtcyB0byBtYWtlIHRoYXQgaGFwcGVuIGZvciBhbnkgbm9uIC1FTk9ERVYgZXJy
b3IsIGluY2x1ZGluZyBQUk9CRV9ERUZFUi4NCj4gVGhhdCdzIGZpbmUsIGJ1dCBpdCdzIG5vdCB3
aGF0IHRoZSBkZXNjcmlwdGlvbiBpbXBsaWVzLg0KPg0KPiBXaGlsc3QgdGlhZGNfcmVxdWVzdF9k
bWEgd2lsbCBmYWlsIHRvZGF5IGlmIHRoZSBkbWFzIGV0YyBpcyBub3QgcHJvdmlkZWQsIHRoYXQg
c2VlbXMNCj4gbGlrZSBjb3JyZWN0IGJlaGF2aW9yIHRvIG1lLiAgQSBmdW5jdGlvbiByZXF1ZXN0
aW5nIGRtYSBmYWlscyBpZiBpdCBpc24ndCBhdmFpbGFibGUuDQo+IFRoZSBoYW5kbGluZyBvZiB3
aGV0aGVyIHRvIGNhcnJ5IG9uIHRoZSBqb2IgZm9yIHRoZSBjYWxsZXIuDQoNClRoYXQgbWFrZXMg
c2Vuc2UsIHllcy4gQnV0IHN0bTMyLWFkYyBpcyBkb2luZyB0aGUgc2FtZSBpbiBpdHMgZG1hIA0K
cmVxdWVzdCBmdW5jdGlvbi4NClNvIEkgYXNzdW1lZCB3ZSBjYW4gZG8gaXQgbGlrZSB0aGF0Lg0K
DQo+DQo+IFNvIEkgdGhpbmsgaXQgc2hvdWxkIGp1c3QgYmUNCj4gCWlmIChlcnIgJiYgZXJyICE9
IC1FSU5WQUwpDQo+IAkJZ290byBlcnJfZG1hOw0KDQpXZSB3aWxsIGVuZCB1cCBmYWlsaW5nIGlm
IG5vIGRtYXMgYXJlIGNvbmZpZ3VyZWQgYmVjYXVzZSB0aGUgcmVxdWVzdCANCnJldHVybnMgLUVO
T0RFVi4NClNvIEkgdGhpbmsgaXQgbmVlZHMgdG8gYmUgYSBjaGVjayBmb3Igbm9uIC1FTk9ERVYu
DQoNCj4NCj4gYW5kIG5vIGNoYW5nZSBpbiB0aWFkY19yZXF1ZXN0X2RtYSgpDQo+DQo+IEhvd2V2
ZXIsIHRoZSBjYXNlIHlvdSBkZXNjcmliZSBzaG91bGQgaGF2ZSB3b3JrZWQgZmluZCB3aXRoIGV4
aXN0aW5nIGNvZGUNCj4gYXMgaXQgd2Fzbid0IC1FUFJPQkVfREVGRVIsIHNvIEkgZG9uJ3QgdW5k
ZXJzdGFuZCB3aHkgeW91IHdlcmUgbG9va2luZyBhdCB0aGlzDQo+IGNvZGUgYmxvY2sgaW4gdGhl
IGZpcnN0IHBsYWNlPw0KDQpQcm92aWRpbmcgd3JvbmcgZG1hcyBpbiB0aGUgZGV2aWNlIHRyZWUg
c2hvdWxkJ3ZlIG1hZGUgdGhlIGRyaXZlciBmYWlsIA0KdG8gcHJvYmUuDQoNClJlZ2FyZHMsDQpX
YWRpbQ0KDQo+DQo+IEpvbmF0aGFuDQo+DQo+DQo+PiAgIAkJZ290byBlcnJfZG1hOw0KPj4gICAN
Cj4+ICAgCXJldHVybiAwOw0KDQoNCg==
