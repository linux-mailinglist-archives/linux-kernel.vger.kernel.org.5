Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BB87BF4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442647AbjJJHz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442618AbjJJHzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:55:52 -0400
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624C591;
        Tue, 10 Oct 2023 00:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696924552; x=1728460552;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F6F/G68dUG0sq4xFhDhcfq0nzHUZbmeO6Snxsvlc640=;
  b=JjbX4SUqy58hT1TYA3nZYMe17I0YLX7UNFnwNqq5oZSUtv8lZE6TDfFq
   CtEpH3lOtO5en+QYLVWdihRRbRe9wA4tpMKO8xYjKukdZ77jWZSHm9Xa5
   hWe2tumSrfCc5vb+Gpui9oqB2KBXJqCG1NB0Cl2fP/ulbmkbuwir0qw7w
   4=;
X-IronPort-AV: E=Sophos;i="6.03,212,1694736000"; 
   d="scan'208";a="612559776"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 07:55:49 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com (Postfix) with ESMTPS id F3CBD8069A;
        Tue, 10 Oct 2023 07:55:45 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 07:55:41 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 10 Oct
 2023 07:55:36 +0000
Message-ID: <0ee221bc-ea99-4724-9ebd-436e91417e4b@amazon.com>
Date:   Tue, 10 Oct 2023 09:55:25 +0200
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
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <2023101010-overwrite-parakeet-91d5@gregkh>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IEdyZWcsCgpPbiAxMC4xMC4yMyAwODoxMywgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOgo+
IE9uIE1vbiwgT2N0IDA5LCAyMDIzIGF0IDA5OjIwOjUyUE0gKzAwMDAsIEFsZXhhbmRlciBHcmFm
IHdyb3RlOgo+PiBUbyBmdWxseSBzdXBwb3J0IHRoZSBOaXRybyBTZWN1cmUgTW9kdWxlIGNvbW11
bmljYXRpb24gcHJvdG9jb2wsIHdlIG5lZWQKPj4gdG8gZW5jb2RlIGFuZCBkZWNvZGUgQ0JPUiBi
aW5hcnkgZGF0YS4gSW1wb3J0IGFuIE1JVCBsaWNlbnNlZCBsaWJyYXJ5Cj4+IGZyb20gaHR0cHM6
Ly9naXRodWIuY29tL2xpYm1jdS9jYm9yIChjb21taXQgZjNkMTY5NmY4ODYpIHNvIHRoYXQgd2Ug
Y2FuCj4+IGVhc2lseSBjb25zdW1lIENCT1IgZGF0YS4KPiBXaGF0IGlzICJDQk9SIj8gIEkgZG9u
J3Qgc2VlIGEgZGVzY3JpcHRpb24gb2YgaXQgaGVyZS4KCgpDQk9SIGlzIHRoZSAiQ29uY2lzZSBC
aW5hcnkgT2JqZWN0IFJlcHJlc2VudGF0aW9uIiAKKGh0dHBzOi8vZW4ud2lraXBlZGlhLm9yZy93
aWtpL0NCT1IpIGJpbmFyeSBmb3JtYXQuCgoKPgo+IEFuZCBJIGd1ZXNzIHlvdSBhcmUgZ29pbmcg
dG8ga2VlcCB0aGlzIGluIHN5bmMgd2l0aCB1cHN0cmVhbT8gIE9yIGRvIHlvdQo+IHJlYWxseSBu
ZWVkIHRoZSBmdWxsIGxpYnJhcnkgaGVyZSAoeW91ICNpZmRlZiB0aGUgZmxvYXQgc3R1ZmYgb3V0
KSwgZG9lcwo+IHlvdXIgbW9kdWxlIHJlYWxseSBuZWVkIGFsbCBvZiB0aGUgZnVuY3Rpb25hbGl0
eSBhbmQgY29tcGxleGl0eSBvZiB0aGlzCj4gbGlicmFyeSwgb3IgY2FuIGl0IHVzZSBqdXN0IGEg
bXVjaCBzbWFsbGVyIG9uZSBpbnN0ZWFkPwoKCkNCT1Iga25vd3MgYSB0b3RhbCBvZiA5IGRhdGEg
dHlwZXM6CgogwqAgLSBVbnNpZ25lZCBpbnRlZ2VycwogwqAgLSBTaWduZWQgaW50ZWdlcnMKIMKg
IC0gQmluYXJ5IHN0cmluZwogwqAgLSBVVEYtOCBzdHJpbmcKIMKgIC0gQXJyYXlzCiDCoCAtIE1h
cHMgKGxpa2UgYSBweXRob24gZGljdGlvbmFyeSkKIMKgIC0gU2VtYW50aWMgdGFnCiDCoCAtIEJv
b2xzCiDCoCAtIEZsb2F0cwoKT3V0IG9mIHRoZXNlLCB0aGUgTlNNIGNvbW11bmljYXRpb24gcHJv
dG9jb2wgdXNlcyBhbGwgZXhjZXB0IFNlbWFudGljIAp0YWdzIGFuZCBGbG9hdHMuIFRoZSBDQk9S
IGxpYnJhcnkgdGhhdCB0aGlzIHBhdGNoIGltcG9ydHMgZG9lcyBub3QgaGF2ZSAKc3BlY2lhbCBo
YW5kbGluZyBmb3IgU2VtYW50aWMgdGFncywgd2hpY2ggbGVhdmVzIG9ubHkgZmxvYXRzIHdoaWNo
IGFyZSAKYWxyZWFkeSAjaWZkZWYnZWQgb3V0LiBUaGF0IG1lYW5zIHRoZXJlIGlzIG5vdCBtdWNo
IHRvIHRyaW0uCgpXaGF0IHlvdSBzZWUgaGVyZSBpcyB3aGF0J3MgbmVlZGVkIHRvIHBhcnNlIENC
T1IgaW4ga2VybmVsIC0gaWYgdGhhdCdzIAp3aGF0IHdlIHdhbnQgdG8gZG8uIEknbSBoYXBweSB0
byByaXAgaXQgb3V0IGFnYWluIGFuZCBtYWtlIGl0IGEgcHVyZSAKdXNlciBzcGFjZSBwcm9ibGVt
IHRvIGRvIENCT1IgOikuCgoKPgo+PiBPbiB0b3Agb2YgdGhlIHVwc3RyZWFtIGNvZGUgYmFzZSwg
SSBhZGRlZCBrZXJuZWwgbW9kdWxlIGFzIHdlbGwgYXMKPj4ga2VybmVsIGhlYWRlciBwYXRoIGF3
YXJlbmVzcyBhbmQgbWFkZSBjaGVja3BhdGNoIGhhcHB5Lgo+IElmIG9ubHkgdGhlIG9uZSBtb2R1
bGUgbmVlZHMgdGhpcywgd2h5IG5vdCBwdXQgaXQgaW4gdGhlIGRpcmVjdG9yeSBmb3IKPiB0aGUg
bW9kdWxlIGl0c2VsZiwgYW5kIHRoZW4gd2hlbi9pZiBhbnlvbmUgZWxzZSBuZWVkcyBpdCwgaXQg
Y291bGQgYmUKPiBtb3ZlZD8KCgpUaGF0IHNvdW5kcyBsaWtlIGEgZ3JlYXQgaWRlYSEgTGV0IG1l
IGRvIHRoYXQgOikKCgpBbGV4CgoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55
IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hy
aXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmlj
aHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6
IERFIDI4OSAyMzcgODc5CgoK

