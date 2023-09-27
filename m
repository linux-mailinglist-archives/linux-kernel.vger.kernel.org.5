Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6BC7AFEC1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjI0Iil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjI0Iij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:38:39 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB3829F;
        Wed, 27 Sep 2023 01:38:37 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 16:37:19
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 16:37:19 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: Clean up errors in sni_53c710.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <11d7b9cb.88b.18ad5c91580.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD+_6RNlUPq9AA--.629W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwAps6
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwoKU2lnbmVkLW9m
Zi1ieTogR3VvSHVhIENoZW5nIDxjaGVuZ3VvaHVhQGphcmkuY24+Ci0tLQogZHJpdmVycy9zY3Np
L3NuaV81M2M3MTAuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zbmlfNTNjNzEwLmMgYi9kcml2
ZXJzL3Njc2kvc25pXzUzYzcxMC5jCmluZGV4IDY3ODY1MWI5YjRkZC4uZTIyNjIyNWQxMjM3IDEw
MDY0NAotLS0gYS9kcml2ZXJzL3Njc2kvc25pXzUzYzcxMC5jCisrKyBiL2RyaXZlcnMvc2NzaS9z
bmlfNTNjNzEwLmMKQEAgLTg2LDcgKzg2LDcgQEAgc3RhdGljIGludCBzbmlybTcxMF9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpCiAJaG9zdC0+aXJxID0gcmMgPSBwbGF0Zm9ybV9n
ZXRfaXJxKGRldiwgMCk7CiAJaWYgKHJjIDwgMCkKIAkJZ290byBvdXRfcHV0X2hvc3Q7Ci0JaWYo
cmVxdWVzdF9pcnEoaG9zdC0+aXJxLCBOQ1JfNzAwX2ludHIsIElSUUZfU0hBUkVELCAic25pcm03
MTAiLCBob3N0KSkgeworCWlmIChyZXF1ZXN0X2lycShob3N0LT5pcnEsIE5DUl83MDBfaW50ciwg
SVJRRl9TSEFSRUQsICJzbmlybTcxMCIsIGhvc3QpKSB7CiAJCXByaW50ayhLRVJOX0VSUiAic25p
cm03MTA6IHJlcXVlc3RfaXJxIGZhaWxlZCFcbiIpOwogCQlnb3RvIG91dF9wdXRfaG9zdDsKIAl9
Ci0tIAoyLjE3LjEK
