Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0A877D094
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbjHORGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbjHORGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:06:35 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76F9B1990;
        Tue, 15 Aug 2023 10:06:31 -0700 (PDT)
Received: from linma$zju.edu.cn ( [112.5.88.102] ) by ajax-webmail-mail-app4
 (Coremail) ; Wed, 16 Aug 2023 01:04:04 +0800 (GMT+08:00)
X-Originating-IP: [112.5.88.102]
Date:   Wed, 16 Aug 2023 01:04:04 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Jakub Kicinski" <kuba@kernel.org>
Cc:     corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, rdunlap@infradead.org, void@manifault.com,
        jani.nikula@intel.com, horms@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] docs: net: add netlink attrs best practices
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230814085318.090c832d@kernel.org>
References: <20230811031549.2011622-1-linma@zju.edu.cn>
 <20230811152634.271608c5@kernel.org>
 <54e9d6f6.106b1a.189e798f8ae.Coremail.linma@zju.edu.cn>
 <20230814085318.090c832d@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7cba74b5.10d19d.189fa27935c.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHTQoFsNtkbKYYCw--.7107W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwUIEmTa1vsUEQAAsK
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSmFrdWIsCgo+IAo+IE9uIFNhdCwgMTIgQXVnIDIwMjMgMTA6MzU6MDkgKzA4MDAgKEdN
VCswODowMCkgTGluIE1hIHdyb3RlOgo+ID4gTW92aW5nIGZvcndhcmQsIEkgc3VnZ2VzdCB3ZSBj
b25zaWRlciB0aGUgZm9sbG93aW5nIG9wdGlvbnM6Cj4gPiAKPiA+IDEuIFVwZGF0ZSB0aGUgZG9j
dW1lbnQgdG8gYWRkcmVzcyB0aGUgY29uZnVzaW9uIGFuZCBtYWtlIGl0IG1vcmUgcmVsZXZhbnQK
PiA+ICAgIHRvIHRoZSBjdXJyZW50IHN0YXRlIG9mIE5ldGxpbmsgZGV2ZWxvcG1lbnQuIE1heWJl
IHRoZSBuZXdseSBhZGRlZAo+ID4gICAgc2VjdGlvbiBzZWVtcyBub3QgZW5vdWdoIGZvciB0aGF0
LiBJIHdvdWxkIGdyZWF0bHkgYXBwcmVjaWF0ZSBhbnkKPiA+ICAgIHNwZWNpZmljIGd1aWRhbmNl
Lgo+IAo+IFVubGVzcyB3ZSBoYXZlIGRvY3MgZm9yIGtlcm5lbCBzaWRlIG9mIG1vZGVybiBnZW5l
dGxpbmsgYW55IHNvcnQgb2YKPiBpbmRpY2F0aW9uIHRoYXQgdGhpcyBkb2MgaXMgb25seSBhIGd1
aWRlIGZvciBsb29raW5nIGF0IG9sZCBjb2RlIHdpbGwKPiBmYWxsIG9uIGRlYWYgZWFycy4KPiAK
PiBTbyB5b3UnZCBuZWVkIHRvIHdyaXRlIGEgc2FtcGxlIGZhbWlseSBhbmQgZG9jcyBmb3IgbW9k
ZXJuIHN0dWZmLgoKR3JlYXQsIEkgZ3Vlc3MgSSAoZmluYWxseSkgdW5kZXJzdGFuZCB0aGUgc2l0
dWF0aW9uIGhlcmUuIEl0IHNlZW1zIHRoYXQKdGhpcyBkb2N1bWVudCBpcyBqdXN0IG9uZSBwaWVj
ZSBvZiB0aGUgcHV6emxlIHdoZW4gaXQgY29tZXMgdG8gdGhlIG1vZGVybgpnZW5lcmljIE5ldGxp
bmsuIEhlbmNlLCBJIHNob3VsZCB3cml0ZSBhIHNhbXBsZSBmYW1pbHkgYW5kIGRvY3MgZm9yIG1v
ZGVybgpzdHVmZiAobWFpbmx5IHRoZSBrZXJuZWwgc2lkZSkgYW5kIHRoZW4gbWFrZSB0aGlzIGRv
Y3VtZW50IG9uZSBwYXJ0IG9mIGl0LgoKPiAKPiA+IDIuIElmIHRoZSBkb2N1bWVudCBpcyBkZWVt
ZWQgdG9vIG91dGRhdGVkIGZvciBiZWluZyBrZXJuZWwgZG9jdW1lbnRhdGlvbiwKPiA+ICAgIG1h
eWJlIEkgc2hvdWxkIHB1Ymxpc2ggaXQgc29tZXdoZXJlIGVsc2UuIERvIHlvdSBoYXZlIGFueQo+
ID4gICAgcmVjb21tZW5kYXRpb25zIG9uIHdoZXJlIGl0IGNvdWxkIGJlIGJldHRlciBzdWl0ZWQ/
Cj4gCj4gR2l0SHViIGNvbWVzIHRvIG1pbmQgZm9yIHB1Ymxpc2hpbmcgUmVTVCBkb2NzLCBpbiB0
aGUgbWVhbnRpbWU/CgpObyB3b3JyaWVzLiBJJ20ganVzdCBicmFpbnN0b3JtaW5nIHdheXMgdG8g
bWFrZSB0aGVzZSBwcmFjdGljZXMgdXNlZnVsIGlmIHRoZXkKZGlkbid0IG1ha2UgaXQgaW50byB0
aGUga2VybmVsIGRvY3VtZW50IDpELgpBbGwgaW4gYWxsLCBJJ2xsIGZvbGxvdyB1cCBvbiBvdXIg
cHJldmlvdXMgZGlzY3Vzc2lvbiBhbmQgZmlsbCBpbiB0aGUgZ2FwcyBhcwpzb29uIGFzIHBvc3Np
YmxlLgoKUmVnYXJkcwpMaW4K
