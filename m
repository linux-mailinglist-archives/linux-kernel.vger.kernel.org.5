Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B707AFEF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjI0IvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjI0IvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:51:04 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1120F4;
        Wed, 27 Sep 2023 01:51:02 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 16:49:44
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 16:49:44 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     aradford@gmail.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: 3w-sas: Clean up errors in 3w-sas.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <38a151ef.88d.18ad5d47214.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD+o7BNl7_u9AA--.630W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwAts+
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
cGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4VikKRVJST1I6IG9wZW4gYnJhY2Ug
J3snIGZvbGxvd2luZyBzdHJ1Y3QgZ28gb24gdGhlIHNhbWUgbGluZQoKU2lnbmVkLW9mZi1ieTog
R3VvSHVhIENoZW5nIDxjaGVuZ3VvaHVhQGphcmkuY24+Ci0tLQogZHJpdmVycy9zY3NpLzN3LXNh
cy5oIHwgMTkgKysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpLzN3LXNhcy5o
IGIvZHJpdmVycy9zY3NpLzN3LXNhcy5oCmluZGV4IDA5NmRlYzI5ZTJhYy4uMzQ0M2NjYmY3M2Ux
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3Njc2kvM3ctc2FzLmgKKysrIGIvZHJpdmVycy9zY3NpLzN3
LXNhcy5oCkBAIC00Niw4ICs0Niw3IEBACiAjZGVmaW5lIF8zV19TQVNfSAogCiAvKiBBRU4gc2V2
ZXJpdHkgdGFibGUgKi8KLXN0YXRpYyBjaGFyICp0d2xfYWVuX3NldmVyaXR5X3RhYmxlW10gPQot
eworc3RhdGljIGNoYXIgKnR3bF9hZW5fc2V2ZXJpdHlfdGFibGVbXSA9IHsKIAkiTm9uZSIsICJF
UlJPUiIsICJXQVJOSU5HIiwgIklORk8iLCAiREVCVUciLCBOVUxMCiB9OwogCkBAIC0xNTIsMTEg
KzE1MSwxMSBAQCBzdGF0aWMgY2hhciAqdHdsX2Flbl9zZXZlcml0eV90YWJsZVtdID0KIC8qIEJp
dG1hc2sgbWFjcm9zIHRvIGVsaW1pbmF0ZSBiaXRmaWVsZHMgKi8KIAogLyogb3Bjb2RlOiA1LCBy
ZXNlcnZlZDogMyAqLwotI2RlZmluZSBUV19PUFJFU19JTih4LHkpICgoeCA8PCA1KSB8ICh5ICYg
MHgxZikpCisjZGVmaW5lIFRXX09QUkVTX0lOKHgsIHkpICgoeCA8PCA1KSB8ICh5ICYgMHgxZikp
CiAjZGVmaW5lIFRXX09QX09VVCh4KSAoeCAmIDB4MWYpCiAKIC8qIG9wY29kZTogNSwgc2dsb2Zm
c2V0OiAzICovCi0jZGVmaW5lIFRXX09QU0dMX0lOKHgseSkgKCh4IDw8IDUpIHwgKHkgJiAweDFm
KSkKKyNkZWZpbmUgVFdfT1BTR0xfSU4oeCwgeSkgKCh4IDw8IDUpIHwgKHkgJiAweDFmKSkKICNk
ZWZpbmUgVFdfU0dMX09VVCh4KSAoKHggPj4gNSkgJiAweDcpCiAKIC8qIHNldmVyaXR5OiAzLCBy
ZXNlcnZlZDogNSAqLwpAQCAtMjA0LDExICsyMDMsMTEgQEAgc3RhdGljIGNoYXIgKnR3bF9hZW5f
c2V2ZXJpdHlfdGFibGVbXSA9CiAJKHdyaXRlbChUV0xfSVNTVUVfU09GVF9SRVNFVCwgVFdMX0hJ
QkRCX1JFR19BRERSKHR3X2RldikpKQogCiAvKiBNYWNyb3MgKi8KLSNkZWZpbmUgVFdfUFJJTlRL
KGgsYSxiLGMpIHsgXAorI2RlZmluZSBUV19QUklOVEsoaCwgYSwgYiwgYykgeyBcCiBpZiAoaCkg
XAotcHJpbnRrKEtFUk5fV0FSTklORyAiM3ctc2FzOiBzY3NpJWQ6IEVSUk9SOiAoMHglMDJYOjB4
JTA0WCk6ICVzLlxuIixoLT5ob3N0X25vLGEsYixjKTsgXAorcHJpbnRrKEtFUk5fV0FSTklORyAi
M3ctc2FzOiBzY3NpJWQ6IEVSUk9SOiAoMHglMDJYOjB4JTA0WCk6ICVzLlxuIiwgaC0+aG9zdF9u
bywgYSwgYiwgYyk7IFwKIGVsc2UgXAotcHJpbnRrKEtFUk5fV0FSTklORyAiM3ctc2FzOiBFUlJP
UjogKDB4JTAyWDoweCUwNFgpOiAlcy5cbiIsYSxiLGMpOyBcCitwcmludGsoS0VSTl9XQVJOSU5H
ICIzdy1zYXM6IEVSUk9SOiAoMHglMDJYOjB4JTA0WCk6ICVzLlxuIiwgYSwgYiwgYyk7IFwKIH0K
ICNkZWZpbmUgVFdfTUFYX0xVTlMgMTYKICNkZWZpbmUgVFdfQ09NTUFORF9TSVpFIChzaXplb2Yo
ZG1hX2FkZHJfdCkgPiA0ID8gNiA6IDQpCkBAIC0zMTAsOCArMzA5LDcgQEAgdHlwZWRlZiBzdHJ1
Y3QgVEFHX1RXX0luaXRjb25uZWN0IHsKIH0gVFdfSW5pdGNvbm5lY3Q7CiAKIC8qIEV2ZW50IGlu
Zm8gc3RydWN0dXJlICovCi10eXBlZGVmIHN0cnVjdCBUQUdfVFdfRXZlbnQKLXsKK3R5cGVkZWYg
c3RydWN0IFRBR19UV19FdmVudCB7CiAJdW5zaWduZWQgaW50IHNlcXVlbmNlX2lkOwogCXVuc2ln
bmVkIGludCB0aW1lX3N0YW1wX3NlYzsKIAl1bnNpZ25lZCBzaG9ydCBhZW5fY29kZTsKQEAgLTM0
OCw4ICszNDYsNyBAQCB0eXBlZGVmIHN0cnVjdCB7CiB9IFRXX1BhcmFtX0FwYWNoZTsKIAogLyog
Q29tcGF0aWJpbGl0eSBpbmZvcm1hdGlvbiBzdHJ1Y3R1cmUgKi8KLXR5cGVkZWYgc3RydWN0IFRB
R19UV19Db21wYXRpYmlsaXR5X0luZm8KLXsKK3R5cGVkZWYgc3RydWN0IFRBR19UV19Db21wYXRp
YmlsaXR5X0luZm8gewogCWNoYXIgZHJpdmVyX3ZlcnNpb25bMzJdOwogCXVuc2lnbmVkIHNob3J0
IHdvcmtpbmdfc3JsOwogCXVuc2lnbmVkIHNob3J0IHdvcmtpbmdfYnJhbmNoOwotLSAKMi4xNy4x
Cg==
