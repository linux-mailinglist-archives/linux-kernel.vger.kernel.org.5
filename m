Return-Path: <linux-kernel+bounces-104245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F340E87CB2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E4CB2308D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9CB18E29;
	Fri, 15 Mar 2024 10:12:25 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC918AEE;
	Fri, 15 Mar 2024 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497545; cv=none; b=IzfLQSxWnLuFyVl67KwDWgniD/vWZXsJ6MutU4PBjwK0tP/us+fmjNWvm4BAAQ6h0+wqJ/hdii+hzT0v4961WRYOoPxJ8a3TXp+Gff08cOUSeN2QNcbxRuopwgCW0VYKoM9DZA7tQcY/NFcDxSJATn1TLwz0CBAHMnyUKcXeMLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497545; c=relaxed/simple;
	bh=CbuDnbaCrp/uLDAVQ+6BHKStFdlC4iTclbuSm70T/Wo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l2VfyJ3v7nbqomaH2tKeqBFSdCl16kAd21/cyqOhdLd0kKwuUguSo193GF6MWwWOquSQkdWhkavD06d3hFl56+fk9okQOY0U4EduFRcnsB1tQDNCh/K4XzQTqfsSI2Zxn/wUwGEV9VOLa4fWLbWsKPAWyzFv7uzdiASCPxtUt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Tx0QW0ycHz1vwMH;
	Fri, 15 Mar 2024 18:11:31 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 365E0180061;
	Fri, 15 Mar 2024 18:12:15 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 18:12:14 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/3] There are some bugfix for the HNS3 ethernet driver
Date: Fri, 15 Mar 2024 18:07:45 +0800
Message-ID: <20240315100748.2913882-1-shaojijie@huawei.com>
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

Jian Shen (1):
  net: hns3: mark unexcuted loopback test result as UNEXECUTED

Jie Wang (1):
  net: hns3: fix index limit to support all queue stats

Yonglong Liu (1):
  net: hns3: fix kernel crash when devlink reload during pf
    initialization

 .../hns3/hns3_common/hclge_comm_tqp_stats.c      |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3_ethtool.c   | 16 +++++++++++++++-
 .../hisilicon/hns3/hns3pf/hclge_devlink.c        |  5 +++--
 3 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.30.0


