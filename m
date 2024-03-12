Return-Path: <linux-kernel+bounces-99903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ACA878EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D6CB2163D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9306995A;
	Tue, 12 Mar 2024 07:00:28 +0000 (UTC)
Received: from hmat.qianxin.com (hmat.qianxin.com [220.181.41.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD8A69944;
	Tue, 12 Mar 2024 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.41.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710226828; cv=none; b=YvIZUtwl9PqqDC3emVHcQd/84Ey8eWAIMfsJ7lsI8Vb0v2pbjDdN0qN/OrvDl1L03AmMkV2xsYXx3iJl+ZD8GmmWYwkaTS60wmFgDgLxBZKSir1bwGCZ3PKYeI2arV8se18DWYppj8IxA7tt3WfbyoLS3ogklCuTWMAZhJL3njU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710226828; c=relaxed/simple;
	bh=DTeaKvuRth4LD2aEgIFjFQezb3PV9VIUrw3zBw55YAE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iau6dimJs8sFvJvb5nB5NBkhIUtwc5F5lh0PsXl3/0MJYNWye5mxa2cSYrmLBptA+L45F1HQ/U1Z2nhRRjtPEbxoHJusiyD0d9NxydXyDUpkxDfnKeXACmkleSsesSDK7D9niLEcum/rQL0MQ60qDDA+ewogZyc+bv7N3PS+oH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=qianxin.com; spf=pass smtp.mailfrom=qianxin.com; arc=none smtp.client-ip=220.181.41.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=qianxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qianxin.com
Received: from hmat.qianxin.com (unknown [10.44.121.89])
	by hmat.qianxin.com (SkyGuard) with ESMTPS id 4Tv4KF2kbsz2LZrq;
	Tue, 12 Mar 2024 15:00:17 +0800 (CST)
Received: from qax-bjmail06.ESG.360ES.CN
 (2402:d040:0:8425:2849:52e7:3abe:7096) by qax-bjmail01.ESG.360ES.CN
 (2402:d040:0:8425:a915:9de4:295a:5b3a) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 12 Mar 2024 15:00:17 +0800
Received: from qax-bjmail06.ESG.360ES.CN ([fe80::2849:52e7:3abe:7096]) by
 qax-bjmail06.ESG.360ES.CN ([fe80::2849:52e7:3abe:7096%5]) with mapi id
 15.01.2507.031; Tue, 12 Mar 2024 15:00:17 +0800
From: =?utf-8?B?5p+z6I+B5bOw?= <liujingfeng@qianxin.com>
To: Z qiang <qiang.zhang1211@gmail.com>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
	"secalert@redhat.com" <secalert@redhat.com>
Subject: reply: memory leak in posix_clock_open
Thread-Topic: reply: memory leak in posix_clock_open
Thread-Index: Adp0Sk62HoO6BZjIQO2BK9zk6rc1QQ==
Date: Tue, 12 Mar 2024 07:00:17 +0000
Message-ID: <86496b3b336544f2b8f9d1932599a4af@qianxin.com>
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

Pg0KPlBsZWFzZSB0cnkgdGhlIGZvbGxvd2luZyBtb2RpZmljYXRpb25zOg0KPg0KPmRpZmYgLS1n
aXQgYS9rZXJuZWwvdGltZS9wb3NpeC1jbG9jay5jIGIva2VybmVsL3RpbWUvcG9zaXgtY2xvY2su
YyBpbmRleCA5ZGU2NmJiYmIzZDEuLjcxZDlkOGMzOTRmYSAxMDA2NDQNCj4tLS0gYS9rZXJuZWwv
dGltZS9wb3NpeC1jbG9jay5jDQo+KysrIGIva2VybmVsL3RpbWUvcG9zaXgtY2xvY2suYw0KPkBA
IC0xMzcsNiArMTM3LDggQEAgc3RhdGljIGludCBwb3NpeF9jbG9ja19vcGVuKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmcCkNCj4NCj4gICAgICAgIGlmICghZXJyKSB7DQo+ICAg
ICAgICAgICAgICAgIGdldF9kZXZpY2UoY2xrLT5kZXYpOw0KPisgICAgICAgfSBlbHNlIHsNCj4r
ICAgICAgICAgICAgICAga2ZyZWUocGNjb250ZXh0KTsNCj4gICAgICAgIH0NCj4gb3V0Og0KPiAg
ICAgICAgdXBfcmVhZCgmY2xrLT5yd3NlbSk7DQoNCkkgdGVzdGVkIGl0LCBpdCB3YXMgYWxsIHJp
Z2h0IGFuZCBmaXhlZCB0aGUgbWVtb3J5IGxlYWsuDQpUaGFua3MuDQo=

