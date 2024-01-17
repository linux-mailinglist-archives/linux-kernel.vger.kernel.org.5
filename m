Return-Path: <linux-kernel+bounces-28808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910C0830338
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7941C24DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D7D1DDF8;
	Wed, 17 Jan 2024 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nCRdVnzw"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709699467;
	Wed, 17 Jan 2024 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485868; cv=fail; b=HyUG/9FFgPu2f6NG4Ieo32w2bsAJtticdzpZyVl0/0sjHVERQ6baMR45fA33pWj3vMbnUTbpMHXUELkneKpsBEFAzOd0EluasfvzEJHqV+r3+pnTxWGjoHXKr50CjDuVlGqtHJbxIEFY3USdrBWM5I/xI6vWbKcq9MCF4CssG8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485868; c=relaxed/simple;
	bh=D5SdNyQsRGlbMwwNJSxG8SVSf5nbs9/RkOcWtBvfDmc=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=HhkEFVsWyi9P09Dd2Z1XLczJQUAFFcN8iFbsg6JOKcuJV/1hzgQ3tcJ8ri6Z8o1WTJvPFgJlatwR6qMDyj06AoXqRplp6+I4T1dVGyQ9xrj2pM/P7zs8EUMZDZEqL080JcTmzE1A9iLT9A571SPxfXQsIGI+C2S0MN4VRytSInQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nCRdVnzw; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOtOg8EEU+4WZvHecNPhjxdj+OoGLeDKvPSRL0AFbID+bbE2oTjsAz8O+XvRdaSyeUmNePoxE50g/vEL03zw6BOsCQtmt24APdqSvi2pdecj91IvAiDKCCy1Z8TNlruzNzH5EkBvMdr6EeXqAeC6xGqXuYB17NXlY/g1kJr47xZpSwggdmVs0sJJ+amXX+3/Uf/EHjkVPJCSLBqhqmhDzhoBtYsPTKm+9XWBgQ2JVprsP3RlHheT7EaCGkH/KCAgsXDvmYcZyCzDIrM269vJ5u+9+uVpphOmTQPCJ9crXaahLHm4t3UYQ+sroIX1Ym74dy84i9mOHQ1AITW6c9v+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPgRd6rMr5XMon4TOi99GTuo3aFRst6wL+Mqc8wza1Y=;
 b=Z1YokQaJdZpQjqVczcZOdnXTxeK3JUyS+KUaLl3LkGQK/oQeP2FHY3B77sOt/m3M/JdGite8Ll4a8OepPoXdevetL+NhgUhdaNGd4LoqwNMqlVfwoutTiMhmnR5Xg+YsUaN2lD+XNNLbUefX6SEyj7V//PBzmVYrQ+L1+iX8ZtJs/xCwX6jRpHjr8UyOK+kTpKBVltabnE+xquvEW098b3eSOoAkm8KHduBOxz4TwS+09fZ2mHqcGJCcKSJJF3hjgXYctabzP88bsfD/QGOoMQ9xaTaR69aBWPJSwsmtZikal0Wo71winHxxgxWRRUnUkllyp42dnIG0sDacW2G1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPgRd6rMr5XMon4TOi99GTuo3aFRst6wL+Mqc8wza1Y=;
 b=nCRdVnzwp5RcEZARJZS8qk4vspPmxPXs+BhzbxIWTEEjCv5ajC5VmvZu+YkHdj1f0s6PFD2XfmYmxGGDFLtlAHAGxUE3todUuzCsKkY0mTwsmD0M6zbzPLePY9uXiNeZUdtgpnedCfwbnxllffDz/dwI15uAg8M1CU2jWa1r9jLw4DmkSkmTLtHHOovvLQvjnQ1D0s6KHXUSIxMcT8hbQdsPbVsRIrnLrWgNwDJy0rN8ubYihJ0lTWlugnmpFlF/y1GZl8a1TPWPV2ihiexcyoWqG10aVir5Yq99xCNpT9577atBcU7QgjVKNgJGObxIdUmXjslxwlo7MMETx/ojlA==
