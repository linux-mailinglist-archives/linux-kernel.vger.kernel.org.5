Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504C87C6902
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbjJLJIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbjJLJID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:08:03 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88D5F98;
        Thu, 12 Oct 2023 02:07:58 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 12 Oct 2023 17:06:10
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Thu, 12 Oct 2023 17:06:10 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     dhowells@redhat.com, jarkko@kernel.org
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: Clean up errors in key.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1f5f72f6.936.18b2322e256.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDXaD4DtydlXbHBAA--.619W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAAEWUjyrIAGQACs1
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwoKU2lnbmVkLW9m
Zi1ieTogR3VvSHVhIENoZW5nIDxjaGVuZ3VvaHVhQGphcmkuY24+Ci0tLQogaW5jbHVkZS9saW51
eC9rZXkuaCB8IDE4ICsrKysrKysrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0
aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2tleS5o
IGIvaW5jbHVkZS9saW51eC9rZXkuaAppbmRleCA5MzhkN2VjZmI0OTUuLjQ4YTQzYzllZmFlZCAx
MDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9rZXkuaAorKysgYi9pbmNsdWRlL2xpbnV4L2tleS5o
CkBAIC01MDMsMTggKzUwMywxOCBAQCBleHRlcm4gdm9pZCBrZXlfaW5pdCh2b2lkKTsKICNkZWZp
bmUga2V5X3ZhbGlkYXRlKGspCQkJMAogI2RlZmluZSBrZXlfc2VyaWFsKGspCQkJMAogI2RlZmlu
ZSBrZXlfZ2V0KGspIAkJCSh7IE5VTEw7IH0pCi0jZGVmaW5lIGtleV9yZXZva2UoaykJCQlkbyB7
IH0gd2hpbGUoMCkKLSNkZWZpbmUga2V5X2ludmFsaWRhdGUoaykJCWRvIHsgfSB3aGlsZSgwKQot
I2RlZmluZSBrZXlfcHV0KGspCQkJZG8geyB9IHdoaWxlKDApCi0jZGVmaW5lIGtleV9yZWZfcHV0
KGspCQkJZG8geyB9IHdoaWxlKDApCisjZGVmaW5lIGtleV9yZXZva2UoaykJCQlkbyB7IH0gd2hp
bGUgKDApCisjZGVmaW5lIGtleV9pbnZhbGlkYXRlKGspCQlkbyB7IH0gd2hpbGUgKDApCisjZGVm
aW5lIGtleV9wdXQoaykJCQlkbyB7IH0gd2hpbGUgKDApCisjZGVmaW5lIGtleV9yZWZfcHV0KGsp
CQkJZG8geyB9IHdoaWxlICgwKQogI2RlZmluZSBtYWtlX2tleV9yZWYoaywgcCkJCU5VTEwKICNk
ZWZpbmUga2V5X3JlZl90b19wdHIoaykJCU5VTEwKICNkZWZpbmUgaXNfa2V5X3Bvc3Nlc3NlZChr
KQkJMAotI2RlZmluZSBrZXlfZnN1aWRfY2hhbmdlZChjKQkJZG8geyB9IHdoaWxlKDApCi0jZGVm
aW5lIGtleV9mc2dpZF9jaGFuZ2VkKGMpCQlkbyB7IH0gd2hpbGUoMCkKLSNkZWZpbmUga2V5X2lu
aXQoKQkJCWRvIHsgfSB3aGlsZSgwKQotI2RlZmluZSBrZXlfZnJlZV91c2VyX25zKG5zKQkJZG8g
eyB9IHdoaWxlKDApCi0jZGVmaW5lIGtleV9yZW1vdmVfZG9tYWluKGQpCQlkbyB7IH0gd2hpbGUo
MCkKKyNkZWZpbmUga2V5X2ZzdWlkX2NoYW5nZWQoYykJCWRvIHsgfSB3aGlsZSAoMCkKKyNkZWZp
bmUga2V5X2ZzZ2lkX2NoYW5nZWQoYykJCWRvIHsgfSB3aGlsZSAoMCkKKyNkZWZpbmUga2V5X2lu
aXQoKQkJCWRvIHsgfSB3aGlsZSAoMCkKKyNkZWZpbmUga2V5X2ZyZWVfdXNlcl9ucyhucykJCWRv
IHsgfSB3aGlsZSAoMCkKKyNkZWZpbmUga2V5X3JlbW92ZV9kb21haW4oZCkJCWRvIHsgfSB3aGls
ZSAoMCkKIAogI2VuZGlmIC8qIENPTkZJR19LRVlTICovCiAjZW5kaWYgLyogX19LRVJORUxfXyAq
LwotLSAKMi4xNy4xCg==
