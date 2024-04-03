Return-Path: <linux-kernel+bounces-129330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDC789697D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF8B0B2E8D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082CC71746;
	Wed,  3 Apr 2024 08:27:10 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A216FE2A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132829; cv=none; b=NIkNKwgHT/j5G9ZdBAujvk7JJlLC81J4KXkwTaPSikLADgMvM6xbCpiJshrr4YPRu7u9YxgjT58lGeHNpRzgMNANnHK/+X7vkW/IH/vW6N5hvCjl7NSwnR9hXOEvqt2FpEbdsvkKVJ9/o/grxONxlGFjdJGedNH0emXAG9Sq4+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132829; c=relaxed/simple;
	bh=Bk4xlZ9YVF21xjG7yoZVHEcBlCbnDiO2HyLUyJ4kfUo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nZgeJYj5OfqO2hMUSI10GStWLtDGb+Mh9ZrZCrlKrP1GC9zku3vuhJnYSUIiGIAPMyonRJE6EO5XA9/vF4eFdnidwFa7tfoMQY+qgjG61xafzXkgbRdVp/Kq9OCI5pRm0tp2UhKGfdYOy46cCpu/YZ2PdHG4saofzvUSBsu8SR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V8d7k3KdmzXkbf;
	Wed,  3 Apr 2024 16:24:02 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id E53121402C7;
	Wed,  3 Apr 2024 16:26:59 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 16:26:59 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Jonathan.Cameron@Huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 0/2] soc: hisilicon: kunpeng_hccs: add dependency and enhance verification
Date: Wed, 3 Apr 2024 16:19:33 +0800
Message-ID: <20240403081935.24308-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
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

Huisong Li (2):
  soc: hisilicon: kunpeng_hccs: Add the check for obtaining complete
    port attribute
  soc: hisilicon: kunpeng_hccs: replace MAILBOX dependency with PCC

 drivers/soc/hisilicon/Kconfig        | 2 +-
 drivers/soc/hisilicon/kunpeng_hccs.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.22.0


