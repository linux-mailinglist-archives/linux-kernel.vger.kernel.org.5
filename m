Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D927AFB18
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjI0G3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0G3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:29:34 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A88BDD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:29:33 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 14:28:15
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 14:28:15 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     linux@armlinux.org.uk, prathubaronia2011@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] amba: Clean up errors in bus.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <65b83372.86c.18ad552ebbd.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwC3VUCAyxNlvOe9AA--.615W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8ANAAEsY
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
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCgpTaWduZWQtb2ZmLWJ5OiBH
dW9IdWEgQ2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBpbmNsdWRlL2xpbnV4L2FtYmEv
YnVzLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2FtYmEvYnVzLmggYi9pbmNsdWRlL2xpbnV4
L2FtYmEvYnVzLmgKaW5kZXggYzYwYTZhMTQ2MzhjLi4zYjNhNmNkOGViYzAgMTAwNjQ0Ci0tLSBh
L2luY2x1ZGUvbGludXgvYW1iYS9idXMuaAorKysgYi9pbmNsdWRlL2xpbnV4L2FtYmEvYnVzLmgK
QEAgLTExMCw3ICsxMTAsNyBAQCBleHRlcm4gc3RydWN0IGJ1c190eXBlIGFtYmFfYnVzdHlwZTsK
ICNkZWZpbmUgdG9fYW1iYV9kZXZpY2UoZCkJY29udGFpbmVyX29mX2NvbnN0KGQsIHN0cnVjdCBh
bWJhX2RldmljZSwgZGV2KQogCiAjZGVmaW5lIGFtYmFfZ2V0X2RydmRhdGEoZCkJZGV2X2dldF9k
cnZkYXRhKCZkLT5kZXYpCi0jZGVmaW5lIGFtYmFfc2V0X2RydmRhdGEoZCxwKQlkZXZfc2V0X2Ry
dmRhdGEoJmQtPmRldiwgcCkKKyNkZWZpbmUgYW1iYV9zZXRfZHJ2ZGF0YShkLCBwKQlkZXZfc2V0
X2RydmRhdGEoJmQtPmRldiwgcCkKIAogI2lmZGVmIENPTkZJR19BUk1fQU1CQQogaW50IGFtYmFf
ZHJpdmVyX3JlZ2lzdGVyKHN0cnVjdCBhbWJhX2RyaXZlciAqKTsKLS0gCjIuMTcuMQo=
