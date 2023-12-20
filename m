Return-Path: <linux-kernel+bounces-7648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 866B081AB36
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA46B20FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D594B143;
	Wed, 20 Dec 2023 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ty5gjEs+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774E64AF64;
	Wed, 20 Dec 2023 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcUJX7ByYBEkedut5ASmDInXnTlfWJa6biBWgmB4+da/xQ44USthG6Xp2D3oWBVYgGGs7Q8y0xMQzIQoYYR3nt5iIV1EbU7frTma0WCJVNJLwN2xriNm40yQbVIO4XAMfA5m20uVMmlwRmLhW+AI1YbSdjIXF3cgx45EcGFiavCTfXLJqbj+wXhvBjrBFQIbLQ2GY39GyHzL7CIUGqbY2CXIN49797ecAUOO1ItFpwJFdctaUEVqAO5TEQC3t5D4wissLYhr0or8+vcqUaK4NMxwqZ7sYKvQqpjV4YlMB5673n+m7W3hMBYxFt35jHNeTjd8IsyAz2oHkxKKJekFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaW2dTWc2+3XAGXo26TktKIaKbuqfT0hs/IF6zDNT4M=;
 b=E9H8VS5je3JG3FeXXQUeTBABQ2qXVvDJwk6zeIT6kGSVJtuhgCMOJWlueoqHoy4KVZJ1g8PXRixnxGV6/5WCkieuPDujHub845cREVrAZtzLi9GM7S+xfyW/DR5HHkbFk2xMARKwQjVkLxp0nYz3Tka0nWmPpn3MrJ560Xgg0DxldbumYxEgeE+IO7IEW5vUwTwIAYnY5PR89uhm8LJjss9NZ4Pik3bw+UmCE7dUIZukwPR1GcMfwc4NZ01Cwws65rrThGW2LF1dxuEbkWyLa6v886d2n4GpknvJbvdExwwgNR0ySWCvPTHDkqBQd+GWjhrLIc0glv1vkqFCgik0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaW2dTWc2+3XAGXo26TktKIaKbuqfT0hs/IF6zDNT4M=;
 b=ty5gjEs+cR22travmniPyaPPf//c8dk6ekqrynLbWEecb4MI2CVCN7qk+XBjItioQTlN6oAoNa1Xd7IzZ9nRVg8VfGaweCqei45WYz/otiOtPLpmqcTXXJH7z7oHsevPeBceY8XmlF9pJu6ngiNZ82StK/PNCJFoH7QQT2QHjtW6odmNHY+OQHhvpatAkIg2f2QlLoSaNZLUx39xiTkPjTia9vMAAxgLmSl4cY+1cas39Cw3T4gXwkw/k0eyqOxUXtWAYG/fzNwIpqa8WwkiaG5+apy9vBHIoLzeoBnlUXhvRroHgjp2RRgK99dV42YakDlP7BcdRH7wmIYR1dgkFw==
