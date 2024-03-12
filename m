Return-Path: <linux-kernel+bounces-100077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A929B879175
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30DE1B2522F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D2C77F08;
	Tue, 12 Mar 2024 09:53:17 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EB38464;
	Tue, 12 Mar 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237197; cv=none; b=R9NmInKU0wpM42+iDkmbWwpGQSd7sEAZn/KLSln9m5Vt+gFSPVX2O7QNT+AoT0l4Alhc3sGov3IYJFSVPAPdaYepxdEZGjKFuU75hKQs8SWmnEV6gpnB03Wn4fAonlW8tKdYbxmLkMX8tNtMQ1CJWRigZ7r2+Ta+/B1pEsRU5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237197; c=relaxed/simple;
	bh=484fGHYCkSxYD6mCMfudQ6WkbUe/ZMV3OusJdX8NaVg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WFOxKsLCrZ0czGvQO+riSMukOzU3+fWBX7Tw25MxQ+3sqrNauv3KxMc/EXLMHMHdCccldNWfJeE7ji0t07hj/nIYo6DUEHc36wnx0GZGoZV/8mqrIHKfGscXdab3FOWf+qrS8q8lg9fHWRj+eJjsDYv/Mr0IlI5c0z5aKXuWb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
	by h3cspam02-ex.h3c.com with ESMTP id 42C8cam6070755;
	Tue, 12 Mar 2024 16:38:36 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 42C8bAQO064331;
	Tue, 12 Mar 2024 16:37:10 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX12-BJD.srv.huawei-3com.com (unknown [10.153.34.14])
	by mail.maildlp.com (Postfix) with ESMTP id 9B02C2005153;
	Tue, 12 Mar 2024 16:38:39 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX12-BJD.srv.huawei-3com.com (10.153.34.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Tue, 12 Mar 2024 16:37:11 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Tue, 12 Mar 2024 16:37:11 +0800
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
Subject: =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIXSBrZGI6IEZpeCB0aGUgZGVhZGxvY2sgaXNz?=
 =?gb2312?Q?ue_in_KDB_debugging.?=
Thread-Topic: =?gb2312?B?tPC4tDogW1BBVENIXSBrZGI6IEZpeCB0aGUgZGVhZGxvY2sgaXNzdWUgaW4g?=
 =?gb2312?Q?KDB_debugging.?=
Thread-Index: AQHaafG3YC/Li+j42kau1FDQhHr2m7EfIsgAgAMadaD///fWgIAJrHcQ
Date: Tue, 12 Mar 2024 08:37:11 +0000
Message-ID: <2ea381e7407a49aaa0b08fa7d4ff62d3@h3c.com>
References: <20240228025602.3087748-1-liu.yeC@h3c.com>
 <20240228120516.GA22898@aspen.lan> <8b41d34adaef4ddcacde2dd00d4e3541@h3c.com>
 <20240301105931.GB5795@aspen.lan>
In-Reply-To: <20240301105931.GB5795@aspen.lan>
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
X-MAIL:h3cspam02-ex.h3c.com 42C8cam6070755

SSBrbm93IHRoYXQgeW91IHNhaWQgc2NoZWR1bGVfd29yayBpcyBub3QgTk1JIHNhdmUsIHdoaWNo
IGlzIHRoZSBmaXJzdCBpc3N1ZS4gUGVyaGFwcyBpdCBjYW4gYmUgZml4ZWQgdXNpbmcgaXJxX3dv
cmtfcXVldWUuIEJ1dCBldmVuIGlmIGlycV93b3JrX3F1ZXVlIGlzIHVzZWQgdG8gaW1wbGVtZW50
IGl0LCB0aGVyZSB3aWxsIHN0aWxsIGJlIGEgZGVhZGxvY2sgcHJvYmxlbSBiZWNhdXNlIHNsYXZl
IGNwdTEgc3RpbGwgaGFzIG5vdCByZWxlYXNlZCB0aGUgcnVubmluZyBxdWV1ZSBsb2NrIG9mIG1h
c3RlciBDUFUwLg0KDQoNCg0K

