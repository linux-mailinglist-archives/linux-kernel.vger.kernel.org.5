Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F419876C17E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjHBA1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHBA1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:27:52 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6301926BD;
        Tue,  1 Aug 2023 17:27:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3720RIQJ0009427, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3720RIQJ0009427
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 2 Aug 2023 08:27:18 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 2 Aug 2023 08:27:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 2 Aug 2023 08:27:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 2 Aug 2023 08:27:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "Lukas F . Hartmann" <lukas@mntre.com>
Subject: RE: [PATCH] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
Thread-Topic: [PATCH] wifi: rtw88: sdio: Honor the host max_req_size in the RX
 path
Thread-Index: AQHZsp+XbJMjQ56edkCHhTIfjugPgq/VGK8AgAEwmsA=
Date:   Wed, 2 Aug 2023 00:27:32 +0000
Message-ID: <d18405744d004aa8a4556db1919c7a12@realtek.com>
References: <20230709195712.603200-1-martin.blumenstingl@googlemail.com>
 <169089906853.212423.17095176293160428610.kvalo@kernel.org>
In-Reply-To: <169089906853.212423.17095176293160428610.kvalo@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2FsbGUgVmFsbyA8a3Zh
bG9Aa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDEsIDIwMjMgMTA6MTEgUE0N
Cj4gVG86IE1hcnRpbiBCbHVtZW5zdGluZ2wgPG1hcnRpbi5ibHVtZW5zdGluZ2xAZ29vZ2xlbWFp
bC5jb20+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGplcm5lai5za3JhYmVjQGdtYWlsLmNvbTsgUGluZy1LZSBTaGlo
DQo+IDxwa3NoaWhAcmVhbHRlay5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyB0b255MDYy
MGVtbWFAZ21haWwuY29tOyBNYXJ0aW4gQmx1bWVuc3RpbmdsDQo+IDxtYXJ0aW4uYmx1bWVuc3Rp
bmdsQGdvb2dsZW1haWwuY29tPjsgTHVrYXMgRiAuIEhhcnRtYW5uIDxsdWthc0BtbnRyZS5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHdpZmk6IHJ0dzg4OiBzZGlvOiBIb25vciB0aGUgaG9z
dCBtYXhfcmVxX3NpemUgaW4gdGhlIFJYIHBhdGgNCj4gDQo+IFBpbmcsIHNob3VsZCBJIHRha2Ug
b3IgZHJvcCB0aGUgcGF0Y2g/IEl0IHdhc24ndCBxdWl0ZSBjbGVhciBmb3IgbWUuDQoNClBsZWFz
ZSBkcm9wIHRoaXMgcGF0Y2gsIGJlY2F1c2UgdGhpcyBwYXRjaCBzdGlsbCBub3QgZml4ZXMgcHJv
YmxlbSBvbiBMdWthcycgcGxhdGZvcm0uDQpJIGdhdmUgbXkgcmV2aWV3ZWQtYnkgdG9vIGVhcmx5
LiBTb3JyeSBmb3IgdGhhdC4gDQoNClBpbmctS2UNCg0K
