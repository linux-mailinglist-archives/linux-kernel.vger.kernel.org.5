Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760E57B0203
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjI0Kk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjI0IZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:25:59 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 547C7CC4;
        Wed, 27 Sep 2023 01:25:41 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 16:24:13
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 16:24:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     gotom@debian.or.jp, yokota@netlab.is.tsukuba.ac.jp,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: Clean up errors in nsp32_io.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7612214f.888.18ad5bd14bc.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDnhD+t5hNlYPi9AA--.583W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwAgsz
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
c3BhY2UgcHJvaGliaXRlZCBiZWZvcmUgdGhhdCBjbG9zZSBwYXJlbnRoZXNpcyAnKScKRVJST1I6
IHNwYWNlIHJlcXVpcmVkIGFmdGVyIHRoYXQgJywnIChjdHg6VnhWKQoKU2lnbmVkLW9mZi1ieTog
R3VvSHVhIENoZW5nIDxjaGVuZ3VvaHVhQGphcmkuY24+Ci0tLQogZHJpdmVycy9zY3NpL25zcDMy
X2lvLmggfCAxOCArKysrKysrKystLS0tLS0tLS0KIGRyaXZlcnMvc2NzaS9zY3NpX3BtLmMgIHwg
IDQgKystLQogMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvbnNwMzJfaW8uaCBiL2RyaXZlcnMvc2NzaS9u
c3AzMl9pby5oCmluZGV4IGUzZjNjMjdiMDFlZi4uNTkwMmYzMDM1YWZhIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3Njc2kvbnNwMzJfaW8uaAorKysgYi9kcml2ZXJzL3Njc2kvbnNwMzJfaW8uaApAQCAt
MTI2LDcgKzEyNiw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBuc3AzMl9pbmRleF93cml0ZTEodW5z
aWduZWQgaW50ICBiYXNlLAogCQkJCSAgICAgIHVuc2lnbmVkIGludCAgcmVnLAogCQkJCSAgICAg
IHVuc2lnbmVkIGNoYXIgdmFsKQogewotCW91dGIocmVnLCBiYXNlICsgSU5ERVhfUkVHICAgKTsK
KwlvdXRiKHJlZywgYmFzZSArIElOREVYX1JFRyk7CiAJb3V0Yih2YWwsIGJhc2UgKyBEQVRBX1JF
R19MT1cpOwogfQogCkBAIC0xNDEsMTggKzE0MSwxOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbnNw
MzJfaW5kZXhfd3JpdGUyKHVuc2lnbmVkIGludCAgIGJhc2UsCiAJCQkJICAgICAgdW5zaWduZWQg
aW50ICAgcmVnLAogCQkJCSAgICAgIHVuc2lnbmVkIHNob3J0IHZhbCkKIHsKLQlvdXRiKHJlZywg
YmFzZSArIElOREVYX1JFRyAgICk7CisJb3V0YihyZWcsIGJhc2UgKyBJTkRFWF9SRUcpOwogCW91
dHcodmFsLCBiYXNlICsgREFUQV9SRUdfTE9XKTsKIH0KIAogc3RhdGljIGlubGluZSB1bnNpZ25l
ZCBsb25nIG5zcDMyX2luZGV4X3JlYWQ0KHVuc2lnbmVkIGludCBiYXNlLAogCQkJCQkgICAgICB1
bnNpZ25lZCBpbnQgcmVnKQogewotCXVuc2lnbmVkIGxvbmcgaCxsOworCXVuc2lnbmVkIGxvbmcg
aCwgbDsKIAogCW91dGIocmVnLCBiYXNlICsgSU5ERVhfUkVHKTsKIAlsID0gaW53KGJhc2UgKyBE
QVRBX1JFR19MT1cpOwotCWggPSBpbncoYmFzZSArIERBVEFfUkVHX0hJICk7CisJaCA9IGludyhi
YXNlICsgREFUQV9SRUdfSEkpOwogCiAJcmV0dXJuICgoaCA8PCAxNikgfCBsKTsKIH0KQEAgLTE2
MSwxNCArMTYxLDE0IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBuc3AzMl9pbmRleF93cml0ZTQodW5z
aWduZWQgaW50ICBiYXNlLAogCQkJCSAgICAgIHVuc2lnbmVkIGludCAgcmVnLAogCQkJCSAgICAg
IHVuc2lnbmVkIGxvbmcgdmFsKQogewotCXVuc2lnbmVkIGxvbmcgaCxsOworCXVuc2lnbmVkIGxv
bmcgaCwgbDsKIAogCWggPSAodmFsICYgMHhmZmZmMDAwMCkgPj4gMTY7CiAJbCA9ICh2YWwgJiAw
eDAwMDBmZmZmKSA+PiAgMDsKIAotCW91dGIocmVnLCBiYXNlICsgSU5ERVhfUkVHICAgKTsKKwlv
dXRiKHJlZywgYmFzZSArIElOREVYX1JFRyk7CiAJb3V0dyhsLCAgIGJhc2UgKyBEQVRBX1JFR19M
T1cpOwotCW91dHcoaCwgICBiYXNlICsgREFUQV9SRUdfSEkgKTsKKwlvdXR3KGgsICAgYmFzZSAr
IERBVEFfUkVHX0hJKTsKIH0KIAogLyo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Ki8KQEAgLTE5NSw3ICsxOTUsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbnNw
MzJfbW1pb19pbmRleF93cml0ZTEodW5zaWduZWQgbG9uZyBiYXNlLAogCWRhdGFfcHRyICA9ICh1
bnNpZ25lZCBzaG9ydCAqKShiYXNlICsgTlNQMzJfTU1JT19PRkZTRVQgKyBEQVRBX1JFR19MT1cp
OwogCiAJd3JpdGViKHJlZywgaW5kZXhfcHRyKTsKLQl3cml0ZWIodmFsLCBkYXRhX3B0ciApOwor
CXdyaXRlYih2YWwsIGRhdGFfcHRyKTsKIH0KIAogc3RhdGljIGlubGluZSB1bnNpZ25lZCBzaG9y
dCBuc3AzMl9tbWlvX2luZGV4X3JlYWQyKHVuc2lnbmVkIGxvbmcgYmFzZSwKQEAgLTIyMCw3ICsy
MjAsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbnNwMzJfbW1pb19pbmRleF93cml0ZTIodW5zaWdu
ZWQgbG9uZyAgYmFzZSwKIAlkYXRhX3B0ciAgPSAodW5zaWduZWQgc2hvcnQgKikoYmFzZSArIE5T
UDMyX01NSU9fT0ZGU0VUICsgREFUQV9SRUdfTE9XKTsKIAogCXdyaXRlYihyZWcsICAgICAgICAg
ICAgICBpbmRleF9wdHIpOwotCXdyaXRldyhjcHVfdG9fbGUxNih2YWwpLCBkYXRhX3B0ciApOwor
CXdyaXRldyhjcHVfdG9fbGUxNih2YWwpLCBkYXRhX3B0cik7CiB9CiAKIC8qPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSovCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3Njc2kvc2NzaV9wbS5jIGIvZHJpdmVycy9zY3NpL3Njc2lfcG0uYwppbmRleCBkNTgxNjEzZDg3
YzcuLmVlNDRmZGVkOGU1NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9zY3NpL3Njc2lfcG0uYworKysg
Yi9kcml2ZXJzL3Njc2kvc2NzaV9wbS5jCkBAIC0yMTgsNyArMjE4LDcgQEAgaW50IHNjc2lfYXV0
b3BtX2dldF9kZXZpY2Uoc3RydWN0IHNjc2lfZGV2aWNlICpzZGV2KQogCWludAllcnI7CiAKIAll
cnIgPSBwbV9ydW50aW1lX2dldF9zeW5jKCZzZGV2LT5zZGV2X2dlbmRldik7Ci0JaWYgKGVyciA8
IDAgJiYgZXJyICE9LUVBQ0NFUykKKwlpZiAoZXJyIDwgMCAmJiBlcnIgIT0gLUVBQ0NFUykKIAkJ
cG1fcnVudGltZV9wdXRfc3luYygmc2Rldi0+c2Rldl9nZW5kZXYpOwogCWVsc2UKIAkJZXJyID0g
MDsKQEAgLTI0Nyw3ICsyNDcsNyBAQCBpbnQgc2NzaV9hdXRvcG1fZ2V0X2hvc3Qoc3RydWN0IFNj
c2lfSG9zdCAqc2hvc3QpCiAJaW50CWVycjsKIAogCWVyciA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMo
JnNob3N0LT5zaG9zdF9nZW5kZXYpOwotCWlmIChlcnIgPCAwICYmIGVyciAhPS1FQUNDRVMpCisJ
aWYgKGVyciA8IDAgJiYgZXJyICE9IC1FQUNDRVMpCiAJCXBtX3J1bnRpbWVfcHV0X3N5bmMoJnNo
b3N0LT5zaG9zdF9nZW5kZXYpOwogCWVsc2UKIAkJZXJyID0gMDsKLS0gCjIuMTcuMQo=
