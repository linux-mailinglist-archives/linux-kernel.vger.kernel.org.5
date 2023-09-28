Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0112F7B1128
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjI1DYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 23:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1DYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:24:30 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9461699
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 20:24:28 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 11:23:09
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 11:23:09 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     terrelln@fb.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: zstd: Clean up errors in zstd_ddict.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2d0d3dda.8af.18ad9cfcf71.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDnhD+d8RRlQ4K+AA--.600W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAIB2UT+K8AFwANs1
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
ImZvbyogYmFyIiBzaG91bGQgYmUgImZvbyAqYmFyIgoKU2lnbmVkLW9mZi1ieTogS2FpTG9uZyBX
YW5nIDx3YW5na2FpbG9uZ0BqYXJpLmNuPgotLS0KIGxpYi96c3RkL2RlY29tcHJlc3MvenN0ZF9k
ZGljdC5oIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGliL3pzdGQvZGVjb21wcmVzcy96c3RkX2RkaWN0Lmgg
Yi9saWIvenN0ZC9kZWNvbXByZXNzL3pzdGRfZGRpY3QuaAppbmRleCA4YzFhNzlkNjY2ZjguLjhm
ZDE1ZmNhMzcyNCAxMDA2NDQKLS0tIGEvbGliL3pzdGQvZGVjb21wcmVzcy96c3RkX2RkaWN0LmgK
KysrIGIvbGliL3pzdGQvZGVjb21wcmVzcy96c3RkX2RkaWN0LmgKQEAgLTM0LDEwICszNCwxMCBA
QAogICogWlNURF9nZXREaWN0SURfZnJvbURpY3QoKQogICovCiAKLWNvbnN0IHZvaWQqIFpTVERf
RERpY3RfZGljdENvbnRlbnQoY29uc3QgWlNURF9ERGljdCogZGRpY3QpOwotc2l6ZV90IFpTVERf
RERpY3RfZGljdFNpemUoY29uc3QgWlNURF9ERGljdCogZGRpY3QpOworY29uc3Qgdm9pZCAqWlNU
RF9ERGljdF9kaWN0Q29udGVudChjb25zdCBaU1REX0REaWN0ICpkZGljdCk7CitzaXplX3QgWlNU
RF9ERGljdF9kaWN0U2l6ZShjb25zdCBaU1REX0REaWN0ICpkZGljdCk7CiAKLXZvaWQgWlNURF9j
b3B5RERpY3RQYXJhbWV0ZXJzKFpTVERfREN0eCogZGN0eCwgY29uc3QgWlNURF9ERGljdCogZGRp
Y3QpOwordm9pZCBaU1REX2NvcHlERGljdFBhcmFtZXRlcnMoWlNURF9EQ3R4ICpkY3R4LCBjb25z
dCBaU1REX0REaWN0ICpkZGljdCk7CiAKIAogCi0tIAoyLjE3LjEK
