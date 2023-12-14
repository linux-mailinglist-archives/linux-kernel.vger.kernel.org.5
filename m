Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDA8813395
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573557AbjLNOvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573524AbjLNOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:51:44 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9939310F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1702565441;
        bh=aLGN4htM89+up79T2eb77aEvSzdj7cHHPgTWA316ebs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KYciiA4d46KvTdukX8riEEaMKPncF5X+3XL5Flodo1iel2EIVjGTA74wx5gPc84Gj
         v7xRwLrPilGvDflTAOUlzq2Mc0hA88pBYjv6jkWAh5z8hP/DBpd+tJqDpwISLtaDsv
         guZpMxAgdNwOfSqGs+fDySkOrUrGX6zA3yb3VW0UBXs9PUSApQcssHXr/uDyU4YsnW
         moFCMBjWlKtl5DWjnuHBzfW821OURYCY7XG3UCWKK1J4syOS55Yaqve5J83N4MKWVs
         ikY+lHGu5dKrPutuVTdo1fLYS0ADPqXbJELe5GwIeCGQAQaQ0jFijW2iCuDv37ggwS
         ns0ykj9bn2qKA==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Thread-Index: AQHaH/jBESSZN4JU2UOxi81YCMKNnLCN1MYggA6QRICABHVPgIADOxKAgASJVgCAABWukIAAJ8AAgAASapA=
Date:   Thu, 14 Dec 2023 14:50:36 +0000
Message-ID: <cc59c5bb16574073ba8b2bf9bc59bc7c@dh-electronics.com>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
 <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
 <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
 <fe28eb93-daa1-41af-a005-f21aa87e1984@gmx.de>
 <ZXcJr4VS_uGr_6TV@smile.fi.intel.com>
 <ZXrX4mQXPLum0jL3@moxa-ThinkCentre-M90t>
 <b35730df8288469fbaf67b5ceae4eece@dh-electronics.com>
 <ed087928-43ac-42bc-8e4d-d1632db451b9@gmx.de>
