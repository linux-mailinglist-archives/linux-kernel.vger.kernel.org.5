Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D5D7B532F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbjJBM2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbjJBM2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:28:42 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB8EFA;
        Mon,  2 Oct 2023 05:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696249715; x=1727785715;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XHudESUk0+r+xywgpWNySwL1BLzsNkPXOyp2CaffniM=;
  b=i/TjFXX2Nq5Cd1ocx1Oft69WP57R1C+0MldBrZ+j6QqTeHHfjquhK/Mu
   bfEhm3R0AEVKX9KBk5xFBPiQXhQwYuvj3zZ2RGCMw7lsKZ5rxuetcWxAW
   x3UW93nU2D2BwUNcWY9kx9wUNuMYV9fe1pk87Ak42Cg3058HrWXHLpJj5
   I=;
X-IronPort-AV: E=Sophos;i="6.03,194,1694736000"; 
   d="scan'208";a="354387822"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 12:28:31 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id E053DA09B9;
        Mon,  2 Oct 2023 12:28:29 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 2 Oct 2023 12:28:29 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 2 Oct
 2023 12:28:26 +0000
Message-ID: <8fee7a04-cee2-4b99-8ec5-63af940c3198@amazon.com>
Date:   Mon, 2 Oct 2023 14:28:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] misc: Add Nitro Secure Module driver
Content-Language: en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230929133320.74848-1-graf@amazon.com>
 <20230929133320.74848-2-graf@amazon.com>
 <74b2d869-0d96-46f9-a180-b405992e6c51@app.fastmail.com>
 <a44a2df0-beb9-4a43-ade4-267ad819729e@amazon.com>
 <2023093054-swimming-whoopee-7ef8@gregkh>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <2023093054-swimming-whoopee-7ef8@gregkh>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IEdyZWcsCgpPbiAzMC4wOS4yMyAwODoyMCwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOgo+
