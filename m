Return-Path: <linux-kernel+bounces-148278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 091748A802D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F87284001
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FD0137766;
	Wed, 17 Apr 2024 09:55:45 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CF8136E32
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347745; cv=none; b=RULUeBgWW/oMvJx5cm3bjkdEFZg2RezzDJVKfOq7c4pJ02BCG2xUEA48fRnVFZpwohzvmQAPiv9L40kEZGYece8X6sPDvS0ABJDzmEoidyjr8As6Z+ZUhyeM+O1Ke9S4ROoM/irYmFvo0XTJ9YDLEX/B4qc9xWfwBBLVO3EjNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347745; c=relaxed/simple;
	bh=dOwDO2gSUz0u5luaONrWuUqZCySnV4xCYjiB41i4sNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VH9soyqT2BrGEpzKyi2KiLB8r30Ef1MhvImorC+O6zTtWlIrlVNvnOpIq3/0ZSeaO4pjTLys3RXLKpA/fDBnZlXY9mPK/kv0CiM6rPoGURZ7ImRGOKluRSfHHUuARRnu5gsbE2GLcorxRbynr5E4OFI1yL0MrCA4l+Riha5t9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VKGTz0mDxz1HBtF;
	Wed, 17 Apr 2024 17:54:47 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id C1453140382;
	Wed, 17 Apr 2024 17:55:40 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 17:55:40 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Jonathan.Cameron@Huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 0/2] soc: hisilicon: kunpeng_hccs: add dependency and enhance verification
Date: Wed, 17 Apr 2024 17:47:59 +0800
Message-ID: <20240417094801.25393-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20240403081935.24308-1-lihuisong@huawei.com>
References: <20240403081935.24308-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)

Add PCC dependency and enhance verification during the probe phase.

---
 v2: fix the log on failure.

Huisong Li (2):
  soc: hisilicon: kunpeng_hccs: Add the check for obtaining complete
    port attribute
  soc: hisilicon: kunpeng_hccs: replace MAILBOX dependency with PCC

 drivers/soc/hisilicon/Kconfig        | 2 +-
 drivers/soc/hisilicon/kunpeng_hccs.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.22.0


