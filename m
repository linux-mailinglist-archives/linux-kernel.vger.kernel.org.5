Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6EC7AFF34
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjI0I67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjI0I6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:58:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BE0B3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:58:49 -0700 (PDT)
Received: from verdu-eth.calcurco.cat.235.168.192.in-addr.arpa (unknown [93.176.144.0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sergi)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16261660732D;
        Wed, 27 Sep 2023 09:58:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695805126;
        bh=bVlQLQG/UbMYp3WOrbJoSGKyZxMcPe77Oo5NLgEH1g4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=i8Jlbw8gQC5ZCJSWYYxINgRq8WW1F5U2ajLm6aoHu56yUw9ufWHm7jwg21bBBoKZX
         hH3tjcp7DC16oMx6xYigHfLY8nZ372Aj6TO+nmJgDf1Z3T0pnPfy2BQ9JHtnn1BbJJ
         yqUiw8s1sLIRpDT0RjQffF0F5r7ZzTK2KIhxmWiIM7+buT9YQgsQgmX+aYcbJSNxa4
         jlAGvE2RtneC/RnmXYcvZMkSCmygYWWb4Td3RgAvW8yeIrr8mxMB8H8WXl+UO/vLqS
         ljlCxgD2n5n/PqT8vXHF7uOAdSHapOTJO0gY0WGH2TamJDP7CmTXtO0DoGpn/7awwF
         R2BQgMlzmEZvQ==
Message-ID: <8f946d0a5632d580b593cf731091126d59feb77f.camel@collabora.com>
Subject: Re: [RFC PATCH] drm/ci: add helper script update-xfails.py
From:   Sergi Blanch Torne <sergi.blanch.torne@collabora.com>
To:     Helen Koike <helen.koike@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        robdclark@gmail.com, daniel@fooishbar.org,
        vignesh.raman@collabora.com, jani.nikula@linux.intel.com,
        mripard@kernel.org, michel.daenzer@mailbox.org,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        david.heidelberg@collabora.com, guilherme.gallo@collabora.com
Date:   Wed, 27 Sep 2023 10:58:38 +0200
In-Reply-To: <20230925195556.106090-1-helen.koike@collabora.com>
References: <20230925195556.106090-1-helen.koike@collabora.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQpIYXNoOiBTSEEyNTYKCkhpIEhlbGVu
LAoKT24gTW9uLCAyMDIzLTA5LTI1IGF0IDE2OjU1IC0wMzAwLCBIZWxlbiBLb2lrZSB3cm90ZToK
PiBIZWxsbywKPiAKPiBUaGlzIHNjcmlwdCBpcyBiZWluZyB2ZXJ5IGhhbmR5IGZvciBtZSwgc28g
SSBzdXBwb3NlIGl0IGNvdWxkIGJlCj4gaGFuZHkKPiB0byBvdGhlcnMsIHNpbmNlIEknbSBwdWJs
aXNoaW5nIGl0IGluIHRoZSB4ZmFpbHMgZm9sZGVyLgo+IAo+IExldCBtZSBrbm93IHlvdXIgdGhv
dWdodHMuCgpJIGhhdmUgdHdvIHN1Z2dlc3Rpb25zIGFuZCBvbmUgY29tbWVudC4gQmVmb3JlIHRo
YXQsIEkgd291bGQgbGlrZSB0bwpoaWdobGlnaHQgdGhlIGltcG9ydGFuY2Ugb2YgdG9vbHMgbGlr
ZSB0aGF0IHRvIGhlbHAgd2l0aCByZXBldGl0aXZlCnRlZGlvdXMgd29yaywgaXQgaXMgZ3JlYXQg
dG8gaGF2ZSB0aGlzIHNjcmlwdC4KCj4gK2RlZiBnZXRfeGZhaWxzX2ZpbGVfcGF0aChjYW5vbmlj
YWxfbmFtZSwgc3VmZml4KToKPiArwqDCoMKgIG5hbWUgPSBjYW5vbmljYWxfbmFtZS5yZXBsYWNl
KCI6IiwgIi0iKQo+ICvCoMKgwqAgc2NyaXB0X2RpciA9IG9zLnBhdGguZGlybmFtZShvcy5wYXRo
LmFic3BhdGgoX19maWxlX18pKQo+ICvCoMKgwqAgcmV0dXJuIG9zLnBhdGguam9pbihzY3JpcHRf
ZGlyLCBmIntuYW1lfS17c3VmZml4fS50eHQiKQoKSSBhcHByZWNpYXRlIHRoZSBjb3JyZXNwb25k
ZW5jZSBiZXR3ZWVuIGpvYiBuYW1lIGFuZCBleHBlY3RhdGlvbiBmaWxlCm5hbWVzLgoKPiArZGVm
IGdldF91bml0X3Rlc3RfbmFtZV9hbmRfcmVzdWx0cyh1bml0X3Rlc3QpOgo+ICvCoMKgwqAgaWYg
IkFydGlmYWN0IHJlc3VsdHMvZmFpbHVyZXMuY3N2IG5vdCBmb3VuZCIgaW4gdW5pdF90ZXN0Ogo+
ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gTm9uZSwgTm9uZQo+ICvCoMKgwqAgdW5pdF90ZXN0X25h
bWUsIHVuaXRfdGVzdF9yZXN1bHQgPSB1bml0X3Rlc3Quc3RyaXAoKS5zcGxpdCgiLCIpCj4gK8Kg
wqDCoCByZXR1cm4gdW5pdF90ZXN0X25hbWUsIHVuaXRfdGVzdF9yZXN1bHQKClN1Z2dlc3Rpb246
IGl0IGlzIG5vdCBtYW5hZ2luZyBlbXB0eSBsaW5lcyBvciBjb21tZW50cy4gQnkgbm93LCB0aGVy
ZQphcmVuJ3QsIGJ1dCB0aGV5IGNvdWxkIGJlIGZvdW5kLgoKPiArZGVmIG1haW4obmFtZXNwYWNl
LCBwcm9qZWN0LCBwaXBlbGluZV9pZCk6Cj4gK8KgwqDCoCB4ZmFpbHMgPSAoCj4gK8KgwqDCoMKg
wqDCoMKgIENvbGxhdGUobmFtZXNwYWNlPW5hbWVzcGFjZSwgcHJvamVjdD1wcm9qZWN0KQo+ICvC
oMKgwqDCoMKgwqDCoCAuZnJvbV9waXBlbGluZShwaXBlbGluZV9pZCkKPiArwqDCoMKgwqDCoMKg
wqAgLmdldF9hcnRpZmFjdCgicmVzdWx0cy9mYWlsdXJlcy5jc3YiKQo+ICvCoMKgwqAgKQo+ICsK
PiArwqDCoMKgIHNwbGl0X3VuaXRfdGVzdF9mcm9tX2NvbGxhdGUoeGZhaWxzKQo+ICsKPiArwqDC
oMKgIGZvciBqb2JfbmFtZSBpbiB4ZmFpbHMua2V5cygpOgo+ICvCoMKgwqDCoMKgwqDCoCBjYW5v
bmljYWxfbmFtZSA9IGdldF9jYW5vbmljYWxfbmFtZShqb2JfbmFtZSkKPiArwqDCoMKgwqDCoMKg
wqAgZmFpbHNfdHh0X3BhdGggPSBnZXRfeGZhaWxzX2ZpbGVfcGF0aChjYW5vbmljYWxfbmFtZSwK
PiAiZmFpbHMiKQo+ICvCoMKgwqDCoMKgwqDCoCBmbGFrZXNfdHh0X3BhdGggPSBnZXRfeGZhaWxz
X2ZpbGVfcGF0aChjYW5vbmljYWxfbmFtZSwKPiAiZmxha2VzIikKPiArCj4gK8KgwqDCoMKgwqDC
oMKgIGZhaWxzX3R4dCA9IHJlYWRfZmlsZShmYWlsc190eHRfcGF0aCkKPiArwqDCoMKgwqDCoMKg
wqAgZmxha2VzX3R4dCA9IHJlYWRfZmlsZShmbGFrZXNfdHh0X3BhdGgpCj4gKwo+ICvCoMKgwqDC
oMKgwqDCoCBmb3Igam9iX2lkIGluIHhmYWlsc1tqb2JfbmFtZV0ua2V5cygpOgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGZvciB1bml0X3Rlc3QgaW4geGZhaWxzW2pvYl9uYW1lXVtqb2JfaWRd
Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5pdF90ZXN0X25hbWUsIHVuaXRf
dGVzdF9yZXN1bHQgPQo+IGdldF91bml0X3Rlc3RfbmFtZV9hbmRfcmVzdWx0cyh1bml0X3Rlc3Qp
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgbm90IHVuaXRfdGVzdF9u
YW1lOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZQo+
ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIGlzX3Rlc3RfcHJlc2VudF9v
bl9maWxlKGZsYWtlc190eHQsCj4gdW5pdF90ZXN0X25hbWUpOgo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZW1vdmVfdW5pdF90ZXN0X2lmX3ByZXNlbnQoZmxha2Vz
X3R4dCwKPiB1bml0X3Rlc3RfbmFtZSwgZmxha2VzX3R4dF9wYXRoKQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcmludCgiV0FSTklORzogdW5pdCB0ZXN0IGlzIG9u
IGZsYWtlcyBsaXN0IGJ1dAo+IGEgam9iIGZhaWxlZCBkdWUgdG8gaXQsICIKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImlzIHlvdXIgdHJlZSB1
cCB0byBkYXRlPyIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHVuaXRfdGVzdF9uYW1lLCAiRFJPUFBFRCBGUk9NIiwKPiBvcy5wYXRoLmJhc2Vu
YW1lKGZsYWtlc190eHRfcGF0aCkpCj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgdW5pdF90ZXN0X3Jlc3VsdCA9PSAiVW5leHBlY3RlZFBhc3MiOgo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZW1vdmVfdW5pdF90ZXN0X2lmX3ByZXNlbnQo
ZmFpbHNfdHh0LAo+IHVuaXRfdGVzdF9uYW1lLCBmYWlsc190eHRfcGF0aCkKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIyBmbGFrZSByZXN1bHQKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgbm90Cj4gaXNfdW5pdF90ZXN0X3ByZXNl
bnRfaW5fb3RoZXJfam9icyh1bml0X3Rlc3QsIHhmYWlsc1tqb2JfbmFtZV0pOgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZF91bml0X3Rlc3RfaWZf
bm90X3ByZXNlbnQoZmxha2VzX3R4dCwKPiB1bml0X3Rlc3RfbmFtZSwgZmxha2VzX3R4dF9wYXRo
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZQoKU3Vn
Z2VzdGlvbjogU29tZXRpbWVzIHRlc3RzIGZhaWxzIHdpdGggZGlmZmVyZW50IHN0YXR1cyAoIkZh
aWwiIHRvCiJDcmFzaCIgZm9yIGV4YW1wbGUpIGFuZCB0aGUgZXhwZWN0YXRpb25zIHNob3VsZCBi
ZSB1cGRhdGVkIHdpdGggdGhlCm5ld2VyIHN0YXR1cy4KCj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgIyBmbGFrZSByZXN1bHQKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIG5vdCBpc191bml0X3Rlc3RfcHJlc2VudF9pbl9vdGhlcl9qb2JzKHVuaXRfdGVz
dCwKPiB4ZmFpbHNbam9iX25hbWVdKToKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYWRkX3VuaXRfdGVzdF9pZl9ub3RfcHJlc2VudChmbGFrZXNfdHh0LAo+IHVuaXRf
dGVzdF9uYW1lLCBmbGFrZXNfdHh0X3BhdGgpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbnRpbnVlCj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgIyBjb25zaXN0ZW50IHJlc3VsdAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAK
PiBhZGRfdW5pdF90ZXN0X29yX3VwZGF0ZV9yZXN1bHRfdG9fZmFpbHNfaWZfcHJlc2VudChmYWls
c190eHQsCj4gdW5pdF90ZXN0LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiBmYWlsc190eHRfcGF0
aCkKPiArCj4gK8KgwqDCoMKgwqDCoMKgIHNhdmVfZmlsZShmYWlsc190eHQsIGZhaWxzX3R4dF9w
YXRoKQo+ICvCoMKgwqDCoMKgwqDCoCBzYXZlX2ZpbGUoZmxha2VzX3R4dCwgZmxha2VzX3R4dF9w
YXRoKQoKUmVnYXJkcywKCi0gLS0gClNlcmdpIEJsYW5jaCBUb3Juw6kKU2VuaW9yIFNvZnR3YXJl
IEVuZ2luZWVyCgpDb2xsYWJvcmEgTHRkLgpQbGF0aW51bSBCdWlsZGluZywgU3QgSm9obidzIElu
bm92YXRpb24gUGFyaywgQ2FtYnJpZGdlIENCNCAwRFMsIFVLClJlZ2lzdGVyZWQgaW4gRW5nbGFu
ZCAmIFdhbGVzLCBuby4gNTUxMzcxOAoKLS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlI
VUVBUllJQUIwV0lRUXdXUks2OGwrdGFKZmh3cUF0bzViSHlUbTlSd1VDWlJQdXZnQUtDUkF0bzVi
SHlUbTkKUjd3SUFQNGhyNWRkQlo5KzNSNG4yS0pBNURPYzZKRTFvUmphYkI3QTJwa1pGbDFCeHdF
QXlYODN5TWFxSkU4VApSWHJoWjNveVFiVUl5Q2JaaExOT1A2T2laNmJjaFFjPQo9UHIxeQotLS0t
LUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

