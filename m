Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EB17EC109
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjKOLAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOLAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:00:43 -0500
Received: from m13123.mail.163.com (m13123.mail.163.com [220.181.13.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5950F5;
        Wed, 15 Nov 2023 03:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=AoAyeXRo37sAb5BjagZny7kRv3gGNX7G+jb8vQNNTQM=; b=R
        +1PCBCVTm2A3+5Bu/qxDLOTUG3vJv0jyj4TqBe391hWI3POtTopvzjHvMwZHMOOO
        xAxy9dxisFe+BQzkg4p24N//7m7h+SSFZyG3nznTVvrl4OI72zwkFHHUneMYnBKw
        PTKZ8pV/g+dWWHjYL7tFKUrl9fe8fMdELWcosqPqRE=
Received: from 00107082$163.com ( [111.35.186.243] ) by
 ajax-webmail-wmsvr123 (Coremail) ; Wed, 15 Nov 2023 18:59:34 +0800 (CST)
X-Originating-IP: [111.35.186.243]
Date:   Wed, 15 Nov 2023 18:59:34 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     "Peter Zijlstra" <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Regression or Fix]perf: profiling stats sigificantly changed
 for aio_write/read(ext4) between 6.7.0-rc1 and 6.6.0
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <20231115103241.GD3818@noisy.programming.kicks-ass.net>
References: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
 <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com>
 <20231115103241.GD3818@noisy.programming.kicks-ass.net>
X-NTES-SC: AL_Qu2bAvyfukEs4iedZOkZnEYQheY4XMKyuPkg1YJXOp80nivM6iAAWlhxL2LG0PyfMhmTlz+RcyhPxsJWVrZDXbyYQrtRD9l4TshPu4MwOLK3
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <407a06f8.632a.18bd2a2ece1.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: e8GowABnf6+XpFRlSckHAA--.4314W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiTBEpqmI0cRk0IwADs0
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIzLTExLTE1IDE4OjMyOjQxLCAiUGV0ZXIgWmlqbHN0cmEiIDxwZXRlcnpAaW5mcmFk
ZWFkLm9yZz4gd3JvdGU6Cj4KPk5hbWh5dW5nLCBjb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBsb29r
LCB5b3Uga25vdyBob3cgdG8gb3BlcmF0ZSB0aGlzCj5jZ3JvdXAgc3R1ZmYuCj4KCk1vcmUgaW5m
b3JtYXRpb24sICBJIHJ1biB0aGUgcHJvZmlsaW5nIHdpdGggOGNwdSBtYWNoaW5lIG9uIGEgU1NE
IHdpdGggZXh0NCBmaWxlc3lzdGVtIDoKCiMgbWtkaXIgL3N5cy9mcy9jZ3JvdXAvbXl0ZXN0CiMg
ZWNobyAkJCA+IC9zeXMvZnMvY2dyb3VwL215dGVzdC9jZ3JvdXAucHJvY3MKIyMgU3RhcnQgcHJv
ZmlsaW5nIHRhcmdldGluZyBjZ3JvdXAgL3N5cy9mcy9jZ3JvdXAvbXl0ZXN0ICAgb24gYW5vdGhl
ciB0ZXJtaW5hbAojIGZpbyAtLXJhbmRyZXBlYXQ9MSAtLWlvZW5naW5lPWxpYmFpbyAtLWRpcmVj
dD0xIC0tbmFtZT10ZXN0ICAtLWJzPTRrIC0taW9kZXB0aD02NCAtLXNpemU9MUcgLS1yZWFkd3Jp
dGU9cmFuZHJ3ICAtLXJ1bnRpbWU9NjAwIC0tbnVtam9icz00IC0tdGltZV9iYXNlZD0xCgpJIGdv
dCBhIGZlZWxpbmcgdGhhdCBmMDZjYzY2N2Y3OTkwIHdvdWxkIGRlY3JlYXNlIHRvdGFsIHNhbXBs
ZXMgYnkgMTAlfjIwJSB3aGVuIHByb2ZpbGluZyBJTyBiZW5jaG1hcmsgd2l0aGluIGNncm91cC4K
CgpEYXZpZCBXYW5n
