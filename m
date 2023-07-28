Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433E7766840
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjG1JHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjG1JGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:06:44 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6815B3AA5;
        Fri, 28 Jul 2023 02:06:34 -0700 (PDT)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3cUcPhcNkLUSWBA--.43291S2;
        Fri, 28 Jul 2023 17:06:23 +0800 (CST)
Received: from zhangyiqun$phytium.com.cn ( [60.27.159.40] ) by
 ajax-webmail-mail (Coremail) ; Fri, 28 Jul 2023 17:06:21 +0800 (GMT+08:00)
X-Originating-IP: [60.27.159.40]
Date:   Fri, 28 Jul 2023 17:06:21 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5byg6L22576k?= <zhangyiqun@phytium.com.cn>
To:     "Herbert Xu" <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] crypto: all - alloc and init all req alloc as zero
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230428(d6537451) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-76b96e3b-3ecc-44d5-9200-de81e6d4c242-
In-Reply-To: <ZMIl1vSitJBU3UJS@gondor.apana.org.au>
References: <20230727080548.8666-1-zhangyiqun@phytium.com.cn>
 <ZMIl1vSitJBU3UJS@gondor.apana.org.au>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: zjxeZmZvb3Rlcl90eHQ9MTUwNzozODM=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6c3f5deb.197.1899bbfbd6f.Coremail.zhangyiqun@phytium.com.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AQAAfwDHTU4NhcNksIsAAA--.326W
X-CM-SenderInfo: x2kd0wp1lt30o6sk53xlxphulrpou0/1tbiAQAOCGTCwasCFwABsf
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=zhangyiqun
        @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZFW3AF4DWw45WF15Cr17KFg_yoW8Xw13pF
        ZxCr15GF4Yg3y8Ca47u3WxCryrW395uFyrtrW5X3s2yr43Zry7KasFkw4fuFyDJryrXw45
        uFW7K3WYqF1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWN0dWFsbHksIEkgbWV0IGEgcHJvYmxlbSBpbiBteSBvd24gZGV2ZWxvcG1lbnQuIEJlY2F1c2Ug
