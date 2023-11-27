Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BF27F9F73
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjK0MUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjK0MUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:20:42 -0500
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 04:20:45 PST
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70300191;
        Mon, 27 Nov 2023 04:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1701087257;
        bh=vz9BHoBHoO5ZtSpjTwYyjwqn8UMnay1tmwhleAtdPwQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=U8Fz3CBfHGyXeGr8oZhNEWkdI7MP7LUWEoa5SUw6PBbGdUfwlfX6N9uifzkc/1zHh
         CzH8r4IHFuX8hKlil2VZSfjSyLpVuNKtOydtuNsl+9v+fVQTgQhbnsVx5VmSIdtKqD
         7x9manomwQYqJcIdrTrzeI18/mp4n97NbOLTm/up4czoTRMKwtrwgfZZ5Cy4pl3wl1
         vwABEVfk/P8P8LQikfvIVTHgtUPLDk6GiJdjnHiYY5bMvWKXvTjGbRX+gYmklzcYgx
         u+GuQHVF9I4biYRb94PKcpKuS0AOmRlfjpgUKdhbcYLsAlNI/UDC+MLYQYfgGEWp8w
         IjqucM2B1s2TQ==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        "brenda.streiff@ni.com" <brenda.streiff@ni.com>,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        "Tomas Paukrt" <tomaspaukrt@email.cz>
Subject: RE: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Thread-Topic: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Thread-Index: AQHaH/jBESSZN4JU2UOxi81YCMKNnLCN1MYg
Date:   Mon, 27 Nov 2023 12:14:06 +0000
Message-ID: <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
In-Reply-To: <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
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

