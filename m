Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E612C78A485
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjH1CNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjH1CNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:13:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25756132;
        Sun, 27 Aug 2023 19:12:46 -0700 (PDT)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RYvCw4N0xzrSMt;
        Mon, 28 Aug 2023 10:10:36 +0800 (CST)
Received: from dggpeml500007.china.huawei.com (7.185.36.75) by
 kwepemm000004.china.huawei.com (7.193.23.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 28 Aug 2023 10:12:12 +0800
Received: from dggpeml500007.china.huawei.com ([7.185.36.75]) by
 dggpeml500007.china.huawei.com ([7.185.36.75]) with mapi id 15.01.2507.031;
 Mon, 28 Aug 2023 10:12:12 +0800
From:   mengkanglai <mengkanglai2@huawei.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>,
        "Yanan (Euler)" <yanan@huawei.com>
Subject: ltp testcases failed due to commit cf3128a7aca
Thread-Topic: ltp testcases failed due to commit cf3128a7aca
Thread-Index: AdnZVQldr3VMVyCYRUKKPDyUsJEoDA==
Date:   Mon, 28 Aug 2023 02:12:12 +0000
Message-ID: <dd2a5ae913a84a36bded3dfeb4dbe466@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.136.115.4]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBJIHJ1biBsYXRlc3QgbHRwIHRlc3RjYXNlIHRlc3RjYXNlcy9uZXR3b3JrL3N0cmVzcy91
ZHAvdW5pLWJhc2ljL3VkcDYtdW5pLWJhc2ljMDcgd2l0aCBsYXRlc3Qga2VybmVsIDYuNSwgaXQg
ZmFpbGVkIGluIKGwbHRwYXBpY21kLmM6MTg4OiBGYWlsZWQgdG8gY29uZmlndXJlIFNBRC9TUEQg
b24gdGhlIGxvY2FsIGhvc3ShsS4NCkkgZm91bmQgdGhhdCB0aGUgcmVhc29uIGZvciBmYWlsdXJl
IHdhcyB0aGlzIGNvbW1hbmQ6DQpvdXRwdXRfaXBzZWNfY29uZiBzcmMgXA0KICAgICAgICAkSVBT
RUNfUFJPVE8gJElQU0VDX01PREUgJFNQSSAkbGhvc3RfYWRkciAkcmhvc3RfYWRkciBcDQogICAg
ICAgICAgICB8ICBzZXRrZXkgLWMgMj4mMSB8IHRlZSAkaXBzZWNfbG9nDQoNClRoaXMgY29tbWFu
ZCBldmVudHVhbGx5IHVzZSBzZXRrZXkgLWMgdG8gYWRkIHNwZGFkZCBlbnRyeSBmYWlsZWQ6DQpz
cGRhZGQgJHNyY19pcGFkZHIgJGRzdF9pcGFkZHIgYW55DQqhoaGhLVAgb3V0IGlwc2VjICRwcm90
b2NvbC90dW5uZWwvJHtzcmNfaXBhZGRyfS0ke2RzdF9pcGFkZHJ9L3VzZSA7IA0KDQpJdCByZXR1
cm5zIEludmFsaWQgYXJndW1lbnQuDQoNCkkgZm91bmQgdGhpcyBmYWlsZWQgZHVlIHRvIGNvbW1p
dCBjZjMxMjhhN2FjYShhZl9rZXk6IFJlamVjdCBvcHRpb25hbCB0dW5uZWwvQkVFVCBtb2RlIHRl
bXBsYXRlcyBpbiBvdXRib3VuZCBwb2xpY2llcyksIGlzIGxhdGVzdCBsdHAgdGVzdGNhc2VzIGFy
ZSBub3QgYWRhcHRlZD8gDQo=
