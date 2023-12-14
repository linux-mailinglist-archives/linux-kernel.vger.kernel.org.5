Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DB38131E2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572927AbjLNNm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573015AbjLNNm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:42:56 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C930123
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1702561312;
        bh=aA46rQnXWzvf6O7iLbhRK/Kl8C4HBcMLPJSxSkIvRFM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QkZSWxigv5o3u941gSyWwYWW0H5RGVPtbYbbOWV4fZfBoCmcwIYWSUb42BvfcCLah
         grRxCxyYxj9Lck0O75SlGdTbXuKgJTJYPp7GA103w7E5/1+lGnyjCh1A9CoVPEUvjH
         qjTCDwyn8yX0avY8Wyg1M7xegbz5ZjyIBYMlNSeEAUqi5PtKrlROcczXAv0f5tNERk
         aQ48ySe1P7hqXMho1zQf6cG+b1FFCfNqBcyYgjcbW/GOH9JrZxTJk59drsvNf019zx
         /+uk8I9zrBuZQNYphUFSnZK1/A5Lsh1vNJyN+sctLv3zmtp6YkZlT39Ilx5ERx5lIn
         I9ZYUyGZt953w==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
CC:     Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        "brenda.streiff@ni.com" <brenda.streiff@ni.com>,
        Tomas Paukrt <tomaspaukrt@email.cz>
Subject: RE: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Thread-Topic: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Thread-Index: AQHaH/jBESSZN4JU2UOxi81YCMKNnLCN1MYggA6QRICABHVPgIADOxKAgASJVgCAABWukA==
Date:   Thu, 14 Dec 2023 13:41:47 +0000
Message-ID: <b35730df8288469fbaf67b5ceae4eece@dh-electronics.com>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
 <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
 <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
 <fe28eb93-daa1-41af-a005-f21aa87e1984@gmx.de>
 <ZXcJr4VS_uGr_6TV@smile.fi.intel.com>
 <ZXrX4mQXPLum0jL3@moxa-ThinkCentre-M90t>
