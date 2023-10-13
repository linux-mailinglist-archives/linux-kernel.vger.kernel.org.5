Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26C97C7BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjJMDRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMDRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:17:00 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FC7F91;
        Thu, 12 Oct 2023 20:16:58 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 11:15:16
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 11:15:16 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     m@bues.ch
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ssb: Clean up errors in ssb.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <54aacb43.944.18b2707fa87.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD9EtihlUdjBAA--.680W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAGQANsJ
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
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKClNpZ25lZC1vZmYtYnk6IEd1b0h1YSBD
aGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGluY2x1ZGUvbGludXgvc3NiL3NzYi5oIHwg
NiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zc2Ivc3NiLmggYi9pbmNsdWRlL2xpbnV4L3Nz
Yi9zc2IuaAppbmRleCAxZjMyNmRhMjg5ZDMuLmI2YTY3NDcxOWEyNyAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9saW51eC9zc2Ivc3NiLmgKKysrIGIvaW5jbHVkZS9saW51eC9zc2Ivc3NiLmgKQEAgLTI4
NSw3ICsyODUsNyBAQCBzdHJ1Y3Qgc3NiX2RldmljZSB7CiAKIC8qIEdvIGZyb20gc3RydWN0IGRl
dmljZSB0byBzdHJ1Y3Qgc3NiX2RldmljZS4gKi8KIHN0YXRpYyBpbmxpbmUKLXN0cnVjdCBzc2Jf
ZGV2aWNlICogZGV2X3RvX3NzYl9kZXYoY29uc3Qgc3RydWN0IGRldmljZSAqZGV2KQorc3RydWN0
IHNzYl9kZXZpY2UgKmRldl90b19zc2JfZGV2KGNvbnN0IHN0cnVjdCBkZXZpY2UgKmRldikKIHsK
IAlzdHJ1Y3QgX19zc2JfZGV2X3dyYXBwZXIgKndyYXA7CiAJd3JhcCA9IGNvbnRhaW5lcl9vZihk
ZXYsIHN0cnVjdCBfX3NzYl9kZXZfd3JhcHBlciwgZGV2KTsKQEAgLTI5OSw3ICsyOTksNyBAQCB2
b2lkIHNzYl9zZXRfZHJ2ZGF0YShzdHJ1Y3Qgc3NiX2RldmljZSAqZGV2LCB2b2lkICpkYXRhKQog
CWRldi0+ZHJ2ZGF0YSA9IGRhdGE7CiB9CiBzdGF0aWMgaW5saW5lCi12b2lkICogc3NiX2dldF9k
cnZkYXRhKHN0cnVjdCBzc2JfZGV2aWNlICpkZXYpCit2b2lkICpzc2JfZ2V0X2RydmRhdGEoc3Ry
dWN0IHNzYl9kZXZpY2UgKmRldikKIHsKIAlyZXR1cm4gZGV2LT5kcnZkYXRhOwogfQpAQCAtMzA3
LDcgKzMwNyw3IEBAIHZvaWQgKiBzc2JfZ2V0X2RydmRhdGEoc3RydWN0IHNzYl9kZXZpY2UgKmRl
dikKIC8qIERldmljZXR5cGUgc3BlY2lmaWMgdXNlciBkYXRhLiBUaGlzIGlzIHBlciBkZXZpY2Ut
dHlwZSAobm90IHBlciBkZXZpY2UpICovCiB2b2lkIHNzYl9zZXRfZGV2dHlwZWRhdGEoc3RydWN0
IHNzYl9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSk7CiBzdGF0aWMgaW5saW5lCi12b2lkICogc3Ni
X2dldF9kZXZ0eXBlZGF0YShzdHJ1Y3Qgc3NiX2RldmljZSAqZGV2KQordm9pZCAqc3NiX2dldF9k
ZXZ0eXBlZGF0YShzdHJ1Y3Qgc3NiX2RldmljZSAqZGV2KQogewogCXJldHVybiBkZXYtPmRldnR5
cGVkYXRhOwogfQotLSAKMi4xNy4xCg==
