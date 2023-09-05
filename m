Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC656792A78
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbjIEQhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354356AbjIEK6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:58:20 -0400
Received: from m1388.mail.163.com (m1388.mail.163.com [220.181.13.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 899F9199;
        Tue,  5 Sep 2023 03:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=e7ubFt8iCe/e60k3yzj15ridqgQBnNGWYjQM6HLh5TU=; b=H
        rsxzZr5icjgv2Wpj6ehLtLU45M8pqZqwiIp2Wttk3MyLxZjqOqQXSd8Dtn8ztWq9
        ifJdYUFuIy53xMQnjeahn92398cSgyRmgh8o4DgTHlYQv46bARaB60fctjODWG36
        jw/wTql8hA0GL2eLL3OoYiMDpD/l5g60SPG+o4v64E=
Received: from 00107082$163.com ( [111.35.184.199] ) by ajax-webmail-wmsvr88
 (Coremail) ; Tue, 5 Sep 2023 18:57:15 +0800 (CST)
X-Originating-IP: [111.35.184.199]
Date:   Tue, 5 Sep 2023 18:57:15 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     "Donald Hunter" <donald.hunter@gmail.com>
Cc:     fw@strlen.de, "Alexei Starovoitov" <ast@kernel.org>,
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
Subject: Re: [PATCH] samples/bpf: Add sample usage for
 BPF_PROG_TYPE_NETFILTER
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <m28r9ldm7d.fsf@gmail.com>
References: <20230904102128.11476-1-00107082@163.com>
 <m28r9ldm7d.fsf@gmail.com>
X-NTES-SC: AL_QuySAfWavkwo4yKbYukZnEYQheY4XMKyuPkg1YJXOp80oyr99Q0sT01nIlv0y/OUNDKKgiqbeQhXx9RqQbBzZohGdF1AFD8lsQfX957ITNG1
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <279bb09e.54ab.18a64fd47e8.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: WMGowABnbpiLCfdk30wAAA--.3911W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEAThqmNfu+chxgAEsc
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjMtMDktMDUgMTc6MDU6MjYsICJEb25hbGQgSHVudGVyIiA8ZG9uYWxkLmh1bnRlckBn
bWFpbC5jb20+IHdyb3RlOgo+RGF2aWQgV2FuZyA8MDAxMDcwODJAMTYzLmNvbT4gd3JpdGVzOgo+
Cj4+IFRoaXMgc2FtcGxlIGNvZGUgaW1wbGVtZW50cyBhIHNpbXBsZSBpcHY0Cj4+IGJsYWNrbGlz
dCB2aWEgdGhlIG5ldyBicGYgdHlwZSBCUEZfUFJPR19UWVBFX05FVEZJTFRFUiwKPj4gd2hpY2gg
d2FzIGludHJvZHVjZWQgaW4gNi40Lgo+Pgo+PiBUaGUgYnBmIHByb2dyYW0gZHJvcHMgcGFja2Fn
ZSBpZiBkZXN0aW5hdGlvbiBpcCBhZGRyZXNzCj4+IGhpdHMgYSBtYXRjaCBpbiB0aGUgbWFwIG9m
IHR5cGUgQlBGX01BUF9UWVBFX0xQTV9UUklFLAo+Pgo+PiBUaGUgdXNlcnNwYWNlIGNvZGUgd291
bGQgbG9hZCB0aGUgYnBmIHByb2dyYW0sCj4+IGF0dGFjaCBpdCB0byBuZXRmaWx0ZXIncyBGT1JX
QVJEL09VVFBVVCBob29rLAo+PiBhbmQgdGhlbiB3cml0ZSBpcCBwYXR0ZXJucyBpbnRvIHRoZSBi
cGYgbWFwLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBXYW5nIDwwMDEwNzA4MkAxNjMuY29t
Pgo+PiAtLS0KPj4gIHNhbXBsZXMvYnBmL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgIHwg
IDMgKwo+PiAgc2FtcGxlcy9icGYvbmV0ZmlsdGVyX2lwNF9ibGFja2xpc3QuYnBmLmMgfCA2MiAr
KysrKysrKysrKysrKysKPj4gIHNhbXBsZXMvYnBmL25ldGZpbHRlcl9pcDRfYmxhY2tsaXN0LmMg
ICAgIHwgOTYgKysrKysrKysrKysrKysrKysrKysrKysKPj4gIDMgZmlsZXMgY2hhbmdlZCwgMTYx
IGluc2VydGlvbnMoKykKPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBzYW1wbGVzL2JwZi9uZXRmaWx0
ZXJfaXA0X2JsYWNrbGlzdC5icGYuYwo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHNhbXBsZXMvYnBm
L25ldGZpbHRlcl9pcDRfYmxhY2tsaXN0LmMKPgo+QWNjb3JkaW5nIHRvIGh0dHBzOi8vZG9jcy5r
ZXJuZWwub3JnL3Byb2Nlc3MvY29kaW5nLXN0eWxlLmh0bWwjbmFtaW5nCj55b3Ugc2hvdWxkIGF2
b2lkIG5ldyB1c2Ugb2YgYmxhY2tsaXN0LiBZb3Ugc2hvdWxkIHVzZSBzb21ldGhpbmsgbGlrZQo+
ZGVueWxpc3Qgb3IgYmxvY2tsaXN0IGluc3RlYWQuCgpUaGFua3MgZm9yIHRoZSBpbmZvcm1hdGlv
bn4hIApJIHdpbGwgbWFrZSB0aGUgY2hhbmdlcywgYW5kIHJlc2VuZCBhIHBhdGNoIGlmIHNhbXBs
ZXMvYnBmIGlzIHN0aWxsIGEgZ29vZCBwbGFjZSB0byBwdXQgdGhlIGNvZGUuCg==
