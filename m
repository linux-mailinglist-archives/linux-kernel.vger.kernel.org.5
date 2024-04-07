Return-Path: <linux-kernel+bounces-134616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8356A89B3B6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120FA1F21A11
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6C53E46D;
	Sun,  7 Apr 2024 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b="JtL9dKnn"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2122.outbound.protection.outlook.com [40.107.7.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7EEDDBD;
	Sun,  7 Apr 2024 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712516234; cv=fail; b=iHz9m+7qO46tMF8/H6zujX9KKmkLRPg3ww0eC7GBYJgfpZ+DEkmRcNvqa53ZphgcjZps25c/Owo78a5NcBEZZi12/D5KfAj/dm4pqYvhdovFG1le+uUGZgr/mflJa62UwAAUxRP0KYeHcgaWiIVFlH0GLB8Ma9WnPg1pSYgl8uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712516234; c=relaxed/simple;
	bh=vyFb664UD6a/TG3YQ5bCnkKYxpUMKXYWoprR090FuxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UePh0a2mRXwZxNLIbEHunIqVwH5tWBHF6gGXj/jq3aIIfLiREUPBU0Z7wu3ITowg7xitap8wr1MHO6pTGg8VOQZFCe4kLBXY95nYkRqI3qcJE9ayny8zfUrIRB75ZD4ol8xNxZwaxfjFQ79oOCebRko4F+3ObdV9jRk/NXMY/Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net; spf=pass smtp.mailfrom=surban.net; dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b=JtL9dKnn; arc=fail smtp.client-ip=40.107.7.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surban.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS7bSQFrSFf8So3PYR3XvN/oS/4gAHv1Zd2QRLD2u8cYhUTW2PMqjHQaqVTPfNwmFwpP2vV2eqHQdtxFp5wX9GU1T2Ff8p1MMV6FElbk+DLIa9N34CssgAhHckgzFNnF/i5TP9flYVr7To4wIn3pwYDNt2Nm16spym24mxQaERxpZ22ATHjLeKk9WrRtW3FHzplICTPtTOOW/vCln67ClzlnRtmCJhhevoGaEvrghQ5rk+KkcnrZ9pUYiBZ23gsyVDeTuBv6DIskAaQ6O8jHO8YFS9Zr2sTr/rZOF51xCHRFNf1AGh6z/CEgUbhlgOLh4lW4jj9Z2ecTbwFx3N+4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyFb664UD6a/TG3YQ5bCnkKYxpUMKXYWoprR090FuxM=;
 b=bI6vA7lcwkDNVWFjI+fXN7ymSP6NCAnPJsfaI7pkTRu0ctizbXinq3DgKHUmE0Rhpu/BY2YfvT3oliD9J5+ePSsW1dofD00FoPKCVL/U3cSDqmCZGWZFh6iLKVMHqLb4b9AMlP8ZnWrZ0N+WOHP0eKcLrAUbQoRYeqnf5r/nH31EcPm1DbQxr1p5buw0pguIgwzWoc83H+PIQol9ZRwfGV8FXCc7Wa3+PfmvAD4lvhAazFkiEo8y/rAy5XjcvLiJDCcNfFbqG5+p37phRu52olIdrxMYnWAa7Bh09jJvBWKz9YU56WfFkRZsdY8dAzuoVBm/B8OfMGw1GvXGIzFCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyFb664UD6a/TG3YQ5bCnkKYxpUMKXYWoprR090FuxM=;
 b=JtL9dKnnH4O0tpJxKSWgNixgwcFI2fY5qF/ieSK2CQDw+Brz4JKeOcSpbtGWwngRkTgyuK14ygkVHBhB0evlbQqVLXUED99u9UzkbjurKXoS9u58s62SoNQpW7DDPF4tfFx7kj7WuRFl13ao8u2vZ1yjOSxwPtnOIClv9n0M+Wg=
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:37d::18)
 by AS8P189MB1270.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:288::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Sun, 7 Apr
 2024 18:57:08 +0000
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1]) by DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1%3]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 18:57:08 +0000
From: Sebastian Urban <surban@surban.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: keep LE flow credits when recvbuf full
Thread-Topic: [PATCH v2] Bluetooth: keep LE flow credits when recvbuf full
Thread-Index: AQHah0PDXML8J70AVU2CTP9XKMvBk7FZzfGAgANeTYA=
Date: Sun, 7 Apr 2024 18:57:07 +0000
Message-ID: <73b930f2-02b9-42cc-9e77-aecfa6601387@surban.net>
References: <20240405093834.63666-1-surban@surban.net>
 <20240405102551.114999-1-surban@surban.net>
 <CABBYNZJfbgDoHr=ZBqf3Rckz7=34Lyq4RRyKbNfpi2qSO6PfqA@mail.gmail.com>
