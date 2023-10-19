Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7EA7CEE49
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjJSDCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjJSDCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:02:09 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AD012D;
        Wed, 18 Oct 2023 20:01:58 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39J3110G02399582, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39J3110G02399582
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 11:01:01 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 19 Oct 2023 11:01:01 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 19 Oct 2023 11:01:00 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Thu, 19 Oct 2023 11:00:59 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        Ricky WU <ricky_wu@realtek.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] mmc: rtsx: add rts5264 to support sd express card
Thread-Topic: [PATCH v3 2/2] mmc: rtsx: add rts5264 to support sd express card
Thread-Index: AQHaAjguN03dRmCsUU20q33k85igXA==
Date:   Thu, 19 Oct 2023 03:00:59 +0000
Message-ID: <1143f3d4d26b4e7a8b3cc0d68caaa5ba@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.81.102]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHJ0czUyNjQgcmVnaXN0ZXIgc2V0dGluZyB3aGVuIHNkIGV4cHJlc3MgY2FyZCBpbnNlcnQN
Cg0KU2lnbmVkLW9mZi1ieTogUmlja3kgV3UgPHJpY2t5X3d1QHJlYWx0ZWsuY29tPg0KLS0tDQp2
Mzogc3BsaXQgdXAgbW1jIHBhcnQgZnJvbSB2MiBwYXRjaA0KLS0tDQogZHJpdmVycy9tbWMvaG9z
dC9ydHN4X3BjaV9zZG1tYy5jIHwgMTcgKysrKysrKysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdl
ZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvaG9zdC9ydHN4X3BjaV9zZG1tYy5jIGIvZHJpdmVycy9tbWMvaG9zdC9ydHN4X3BjaV9z
ZG1tYy5jDQppbmRleCA4N2Q3ODQzMmExZTAuLjdkZmU3YzRlMDA3NyAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvbW1jL2hvc3QvcnRzeF9wY2lfc2RtbWMuYw0KKysrIGIvZHJpdmVycy9tbWMvaG9zdC9y
dHN4X3BjaV9zZG1tYy5jDQpAQCAtNyw2ICs3LDcgQEANCiAgKiAgIFdlaSBXQU5HIDx3ZWlfd2Fu
Z0ByZWFsc2lsLmNvbS5jbj4NCiAgKi8NCiANCisjaW5jbHVkZSA8bGludXgvcGNpLmg+DQogI2lu
Y2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQogI2luY2x1
ZGUgPGxpbnV4L2hpZ2htZW0uaD4NCkBAIC05NDcsNyArOTQ4LDcgQEAgc3RhdGljIGludCBzZF9w
b3dlcl9vbihzdHJ1Y3QgcmVhbHRla19wY2lfc2RtbWMgKmhvc3QsIHVuc2lnbmVkIGNoYXIgcG93
ZXJfbW9kZSkNCiAJLyogc2VuZCBhdCBsZWFzdCA3NCBjbG9ja3MgKi8NCiAJcnRzeF9wY2lfd3Jp
dGVfcmVnaXN0ZXIocGNyLCBTRF9CVVNfU1RBVCwgU0RfQ0xLX1RPR0dMRV9FTiwgU0RfQ0xLX1RP
R0dMRV9FTik7DQogDQotCWlmIChQQ0lfUElEKHBjcikgPT0gUElEXzUyNjEpIHsNCisJaWYgKChQ
Q0lfUElEKHBjcikgPT0gUElEXzUyNjEpIHx8IChQQ0lfUElEKHBjcikgPT0gUElEXzUyNjQpKSB7
DQogCQkvKg0KIAkJICogSWYgdGVzdCBtb2RlIGlzIHNldCBzd2l0Y2ggdG8gU0QgRXhwcmVzcyBt
YW5kYXRvcmlseSwNCiAJCSAqIHRoaXMgaXMgb25seSBmb3IgZmFjdG9yeSB0ZXN0aW5nLg0KQEAg
LTEzNjQsNiArMTM2NSwxNCBAQCBzdGF0aWMgaW50IHNkbW1jX2luaXRfc2RfZXhwcmVzcyhzdHJ1
Y3QgbW1jX2hvc3QgKm1tYywgc3RydWN0IG1tY19pb3MgKmlvcykNCiAJc3RydWN0IHJlYWx0ZWtf
cGNpX3NkbW1jICpob3N0ID0gbW1jX3ByaXYobW1jKTsNCiAJc3RydWN0IHJ0c3hfcGNyICpwY3Ig
PSBob3N0LT5wY3I7DQogDQorCWlmIChQQ0lfUElEKHBjcikgPT0gUElEXzUyNjQpIHsNCisJCXBj
aWVfY2FwYWJpbGl0eV9jbGVhcl9hbmRfc2V0X3dvcmQocGNyLT5wY2ksIFBDSV9FWFBfTE5LQ1RM
MiwNCisJCQkJUENJX0VYUF9MTktDVEwyX1RMUywgUENJX0VYUF9MTktDVEwyX1RMU18yXzVHVCk7
DQorCQlwY2lfd3JpdGVfY29uZmlnX2J5dGUocGNyLT5wY2ksIDB4ODBlLCAweDAyKTsNCisJCXBj
aWVfY2FwYWJpbGl0eV9jbGVhcl9hbmRfc2V0X3dvcmQocGNyLT5wY2ksIFBDSV9FWFBfTE5LQ1RM
MiwNCisJCQkJUENJX0VYUF9MTktDVEwyX1RMUywgUENJX0VYUF9MTktDVEwyX1RMU181XzBHVCk7
DQorCX0NCisNCiAJLyogU2V0IHJlbGlua190aW1lIGZvciBjaGFuZ2luZyB0byBQQ0llIGNhcmQg
Ki8NCiAJcmVsaW5rX3RpbWUgPSAweDhGRkY7DQogDQpAQCAtMTM3OSw2ICsxMzg4LDEyIEBAIHN0
YXRpYyBpbnQgc2RtbWNfaW5pdF9zZF9leHByZXNzKHN0cnVjdCBtbWNfaG9zdCAqbW1jLCBzdHJ1
Y3QgbW1jX2lvcyAqaW9zKQ0KIAlpZiAocGNyLT5vcHMtPmRpc2FibGVfYXV0b19ibGluaykNCiAJ
CXBjci0+b3BzLT5kaXNhYmxlX2F1dG9fYmxpbmsocGNyKTsNCiANCisJaWYgKFBDSV9QSUQocGNy
KSA9PSBQSURfNTI2NCkgew0KKwkJcnRzeF9wY2lfd3JpdGVfcmVnaXN0ZXIocGNyLCBSVFM1MjY0
X0FVVE9MT0FEX0NGRzIsDQorCQkJUlRTNTI2NF9DSElQX1JTVF9OX1NFTCwgUlRTNTI2NF9DSElQ
X1JTVF9OX1NFTCk7DQorCQlydHN4X3BjaV93cml0ZV9yZWdpc3RlcihwY3IsIEdQSU9fQ1RMLCAw
eDAyLCAweDAwKTsNCisJfQ0KKw0KIAkvKiBGb3IgUENJZS9OVk1lIG1vZGUgY2FuJ3QgZW50ZXIg
ZGVsaW5rIGlzc3VlICovDQogCXBjci0+aHdfcGFyYW0uaW50ZXJydXB0X2VuICY9IH4oU0RfSU5U
X0VOKTsNCiAJcnRzeF9wY2lfd3JpdGVsKHBjciwgUlRTWF9CSUVSLCBwY3ItPmh3X3BhcmFtLmlu
dGVycnVwdF9lbik7DQotLSANCjIuMjUuMQ==
