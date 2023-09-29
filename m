Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6747B2D30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjI2Hpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjI2Hp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:45:27 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E91A8;
        Fri, 29 Sep 2023 00:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+eXxXFxdGKMBC1WrS9sCYkiLizQuEDfyeWP1w0ukICqE9BpK5US7Rz7C9dvWNcaJKgaVamnCNGK7ySMaNyRY+9UnKGMbQzqj28um9Z9AyMrPrMs/UxAjdWxWHGp7MC3R8c8gQYLyW7cu9SfigWXvXM5kD84Gt0Ba+z0cP5X1ucxfUvS/qM1egUHA5vOlaz9GFOSDP7MVsdoAL1paRsSj/NhUs1uh+oPh64DMSdCef3udiEPpjXp+KwtY8E5x1XHPhCXdfkdt4DYeNqXP7k5QI27qlki4p+UkTgZHnMhuEHjOrChhzGNDkC0deQM3jG5e4ON68FWI2LJzRHj9+Z6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCkbBxXVt6OagbPZG0fqwWIlqmcUQmCg3s909KOvWZw=;
 b=MLOcMAqNOhgOPOei3zIlHnlwZ2jQxjULHEoha2A+ufwB5WimgbynAY6qK/tNcgaeKoil3c4MfINcPfDPlHncNA82foF6F7ibB5+UgfSAUEPJsuadMRUZOuXl5MygdsUxC5CI4O2TtykW9qniU9BPtI4abhgnm6sx79wzvyRlQ81895ZXRdPEk7PgQVcJ9ecLZy5CQEe9RhTvn6GmvfA1KJGGt73rBFeEog7vXAHPuBw0vVkz8IzJhK7+Z0f7YqFptTY6CRIZ2YwMd1LzqVqBPWnRQrISGmLHMwW0U1qkY2SIjGWPgQb8k1+Oar4ezab0vF1+akv4/tJ3hawpJbCKig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=linaro.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCkbBxXVt6OagbPZG0fqwWIlqmcUQmCg3s909KOvWZw=;
 b=QP+71y8SiPK3PrkTVIFCRWOW0pfhhaGotKIoVNx4aCtMeS0oqPJUXRTbAxtLJFErK1Os0TWfxDoypd0fRNmZhJ5zRc9/cuI/rO6+ARaNDLTzhsPmTvrYhpwsDpJez3JY+yl9NgFr65MPOeU7dqSlfri3fM9twVyARmObLyJGFsE=
