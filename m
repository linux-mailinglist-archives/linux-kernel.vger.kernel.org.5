Return-Path: <linux-kernel+bounces-27356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863DF82EE9C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077761F23F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58D31BC30;
	Tue, 16 Jan 2024 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lQ/5uDDh"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAB1B968;
	Tue, 16 Jan 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DP1UZMp7jzWbY4gykoHMBsISKv4i/kID87YoZ4+M890f30rYMtWY/Yz4VDj1bVWt9czn6Dyv07bw3F+W1Ol7yd0AU8ehxCMKVTEILRTvVllKc0Xj2JPyOvswhOTs/d4zBRrFAPgN+/dcNghkcXe8oqxYzAbhZ3riQflIRwkszVpsIX9vlfAAi9U1/nBOQA7VcsI8jdx9p6NE6aqUsh/3WjgmBUuhryWUOseej9QiIbgfYSN043dqRrZQ53ouLXi4B0lp5GuN2G3DqWtaEb/5RA02ma+dJpgvSWnHdPFySzxvfUka/cZZyqm53FuuiHEsO1T2Xq0VZEvSz4x+croYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RT3RJhlmjlt53Kf3P/XzHuvpYOTl2AveAXukxItq2X0=;
 b=DJDC9YuRtWmkP9zqcnaM1vUOhAQGRYwv4nx9BTBDdZfrvQUFBocPnbpBnZHI8S469XIoDGNwW5VvwhdGL8qEnFcdSNsYkEiXZokBL9Fx8+BaUB2S5cP8YesrsAD/o8pe0HW690uwp2f9lOpLLB+/olfsW0eR8Q8myknrKOjnjs9jNKt7rq2zmaOlAiIgbVV3jaCXn2npAFTAZXLtZmfc0ygVa0EyfEE8KKM0xRa2nChknxM+PHE9CZXW7KW6rupEGiVP8e4xC/8kHqGeChMRl99vE/+mdHdwXuHfQHE9R91avGW/CP6MnynQ+6KnX93M9zYGAd97U9Oddx7WVZF2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RT3RJhlmjlt53Kf3P/XzHuvpYOTl2AveAXukxItq2X0=;
 b=lQ/5uDDhXQlDT/XnlWZ+JpUT1AQS290zKLU6DGdqTZDHVbs7nFY7m2jsysVxfTMXQpkCGRPiT7zX5ufMyAqOCVPX8S3bQWj0srs7upGBV4IpUvdDSU22z4EKZJHfJ1B08SVbQVcjlrh9yw/F14jfn3a9imziINjpDezFxtc28kDkUemE/FRyvNe8oEoo9eq5uVIsaiIgl23PatuA9CVBnIVjqdqHsp8nS8WxnMP3MRHZZEGs8fpt2xBzm4f6OVPQD0EJle6C9ThccY35rCKuTswFZTAwQHPt+DOlMC+kpq5jibpEB4G4FkZ4vysECGPC2n+lOQ5aHEoqIjMHZr0Zww==
