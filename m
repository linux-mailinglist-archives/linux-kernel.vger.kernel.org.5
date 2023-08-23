Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2097078537A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbjHWJGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjHWJEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:04:01 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98623CC7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:58:37 -0700 (PDT)
Received: from chenxuebing$jari.cn ( [125.70.163.142] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 23 Aug 2023 16:58:07
 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.142]
Date:   Wed, 23 Aug 2023 16:58:07 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Clean up errors in nbio_v7_4.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <33f75a47.621.18a219d8b09.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDXaD4fyuVkL16QAA--.420W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAMCmTkgo0ATAACsG
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
dGhhdCBvcGVuIGJyYWNlIHsgc2hvdWxkIGJlIG9uIHRoZSBwcmV2aW91cyBsaW5lCkVSUk9SOiBz
cGFjZSBwcm9oaWJpdGVkIGJlZm9yZSB0aGF0ICcsJyAoY3R4Old4VykKClNpZ25lZC1vZmYtYnk6
IFh1ZUJpbmcgQ2hlbiA8Y2hlbnh1ZWJpbmdAamFyaS5jbj4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9uYmlvX3Y3XzQuYyB8IDUgKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvbmJpb192N180LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3
XzQuYwppbmRleCA2ODVhYmY1N2ZmZGQuLjI3NGY3MmNiZDRkZCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbmJpb192N180LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvbmJpb192N180LmMKQEAgLTIzNCw3ICsyMzQsNyBAQCBzdGF0aWMgdm9pZCBuYmlv
X3Y3XzRfZW5hYmxlX2Rvb3JiZWxsX3NlbGZyaW5nX2FwZXJ0dXJlKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZAogc3RhdGljIHZvaWQgbmJpb192N180X2loX2Rvb3JiZWxsX3JhbmdlKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LAogCQkJCQlib29sIHVzZV9kb29yYmVsbCwgaW50IGRvb3JiZWxs
X2luZGV4KQogewotCXUzMiBpaF9kb29yYmVsbF9yYW5nZSA9IFJSRUczMl9TT0MxNShOQklPLCAw
ICwgbW1CSUZfSUhfRE9PUkJFTExfUkFOR0UpOworCXUzMiBpaF9kb29yYmVsbF9yYW5nZSA9IFJS
RUczMl9TT0MxNShOQklPLCAwLCBtbUJJRl9JSF9ET09SQkVMTF9SQU5HRSk7CiAKIAlpZiAodXNl
X2Rvb3JiZWxsKSB7CiAJCWloX2Rvb3JiZWxsX3JhbmdlID0gUkVHX1NFVF9GSUVMRChpaF9kb29y
YmVsbF9yYW5nZSwgQklGX0lIX0RPT1JCRUxMX1JBTkdFLCBPRkZTRVQsIGRvb3JiZWxsX2luZGV4
KTsKQEAgLTYyMCw4ICs2MjAsNyBAQCBzdGF0aWMgdm9pZCBuYmlvX3Y3XzRfcXVlcnlfcmFzX2Vy
cm9yX2NvdW50KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQllbHNlCiAJCQlXUkVHMzJf
UENJRShzbW5SQVNfR0xPQkFMX1NUQVRVU19MTywgZ2xvYmFsX3N0cyk7CiAKLQkJaWYgKGZhdGFs
KQotCQl7CisJCWlmIChmYXRhbCkgewogCQkJLyogY2xlYXIgcGFyaXR5IGZhdGFsIGVycm9yIGlu
ZGljYXRpb24gZmllbGQgKi8KIAkJCWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9BTERFQkFS
QU4pCiAJCQkJV1JFRzMyX1BDSUUoc21uUEFSSVRZX0VSUk9SX1NUQVRVU19VTkNPUlJfR1JQMl9B
TERFLCBwYXJpdHlfc3RzKTsKLS0gCjIuMTcuMQo=
