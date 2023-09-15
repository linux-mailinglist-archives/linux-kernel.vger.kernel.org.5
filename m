Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB587A2531
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbjIORuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjIORuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:50:20 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883521BF2;
        Fri, 15 Sep 2023 10:50:14 -0700 (PDT)
Received: from msexch01.omp.ru (10.188.4.12) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Fri, 15 Sep
 2023 20:50:11 +0300
Received: from msexch01.omp.ru ([fe80::4020:d881:621a:6b6b]) by
 msexch01.omp.ru ([fe80::4020:d881:621a:6b6b%5]) with mapi id 15.02.0986.014;
 Fri, 15 Sep 2023 20:50:11 +0300
From:   Denis Glazkov <d.glazkov@omp.ru>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
CC:     "dhowells@redhat.com" <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Denis Glazkov <d.glazkov@omp.ru>
Subject: Re: [PATCH v2] certs: Add option to disallow non-CA certificates in
 secondary trusted keying
Thread-Topic: [PATCH v2] certs: Add option to disallow non-CA certificates in
 secondary trusted keying
Thread-Index: AQHZ4k4BzqaMvMEYP0mVw3ughXalxbAV80gAgAYP9wA=
Date:   Fri, 15 Sep 2023 17:50:11 +0000
Message-ID: <3bc6b569be0beff9f70d58b751088fd2cc798e93.camel@omp.ru>
References: <f5a1d856-0482-a2c3-0e62-3ca911ce3dd2@omp.ru>
         <20230908121330.4076-1-d.glazkov@omp.ru>
         <CVGEE9ODRR8I.1RIVO2MVE2UAX@suppilovahvero>
