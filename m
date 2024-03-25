Return-Path: <linux-kernel+bounces-117893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0564B88B107
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9450E1FA54AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B1E56B66;
	Mon, 25 Mar 2024 20:11:07 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68E55E59
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397467; cv=none; b=OP7svYiVCbPveSLky71bjSzkexOK4YI3OEy6Z3yLHL6xZZVTWM/UzreOKAuUXVkuOkl/zQoLA1NZGCUmOhoYWSudAbp/2VhodwrwEFtjlj+Ol3L1qiK3/wZetLpUeprh4r2Pypus5UIDXnK1Y3TTTWUy1fHkuTmGum31MNe/KCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397467; c=relaxed/simple;
	bh=kRi+z/iUZL9y3YATCe7YxHnRZjrRJLGs2SytpHRsKbA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EuSURhv1Y7mLsALNzLBbgbxGF0XPVnYYlbYz+3ydJN6/xIYzDIPDR7IWSv+9ji27wvhXSGEDE6W+E4GfHT//0FTaHxVoIfdb6rcf0vc1Gw9A+7DFZkmNJDnAqFUaYekcTterucXPq3qsLR/PmOJG6Glftd7fj2ebmZ8yQ7j9hvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3PDj3HrVz6K5Yf;
	Tue, 26 Mar 2024 04:10:13 +0800 (CST)
Received: from lhrpeml100003.china.huawei.com (unknown [7.191.160.210])
	by mail.maildlp.com (Postfix) with ESMTPS id BCB1A140A35;
	Tue, 26 Mar 2024 04:11:01 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (7.191.160.78) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 20:11:01 +0000
Received: from lhrpeml500002.china.huawei.com ([7.191.160.78]) by
 lhrpeml500002.china.huawei.com ([7.191.160.78]) with mapi id 15.01.2507.035;
 Mon, 25 Mar 2024 20:11:01 +0000
From: Niyas Sait <niyas.sait@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Shimrra Shai
	<shimmyshai00@gmail.com>
CC: "heiko@sntech.de" <heiko@sntech.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "max.schwarz@online.de"
	<max.schwarz@online.de>
Subject: RE: [PATCH 0/0] (proposed?) Add ACPI binding to Rockchip RK3xxx I2C
 bus
Thread-Topic: [PATCH 0/0] (proposed?) Add ACPI binding to Rockchip RK3xxx I2C
 bus
Thread-Index: AQHafsr0Wl6sT07ewk2P4IUJwaVt4bFI4A9w
Importance: high
X-Priority: 1
Date: Mon, 25 Mar 2024 20:11:01 +0000
Message-ID: <78763d69bae04204b2af37201b09f8b5@huawei.com>
References: <20240322103521.00001a12@Huawei.com>
	<20240322155146.22755-1-shimmyshai00@gmail.com>
 <20240325154150.00003bde@Huawei.com>
In-Reply-To: <20240325154150.00003bde@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> Niyas, could you forward what you had to Shimrra? (I can find it if you d=
on't have it any more).

I am on holiday so only had a chance to skim through the email. By the way,=
 the half-baked patch is here [1].=20

The patch only supports fixed clock sources and require further changes to =
support multiple clock sources.

I will have a look at the discussions when I am back. Hopefully the patch g=
ives some idea. Feel free to take up the patch and fill any missing bits.

[1] https://github.com/niyas-sait/linux-acpi/blob/main/0001-acpi-add-clock-=
bindings-for-fixed-clock-resources.patch

Thanks
Niyas


