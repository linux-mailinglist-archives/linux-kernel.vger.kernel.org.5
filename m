Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32D27C7BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjJMCrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMCrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:47:20 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DEFC83;
        Thu, 12 Oct 2023 19:47:19 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 10:45:31
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 10:45:31 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: Clean up errors in edac.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <631078e4.93f.18b26ecbdaf.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDnhD9LryhliNfBAA--.644W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAGAACsH
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKClNpZ25lZC1vZmYtYnk6IEd1b0h1YSBD
aGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGluY2x1ZGUvbGludXgvZWRhYy5oIHwgOCAr
KysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2VkYWMuaCBiL2luY2x1ZGUvbGludXgvZWRhYy5o
CmluZGV4IGZhNGJkYTJhNzBmNi4uYzFmNWE3ZWU4YjZlIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xp
bnV4L2VkYWMuaAorKysgYi9pbmNsdWRlL2xpbnV4L2VkYWMuaApAQCAtNTE1LDI0ICs1MTUsMjQg
QEAgc3RydWN0IG1lbV9jdGxfaW5mbyB7CiAJICAgaW50ZXJuYWwgcmVwcmVzZW50YXRpb24gYW5k
IGNvbmZpZ3VyZXMgd2hhdGV2ZXIgZWxzZSBuZWVkcwogCSAgIHRvIGJlIGNvbmZpZ3VyZWQuCiAJ
ICovCi0JaW50ICgqc2V0X3NkcmFtX3NjcnViX3JhdGUpIChzdHJ1Y3QgbWVtX2N0bF9pbmZvICog
bWNpLCB1MzIgYncpOworCWludCAoKnNldF9zZHJhbV9zY3J1Yl9yYXRlKSAoc3RydWN0IG1lbV9j
dGxfaW5mbyAqbWNpLCB1MzIgYncpOwogCiAJLyogR2V0IHRoZSBjdXJyZW50IHNkcmFtIG1lbW9y
eSBzY3J1YiByYXRlIGZyb20gdGhlIGludGVybmFsCiAJICAgcmVwcmVzZW50YXRpb24gYW5kIGNv
bnZlcnRzIGl0IHRvIHRoZSBjbG9zZXN0IG1hdGNoaW5nCiAJICAgYmFuZHdpZHRoIGluIGJ5dGVz
L3NlYy4KIAkgKi8KLQlpbnQgKCpnZXRfc2RyYW1fc2NydWJfcmF0ZSkgKHN0cnVjdCBtZW1fY3Rs
X2luZm8gKiBtY2kpOworCWludCAoKmdldF9zZHJhbV9zY3J1Yl9yYXRlKSAoc3RydWN0IG1lbV9j
dGxfaW5mbyAqbWNpKTsKIAogCiAJLyogcG9pbnRlciB0byBlZGFjIGNoZWNraW5nIHJvdXRpbmUg
Ki8KLQl2b2lkICgqZWRhY19jaGVjaykgKHN0cnVjdCBtZW1fY3RsX2luZm8gKiBtY2kpOworCXZv
aWQgKCplZGFjX2NoZWNrKSAoc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpKTsKIAogCS8qCiAJICog
UmVtYXBzIG1lbW9yeSBwYWdlczogY29udHJvbGxlciBwYWdlcyB0byBwaHlzaWNhbCBwYWdlcy4K
IAkgKiBGb3IgbW9zdCBNQydzLCB0aGlzIHdpbGwgYmUgTlVMTC4KIAkgKi8KIAkvKiBGSVhNRSAt
IHdoeSBub3Qgc2VuZCB0aGUgcGh5cyBwYWdlIHRvIGJlZ2luIHdpdGg/ICovCi0JdW5zaWduZWQg
bG9uZyAoKmN0bF9wYWdlX3RvX3BoeXMpIChzdHJ1Y3QgbWVtX2N0bF9pbmZvICogbWNpLAorCXVu
c2lnbmVkIGxvbmcgKCpjdGxfcGFnZV90b19waHlzKSAoc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNp
LAogCQkJCQkgICB1bnNpZ25lZCBsb25nIHBhZ2UpOwogCWludCBtY19pZHg7CiAJc3RydWN0IGNz
cm93X2luZm8gKipjc3Jvd3M7Ci0tIAoyLjE3LjEK
