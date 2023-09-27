Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3AC7AFC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjI0HhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0HhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:37:11 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E62B10E;
        Wed, 27 Sep 2023 00:37:08 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 15:35:50
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 15:35:50 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic7xxx: Clean up errors in aic7xxx.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3d665d21.883.18ad590c856.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD9W2xNl8fG9AA--.626W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwATsA
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
ImZvbyBfX21heWJlX3VudXNlZAkgYmFyIiBzaG91bGQgYmUgImZvbyBfX21heWJlX3VudXNlZCBi
YXIiCkVSUk9SOiAiZm9vKgliYXIiIHNob3VsZCBiZSAiZm9vICpiYXIiCgpTaWduZWQtb2ZmLWJ5
OiBHdW9IdWEgQ2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBkcml2ZXJzL3Njc2kvYWlj
N3h4eC9haWM3eHh4LmggfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvYWljN3h4eC9haWM3
eHh4LmggYi9kcml2ZXJzL3Njc2kvYWljN3h4eC9haWM3eHh4LmgKaW5kZXggOWJjNzU1YTBhMmQz
Li4zM2YxYTlhYzQ2ODIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9haWM3eHh4L2FpYzd4eHgu
aAorKysgYi9kcml2ZXJzL3Njc2kvYWljN3h4eC9haWM3eHh4LmgKQEAgLTUxMiw3ICs1MTIsNyBA
QCBzdHJ1Y3QgYWhjX2RtYV9zZWcgewogc3RydWN0IHNnX21hcF9ub2RlIHsKIAlidXNfZG1hbWFw
X3QJCSBzZ19kbWFtYXA7CiAJZG1hX2FkZHJfdAkJIHNnX3BoeXNhZGRyOwotCXN0cnVjdCBhaGNf
ZG1hX3NlZyoJIHNnX3ZhZGRyOworCXN0cnVjdCBhaGNfZG1hX3NlZyAqc2dfdmFkZHI7CiAJU0xJ
U1RfRU5UUlkoc2dfbWFwX25vZGUpIGxpbmtzOwogfTsKIApAQCAtNzExLDcgKzcxMSw3IEBAIHN0
cnVjdCBhaGNfaW5pdGlhdG9yX3RpbmZvIHsKICAqIG5lZ290aWF0aW9uIGlzIHRoZSBzYW1lIHJl
Z2FyZGxlc3Mgb2Ygcm9sZS4KICAqLwogc3RydWN0IGFoY190bW9kZV90c3RhdGUgewotCXN0cnVj
dCBhaGNfdG1vZGVfbHN0YXRlKgllbmFibGVkX2x1bnNbQUhDX05VTV9MVU5TXTsKKwlzdHJ1Y3Qg
YWhjX3Rtb2RlX2xzdGF0ZSAqZW5hYmxlZF9sdW5zW0FIQ19OVU1fTFVOU107CiAJc3RydWN0IGFo
Y19pbml0aWF0b3JfdGluZm8JdHJhbnNpbmZvW0FIQ19OVU1fVEFSR0VUU107CiAKIAkvKgpAQCAt
MTEzMiw3ICsxMTMyLDcgQEAgY29uc3Qgc3RydWN0IGFoY19wY2lfaWRlbnRpdHkJKmFoY19maW5k
X3BjaV9kZXZpY2UoYWhjX2Rldl9zb2Z0Y190KTsKIGludAkJCSBhaGNfcGNpX2NvbmZpZyhzdHJ1
Y3QgYWhjX3NvZnRjICosCiAJCQkJCWNvbnN0IHN0cnVjdCBhaGNfcGNpX2lkZW50aXR5ICopOwog
aW50CQkJIGFoY19wY2lfdGVzdF9yZWdpc3Rlcl9hY2Nlc3Moc3RydWN0IGFoY19zb2Z0YyAqKTsK
LXZvaWQgX19tYXliZV91bnVzZWQJIGFoY19wY2lfcmVzdW1lKHN0cnVjdCBhaGNfc29mdGMgKmFo
Yyk7Cit2b2lkIF9fbWF5YmVfdW51c2VkIGFoY19wY2lfcmVzdW1lKHN0cnVjdCBhaGNfc29mdGMg
KmFoYyk7CiAKIC8qKioqKioqKioqKioqKioqKioqKioqKioqKiogRUlTQS9WTCBGcm9udCBFbmQg
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCiBzdHJ1Y3QgYWljNzc3MF9pZGVudGl0
eSAqYWljNzc3MF9maW5kX2RldmljZSh1aW50MzJfdCk7Ci0tIAoyLjE3LjEK
