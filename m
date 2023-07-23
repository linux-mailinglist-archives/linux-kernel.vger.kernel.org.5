Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FC975E108
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjGWJs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGWJsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:48:54 -0400
X-Greylist: delayed 6945 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Jul 2023 02:48:50 PDT
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E60F010DC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:48:50 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.59] ) by
 ajax-webmail-mail-app3 (Coremail) ; Sun, 23 Jul 2023 17:48:46 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.59]
Date:   Sun, 23 Jul 2023 17:48:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length
 check
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
 <20230723050656-mutt-send-email-mst@kernel.org>
 <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgDnl5x+97xkwjmBCw--.34923W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwUFEmS8hHkFxAABs0
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4gU3VyZSwgdGhhdCBpcyBhbm90aGVyIHVuZGVyZ29pbmcgdGFzayBJJ20gd29ya2luZyBvbi4g
SWYgdGhlIG5sYXR0ciBpcyBwYXJzZWQgd2l0aAo+IE5MX1ZBTElEQVRFX1VOU1BFQywgYW55IGZv
cmdvdHRlbiBubGF0dHIgd2lsbCBiZSByZWplY3RlZCwgdGhlcmVmb3JlICh3aGljaCBpcyB0aGUg
ZGVmYXVsdAo+IGZvciBtb2Rlcm4gbmxhX3BhcnNlKS4gCgpGb3IgdGhlIGdlbmVyYWwgbmV0bGlu
ayBpbnRlcmZhY2UsIHRoZSBkZWNpZGluZyBmbGFnIHNob3VsZCBiZSBnZW5sX29wcy52YWxpZGF0
ZSBkZWZpbmVkIGluIAplYWNoIG9wcy4gVGhlIGRlZmF1bHQgdmFsaWRhdGUgZmxhZyBpcyBzdHJp
Y3QsIHdoaWxlIHRoZSBkZXZlbG9wZXIgY2FuIG92ZXJ3cml0ZSB0aGUgZmxhZyAKd2l0aCBHRU5M
X0RPTlRfVkFMSURBVEVfU1RSSUNUIHRvIGVhc2UgdGhlIHZhbGlkYXRpb24uIFRoYXQgaXMgdG8g
c2F5LCBzYWZlciBjb2RlIHNob3VsZCAKZW5mb3JjZSBOTF9WQUxJREFURV9TVFJJQ1QgYnkgbm90
IG92ZXJ3cml0aW5nIHRoZSB2YWxpZGF0ZSBmbGFnLgoKUmVncmFkcwpMaW4=
