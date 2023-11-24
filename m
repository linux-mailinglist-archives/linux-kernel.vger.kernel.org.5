Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623AD7F6AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 04:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjKXDPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 22:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXDPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 22:15:44 -0500
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D812D6F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 19:15:49 -0800 (PST)
Received: from w013.hihonor.com (unknown [10.68.26.19])
        by mta22.hihonor.com (SkyGuard) with ESMTPS id 4Sc0Tg4XnGzYkxhQ;
        Fri, 24 Nov 2023 11:15:03 +0800 (CST)
Received: from a002.hihonor.com (10.68.31.193) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Fri, 24 Nov
 2023 11:15:46 +0800
Received: from a007.hihonor.com (10.68.22.31) by a002.hihonor.com
 (10.68.31.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Fri, 24 Nov
 2023 11:15:46 +0800
Received: from a007.hihonor.com ([fe80::ccdd:b4b:ae86:edd4]) by
 a007.hihonor.com ([fe80::ccdd:b4b:ae86:edd4%10]) with mapi id 15.02.1258.025;
 Fri, 24 Nov 2023 11:15:46 +0800
From:   gaoxu <gaoxu2@hihonor.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        yipengxiang <yipengxiang@hihonor.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBtbSxvb21fcmVhcGVyOiBhdm9pZCBydW4gcXVldWVf?=
 =?gb2312?Q?oom=5Freaper_if_task_is_not_oom?=
Thread-Topic: [PATCH] mm,oom_reaper: avoid run queue_oom_reaper if task is not
 oom
Thread-Index: AdodQUgb0N3ZJU2TSUK/4IicgpocdQAZdvMAADdSyGA=
Date:   Fri, 24 Nov 2023 03:15:46 +0000
Message-ID: <242025e9a8c84f6b96ba3f180ea01be9@hihonor.com>
References: <400d13bddb524ef6af37cb2220808c75@hihonor.com>
 <ZV8SenfRYnkKwqu6@tiehlicka>
In-Reply-To: <ZV8SenfRYnkKwqu6@tiehlicka>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.164.11.140]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyNCBOb3YgMjAyMyAwODo1MSAgTWljaGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+
IHdyb3RlOg0KPiBPbiBXZWQgMjItMTEtMjMgMTI6NDY6NDQsIGdhb3h1IHdyb3RlOg0KPj4gVGhl
IGZ1bmN0aW9uIHF1ZXVlX29vbV9yZWFwZXIgdGVzdHMgYW5kIHNldHMgdHNrLT5zaWduYWwtPm9v
bV9tbS0+ZmxhZ3MuDQo+PiBIb3dldmVyLCBpdCBpcyBuZWNlc3NhcnkgdG8gY2hlY2sgaWYgJ3Rz
aycgaXMgYW4gT09NIHZpY3RpbSBiZWZvcmUgDQo+PiBleGVjdXRpbmcgJ3F1ZXVlX29vbV9yZWFw
ZXInIGJlY2F1c2UgdGhlIHZhcmlhYmxlIG1heSBiZSBOVUxMLg0KPj4gDQo+PiBXZSBlbmNvdW50
ZXJlZCBzdWNoIGFuIGlzc3VlLCBhbmQgdGhlIGxvZyBpcyBhcyBmb2xsb3dzOg0KPj4gWzM3MDE6
MTFfc2VlXU91dCBvZiBtZW1vcnk6IEtpbGxlZCBwcm9jZXNzIDMxNTQgKHN5c3RlbV9zZXJ2ZXIp
IA0KPj4gdG90YWwtdm06MjM2NjIwNDRrQiwgYW5vbi1yc3M6MGtCLCBmaWxlLXJzczowa0IsIHNo
bWVtLXJzczowa0IsDQo+PiBVSUQ6MTAwMCBwZ3RhYmxlczo0MDU2a0Igb29tX3Njb3JlX2Fkajot
OTAwDQo+DQo+PiBbMzcwMToxMV9zZWVdW1JCL0VdcmJfc3JlYXNvbl9zdHJfc2V0OiBzcmVhc29u
X3N0ciBzZXQgbnVsbF9wb2ludGVyDQo+PiBbMzcwMToxMV9zZWVdW1JCL0VdcmJfc3JlYXNvbl9z
dHJfc2V0OiBzcmVhc29uX3N0ciBzZXQgdW5rbm93bl9hZGRyDQo+DQo+IFdoYXQgYXJlIHRoZXNl
Pw0KVGhpcyBpcyBhIGxvZyBtZXNzYWdlIHRoYXQgd2UgYWRkZWQgb3Vyc2VsdmVzLg0KDQo+PiBb
MzcwMToxMV9zZWVdVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJl
bmNlIGF0IA0KPj4gdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAwMDAzMjggWzM3MDE6MTFfc2Vl
XXVzZXIgcGd0YWJsZTogNGsgcGFnZXMsIA0KPj4gMzktYml0IFZBcywgcGdkcD0wMDAwMDAwMDgy
MWRlMDAwIFszNzAxOjExX3NlZV1bMDAwMDAwMDAwMDAwMDMyOF0gDQo+PiBwZ2Q9MDAwMDAwMDAw
MDAwMDAwMCwNCj4+IHA0ZD0wMDAwMDAwMDAwMDAwMDAwLHB1ZD0wMDAwMDAwMDAwMDAwMDAwDQo+
PiBbMzcwMToxMV9zZWVddHJhY2luZyBvZmYNCj4+IFszNzAxOjExX3NlZV1JbnRlcm5hbCBlcnJv
cjogT29wczogOTYwMDAwMDUgWyMxXSBQUkVFTVBUIFNNUCANCj4+IFszNzAxOjExX3NlZV1DYWxs
IHRyYWNlOg0KPj4gWzM3MDE6MTFfc2VlXSBxdWV1ZV9vb21fcmVhcGVyKzB4MzAvMHgxNzANCj4N
Cj4gQ291bGQgeW91IHJlc29sdmUgdGhpcyBvZmZzZXQgaW50byB0aGUgY29kZSBsaW5lIHBsZWFz
ZT8NCkR1ZSB0byB0aGUgYWRkaXRpb25hbCBjb2RlIHdlIGFkZGVkIGZvciBsb2cgcHVycG9zZXMs
IHRoZSBsaW5lIG51bWJlcnMgbWF5IG5vdCBjb3JyZXNwb25kIHRvIHRoZSBvcmlnaW5hbCBMaW51
eCBjb2RlLg0KDQpzdGF0aWMgdm9pZCBxdWV1ZV9vb21fcmVhcGVyKHN0cnVjdCB0YXNrX3N0cnVj
dCAqdHNrKQ0Kew0KCS8qIG1tIGlzIGFscmVhZHkgcXVldWVkPyAqLw0KCWlmICh0ZXN0X2FuZF9z
ZXRfYml0KE1NRl9PT01fUkVBUF9RVUVVRUQsICZ0c2stPnNpZ25hbC0+b29tX21tLT5mbGFncykp
IC8vYSBudWxsIHBvaW50ZXIgZXhjZXB0aW9uIG9jY3VycmVkDQoJCXJldHVybjsNCi4uLg0KfQ0K
Pj4gWzM3MDE6MTFfc2VlXSBfX29vbV9raWxsX3Byb2Nlc3MrMHg1OTAvMHg4NjAgWzM3MDE6MTFf
c2VlXSANCj4+IG9vbV9raWxsX3Byb2Nlc3MrMHgxNDAvMHgyNzQgWzM3MDE6MTFfc2VlXSBvdXRf
b2ZfbWVtb3J5KzB4MmY0LzB4NTRjIA0KPj4gWzM3MDE6MTFfc2VlXSBfX2FsbG9jX3BhZ2VzX3Ns
b3dwYXRoKzB4NWQ4LzB4YWFjDQo+PiBbMzcwMToxMV9zZWVdIF9fYWxsb2NfcGFnZXMrMHg3NzQv
MHg4MDAgWzM3MDE6MTFfc2VlXSANCj4+IHdwX3BhZ2VfY29weSsweGM0LzB4MTE2YyBbMzcwMTox
MV9zZWVdIGRvX3dwX3BhZ2UrMHg0YmMvMHg2ZmMgDQo+PiBbMzcwMToxMV9zZWVdIGhhbmRsZV9w
dGVfZmF1bHQrMHg5OC8weDJhOCBbMzcwMToxMV9zZWVdIA0KPj4gX19oYW5kbGVfbW1fZmF1bHQr
MHgzNjgvMHg3MDAgWzM3MDE6MTFfc2VlXSANCj4+IGRvX2hhbmRsZV9tbV9mYXVsdCsweDE2MC8w
eDJjYyBbMzcwMToxMV9zZWVdIGRvX3BhZ2VfZmF1bHQrMHgzZTAvMHg4MTggDQo+PiBbMzcwMTox
MV9zZWVdIGRvX21lbV9hYm9ydCsweDY4LzB4MTdjIFszNzAxOjExX3NlZV0gZWwwX2RhKzB4M2Mv
MHhhMCANCj4+IFszNzAxOjExX3NlZV0gZWwwdF82NF9zeW5jX2hhbmRsZXIrMHhjNC8weGVjIFsz
NzAxOjExX3NlZV0gDQo+PiBlbDB0XzY0X3N5bmMrMHgxYjQvMHgxYjggWzM3MDE6MTFfc2VlXXRy
YWNpbmcgb2ZmDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEdhbyBYdSA8Z2FveHUyQGhpaG9ub3Iu
Y29tPg0KPj4gLS0tDQo+PiAgbW0vb29tX2tpbGwuYyB8IDIgKy0NCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL21t
L29vbV9raWxsLmMgYi9tbS9vb21fa2lsbC5jIGluZGV4IDllNjA3MWZkZS4uMzc1NGFiNGI2IA0K
Pj4gMTAwNjQ0DQo+PiAtLS0gYS9tbS9vb21fa2lsbC5jDQo+PiArKysgYi9tbS9vb21fa2lsbC5j
DQo+PiBAQCAtOTg0LDcgKzk4NCw3IEBAIHN0YXRpYyB2b2lkIF9fb29tX2tpbGxfcHJvY2Vzcyhz
dHJ1Y3QgdGFza19zdHJ1Y3QgKnZpY3RpbSwgY29uc3QgY2hhciAqbWVzc2FnZSkNCj4+ICAJfQ0K
Pj4gIAlyY3VfcmVhZF91bmxvY2soKTsNCj4+ICANCj4+IC0JaWYgKGNhbl9vb21fcmVhcCkNCj4+
ICsJaWYgKGNhbl9vb21fcmVhcCAmJiB0c2tfaXNfb29tX3ZpY3RpbSh2aWN0aW0pKQ0KPj4gIAkJ
cXVldWVfb29tX3JlYXBlcih2aWN0aW0pOw0KPg0KPiBJIGRvIG5vdCB1bmRlcnN0YW5kLiBXZSBh
bHdheXMgZG8gc2VuZCBTSUdLSUxMIGFuZCBjYWxsIG1hcmtfb29tX3ZpY3RpbSh2aWN0aW0pOyBv
biB2aWN0aW0gdGFzayB3aGVuIHJlYWNoaW5nIG91dCBoZXJlLiBIb3cgY2FuIHRza19pc19vb21f
dmljdGltIGNhbiBldmVyIGJlIGZhbHNlPw0KVGhpcyBpcyBhIGxvdy1wcm9iYWJpbGl0eSBpc3N1
ZSwgYXMgaXQgb25seSBvY2N1cnJlZCBvbmNlIGR1cmluZyB0aGUgbW9ua2V5IHRlc3RpbmcuDQpJ
IGhhdmVuJ3QgYmVlbiBhYmxlIHRvIGZpbmQgdGhlIHJvb3QgY2F1c2UgZWl0aGVyLg0KDQo+PiAg
DQo+PiAgCW1tZHJvcChtbSk7DQo+PiAtLQ0KPj4gMi4xNy4xDQo+PiANCj4+IA0KPg0KPi0tDQo+
IE1pY2hhbCBIb2Nrbw0KPiBTVVNFIExhYnMNCg==
