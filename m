Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685AD79DDFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbjIMBye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjIMBye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:54:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 814C910DF;
        Tue, 12 Sep 2023 18:54:29 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38D1s8hhD3344280, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38D1s8hhD3344280
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 09:54:08 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 13 Sep 2023 09:54:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 13 Sep 2023 09:54:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Wed, 13 Sep 2023 09:54:08 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] usb: dwc3: core: configure TX/RX threshold for DWC3_IP
Thread-Topic: [PATCH v3 1/2] usb: dwc3: core: configure TX/RX threshold for
 DWC3_IP
Thread-Index: AQHZ5TBP8fUNKWCfYE6yDInCdRDucrAXVCeAgAAYdYCAAJKfEA==
Date:   Wed, 13 Sep 2023 01:54:08 +0000
Message-ID: <608f80dc54164ef5be822890701362ad@realtek.com>
References: <20230912041904.30721-1-stanley_chang@realtek.com>
 <90e27f2b-4512-6121-c5f4-e7cb87b259ab@quicinc.com>
 <20230913010637.c4eukssffviugkhl@synopsys.com>
In-Reply-To: <20230913010637.c4eukssffviugkhl@synopsys.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VzbGV5IGFuZCBUaGluaCwNCg0KPiA+IEFyZW4ndCB0aGVyZSB2YWx1ZSBsaW1pdGF0aW9u
cyBmb3Igc29tZSBvZiB0aGVzZSAoaWYgbm90IGFsbCkNCj4gPiBzZXR0aW5ncz8gIEZvciBleGFt
cGxlLCBpbiB0aGUgRFdDMyBwcm9ncmFtbWluZyBndWlkZSwgdGhlIG1heCBidXJzdA0KPiA+IGZp
ZWxkcyBzYXkgKGZvcg0KPiA+IERXQzMxKToNCj4gPiAgICAgICAiTm90ZTogVGhpcyBmaWVsZCBj
YW4gb25seSBiZSBzZXQgdG8gMiwgNCwgOCBvciAxNi4iDQo+ID4NCj4gPiBBbmQgZm9yIHRoZSBw
YWNrZXQgdGhyZXNob2xkIGNvdW50Og0KPiA+ICAgICAgICJWYWxpZCB2YWx1ZXMgYXJlIGZyb20g
MSB0byAxNi4iDQo+ID4NCj4gDQo+IFN0YW5sZXkgZG9jdW1lbnRlZCB0aGlzIGluIHRoZSBkdCBi
aW5kaW5nLiBJIHRoaW5rIHdoYXQgaGUgaGFkIHdyaXR0ZW4gdGhlcmUgaXMNCj4gZmluZS4NCj4g
DQoNClRoYW5rcyBmb3IgVGhpbmgncyByZXNwb25zZS4NCg0KU3RhbmxleQ0K
