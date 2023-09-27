Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E857AFAFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjI0GWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjI0GVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:21:38 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C31F19F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:21:36 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 14:20:03
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 14:20:03 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] timex: Clean up errors in timex.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <34f1ce02.866.18ad54b684b.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDXaD6TyRNlvOa9AA--.567W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AMgABsb
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
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKClNpZ25lZC1vZmYtYnk6IEd1b0h1YSBD
aGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGluY2x1ZGUvbGludXgvdGltZXguaCB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvdGltZXguaCBiL2luY2x1ZGUvbGludXgvdGltZXguaAppbmRl
eCAzODcxYjA2YmQzMDIuLjNmNjU5MmFhNjc1YiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC90
aW1leC5oCisrKyBiL2luY2x1ZGUvbGludXgvdGltZXguaApAQCAtMTYwLDcgKzE2MCw3IEBAIGV4
dGVybiB1bnNpZ25lZCBsb25nIHRpY2tfbnNlYzsJCS8qIFNISUZURURfSFogcGVyaW9kIChuc2Vj
KSAqLwogI2RlZmluZSBOVFBfSU5URVJWQUxfTEVOR1RIIChOU0VDX1BFUl9TRUMvTlRQX0lOVEVS
VkFMX0ZSRVEpCiAKIGV4dGVybiBpbnQgZG9fYWRqdGltZXgoc3RydWN0IF9fa2VybmVsX3RpbWV4
ICopOwotZXh0ZXJuIGludCBkb19jbG9ja19hZGp0aW1lKGNvbnN0IGNsb2NraWRfdCB3aGljaF9j
bG9jaywgc3RydWN0IF9fa2VybmVsX3RpbWV4ICoga3R4KTsKK2V4dGVybiBpbnQgZG9fY2xvY2tf
YWRqdGltZShjb25zdCBjbG9ja2lkX3Qgd2hpY2hfY2xvY2ssIHN0cnVjdCBfX2tlcm5lbF90aW1l
eCAqa3R4KTsKIAogZXh0ZXJuIHZvaWQgaGFyZHBwcyhjb25zdCBzdHJ1Y3QgdGltZXNwZWM2NCAq
LCBjb25zdCBzdHJ1Y3QgdGltZXNwZWM2NCAqKTsKIAotLSAKMi4xNy4xCgo=
