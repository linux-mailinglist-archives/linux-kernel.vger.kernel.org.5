Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FB57AFEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjI0Ig5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjI0IgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:36:08 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D06F4CC7;
        Wed, 27 Sep 2023 01:35:43 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 16:34:26
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 16:34:26 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: Clean up errors in mvme16x_scsi.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6ddb5837.88a.18ad5c66ee8.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwC3VUAS6RNl7fm9AA--.622W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwAns0
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
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKClNpZ25lZC1vZmYtYnk6IEd1b0h1YSBD
aGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGRyaXZlcnMvc2NzaS9tdm1lMTZ4X3Njc2ku
YyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9tdm1lMTZ4X3Njc2kuYyBiL2RyaXZlcnMvc2NzaS9t
dm1lMTZ4X3Njc2kuYwppbmRleCAyMWQ2MzgyOTlhYjguLjkzMWI3Mjc0NzFiZiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9zY3NpL212bWUxNnhfc2NzaS5jCisrKyBiL2RyaXZlcnMvc2NzaS9tdm1lMTZ4
X3Njc2kuYwpAQCAtMzcsNyArMzcsNyBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
bXZtZTE2eF9zY3NpX2RldmljZTsKIAogc3RhdGljIGludCBtdm1lMTZ4X3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKmRldikKIHsKLQlzdHJ1Y3QgU2NzaV9Ib3N0ICogaG9zdCA9IE5VTEw7
CisJc3RydWN0IFNjc2lfSG9zdCAqaG9zdCA9IE5VTEw7CiAJc3RydWN0IE5DUl83MDBfSG9zdF9Q
YXJhbWV0ZXJzICpob3N0ZGF0YTsKIAogCWlmICghTUFDSF9JU19NVk1FMTZ4KQotLSAKMi4xNy4x
Cg==
