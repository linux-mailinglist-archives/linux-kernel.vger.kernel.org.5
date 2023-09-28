Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672437B111C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjI1DQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 23:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1DQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:16:05 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8EF394;
        Wed, 27 Sep 2023 20:16:03 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 11:14:40
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 11:14:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: snmp: Clean up errors in snmp.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <55bdec01.8ad.18ad9c80cca.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwC3VUCg7xRlEIG+AA--.629W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAIB2UT+K8AFwAHs-
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
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCkVSUk9SOiBzcGFjZXMgcmVx
dWlyZWQgYXJvdW5kIHRoYXQgJz09JyAoY3R4OlZ4VikKClNpZ25lZC1vZmYtYnk6IEthaUxvbmcg
V2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBpbmNsdWRlL25ldC9zbm1wLmggfCA0ICsr
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9uZXQvc25tcC5oIGIvaW5jbHVkZS9uZXQvc25tcC5oCmluZGV4IDQ2
OGE2NzgzNmUyZi4uOTJlOTJiZWJkZTJjIDEwMDY0NAotLS0gYS9pbmNsdWRlL25ldC9zbm1wLmgK
KysrIGIvaW5jbHVkZS9uZXQvc25tcC5oCkBAIC0zMSw3ICszMSw3IEBAIHN0cnVjdCBzbm1wX21p
YiB7CiAJaW50IGVudHJ5OwogfTsKIAotI2RlZmluZSBTTk1QX01JQl9JVEVNKF9uYW1lLF9lbnRy
eSkJewlcCisjZGVmaW5lIFNOTVBfTUlCX0lURU0oX25hbWUsIF9lbnRyeSkJewlcCiAJLm5hbWUg
PSBfbmFtZSwJCQkJXAogCS5lbnRyeSA9IF9lbnRyeSwJCQlcCiB9CkBAIC0xNTUsNyArMTU1LDcg
QEAgc3RydWN0IGxpbnV4X3Rsc19taWIgewogCX0gd2hpbGUgKDApCiAKIAotI2lmIEJJVFNfUEVS
X0xPTkc9PTMyCisjaWYgQklUU19QRVJfTE9ORyA9PSAzMgogCiAjZGVmaW5lIF9fU05NUF9BRERf
U1RBVFM2NChtaWIsIGZpZWxkLCBhZGRlbmQpIAkJCQlcCiAJZG8gewkJCQkJCQkJXAotLSAKMi4x
Ny4xCg==
