Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579617B1084
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjI1CAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1CAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:00:38 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A5ACAC;
        Wed, 27 Sep 2023 19:00:35 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 09:58:47
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 09:58:47 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: Clean up errors in lpfc_crtn.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <397df3cb.899.18ad9829062.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD_X3RRlN3i+AA--.632W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAJB2T8PZMAAQATsr
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
c3BhY2UgcHJvaGliaXRlZCBiZWZvcmUgdGhhdCAnLCcgKGN0eDpXeFcpCkVSUk9SOiAiZm9vICog
YmFyIiBzaG91bGQgYmUgImZvbyAqYmFyIgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZWZvcmUg
dGhhdCBjbG9zZSBwYXJlbnRoZXNpcyAnKScKClNpZ25lZC1vZmYtYnk6IEthaUxvbmcgV2FuZyA8
d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBkcml2ZXJzL3Njc2kvbHBmYy9scGZjX2NydG4uaCB8
IDEwICsrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19jcnRuLmggYi9kcml2
ZXJzL3Njc2kvbHBmYy9scGZjX2NydG4uaAppbmRleCBkNGU0NmEwOGY5NGQuLjY4YTIzZTkzNDI4
ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19jcnRuLmgKKysrIGIvZHJpdmVy
cy9zY3NpL2xwZmMvbHBmY19jcnRuLmgKQEAgLTI4MSw3ICsyODEsNyBAQCBpbnQgbHBmY19jaGVj
a19wZW5kaW5nX2Zjb2VfZXZlbnQoc3RydWN0IGxwZmNfaGJhICosIHVpbnQ4X3QpOwogdm9pZCBs
cGZjX2lzc3VlX2luaXRfdnBpKHN0cnVjdCBscGZjX3Zwb3J0ICopOwogCiB2b2lkIGxwZmNfY29u
ZmlnX2hicShzdHJ1Y3QgbHBmY19oYmEgKiwgdWludDMyX3QsIHN0cnVjdCBscGZjX2hicV9pbml0
ICosCi0JdWludDMyX3QgLCBMUEZDX01CT1hRX3QgKik7CisJdWludDMyX3QsIExQRkNfTUJPWFFf
dCAqKTsKIHN0cnVjdCBoYnFfZG1hYnVmICpscGZjX2Vsc19oYnFfYWxsb2Moc3RydWN0IGxwZmNf
aGJhICopOwogdm9pZCBscGZjX2Vsc19oYnFfZnJlZShzdHJ1Y3QgbHBmY19oYmEgKiwgc3RydWN0
IGhicV9kbWFidWYgKik7CiBzdHJ1Y3QgaGJxX2RtYWJ1ZiAqbHBmY19zbGk0X3JiX2FsbG9jKHN0
cnVjdCBscGZjX2hiYSAqKTsKQEAgLTMyNyw3ICszMjcsNyBAQCBscGZjX3NsaV9oYW5kbGVfZmFz
dF9yaW5nX2V2ZW50KHN0cnVjdCBscGZjX2hiYSAqLAogCQkJc3RydWN0IGxwZmNfc2xpX3Jpbmcg
KiwgdWludDMyX3QpOwogCiBzdHJ1Y3QgbHBmY19pb2NicSAqX19scGZjX3NsaV9nZXRfaW9jYnEo
c3RydWN0IGxwZmNfaGJhICopOwotc3RydWN0IGxwZmNfaW9jYnEgKiBscGZjX3NsaV9nZXRfaW9j
YnEoc3RydWN0IGxwZmNfaGJhICopOworc3RydWN0IGxwZmNfaW9jYnEgKmxwZmNfc2xpX2dldF9p
b2NicShzdHJ1Y3QgbHBmY19oYmEgKik7CiB2b2lkIGxwZmNfc2xpX3JlbGVhc2VfaW9jYnEoc3Ry
dWN0IGxwZmNfaGJhICosIHN0cnVjdCBscGZjX2lvY2JxICopOwogdWludDE2X3QgbHBmY19zbGlf
bmV4dF9pb3RhZyhzdHJ1Y3QgbHBmY19oYmEgKiwgc3RydWN0IGxwZmNfaW9jYnEgKik7CiB2b2lk
IGxwZmNfc2xpX2NhbmNlbF9pb2NicyhzdHJ1Y3QgbHBmY19oYmEgKiwgc3RydWN0IGxpc3RfaGVh
ZCAqLCB1aW50MzJfdCwKQEAgLTM5NSw4ICszOTUsOCBAQCBzdHJ1Y3QgbHBmY19kbWFidWYgKmxw
ZmNfc2xpX3Jpbmdwb3N0YnVmX2dldChzdHJ1Y3QgbHBmY19oYmEgKiwKIAkJCQkJICAgICBkbWFf
YWRkcl90KTsKIAogdWludDMyX3QgbHBmY19zbGlfZ2V0X2J1ZmZlcl90YWcoc3RydWN0IGxwZmNf
aGJhICopOwotc3RydWN0IGxwZmNfZG1hYnVmICogbHBmY19zbGlfcmluZ190YWdnZWRidWZfZ2V0
KHN0cnVjdCBscGZjX2hiYSAqLAotCQkJc3RydWN0IGxwZmNfc2xpX3JpbmcgKiwgdWludDMyX3Qg
KTsKK3N0cnVjdCBscGZjX2RtYWJ1ZiAqbHBmY19zbGlfcmluZ190YWdnZWRidWZfZ2V0KHN0cnVj
dCBscGZjX2hiYSAqLAorCQkJc3RydWN0IGxwZmNfc2xpX3JpbmcgKiwgdWludDMyX3QpOwogCiBp
bnQgbHBmY19zbGlfaGJxX2NvdW50KHZvaWQpOwogaW50IGxwZmNfc2xpX2hicWJ1Zl9hZGRfaGJx
cyhzdHJ1Y3QgbHBmY19oYmEgKiwgdWludDMyX3QpOwpAQCAtNDQ1LDcgKzQ0NSw3IEBAIGludCBs
cGZjX2xpbmtfcmVzZXQoc3RydWN0IGxwZmNfdnBvcnQgKnZwb3J0KTsKIAogLyogRnVuY3Rpb24g
cHJvdG90eXBlcy4gKi8KIGludCBscGZjX2NoZWNrX3BjaV9yZXNldHRhYmxlKHN0cnVjdCBscGZj
X2hiYSAqcGhiYSk7Ci1jb25zdCBjaGFyKiBscGZjX2luZm8oc3RydWN0IFNjc2lfSG9zdCAqKTsK
K2NvbnN0IGNoYXIgKmxwZmNfaW5mbyhzdHJ1Y3QgU2NzaV9Ib3N0ICopOwogaW50IGxwZmNfc2Nh
bl9maW5pc2hlZChzdHJ1Y3QgU2NzaV9Ib3N0ICosIHVuc2lnbmVkIGxvbmcpOwogCiBpbnQgbHBm
Y19pbml0X2FwaV90YWJsZV9zZXR1cChzdHJ1Y3QgbHBmY19oYmEgKiwgdWludDhfdCk7Ci0tIAoy
LjE3LjEK
