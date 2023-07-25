Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF42760A03
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGYGGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjGYGGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:06:00 -0400
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D2991BD3;
        Mon, 24 Jul 2023 23:05:52 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.62] ) by
 ajax-webmail-mail-app4 (Coremail) ; Tue, 25 Jul 2023 14:05:35 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.62]
Date:   Tue, 25 Jul 2023 14:05:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, ast@kernel.org, martin.lau@kernel.org,
        yhs@fb.com, void@manifault.com, andrii@kernel.org,
        houtao1@huawei.com, inwardvessel@gmail.com, kuniyu@amazon.com,
        songliubraving@fb.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230725055434.GM11388@unreal>
References: <20230725023330.422856-1-linma@zju.edu.cn>
 <20230725044409.GF11388@unreal>
 <15dc24fc.e7c38.1898b81ac08.Coremail.linma@zju.edu.cn>
 <20230725055434.GM11388@unreal>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7e61b9e3.e7d98.1898ba72993.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgB3fxcwZr9khacPCg--.50776W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwQHEmS-J3oE-QAMsh
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTGVvbiwKCj4gCj4gTXkgY29uY2VybiBpcyByZWxhdGVkIHRvIG1haW50YWluYWJpbGl0
eSBpbiBsb25nIHJ1bi4gWW91ciBjaGVjayBhZGRzCj4gYW5vdGhlciBsYXllciBvZiBjYWJhbCBr
bm93bGVkZ2Ugd2hpY2ggd2lsbCBiZSBjb3BpZWQvcGFzdGVkIGluIG90aGVyCj4gcGxhY2VzLgo+
IAo+IFRoYW5rcwo+IAoKWWVhaCwgSSBndWVzcyB5b3UgYXJlIHJpZ2h0LiBJIGd1ZXNzIEkgc2hv
dWxkIG5vdCBqdXN0ICpmaXgqIHRoaXMgaXNzdWUKYnV0IGFsc28gdGhpbmsgb2YgdGhlIG1haW50
YWluYWJpbGl0eS4gVGhlIHZlcnkgZmlyc3QgaWRlYSBwb3AgaW50byBteQptaW5kIGlzIHRvIGNv
bXBsZXRlIHRoZSBuZWNlc3NhcnkgbmxhX3BvbGljeSBoZW5jZSB0aGUgaW52YWxpZCBubGF0dHJz
CmNvdWxkIGJlIHJlamVjdGVkIGF0IHRoZSB2ZXJ5IGZpcnN0IHBsYWNlLgoKV2lsbCBzcGVuZCBt
b3JlIHRpbWUgb24gdGhpcy4KClJlZ2FyZHMKTGlu
