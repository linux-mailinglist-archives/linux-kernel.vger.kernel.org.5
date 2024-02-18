Return-Path: <linux-kernel+bounces-70171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E6385944B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF38282FD9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B49C17F0;
	Sun, 18 Feb 2024 03:13:18 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7415C0
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 03:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708225998; cv=none; b=T0dwoh9tNgHyzMrFaRLpMcLIWqMXcmkgGREuagElxGFXGMnxu288EtlesX5iW7GyanetibA4amE8kDdEH4zlYwOVVQ2y6CABqkv0ro5iL+ukd/ktiaD3SMal8voyqc4emHlCehlTNKY0Oey8e2i41L8MYxsHhx674FdzQezWTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708225998; c=relaxed/simple;
	bh=BAzZDtWxmPKCYWUkBPM7TWSay365QqhhOeFGtf5/nX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=RuDKaf2OgmTqxaH6zlyrz3lk2ZzifKxL9zXAA4XXDSsItVmnRc3cGOn+iYx+H2nqAGtz9eEChzyUdsBgF77WsdcksgjpXmgap7oHkze/l/xubXEUx1nNzjKo+bTWnzuLGftnxPSwkiAzvmQbMXv0SUucUTwEe+qjayZBXj9VoBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TcrKJ2DB2z1gyx0
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 11:11:00 +0800 (CST)
Received: from kwepemd200002.china.huawei.com (unknown [7.221.188.186])
	by mail.maildlp.com (Postfix) with ESMTPS id 0ED271400CC
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 11:13:06 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemd200002.china.huawei.com (7.221.188.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Sun, 18 Feb 2024 11:13:05 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.035;
 Sun, 18 Feb 2024 11:13:05 +0800
From: "chenjun (AM)" <chenjun102@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "xuqiang (M)" <xuqiang36@huawei.com>
Subject: Re: [PATCH] irqchip/mbigen: Fix incorrect null pointer check
Thread-Topic: [PATCH] irqchip/mbigen: Fix incorrect null pointer check
Thread-Index: AQHaUrPy4yFabhAFLUSb7iNXYyazpg==
Date: Sun, 18 Feb 2024 03:13:05 +0000
Message-ID: <45fe193a87fc4a5cb2e3233386b47dc7@huawei.com>
References: <20240129130003.18181-1-chenjun102@huawei.com>
 <874jecisku.ffs@tglx>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=1B$B:_=1B(B 2024/2/13 18:09, Thomas Gleixner =1B$B<LF;=1B(B:=0A=
> On Mon, Jan 29 2024 at 21:00, Chen Jun wrote:=0A=
> =0A=
> That's not about an incorrect NULL pointer check. That's about using a=0A=
> function which is guaranteed to return NULL on your platform, no?=0A=
> =0A=
>> bus_get_dev_root(&platform_bus_type) always returns NULL.=0A=
> =0A=
> Lacks an explanation why this always returns NULL.=0A=
> =0A=
=0A=
Thank you for the reply.=0A=
=0A=
bus_get_dev_root returns sp->dev_root set in subsys_register.=0A=
And subsys_register is not called by platform_bus_init.=0A=
=0A=
So, for platform_bus_type, bus_get_dev_root always returns NULL.=0A=
=0A=
> Thanks=0A=
> =0A=
>          tglx=0A=
> =0A=
> =0A=
=0A=

