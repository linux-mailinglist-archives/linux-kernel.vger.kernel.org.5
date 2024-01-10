Return-Path: <linux-kernel+bounces-17368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3598824C57
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A121F23297
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEBB1876;
	Fri,  5 Jan 2024 01:06:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C191FA3;
	Fri,  5 Jan 2024 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4T5lcf4qggzMqgD;
	Fri,  5 Jan 2024 09:05:22 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 90EDB1400CA;
	Fri,  5 Jan 2024 09:05:54 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 09:05:53 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <lanhao@huawei.com>, <wangpeiyang1@huawei.com>,
	<shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V4 net-next 0/4] There are some features for the HNS3 ethernet driver
Date: Fri, 5 Jan 2024 09:01:15 +0800
Message-ID: <20240105010119.2619873-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)

There are some features for the HNS3 ethernet driver

---
changeLog:
v3 -> v4:
  - Adjuste the patches sequence in this patch set, suggested by Simon Horman
  v3: https://lore.kernel.org/all/20231216070018.222798-1-shaojijie@huawei.com/
v2 -> v3:
  - Fix the incorrect use of byte order in patch
    "net: hns3: add command queue trace for hns3" suggested by Simon Horman
  - Add a new patch to move constants from hclge_debugfs.h
    to hclge_debugfs.c suggested by Simon Horman
  v2: https://lore.kernel.org/all/20231214141135.613485-1-shaojijie@huawei.com/
v1 -> v2:
  - Delete a patch for ethtool -S to dump page pool statistics, suggested by Jakub Kicinski
  - Delete two patches about CMIS transceiver modules because
    ethtool get_module_eeprom_by_page op is not implemented, suggested by Jakub Kicinski
  v1: https://lore.kernel.org/all/20231211020816.69434-1-shaojijie@huawei.com/
---

Hao Lan (1):
  net: hns3: add command queue trace for hns3

Jijie Shao (2):
  net: hns3: move constants from hclge_debugfs.h to hclge_debugfs.c
  net: hns3: support dump pfc frame statistics in tx timeout log

Peiyang Wang (1):
  net: hns3: dump more reg info based on ras mod

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   6 +
 .../hns3/hns3_common/hclge_comm_cmd.c         |  19 +
 .../hns3/hns3_common/hclge_comm_cmd.h         |  16 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   6 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 646 +++++++++++++++++-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.h     | 643 +----------------
 .../hisilicon/hns3/hns3pf/hclge_err.c         | 434 +++++++++++-
 .../hisilicon/hns3/hns3pf/hclge_err.h         |  36 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  47 ++
 .../hisilicon/hns3/hns3pf/hclge_trace.h       |  94 +++
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  40 ++
 .../hisilicon/hns3/hns3vf/hclgevf_trace.h     |  50 ++
 12 files changed, 1386 insertions(+), 651 deletions(-)

-- 
2.30.0


