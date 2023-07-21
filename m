Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7DC75CC3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjGUPny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjGUPnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:43:53 -0400
Received: from m13116.mail.163.com (m13116.mail.163.com [220.181.13.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79B1B1727;
        Fri, 21 Jul 2023 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=XTJYfllEo+smLOKh/rd6ml4aoLIB5HXMxyL+yhtIcmU=; b=a
        13wUjK/MmGPfFsL/dCAvM0ekyKiiFQvSly+YJvF0RLlSl3KxOtevyQOqrkjD2XbL
        jKafM0Ybd1AtwFfq4sEOxcqsXH6LH3qZc+qp2Txa2TN7GFWSXmLA/SSLBGG/KyQD
        TtlsGG3rE/jFJsHAV/13KX3x/1Stca+UbuKkZiFBCY=
Received: from 18500469033$163.com ( [114.253.21.2] ) by
 ajax-webmail-wmsvr116 (Coremail) ; Fri, 21 Jul 2023 23:43:29 +0800 (CST)
X-Originating-IP: [114.253.21.2]
Date:   Fri, 21 Jul 2023 23:43:29 +0800 (CST)
From:   "Dingyan Li" <18500469033@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, sebastian.reichel@collabora.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: Re: [PATCH] USB: add usbfs ioctl to get specific
 superspeedplus rates
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <2023072159-carol-underfeed-43eb@gregkh>
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
 <2023072159-carol-underfeed-43eb@gregkh>
X-NTES-SC: AL_QuyTC/Weu0or7yObY+kXkkYVgew6WsC4vf4k3IReOps0qivL0AQaZkZ9F17s0sauIQaniSG2SRFhy9V1ZpRmfKJEjac7+fRCjtf1K7IOZ8uS
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <25f05926.7e4c.189791ece3b.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: dMGowAC331Shp7pkrvMHAA--.45458W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbBUQazy1aEE963YAABsm
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjMtMDctMjEgMjI6NTE6MzIsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOgo+T24gRnJpLCBKdWwgMjEsIDIwMjMgYXQgMDg6MzU6MzdQTSArMDgwMCwg
RGluZ3lhbiBMaSB3cm90ZToKPj4gCj4+IEF0IDIwMjMtMDctMjEgMTk6MDQ6MjksICJHcmVnIEtI
IiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+PiA+T24gRnJpLCBKdWwgMjEs
IDIwMjMgYXQgMDQ6NDA6MzlQTSArMDgwMCwgRGluZ3lhbiBMaSB3cm90ZToKPj4gPj4gVGhlIHVz
YmZzIGludGVyZmFjZSBkb2VzIG5vdCBwcm92aWRlIGFueSB3YXkgdG8gZ2V0IHNwZWNpZmljCj4+
ID4+IHN1cGVyc3BlZWRwbHVzIHJhdGUsIGxpa2UgR2VuMngxLCBHZW4xeDIgb3IgR2VuMngyLiBD
dXJyZW50Cj4+ID4+IEFQSSBpbmNsdWRlIGFuIFVTQkRFVkZTX0dFVF9TUEVFRCBpb2N0bCwgYnV0
IGl0IGNhbiBvbmx5IHJldHVybgo+PiA+PiBnZW5lcmFsIHN1cGVyc3BlZWRwbHVzIHNwZWVkIGlu
c3RlYWQgb2YgYW55IHNwZWNpZmljIHJhdGVzLgo+PiA+PiBUaGVyZWZvcmUgd2UgY2FuJ3QgdGVs
bCB3aGV0aGVyIGl0J3MgYSBHZW4yeDIoMjBHYnBzKSBkZXZpY2UuCj4+ID4+IAo+PiA+PiBUaGlz
IHBhdGNoIGludHJvZHVjZSBhIG5ldyBpb2N0bCBVU0JERVZGU19HRVRfU1NQX1JBVEUgdG8gZml4
Cj4+ID4+IGl0LiBTaW1pbGFyIGluZm9ybWF0aW9uIGlzIGFscmVhZHkgYXZhaWxhYmxlIHZpYSBz
eXNmcywgaXQncwo+PiA+PiBnb29kIHRvIGFkZCBpdCBmb3IgdXNiZnMgdG9vLgo+PiA+PiAKPj4g
Pj4gU2lnbmVkLW9mZi1ieTogRGluZ3lhbiBMaSA8MTg1MDA0NjkwMzNAMTYzLmNvbT4KPj4gPj4g
LS0tCj4+ID4+ICBkcml2ZXJzL3VzYi9jb3JlL2RldmlvLmMgICAgICAgICAgfCAzICsrKwo+PiA+
PiAgaW5jbHVkZS91YXBpL2xpbnV4L3VzYmRldmljZV9mcy5oIHwgMSArCj4+ID4+ICAyIGZpbGVz
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+PiA+PiAKPj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2NvcmUvZGV2aW8uYyBiL2RyaXZlcnMvdXNiL2NvcmUvZGV2aW8uYwo+PiA+PiBpbmRl
eCAxYTE2YThiZGVhNjAuLjJmNTdlYjE2MzM2MCAxMDA2NDQKPj4gPj4gLS0tIGEvZHJpdmVycy91
c2IvY29yZS9kZXZpby5jCj4+ID4+ICsrKyBiL2RyaXZlcnMvdXNiL2NvcmUvZGV2aW8uYwo+PiA+
PiBAQCAtMjc4Myw2ICsyNzgzLDkgQEAgc3RhdGljIGxvbmcgdXNiZGV2X2RvX2lvY3RsKHN0cnVj
dCBmaWxlICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLAo+PiA+PiAgCWNhc2UgVVNCREVWRlNfR0VU
X1NQRUVEOgo+PiA+PiAgCQlyZXQgPSBwcy0+ZGV2LT5zcGVlZDsKPj4gPj4gIAkJYnJlYWs7Cj4+
ID4+ICsJY2FzZSBVU0JERVZGU19HRVRfU1NQX1JBVEU6Cj4+ID4+ICsJCXJldCA9IHBzLT5kZXYt
PnNzcF9yYXRlOwo+PiA+PiArCQlicmVhazsKPj4gPgo+PiA+U2hvdWxkbid0IHRoaXMgbmV3IGlv
Y3RsIGJlIGRvY3VtZW50ZWQgc29tZXdoZXJlPyAgV2hhdCBhcmUgdGhlIHZhbGlkCj4+ID52YWx1
ZXMgaXQgY2FuIHJldHVybj8gIFdoYXQgaWYgaXQgaW4ndCBhIHN1cGVyc3BlZWQgZGV2aWNlPyAg
V2hvIGlzCj4+ID5nb2luZyB0byB1c2UgdGhpcz8KPj4gPgo+PiA+QW5kIHdlIGhhdmUgdHJhZGl0
aW9uYWxseSBvbmx5IGJlZW4gYWRkaW5nIG5ldyBpbmZvcm1hdGlvbiBsaWtlIHRoaXMgdG8KPj4g
PnN5c2ZzLCB3aGljaCB3YXMgbm90IGFyb3VuZCB3aGVuIHVzYmZzIHdhcyBjcmVhdGVkLiAgV2h5
IG5vdCBqdXN0IHVzZQo+PiA+dGhhdCBpbnN0ZWFkPyAgQXJlIHlvdSB3YW50aW5nIHRvIHNlZSBh
bGwgb2YgdGhlIHN5c2ZzLXByb3ZpZGVkCj4+ID5pbmZvcm1hdGlvbiBpbiB1c2JmcyBhbHNvPwo+
PiA+Cj4+ID50aGFua3MsCj4+ID4KPj4gCj4+ID5ncmVnIGstaAo+PiAKPj4gMS4gQnkgc2F5aW5n
ICJiZSBkb2N1bWVudGVkIHNvbWV3aGVyZSIsIGRvIHlvdSBtZWFuIHRoZXJlIGlzIGV4dHJhCj4+
ICAgICBkb2N1bWVudGF0aW9uIHdvcmsgd2hpY2ggbmVlZHMgdG8gYmUgZG9uZT8gU29ycnkgdGhh
dCBJIG1pc3NlZCB0aGlzCj4+ICAgICBwYXJ0IHNpbmNlIGl0J3MgdGhlIGZpcnN0IHRpbWUgZm9y
IG1lIHRvIHdvcmsgb24gYSBrZXJuZWwgcGF0Y2guCj4KPkl0IG5lZWRzIHRvIGJlIGRvY3VtZW50
ZWQgc29tZXdoZXJlLCBvdGhlcndpc2Ugbm8gb25lIGtub3dzIGhvdyB0byB1c2UKPml0Lgo+Cj4+
IDIuIElmIG5vIGVycm9yLCByZXR1cm5lZCB2YWx1ZXMgYXJlICJlbnVtIHVzYl9zc3BfcmF0ZSIg
ZGVmaW5lZCBpbiBpbmNsdWRlL2xpbnV4L3VzYi9jaDkuaAo+PiAzLiBzc3AgcmF0ZSBpcyBvbmx5
IHZhbGlkIGZvciBzdXBlcnNwZWVkcGx1cy4gRm9yIG90aGVyIHNwZWVkcywgaXQgc2hvdWxkIGJl
Cj4+ICAgICBVU0JfU1NQX0dFTl9VTktOT1dOLgo+Cj5PaywgdGhhdCBzaG91bGQgYmUgZG9jdW1l
bnRlZC4KPgo+PiA0LiBJIGZvdW5kIGluIGxpYnVzYiwgdGhlcmUgYXJlIHR3byB3YXlzIHRvIGdl
dCBzcGVlZCB2YWx1ZSBmb3IgYSBkZXZpY2UuCj4+ICAgICBPbmUgd2F5IGlzIHZpYSBzeXNmcywg
d2hpY2ggaGFzIHN1cHBvcnRlZCAyMEdicHMgbm93LiBBbm90aGVyIHdheSBpcwo+PiAgICAgdG8g
dXNlIGlvY3RsIFVTQkRFVkZTX0dFVF9TUEVFRC4gVGhpcyBpcyB3aGVuIEkgZm91bmQgdGhpcyBp
b2N0bCBjYW4gb25seQo+PiAgICAgcmV0dXJuIFVTQl9TUEVFRF9TVVBFUl9QTFVTIGF0IG1vc3Qs
IGl0IGNhbm5vdCBkZXRlcm1pbmUgY3VycmVudCBzc3AgcmF0ZQo+PiAgICAgZnVydGhlciwgbm8g
bWF0dGVyIEdlbjF4MigxMEdicHMpLCBHZW4yeDEoMTBHYnBzKSBvciBHZW4yeDIoMjBHYnBzKS4g
U28gSQo+PiAgICAgdGhvdWdodCBtYXliZSBpdCdzIGdvb2QgdG8gcHJvdmlkZSBhIHNpbWlsYXIg
d2F5IGxpa2UgaW9jdGwgVVNCREVWRlNfR0VUX1NQRUVECj4+ICAgICBpbiBvcmRlciB0byBnZXQg
c3NwIHJhdGVzLgo+Cj5JZiBsaWJ1c2IgZG9lc24ndCBuZWVkIHRoaXMgaW9jdGwsIHdobyB3b3Vs
ZCB1c2UgaXQ/ICBXZSBvbmx5IGFkZCBhcGlzCj50aGF0IGFyZSBhY3R1YWxseSBnb2luZyB0byBi
ZSB1c2VkLgo+Cj5TbyBpZiBsaWJ1c2IgZG9lc24ndCB1c2UgaXQsIHdlIG5lZWQgYSByZWFsLXdv
cmxkIHVzZXIgZm9yIHVzIHRvIGJlIGFibGUKPnRvIGFkZCB0aGlzLgo+Cj50aGFua3MsCj4KCj5n
cmVnIGstaAoKT2theSwgZ290IGl0LiBUaGUgbW90aXZhdGlvbiBzaG91bGQgY29tZSBmcm9tIHJl
YWwtd29ybGQgbmVlZHMuCgpKdXN0IGxpa2UgSSBtZW50aW9uZWQgYWJvdmUsIGN1cnJlbnRseSBp
biBsaWJ1c2IgaW9jdGwgVVNCREVWRlNfR0VUX1NQRUVECmlzIHN0aWxsIHVzZWQsIGVzcGVjaWFs
bHkgd2hlcmUgc3lzZnMgaXMgbm90IHN1cHBvcnRlZC4gTXkgb3JpZ2luYWwgaWRlYQp3YXMgZXhh
Y3RseSB0cnlpbmcgdG8gYWRkIHRoaXMgbmV3IGlvY3RsIGludG8gbGlidXNiLiBTbyBpbiBvcmRl
ciB0byBnZXQgMjBHYnBzCnNwZWVkLCB3ZSBuZWVkIGV4dHJhIGluZm9ybWF0aW9uLiBUaGUgYmFz
aWMgd29ya2Zsb3cgaXMgbGlrZSBiZWxvdzoKCi8vIFRoaXMgaXMgcHJldHR5IG11Y2ggaG93IGxp
YnVzYiBkb2VzIGl0LCBnZXQgMTBHYnBzIGF0IG1vc3QKcmV0ID0gaW9jdGwoVVNCREVWRlNfR0VU
X1NQRUVEKQppZiAocmV0ID09wqBVU0JfU1BFRURfU1VQRVJfUExVUykgdGhlbgogICDCoHNwZWVk
ID0gMTBHYnBzCiAgICAvLyBXaXRoIHRoaXMgbmV3IGlvY3RsLCB3ZSBjYW4gZ2V0IDIwR2JwcyBu
b3cKICAgIHJldCA9IGlvY3RsKFVTQkRFVkZTX0dFVF9TU1BfUkFURSkKICAgIGlmIChyZXQgPT0g
VVNCX1NTUF9HRU5fMngyKQogICAgICAgIHNwZWVkID0gMjBHYnBzCgpsaWJ1c2IgY2FuIGJlIGEg
Z29vZCBwbGFjZSB0byBkb2N1bWVudCB0aGUgdXNhZ2Ugb2YgdGhpcyBuZXcgaW9jdGwgaWbCoHNp
bWlsYXIgcGF0Y2gKY2FuIGJlIGFjY2VwdGVkIGludG8gaXQuIEFuZCBJIGNhbid0IHRoaW5rIG9m
IG90aGVyIHJlYWwtd29ybGQgdXNlcnMgbm93LiBPZiBjb3Vyc2UsCmxpa2UgeW91J3ZlIGV4cGxh
aW5lZCwgaXQgc2VlbXMgcXVpdGUgdW5uZWNlc3Nhcnkgd2hlbiBzeXNmcyBpcyBzdXBwb3J0ZWQu
CgpSZWdhcmRzLApEaW5neWFu
