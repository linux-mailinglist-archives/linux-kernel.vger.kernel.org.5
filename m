Return-Path: <linux-kernel+bounces-49049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDAD846548
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C35B21917
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB976130;
	Fri,  2 Feb 2024 01:09:17 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FFE5678;
	Fri,  2 Feb 2024 01:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706836157; cv=none; b=HOYZxRvzLY4w1G3UgRg0oO/8jMo5QKravOzSCWhJ19QUIDII1Tvu6CTx73XritMii77J1/EB7YChftPgBGKpbORUfFuwRfKq3Kj/quigrkNdeUe5HV0GP8w4NRfkUAe52dYTy79Jw7iYNQP9s15ulUJH93INjvyDp2U2MhRCN8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706836157; c=relaxed/simple;
	bh=2MMnCP8CJCwqGCW+J2bQ7c7qs3ug+y2ozOiY5gstMog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mF6E8AVmYYqIDwNMIISB2O3KjX5dvaahHus+6fDz2tKea7F5olO4DPWMJsbce564LWEyvHozSj4+xRdjnlQdlgcsIyVMOGn2DZVSw1r6vmdD3+edBMYSOjEgxoa1Y5FbWgEiBuM9rN+G4unzTS1IKEjkka7KUFE0fwUsRwAZTcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TQyMd1N0vz1vt2J;
	Fri,  2 Feb 2024 09:08:45 +0800 (CST)
Received: from kwepemd200003.china.huawei.com (unknown [7.221.188.150])
	by mail.maildlp.com (Postfix) with ESMTPS id ED3901A016B;
	Fri,  2 Feb 2024 09:09:10 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (7.185.36.136) by
 kwepemd200003.china.huawei.com (7.221.188.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 2 Feb 2024 09:09:10 +0800
Received: from dggpemm500008.china.huawei.com ([7.185.36.136]) by
 dggpemm500008.china.huawei.com ([7.185.36.136]) with mapi id 15.01.2507.035;
 Fri, 2 Feb 2024 09:09:10 +0800
From: wangyunjian <wangyunjian@huawei.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, xudingke
	<xudingke@huawei.com>
Subject: RE: [PATCH net-next] tun: Fix code style issues in <linux/if_vlan.h>
Thread-Topic: [PATCH net-next] tun: Fix code style issues in <linux/if_vlan.h>
Thread-Index: AQHaVRHPhW+sBdmp20ehAKJLTO4e/LD1GxqAgAEjetA=
Date: Fri, 2 Feb 2024 01:09:10 +0000
Message-ID: <e59177fbc48944479f0ea4c17fd1c532@huawei.com>
References: <1706793792-20928-1-git-send-email-wangyunjian@huawei.com>
 <65bbbc9776ea4_2226992949c@willemb.c.googlers.com.notmuch>
In-Reply-To: <65bbbc9776ea4_2226992949c@willemb.c.googlers.com.notmuch>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXaWxsZW0gZGUgQnJ1aWpuIFtt
YWlsdG86d2lsbGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbV0NCj4gU2VudDogVGh1cnNkYXks
IEZlYnJ1YXJ5IDEsIDIwMjQgMTE6NDUgUE0NCj4gVG86IHdhbmd5dW5qaWFuIDx3YW5neXVuamlh
bkBodWF3ZWkuY29tPjsNCj4gd2lsbGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbTsgamFzb3dh
bmdAcmVkaGF0LmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0DQo+
IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyB4dWRpbmdrZQ0KPiA8eHVkaW5na2VAaHVhd2VpLmNvbT47IHdhbmd5dW5qaWFuIDx3YW5neXVu
amlhbkBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0XSB0dW46IEZp
eCBjb2RlIHN0eWxlIGlzc3VlcyBpbiA8bGludXgvaWZfdmxhbi5oPg0KPiANCj4gWXVuamlhbiBX
YW5nIHdyb3RlOg0KPiA+IFRoaXMgZml4ZXMgdGhlIGZvbGxvd2luZyBjb2RlIHN0eWxlIHByb2Js
ZW06DQo+ID4gLSBXQVJOSU5HOiBwbGVhc2UsIG5vIHNwYWNlcyBhdCB0aGUgc3RhcnQgb2YgYSBs
aW5lDQo+ID4gLSBDSEVDSzogUGxlYXNlIHVzZSBhIGJsYW5rIGxpbmUgYWZ0ZXINCj4gPiAgICAg
ICAgICBmdW5jdGlvbi9zdHJ1Y3QvdW5pb24vZW51bSBkZWNsYXJhdGlvbnMNCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFl1bmppYW4gV2FuZyA8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT4NCj4gPiAt
LS0NCj4gPiAgaW5jbHVkZS9saW51eC9pZl90dW4uaCB8IDE2ICsrKysrKysrKysrKystLS0NCj4g
DQo+IFN1YmplY3Q6IHMvaWZfdmxhbi9pZl90dW4vDQpZZXAsIG15IGJhZCwgd2lsbCBzZW5kIHYy
IHdpdGggY29ycmVjdGlvbi4NClRoYW5rcw0K