Received: from CYXPR02CA0077.namprd02.prod.outlook.com (2603:10b6:930:ce::25)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 23:47:51 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::f9) by CYXPR02CA0077.outlook.office365.com
 (2603:10b6:930:ce::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19 via Frontend
 Transport; Wed, 20 Dec 2023 23:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.20 via Frontend Transport; Wed, 20 Dec 2023 23:47:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Dec
 2023 15:47:46 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 20 Dec 2023 15:47:46 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Wed, 20 Dec
 2023 15:47:45 -0800
From: David Thompson <davthompson@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tbogendoerfer@suse.de>, <horms@kernel.org>
CC: <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH net v2] mlxbf_gige: fix receive packet race condition
Date: Wed, 20 Dec 2023 18:47:39 -0500
Message-ID: <20231220234739.13753-1-davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 496fdd6b-7b27-4fdc-36bd-08dc01b613c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nPmOUO+v5bNxiICRw0lKa/tEPdiHz60bR8hbI3eFjFvsN1xtcYnbOA/zvg06pWaDiGnA4oJTuouGNLfQGjunFmq3vYcHcVI9AmBT4cjFysKUDkJNKwEOmxXPs7sk7JBh4Rera7geYVcAfMNoHHf5+LaAsn3PWaixo6o7cPuUsNkF32itdfOWbxvRiSIjLfM7JKi2ADRkC6kBSjUJxDhQsPWAqJv/YAxAHWEKzClrgEnI8TekxExYvbuAUt3HPgDfaGIUCFDdJClg2QcHh/u8ztK3kjkVnzTj+xCq5j3hyyMyf53fWr1KeWfHSIuhriVqRCVckbReoFYDTekAgeGEsArjyn0LvAflxm/DpstnVhvQdvYsT1EGzlmM9DOWxDWnPyYccICkq50D0FZFDwc7muTYi3Nogvzb0ove3RuBvaDsl+gxxqjAd65Ydijhkdq66ERxepOD63Akjil11AlfThrTz3oFXnIRUFUgUdU+pYZfqMxwhoJQLJ61Vg8wU9tPVxWhGhwuHiiEshG0cmmzay65pyX44UiR8QqgNSDLb86k9iEWgCHA1i7yyiCS2VACVfj3MDPqNpSIlBmkH/PZ+eYVPank0DYfGrHujVQuF9r0mPH4SbzJ92xzovw+FJo3Y/i+ZcvVXo3fD6BxSfF2Omwv3KycYgvw4avwrWTUhdlLRFY4jy8Kex+8X5c5K9nzVO61itI1sW6V2Zj7Nu7gJ+sEf4A7+mDX1cjeWNcNqVZSsQ4+jxEonRvhg3ZRdHwv
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(1076003)(4326008)(426003)(83380400001)(7696005)(5660300002)(336012)(54906003)(110136005)(26005)(8676002)(8936002)(70206006)(70586007)(2616005)(107886003)(316002)(478600001)(36860700001)(7636003)(36756003)(356005)(6666004)(82740400003)(47076005)(2906002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 23:47:50.5869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496fdd6b-7b27-4fdc-36bd-08dc01b613c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009

Under heavy traffic, the BlueField Gigabit interface can
become unresponsive. This is due to a possible race condition
in the mlxbf_gige_rx_packet function, where the function exits
with producer and consumer indices equal but there are remaining
packet(s) to be processed. In order to prevent this situation,
read receive consumer index *before* the HW replenish so that
the mlxbf_gige_rx_packet function returns an accurate return
value even if a packet is received into just-replenished buffer
prior to exiting this routine. If the just-replenished buffer
is received and occupies the last RX ring entry, the interface
would not recover and instead would encounter RX packet drops
related to internal buffer shortages since the driver RX logic
is not being triggered to drain the RX ring. This patch will
address and prevent this "ring full" condition.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
v2
* removed logic that affected RX_DMA enable/disable
---
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
index 0d5a41a2ae01..227d01cace3f 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
@@ -267,6 +267,13 @@ static bool mlxbf_gige_rx_packet(struct mlxbf_gige *priv, int *rx_pkts)
 		priv->stats.rx_truncate_errors++;
 	}
 
+	/* Read receive consumer index before replenish so that this routine
+	 * returns accurate return value even if packet is received into
+	 * just-replenished buffer prior to exiting this routine.
+	 */
+	rx_ci = readq(priv->base + MLXBF_GIGE_RX_CQE_PACKET_CI);
+	rx_ci_rem = rx_ci % priv->rx_q_entries;
+
 	/* Let hardware know we've replenished one buffer */
 	rx_pi++;
 
@@ -279,8 +286,6 @@ static bool mlxbf_gige_rx_packet(struct mlxbf_gige *priv, int *rx_pkts)
 	rx_pi_rem = rx_pi % priv->rx_q_entries;
 	if (rx_pi_rem == 0)
 		priv->valid_polarity ^= 1;
-	rx_ci = readq(priv->base + MLXBF_GIGE_RX_CQE_PACKET_CI);
-	rx_ci_rem = rx_ci % priv->rx_q_entries;
 
 	if (skb)
 		netif_receive_skb(skb);
-- 
2.30.1


