Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0726C7854B7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjHWJ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjHWJ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:56:32 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26FDD10B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:56:27 -0700 (PDT)
Received: from chenxuebing$jari.cn ( [125.70.163.142] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 23 Aug 2023 17:56:02
 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.142]
Date:   Wed, 23 Aug 2023 17:56:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Clean up errors in gfx_v6_0.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2d0c6301.62b.18a21d2920f.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD+y1+Vk53aQAA--.478W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAMCmTl1A4AAgADsd
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
cGFjZSBwcm9oaWJpdGVkIGJlZm9yZSB0aGF0ICcrKycgKGN0eDpXeE8pCkVSUk9SOiBzcGFjZSBy
ZXF1aXJlZCBiZWZvcmUgdGhlIG9wZW4gYnJhY2UgJ3snCkVSUk9SOiB0cmFpbGluZyBzdGF0ZW1l
bnRzIHNob3VsZCBiZSBvbiBuZXh0IGxpbmUKClNpZ25lZC1vZmYtYnk6IFh1ZUJpbmcgQ2hlbiA8
Y2hlbnh1ZWJpbmdAamFyaS5jbj4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djZfMC5jIHwgMTMgKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjZfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYwppbmRl
eCBkYTZjYWZmNzhjMjIuLjM2ZDAyYzdiOWM4YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjZfMC5jCkBAIC04Niw4ICs4Niw3IEBAIHN0YXRpYyB2b2lkIGdmeF92Nl8wX2luaXRfcGco
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogI2RlZmluZSBNQUNST19USUxFX0FTUEVDVCh4
KQkJCQkoKHgpIDw8IDE4KQogI2RlZmluZSBOVU1fQkFOS1MoeCkJCQkJCSgoeCkgPDwgMjApCiAK
LXN0YXRpYyBjb25zdCB1MzIgdmVyZGVfcmxjX3NhdmVfcmVzdG9yZV9yZWdpc3Rlcl9saXN0W10g
PQoteworc3RhdGljIGNvbnN0IHUzMiB2ZXJkZV9ybGNfc2F2ZV9yZXN0b3JlX3JlZ2lzdGVyX2xp
c3RbXSA9IHsKIAkoMHg4MDAwIDw8IDE2KSB8ICgweDk4ZjQgPj4gMiksCiAJMHgwMDAwMDAwMCwK
IAkoMHg4MDQwIDw8IDE2KSB8ICgweDk4ZjQgPj4gMiksCkBAIC0zMzQsNyArMzMzLDggQEAgc3Rh
dGljIGludCBnZnhfdjZfMF9pbml0X21pY3JvY29kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIAljYXNlIENISVBfSEFJTkFOOgogCQljaGlwX25hbWUgPSAiaGFpbmFuIjsKIAkJYnJlYWs7
Ci0JZGVmYXVsdDogQlVHKCk7CisJZGVmYXVsdDoKKwkJQlVHKCk7CiAJfQogCiAJc25wcmludGYo
ZndfbmFtZSwgc2l6ZW9mKGZ3X25hbWUpLCAiYW1kZ3B1LyVzX3BmcC5iaW4iLCBjaGlwX25hbWUp
OwpAQCAtMzIyMiw3ICszMjIyLDcgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y2XzBfc2V0X2NvbXB1dGVf
ZW9wX2ludGVycnVwdF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCQkJCSAg
ICAgZW51bSBhbWRncHVfaW50ZXJydXB0X3N0YXRlIHN0YXRlKQogewogCXUzMiBjcF9pbnRfY250
bDsKLQlzd2l0Y2ggKHN0YXRlKXsKKwlzd2l0Y2ggKHN0YXRlKSB7CiAJY2FzZSBBTURHUFVfSVJR
X1NUQVRFX0RJU0FCTEU6CiAJCWlmIChyaW5nID09IDApIHsKIAkJCWNwX2ludF9jbnRsID0gUlJF
RzMyKG1tQ1BfSU5UX0NOVExfUklORzEpOwpAQCAtMzU4Myw3ICszNTgzLDcgQEAgc3RhdGljIHZv
aWQgZ2Z4X3Y2XzBfZ2V0X2N1X2luZm8oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCQkJ
aWYgKGJpdG1hcCAmIG1hc2spIHsKIAkJCQkJaWYgKGNvdW50ZXIgPCBhb19jdV9udW0pCiAJCQkJ
CQlhb19iaXRtYXAgfD0gbWFzazsKLQkJCQkJY291bnRlciArKzsKKwkJCQkJY291bnRlcisrOwog
CQkJCX0KIAkJCQltYXNrIDw8PSAxOwogCQkJfQpAQCAtMzYwMSw4ICszNjAxLDcgQEAgc3RhdGlj
IHZvaWQgZ2Z4X3Y2XzBfZ2V0X2N1X2luZm8oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJ
Y3VfaW5mby0+YW9fY3VfbWFzayA9IGFvX2N1X21hc2s7CiB9CiAKLWNvbnN0IHN0cnVjdCBhbWRn
cHVfaXBfYmxvY2tfdmVyc2lvbiBnZnhfdjZfMF9pcF9ibG9jayA9Ci17Citjb25zdCBzdHJ1Y3Qg
YW1kZ3B1X2lwX2Jsb2NrX3ZlcnNpb24gZ2Z4X3Y2XzBfaXBfYmxvY2sgPSB7CiAJLnR5cGUgPSBB
TURfSVBfQkxPQ0tfVFlQRV9HRlgsCiAJLm1ham9yID0gNiwKIAkubWlub3IgPSAwLAotLSAKMi4x
Ny4xCg==
