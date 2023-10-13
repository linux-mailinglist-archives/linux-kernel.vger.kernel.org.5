Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D677C7BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjJMDUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMDT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:19:56 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97CA891;
        Thu, 12 Oct 2023 20:19:52 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 11:18:10
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 11:18:10 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     m@bues.ch
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ssb: Clean up errors in ssb_driver_gige.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <23127c9a.945.18b270aa249.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD_ytihlYdjBAA--.745W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAGQAPsL
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKClNpZ25lZC1vZmYtYnk6IEd1b0h1YSBD
aGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGluY2x1ZGUvbGludXgvc3NiL3NzYl9kcml2
ZXJfZ2lnZS5oIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zc2Ivc3NiX2RyaXZlcl9n
aWdlLmggYi9pbmNsdWRlL2xpbnV4L3NzYi9zc2JfZHJpdmVyX2dpZ2UuaAppbmRleCAyOGMxNDVh
NTFlNTcuLjU1YzBiYjM5YTQxMCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9zc2Ivc3NiX2Ry
aXZlcl9naWdlLmgKKysrIGIvaW5jbHVkZS9saW51eC9zc2Ivc3NiX2RyaXZlcl9naWdlLmgKQEAg
LTU1LDcgKzU1LDcgQEAgc3RydWN0IHNzYl9naWdlIHsKIGV4dGVybiBib29sIHBkZXZfaXNfc3Ni
X2dpZ2VfY29yZShzdHJ1Y3QgcGNpX2RldiAqcGRldik7CiAKIC8qIENvbnZlcnQgYSBwY2lfZGV2
IHBvaW50ZXIgdG8gYSBzc2JfZ2lnZSBwb2ludGVyLiAqLwotc3RhdGljIGlubGluZSBzdHJ1Y3Qg
c3NiX2dpZ2UgKiBwZGV2X3RvX3NzYl9naWdlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQorc3RhdGlj
IGlubGluZSBzdHJ1Y3Qgc3NiX2dpZ2UgKnBkZXZfdG9fc3NiX2dpZ2Uoc3RydWN0IHBjaV9kZXYg
KnBkZXYpCiB7CiAJaWYgKCFwZGV2X2lzX3NzYl9naWdlX2NvcmUocGRldikpCiAJCXJldHVybiBO
VUxMOwpAQCAtNjYsNyArNjYsNyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBzc2JfZ2lnZSAqIHBk
ZXZfdG9fc3NiX2dpZ2Uoc3RydWN0IHBjaV9kZXYgKnBkZXYpCiBzdGF0aWMgaW5saW5lIGJvb2wg
c3NiX2dpZ2VfaXNfcmdtaWkoc3RydWN0IHBjaV9kZXYgKnBkZXYpCiB7CiAJc3RydWN0IHNzYl9n
aWdlICpkZXYgPSBwZGV2X3RvX3NzYl9naWdlKHBkZXYpOwotCXJldHVybiAoZGV2ID8gZGV2LT5o
YXNfcmdtaWkgOiAwKTsKKwlyZXR1cm4gZGV2ID8gZGV2LT5oYXNfcmdtaWkgOiAwOwogfQogCiAv
KiBSZXR1cm5zIHdoZXRoZXIgd2UgaGF2ZSBhIFJvYm9zd2l0Y2guICovCkBAIC0xNjEsNyArMTYx
LDcgQEAgc3RhdGljIGlubGluZSBib29sIHBkZXZfaXNfc3NiX2dpZ2VfY29yZShzdHJ1Y3QgcGNp
X2RldiAqcGRldikKIHsKIAlyZXR1cm4gZmFsc2U7CiB9Ci1zdGF0aWMgaW5saW5lIHN0cnVjdCBz
c2JfZ2lnZSAqIHBkZXZfdG9fc3NiX2dpZ2Uoc3RydWN0IHBjaV9kZXYgKnBkZXYpCitzdGF0aWMg
aW5saW5lIHN0cnVjdCBzc2JfZ2lnZSAqcGRldl90b19zc2JfZ2lnZShzdHJ1Y3QgcGNpX2RldiAq
cGRldikKIHsKIAlyZXR1cm4gTlVMTDsKIH0KLS0gCjIuMTcuMQo=
