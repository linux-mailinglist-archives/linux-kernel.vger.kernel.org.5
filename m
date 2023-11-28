Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632B27FB23A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjK1HAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjK1HAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:00:08 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E9BEA;
        Mon, 27 Nov 2023 23:00:11 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AS6wcIzB1875016, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AS6wcIzB1875016
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 14:58:39 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 28 Nov 2023 14:58:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 28 Nov 2023 14:58:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 28 Nov 2023 14:58:39 +0800
From:   =?utf-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
To:     Christian Loehle <christian.loehle@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "doug@schmorgal.com" <doug@schmorgal.com>,
        "tonyhuang.sunplus@gmail.com" <tonyhuang.sunplus@gmail.com>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "william.qiu@starfivetech.com" <william.qiu@starfivetech.com>
Subject: RE: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
Thread-Topic: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host
 driver
Thread-Index: AQHaHFq+bFd/3O/jHUaixlBEulhIvbCNpQgAgAGvOTA=
Date:   Tue, 28 Nov 2023 06:58:38 +0000
Message-ID: <02f3c158c7fe44f382d865345628b79a@realtek.com>
References: <20231121091101.5540-1-jyanchou@realtek.com>
 <20231121091101.5540-3-jyanchou@realtek.com>
 <87d7235c-8d3f-42df-b1ed-ea0abe5af3b9@arm.com>
