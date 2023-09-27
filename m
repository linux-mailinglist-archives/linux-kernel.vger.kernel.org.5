Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B127AFA77
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjI0F5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0F5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:57:39 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AD9DF4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 22:57:35 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 13:56:08
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 13:56:08 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     rafael.j.wysocki@intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pnp: Clean up errors in pnp.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <13c70c43.85d.18ad53580c7.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwC3VUD4wxNlp+O9AA--.612W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAFEWFEYxtJMwAJs7
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFm
dGVyIHRoYXQgJzsnIChjdHg6VnhWKQoKU2lnbmVkLW9mZi1ieTogR3VvSHVhIENoZW5nIDxjaGVu
Z3VvaHVhQGphcmkuY24+Ci0tLQogaW5jbHVkZS9saW51eC9wbnAuaCB8IDggKysrKy0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9wbnAuaCBiL2luY2x1ZGUvbGludXgvcG5wLmgKaW5kZXggYzJhN2Nm
YmNhNzEzLi4yNjdmYjhhNGZiNmUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvcG5wLmgKKysr
IGIvaW5jbHVkZS9saW51eC9wbnAuaApAQCAtMjkxLDcgKzI5MSw3IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBwbnBfc2V0X2RydmRhdGEoc3RydWN0IHBucF9kZXYgKnBkZXYsIHZvaWQgKmRhdGEpCiAK
IHN0cnVjdCBwbnBfZml4dXAgewogCWNoYXIgaWRbN107Ci0Jdm9pZCAoKnF1aXJrX2Z1bmN0aW9u
KSAoc3RydWN0IHBucF9kZXYgKiBkZXYpOwkvKiBmaXh1cCBmdW5jdGlvbiAqLworCXZvaWQgKCpx
dWlya19mdW5jdGlvbikgKHN0cnVjdCBwbnBfZGV2ICpkZXYpOwkvKiBmaXh1cCBmdW5jdGlvbiAq
LwogfTsKIAogLyogY29uZmlnIHBhcmFtZXRlcnMgKi8KQEAgLTQxOSw4ICs0MTksOCBAQCBzdHJ1
Y3QgcG5wX3Byb3RvY29sIHsKIAogCS8qIHByb3RvY29sIHNwZWNpZmljIHN1c3BlbmQvcmVzdW1l
ICovCiAJYm9vbCAoKmNhbl93YWtldXApIChzdHJ1Y3QgcG5wX2RldiAqZGV2KTsKLQlpbnQgKCpz
dXNwZW5kKSAoc3RydWN0IHBucF9kZXYgKiBkZXYsIHBtX21lc3NhZ2VfdCBzdGF0ZSk7Ci0JaW50
ICgqcmVzdW1lKSAoc3RydWN0IHBucF9kZXYgKiBkZXYpOworCWludCAoKnN1c3BlbmQpIChzdHJ1
Y3QgcG5wX2RldiAqZGV2LCBwbV9tZXNzYWdlX3Qgc3RhdGUpOworCWludCAoKnJlc3VtZSkgKHN0
cnVjdCBwbnBfZGV2ICpkZXYpOwogCiAJLyogdXNlZCBieSBwbnAgbGF5ZXIgb25seSAobG9vayBi
dXQgZG9uJ3QgdG91Y2gpICovCiAJdW5zaWduZWQgY2hhciBudW1iZXI7CS8qIHByb3RvY29sIG51
bWJlciAqLwpAQCAtNDkyLDcgKzQ5Miw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHBucF9zdGFydF9k
ZXYoc3RydWN0IHBucF9kZXYgKmRldikgeyByZXR1cm4gLUVOT0RFVjsgfQogc3RhdGljIGlubGlu
ZSBpbnQgcG5wX3N0b3BfZGV2KHN0cnVjdCBwbnBfZGV2ICpkZXYpIHsgcmV0dXJuIC1FTk9ERVY7
IH0KIHN0YXRpYyBpbmxpbmUgaW50IHBucF9hY3RpdmF0ZV9kZXYoc3RydWN0IHBucF9kZXYgKmRl
dikgeyByZXR1cm4gLUVOT0RFVjsgfQogc3RhdGljIGlubGluZSBpbnQgcG5wX2Rpc2FibGVfZGV2
KHN0cnVjdCBwbnBfZGV2ICpkZXYpIHsgcmV0dXJuIC1FTk9ERVY7IH0KLXN0YXRpYyBpbmxpbmUg
aW50IHBucF9yYW5nZV9yZXNlcnZlZChyZXNvdXJjZV9zaXplX3Qgc3RhcnQsIHJlc291cmNlX3Np
emVfdCBlbmQpIHsgcmV0dXJuIDA7fQorc3RhdGljIGlubGluZSBpbnQgcG5wX3JhbmdlX3Jlc2Vy
dmVkKHJlc291cmNlX3NpemVfdCBzdGFydCwgcmVzb3VyY2Vfc2l6ZV90IGVuZCkgeyByZXR1cm4g
MDsgfQogCiAvKiBwcm90b2NvbCBoZWxwZXJzICovCiBzdGF0aWMgaW5saW5lIGludCBwbnBfaXNf
YWN0aXZlKHN0cnVjdCBwbnBfZGV2ICpkZXYpIHsgcmV0dXJuIDA7IH0KLS0gCjIuMTcuMQoK
