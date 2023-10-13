Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1897C7C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjJMDje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJMDjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:39:33 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67052A9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:39:31 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 11:37:49
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 11:37:49 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org
Subject: [PATCH] drbd: Clean up errors in drbd.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4b210be.94a.18b271ca056.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD+Nuyhl5djBAA--.681W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAGQAcsY
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
c3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc9JyAoY3R4OlZ4VykKClNpZ25lZC1vZmYtYnk6
IEd1b0h1YSBDaGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGluY2x1ZGUvbGludXgvZHJi
ZC5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kcmJkLmggYi9pbmNsdWRlL2xpbnV4L2RyYmQu
aAppbmRleCA1NDY4YTIzOTlkNDguLjNhOGM2MGVhZjNiZCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9s
aW51eC9kcmJkLmgKKysrIGIvaW5jbHVkZS9saW51eC9kcmJkLmgKQEAgLTEzOSw3ICsxMzksNyBA
QCBlbnVtIGRyYmRfcmV0X2NvZGUgewogCUVSUl9DU1VNU19BTEdfTkQJPSAxNDUsIC8qIERSQkQg
OC4yIG9ubHkgKi8KIAlFUlJfVkVSSUZZX0FMRwkJPSAxNDYsIC8qIERSQkQgOC4yIG9ubHkgKi8K
IAlFUlJfVkVSSUZZX0FMR19ORAk9IDE0NywgLyogRFJCRCA4LjIgb25seSAqLwotCUVSUl9DU1VN
U19SRVNZTkNfUlVOTklORz0gMTQ4LCAvKiBEUkJEIDguMiBvbmx5ICovCisJRVJSX0NTVU1TX1JF
U1lOQ19SVU5OSU5HID0gMTQ4LCAvKiBEUkJEIDguMiBvbmx5ICovCiAJRVJSX1ZFUklGWV9SVU5O
SU5HCT0gMTQ5LCAvKiBEUkJEIDguMiBvbmx5ICovCiAJRVJSX0RBVEFfTk9UX0NVUlJFTlQJPSAx
NTAsCiAJRVJSX0NPTk5FQ1RFRAkJPSAxNTEsIC8qIERSQkQgOC4zIG9ubHkgKi8KLS0gCjIuMTcu
MQo=
