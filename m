Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE967855FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjHWKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjHWJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:41:48 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF15110B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:37:38 -0700 (PDT)
Received: from chenxuebing$jari.cn ( [125.70.163.142] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 23 Aug 2023 17:37:13
 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.142]
Date:   Wed, 23 Aug 2023 17:37:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/amdgpu: Clean up errors in amdgpu_vf_error.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5fb7dc6d.628.18a21c158e8.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD9K0+VkDm+QAA--.478W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAMCmTkgo0AVgAGsY
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
c3BhY2UgcHJvaGliaXRlZCBiZWZvcmUgb3BlbiBzcXVhcmUgYnJhY2tldCAnWycKRVJST1I6IHNw
YWNlIHByb2hpYml0ZWQgYmVmb3JlIHRoYXQgJysrJyAoY3R4Old4TykKRVJST1I6IHNwYWNlcyBy
ZXF1aXJlZCBhcm91bmQgdGhhdCAnPScgKGN0eDpXeFYpCgpTaWduZWQtb2ZmLWJ5OiBYdWVCaW5n
IENoZW4gPGNoZW54dWViaW5nQGphcmkuY24+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZmX2Vycm9yLmMgfCAxMiArKysrKystLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L214Z3B1X2FpLmMgICAgICAgIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZmX2Vycm9yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmZfZXJyb3IuYwppbmRleCBmOWQzZDc5ZjY4YjEuLjE1OTllODE4YzY5NiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZmX2Vycm9yLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZmX2Vycm9yLmMKQEAgLTQwLDEw
ICs0MCwxMCBAQCB2b2lkIGFtZGdwdV92Zl9lcnJvcl9wdXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCiAKIAltdXRleF9sb2NrKCZhZGV2LT52aXJ0LnZmX2Vycm9ycy5sb2NrKTsKIAlpbmRl
eCA9IGFkZXYtPnZpcnQudmZfZXJyb3JzLndyaXRlX2NvdW50ICUgQU1ER1BVX1ZGX0VSUk9SX0VO
VFJZX1NJWkU7Ci0JYWRldi0+dmlydC52Zl9lcnJvcnMuY29kZSBbaW5kZXhdID0gZXJyb3JfY29k
ZTsKLQlhZGV2LT52aXJ0LnZmX2Vycm9ycy5mbGFncyBbaW5kZXhdID0gZXJyb3JfZmxhZ3M7Ci0J
YWRldi0+dmlydC52Zl9lcnJvcnMuZGF0YSBbaW5kZXhdID0gZXJyb3JfZGF0YTsKLQlhZGV2LT52
aXJ0LnZmX2Vycm9ycy53cml0ZV9jb3VudCArKzsKKwlhZGV2LT52aXJ0LnZmX2Vycm9ycy5jb2Rl
W2luZGV4XSA9IGVycm9yX2NvZGU7CisJYWRldi0+dmlydC52Zl9lcnJvcnMuZmxhZ3NbaW5kZXhd
ID0gZXJyb3JfZmxhZ3M7CisJYWRldi0+dmlydC52Zl9lcnJvcnMuZGF0YVtpbmRleF0gPSBlcnJv
cl9kYXRhOworCWFkZXYtPnZpcnQudmZfZXJyb3JzLndyaXRlX2NvdW50Kys7CiAJbXV0ZXhfdW5s
b2NrKCZhZGV2LT52aXJ0LnZmX2Vycm9ycy5sb2NrKTsKIH0KIApAQCAtNzMsMTQgKzczLDE0IEBA
IHZvaWQgYW1kZ3B1X3ZmX2Vycm9yX3RyYW5zX2FsbChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIAl9CiAKIAl3aGlsZSAoYWRldi0+dmlydC52Zl9lcnJvcnMucmVhZF9jb3VudCA8IGFkZXYt
PnZpcnQudmZfZXJyb3JzLndyaXRlX2NvdW50KSB7Ci0JCWluZGV4ID1hZGV2LT52aXJ0LnZmX2Vy
cm9ycy5yZWFkX2NvdW50ICUgQU1ER1BVX1ZGX0VSUk9SX0VOVFJZX1NJWkU7CisJCWluZGV4ID0g
YWRldi0+dmlydC52Zl9lcnJvcnMucmVhZF9jb3VudCAlIEFNREdQVV9WRl9FUlJPUl9FTlRSWV9T
SVpFOwogCQlkYXRhMSA9IEFNREdJTV9FUlJPUl9DT0RFX0ZMQUdTX1RPX01BSUxCT1goYWRldi0+
dmlydC52Zl9lcnJvcnMuY29kZVtpbmRleF0sCiAJCQkJCQkJICAgYWRldi0+dmlydC52Zl9lcnJv
cnMuZmxhZ3NbaW5kZXhdKTsKIAkJZGF0YTIgPSBhZGV2LT52aXJ0LnZmX2Vycm9ycy5kYXRhW2lu
ZGV4XSAmIDB4RkZGRkZGRkY7CiAJCWRhdGEzID0gKGFkZXYtPnZpcnQudmZfZXJyb3JzLmRhdGFb
aW5kZXhdID4+IDMyKSAmIDB4RkZGRkZGRkY7CiAKIAkJYWRldi0+dmlydC5vcHMtPnRyYW5zX21z
ZyhhZGV2LCBJREhfTE9HX1ZGX0VSUk9SLCBkYXRhMSwgZGF0YTIsIGRhdGEzKTsKLQkJYWRldi0+
dmlydC52Zl9lcnJvcnMucmVhZF9jb3VudCArKzsKKwkJYWRldi0+dmlydC52Zl9lcnJvcnMucmVh
ZF9jb3VudCsrOwogCX0KIAltdXRleF91bmxvY2soJmFkZXYtPnZpcnQudmZfZXJyb3JzLmxvY2sp
OwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMKaW5kZXggZjUyZTAyNzhhYmY5
Li41ODc1ODZlY2RkZGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214
Z3B1X2FpLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYwpAQCAt
MzQwLDYgKzM0MCw3IEBAIHN0YXRpYyBpbnQgeGdwdV9haV9tYWlsYm94X3Jjdl9pcnEoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJfQogCiAKKwogCXJldHVybiAwOwogfQogCi0tIAoyLjE3
LjEK
