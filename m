Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DBA80C0A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjLKFTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjLKFTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:19:53 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62249D7;
        Sun, 10 Dec 2023 21:19:56 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BB5JLHZ02459352, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BB5JLHZ02459352
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Dec 2023 13:19:22 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Mon, 11 Dec 2023 13:19:21 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 11 Dec 2023 13:19:21 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Mon, 11 Dec 2023 13:19:21 +0800
From:   =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: RE: [PATCH v3 2/6] irqchip: Add interrupt controller support for Realtek DHC SoCs
Thread-Topic: [PATCH v3 2/6] irqchip: Add interrupt controller support for
 Realtek DHC SoCs
Thread-Index: AQHaIocg6atZJ97H502y6uXXYTUFxrCQbtQAgABT8ICADlCZYP//hq+AgAUCdeA=
Date:   Mon, 11 Dec 2023 05:19:21 +0000
Message-ID: <f8e4e4ad914f437d8f14d6a719976d6d@realtek.com>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-3-james.tai@realtek.com>
 <d94c79bf-04c4-4e87-bd7e-a8755508ac89@suswa.mountain>
 <8f87bfca-ab5f-4b32-a400-a90d09b64cf1@suswa.mountain>
 <c558b1de9a8841e498f6dfc406a43158@realtek.com>
 <f154673d-f577-406e-adb0-c567b604e7f4@suswa.mountain>
In-Reply-To: <f154673d-f577-406e-adb0-c567b604e7f4@suswa.mountain>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [49.216.19.50]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuLA0KDQo+WW91J3JlIHJ1bm5pbmcgaW50byB0aGUgaXNzdWUgYmVjYXVzZSB5b3UncmUg
dXNpbmcgT25lIEVyciBMYWJlbCBzdHlsZSBlcnJvcg0KPmhhbmRsaW5nLiAgSXQgd291bGQgYmUg
YmV0dGVyIHRvIHVzZSBub3JtYWwgdW53aW5kIGxhZGRlcmluZy4NCj5TZWUgbXkgYmxvZyBmb3Ig
bW9yZSBpbmZvOg0KPg0KPmh0dHBzOi8vc3RhdGljdGhpbmtpbmcud29yZHByZXNzLmNvbS8yMDIy
LzA0LzI4L2ZyZWUtdGhlLWxhc3QtdGhpbmctc3R5bGUvDQo+DQoNClRoYW5rcyBmb3IgeW91ciBn
dWlkYW5jZS4gSSB3aWxsIGFkanVzdCB0aGUgZXJyb3IgaGFuZGxpbmcgZmxvdy4NCg0KUmVnYXJk
cywNCkphbWVzDQoNCg0K
