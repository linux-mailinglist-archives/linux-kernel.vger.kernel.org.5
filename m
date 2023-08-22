Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3F4783A06
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjHVGcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjHVGca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:32:30 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DBE1A4;
        Mon, 21 Aug 2023 23:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBezX/+/9GQ9PbMSj2P3bq8WPexMmntmRglWXfDbLo2DX8e84SJ0s5pL85TYfHD797+tjGv8zjuBqRF8EMUIpZRD27VNxmzD2GR8XyE1O67/V3txHKgXX9A1AsBzbzwfsh8Hpfok43eMsFIL8fmu2WVpA31n9ZfQv7f+0gms350TMq6ZpyMJYYaQGULwG2QkIj4HqajjKB3BuIVAh2GpE2uH+aREJQ4Mcf2h4LVDbIhk9D8aqe/o2Pwk7VXH0SMO+u8TZF6MOQHRh07jd5lBGakhP62IFwflqYIHVcbxaosF6iCfWOktwpEx7b9gbW8f13MLX1+I50vsxpoBPpKMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3/luZGIP2yZkNSQosU26Zs3McFWtFDRsmMlXPnoZG4=;
 b=hiNmWMO0J0/bUvOXzEB7NbzmOl37UcKvPP3VAFn7UKT/b1vTQaSY5CZtO2qBhiLjlVAMjRNm6ZhlQf0MpUgNtMhPx9JOwMn5aVsRlBUMTRE0rCIo/bhChVjybfh0g8RKILy3F8XUcXng+TPE8xR3FnmtTOjpu07+scKpkQ2pnkM2m4qjetBI7ReGh21gUdzknOfOqu+4l3lXskXeQFB0d/5o/GdMqAujN8+i83QRBu+ef9K1R69ny9NP2/DSdrxZsQ4x4WTQDjFpg2L7C6XeOLDPI1JcE4xmMuatGUvFUGMQFomwQGfJiPs5srttwCKvkapnYq6a8B46Bkq5MQML3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3/luZGIP2yZkNSQosU26Zs3McFWtFDRsmMlXPnoZG4=;
 b=O6W/fET4sb7rf60LE4iyDKy3rwTl5gIerInLGd7Ds55FME9Kr7bLmTD90EjV8gK1JeQsSft55H5m12rD7UnuhkgKJA5M4waB4p3C04Ws4zTbeqFU4+JuSg1EEAkOflQU2JYp4tM21SG+KomXqaRe/Dpo8sohry6awptvPTWzEVk=
Received: from SA1P222CA0137.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::6)
 by MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 06:32:18 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::e6) by SA1P222CA0137.outlook.office365.com
 (2603:10b6:806:3c2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 06:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 22 Aug 2023 06:32:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 01:32:17 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 22 Aug 2023 01:32:14 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <u.kleine-koenig@pengutronix.de>, <linus.walleij@linaro.org>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 3/3] usb: gadget: udc-xilinx: fix incorrect type in assignment warning
Date:   Tue, 22 Aug 2023 12:02:01 +0530
Message-ID: <20230822063201.16929-4-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230822063201.16929-1-piyush.mehta@amd.com>
References: <20230822063201.16929-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|MW4PR12MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: b55912b8-f052-4630-d7fc-08dba2d9884c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pVd4Wu7glJ1URHRErvu/mbl+vih/A6VHmVyulLR3NWkopebWv278ZxwI73+f6Ljhm3VZ+vR2yIQuypf3ddpUDFb+dy9NSQzIiubmmPoL4TIn37/D1k5VPbLSN3kFwi2uYPU54xJSSFPcW1yZ/YYMJV3XHuwlS5wNC7ZZvbOXnuaMoipQY+ATQYBe66TIznjSvMhWw6eM2nAxyEI7apuwc5apq9RRJ7Ir3pccELHr5sY6qB31ttms03eoy4klt+DkDBtvgmYb8UdHNGPem0LKQCPqbk51zdgzTL9dsuU8u4OJtv2o92o2P92lytqtCK6M4oUSE/7J/iz2TElfmBQjQpjOJnc+VFKQNX7KnJZw5xbcZEPqnO9ELdWl0yBM+XdSFdqq7Ktq6pvOi1yHtXLVeiZ/KvUT+s998HuTnd9LL3MPUyJMcCpmAcUtWfrUUPS3Ai+cMYIb+P6BkHUcxxcBuaKodo+KqW7GVXs0U8CWVfiZcsgMmp3y2TxhLoppbMrS3SMbUmC6+/2U5Gt8gKiWWCAiMbRMh087Nab4WApEjZwGf6/grefrxkuoxLLaQ+jL62vmPy/a7eWUd5T+QxrmYb3JSoe170T1bHWtzhy7OxgrD27oUYz8mYq1S4bTH7H65Q+Eu05FGUOZxXYiPVBt89da79ENiRWDrCQiyCKNjm229NV5iFsFFWXVXdSCc12yLHIScIrnB4Yh5hwX8tqrt39OILMYTSbNFWMnjMDxutuHWFaaOwqXyIruzGElwPWuwrub3wXCXoG3WQIu5hPSBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(2906002)(40480700001)(83380400001)(5660300002)(44832011)(336012)(426003)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(70586007)(54906003)(110136005)(966005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(36756003)(41300700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 06:32:18.0616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b55912b8-f052-4630-d7fc-08dba2d9884c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bitwise attribute is used by the sparse utility to make sure the
variable is converted to the local processor type before other (unsafe)
operations are performed on the variable. Fix the below sparse warnings
type casted with __le16:

warning: incorrect type in assignment (different base types)
   expected unsigned short [usertype]
   got restricted __le16 [usertype]

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202209020044.CX2PfZzM-lkp@intel.com/
Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 476c0a8fc5e7..0b12155635d9 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1638,7 +1638,7 @@ static void xudc_getstatus(struct xusb_udc *udc)
 	}
 
 	req->usb_req.length = 2;
-	*(u16 *)req->usb_req.buf = cpu_to_le16(status);
+	*(__le16 *)req->usb_req.buf = cpu_to_le16(status);
 	ret = __xudc_ep0_queue(ep0, req);
 	if (ret == 0)
 		return;
-- 
2.17.1

