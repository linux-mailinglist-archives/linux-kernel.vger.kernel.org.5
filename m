Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4E7936C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjIFIEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjIFIEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:04:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F36BECF0;
        Wed,  6 Sep 2023 01:03:59 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 386839PB0008536, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 386839PB0008536
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Sep 2023 16:03:09 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 6 Sep 2023 16:03:37 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Sep 2023 16:03:37 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Wed, 6 Sep 2023 16:03:37 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Ricky WU <ricky_wu@realtek.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH] misc: rtsx: Fix an error access Page fault
Thread-Topic: [PATCH] misc: rtsx: Fix an error access Page fault
Thread-Index: AQHZ4Jftyjh/fSClKUGC38rBdS0qoQ==
Date:   Wed, 6 Sep 2023 08:03:36 +0000
Message-ID: <2ce258f371234b1f8a1a470d5488d00e@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.81.102]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YW4gZXJyb3Igb2NjdXJzIG9uIGluc2VydCBTRDcuMCBjYXJkLg0KVGhlIHBjaSBzbG90IG9mIHJ0
c3hfcGNpIHdpbGwgTGluayBEb3duIHdoZW4gdGhlIFNENy4wIGNhcmQgaW5zZXJ0ZWQsDQpidXQg
dGhlIHJ0c3hfcGNpIG5vdCBleGl0IGZyb20gcnVudGltZV9pZGxlIGF0IHRoYXQgdGltZSwNCnRo
ZW4gZG8gdGhlIHBvd2VyX3NhdmluZyBmdW5jdGlvbiB0byBhY2Nlc3MgdGhlIHdyb25nIHJlc291
cmNlDQoNCkZpeGVzOiA1OTc1NjhlOGRmMDQgKCJtaXNjOiBydHN4OiBSZXdvcmsgcnVudGltZSBw
b3dlciBtYW5hZ2VtZW50IGZsb3ciKQ0KQ2M6IEthaS1IZW5nIEZlbmcgPGthaS5oZW5nLmZlbmdA
Y2Fub25pY2FsLmNvbT4NClNpZ25lZC1vZmYtYnk6IFJpY2t5IFd1IDxyaWNreV93dUByZWFsdGVr
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvbWlzYy9jYXJkcmVhZGVyL3J0c3hfcGNyLmMgfCAxNCArKysr
KysrKy0tLS0tLQ0KIGRyaXZlcnMvbW1jL2hvc3QvcnRzeF9wY2lfc2RtbWMuYyAgfCAgMSArDQog
aW5jbHVkZS9saW51eC9ydHN4X3BjaS5oICAgICAgICAgICB8ICAxICsNCiAzIGZpbGVzIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL21pc2MvY2FyZHJlYWRlci9ydHN4X3Bjci5jIGIvZHJpdmVycy9taXNjL2NhcmRyZWFkZXIv
cnRzeF9wY3IuYw0KaW5kZXggYTNmNGI1MmJiMTU5Li41MzZhMzY4MWZkNWUgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHN4X3Bjci5jDQorKysgYi9kcml2ZXJzL21pc2Mv
Y2FyZHJlYWRlci9ydHN4X3Bjci5jDQpAQCAtMTUyNiw2ICsxNTI2LDcgQEAgc3RhdGljIGludCBy
dHN4X3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGNpZGV2LA0KIAlwY3ItPmhvc3Rfc2dfdGJs
X2FkZHIgPSBwY3ItPnJ0c3hfcmVzdl9idWZfYWRkciArIEhPU1RfQ01EU19CVUZfTEVOOw0KIAlw
Y3ItPmNhcmRfaW5zZXJ0ZWQgPSAwOw0KIAlwY3ItPmNhcmRfcmVtb3ZlZCA9IDA7DQorCXBjci0+
aXNfc2RfZXhwcmVzcyA9IGZhbHNlOw0KIAlJTklUX0RFTEFZRURfV09SSygmcGNyLT5jYXJkZGV0
X3dvcmssIHJ0c3hfcGNpX2NhcmRfZGV0ZWN0KTsNCiANCiAJcGNyLT5tc2lfZW4gPSBtc2lfZW47
DQpAQCAtMTczNSwxMiArMTczNiwxMyBAQCBzdGF0aWMgaW50IHJ0c3hfcGNpX3J1bnRpbWVfaWRs
ZShzdHJ1Y3QgZGV2aWNlICpkZXZpY2UpDQogDQogCXBjci0+c3RhdGUgPSBQREVWX1NUQVRfSURM
RTsNCiANCi0JaWYgKHBjci0+b3BzLT5kaXNhYmxlX2F1dG9fYmxpbmspDQotCQlwY3ItPm9wcy0+
ZGlzYWJsZV9hdXRvX2JsaW5rKHBjcik7DQotCWlmIChwY3ItPm9wcy0+dHVybl9vZmZfbGVkKQ0K
LQkJcGNyLT5vcHMtPnR1cm5fb2ZmX2xlZChwY3IpOw0KLQ0KLQlydHN4X3BtX3Bvd2VyX3Nhdmlu
ZyhwY3IpOw0KKwlpZiAoIXBjci0+aXNfc2RfZXhwcmVzcykgew0KKwkJaWYgKHBjci0+b3BzLT5k
aXNhYmxlX2F1dG9fYmxpbmspDQorCQkJcGNyLT5vcHMtPmRpc2FibGVfYXV0b19ibGluayhwY3Ip
Ow0KKwkJaWYgKHBjci0+b3BzLT50dXJuX29mZl9sZWQpDQorCQkJcGNyLT5vcHMtPnR1cm5fb2Zm
X2xlZChwY3IpOw0KKwkJcnRzeF9wbV9wb3dlcl9zYXZpbmcocGNyKTsNCisJfQ0KIA0KIAltdXRl
eF91bmxvY2soJnBjci0+cGNyX211dGV4KTsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9o
b3N0L3J0c3hfcGNpX3NkbW1jLmMgYi9kcml2ZXJzL21tYy9ob3N0L3J0c3hfcGNpX3NkbW1jLmMN
CmluZGV4IDg3ZDc4NDMyYTFlMC4uODBiMmYyYTMxZmRjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9t
bWMvaG9zdC9ydHN4X3BjaV9zZG1tYy5jDQorKysgYi9kcml2ZXJzL21tYy9ob3N0L3J0c3hfcGNp
X3NkbW1jLmMNCkBAIC0xMzkzLDYgKzEzOTMsNyBAQCBzdGF0aWMgaW50IHNkbW1jX2luaXRfc2Rf
ZXhwcmVzcyhzdHJ1Y3QgbW1jX2hvc3QgKm1tYywgc3RydWN0IG1tY19pb3MgKmlvcykNCiAJCVJU
UzUyNjFfTUNVX0JVU19TRUxfTUFTSyB8IFJUUzUyNjFfTUNVX0NMT0NLX1NFTF9NQVNLDQogCQl8
IFJUUzUyNjFfRFJJVkVSX0VOQUJMRV9GVywNCiAJCVJUUzUyNjFfTUNVX0NMT0NLX1NFTF8xNk0g
fCBSVFM1MjYxX0RSSVZFUl9FTkFCTEVfRlcpOw0KKwlwY3ItPmlzX3NkX2V4cHJlc3MgPSB0cnVl
Ow0KIAlob3N0LT5lamVjdCA9IHRydWU7DQogCXJldHVybiAwOw0KIH0NCmRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L3J0c3hfcGNpLmggYi9pbmNsdWRlL2xpbnV4L3J0c3hfcGNpLmgNCmluZGV4
IDUzNDAzOGQ5NjJlNC4uMjk1ZTkyMjI0ZmQwIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9y
dHN4X3BjaS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3J0c3hfcGNpLmgNCkBAIC0xMjYyLDYgKzEy
NjIsNyBAQCBzdHJ1Y3QgcnRzeF9wY3Igew0KIAl1OAkJCW9jcF9zdGF0Ow0KIAl1OAkJCW9jcF9z
dGF0MjsNCiAJdTgJCQlydGQzX2VuOw0KKwlib29sCQkJaXNfc2RfZXhwcmVzczsNCiB9Ow0KIA0K
ICNkZWZpbmUgUElEXzUyNEEJMHg1MjRBDQotLSANCjIuMjUuMQ0KDQo=
