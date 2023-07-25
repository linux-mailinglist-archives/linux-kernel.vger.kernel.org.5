Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB1A760F55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjGYJem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjGYJeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:34:13 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2079.outbound.protection.outlook.com [40.107.14.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544B9469A;
        Tue, 25 Jul 2023 02:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFcwSfYD/PQ1XwKz2SxsOvagj5Qlj3uGfOo7+FB8XPW2FgawBlc5XU3dvzP5w+Mqy8Fh9Edpdks9URLIRwJzWDmkZcAGAvBVHbt/8XhfOzvrJ2GIQlCQSn3oCJ4ZLCDv0ePmGoS/DMbjiyXf7LFFbP2Ix1lNgNWqxv6NK5TDcyAl/ukKBQv/Ht2XUAXFAbeliodzTnbIbC2noApcPJUOkfevJYr8AerJVpAV06rN2DjktHLAQc1RWTmJ7SjYaYANM4rzJNwKaJa3OzwdN1IiLPEsdczS10ae3BAtK/3rEUgYxFGFYI/ENIUUwFXzK7cBMtKrSsBBzD9HZE1XhfP5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBZvBbrWEghCAbIQh0iU53HT1iGjjEkXNfOacIA4kVs=;
 b=g6HaMDklYdxIIops4ITNSswR/64UxJ29oBntbUFFED4Bb1x653s29b7ZlBxpqd6cxIrJ/kUzsg2G4xggUqrG5rOygRJxwHvH7m8oHaf0MjCJNP71hZswsEOZON/ECJjOLPmElRCus+xHSZ0Kq2nyLuQJqwUpy8/XLcAP6bmxvOO5gz0T0YsdQUDk5mOIi0LYyqYtOsp73wdNO8iniDiHKBQsQ/KKQ88S0FCuHHG1Ztp+Pli6KrEsrv6WvB9lPpNs/BURn+8SWAZea5JDVisaBj1TPb5tPFNoYuohsC/tCWnFwlivxfqUc7ISRhxdnWdpYagVEfW/yPCAcaGxlGocNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=redhat.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBZvBbrWEghCAbIQh0iU53HT1iGjjEkXNfOacIA4kVs=;
 b=KhitNDMeok2ic4Xwwf6iWpetADuEVxY3QBn3OYI6jBH7VNidydBX9ElmgGkElkpPzD3KCV4zPMTzOWQEUvstgoTsyjTB1dydENQBOjFV+vZiGuBLPXvKtleC2V1gAWHtJt5oYbK8b1PPTEFiquGesRnc9wuu38tMk+WO8cTKQ4BK9mpKDUs1EfA56G+d3HrHkMErX6VVfgzghA+7VZx+Ns+CDk5YcVHHvF8cjSBz9hGiGVcERO8R+y4H1JqjNm3jtdH5VU0tjFsDI5B0JHYPO85YoD2LT1dOsIgFnXPzEpFkjjoj8TYDOA/nIYYx5Z34qP4iGBdrGbK0/a+ux9XBpQ==
Received: from AS9PR06CA0706.eurprd06.prod.outlook.com (2603:10a6:20b:49f::16)
 by DB9PR10MB5668.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 09:31:25 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:49f:cafe::6e) by AS9PR06CA0706.outlook.office365.com
 (2603:10a6:20b:49f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 09:31:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Tue, 25 Jul 2023 09:31:25 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Tue, 25 Jul 2023 11:31:25 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.68.189) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 25 Jul 2023 11:31:24 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 2/2] platform/x86/siemens: Kconfig: adjust help text
Date:   Tue, 25 Jul 2023 11:31:13 +0200
Message-ID: <20230725093113.9739-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725093113.9739-1-henning.schild@siemens.com>
References: <20230725093113.9739-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.189]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|DB9PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 038227b1-eb74-4925-8868-08db8cf1eab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQ8Qo+BJknTFeD6WN/KoZtCdXTRar4vqSmig4D3iotyKVt5s+TJKLeBx3zqy1I1YIsQwc8bbjo94rvcGPeSZrsaQhmARwawwBpuJgapX+V2yJ8ZXbmjGF7WbVM7Gcw8Ac+OEohsddeAHPpf2zUFuUt+zCIQ8uwV8pA5sv5qxQOZa3YD8XS+SsrDYgR2PxZWolci8eSL8OgviNFPUyGvdxXoY4wIhCmh+Nsy9mxN5oiPpDmb+KluwnhGUzhWQQzxltkCdwBTZEabrMRLn6odt7g4dCmMR1mdJ7rUFtIZSJb0eXOUp/o3RRKzsgj8itnsaFf8OPnMNSj0XsVO+jX0bQRR29JyF7PlTC/KbVTytSsK1M9kuSqSDFu0rB096IXtavTMnld5UOpokvI1NzMvZG4UiOd7X8Szc/5b19iawW4dJ3+Uxka+lMOKO+KcsQO6b1k2pyjQq+H4pyfyGTaSVZFOV0wQGnt1aTv6tb3d67vfBvM1HNvja91F9JUA7wie6BJ/Q/f9c7P3GekVB+E01BQP0uj03Mr6QB20sk2ESctZ65Fs1zP9wWrk0fQLvLqa1hRWeluuJdRmgzIWe64p/7uKT3XXd09TGOqcr3RJhYHxuZNtWYPZ150wSQbzxNYi5o9Eb9DNfUndkZTQpcBDS+zTLBR8P4eareAKLh5qQmKaXDC6eTkB2wPJITLa79JSik5z8qDiBiP9nP1eIAgP6Zqcwqnoe89kdBvJTaCJCUc5Uiur6LtenLFog/PJHJF6c
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(4744005)(2616005)(956004)(2906002)(82740400003)(40480700001)(40460700003)(83380400001)(47076005)(36860700001)(4326008)(316002)(70586007)(54906003)(70206006)(107886003)(41300700001)(8676002)(478600001)(6666004)(86362001)(36756003)(356005)(16526019)(7636003)(336012)(44832011)(7596003)(186003)(82960400001)(110136005)(8936002)(1076003)(5660300002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 09:31:25.5557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 038227b1-eb74-4925-8868-08db8cf1eab8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5668
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a copy and paste mistake where the module name was not
correct.

Fixes: 917f54340794 ("platform/x86: simatic-ipc: add CMOS battery monitoring")
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/siemens/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/siemens/Kconfig b/drivers/platform/x86/siemens/Kconfig
index 8e78dc609a38..9c227a19432f 100644
--- a/drivers/platform/x86/siemens/Kconfig
+++ b/drivers/platform/x86/siemens/Kconfig
@@ -60,4 +60,4 @@ config SIEMENS_SIMATIC_IPC_BATT_F7188X
 	  from Siemens based on Nuvoton GPIO.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called simatic-ipc-batt-elkhartlake.
+	  will be called simatic-ipc-batt-f7188x.
-- 
2.41.0

