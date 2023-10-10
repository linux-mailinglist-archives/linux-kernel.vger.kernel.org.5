Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87307C4288
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbjJJV2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344087AbjJJV23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:28:29 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D94EC4;
        Tue, 10 Oct 2023 14:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696973302; x=1728509302;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=apemo4mafJnoQdOvUmfvzVoj6gatjNwvh2GpddgC7yk=;
  b=Bg7NakZr1dhDP3yEvj2R/ixIyJPgGgOgXWjoT7ymh3/u6GA/MrxRDjaG
   mJSr11SeE1O17+5stS1ObhYq1veAqAcusKmAnpbNNYVVbZlZjPKbd7mY9
   mIzdwR2wXjByj3iQ2/8c96sB6puJAaoBgby3NhBdIyd/1HZgh9fwp83Ar
   8=;
X-IronPort-AV: E=Sophos;i="6.03,213,1694736000"; 
   d="scan'208";a="244707872"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 21:28:19 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id 6C3DD40D40;
        Tue, 10 Oct 2023 21:28:18 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 21:28:18 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 10 Oct
 2023 21:28:15 +0000
Message-ID: <80a54418-5ecb-47f2-8862-2b1097124985@amazon.com>
Date:   Tue, 10 Oct 2023 23:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] misc: Add Nitro Secure Module driver
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        "Petre Eftime" <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20231010191815.13641-1-graf@amazon.com>
 <7792f0ce-b6b4-4b20-9725-1792a888297f@wanadoo.fr>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <7792f0ce-b6b4-4b20-9725-1792a888297f@wanadoo.fr>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoZSwKClRoYW5rcyBhIGJ1bmNoIGZvciB0aGUgcmV2aWV3IQoKCk9uIDEwLjEw
