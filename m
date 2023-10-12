Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EF47C6A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343669AbjJLJ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343736AbjJLJ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:59:38 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21D55136
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:58:39 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 12 Oct 2023 17:56:58
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Thu, 12 Oct 2023 17:56:58 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     rafael.j.wysocki@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] jiffies: Clean up errors in jiffies.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7e52c005.938.18b235165c2.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwC3VUDrwidl6bTBAA--.658W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAAEWUjyrIAGQAIs-
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
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCkVSUk9SOiBzcGFjZSByZXF1
aXJlZCBiZWZvcmUgdGhlIG9wZW4gcGFyZW50aGVzaXMgJygnCgpTaWduZWQtb2ZmLWJ5OiBKaWFu
Z0h1aSBYdSA8eHVqaWFuZ2h1aUBjZGpybGMuY29tPgotLS0KIGluY2x1ZGUvbGludXgvamlmZmll
cy5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9qaWZmaWVzLmggYi9pbmNsdWRlL2xpbnV4L2pp
ZmZpZXMuaAppbmRleCBlMGFlMmE0M2UwZWIuLjZkMTZhNzk0ZjFiYSAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9saW51eC9qaWZmaWVzLmgKKysrIGIvaW5jbHVkZS9saW51eC9qaWZmaWVzLmgKQEAgLTUz
LDcgKzUzLDcgQEAKICAqICAgLSAoTk9NIC8gREVOKSBmaXRzIGluICgzMiAtIExTSCkgYml0cy4K
ICAqICAgLSAoTk9NICUgREVOKSBmaXRzIGluICgzMiAtIExTSCkgYml0cy4KICAqLwotI2RlZmlu
ZSBTSF9ESVYoTk9NLERFTixMU0gpICggICAoKChOT00pIC8gKERFTikpIDw8IChMU0gpKSAgICAg
ICAgICAgICAgXAorI2RlZmluZSBTSF9ESVYoTk9NLCBERU4sIExTSCkgKCgoKE5PTSkgLyAoREVO
KSkgPDwgKExTSCkpICAgICAgICAgICAgICBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICsgKCgoKE5PTSkgJSAoREVOKSkgPDwgKExTSCkpICsgKERFTikgLyAyKSAvIChERU4pKQogCiAv
KiBMQVRDSCBpcyB1c2VkIGluIHRoZSBpbnRlcnZhbCB0aW1lciBhbmQgZnRhcGUgc2V0dXAuICov
Ci0tIAoyLjE3LjEK
