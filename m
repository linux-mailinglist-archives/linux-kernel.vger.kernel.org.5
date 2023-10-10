Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A047BF54E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346694AbjJJIJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjJJIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:09:31 -0400
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F17E0;
        Tue, 10 Oct 2023 01:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696925367; x=1728461367;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4EmhsOwP69F//6433Xn4ERWpOgRb07iso5k41/IoZyU=;
  b=lbzyHFXL72Vh3/lW0FsQBpOFc8noynr9mM4kEt+4P+RjNiO+qv6vemtN
   IDFzjRznPQdMOsXipq7g3RhVfMrSeeuxo+4jkKRdejDMUPv3XI9E9iqPY
   rlG3PK62W95tsNV5KElbi7PXCuHRXNlmKKsJoTwbaJiHDusDm1ihUAph1
   M=;
X-IronPort-AV: E=Sophos;i="6.03,212,1694736000"; 
   d="scan'208";a="676722895"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 08:09:22 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 07D3960ACE;
        Tue, 10 Oct 2023 08:09:20 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 08:09:20 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 10 Oct
 2023 08:09:16 +0000
Message-ID: <b3a8c722-c0e2-4c8c-aef0-29af0a93572d@amazon.com>
Date:   Tue, 10 Oct 2023 10:08:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] Import CBOR library
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Olivia Mackall" <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        "Erdem Meydanlli" <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Kyunghwan Kwon <k@mononn.com>
References: <20231009212053.2007-1-graf@amazon.com>
 <20231009212053.2007-2-graf@amazon.com>
 <2023101010-overwrite-parakeet-91d5@gregkh>
 <0ee221bc-ea99-4724-9ebd-436e91417e4b@amazon.com>
 <2023101009-accustom-manifesto-8bdb@gregkh>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <2023101009-accustom-manifesto-8bdb@gregkh>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDEwLjEwLjIzIDEwOjAzLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6Cj4KPiBPbiBUdWUs