LjIzIDIyOjA2LCBDaHJpc3RvcGhlIEpBSUxMRVQgd3JvdGU6Cj4KPgo+IExlIDEwLzEwLzIwMjMg
w6AgMjE6MTgsIEFsZXhhbmRlciBHcmFmIGEgw6ljcml0IDoKPj4gV2hlbiBydW5uaW5nIExpbnV4
IGluc2lkZSBhIE5pdHJvIEVuY2xhdmUsIHRoZSBoeXBlcnZpc29yIHByb3ZpZGVzIGEKPj4gc3Bl
Y2lhbCB2aXJ0aW8gZGV2aWNlIGNhbGxlZCAiTml0cm8gU2VjdXJpdHkgTW9kdWxlIiAoTlNNKS4g
VGhpcyBkZXZpY2UKPj4gaGFzIDMgbWFpbiBmdW5jdGlvbnM6Cj4+Cj4+IMKgwqAgMSkgUHJvdmlk
ZSBhdHRlc3RhdGlvbiByZXBvcnRzCj4+IMKgwqAgMikgTW9kaWZ5IFBDUiBzdGF0ZQo+PiDCoMKg
IDMpIFByb3ZpZGUgZW50cm9weQo+Pgo+PiBUaGlzIHBhdGNoIGFkZHMgYSBkcml2ZXIgZm9yIE5T
TSB0aGF0IGV4cG9zZXMgYSAvZGV2L25zbSBkZXZpY2Ugbm9kZSAKPj4gd2hpY2gKPj4gdXNlciBz
cGFjZSBjYW4gaXNzdWUgYW4gaW9jdGwgb24gdGhpcyBkZXZpY2Ugd2l0aCByYXcgTlNNIENCT1Ig
Zm9ybWF0dGVkCj4+IGNvbW1hbmRzIHRvIHJlcXVlc3QgYXR0ZXN0YXRpb24gZG9jdW1lbnRzLCBp
bmZsdWVuY2UgUENSIHN0YXRlcywgcmVhZAo+PiBlbnRyb3B5IGFuZCBlbnVtZXJhdGUgc3RhdHVz
IG9mIHRoZSBkZXZpY2UuIEluIGFkZGl0aW9uLCB0aGUgZHJpdmVyCj4+IGltcGxlbWVudHMgYSBo
d3JuZyBiYWNrZW5kLgo+Pgo+PiBPcmlnaW5hbGx5LWJ5OiBQZXRyZSBFZnRpbWUgPHBldHJlLmVm
dGltZUBnbWFpbC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBHcmFmIDxncmFmQGFt
YXpvbi5jb20+Cj4+Cj4+IC0tLQo+Cj4gLi4uCj4KPj4gK3N0YXRpYyBpbnQgbnNtX3JuZ19yZWFk
KHN0cnVjdCBod3JuZyAqcm5nLCB2b2lkICpkYXRhLCBzaXplX3QgbWF4LCAKPj4gYm9vbCB3YWl0
KQo+PiArewo+PiArwqDCoMKgwqAgc3RydWN0IG5zbSAqbnNtID0gaHdybmdfdG9fbnNtKHJuZyk7
Cj4+ICvCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmbnNtLT52ZGV2LT5kZXY7Cj4+ICvC
oMKgwqDCoCBzdHJ1Y3QgbnNtX21zZyAqbXNnOwo+PiArwqDCoMKgwqAgaW50IHJjID0gMDsKPj4g
Kwo+PiArwqDCoMKgwqAgLyogTlNNIGFsd2F5cyBuZWVkcyB0byB3YWl0IGZvciBhIHJlc3BvbnNl
ICovCj4+ICvCoMKgwqDCoCBpZiAoIXdhaXQpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIDA7Cj4+ICsKPj4gK8KgwqDCoMKgIG1zZyA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVv
ZigqbXNnKSwgR0ZQX0tFUk5FTCk7Cj4+ICvCoMKgwqDCoCBpZiAoIW1zZykKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsKPgo+IFdoeSB1c2UgZGV2bV8gaGVyZT8g
SXQgaXMgZnJlZWQgaW4gYWxsIGNhc2VzLi4uCgoKWWVzLCBhYnNvbHV0ZWx5LiBMZXQgbWUgY2hh
bmdlIHRoYXQgOikKCgo+Cj4+ICsKPj4gK8KgwqDCoMKgIHJjID0gZmlsbF9yZXFfZ2V0X3JhbmRv
bShuc20sICZtc2ctPnJlcSk7Cj4+ICvCoMKgwqDCoCBpZiAocmMgIT0gMCkKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPj4gKwo+PiArwqDCoMKgwqAgcmMgPSBuc21fc2Vu
ZHJlY3ZfbXNnKG5zbSwgbXNnKTsKPj4gK8KgwqDCoMKgIGlmIChyYyAhPSAwKQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+PiArCj4+ICvCoMKgwqDCoCByYyA9IHBhcnNl
X3Jlc3BfZ2V0X3JhbmRvbShuc20sICZtc2ctPnJlc3AsIGRhdGEsIG1heCk7Cj4+ICvCoMKgwqDC
oCBpZiAocmMgPCAwKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+PiAr
Cj4+ICvCoMKgwqDCoCBkZXZfZGJnKGRldiwgIlJORzogcmV0dXJuaW5nIHJhbmQgYnl0ZXMgPSAl
ZCIsIHJjKTsKPj4gK291dDoKPj4gK8KgwqDCoMKgIGRldm1fa2ZyZWUoZGV2LCBtc2cpOwo+Cj4g
Li4uLCBzbyBrZnJlZSB3b3VsZCBiZSBqdXN0IGZpbmUgYXMgd2VsbC4KPgo+PiArwqDCoMKgwqAg
cmV0dXJuIHJjOwo+PiArfQo+PiArCj4+ICtzdGF0aWMgbG9uZyBuc21fZGV2X2lvY3RsKHN0cnVj
dCBmaWxlICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLAo+PiArwqDCoMKgwqAgdW5zaWduZWQgbG9u
ZyBhcmcpCj4+ICt7Cj4+ICvCoMKgwqDCoCB2b2lkIF9fdXNlciAqYXJncCA9IHU2NF90b191c2Vy
X3B0cigodTY0KWFyZyk7Cj4+ICvCoMKgwqDCoCBzdHJ1Y3QgbnNtICpuc20gPSBmaWxlX3RvX25z
bShmaWxlKTsKPj4gK8KgwqDCoMKgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZuc20tPnZkZXYtPmRl
djsKPj4gK8KgwqDCoMKgIHN0cnVjdCBuc21fbXNnICptc2c7Cj4+ICvCoMKgwqDCoCBzdHJ1Y3Qg
bnNtX3JhdyByYXc7Cj4+ICvCoMKgwqDCoCBpbnQgciA9IDA7Cj4+ICsKPj4gK8KgwqDCoMKgIGlm
IChjbWQgIT0gTlNNX0lPQ1RMX1JBVykKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gLUVJTlZBTDsKPj4gKwo+PiArwqDCoMKgwqAgaWYgKF9JT0NfU0laRShjbWQpICE9IHNpemVv
ZihyYXcpKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+PiAr
Cj4+ICvCoMKgwqDCoCAvKiBBbGxvY2F0ZSBtZXNzYWdlIGJ1ZmZlcnMgdG8gZGV2aWNlICovCj4+
ICvCoMKgwqDCoCByID0gLUVOT01FTTsKPj4gK8KgwqDCoMKgIG1zZyA9IGRldm1fa3phbGxvYyhk
ZXYsIHNpemVvZigqbXNnKSwgR0ZQX0tFUk5FTCk7Cj4KPiBXaHkgdXNlIGRldm1fIGhlcmU/IEl0
IGlzIGZyZWVkIGluIGFsbCBjYXNlcy4uLgo+Cj4+ICvCoMKgwqDCoCBpZiAoIW1zZykKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPj4gKwo+PiArwqDCoMKgwqAgLyogQ29w
eSB1c2VyIGFyZ3VtZW50IHN0cnVjdCB0byBrZXJuZWwgYXJndW1lbnQgc3RydWN0ICovCj4+ICvC
oMKgwqDCoCByID0gLUVGQVVMVDsKPj4gK8KgwqDCoMKgIGlmIChjb3B5X2Zyb21fdXNlcigmcmF3
LCBhcmdwLCBfSU9DX1NJWkUoY21kKSkpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290
byBvdXQ7Cj4+ICsKPj4gK8KgwqDCoMKgIC8qIENvbnZlcnQga2VybmVsIGFyZ3VtZW50IHN0cnVj
dCB0byBkZXZpY2UgcmVxdWVzdCAqLwo+PiArwqDCoMKgwqAgciA9IGZpbGxfcmVxX3Jhdyhuc20s
ICZtc2ctPnJlcSwgJnJhdyk7Cj4+ICvCoMKgwqDCoCBpZiAocikKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBnb3RvIG91dDsKPj4gKwo+PiArwqDCoMKgwqAgLyogU2VuZCBtZXNzYWdlIHRv
IE5TTSBhbmQgcmVhZCByZXBseSAqLwo+PiArwqDCoMKgwqAgciA9IG5zbV9zZW5kcmVjdl9tc2co
bnNtLCBtc2cpOwo+PiArwqDCoMKgwqAgaWYgKHIpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZ290byBvdXQ7Cj4+ICsKPj4gK8KgwqDCoMKgIC8qIFBhcnNlIGRldmljZSByZXNwb25zZSBp
bnRvIGtlcm5lbCBhcmd1bWVudCBzdHJ1Y3QgKi8KPj4gK8KgwqDCoMKgIHIgPSBwYXJzZV9yZXNw
X3Jhdyhuc20sICZtc2ctPnJlc3AsICZyYXcpOwo+PiArwqDCoMKgwqAgaWYgKHIpCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4+ICsKPj4gK8KgwqDCoMKgIC8qIENvcHkg
a2VybmVsIGFyZ3VtZW50IHN0cnVjdCBiYWNrIHRvIHVzZXIgYXJndW1lbnQgc3RydWN0ICovCj4+
ICvCoMKgwqDCoCByID0gLUVGQVVMVDsKPj4gK8KgwqDCoMKgIGlmIChjb3B5X3RvX3VzZXIoYXJn
cCwgJnJhdywgc2l6ZW9mKHJhdykpKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8g
b3V0Owo+PiArCj4+ICvCoMKgwqDCoCByID0gMDsKPj4gKwo+PiArb3V0Ogo+PiArwqDCoMKgwqAg
ZGV2bV9rZnJlZShkZXYsIG1zZyk7Cj4KPiAuLi4sIHNvIGtmcmVlIHdvdWxkIGJlIGp1c3QgZmlu
ZSBhcyB3ZWxsLgo+Cj4+ICvCoMKgwqDCoCByZXR1cm4gcjsKPj4gK30KPgo+IC4uLgo+Cj4+ICsv
KiBIYW5kbGVyIGZvciBwcm9iaW5nIHRoZSBOU00gZGV2aWNlICovCj4+ICtzdGF0aWMgaW50IG5z
bV9kZXZpY2VfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+ICt7Cj4+ICvCoMKg
wqDCoCBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmdmRldi0+ZGV2Owo+PiArwqDCoMKgwqAgc3RydWN0
IG5zbSAqbnNtOwo+PiArwqDCoMKgwqAgaW50IHJjOwo+PiArCj4+ICvCoMKgwqDCoCBuc20gPSBk
ZXZtX2t6YWxsb2MoJnZkZXYtPmRldiwgc2l6ZW9mKCpuc20pLCBHRlBfS0VSTkVMKTsKPj4gK8Kg
wqDCoMKgIGlmICghbnNtKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5P
TUVNOwo+PiArCj4+ICvCoMKgwqDCoCB2ZGV2LT5wcml2ID0gbnNtOwo+PiArwqDCoMKgwqAgbnNt
LT52ZGV2ID0gdmRldjsKPj4gKwo+PiArwqDCoMKgwqAgcmMgPSBuc21fZGV2aWNlX2luaXRfdnEo
dmRldik7Cj4+ICvCoMKgwqDCoCBpZiAocmMpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkZXZfZXJyKGRldiwgInF1ZXVlIGZhaWxlZCB0byBpbml0aWFsaXplOiAlZC5cbiIsIHJjKTsK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9pbml0X3ZxOwo+PiArwqDCoMKg
wqAgfQo+PiArCj4+ICvCoMKgwqDCoCBtdXRleF9pbml0KCZuc20tPmxvY2spOwo+PiArwqDCoMKg
wqAgaW5pdF93YWl0cXVldWVfaGVhZCgmbnNtLT53cSk7Cj4+ICsKPj4gK8KgwqDCoMKgIC8qIFJl
Z2lzdGVyIGFzIGh3cm5nIHByb3ZpZGVyICovCj4+ICvCoMKgwqDCoCBuc20tPmh3cm5nID0gKHN0
cnVjdCBod3JuZykgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5yZWFkID0gbnNtX3Ju
Z19yZWFkLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5uYW1lID0gIm5zbS1od3JuZyIs
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnF1YWxpdHkgPSAxMDAwLAo+PiArwqDCoMKg
wqAgfTsKPj4gKwo+PiArwqDCoMKgwqAgcmMgPSBkZXZtX2h3cm5nX3JlZ2lzdGVyKCZ2ZGV2LT5k
ZXYsICZuc20tPmh3cm5nKTsKPj4gK8KgwqDCoMKgIGlmIChyYykgewo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGRldl9lcnIoZGV2LCAiUk5HIGluaXRpYWxpemF0aW9uIGVycm9yOiAlZC5c
biIsIHJjKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9od3JuZzsKPj4g
K8KgwqDCoMKgIH0KPj4gKwo+PiArwqDCoMKgwqAgLyogUmVnaXN0ZXIgL2Rldi9uc20gZGV2aWNl
IG5vZGUgKi8KPj4gK8KgwqDCoMKgIG5zbS0+bWlzYyA9IChzdHJ1Y3QgbWlzY2RldmljZSkgewo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5taW5vcsKgID0gTUlTQ19EWU5BTUlDX01JTk9S
LAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5uYW1lwqDCoCA9ICJuc20iLAo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5mb3BzwqDCoCA9ICZuc21fZGV2X2ZvcHMsCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLm1vZGXCoMKgID0gMDY2NiwKPj4gK8KgwqDCoMKgIH07Cj4+
ICsKPj4gK8KgwqDCoMKgIHJjID0gbWlzY19yZWdpc3RlcigmbnNtLT5taXNjKTsKPj4gK8KgwqDC
oMKgIGlmIChyYykgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoZGV2LCAi
bWlzYyBkZXZpY2UgcmVnaXN0cmF0aW9uIGVycm9yOiAlZC5cbiIsIHJjKTsKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9taXNjOwo+PiArwqDCoMKgwqAgfQo+PiArCj4+ICvC
oMKgwqDCoCByZXR1cm4gMDsKPj4gKwo+PiArZXJyX21pc2M6Cj4+ICvCoMKgwqDCoCBod3JuZ191
bnJlZ2lzdGVyKCZuc20tPmh3cm5nKTsKPgo+IElzIGl0IG5lZWRlZD8gZGV2bV9od3JuZ19yZWdp
c3RlcigpIGlzIHVzZWQuCgoKSSdtIGFmcmFpZCBJIGNhbid0IC8gc2hvdWxkbid0IHVzZSBkZXZt
X2h3cm5nX3JlZ2lzdGVyKCkgaGVyZS4gSSBuZWVkIHRvIApjbGVhbiB1cCB0aGUgdnEgcG9pbnRl
ciBpbiB0aGUgcmVtb3ZlIGZ1bmN0aW9uIHdoaWNoIEkgdGhpbmsgbWF5IHJhY2UgCmR1cmluZyBy
ZW1vdmFsLiBJIHJlYWxseSBkb24ndCB3YW50IHRvIGhhdmUgaHdybmcgY2FsbCB0aGUgZHJpdmVy
IGNvZGUgCndoaWxlIHdlJ3ZlIGFscmVhZHkgZGVzdHJveWVkIHRoZSB2cXMuCgpTbyBJJ2xsIGNo
YW5nZSBpdCB0byBub24tZGV2bSBjYWxscy4KCgo+Cj4+ICtlcnJfaHdybmc6Cj4+ICvCoMKgwqDC
oCB2ZGV2LT5jb25maWctPmRlbF92cXModmRldik7Cj4+ICtlcnJfaW5pdF92cToKPj4gK8KgwqDC
oMKgIGtmcmVlKG5zbSk7Cj4KPiAnbnNtJyBpcyBkZXZtX2t6YWxsb2MoKSdlZCwgc28gdGhpcyBp
cyBhIGRvdWJsZSBmcmVlLgoKClRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcyEKCgo+Cj4+ICvCoMKg
wqDCoCByZXR1cm4gcmM7Cj4+ICt9Cj4+ICsKPj4gKy8qIEhhbmRsZXIgZm9yIHJlbW92aW5nIHRo
ZSBOU00gZGV2aWNlICovCj4+ICtzdGF0aWMgdm9pZCBuc21fZGV2aWNlX3JlbW92ZShzdHJ1Y3Qg
dmlydGlvX2RldmljZSAqdmRldikKPj4gK3sKPj4gK8KgwqDCoMKgIHN0cnVjdCBuc20gKm5zbSA9
IHZkZXYtPnByaXY7Cj4+ICsKPj4gK8KgwqDCoMKgIGh3cm5nX3VucmVnaXN0ZXIoJm5zbS0+aHdy
bmcpOwo+Cj4gSXMgaXQgbmVlZGVkPyBkZXZtX2h3cm5nX3JlZ2lzdGVyKCkgaXMgdXNlZC4KPgo+
PiArCj4+ICvCoMKgwqDCoCB2ZGV2LT5jb25maWctPmRlbF92cXModmRldik7Cj4+ICvCoMKgwqDC
oCBtaXNjX2RlcmVnaXN0ZXIoJm5zbS0+bWlzYyk7Cj4+ICvCoMKgwqDCoCBsaXN0X2RlbCgmbnNt
LT5ub2RlKTsKPgo+IFdoZW4gaXMgaXQgbGlzdF9hZGQoKSdlZD8KPiBUaGUgJ25vZGUnIGZpZWxk
IHNlZW1zIHVudXNlZC4KCgpUaGlzIGlzIGEgbGVmdG92ZXIgZnJvbSBvbGQgY29kZSwgcmVtb3Zl
ZC4gVGhhbmtzIGZvciBjYXRjaGluZyBpdCEKCgpBbGV4CgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQg
Q2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0
c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdl
biBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejog
QmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

