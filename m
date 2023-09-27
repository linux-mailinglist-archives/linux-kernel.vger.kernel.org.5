Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3077E7AFC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjI0HmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjI0HmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:42:16 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0125F11D;
        Wed, 27 Sep 2023 00:42:14 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 15:40:55
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 15:40:55 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic7xxx: aic79xx: Clean up errors in aic79xx_proc.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7f087bb5.884.18ad5957238.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwC3VUCH3BNltfK9AA--.619W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwAWsF
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
Iihmb28qKSIgc2hvdWxkIGJlICIoZm9vICopIgpFUlJPUjogcmV0dXJuIGlzIG5vdCBhIGZ1bmN0
aW9uLCBwYXJlbnRoZXNlcyBhcmUgbm90IHJlcXVpcmVkCgpTaWduZWQtb2ZmLWJ5OiBHdW9IdWEg
Q2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBkcml2ZXJzL3Njc2kvYWljN3h4eC9haWM3
OXh4X3Byb2MuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9haWM3eHh4L2FpYzc5eHhf
cHJvYy5jIGIvZHJpdmVycy9zY3NpL2FpYzd4eHgvYWljNzl4eF9wcm9jLmMKaW5kZXggNzQ2ZDBj
YTJhNjU3Li44Y2E5YjE5OTQxZTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9haWM3eHh4L2Fp
Yzc5eHhfcHJvYy5jCisrKyBiL2RyaXZlcnMvc2NzaS9haWM3eHh4L2FpYzc5eHhfcHJvYy5jCkBA
IC0yMjgsNyArMjI4LDcgQEAgYWhkX3Byb2Nfd3JpdGVfc2VlcHJvbShzdHJ1Y3QgU2NzaV9Ib3N0
ICpzaG9zdCwgY2hhciAqYnVmZmVyLCBpbnQgbGVuZ3RoKQogCQlnb3RvIGRvbmU7CiAJfQogCi0J
aGF2ZV9zZWVwcm9tID0gYWhkX3ZlcmlmeV9ja3N1bSgoc3RydWN0IHNlZXByb21fY29uZmlnKili
dWZmZXIpOworCWhhdmVfc2VlcHJvbSA9IGFoZF92ZXJpZnlfY2tzdW0oKHN0cnVjdCBzZWVwcm9t
X2NvbmZpZyAqKWJ1ZmZlcik7CiAJaWYgKGhhdmVfc2VlcHJvbSA9PSAwKSB7CiAJCXByaW50aygi
YWhkX3Byb2Nfd3JpdGVfc2VlcHJvbTogY2tzdW0gdmVyaWZpY2F0aW9uIGZhaWxlZFxuIik7CiAJ
CWdvdG8gZG9uZTsKQEAgLTI2Niw3ICsyNjYsNyBAQCBhaGRfcHJvY193cml0ZV9zZWVwcm9tKHN0
cnVjdCBTY3NpX0hvc3QgKnNob3N0LCBjaGFyICpidWZmZXIsIGludCBsZW5ndGgpCiAJaWYgKCFw
YXVzZWQpCiAJCWFoZF91bnBhdXNlKGFoZCk7CiAJYWhkX3VubG9jayhhaGQsICZzKTsKLQlyZXR1
cm4gKHdyaXR0ZW4pOworCXJldHVybiB3cml0dGVuOwogfQogLyoKICAqIFJldHVybiBpbmZvcm1h
dGlvbiB0byBoYW5kbGUgL3Byb2Mgc3VwcG9ydCBmb3IgdGhlIGRyaXZlci4KQEAgLTI5OCw3ICsy
OTgsNyBAQCBhaGRfbGludXhfc2hvd19pbmZvKHN0cnVjdCBzZXFfZmlsZSAqbSwgc3RydWN0IFNj
c2lfSG9zdCAqc2hvc3QpCiAJCQkJc2VxX3B1dGMobSwgJ1xuJyk7CiAJCQl9CiAJCQlzZXFfcHJp
bnRmKG0sICIweCUuNHggIiwKLQkJCQkgICgodWludDE2X3QqKWFoZC0+c2VlcF9jb25maWcpW2ld
KTsKKwkJCQkgICgodWludDE2X3QgKilhaGQtPnNlZXBfY29uZmlnKVtpXSk7CiAJCX0KIAkJc2Vx
X3B1dGMobSwgJ1xuJyk7CiAJfQotLSAKMi4xNy4xCg==
