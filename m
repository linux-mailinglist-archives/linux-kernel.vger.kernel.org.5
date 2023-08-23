Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DE2785451
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbjHWJfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbjHWJdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:33:50 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 650EE1FE3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:22:00 -0700 (PDT)
Received: from chenxuebing$jari.cn ( [125.70.163.142] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 23 Aug 2023 17:21:34
 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.142]
Date:   Wed, 23 Aug 2023 17:21:34 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Clean up errors in dce_v6_0.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3b6c6469.624.18a21b30506.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD+fz+VktmiQAA--.473W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAMCmTkgo0AVAACse
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
c3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIGJyYWNlICd7JwpFUlJPUjogdGhhdCBvcGVu
IGJyYWNlIHsgc2hvdWxkIGJlIG9uIHRoZSBwcmV2aW91cyBsaW5lCgpTaWduZWQtb2ZmLWJ5OiBY
dWVCaW5nIENoZW4gPGNoZW54dWViaW5nQGphcmkuY24+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZGNlX3Y2XzAuYyB8IDIwICsrKysrKystLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjZfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZGNlX3Y2XzAuYwppbmRleCA3Zjg1YmE1YjcyNmYuLmExMDJlMzIyN2Q3NSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3Y2XzAuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjZfMC5jCkBAIC01Niw4ICs1Niw3IEBACiBzdGF0aWMg
dm9pZCBkY2VfdjZfMF9zZXRfZGlzcGxheV9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dik7CiBzdGF0aWMgdm9pZCBkY2VfdjZfMF9zZXRfaXJxX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KTsKIAotc3RhdGljIGNvbnN0IHUzMiBjcnRjX29mZnNldHNbNl0gPQoteworc3Rh
dGljIGNvbnN0IHUzMiBjcnRjX29mZnNldHNbNl0gPSB7CiAJU0lfQ1JUQzBfUkVHSVNURVJfT0ZG
U0VULAogCVNJX0NSVEMxX1JFR0lTVEVSX09GRlNFVCwKIAlTSV9DUlRDMl9SRUdJU1RFUl9PRkZT
RVQsCkBAIC02Niw4ICs2NSw3IEBAIHN0YXRpYyBjb25zdCB1MzIgY3J0Y19vZmZzZXRzWzZdID0K
IAlTSV9DUlRDNV9SRUdJU1RFUl9PRkZTRVQKIH07CiAKLXN0YXRpYyBjb25zdCB1MzIgaHBkX29m
ZnNldHNbXSA9Ci17CitzdGF0aWMgY29uc3QgdTMyIGhwZF9vZmZzZXRzW10gPSB7CiAJbW1EQ19I
UEQxX0lOVF9TVEFUVVMgLSBtbURDX0hQRDFfSU5UX1NUQVRVUywKIAltbURDX0hQRDJfSU5UX1NU
QVRVUyAtIG1tRENfSFBEMV9JTlRfU1RBVFVTLAogCW1tRENfSFBEM19JTlRfU1RBVFVTIC0gbW1E
Q19IUEQxX0lOVF9TVEFUVVMsCkBAIC0xMzI4LDggKzEzMjYsNyBAQCBzdGF0aWMgdm9pZCBkY2Vf
djZfMF9hdWRpb19lbmFibGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQllbmFibGUg
PyBBWkFMSUFfRjBfQ09ERUNfUElOX0NPTlRST0xfSE9UX1BMVUdfQ09OVFJPTF9fQVVESU9fRU5B
QkxFRF9NQVNLIDogMCk7CiB9CiAKLXN0YXRpYyBjb25zdCB1MzIgcGluX29mZnNldHNbN10gPQot
eworc3RhdGljIGNvbnN0IHUzMiBwaW5fb2Zmc2V0c1s3XSA9IHsKIAkoMHgxNzgwIC0gMHgxNzgw
KSwKIAkoMHgxNzg2IC0gMHgxNzgwKSwKIAkoMHgxNzhjIC0gMHgxNzgwKSwKQEAgLTE3NzYsOCAr
MTc3Myw3IEBAIHN0YXRpYyB2b2lkIGRjZV92Nl8wX2FmbXRfZmluaShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAl9CiB9CiAKLXN0YXRpYyBjb25zdCB1MzIgdmdhX2NvbnRyb2xfcmVnc1s2
XSA9Ci17CitzdGF0aWMgY29uc3QgdTMyIHZnYV9jb250cm9sX3JlZ3NbNl0gPSB7CiAJbW1EMVZH
QV9DT05UUk9MLAogCW1tRDJWR0FfQ09OVFJPTCwKIAltbUQzVkdBX0NPTlRST0wsCkBAIC0zMDU5
LDcgKzMwNTUsNyBAQCBzdGF0aWMgaW50IGRjZV92Nl8wX3BhZ2VmbGlwX2lycShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKIAogCXNwaW5fbG9ja19pcnFzYXZlKCZhZGV2X3RvX2RybShhZGV2
KS0+ZXZlbnRfbG9jaywgZmxhZ3MpOwogCXdvcmtzID0gYW1kZ3B1X2NydGMtPnBmbGlwX3dvcmtz
OwotCWlmIChhbWRncHVfY3J0Yy0+cGZsaXBfc3RhdHVzICE9IEFNREdQVV9GTElQX1NVQk1JVFRF
RCl7CisJaWYgKGFtZGdwdV9jcnRjLT5wZmxpcF9zdGF0dXMgIT0gQU1ER1BVX0ZMSVBfU1VCTUlU
VEVEKSB7CiAJCURSTV9ERUJVR19EUklWRVIoImFtZGdwdV9jcnRjLT5wZmxpcF9zdGF0dXMgPSAl
ZCAhPSAiCiAJCQkJCQkiQU1ER1BVX0ZMSVBfU1VCTUlUVEVEKCVkKVxuIiwKIAkJCQkJCWFtZGdw
dV9jcnRjLT5wZmxpcF9zdGF0dXMsCkBAIC0zNDY1LDggKzM0NjEsNyBAQCBzdGF0aWMgdm9pZCBk
Y2VfdjZfMF9zZXRfaXJxX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWFkZXYt
PmhwZF9pcnEuZnVuY3MgPSAmZGNlX3Y2XzBfaHBkX2lycV9mdW5jczsKIH0KIAotY29uc3Qgc3Ry
dWN0IGFtZGdwdV9pcF9ibG9ja192ZXJzaW9uIGRjZV92Nl8wX2lwX2Jsb2NrID0KLXsKK2NvbnN0
IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tfdmVyc2lvbiBkY2VfdjZfMF9pcF9ibG9jayA9IHsKIAku
dHlwZSA9IEFNRF9JUF9CTE9DS19UWVBFX0RDRSwKIAkubWFqb3IgPSA2LAogCS5taW5vciA9IDAs
CkBAIC0zNDc0LDggKzM0NjksNyBAQCBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrX3ZlcnNp
b24gZGNlX3Y2XzBfaXBfYmxvY2sgPQogCS5mdW5jcyA9ICZkY2VfdjZfMF9pcF9mdW5jcywKIH07
CiAKLWNvbnN0IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tfdmVyc2lvbiBkY2VfdjZfNF9pcF9ibG9j
ayA9Ci17Citjb25zdCBzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrX3ZlcnNpb24gZGNlX3Y2XzRfaXBf
YmxvY2sgPSB7CiAJLnR5cGUgPSBBTURfSVBfQkxPQ0tfVFlQRV9EQ0UsCiAJLm1ham9yID0gNiwK
IAkubWlub3IgPSA0LAotLSAKMi4xNy4xCg==
