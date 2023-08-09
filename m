Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC977504E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjHIBZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHIBZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:25:35 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29188173F;
        Tue,  8 Aug 2023 18:25:29 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.58] ) by
 ajax-webmail-mail-app4 (Coremail) ; Wed, 9 Aug 2023 09:25:06 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.58]
Date:   Wed, 9 Aug 2023 09:25:06 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Jakub Kicinski" <kuba@kernel.org>
Cc:     corbet@lwn.net, void@manifault.com, jani.nikula@intel.com,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: staging: add netlink attrs best practices
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230808123755.43610137@kernel.org>
References: <20230808035636.148552-1-linma@zju.edu.cn>
 <20230808123755.43610137@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7cf8fc98.1012f6.189d7e5c45a.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHjAnz6tJkKEbBCg--.61594W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwICEmTRnHsXDgAAsa
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSmFrdWIsCgo+IE9oLCB5b3UgcHV0IHF1aXRlIHNvbWUgZWZmb3J0IGludG8gdGhpcyEK
PiAKPiBJIGhhdmUgYSBoYXJkIHRpbWUgY29taW5nIHVwIHdpdGggcmVhc29uYWJsZSByZXZpZXcg
Y29tbWVudHMsIGJlY2F1c2UKPiB3aGlsZSB0aGUgZG9jIGlzIGluZm9ybWF0aXZlIGFuZCBwcmV0
dHkgY29ycmVjdCwgaXQgZm9jdXNlcyBvbiB3aGF0J3MKPiBsZWdhY3kgdXNlIG9mIG5ldGxpbmsg
YXQgdGhpcyBwb2ludC4gUGVvcGxlIHdyaXRpbmcgbmV3IGNvZGUgd2lsbCBvbmx5Cj4gZ2V0IGNv
bmZ1c2Ugd2l0aCB0aGlzIGluZm9ybWF0aW9uIDooCgpPb3BzLCBteSBiYWQsIEkgd2lsbCBzb21l
d2hhdCBhZGp1c3QgdGhlIGNvbnRlbnQgc3RydWN0dXJlLCBvciBqdXN0IGNsYWltCnRvIGp1c3Qg
Y29uY2VybiBsZWdhY3kgdXNlIGZvciBzaW1wbGljaXR5IGFuZCBhdm9pZCBjb25mdXNpb24uCgo+
IAo+IE1vZGVybiBmYW1pbGllcyBhcmUgYWxsIGdlbmVyaWMgbmV0bGluaywgYW5kIHZhbGlkYXRp
b24gaXMgdGFrZW4gY2FyZQo+IG9mIGluIHRoZSBjb3JlIDooCj4gCgpPSywgeW91IGFyZSByaWdo
dC4KCj4gSWYgeW91IHBvc3QgYSB2MiBwbGVhc2UgbWFrZSBzdXJlIHRvIENDIG5ldGRldkAKCkkg
c2VlLiBJdCBhcHBlYXJzIHRoYXQgdGhlIGlzc3VlIGlzIGR1ZSB0byBhbiBTTVRQIGVycm9yLiwg
d2lsbCB3YXRjaApvdXQgdGhpcy4KClJlZ2FyZHMKTGlu