IE9jdCAxMCwgMjAyMyBhdCAwOTo1NToyNUFNICswMjAwLCBBbGV4YW5kZXIgR3JhZiB3cm90ZToK
Pj4gSGV5IEdyZWcsCj4+Cj4+IE9uIDEwLjEwLjIzIDA4OjEzLCBHcmVnIEtyb2FoLUhhcnRtYW4g
d3JvdGU6Cj4+PiBPbiBNb24sIE9jdCAwOSwgMjAyMyBhdCAwOToyMDo1MlBNICswMDAwLCBBbGV4
YW5kZXIgR3JhZiB3cm90ZToKPj4+PiBUbyBmdWxseSBzdXBwb3J0IHRoZSBOaXRybyBTZWN1cmUg
TW9kdWxlIGNvbW11bmljYXRpb24gcHJvdG9jb2wsIHdlIG5lZWQKPj4+PiB0byBlbmNvZGUgYW5k
IGRlY29kZSBDQk9SIGJpbmFyeSBkYXRhLiBJbXBvcnQgYW4gTUlUIGxpY2Vuc2VkIGxpYnJhcnkK
Pj4+PiBmcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9saWJtY3UvY2JvciAoY29tbWl0IGYzZDE2OTZm
ODg2KSBzbyB0aGF0IHdlIGNhbgo+Pj4+IGVhc2lseSBjb25zdW1lIENCT1IgZGF0YS4KPj4+IFdo
YXQgaXMgIkNCT1IiPyAgSSBkb24ndCBzZWUgYSBkZXNjcmlwdGlvbiBvZiBpdCBoZXJlLgo+Pgo+
PiBDQk9SIGlzIHRoZSAiQ29uY2lzZSBCaW5hcnkgT2JqZWN0IFJlcHJlc2VudGF0aW9uIgo+PiAo
aHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvQ0JPUikgYmluYXJ5IGZvcm1hdC4KPj4KPj4K
Pj4+IEFuZCBJIGd1ZXNzIHlvdSBhcmUgZ29pbmcgdG8ga2VlcCB0aGlzIGluIHN5bmMgd2l0aCB1
cHN0cmVhbT8gIE9yIGRvIHlvdQo+Pj4gcmVhbGx5IG5lZWQgdGhlIGZ1bGwgbGlicmFyeSBoZXJl
ICh5b3UgI2lmZGVmIHRoZSBmbG9hdCBzdHVmZiBvdXQpLCBkb2VzCj4+PiB5b3VyIG1vZHVsZSBy
ZWFsbHkgbmVlZCBhbGwgb2YgdGhlIGZ1bmN0aW9uYWxpdHkgYW5kIGNvbXBsZXhpdHkgb2YgdGhp
cwo+Pj4gbGlicmFyeSwgb3IgY2FuIGl0IHVzZSBqdXN0IGEgbXVjaCBzbWFsbGVyIG9uZSBpbnN0
ZWFkPwo+Pgo+PiBDQk9SIGtub3dzIGEgdG90YWwgb2YgOSBkYXRhIHR5cGVzOgo+Pgo+PiAgICAt
IFVuc2lnbmVkIGludGVnZXJzCj4+ICAgIC0gU2lnbmVkIGludGVnZXJzCj4+ICAgIC0gQmluYXJ5
IHN0cmluZwo+PiAgICAtIFVURi04IHN0cmluZwo+PiAgICAtIEFycmF5cwo+PiAgICAtIE1hcHMg
KGxpa2UgYSBweXRob24gZGljdGlvbmFyeSkKPj4gICAgLSBTZW1hbnRpYyB0YWcKPj4gICAgLSBC
b29scwo+PiAgICAtIEZsb2F0cwo+Pgo+PiBPdXQgb2YgdGhlc2UsIHRoZSBOU00gY29tbXVuaWNh
dGlvbiBwcm90b2NvbCB1c2VzIGFsbCBleGNlcHQgU2VtYW50aWMgdGFncwo+PiBhbmQgRmxvYXRz
LiBUaGUgQ0JPUiBsaWJyYXJ5IHRoYXQgdGhpcyBwYXRjaCBpbXBvcnRzIGRvZXMgbm90IGhhdmUg
c3BlY2lhbAo+PiBoYW5kbGluZyBmb3IgU2VtYW50aWMgdGFncywgd2hpY2ggbGVhdmVzIG9ubHkg
ZmxvYXRzIHdoaWNoIGFyZSBhbHJlYWR5Cj4+ICNpZmRlZidlZCBvdXQuIFRoYXQgbWVhbnMgdGhl
cmUgaXMgbm90IG11Y2ggdG8gdHJpbS4KPj4KPj4gV2hhdCB5b3Ugc2VlIGhlcmUgaXMgd2hhdCdz
IG5lZWRlZCB0byBwYXJzZSBDQk9SIGluIGtlcm5lbCAtIGlmIHRoYXQncyB3aGF0Cj4+IHdlIHdh
bnQgdG8gZG8uIEknbSBoYXBweSB0byByaXAgaXQgb3V0IGFnYWluIGFuZCBtYWtlIGl0IGEgcHVy
ZSB1c2VyIHNwYWNlCj4+IHByb2JsZW0gdG8gZG8gQ0JPUiA6KS4KPiBZZXMsIHdoeSBhcmUgd2Ug
cGFyc2luZyB0aGlzIGluIHRoZSBrZXJuZWw/ICBXaGF0IGNvdWxkIGdvIHdyb25nIHdpdGgKPiBh
ZGRpbmcgeWV0LWFub3RoZXItcGFyc2VyIGluIHByaXZpbGVnZWQgY29udGV4dD8gIDopCj4KPiBX
aHkgZG9lcyB0aGlzIGhhdmUgdG8gYmUgaW4gdGhlIGtlcm5lbCwgdGhlIGRhdGEgc2VudC9yZWNp
ZXZlZCBpcyBvdmVyCj4gdmlydGlvLCBzbyB3aHkgZG9lcyB0aGUga2VybmVsIGhhdmUgdG8gcGFy
c2UgaXQ/ICBJIGNvdWxkbid0IGZpZ3VyZSB0aGF0Cj4gb3V0IGZyb20gdGhlIGRyaXZlciwgeWV0
IHRoZSBkcml2ZXIgc2VlbXMgdG8gaGF2ZSBhIGxvdCBvZiBoYXJkLWNvZGVkCj4gcGFyc2luZyBs
b2dpYyBpbiBpdCB0byBhc3N1bWUgc3BlY2lmaWMgbWVzc2FnZSBmb3JtYXRzPwoKClRoZSBwYXJz
aW5nIGRvZXNuJ3QgaGF2ZSB0byBiZSBpbiBrZXJuZWwgYW5kIGl0IHByb2JhYmx5IHNob3VsZG4n
dCBiZSAKZWl0aGVyLiBWMyBvZiB0aGUgcGF0Y2ggd2FzIHB1bnRpbmcgYWxsIHRoZSBwYXJzaW5n
IHRvIHVzZXIgc3BhY2UsIGF0IAp3aGljaCBwb2ludCB5b3UgYW5kIEFybmQgc2FpZCBJIHNob3Vs
ZCBnaXZlIGl0IGEgdHJ5IHRvIGRvIHRoZSBwcm90b2NvbCAKcGFyc2luZyBpbiBrZXJuZWwgc3Bh
Y2UgaW5zdGVhZC4gVGhhdCdzIHdoeSB0aGUgcGFyc2VyIGlzIGhlcmUuCgpJZiB3ZSBjb25jbHVk
ZSB0aGF0IGFsbCB0aGlzIGluLWtlcm5lbCBwYXJzaW5nIGlzIG5vdCB3b3J0aCBpdCwgSSdtIHZl
cnkgCmhhcHB5IHRvIGp1c3QgZ28gYmFjayB0byB0aGUgdGhlIHYzIGlvY3RsIGludGVyZmFjZSBh
bmQgcG9zdCB2NSB3aXRoIApod3JuZyBtZXJnZWQgaW50byBtaXNjLCBidXQgcmVtb3ZlIGFsbCBD
Qk9SIGxvZ2ljIGFnYWluIDopCgoKQWxleAoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBH
ZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVu
ZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10
c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpV
c3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

