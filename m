Return-Path: <linux-kernel+bounces-28936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F338304DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062241F25467
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3711DFE1;
	Wed, 17 Jan 2024 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="CQnGMhrf"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2741DFC8;
	Wed, 17 Jan 2024 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493012; cv=fail; b=Y72/9hOT3MrlDKPHhA88XQqswxZToRiyToMXKLZ4AtZBSfAu2h2LHLQBNZtFbAVq3/IM0w547vqzRTGYvq+yqrBKY1FbI5Df9LBXmt7VriuLy4PVTWbTaWQksctoGYFPtgjaIdzIWw6ZPS5UdpUv2SA8IboVJ5c9STkciN1mF+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493012; c=relaxed/simple;
	bh=hnbQpFysn4Yku2xcjGs7E/r9j6QrAl4CEsCWG13KSpk=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:To:CC:X-Mailer:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=Q/zZW3w458gToZZ7pcAL9AEyR58KexihWbG4eOqnWy1GI4DA1IiQ1Z3WBGijVTQznApt7oZZgqjfV+b8llWlDvZ5UgcInfcCZNJtB3ym1k/58hBNJG/AhVKwq3J40+tZpBx6gRhjsiN64st8CpKyJNyWqzkY6p05Ly5Sn3ASq3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=CQnGMhrf; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0Xd+BmOUfgBuSHWsqBkpG0QPxUOLMLGlS8KqYMiCBkil9j4wZ6iJr9bC71yGCgKoYDflUlwTQCzZu3fEU774d8ydAOK0vyggu59qKRMmHLZL4WrVU0pKqQKuvRHZD+qpdX9KKMbDlKYVwKLtzxkhPTiXfqFQulQuMphK2ee8cUPITMIotnGYJFp4KJP7FKqKcGgpY0Sb9boIweVrwxCZYOBNpUHngUyKvEkedZVJTHim9zNDSxZRuVmIyf93nplTG2CLQhZuAjhlvwQttSEa7WetCVeZwu7MXTEJZwd+uZIYfiVJeuBI/y3FZUULYqYSlmXwl+M+mKWtctnpJV3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TlkXZOeV/7BChg+MIZ3Sw1YERTLBQiWXUotyxy4Av0=;
 b=DQX5aKhWMlviWuN9vl6qdwzL6hXYR04wS0pAUWLakoYD+F7/h8wcee3eRZZGFncxGtG64QxzH6o//A151+gIGV51oMHjrtozfC6siekalzKbklO5eYfq/V23o9dDwngdI3crO8M1d6avwAwYIn3cHkpXbhj4j7FuO78zBSnz4l81cm8lv/hGG2m7d8qTb8L9+u9FB7PPO42G5IPesNpWPKqZhxabzyEbwpE00sGYHNDHi3EIvUeZ7XmCzr35BsDPm97tMQ3xC6MHdE2M7XSECrlGiA737um+z+m+EMojkPHm+e6lin00lCiVjnKes83enxC/np7CfGyGYrHtKsJAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=davemloft.net smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TlkXZOeV/7BChg+MIZ3Sw1YERTLBQiWXUotyxy4Av0=;
 b=CQnGMhrfmLXDqQ8RMblAaRgfNQxQzipusvF/LCEQ5SIuqubg3h65ZC6NenSzrH91k+QdUdDNczHkROQhkzQGjRSYlTg1221whxc+RH7b7f5MBx22/RqXl+Lhd2MSGLk12EW1yeisjSYCd/T+peLqQlOPbDFuU1pxqmGu4OjywiI=
