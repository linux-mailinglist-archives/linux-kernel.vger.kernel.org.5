Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D21E7F002E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 15:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjKROoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 09:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKROog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 09:44:36 -0500
X-Greylist: delayed 395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Nov 2023 06:44:31 PST
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF23AC0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 06:44:31 -0800 (PST)
Message-ID: <6c4e59de57c4e38fbe36235a264973d6f8d3e881.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700318274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TvHjbwrHqbRd1fNQEI0IfwNDNv4jGQ13g6zsDW0sYc4=;
        b=wlb3BbZ87wQ+szydcR0mz4d9soR/bn/WV+AH+jF99mBTMxbRwCE9Ga7QBQy/x5LG2wg5jF
        0aQJvY+Vpcy9aLa0mCpxV09hjOuaNCf4yfqrk12ZklFHFerGq7zHUZ4kqTMFvqJd51RVcv
        lcz2a+GDn9p0IxzcwUbIRepJzDW6mFM=
Subject: Re: [PATCH] checkpatch: add judgment condition for Kconfig help test
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cixi Geng <cixi.geng@linux.dev>
To:     Randy Dunlap <rdunlap@infradead.org>, apw@canonical.com,
        joe@perches.co, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 18 Nov 2023 22:37:37 +0800
In-Reply-To: <c40ddfd4-5781-4382-a3f1-c18cbfb22b34@infradead.org>
References: <20231116153904.15589-1-cixi.geng@linux.dev>
         <c40ddfd4-5781-4382-a3f1-c18cbfb22b34@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTExLTE3IGF0IDE4OjI2IC0wODAwLCBSYW5keSBEdW5sYXAgd3JvdGU6Cj4g
