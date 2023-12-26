Return-Path: <linux-kernel+bounces-11503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1687D81E75D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BB81C21EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887694E63B;
	Tue, 26 Dec 2023 12:22:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F914E611;
	Tue, 26 Dec 2023 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Szv4h5Tm1z1R6Hw;
	Tue, 26 Dec 2023 20:20:52 +0800 (CST)
Received: from kwepemi500024.china.huawei.com (unknown [7.221.188.100])
	by mail.maildlp.com (Postfix) with ESMTPS id F10C21402DE;
	Tue, 26 Dec 2023 20:22:11 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 20:22:11 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.035;
 Tue, 26 Dec 2023 20:22:11 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: Markus Elfring <Markus.Elfring@web.de>, kernel test robot <lkp@intel.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	"Xuan Zhuo" <xuanzhuo@linux.alibaba.com>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
Subject: RE: [PATCH v2] crypto: virtio - Less function calls in
 __virtio_crypto_akcipher_do_req() after error detection
Thread-Topic: [PATCH v2] crypto: virtio - Less function calls in
 __virtio_crypto_akcipher_do_req() after error detection
Thread-Index: AQHaN+QUjZOxb6ORnEG4ZWEqtSGvn7C7fD+A
Date: Tue, 26 Dec 2023 12:22:11 +0000
Message-ID: <deb25ea00a57448d94496db1c46af693@huawei.com>
References: <2413f22f-f0c3-45e0-9f6b-a551bdf0f54c@web.de>
 <202312260852.0ge5O8IL-lkp@intel.com>
 <7bf9a4fa-1675-45a6-88dd-82549ae2c6e0@web.de>
In-Reply-To: <7bf9a4fa-1675-45a6-88dd-82549ae2c6e0@web.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFya3VzIEVsZnJpbmcg
W21haWx0bzpNYXJrdXMuRWxmcmluZ0B3ZWIuZGVdDQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVy
IDI2LCAyMDIzIDY6MTIgUE0NCj4gVG86IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29t
PjsgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1jcnlwdG9Admdlci5r
ZXJuZWwub3JnOyBrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3JnOyBEYXZpZCBTLiBNaWxs
ZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBHb25nbGVpIChBcmVpKSA8YXJlaS5nb25nbGVp
QGh1YXdlaS5jb20+OyBIZXJiZXJ0DQo+IFh1IDxoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU+
OyBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsNCj4gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT47IFh1YW4gWmh1bw0KPiA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+DQo+IENjOiBsbHZtQGxpc3RzLmxpbnV4LmRldjsgb2Uta2J1aWxkLWFsbEBsaXN0cy5saW51
eC5kZXY7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc+OyBjb2NjaUBpbnJpYS5mcg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjJdIGNyeXB0
bzogdmlydGlvIC0gTGVzcyBmdW5jdGlvbiBjYWxscyBpbg0KPiBfX3ZpcnRpb19jcnlwdG9fYWtj
aXBoZXJfZG9fcmVxKCkgYWZ0ZXIgZXJyb3IgZGV0ZWN0aW9uDQo+IA0KPiBGcm9tOiBNYXJrdXMg
RWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+DQo+IERhdGU6IFR1ZSwgMjYg
RGVjIDIwMjMgMTE6MDA6MjAgKzAxMDANCj4gDQo+IFRoZSBrZnJlZSgpIGZ1bmN0aW9uIHdhcyBj
YWxsZWQgaW4gdXAgdG8gdHdvIGNhc2VzIGJ5IHRoZQ0KPiBfX3ZpcnRpb19jcnlwdG9fYWtjaXBo
ZXJfZG9fcmVxKCkgZnVuY3Rpb24gZHVyaW5nIGVycm9yIGhhbmRsaW5nIGV2ZW4gaWYgdGhlDQo+
IHBhc3NlZCB2YXJpYWJsZSBjb250YWluZWQgYSBudWxsIHBvaW50ZXIuDQo+IFRoaXMgaXNzdWUg
d2FzIGRldGVjdGVkIGJ5IHVzaW5nIHRoZSBDb2NjaW5lbGxlIHNvZnR3YXJlLg0KPiANCj4gKiBB
ZGp1c3QganVtcCB0YXJnZXRzLg0KPiANCj4gKiBEZWxldGUgdHdvIGluaXRpYWxpc2F0aW9ucyB3
aGljaCBiZWNhbWUgdW5uZWNlc3NhcnkNCj4gICB3aXRoIHRoaXMgcmVmYWN0b3JpbmcuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgRWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3Jn
ZS5uZXQ+DQo+IC0tLQ0KPiANCj4gdjI6DQo+IEEgdHlwbyB3YXMgZml4ZWQgZm9yIHRoZSBkZWxp
bWl0ZXIgb2YgYSBsYWJlbC4NCj4gDQo+ICBkcml2ZXJzL2NyeXB0by92aXJ0aW8vdmlydGlvX2Ny
eXB0b19ha2NpcGhlcl9hbGdzLmMgfCAxMiArKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KDQpSZXZpZXdlZC1ieTogR29u
Z2xlaSA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+DQoNCg0KUmVnYXJkcywNCi1Hb25nbGVpDQo=

