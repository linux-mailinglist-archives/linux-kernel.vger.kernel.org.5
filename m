Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653137C7B14
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 03:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjJMBM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 21:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJMBM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 21:12:56 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E70083
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 18:12:51 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 09:10:59
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 09:10:59 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     rafael.j.wysocki@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sonet: Clean up errors in sonet.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <ad4d09c.939.18b2696341d.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD8jmShlWdXBAA--.738W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAAEWUjyrIAGQALs8
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCgpTaWduZWQtb2ZmLWJ5OiBH
dW9IdWEgQ2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBpbmNsdWRlL2xpbnV4L3NvbmV0
LmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvbmV0LmggYi9pbmNsdWRlL2xpbnV4L3NvbmV0
LmgKaW5kZXggMmI4MDJiNmQxMmFkLi5kYjAxYTEzNjFjYjMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUv
bGludXgvc29uZXQuaAorKysgYi9pbmNsdWRlL2xpbnV4L3NvbmV0LmgKQEAgLTEzLDcgKzEzLDcg
QEAgc3RydWN0IGtfc29uZXRfc3RhdHMgewogI3VuZGVmIF9fSEFORExFX0lURU0KIH07CiAKLWV4
dGVybiB2b2lkIHNvbmV0X2NvcHlfc3RhdHMoc3RydWN0IGtfc29uZXRfc3RhdHMgKmZyb20sc3Ry
dWN0IHNvbmV0X3N0YXRzICp0byk7CitleHRlcm4gdm9pZCBzb25ldF9jb3B5X3N0YXRzKHN0cnVj
dCBrX3NvbmV0X3N0YXRzICpmcm9tLCBzdHJ1Y3Qgc29uZXRfc3RhdHMgKnRvKTsKIGV4dGVybiB2
b2lkIHNvbmV0X3N1YnRyYWN0X3N0YXRzKHN0cnVjdCBrX3NvbmV0X3N0YXRzICpmcm9tLAogICAg
IHN0cnVjdCBzb25ldF9zdGF0cyAqdG8pOwogCi0tIAoyLjE3LjEK