SGktLQo+IAo+IE9uIDExLzE2LzIzIDA3OjM5LCBDaXhpIEdlbmcgd3JvdGU6Cj4gPiBGcm9tOiBD
aXhpIEdlbmcgPGNpeGkuZ2VuZzFAdW5pc29jLmNvbT4KPiA+IAo+ID4gVGhlIGhhc19oZWxwIG9u
bHkgY291bnRlZCB0aGXCoCBzaXR1YXRpb24gd2hpY2ggdGhlIHBhdGNoIGZpbGUgYWRkCj4gPiBh
IGhlbHAgbGluZSwgd2hlbiB0aGUgY29uZmlnIHdhcyByZW5hbWVkIGFuZMKgIG1vZGlmeSBkZXNj
cmlwdGlvbiwKPiA+IHRoZSBoYXNfaGVscCBpcyB6ZXJvIGZvciB0aGUgImhlbHAiIGxpbmUgbm90
IGFkZGVkLgo+ID4gCj4gPiBoZXJlIGlzIG9uZSBjYXNlOgo+ID4gwqDCoMKgIHRoZSBtb2RpZnkg
ZmlsZTogZHJpdmVycy9paW8vYWRjL0tjb25maWfCoCBsaW5lKDEwNDcpCj4gPiAKPiA+IMKgwqDC
oCAtY29uZmlnIFNDMjdYWF9BREMKPiA+IMKgwqDCoCArY29uZmlnIFNQUkRfQURDCj4gPiDCoMKg
wqDCoMKgwqDCoMKgdHJpc3RhdGUgIlNwcmVhZHRydW0gU0MyN3h4IHNlcmllcyBQTUlDcyBBREMi
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgZGVwZW5kcyBvbiBNRkRfU0MyN1hYX1BNSUMgfHwgQ09NUElM
RV9URVNUCj4gPiDCoMKgwqAgK8KgwqDCoGRlcGVuZHMgb24gQVJDSF9TUFJECj4gPiDCoMKgwqDC
oMKgwqDCoMKgaGVscAo+ID4gwqDCoMKgIC3CoMKgwqDCoCBTYXkgeWVzIGhlcmUgdG8gYnVpbGQg
c3VwcG9ydCBmb3IgdGhlIGludGVncmF0ZWQgQURDCj4gPiBpbnNpZGUgdGhlCj4gPiDCoMKgwqAg
LcKgwqDCoMKgIFNwcmVhZHRydW0gU0MyN3h4IHNlcmllcyBQTUlDcy4KPiA+IMKgwqDCoCArwqDC
oMKgwqAgU2F5IHllcyBoZXJlIHRvIGJ1aWxkIHN1cHBvcnQgZm9yIHRoZSBpbnRlZ3JhdGVkIEFE
Qwo+ID4gaW5zaWRlIG9mIHRoZQo+ID4gwqDCoMKgICvCoMKgwqDCoCBTcHJlYWR0cnVtIFNDMjd4
eCBhbmQgVU1QeHggc2VyaWVzIFBNSUNzLgo+ID4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgVGhp
cyBkcml2ZXIgY2FuIGFsc28gYmUgYnVpbHQgYXMgYSBtb2R1bGUuIElmIHNvLCB0aGUKPiA+IG1v
ZHVsZQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIHdpbGwgYmUgY2FsbGVkIHNjMjd4eF9hZGMuCj4g
Cj4gT0ssIEkgbWFkZSB0aG9zZSBjaGFuZ2VzIHRvIHRoYXQgS2NvbmZpZyBmaWxlIGFuZCByYW4g
Y2hlY2twYXRjaC4KPiBJIGRpZG4ndCBnZXQgYW55IG9mIHRoZSBmb2xsb3dpbmcgY2hlY2twYXRj
aCByZXN1bHRzLgo+IAo+IEFyZSB5b3UgdXNpbmcgYSBjdXJyZW50IHZlcnNpb24gb2YgY2hlY2tw
YXRjaD8KeWVzLCBJJ2FtIHN1cmUgdGhlcmUgaXMgc29tZSB3cm9uZyByZXN1bHQgYWJvdXQgdGhl
IHBhdGNoLCBNeSBsb2NhbAp2ZXJpb24gaXMgYmFzZWQgb24gKDc0NzVlNTFiODc5NiAoSEVBRCAt
PiBsb2NhbCwgb3JpZ2luL21hc3RlciwKb3JpZ2luL0hFQUQpIE1lcmdlIHRhZyAnbmV0LTYuNy1y
YzInIG9mCmdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRk
ZXYvbmV0KQoKbXkgc3RlcHMgaXMgbW9kaWZ5IHRoZSBLY29uZmlnLCBnZW5lcmF0ZSBhIHRlc3Qg
Y29tbWl0LiBhbmQgZ2l0IGZvcm1hdAp0aGlzIGNvbW1pdCwgdGhlbiBydW4gLi9zY3JpcHRzL2No
ZWNrcGF0Y2gucGwgMDAwMS10ZXN0LnBhdGNoLgo+IAo+ID4gdGhlIGNoZWNrcGF0Y2ggcmVzdWx0
Ogo+ID4gwqDCoMKgIFdBUk5JTkc6IHBsZWFzZSB3cml0ZSBhIGhlbHAgcGFyYWdyYXBoIHRoYXQg
ZnVsbHkgZGVzY3JpYmVzIHRoZQo+ID4gY29uZmlnIHN5bWJvbAo+ID4gwqDCoMKgICMyMzogRklM
RTogZHJpdmVycy9paW8vYWRjL0tjb25maWc6MTA1MDoKPiA+IMKgwqDCoCArY29uZmlnIFNQUkRf
QURDCj4gPiDCoMKgwqAgK8KgwqDCoHRyaXN0YXRlICJTcHJlYWR0cnVtJ3MgQURDIFBNSUNzIGRy
aXZlciIKPiA+IMKgwqDCoMKgwqDCoMKgwqBkZXBlbmRzIG9uIE1GRF9TQzI3WFhfUE1JQyB8fCBD
T01QSUxFX1RFU1QKPiA+IMKgwqDCoCArwqDCoMKgZGVwZW5kcyBvbiBBUkNIX1NQUkQKPiA+IMKg
wqDCoMKgwqDCoMKgwqBoZWxwCj4gPiDCoMKgwqAgK8KgwqDCoMKgIFNheSB5ZXMgaGVyZSB0byBi
dWlsZCBzdXBwb3J0IGZvciB0aGUgaW50ZWdyYXRlZCBBREMKPiA+IGluc2lkZSBvZiB0aGUKPiA+
IMKgwqDCoCArwqDCoMKgwqAgU2F5IHllcyBoZXJlIHRvIGJ1aWxkIHN1cHBvcnQgZm9yIHRoZSBp
bnRlZ3JhdGVkIEFEQwo+ID4gaW5zaWRlIG9mIHRoZQo+ID4gwqDCoMKgICvCoMKgwqDCoCBTYXkg
eWVzIGhlcmUgdG8gYnVpbGQgc3VwcG9ydCBmb3IgdGhlIGludGVncmF0ZWQgQURDCj4gPiBpbnNp
ZGUgb2YgdGhlCj4gPiDCoMKgwqAgK8KgwqDCoMKgIFNwcmVhZHRydW0gU0MyN3h4IGFuZCBVTVB4
eCBzZXJpZXMgUE1JQ3MuCj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBUaGlzIGRyaXZlciBj
YW4gYWxzbyBiZSBidWlsdCBhcyBhIG1vZHVsZS4gSWYgc28sIHRoZQo+ID4gbW9kdWxlCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqAgd2lsbCBiZSBjYWxsZWQgc2MyN3h4X2FkYy4KPiA+IAo+ID4gwqDC
oMKgIHRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMTcgbGluZXMgY2hlY2tlZAo+ID4gCj4g
PiBGaXhlczogYjg3MDliY2U5MDg5ICgiY2hlY2twYXRjaDogaW1wcm92ZSBLY29uZmlnIGhlbHAg
dGVzdCIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaXhpIEdlbmcgPGNpeGkuZ2VuZzFAdW5pc29jLmNv
bT4KPiA+IC0tLQo+ID4gwqBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgfCAyICstCj4gPiDCoDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4gCj4gPiBkaWZmIC0t
Z2l0IGEvc2NyaXB0cy9jaGVja3BhdGNoLnBsIGIvc2NyaXB0cy9jaGVja3BhdGNoLnBsCj4gPiBp
bmRleCAyNWZkYjdmZGExMTIuLjQwMjAwOWQwODUwNSAxMDA3NTUKPiA+IC0tLSBhL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbAo+ID4gKysrIGIvc2NyaXB0cy9jaGVja3BhdGNoLnBsCj4gPiBAQCAtMzYx
Niw3ICszNjE2LDcgQEAgc3ViIHByb2Nlc3Mgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAk
bmVlZHNfaGVscCA9IDE7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5leHQ7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgfQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKCRmID1+IC9eXCtccypoZWxwXHMqJC8pIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
ICgkZiA9fiAvXlwrXHMqaGVscFxzKiQvIHx8ICRmID1+Cj4gPiAvXlxzKmhlbHBccyokLykgewo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAkaGFzX2hlbHAgPSAxOwo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBuZXh0Owo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiAKCg==

