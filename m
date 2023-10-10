Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145927C428C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbjJJV3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjJJV3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:29:10 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6040B92;
        Tue, 10 Oct 2023 14:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696973349; x=1728509349;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6/e6d3zvTUXwsYvqJ6nT0VyA8vwAKmD/AR7R2WhZNKo=;
  b=gx3PBdC1gx67LmLssmEGu4C00auD0rRNHNp63/I7WKuTA6/lC2aiYmRH
   iSFCEhrUqGmoswxT7LTyKwA0R6qKBd+Hc2JuhpaKFkbuB4zYMhU16CZRi
   tvPD6r4pCI/PoQ/+NHxCEA1Mo6nHERJIS+RbUWaM6U8GtdMy+h66CGfhV
   U=;
X-IronPort-AV: E=Sophos;i="6.03,213,1694736000"; 
   d="scan'208";a="361171961"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 21:29:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id E74A240D44;
        Tue, 10 Oct 2023 21:29:03 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 21:29:02 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 10 Oct
 2023 21:29:00 +0000
Message-ID: <aa782a43-ad4a-455d-bc14-a6a6bb4022e0@amazon.com>
Date:   Tue, 10 Oct 2023 23:29:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] misc: Add Nitro Secure Module driver
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jason Wang <jasowang@redhat.com>,
        "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>
References: <20231010191815.13641-1-graf@amazon.com>
 <20231010163151-mutt-send-email-mst@kernel.org>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <20231010163151-mutt-send-email-mst@kernel.org>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
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

Ck9uIDEwLjEwLjIzIDIyOjM0LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4KPiBPbiBUdWUs
IE9jdCAxMCwgMjAyMyBhdCAwNzoxODoxNVBNICswMDAwLCBBbGV4YW5kZXIgR3JhZiB3cm90ZToK
Pj4gV2hlbiBydW5uaW5nIExpbnV4IGluc2lkZSBhIE5pdHJvIEVuY2xhdmUsIHRoZSBoeXBlcnZp
c29yIHByb3ZpZGVzIGEKPj4gc3BlY2lhbCB2aXJ0aW8gZGV2aWNlIGNhbGxlZCAiTml0cm8gU2Vj
dXJpdHkgTW9kdWxlIiAoTlNNKS4gVGhpcyBkZXZpY2UKPj4gaGFzIDMgbWFpbiBmdW5jdGlvbnM6
Cj4+Cj4+ICAgIDEpIFByb3ZpZGUgYXR0ZXN0YXRpb24gcmVwb3J0cwo+PiAgICAyKSBNb2RpZnkg
UENSIHN0YXRlCj4+ICAgIDMpIFByb3ZpZGUgZW50cm9weQo+Pgo+PiBUaGlzIHBhdGNoIGFkZHMg
YSBkcml2ZXIgZm9yIE5TTSB0aGF0IGV4cG9zZXMgYSAvZGV2L25zbSBkZXZpY2Ugbm9kZSB3aGlj
aAo+PiB1c2VyIHNwYWNlIGNhbiBpc3N1ZSBhbiBpb2N0bCBvbiB0aGlzIGRldmljZSB3aXRoIHJh
dyBOU00gQ0JPUiBmb3JtYXR0ZWQKPj4gY29tbWFuZHMgdG8gcmVxdWVzdCBhdHRlc3RhdGlvbiBk
b2N1bWVudHMsIGluZmx1ZW5jZSBQQ1Igc3RhdGVzLCByZWFkCj4+IGVudHJvcHkgYW5kIGVudW1l
cmF0ZSBzdGF0dXMgb2YgdGhlIGRldmljZS4gSW4gYWRkaXRpb24sIHRoZSBkcml2ZXIKPj4gaW1w
bGVtZW50cyBhIGh3cm5nIGJhY2tlbmQuCj4+Cj4+IE9yaWdpbmFsbHktYnk6IFBldHJlIEVmdGlt
ZSA8cGV0cmUuZWZ0aW1lQGdtYWlsLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIEdy
YWYgPGdyYWZAYW1hem9uLmNvbT4KPiBDb3VsZCBzb21lIGRvY3VtZW50YXRpb24gYWJvdXQgaG93
IHRoaXMgZGV2aWNlIHdvcmtzIGJlIHBvc3RlZCBvbiB2aXJ0aW8KPiBsaXN0IHBsZWFzZT8KCgpT
dXJlISBXaGF0IGlzIHlvdXIgcHJlZmVycmVkIG1ldGhvZCB0byBwcm92aWRlIHRoaXM/IDopCgpB
bGV4CgoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0
ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdl
ciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1
cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5
CgoK

