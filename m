Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2278B7604B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjGYBdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGYBdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:33:39 -0400
X-Greylist: delayed 5541 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Jul 2023 18:33:36 PDT
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B7F0170E;
        Mon, 24 Jul 2023 18:33:36 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.62] ) by
 ajax-webmail-mail-app2 (Coremail) ; Tue, 25 Jul 2023 09:33:12 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.62]
Date:   Tue, 25 Jul 2023 09:33:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Jakub Kicinski" <kuba@kernel.org>
Cc:     "Joe Perches" <joe@perches.com>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230724175612.0649ef67@kernel.org>
References: <20230724014625.4087030-1-linma@zju.edu.cn>
 <20230724160214.424573ac@kernel.org>
 <63d69a72.e2656.1898a66ca22.Coremail.linma@zju.edu.cn>
 <20230724175612.0649ef67@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <150f7e19.e27f3.1898aadc871.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgDn74tZJr9kNXyBCg--.39653W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwMHEmS91fkWAgADs3
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFrdWIsCgo+ID4gPiA+IFRoZSBubGFfZm9yX2VhY2hfbmVzdGVkIHBhcnNpbmcgaW4gZnVu
Y3Rpb24gbXFwcmlvX3BhcnNlX25sYXR0cigpIGRvZXMKPiA+ID4gPiBub3QgY2hlY2sgdGhlIGxl
bmd0aCBvZiB0aGUgbmVzdGVkIGF0dHJpYnV0ZS4gVGhpcyBjYW4gbGVhZCB0byBhbgo+ID4gPiA+
IG91dC1vZi1hdHRyaWJ1dGUgcmVhZCBhbmQgYWxsb3cgYSBtYWxmb3JtZWQgbmxhdHRyIChlLmcu
LCBsZW5ndGggMCkgdG8KPiA+ID4gPiBiZSB2aWV3ZWQgYXMgOCBieXRlIGludGVnZXIgYW5kIHBh
c3NlZCB0byBwcml2LT5tYXhfcmF0ZS9taW5fcmF0ZS4KPiA+ID4gPiAKPiA+ID4gPiBUaGlzIHBh
dGNoIGFkZHMgdGhlIGNoZWNrIGJhc2VkIG9uIG5sYV9sZW4oKSB3aGVuIGNoZWNrIHRoZSBubGFf
dHlwZSgpLAo+ID4gPiA+IHdoaWNoIGVuc3VyZXMgdGhhdCB0aGUgbGVuZ3RoIG9mIHRoZXNlIHR3
byBhdHRyaWJ1dGUgbXVzdCBlcXVhbHMKPiA+ID4gPiBzaXplb2YodTY0KS4gIAo+ID4gPiAKPiA+
ID4gSG93IGRvIHlvdSBydW4gZ2V0X21haW50YWluZXI/IFlvdSBkaWRuJ3QgQ0MgdGhlIGF1dGhv
ciBvZiB0aGUgY29kZS4gIAo+ID4gCj4gPiBUaGF0J3Mgd2VpcmQsIEkganVzdCByYW4gY29kZSBi
ZWxvdyBhbmQgc2VuZCB0aGlzIHBhdGNoIHRvIGFsbCA5IGVtYWlscyBwb3BlZCBvdXQuCj4gPiAK
PiA+ICMgLi9zY3JpcHRzL2dldF9tYWludGFpbmVyLnBsIG5ldC9zY2hlZC9zY2hfbXFwcmlvLmMK
PiAKPiBKb2UsIGhlcmUncyBhbm90aGVyIGNhc2UuCj4gCj4gTGluIE1hLCB5b3UgbmVlZCB0byBy
dW4gdGhlIHNjcmlwdCBvbiB0aGUgZmlsZSBnZW5lcmF0ZWQgYnkgCj4gZ2l0IGZvcm1hdC1wYXRj
aCwgcmF0aGVyIHRoYW4gdGhlIGZpbGUgcGF0aC4gVGhhdCBnaXZlcyBiZXR0ZXIKPiBjb3ZlcmFn
ZSBmb3Iga2V5d29yZHMgaW5jbHVkZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIChlc3BlY2lhbGx5
IAo+IHRoZSBGaXhlcyB0YWcpLiBQbGVhc2UgcmVydW4gaXQgb24gdGhlIHBhdGNoIGFuZCByZXBv
c3Qgd2l0aCAKPiB0aGUgcmlnaHQgQ0MgbGlzdC4KCkNvcHkgdGhhdC4gU29ycnkgZm9yIHRoZSBp
bmNvbnZlbmllbmNlIHRoYXQgd2FzIHJhaXNlZCBieSB0aGF0LiBXaWxsIApyZXNlbmQgdGhlIHBh
dGNoIHdpdGggdGhlIGNvcnJlY3QgQ0MgbGlzdCBBU0FQLgoKUmVnYXJkcwpMaW4KCj4gLS0gCj4g
cHctYm90OiBjcgo=
