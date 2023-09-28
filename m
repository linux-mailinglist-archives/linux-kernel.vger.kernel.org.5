Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D2E7B111A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjI1DNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 23:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1DNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:13:24 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70AD494;
        Wed, 27 Sep 2023 20:13:22 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 11:12:00
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 11:12:00 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: Clean up errors in ipv6.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1f323424.8ac.18ad9c59948.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD8A7xRltYC+AA--.637W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAIB2UT+K8AFwACs6
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
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCgpTaWduZWQtb2ZmLWJ5OiBL
YWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogaW5jbHVkZS9uZXQvaXB2Ni5o
IHwgMTIgKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L2lwdjYuaCBiL2luY2x1ZGUvbmV0
L2lwdjYuaAppbmRleCBiMzQ0NGM4YTZmNzQuLjkwOWUwNTJmZTAxMiAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9uZXQvaXB2Ni5oCisrKyBiL2luY2x1ZGUvbmV0L2lwdjYuaApAQCAtMjYxLDE3ICsyNjEs
MTcgQEAgZXh0ZXJuIGludCBzeXNjdGxfbWxkX3FydjsKIAogLyogTUlCcyAqLwogCi0jZGVmaW5l
IElQNl9JTkNfU1RBVFMobmV0LCBpZGV2LGZpZWxkKQkJXAorI2RlZmluZSBJUDZfSU5DX1NUQVRT
KG5ldCwgaWRldiwgZmllbGQpCQlcCiAJCV9ERVZJTkMobmV0LCBpcHY2LCAsIGlkZXYsIGZpZWxk
KQotI2RlZmluZSBfX0lQNl9JTkNfU1RBVFMobmV0LCBpZGV2LGZpZWxkKQlcCisjZGVmaW5lIF9f
SVA2X0lOQ19TVEFUUyhuZXQsIGlkZXYsIGZpZWxkKQlcCiAJCV9ERVZJTkMobmV0LCBpcHY2LCBf
XywgaWRldiwgZmllbGQpCi0jZGVmaW5lIElQNl9BRERfU1RBVFMobmV0LCBpZGV2LGZpZWxkLHZh
bCkJXAorI2RlZmluZSBJUDZfQUREX1NUQVRTKG5ldCwgaWRldiwgZmllbGQsIHZhbCkJXAogCQlf
REVWQUREKG5ldCwgaXB2NiwgLCBpZGV2LCBmaWVsZCwgdmFsKQotI2RlZmluZSBfX0lQNl9BRERf
U1RBVFMobmV0LCBpZGV2LGZpZWxkLHZhbCkJXAorI2RlZmluZSBfX0lQNl9BRERfU1RBVFMobmV0
LCBpZGV2LCBmaWVsZCwgdmFsKQlcCiAJCV9ERVZBREQobmV0LCBpcHY2LCBfXywgaWRldiwgZmll
bGQsIHZhbCkKLSNkZWZpbmUgSVA2X1VQRF9QT19TVEFUUyhuZXQsIGlkZXYsZmllbGQsdmFsKSAg
IFwKKyNkZWZpbmUgSVA2X1VQRF9QT19TVEFUUyhuZXQsIGlkZXYsIGZpZWxkLCB2YWwpICAgXAog
CQlfREVWVVBEKG5ldCwgaXB2NiwgLCBpZGV2LCBmaWVsZCwgdmFsKQotI2RlZmluZSBfX0lQNl9V
UERfUE9fU1RBVFMobmV0LCBpZGV2LGZpZWxkLHZhbCkgICBcCisjZGVmaW5lIF9fSVA2X1VQRF9Q
T19TVEFUUyhuZXQsIGlkZXYsIGZpZWxkLCB2YWwpICAgXAogCQlfREVWVVBEKG5ldCwgaXB2Niwg
X18sIGlkZXYsIGZpZWxkLCB2YWwpCiAjZGVmaW5lIElDTVA2X0lOQ19TVEFUUyhuZXQsIGlkZXYs
IGZpZWxkKQlcCiAJCV9ERVZJTkNBVE9NSUMobmV0LCBpY21wdjYsICwgaWRldiwgZmllbGQpCi0t
IAoyLjE3LjEK
