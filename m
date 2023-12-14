Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87A8133A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573571AbjLNOxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573563AbjLNOxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:53:50 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC7D124
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:53:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D45+h5QSdIkPZHB6l+YPFbwieAcYi/aE9LRmXuxPas50iYel4cuKaIgj/6aDd3/XXchCXuXZ9xx7OhRuAMCiiuRzmACqQMn/MY5Ay+DZtGwAqojnZt6BE2BAl4+Woo+4cc2vhHzS9RrdgAFJ4KCwjhXVo7T5HPEdVNITXW8DeVueI5N4d+NKmLvf01d7vEkdGiZOOrd2QrMk6C2EZY5XsEmSzRP2NHaRoZmfFbc4ibtsFRqb4187IxPy0Zz2Cf6HCL20w0KPVyUuXLbTcWJk5UXQkX6GSFawc9EG3uNTegpY70Zg6z8yARY/Lkx7NoxlihNAdJOLnabAle6IASvuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xe4yr8nM+pUaUotyPGOwZZIjNH0t1TzFYsXEwSXDxYA=;
 b=JewE9ru4G6PlkJKW2SYulHlZH1gq5+0o2gY4o3l1j5CLm1ENdpKi3SNyxPrpl2e/F0tfiBcySiH2jL2X7CH7wwut7itB6O6z4ig1O/KIfR2OHVqQAZ+0o2em0K+b77nrgACzWNezPFoyD1TQ2VbzIMpnA5U9QAH42DtZwm5BW5/4hTsW2Dv6KmIeF2aiCb+S7/e51vibdoflkL6pMBgkXtazPdcWHDlquXi32vpS9CR2cOR+kikoslkxDoWCLBg5xhzoxEVBjtC5ImVWxZRO/5ViDuvGQxg2DZFkGed2aumFXRT/Dtf/h3vJlzjzCl257tc2XM5HHgXu6Ny9KMv5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe4yr8nM+pUaUotyPGOwZZIjNH0t1TzFYsXEwSXDxYA=;
 b=um//lsuTPKTcjZ9PiPjVDnVcl9bF3DNxTUXfJiD3wzGfs2eYcbE//CJKe5a4Dq0Jq4oERsfuAubQT3Ju8hUUf5lbB3tIk1q6w23OfPc3idJrk8VITCI8rdc8p3uFYwM3EMddpfTl8zchacvsZDudMyxlSz3sXt28L56xfnj2nXs=
Received: from MN2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:208:134::40)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 14:53:53 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:134:cafe::69) by MN2PR16CA0027.outlook.office365.com
 (2603:10b6:208:134::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Thu, 14 Dec 2023 14:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 14:53:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 08:53:51 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Dhaval Shah <dhaval.r.shah@amd.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Marek Vasut" <marex@denx.de>,
        Nava kishore Manne <nava.kishore.manne@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] firmware: xilinx: Remove clock_setrate and clock_getrate api
