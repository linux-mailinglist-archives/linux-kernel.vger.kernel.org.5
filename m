Return-Path: <linux-kernel+bounces-137950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EF089EA35
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A821F231FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF281CAA9;
	Wed, 10 Apr 2024 05:55:51 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A764A;
	Wed, 10 Apr 2024 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728551; cv=none; b=Xj5jOSZflDL5NhbWJWnBz9JfeF3iP+xgPY9S5m354dlGtRkSVe82bEkyYcxoleAY8bAAPMNFldg0IyC9qMCdZxbXCAbeLNLxYk9+uAEWFRs6GSE3c1TyQ689UUX0yDHSFTAZqz5cGNPLnM8xC8V/Jpd2HYQ8Z1T7mr+y8hjsNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728551; c=relaxed/simple;
	bh=igMcFDMxvu2p9U20IbqyeRQJRA/g0Q0NAOMiAPdkpwM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AEZ79mjuNwfPL8Tu0hORVpnCT7JES/1HkaC2XTtcSexzcnqccjhXTyXbv3nBTf1TS5V/YQTS1INxjNpUN1W2Nb43fmyplZ/5AzEPq10Yy6j5G2I4HPoJM5vnbEU1S4JfmZJHSQaL7qLO18EWWCesVy/Qs73bBsNz1ZE0umOadnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 43A5s7Wa084336;
	Wed, 10 Apr 2024 13:54:07 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX08-BJD.srv.huawei-3com.com (unknown [10.153.34.10])
	by mail.maildlp.com (Postfix) with ESMTP id CEF182004BC2;
	Wed, 10 Apr 2024 13:56:16 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX08-BJD.srv.huawei-3com.com (10.153.34.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 10 Apr 2024 13:54:08 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Wed, 10 Apr 2024 13:54:08 +0800
From: Liuye <liu.yeC@h3c.com>
To: Greg KH <gregkh@linuxfoundation.org>,
        "andy.shevchenko@gmail.com"
	<andy.shevchenko@gmail.com>
CC: "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "jason.wessel@windriver.com"
	<jason.wessel@windriver.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net"
	<kgdb-bugreport@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFYxMF0ga2RiOiBGaXggdGhlIGRlYWRsb2NrIGlzc3Vl?=
 =?gb2312?Q?_in_KDB_debugging.?=
Thread-Topic: [PATCH V10] kdb: Fix the deadlock issue in KDB debugging.
Thread-Index: AQHaiuuw81gSSyk26Eq+v/7KfdTz2LFgdGkAgACJimA=
Date: Wed, 10 Apr 2024 05:54:08 +0000
Message-ID: <0c004dd44ad5478eba9451186f4ec962@h3c.com>
References: <20240409020326.2125332-1-liu.yec@h3c.com>
 <20240410020615.2885000-1-liu.yec@h3c.com>
 <2024041014-padlock-aggregate-4705@gregkh>
In-Reply-To: <2024041014-padlock-aggregate-4705@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-sender-location: DAG2
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 43A5s7Wa084336

Pj4gU2lnbmVkLW9mZi1ieTogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+
DQo+SSBoYXZlIE5PVCBzaWduZWQgb2ZmIG9uIHRoaXMgY29tbWl0LiAgWW91IGp1c3Qgc2FpZCB0
aGF0IEkgbWFkZSBhIGxlZ2FsIHN0YXRlbWVudCBhYm91dCB0aGlzIGNvbW1pdCB3aXRob3V0IHRo
YXQgYWN0dWFsbHkgYmVpbmcgdHJ1ZT8/Pw0KPg0KPlNvcnJ5LCBidXQgdGhhdCBpcyBmbGF0IG91
dCBub3QgYWNjZXB0YWJsZSBhdCBhbGwuICBQbGVhc2UgZ28gd29yayB3aXRoIHlvdXIgY29tcGFu
eSBsYXd5ZXJzIHRvIGZpZ3VyZSBvdXQgd2hhdCB5b3UgZGlkIGFuZCBjb21lIGJhY2sgd2l0aCBh
biBleHBsYWluYXRpb24gb2YgZXhhY3RseSB3aGF0IHRoaXMgaXMgYW5kIGhvdyBpdCB3aWxsIG5v
dCBoYXBwZW4gYWdhaW4uDQo+DQoNCj4+IFNpZ25lZC1vZmYtYnk6IEFuZHkgU2hldmNoZW5rbyA8
YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4NCj4+IFY5IC0+IFYxMCA6IEFkZCBTaWduZWQt
b2ZmLWJ5IG9mIEdyZWcgS0ggYW5kIEFuZHkgU2hldmNoZW5rbywgQWNrZWQtYnkgDQo+PiBvZiBE
YW5pZWwgVGhvbXBzb24NCj4NCj5IdWg/IQ0KDQpAZ3JlZyBrLWggo7oNCkBBbmR5IFNoZXZjaGVu
a28go7oNCg0KU29ycnksIGl0IHdhcyBteSBtaXN0YWtlLiBJIG1pc3VuZGVyc3Rvb2QgdGhlIG1l
YW5pbmcgb2YgInNpZ25lZC1vZmYtYnkiLCB3aGljaCBsZWQgdG8gdXNhZ2UgaXNzdWVzLg0KDQpJ
IHdhbnQgdG8gZXhwcmVzcyBteSBncmF0aXR1ZGUgZm9yIHRoZSBzdWdnZXN0aW9ucyBvbiB0aGUg
cGF0Y2ggZnJvbSB0aGUgdHdvIG9mIHlvdS4gDQoNCldoYXQgZG8gSSBuZWVkIHRvIGRvIG5vdz8g
UmVsZWFzZSBQQVRDSCBWMTEgYW5kIGRlbGV0ZSB0aGVzZSB0d28gc2lnbmF0dXJlcyBpbiBpdCA/
DQo=

