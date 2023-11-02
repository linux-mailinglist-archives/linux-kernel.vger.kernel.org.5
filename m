Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D0A7DEF43
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345950AbjKBJzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbjKBJzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:55:10 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC1123;
        Thu,  2 Nov 2023 02:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698918907; x=1730454907;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ty2pZC8GieEaKxoyIj+QktVwP/871rX0khhasjva50E=;
  b=lvZV2w1O481bKr2AQZl+zo9X1UEB6FlAEDpsCjiSzzQTL2VnNucyBe1t
   TX/qzkin88ZOpPTX0AZCQWIZioFKoPH3hlNHhVA+zgAYwn0qhxITDhPAB
   y8TGuhxwRuhe/NKZC+vtkD1HZrz1J8B+Famr9cfiz3K4uBI/TOOFrAcBF
   g=;
X-IronPort-AV: E=Sophos;i="6.03,271,1694736000"; 
   d="scan'208";a="374009157"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:55:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
        by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 0635B48A2D;
        Thu,  2 Nov 2023 09:54:55 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:54569]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.251:2525] with esmtp (Farcaster)
 id 30586fe6-8734-472c-ba27-ac04058e2bba; Thu, 2 Nov 2023 09:54:55 +0000 (UTC)
X-Farcaster-Flow-ID: 30586fe6-8734-472c-ba27-ac04058e2bba
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 2 Nov 2023 09:54:54 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 2 Nov
 2023 09:54:45 +0000
Message-ID: <6b836c66-dbbf-417f-8fbe-dfd67f464a64@amazon.com>
Date:   Thu, 2 Nov 2023 10:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] misc: Add Nitro Secure Module driver
Content-Language: en-US
From:   Alexander Graf <graf@amazon.com>
To:     <linux-kernel@vger.kernel.org>
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
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
References: <20231011213522.51781-1-graf@amazon.com>
In-Reply-To: <20231011213522.51781-1-graf@amazon.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEuMTAuMjMgMjM6MzUsIEFsZXhhbmRlciBHcmFmIHdyb3RlOgo+IFdoZW4gcnVubmluZyBM
aW51eCBpbnNpZGUgYSBOaXRybyBFbmNsYXZlLCB0aGUgaHlwZXJ2aXNvciBwcm92aWRlcyBhCj4g
c3BlY2lhbCB2aXJ0aW8gZGV2aWNlIGNhbGxlZCAiTml0cm8gU2VjdXJpdHkgTW9kdWxlIiAoTlNN
KS4gVGhpcyBkZXZpY2UKPiBoYXMgMyBtYWluIGZ1bmN0aW9uczoKPgo+ICAgIDEpIFByb3ZpZGUg
YXR0ZXN0YXRpb24gcmVwb3J0cwo+ICAgIDIpIE1vZGlmeSBQQ1Igc3RhdGUKPiAgICAzKSBQcm92
aWRlIGVudHJvcHkKPgo+IFRoaXMgcGF0Y2ggYWRkcyBhIGRyaXZlciBmb3IgTlNNIHRoYXQgZXhw
b3NlcyBhIC9kZXYvbnNtIGRldmljZSBub2RlIHdoaWNoCj4gdXNlciBzcGFjZSBjYW4gaXNzdWUg
YW4gaW9jdGwgb24gdGhpcyBkZXZpY2Ugd2l0aCByYXcgTlNNIENCT1IgZm9ybWF0dGVkCj4gY29t
bWFuZHMgdG8gcmVxdWVzdCBhdHRlc3RhdGlvbiBkb2N1bWVudHMsIGluZmx1ZW5jZSBQQ1Igc3Rh
dGVzLCByZWFkCj4gZW50cm9weSBhbmQgZW51bWVyYXRlIHN0YXR1cyBvZiB0aGUgZGV2aWNlLiBJ
biBhZGRpdGlvbiwgdGhlIGRyaXZlcgo+IGltcGxlbWVudHMgYSBod3JuZyBiYWNrZW5kLgo+Cj4g
T3JpZ2luYWxseS1ieTogUGV0cmUgRWZ0aW1lIDxwZXRyZS5lZnRpbWVAZ21haWwuY29tPgo+IFNp
Z25lZC1vZmYtYnk6IEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+CgoKUGluZyBmb3Ig
aW5jbHVzaW9uPyBJIGhhdmVuJ3Qgc2VlbiBhbnkgZnVydGhlciBjb21tZW50cyBvbiB2NyBvZiB0
aGlzIApwYXRjaCwgc28gSSdkIGFzc3VtZSBpdCdzIGdvb2QgdG8gZ28/IDopCgoKQWxleAoKCgoK
QW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAx
MTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRo
YW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIg
SFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

