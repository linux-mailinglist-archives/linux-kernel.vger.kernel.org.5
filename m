Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9624278545A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbjHWJfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbjHWJd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:33:56 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFD1A1BE1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:22:24 -0700 (PDT)
Received: from chenxuebing$jari.cn ( [125.70.163.142] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 23 Aug 2023 17:21:59
 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.142]
Date:   Wed, 23 Aug 2023 17:21:59 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Clean up errors in jpeg_v3_0.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <8040b2d.625.18a21b36326.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBn+D23z+VkyWiQAA--.448W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAMCmTkgo0AVQACsf
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
c3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwpFUlJPUjogdGhh
dCBvcGVuIGJyYWNlIHsgc2hvdWxkIGJlIG9uIHRoZSBwcmV2aW91cyBsaW5lCgpTaWduZWQtb2Zm
LWJ5OiBYdWVCaW5nIENoZW4gPGNoZW54dWViaW5nQGphcmkuY24+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvanBlZ192M18wLmMgfCA3ICsrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvanBlZ192M18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9q
cGVnX3YzXzAuYwppbmRleCBkZjQ0NDBjMjFiYmYuLjQzNjYwNmE2NmUzYSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192M18wLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvanBlZ192M18wLmMKQEAgLTQ5OCw3ICs0OTgsNyBAQCBzdGF0aWMgaW50
IGpwZWdfdjNfMF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUodm9pZCAqaGFuZGxlLAogCXN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwogCWlu
dCByZXQ7CiAKLQlpZihzdGF0ZSA9PSBhZGV2LT5qcGVnLmN1cl9zdGF0ZSkKKwlpZiAoc3RhdGUg
PT0gYWRldi0+anBlZy5jdXJfc3RhdGUpCiAJCXJldHVybiAwOwogCiAJaWYgKHN0YXRlID09IEFN
RF9QR19TVEFURV9HQVRFKQpAQCAtNTA2LDcgKzUwNiw3IEBAIHN0YXRpYyBpbnQganBlZ192M18w
X3NldF9wb3dlcmdhdGluZ19zdGF0ZSh2b2lkICpoYW5kbGUsCiAJZWxzZQogCQlyZXQgPSBqcGVn
X3YzXzBfc3RhcnQoYWRldik7CiAKLQlpZighcmV0KQorCWlmICghcmV0KQogCQlhZGV2LT5qcGVn
LmN1cl9zdGF0ZSA9IHN0YXRlOwogCiAJcmV0dXJuIHJldDsKQEAgLTYwNSw4ICs2MDUsNyBAQCBz
dGF0aWMgdm9pZCBqcGVnX3YzXzBfc2V0X2lycV9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIAlhZGV2LT5qcGVnLmluc3QtPmlycS5mdW5jcyA9ICZqcGVnX3YzXzBfaXJxX2Z1bmNz
OwogfQogCi1jb25zdCBzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrX3ZlcnNpb24ganBlZ192M18wX2lw
X2Jsb2NrID0KLXsKK2NvbnN0IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tfdmVyc2lvbiBqcGVnX3Yz
XzBfaXBfYmxvY2sgPSB7CiAJLnR5cGUgPSBBTURfSVBfQkxPQ0tfVFlQRV9KUEVHLAogCS5tYWpv
ciA9IDMsCiAJLm1pbm9yID0gMCwKLS0gCjIuMTcuMQo=