Received: from AS9PR04CA0125.eurprd04.prod.outlook.com (2603:10a6:20b:531::16)
 by DB4PR02MB9600.eurprd02.prod.outlook.com (2603:10a6:10:3f0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 12:03:26 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:20b:531:cafe::50) by AS9PR04CA0125.outlook.office365.com
 (2603:10a6:20b:531::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 12:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 12:03:25 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 Jan
 2024 13:03:25 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 Jan 2024 13:03:25 +0100
Received: from pc44637-2125.se.axis.com (pc44637-2125.se.axis.com [10.92.125.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 7D3B912529;
	Wed, 17 Jan 2024 13:03:25 +0100 (CET)
Received: by pc44637-2125.se.axis.com (Postfix, from userid 15765)
	id 772064128B9B; Wed, 17 Jan 2024 13:03:25 +0100 (CET)
From: =?utf-8?q?Ludvig_P=C3=A4rsson?= <ludvig.parsson@axis.com>
Date: Wed, 17 Jan 2024 13:03:14 +0100
Subject: [PATCH net v2] ethtool: netlink: Add missing
 ethnl_ops_begin/complete
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240117-etht2-v2-1-1a96b6e8c650@axis.com>
X-B4-Tracking: v=1; b=H4sIAALCp2UC/12MwQ7CIBAFf6XZsxhAGtCT/2F6gLqVPQgGCKlp+
 HcJR4/z3mQOyJgIM9ymAxJWyhRDB3maYPU2vJDRszNILhUX3DAsvkgmnVSzQnPRqKG7n4Qb7aP
 zgIAFlj56yiWm72hXMa6/TBVMMIfWXWc0fNN4tzvl8xrfsLTWfutZgjeeAAAA
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, =?utf-8?q?Ludvig_P=C3=A4rsson?= <ludvig.parsson@axis.com>
X-Mailer: b4 0.12.4
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|DB4PR02MB9600:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f93a61d-c7fb-4bfd-8118-08dc17544f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4poczvKIBYzggpEHRkgt/WLSlYVBVeJQQmHWfEEjEwrMF/mXFeWLKZX+j9uwEe/UJZsbV3YxXa48pQl+QV40g9EMe4C4tDVmXvBY2t6Sht2eFeevoWWZXUvudlRy3KRwHqMobdtBtV2tlCwIFgGOD0aBtyfePucXPC+AzNLUFFXT2V72/1wVUzKvEBxxi4pt/TW60z1D1CSIuOre0o4ucMnUc4e8qyiczgltfTfptXtOwIhzDFRpbMgjIhBfUV8cSMJWg/TiyH3AC22Y3c2xkoP+xvaNXvKlP6egTaCdUAcFJcEaUOz5N/ByR5ojIw/V3zIuFSJgSYVsGuZGj/3874fzC1tDnD5obfFqHYagtCV5xaTJhbJLgawJgF+R69sQLIv3f26etsa0ZdvzmewdS1wTRSA4+btgt30LXSv2zLXiueHNhMaPXZ9FQeHHcsjtX2wmq+Fb43dbPbB3QG9Nlh+r73gThineDgAHEnHyj/gKtfo7SMLnyjSLEk2cjeWzaEHOse6Q8n1kwFifItrZfn4VyJYVlY9Vo/uqFAotwGbtgeKe5jgojyvN8Ybz5aO80KRw6XxsQQRW2UHqFy9+JsAul7MmBQtNilS4i4K3v08pLzBuh2UNrUZ13GFbJw0NEbeIEfvLooGfIhpeZrlbP2VilUjVApUxmf/AOJz5f3V8uf0phwAYlod1aR9tf9V70JMRDwR4RWFArJAX4v4unLfQCPm8ZicMMIv3tt0PyjpptmyaQRzEhTP2WSyHz8Jw7K24nM3AFJj0UsM4HBPrzQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(8676002)(4326008)(8936002)(2906002)(5660300002)(6666004)(316002)(42186006)(54906003)(70586007)(70206006)(966005)(478600001)(41300700001)(36860700001)(47076005)(86362001)(356005)(82740400003)(110136005)(81166007)(40480700001)(40460700003)(66574015)(107886003)(26005)(2616005)(426003)(336012)(6266002)(36756003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 12:03:25.9082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f93a61d-c7fb-4bfd-8118-08dc17544f91
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB9600

Accessing an ethernet device that is powered off or clock gated might
cause the CPU to hang. Add ethnl_ops_begin/complete in
ethnl_set_features() to protect against this.

Fixes: 0980bfcd6954 ("ethtool: set netdev features with FEATURES_SET request")
Signed-off-by: Ludvig Pärsson <ludvig.parsson@axis.com>
---
Changes in v2:
- Add Fixes tag.
- Link to v1: https://lore.kernel.org/r/20240108-etht2-v1-1-beab95e80f7e@axis.com
---
 net/ethtool/features.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/features.c b/net/ethtool/features.c
index a79af8c25a07..b6cb101d7f19 100644
--- a/net/ethtool/features.c
+++ b/net/ethtool/features.c
@@ -234,17 +234,20 @@ int ethnl_set_features(struct sk_buff *skb, struct genl_info *info)
 	dev = req_info.dev;
 
 	rtnl_lock();
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		goto out_rtnl;
 	ethnl_features_to_bitmap(old_active, dev->features);
 	ethnl_features_to_bitmap(old_wanted, dev->wanted_features);
 	ret = ethnl_parse_bitset(req_wanted, req_mask, NETDEV_FEATURE_COUNT,
 				 tb[ETHTOOL_A_FEATURES_WANTED],
 				 netdev_features_strings, info->extack);
 	if (ret < 0)
-		goto out_rtnl;
+		goto out_ops;
 	if (ethnl_bitmap_to_features(req_mask) & ~NETIF_F_ETHTOOL_BITS) {
 		GENL_SET_ERR_MSG(info, "attempt to change non-ethtool features");
 		ret = -EINVAL;
-		goto out_rtnl;
+		goto out_ops;
 	}
 
 	/* set req_wanted bits not in req_mask from old_wanted */
@@ -281,6 +284,8 @@ int ethnl_set_features(struct sk_buff *skb, struct genl_info *info)
 	if (mod)
 		netdev_features_change(dev);
 
+out_ops:
+	ethnl_ops_complete(dev);
 out_rtnl:
 	rtnl_unlock();
 	ethnl_parse_header_dev_put(&req_info);

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240108-etht2-2b2454e837e7

Best regards,
-- 
Ludvig Pärsson <ludvig.parsson@axis.com>


