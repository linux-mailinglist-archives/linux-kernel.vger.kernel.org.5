Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C4D7B76C3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 05:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjJDDIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 23:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJDDIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 23:08:15 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D465DAF;
        Tue,  3 Oct 2023 20:08:09 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39437PNe82806956, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39437PNe82806956
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 11:07:25 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 4 Oct 2023 11:07:25 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 4 Oct 2023 11:07:24 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Wed, 4 Oct 2023 11:07:24 +0800
From:   Max Chou <max.chou@realtek.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hilda Wu <hildawu@realtek.com>
CC:     "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Regression: devcoredump patch broke Realtek usb bluetooth adapter
Thread-Topic: Regression: devcoredump patch broke Realtek usb bluetooth
 adapter
Thread-Index: AQHZ9iZZqIk9cnxrEkOIPrwHFnXgfLA4N/0AgAA1ZDA=
Date:   Wed, 4 Oct 2023 03:07:24 +0000
Message-ID: <b2ef2f1c457a4cf7a246b2e8b8598a30@realtek.com>
References: <20231003182038.k57nirtt4sonvt7c@box.shutemov.name>
 <ZRyqIn0_qqEFBPdy@debian.me>
In-Reply-To: <ZRyqIn0_qqEFBPdy@debian.me>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.132.197]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhIEtpcmlsbCwNCkkgYmFzZWQgb24gS2VybmVsIHY2LjUuNSBhbmQgdXBkYXRlZCBkcml2ZXJz
L2JsdWV0b290aCB0byB0aGUgbGFzdCB2ZXJzaW9uIG9mIGJsdWV0b290aC1uZXh0IHRyZWUgZm9y
IGEgdGVzdCB3aXRoIFJUTDg3NjFCVVYuDQpUaGUgZG1lc2cgbG9nIGFuZCAiaGNpY29uZmlnIC1h
IiBhcmUgY29ycmVjdC4NCkNvdWxkIHlvdSBzaGFyZSB0aGUgZG1lc2cgZm9yIHlvdXIgZmFpbHVy
ZSBjYXNlPw0KDQpbNTYxMzMuNTYzMjkzXSB1c2IgMy0xOiBuZXcgZnVsbC1zcGVlZCBVU0IgZGV2
aWNlIG51bWJlciAyOCB1c2luZyB4aGNpX2hjZA0KWzU2MTMzLjcxMjU1OV0gdXNiIDMtMTogTmV3
IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTBiZGEsIGlkUHJvZHVjdD04NzcxLCBiY2REZXZp
Y2U9IDIuMDANCls1NjEzMy43MTI1NzddIHVzYiAzLTE6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6
IE1mcj0xLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0zDQpbNTYxMzMuNzEyNTgyXSB1c2IgMy0x
OiBQcm9kdWN0OiBCbHVldG9vdGggUmFkaW8NCls1NjEzMy43MTI1ODVdIHVzYiAzLTE6IE1hbnVm
YWN0dXJlcjogUmVhbHRlaw0KWzU2MTMzLjcxMjU4OF0gdXNiIDMtMTogU2VyaWFsTnVtYmVyOiAw
MEUwNEMyMzk5ODcNCls1NjEzMy43Mzc4MTJdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVy
ZmFjZSBkcml2ZXIgYnR1c2INCls1NjEzMy43NDIxMjZdIEJsdWV0b290aDogaGNpMDogUlRMOiBl
eGFtaW5pbmcgaGNpX3Zlcj0wYSBoY2lfcmV2PTAwMGIgbG1wX3Zlcj0wYSBsbXBfc3VidmVyPTg3
NjENCls1NjEzMy43NDMxMTVdIEJsdWV0b290aDogaGNpMDogUlRMOiByb21fdmVyc2lvbiBzdGF0
dXM9MCB2ZXJzaW9uPTENCls1NjEzMy43NDMxMjRdIEJsdWV0b290aDogaGNpMDogUlRMOiBsb2Fk
aW5nIHJ0bF9idC9ydGw4NzYxYnVfZncuYmluDQpbNTYxMzMuNzQzNzU0XSBCbHVldG9vdGg6IGhj
aTA6IFJUTDogbG9hZGluZyBydGxfYnQvcnRsODc2MWJ1X2NvbmZpZy5iaW4NCls1NjEzMy43NDM4
MjldIEJsdWV0b290aDogaGNpMDogUlRMOiBjZmdfc3ogNiwgdG90YWwgc3ogMzAyMTANCls1NjEz
My45MTMzMTFdIEJsdWV0b290aDogaGNpMDogUlRMOiBmdyB2ZXJzaW9uIDB4ZGZjNmQ5MjINCls1
NjEzMy45ODAyOTldIEJsdWV0b290aDogTUdNVCB2ZXIgMS4yMg0KDQpoY2kwOiAgIFR5cGU6IFBy
aW1hcnkgIEJ1czogVVNCDQogICAgICAgIEJEIEFkZHJlc3M6IDk4OkEyOjM1Ojg1OjU2OkYxICBB
Q0wgTVRVOiAxMDIxOjYgIFNDTyBNVFU6IDI1NToxMg0KICAgICAgICBVUCBSVU5OSU5HDQogICAg
ICAgIFJYIGJ5dGVzOjE2NzAgYWNsOjAgc2NvOjAgZXZlbnRzOjE4NCBlcnJvcnM6MA0KICAgICAg
ICBUWCBieXRlczozMzkxNyBhY2w6MCBzY286MCBjb21tYW5kczoxODQgZXJyb3JzOjANCiAgICAg
ICAgRmVhdHVyZXM6IDB4ZmYgMHhmZiAweGZmIDB4ZmUgMHhkYiAweGZkIDB4N2IgMHg4Nw0KICAg
ICAgICBQYWNrZXQgdHlwZTogRE0xIERNMyBETTUgREgxIERIMyBESDUgSFYxIEhWMiBIVjMNCiAg
ICAgICAgTGluayBwb2xpY3k6IFJTV0lUQ0ggSE9MRCBTTklGRiBQQVJLDQogICAgICAgIExpbmsg
bW9kZTogUEVSSVBIRVJBTCBBQ0NFUFQNCiAgICAgICAgTmFtZTogJ21heC1UaGlua1BhZC1YMjMw
Jw0KICAgICAgICBDbGFzczogMHg2YzAxMGMNCiAgICAgICAgU2VydmljZSBDbGFzc2VzOiBSZW5k
ZXJpbmcsIENhcHR1cmluZywgQXVkaW8sIFRlbGVwaG9ueQ0KICAgICAgICBEZXZpY2UgQ2xhc3M6
IENvbXB1dGVyLCBMYXB0b3ANCiAgICAgICAgSENJIFZlcnNpb246IDUuMSAoMHhhKSAgUmV2aXNp
b246IDB4ZGZjNg0KICAgICAgICBMTVAgVmVyc2lvbjogNS4xICgweGEpICBTdWJ2ZXJzaW9uOiAw
eGQ5MjINCiAgICAgICAgTWFudWZhY3R1cmVyOiBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ29ycG9y
YXRpb24gKDkzKQ0KDQoNCkJScywNCk1heA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQmFnYXMgU2FuamF5YSA8YmFnYXNkb3RtZUBnbWFpbC5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgT2N0b2JlciA0LCAyMDIzIDc6NTYgQU0NCj4gVG86IEtpcmlsbCBBLiBTaHV0
ZW1vdiA8a2lyaWxsQHNodXRlbW92Lm5hbWU+OyBIaWxkYSBXdQ0KPiA8aGlsZGF3dUByZWFsdGVr
LmNvbT4NCj4gQ2M6IGFsZXhfbHVAcmVhbHNpbC5jb20uY247IEx1aXogQXVndXN0byB2b24gRGVu
dHoNCj4gPGx1aXoudm9uLmRlbnR6QGludGVsLmNvbT47IE1heCBDaG91IDxtYXguY2hvdUByZWFs
dGVrLmNvbT47IE1hcmNlbA0KPiBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz47IEpvaGFu
IEhlZGJlcmcNCj4gPGpvaGFuLmhlZGJlcmdAZ21haWwuY29tPjsgSnVlcmcgSGFlZmxpZ2VyDQo+
IDxqdWVyZy5oYWVmbGlnZXJAY2Fub25pY2FsLmNvbT47IExpbnV4IEJsdWV0b290aA0KPiA8bGlu
dXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZz47IFRob3JzdGVuIExlZW1odWlzIDxsaW51eEBs
ZWVtaHVpcy5pbmZvPjsNCj4gTGludXggUmVncmVzc2lvbnMgPHJlZ3Jlc3Npb25zQGxpc3RzLmxp
bnV4LmRldj47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QNCj4gPGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBSZWdyZXNzaW9uOiBkZXZjb3JlZHVtcCBwYXRj
aCBicm9rZSBSZWFsdGVrIHVzYiBibHVldG9vdGgNCj4gYWRhcHRlcg0KPiANCj4gT24gVHVlLCBP
Y3QgMDMsIDIwMjMgYXQgMDk6MjA6MzhQTSArMDMwMCwgS2lyaWxsIEEuIFNodXRlbW92IHdyb3Rl
Og0KPiA+IEhpLA0KPiA+DQo+ID4gQ29tbWl0IDA0NDAxNGNlODVhMSAoIkJsdWV0b290aDogYnRy
dGw6IEFkZCBSZWFsdGVrIGRldmNvcmVkdW1wDQo+ID4gc3VwcG9ydCIpIGJyb2tlIFJlYWx0ZWst
YmFzZWQgQVNVUyBVU0ItQlQ1MDAsIElEIDBiMDU6MTkwZS4NCj4gPg0KPiA+IERldmljZXMgZmFp
bGVkIHRvIGNvbm5lY3QuIGhjaWNvbmZpZyBzaG93ZWQgYSBjb250cm9sbGVyIHdpdGggYWxsLXpl
cm8NCj4gPiBCRCBhZGRyZXNzLg0KPiANCj4gV2hhdCBpcyBpdHMgb3V0cHV0IHRoZW4/IEFuZCBk
bWVzZyBsb2c/DQo+IA0KPiA+DQo+ID4gSSByZXZlcnRlZCB0aGUgY29tbWl0IGFzIHdlbGwgYXMg
YmQwMDNmYjMzOGFmIHRoYXQgZGVwZW5kcyBvbiB0aGUgY29tbWl0Lg0KPiA+IEl0IG1hZGUgdGhl
IHByb2JsZW0gZ28gYXdheS4NCj4gPg0KPiA+IEkga25vdyB2aXJ0dWFsbHkgbm90aGluZyBhYm91
dCBibHVldG9vdGguIExldCBtZSBrbm93IHdoYXQgaW5mbyB5b3UNCj4gPiBuZWVkIHRvIGRlYnVn
IHRoZSBpc3N1ZS4NCj4gPg0KPiANCj4gSGlsZGEsIGl0IGxvb2tzIGxpa2UgdGhpcyByZWdyZXNz
aW9uIGlzIGNhdXNlZCBieSBhIGNvbW1pdCBvZiB5b3Vycy4gV291bGQgeW91DQo+IGxpa2UgdG8g
dGFrZSBhIGxvb2sgb24gaXQ/DQo+IA0KPiBSZWdhcmRsZXNzLCB0aGFua3MgZm9yIHRoZSByZWdy
ZXNzaW9uIHJlcG9ydC4gSSdtIGFkZGluZyBpdCB0byByZWd6Ym90Og0KPiANCj4gI3JlZ3pib3Qg
XmludHJvZHVjZWQ6IDA0NDAxNGNlODVhMTdjDQo+IA0KPiAtLQ0KPiBBbiBvbGQgbWFuIGRvbGwu
Li4ganVzdCB3aGF0IEkgYWx3YXlzIHdhbnRlZCEgLSBDbGFyYQ0K
