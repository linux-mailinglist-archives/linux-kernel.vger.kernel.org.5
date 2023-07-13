Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EB875257C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjGMOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjGMOs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:48:56 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2060.outbound.protection.outlook.com [40.107.247.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B375A19A6;
        Thu, 13 Jul 2023 07:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbrRo7ceKPTkDvJd/LttA857y0+z9U5ksRuS7WHrlO4ZoUvr1NJqHVt5qVDPpPiKnxVYWEGWa07kE7AxrXbktvr/B3yvx7D9bTwgltSa4TnZfu+x1pa1XG3fxzLqTJTLJ1ZadXqKLW7UZPPf4Ywd4+ZTRCphmAee2Jn3keug0ta9ifiiNvdpUzGxQRzoTozSqw3vsP+1y5oCqAD4b9fiaCMfR2n800QxXTTMFGZn/IPgkqDF7RCRihCM1LqbHBFZSK5kgi+8KLIqhj17r/ZuLo4YgrTCxvoxk/LOQNyOQ8CN823kmzwwS2xsU9V8qTO9MFRoQxbmbE4pvxS2JFs9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSJcoY4+HAmGuyDEiIYVd4CBBAFTxbUWiQfpFvrvjXM=;
 b=JB8w1KQr+NdmWsLBpplh1X/oPSBl1nO44+hgCyBlcTjacjUALw3DkKeRJsTjIq6onw1/5zl3uOVoZ7QuK0UdYF9VqdNakIM01DR3KdA5iUkqR28LmhYBZw0umEna1GiX84wuwwLMlxv6UHm6ysIzD0Hogu+l+c3YP2zp6axMQVvYvLzSzwY1r99XDjmzEG9s0hr2TF1DicCY/Z87wUnykxcEmXFK5BmPpzPdRbKmwiG9XPhfORr8Rnnv2PckD58LZ6Seqcn67YRcisZ0WQZcb0BYNotPOmnrTApyJcWeEDf+tHarqDxjfRQ05AwfXpA7wS5h2T23l6Y4WTHsbYNwhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=redhat.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSJcoY4+HAmGuyDEiIYVd4CBBAFTxbUWiQfpFvrvjXM=;
 b=Ob5FRIDBsx8M1mB4NwesfsNmb4HYZuBcRAZyLBml1ucFVeqyXMzNADIRm0yHQXYH5sksjOeNUqcY75UWpFyynOzd2A65sGeLS0+8W7ntCXOGLvwTorXRRV8GERGOKvoBici0Pme0T3VNnlmX5oF23+vkT1wUR/cXi3N5eO3mfnrvrC8/Z2r42BmnhTlkvCGqSiP0VBkIhj6kw4A2ZHUI9pUKbT0M2E9w33v0OugRwJsI2vKrYTjQFI3bFjr53akCpIcgzd8+HUe20aQMvvWMP8NJrBbum9KDF/y6M1GpZvQVqQb1UuK3zptfzml34hPd6XfhHLqtU18PhtLfoOqrqA==
Received: from FR0P281CA0093.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a9::7) by
 AS4PR10MB5371.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 14:48:52 +0000
Received: from VE1EUR01FT096.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a9:cafe::77) by FR0P281CA0093.outlook.office365.com
 (2603:10a6:d10:a9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Thu, 13 Jul 2023 14:48:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT096.mail.protection.outlook.com (10.152.3.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22 via Frontend Transport; Thu, 13 Jul 2023 14:48:52 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 16:48:51 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.128) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Jul 2023 16:48:51 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 3/3] platform/x86: simatic-ipc: use extra module loading for watchdog
