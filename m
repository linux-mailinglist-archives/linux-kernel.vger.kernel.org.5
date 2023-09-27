Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BEB7AFC15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjI0H2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjI0H2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:28:08 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25438191;
        Wed, 27 Sep 2023 00:28:05 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 15:26:47
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 15:26:47 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [SCSI] aic7xxx: Clean up errors in aic79xx_inline.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3c2920eb.881.18ad5887ee9.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD832RNls_C9AA--.677W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwANse
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
cmV0dXJuIGlzIG5vdCBhIGZ1bmN0aW9uLCBwYXJlbnRoZXNlcyBhcmUgbm90IHJlcXVpcmVkCgpT
aWduZWQtb2ZmLWJ5OiBHdW9IdWEgQ2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBkcml2
ZXJzL3Njc2kvYWljN3h4eC9haWM3OXh4X2lubGluZS5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3Np
L2FpYzd4eHgvYWljNzl4eF9pbmxpbmUuaCBiL2RyaXZlcnMvc2NzaS9haWM3eHh4L2FpYzc5eHhf
aW5saW5lLmgKaW5kZXggNzY0NGUzZDJlYzIyLi5mNmUyYmQzZjIxY2IgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvc2NzaS9haWM3eHh4L2FpYzc5eHhfaW5saW5lLmgKKysrIGIvZHJpdmVycy9zY3NpL2Fp
Yzd4eHgvYWljNzl4eF9pbmxpbmUuaApAQCAtMTEwLDcgKzExMCw3IEBAIHN0YXRpYyBpbmxpbmUg
c2l6ZV90IGFoZF9zZ19zaXplKHN0cnVjdCBhaGRfc29mdGMgKmFoZCkKIHsKIAlpZiAoKGFoZC0+
ZmxhZ3MgJiBBSERfNjRCSVRfQUREUkVTU0lORykgIT0gMCkKIAkJcmV0dXJuIChzaXplb2Yoc3Ry
dWN0IGFoZF9kbWE2NF9zZWcpKTsKLQlyZXR1cm4gKHNpemVvZihzdHJ1Y3QgYWhkX2RtYV9zZWcp
KTsKKwlyZXR1cm4gc2l6ZW9mKHN0cnVjdCBhaGRfZG1hX3NlZyk7CiB9CiAKIC8qKioqKioqKioq
KioqKioqKioqKioqKiBNaXNjZWxsYW5lb3VzIFN1cHBvcnQgRnVuY3Rpb25zICoqKioqKioqKioq
KioqKioqKioqKioqLwotLSAKMi4xNy4xCgo=
