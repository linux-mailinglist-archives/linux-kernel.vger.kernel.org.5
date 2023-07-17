Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0CB755F44
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGQJcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQJcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:32:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94BFDE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:31:57 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-135-apLXlhmXNzi0D1T5VLB85Q-1; Mon, 17 Jul 2023 10:31:55 +0100
X-MC-Unique: apLXlhmXNzi0D1T5VLB85Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jul
 2023 10:31:53 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 17 Jul 2023 10:31:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Zhang, Rui'" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>
Subject: RE: [PATCH] powercap: intel_rapl_tpmi: Fix a sparse warning
Thread-Topic: [PATCH] powercap: intel_rapl_tpmi: Fix a sparse warning
Thread-Index: AQHZrjTUbW983MhKOEiMpogSWUeue6+06qCAgARopICAABJWgIAEW8cAgAADsuA=
Date:   Mon, 17 Jul 2023 09:31:53 +0000
Message-ID: <34e5be4d97d04155be1a37c1fb100640@AcuMS.aculab.com>
References: <20230704050238.712223-1-rui.zhang@intel.com>
         <CAJZ5v0gZz1RCqp=Do0RTOCwPvWW9E_SQSyFjuRVuBkR9jxCJjw@mail.gmail.com>
         <a6d032df2b664950a63518c83a7db3f3@AcuMS.aculab.com>
         <CAJZ5v0hu2Gimbxv+RSQVRyLXOPSCNSzQDdneS8ig4zn63VkUKA@mail.gmail.com>
 <8eb14700c23828be1c0086ad004dfa1840926818.camel@intel.com>
