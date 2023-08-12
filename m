Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01079779CA0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 04:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjHLCfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 22:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjHLCfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:35:32 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB61130FB;
        Fri, 11 Aug 2023 19:35:29 -0700 (PDT)
Received: from linma$zju.edu.cn ( [10.181.217.213] ) by
 ajax-webmail-mail-app4 (Coremail) ; Sat, 12 Aug 2023 10:35:09 +0800
 (GMT+08:00)
X-Originating-IP: [10.181.217.213]
Date:   Sat, 12 Aug 2023 10:35:09 +0800 (GMT+08:00)
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
In-Reply-To: <20230811152634.271608c5@kernel.org>
References: <20230811031549.2011622-1-linma@zju.edu.cn>
 <20230811152634.271608c5@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <54e9d6f6.106b1a.189e798f8ae.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHjAnd79ZkkbHlCg--.64007W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwUFEmTW4nsAugABsB
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSmFrdWIsCgo+ID4gUHJvdmlkZSBzb21lIHN1Z2dlc3Rpb25zIHRoYXQgd2hvIGRlYWwg
d2l0aCBOZXRsaW5rIGNvZGUgY291bGQgZm9sbG93Cj4gPiAob2YgY291cnNlIHVzaW5nIHRoZSB3
b3JkICJiZXN0LXByYWN0aWNlcyIgbWF5IHNvdW5kIHNvbWV3aGF0Cj4gPiBleGFnZ2VyYXRlKS4K
PiAKPiBJIHRydWx5IGFwcHJlY2lhdGUgdGhlIGVmZm9ydCwgYnV0IEknbSB3b3JyaWVkIHRoaXMg
d2lsbCBvbmx5IGNvbmZ1c2UKPiBkZXZlbG9wZXJzLiBUaGlzIGRvY3VtZW50IGRvZXMgbm90IHJl
ZmxlY3QgdGhlIHJlYWxpdHkgb2Ygd3JpdGluZyBuZXcKPiBuZXRsaW5rIGZhbWlsaWVzIGF0IGFs
bC4gSXQncyBtb3JlIG9mIGEgaGlzdG9yaWMgcGVyc3BlY3RpdmUuCgpXaGlsZSBJIHVuZGVyc3Rh
bmQgeW91ciBjb25jZXJucywgSSBoYXZlIGEgc2xpZ2h0bHkgZGlmZmVyZW50IHBlcnNwZWN0aXZl
Cm9uIHRoZSBzdGF0ZW1lbnQgdGhhdCBpdCAiZG9lcyBub3QgcmVmbGVjdCB0aGUgcmVhbGl0eS4u
LiBhdCBhbGwuIgpUaGUgIkFib3V0IEdlbmVyYWwgTmV0bGluayBDYXNlIiBzZWN0aW9uIGRvZXMg
aGlnaGxpZ2h0IHNvbWUgaW1wb3J0YW50CmNvbnNpZGVyYXRpb25zIGZvciB3cml0aW5nIG5ldyBu
ZXRsaW5rIGZhbWlsaWVzLCBzdWNoIGFzIHVzaW5nIGhlbHBlcnMgdG8KYWNjZXNzIG5sYXR0ciBh
bmQgYXZvaWRpbmcgZGVwcmVjYXRlZCBwYXJzZXJzLgoKSG93ZXZlciwgSSBkbyBhY2tub3dsZWRn
ZSB0aGF0IHRoZSBzZWNvbmQgYmVzdCBwcmFjdGljZSBjb3VsZCBiZQpjb25mdXNpbmcsIGFzIGRl
dmVsb3BlcnMgd2hvIHVzZSBhdXRvIEMgY29kZSBnZW5lcmF0aW9uIG1heSBub3QgZW5jb3VudGVy
CnRoZSBpc3N1ZXMgbWVudGlvbmVkLgoKTW92aW5nIGZvcndhcmQsIEkgc3VnZ2VzdCB3ZSBjb25z
aWRlciB0aGUgZm9sbG93aW5nIG9wdGlvbnM6CgoxLiBVcGRhdGUgdGhlIGRvY3VtZW50IHRvIGFk
ZHJlc3MgdGhlIGNvbmZ1c2lvbiBhbmQgbWFrZSBpdCBtb3JlIHJlbGV2YW50CiAgIHRvIHRoZSBj
dXJyZW50IHN0YXRlIG9mIE5ldGxpbmsgZGV2ZWxvcG1lbnQuIE1heWJlIHRoZSBuZXdseSBhZGRl
ZAogICBzZWN0aW9uIHNlZW1zIG5vdCBlbm91Z2ggZm9yIHRoYXQuIEkgd291bGQgZ3JlYXRseSBh
cHByZWNpYXRlIGFueQogICBzcGVjaWZpYyBndWlkYW5jZS4gCjIuIElmIHRoZSBkb2N1bWVudCBp
cyBkZWVtZWQgdG9vIG91dGRhdGVkIGZvciBiZWluZyBrZXJuZWwgZG9jdW1lbnRhdGlvbiwKICAg
bWF5YmUgSSBzaG91bGQgcHVibGlzaCBpdCBzb21ld2hlcmUgZWxzZS4gRG8geW91IGhhdmUgYW55
CiAgIHJlY29tbWVuZGF0aW9ucyBvbiB3aGVyZSBpdCBjb3VsZCBiZSBiZXR0ZXIgc3VpdGVkPwoK
VGhhbmsgeW91IGZvciB5b3VyIHRpbWUgYW5kIGNvbnNpZGVyYXRpb24uIEhhdmUgYSBncmVhdCB3
ZWVrZW5kLiA6RAoKUmVnYXJkcwpMaW4=