In-Reply-To:
 <CABBYNZJfbgDoHr=ZBqf3Rckz7=34Lyq4RRyKbNfpi2qSO6PfqA@mail.gmail.com>
Accept-Language: en-US, en-DE, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P189MB1978:EE_|AS8P189MB1270:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PiV8uPh83euFR3jD1ef9zJ+991MD7W9QXc+N5W+kfxpD3y0sRHxDh1KL6VRaxz3UquBd00Zl6Ehu6z//254bX3mFwlAkgOzTQ+GKJZXaMB4Tkl17e1K4tGMmt5uPIOl/lTtxBNb2ZvHPHULudwd3auftJvuBVNZUQbhVbeSCNgu6SLaaw3pgdKNOAy1nYlqwKpZ1putbwrdspa/964Tz4yecafaEzyVsXy1NuPF8vWYtW9nwitX4TMP7dH0P00lnuvJY48aesJ7VcXl9Wt0fNjh/mMBHxndjnwq/AmjpU74PZL7eICYPMrzKLvXPMJhDe6qpyCYR1pLGCQ8ox4BtCB1XGK1RSS163mBTeqvEtCGJCHLvZR2IYQAKqtgv80jDkgnoC/465lxi2oj37QS9AGy2Z73iUEfKQ6lwlkVh2mm9ofvNs5jmw0Smk6TGVxSEa7xPFYlH027QgZ4wn+b1ExpVW7CW3huu63S23xrQ7xpGwhOI9pBK8Ze+DkCu7Blvf1Tvjr77IGh69UVgnTh3+zz4g63rdBrVvA1OVW73L2zZpDN9bxEAyHhknh2p5xs3st/1y2aXiYXzWRhkEyZrfquvYlndIxeeL0m1p3AsZKa2gPlJvBsCsJikDi1S1F6pAW/q0ukP29EADkmO7yVTpD7nogbLUs6illemHsGz7m0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1978.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWdlTXczL0ZlNkMzOUJDVlZIZDZpa2pRQU5JcU5FUy9JeHl3MVE4YlVxSFRu?=
 =?utf-8?B?UitObHp0czF1RFFGRWcwQVNwdXJCdHZrT294RW51dmNoQ1lrS0hIU3ZYWDJh?=
 =?utf-8?B?azMxUW1Bc1dEdjZ3anhDVTNVWXQ5QWtrRW1renNYVVJ3U2ZzZWdNRDVhV2FC?=
 =?utf-8?B?cS9ScGhiSDJkQTUzVWRaUTJLSldDaTJSNkJBOWFBMGluZzBoUFdIWncxd1V3?=
 =?utf-8?B?L1RoNDJienhBRDAzMTFScjVxNDlLNUNLb3p3d1FEWmhCZXBUVGszSjlRaXdE?=
 =?utf-8?B?LzdkUGc4NVF3aUhNRVlleHp4a0Z2Zk1yNXk2V2k4NXdWeklzN1ZGdld4SWZO?=
 =?utf-8?B?d1NZYXpWSUt1NkxsbzNQV0l1ZVM3ZGFnQ2J3ZllqamRMeVBpQVZEbXd3U05x?=
 =?utf-8?B?K2pzVXJ4NjYra3Eyd3JjeTJkVW45Yzdjb3pxTjc2WEFTRlRlL0ZNekRvcjdo?=
 =?utf-8?B?UUdKMG1rOTIrVGk4aVJQaWUybTJ6c2M1dGpXQkI1ai9mZHN2aFU2Um01bHdW?=
 =?utf-8?B?bjlpWXRDM3RXdzZ0M3dQNHY0cllsVUJ1QVNqZmFMZEhnVGM2Q0tTTVcxdExQ?=
 =?utf-8?B?bFY4NUl1bS9MWkl4T1JaT2NBR0Z3OGIwOFY5dXF3WGd5eEhqa2JLY3NQOGhN?=
 =?utf-8?B?Z2ZJMHlUOFVwTVF1ck11ems4czRQbjVRQ3ljOEhmNWdTSUNaQ0J5SkluOE8w?=
 =?utf-8?B?aFJoN2RjVzA1VVdOU1ZsU3ZyOG1LRjNMbEIvVXdUSEd5ZFVVdkFQMEc4ZVcy?=
 =?utf-8?B?aEQ4UHF3OU4zd1lzZnozVEUrWERlMWZqTGFUc3dtb1F6YWdlT25RbVA4Y0g3?=
 =?utf-8?B?YTdDREZzb0xybm9LVDhHdXY1d2d3SGxlcVZyd0k2V25HMmxaSitRb21NUTJl?=
 =?utf-8?B?cmJYNnlCVGl1M2NoN1pjNFhYRmZkaTRzL3ZtU00zVW0rUWxXeFNEZUpxVE4y?=
 =?utf-8?B?Vm4xeU91eEd1WVlWemlPSjhua2FiRTByWVF2VElkelRSTmR4SUlnZnZxWURO?=
 =?utf-8?B?ekRzQURoVXc5Zi8vT0wzTG9JVEZrMVg4d1pONjRXMUg3RExkcWZuOFZhVnlZ?=
 =?utf-8?B?U2Q5eWJDVVVSRG9lcUYzOGFSQTlpVVlOVDFudzZyZXFiSVhoZVBOTGdUWFdT?=
 =?utf-8?B?VkhkTFR5eW5Ud2txaVhEQnBja0ZiaGttVFFkNnVRWjVDSDVsSlVDR1N4TTR3?=
 =?utf-8?B?YjJqZzhSVDlHNytRWUkxbUZ6Z1dkcmlzRFhXVUxMVUljOVZYUkZoeStsMCtX?=
 =?utf-8?B?NG5zWWN4NitCM0dSRmI4Wk1NYitrYVY4bURldWJ1RFJ4blZPL2FHRzJGWUZT?=
 =?utf-8?B?aUJjRVVhUmxha2xHSjJ4M0pzVC9XMDRLV3JMRjNIM1VlMzVsSGF3bVZTcjdZ?=
 =?utf-8?B?cjJjRHdPT3lUZUo4SUlJTXdkNXJ2bDkyVDBVbTYzc3Q4UDJSNmkwOHBLMFZQ?=
 =?utf-8?B?N2dBWEQrSkdSdUcyOVdYZ1NOVGdGeW4vWFIzWXRXQUpRbnZuTE5QSUQzNmpr?=
 =?utf-8?B?VVVqQ1lWV01yb2NwQ2ZtaU1QQUxNV28vNXNxT2U0cUJKd2tJN0pUOWF6Ny9V?=
 =?utf-8?B?eTQwcXNWWlRvbzRlZFA0d3c1YjFmcjdBOGdWcG9XQ2tYbFVIaGxFN2pnUHc5?=
 =?utf-8?B?alRCYktIS2pPdHVlSmkvQ2JlTUhrenRiVmxiUlY1UHVoQ09LN2VRM1hTWW9k?=
 =?utf-8?B?RFdBUzBENEVKeHlCZzBkcXZ5YjRJWjJhWWNjbW42dGpBcWk3MVE4NU5rQ0lm?=
 =?utf-8?B?dG1WU0dKczhnbUIyRFhQSDI5dC92Nzd5Q0J2ek1IMVhWSm5XSXhnWlNkR2lT?=
 =?utf-8?B?enB1alROV2RKekp1ODZEWXpGZXcxZ1JsOTdydFlSWjgxRGRNVW1JOG1hVy85?=
 =?utf-8?B?NGE2ODNKdzN3SC9iQTR1aUxPUG1QdzRvcUJpZ0ZJbHBCZTA2RGRrcDV6TGJa?=
 =?utf-8?B?UWMwb0NEUnBLUFQzZUpwZjhuK2JQYmVQbVlUTzZyTUk0TjRXa2lxQ0QyQUZL?=
 =?utf-8?B?aENieXhEVzVQTWIwdklIemw0TnRmYWxtQjN0MFhmek1jc2xmSXl1bnBkY0FI?=
 =?utf-8?B?QXd5eEk0YVBhbWRvVHN4cnovNWU2a1VkVERkbzBCS3QzUVFBdnlpNjhQeFNw?=
 =?utf-8?B?bGFOTjg3RlRRN2hxYVdVSGJsZTRPVytwaThiNHE2Umo4NzF1dXFCSVJnMFp3?=
 =?utf-8?Q?x8ERt77VaqBUCjR6RSa+Itc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8809FDD7E71C44284C9101D7558D836@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b47675ab-7aa1-47f0-589d-08dc57348618
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 18:57:07.9026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0oVruGyibIdb+yubimrIylbI0h00Wxec/reIjrrp9LDRdhWvP+RvlH09uWKw+8MeWc4d4QEYP7sQoYDiXpaOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1270