Date:   Thu, 13 Jul 2023 16:48:32 +0200
Message-ID: <20230713144832.26473-4-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713144832.26473-1-henning.schild@siemens.com>
References: <20230713144832.26473-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.128]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT096:EE_|AS4PR10MB5371:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8ac1f7-621d-4409-7a98-08db83b0468f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xz08wHDpx6dY4ETWtNuR9LAd2b+f/NZz21fxNZ3UsH9xiE+GpakS3hEbD85hm3o+HB2mEecrnlWOBK6AhDGZHwYDOWCj2oAAWqrcyv10CvHYfj2Fx8MDWrHvT0WfNJ/d1u0yBsADbJL0q0KMzG/pk5BkZNR40MiIu0WmyN9hxnqa4fgorqCbcex1huICaevF+IK/LTBdIew+tYIAjB2D5a2/A/8FAlEExaFdeOencdAL/gJBJEB8LKuncsovR35yJLRI2MG0KyD7ApacJ2G6/zyEqzjj86SDcFivJYlgyyRit+sNOdyMTxQ4P1eM3haiq0dtNcIQ2fcrduWD2pMvsuJA/+lw//P4l8GoJevI2O7T7CnzEp6frp5cL05L9xGmz05+bHGNruL0GK6wN4HRdq4kb5KL9jOpRC9Xu0aaVmItoAFobA4ZPeQ70T24CszaYVLISD9mM2MK4yMYBJXEkHe9OJvqMWJhVG9GkcA3PDG0FJyctqHX+e6db2h2f2WNN19eg2FXsOjeniIQOA3q5ppwAwJ1i3qZyIzd+nr2bAHrIvYefSs69HFPNG02n58JcXTDKDeTberG7JcIo7/k+W6I0KAcVpiED374kuC+oK6dfVdP2xy+H97zzuPlJYAoIObsONDKrLszRmTTtdW7Iv9X06/2rHGhJIexcNkz2WrDDQXNXB+0lxoC4d9roAzevXs7Llw/w6Rf0ydVhZFPIaqLtuvwAWjCG+oVyPL43Vz5c6SPZK9bmtVKhGQpTmXjVMrU6QWItc/5j3bGuxP0zYtkWGvY2zTypTRZQ6O8K48=
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(4326008)(70586007)(70206006)(110136005)(478600001)(356005)(1076003)(82960400001)(81166007)(82740400003)(26005)(40480700001)(6666004)(54906003)(316002)(41300700001)(82310400005)(8676002)(8936002)(86362001)(40460700003)(83380400001)(107886003)(5660300002)(44832011)(16526019)(186003)(2616005)(956004)(2906002)(36756003)(36860700001)(336012)(47076005)(171213001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 14:48:52.3879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8ac1f7-621d-4409-7a98-08db83b0468f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT096.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5371
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently introduced a way to name additional modules to load for each
device. Use that instead of wdtmode to load the watchdog module. This
patch does not change behaviour, it is just style.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/simatic-ipc.c | 42 ++++++++++++++----------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index 46487b4e0016..ef59009db9cf 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -34,7 +34,7 @@ static const struct dmi_system_id simatic_ipc_whitelist[] = {
 
 static struct simatic_ipc_platform platform_data;
 
-#define SIMATIC_IPC_MAX_EXTRA_MODULES 1
+#define SIMATIC_IPC_MAX_EXTRA_MODULES 2
 
 static struct {
 	u32 station_id;
@@ -45,40 +45,40 @@ static struct {
 } device_modes[] = {
 	{SIMATIC_IPC_IPC127E,
 		SIMATIC_IPC_DEVICE_127E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_127E,
-		{ "emc1403" }},
+		{ "emc1403", NULL }},
 	{SIMATIC_IPC_IPC227D,
 		SIMATIC_IPC_DEVICE_227D, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE,
-		{ "emc1403" }},
+		{ "emc1403", NULL }},
 	{SIMATIC_IPC_IPC227E,
 		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E,
-		{ "emc1403" }},
+		{ "emc1403", NULL }},
 	{SIMATIC_IPC_IPC227G,
-		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G,
-		{ "nct6775" }},
+		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G,
+		{ "nct6775", "w83627hf_wdt" }},
 	{SIMATIC_IPC_IPC277G,
-		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G,
-		{ "nct6775" }},
+		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G,
+		{ "nct6775", "w83627hf_wdt" }},
 	{SIMATIC_IPC_IPC277E,
 		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E,
-		{ "emc1403" }},
+		{ "emc1403", NULL }},
 	{SIMATIC_IPC_IPC427D,
 		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE,
-		{ "emc1403" }},
+		{ "emc1403", NULL }},
 	{SIMATIC_IPC_IPC427E,
 		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE,
-		{ "emc1403" }},
+		{ "emc1403", NULL }},
 	{SIMATIC_IPC_IPC477E,
 		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE,
-		{ "emc1403" }},
+		{ "emc1403", NULL }},
 	{SIMATIC_IPC_IPCBX_39A,
-		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_BX_39A,
-		{ "nct6775" }},
+		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_39A,
+		{ "nct6775", "w83627hf_wdt" }},
 	{SIMATIC_IPC_IPCPX_39A,
-		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_BX_39A,
-		{ "nct6775" }},
+		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_39A,
+		{ "nct6775", "w83627hf_wdt" }},
 	{SIMATIC_IPC_IPCBX_21A,
 		SIMATIC_IPC_DEVICE_BX_21A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_21A,
-		{ "emc1403" }},
+		{ "emc1403", NULL }},
 };
 
 static int register_platform_devices(u32 station_id)
@@ -139,11 +139,6 @@ static int register_platform_devices(u32 station_id)
 			 ipc_led_platform_device->name);
 	}
 
-	if (wdtmode == SIMATIC_IPC_DEVICE_227G) {
-		request_module("w83627hf_wdt");
-		return 0;
-	}
-
 	if (wdtmode != SIMATIC_IPC_DEVICE_NONE) {
 		platform_data.devmode = wdtmode;
 		ipc_wdt_platform_device =
@@ -159,7 +154,8 @@ static int register_platform_devices(u32 station_id)
 	}
 
 	if (ledmode == SIMATIC_IPC_DEVICE_NONE &&
-	    wdtmode == SIMATIC_IPC_DEVICE_NONE) {
+	    wdtmode == SIMATIC_IPC_DEVICE_NONE &&
+	    battmode == SIMATIC_IPC_DEVICE_NONE) {
 		pr_warn("unsupported IPC detected, station id=%08x\n",
 			station_id);
 		return -EINVAL;
-- 
2.41.0

