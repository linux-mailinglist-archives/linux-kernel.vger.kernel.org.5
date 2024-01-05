Return-Path: <linux-kernel+bounces-18028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30F2825770
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA171F23CA8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A552E831;
	Fri,  5 Jan 2024 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="itvsjfFf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124BE2E821;
	Fri,  5 Jan 2024 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBIIbcv4ihec6knCdJ5AG8ofTNwD36kS6h9WiDe4QKIdoE/wLt/RhPiahRK4+jIZD0EQ0VfxXhscdm9hSkPdNhRLBcx9N1ZpHIBxI6JUs2sYdipJBJFKfoug3qXEZ/sX0l7ofLRBAcQ7HlfwOFpIJRWwUGwMk51phq7KjKxvglFAoQo1ftgBIvteaI0J1T+sawTHvLmihiiKyOcStN7E+UOS2OPYwWSCAKjfTTVN2VInQW2HdLjq6kVpHYB9gb6BguEAg3cDx42aLoW0M/NlDmNcyrMyNK6vAkecOPaPP7PVivj6SsLvxs9U0MLmynbKQvb+UKtE6m1M3QYao8CrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XMpEgwyzWdp/e+b5mhwFJQ4OWGBvQypJUiKX2EKqlM=;
 b=lZi1h/7Yy2WmaDbxtHz9S7jvBlvlbvOt0lZceCGJrqnITy2ikV/ronMbozrdmlWDNgGOTZLhtfrAiAsinztYYJlHV8nJw0fGFrzzGkEE4f/BQSRyl8N40/E9lHKbhNJj3NZgYCdkgKgVhn3FC5MTijDdhcEN0rQ/pDFbQrvO1STIhGsNseagasaWNPiQ9TQUpGtXqKf3unX1oEPzCjbi9FANKToIUzu5lLC4Fwvt2ox7ndb5B0c9jC0ACmgasNkNt3ZpQx4c0lPP8SJr2t3Y776opuX2lQicJmKMLCQnSb1t2fLgRE5RZ4300GIYAkYOxQ/JZCO0Y2UFE47Ah8rqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XMpEgwyzWdp/e+b5mhwFJQ4OWGBvQypJUiKX2EKqlM=;
 b=itvsjfFfM0gdP8wyfn+O08U3iFc3ISJXy93ZVSyhMuNiZ4F38+o283ExtJiCqtv53uvkSTJcwWzxf0j97BFTFbm31IWrKoccTUiBWyjMLTr/aejQ3Jfn81UNc4t4L/+5M3xULUI/gya6HYG9ia4G9892eDlAYvgfH4TG9VWhOVoisNhIGn4e774l3ifJj1quolD9nXKOxxxsNLBBDHG8q+BonMDit+YG8xUUakssTnWIDstxNQOBCXCmCjKAiMIIyI6a6mDnG1cRIyZOR1dAlWcfgOyqeREjzGdtDhZF4CmDMBV7kJNqKsh95S7ZbIT/OXIxMKX9cVnfxoe7+0zNkg==