IE9uIEZyaSwgU2VwIDI5LCAyMDIzIGF0IDA5OjI2OjE2UE0gKzAyMDAsIEFsZXhhbmRlciBHcmFm
IHdyb3RlOgo+PiBIaSBBcm5kIQo+Pgo+PiBPbiAyOS4wOS4yMyAxOToyOCwgQXJuZCBCZXJnbWFu
biB3cm90ZToKPj4+IE9uIEZyaSwgU2VwIDI5LCAyMDIzLCBhdCAwOTozMywgQWxleGFuZGVyIEdy
YWYgd3JvdGU6Cj4+Pj4gV2hlbiBydW5uaW5nIExpbnV4IGluc2lkZSBhIE5pdHJvIEVuY2xhdmUs
IHRoZSBoeXBlcnZpc29yIHByb3ZpZGVzIGEKPj4+PiBzcGVjaWFsIHZpcnRpbyBkZXZpY2UgY2Fs
bGVkICJOU00iLiBUaGlzIGRldmljZSBoYXMgMiBtYWluIGZ1bmN0aW9uczoKPj4+Pgo+Pj4+ICAg
ICAxKSBQcm92aWRlIGF0dGVzdGF0aW9uIHJlcG9ydHMKPj4+PiAgICAgMikgTW9kaWZ5IFBDUiBz
dGF0ZQo+Pj4+ICAgICAzKSBQcm92aWRlIGVudHJvcHkKPj4+Pgo+Pj4+IFRoaXMgcGF0Y2ggYWRk
cyB0aGUgY29yZSBOU00gZHJpdmVyIHRoYXQgZXhwb3NlcyBhIC9kZXYvbnNtIGRldmljZSBub2Rl
Cj4+Pj4gd2hpY2ggdXNlciBzcGFjZSBjYW4gdXNlIHRvIHJlcXVlc3QgYXR0ZXN0YXRpb24gZG9j
dW1lbnRzIGFuZCBpbmZsdWVuY2UKPj4+PiBQQ1Igc3RhdGVzLiBBIGZvbGxvdyB1cCBwYXRjaCB3
aWxsIGFkZCBhIGh3cm5nIGRyaXZlciB0byBmZWVkIGl0cyBlbnRyb3B5Cj4+Pj4gaW50byB0aGUg
a2VybmVsLgo+Pj4+Cj4+Pj4gT3JpZ2luYWxseS1ieTogUGV0cmUgRWZ0aW1lIDxwZXRyZS5lZnRp
bWVAZ21haWwuY29tPgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBHcmFmIDxncmFmQGFt
YXpvbi5jb20+Cj4+PiBIaSBBbGV4LAo+Pj4KPj4+IEkndmUgdGFrZW4gYSBmaXJzdCBsb29rIGF0
IHRoaXMgZHJpdmVyIGFuZCBoYXZlIHNvbWUgbWlub3IgY29tbWVudHMuCj4+Cj4+IFRoYW5rcyBh
IGJ1bmNoIQo+Pgo+Pgo+Pj4gVGhlIG1haW4gcG9pbnQgaGVyZSBpcyB0aGF0IEkgdGhpbmsgd2Ug
bmVlZCB0byBsb29rIGF0IHBvc3NpYmxlCj4+PiBhbHRlcm5hdGl2ZXMgZm9yIHRoZSB1c2VyIHNw
YWNlIGludGVyZmFjZSwgYW5kIChpZiBwb3NzaWJsZSkgY2hhbmdlCj4+PiB0byBhIHNldCBvZiBo
aWdoZXItbGV2ZWwgaW9jdGwgY29tbWFuZHMgZnJvbSB0aGUgc2ltcGxlIHBhc3N0aHJvdWdoLgo+
Pgo+PiBJJ20gc2xpZ2h0bHkgdG9ybiBvbiB0aGF0IGJpdC4gSSB0aGluayBpbiBoaW5kc2lnaHQg
dGhlIE5TTSBkZXZpY2UgcHJvYmFibHkKPj4gc2hvdWxkIGhhdmUgYmVlbiBhIHJlc2VydmVkIHZz
b2NrIENJRCBhbmQgdGhlIGh3cm5nIG9uZSBzaG91bGQgaGF2ZSBqdXN0Cj4+IGJlZW4gdmlydGlv
LXJuZy4KPj4KPj4gVGhlIHByb2JsZW0gaXMgdGhhdCBOaXRybyBFbmNsYXZlcyB3ZXJlIGxhdW5j
aGVkIGluIDIwMjAgYW5kIHNpbmNlIGFuCj4+IGVjb3N5c3RlbSBkZXZlbG9wZWQgaW4gbXVsdGlw
bGUgbGFuZ3VhZ2VzIHRvIHN1cHBvcnQgYnVpbGRpbmcgY29kZSBpbnNpZGU6Cj4+Cj4+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9hd3MvYXdzLW5pdHJvLWVuY2xhdmVzLW5zbS1hcGkvYmxvYi9tYWluL3Ny
Yy9kcml2ZXIvbW9kLnJzI0w2Ngo+PiBodHRwczovL2dpdGh1Yi5jb20vZG9ua2Vyc2dvZWQvYXdz
LW5zbS1pbnRlcmZhY2UvYmxvYi9tYWluL2F3c19uc21faW50ZXJmYWNlL19faW5pdF9fLnB5I0wy
NjQtTDI3NAo+PiAgICBodHRwczovL2dpdGh1Yi5jb20vaGYvbnNtL2Jsb2IvbWFpbi9uc20uZ28j
TDk5LUwxMjkKPj4KPj4KPj4gQWxsIG9mIHRoZXNlIHVzZSB0aGUgKGRvd25zdHJlYW0pIGlvY3Rs
IHRoYXQgdGhpcyBwYXRjaCBhbHNvIGltcGxlbWVudHMuIFdlCj4+IGNvdWxkIGNoYW5nZSBpdCwg
YnV0IGluc3RlYWQgb2YgbWFraW5nIGl0IGVhc2llciBmb3IgdXNlciBzcGFjZSB0byBhZGFwdCB0
aGUKPj4gZGV2aWNlIG5vZGUsIGl0IHdvdWxkIHByb2JhYmx5IGh1cnQgbW9yZS4KPj4KPj4gSSBh
Z3JlZSB0aGF0IHRoaXMgaXMgbm90IGEgZ3JlYXQgcGxhY2UgdG8gYmUgaW4uIFRoaXMgZHJpdmVy
IGFic29sdXRlbHkKPj4gc2hvdWxkIGhhdmUgYmVlbiB1cHN0cmVhbWVkIDMgeWVhcnMgYWdvLiBC
dXQgSSBjYW4ndCB0dXJuIGJhY2sgdGltZSAoeWV0KQo+PiA6KS4KPiBBcyB5b3Uga25vdywgdGhp
cyBpcyBubyBleGN1c2UgdG8gcHV0IGFuIGFwaSBpbiB0aGUga2VybmVsIHRoYXQgaXNuJ3QKPiBj
b3JyZWN0IG9yIGdvb2QgZm9yIHRoZSBsb25nLXRlcm0uICBKdXN0IGJlY2F1c2UgcGVvcGxlIGRv
IGZvb2xpc2gKPiB0aGluZ3Mgb3V0c2lkZSBvZiB0aGUga2VybmVsIHRyZWUgbmV2ZXIgbWVhbnMg
d2UgaGF2ZSB0byBhY2NlcHQgdGhlbSBpbgo+IG91ciB0cmVlLiAgSW5zdGVhZCB3ZSBjYW4gYXNr
IHRoZW0gdG8gZml4IHRoZW0gcHJvcGVybHkgYXMgcGFydCBvZiB1cwo+IHRha2luZyB0aGUgY29k
ZS4KPgo+IFNvIHBsZWFzZSwgd29yayBvbiBkb2luZyB0aGlzIHJpZ2h0LgoKClNvcnJ5IGlmIG15
IG1lc3NhZ2UgYWJvdmUgY2FtZSBvdmVyIGFzIGEgcHVzaCB0byBwdXQgYW4gImluY29ycmVjdCBh
cGkiIAppbnRvIHRoZSBrZXJuZWwuCgpJbiBzaXR1YXRpb25zIGxpa2UgdGhpcyB3aGVyZSB5b3Ug
Y2FuIGVpdGhlciBnaXZlIHVzZXIgc3BhY2UgZnVsbCBhY2Nlc3MgCnRvIHRoZSBkZXZpY2UncyBj
b21tYW5kIHNwYWNlIHRocm91Z2ggYSBnZW5lcmljIEFQSSBvciB5b3UgY2FuIGNyZWF0ZSAKY29t
bWFuZCBhd2FyZW5lc3MgaW4gdGhlIGtlcm5lbCBhbmQgbWFrZSBpdCB0aGUga2VybmVsJ3MgdGFz
ayB0byBsZWFybiAKYWJvdXQgZWFjaCBjb21tYW5kLCBJTUhPIGl0J3MgbmV2ZXIgYSBjbGVhciBj
dXQgb24gd2hpY2ggb25lIGlzIGJldHRlci4gCkVzcGVjaWFsbHkgaW4gdmlydHVhbCBlbnZpcm9u
bWVudHMgd2hlcmUgdGhlIHNldCBvZiBjb21tYW5kcyBjYW4gY2hhbmdlIApxdWlja2x5IG92ZXIg
dGltZS4KClNvIHdoYXQgSSB3YXMgdHJ5aW5nIHRvIHNheSBhYm92ZSBpcyB0aGF0ICppZiogd2Ug
Y29uc2lkZXIgYm90aCBwYXRocyAKZXF1YWxseSB2aWFibGUsIEknZCBlcnIgb24gdGhlIG9uZSB0
aGF0IGVuYWJsZXMgdGhlIGV4aXN0aW5nIGVjb3N5c3RlbS4gCkhvd2V2ZXIgaWYgdGhlcmUgYXJl
IGdvb2QgcmVhc29ucyB0byBub3QgZG8gY29tbWFuZCBwYXNzLXRocm91Z2gsIEknbSAKYWxsIGZv
ciBhYnN0cmFjdGluZyBpdCBhd2F5IDopCgpMb29raW5nIGF0IHByaW9yIGFydCwgdGhlIG1vc3Qg
c2ltaWxhciBpbXBsZW1lbnRhdGlvbnMgdG8gdGhpcyBhcmUgVFBNcyAKYW5kIHZpcnRpby12c29j
ay4gV2l0aCB2aXJ0aW8tdnNvY2ssIGtlcm5lbCBzcGFjZSBoYXMgbm8gaWRlYSB3aGF0IGl0IAp0
YWxrcyB0byBvbiB0aGUgb3RoZXIgaGFuZCBhbmQgbWFrZXMgaXQgMTAwJSB1c2VyIHNwYWNlJ3Mg
cHJvYmxlbS4gV2l0aCAKVFBNcywgeW91IHR5cGljYWxseSB1c2UgL2Rldi90cG0wIHRvIGdhaW4g
cmF3IGNvbW1hbmQgYWNjZXNzIHRvIHRoZSAKdGFyZ2V0IGRldmljZS4gU28gd2hpbGUgd2UgY291
bGQgZW5naW5lZXIgc29tZXRoaW5nIHNtYXJ0ZXIgaGVyZSwgSSdtIApub3QgY29udmluY2VkIHll
dCBpdCdzIGEgbmV0IHdpbi4KCgpBbGV4CgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdl
cm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5n
OiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRz
Z2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVz
dC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