In-Reply-To: <ZXrX4mQXPLum0jL3@moxa-ThinkCentre-M90t>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ3Jlc2NlbnQgQ1kgSHNpZWggPGNyZXNjZW50Y3kuaHNpZWhAbW94YS5jb20+DQpTZW50
OiBUaHVyc2RheSwgRGVjZW1iZXIgMTQsIDIwMjMgMTE6MjUgQU0NCj4gT24gTW9uLCBEZWMgMTEs
IDIwMjMgYXQgMDM6MDc6NTlQTSArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPj4gT24g
U2F0LCBEZWMgMDksIDIwMjMgYXQgMTI6NDc6NDdQTSArMDEwMCwgTGlubyBTYW5maWxpcHBvIHdy
b3RlOg0KPj4+IE9uIDA2LjEyLjIzIDE2OjQyLCBMaW5vIFNhbmZpbGlwcG8gd3JvdGU6DQo+Pg0K
Pj4+Pj4+PiBDcmVzY2VudCBDWSBIc2llaCAoK2NjKSBpcyBpbiBwYXJhbGxlbCB0cnlpbmcgdG8g
YWRkIGFuIFJTLTQyMiBtb2RlIGJpdA0KPj4+Pj4+PiB0byBzdHJ1Y3Qgc2VyaWFsX3JzNDg1Og0K
Pj4+Pj4+Pg0KPj4+Pj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzExMjEwOTUx
MjIuMTU5NDgtMS1jcmVzY2VudGN5LmhzaWVoQG1veGEuY29tLw0KPj4+Pj4+Pg0KPj4+Pj4+DQo+
Pj4+Pj4gVGhhdCBuZXcgZmxhZyB3YXMgc3VnZ2VzdGVkIGJ5IG1lIGluc3RlYWQgb2YgdXNpbmcg
U0VSX1JTNDIyX0VOQUJMRUQsIHdoaWNoDQo+Pj4+Pj4gd291bGQgbW9zdGx5IGJlIHJlZHVuZGFu
dCB0byBTRVJfUlM0ODVfRU5BQkxFRC4NCj4+Pg0KPj4+IEEgY2xlYW5lciBzb2x1dGlvbiB3b3Vs
ZCBwcm9iYWJseSBiZSB0byBub3QgaGFuZGxlIFJTNDIyIHdpdGggdGhlIFJTNDg1IHNldHRpbmdz
IGF0DQo+Pj4gYWxsLCBidXQgdG8gaW50cm9kdWNlIGFub3RoZXIgc2V0IG9mIGlvY3RscyB0byBz
ZXQgYW5kIHJlYWQgaXQuDQo+Pj4NCj4+PiBBbiBvd24gUlM0MjIgc3RydWN0dXJlIGxpa2UNCj4+
Pg0KPj4+IHN0cnVjdCBzZXJpYWxfcnM0MjIgew0KPj4+ICAgICBfX3UzMiAgIGZsYWdzOw0KPj4+
ICNkZWZpbmUgU0VSX1JTNDIyX0VOQUJMRUQgICAgICAgICAgICgxIDw8IDApDQo+Pj4gI2RlZmlu
ZSBTRVJfUlM0MjJfVEVSTUlOQVRFX0JVUyAgICAgICAgICAgICAoMSA8PCAxKQ0KPj4+IH07DQo+
Pj4NCj4+Pg0KPj4+IGNvdWxkIGJlIHVzZWQgYXMgdGhlIHBhcmFtZXRlciBmb3IgdGhlc2UgbmV3
IGlvY3Rscy4NCj4+Pg0KPj4+IEFueSBjb21tZW50cyBvbiB0aGlzPw0KPj4NCj4+IEkgaGF2ZSAo
bWF5YmUgbm90IHNvIGNvbnN0cnVjdGl2ZSkgYSBjb21tZW50LiBQbGVhc2UsIGF0IGFsbCBtZWFu
cyB0cnkgdG8gbm90DQo+PiBleHRlbmQgdGhlIGV4aXN0aW5nIHNlcmlhbCBkYXRhIHN0cnVjdHVy
ZXMsIHdlIGhhdmUgdG9vIG1hbnkgb25lcyB3aXRoIHRvbyBtYW55DQo+PiBmaWVsZHMgYWxyZWFk
eS4gRm9yIHVzZXIgc3BhY2UsIHRob3VnaCwgb25lIG1heSB1c2UgdW5pb25zIGFuZCBmbGFncywg
YnV0IGZvcg0KPj4gaW50ZXJuYWwgb25lcyBpdCBtaWdodCBiZSBiZXR0ZXIgd2F5cywgSSB0aGlu
ay4NCj4gDQo+IEhvdyBhYm91dCByZXZpc2luZyB0aGUgbmFtZSBvZiAnVElPQ1NSUzQ4NScgYW5k
ICdzZXJpYWxfcnM0ODUnIHRvIGENCj4gZ2VuZXJhbCBvbmUsIGFuZCBwdXQgUlM0MjIgYW5kIFJT
NDg1IGNvbmZpZ3VyYXRpb24gZmxhZ3MgaW50byB0aGF0DQo+IHN0cnVjdHVyZT8NCj4gDQo+IFNv
IHRoYXQgaW4gdXNlcnNwYWNlIGl0IGNvdWxkIHNldCBSUzQyMiBvciBSUzQ4NSBjb25maWd1cmF0
aW9ucyB1c2luZyBhDQo+IHNpbmdsZSBpb2N0bCBjb21tYW5kIGFuZCBvbmUgc3RydWN0dXJlLg0K
PiANCj4gSW4gdGhpcyB3YXksIGl0IHdvbid0IGJlIGNvbmZ1c2VkIGluIHVzZXJzcGFjZSBhbmQg
d29uJ3QgYWRkIG5ldyBkYXRhDQo+IHN0cnVjdHVyZSBpbnRlcm5hbGx5IGFzIHdlbGwuDQo+IA0K
DQpJIHdpbGwgc3VtbWFyaXplIHRoZSBjdXJyZW50IHNpdHVhdGlvbiBmcm9tIG15IHBvaW50IG9m
IHZpZXcsIG1heWJlIGl0IGhlbHBzOg0KDQpSUy0yMzI6DQogIC0gRnVsbCBEdXBsZXggUG9pbnQt
dG8tUG9pbnQgY29ubmVjdGlvbg0KICAtIE5vIHRyYW5zY2VpdmVyIGNvbnRyb2wgd2l0aCBSVFMN
CiAgLSBObyB0ZXJtaW5hdGlvbg0KICAtIE5vIGV4dHJhIHN0cnVjdCBpbiB1c2UNCg0KUlMtNDIy
Og0KICAtIEZ1bGwgRHVwbGV4IFBvaW50LXRvLVBvaW50IGNvbm5lY3Rpb24NCiAgLSBObyB0cmFu
c2NlaXZlciBjb250cm9sIHdpdGggUlRTIG5lZWRlZA0KICAtIFRlcm1pbmF0aW9uIHBvc3NpYmxl
DQogIC0gRXh0cmEgc3RydWN0IHNlcmlhbF9yczQ4NSBuZWVkZWQgaWYgdGVybWluYXRpb24gaXMg
dXNlZA0KID0+IFJTLTQyMiBjYW4gYmUgdXNlZCBpbiBSUy0yMzIgb3BlcmF0aW9uLCBidXQgaWYg
YSB0ZXJtaW5hdGlvbiBzaG91bGQgYmUNCiAgICBzd2l0Y2hhYmxlIHRoZSBSUzQ4NSBmbGFnIGhh
cyB0byBiZSBlbmFibGVkLiBCdXQgdGhlbiBhbHNvIHRyYW5zY2VpdmVyDQogICAgY29udHJvbCB3
aWxsIGJlIGVuYWJsZWQuIE5vdCBhIHZlcnkgc2F0aXNmeWluZyBzaXR1YXRpb24uDQoNClJTLTQ4
NSAoMi13aXJlKSB2ZXJ5IGNvbW1vbjoNCiAgLSBIYWxmIER1cGxleCBSUy00ODUgYnVzDQogIC0g
VHJhbnNjZWl2ZXIgY29udHJvbCB3aXRoIFJUUyBpcyBuZWVkZWQNCiAgLSBUZXJtaW5hdGlvbiBw
b3NzaWJsZQ0KICAtIEV4dHJhIHN0cnVjdCBzZXJpYWxfcnM0ODUgaXMgbmVlZGVkDQogPT4gUlMt
NDg1IGhhcyB0byBiZSBlbmFibGVkIGFuZCBjb25maWd1cmVkOg0KICAgIC0gU2V0IFNFUl9SUzQ4
NV9FTkFCTEVEIA0KICAgIC0gU2V0IFNFUl9SUzQ4NV9SVFNfT05fU0VORCBvciBTRVJfUlM0ODVf
UlRTX0FGVEVSX1NFTkQNCiAgICAtIFNldC9jbGVhciBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYIGRl
cGVuZGluZyBvbiB3aGV0aGVyDQogICAgICB0aGUgcmVjZWl2ZXIgcGF0aCBzaG91bGQgYmUgb24g
b3Igb2ZmIGR1cmluZyBzZW5kaW5nLg0KICAgICAgSWYgaXQncyBzZXQgaXQgYWxsb3dzIHRvIG1v
bml0b3IgdGhlIHNlbmRpbmcgb24gdGhlIGJ1cw0KICAgICAgYW5kIGRldGVjdCB3aGV0aGVyIGFu
b3RoZXIgYnVzIGRldmljZSBpcyB0cmFuc21pdHRpbmcNCiAgICAgIGF0IHRoZSBzYW1lIHRpbWUu
DQogICAgLSBTZXQvY2xlYXIgU0VSX1JTNDg1X1RFUk1JTkFURV9CVVMgZm9yIGJ1cyB0ZXJtaW5h
dGlvbi4NCg0KUlMtNDg1ICg0LXdpcmUpIGxpdHRsZSB1c2VkOg0KICAtIEZ1bGwgRHVwbGV4IFJT
LTQ4NSBidXMNCiAgLSBUcmFuc2NlaXZlciBjb250cm9sIHdpdGggUlRTIGlzIG5lZWRlZA0KICAt
IFRlcm1pbmF0aW9uIHBvc3NpYmxlDQogIC0gRXh0cmEgc3RydWN0IHNlcmlhbF9yczQ4NSBpcyBu
ZWVkZWQNCiA9PiBSUy00ODUgaGFzIHRvIGJlIGVuYWJsZWQgYW5kIGNvbmZpZ3VyZWQ6DQogICAg
LSBTZXQgU0VSX1JTNDg1X0VOQUJMRUQgDQogICAgLSBTZXQgU0VSX1JTNDg1X1JUU19PTl9TRU5E
IG9yIFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORA0KICAgIC0gU2V0IFNFUl9SUzQ4NV9SWF9EVVJJ
TkdfVFgsIGFzIHRoZSByZWNlaXZlciBzaG91bGQgYWx3YXlzDQogICAgICBiZSBlbmFibGVkIGlu
ZGVwZW5kZW50bHkgb2YgVFgsIGJlY2F1c2UgVFggYW5kIFJYIGFyZQ0KICAgICAgc2VwYXJhdGVk
IGZyb20gZWFjaCBvdGhlciBieSB0aGVpciBvd24gd2lyZXMuDQogICAgLSBTZXQvY2xlYXIgU0VS
X1JTNDg1X1RFUk1JTkFURV9CVVMgZm9yIGJ1cyB0ZXJtaW5hdGlvbi4NCg0KSSB0aGluayB0aGUg
R1BJT3MgcmVmbGVjdCB0aGUgZmxhZyBzdGF0ZXMgYW5kIGFyZSBtZWFuaW5nZnVsOg0KLSBTRVJf
UlM0ODVfVEVSTUlOQVRFX0JVUzogU3dpdGNoIGJ1cyB0ZXJtaW5hdGlvbiBvbi9vZmYgYnkgR1BJ
Tw0KLSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYOiAgVXNlZCB0byBlbmFibGUvZGlzYWJsZSBSWCBk
dXJpbmcgVFgNCiAgICAgICAgICAgICAgICAgICAgICAgICAgIGluIGhhcmR3YXJlIGJ5IEdQSU8g
KGZvciAyLXdpcmUpDQotIFNFUl9SUzQ4NV9FTkFCTEVEOiAgICAgICBNdXhpbmcgYmV0d2VlbiBS
Uy0yMzIgYW5kIFJTLTQ4NSBieSBHUElPDQoNClN3aXRjaGluZyBSUy00ODUgb24gZHVyaW5nIGJv
b3QgY291bGQgYWxzbyBiZSBoYW5kbGVkIGJ5IGEgZGV2aWNldHJlZQ0Kb3ZlcmxheS4gRXZhbHVh
dGUgdGhlIEdQSU8gYW5kIGxvYWQgYSBEVE8gYWNjb3JkaW5nbHkgYmVmb3JlIGJvb3RpbmcuDQoN
ClBsZWFzZSBjb3JyZWN0IG1lIGlmIEkgaGF2ZSBtaXNyZXByZXNlbnRlZCBzb21ldGhpbmcuLi4N
Cg0KSWYgSSBsb29rZWQgYXQgaXQgaW4gdGhpcyBuZXcgd2F5LCBJIHdvdWxkIGRpc2NhcmQgbXkg
aWRlYSB3aXRoIHRoZQ0KRlVMTF9EVVBMRVggYW5kIEhBTEZfRFVQTEVYLiBGb3IgYSBiZXR0ZXIg
dXNlIG9mIFJTLTQyMiBpdCB3b3VsZCBiZQ0KZ29vZCB0byBkaXNhYmxlIHRyYW5zY2VpdmVyIGNv
bnRyb2wgdmlhIFJUUy4gSXQgY2FuIGJlIGRvbmUgYnkgY2xlYXJpbmcNCnRoZSBleGlzdGluZyBm
bGFncyBTRVJfUlM0ODVfUlRTX09OX1NFTkQgYW5kIFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORA0K
YXQgdGhlIHNhbWUgdGltZSwgYnV0IEkgdGhpbmsgaXQgaXMgY29uZnVzaW5nLiBCZXR0ZXIgd291
bGQgYmUgYSBmbGFnDQpmb3IgUlMtNDIyOg0KDQpSUy00MjI6ICAgICAgICAgICAgICAgICAgICAg
U2V0IFNFUl9SUzQyMl9NT0RFIGZvciBkaXNhYmxpbmcNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB0cmFuc2NlaXZlciBjb250cm9sIHZpYSBSVFMuDQpSUy00ODUgKDItd2lyZSBhbmQgNC13
aXJlKTogQ2xlYXIgU0VSX1JTNDIyX01PREUgZm9yIGVuYWJsaW5nDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdHJhbnNjZWl2ZXIgY29udHJvbCB2aWEgUlRTLg0KDQpGaW5hbGx5LCBhdCBw
cmVzZW50IGl0IGlzIGFsc28gbm90IHBvc3NpYmxlIHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gUlM0
ODUNCjItd2lyZSBhbmQgNC13aXJlIG9wZXJhdGlvbi4gSSB0aGluayBpdCBpc24ndCBuZWNlc3Nh
cnksIGFzIGRpZmZlcmVudA0KaGFyZHdhcmUgaGFzIHRvIGJlIHVzZWQgYW55d2F5LiBUaGUgaGFy
ZHdhcmUgdGhlbiBkZXRlcm1pbmVzIHRoZQ0KY29uZmlndXJhdGlvbiwgc2VlIGFib3ZlLg0KDQoN
ClJlZ2FyZHMNCkNocmlzdG9waA0K
