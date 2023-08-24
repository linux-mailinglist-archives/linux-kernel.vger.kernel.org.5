Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34341786BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbjHXJ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbjHXJ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:26:05 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E792C199F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:25:59 -0700 (PDT)
Received: from chenxuebing$jari.cn ( [125.70.163.142] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 24 Aug 2023 17:25:32
 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.142]
Date:   Thu, 24 Aug 2023 17:25:32 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Clean up errors in vcn_v2_0.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6fbca6c3.649.18a26dd0269.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD8MIudkdFiSAA--.487W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQANCmTl1A4AUgADsM
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
dGhhdCBvcGVuIGJyYWNlIHsgc2hvdWxkIGJlIG9uIHRoZSBwcmV2aW91cyBsaW5lCgpTaWduZWQt
b2ZmLWJ5OiBYdWVCaW5nIENoZW4gPGNoZW54dWViaW5nQGphcmkuY24+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzAuYyB8IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmNuX3YyXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92
Ml8wLmMKaW5kZXggMTg3OTQzOTRjNWEwLi5iMzBhZTU2NGI0MGYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNuX3YyXzAuYwpAQCAtMjA5Niw4ICsyMDk2LDcgQEAgc3RhdGljIHZvaWQgdmNu
X3YyXzBfc2V0X2lycV9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlhZGV2LT52
Y24uaW5zdC0+aXJxLmZ1bmNzID0gJnZjbl92Ml8wX2lycV9mdW5jczsKIH0KIAotY29uc3Qgc3Ry
dWN0IGFtZGdwdV9pcF9ibG9ja192ZXJzaW9uIHZjbl92Ml8wX2lwX2Jsb2NrID0KLXsKK2NvbnN0
IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tfdmVyc2lvbiB2Y25fdjJfMF9pcF9ibG9jayA9IHsKIAkJ
LnR5cGUgPSBBTURfSVBfQkxPQ0tfVFlQRV9WQ04sCiAJCS5tYWpvciA9IDIsCiAJCS5taW5vciA9
IDAsCi0tIAoyLjE3LjEKCg==
