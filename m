Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBC47C7BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjJMC4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMC4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:56:46 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA1C191;
        Thu, 12 Oct 2023 19:56:43 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 10:55:01
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 10:55:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] vt: Clean up errors in selection.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4545cc2c.940.18b26f571fe.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBn+D2FsShluNfBAA--.681W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAGQACsG
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKClNpZ25lZC1vZmYtYnk6IEd1b0h1YSBD
aGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGluY2x1ZGUvbGludXgvc2VsZWN0aW9uLmgg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NlbGVjdGlvbi5oIGIvaW5jbHVkZS9saW51eC9zZWxl
Y3Rpb24uaAppbmRleCAxNzBlZjI4ZmYyNmIuLjNiZmY5NTY5OTA4MyAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9saW51eC9zZWxlY3Rpb24uaAorKysgYi9pbmNsdWRlL2xpbnV4L3NlbGVjdGlvbi5oCkBA
IC0yMiw3ICsyMiw3IEBAIGV4dGVybiBpbnQgc2V0X3NlbGVjdGlvbl9rZXJuZWwoc3RydWN0IHRp
b2NsX3NlbGVjdGlvbiAqdiwKIGV4dGVybiBpbnQgcGFzdGVfc2VsZWN0aW9uKHN0cnVjdCB0dHlf
c3RydWN0ICp0dHkpOwogZXh0ZXJuIGludCBzZWxfbG9hZGx1dChjaGFyIF9fdXNlciAqcCk7CiBl
eHRlcm4gaW50IG1vdXNlX3JlcG9ydGluZyh2b2lkKTsKLWV4dGVybiB2b2lkIG1vdXNlX3JlcG9y
dChzdHJ1Y3QgdHR5X3N0cnVjdCAqIHR0eSwgaW50IGJ1dHQsIGludCBtcngsIGludCBtcnkpOwor
ZXh0ZXJuIHZvaWQgbW91c2VfcmVwb3J0KHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIGludCBidXR0
LCBpbnQgbXJ4LCBpbnQgbXJ5KTsKIAogYm9vbCB2Y19pc19zZWwoc3RydWN0IHZjX2RhdGEgKnZj
KTsKIAotLSAKMi4xNy4xCg==
