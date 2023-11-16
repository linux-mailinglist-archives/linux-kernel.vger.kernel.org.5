Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56C37EE46D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjKPPbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjKPPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:30:54 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADC41BE6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:29:41 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AGFTPWN02493714, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AGFTPWN02493714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 23:29:25 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Nov 2023 23:29:26 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 16 Nov 2023 23:29:25 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Thu, 16 Nov 2023 23:29:25 +0800
From:   =?big5?B?SmFtZXMgVGFpIFvAuafTrnBd?= <james.tai@realtek.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH 3/6] irqchip: Introduce RTD1319 support using the Realtek Common Interrupt Controller Driver
Thread-Topic: [PATCH 3/6] irqchip: Introduce RTD1319 support using the Realtek
 Common Interrupt Controller Driver
Thread-Index: AQHaENOEZDLfNQp1+0+u8++yhuq29rB9IO2g
Date:   Thu, 16 Nov 2023 15:29:25 +0000
Message-ID: <47aa4fd77ae64a12a9462d1845354fa0@realtek.com>
References: <20231102142731.2087245-1-james.tai@realtek.com>
 <20231102142731.2087245-4-james.tai@realtek.com> <87r0l2hkw6.ffs@tglx>
In-Reply-To: <87r0l2hkw6.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [114.25.87.77]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhvbWFzLA0KDQo+PiArZW51bSBydGQxMzE5X2lzb19pc3JfYml0cyB7DQo+PiArICAgICBS
VEQxMzE5X0lTT19JU1JfVEMzX1NISUZUID0gMSwNCj4+ICsgICAgIFJURDEzMTlfSVNPX0lTUl9V
UjBfU0hJRlQgPSAyLA0KPg0KPlBsZWFzZSB1c2UgdGFidWxhciBmb3JtYXR0aW5nIGFsbCBvdmVy
IHRoZSBwbGFjZS4NCg0KSSB3aWxsIGZpeCBpdCBpbiB0aGUgbmV4dCBwYXRjaGVzLg0KDQo+DQo+
PiArICAgICBSVEQxMzE5X0lTT19JU1JfTFNBREMwX1NISUZUID0gMywNCj4+ICsgICAgIFJURDEz
MTlfSVNPX0lTUl9JUkRBX1NISUZUID0gNSwNCj4+ICsNCj4NCj4NCj4+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHJlYWx0ZWtfaW50Y19pbmZvIHJ0ZDEzMTlfaW50Y19pc29faW5mbyA9IHsNCj4+ICsg
ICAgIC5pc3Jfb2Zmc2V0ID0gMHgwLA0KPj4gKyAgICAgLnVtc2tfaXNyX29mZnNldCA9IDB4NCwN
Cj4+ICsgICAgIC5zY3B1X2ludF9lbl9vZmZzZXQgPSAweDQwLA0KPg0KPk1hZ2ljIG51bWJlcnMu
IERlZmluZXMgZXhpc3QgZm9yIGEgcmVhc29uLg0KDQpJIHdpbGwgZml4IGl0IGluIHRoZSBuZXh0
IHBhdGNoZXMuDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4NCg0KUmVnYXJkcywNCkph
bWVzDQoNCg0K
