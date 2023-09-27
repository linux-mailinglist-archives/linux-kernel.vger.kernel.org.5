Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37847AFBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjI0HEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0HD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:03:56 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB5C0DE;
        Wed, 27 Sep 2023 00:03:54 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 15:02:35
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 15:02:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [SCSI] aic7xxx: Clean up errors in aiclib.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5645eb7.87d.18ad5725a91.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD+L0xNl4O29AA--.625W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwABsS
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
b3BlbiBicmFjZSAneycgZm9sbG93aW5nIHN0cnVjdCBnbyBvbiB0aGUgc2FtZSBsaW5lCkVSUk9S
OiByZXR1cm4gaXMgbm90IGEgZnVuY3Rpb24sIHBhcmVudGhlc2VzIGFyZSBub3QgcmVxdWlyZWQK
RVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIHRoYXQgJywnIChjdHg6VnhWKQoKU2lnbmVkLW9m
Zi1ieTogR3VvSHVhIENoZW5nIDxjaGVuZ3VvaHVhQGphcmkuY24+Ci0tLQogZHJpdmVycy9zY3Np
L2FpYzd4eHgvYWljbGliLmggfCAxMCArKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9haWM3
eHh4L2FpY2xpYi5oIGIvZHJpdmVycy9zY3NpL2FpYzd4eHgvYWljbGliLmgKaW5kZXggYmEwOGVi
M2M0ZTNiLi5hN2QwYTJkOTEyY2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9haWM3eHh4L2Fp
Y2xpYi5oCisrKyBiL2RyaXZlcnMvc2NzaS9haWM3eHh4L2FpY2xpYi5oCkBAIC01Nyw4ICs1Nyw3
IEBACiAjaWZuZGVmCV9BSUNMSUJfSAogI2RlZmluZSBfQUlDTElCX0gKIAotc3RydWN0IHNjc2lf
c2Vuc2UKLXsKK3N0cnVjdCBzY3NpX3NlbnNlIHsKIAl1aW50OF90IG9wY29kZTsKIAl1aW50OF90
IGJ5dGUyOwogCXVpbnQ4X3QgdW51c2VkWzJdOwpAQCAtNzIsOCArNzEsNyBAQCBzdHJ1Y3Qgc2Nz
aV9zZW5zZQogI2RlZmluZQkJU0NTSV9SRVZfU1BDCQkzCiAjZGVmaW5lCQlTQ1NJX1JFVl9TUEMy
CQk0CiAKLXN0cnVjdCBzY3NpX3NlbnNlX2RhdGEKLXsKK3N0cnVjdCBzY3NpX3NlbnNlX2RhdGEg
ewogCXVpbnQ4X3QgZXJyb3JfY29kZTsKICNkZWZpbmUJU1NEX0VSUkNPREUJCQkweDdGCiAjZGVm
aW5lCQlTU0RfQ1VSUkVOVF9FUlJPUgkweDcwCkBAIC0xMzUsNyArMTMzLDcgQEAgc2NzaV80YnRv
dWwodWludDhfdCAqYnl0ZXMpCiAJICAgICAoYnl0ZXNbMV0gPDwgMTYpIHwKIAkgICAgIChieXRl
c1syXSA8PCA4KSB8CiAJICAgICBieXRlc1szXTsKLQlyZXR1cm4gKHJ2KTsKKwlyZXR1cm4gcnY7
CiB9CiAKIC8qIE1hY3JvcyBmb3IgZ2VuZXJhdGluZyB0aGUgZWxlbWVudHMgb2YgdGhlIFBDSSBJ
RCB0YWJsZXMuICovCkBAIC0xNDQsNyArMTQyLDcgQEAgc2NzaV80YnRvdWwodWludDhfdCAqYnl0
ZXMpCiAKICNkZWZpbmUgSURfQyh4LCBjKQkJCQkJCVwKIHsJCQkJCQkJCVwKLQlHRVRJRCh4LDMy
KSwgR0VUSUQoeCw0OCksIEdFVElEKHgsMCksIEdFVElEKHgsMTYpLAlcCisJR0VUSUQoeCwgMzIp
LCBHRVRJRCh4LCA0OCksIEdFVElEKHgsIDApLCBHRVRJRCh4LCAxNiksCVwKIAkoYykgPDwgOCwg
MHhGRkZGMDAsIDAJCQkJCVwKIH0KIAotLSAKMi4xNy4xCg==
