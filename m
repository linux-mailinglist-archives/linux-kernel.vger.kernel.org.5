Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0C5753BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjGNNeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbjGNNeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:34:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E975135A9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:34:01 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-81-ZP8DPh8MNd-v9zhHoSe8Pg-1; Fri, 14 Jul 2023 14:33:59 +0100
X-MC-Unique: ZP8DPh8MNd-v9zhHoSe8Pg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 14 Jul
 2023 14:33:57 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 14 Jul 2023 14:33:57 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>
Subject: RE: [PATCH] powercap: intel_rapl_tpmi: Fix a sparse warning
Thread-Topic: [PATCH] powercap: intel_rapl_tpmi: Fix a sparse warning
Thread-Index: AQHZtCOQbW983MhKOEiMpogSWUeue6+5RwXg
Date:   Fri, 14 Jul 2023 13:33:57 +0000
Message-ID: <a6d032df2b664950a63518c83a7db3f3@AcuMS.aculab.com>
References: <20230704050238.712223-1-rui.zhang@intel.com>
 <CAJZ5v0gZz1RCqp=Do0RTOCwPvWW9E_SQSyFjuRVuBkR9jxCJjw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gZz1RCqp=Do0RTOCwPvWW9E_SQSyFjuRVuBkR9jxCJjw@mail.gmail.com>
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

RnJvbTogUmFmYWVsIEouIFd5c29ja2kNCj4gU2VudDogMTEgSnVseSAyMDIzIDE5OjE0DQouLi4N
Cj4gT24gVHVlLCBKdWwgNCwgMjAyMyBhdCA3OjAy4oCvQU0gWmhhbmcgUnVpIDxydWkuemhhbmdA
aW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZpeCBhIHNwYXJzZSB3YXJuaW5nIGluIGludGVs
X3JhcGxfdHBtaSBkcml2ZXIuDQo+ID4NCj4gPiAuLi9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3Jh
cGxfdHBtaS5jOjE0MTo0MTogc3BhcnNlOiB3YXJuaW5nOiBpbmNvcnJlY3QgdHlwZSBpbiBpbml0
aWFsaXplcg0KPiAoZGlmZmVyZW50IGFkZHJlc3Mgc3BhY2VzKQ0KPiA+IC4uL2RyaXZlcnMvcG93
ZXJjYXAvaW50ZWxfcmFwbF90cG1pLmM6MTQxOjQxOiBzcGFyc2U6ICAgIGV4cGVjdGVkIHVuc2ln
bmVkIGxvbmcgbG9uZyBbdXNlcnR5cGVdDQo+ICp0cG1pX3JhcGxfcmVncw0KPiA+IC4uL2RyaXZl
cnMvcG93ZXJjYXAvaW50ZWxfcmFwbF90cG1pLmM6MTQxOjQxOiBzcGFyc2U6ICAgIGdvdCB2b2lk
IFtub2RlcmVmXSBfX2lvbWVtICoNCj4gPg0KPiA+IEZpeGVzOiA5ZWVmN2Y5ZGE5MjggKCJwb3dl
cmNhcDogaW50ZWxfcmFwbDogSW50cm9kdWNlIFJBUEwgVFBNSSBpbnRlcmZhY2UgZHJpdmVyIikN
Cj4gPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+ID4g
Q2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIwMjMwNzAzMTQw
NS5keTNkcnV1eS1sa3BAaW50ZWwuY29tLw0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW5nIFJ1aSA8
cnVpLnpoYW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wb3dlcmNhcC9pbnRl
bF9yYXBsX3RwbWkuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dlcmNhcC9p
bnRlbF9yYXBsX3RwbWkuYyBiL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF90cG1pLmMNCj4g
PiBpbmRleCA0ZjRmMTNkZWQyMjUuLjA1ZjY2NGEwOTZhYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfdHBtaS5jDQo+ID4gKysrIGIvZHJpdmVycy9wb3dlcmNh
cC9pbnRlbF9yYXBsX3RwbWkuYw0KPiA+IEBAIC0xMzgsNyArMTM4LDcgQEAgc3RhdGljIGludCBw
YXJzZV9vbmVfZG9tYWluKHN0cnVjdCB0cG1pX3JhcGxfcGFja2FnZSAqdHJwLCB1MzIgb2Zmc2V0
KQ0KPiA+ICAgICAgICAgZW51bSB0cG1pX3JhcGxfcmVnaXN0ZXIgcmVnX2luZGV4Ow0KPiA+ICAg
ICAgICAgZW51bSByYXBsX2RvbWFpbl9yZWdfaWQgcmVnX2lkOw0KPiA+ICAgICAgICAgaW50IHRw
bWlfZG9tYWluX3NpemUsIHRwbWlfZG9tYWluX2ZsYWdzOw0KPiA+IC0gICAgICAgdTY0ICp0cG1p
X3JhcGxfcmVncyA9IHRycC0+YmFzZSArIG9mZnNldDsNCj4gPiArICAgICAgIHU2NCAqdHBtaV9y
YXBsX3JlZ3MgPSAodTY0ICopKHRycC0+YmFzZSArIG9mZnNldCk7DQo+ID4gICAgICAgICB1NjQg
dHBtaV9kb21haW5faGVhZGVyID0gcmVhZHEoKHZvaWQgX19pb21lbSAqKXRwbWlfcmFwbF9yZWdz
KTsNCg0KSXNuJ3QgdGhlIGNvcnJlY3QgZml4IHRvIGFkZCBfX2lvbWVtIHRvIHRoZSBkZWZpbml0
aW9uIG9mDQp0cG1pX3JhcGlfcmVncyBhbmQgYWxzbyByZW1vdmUgdGhlIGNhc3QgZnJvbSB0aGUg
Zm9sbG93aW5nDQpyZWFkcSgpIGxpbmU/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