Date:   Thu, 14 Dec 2023 15:53:47 +0100
Message-ID: <6ccbffbafd1f0f48f6574d5a3bf2db6a5603fdb0.1702565618.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3811; i=michal.simek@amd.com; h=from:subject:message-id; bh=SF1GxqVWXlPpmKKF/2sSPzOtZHrAiO8mzZRjJYk94TA=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtRqsS8Kk43Mvuf2MTA7Wbl9uXrroknph4lpjHJpP/kP/ nt2zaOsI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzkiQbDPAPpmoDZlcw+hbei ws6fkDg0QYlFiWF+7LykR7yLV9y0uni5c5as0sawByV8AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: f43e7e43-506d-49f0-397b-08dbfcb47db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chD/IvUQCiRF4biJhDDyxqOm7rrevwouO/cPhYMnRdJHx95J9JtWhn8GIPwsWGo7bS4b6tmvB85wPPYiKH9VeQbRuW0bedcdYzXSajN4IEVJtSyE/upssuzZKDx9UR4gljNoChTvdvlsP2QB89fLFpM4yLyhdcJhTXroSSS4KivbRhP/26aWN0iLPuJPgmRKJqe9U7DrAUZ9syHtuHLFFE/95btlpKjqqVQBugZebt8m1RogQDFj7vVoYckcV+Q/9UEna1ui+EddnwWjlOTlgkvdW4I58Y9Iw2V1G8HCsXmwCjVeYIqHSk5yXBVFchlLIkZUpx2yff7ct1UXvZylcXOWcb8RqDEuf5KesbSPQPYFZxqN4/Gklwd+qyyizp+DC6fP86zLjyG3AMLvHdqoOL+zAvN0KHnNKq7jjIKAusv+v3R/23vXKm1sKnPbQNDF8qM5x89GpBJcviPH9ylGxTEBR6qn+YadUCcZGPDNWkko9OC/qdnYmlycSTAeh0+tAycy/v3NWYX805Cqsd/CUUtbVmpf5FK2RL9LtFRsW3BWlF1jgmC1m2wfsSzZ4sH9MSpuHgMZQktYpckU8kN2QbRpeSnsfXpzmgMsb55ps3z14+EcTgSBsAsXWwqNb0islirP43EHj5npg8N2bt0egQUFWRgZNlL+m8Rse65K/hh+j07N6Z/23xAeAhsSEwNE3HI86vD5B27ngYaDmLirniYJ3cWUAlc0rmvVL8109eGK5HHTeiPulPCV/uMBz8KUgT6QhmdUgij1drHNNbTSrqBCKOuhaXzsNqJ7GHY0+IE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799012)(82310400011)(451199024)(186009)(64100799003)(36840700001)(40470700004)(46966006)(356005)(86362001)(36860700001)(82740400003)(81166007)(36756003)(40480700001)(40460700003)(26005)(2616005)(70206006)(478600001)(6666004)(44832011)(70586007)(54906003)(110136005)(8676002)(316002)(426003)(47076005)(336012)(16526019)(83380400001)(4326008)(8936002)(41300700001)(5660300002)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 14:53:53.6035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f43e7e43-506d-49f0-397b-08dbfcb47db9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the current code base, PM_CLOCK_SETRATE and PM_CLOCK_GETRATE
APIs are not supported for the runtime operations. In the case of
ZynqMP returning an error from TF-A when there is any request to
access these APIs and for Versal also it is returning an error like
NO_ACCESS from the firmware. So, just removing the unused code to
avoid the confusion around these APIs.

Also, there is no issue with the backward compatibility as these APIs
were never used since implemented. Hence no need to bump up the
version of the feature check API as well.

Signed-off-by: Ronak Jain <ronak.jain@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/firmware/xilinx/zynqmp.c     | 38 ----------------------------
 include/linux/firmware/xlnx-zynqmp.h | 14 ----------
 2 files changed, 52 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index caa0952bfc42..2ae9da268215 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -657,44 +657,6 @@ int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getdivider);
 
-/**
- * zynqmp_pm_clock_setrate() - Set the clock rate for given id
- * @clock_id:	ID of the clock
- * @rate:	rate value in hz
- *
- * This function is used by master to set rate for any clock.
- *
- * Return: Returns status, either success or error+reason
- */
-int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
-{
-	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, NULL, 3, clock_id, lower_32_bits(rate),
-				   upper_32_bits(rate));
-}
-EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setrate);
-
-/**
- * zynqmp_pm_clock_getrate() - Get the clock rate for given id
- * @clock_id:	ID of the clock
- * @rate:	rate value in hz
- *
- * This function is used by master to get rate
- * for any clock.
- *
- * Return: Returns status, either success or error+reason
- */
-int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
-{
-	u32 ret_payload[PAYLOAD_ARG_CNT];
-	int ret;
-
-	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, ret_payload, 1, clock_id);
-	*rate = ((u64)ret_payload[2] << 32) | ret_payload[1];
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getrate);
-
 /**
  * zynqmp_pm_clock_setparent() - Set the clock parent for given id
  * @clock_id:	ID of the clock
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 6b48294f3c92..c6a7fb1f980b 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -160,8 +160,6 @@ enum pm_api_id {
 	PM_CLOCK_GETSTATE = 38,
 	PM_CLOCK_SETDIVIDER = 39,
 	PM_CLOCK_GETDIVIDER = 40,
-	PM_CLOCK_SETRATE = 41,
-	PM_CLOCK_GETRATE = 42,
 	PM_CLOCK_SETPARENT = 43,
 	PM_CLOCK_GETPARENT = 44,
 	PM_FPGA_READ = 46,
@@ -533,8 +531,6 @@ int zynqmp_pm_clock_disable(u32 clock_id);
 int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state);
 int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider);
 int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider);
-int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate);
-int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate);
 int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id);
 int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id);
 int zynqmp_pm_set_pll_frac_mode(u32 clk_id, u32 mode);
@@ -639,16 +635,6 @@ static inline int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
 	return -ENODEV;
 }
 
-static inline int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
-{
-	return -ENODEV;
-}
-
-static inline int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
-{
-	return -ENODEV;
-}
-
 static inline int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
 {
 	return -ENODEV;
-- 
2.36.1

