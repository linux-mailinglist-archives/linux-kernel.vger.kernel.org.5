Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE4478682F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbjHXHP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbjHXHPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:15:40 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F1461996
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:15:05 -0700 (PDT)
Received: from chenxuebing$jari.cn ( [125.70.163.142] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 24 Aug 2023 15:14:39
 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.142]
Date:   Thu, 24 Aug 2023 15:14:39 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Clean up errors in dce_v11_0.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4e7007e6.63e.18a26652d06.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD9fA+dkYTSSAA--.484W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQANCmTl1A4AOgAKst
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
dGhhdCBvcGVuIGJyYWNlIHsgc2hvdWxkIGJlIG9uIHRoZSBwcmV2aW91cyBsaW5lCkVSUk9SOiBz
d2l0Y2ggYW5kIGNhc2Ugc2hvdWxkIGJlIGF0IHRoZSBzYW1lIGluZGVudApFUlJPUjogc3BhY2Ug
cmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwpFUlJPUjogc3BhY2UgcmVx
dWlyZWQgYmVmb3JlIHRoZSBvcGVuIGJyYWNlICd7JwoKU2lnbmVkLW9mZi1ieTogWHVlQmluZyBD
aGVuIDxjaGVueHVlYmluZ0BqYXJpLmNuPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2RjZV92MTFfMC5jIHwgMjAgKysrKysrKystLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2RjZV92MTFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
ZGNlX3YxMV8wLmMKaW5kZXggYzE0YjcwMzUwYTUxLi5jYjYzMGRmZGNkNTAgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92MTFfMC5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2RjZV92MTFfMC5jCkBAIC0xNDUxLDggKzE0NTEsNyBAQCBzdGF0aWMg
dm9pZCBkY2VfdjExXzBfYXVkaW9fZW5hYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAog
CQkJICAgZW5hYmxlID8gQVpBTElBX0YwX0NPREVDX1BJTl9DT05UUk9MX0hPVF9QTFVHX0NPTlRS
T0xfX0FVRElPX0VOQUJMRURfTUFTSyA6IDApOwogfQogCi1zdGF0aWMgY29uc3QgdTMyIHBpbl9v
ZmZzZXRzW10gPQoteworc3RhdGljIGNvbnN0IHUzMiBwaW5fb2Zmc2V0c1tdID0gewogCUFVRDBf
UkVHSVNURVJfT0ZGU0VULAogCUFVRDFfUkVHSVNURVJfT0ZGU0VULAogCUFVRDJfUkVHSVNURVJf
T0ZGU0VULApAQCAtMTg1Myw4ICsxODUyLDcgQEAgc3RhdGljIHZvaWQgZGNlX3YxMV8wX2FmbXRf
ZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAl9CiB9CiAKLXN0YXRpYyBjb25zdCB1
MzIgdmdhX2NvbnRyb2xfcmVnc1s2XSA9Ci17CitzdGF0aWMgY29uc3QgdTMyIHZnYV9jb250cm9s
X3JlZ3NbNl0gPSB7CiAJbW1EMVZHQV9DT05UUk9MLAogCW1tRDJWR0FfQ09OVFJPTCwKIAltbUQz
VkdBX0NPTlRST0wsCkBAIC0zMjQwLDcgKzMyMzgsNyBAQCBzdGF0aWMgaW50IGRjZV92MTFfMF9z
ZXRfY3J0Y19pcnFfc3RhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJY2FzZSBBTURH
UFVfQ1JUQ19JUlFfVkxJTkU1OgogCQlkY2VfdjExXzBfc2V0X2NydGNfdmxpbmVfaW50ZXJydXB0
X3N0YXRlKGFkZXYsIDQsIHN0YXRlKTsKIAkJYnJlYWs7Ci0JIGNhc2UgQU1ER1BVX0NSVENfSVJR
X1ZMSU5FNjoKKwljYXNlIEFNREdQVV9DUlRDX0lSUV9WTElORTY6CiAJCWRjZV92MTFfMF9zZXRf
Y3J0Y192bGluZV9pbnRlcnJ1cHRfc3RhdGUoYWRldiwgNSwgc3RhdGUpOwogCQlicmVhazsKIAlk
ZWZhdWx0OgpAQCAtMzI5NSwxMiArMzI5MywxMiBAQCBzdGF0aWMgaW50IGRjZV92MTFfMF9wYWdl
ZmxpcF9pcnEoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCSAgICAgICBHUlBIX0lOVEVS
UlVQVF9TVEFUVVNfX0dSUEhfUEZMSVBfSU5UX0NMRUFSX01BU0spOwogCiAJLyogSVJRIGNvdWxk
IG9jY3VyIHdoZW4gaW4gaW5pdGlhbCBzdGFnZSAqLwotCWlmKGFtZGdwdV9jcnRjID09IE5VTEwp
CisJaWYgKGFtZGdwdV9jcnRjID09IE5VTEwpCiAJCXJldHVybiAwOwogCiAJc3Bpbl9sb2NrX2ly
cXNhdmUoJmFkZXZfdG9fZHJtKGFkZXYpLT5ldmVudF9sb2NrLCBmbGFncyk7CiAJd29ya3MgPSBh
bWRncHVfY3J0Yy0+cGZsaXBfd29ya3M7Ci0JaWYgKGFtZGdwdV9jcnRjLT5wZmxpcF9zdGF0dXMg
IT0gQU1ER1BVX0ZMSVBfU1VCTUlUVEVEKXsKKwlpZiAoYW1kZ3B1X2NydGMtPnBmbGlwX3N0YXR1
cyAhPSBBTURHUFVfRkxJUF9TVUJNSVRURUQpIHsKIAkJRFJNX0RFQlVHX0RSSVZFUigiYW1kZ3B1
X2NydGMtPnBmbGlwX3N0YXR1cyA9ICVkICE9ICIKIAkJCQkJCSAiQU1ER1BVX0ZMSVBfU1VCTUlU
VEVEKCVkKVxuIiwKIAkJCQkJCSBhbWRncHVfY3J0Yy0+cGZsaXBfc3RhdHVzLApAQCAtMzMxNCw3
ICszMzEyLDcgQEAgc3RhdGljIGludCBkY2VfdjExXzBfcGFnZWZsaXBfaXJxKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAogCWFtZGdwdV9jcnRjLT5wZmxpcF93b3JrcyA9IE5VTEw7CiAKIAkv
KiB3YWtldXAgdXNlcnNhcGNlICovCi0JaWYod29ya3MtPmV2ZW50KQorCWlmICh3b3Jrcy0+ZXZl
bnQpCiAJCWRybV9jcnRjX3NlbmRfdmJsYW5rX2V2ZW50KCZhbWRncHVfY3J0Yy0+YmFzZSwgd29y
a3MtPmV2ZW50KTsKIAogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmFkZXZfdG9fZHJtKGFkZXYp
LT5ldmVudF9sb2NrLCBmbGFncyk7CkBAIC0zNzgwLDggKzM3NzgsNyBAQCBzdGF0aWMgdm9pZCBk
Y2VfdjExXzBfc2V0X2lycV9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlhZGV2
LT5ocGRfaXJxLmZ1bmNzID0gJmRjZV92MTFfMF9ocGRfaXJxX2Z1bmNzOwogfQogCi1jb25zdCBz
dHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrX3ZlcnNpb24gZGNlX3YxMV8wX2lwX2Jsb2NrID0KLXsKK2Nv
bnN0IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tfdmVyc2lvbiBkY2VfdjExXzBfaXBfYmxvY2sgPSB7
CiAJLnR5cGUgPSBBTURfSVBfQkxPQ0tfVFlQRV9EQ0UsCiAJLm1ham9yID0gMTEsCiAJLm1pbm9y
ID0gMCwKQEAgLTM3ODksOCArMzc4Niw3IEBAIGNvbnN0IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tf
dmVyc2lvbiBkY2VfdjExXzBfaXBfYmxvY2sgPQogCS5mdW5jcyA9ICZkY2VfdjExXzBfaXBfZnVu
Y3MsCiB9OwogCi1jb25zdCBzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrX3ZlcnNpb24gZGNlX3YxMV8y
X2lwX2Jsb2NrID0KLXsKK2NvbnN0IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tfdmVyc2lvbiBkY2Vf
djExXzJfaXBfYmxvY2sgPSB7CiAJLnR5cGUgPSBBTURfSVBfQkxPQ0tfVFlQRV9EQ0UsCiAJLm1h
am9yID0gMTEsCiAJLm1pbm9yID0gMiwKLS0gCjIuMTcuMQo=