Received: from DM6PR18CA0015.namprd18.prod.outlook.com (2603:10b6:5:15b::28)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 16:00:04 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::1) by DM6PR18CA0015.outlook.office365.com
 (2603:10b6:5:15b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24 via Frontend
 Transport; Fri, 5 Jan 2024 16:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 16:00:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 5 Jan 2024
 07:59:50 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 5 Jan 2024 07:59:50 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Fri, 5 Jan 2024 07:59:48 -0800
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <f.fainelli@gmail.com>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <tbogendoerfer@suse.de>,
	<horms@kernel.org>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <davthompson@nvidia.com>
Subject: [PATCH net v4] mlxbf_gige: Fix intermittent no ip issue
Date: Fri, 5 Jan 2024 10:59:46 -0500
Message-ID: <20240105155946.23121-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef02b20-c3da-4175-979e-08dc0e076166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pp1qD6b8QkFPAjqPzwHMqqfpMbVJP11d9rEPE/MEYS/7PB71dON9UAqYp/fBah4QNJpJUDnhkR5OlfDwhz0GWvo/QS7EQAaw2APhEOBSnyj/Pd0tB0+eE8ZmdmcWNrso2Wnm/0/6AH20HyXpU14BE9Q21Q0ZWAbH18clwwR5eYySRAgufuEw+dssIst3WQOdv/fmhYOyXzotdKKCYVvNhIoF0iB5+Ao5ggcs72GStsdPK0xZ94AanhxBksi8KfIvD576ZoInYZX42xWmiSXHYLlNeJUQ1l7SIn9Fy7GAK7eNg4v8vOkQGRWfm9SfdskZixi3b6LzlAQu7vUAYngq/qvFjLIOO9CwKi2lIELFh9Pq2QftyiJn4/1fTwyTDu6U7Rk1ok52IPgdgc9yKjYrFGu43IJjZQ/3CfFf6M+v2S8KVmz0L2t0pYx6tzd3ITtS5PpN6Xr4a9abXwDmDgzgkahNzuJB0pUh8bHlnOEP0VJrQGgoDMIkKhDBcfwpdFp0DEbi7DzrsQtxDXTrbBYHzkSj6lKv3jWHY3+aOYHuQNk9Iaxcrs/mf1FjiQuBdxIozzZdHHUismTYs24fwd4a+2j8js2mXb7ZUrTX1tCBUUJgd9anbdODsluFrxuVIBJ4ztyPp0l3O8WgTvx62RznnogjhJ+PHjCvNrJ/t4FyauYp6zk3xUhKXzL+YYSXzPro0T7RXud/wW/+Of5Wse7/9nSaK9YOqhFADok+Yy+LgCEPN6+eMFVP3H85Fz/Kj3VC
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(46966006)(36840700001)(40470700004)(82740400003)(36860700001)(47076005)(86362001)(356005)(7636003)(41300700001)(478600001)(2906002)(5660300002)(7696005)(336012)(83380400001)(426003)(110136005)(1076003)(2616005)(26005)(8936002)(54906003)(8676002)(316002)(4326008)(107886003)(70206006)(70586007)(36756003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 16:00:04.0034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef02b20-c3da-4175-979e-08dc0e076166
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966

Although the link is up, there is no ip assigned on setups with high background
traffic. Nothing is transmitted nor received. The RX error count keeps on
increasing. After several minutes, the RX error count stagnates and the
GigE interface finally gets an ip.

The issue is that mlxbf_gige_rx_init() is called before phy_start().
As soon as the RX DMA is enabled in mlxbf_gige_rx_init(), the RX CI reaches the max
of 128, and becomes equal to RX PI. RX CI doesn't decrease since the code hasn't
ran phy_start yet.
Bring the PHY up before starting the RX.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
v3->v4:
- rebase
- Fork this patch from bundle of unrelated bug fixes.
- update the subject format

 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c | 14 +++++++-------
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index b3adc491bdb9..3385cf1ef9ae 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -147,14 +147,14 @@ static int mlxbf_gige_open(struct net_device *netdev)
 	 */
 	priv->valid_polarity = 0;
 
-	err = mlxbf_gige_rx_init(priv);
+	phy_start(phydev);
+
+	err = mlxbf_gige_tx_init(priv);
 	if (err)
 		goto free_irqs;
-	err = mlxbf_gige_tx_init(priv);
+	err = mlxbf_gige_rx_init(priv);
 	if (err)
-		goto rx_deinit;
-
-	phy_start(phydev);
+		goto tx_deinit;
 
 	netif_napi_add(netdev, &priv->napi, mlxbf_gige_poll);
 	napi_enable(&priv->napi);
@@ -176,8 +176,8 @@ static int mlxbf_gige_open(struct net_device *netdev)
 
 	return 0;
 
-rx_deinit:
-	mlxbf_gige_rx_deinit(priv);
+tx_deinit:
+	mlxbf_gige_tx_deinit(priv);
 
 free_irqs:
 	mlxbf_gige_free_irqs(priv);
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
index 0d5a41a2ae01..a65fe026e1e6 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
@@ -142,6 +142,9 @@ int mlxbf_gige_rx_init(struct mlxbf_gige *priv)
 	writeq(MLXBF_GIGE_RX_MAC_FILTER_COUNT_PASS_EN,
 	       priv->base + MLXBF_GIGE_RX_MAC_FILTER_COUNT_PASS);
 
+	writeq(ilog2(priv->rx_q_entries),
+	       priv->base + MLXBF_GIGE_RX_WQE_SIZE_LOG2);
+
 	/* Clear MLXBF_GIGE_INT_MASK 'receive pkt' bit to
 	 * indicate readiness to receive interrupts
 	 */
@@ -154,9 +157,6 @@ int mlxbf_gige_rx_init(struct mlxbf_gige *priv)
 	data |= MLXBF_GIGE_RX_DMA_EN;
 	writeq(data, priv->base + MLXBF_GIGE_RX_DMA);
 
-	writeq(ilog2(priv->rx_q_entries),
-	       priv->base + MLXBF_GIGE_RX_WQE_SIZE_LOG2);
-
 	return 0;
 
 free_wqe_and_skb:
-- 
2.30.1


