Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB6A786873
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjHXHgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjHXHg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:36:29 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6AB4C7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:36:27 -0700 (PDT)
Received: from chenxuebing$jari.cn ( [125.70.163.142] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 24 Aug 2023 15:36:01
 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.142]
Date:   Thu, 24 Aug 2023 15:36:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu_vf_error.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <62c52e75.642.18a2678bbd3.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBn+D1hCOdkLDmSAA--.463W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQANCmTl1A4APAACsj
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
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCgpTaWduZWQtb2ZmLWJ5OiBY
dWVCaW5nIENoZW4gPGNoZW54dWViaW5nQGphcmkuY24+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZmX2Vycm9yLmggfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZmX2Vycm9yLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmZfZXJyb3IuaAppbmRleCA2NDM2YmQwNTMzMjUuLjdhNThiZDhjZWEwYSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZmX2Vycm9yLmgKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZmX2Vycm9yLmgKQEAgLTI0LDgg
KzI0LDggQEAKICNpZm5kZWYgX19WRl9FUlJPUl9IX18KICNkZWZpbmUgX19WRl9FUlJPUl9IX18K
IAotI2RlZmluZSBBTURHSU1fRVJST1JfQ09ERV9GTEFHU19UT19NQUlMQk9YKGMsZikgICAgKCgo
YyAmIDB4RkZGRikgPDwgMTYpIHwgKGYgJiAweEZGRkYpKQotI2RlZmluZSBBTURHSU1fRVJST1Jf
Q09ERSh0LGMpICAgICAgICgoKHQmMHhGKTw8MTIpfChjJjB4RkZGKSkKKyNkZWZpbmUgQU1ER0lN
X0VSUk9SX0NPREVfRkxBR1NfVE9fTUFJTEJPWChjLCBmKSAgICAoKChjICYgMHhGRkZGKSA8PCAx
NikgfCAoZiAmIDB4RkZGRikpCisjZGVmaW5lIEFNREdJTV9FUlJPUl9DT0RFKHQsIGMpICAgICAg
ICgoKHQmMHhGKTw8MTIpfChjJjB4RkZGKSkKIAogLyogUGxlYXNlIGtlZXAgZW51bSBzYW1lIGFz
IEFNRCBHSU0gZHJpdmVyICovCiBlbnVtIEFNREdJTV9FUlJPUl9WRiB7Ci0tIAoyLjE3LjEK