Received: from BL0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:207:3d::19)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Wed, 17 Jan
 2024 10:04:23 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::23) by BL0PR02CA0042.outlook.office365.com
 (2603:10b6:207:3d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 10:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 10:04:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 02:04:09 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 02:04:09 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Wed, 17 Jan
 2024 02:04:08 -0800
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] platform/mellanox: mlxbf-pmc: Fix offset calculation for crspace events
Date: Wed, 17 Jan 2024 05:01:34 -0500
Message-ID: <8834cfa496c97c7c2fcebcfca5a2aa007e20ae96.1705485095.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: ed351b7d-a8bb-4cbe-92b1-08dc1743ae56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5QtF4dAHHZmq4I6DMoel6bWj+TUPMKOv0N9pxR2+/glNy/ZyhfrRxsE4ewBLt25kut4S5YgwCSNfyw3BHXhW0jQUzaNU2tUNS9c0ZeopsxTOgBVGrgbbVgkoD6JCIMTJ0jj+ym6+IAl5EPEyjofzfXMF1UaRR871wTKaT5BUshH1EApMPSUgSeG4Ls8AepHxjjGabfxlfnorAV4H0HwazVQ+PO+b9mlPyFWzWvX8VOXtyduCUA+eKMV81weRIqabvlAWDraWOT3X+XqqsuVVETM3L+3pKCuGnlRDDFeb+b0fl1dSgWy+YBVUay6MSoicJNW1bbydWNavTpC3jOwx6RT/B3Fc178lkxDLWRTIE4qMzRjqiwPH4YBKcayLqNmAv6LBbGgtlcijcSULYLBG+IjMKHrA9WY3I2g/bZ1V+QuoiTAy3ACHvVwfS9rh1PYLaaOMHtikSXSpfqx7HSpW7/Atywe0Rx7wAYzaBCNUnkOYBaj8pK4WrawdJi/Cp9HLpYlR1lp0zShP90psC9cyYV9SzyDtjV7EAZBuykL3y6jx54LlzYznBBKrnG0PfpLjAxwsZZI/E59jCbPs8F0y4d52w3tml3zbrFZsiSLgBoMs1C7VXDmcD5l+dzSNzjKtzCE+OWf4R1OacIW9JH5R0uSXlLjKkg/PSLHRs/0Lm+Qf1MBC3wXplfh6lufAUUt8+wOtCwdZbQq6OyATb/E5dMeaFj59z/5Xu77Loo/C6cXdE9wGheKLZlEJ34f6KQ1l
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(86362001)(70586007)(36756003)(41300700001)(2616005)(336012)(83380400001)(426003)(356005)(36860700001)(7636003)(47076005)(26005)(2906002)(5660300002)(316002)(6666004)(6636002)(4326008)(70206006)(478600001)(7696005)(54906003)(82740400003)(8676002)(110136005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 10:04:23.2893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed351b7d-a8bb-4cbe-92b1-08dc1743ae56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794

The event selector fields for 2 counters are contained in one
32-bit register and the current logic does not account for this.

Fixes: 423c3361855c ("platform/mellanox: mlxbf-pmc: Add support for BlueField-3")
Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 1dd84c7a79de..b1995ac268d7 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1170,7 +1170,7 @@ static int mlxbf_pmc_program_crspace_counter(int blk_num, uint32_t cnt_num,
 	int ret;
 
 	addr = pmc->block[blk_num].mmio_base +
-		(rounddown(cnt_num, 2) * MLXBF_PMC_CRSPACE_PERFSEL_SZ);
+		((cnt_num / 2) * MLXBF_PMC_CRSPACE_PERFSEL_SZ);
 	ret = mlxbf_pmc_readl(addr, &word);
 	if (ret)
 		return ret;
@@ -1413,7 +1413,7 @@ static int mlxbf_pmc_read_crspace_event(int blk_num, uint32_t cnt_num,
 	int ret;
 
 	addr = pmc->block[blk_num].mmio_base +
-		(rounddown(cnt_num, 2) * MLXBF_PMC_CRSPACE_PERFSEL_SZ);
+		((cnt_num / 2) * MLXBF_PMC_CRSPACE_PERFSEL_SZ);
 	ret = mlxbf_pmc_readl(addr, &word);
 	if (ret)
 		return ret;
-- 
2.30.1


