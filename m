Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C457B30CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjI2KpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjI2KpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:45:15 -0400
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98313F9;
        Fri, 29 Sep 2023 03:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695984311; x=1727520311;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FY4+uwILG++fulADx59B41wzoeVUtcBbdGx5sYnpP9w=;
  b=iwpbPczeietjjPs24iFrMwDRjW648EhBBCuddVQh1J3rtXyYRu81Pihx
   k1+zrQYD2QRzvHH3xyK5FmkFo+6bSL1dWI7U4W04+KvHzp30gI/8ixsLV
   eNB+YgFps9ijdUjsNi1g07JIY3bL6ZTZ9yuP36ioTUF2v1DxZqB6QRs8e
   M=;
X-IronPort-AV: E=Sophos;i="6.03,187,1694736000"; 
   d="scan'208";a="586353328"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 10:45:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com (Postfix) with ESMTPS id 69F83A526F;
        Fri, 29 Sep 2023 10:45:05 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 10:44:54 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 29 Sep
 2023 10:44:51 +0000
Message-ID: <2ef7c657-eb7e-499e-9265-56fa57ccd86f@amazon.com>
Date:   Fri, 29 Sep 2023 12:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] misc: Add Nitro Secure Module driver
Content-Language: en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Olivia Mackall" <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        "Erdem Meydanlli" <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230928224645.19768-1-graf@amazon.com>
 <20230928224645.19768-2-graf@amazon.com>
 <2023092906-strangle-pawing-16e2@gregkh>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <2023092906-strangle-pawing-16e2@gregkh>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IEdyZWcsCgpPbiAyOS4wOS4yMyAwNzo0NCwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOgo+
Cj4gT24gVGh1LCBTZXAgMjgsIDIwMjMgYXQgMTA6NDY6NDRQTSArMDAwMCwgQWxleGFuZGVyIEdy
YWYgd3JvdGU6Cj4+IFdoZW4gcnVubmluZyBMaW51eCBpbnNpZGUgYSBOaXRybyBFbmNsYXZlLCB0
aGUgaHlwZXJ2aXNvciBwcm92aWRlcyBhCj4+IHNwZWNpYWwgdmlydGlvIGRldmljZSBjYWxsZWQg
Ik5TTSIuIFRoaXMgZGV2aWNlIGhhcyAyIG1haW4gZnVuY3Rpb25zOgo+Pgo+PiAgICAxKSBQcm92
aWRlIGF0dGVzdGF0aW9uIHJlcG9ydHMKPj4gICAgMikgTW9kaWZ5IFBDUiBzdGF0ZQo+PiAgICAz
KSBQcm92aWRlIGVudHJvcHkKPj4KPj4gVGhpcyBwYXRjaCBhZGRzIHRoZSBjb3JlIE5TTSBkcml2
ZXIgdGhhdCBleHBvc2VzIGEgL2Rldi9uc20gZGV2aWNlIG5vZGUKPj4gd2hpY2ggdXNlciBzcGFj
ZSBjYW4gdXNlIHRvIHJlcXVlc3QgYXR0ZXN0YXRpb24gZG9jdW1lbnRzIGFuZCBpbmZsdWVuY2UK
Pj4gUENSIHN0YXRlcy4gQSBmb2xsb3cgdXAgcGF0Y2ggd2lsbCBhZGQgYSBod3JuZyBkcml2ZXIg
dG8gZmVlZCBpdHMgZW50cm9weQo+PiBpbnRvIHRoZSBrZXJuZWwuCj4+Cj4+IE9yaWdpbmFsbHkt
Ynk6IFBldHJlIEVmdGltZSA8cGV0cmUuZWZ0aW1lQGdtYWlsLmNvbT4KPiBIYXNuJ3QgdGhpcyBi
ZWVuIHN1Ym1pdHRlZCBhIGxvbmcgdGltZSBhZ28/ICBXaGF0IGNoYW5nZWQgZnJvbSB0aGF0Cj4g
c3VibWlzc2lvbj8gIE9yIGFtIEkgbWlzLXJlbWVtYmVyaW5nIHRoaW5ncz8KCgpXaXRoIE5pdHJv
IEVuY2xhdmVzLCB0aGVyZSBhcmUgMiBwYXJ0aWVzOiBQYXJlbnQgYW5kIEVuY2xhdmUuCgpUaGUg
cGFyZW50IGxhdW5jaGVzIHRoZSBFbmNsYXZlLiBUbyBkbyBzbywgaXQgY3JlYXRlcyBhIHNpYmxp
bmcgVk0gdXNpbmcgCmEgc3BlY2lhbCBFbmNsYXZlcyBQQ0kgZGV2aWNlLiBUaGUgZHJpdmVyIGZv
ciB0aGF0IGlzIGluIApkcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMgYW5kIHlvdSBoZWxwZWQg
dG8gdXBzdHJlYW0gdGhhdCBiYWNrIHRoZW4uCgpUaGUgZW5jbGF2ZSBpcyB3aGF0IGlzIHJ1bm5p
bmcgaW5zaWRlIHRoZSBzaWJsaW5nIFZNLiBJdCBzZWVzIGEgCkZpcmVjcmFja2VyIGxpa2UgZGV2
aWNlIG1vZGVsIHdpdGggdmlydGlvLXZzb2NrIHRvIGNvbW11bmljYXRlIHRvIHRoZSAKcGFyZW50
IGFzIHdlbGwgYXMgYSBzcGVjaWFsIHZpcnRpby1tbWlvIGRldmljZSBjYWxsZWQgIk5TTSIgdG8g
CmNvbW11bmljYXRlIHRvIHRoZSBoeXBlcnZpc29yLiBUaGlzIGRyaXZlciBpcyBmb3IgdGhlIGxh
dHRlci4KCkknbSBub3cgYXdhcmUgb2YgcHJldmlvdXMgYXR0ZW1wdHMgdG8gdXBzdHJlYW0gaXQu
CgoKPgo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBiL2RyaXZlcnMvbWlzYy9uc20uYwo+PiBAQCAt
MCwwICsxLDQ3MCBAQAo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPj4g
Ky8qCj4+ICsgKiBBbWF6b24gTml0cm8gU2VjdXJlIE1vZHVsZSBkcml2ZXIuCj4+ICsgKgo+PiAr
ICogQ29weXJpZ2h0IEFtYXpvbi5jb20sIEluYy4gb3IgaXRzIGFmZmlsaWF0ZXMuIEFsbCBSaWdo
dHMgUmVzZXJ2ZWQuCj4+ICsgKgo+PiArICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7
IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgaXQKPj4gKyAqIHVuZGVyIHRo
ZSB0ZXJtcyBhbmQgY29uZGl0aW9ucyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Us
Cj4+ICsgKiB2ZXJzaW9uIDIsIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3Vu
ZGF0aW9uLgo+PiArICoKPj4gKyAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUg
aG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAo+PiArICogYnV0IFdJVEhPVVQgQU5ZIFdBUlJB
TlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKPj4gKyAqIE1FUkNIQU5U
QUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gU2VlIHRoZQo+PiAr
ICogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KPj4gKyAqCj4+
ICsgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZQo+PiArICogYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgc2Vl
IDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4KPiBQbGVhc2UgZHJvcCB0aGUgbGljZW5z
ZSAiYm9pbGVyLXBsYXRlIiB0ZXh0LCB0aGUgU1BEWCBsaW5lIGlzCj4gc3VmZmljaWVudC4KCgpT
dXJlLCBoYXBweSB0byEgOikKCgpBbGV4CgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdl
cm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5n
OiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRz
Z2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVz
dC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

