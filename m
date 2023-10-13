Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F907C7BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjJMCjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMCjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:39:45 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D4FF83;
        Thu, 12 Oct 2023 19:39:43 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 10:38:01
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 10:38:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: Clean up errors in acpi.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <547f8b.93e.18b26e5e031.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDXaD6JrShlZ9fBAA--.621W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAEwADsN
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
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFm
dGVyIHRoYXQgJzsnIChjdHg6VnhWKQoKU2lnbmVkLW9mZi1ieTogR3VvSHVhIENoZW5nIDxjaGVu
Z3VvaHVhQGphcmkuY24+Ci0tLQogaW5jbHVkZS9saW51eC9hY3BpLmggfCA0ICsrLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9hY3BpLmggYi9pbmNsdWRlL2xpbnV4L2FjcGkuaAppbmRleCA5YmNmNTY0
MWE3Y2YuLmI1NWE4YWM2MjdlOSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9hY3BpLmgKKysr
IGIvaW5jbHVkZS9saW51eC9hY3BpLmgKQEAgLTE0MjEsNyArMTQyMSw3IEBAIGFjcGlfZ3JhcGhf
Z2V0X3JlbW90ZV9lbmRwb2ludChjb25zdCBzdHJ1Y3QgZndub2RlX2hhbmRsZSAqZndub2RlLAog
fQogCiAjZGVmaW5lIEFDUElfREVDTEFSRV9QUk9CRV9FTlRSWSh0YWJsZSwgbmFtZSwgdGFibGVf
aWQsIHN1YnRhYmxlLCB2YWxpZCwgZGF0YSwgZm4pIFwKLQlzdGF0aWMgY29uc3Qgdm9pZCAqIF9f
YWNwaV90YWJsZV8jI25hbWVbXQkJCVwKKwlzdGF0aWMgY29uc3Qgdm9pZCAqX19hY3BpX3RhYmxl
XyMjbmFtZVtdCQkJXAogCQlfX2F0dHJpYnV0ZV9fKCh1bnVzZWQpKQkJCQkJXAogCQkgPSB7ICh2
b2lkICopIHRhYmxlX2lkLAkJCQkJXAogCQkgICAgICh2b2lkICopIHN1YnRhYmxlLAkJCQkJXApA
QCAtMTQyOSw3ICsxNDI5LDcgQEAgYWNwaV9ncmFwaF9nZXRfcmVtb3RlX2VuZHBvaW50KGNvbnN0
IHN0cnVjdCBmd25vZGVfaGFuZGxlICpmd25vZGUsCiAJCSAgICAgKHZvaWQgKikgZm4sCQkJCQlc
CiAJCSAgICAgKHZvaWQgKikgZGF0YSB9CiAKLSNkZWZpbmUgYWNwaV9wcm9iZV9kZXZpY2VfdGFi
bGUodCkJKHsgaW50IF9fciA9IDA7IF9fcjt9KQorI2RlZmluZSBhY3BpX3Byb2JlX2RldmljZV90
YWJsZSh0KQkoeyBpbnQgX19yID0gMDsgX19yOyB9KQogI2VuZGlmCiAKICNpZmRlZiBDT05GSUdf
QUNQSV9UQUJMRV9VUEdSQURFCi0tIAoyLjE3LjEK
