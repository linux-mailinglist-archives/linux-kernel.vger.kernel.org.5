Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED567F88AB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 07:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjKYGqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 01:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYGqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 01:46:03 -0500
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2329DC1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 22:46:08 -0800 (PST)
Received: from w013.hihonor.com (unknown [10.68.26.19])
        by mta20.hihonor.com (SkyGuard) with ESMTPS id 4Scj6044vQzYmQ2N;
        Sat, 25 Nov 2023 14:45:28 +0800 (CST)
Received: from a002.hihonor.com (10.68.31.193) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Sat, 25 Nov
 2023 14:46:05 +0800
Received: from a007.hihonor.com (10.68.22.31) by a002.hihonor.com
 (10.68.31.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Sat, 25 Nov
 2023 14:46:04 +0800
Received: from a007.hihonor.com ([fe80::ccdd:b4b:ae86:edd4]) by
 a007.hihonor.com ([fe80::ccdd:b4b:ae86:edd4%10]) with mapi id 15.02.1258.025;
 Sat, 25 Nov 2023 14:46:04 +0800
From:   gaoxu <gaoxu2@hihonor.com>
To:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        yipengxiang <yipengxiang@hihonor.com>
Subject: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIXSBtbSxvb21fcmVhcGVyOiBhdm9pZCBydW4g?=
 =?gb2312?B?cXVldWVfb29tX3JlYXBlciBpZiB0YXNrIGlzIG5vdCBvb20=?=
Thread-Topic: =?gb2312?B?u9i4tDogW1BBVENIXSBtbSxvb21fcmVhcGVyOiBhdm9pZCBydW4gcXVldWVf?=
 =?gb2312?Q?oom=5Freaper_if_task_is_not_oom?=
Thread-Index: AdodQUgb0N3ZJU2TSUK/4IicgpocdQAZdvMAADdSyGD//+LRAP/+FajQ
Date:   Sat, 25 Nov 2023 06:46:04 +0000
Message-ID: <1d84bf0d1aed45bbbc5941483d8e1695@hihonor.com>
References: <400d13bddb524ef6af37cb2220808c75@hihonor.com>
 <ZV8SenfRYnkKwqu6@tiehlicka> <242025e9a8c84f6b96ba3f180ea01be9@hihonor.com>
 <ZWBtRGCXbz49UeXa@tiehlicka>
In-Reply-To: <ZWBtRGCXbz49UeXa@tiehlicka>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.164.11.140]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyNCBOb3YgMjAyMyAwOTozMSAgTWljaGFsIEhvY2tvIHdyb3RlOg0KPk9uIEZyaSAy
NC0xMS0yMyAwMzoxNTo0NiwgZ2FveHUgd3JvdGU6DQo+Wy4uLl0NCj4+ID4+IFszNzAxOjExX3Nl
ZV1VbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgDQo+
PiA+PiB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAwMDAwMDMyOCBbMzcwMToxMV9zZWVddXNlciBw
Z3RhYmxlOiA0ayANCj4+ID4+IHBhZ2VzLCAzOS1iaXQgVkFzLCBwZ2RwPTAwMDAwMDAwODIxZGUw
MDAgDQo+PiA+PiBbMzcwMToxMV9zZWVdWzAwMDAwMDAwMDAwMDAzMjhdIHBnZD0wMDAwMDAwMDAw
MDAwMDAwLA0KPj4gPj4gcDRkPTAwMDAwMDAwMDAwMDAwMDAscHVkPTAwMDAwMDAwMDAwMDAwMDAN
Cj4+ID4+IFszNzAxOjExX3NlZV10cmFjaW5nIG9mZg0KPj4gPj4gWzM3MDE6MTFfc2VlXUludGVy
bmFsIGVycm9yOiBPb3BzOiA5NjAwMDAwNSBbIzFdIFBSRUVNUFQgU01QIA0KPj4gPj4gWzM3MDE6
MTFfc2VlXUNhbGwgdHJhY2U6DQo+PiA+PiBbMzcwMToxMV9zZWVdIHF1ZXVlX29vbV9yZWFwZXIr
MHgzMC8weDE3MA0KPj4gPg0KPj4gPiBDb3VsZCB5b3UgcmVzb2x2ZSB0aGlzIG9mZnNldCBpbnRv
IHRoZSBjb2RlIGxpbmUgcGxlYXNlPw0KPj4gRHVlIHRvIHRoZSBhZGRpdGlvbmFsIGNvZGUgd2Ug
YWRkZWQgZm9yIGxvZyBwdXJwb3NlcywgdGhlIGxpbmUgbnVtYmVycyBtYXkgbm90IGNvcnJlc3Bv
bmQgdG8gdGhlIG9yaWdpbmFsIExpbnV4IGNvZGUuDQo+PiANCj4+IHN0YXRpYyB2b2lkIHF1ZXVl
X29vbV9yZWFwZXIoc3RydWN0IHRhc2tfc3RydWN0ICp0c2spIHsNCj4+IAkvKiBtbSBpcyBhbHJl
YWR5IHF1ZXVlZD8gKi8NCj4+IAlpZiAodGVzdF9hbmRfc2V0X2JpdChNTUZfT09NX1JFQVBfUVVF
VUVELCAmdHNrLT5zaWduYWwtPm9vbV9tbS0+ZmxhZ3MpKSAvL2EgbnVsbCBwb2ludGVyIGV4Y2Vw
dGlvbiBvY2N1cnJlZA0KPj4gCQlyZXR1cm47DQo+DQo+RGlkIHlvdSBtYW5hZ2UgdG8gbmFycm93
IGl0IGRvd24gdG8gd2hpY2ggb2YgdGhlIGRlcmVmZXJlbmNlIHRoaXMgY29ycmVzcG9uZHMgdG8/
IElzIGl0IHRzay0+c2lnbmFsID09IE5VTEwgb3Igc2lnbmFsLT5vb21fbW0gPT0gTlVMTC4NCj5U
aGUgZmF1bHRpbmcgYWRkcmVzcyBkb2Vzbid0IG1hdGNoIG5laXRoZXIgd2l0aCBteSBjb25maWdz
Lg0KDQpbLi4uXQ0KDQo+PiA+PiAtLS0gYS9tbS9vb21fa2lsbC5jDQo+PiA+PiArKysgYi9tbS9v
b21fa2lsbC5jDQo+PiA+PiBAQCAtOTg0LDcgKzk4NCw3IEBAIHN0YXRpYyB2b2lkIF9fb29tX2tp
bGxfcHJvY2VzcyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnZpY3RpbSwgY29uc3QgY2hhciAqbWVzc2Fn
ZSkNCj4+ID4+ICAJfQ0KPj4gPj4gIAlyY3VfcmVhZF91bmxvY2soKTsNCj4+ID4+ICANCj4+ID4+
IC0JaWYgKGNhbl9vb21fcmVhcCkNCj4+ID4+ICsJaWYgKGNhbl9vb21fcmVhcCAmJiB0c2tfaXNf
b29tX3ZpY3RpbSh2aWN0aW0pKQ0KPj4gPj4gIAkJcXVldWVfb29tX3JlYXBlcih2aWN0aW0pOw0K
Pj4gPg0KPj4gPiBJIGRvIG5vdCB1bmRlcnN0YW5kLiBXZSBhbHdheXMgZG8gc2VuZCBTSUdLSUxM
IGFuZCBjYWxsIG1hcmtfb29tX3ZpY3RpbSh2aWN0aW0pOyBvbiB2aWN0aW0gdGFzayB3aGVuIHJl
YWNoaW5nIG91dCBoZXJlLiBIb3cgY2FuIHRza19pc19vb21fdmljdGltIGNhbiBldmVyIGJlIGZh
bHNlPw0KPj4gVGhpcyBpcyBhIGxvdy1wcm9iYWJpbGl0eSBpc3N1ZSwgYXMgaXQgb25seSBvY2N1
cnJlZCBvbmNlIGR1cmluZyB0aGUgbW9ua2V5IHRlc3RpbmcuDQo+PiBJIGhhdmVuJ3QgYmVlbiBh
YmxlIHRvIGZpbmQgdGhlIHJvb3QgY2F1c2UgZWl0aGVyLg0KPg0KPk9LLCB3YXMgdGhlcmUgYW55
IG5vbi1zdGFuZGFyZCBjb2RlIHJ1bm5pbmcgZHVyaW5nIHRoaXMgdGVzdD8NCj5JbiBhbnkgY2Fz
ZSBJIGRvIG5vdCBzZWUgaG93IHRoaXMgcGF0Y2ggY291bGQgYmUgY29ycmVjdC4gSWYsIGZvciBz
b21lIHJlYXNvbiB3ZSBtYW5hZ2VkIHRvIHJlbGVhc2UgdGhlIHNpZ25hbCBzdHJ1Y3R1cmUgb3Ig
c29tZXRoaW5nIGVsc2UgdGhlbiB3ZSBuZWVkIHRvIHVuZGVyc3RhbmQgd2hldGhlciB0aGlzIGlz
IGEgbG9ja2luZyBvciByZWZlcmVuY2UgY291bnRpbmcgaXNzdWUuIEkgZG8gbm90IHJlYWxseSBz
ZWUgaG93IHRoaXMgd291bGQgYmUgcG9zc2libGUuIEJ1dCB0aGlzIGNoZWNrIHJpZ2h0IGhlcmUg
ZG9lc24ndCByZWFsbHkgbWFrZSBzZW5zZS4NCg0KdGhlcmUgd2FzIG5vIGFueSBub24tc3RhbmRh
cmQgY29kZSBydW5uaW5nIGR1cmluZyB0aGlzIHRlc3QuDQpUaGUgY2F1c2Ugb2YgdGhlIE9PTSBl
cnJvciBpcyB0aGUgcHJvY2VzcyBzdXJmYWNlZmxpbmdlciBoYXMgZW5jb3VudGVyZWQgZG1hLWJ1
ZiBtZW1vcnkgbGVhay4NClRoaXMgcHJvYmxlbSBpcyBsaWtlbHkgY2F1c2VkIGJ5IGNvbmN1cnJl
bmN5LiBJIHdpbGwgdHJ5IHRvIGNyZWF0ZSBhIGNvbmN1cnJlbnQgc2NlbmFyaW8gb2Ygb29tIG9y
IGtpbGwgcHJvY2VzcyB0byByZXByb2R1Y2UgdGhlIGlzc3VlLA0KYW5kIGlmIGRpc2NvdmVyIGFu
eXRoaW5nLCBJIHdpbGwgc2VuZCBpdCBoZXJlLg0KVGhhbmsgeW91LCBNaWNoYWwgYW5kIEFuZHJl
dywgZm9yIGFuYWx5emluZyBhbmQgZGlzY3Vzc2luZyB0aGUgaXNzdWUuDQoNCj5BbmRyZXcgcGxl
YXNlIGRyb3AgdGhlIHBhdGNoIGZyb20geW91ciB0cmVlLg0KDQo=
