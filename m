Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B2E7EB041
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjKNMwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjKNMwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:52:14 -0500
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F55719F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699966331; x=1731502331;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lUOKRlOn/IToXT6nY32BLiDcuxnETgTaOJaO3CpQG0I=;
  b=T6O1RDHZoiAel4jr3nAEdJjoRcyaBK53GIsAqnYRsWyt9xYaIx4FZiIg
   CAcAnC4dgi4U+ixtif+4GYfGb3bm6SISoAsbZqxxcx+if6yvk5nTfkdgu
   csKoUNegX8RAoJbHBtyADxoik97ddmDKHTMT/CBsD0VpBzCUcHgjhSa1k
   Y=;
X-IronPort-AV: E=Sophos;i="6.03,302,1694736000"; 
   d="scan'208";a="166082886"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 12:52:09 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 56422488FA;
        Tue, 14 Nov 2023 12:52:07 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:12502]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.255:2525] with esmtp (Farcaster)
 id 9999ac78-449d-4707-acab-487af6ddb6d6; Tue, 14 Nov 2023 12:52:06 +0000 (UTC)
X-Farcaster-Flow-ID: 9999ac78-449d-4707-acab-487af6ddb6d6
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 14 Nov 2023 12:52:05 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 14 Nov
 2023 12:52:02 +0000
Message-ID: <00d6172f-e291-4e96-9d3e-63ee8e60d556@amazon.com>
Date:   Tue, 14 Nov 2023 13:51:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] vmgenid: emit uevent when VMGENID updates
To:     Lennart Poettering <mzxreary@0pointer.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Babis Chalios <bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>,
        <linux-kernel@vger.kernel.org>, <graf@amazon.de>,
        <xmarcalx@amazon.co.uk>, Arnd Bergmann <arnd@arndb.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Ted Tso <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>
References: <20230531095119.11202-1-bchalios@amazon.es>
 <20230531095119.11202-2-bchalios@amazon.es>
 <CAHmME9pVLD-U+iYfv7=HBufRtaSkBmCRpKLH8pbvPNkgozE3cg@mail.gmail.com>
 <ZJGNREN4tLzQXOJr@gardel-login>
Content-Language: en-US
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <ZJGNREN4tLzQXOJr@gardel-login>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzb24sCgpPbiAyMC4wNi4yMyAxMzoyOCwgTGVubmFydCBQb2V0dGVyaW5nIHdyb3RlOgo+
IE9uIE1vLCAxOS4wNi4yMyAyMjozMCwgSmFzb24gQS4gRG9uZW5mZWxkIChKYXNvbkB6eDJjNC5j
b20pIHdyb3RlOgo+Cj4+IExpa2UgdGhlIG90aGVyIHBhdGNoLCBhbmQgYXMgZGlzY3Vzc2VkIGJl
Zm9yZSB0b28sIEkgZG9uJ3QgdGhpbmsgdGhpcwo+PiBoYXMgYW55IGJ1c2luZXNzIGJlaW5nIHBh
cnQgb2YgKHZpcnR1YWwpIGhhcmR3YXJlIGRyaXZlcnMsIGFuZCBpbnN0ZWFkCj4+IGJlbG9uZ3Mg
aW4gcmFuZG9tLmMsIHdoaWNoIG1pZ2h0IHJlY2VpdmUgdGhlc2Ugbm90aWZpY2F0aW9ucyBmcm9t
IGEKPj4gdmFyaWV0eSBvZiBkZXZpY2VzLCBhbmQgY2FuIHRodXMgc3luY2hyb25pemUgdGhpbmdz
IGFjY29yZGluZ2x5Lgo+PiBQbGVhc2Ugc3RvcCBwb3N0aW5nIG1vcmUgb2YgdGhlc2Ugc2FtZSBh
cHByb2FjaGVzLiBTYW1lIG5hY2sgYXMgdGhlCj4+IG90aGVyIG9uZXMuCj4gTm90ZSB0aGUgaW50
ZW5kZWQgdXNlY2FzZSBmb3IgdGhpcyBpbiB1c2Vyc3BhY2UgcmVhbGx5IGhhcyBub3RoaW5nIHRv
Cj4gZG8gd2l0aCBSTkdzLiBXZSBqdXN0IHdhbnQgYW4gZXZlbnQgdGhhdCBpcyBnZW5lcmF0ZWQg
d2hlbiBhIG1hY2hpbmUKPiBpcyBkdXBsaWNhdGVkIHNvIHRoYXQgd2UgY2FuIHJlcXVlc3QgYSBu
ZXcgREhDUCBsZWFzZSwgYW5kIHNpbWlsYXIuIEkKPiBkb24ndCBzZWUgYW55IHJlbGF0aW9uc2hp
cCB0byByYW5kb20uYyBmb3IgdGhhdC4KCgpDaGVja2luZyB1cCBvbiB0aGlzIGNvbnZlcnNhdGlv
bi4gVGhlIGludGVuZGVkIHVzZSBjYXNlIGhhcyBub3RoaW5nIHRvIApkbyB3aXRoIFJORyAtIHdl
IG1lcmVseSBuZWVkIGEgbm90aWZpY2F0aW9uIGZvciBzeXN0ZW0gbGV2ZWwgdXNlciBzcGFjZSAK
dGhhdCBhIHN5c3RlbSBjbG9uZSBvcGVyYXRpb24gaGFwcGVuZWQgc28gaXQgY2FuIGFjdCBvbiBp
dC4KClBsZWFzZSBjb25zaWRlciB0YWtpbmcgdGhlIHBhdGNoIGFzIGlzIG9yIGFkdmlzZSBvbiBo
b3cgdG8gcHJvY2VlZCB0byAKYWRkcmVzcyB0aGlzIG5vbi1STkcgdXNlIGNhc2UuCgoKVGhhbmtz
LAoKQWxleAoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNl
bnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxh
ZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRl
bmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcg
ODc5CgoK