In-Reply-To: <87d7235c-8d3f-42df-b1ed-ea0abe5af3b9@arm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.236]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4+IFdlIGltcGxlbWVudGVkIGNtZHEgZmVhdHVyZSBvbiBTeW5vcHN5cyBEZXNpZ25X
YXJlIG1tYyBkcml2ZXIuDQo+PiBUaGUgZGlmZmVyZW5jZSBiZXR3ZWVuIGR3X21tYy5jIGFuZCBk
d19tbWNfY3FlLmMgd2VyZSBkaXN0aW5jdCANCj4+IHJlZ2lzdGVyIGRlZmluaXRpb25zLCBtbWMg
dXNlciBmbG93IGFuZCB0aGUgYWRkaXRpb24gb2YgY21kcS4NCj4+DQo+PiBOZXcgdmVyc2lvbiBv
ZiBVc2VyIEd1aWRlIGhhZCBtb2RpZnkgbW1jIGRyaXZlcidzIHVzYWdlIGZsb3csIHdlIG1heSAN
Cj4+IG5lZWQgdG8gcmVuZXcgY29kZSB0byBwcmVjaXNlbHkgZm9sbG93IHVzZXIgZ3VpZGUuDQo+
Pg0KPj4gTW9yZSBvdmVyLCBXZSBhZGRlZCBhIHdhaXQgc3RhdHVzIGZ1bmN0aW9uIHRvIHNhdGlz
Znkgc3lub3BzeXMgdXNlciANCj4+IGd1aWRlJ3MgZGVzY3JpcHRpb24sIHNpbmNlIHRoaXMgZmxv
dyBtaWdodCBiZSBzcGVjaWZpYyBpbiBzeW5vcHN5cyANCj4+IGhvc3QgZHJpdmVyIG9ubHkuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogSnlhbiBDaG91IDxqeWFuY2hvdUByZWFsdGVrLmNvbT4NCj4+
DQo+PiDigJQtLQ0KPj4gdjYgLT4gdjc6DQo+PiAtIFJlbW92ZSByZXNldC1uYW1lcyBpbiBkcml2
ZXIgYW5kIGFkanVzdCByZXNldCBjb250cm9sJ3MgY29kZS4NCj4+DQo+PiB2NSAtPiB2NjoNCj4+
IC0gRml4IGxpbnV4IGNvZGluZyBzdHlsZSBpc3N1ZXMuDQo+PiAtIERyb3AgdXNlbGVzcyBjb2Rl
IHRoYXQgaXMgbm90IGRlc2NyaWJlZCBpbiB0aGUgYmluZGluZ3MuDQo+PiAtIFJlcGxhY2UgZGV2
bV9jbGtfZ2V0IGFuZCBjbGtfcHJlcGFyZV9lbmFibGUgd2l0aCBkZXZtX2Nsa19nZXRfZW5hYmxl
ZC4NCj4+IC0gUmVwbGFjZSBFWFBPUlRfU1lNQk9MIHdpdGggRVhQT1JUX1NZTUJPTF9HUEwuDQo+
Pg0KPj4gdjQgLT4gdjU6DQo+PiAtIEZpeCBsaW51eCBjb2Rpbmcgc3R5bGUgaXNzdWVzLg0KPj4g
LSBGaXggdGVzdCByb2JvdCBidWlsZCBlcnJvcnMgdG8gbWFrZSBnb29kIHVzZSBvZiBzZXR1cF90
cmFuX2Rlc2MNCj4+ICAgY2FsbCBiYWNrIGZ1bmN0aW9uLg0KPj4gLSBSZW1vdmUgdXNlbGVzcyBm
dW5jdGlvbi4NCj4+DQo+PiB2MyAtPiB2NDoNCj4+IC0gTW9kaWZ5IGRtYSBtb2RlIHNlbGVjdGlv
biBhbmQgZG1hIGFkZHJlc3NpbmcgYml0IHRvIHN0YXRpc2Z5DQo+PiAgIGxpbnV4IGNvZGluZyBz
dHlsZS4NCj4+DQo+PiB2MSAtPiB2MjoNCj4+IC0gUmVtb3ZlIGR3X21jaV9jcWVfc2V0X3RyYW5f
ZGVzYyBkdWUgdG8gdGhlIGR1cGxpY2F0ZWQgZnVuY3Rpb24uDQo+PiAtIEFkZCAtPnByZV9lbmFi
bGUoKSAvIC0+cG9zdF9kaXNhYmxlKCkNCj4+DQo+PiB2MCAtPiB2MToNCj4+IC0gU2VwZXJhdGUg
ZGlmZmVyZW50IHN1cHBvcnQgaW50byBzaW5nbGUgcGF0Y2guDQo+PiAtIEZpeCB0aGUgY29tcGls
ZXIgY29tcGxhaW5zLg0KPj4gLS0tDQo+PiAtLS0NCj4+ICBkcml2ZXJzL21tYy9ob3N0L0tjb25m
aWcgICAgICB8ICAgMTMgKw0KPj4gIGRyaXZlcnMvbW1jL2hvc3QvTWFrZWZpbGUgICAgIHwgICAg
MSArDQo+PiAgZHJpdmVycy9tbWMvaG9zdC9kd19tbWNfY3FlLmMgfCAxNDY3IA0KPj4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrICBkcml2ZXJzL21tYy9ob3N0L2R3X21tY19jcWUu
aCB8ICANCj4+IDQ1NiArKysrKysrKysrDQo+PiAgNCBmaWxlcyBjaGFuZ2VkLCAxOTM3IGluc2Vy
dGlvbnMoKykNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tbWMvaG9zdC9kd19tbWNf
Y3FlLmMgIGNyZWF0ZSBtb2RlIDEwMDY0NCANCj4+IGRyaXZlcnMvbW1jL2hvc3QvZHdfbW1jX2Nx
ZS5oDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZyBiL2RyaXZl
cnMvbW1jL2hvc3QvS2NvbmZpZyBpbmRleCANCj4+IDU4YmQ1ZmU0Y2QyNS4uMDZiYjRkZTI4Y2M0
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnDQo+PiArKysgYi9kcml2
ZXJzL21tYy9ob3N0L0tjb25maWcNCj4+IEBAIC04MzcsNiArODM3LDE5IEBAIGNvbmZpZyBNTUNf
RFdfU1RBUkZJVkUNCj4+ICAgICAgICAgU3lub3BzeXMgRGVzaWduV2FyZSBNZW1vcnkgQ2FyZCBJ
bnRlcmZhY2UgZHJpdmVyLiBTZWxlY3QgdGhpcyBvcHRpb24NCj4+ICAgICAgICAgZm9yIHBsYXRm
b3JtcyBiYXNlZCBvbiBTdGFyRml2ZSBKSDcxMTAgU29DLg0KPj4NCj4+ICtjb25maWcgTU1DX0RX
X0NRRQ0KPj4gKyAgICAgdHJpc3RhdGUgIlN5bm9wc3lzIERlc2lnbldhcmUgTWVtb3J5IENhcmQg
d2l0aCBDUUUgSW50ZXJmYWNlIg0KPj4gKyAgICAgZGVwZW5kcyBvbiBBUkMgfHwgQVJNIHx8IEFS
TTY0IHx8IE1JUFMgfHwgQ09NUElMRV9URVNUDQo+PiArICAgICBzZWxlY3QgTU1DX0NRSENJDQo+
PiArICAgICBoZWxwDQo+PiArICAgICAgVGhpcyBzZWxlY3RzIHN1cHBvcnQgZm9yIHRoZSBTeW5v
cHN5cyBEZXNpZ25XYXJlIE1vYmlsZSBTdG9yYWdlIElQDQo+PiArICAgICAgYmxvY2sgYWZ0ZXIg
SkVERUMgU3RhbmRhcmQgdmVyc2lvbiA1LjEuIFNlbGVjdCB0aGlzIG9wdGlvbiBmb3IgU0QgYW5k
DQo+PiArICAgICAgTU1DIGludGVyZmFjZXMgdGhhdCB1c2UgY29tbWFuZCBxdWV1ZS4NCj4gL2Fm
dGVyL2FjY29yZGluZyB0by8gPw0KDQpTb3JyeSBmb3IgYXNraW5nLCB3aGF0IGRvZXMgIiAvYWZ0
ZXIvYWNjb3JkaW5nIHRvLyA/ICIgbWVhbiA/DQoNCj4gRG9lcyB0aGUgaGFyZHdhcmUgYWN0dWFs
bHkgaW1wbGVtZW50IGJvdGg6IFNEIGFuZCBNTUMgQ1E/DQo+IElmIHNvIHRoYXQgd291bGQgYmUg
dmVyeSBpbnRlcmVzdGluZywgYnV0IGFsc28gbm90IGN1cnJlbnRseSBzdXBwb3J0ZWQgYnkgbW1j
IGxheWVyLg0KDQpTaW5jZSB3ZSBvbmx5IGhhZCBTeW5vcHN5cyBlTU1DJ3MgSVAsIG91ciBoYXJk
d2FyZSBvbmx5IGltcGxlbWVudCBNTUMgQ1EsDQpidXQgYmVjYXVzZSB3ZSBmb2xsb3dlZCBTeW5v
cHN5cycgZGF0YSBib29rIGFuZCB1c2VyIGd1aWRlLCBpdCBtaWdodCBwcm9iYWJseSBleHBhbmQg
DQp0byBTRCBjYXJkIHVzYWdlLCB0aGFua3MuDQoNCkJlc3QgUmVnYXJkcywNCkp5YW4NCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RpYW4gTG9laGxlIDxjaHJpc3RpYW4u
bG9laGxlQGFybS5jb20+IA0KU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyNywgMjAyMyA5OjAyIFBN
DQpUbzogSnlhbiBDaG91IFvlkajoirflroldIDxqeWFuY2hvdUByZWFsdGVrLmNvbT47IHVsZi5o
YW5zc29uQGxpbmFyby5vcmc7IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOyBqaDgwLmNodW5nQHNh
bXN1bmcuY29tOyByaXRlc2hoQGNvZGVhdXJvcmEub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IGty
enlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZw0KQ2M6IGNvbm9yK2R0QGtlcm5lbC5vcmc7
IGFzdXRvc2hkQGNvZGVhdXJvcmEub3JnOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1t
bWNAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgYXJuZEBhcm5kYi5kZTsgYnJpYW5ub3JyaXNAY2hyb21pdW0u
b3JnOyBkb3VnQHNjaG1vcmdhbC5jb207IHRvbnlodWFuZy5zdW5wbHVzQGdtYWlsLmNvbTsgYWJl
bC52ZXNhQGxpbmFyby5vcmc7IHdpbGxpYW0ucWl1QHN0YXJmaXZldGVjaC5jb20NClN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjddWzIvNF0gbW1jOiBBZGQgU3lub3BzeXMgRGVzaWduV2FyZSBtbWMgY21k
cSBob3N0IGRyaXZlcg0KDQoNCkV4dGVybmFsIG1haWwuDQoNCg0KDQpPbiAyMS8xMS8yMDIzIDA5
OjEwLCBKeWFuIENob3Ugd3JvdGU6DQo+IFdlIGltcGxlbWVudGVkIGNtZHEgZmVhdHVyZSBvbiBT
eW5vcHN5cyBEZXNpZ25XYXJlIG1tYyBkcml2ZXIuDQo+IFRoZSBkaWZmZXJlbmNlIGJldHdlZW4g
ZHdfbW1jLmMgYW5kIGR3X21tY19jcWUuYyB3ZXJlIGRpc3RpbmN0IA0KPiByZWdpc3RlciBkZWZp
bml0aW9ucywgbW1jIHVzZXIgZmxvdyBhbmQgdGhlIGFkZGl0aW9uIG9mIGNtZHEuDQo+DQo+IE5l
dyB2ZXJzaW9uIG9mIFVzZXIgR3VpZGUgaGFkIG1vZGlmeSBtbWMgZHJpdmVyJ3MgdXNhZ2UgZmxv
dywgd2UgbWF5IA0KPiBuZWVkIHRvIHJlbmV3IGNvZGUgdG8gcHJlY2lzZWx5IGZvbGxvdyB1c2Vy
IGd1aWRlLg0KPg0KPiBNb3JlIG92ZXIsIFdlIGFkZGVkIGEgd2FpdCBzdGF0dXMgZnVuY3Rpb24g
dG8gc2F0aXNmeSBzeW5vcHN5cyB1c2VyIA0KPiBndWlkZSdzIGRlc2NyaXB0aW9uLCBzaW5jZSB0
aGlzIGZsb3cgbWlnaHQgYmUgc3BlY2lmaWMgaW4gc3lub3BzeXMgDQo+IGhvc3QgZHJpdmVyIG9u
bHkuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEp5YW4gQ2hvdSA8anlhbmNob3VAcmVhbHRlay5jb20+
DQo+DQo+IOKAlC0tDQo+IHY2IC0+IHY3Og0KPiAtIFJlbW92ZSByZXNldC1uYW1lcyBpbiBkcml2
ZXIgYW5kIGFkanVzdCByZXNldCBjb250cm9sJ3MgY29kZS4NCj4NCj4gdjUgLT4gdjY6DQo+IC0g
Rml4IGxpbnV4IGNvZGluZyBzdHlsZSBpc3N1ZXMuDQo+IC0gRHJvcCB1c2VsZXNzIGNvZGUgdGhh
dCBpcyBub3QgZGVzY3JpYmVkIGluIHRoZSBiaW5kaW5ncy4NCj4gLSBSZXBsYWNlIGRldm1fY2xr
X2dldCBhbmQgY2xrX3ByZXBhcmVfZW5hYmxlIHdpdGggZGV2bV9jbGtfZ2V0X2VuYWJsZWQuDQo+
IC0gUmVwbGFjZSBFWFBPUlRfU1lNQk9MIHdpdGggRVhQT1JUX1NZTUJPTF9HUEwuDQo+DQo+IHY0
IC0+IHY1Og0KPiAtIEZpeCBsaW51eCBjb2Rpbmcgc3R5bGUgaXNzdWVzLg0KPiAtIEZpeCB0ZXN0
IHJvYm90IGJ1aWxkIGVycm9ycyB0byBtYWtlIGdvb2QgdXNlIG9mIHNldHVwX3RyYW5fZGVzYw0K
PiAgIGNhbGwgYmFjayBmdW5jdGlvbi4NCj4gLSBSZW1vdmUgdXNlbGVzcyBmdW5jdGlvbi4NCj4N
Cj4gdjMgLT4gdjQ6DQo+IC0gTW9kaWZ5IGRtYSBtb2RlIHNlbGVjdGlvbiBhbmQgZG1hIGFkZHJl
c3NpbmcgYml0IHRvIHN0YXRpc2Z5DQo+ICAgbGludXggY29kaW5nIHN0eWxlLg0KPg0KPiB2MSAt
PiB2MjoNCj4gLSBSZW1vdmUgZHdfbWNpX2NxZV9zZXRfdHJhbl9kZXNjIGR1ZSB0byB0aGUgZHVw
bGljYXRlZCBmdW5jdGlvbi4NCj4gLSBBZGQgLT5wcmVfZW5hYmxlKCkgLyAtPnBvc3RfZGlzYWJs
ZSgpDQo+DQo+IHYwIC0+IHYxOg0KPiAtIFNlcGVyYXRlIGRpZmZlcmVudCBzdXBwb3J0IGludG8g
c2luZ2xlIHBhdGNoLg0KPiAtIEZpeCB0aGUgY29tcGlsZXIgY29tcGxhaW5zLg0KPiAtLS0NCj4g
LS0tDQo+ICBkcml2ZXJzL21tYy9ob3N0L0tjb25maWcgICAgICB8ICAgMTMgKw0KPiAgZHJpdmVy
cy9tbWMvaG9zdC9NYWtlZmlsZSAgICAgfCAgICAxICsNCj4gIGRyaXZlcnMvbW1jL2hvc3QvZHdf
bW1jX2NxZS5jIHwgMTQ2NyANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrICBk
cml2ZXJzL21tYy9ob3N0L2R3X21tY19jcWUuaCB8ICANCj4gNDU2ICsrKysrKysrKysNCj4gIDQg
ZmlsZXMgY2hhbmdlZCwgMTkzNyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9tbWMvaG9zdC9kd19tbWNfY3FlLmMgIGNyZWF0ZSBtb2RlIDEwMDY0NCANCj4gZHJp
dmVycy9tbWMvaG9zdC9kd19tbWNfY3FlLmgNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1j
L2hvc3QvS2NvbmZpZyBiL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZyBpbmRleCANCj4gNThiZDVm
ZTRjZDI1Li4wNmJiNGRlMjhjYzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvS2Nv
bmZpZw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L0tjb25maWcNCj4gQEAgLTgzNyw2ICs4Mzcs
MTkgQEAgY29uZmlnIE1NQ19EV19TVEFSRklWRQ0KPiAgICAgICAgIFN5bm9wc3lzIERlc2lnbldh
cmUgTWVtb3J5IENhcmQgSW50ZXJmYWNlIGRyaXZlci4gU2VsZWN0IHRoaXMgb3B0aW9uDQo+ICAg
ICAgICAgZm9yIHBsYXRmb3JtcyBiYXNlZCBvbiBTdGFyRml2ZSBKSDcxMTAgU29DLg0KPg0KPiAr
Y29uZmlnIE1NQ19EV19DUUUNCj4gKyAgICAgdHJpc3RhdGUgIlN5bm9wc3lzIERlc2lnbldhcmUg
TWVtb3J5IENhcmQgd2l0aCBDUUUgSW50ZXJmYWNlIg0KPiArICAgICBkZXBlbmRzIG9uIEFSQyB8
fCBBUk0gfHwgQVJNNjQgfHwgTUlQUyB8fCBDT01QSUxFX1RFU1QNCj4gKyAgICAgc2VsZWN0IE1N
Q19DUUhDSQ0KPiArICAgICBoZWxwDQo+ICsgICAgICBUaGlzIHNlbGVjdHMgc3VwcG9ydCBmb3Ig
dGhlIFN5bm9wc3lzIERlc2lnbldhcmUgTW9iaWxlIFN0b3JhZ2UgSVANCj4gKyAgICAgIGJsb2Nr
IGFmdGVyIEpFREVDIFN0YW5kYXJkIHZlcnNpb24gNS4xLiBTZWxlY3QgdGhpcyBvcHRpb24gZm9y
IFNEIGFuZA0KPiArICAgICAgTU1DIGludGVyZmFjZXMgdGhhdCB1c2UgY29tbWFuZCBxdWV1ZS4N
Ci9hZnRlci9hY2NvcmRpbmcgdG8vID8NCkRvZXMgdGhlIGhhcmR3YXJlIGFjdHVhbGx5IGltcGxl
bWVudCBib3RoOiBTRCBhbmQgTU1DIENRPw0KSWYgc28gdGhhdCB3b3VsZCBiZSB2ZXJ5IGludGVy
ZXN0aW5nLCBidXQgYWxzbyBub3QgY3VycmVudGx5IHN1cHBvcnRlZCBieSBtbWMgbGF5ZXIuDQo=
