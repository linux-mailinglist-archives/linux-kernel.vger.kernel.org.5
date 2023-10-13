Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D617C7B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjJMCTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMCTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:19:17 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 350DE95
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:19:13 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 10:17:29
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 10:17:29 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Clean up errors in dcn_calc_auto.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <100592b2.93d.18b26d31479.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDXaD65qChlD9fBAA--.620W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAEAACsP
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
ZWxzZSBzaG91bGQgZm9sbG93IGNsb3NlIGJyYWNlICd9JwoKU2lnbmVkLW9mZi1ieTogR3VvSHVh
IENoZW5nIDxjaGVuZ3VvaHVhQGphcmkuY24+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RtbC9jYWxjcy9kY25fY2FsY19hdXRvLmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvY2FsY3MvZGNuX2NhbGNfYXV0by5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9jYWxjcy9kY25fY2FsY19hdXRvLmMKaW5kZXggMjg4
ZDIyYTE2Y2YyLi5jYTAyYzRiNDA0MzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kbWwvY2FsY3MvZGNuX2NhbGNfYXV0by5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kbWwvY2FsY3MvZGNuX2NhbGNfYXV0by5jCkBAIC00NSw4ICs0NSw3
IEBAIHZvaWQgc2NhbGVyX3NldHRpbmdzX2NhbGN1bGF0aW9uKHN0cnVjdCBkY25fYndfaW50ZXJu
YWxfdmFycyAqdikKIAkJCWlmICh2LT5zb3VyY2Vfc2NhbltrXSA9PSBkY25fYndfaG9yKSB7CiAJ
CQkJdi0+aF9yYXRpb1trXSA9IHYtPnZpZXdwb3J0X3dpZHRoW2tdIC8gdi0+c2NhbGVyX3JlY19v
dXRfd2lkdGhba107CiAJCQkJdi0+dl9yYXRpb1trXSA9IHYtPnZpZXdwb3J0X2hlaWdodFtrXSAv
IHYtPnNjYWxlcl9yZWNvdXRfaGVpZ2h0W2tdOwotCQkJfQotCQkJZWxzZSB7CisJCQl9IGVsc2Ug
ewogCQkJCXYtPmhfcmF0aW9ba10gPSB2LT52aWV3cG9ydF9oZWlnaHRba10gLyB2LT5zY2FsZXJf
cmVjX291dF93aWR0aFtrXTsKIAkJCQl2LT52X3JhdGlvW2tdID0gdi0+dmlld3BvcnRfd2lkdGhb
a10gLyB2LT5zY2FsZXJfcmVjb3V0X2hlaWdodFtrXTsKIAkJCX0KLS0gCjIuMTcuMQo=