RnJvbTogTGlubyBTYW5maWxpcHBvIFttYWlsdG86TGlub1NhbmZpbGlwcG9AZ214LmRlXQ0KU2Vu
dDogU3VuZGF5LCBOb3ZlbWJlciAyNiwgMjAyMyAxMjo0MCBBTQ0KDQpIaSwgDQoNCj4gT24gMjIu
MTEuMjMgYXQgMTU6NTMsIEx1a2FzIFd1bm5lciB3cm90ZToNCj4+IE9uIE1vbiwgTm92IDIwLCAy
MDIzIGF0IDA0OjEwOjU0UE0gKzAxMDAsIFJhc211cyBWaWxsZW1vZXMgd3JvdGU6DQo+Pj4gU29t
ZSBib2FyZHMgYXJlIGNhcGFibGUgb2YgYm90aCByczIzMiBhbmQgcnM0ODUsIGFuZCBjb250cm9s
IHdoaWNoDQo+Pj4gZXh0ZXJuYWwgdGVybWluYWxzIGFyZSBhY3RpdmUgdmlhIGEgZ3Bpby1jb250
cm9sbGVkIG11eC4gQWxsb3cNCj4+PiBkZXNjcmliaW5nIHRoYXQgZ3BpbyBpbiBEVCBzbyB0aGF0
IHRoZSBrZXJuZWwgY2FuIHRyYW5zcGFyZW50bHkgaGFuZGxlDQo+Pj4gdGhlIHByb3BlciBzZXR0
aW5nIHdoZW4gdGhlIHVhcnQgaXMgc3dpdGNoZWQgYmV0d2VlbiByczIzMiBhbmQgcnM0ODUNCj4+
PiBtb2Rlcy4NCj4+DQo+PiBDcmVzY2VudCBDWSBIc2llaCAoK2NjKSBpcyBpbiBwYXJhbGxlbCB0
cnlpbmcgdG8gYWRkIGFuIFJTLTQyMiBtb2RlIGJpdA0KPj4gdG8gc3RydWN0IHNlcmlhbF9yczQ4
NToNCj4+DQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzExMjEwOTUxMjIuMTU5
NDgtMS1jcmVzY2VudGN5LmhzaWVoQG1veGEuY29tLw0KPj4NCj4gDQo+IFRoYXQgbmV3IGZsYWcg
d2FzIHN1Z2dlc3RlZCBieSBtZSBpbnN0ZWFkIG9mIHVzaW5nIFNFUl9SUzQyMl9FTkFCTEVELCB3
aGljaA0KPiB3b3VsZCBtb3N0bHkgYmUgcmVkdW5kYW50IHRvIFNFUl9SUzQ4NV9FTkFCTEVELg0K
PiBJIGRvbnQga25vdyBpZiBpdCBpcyBhIGdvb2QgY2hvaWNlIGluIHRoZSBsb25nIHRlcm0gdG8g
aGFuZGxlIGJvdGggbW9kZXMgd2l0aGluDQo+IHRoZSBSUzQ4NSBjb25maWd1cmF0aW9uLiBJdCB3
b3VsZCBiZSBjbGVhbmVyIHRvIGhhdmUgYW4gb3duIFJTNDIyIHN0cnVjdHVyZSB3aXRoDQo+IGl0
cyBvd24gZmxhZ3MgYW5kIHByb3BlcnRpZXMuIEFuZCB1bnRpbCBub3cgdGhlIG9ubHkgZmxhZyB0
aGF0IHNlZW1zIHRvIG1ha2Ugc2Vuc2UNCj4gZm9yIGJvdGggUlM0MjIgYW5kIFJTNDg1IGlzIEFG
QUlDUyBTRVJfUlM0ODVfVEVSTUlOQVRFX0JVUy4NCj4gDQo+IE9uIHRoZSBvdGhlciBoYW5kIHRo
ZSBidXMgdGVybWluYXRpb24gaXMgYXQgbGVhc3QgYSBwcm9wZXJ0eSB0aGF0IGJvdGggbW9kZXMg
aGF2ZQ0KPiBpbiBjb21tb24uIEFuZCBoYW5kbGluZyBSUzQyMiBpbiBpdHMgb3duIHN0cnVjdHVy
ZSB3b3VsZCByZXF1aXJlIGFub3RoZXIgaW9jdGwNCj4gdG8gc2V0IGFuZCBnZXQgdGhlIHRoZSBS
UzQyMiBzZXR0aW5ncy4NCj4gDQo+IEJ1dCBtYXliZSB0aGVyZSBhcmUgbW9yZSBvciBiZXR0ZXIg
cG9zc2liaWxpdGllcyB0byBoYW5kbGUgUlM0ODIyIHN1cHBvcnQuIEkgd291bGQgbGlrZSB0bw0K
PiBoZWFyIG90aGVyIGlkZWFzLg0KPiANCj4gDQo+IA0KPj4gSSBkb24ndCBrbm93IHdoZXRoZXIg
dGhhdCBtYWtlcyBzZW5zZSBhdCBhbGwgKEkgaGFkIHRob3VnaHQgUlMtNDIyIGlzDQo+PiB0aGUg
c2FtZSBhcyBSUy00ODUgd2l0aCBmdWxsLWR1cGxleCwgaS5lLiBTRVJfUlM0ODVfRU5BQkxFRCBw
bHVzDQo+PiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKQ0KDQpXaXRoIFJTLTQ4NSBmdWxsIGR1cGxl
eCwgU0VSX1JTNDg1X1JYX0RVUklOR19UWCBtYWtlcyBubyBzZW5zZSB0byBtZS4NClNlZSBiZWxv
dy4NCg0KPj4NCj4+IEJ1dCBpZiB0aGF0IHBhdGNoIGdldHMgYWNjZXB0ZWQsIHdlJ2QgaGF2ZSAq
dGhyZWUqIGRpZmZlcmVudCBtb2RlczoNCj4+IFJTLTIzMiwgUlMtNDg1LCBSUy00MjIuDQo+IA0K
PiBBY3R1YWxseSB3ZSB3b3VsZCBoYXZlIGZvdXIgKGFzIEJyZW5kYSBhbHJlYWR5IHdyb3RlLA0K
PiBzZWUgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2M2ZWE5MTJmLWQ1YWItNDc2MS04MTNk
LTNiNmI2YmUxNDFjYkBuaS5jb20vKSwNCj4gYW5kIHdpdGggdGhlIHByb3Bvc2UgU0VSX1JTNDg1
X01PREVfUlM0MjIgZmxhZyB0aGVzZSBtb2RlcyB3b3VsZCBiZSB1c2VkIGxpa2UNCj4gDQo+IFJT
LTIzMjogICAgICAgICAgICAgICAgICAgICAgIHJzNDg1LT5mbGFncyA9IDANCj4gUlMtNDIyOiAg
ICAgICAgICAgICAgICAgICAgICAgcnM0ODUtPmZsYWdzID0gU0VSX1JTNDg1X0VOQUJMRUR8U0VS
X1JTNDg1X01PREVfUlM0MjINCj4gUlMtNDg1ICgyLXdpcmUgaGFsZi1kdXBsZXgpOiAgcnM0ODUt
PmZsYWdzID0gU0VSX1JTNDg1X0VOQUJMRUQNCj4gUlMtNDg1ICg0LXdpcmUgZnVsbC1kdXBsZXgp
OiAgcnM0ODUtPmZsYWdzID0gU0VSX1JTNDg1X0VOQUJMRUR8U0VSX1JTNDg1X1JYX0RVUklOR19U
WA0KDQpJbiBteSBwb2ludCBvZiB2aWV3IHRoZXJlIGFyZSBhbHNvIHR3byBkaWZmZXJlbnQgbW9k
ZXMgZm9yIHRoZSBSUy00ODUgMi13aXJlDQpoYWxmLWR1cGxleCBidXMgZGVwZW5kaW5nIG9uIHRo
ZSBmbGFnIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFguDQotIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgg
aXMgbm90IHNldDogVGhlIGRldmljZSBkb2Vzbid0IHNlZSB0aGUgYnVzIGR1cmluZyBzZW5kaW5n
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKFJYIGlzIG9mZiBkdXJpbmcg
c2VuZGluZykuIA0KLSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYIGlzIHNldDogICAgIFRoZSBkZXZp
Y2Ugc2VlIHdhbnQgaXMgb24gYnVzIGR1cmluZyBzZW5kaW5nDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKFJYIGlzIGFsc28gb24gZHVyaW5nIHNlbmRpbmcpLCBzbyB5b3Ug
Y2FuDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2VlIHlvdXIgdHJhbnNt
aXNzaW9uIGFuZCBhbHNvIGlmIGFub3RoZXIgYnVzDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZGV2aWNlIGlzIHRyYW5zbWl0dGluZyBhdCB0aGUgc2FtZSB0aW1lLg0KDQpP
biBSUy00ODUgNC13aXJlIFRYIGFuZCBSWCBhcmUgc2VwYXJhdGVkIGJ5IHdpcmVzLiBTbyB0aGUg
ZGVmaW5pdGlvbiBvZg0KU0VSX1JTNDg1X1JYX0RVUklOR19UWCBhYm92ZSBtYWtlcyBubyBzZW5z
ZSwgYmVjYXVzZSB5b3UgY2FuIHJlY2VpdmUgYWxsIHRoZSB0aW1lDQp3aXRob3V0IHdvcnJ5aW5n
IGFib3V0IFRYLiBPbiB0aGUgc29mdHdhcmUgc2lkZSBSUy00ODUgNC13aXJlIGZ1bGwgZHVwbGV4
IGl0IGJlaGF2ZXMNCmxpa2UgUlMtMjMyLiBTbyB3ZSBkb24ndCBuZWVkIHRyYW5zY2VpdmVyIGNv
bnRyb2xsaW5nIGJ5IHRoZSBSVFMgcGluLg0KDQpCYXNpY2FsbHkgZm9yIG1lIHRoZSBTRVJfUlM0
ODVfRU5BQkxFRCBmbGFnIGlzIHRvIGVuYWJsZSB0aGUgUlRTIGNvbnRyb2wgZm9yIHRoZQ0KdHJh
bnNjZWl2ZXIuIE1heWJlIG9uIHNvZnR3YXJlIHNpZGUgd2UgY2FuIGRpc3Rpbmd1aXNoIGJldHdl
ZW4gaGFsZiBhbmQgZnVsbCBkdXBsZXgNCm1vZGUgYW5kIHdoZXRoZXIgUlggaXMgZW5hYmxlZCBk
dXJpbmcgc2VuZGluZyBieSB0aGUgZmxhZyBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYOg0KUlMtMjMy
OiAgICAgICAgICAgICAgICAgICAgICAgICAgcnM0ODUtPmZsYWdzID0gMA0KUlMtNDIyIC8gUlMt
NDg1ICg0LXdpcmUpOiAgICAgICAgcnM0ODUtPmZsYWdzID0gU0VSX1JTNDg1X0VOQUJMRUR8U0VS
X1JTNDg1X01PREVfRlVMTF9EVVBMRVgNClJTLTQ4NSAoMi13aXJlIE5PIFJYX0RVUklOR19UWCk6
IHJzNDg1LT5mbGFncyA9IFNFUl9SUzQ4NV9FTkFCTEVEfFNFUl9SUzQ4NV9NT0RFX0hBTEZfRFVQ
TEVYDQpSUy00ODUgKDItd2lyZSBSWF9EVVJJTkdfVFgpOiAgICByczQ4NS0+ZmxhZ3MgPSBTRVJf
UlM0ODVfRU5BQkxFRHxTRVJfUlM0ODVfTU9ERV9IQUxGX0RVUExFWHxTRVJfUlM0ODVfUlhfRFVS
SU5HX1RYDQoNClNFUl9SUzQ4NV9NT0RFX0ZVTExfRFVQTEVYIGFuZCBTRVJfUlM0ODVfTU9ERV9I
QUxGX0RVUExFWCBjYW4gYmUgZGVmaW5lZCBhdCB0aGUNCnNhbWUgYml0LiBJZiBTRVJfUlM0ODVf
TU9ERV9IQUxGX0RVUExFWCB3aWxsIGJlIGRlZmluZWQgYXMgMCBpdCBicmVha3Mgbm90aGluZy4N
CldpdGggU0VSX1JTNDg1X01PREVfRlVMTF9EVVBMRVgsIHRoZSBSVFMgcGluIGRvZXMgbm90IG5l
ZWQgdG8gYmUgY29udHJvbGxlZC4NCg0KPiANCj4+ICBBIHNpbmdsZSBHUElPIHNlZW1zIGluc3Vm
ZmljaWVudCB0byBoYW5kbGUgdGhhdC4NCj4gDQo+IEdQSU9zIGZvciBSUzQ4NSBpcyBhbm90aGVy
IHRoaW5nLg0KPiANCj4gSSBtZWFuLCBjdXJyZW50bHkgd2UgaGF2ZSBhIEdQSU8gZm9yIFJTNDg1
IHRlcm1pbmF0aW9uIChJIGludHJvZHVjZWQgaXQgd2l0aCBjb21taXQNCj4gNDRiMjdhZWM5ZDk2
ODA4NzUpLg0KPiBDaHJpc3RvcGggaW50cm9kdWNlZCBzdXBwb3J0IGZvciBhIHJ4LWR1cmluZy10
eCBHUElPIChzZWUgY29tbWl0IDE2M2YwODBlYjcxNykuIFRvbWFzDQo+IGludGVuZHMNCj4gdG8g
YWRkIGEgR1BJTyB3aGljaCBlbmFibGVzIFJTNDg1IGlmIGFzc2VydGVkDQo+IChzZWUgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzNaYS5aWnMlN0QubmRYSThDTWVlNC4xYk42ZVFAc2V6bmFt
LmN6LykgYW5kIHdpdGggUmFzbXVzDQo+IHBhdGNoZXMNCj4gd2UgYXJlIGFib3V0IHRvIGFkZCBh
IE1VWC1HUElPIHdoaWNoIGlzIHRvIGJlIGFzc2VydGVkIGlmIFJTNDg1IGlzIGVuYWJsZWQuDQo+
IA0KPiBJIHdvbmRlciB3aGVyZSB0aGlzIHdpbGwgZW5kIGFuZCBpZiB3ZSByZWFsbHkgaGF2ZSB0
byBzdXBwb3J0IGV2ZXJ5IHBvc3NpYmxlIEdQSU8NCj4gaW4gdGhlIHNlcmlhbCBjb3JlLg0KDQpJ
IHRoaW5rIHRoZSBHUElPcyByZWZsZWN0IHRoZSBmbGFnIHN0YXRlcyBhbmQgYXJlIG1lYW5pbmdm
dWw6DQotIFNFUl9SUzQ4NV9URVJNSU5BVEVfQlVTOiBTd2l0Y2ggYnVzIHRlcm1pbmF0aW9uIG9u
L29mZiBieSBHUElPDQotIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFg6ICBVc2VkIHRvIHN0b3AgUlgg
ZHVyaW5nIFRYIGluIGhhcmR3YXJlIGJ5IEdQSU8gKGZvciAyLXdpcmUpDQotIFNFUl9SUzQ4NV9F
TkFCTEVEOiAgICAgICBNdXhpbmcgYmV0d2VlbiBSUy0yMzIgYW5kIFJTLTQ4NSBieSBHUElPDQoN
ClN3aXRjaGluZyBSUy00ODUgb24gZHVyaW5nIGJvb3QgY291bGQgYWxzbyBiZSBoYW5kbGVkIGJ5
IGEgZGV2aWNldHJlZSBvdmVybGF5LiBFdmFsdWF0ZSB0aGUNCkdQSU8gYW5kIGxvYWQgYSBEVE8g
YWNjb3JkaW5nbHkgYmVmb3JlIGJvb3RpbmcuDQoNCg0KUmVnYXJkcw0KQ2hyaXN0b3BoDQo=