In-Reply-To: <CVGEE9ODRR8I.1RIVO2MVE2UAX@suppilovahvero>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.188.4.40]
x-kse-serverinfo: msexch01.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 9/15/2023 2:10:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB87FA412D9D9243A0A5D612B10C1A4D@omp.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMTIgMjAyMyBhdCAwMToxNSBBTSArMDMwMCwgSmFya2tvIFNha2tpbmVuIHdy
b3RlOgo+IE9uIEZyaSBTZXAgOCwgMjAyMyBhdCAzOjE0IFBNIEVFU1QsIERlbmlzIEdsYXprb3Yg
d3JvdGU6Cj4gPiBUaGUgTGludXgga2VybmVsIGhhcyBhbiBJTUEgKEludGVncml0eSBNZWFzdXJl
bWVudCBBcmNoaXRlY3R1cmUpCj4gPiBzdWJzeXN0ZW0gdG8gY2hlY2sgdGhlIGludGVncml0eSBv
ZiB0aGUgZmlsZSBzeXN0ZW0gYmFzZWQgb24gZGlnaXRhbAo+ID4gc2lnbmF0dXJlcy4gSU1BIHVz
ZXMgY2VydGlmaWNhdGVzIGluIGAuaW1hYCBrZXlpbmcgdG8gY2hlY2sgaW50ZWdyaXR5Lgo+ID4g
Cj4gPiBPbmx5IGNlcnRpZmljYXRlcyBpc3N1ZWQgYnkgb25lIG9mIHRoZSB0cnVzdGVkIENBIChD
ZXJ0aWZpY2F0ZSBBdXRob3JpdHkpCj4gPiBjZXJ0aWZpY2F0ZXMgY2FuIGJlIGFkZGVkIHRvIHRo
ZSBgLmltYWAga2V5aW5nLgo+ID4gCj4gPiBUaGUgTGludXgga2VybmVsIG5vdyBoYXMgYSBzZWNv
bmRhcnkgdHJ1c3RlZCBrZXlpbmcgdG8gd2hpY2ggdHJ1c3RlZAo+ID4gY2VydGlmaWNhdGVzIGZy
b20gdXNlciBzcGFjZSBjYW4gYmUgYWRkZWQgaWYgeW91IGhhdmUgc3VwZXJ1c2VyCj4gPiBwcml2
aWxlZ2VzLiBQcmV2aW91c2x5LCBhbGwgdHJ1c3RlZCBjZXJ0aWZpY2F0ZXMgd2VyZSBpbiB0aGUg
YnVpbHQtaW4KPiA+IHRydXN0ZWQga2V5aW5nLCB3aGljaCBjb3VsZCBub3QgYmUgbW9kaWZpZWQg
ZnJvbSB1c2VyIHNwYWNlLgo+ID4gVHJ1c3RlZCBjZXJ0aWZpY2F0ZXMgd2VyZSBwbGFjZWQgaW4g
dGhlIGJ1aWx0LWluIHRydXN0ZWQga2V5aW5nIGF0Cj4gPiBrZXJuZWwgY29tcGlsZSB0aW1lLgo+
ID4gCj4gPiBUaGUgc2Vjb25kYXJ5IHRydXN0ZWQga2V5aW5nIGlzIGRlc2lnbmVkIHNvIHRoYXQg
YW55IGNlcnRpZmljYXRlcyB0aGF0Cj4gPiBhcmUgc2lnbmVkIGJ5IG9uZSBvZiB0aGUgdHJ1c3Rl
ZCBDQSBjZXJ0aWZpY2F0ZXMgaW4gdGhlIGJ1aWx0LWluIG9yCj4gPiBzZWNvbmRhcnkgdHJ1c3Rl
ZCBrZXlyaW5nIGNhbiBiZSBhZGRlZCB0byBpdC4KPiA+IAo+ID4gTGV0J3MgaW1hZ2luZSB0aGF0
IHdlIGhhdmUgdGhlIGZvbGxvd2luZyBjZXJ0aWZpY2F0ZSB0cnVzdCBjaGFpbjoKPiA+IAo+ID4g
ICAgICAgICAgICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUrOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkAo+ID4g
ICAgICAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiAgICAg4pSM4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSQICAgICAgIOKUggo+ID4gICAgICAgICAgICAgIOKUgiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIOKUgiAgICAg4pSCICAgICAgIOKUgiAgICAgICDilIIKPiA+
IOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKWvOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUkCAgICDilIzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilrzilIDilIDilIDilIDilIDilrzilIDilIDilIDilIDilJAgIOKUgiDilIzilIDilIDilIDi
lIDilIDilLTilIDilIDilIDilIDilIDilJAKPiA+IOKUgi5idWlsdGluX3RydXN0ZWRfa2V5c+KU
guKXhOKUgOKUgOKUgOKUpC5zZWNvbmRhcnlfdHJ1c3RlZF9rZXlzIOKUnOKUgOKUgOKUmCDilIIg
ICAuaW1hICAgIOKUggo+ID4g4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSkICAgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpCAg
ICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQKPiA+IOKUgiAgICAgUm9v
dCBDQSBDZXJ0ICAgIOKUgi0tLS0t4pa6IEludGVybWVkaWF0ZSBDQSBDZXJ0ICDilIItLS0tLeKW
uiBJTUEgQ2VydCDilIIKPiA+IOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmCAgICDilJTilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJgg
ICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYCj4gPiAKPiA+ICAgICAg
ICAgICAgICAgICBJc3N1ZXMgICAgICAgICAgICAgICAgICBSZXN0cmljdGVkIGJ5Cj4gPiAgICAg
ICAgICAgICAtLS0tLS0tLS0tLS0t4pa6ICAgICAgICAgICAgIOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKWugo+ID4gCj4gPiBTaW5jZSB0aGUgSU1BIGNlcnRpZmlj
YXRlIGlzIHNpZ25lZCBieSBhIENBIGNlcnRpZmljYXRlIGZyb20gYSBzZWNvbmRhcnkKPiA+IHRy
dXN0ZWQga2V5aW5nLCBhbiBhdHRhY2tlciB3aXRoIHN1cGVydXNlciBwcml2aWxlZ2VzIHdpbGwg
YmUgYWJsZSB0bwo+ID4gYWRkIHRoZSBJTUEgY2VydGlmaWNhdGUgdG8gdGhlIHNlY29uZGFyeSB0
cnVzdGVkIGtleWluZy4gVGhhdCBpcywgdGhlIElNQQo+ID4gY2VydGlmaWNhdGUgd2lsbCBiZWNv
bWUgdHJ1c3RlZC4KPiA+IAo+ID4gU2luY2UsIHdpdGggYENPTkZJR19NT0RVTEVfU0lHYCBvcHRp
b24gZW5hYmxlZCwgbW9kdWxlcyBjYW4gb25seSBiZQo+ID4gbG9hZGVkIGludG8ga2VybmVsIHNw
YWNlIGlmIHRoZXkgYXJlIHNpZ25lZCB3aXRoIG9uZSBvZiB0aGUgdHJ1c3RlZAo+ID4gY2VydGlm
aWNhdGVzLCBhbiBhdHRhY2tlciBjb3VsZCBzaWduIHVudHJ1c3RlZCBrZXJuZWwgbW9kdWxlcyB3
aXRoCj4gPiB0aGUgcHJpdmF0ZSBrZXkgY29ycmVzcG9uZGluZyB0byB0aGUgSU1BIGNlcnRpZmlj
YXRlIGFuZCBzdWNjZXNzZnVsbHkKPiA+IGxvYWQgdGhlIHVudHJ1c3RlZCBtb2R1bGVzIGludG8g
a2VybmVsIHNwYWNlLgo+ID4gCj4gPiBUaGlzIHBhdGNoIGFkZHMgdGhlIGNvbmZpZ3VyYXRpb24g
dGhhdCBvbmNlIGVuYWJsZWQsIG9ubHkKPiA+IGNlcnRpZmljYXRlcyB0aGF0IG1lZXQgdGhlIGZv
bGxvd2luZyByZXF1aXJlbWVudHMgY2FuIGJlIGFkZGVkCj4gPiB0byB0aGUgc2Vjb25kYXJ5IHRy
dXN0ZWQga2V5aW5nOgo+ID4gCj4gPiAxLiBUaGUgY2VydGlmaWNhdGUgaXMgYSBDQSAoQ2VydGlm
aWNhdGUgQXV0aG9yaXR5KQo+ID4gMi4gVGhlIGNlcnRpZmljYXRlIG11c3QgYmUgdXNlZCBmb3Ig
dmVyaWZ5aW5nIGEgQ0EncyBzaWduYXR1cmVzCj4gPiAzLiBUaGUgY2VydGlmaWNhdGUgbXVzdCBu
b3QgYmUgdXNlZCBmb3IgZGlnaXRhbCBzaWduYXR1cmVzCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6
IERlbmlzIEdsYXprb3YgPGQuZ2xhemtvdkBvbXAucnU+Cj4gCj4gcy9rZXlpbmcva2V5cmluZy8g
KG11bHRpcGxlKQo+IAo+IEhhdmUgeW91IGNvbnNpZGVyZWQgaW5zdGVhZCBtYWtpbmcgbW9kX3Zl
cmlmeV9zaWcoKSBtb3JlIHJvYnVzdD8KPiBPYnZpb3VzbHkgdGhpcyB3b3VsZCBtZWFuIG1ha2lu
ZyBzZWxlY3Rpb24gb2Yga2V5cyBpbgo+IHZlcmlmeV9wa2NzN19zaWduYXR1cmUoKSBtb3JlIHJv
YnVzdCAoc2VlIHRoZSBkb2N1bWVudGF0aW9uIG9mCj4gJ3RydXN0ZWRfa2V5cycpLgo+IAo+IFRo
ZSB0aGlzIHdvdWxkIGJlIGFsc28gbGVzcyBuaWNoZSBmZWF0dXJlIHRvIHBpY2sgZm9yIGRpc3Ry
aWJ1dG9ycwo+IGlmIGl0IHdhcyBqdXN0IGNvbmNlcm5pbmcgbW9kdWxlIGxvYWRpbmcsIGFuZCBo
YXZlIGFzc29jaWF0ZWQgY29uZmlnCj4gZmxhZyBvdmVyIHRoZXJlLgo+IAo+IEJSLCBKYXJra28K
CkphcmtrbywgdGhhbmsgeW91IGZvciB5b3VyIHN1Z2dlc3Rpb24uCgpUaGlzIHBhdGNoIHdhcyBj
cmVhdGVkIG5vdCB0byBzb2x2ZSBvbmx5IHRoZSBwcm9ibGVtIG9mIGxvYWRpbmcKdW50cnVzdGVk
IGtlcm5lbCBtb2R1bGVzLCBidXQgdG8gbWFrZSBpdCBwb3NzaWJsZSB0byB1c2UgYSBzZWNvbmRh
cnkKdHJ1c3RlZCBrZXlpbmcgb25seSBhcyBhIHBhcnQgb2YgYSBjaGFpbiBvZiB0cnVzdCBjb250
YWluaW5nIG9ubHkKQ0EgY2VydGlmaWNhdGVzIHdpdGggbm8gZGlnaXRhbCBzaWduYXR1cmUgY2Fw
YWJpbGl0eS4KCkxldCdzIGltYWdpbmUgdGhhdCB0b21vcnJvdyB3ZSBoYXZlIGEgbmV3IGtlcm5l
bCBmZWF0dXJlLCBzaW1pbGFyCnRvIGtlcm5lbCBtb2R1bGVzIGluIHRlcm1zIG9mIGl0cyBpbXBh
Y3Qgb24gc3lzdGVtIHNlY3VyaXR5LCB3aGljaAphbHNvIHVzZXMgdHJ1c3RlZCBjZXJ0aWZpY2F0
ZXMgZm9yIHNpZ25hdHVyZSB2ZXJpZmljYXRpb24uCgpJZiBhdCB0aGlzIHBvaW50IHdlIHNvbHZl
IG9ubHkgdGhlIHByb2JsZW0gb2YgbG9hZGluZyB1bnRydXN0ZWQKa2VybmVsIG1vZHVsZXMsIGFu
ZCBub3QgdGhlIHByb2JsZW0gb2YgdGhlIGVudGlyZSB0cnVzdGVkIGtleXMKc3lzdGVtLCB3ZSB3
aWxsIG5lZWQgdG8gYWRkIGEgbmV3IGtlcm5lbCBvcHRpb24gZWFjaCB0aW1lIHRvIHNvbHZlCmEg
c2ltaWxhciBwcm9ibGVtIGZvciBlYWNoIG5ldyBrZXJuZWwgZmVhdHVyZSB0aGF0IHVzZXMgdHJ1
c3RlZApjZXJ0aWZpY2F0ZXMuCgpCUiwgRGVuaXMK