SGkgTHVpeiwNCg0KT24gNC81LzI0IDE3OjMwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IHdyb3Rl
Og0KPiBIaSBTZWJhc3RpYW4sDQo+IA0KPiBPbiBGcmksIEFwciA1LCAyMDI0IGF0IDY6MjbigK9B
TSBTZWJhc3RpYW4gVXJiYW4gPHN1cmJhbkBzdXJiYW4ubmV0PiB3cm90ZToNCj4+DQo+PiAtLS0g
YS9pbmNsdWRlL25ldC9ibHVldG9vdGgvbDJjYXAuaA0KPj4gKysrIGIvaW5jbHVkZS9uZXQvYmx1
ZXRvb3RoL2wyY2FwLmgNCj4+IEBAIC02ODIsMTAgKzY4MiwxNSBAQCBzdHJ1Y3QgbDJjYXBfdXNl
ciB7DQo+PiAgIC8qIC0tLS0tIEwyQ0FQIHNvY2tldCBpbmZvIC0tLS0tICovDQo+PiAgICNkZWZp
bmUgbDJjYXBfcGkoc2spICgoc3RydWN0IGwyY2FwX3BpbmZvICopIHNrKQ0KPj4NCj4+ICtzdHJ1
Y3QgbDJjYXBfcnhfYnVzeSB7DQo+PiArICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgICAgICAgIGxp
c3Q7DQo+PiArICAgICAgIHN0cnVjdCBza19idWZmICAgICAgICAgICpza2I7DQo+PiArfTsNCj4g
DQo+IEluIHRoZW9yeSB3ZSBvbmx5IHJlYWxseSB0byBxdWV1ZSAxIHNrYiBhdCBtb3N0LCBzaW5j
ZSB3ZSB3b3VsZCBzdG9wDQo+IGdpdmluZyBjcmVkaXRzLCBvciBwZXJoYXBzIHRoaXMgaXMgYmVj
YXVzZSB3ZSBoYWQgZ2l2ZW4gZW5vdWdoIGNyZWRpdHMNCj4gZm9yIE1UVSArIDEsIHNvIHRoZSAr
MSBzZWdtZW50IGNvdWxkIHJlc3VsdCBpbiBhIHNlY29uZCBTRFUvc2tiIHRvIGJlDQo+IGNvbXBs
ZXRlZCB3aGlsZSB3YWl0aW5nIHRoZSB1c2VyIHNwYWNlIHByb2Nlc3MgdG8gc3RhcnQgcmVhZGlu
ZyBhZ2Fpbj8NCg0KWWVzLCBkdXJpbmcgdGVzdGluZyBpdCBiZWNhbWUgYXBwYXJlbnQgdGhhdCB0
aGVyZSBtaWdodCBiZSBhIHNlY29uZCANCmluY29taW5nIHNrYiwgd2hpY2ggYWxzbyBuZWVkcyB0
byBiZSBidWZmZXJlZC4NCg0KRXZlbiBpZiAtLWFzIGRpc2N1c3NlZCBiZWxvdy0tIHdlIGNoYW5n
ZSBzZW5kX2NyZWRpdHMgdG8gcmV0dXJuIGNyZWRpdHMgDQpiYXNlZCBvbiB0aGUgYWN0dWFsIGF2
YWlsYWJsZSByZWNlaXZlIGJ1ZmZlciBzcGFjZSwgSSBiZWxpZXZlIHdlIHN0aWxsIA0KbmVlZCB0
byBhbGxvdyBidWZmZXJpbmcgbW9yZSB0aGFuIG9uZSBza2IuIFRoaXMgaXMgYmVjYXVzZSBsb2Nh
bCANCnVzZXItc3BhY2UgbWlnaHQgZGVjaWRlIHRvIHJlc2l6ZSB0aGUgcmVjZWl2ZSBidWZmZXIg
c2l6ZSAoU09fUkNWQlVGKSB0byANCmEgc21hbGxlciB2YWx1ZSBhZnRlciB0aGUgY3JlZGl0cyBo
YXZlIGFscmVhZHkgYmVlbiBnaXZlbiB0byB0aGUgcmVtb3RlIA0Kc2lkZS4NCg0KPj4gZGlmZiAt
LWdpdCBhL25ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jIGIvbmV0L2JsdWV0b290aC9sMmNhcF9j
b3JlLmMNCj4+IGluZGV4IGFiNWE5ZDQyZmFlNy4uYzc4YWY3ZmFkMjU1IDEwMDY0NA0KPj4gLS0t
IGEvbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmMNCj4+ICsrKyBiL25ldC9ibHVldG9vdGgvbDJj
YXBfY29yZS5jDQo+PiBAQCAtNjMsNiArNjMsOCBAQCBzdGF0aWMgdm9pZCBsMmNhcF9yZXRyYW5z
X3RpbWVvdXQoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKTsNCj4+ICAgc3RhdGljIHZvaWQgbDJj
YXBfbW9uaXRvcl90aW1lb3V0KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yayk7DQo+PiAgIHN0YXRp
YyB2b2lkIGwyY2FwX2Fja190aW1lb3V0KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yayk7DQo+Pg0K
Pj4gK3N0YXRpYyB2b2lkIGwyY2FwX2NoYW5fbGVfc2VuZF9jcmVkaXRzKHN0cnVjdCBsMmNhcF9j
aGFuICpjaGFuKTsNCj4gDQo+IFdlIHByb2JhYmx5IG5lZWQgdG8gY2hhbmdlIHRoZSB3YXkgc2Vu
ZF9jcmVkaXRzIGNhbGN1bGF0ZXMgdGhlIG51bWJlcg0KPiBvZiBjcmVkaXRzIHRvIGJlIHJlc3Rv
cmVkLCBpdCBuZWVkcyB0byBjb25zaWRlciB0aGUgYWN0dWFsIGF2YWlsYWJsZQ0KPiBidWZmZXIg
c2l6ZSBhdCB0aGUgc29ja2V0IHJhdGhlciB0aGVuIGFzc3VtaW5nIHdlIGFsd2F5cyBzaGFsbCBo
YXZlDQo+IHNwYWNlIGZvciBNVFUgKyAxLCB0aGF0IHdheSB0aGUgcmVtb3RlIHNpZGUgd291bGQg
YWx3YXlzIGhhdmUgdGhlDQo+IGV4YWN0IGluZm9ybWF0aW9uIG9mIGhvdyBtdWNoIGJ1ZmZlciBz
cGFjZSBpcyBsZWZ0LiBUaGF0IHNhaWQgcGVyaGFwcw0KPiB3ZSBuZWVkIGEgd2F5IHRvIGluZm9y
bSB3aGVuIHVzZXIgc3BhY2UgcmVhZHMgdGhlbiB3ZSBuZWVkIHRvIGNhbGwNCj4gaW50byBzZW5k
X2NyZWRpdHMgYWdhaW4uDQoNClllcywgdGhpcyBtYWtlcyBzZW5zZS4gSSB3aWxsIGV4dGVuZCB0
aGUgcGF0Y2ggYXBwcm9wcmlhdGVseS4NCg0KPj4gQEAgLTExODcsMTEgKzExODksMTUgQEAgc3Rh
dGljIGludCBsMmNhcF9zb2NrX3JlY3Ztc2coc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IG1z
Z2hkciAqbXNnLA0KPj4gICAgICAgICAgaWYgKCF0ZXN0X2JpdChDT05OX0xPQ0FMX0JVU1ksICZw
aS0+Y2hhbi0+Y29ubl9zdGF0ZSkpDQo+PiAgICAgICAgICAgICAgICAgIGdvdG8gZG9uZTsNCj4+
DQo+PiAtICAgICAgIGlmIChwaS0+cnhfYnVzeV9za2IpIHsNCj4+IC0gICAgICAgICAgICAgICBp
ZiAoIV9fc29ja19xdWV1ZV9yY3Zfc2tiKHNrLCBwaS0+cnhfYnVzeV9za2IpKQ0KPj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgcGktPnJ4X2J1c3lfc2tiID0gTlVMTDsNCj4+IC0gICAgICAgICAg
ICAgICBlbHNlDQo+PiArICAgICAgIHdoaWxlICghbGlzdF9lbXB0eSgmcGktPnJ4X2J1c3kpKSB7
DQo+PiArICAgICAgICAgICAgICAgc3RydWN0IGwyY2FwX3J4X2J1c3kgKnJ4X2J1c3kgPQ0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9maXJzdF9lbnRyeSgmcGktPnJ4X2J1c3ksDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBsMmNhcF9y
eF9idXN5LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaXN0
KTsNCj4+ICsgICAgICAgICAgICAgICBpZiAoX19zb2NrX3F1ZXVlX3Jjdl9za2Ioc2ssIHJ4X2J1
c3ktPnNrYikgPCAwKQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZG9uZTsNCj4+
ICsgICAgICAgICAgICAgICBsaXN0X2RlbCgmcnhfYnVzeS0+bGlzdCk7DQo+PiArICAgICAgICAg
ICAgICAga2ZyZWUocnhfYnVzeSk7DQo+IA0KPiBJIHNlZSBub3csIHRoaXMgaXMgdHJ5aW5nIHRv
IGRlcXVldWUgcGFja2V0cyBpZiB0aGUgc29ja2V0IGlzIHJlYWQsDQo+IHdoaWNoIGluIGNhc2Ug
d2UgdHVybiB0aGUgc2VuZF9jcmVkaXRzIGZ1bmN0aW9uIHRvIGNhbGN1bGF0ZSB0aGUNCj4gY3Jl
ZGl0cyBiYXNlZCBvbiB0aGUgc29ja2V0IGJ1ZmZlciBzaXplIHRoYXQgd291bGQgbm90IGJlIG5l
Y2Vzc2FyeQ0KPiBidXQgdGhlbiB3ZSB3b3VsZCBuZWVkIHRvIGNhbGwgaW50byBzZW5kX2NyZWRp
dHMgaGVyZS4NCg0KVGhpcyBpcyBmb2xsb3dlZCBieSAodW5tb2RpZmllZCk6DQoNCglpZiAoYXRv
bWljX3JlYWQoJnNrLT5za19ybWVtX2FsbG9jKSA8PSBzay0+c2tfcmN2YnVmID4+IDEpDQoJCWwy
Y2FwX2NoYW5fYnVzeShwaS0+Y2hhbiwgMCk7DQoNCkFuZCB3aWxsIGluIGZhY3QgY2FsbCBzZW5k
X2NyZWRpdHMgdGhyb3VnaCBsMmNhcF9jaGFuX2J1c3kgZnJvbSBoZXJlIA0Kb25jZSBhbGwgcXVl
dWVkIHNrYnMgaGF2ZSBiZWVuIGFjY2VwdGVkIGJ5IHRoZSBzb2NrZXQgYW5kIGl0cyByZWNlaXZl
IA0KYnVmZmVyIGhhcyBiZWNvbWUgaGFsZiBlbXB0eS4NCg0KDQo=