In-Reply-To: <ed087928-43ac-42bc-8e4d-d1632db451b9@gmx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxMaW5vU2FuZmlsaXBwb0BnbXguZGU+DQpTZW50OiBUaHVy
c2RheSwgRGVjZW1iZXIgMTQsIDIwMjMgMzowNCBQTQ0KPiANCj4gSGksDQo+IA0KPiBPbiAxNC4x
Mi4yMyAxNDo0MSwgQ2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4gRnJvbTogQ3Jlc2Nl
bnQgQ1kgSHNpZWggPGNyZXNjZW50Y3kuaHNpZWhAbW94YS5jb20+DQo+PiBTZW50OiBUaHVyc2Rh
eSwgRGVjZW1iZXIgMTQsIDIwMjMgMTE6MjUgQU0NCj4+PiBPbiBNb24sIERlYyAxMSwgMjAyMyBh
dCAwMzowNzo1OVBNICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+Pj4+IE9uIFNhdCwg
RGVjIDA5LCAyMDIzIGF0IDEyOjQ3OjQ3UE0gKzAxMDAsIExpbm8gU2FuZmlsaXBwbyB3cm90ZToN
Cj4+Pj4+IE9uIDA2LjEyLjIzIDE2OjQyLCBMaW5vIFNhbmZpbGlwcG8gd3JvdGU6DQo+Pj4+DQo+
Pj4+Pj4+Pj4gQ3Jlc2NlbnQgQ1kgSHNpZWggKCtjYykgaXMgaW4gcGFyYWxsZWwgdHJ5aW5nIHRv
IGFkZCBhbiBSUy00MjIgbW9kZSBiaXQNCj4+Pj4+Pj4+PiB0byBzdHJ1Y3Qgc2VyaWFsX3JzNDg1
Og0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMx
MTIxMDk1MTIyLjE1OTQ4LTEtY3Jlc2NlbnRjeS5oc2llaEBtb3hhLmNvbS8NCj4+Pj4+Pj4+Pg0K
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+IFRoYXQgbmV3IGZsYWcgd2FzIHN1Z2dlc3RlZCBieSBtZSBpbnN0
ZWFkIG9mIHVzaW5nIFNFUl9SUzQyMl9FTkFCTEVELCB3aGljaA0KPj4+Pj4+Pj4gd291bGQgbW9z
dGx5IGJlIHJlZHVuZGFudCB0byBTRVJfUlM0ODVfRU5BQkxFRC4NCj4+Pj4+DQo+Pj4+PiBBIGNs
ZWFuZXIgc29sdXRpb24gd291bGQgcHJvYmFibHkgYmUgdG8gbm90IGhhbmRsZSBSUzQyMiB3aXRo
IHRoZSBSUzQ4NSBzZXR0aW5ncyBhdA0KPj4+Pj4gYWxsLCBidXQgdG8gaW50cm9kdWNlIGFub3Ro
ZXIgc2V0IG9mIGlvY3RscyB0byBzZXQgYW5kIHJlYWQgaXQuDQo+Pj4+Pg0KPj4+Pj4gQW4gb3du
IFJTNDIyIHN0cnVjdHVyZSBsaWtlDQo+Pj4+Pg0KPj4+Pj4gc3RydWN0IHNlcmlhbF9yczQyMiB7
DQo+Pj4+PiAgICAgX191MzIgICBmbGFnczsNCj4+Pj4+ICNkZWZpbmUgU0VSX1JTNDIyX0VOQUJM
RUQgICAgICAgICAgICgxIDw8IDApDQo+Pj4+PiAjZGVmaW5lIFNFUl9SUzQyMl9URVJNSU5BVEVf
QlVTICAgICAgICAgICAgICgxIDw8IDEpDQo+Pj4+PiB9Ow0KPj4+Pj4NCj4+Pj4+DQo+Pj4+PiBj
b3VsZCBiZSB1c2VkIGFzIHRoZSBwYXJhbWV0ZXIgZm9yIHRoZXNlIG5ldyBpb2N0bHMuDQo+Pj4+
Pg0KPj4+Pj4gQW55IGNvbW1lbnRzIG9uIHRoaXM/DQo+Pj4+DQo+Pj4+IEkgaGF2ZSAobWF5YmUg
bm90IHNvIGNvbnN0cnVjdGl2ZSkgYSBjb21tZW50LiBQbGVhc2UsIGF0IGFsbCBtZWFucyB0cnkg
dG8gbm90DQo+Pj4+IGV4dGVuZCB0aGUgZXhpc3Rpbmcgc2VyaWFsIGRhdGEgc3RydWN0dXJlcywg
d2UgaGF2ZSB0b28gbWFueSBvbmVzIHdpdGggdG9vIG1hbnkNCj4+Pj4gZmllbGRzIGFscmVhZHku
IEZvciB1c2VyIHNwYWNlLCB0aG91Z2gsIG9uZSBtYXkgdXNlIHVuaW9ucyBhbmQgZmxhZ3MsIGJ1
dCBmb3INCj4+Pj4gaW50ZXJuYWwgb25lcyBpdCBtaWdodCBiZSBiZXR0ZXIgd2F5cywgSSB0aGlu
ay4NCj4+Pg0KPj4+IEhvdyBhYm91dCByZXZpc2luZyB0aGUgbmFtZSBvZiAnVElPQ1NSUzQ4NScg
YW5kICdzZXJpYWxfcnM0ODUnIHRvIGENCj4+PiBnZW5lcmFsIG9uZSwgYW5kIHB1dCBSUzQyMiBh
bmQgUlM0ODUgY29uZmlndXJhdGlvbiBmbGFncyBpbnRvIHRoYXQNCj4+PiBzdHJ1Y3R1cmU/DQo+
Pj4NCj4+PiBTbyB0aGF0IGluIHVzZXJzcGFjZSBpdCBjb3VsZCBzZXQgUlM0MjIgb3IgUlM0ODUg
Y29uZmlndXJhdGlvbnMgdXNpbmcgYQ0KPj4+IHNpbmdsZSBpb2N0bCBjb21tYW5kIGFuZCBvbmUg
c3RydWN0dXJlLg0KPj4+DQo+Pj4gSW4gdGhpcyB3YXksIGl0IHdvbid0IGJlIGNvbmZ1c2VkIGlu
IHVzZXJzcGFjZSBhbmQgd29uJ3QgYWRkIG5ldyBkYXRhDQo+Pj4gc3RydWN0dXJlIGludGVybmFs
bHkgYXMgd2VsbC4NCj4+Pg0KPj4NCj4+IEkgd2lsbCBzdW1tYXJpemUgdGhlIGN1cnJlbnQgc2l0
dWF0aW9uIGZyb20gbXkgcG9pbnQgb2YgdmlldywgbWF5YmUgaXQgaGVscHM6DQo+Pg0KPj4gUlMt
MjMyOg0KPj4gICAtIEZ1bGwgRHVwbGV4IFBvaW50LXRvLVBvaW50IGNvbm5lY3Rpb24NCj4+ICAg
LSBObyB0cmFuc2NlaXZlciBjb250cm9sIHdpdGggUlRTDQo+PiAgIC0gTm8gdGVybWluYXRpb24N
Cj4+ICAgLSBObyBleHRyYSBzdHJ1Y3QgaW4gdXNlDQo+Pg0KPj4gUlMtNDIyOg0KPj4gICAtIEZ1
bGwgRHVwbGV4IFBvaW50LXRvLVBvaW50IGNvbm5lY3Rpb24NCj4+ICAgLSBObyB0cmFuc2NlaXZl
ciBjb250cm9sIHdpdGggUlRTIG5lZWRlZA0KPj4gICAtIFRlcm1pbmF0aW9uIHBvc3NpYmxlDQo+
PiAgIC0gRXh0cmEgc3RydWN0IHNlcmlhbF9yczQ4NSBuZWVkZWQgaWYgdGVybWluYXRpb24gaXMg
dXNlZA0KPj4gID0+IFJTLTQyMiBjYW4gYmUgdXNlZCBpbiBSUy0yMzIgb3BlcmF0aW9uLCBidXQg
aWYgYSB0ZXJtaW5hdGlvbiBzaG91bGQgYmUNCj4+ICAgICBzd2l0Y2hhYmxlIHRoZSBSUzQ4NSBm
bGFnIGhhcyB0byBiZSBlbmFibGVkLiBCdXQgdGhlbiBhbHNvIHRyYW5zY2VpdmVyDQo+PiAgICAg
Y29udHJvbCB3aWxsIGJlIGVuYWJsZWQuIE5vdCBhIHZlcnkgc2F0aXNmeWluZyBzaXR1YXRpb24u
DQo+Pg0KPiANCj4gVGhhdHMgd2h5IEkgdm90ZSBmb3IgYSAgUlM0MjIgbW9kZS4NCj4gDQo+PiBS
Uy00ODUgKDItd2lyZSkgdmVyeSBjb21tb246DQo+PiAgIC0gSGFsZiBEdXBsZXggUlMtNDg1IGJ1
cw0KPj4gICAtIFRyYW5zY2VpdmVyIGNvbnRyb2wgd2l0aCBSVFMgaXMgbmVlZGVkDQo+PiAgIC0g
VGVybWluYXRpb24gcG9zc2libGUNCj4+ICAgLSBFeHRyYSBzdHJ1Y3Qgc2VyaWFsX3JzNDg1IGlz
IG5lZWRlZA0KPj4gID0+IFJTLTQ4NSBoYXMgdG8gYmUgZW5hYmxlZCBhbmQgY29uZmlndXJlZDoN
Cj4+ICAgICAtIFNldCBTRVJfUlM0ODVfRU5BQkxFRA0KPj4gICAgIC0gU2V0IFNFUl9SUzQ4NV9S
VFNfT05fU0VORCBvciBTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQNCj4+ICAgICAtIFNldC9jbGVh
ciBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYIGRlcGVuZGluZyBvbiB3aGV0aGVyDQo+PiAgICAgICB0
aGUgcmVjZWl2ZXIgcGF0aCBzaG91bGQgYmUgb24gb3Igb2ZmIGR1cmluZyBzZW5kaW5nLg0KPj4g
ICAgICAgSWYgaXQncyBzZXQgaXQgYWxsb3dzIHRvIG1vbml0b3IgdGhlIHNlbmRpbmcgb24gdGhl
IGJ1cw0KPj4gICAgICAgYW5kIGRldGVjdCB3aGV0aGVyIGFub3RoZXIgYnVzIGRldmljZSBpcyB0
cmFuc21pdHRpbmcNCj4+ICAgICAgIGF0IHRoZSBzYW1lIHRpbWUuDQo+PiAgICAgLSBTZXQvY2xl
YXIgU0VSX1JTNDg1X1RFUk1JTkFURV9CVVMgZm9yIGJ1cyB0ZXJtaW5hdGlvbi4NCj4+DQo+PiBS
Uy00ODUgKDQtd2lyZSkgbGl0dGxlIHVzZWQ6DQo+PiAgIC0gRnVsbCBEdXBsZXggUlMtNDg1IGJ1
cw0KPj4gICAtIFRyYW5zY2VpdmVyIGNvbnRyb2wgd2l0aCBSVFMgaXMgbmVlZGVkDQo+PiAgIC0g
VGVybWluYXRpb24gcG9zc2libGUNCj4+ICAgLSBFeHRyYSBzdHJ1Y3Qgc2VyaWFsX3JzNDg1IGlz
IG5lZWRlZA0KPj4gID0+IFJTLTQ4NSBoYXMgdG8gYmUgZW5hYmxlZCBhbmQgY29uZmlndXJlZDoN
Cj4+ICAgICAtIFNldCBTRVJfUlM0ODVfRU5BQkxFRA0KPj4gICAgIC0gU2V0IFNFUl9SUzQ4NV9S
VFNfT05fU0VORCBvciBTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQNCj4+ICAgICAtIFNldCBTRVJf
UlM0ODVfUlhfRFVSSU5HX1RYLCBhcyB0aGUgcmVjZWl2ZXIgc2hvdWxkIGFsd2F5cw0KPj4gICAg
ICAgYmUgZW5hYmxlZCBpbmRlcGVuZGVudGx5IG9mIFRYLCBiZWNhdXNlIFRYIGFuZCBSWCBhcmUN
Cj4+ICAgICAgIHNlcGFyYXRlZCBmcm9tIGVhY2ggb3RoZXIgYnkgdGhlaXIgb3duIHdpcmVzLg0K
Pj4gICAgIC0gU2V0L2NsZWFyIFNFUl9SUzQ4NV9URVJNSU5BVEVfQlVTIGZvciBidXMgdGVybWlu
YXRpb24uDQo+IA0KPiBIb3cgY2FuIHRoZSBkcml2ZXIgZGlzdGluZ3Vpc2ggYmV0d2VlbiBSUzQ4
NSBmdWxsIGR1cGxleCBhbmQgaGFsZiBkdXBsZXggdGhlbj8NCj4gSW4gZnVsbCBkdXBsZXggUlRT
IGNvbnRyb2wgaXMgbm90IG5lZWRlZCBBRkFJVS4NCg0KSSB0aGluayB3ZSBkb24ndCBuZWVkIHRv
IGRpc3Rpbmd1aXNoLCBiZWNhdXNlIGZvciBhIGZ1bGwgZHVwbGV4IFJTLTQ4NQ0KdHJhbnNjZWl2
ZXIgYWxzbyBuZWVkcyBSVFMgY29udHJvbC4gRm9yIGV4YW1wbGUgbG9vayBhdCB0aGUgZnVsbCBk
dXBsZXgNClJTLTQ4NSB0cmFuc2NlaXZlciBBRE0zNDkxRSBbMV0uIEl0J3MgYSBmdWxsIGR1cGxl
eCB0cmFuc2NlaXZlciAoQS9CIGFuZCBaL1kpDQp0aGF0IGhhcyBERSAoRHJpdmVyIGVuYWJsZSkg
YW5kIERJIChEcml2ZXIgSW5wdXQpIHBpbnMgZm9yIGNvbnRyb2xsaW5nIFRYLiBJDQp0aGluayB0
aGUgUlMtNDg1IG1hc3RlciBkb2Vzbid0IG5lZWQgaXQuIFRoZSBERSBwaW4gY291bGQgYWxzbyBi
ZSBzZXQNCnBlcm1hbmVudGx5IGhpZ2guIEJ1dCBpZiB3ZSBoYXZlIG1vcmUgdGhhbiBvbmUgUlMt
NDg1IHNsYXZlcyBpdCdzIG5lZWRlZCB0bw0KYXZvaWQgYmxvY2tpbmcgb2YgZWFjaCBvdGhlciBv
biB0aGUgcmVjZWl2aW5nIHdpcmVzIG9mIHRoZSBSUy00ODUgbWFzdGVyLg0KDQpbMV0gaHR0cHM6
Ly93d3cuYW5hbG9nLmNvbS9lbi9wcm9kdWN0cy9hZG0zNDkxZS5odG1sDQoNCj4+IEkgdGhpbmsg
dGhlIEdQSU9zIHJlZmxlY3QgdGhlIGZsYWcgc3RhdGVzIGFuZCBhcmUgbWVhbmluZ2Z1bDoNCj4+
IC0gU0VSX1JTNDg1X1RFUk1JTkFURV9CVVM6IFN3aXRjaCBidXMgdGVybWluYXRpb24gb24vb2Zm
IGJ5IEdQSU8NCj4+IC0gU0VSX1JTNDg1X1JYX0RVUklOR19UWDogIFVzZWQgdG8gZW5hYmxlL2Rp
c2FibGUgUlggZHVyaW5nIFRYDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbiBoYXJk
d2FyZSBieSBHUElPIChmb3IgMi13aXJlKQ0KPj4gLSBTRVJfUlM0ODVfRU5BQkxFRDogICAgICAg
TXV4aW5nIGJldHdlZW4gUlMtMjMyIGFuZCBSUy00ODUgYnkgR1BJTw0KPj4NCj4+IFN3aXRjaGlu
ZyBSUy00ODUgb24gZHVyaW5nIGJvb3QgY291bGQgYWxzbyBiZSBoYW5kbGVkIGJ5IGEgZGV2aWNl
dHJlZQ0KPj4gb3ZlcmxheS4gRXZhbHVhdGUgdGhlIEdQSU8gYW5kIGxvYWQgYSBEVE8gYWNjb3Jk
aW5nbHkgYmVmb3JlIGJvb3RpbmcuDQo+Pg0KPj4gUGxlYXNlIGNvcnJlY3QgbWUgaWYgSSBoYXZl
IG1pc3JlcHJlc2VudGVkIHNvbWV0aGluZy4uLg0KPj4NCj4+IElmIEkgbG9va2VkIGF0IGl0IGlu
IHRoaXMgbmV3IHdheSwgSSB3b3VsZCBkaXNjYXJkIG15IGlkZWEgd2l0aCB0aGUNCj4+IEZVTExf
RFVQTEVYIGFuZCBIQUxGX0RVUExFWC4gRm9yIGEgYmV0dGVyIHVzZSBvZiBSUy00MjIgaXQgd291
bGQgYmUNCj4+IGdvb2QgdG8gZGlzYWJsZSB0cmFuc2NlaXZlciBjb250cm9sIHZpYSBSVFMuIEl0
IGNhbiBiZSBkb25lIGJ5IGNsZWFyaW5nDQo+PiB0aGUgZXhpc3RpbmcgZmxhZ3MgU0VSX1JTNDg1
X1JUU19PTl9TRU5EIGFuZCBTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQNCj4+IGF0IHRoZSBzYW1l
IHRpbWUsIGJ1dCBJIHRoaW5rIGl0IGlzIGNvbmZ1c2luZy4gQmV0dGVyIHdvdWxkIGJlIGEgZmxh
Zw0KPj4gZm9yIFJTLTQyMjoNCj4+DQo+PiBSUy00MjI6ICAgICAgICAgICAgICAgICAgICAgU2V0
IFNFUl9SUzQyMl9NT0RFIGZvciBkaXNhYmxpbmcNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB0cmFuc2NlaXZlciBjb250cm9sIHZpYSBSVFMuDQo+PiBSUy00ODUgKDItd2lyZSBhbmQg
NC13aXJlKTogQ2xlYXIgU0VSX1JTNDIyX01PREUgZm9yIGVuYWJsaW5nDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdHJhbnNjZWl2ZXIgY29udHJvbCB2aWEgUlRTLg0KPj4NCj4+IEZp
bmFsbHksIGF0IHByZXNlbnQgaXQgaXMgYWxzbyBub3QgcG9zc2libGUgdG8gZGlzdGluZ3Vpc2gg
YmV0d2VlbiBSUzQ4NQ0KPj4gMi13aXJlIGFuZCA0LXdpcmUgb3BlcmF0aW9uLiBJIHRoaW5rIGl0
IGlzbid0IG5lY2Vzc2FyeSwgYXMgZGlmZmVyZW50DQo+PiBoYXJkd2FyZSBoYXMgdG8gYmUgdXNl
ZCBhbnl3YXkuIFRoZSBoYXJkd2FyZSB0aGVuIGRldGVybWluZXMgdGhlDQo+PiBjb25maWd1cmF0
aW9uLCBzZWUgYWJvdmUuDQo+IA0KPiBCdXQgdGhlIGRyaXZlciBzaG91bGQgc29tZWhvdyBiZSBp
bmZvcm1lZCB0aGF0IHRoZXJlIGV4aXN0cyBhIGZ1bGwNCj4gZHVwbGV4IGhhcmR3YXJlIHNldHVw
LCBzbyB0aGF0IGl0IGRvZXMgbm90IG5lZWQgdG8gY29udHJvbCB0aGUgUlRTIGxpbmUuDQo+IE1h
eWJlIGJ5IG1lYW5zIG9mIGEgZGV2aWNlIHRyZWUgcHJvcGVydHk/DQoNClNlZSBhYm92ZS4NCg0K
UmVnYXJkcw0KQ2hyaXN0b3BoDQo=
