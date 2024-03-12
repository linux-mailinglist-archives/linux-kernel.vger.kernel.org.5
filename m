Return-Path: <linux-kernel+bounces-100091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75588791AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5364B1F22C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39507829A;
	Tue, 12 Mar 2024 10:06:03 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22B33994;
	Tue, 12 Mar 2024 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237963; cv=none; b=RkuJ4cAcfYfjupY/rGv0ybmVEsGQ0mg5HiF6GaL2fJAz8GPEpNj8ILms50F1kxYkkPC/vdxCebmaHw2HbrHtDB3WuQgZsU/GD5eP4BKABWP2TyzpbpwbzYCZ5TvhKfspiyeAOoUx0MByxF8DLcHVXVmTs+fUouIxetrzt4TnfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237963; c=relaxed/simple;
	bh=dDcqmysluy075HS1NSHrCBspR8WbAsMo85MDQAqKgpU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ryxb8tn5UhHV7v8QCr8hAzkCCjj8UW2Vyir6cxgJ2ESROVPySLI8xlLRCE9FvJIyl6Ej8sDR6AkoekAE0Vyf3lEITAUAqTuYFcaOlcGI4BXvLrhv/X56cD9eLUYymFqy+z7gW/aMSL5hwz2sbepgSy3u4JBrIgBsngR8ZIiH2pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 42CA4qbZ063785;
	Tue, 12 Mar 2024 18:04:52 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id 68AC42004BAE;
	Tue, 12 Mar 2024 18:06:22 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Tue, 12 Mar 2024 18:04:54 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Tue, 12 Mar 2024 18:04:54 +0800
From: Liuye <liu.yeC@h3c.com>
To: Daniel Thompson <daniel.thompson@linaro.org>
CC: "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net"
	<kgdb-bugreport@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBrZGI6IEZpeCB0aGUgZGVhZGxv?=
 =?gb2312?Q?ck_issue_in_KDB_debugging.?=
Thread-Topic: =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIXSBrZGI6IEZpeCB0aGUgZGVhZGxvY2sgaXNz?=
 =?gb2312?Q?ue_in_KDB_debugging.?=
Thread-Index: AQHaafG3YC/Li+j42kau1FDQhHr2m7EfIsgAgAMadaD///fWgIAJrHcQgAeL+QCAAIb8YA==
Date: Tue, 12 Mar 2024 10:04:54 +0000
Message-ID: <06cfa3459ed848cf8f228997b983cf53@h3c.com>
References: <20240228025602.3087748-1-liu.yeC@h3c.com>
 <20240228120516.GA22898@aspen.lan> <8b41d34adaef4ddcacde2dd00d4e3541@h3c.com>
 <20240301105931.GB5795@aspen.lan> <2ea381e7407a49aaa0b08fa7d4ff62d3@h3c.com>
 <20240312095756.GB202685@aspen.lan>
In-Reply-To: <20240312095756.GB202685@aspen.lan>
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
X-MAIL:h3cspam02-ex.h3c.com 42CA4qbZ063785

Pk9uIFR1ZSwgTWFyIDEyLCAyMDI0IGF0IDA4OjM3OjExQU0gKzAwMDAsIExpdXllIHdyb3RlOg0K
Pj4gSSBrbm93IHRoYXQgeW91IHNhaWQgc2NoZWR1bGVfd29yayBpcyBub3QgTk1JIHNhdmUsIHdo
aWNoIGlzIHRoZSBmaXJzdCANCj4+IGlzc3VlLiBQZXJoYXBzIGl0IGNhbiBiZSBmaXhlZCB1c2lu
ZyBpcnFfd29ya19xdWV1ZS4gQnV0IGV2ZW4gaWYgDQo+PiBpcnFfd29ya19xdWV1ZSBpcyB1c2Vk
IHRvIGltcGxlbWVudCBpdCwgdGhlcmUgd2lsbCBzdGlsbCBiZSBhIGRlYWRsb2NrIA0KPj4gcHJv
YmxlbSBiZWNhdXNlIHNsYXZlIGNwdTEgc3RpbGwgaGFzIG5vdCByZWxlYXNlZCB0aGUgcnVubmlu
ZyBxdWV1ZSANCj4+IGxvY2sgb2YgbWFzdGVyIENQVTAuDQo+DQo+VGhpcyBkb2Vzbid0IHNvdW5k
IHJpZ2h0IHRvIG1lLiBXaHkgZG8geW91IHRoaW5rIENQVTEgd29uJ3QgcmVsZWFzZSB0aGUgcnVu
IHF1ZXVlIGxvY2s/DQoNCkluIHRoaXMgZXhhbXBsZSwgQ1BVMSBpcyB3YWl0aW5nIGZvciBDUFUw
IHRvIHJlbGVhc2UgZGJnX3NsYXZlX2xvY2suDQo=

