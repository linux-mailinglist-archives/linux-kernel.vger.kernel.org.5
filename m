Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A565C7B1125
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjI1DWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 23:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1DWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:22:00 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3FE094
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 20:21:56 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 11:20:37
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 11:20:37 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     terrelln@fb.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] zstd: Clean up errors in zstd_decompress_block.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4102ea9a.8ae.18ad9cd7e6d.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBn+D0F8RRl54G+AA--.638W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAIB2UT+K8AFwALsz
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
ZWNvbXByZXNzX2Jsb2NrLmggfCAxNCArKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9saWIvenN0ZC9kZWNv
bXByZXNzL3pzdGRfZGVjb21wcmVzc19ibG9jay5oIGIvbGliL3pzdGQvZGVjb21wcmVzcy96c3Rk
X2RlY29tcHJlc3NfYmxvY2suaAppbmRleCAzZDJkNTdhNWQyNWEuLmY1ZDg5ZmU4OWQzMiAxMDA2
NDQKLS0tIGEvbGliL3pzdGQvZGVjb21wcmVzcy96c3RkX2RlY29tcHJlc3NfYmxvY2suaAorKysg
Yi9saWIvenN0ZC9kZWNvbXByZXNzL3pzdGRfZGVjb21wcmVzc19ibG9jay5oCkBAIC00NSw5ICs0
NSw5IEBAIHR5cGVkZWYgZW51bSB7CiAgKiBAcmV0dXJuIDogZGVjb21wcmVzc2VkIGJsb2NrIHNp
emUsCiAgKiAgICAgICAgICAgb3IgYW4gZXJyb3IgY29kZSAod2hpY2ggY2FuIGJlIHRlc3RlZCB1
c2luZyBaU1REX2lzRXJyb3IoKSkKICAqLwotc2l6ZV90IFpTVERfZGVjb21wcmVzc0Jsb2NrX2lu
dGVybmFsKFpTVERfREN0eCogZGN0eCwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2
b2lkKiBkc3QsIHNpemVfdCBkc3RDYXBhY2l0eSwKLSAgICAgICAgICAgICAgICAgICAgICAgICBj
b25zdCB2b2lkKiBzcmMsIHNpemVfdCBzcmNTaXplLCBjb25zdCBpbnQgZnJhbWUsIGNvbnN0IHN0
cmVhbWluZ19vcGVyYXRpb24gc3RyZWFtaW5nKTsKK3NpemVfdCBaU1REX2RlY29tcHJlc3NCbG9j
a19pbnRlcm5hbChaU1REX0RDdHggKmRjdHgsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdm9pZCAqZHN0LCBzaXplX3QgZHN0Q2FwYWNpdHksCisgICAgICAgICAgICAgICAgICAgICAg
ICAgY29uc3Qgdm9pZCAqc3JjLCBzaXplX3Qgc3JjU2l6ZSwgY29uc3QgaW50IGZyYW1lLCBjb25z
dCBzdHJlYW1pbmdfb3BlcmF0aW9uIHN0cmVhbWluZyk7CiAKIC8qIFpTVERfYnVpbGRGU0VUYWJs
ZSgpIDoKICAqIGdlbmVyYXRlIEZTRSBkZWNvZGluZyB0YWJsZSBmb3Igb25lIHN5bWJvbCAobGws
IG1sIG9yIG9mZikKQEAgLTU4LDEwICs1OCwxMCBAQCBzaXplX3QgWlNURF9kZWNvbXByZXNzQmxv
Y2tfaW50ZXJuYWwoWlNURF9EQ3R4KiBkY3R4LAogICogZGVmaW5lZCBpbiB6c3RkX2RlY29tcHJl
c3NfaW50ZXJuYWwuaC4KICAqIEludGVybmFsIHVzZSBvbmx5LgogICovCi12b2lkIFpTVERfYnVp
bGRGU0VUYWJsZShaU1REX3NlcVN5bWJvbCogZHQsCi0gICAgICAgICAgICAgY29uc3Qgc2hvcnQq
IG5vcm1hbGl6ZWRDb3VudGVyLCB1bnNpZ25lZCBtYXhTeW1ib2xWYWx1ZSwKLSAgICAgICAgICAg
ICBjb25zdCBVMzIqIGJhc2VWYWx1ZSwgY29uc3QgVTgqIG5iQWRkaXRpb25hbEJpdHMsCi0gICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgdGFibGVMb2csIHZvaWQqIHdrc3AsIHNpemVfdCB3a3Nw
U2l6ZSwKK3ZvaWQgWlNURF9idWlsZEZTRVRhYmxlKFpTVERfc2VxU3ltYm9sICpkdCwKKyAgICAg
ICAgICAgICBjb25zdCBzaG9ydCAqbm9ybWFsaXplZENvdW50ZXIsIHVuc2lnbmVkIG1heFN5bWJv
bFZhbHVlLAorICAgICAgICAgICAgIGNvbnN0IFUzMiAqYmFzZVZhbHVlLCBjb25zdCBVOCAqbmJB
ZGRpdGlvbmFsQml0cywKKyAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCB0YWJsZUxvZywgdm9p
ZCAqd2tzcCwgc2l6ZV90IHdrc3BTaXplLAogICAgICAgICAgICAgICAgICAgIGludCBibWkyKTsK
IAogCi0tIAoyLjE3LjEK
