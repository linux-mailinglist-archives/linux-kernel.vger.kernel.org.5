Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECC0792B27
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242329AbjIEQs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344289AbjIEDRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 23:17:38 -0400
Received: from m1380.mail.163.com (m1380.mail.163.com [220.181.13.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC4D6CC6;
        Mon,  4 Sep 2023 20:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=jLyBt3DzTjG5LnMN4OhdFPOe9r06n8TNJPEGNLsLVrI=; b=m
        YnPcw+SrkVHk+siAMPGtklCL/zotUz6s5TzSi6YJpAu4O8RsUj93C3Qc/gMtgFml
        vd5KFNqktRQCJEeWRwEKf3/iBiYWYOYcc78arWDzouViNzjfOvPANiozhD6pEbyG
        M6WMyERaXxgZqLlB4+PRbbTc4Y5YPV3EiqYdRcUcR8=
Received: from 00107082$163.com ( [111.35.184.199] ) by ajax-webmail-wmsvr80
 (Coremail) ; Tue, 5 Sep 2023 11:16:20 +0800 (CST)
X-Originating-IP: [111.35.184.199]
Date:   Tue, 5 Sep 2023 11:16:20 +0800 (CST)
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
Subject: Re: [PATCH] samples/bpf: Add sample usage for
 BPF_PROG_TYPE_NETFILTER
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <CAADnVQJVyQQ5geDuUgoDYygN9R1gJr-21XmQOR8gY5UkZsosCQ@mail.gmail.com>
References: <20230904102128.11476-1-00107082@163.com>
 <20230904104856.GE11802@breakpoint.cc>
 <CAADnVQJVyQQ5geDuUgoDYygN9R1gJr-21XmQOR8gY5UkZsosCQ@mail.gmail.com>
X-NTES-SC: AL_QuySAfSTvE8j5ieZZ+kZnEYQheY4XMKyuPkg1YJXOp80hyrt+iocQEJNBHvc1seeNB6MjSWHVBpI8s5lV7NZYq5XJ+C+KNGUQzNkBWI2QIxt
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <49e1d877.1e64.18a63574e6a.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: UMGowAAXpVyFnfZkzwIAAA--.191W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbCfgXgqmDcPgegTAAKsS
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjMtMDktMDUgMDU6MDE6MTQsICJBbGV4ZWkgU3Rhcm92b2l0b3YiIDxhbGV4ZWkuc3Rh
cm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPk9uIE1vbiwgU2VwIDQsIDIwMjMgYXQgMzo0OeKA
r0FNIEZsb3JpYW4gV2VzdHBoYWwgPGZ3QHN0cmxlbi5kZT4gd3JvdGU6Cj4+Cj4+IERhdmlkIFdh
bmcgPDAwMTA3MDgyQDE2My5jb20+IHdyb3RlOgo+PiA+IFRoaXMgc2FtcGxlIGNvZGUgaW1wbGVt
ZW50cyBhIHNpbXBsZSBpcHY0Cj4+ID4gYmxhY2tsaXN0IHZpYSB0aGUgbmV3IGJwZiB0eXBlIEJQ
Rl9QUk9HX1RZUEVfTkVURklMVEVSLAo+PiA+IHdoaWNoIHdhcyBpbnRyb2R1Y2VkIGluIDYuNC4K
Pj4gPgo+PiA+IFRoZSBicGYgcHJvZ3JhbSBkcm9wcyBwYWNrYWdlIGlmIGRlc3RpbmF0aW9uIGlw
IGFkZHJlc3MKPj4gPiBoaXRzIGEgbWF0Y2ggaW4gdGhlIG1hcCBvZiB0eXBlIEJQRl9NQVBfVFlQ
RV9MUE1fVFJJRSwKPj4gPgo+PiA+IFRoZSB1c2Vyc3BhY2UgY29kZSB3b3VsZCBsb2FkIHRoZSBi
cGYgcHJvZ3JhbSwKPj4gPiBhdHRhY2ggaXQgdG8gbmV0ZmlsdGVyJ3MgRk9SV0FSRC9PVVRQVVQg
aG9vaywKPj4gPiBhbmQgdGhlbiB3cml0ZSBpcCBwYXR0ZXJucyBpbnRvIHRoZSBicGYgbWFwLgo+
Pgo+PiBUaGFua3MsIEkgdGhpbmsgaXRzIGdvb2QgdG8gaGF2ZSB0aGlzLgo+Cj5ZZXMsIGJ1dCBv
bmx5IGluIHNlbGZ0ZXN0cy9icGYuCj5zYW1wbGVzL2JwZi8gYXJlIG5vdCB0ZXN0ZWQgYW5kIGJp
dCByb3QgaGVhdmlseS4KCk15IHB1cnBvc2UgaXMgdG8gZGVtb25zdHJhdGUgdGhlIGJhc2ljIHVz
YWdlIG9mIEJQRl9QUk9HX1RZUEVfTkVURklMVEVSICwgIHNob3dpbmcgd2hhdCBicGYgcHJvZ3Jh
bSBhbmQgdXNlcnNwYWNlIHByb2dyYW0gc2hvdWxkIGRvIHRvIG1ha2UgaXQgd29yay4KVGhlIGNv
ZGUgaXMgbmVpdGhlciAgdGhvcm91Z2ggIGVub3VnaCB0byBtYWtlIGEgdmFsaWQgdGVzdCBzdWl0
ZSwgIG5vciAgZGV0YWlsZWQgZW5vdWdoIHRvIG1ha2Ugb3V0IGEgdG9vbCAoQ291bGQgYmUgYSBz
dGFydCBmb3IgYSB0b29sKQoKc2FtcGxlcy9icGYgaXMgYSBnb29kICBwbGFjZSB0byBzdGFydCBm
b3IgIGJlZ2lubmVycyB0byBnZXQgYWxvbmcgIHdpdGggYnBmIHF1aWNrbHksICAgdGhvc2UgIHNh
bXBsZS9icGYgY29kZXMgZG8gaGVscCBtZSBhIGxvdCwKICBidXQgc2VsZnRlc3RzL2JwZiBpcyBu
b3QgdGhhdCAgZnJpZW5kbHksIGF0IGxlYXN0IG5vdCBmcmllbmRseSBmb3IgYmVnaW5uZXJzLCBJ
IHRoaW5rLiAgIApUaGVyZSBhcmUgYWxyZWFkeSB0ZXN0IGNvZGVzIGZvciAgIEJQRl9QUk9HX1RZ
UEVfTkVURklMVEVSIGluIHNlbGZ0ZXN0cy9icGYsICBhY3R1YWxseSBJIGRpZCByZWZlciB0byB0
aG9zZSBjb2RlICB3aGVuIEkgbWFkZSB0aGlzIHNhbXBsZS4KCkdldCBhIGZlZWxpbmcgc2FtcGxl
cy9icGYgd291bGQgYmUgZGVwcmVjYXRlZCBzb29uZXIgb3IgbGF0ZXIsIGhvcGUgdGhhdCB3b3Vs
ZCBub3QgaGFwcGVuLgoKQW55d2F5LCB0aGlzIHNhbXBsZSBjb2RlIGlzIG5vdCBtZWFudCB0byB0
ZXN0LiAKCgoK
