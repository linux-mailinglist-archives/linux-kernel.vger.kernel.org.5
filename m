Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80962773663
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjHHCO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHHCOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:14:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A643FA;
        Mon,  7 Aug 2023 19:14:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3782EUGt8012061, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3782EUGt8012061
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 8 Aug 2023 10:14:30 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 8 Aug 2023 10:14:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 8 Aug 2023 10:14:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 8 Aug 2023 10:14:46 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 RESEND] usb: dwc3: core: configure TX/RX threshold for DWC3_IP
Thread-Topic: [PATCH v1 RESEND] usb: dwc3: core: configure TX/RX threshold for
 DWC3_IP
Thread-Index: AQHZyQKVd0xYvrabgkGdq1Xn2zdTCK/e97YAgACyGAA=
Date:   Tue, 8 Aug 2023 02:14:46 +0000
Message-ID: <796aa899992e4301a341a95f74d6f988@realtek.com>
References: <20230807074131.27355-1-stanley_chang@realtek.com>
 <20230807233538.4vnycx5dej3nw2ak@synopsys.com>
In-Reply-To: <20230807233538.4vnycx5dej3nw2ak@synopsys.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhpbmgsDQoNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBpbmRleA0KPiA+IGY2Njg5YjczMTcxOC4uYTBhNTRlNWM0
YWQ5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiBAQCAtMTI2Miw2ICsxMjYyLDM5IEBAIHN0YXRp
YyBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gPiAgICAgICAgICAgICAg
IH0NCj4gPiAgICAgICB9DQo+ID4NCj4gPiArICAgICBpZiAoRFdDM19JUF9JUyhEV0MzKSkgew0K
PiA+ICsgICAgICAgICAgICAgdTggcnhfdGhyX251bSA9IGR3Yy0+cnhfdGhyX251bV9wa3RfcHJk
Ow0KPiA+ICsgICAgICAgICAgICAgdTggcnhfbWF4YnVyc3QgPSBkd2MtPnJ4X21heF9idXJzdF9w
cmQ7DQo+ID4gKyAgICAgICAgICAgICB1OCB0eF90aHJfbnVtID0gZHdjLT50eF90aHJfbnVtX3Br
dF9wcmQ7DQo+ID4gKyAgICAgICAgICAgICB1OCB0eF9tYXhidXJzdCA9IGR3Yy0+dHhfbWF4X2J1
cnN0X3ByZDsNCj4gDQo+IFRoZXNlIGFyZSBtZWFudCBmb3IgcGVyaW9kaWMgc2V0dGluZ3MuIFlv
dSdyZSBvdmVybG9hZGluZyB0aGVtIGZvcg0KPiBub24tcGVyaW9kaWMgc2V0dGluZ3MuDQo+IA0K
SSB3aWxsIGFkZCBuZXcgcHJvcGVydHkgZm9yIG5vbi1wZXJpb2RpYyBzZXR0aW5ncy4NCg0KVGhh
bmtzLA0KU3RhbmxleQ0K