Received: from AM6P192CA0086.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::27)
 by PAVPR02MB9643.eurprd02.prod.outlook.com (2603:10a6:102:300::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 07:45:19 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:209:8d:cafe::d) by AM6P192CA0086.outlook.office365.com
 (2603:10a6:209:8d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 07:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 07:45:18 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 29 Sep
 2023 09:45:18 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 29 Sep 2023 09:45:18 +0200
Received: from pc45945-2140.se.axis.com (pc45945-2140.se.axis.com [10.88.125.80])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id 615A33071;
        Fri, 29 Sep 2023 09:45:18 +0200 (CEST)
Received: by pc45945-2140.se.axis.com (Postfix, from userid 10564)
        id 5DB967124471; Fri, 29 Sep 2023 09:45:18 +0200 (CEST)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 29 Sep 2023 09:45:09 +0200
Subject: [PATCH v2 2/2] mmc: debugfs: Allow host caps to be modified
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230929-mmc-caps-v2-2-11a4c2d94f15@axis.com>
References: <20230929-mmc-caps-v2-0-11a4c2d94f15@axis.com>
In-Reply-To: <20230929-mmc-caps-v2-0-11a4c2d94f15@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|PAVPR02MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc2c3fc-711a-4904-5e49-08dbc0c00717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5CBtZNecg98ybzve50TUf3YGYjUdNLzqMFR/FKmIZ5iwH7efYbSBlo30byCbJgZ8+HIrw/nhNsCsZaUUJd5bN162dhpqVEAssCsF2DaodYocF+U191YDRrWmoN5eLXaCbG7+dWSJ3U+NRK7U5xW3/AdgZ+AN7w4V1O9dgZpHJB8Q5FN01aUBmtBedccQHWMqLZ2/iZTpMvlJSkNmiH4f0suh094peOJI541XjuU1cuzWC6WqepmWngiLhmiYihL8Ua2A1WsGggixGiFlbSW+zlZOq6u+/KAlLtvQgllA9G0j0WcBb/vMLq1WbekWEvKR2epHcDGSO3XQCEVJlN8DoWW+0mIN/zQPClWPE6oom0paZdWVn/L91R8GP3lm5+1j+LSC9cMoxHKXBQAdmXFO+OG7Jvp5bLpxFAmTYkO0Q2k1cxIIn0IosqUFnqbjY2yhIFZEwJHxmV9FhkAXGlKTK3V0sN52QURyPVt5YtQRvHYJgkwsKEwBTh481pP1DZQw+HlXhZznOLVWJYggxAReEDfLFSdOr+s1ASHRYW+bbQRkZUZaFslvVDInwkjWpor5oxiao0hIObXagY97hgaTCZ3MZIyKkEgjnA0Zod9v/0LWQsc4hmV28Cs6VRBj7az5Bo34qnx6LbFRcPIL1G/kptOQm+WPkrnqdfYf+0Nt2XsDBLGSjLdD+buwGc4X6bI8IcEl27RjxCkOiKUPxrdZI5Rcoqs5FMd+Jm2TYPa5eNkpAQp05F1NbsnjiOJuWUVC67NKj0usC03OjLwe26iyPQ==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(40470700004)(46966006)(36840700001)(336012)(426003)(2616005)(26005)(6266002)(6666004)(47076005)(107886003)(4326008)(83380400001)(2906002)(8676002)(70206006)(70586007)(42186006)(54906003)(8936002)(5660300002)(41300700001)(44832011)(6916009)(316002)(40480700001)(40460700003)(356005)(36860700001)(86362001)(36756003)(81166007)(82740400003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 07:45:18.7970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc2c3fc-711a-4904-5e49-08dbc0c00717
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9643
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During board verification, there is a need to test the various supported
eMMC/SD speed modes.  However, since the framework chooses the best mode
supported by the card and the host controller's caps, this currently
necessitates changing the devicetree for every iteration.

Allow the various speed mode host capabilities to be modified via
debugfs in order to allow easier hardware verification.  The values to
be written are the raw MMC_CAP* values from include/linux/mmc/host.h.
This is rather low-level, and these defines are not guaranteed to be
stable, but it is perhaps good enough for the intended use case.

MMC_CAP_AGGRESSIVE_PM can also be set, in order to be able to
re-initialize the card without having to physically remove and re-insert
it.

 /sys/kernel/debug/mmc0# grep timing ios
 timing spec:	9 (mmc HS200)

 // Turn on MMC_CAP_AGGRESSIVE_PM and re-trigger runtime suspend
 /sys/kernel/debug/mmc0# echo $(($(cat caps) | (1 << 7))) > caps
 /sys/kernel/debug/mmc0# echo on > /sys/bus/mmc/devices/mmc0\:0001/power/control
 /sys/kernel/debug/mmc0# echo auto > /sys/bus/mmc/devices/mmc0\:0001/power/control

 // MMC_CAP2_HS200_1_8V_SDR
 /sys/kernel/debug/mmc0# echo $(($(cat caps2) & ~(1 << 5))) > caps2
 /sys/kernel/debug/mmc0# echo on > /sys/bus/mmc/devices/mmc0\:0001/power/control
 /sys/kernel/debug/mmc0# grep timing ios
 timing spec:	8 (mmc DDR52)

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mmc/core/debugfs.c | 51 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 2c97b94aab23..1642ea72d22c 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -12,9 +12,12 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/fault-inject.h>
+#include <linux/time.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sd.h>
 
 #include "core.h"
 #include "card.h"
@@ -298,6 +301,49 @@ static const struct file_operations mmc_err_stats_fops = {
 	.release = single_release,
 };
 
+static int mmc_caps_get(void *data, u64 *val)
+{
+	*val = *(u32 *)data;
+	return 0;
+}
+
+static int mmc_caps_set(void *data, u64 val)
+{
+	u32 *caps = data;
+	u32 diff = *caps ^ val;
+	u32 allowed = MMC_CAP_AGGRESSIVE_PM |
+		      MMC_CAP_SD_HIGHSPEED |
+		      MMC_CAP_MMC_HIGHSPEED |
+		      MMC_CAP_UHS |
+		      MMC_CAP_DDR;
+
+	if (diff & ~allowed)
+		return -EINVAL;
+
+	*caps = val;
+
+	return 0;
+}
+
+static int mmc_caps2_set(void *data, u64 val)
+{
+	u32 allowed = MMC_CAP2_HSX00_1_8V | MMC_CAP2_HSX00_1_2V;
+	u32 *caps = data;
+	u32 diff = *caps ^ val;
+
+	if (diff & ~allowed)
+		return -EINVAL;
+
+	*caps = val;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(mmc_caps_fops, mmc_caps_get, mmc_caps_set,
+			 "0x%08llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(mmc_caps2_fops, mmc_caps_get, mmc_caps2_set,
+			 "0x%08llx\n");
+
 void mmc_add_host_debugfs(struct mmc_host *host)
 {
 	struct dentry *root;
@@ -306,8 +352,9 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	host->debugfs_root = root;
 
 	debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops);
-	debugfs_create_x32("caps", S_IRUSR, root, &host->caps);
-	debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2);
+	debugfs_create_file("caps", 0600, root, &host->caps, &mmc_caps_fops);
+	debugfs_create_file("caps2", 0600, root, &host->caps2,
+			    &mmc_caps2_fops);
 	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
 				   &mmc_clock_fops);
 

-- 
2.34.1