In-Reply-To: <8eb14700c23828be1c0086ad004dfa1840926818.camel@intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWmhhbmcsIFJ1aQ0KPiBTZW50OiAxNyBKdWx5IDIwMjMgMTA6MTMNCj4gDQo+IEhpLCBE
YXZpZCwNCj4gDQo+IFRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQsIGFmdGVyIGRpZ2dpbmcg
aW50byB0aGUgcHJvYmxlbSBmdXJ0aGVyLA0KPiBJJ20gY29uZnVzZWQgYWJvdXQgaG93IHRvIGFk
ZHJlc3MgYWxsIHRoZSBzcGFyc2Ugd2FybmluZ3MuDQo+IA0KPiBJbiB0aGUgUkFQTCBmcmFtZXdv
cmssIHU2NCByZWdzW1JBUExfRE9NQUlOX01BWF1bUkFQTF9ET01BSU5fUkVHX01BWF0NCj4gaXMg
dXNlZCB0byBzYXZlIHRoZSBSQVBMIHJlZ2lzdGVyIGFkZHJlc3NlcywgYmVjYXVzZSB0aGUgcmVn
aXN0ZXIgY2FuDQo+IGVpdGhlciBiZSBhIE1NSU8gcmVnaXN0ZXIgb3IgTVNSLg0KPiANCj4gV2l0
aCBzcGFyc2UgZW5hYmxlZCwgdGhpcyBiZWNvbWVzIGEgcHJvYmxlbSBmb3IgTU1JTyByZWdpc3Rl
cnMgYmVjYXVzZQ0KPiB3ZSB3aWxsIGdldCBhIHdhcm5pbmcgYW55d2F5IHdoZW4gc2F2aW5nIGFu
IF9faW9tZW0gYWRkcmVzcyB0byB1NjQNCj4gcmVnc1tdW10sIHJpZ2h0Pw0KDQpUbyBhdm9pZCB0
aG9zZSBpc3N1ZXMgKHdoaWNoIHNlZW0gZGlmZmVyZW50IGZyb20gdGhlIG9uZSBoZXJlKQ0KeW91
IGNvdWxkIHVzZSBhIHVuaW9uIG9mIHRoZSBfX2lvbWVtIGFkZHJlc3MgYW5kIHRoZSBNU1IgbnVt
YmVyLg0KDQpUaGF0IG91Z2h0IHRvIGxldCB5b3UgcmVtb3ZlIGFsbCB0aGUgX19pb21lbSBjYXN0
cy4NCg0KCURhdmlkDQoNCj4gDQo+IFRoaXMgcHJvYmxlbSBpcyBub3QgbmV3LiBUaGUgc2FtZSB3
YXJuaW5nIGlzIGFsc28gdGhlcmUgd2hlbiBjb21waWxpbmcNCj4gZHJpdmVycy90aGVybWFsL2lu
dGVsL2ludDM0MHhfdGhlcm1hbC9wcm9jZXNzb3JfdGhlcm1hbF9yYXBsLmMsIHdoaWNoDQo+IGFs
c28gdXNlcyBNTUlPIFJBUEwgcmVnaXN0ZXIuDQo+IA0KPiBBbnkgaWRlYSBob3cgdG8gZml4IHRo
aXM/DQo+IA0KPiB0aGFua3MsDQo+IHJ1aQ0KPiANCj4gT24gRnJpLCAyMDIzLTA3LTE0IGF0IDE2
OjM5ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gPiBPbiBGcmksIEp1bCAxNCwg
MjAyMyBhdCAzOjM04oCvUE0gRGF2aWQgTGFpZ2h0DQo+ID4gPERhdmlkLkxhaWdodEBhY3VsYWIu
Y29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraQ0KPiA+ID4g
PiBTZW50OiAxMSBKdWx5IDIwMjMgMTk6MTQNCj4gPiA+IC4uLg0KPiA+ID4gPiBPbiBUdWUsIEp1
bCA0LCAyMDIzIGF0IDc6MDLigK9BTSBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQo+
ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gRml4IGEgc3BhcnNlIHdhcm5pbmcg
aW4gaW50ZWxfcmFwbF90cG1pIGRyaXZlci4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC4uL2RyaXZl
cnMvcG93ZXJjYXAvaW50ZWxfcmFwbF90cG1pLmM6MTQxOjQxOiBzcGFyc2U6IHdhcm5pbmc6DQo+
ID4gPiA+ID4gaW5jb3JyZWN0IHR5cGUgaW4gaW5pdGlhbGl6ZXINCj4gPiA+ID4gKGRpZmZlcmVu
dCBhZGRyZXNzIHNwYWNlcykNCj4gPiA+ID4gPiAuLi9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3Jh
cGxfdHBtaS5jOjE0MTo0MTogc3BhcnNlOg0KPiA+ID4gPiA+IGV4cGVjdGVkIHVuc2lnbmVkIGxv
bmcgbG9uZyBbdXNlcnR5cGVdDQo+ID4gPiA+ICp0cG1pX3JhcGxfcmVncw0KPiA+ID4gPiA+IC4u
L2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF90cG1pLmM6MTQxOjQxOiBzcGFyc2U6wqDCoMKg
IGdvdA0KPiA+ID4gPiA+IHZvaWQgW25vZGVyZWZdIF9faW9tZW0gKg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gRml4ZXM6IDllZWY3ZjlkYTkyOCAoInBvd2VyY2FwOiBpbnRlbF9yYXBsOiBJbnRyb2R1
Y2UgUkFQTCBUUE1JDQo+ID4gPiA+ID4gaW50ZXJmYWNlIGRyaXZlciIpDQo+ID4gPiA+ID4gUmVw
b3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiA+ID4gPiA+IENs
b3NlczoNCj4gPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIw
MjMwNzAzMTQwNS5keTNkcnV1eS1sa3BAaW50ZWwuY29tLw0KPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+
ID4gPiDCoGRyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF90cG1pLmMgfCAyICstDQo+ID4gPiA+
ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxf
dHBtaS5jDQo+ID4gPiA+ID4gYi9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfdHBtaS5jDQo+
ID4gPiA+ID4gaW5kZXggNGY0ZjEzZGVkMjI1Li4wNWY2NjRhMDk2YWIgMTAwNjQ0DQo+ID4gPiA+
ID4gLS0tIGEvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX3RwbWkuYw0KPiA+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF90cG1pLmMNCj4gPiA+ID4gPiBAQCAtMTM4
LDcgKzEzOCw3IEBAIHN0YXRpYyBpbnQgcGFyc2Vfb25lX2RvbWFpbihzdHJ1Y3QNCj4gPiA+ID4g
PiB0cG1pX3JhcGxfcGFja2FnZSAqdHJwLCB1MzIgb2Zmc2V0KQ0KPiA+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgIGVudW0gdHBtaV9yYXBsX3JlZ2lzdGVyIHJlZ19pbmRleDsNCj4gPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoCBlbnVtIHJhcGxfZG9tYWluX3JlZ19pZCByZWdfaWQ7DQo+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgwqAgaW50IHRwbWlfZG9tYWluX3NpemUsIHRwbWlfZG9tYWluX2ZsYWdzOw0KPiA+
ID4gPiA+IC3CoMKgwqDCoMKgwqAgdTY0ICp0cG1pX3JhcGxfcmVncyA9IHRycC0+YmFzZSArIG9m
ZnNldDsNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIHU2NCAqdHBtaV9yYXBsX3JlZ3MgPSAodTY0
ICopKHRycC0+YmFzZSArIG9mZnNldCk7DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgdTY0IHRw
bWlfZG9tYWluX2hlYWRlciA9IHJlYWRxKCh2b2lkIF9faW9tZW0NCj4gPiA+ID4gPiAqKXRwbWlf
cmFwbF9yZWdzKTsNCj4gPiA+DQo+ID4gPiBJc24ndCB0aGUgY29ycmVjdCBmaXggdG8gYWRkIF9f
aW9tZW0gdG8gdGhlIGRlZmluaXRpb24gb2YNCj4gPiA+IHRwbWlfcmFwaV9yZWdzIGFuZCBhbHNv
IHJlbW92ZSB0aGUgY2FzdCBmcm9tIHRoZSBmb2xsb3dpbmcNCj4gPiA+IHJlYWRxKCkgbGluZT8N
Cj4gPg0KPiA+IEdvb2QgcG9pbnQuDQo+ID4NCj4gPiBSdWksIGNhbiB5b3UgdGFrZSBhbm90aGVy
IGxvb2sgYXQgdGhpcywgcGxlYXNlPw0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

