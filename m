Return-Path: <linux-kernel+bounces-127911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052AC8952B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7578CB25330
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EACF7764E;
	Tue,  2 Apr 2024 12:17:01 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA3E3D547;
	Tue,  2 Apr 2024 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060221; cv=none; b=n8m5xprMTXXO+Sb4vkwUmgUmnLs+QrO8+XoIgSS8+3vv147ZoexZhNWqaIP6AKzkAmxHQIqJj3KA1ern0EP3ivlnZluMyAcL+zKW+CJVCp0+THyUYh6I1CJThhpO0u3X433Ud5ktfYDG45MKouAGsbnYcysGIkVLKjwrl1bb0/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060221; c=relaxed/simple;
	bh=A7iLegrAwEYBCF7LSMEZXbChtdJdTBbMPN3RLiGEuWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dO5eycJk8MVU7ZaFVphIzcx0SVHEicvib5mi/jSHti1YBZwqncmflC4A0uahPOiBCi2MIQ425plugjbWqmJfHUda2ldcx3AaVcFJJJziMP4VTyXubYNhFkSkiW1rP9yqlkTCGFxYxshFG/HI3D8FniiK7fhvroFzdddO45CpOKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V86Hk6WNWz1h4k5;
	Tue,  2 Apr 2024 20:14:10 +0800 (CST)
Received: from dggpemd500003.china.huawei.com (unknown [7.185.36.29])
	by mail.maildlp.com (Postfix) with ESMTPS id A005A1A016C;
	Tue,  2 Apr 2024 20:16:55 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpemd500003.china.huawei.com (7.185.36.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 2 Apr 2024 20:16:55 +0800
From: gaoxingwang <gaoxingwang1@huawei.com>
To: <jiri@resnulli.us>, <mkubecek@suse.cz>
CC: <gaoxingwang1@huawei.com>, <idosch@nvidia.com>, <kuba@kernel.org>,
	<liaichun@huawei.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <yanan@huawei.com>
Subject: [PATCH ethtool-next] netlink: fix typo in coalesce_reply_cb()
Date: Tue, 2 Apr 2024 20:16:18 +0800
Message-ID: <20240402121618.3575706-1-gaoxingwang1@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <ZgvpKNFcBw-39SOD@nanopsycho>
References: <ZgvpKNFcBw-39SOD@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd500003.china.huawei.com (7.185.36.29)

Add missing colon in coalesce_reply_cb()

Fixes: ec573f209dfd (netlink: settings: add netlink support for coalesce tx aggr params)
Signed-off-by: Gao Xingwang <gaoxingwang1@huawei.com>
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


