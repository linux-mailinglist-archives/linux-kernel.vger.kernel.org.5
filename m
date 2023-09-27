Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CFB7AFB26
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjI0Gd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjI0Gdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:33:42 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1918FB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:33:40 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 14:32:23
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 14:32:23 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     linux@armlinux.org.uk, prathubaronia2011@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vidio: Clean up errors in serial.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <706285a.86e.18ad556b0e1.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD93zBNlV+i9AA--.623W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8ANQABsc
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
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCgpTaWduZWQtb2ZmLWJ5OiBH
dW9IdWEgQ2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBpbmNsdWRlL2xpbnV4L2FtYmEv
Y2xjZC5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9hbWJhL2NsY2QuaCBiL2luY2x1ZGUvbGlu
dXgvYW1iYS9jbGNkLmgKaW5kZXggYjZlMGNiZWFmNTMzLi42NGRmODIzNWQ5Y2MgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvbGludXgvYW1iYS9jbGNkLmgKKysrIGIvaW5jbHVkZS9saW51eC9hbWJhL2Ns
Y2QuaApAQCAtMjQ0LDcgKzI0NCw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IGNsY2RmYl9jaGVjayhz
dHJ1Y3QgY2xjZF9mYiAqZmIsIHN0cnVjdCBmYl92YXJfc2NyZWVuaW5mbyAqdmFyCiAJdmFyLT54
cmVzX3ZpcnR1YWwgPSB2YXItPnhyZXMgPSAodmFyLT54cmVzICsgMTUpICYgfjE1OwogCXZhci0+
eXJlc192aXJ0dWFsID0gdmFyLT55cmVzID0gKHZhci0+eXJlcyArIDEpICYgfjE7CiAKLSNkZWZp
bmUgQ0hFQ0soZSxsLGgpICh2YXItPmUgPCBsIHx8IHZhci0+ZSA+IGgpCisjZGVmaW5lIENIRUNL
KGUsIGwsIGgpICh2YXItPmUgPCBsIHx8IHZhci0+ZSA+IGgpCiAJaWYgKENIRUNLKHJpZ2h0X21h
cmdpbiwgKDUrMSksIDI1NikgfHwJLyogYmFjayBwb3JjaCAqLwogCSAgICBDSEVDSyhsZWZ0X21h
cmdpbiwgKDUrMSksIDI1NikgfHwJLyogZnJvbnQgcG9yY2ggKi8KIAkgICAgQ0hFQ0soaHN5bmNf
bGVuLCAoNSsxKSwgMjU2KSB8fAotLSAKMi4xNy4xCg==
