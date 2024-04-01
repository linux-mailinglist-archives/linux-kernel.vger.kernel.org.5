Return-Path: <linux-kernel+bounces-126407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E96FE8936E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 04:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A551C281CDE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 02:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EDC1FAA;
	Mon,  1 Apr 2024 02:18:25 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241DD10E5;
	Mon,  1 Apr 2024 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711937904; cv=none; b=V7Hds4GcCm9e4Q1/mgZ7TZSOa1xsHQ2o7g0XQr4290f6TbskeFHDA/I200bX+vvECLAyocBNhJ/GJXE0cSD3pDEExHYmfFeZiBZuEmwSidIy948+lCQBPwUuNzOp914l1JYHMa/y20WG5d16N9C4HWXEq1el/svVA6rSAeJBwqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711937904; c=relaxed/simple;
	bh=XaikyVQs5EJGZ8CGtdMMdgUqWK86PcrEdVmxt1j3bwg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fsrA5h5H3WXW6nUU4bOxp3w5MSBhQcTXcACaP+wvG6Z1SOiEmWvHJE5JCQiuzbl9c7zXlZABqZ8fin6563MjGjRZRGUcxEV+ikSecyo1B0BYjeloSIQzBcuIdyImqKOMN6CnwCUHSQPri9A8wOpBbnDOAk846fVG47EFZ/Rqn00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 4312H1be015188;
	Mon, 1 Apr 2024 10:17:01 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX08-BJD.srv.huawei-3com.com (unknown [10.153.34.10])
	by mail.maildlp.com (Postfix) with ESMTP id B6F9F200BBEF;
	Mon,  1 Apr 2024 10:18:57 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX08-BJD.srv.huawei-3com.com (10.153.34.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Mon, 1 Apr 2024 10:17:02 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Mon, 1 Apr 2024 10:17:02 +0800
From: Liuye <liu.yeC@h3c.com>
To: Daniel Thompson <daniel.thompson@linaro.org>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "dianders@chromium.org"
	<dianders@chromium.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "jason.wessel@windriver.com"
	<jason.wessel@windriver.com>,
        "kgdb-bugreport@lists.sourceforge.net"
	<kgdb-bugreport@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFY3XSBrZGI6IEZpeCB0aGUgZGVhZGxvY2sgaXNzdWUg?=
 =?gb2312?Q?in_KDB_debugging.?=
Thread-Topic: [PATCH V7] kdb: Fix the deadlock issue in KDB debugging.
Thread-Index: AdqD2hPGLsWNTqu4Qy+z4NFD9ArrsQ==
Date: Mon, 1 Apr 2024 02:17:02 +0000
Message-ID: <ebd5ce38abfd435886d526d4488db9ee@h3c.com>
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
X-MAIL:h3cspam02-ex.h3c.com 4312H1be015188

SGkgRGFuaWVsLA0KDQpIb3cgYWJvdXQgUEFUQ0ggVjcuDQoNClRoYW5rcy4NCg==

