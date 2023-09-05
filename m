Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93578792F68
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbjIET7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbjIET7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:59:17 -0400
Received: from m1380.mail.163.com (m1380.mail.163.com [220.181.13.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F5E0BF;
        Tue,  5 Sep 2023 12:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=OtFJuI2jeRf9ECz6gG6EpxwvjHaztHRnOg/2QdNgt1g=; b=L
        ssutWHHT92CAeICBmuNY+ru8uJnnh4J8NI4MKqJR5JRwonZsf0G68MdfTBEEM6+x
        l38VnSkN1l7Vlp2ybqHvVX8ZLREmTqqOcU789+KRStHlkUfsLcbdN9KSfeHPA4DL
        5D9lTvJFlYJDVB3N+aAy+H7t8Niy45l3mk4z6WsOgk=
Received: from 00107082$163.com ( [111.35.184.199] ) by ajax-webmail-wmsvr80
 (Coremail) ; Wed, 6 Sep 2023 00:06:53 +0800 (CST)
X-Originating-IP: [111.35.184.199]
Date:   Wed, 6 Sep 2023 00:06:53 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc:     "Florian Westphal" <fw@strlen.de>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        "Song Liu" <song@kernel.org>,
        "Yonghong Song" <yonghong.song@linux.dev>,
        "John Fastabend" <john.fastabend@gmail.com>,
        "KP Singh" <kpsingh@kernel.org>,
        "Stanislav Fomichev" <sdf@google.com>,
        "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re:Re: [PATCH] samples/bpf: Add sample usage for
 BPF_PROG_TYPE_NETFILTER
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <CAADnVQKK-xGL55aYyhv-bWRizi5Ymp75c=Qwhu4y4v8DQK1s+g@mail.gmail.com>
References: <20230904102128.11476-1-00107082@163.com>
 <20230904104856.GE11802@breakpoint.cc>
 <CAADnVQJVyQQ5geDuUgoDYygN9R1gJr-21XmQOR8gY5UkZsosCQ@mail.gmail.com>
 <5490ca67.552d.18a6508175f.Coremail.00107082@163.com>
 <CAADnVQKK-xGL55aYyhv-bWRizi5Ymp75c=Qwhu4y4v8DQK1s+g@mail.gmail.com>
X-NTES-SC: AL_QuySAfWYv0gq5SiaYukXn0oTju85XMCzuv8j3YJeN500hyrP/yMcQEJqGmPq1seOICGMjSWMdBNC08teX6N9bbhQGBCLkox8mIDNIQYFC2YC
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2fda69d6.5c09.18a6618c48a.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: UMGowAD3H88eUvdkvwEAAA--.147W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiTBnhqmI0a0ZE5wAEsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_INVALID,DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjMtMDktMDUgMjM6NDk6NDEsICJBbGV4ZWkgU3Rhcm92b2l0b3YiIDxhbGV4ZWkuc3Rh
cm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPk9uIFR1ZSwgU2VwIDUsIDIwMjMgYXQgNDoxMeKA
r0FNIERhdmlkIFdhbmcgPDAwMTA3MDgyQDE2My5jb20+IHdyb3RlOgoKPj4gPgo+PiA+WWVzLCBi
dXQgb25seSBpbiBzZWxmdGVzdHMvYnBmLgo+PiA+c2FtcGxlcy9icGYvIGFyZSBub3QgdGVzdGVk
IGFuZCBiaXQgcm90IGhlYXZpbHkuCj4+Cj4+IEhpIEFsZXhlaSwKPj4KPj4gSSBuZWVkIHRvIGtu
b3cgd2hldGhlciBzYW1wbGVzL2JwZiBpcyBzdGlsbCBhIGdvb2QgcGxhY2UgdG8gcHV0IGNvZGUu
Cj4+IEkgd2lsbCBwdXQgdGhlIGNvZGUgaW4gYW5vdGhlciBvcGVuIHNvdXJjZSBwcm9qZWN0ICBm
b3IgYnBmIHNhbXBsZXMsICBtZW50aW9uZWQgYnkgVG9rZS4KPj4gQnV0IEkgc3RpbGwgd2FudCB0
byBwdXQgaXQgaW4gc2FtcGxlcy9icGYgLCBzaW5jZSB0aGUgY29kZSBvbmx5IGNvbXBpbGUvd29y
ayB3aXRoIG5ldyBrZXJuZWwuCj4+Cj4+IE5lZWQgeW91ciBmZWVkYmFjayBvbiB0aGlzLCAgY291
bGQgdGhpcyBjb2RlIGJlIGtlcHQgaW4gc2FtcGxlcy9icGY/IDopCj4KPlNvcnJ5LCBidXQgd2Ug
ZG9uJ3QgYWNjZXB0IG5ldyBjb2RlIHRvIHNhbXBsZXMvYnBmLy4KPkV2ZXJ5dGhpbmcgaW4gdGhl
cmUgIHdpbGwgYmUgbW92ZWQvcmVtb3ZlZC4KPklmIHlvdSB3YW50IHRvIHN0YXkgaW4gdGhlIGtl
cm5lbCBzZWxmdGVzdHMvYnBmIGlzIHRoZSBvbmx5IHBsYWNlIGFuZAo+aXQncyBnb3R0YSBiZSB0
aGUgcmVhbCB0ZXN0IGFuZCBub3QganVzdCBhIHNhbXBsZS4KCgpTYWQgdG8gaGVhciB0aGlzLi4u
LiAKQW55d2F5LCB0aGFuayB5b3UgYW5kIGFsbCBvdGhlcnMgd2hvIHRvb2sgdGltZSByZXZpZXdp
bmcgdGhpcy4KCkRhdmlk
