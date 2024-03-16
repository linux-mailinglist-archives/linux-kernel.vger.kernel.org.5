Return-Path: <linux-kernel+bounces-105162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9B987D9E1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8121F21AE1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8D18B09;
	Sat, 16 Mar 2024 11:16:07 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10718026;
	Sat, 16 Mar 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710587766; cv=none; b=OQ2Zt4a4U+M8yFDt+cDmY6QoZ4AwurWfepGoOaPUJAbtqskgepDj6NJWU4rjJf8WvwkUaxo7+GFoyWdyeZFI7QkmYPtecBQVBBn3pzn4DRKldtkDb7Du1dgaBMVMKzANW0V0OMym17EpRhrfaHsxaiqwMaxtIhdEllavgz6AuhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710587766; c=relaxed/simple;
	bh=hZZyv4cAOdJ3qjCkB+VS05KHWgLITZemnzhM54fkbOU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PGgVRqfV/QGIYToCo8vJXbQU705uJ2iru+WGx1dYDMjPGP08A+WP/UWIiuImeF161786bmQl522kbs86ZQxdr4xEp49kPRvRnTswJxyF9oJdSOQk1siKqsE5iB9HpaRXcUMx9g88uM2fxFa7DctxZQu92PTKCxkhFSngreHmj84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TxdlT4VNKz1QBH5;
	Sat, 16 Mar 2024 19:13:25 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id D952A1A016C;
	Sat, 16 Mar 2024 19:15:55 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 16 Mar 2024 19:15:55 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <michal.kubiak@intel.com>, <shenjian15@huawei.com>,
	<wangjie125@huawei.com>, <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 0/3] There are some bugfix for the HNS3 ethernet driver
Date: Sat, 16 Mar 2024 19:10:54 +0800
Message-ID: <20240316111057.277591-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)

There are some bugfix for the HNS3 ethernet driver

---
changeLog:
v1 -> v2:
  - Fixed some syntax errors in git messages and comments, suggested by Michal Kubiak
  - Optimized the code by using a flag, suggested by Michal Kubiak
  v1: https://lore.kernel.org/all/20240315100748.2913882-1-shaojijie@huawei.com/
---

Jian Shen (1):
  net: hns3: mark unexcuted loopback test result as UNEXECUTED

Jie Wang (1):
  net: hns3: fix index limit to support all queue stats

Yonglong Liu (1):
  net: hns3: fix kernel crash when devlink reload during pf
    initialization

 .../hns3/hns3_common/hclge_comm_tqp_stats.c    |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3_ethtool.c | 18 ++++++++++++++++--
 .../hisilicon/hns3/hns3pf/hclge_devlink.c      |  5 +++--
 3 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.30.0


