Return-Path: <linux-kernel+bounces-27357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC4B82EE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7654FB235A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE6A1BC43;
	Tue, 16 Jan 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="diOL8NOo"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE751B96F;
	Tue, 16 Jan 2024 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhiIk2mh9lyPmPjaDZGLfRldO6nEOH2cp5/Q9tUo4U2vOOmpAPec+YDzJ5LRiTtRAV5tirhr6eMQwNDZLnGbN9rgqa9hCdwhmS08PCiKkQmEWO8xEEdu3TLBD8j8+QSotBD6+U9LVNWr+QqJk67ixMR0DqaYeJRGeNy0tMl0bjPkceav8H51g/1V0+N0A9QQcYMnGs3E3gBq2PmaUGhRIw3mTbNo6vN+ApUNM5nfVYD7o4mYbW0zDDS5XhbSfTBeJq9ERGB4Nr3zPJ1Z1SejilgQuLU+5n8cgBJZ5H1eIQCg/kQUVOdna8GDZAQt6e1PiZyDJuBsZSKSS++mrf9HJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqAlyeWm5KWLX0BzuSxwsTtHhRJPt37Lq4jARKhl1eA=;
 b=CGuQLUf1FpWHWC811VjgGwpWH+oryT5ABgTa8pHsl6UBUVPgiVHuX9eAQ1vuhvSMifzUpEQioXF2R6LDDj0AMYrKT56mlK8co9R/FMMCxSowd20fl7s7+0N5ix8ahcDZLLEYcd/IHfdysvIqS8Dz2FDD/tF/AuLv60wtMBp8yY2LxNZ9+Rwo9q6TXOLZHC9OF9gg8k+LgiHZvmWQWonlIbD7oey9U0JM1Wqg1pNEIk2stRm06K3I/oNqp5DEnpgM4HpGoaJAxJQILwaLUxIiuo+QgCczPSDjm/nkHYEHojNI89RKxAgsX4BSVnOM3x9Vf7ioAfy1qThJntdMgaP+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqAlyeWm5KWLX0BzuSxwsTtHhRJPt37Lq4jARKhl1eA=;
 b=diOL8NOoPppKM7JymJpQyHkMv9I0u0BE5wlY32G1HjhMxLu0vbUEJjKQ0yfjnc6gfs42zvlmq+7B70joo8D4tOZReWmmLjOvnKoEyKlcpJKjJq3ntBWOL2PWvgU2BTGlKqLZDkm8NZ99xHkrgWddvFkl5BNhpFA5Xv/fSVqeznkU/BUHwBt6BAsvRrU2PtGUOrbTgT2jFhjjNaAOtiFyai58zYxDDp1mUPU9EsO3CtNS3EKAS0QOPKIfdwVPVbDZ/Ncmp1aJA/2gYTqIRMfFsdc5EdHdbLAvjC6xsQBc9wUgmbtX15iE9K7pLpAcfuvLkF9Rg+nNYiF99/vKXr7/2w==
