Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87967C7DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjJMGr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjJMGr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:47:26 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 262CCCE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:47:24 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 14:45:42
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 14:45:42 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: Clean up errors in segment.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1712b338.95b.18b27c8a5b6.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD+W5yhlQN7BAA--.687W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQABB2UlHDMAlgAJs3
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc6JyAoY3R4OlZ4VykKClNpZ25lZC1vZmYtYnk6
IEthaUxvbmcgV2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBmcy9mMmZzL3NlZ21lbnQu
aCB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9mcy9mMmZzL3NlZ21lbnQuaCBiL2ZzL2YyZnMvc2VnbWVudC5oCmlu
ZGV4IDJjYThmYjVkMGRjNC4uODEyOWJlNzg4YmQ1IDEwMDY0NAotLS0gYS9mcy9mMmZzL3NlZ21l
bnQuaAorKysgYi9mcy9mMmZzL3NlZ21lbnQuaApAQCAtMTA4LDExICsxMDgsMTEgQEAgc3RhdGlj
IGlubGluZSB2b2lkIHNhbml0eV9jaGVja19zZWdfdHlwZShzdHJ1Y3QgZjJmc19zYl9pbmZvICpz
YmksCiAJKChzYmkpLT5zZWdzX3Blcl9zZWMgLSAoKHNiaSktPnVudXNhYmxlX2Jsb2Nrc19wZXJf
c2VjID4+XAogCShzYmkpLT5sb2dfYmxvY2tzX3Blcl9zZWcpKQogI2RlZmluZSBHRVRfU0VDX0ZS
T01fU0VHKHNiaSwgc2Vnbm8pCQkJCVwKLQkoKChzZWdubykgPT0gLTEpID8gLTE6IChzZWdubykg
LyAoc2JpKS0+c2Vnc19wZXJfc2VjKQorCSgoKHNlZ25vKSA9PSAtMSkgPyAtMSA6IChzZWdubykg
LyAoc2JpKS0+c2Vnc19wZXJfc2VjKQogI2RlZmluZSBHRVRfU0VHX0ZST01fU0VDKHNiaSwgc2Vj
bm8pCQkJCVwKIAkoKHNlY25vKSAqIChzYmkpLT5zZWdzX3Blcl9zZWMpCiAjZGVmaW5lIEdFVF9a
T05FX0ZST01fU0VDKHNiaSwgc2Vjbm8pCQkJCVwKLQkoKChzZWNubykgPT0gLTEpID8gLTE6IChz
ZWNubykgLyAoc2JpKS0+c2Vjc19wZXJfem9uZSkKKwkoKChzZWNubykgPT0gLTEpID8gLTEgOiAo
c2Vjbm8pIC8gKHNiaSktPnNlY3NfcGVyX3pvbmUpCiAjZGVmaW5lIEdFVF9aT05FX0ZST01fU0VH
KHNiaSwgc2Vnbm8pCQkJCVwKIAlHRVRfWk9ORV9GUk9NX1NFQyhzYmksIEdFVF9TRUNfRlJPTV9T
RUcoc2JpLCBzZWdubykpCiAKLS0gCjIuMTcuMQo=
