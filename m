Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3F57B1078
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjI1BtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:49:12 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D7E5B3;
        Wed, 27 Sep 2023 18:49:10 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 09:47:39
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 09:47:39 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: Clean up errors in lpfc_compat.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3a564508.897.18ad97860cb.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDnhD872xRl73a+AA--.589W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAJB2T8PZMAAQAPs3
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
bmVlZCBjb25zaXN0ZW50IHNwYWNpbmcgYXJvdW5kICcvJyAoY3R4Old4VikKRVJST1I6IHNwYWNl
IHByb2hpYml0ZWQgYWZ0ZXIgdGhhdCBvcGVuIHBhcmVudGhlc2lzICcoJwoKU2lnbmVkLW9mZi1i
eTogR3VvSHVhIENoZW5nIDxjaGVuZ3VvaHVhQGphcmkuY24+Ci0tLQogZHJpdmVycy9zY3NpL2xw
ZmMvbHBmY19jb21wYXQuaCB8IDE2ICsrKysrKysrLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3Np
L2xwZmMvbHBmY19jb21wYXQuaCBiL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfY29tcGF0LmgKaW5k
ZXggNDNjZjQ2YTNhNzFmLi40YzRmNmJhNGY4MTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9s
cGZjL2xwZmNfY29tcGF0LmgKKysrIGIvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19jb21wYXQuaApA
QCAtNDgsOCArNDgsOCBAQCBscGZjX21lbWNweV90b19zbGltKHZvaWQgX19pb21lbSAqZGVzdCwg
dm9pZCAqc3JjLCB1bnNpZ25lZCBpbnQgYnl0ZXMpCiAJc3JjMzIgID0gKHVpbnQzMl90ICopIHNy
YzsKIAogCS8qIHdyaXRlIGlucHV0IGJ5dGVzLCA0IGJ5dGVzIGF0IGEgdGltZSAqLwotCWZvciAo
Zm91cl9ieXRlcyA9IGJ5dGVzIC80OyBmb3VyX2J5dGVzID4gMDsgZm91cl9ieXRlcy0tKSB7Ci0J
CXdyaXRlbCggKnNyYzMyLCBkZXN0MzIpOworCWZvciAoZm91cl9ieXRlcyA9IGJ5dGVzIC8gNDsg
Zm91cl9ieXRlcyA+IDA7IGZvdXJfYnl0ZXMtLSkgeworCQl3cml0ZWwoKnNyYzMyLCBkZXN0MzIp
OwogCQlyZWFkbChkZXN0MzIpOyAvKiBmbHVzaCAqLwogCQlkZXN0MzIrKzsKIAkJc3JjMzIrKzsK
QEAgLTU5LDcgKzU5LDcgQEAgbHBmY19tZW1jcHlfdG9fc2xpbSh2b2lkIF9faW9tZW0gKmRlc3Qs
IHZvaWQgKnNyYywgdW5zaWduZWQgaW50IGJ5dGVzKQogfQogCiBzdGF0aWMgaW5saW5lIHZvaWQK
LWxwZmNfbWVtY3B5X2Zyb21fc2xpbSggdm9pZCAqZGVzdCwgdm9pZCBfX2lvbWVtICpzcmMsIHVu
c2lnbmVkIGludCBieXRlcykKK2xwZmNfbWVtY3B5X2Zyb21fc2xpbSh2b2lkICpkZXN0LCB2b2lk
IF9faW9tZW0gKnNyYywgdW5zaWduZWQgaW50IGJ5dGVzKQogewogCXVpbnQzMl90ICpkZXN0MzI7
CiAJdWludDMyX3QgX19pb21lbSAqc3JjMzI7CkBAIC03MCw4ICs3MCw4IEBAIGxwZmNfbWVtY3B5
X2Zyb21fc2xpbSggdm9pZCAqZGVzdCwgdm9pZCBfX2lvbWVtICpzcmMsIHVuc2lnbmVkIGludCBi
eXRlcykKIAlzcmMzMiAgPSAodWludDMyX3QgX19pb21lbSAqKSBzcmM7CiAKIAkvKiByZWFkIGlu
cHV0IGJ5dGVzLCA0IGJ5dGVzIGF0IGEgdGltZSAqLwotCWZvciAoZm91cl9ieXRlcyA9IGJ5dGVz
IC80OyBmb3VyX2J5dGVzID4gMDsgZm91cl9ieXRlcy0tKSB7Ci0JCSpkZXN0MzIgPSByZWFkbCgg
c3JjMzIpOworCWZvciAoZm91cl9ieXRlcyA9IGJ5dGVzIC8gNDsgZm91cl9ieXRlcyA+IDA7IGZv
dXJfYnl0ZXMtLSkgeworCQkqZGVzdDMyID0gcmVhZGwoc3JjMzIpOwogCQlkZXN0MzIrKzsKIAkJ
c3JjMzIrKzsKIAl9CkBAIC04MiwxNyArODIsMTcgQEAgbHBmY19tZW1jcHlfZnJvbV9zbGltKCB2
b2lkICpkZXN0LCB2b2lkIF9faW9tZW0gKnNyYywgdW5zaWduZWQgaW50IGJ5dGVzKQogI2Vsc2UK
IAogc3RhdGljIGlubGluZSB2b2lkCi1scGZjX21lbWNweV90b19zbGltKCB2b2lkIF9faW9tZW0g
KmRlc3QsIHZvaWQgKnNyYywgdW5zaWduZWQgaW50IGJ5dGVzKQorbHBmY19tZW1jcHlfdG9fc2xp
bSh2b2lkIF9faW9tZW0gKmRlc3QsIHZvaWQgKnNyYywgdW5zaWduZWQgaW50IGJ5dGVzKQogewog
CS8qIGNvbnZlcnQgYnl0ZXMgaW4gYXJndW1lbnQgbGlzdCB0byB3b3JkIGNvdW50IGZvciBjb3B5
IGZ1bmN0aW9uICovCiAJX19pb3dyaXRlMzJfY29weShkZXN0LCBzcmMsIGJ5dGVzIC8gc2l6ZW9m
KHVpbnQzMl90KSk7CiB9CiAKIHN0YXRpYyBpbmxpbmUgdm9pZAotbHBmY19tZW1jcHlfZnJvbV9z
bGltKCB2b2lkICpkZXN0LCB2b2lkIF9faW9tZW0gKnNyYywgdW5zaWduZWQgaW50IGJ5dGVzKQor
bHBmY19tZW1jcHlfZnJvbV9zbGltKHZvaWQgKmRlc3QsIHZvaWQgX19pb21lbSAqc3JjLCB1bnNp
Z25lZCBpbnQgYnl0ZXMpCiB7CiAJLyogYWN0dWFsbHkgcmV0dXJucyAxIGJ5dGUgcGFzdCBkZXN0
ICovCi0JbWVtY3B5X2Zyb21pbyggZGVzdCwgc3JjLCBieXRlcyk7CisJbWVtY3B5X2Zyb21pbyhk
ZXN0LCBzcmMsIGJ5dGVzKTsKIH0KIAogI2VuZGlmCS8qIF9fQklHX0VORElBTiAqLwotLSAKMi4x
Ny4xCg==
