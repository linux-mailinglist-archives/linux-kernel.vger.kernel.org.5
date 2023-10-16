Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19A77C9E34
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 06:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjJPE0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 00:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjJPE0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 00:26:43 -0400
X-Greylist: delayed 395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Oct 2023 21:26:35 PDT
Received: from cstnet.cn (smtp87.cstnet.cn [159.226.251.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75612DC
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 21:26:35 -0700 (PDT)
Received: from huangsicong$iie.ac.cn ( [159.226.94.118] ) by
 ajax-webmail-APP-17 (Coremail) ; Mon, 16 Oct 2023 12:19:48 +0800
 (GMT+08:00)
X-Originating-IP: [159.226.94.118]
Date:   Mon, 16 Oct 2023 12:19:48 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6buE5oCd6IGq?= <huangsicong@iie.ac.cn>
To:     dushistov@mail.ru
Cc:     linux-kernel@vger.kernel.org
Subject: PROBLEM: NULL pointer dereference error in the
 "ufs_put_super_internal" function
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230321(1bf45b10)
 Copyright (c) 2002-2023 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2802cec3.265e.18b36b6261e.Coremail.huangsicong@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: qgCowAAHqPHkuSxln68UAA--.33873W
X-CM-SenderInfo: xkxd0wpvlf003j6lxvwodfhubq/1tbiCggDC2UpTSuObgACsC
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

TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGVycm9yIG1heSBvY2N1ciBpbiAidWZzX3B1dF9zdXBl
cl9pbnRlcm5hbCIgZnVuY3Rpb24uCgpUaGUgInVmc19wdXRfc3VwZXJfaW50ZXJuYWwiIGZ1bmN0
aW9uIGxvY2F0ZWQgaW4gImZzL3Vmcy9zdXBlci5jIiBtYXkgb2NjdXIgYSBOVUxMIHBvaW50ZXIg
ZGVyZWZlcmVuY2UgZXJyb3Igd2hlbiBpdCBjYWxscyB0aGUgZnVuY3Rpb24gInViaF9tZW1jcHl1
YmgiIGRlZmluZWQgaW4gImZzL3Vmcy91dGlsLmMiLiBUaGUgcmVsZXZhbnQgY29kZSBkZWZpbml0
aW9ucyBhcmUgYXMgZm9sbG93czoKdWJoID0gdWJoX2JyZWFkKHNiLCB1c3BpLSZndDtzX2NzYWRk
ciArIGksIHNpemUpOyAgCnViaF9tZW1jcHl1YmggKHViaCwgc3BhY2UsIHNpemUpOwoKSXQgd2ls
bCBjYWxsICJ1YmhfYnJlYWQiIGZ1bmN0aW9uIHRvIGFsbG9jYXRlIGVub3VnaCBtZW1vcnkgdG8g
c3RvcmUgdGhlIHZhcmlhYmxlICJ1YmgiLiBUaGUgInViaF9icmVhZCIgZnVuY3Rpb24gbWF5IHJl
dHVybiBOVUxMIGluIHZhcmlvdXMgc2l0dWF0aW9ucywgZXNwZWNpYWxseSB3aGVuIGNhbGxpbmcg
ImttYWxsb2MiIGZ1bmN0aW9uLiBJZiB0aGVyZSBhcmUgc2lnbmlmaWNhbnQgbWVtb3J5IGZyYWdt
ZW50YXRpb24gaXNzdWVzLCBpbnN1ZmZpY2llbnQgZnJlZSBtZW1vcnkgYmxvY2tzLCBvciBpbnRl
cm5hbCBlcnJvcnMgaW4gdGhlIGFsbG9jYXRpb24gZnVuY3Rpb24sIHRoZSAia21hbGxvYyIgZnVu
Y3Rpb24gd2lsbCByZXR1cm4gTlVMTC4gRmluYWxseSwgdGhlICJ1YmgiIHZhcmlhYmxlIHdpbGwg
Z2V0IE5VTEzvvIwgYW5kIHRoZSAidWJoIiB3aWxsIGJlIHBhc3NlZCBhcyB0aGUgZmlyc3QgcGFy
YW1ldGVyIHRvIHRoZSAidWJoX21lbWNweXViaCIgZnVuY3Rpb24uICBUaGlzIGZ1bmN0aW9uIHdp
bGwgZXhlY3V0ZSB0aGUgZm9sbG93aW5nIGNvZGUgc25pcHBldDoKaWYgKHNpemUgJmd0OyAodWJo
LSZndDtjb3VudCAmbHQ7Jmx0OyB1c3BpLSZndDtzX2ZzaGlmdCkpCnNpemUgPSB1YmgtJmd0O2Nv
dW50ICZsdDsmbHQ7IHVzcGktJmd0O3NfZnNoaWZ0OwoKSWYgdGhlICJ1YmgiIHZhcmlhYmxlIGlz
IE5VTEwsIGl0IHdpbGwgY2F1c2UgYW4gZXJyb3IuIFNvIEkgdGhpbmsgdGhhdCBhIG51bGwgcG9p
bnRlciBjaGVjayBzaG91bGQgYmUgYWRkZWQgaW4gdGhlIGZ1bmN0aW9uICJ1ZnNfcHV0X3N1cGVy
X2ludGVybmFsIi4KCk15IGV4cGVyaW1lbnRhbCBrZXJuZWwgdmVyc2lvbiBpcyAiTElOVVggNi4x
IiwgYW5kIHRoaXMgcHJvYmxlbSBleGlzdHMgaW4gYWxsIHRoZSB2ZXJzaW9uIGZyb20gIkxJTlVY
IHYzLjAtcmMxIiB0byAiTElOVVggdjYuNi1yYzUiLgoKQmVzdCByZWdhcmRzLApTaWNvbmcgSHVh
bmcKCgo=
