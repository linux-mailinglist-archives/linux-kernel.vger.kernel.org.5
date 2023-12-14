Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B898130E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573205AbjLNNFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573200AbjLNNFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:05:45 -0500
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C07C3125;
        Thu, 14 Dec 2023 05:05:51 -0800 (PST)
Received: from alexious$zju.edu.cn ( [124.90.104.65] ) by
 ajax-webmail-mail-app2 (Coremail) ; Thu, 14 Dec 2023 21:05:27 +0800
 (GMT+08:00)
X-Originating-IP: [124.90.104.65]
Date:   Thu, 14 Dec 2023 21:05:27 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   alexious@zju.edu.cn
To:     "Jakub Kicinski" <kuba@kernel.org>
Cc:     "Chris Snook" <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Simon Horman" <horms@kernel.org>,
        "Yuanjun Gong" <ruc_gongyuanjun@163.com>,
        "Jie Yang" <jie.yang@atheros.com>,
        "Jeff Garzik" <jgarzik@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] [v2] ethernet: atheros: fix a memleak in
 atl1e_setup_ring_resources
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20231211191447.0408689d@kernel.org>
References: <20231208082316.3384650-1-alexious@zju.edu.cn>
 <20231211191447.0408689d@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <632c5358.35eae.18c686e98f2.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgDnDiqY_Xpl526SAA--.29775W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAggGAGV23RYUMAAGs2
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4gT24gRnJpLCAgOCBEZWMgMjAyMyAxNjoyMzoxNCArMDgwMCBaaGlwZW5nIEx1IHdyb3RlOgo+
ID4gdjI6IFNldHRpbmcgdHhfcmluZy0+dHhfYnVmZmVyIHRvIE5VTEwgYWZ0ZXIgZnJlZS4KPiAK
PiBIYXZpbmcgY2xvc2VyIGxvb2sgYXQgdGhpcyBkcml2ZXIgIC0gaXQgdHJpZXMgdG8gZnJlZSBi
b3RoIG9uIGNsb3NlIGFuZAo+IHJlbW92ZSwgc28gc2VlbXMgbGlrZSB3ZSBkbyBpbmRlZWQgaGF2
ZSB0byBOVUxMLW91dCB0aGUgcG9pbnRlciwgc2lnaC4KPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9hdGhlcm9zL2F0bDFlL2F0bDFlX21haW4uYyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2F0aGVyb3MvYXRsMWUvYXRsMWVfbWFpbi5jCj4gPiBpbmRleCA1OTM1YmUxOTBi
OWUuLjFiZmZlNzc0MzlhYyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2F0
aGVyb3MvYXRsMWUvYXRsMWVfbWFpbi5jCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9h
dGhlcm9zL2F0bDFlL2F0bDFlX21haW4uYwo+ID4gQEAgLTg2Niw2ICs4NjYsOCBAQCBzdGF0aWMg
aW50IGF0bDFlX3NldHVwX3JpbmdfcmVzb3VyY2VzKHN0cnVjdCBhdGwxZV9hZGFwdGVyICphZGFw
dGVyKQo+ID4gIAkJbmV0ZGV2X2VycihhZGFwdGVyLT5uZXRkZXYsICJvZmZzZXQoJWQpID4gcmlu
ZyBzaXplKCVkKSAhIVxuIiwKPiA+ICAJCQkgICBvZmZzZXQsIGFkYXB0ZXItPnJpbmdfc2l6ZSk7
Cj4gPiAgCQllcnIgPSAtMTsKPiA+ICsJCWtmcmVlKHR4X3JpbmctPnR4X2J1ZmZlcik7Cj4gPiAr
CQl0eF9yaW5nLT50eF9idWZmZXIgPSBOVUxMOwo+ID4gIAkJZ290byBmYWlsZWQ7Cj4gCj4gUGxl
YXNlIGFkZCBhIG5ldyBqdW1wIHRhcmdldCwgdGhvLCBhbmQgbW92ZSB0aGUgZnJlZWluZyB0aGVy
ZS4KPiBUaGVyZSdzIGEgc21hbGwgY2hhbmNlIHNvbWVvbmUgd2lsbCBhZGQgbW9yZSBjb2RlIHRv
IHRoaXMgZnVuY3Rpb24KPiBhbmQgaXQgd2lsbCBuZWVkIHRvIGNvcHkgLyBwYXN0ZSB0aGlzIHVu
d2luZC4KPiAtLSAKClRoYW5rIHlvdSBmb3IgeW91ciBhZHZpY2UsIEkndmUgc2VuZCBhIHYzIHZl
cnNpb24gb2YgdGhpcyBwYXRjaC4K
