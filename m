Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF4C8001BB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376837AbjLACop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjLACoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:44:44 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459CC9A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 18:44:50 -0800 (PST)
Received: from kwepemm000019.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ShHNW3f3QzNnd0;
        Fri,  1 Dec 2023 10:40:27 +0800 (CST)
Received: from kwepemm000018.china.huawei.com (7.193.23.4) by
 kwepemm000019.china.huawei.com (7.193.23.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 10:44:46 +0800
Received: from kwepemm000018.china.huawei.com ([7.193.23.4]) by
 kwepemm000018.china.huawei.com ([7.193.23.4]) with mapi id 15.01.2507.035;
 Fri, 1 Dec 2023 10:44:46 +0800
From:   zhuweixi <weixi.zhu@huawei.com>
To:     David Hildenbrand <david@redhat.com>,
        Dave Airlie <airlied@gmail.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "weixi.zhu@openeuler.sh" <weixi.zhu@openeuler.sh>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "mhairgrove@nvidia.com" <mhairgrove@nvidia.com>,
        "ziy@nvidia.com" <ziy@nvidia.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "Zeng, Oak" <oak.zeng@intel.com>
Subject: RE: [RFC PATCH 0/6] Supporting GMEM (generalized memory management)
 for external memory devices
Thread-Topic: [RFC PATCH 0/6] Supporting GMEM (generalized memory management)
 for external memory devices
Thread-Index: AQHaIfl9wrtrX0lryUy6fTQuS5BXZrCPLVeAgAEOlwCAALjigIABe6QAgAFK01A=
Date:   Fri, 1 Dec 2023 02:44:46 +0000
Message-ID: <f4ec70345800432caa94d662f49370f6@huawei.com>
References: <20231128125025.4449-1-weixi.zhu@huawei.com>
 <9308a79d-e312-4e6d-98fe-75dc6d0fbeda@amd.com>
 <CAPM=9tx-d-Au_bjX0vYxv6OwqiSjmbbMC7ebWpTsQgFNddWDuw@mail.gmail.com>
 <a07fd33c6f9e44418c528de06f89707e@huawei.com>
 <188814aa-4f55-40c6-961c-6105c89d76f3@redhat.com>
In-Reply-To: <188814aa-4f55-40c6-961c-6105c89d76f3@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.172]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzISBJIGFtIHBsYW5uaW5nIHRvIHByZXNlbnQgR01FTSBpbiBMaW51eCBNTSBBbGlnbm1l
bnQgU2Vzc2lvbnMgc28gSSBjYW4gY29sbGVjdCBtb3JlIGlucHV0IGZyb20gdGhlIG1tIGRldmVs
b3BlcnMuDQoNCkBDaHJpc3RpYW4gQE9hayBJIHdpbGwgYWxzbyBzZW5kIHlvdSBpbnZpdGF0aW9u
cyBvbmNlIGEgcHJlc2VudGF0aW9uIGlzIHNjaGVkdWxlZC4gOikNCg0KLVdlaXhpDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVk
aGF0LmNvbT4gDQpTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMzAsIDIwMjMgMTA6NTUgUE0NClRv
OiB6aHV3ZWl4aSA8d2VpeGkuemh1QGh1YXdlaS5jb20+OyBEYXZlIEFpcmxpZSA8YWlybGllZEBn
bWFpbC5jb20+OyBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQpD
YzogbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBha3Bt
QGxpbnV4LWZvdW5kYXRpb24ub3JnOyB3ZWl4aS56aHVAb3BlbmV1bGVyLnNoOyBtZ29ybWFuQHN1
c2UuZGU7IGpnbGlzc2VAcmVkaGF0LmNvbTsgcmNhbXBiZWxsQG52aWRpYS5jb207IGpodWJiYXJk
QG52aWRpYS5jb207IGFwb3BwbGVAbnZpZGlhLmNvbTsgbWhhaXJncm92ZUBudmlkaWEuY29tOyB6
aXlAbnZpZGlhLmNvbTsgYWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbTsgWGluaHVpLlBhbkBhbWQu
Y29tOyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRmVsaXguS3VlaGxpbmdAYW1kLmNv
bTsgb2dhYmJheUBrZXJuZWwub3JnOyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBq
Z2dAbnZpZGlhLmNvbTsgbGVvbnJvQG52aWRpYS5jb207IHpoZW55dXdAbGludXguaW50ZWwuY29t
OyB6aGkuYS53YW5nQGludGVsLmNvbTsgaW50ZWwtZ3Z0LWRldkBsaXN0cy5mcmVlZGVza3RvcC5v
cmc7IGludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGphbmkubmlrdWxhQGxpbnV4Lmlu
dGVsLmNvbTsgam9vbmFzLmxhaHRpbmVuQGxpbnV4LmludGVsLmNvbTsgcm9kcmlnby52aXZpQGlu
dGVsLmNvbTsgdHZydGtvLnVyc3VsaW5AbGludXguaW50ZWwuY29tDQpTdWJqZWN0OiBSZTogW1JG
QyBQQVRDSCAwLzZdIFN1cHBvcnRpbmcgR01FTSAoZ2VuZXJhbGl6ZWQgbWVtb3J5IG1hbmFnZW1l
bnQpIGZvciBleHRlcm5hbCBtZW1vcnkgZGV2aWNlcw0KDQpPbiAyOS4xMS4yMyAwOToyNywgemh1
d2VpeGkgd3JvdGU6DQo+IEdsYWQgdG8gaGVhciB0aGF0IG1vcmUgc2hhcmFibGUgY29kZSBpcyBk
ZXNpcmFibGUuDQo+IElNSE8sIGZvciBhIGNvbW1vbiBNTSBzdWJzeXN0ZW0sIGl0IGlzIG1vcmUg
YmVuZWZpY2lhbCBmb3IgR01FTSB0byANCj4gZXh0ZW5kIGNvcmUgTU0gaW5zdGVhZCBvZiBidWls
ZGluZyBhIHNlcGFyYXRlIG9uZS4NCg0KTW9yZSBjb3JlLW1tIGNvbXBsZXhpdHksIGF3ZXNvbWUs
IHdlIGFsbCBsb3ZlIHRoYXQhIDspDQoNCi0tDQpDaGVlcnMsDQoNCkRhdmlkIC8gZGhpbGRlbmIN
Cg0K
