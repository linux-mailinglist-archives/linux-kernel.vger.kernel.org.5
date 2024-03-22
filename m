Return-Path: <linux-kernel+bounces-111059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAF6886776
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2051F24CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E889312E56;
	Fri, 22 Mar 2024 07:25:36 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F51119E;
	Fri, 22 Mar 2024 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092336; cv=none; b=Om336MGy7VLZtLKarbwwoVRV/9qi6i3Z7i6WJi6DVaaBZWZ6E2mzhTC1bX4WwFr1UZCpYDFApIiOKSbhyLYf7fvDReObPICfmhIslusZNRQkKEt3oq0EHH9lzQxA92i5z5hqAcBSNovWCHndGbyXYzfD8TaRu6TeMUCnMRaFL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092336; c=relaxed/simple;
	bh=jQu3KitGULF0GTxrp71MyfRYsV4/79VPg4mVWauE5Nc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=msTOkXaAoBaXGl565OFdJUBQJRLdur1BAqXvErdRcq+LwTIntBfFJMC2tszxn2LACPGj623pamtStTdQ1bxfatZnqwbp9iUKwt5MY8FD4WFDfDQ5026jpfU8BYAID8v9pWqGAEGCo6QihHhY0XKegZ03nWYdazG1rw4OmRpK3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V1DLj6hwCz2BhNQ;
	Fri, 22 Mar 2024 15:22:53 +0800 (CST)
Received: from dggpemd500003.china.huawei.com (unknown [7.185.36.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 029171A0172;
	Fri, 22 Mar 2024 15:25:29 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpemd500003.china.huawei.com (7.185.36.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 22 Mar 2024 15:25:28 +0800
From: gaoxingwang <gaoxingwang1@huawei.com>
To: <mkubecek@suse.cz>, <idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yanan@huawei.com>, <liaichun@huawei.com>
Subject: [PATCH] netlink: fix typo
Date: Fri, 22 Mar 2024 15:24:56 +0800
Message-ID: <20240322072456.1251387-1-gaoxingwang1@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd500003.china.huawei.com (7.185.36.29)

Add missing colon in coalesce_reply_cb

Fixes: ec573f209d (netlink: settings: add netlink support for coalesce tx aggr params)
Signed-off-by: gaoxingwang <gaoxingwang1@huawei.com>

Signed-off-by: gaoxingwang <gaoxingwang1@huawei.com>
---
 netlink/coalesce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/netlink/coalesce.c b/netlink/coalesce.c
index bc34d3d..bb93f9b 100644
--- a/netlink/coalesce.c
+++ b/netlink/coalesce.c
@@ -93,7 +93,7 @@ int coalesce_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES]);
 	show_u32("tx-aggr-max-frames", "tx-aggr-max-frames:\t",
 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES]);
-	show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs\t",
+	show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs:\t",
 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS]);
 	show_cr();
 
-- 
2.27.0


