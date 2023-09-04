Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD4F791638
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351164AbjIDL1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbjIDL1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:27:14 -0400
X-Greylist: delayed 920 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Sep 2023 04:27:10 PDT
Received: from m1326.mail.163.com (m1326.mail.163.com [220.181.13.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52A3BE3;
        Mon,  4 Sep 2023 04:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=oOrvVEuXehCrhaRUsZ2VCWXmwU+bjnfYSuYNWyrf6qI=; b=a
        qGWbqkNYcFjwMjnHxKN2lK9U6fZkJldhS+2BgRMkx9nijw/KeHXrbyYpriiLjaEy
        ARPP84jxYEm9IU+OK0UJmzNhG0iyf2OavnM+ws/P3MM1/Y5nbipA3p15EDMw6bYd
        wE8GDLXhDVf6xmEWji3dpA9eMieLfsKJ1QTYq76S/Q=
Received: from 00107082$163.com ( [111.35.184.199] ) by ajax-webmail-wmsvr26
 (Coremail) ; Mon, 4 Sep 2023 19:10:23 +0800 (CST)
X-Originating-IP: [111.35.184.199]
Date:   Mon, 4 Sep 2023 19:10:23 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     "Florian Westphal" <fw@strlen.de>
Cc:     "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        "Song Liu" <song@kernel.org>,
        "Yonghong Song" <yonghong.song@linux.dev>,
        "John Fastabend" <john.fastabend@gmail.com>,
        "KP Singh" <kpsingh@kernel.org>,
        "Stanislav Fomichev" <sdf@google.com>,
        "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re:Re: [PATCH] samples/bpf: Add sample usage for
 BPF_PROG_TYPE_NETFILTER
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <20230904104856.GE11802@breakpoint.cc>
References: <20230904102128.11476-1-00107082@163.com>
 <20230904104856.GE11802@breakpoint.cc>
X-NTES-SC: AL_QuySAfSZukAp5SGYYukXn0oTju85XMCzuv8j3YJeN500kynv+QIif0dkG0DQ78y/Cg+UiCCrYQlT+tRgQJJoYbozapZjFwUkO3JyF79fvtYH
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3bc1d9a3.5bb6.18a5fe2f185.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GsGowABXtewgu_VkU9gTAA--.11573W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMwTgqlXmGU34bgACsO
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjMtMDktMDQgMTg6NDg6NTYsICJGbG9yaWFuIFdlc3RwaGFsIiA8ZndAc3RybGVuLmRl
PiB3cm90ZToKPkRhdmlkIFdhbmcgPDAwMTA3MDgyQDE2My5jb20+IHdyb3RlOgo+PiBUaGlzIHNh
bXBsZSBjb2RlIGltcGxlbWVudHMgYSBzaW1wbGUgaXB2NAo+PiBibGFja2xpc3QgdmlhIHRoZSBu
ZXcgYnBmIHR5cGUgQlBGX1BST0dfVFlQRV9ORVRGSUxURVIsCj4+IHdoaWNoIHdhcyBpbnRyb2R1
Y2VkIGluIDYuNC4KPj4gCj4+IFRoZSBicGYgcHJvZ3JhbSBkcm9wcyBwYWNrYWdlIGlmIGRlc3Rp
bmF0aW9uIGlwIGFkZHJlc3MKPj4gaGl0cyBhIG1hdGNoIGluIHRoZSBtYXAgb2YgdHlwZSBCUEZf
TUFQX1RZUEVfTFBNX1RSSUUsCj4+IAo+PiBUaGUgdXNlcnNwYWNlIGNvZGUgd291bGQgbG9hZCB0
aGUgYnBmIHByb2dyYW0sCj4+IGF0dGFjaCBpdCB0byBuZXRmaWx0ZXIncyBGT1JXQVJEL09VVFBV
VCBob29rLAo+PiBhbmQgdGhlbiB3cml0ZSBpcCBwYXR0ZXJucyBpbnRvIHRoZSBicGYgbWFwLgo+
Cj5UaGFua3MsIEkgdGhpbmsgaXRzIGdvb2QgdG8gaGF2ZSB0aGlzLgoKVGhhbmtzIGZvciB0aGUg
cXVpY2sgcmVzcG9uc2UuCj4KPj4gZGlmZiAtLWdpdCBhL3NhbXBsZXMvYnBmL25ldGZpbHRlcl9p
cDRfYmxhY2tsaXN0LmJwZi5jIGIvc2FtcGxlcy9icGYvbmV0ZmlsdGVyX2lwNF9ibGFja2xpc3Qu
YnBmLmMKPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5kMzE1
ZDY0ZmRhN2YKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi9zYW1wbGVzL2JwZi9uZXRmaWx0ZXJf
aXA0X2JsYWNrbGlzdC5icGYuYwo+PiBAQCAtMCwwICsxLDYyIEBACj4+ICsvLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMAo+PiArCj4+ICsjaW5jbHVkZSAidm1saW51eC5oIgo+PiAr
I2luY2x1ZGUgPGJwZi9icGZfaGVscGVycy5oPgo+PiArCj4+ICsKPj4gKyNkZWZpbmUgTkZfRFJP
UCAwCj4+ICsjZGVmaW5lIE5GX0FDQ0VQVCAxCj4KPklmIHlvdSBhcmUgaW50ZXJlc3RlZCwgeW91
IGNvdWxkIHNlbmQgYSBwYXRjaCBmb3IgbmYtbmV4dCB0aGF0Cj5tYWtlcyB0aGUgdWFwaSBoZWFk
ZXJzIGV4cG9zZSB0aGlzIGFzIGVudW0sIEFGQUlVIHRoYXQgd291bGQgbWFrZQo+dGhlIHZlcmRp
Y3QgbmFuZXMgYXZhaWxhYmxlIHZpYSB2bWxpbnV4LmguCj4KSSB0aGluayBJIGNhbiB3b3JrIG9u
IHRoaXMuCgoKCj4+ICsJLyogc2VhcmNoIHAtPmRhZGRyIGluIHRyaWUgKi8KPj4gKwlrZXkucHJl
Zml4bGVuID0gMzI7Cj4+ICsJa2V5LmRhdGEgPSBwLT5kYWRkcjsKPj4gKwlwdmFsdWUgPSBicGZf
bWFwX2xvb2t1cF9lbGVtKCZpcHY0X2xwbV9tYXAsICZrZXkpOwo+PiArCWlmIChwdmFsdWUpIHsK
Pj4gKwkJLyogY2F0IC9zeXMva2VybmVsL2RlYnVnL3RyYWNpbmcvdHJhY2VfcGlwZSAqLwo+PiAr
CQlicGZfcHJpbnRrKCJydWxlIG1hdGNoZWQgd2l0aCAlZC4uLlxuIiwgKnB2YWx1ZSk7Cj4KPklm
IHlvdSBhcmUgaW50ZXJlc3RlZCB5b3UgY291bGQgc2VuZCBhIHBhdGNoIHRoYXQgYWRkcyBhIGtm
dW5jIHRvCj5uZl9icGZfbGluayB0aGF0IGV4cG9zZXMgbmZfbG9nX3BhY2tldCgpIHRvIGJwZi4K
Pgo+bmZfbG9nX3BhY2tldCBoYXMgYSB0ZXJyaWJsZSBhcGksIEkgc3VnZ2VzdCB0byBoYXZlIHRo
ZSBrZnVuYyB0YWtlCj4nc3RydWN0IG5mX2hvb2tfc3RhdGUgKicgaW5zdGVhZCBvZiA2KyBtZW1i
ZXJzIG9mIHRoYXQgc3RydWN0IGFzCj5hcmd1bWVudC4KPgpMb2dnaW5nIHN0cmF0ZWd5IGlzIG91
dCBvZiBteSBsZWFndWUsIGJ1dCBJIHdpbGwga2VlcCBleWUgb24gdGhpcy4KCkdsYWQgdG8gY29u
dHJpYnV0ZS4KCgpEYXZpZAo=
