Return-Path: <linux-kernel+bounces-112249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2381688776A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2881F22907
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4CAC2D0;
	Sat, 23 Mar 2024 07:27:48 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644EB523A;
	Sat, 23 Mar 2024 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711178868; cv=none; b=LbuJwDv9p/0gghxghxDFF5Wdr8L1a5xBRMBj0Q82jmkZpq2Co6BOz1kC4osItobherPyoYCCFOu89sDLWpdjOOGtXhqI7t4Rru81dXBcJOufLOVoNhCi03XxIDwhnUqcdmFOcpN1yqrue+GG7w60j/CFA33FY8ujuJF0h/4Z1H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711178868; c=relaxed/simple;
	bh=A7iLegrAwEYBCF7LSMEZXbChtdJdTBbMPN3RLiGEuWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egMwJExG8gGqbkaml93vSOwq8omEWToOEBDgH7rkMN7mvf2ZIEjXxMAc/xjNc1swToFVoQkiaB3Dv7hbS30cKkPH8A9FKfTMWJagytLV/lwt2he1dGUZ+6NxLEUvhQWqivJpeGQfJUNhycI2JUFEVQJficHlPwkbukRATlO3qOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V1rLZ5ZCYzXj9L;
	Sat, 23 Mar 2024 15:24:54 +0800 (CST)
Received: from dggpemd500003.china.huawei.com (unknown [7.185.36.29])
	by mail.maildlp.com (Postfix) with ESMTPS id A28261400D7;
	Sat, 23 Mar 2024 15:27:35 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpemd500003.china.huawei.com (7.185.36.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 23 Mar 2024 15:27:35 +0800
From: gaoxingwang <gaoxingwang1@huawei.com>
To: <gaoxingwang1@huawei.com>
CC: <idosch@nvidia.com>, <jiri@resnulli.us>, <liaichun@huawei.com>,
	<linux-kernel@vger.kernel.org>, <mkubecek@suse.cz>, <netdev@vger.kernel.org>,
	<yanan@huawei.com>
Subject: [PATCH ethtool-next] netlink: fix typo in coalesce_reply_cb()
Date: Sat, 23 Mar 2024 15:27:02 +0800
Message-ID: <20240323072702.2102610-1-gaoxingwang1@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240323071627.2095986-1-gaoxingwang1@huawei.com>
References: <20240323071627.2095986-1-gaoxingwang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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