Received: from SA1PR05CA0008.namprd05.prod.outlook.com (2603:10b6:806:2d2::15)
 by DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Tue, 16 Jan
 2024 11:59:53 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::32) by SA1PR05CA0008.outlook.office365.com
 (2603:10b6:806:2d2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.19 via Frontend
 Transport; Tue, 16 Jan 2024 11:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 11:59:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Jan
 2024 03:59:40 -0800
Received: from pohsuns-pegasus.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 16 Jan 2024 03:59:38 -0800
From: Pohsun Su <pohsuns@nvidia.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Pohsun Su <pohsuns@nvidia.com>
Subject: [PATCH 1/2] clocksource/drivers/timer-tegra186: add WDIOC_GETTIMELEFT support
Date: Tue, 16 Jan 2024 19:58:37 +0800
Message-ID: <20240116115838.16544-2-pohsuns@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM6PR12MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e10531-e990-4da1-310f-08dc168aa699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QOP/Wk9IyfPIBLLsZu6yrBe7VFTVH/vNhViuXKTPPSpaa8Rb1OPdyoD0yOPXMOKmQTc108X6pRUNIJu0lldMJOXqcNvgQPwNtgK7T0h4GdODg8/3Y8u84r/EAFLHdrtUHddbWijlYDgXpE8tlpiqWeb6WfKPHNUZn0LzgtiCLZ7nDziVnGf2C2Rb1kLJINUvjtVFpKLS/T+npKtSdrEcMlb9JbEzjnAP36ucILUwHpM2WBGRveIeI3PDZX5bG9a5EroNvJYqaEx814Tp1UAf6Tlt+fEJxvHlMAGZP82vSUJG0R+E7p2hJdQuCEgZZEWxlhYC5s1Z7/jjdHB2yzzbkP5pdNtZTIVv4681ksIFAALk1HJVSFvZMlDmMXBPiDAWVqh9GzGeygZ9QH06nXRkkro2La03ORHzpD6Q9ynMHkqLysMQrMjthuOw7KQsVGdi/vwssF1mPVFM64/DYpgWqFmBYFvsS1efrU1ZPqNSZ9TAph+ONYII3Kf0RfU22ISYkWnvJ5ftGrPEjAD4GgDUCYYAaPk8CwnhCyFBUIbzb5HsAwjPAjZ8l9mVnBumWt11dgd9eHXeNN8Ndn8I+1Rq0Ciy+p2oXg1jHolzJNDBE0n6SL46bVsc5hWgDBbOn8cx3InCxx2hBmazLAneJ9D6mwCP18vEUO3mgy6xk8xcXrarL7+uA2a2D0p6aTDSlnxF7+M5Esf34AC6ISppnLwbBREjhocJwApadKk/7M/mIj8Hcr3qzmvgf8EHWT1gqX1h+I2bNHqyLPTXPVoXB6MAyA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(40470700004)(46966006)(7696005)(478600001)(26005)(16526019)(336012)(2616005)(426003)(356005)(107886003)(36756003)(7636003)(83380400001)(36860700001)(86362001)(1076003)(82740400003)(41300700001)(47076005)(4326008)(8936002)(8676002)(5660300002)(70586007)(2906002)(6636002)(110136005)(40460700003)(70206006)(40480700001)(316002)(54906003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 11:59:53.4716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e10531-e990-4da1-310f-08dc168aa699
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4545

This change adds support for WDIOC_GETTIMELEFT so userspace
programs can get the number of seconds before system reset by
the watchdog timer via ioctl.

Signed-off-by: Pohsun Su <pohsuns@nvidia.com>
---
 drivers/clocksource/timer-tegra186.c | 41 ++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index 304537dadf2c..685c6689a2da 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -29,6 +29,7 @@
 
 #define TMRSR 0x004
 #define  TMRSR_INTR_CLR BIT(30)
+#define  TMRSR_PCV GENMASK(28, 0)
 
 #define TMRCSSR 0x008
 #define  TMRCSSR_SRC_USEC (0 << 0)
@@ -45,6 +46,9 @@
 #define  WDTCR_TIMER_SOURCE_MASK 0xf
 #define  WDTCR_TIMER_SOURCE(x) ((x) & 0xf)
 
+#define WDTSR 0x004
+#define  WDTSR_CURRENT_EXPIRATION_COUNT GENMASK(14, 12)
+
 #define WDTCMDR 0x008
 #define  WDTCMDR_DISABLE_COUNTER BIT(1)
 #define  WDTCMDR_START_COUNTER BIT(0)
@@ -234,12 +238,49 @@ static int tegra186_wdt_set_timeout(struct watchdog_device *wdd,
 	return 0;
 }
 
+static unsigned int tegra186_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
+	u32 timeleft;
+	u32 expiration;
+
+	if (!watchdog_active(&wdt->base)) {
+		/* return zero if the watchdog timer is not activated. */
+		return 0;
+	}
+
+	/*
+	 * System power-on reset occurs on the fifth expiration of the watchdog timer and so
+	 * when the watchdog timer is configured, the actual value programmed into the counter
+	 * is 1/5 of the timeout value. Once the counter reaches 0, expiration count will be
+	 * increased by 1 and the down counter restarts.
+	 * Hence to get the time left before system reset we must combine 2 parts:
+	 * 1. value of the current down counter
+	 * 2. (number of counter expirations remaining) * (timeout/5)
+	 */
+
+	/* Get the current number of counter expirations. Should be a value between 0 and 4. */
+	expiration = FIELD_GET(WDTSR_CURRENT_EXPIRATION_COUNT, readl_relaxed(wdt->regs + WDTSR));
+
+	/* Convert the current counter value to seconds, rounding up to the nearest second. */
+	timeleft = FIELD_GET(TMRSR_PCV, readl_relaxed(wdt->tmr->regs + TMRSR));
+	timeleft = (timeleft + USEC_PER_SEC / 2) / USEC_PER_SEC;
+
+	/*
+	 * Calculate the time remaining by adding the time for the counter value
+	 * to the time of the counter expirations that remain.
+	 */
+	timeleft += wdt->base.timeout * (4 - expiration) / 5;
+	return timeleft;
+}
+
 static const struct watchdog_ops tegra186_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = tegra186_wdt_start,
 	.stop = tegra186_wdt_stop,
 	.ping = tegra186_wdt_ping,
 	.set_timeout = tegra186_wdt_set_timeout,
+	.get_timeleft = tegra186_wdt_get_timeleft,
 };
 
 static struct tegra186_wdt *tegra186_wdt_create(struct tegra186_timer *tegra,
-- 
2.17.1


