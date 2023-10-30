Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0497DB27C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 05:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjJ3ESq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 00:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3ESo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 00:18:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDDFB4;
        Sun, 29 Oct 2023 21:18:42 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39U4IQ5x82683577, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39U4IQ5x82683577
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 12:18:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 30 Oct 2023 12:18:27 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 30 Oct 2023 12:18:26 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Mon, 30 Oct 2023 12:18:26 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ricky WU <ricky_wu@realtek.com>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: [PATCH v4 3/3] mmc: rtsx: add rts5264 to support sd express card
Thread-Topic: [PATCH v4 3/3] mmc: rtsx: add rts5264 to support sd express card
Thread-Index: AQHaCufLAWNCViBwOEmC803+Z0Ff0w==
Date:   Mon, 30 Oct 2023 04:18:26 +0000
Message-ID: <2ba6662162b343e186839abedb8e98c1@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.81.102]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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
Mzogc3BsaXQgdXAgbW1jIHBhcnQgZnJvbSB2MiBwYXRjaA0KdjQ6IHNwbGl0IG5ldyBkZWZpbml0
aW9uIHVwIGZyb20gdjMNCi0tLQ0KIGRyaXZlcnMvbW1jL2hvc3QvcnRzeF9wY2lfc2RtbWMuYyB8
IDE3ICsrKysrKysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvcnRzeF9wY2lf
c2RtbWMuYyBiL2RyaXZlcnMvbW1jL2hvc3QvcnRzeF9wY2lfc2RtbWMuYw0KaW5kZXggODdkNzg0
MzJhMWUwLi43ZGZlN2M0ZTAwNzcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3J0c3hf
cGNpX3NkbW1jLmMNCisrKyBiL2RyaXZlcnMvbW1jL2hvc3QvcnRzeF9wY2lfc2RtbWMuYw0KQEAg
LTcsNiArNyw3IEBADQogICogICBXZWkgV0FORyA8d2VpX3dhbmdAcmVhbHNpbC5jb20uY24+DQog
ICovDQogDQorI2luY2x1ZGUgPGxpbnV4L3BjaS5oPg0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4NCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KICNpbmNsdWRlIDxsaW51eC9oaWdobWVtLmg+
DQpAQCAtOTQ3LDcgKzk0OCw3IEBAIHN0YXRpYyBpbnQgc2RfcG93ZXJfb24oc3RydWN0IHJlYWx0
ZWtfcGNpX3NkbW1jICpob3N0LCB1bnNpZ25lZCBjaGFyIHBvd2VyX21vZGUpDQogCS8qIHNlbmQg
YXQgbGVhc3QgNzQgY2xvY2tzICovDQogCXJ0c3hfcGNpX3dyaXRlX3JlZ2lzdGVyKHBjciwgU0Rf
QlVTX1NUQVQsIFNEX0NMS19UT0dHTEVfRU4sIFNEX0NMS19UT0dHTEVfRU4pOw0KIA0KLQlpZiAo
UENJX1BJRChwY3IpID09IFBJRF81MjYxKSB7DQorCWlmICgoUENJX1BJRChwY3IpID09IFBJRF81
MjYxKSB8fCAoUENJX1BJRChwY3IpID09IFBJRF81MjY0KSkgew0KIAkJLyoNCiAJCSAqIElmIHRl
c3QgbW9kZSBpcyBzZXQgc3dpdGNoIHRvIFNEIEV4cHJlc3MgbWFuZGF0b3JpbHksDQogCQkgKiB0
aGlzIGlzIG9ubHkgZm9yIGZhY3RvcnkgdGVzdGluZy4NCkBAIC0xMzY0LDYgKzEzNjUsMTQgQEAg
c3RhdGljIGludCBzZG1tY19pbml0X3NkX2V4cHJlc3Moc3RydWN0IG1tY19ob3N0ICptbWMsIHN0
cnVjdCBtbWNfaW9zICppb3MpDQogCXN0cnVjdCByZWFsdGVrX3BjaV9zZG1tYyAqaG9zdCA9IG1t
Y19wcml2KG1tYyk7DQogCXN0cnVjdCBydHN4X3BjciAqcGNyID0gaG9zdC0+cGNyOw0KIA0KKwlp
ZiAoUENJX1BJRChwY3IpID09IFBJRF81MjY0KSB7DQorCQlwY2llX2NhcGFiaWxpdHlfY2xlYXJf
YW5kX3NldF93b3JkKHBjci0+cGNpLCBQQ0lfRVhQX0xOS0NUTDIsDQorCQkJCVBDSV9FWFBfTE5L
Q1RMMl9UTFMsIFBDSV9FWFBfTE5LQ1RMMl9UTFNfMl81R1QpOw0KKwkJcGNpX3dyaXRlX2NvbmZp
Z19ieXRlKHBjci0+cGNpLCAweDgwZSwgMHgwMik7DQorCQlwY2llX2NhcGFiaWxpdHlfY2xlYXJf
YW5kX3NldF93b3JkKHBjci0+cGNpLCBQQ0lfRVhQX0xOS0NUTDIsDQorCQkJCVBDSV9FWFBfTE5L
Q1RMMl9UTFMsIFBDSV9FWFBfTE5LQ1RMMl9UTFNfNV8wR1QpOw0KKwl9DQorDQogCS8qIFNldCBy
ZWxpbmtfdGltZSBmb3IgY2hhbmdpbmcgdG8gUENJZSBjYXJkICovDQogCXJlbGlua190aW1lID0g
MHg4RkZGOw0KIA0KQEAgLTEzNzksNiArMTM4OCwxMiBAQCBzdGF0aWMgaW50IHNkbW1jX2luaXRf
c2RfZXhwcmVzcyhzdHJ1Y3QgbW1jX2hvc3QgKm1tYywgc3RydWN0IG1tY19pb3MgKmlvcykNCiAJ
aWYgKHBjci0+b3BzLT5kaXNhYmxlX2F1dG9fYmxpbmspDQogCQlwY3ItPm9wcy0+ZGlzYWJsZV9h
dXRvX2JsaW5rKHBjcik7DQogDQorCWlmIChQQ0lfUElEKHBjcikgPT0gUElEXzUyNjQpIHsNCisJ
CXJ0c3hfcGNpX3dyaXRlX3JlZ2lzdGVyKHBjciwgUlRTNTI2NF9BVVRPTE9BRF9DRkcyLA0KKwkJ
CVJUUzUyNjRfQ0hJUF9SU1RfTl9TRUwsIFJUUzUyNjRfQ0hJUF9SU1RfTl9TRUwpOw0KKwkJcnRz
eF9wY2lfd3JpdGVfcmVnaXN0ZXIocGNyLCBHUElPX0NUTCwgMHgwMiwgMHgwMCk7DQorCX0NCisN
CiAJLyogRm9yIFBDSWUvTlZNZSBtb2RlIGNhbid0IGVudGVyIGRlbGluayBpc3N1ZSAqLw0KIAlw
Y3ItPmh3X3BhcmFtLmludGVycnVwdF9lbiAmPSB+KFNEX0lOVF9FTik7DQogCXJ0c3hfcGNpX3dy
aXRlbChwY3IsIFJUU1hfQklFUiwgcGNyLT5od19wYXJhbS5pbnRlcnJ1cHRfZW4pOw0KLS0gDQoy
LjI1LjENCg==
