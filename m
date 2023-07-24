Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7875E68B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjGXBVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjGXBVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:21:02 -0400
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDBE91730;
        Sun, 23 Jul 2023 18:20:32 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.62] ) by
 ajax-webmail-mail-app2 (Coremail) ; Mon, 24 Jul 2023 09:19:14 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.62]
Date:   Mon, 24 Jul 2023 09:19:14 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Victor Nogueira" <victor@mojatatu.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <fe7cba2c-a0da-b1bd-1f0b-c6ecfa10de81@mojatatu.com>
References: <20230723075631.3712113-1-linma@zju.edu.cn>
 <fe7cba2c-a0da-b1bd-1f0b-c6ecfa10de81@mojatatu.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <225079a8.e02fc.189857aa264.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgBXX4uS0b1k8qhwCg--.27483W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwQFEmS8hHkF2QAGsv
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVmljdG9yLAoKPgo+IFNob3VsZG4ndCB0aGUgY2hlY2sgYmUgbmxhX2xlbihhdHRyKSAh
PSBzaXplb2YodTY0KT8KPiBBbiBhdHRyaWJ1dGUgd2l0aCBhIGJpZ2dlciBsZW5ndGggYWxzbyBz
ZWVtcyB0byBiZSBpbnZhbGlkLgo+IAo+IFlvdSBjb3VsZCBhbHNvIHNlcGFyYXRlIHRoaXMgY2hl
Y2sgaW50byBhbm90aGVyIGlmIHN0YXRlbWVudCwKPiBzbyB0aGF0IHRoZSBlcnJvciBtZXNzYWdl
IGlzIGNsZWFyZXIgaW4gcmVnYXJkcyB0byB3aHkgdGhlIGF0dHIgaXMKPiBpbnZhbGlkLiBTb21l
dGhpbmcgbGlrZToKPiAKPiBpZiAobmxhX2xlbihhdHRyKSAhPSBzaXplb2YodTY0KSkgewo+ICAg
ICAgICAgIE5MX1NFVF9FUlJfTVNHX0FUVFJfRk1UKGV4dGFjaywgYXR0ciwKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiQXR0cmlidXRlIGxlbmd0aCBleHBlY3RlZCB0byBiZSAl
bHUiLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZih1NjQpKTsKPiAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiB9Cj4gCj4gPiAgIAkJCQlOTF9TRVRfRVJSX01TR19B
VFRSKGV4dGFjaywgYXR0ciwKPiA+ICAgCQkJCQkJICAgICJBdHRyaWJ1dGUgdHlwZSBleHBlY3Rl
ZCB0byBiZSBUQ0FfTVFQUklPX01JTl9SQVRFNjQiKTsKPiA+ICAgCQkJCXJldHVybiAtRUlOVkFM
Owo+ID4gQEAgLTMwNyw3ICszMDgsOCBAQCBzdGF0aWMgaW50IG1xcHJpb19wYXJzZV9ubGF0dHIo
c3RydWN0IFFkaXNjICpzY2gsIHN0cnVjdCB0Y19tcXByaW9fcW9wdCAqcW9wdCwKPiA+ICAgCQlp
ID0gMDsKPiA+ICAgCQlubGFfZm9yX2VhY2hfbmVzdGVkKGF0dHIsIHRiW1RDQV9NUVBSSU9fTUFY
X1JBVEU2NF0sCj4gPiAgIAkJCQkgICAgcmVtKSB7Cj4gPiAtCQkJaWYgKG5sYV90eXBlKGF0dHIp
ICE9IFRDQV9NUVBSSU9fTUFYX1JBVEU2NCkgewo+ID4gKwkJCWlmIChubGFfdHlwZShhdHRyKSAh
PSBUQ0FfTVFQUklPX01BWF9SQVRFNjQgfHwKPiA+ICsJCQkgICAgbmxhX2xlbihhdHRyKSA8IHNp
emVvZih1NjQpKSB7Cj4gCj4gU2FtZSBhcyB0aGUgcHJldmlvdXMgY29tbWVudC4KPiAKPiA+ICAg
CQkJCU5MX1NFVF9FUlJfTVNHX0FUVFIoZXh0YWNrLCBhdHRyLAo+ID4gICAJCQkJCQkgICAgIkF0
dHJpYnV0ZSB0eXBlIGV4cGVjdGVkIHRvIGJlIFRDQV9NUVBSSU9fTUFYX1JBVEU2NCIpOwo+ID4g
ICAJCQkJcmV0dXJuIC1FSU5WQUw7Cj4gCj4gY2hlZXJzLAo+IFZpY3RvcgoKWWVhaCwgSSB1c2Ug
PCBpbnN0ZWFkIG9mICE9IGZvciBhIGxvb3NlciBjaGVjay4gSSBhZ3JlZSB3aXRoIHlvdSB0aGUg
IiE9IiBjb25kaXRpb24gYW5kIHRoZSBzZXBhcmF0aW9uIHN1Z2dlc3Rpb24uCkkgd2lsbCBwcmVw
YXJlIHRoZSB2MiBBU0FQLgoKVGhhbmtzCkxpbiAgCg==
