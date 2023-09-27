Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C487AFBCF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjI0HS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI0HS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:18:56 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7101F11D;
        Wed, 27 Sep 2023 00:18:54 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 15:17:35
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 15:17:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic7xxx: aic79xx: Clean up errors in aic7xxx_proc.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <241fddbf.87f.18ad5801405.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD8P1xNl4++9AA--.675W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwAHsU
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
eHh4X3Byb2MuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9haWM3eHh4L2FpYzd4eHhf
cHJvYy5jIGIvZHJpdmVycy9zY3NpL2FpYzd4eHgvYWljN3h4eF9wcm9jLmMKaW5kZXggNGJjOWUy
ZGZjY2Y2Li4yNTY4MTZlNmQ1NzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9haWM3eHh4L2Fp
Yzd4eHhfcHJvYy5jCisrKyBiL2RyaXZlcnMvc2NzaS9haWM3eHh4L2FpYzd4eHhfcHJvYy5jCkBA
IC0yMDYsNyArMjA2LDcgQEAgYWhjX3Byb2Nfd3JpdGVfc2VlcHJvbShzdHJ1Y3QgU2NzaV9Ib3N0
ICpzaG9zdCwgY2hhciAqYnVmZmVyLCBpbnQgbGVuZ3RoKQogCQlnb3RvIGRvbmU7CiAJfQogCi0J
aGF2ZV9zZWVwcm9tID0gYWhjX3ZlcmlmeV9ja3N1bSgoc3RydWN0IHNlZXByb21fY29uZmlnKili
dWZmZXIpOworCWhhdmVfc2VlcHJvbSA9IGFoY192ZXJpZnlfY2tzdW0oKHN0cnVjdCBzZWVwcm9t
X2NvbmZpZyAqKWJ1ZmZlcik7CiAJaWYgKGhhdmVfc2VlcHJvbSA9PSAwKSB7CiAJCXByaW50aygi
YWhjX3Byb2Nfd3JpdGVfc2VlcHJvbTogY2tzdW0gdmVyaWZpY2F0aW9uIGZhaWxlZFxuIik7CiAJ
CWdvdG8gZG9uZTsKQEAgLTI4MCw3ICsyODAsNyBAQCBhaGNfcHJvY193cml0ZV9zZWVwcm9tKHN0
cnVjdCBTY3NpX0hvc3QgKnNob3N0LCBjaGFyICpidWZmZXIsIGludCBsZW5ndGgpCiAJaWYgKCFw
YXVzZWQpCiAJCWFoY191bnBhdXNlKGFoYyk7CiAJYWhjX3VubG9jayhhaGMsICZzKTsKLQlyZXR1
cm4gKHdyaXR0ZW4pOworCXJldHVybiB3cml0dGVuOwogfQogCiAvKgpAQCAtMzEyLDcgKzMxMiw3
IEBAIGFoY19saW51eF9zaG93X2luZm8oc3RydWN0IHNlcV9maWxlICptLCBzdHJ1Y3QgU2NzaV9I
b3N0ICpzaG9zdCkKIAkJCQlzZXFfcHV0YyhtLCAnXG4nKTsKIAkJCX0KIAkJCXNlcV9wcmludGYo
bSwgIjB4JS40eCAiLAotCQkJCSAgKCh1aW50MTZfdCopYWhjLT5zZWVwX2NvbmZpZylbaV0pOwor
CQkJCSAgKCh1aW50MTZfdCAqKWFoYy0+c2VlcF9jb25maWcpW2ldKTsKIAkJfQogCQlzZXFfcHV0
YyhtLCAnXG4nKTsKIAl9Ci0tIAoyLjE3LjEK
