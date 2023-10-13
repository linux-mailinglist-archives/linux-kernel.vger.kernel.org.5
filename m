Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570EB7C7BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjJMC76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMC75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:59:57 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E0A791
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:59:56 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 10:58:14
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 10:58:14 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     tzimmermann@suse.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iosys-map: Clean up errors in iosys-map.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <14ac9e76.941.18b26f86290.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD9Gsihl1NfBAA--.742W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAGQAFsB
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc6JyAoY3R4OlZ4VykKClNpZ25lZC1vZmYtYnk6
IEd1b0h1YSBDaGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGluY2x1ZGUvbGludXgvaW9z
eXMtbWFwLmggfCAyMCArKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
aW9zeXMtbWFwLmggYi9pbmNsdWRlL2xpbnV4L2lvc3lzLW1hcC5oCmluZGV4IGNiNzFhYTYxNmJk
My4uMTA4ZmQwZGQ5MTIxIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2lvc3lzLW1hcC5oCisr
KyBiL2luY2x1ZGUvbGludXgvaW9zeXMtbWFwLmgKQEAgLTM0OSwyOSArMzQ5LDI5IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBpb3N5c19tYXBfbWVtc2V0KHN0cnVjdCBpb3N5c19tYXAgKmRzdCwgc2l6
ZV90IG9mZnNldCwKIAogI2lmZGVmIENPTkZJR182NEJJVAogI2RlZmluZSBfX2lvc3lzX21hcF9y
ZF9pb191NjRfY2FzZSh2YWxfLCB2YWRkcl9pb21lbV8pCQkJCVwKLQl1NjQ6IHZhbF8gPSByZWFk
cSh2YWRkcl9pb21lbV8pCisJdTY0IDogdmFsXyA9IHJlYWRxKHZhZGRyX2lvbWVtXykKICNkZWZp
bmUgX19pb3N5c19tYXBfd3JfaW9fdTY0X2Nhc2UodmFsXywgdmFkZHJfaW9tZW1fKQkJCQlcCi0J
dTY0OiB3cml0ZXEodmFsXywgdmFkZHJfaW9tZW1fKQorCXU2NCA6IHdyaXRlcSh2YWxfLCB2YWRk
cl9pb21lbV8pCiAjZWxzZQogI2RlZmluZSBfX2lvc3lzX21hcF9yZF9pb191NjRfY2FzZSh2YWxf
LCB2YWRkcl9pb21lbV8pCQkJCVwKLQl1NjQ6IG1lbWNweV9mcm9taW8oJih2YWxfKSwgdmFkZHJf
aW9tZW1fLCBzaXplb2YodTY0KSkKKwl1NjQgOiBtZW1jcHlfZnJvbWlvKCYodmFsXyksIHZhZGRy
X2lvbWVtXywgc2l6ZW9mKHU2NCkpCiAjZGVmaW5lIF9faW9zeXNfbWFwX3dyX2lvX3U2NF9jYXNl
KHZhbF8sIHZhZGRyX2lvbWVtXykJCQkJXAotCXU2NDogbWVtY3B5X3RvaW8odmFkZHJfaW9tZW1f
LCAmKHZhbF8pLCBzaXplb2YodTY0KSkKKwl1NjQgOiBtZW1jcHlfdG9pbyh2YWRkcl9pb21lbV8s
ICYodmFsXyksIHNpemVvZih1NjQpKQogI2VuZGlmCiAKICNkZWZpbmUgX19pb3N5c19tYXBfcmRf
aW8odmFsX18sIHZhZGRyX2lvbWVtX18sIHR5cGVfXykgX0dlbmVyaWModmFsX18sCQlcCi0JdTg6
IHZhbF9fID0gcmVhZGIodmFkZHJfaW9tZW1fXyksCQkJCQlcCi0JdTE2OiB2YWxfXyA9IHJlYWR3
KHZhZGRyX2lvbWVtX18pLAkJCQkJXAotCXUzMjogdmFsX18gPSByZWFkbCh2YWRkcl9pb21lbV9f
KSwJCQkJCVwKKwl1OCA6IHZhbF9fID0gcmVhZGIodmFkZHJfaW9tZW1fXyksCQkJCQlcCisJdTE2
IDogdmFsX18gPSByZWFkdyh2YWRkcl9pb21lbV9fKSwJCQkJCVwKKwl1MzIgOiB2YWxfXyA9IHJl
YWRsKHZhZGRyX2lvbWVtX18pLAkJCQkJXAogCV9faW9zeXNfbWFwX3JkX2lvX3U2NF9jYXNlKHZh
bF9fLCB2YWRkcl9pb21lbV9fKSkKIAogI2RlZmluZSBfX2lvc3lzX21hcF9yZF9zeXModmFsX18s
IHZhZGRyX18sIHR5cGVfXykJCQkJXAogCXZhbF9fID0gUkVBRF9PTkNFKCoodHlwZV9fICopKHZh
ZGRyX18pKQogCiAjZGVmaW5lIF9faW9zeXNfbWFwX3dyX2lvKHZhbF9fLCB2YWRkcl9pb21lbV9f
LCB0eXBlX18pIF9HZW5lcmljKHZhbF9fLAkJXAotCXU4OiB3cml0ZWIodmFsX18sIHZhZGRyX2lv
bWVtX18pLAkJCQkJXAotCXUxNjogd3JpdGV3KHZhbF9fLCB2YWRkcl9pb21lbV9fKSwJCQkJCVwK
LQl1MzI6IHdyaXRlbCh2YWxfXywgdmFkZHJfaW9tZW1fXyksCQkJCQlcCisJdTggOiB3cml0ZWIo
dmFsX18sIHZhZGRyX2lvbWVtX18pLAkJCQkJXAorCXUxNiA6IHdyaXRldyh2YWxfXywgdmFkZHJf
aW9tZW1fXyksCQkJCQlcCisJdTMyIDogd3JpdGVsKHZhbF9fLCB2YWRkcl9pb21lbV9fKSwJCQkJ
CVwKIAlfX2lvc3lzX21hcF93cl9pb191NjRfY2FzZSh2YWxfXywgdmFkZHJfaW9tZW1fXykpCiAK
ICNkZWZpbmUgX19pb3N5c19tYXBfd3Jfc3lzKHZhbF9fLCB2YWRkcl9fLCB0eXBlX18pCQkJCVwK
LS0gCjIuMTcuMQo=
