Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84337854CD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjHWKC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbjHWJsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:48:07 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 129FD6A6B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:20:03 -0700 (PDT)
Received: from chenxuebing$jari.cn ( [125.70.163.142] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 23 Aug 2023 17:19:38
 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.142]
Date:   Wed, 23 Aug 2023 17:19:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Clean up errors in mxgpu_ai.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1c0204f7.623.18a21b13e92.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDXaD4qz+VkOmiQAA--.421W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAMCmTkgo0AUAAEsc
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
b3BlbiBicmFjZSAneycgZm9sbG93aW5nIGZ1bmN0aW9uIGRlZmluaXRpb25zIGdvIG9uIHRoZSBu
ZXh0IGxpbmUKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGJlZm9yZSB0aGUgb3BlbiBwYXJlbnRoZXNp
cyAnKCcKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGJlZm9yZSB0aGUgb3BlbiBicmFjZSAneycKRVJS
T1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKRVJST1I6IHN3aXRjaCBhbmQgY2FzZSBzaG91bGQgYmUg
YXQgdGhlIHNhbWUgaW5kZW50CgpTaWduZWQtb2ZmLWJ5OiBYdWVCaW5nIENoZW4gPGNoZW54dWVi
aW5nQGphcmkuY24+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYyB8
IDE4ICsrKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyks
IDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bXhncHVfYWkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMKaW5kZXgg
NjM3MjViMmViYzAzLi45OTQxYzFmNjk2NTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L214Z3B1X2FpLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhn
cHVfYWkuYwpAQCAtNzUsNyArNzUsOCBAQCBzdGF0aWMgaW50IHhncHVfYWlfbWFpbGJveF9yY3Zf
bXNnKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCXJldHVybiAwOwogfQogCi1zdGF0aWMg
dWludDhfdCB4Z3B1X2FpX3BlZWtfYWNrKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSB7Citz
dGF0aWMgdWludDhfdCB4Z3B1X2FpX3BlZWtfYWNrKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQorewogCXJldHVybiBSUkVHOChBSV9NQUlCT1hfQ09OVFJPTF9UUk5fT0ZGU0VUX0JZVEUpICYg
MjsKIH0KIApAQCAtMTE3LDcgKzExOCw4IEBAIHN0YXRpYyBpbnQgeGdwdV9haV9wb2xsX21zZyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgZW51bSBpZGhfZXZlbnQgZXZlbnQpCiB9CiAKIHN0
YXRpYyB2b2lkIHhncHVfYWlfbWFpbGJveF90cmFuc19tc2cgKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAotCSAgICAgIGVudW0gaWRoX3JlcXVlc3QgcmVxLCB1MzIgZGF0YTEsIHUzMiBkYXRh
MiwgdTMyIGRhdGEzKSB7CisJICAgICAgZW51bSBpZGhfcmVxdWVzdCByZXEsIHUzMiBkYXRhMSwg
dTMyIGRhdGEyLCB1MzIgZGF0YTMpCit7CiAJdTMyIHJlZzsKIAlpbnQgcjsKIAl1aW50OF90IHRy
bjsKQEAgLTEzNSw3ICsxMzcsNyBAQCBzdGF0aWMgdm9pZCB4Z3B1X2FpX21haWxib3hfdHJhbnNf
bXNnIChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCXByX2VycigidHJuPSV4IEFDSyBz
aG91bGQgbm90IGFzc2VydCEgd2FpdCBhZ2FpbiAhXG4iLCB0cm4pOwogCQkJbXNsZWVwKDEpOwog
CQl9Ci0JfSB3aGlsZSh0cm4pOworCX0gd2hpbGUgKHRybik7CiAKIAlyZWcgPSBSUkVHMzJfTk9f
S0lRKFNPQzE1X1JFR19PRkZTRVQoTkJJTywgMCwKIAkJCQkJICAgICBtbUJJRl9CWF9QRjBfTUFJ
TEJPWF9NU0dCVUZfVFJOX0RXMCkpOwpAQCAtMTgyLDExICsxODQsMTEgQEAgc3RhdGljIGludCB4
Z3B1X2FpX3NlbmRfYWNjZXNzX3JlcXVlc3RzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAog
CQkJCVJSRUczMl9OT19LSVEoU09DMTVfUkVHX09GRlNFVChOQklPLCAwLAogCQkJCQltbUJJRl9C
WF9QRjBfTUFJTEJPWF9NU0dCVUZfUkNWX0RXMikpOwogCQl9Ci0JfSBlbHNlIGlmIChyZXEgPT0g
SURIX1JFUV9HUFVfSU5JVF9EQVRBKXsKKwl9IGVsc2UgaWYgKHJlcSA9PSBJREhfUkVRX0dQVV9J
TklUX0RBVEEpIHsKIAkJLyogRHVtbXkgUkVRX0dQVV9JTklUX0RBVEEgaGFuZGxpbmcgKi8KIAkJ
ciA9IHhncHVfYWlfcG9sbF9tc2coYWRldiwgSURIX1JFUV9HUFVfSU5JVF9EQVRBX1JFQURZKTsK
IAkJLyogdmVyc2lvbiBzZXQgdG8gMCBzaW5jZSBkdW1teSAqLwotCQlhZGV2LT52aXJ0LnJlcV9p
bml0X2RhdGFfdmVyID0gMDsJCisJCWFkZXYtPnZpcnQucmVxX2luaXRfZGF0YV92ZXIgPSAwOwog
CX0KIAogCXJldHVybiAwOwpAQCAtMzE2LDE0ICszMTgsMTQgQEAgc3RhdGljIGludCB4Z3B1X2Fp
X21haWxib3hfcmN2X2lycShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAllbnVtIGlkaF9l
dmVudCBldmVudCA9IHhncHVfYWlfbWFpbGJveF9wZWVrX21zZyhhZGV2KTsKIAogCXN3aXRjaCAo
ZXZlbnQpIHsKLQkJY2FzZSBJREhfRkxSX05PVElGSUNBVElPTjoKKwljYXNlIElESF9GTFJfTk9U
SUZJQ0FUSU9OOgogCQlpZiAoYW1kZ3B1X3NyaW92X3J1bnRpbWUoYWRldikgJiYgIWFtZGdwdV9p
bl9yZXNldChhZGV2KSkKIAkJCVdBUk5fT05DRSghYW1kZ3B1X3Jlc2V0X2RvbWFpbl9zY2hlZHVs
ZShhZGV2LT5yZXNldF9kb21haW4sCiAJCQkJCQkJCSZhZGV2LT52aXJ0LmZscl93b3JrKSwKIAkJ
CQkgICJGYWlsZWQgdG8gcXVldWUgd29yayEgYXQgJXMiLAogCQkJCSAgX19mdW5jX18pOwogCQli
cmVhazsKLQkJY2FzZSBJREhfUVVFUllfQUxJVkU6CisJY2FzZSBJREhfUVVFUllfQUxJVkU6CiAJ
CQl4Z3B1X2FpX21haWxib3hfc2VuZF9hY2soYWRldik7CiAJCQlicmVhazsKIAkJLyogUkVBRFlf
VE9fQUNDRVNTX0dQVSBpcyBmZXRjaGVkIGJ5IGtlcm5lbCBwb2xsaW5nLCBJUlEgY2FuIGlnbm9y
ZQpAQCAtMzMzLDcgKzMzNSw3IEBAIHN0YXRpYyBpbnQgeGdwdV9haV9tYWlsYm94X3Jjdl9pcnEo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCWNhc2UgSURIX0NMUl9NU0dfQlVGOgogCQlj
YXNlIElESF9GTFJfTk9USUZJQ0FUSU9OX0NNUEw6CiAJCWNhc2UgSURIX1JFQURZX1RPX0FDQ0VT
U19HUFU6Ci0JCWRlZmF1bHQ6CisJZGVmYXVsdDoKIAkJYnJlYWs7CiAJfQogCi0tIAoyLjE3LjEK

