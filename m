Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FE17AFD7E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjI0IBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjI0IB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:01:26 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16681126;
        Wed, 27 Sep 2023 01:01:21 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 16:00:03
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 16:00:03 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netlink: Clean up errors in scsi_netlink.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7a749e12.886.18ad5a6f493.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwC3VUAD4RNlffW9AA--.620W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwAcsP
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
ZWxzZSBzaG91bGQgZm9sbG93IGNsb3NlIGJyYWNlICd9JwoKU2lnbmVkLW9mZi1ieTogR3VvSHVh
IENoZW5nIDxjaGVuZ3VvaHVhQGphcmkuY24+Ci0tLQogZHJpdmVycy9zY3NpL3Njc2lfbmV0bGlu
ay5jIHwgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvc2NzaV9uZXRsaW5rLmMgYi9kcml2ZXJzL3Nj
c2kvc2NzaV9uZXRsaW5rLmMKaW5kZXggZDdmNzZmZDg0MjU2Li41ZmYyMmZlOTMyNzcgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvc2NzaS9zY3NpX25ldGxpbmsuYworKysgYi9kcml2ZXJzL3Njc2kvc2Nz
aV9uZXRsaW5rLmMKQEAgLTkxLDggKzkxLDcgQEAgc2NzaV9ubF9yY3ZfbXNnKHN0cnVjdCBza19i
dWZmICpza2IpCiAJCQlpZiAoZXJyKQogCQkJCXByaW50ayhLRVJOX1dBUk5JTkcgIiVzOiBNc2d0
eXBlICVkIGZhaWxlZCAtIGVyciAlZFxuIiwKIAkJCQkgICAgICAgX19mdW5jX18sIGhkci0+bXNn
dHlwZSwgZXJyKTsKLQkJfQotCQllbHNlCisJCX0gZWxzZQogCQkJZXJyID0gLUVOT0VOVDsKIAog
bmV4dF9tc2c6Ci0tIAoyLjE3LjEK