c29tZSBtZW1iZXJzIGluIHJlcQpzdHJ1Y3QgaXMgbm90IGludGlhbGl6ZWQsIHRoZXkgY2F1c2Ug
c29tZSBlcnJvcnMgaW4gdGVzdC4gSWYgd2UgY2hhbmdlIGttYWxsb2MKdG8ga3phbGxvYywgaXQg
Y2FuIGZhY2lsaXRhdGUgYWxsIGRldmVsb3BlcnMgdG8gY2FyZSBhYm91dCBpbmlhbGl6ZWQgYWxs
IAptZW1iZXJzLiBJIGhvcGUgbXkgaWRlYSBjYW4gY29udmluY2UgeW91LiBCdXQgSSB0aGluayB5
b3UgaGF2ZSBvdGhlcgppbXBvcnRhbnQgY29uc2lkZXJhdGlvbi4KClRoYW5rcywKCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlcy0tLS0tCj4gRnJvbTogIkhlcmJlcnQgWHUiIDxoZXJiZXJ0QGdvbmRv
ci5hcGFuYS5vcmcuYXU+Cj4gU2VuZCB0aW1lOlRodXJzZGF5LCAwNy8yNy8yMDIzIDE2OjA3OjUw
Cj4gVG86ICJaaGFuZyBZaXF1biIgPHpoYW5neWlxdW5AcGh5dGl1bS5jb20uY24+Cj4gQ2M6IGRh
dmVtQGRhdmVtbG9mdC5uZXQsIGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjcnlwdG86IGFsbCAt
IGFsbG9jIGFuZCBpbml0IGFsbCByZXEgYWxsb2MgYXMgemVybwo+IAo+IE9uIFRodSwgSnVsIDI3
LCAyMDIzIGF0IDA0OjA1OjQ4UE0gKzA4MDAsIFpoYW5nIFlpcXVuIHdyb3RlOgo+ID4gVGhpcyBw
YXRjaCBpcyB0byBjaGFuZ2UgYWxsIHJlcSBzdHJ1Y3QgYWxsb2MgZnVuY3Rpb24gZnJvbSBrbWFs
bG9jCj4gPiB0byBremFsbG9jLiBTb21ldGltZXMsIGl0IHdpbGwgaW5jdXIgc29tZSBlcnJvcnMg
d2l0aG91dCBpbml0aWFsaXplZAo+ID4gemVyby4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogWmhh
bmcgWWlxdW4gPHpoYW5neWlxdW5AcGh5dGl1bS5jb20uY24+Cj4gPiAtLS0KPiA+ICBpbmNsdWRl
L2NyeXB0by9ha2NpcGhlci5oIHwgMiArLQo+ID4gIGluY2x1ZGUvY3J5cHRvL2hhc2guaCAgICAg
fCAyICstCj4gPiAgaW5jbHVkZS9jcnlwdG8va3BwLmggICAgICB8IDIgKy0KPiA+ICBpbmNsdWRl
L2NyeXB0by9za2NpcGhlci5oIHwgMiArLQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IE5hY2suICBVbmxlc3MgeW91IGhhdmUgYSBzcGVj
aWZpYyBpc3N1ZSBwbGVhc2UgZG9uJ3Qgc3VibWl0IHZhZ3VlCj4gcGF0Y2hlcyBsaWtlIHRoaXMu
ICBZb3Ugc2hvdWxkIGFsd2F5cyBzdGF0ZSB3aGF0IGlzc3VlIGxlZCB5b3UgdG8KPiBtYWtlIGEg
Y2hhbmdlIGxpa2UgdGhpcy4KPiAKPiBUaGFua3MsCj4gLS0gCj4gRW1haWw6IEhlcmJlcnQgWHUg
PGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdT4KPiBIb21lIFBhZ2U6IGh0dHA6Ly9nb25kb3Iu
YXBhbmEub3JnLmF1L35oZXJiZXJ0Lwo+IFBHUCBLZXk6IGh0dHA6Ly9nb25kb3IuYXBhbmEub3Jn
LmF1L35oZXJiZXJ0L3B1YmtleS50eHQKCg0KDQrkv6Hmga/lronlhajlo7DmmI7vvJrmnKzpgq7k
u7bljIXlkKvkv6Hmga/lvZLlj5Hku7bkurrmiYDlnKjnu4Tnu4fmiYDmnIks5Y+R5Lu25Lq65omA
5Zyo57uE57uH5a+56K+l6YKu5Lu25oul5pyJ5omA5pyJ5p2D5Yip44CC6K+35o6l5pS26ICF5rOo
5oSP5L+d5a+GLOacque7j+WPkeS7tuS6uuS5pumdouiuuOWPryzkuI3lvpflkJHku7vkvZXnrKzk
uInmlrnnu4Tnu4flkozkuKrkurrpgI/pnLLmnKzpgq7ku7bmiYDlkKvkv6Hmga/jgIINCkluZm9y
bWF0aW9uIFNlY3VyaXR5IE5vdGljZTogVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlz
IG1haWwgaXMgc29sZWx5IHByb3BlcnR5IG9mIHRoZSBzZW5kZXIncyBvcmdhbml6YXRpb24uVGhp
cyBtYWlsIGNvbW11bmljYXRpb24gaXMgY29uZmlkZW50aWFsLlJlY2lwaWVudHMgbmFtZWQgYWJv
dmUgYXJlIG9ibGlnYXRlZCB0byBtYWludGFpbiBzZWNyZWN5IGFuZCBhcmUgbm90IHBlcm1pdHRl
ZCB0byBkaXNjbG9zZSB0aGUgY29udGVudHMgb2YgdGhpcyBjb21tdW5pY2F0aW9uIHRvIG90aGVy
cy4=