Received: from PH0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:510:5::7) by
 LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Tue, 16 Jan
 2024 11:59:56 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::a8) by PH0PR07CA0002.outlook.office365.com
 (2603:10b6:510:5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28 via Frontend
 Transport; Tue, 16 Jan 2024 11:59:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 11:59:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Jan
 2024 03:59:42 -0800
Received: from pohsuns-pegasus.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 16 Jan 2024 03:59:40 -0800
From: Pohsun Su <pohsuns@nvidia.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Pohsun Su <pohsuns@nvidia.com>
Subject: [PATCH 2/2] clocksource/drivers/timer-tegra186: fix watchdog self-pinging.
Date: Tue, 16 Jan 2024 19:58:38 +0800
Message-ID: <20240116115838.16544-3-pohsuns@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116115838.16544-1-pohsuns@nvidia.com>
References: <20240116115838.16544-1-pohsuns@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c65761f-05bc-47b5-b04f-08dc168aa7cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5pdeVyNAINZwAR/1iPvdXwlQX2uhdVwJE0LHJ3GXHnI7clhddeZhgY4YtXxnEtVE+1Nb+8ciduEuh3wym0MF0dO/soVXlegBU1wzhB+/z9HRJSOtp5X7JJsZYENxchKgnUs3qelQLNnx7JVqv5oTryCjx44KRFXgWNVCD0GkD+p4exLhykcf4e6cPpkbVFy9TTB6kv2pKQIF+61WYP1Gc/TJG8NM09nL8LtW6wTMWPUNDQxCktnEaRGWDiux+qrOAYQYzC515WXAN+dfHuN6v6/nex6X48HBRy/ciu6oBDA0M175IoIpTAihyPlHN0Jzru7v21tv498DdPXGFzGXFiLbIEiUFpZasGDNZwiZjUgqdKvZuWE7k3+TAAKP7UCyLut9a0m2uw00sDySDcNcYLnzU/ctK9wmeqHW/mt4x2Wzo0eYic81eyzFNRWcEhz08icTpnvrR4j4fohJJ8lR2xU87FnohVZscq9tgdoyvcxOpQvhQ+eNoK79dwRhGy+GJlv8JPcPUrf9hAAsquIF8RUzlbWuWareI9ZEJIAEmgno3qYG32HXRNmPILijPUKL9l5GOGaFYp5LcPXdoKasBPOyPugA2IR3dsv3+UhIFYxlJmbcKy174iBZGEb9jgvfZSkirgbmXN8XcTGlJ1lmzqP4gzzyojMw2V0jJhqbupQEOmJmN8538KMoprGgaez6l5ZnQdeLYL0aQlIibqRfBWL4tTUvlGCEfPoG9BK7IOohxqChp5DtanlMGFgO9TYKvNCID0W5bko3rxlKXNMMtA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(82740400003)(2906002)(5660300002)(36860700001)(36756003)(86362001)(41300700001)(7636003)(356005)(54906003)(6636002)(316002)(2616005)(110136005)(70586007)(70206006)(478600001)(7696005)(83380400001)(47076005)(16526019)(26005)(1076003)(107886003)(336012)(4326008)(8676002)(8936002)(426003)(40480700001)(40460700003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 11:59:55.4803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c65761f-05bc-47b5-b04f-08dc168aa7cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

This change removes watchdog self-pinging behavior.

The timer irq handler is triggered due to the 1st expiration,
the handler disables and enables watchdog but also implicitly
clears the expiration count so the count can only be 0 or 1.

Since this watchdog supports opened, configured, or pinged by
systemd, We remove this behavior or the watchdog may not bark
when systemd crashes since the 5th expiration never comes.

Signed-off-by: Pohsun Su <pohsuns@nvidia.com>
---
 drivers/clocksource/timer-tegra186.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index 685c6689a2da..963c12c81f4d 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -174,7 +174,8 @@ static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
 		value |= WDTCR_PERIOD(1);
 
 		/* enable local interrupt for WDT petting */
-		value |= WDTCR_LOCAL_INT_ENABLE;
+		if (0)
+			value |= WDTCR_LOCAL_INT_ENABLE;
 
 		/* enable local FIQ and remote interrupt for debug dump */
 		if (0)
@@ -406,18 +407,6 @@ static int tegra186_timer_usec_init(struct tegra186_timer *tegra)
 	return clocksource_register_hz(&tegra->usec, USEC_PER_SEC);
 }
 
-static irqreturn_t tegra186_timer_irq(int irq, void *data)
-{
-	struct tegra186_timer *tegra = data;
-
-	if (watchdog_active(&tegra->wdt->base)) {
-		tegra186_wdt_disable(tegra->wdt);
-		tegra186_wdt_enable(tegra->wdt);
-	}
-
-	return IRQ_HANDLED;
-}
-
 static int tegra186_timer_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -469,17 +458,8 @@ static int tegra186_timer_probe(struct platform_device *pdev)
 		goto unregister_osc;
 	}
 
-	err = devm_request_irq(dev, irq, tegra186_timer_irq, 0,
-			       "tegra186-timer", tegra);
-	if (err < 0) {
-		dev_err(dev, "failed to request IRQ#%u: %d\n", irq, err);
-		goto unregister_usec;
-	}
-
 	return 0;
 
-unregister_usec:
-	clocksource_unregister(&tegra->usec);
 unregister_osc:
 	clocksource_unregister(&tegra->osc);
 unregister_tsc:
-- 
2.17.1


