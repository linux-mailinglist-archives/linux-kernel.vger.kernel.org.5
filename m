Return-Path: <linux-kernel+bounces-19744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CE48272C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901921F236CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D564C3D3;
	Mon,  8 Jan 2024 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="YhaZ2Khv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9968E5100F;
	Mon,  8 Jan 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wnt1Nw7ePBfYxMr7KbehX/s2F5Rq6xGBWwuWBs5lkSeDVLIUTG5hD7UX+1h154DJgrWNkcOxR+RWYi8p0+r3vNvelRfzXGsyOL1hR2OuLXR3SjcM+RG0b+nTsCJTjrXXXcCeeg5cgy4PWQG9+9dWfLsMvziwBX2vwWc04Wjge8x3sh3cj+nyffDYy0r6RCIGi/p5c6W80ger6gkmuN2f8T4N6g53YkdYrRCkNetYHVZxm8mQJFtNN8BQtkZY2KjY3eANHhWFnNcnlPFcqNecAwY8+NZq1CygQtlsutzqU9df+yF/M9TQokRPztXJOBme5zeCpe1urxQ8d8Yk751SPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R78t8OXNKNsy6Y4msFJJjhavc0E1CuNf8zfndHf9fd8=;
 b=SZRPKwCF9deo7gThRN/17YgoyYLj60iprMpZTtdDQzJiOJ0z1c3HMv9KkNKVWfTi3a6zIr2o07WOFy/zB9oyIoWmoTbQwnS9rIlHVgwxzZSx0sr2EtVa9GnkuGYmRAcRActVb8OaLxnT3T5o/SJ1NPTI9PJ6LXjqdhZXQM1ktwsQ5Dts5NhjvdF7BCFsQE4iOCfAkNpjcJ2WKMRcZZVDV+PlptEsmHwkvXsarp+uqxcQCNRaKFhY+eU1GsKlhn1ujrYbpvEf7KrOGZDOKe33deb6UrTBj0y4K7RCQSos6+ewQd5HvxIvKge+UbLb8Zp+g/7ozsj5GYQSPl4nWtqZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=davemloft.net smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R78t8OXNKNsy6Y4msFJJjhavc0E1CuNf8zfndHf9fd8=;
 b=YhaZ2KhvUmw1EbyIzErssuU7npFdIAjz1S/5k3GBN+36zTS7FZlN4PEfgN/Ar0CfSJP5MyfNpX1V+Z7CRNLlAo8Ol/tsP7EjmSyXwvHYmyr/vKOW6CV2nxhLiOFrzjW7rB7vktQv5mq7a50A4WgWUmI07VfbgF/DcfuJCPtBA9Y=
Received: from AS4PR10CA0030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::11)
 by DU0PR02MB8340.eurprd02.prod.outlook.com (2603:10a6:10:3b8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 15:17:27 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::6b) by AS4PR10CA0030.outlook.office365.com
 (2603:10a6:20b:5d8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 15:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 15:17:26 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 Jan
 2024 16:17:26 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 Jan
 2024 16:17:26 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 8 Jan 2024 16:17:26 +0100
Received: from pc44637-2125.se.axis.com (pc44637-2125.se.axis.com [10.92.125.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 0DCCB11B2E;
	Mon,  8 Jan 2024 16:17:26 +0100 (CET)
Received: by pc44637-2125.se.axis.com (Postfix, from userid 15765)
	id 081704128B97; Mon,  8 Jan 2024 16:17:26 +0100 (CET)
From: =?utf-8?q?Ludvig_P=C3=A4rsson?= <ludvig.parsson@axis.com>
Date: Mon, 8 Jan 2024 16:17:19 +0100
Subject: [PATCH net] ethtool: netlink: Add missing ethnl_ops_begin/complete
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240108-etht2-v1-1-beab95e80f7e@axis.com>
X-B4-Tracking: v=1; b=H4sIAP4RnGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQwML3dSSjBIjXaMkIxNTk1QLY/NUcyWg2oKi1LTMCrA50Up5qSVKsbW
 1AE3ceD5cAAAA
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, =?utf-8?q?Ludvig_P=C3=A4rsson?= <ludvig.parsson@axis.com>
X-Mailer: b4 0.12.4
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5E:EE_|DU0PR02MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf6d4cc-0bd5-4b1a-713f-08dc105cec31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZGN2ByNtUws00g3BjdCoOLVlb5/dzCN6ucTEB9GmKZ76UPbDKNPIwdS8n5zrb0VfjOWOjg0g9vutsTGPpX6Wi5qaVelQ12zuWXErCcZLdX3Ih/KwO8YgbuB0ErDLxWtIAC5W+gRNPkADsRd5GRvBCaKslCbMQZ167iGFQq8+pqVF+/cngmu3uYrXOWYlolVUY6wBUSRPAnfgt46++eoh02flX91KNbTwy3nIG98Xb3dMnxSuv2Yyt3B7qp2JTRxB7xfjzRrH6jmWIbFyJaESzMg4pdggxBwYCROp2uDwwhblbFUGYNXcywtNg8W9UosHpfpZtGouGX48MNBty6vbsgM3tvAzfZdIO2Kl2wNAhV/zlC2Qh4vsSz7tH9h34O5UxJuAz3bffw2W1JYCCFWTWdfpZXuF3d3msezryk0WG0vL3sqb6taq6LJ/Srb+bMVHuU3s8ikB5IDH6LHFjpu3BjcuN5Ooc8HJHXAjU7Znc6kOq14RZQ9mF6s5QTcOuyaZOLzAsMOBNjzXPAViuH0B5lNc+SLvKkXbScirE/8NYPTqP1p4rsIBt9/bUjhqp0qyyvzxQAGbhozxTjYFNjPj2ncxheV11WlrLTwwNXrqP4xi303N5Ck3hMyuhneG4yTd/jHXzdYZWQYUfwS75X1DFk67Qnambgb9rd4SI3Qz4c6qx7zs6SlycMF2T1Qm27TH4/Gows7e2J+ty44SiIkI12lADktu9LPe1UmXvonJaXMygMBZKFPErBCgISQj/TxtGA1V94qTvPbfdgbLWyZ/CQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(6266002)(26005)(2616005)(426003)(336012)(6666004)(478600001)(82740400003)(36756003)(36860700001)(86362001)(356005)(81166007)(2906002)(5660300002)(41300700001)(47076005)(83380400001)(66574015)(107886003)(8676002)(110136005)(70586007)(54906003)(42186006)(4326008)(70206006)(316002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:17:26.4997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf6d4cc-0bd5-4b1a-713f-08dc105cec31
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8340

Accessing an ethernet device that is powered off or clock gated might
cause the CPU to hang. Add ethnl_ops_begin/complete in
ethnl_set_features() to protect against this.

Signed-off-by: Ludvig Pärsson <ludvig.parsson@axis.com>
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


