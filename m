Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D0783A01
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjHVGcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjHVGc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:32:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119BB1A3;
        Mon, 21 Aug 2023 23:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXz7mclsaeg3GCvaCIbTawia804Dqyg+nk3mtfCW7U4sGkpylSPABmcx91sjFE8h6ygCBjhIVAeQfQcNlcYtbxxldyEe2YjZWBEUpjvQGWiGDRsccDCven/eprDiVvxVXTFt94uJBnAARjaonvXv7FG8ZlgKYNfxmrmfCFle29VHam/7C1SntVSn+glQRKgw5qS9seWI5SqoqeSXmeO2BIKLkHEiLFzW733/ZnQq+B0qeE7wKlx8KVAHIubR2hSRpaHhoL/ClRbl56nZwAOYGb+dDrByMCw3A9HfUIMLRpfcZdmate6V/aD0Xt3M2EaJC7Ab7gmmCoC26yF3Rb4GkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpPrHEE4ddnOxj+Nlc449tY6ETQWkegsX1lHKRzxeFQ=;
 b=X0TunI/tiwmI1VxKCzbSy58YbVDSNFdJTeIaRwxqGTwS4Gbvzb2EW9QKX2Ib3zha4cCW0nw+UCw94mrbYKVm13TnXVxVZualFWYFwPs0KAQOm/eFGGFANrKCRM1ZmvkEOUdflc5uWJpN0UugaFkJ+TcjkoQr9tiZK6l3hR/41klo0k9cRYnaMxdwlA8yvoXl84UMRO/uiPsSpivJsLSM/0bvLMHCykhHnvg+fean9h6fWWF4r2luZ5joK0TcwCc6+1FimINUwdDKYysbqkBNz+MtI+MXKs++iv8yz4XgnKwRjcnkYCNsp4t0AwRzG3TVaq4teHTvixp62iwSvJgXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpPrHEE4ddnOxj+Nlc449tY6ETQWkegsX1lHKRzxeFQ=;
 b=JignJ5O2rOInwQg8JRw0x2cycBDz7GoDdo7ssMCR99xWZPx6n8/HowbGBEKr+yoee6oPCCbNdEjwpxKn4WlSUAzlou8VpKildomfyXx0sPrLZVwdw/Oo2DSYP5rzA0xJJK5/4WSgMisBeEgtQGC1PdyB31oisfYdvbRXoIC24BU=
Received: from SA1PR02CA0007.namprd02.prod.outlook.com (2603:10b6:806:2cf::18)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 06:32:15 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::ef) by SA1PR02CA0007.outlook.office365.com
 (2603:10b6:806:2cf::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 06:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 22 Aug 2023 06:32:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 01:32:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 01:32:14 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 22 Aug 2023 01:32:11 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <u.kleine-koenig@pengutronix.de>, <linus.walleij@linaro.org>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 2/3] usb: gadget: udc-xilinx: fix cast from restricted __le16 warning
Date:   Tue, 22 Aug 2023 12:02:00 +0530
Message-ID: <20230822063201.16929-3-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230822063201.16929-1-piyush.mehta@amd.com>
References: <20230822063201.16929-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MN2PR12MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f0ff23-bd98-4bb0-2d2f-08dba2d9868e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObhCoT/HK7IockWRvPwE81SZwJDnaKUYsHkGAJs0rJx3ig6hp6koWnrfHsBj4HXZqoKi4ffpPR4FQ7KHUEPdsfIrST6TTUqOXlMQYCm3RBl5MDBtzVDf0ysCjikuPiTN/qObQnT5fuPOAE7AdkbnRrQ0Q82XTCqFcWQHMuAwihYTKu87ddzc6RUnuqib5p6KxIUTy9yrW+i84t1mT/0tOqc3DdS/NrX/itgtqBBMxQRm52QoZJ+1Atkt+rIcZbo7IHHd6UtFLrkWCX3vxXaSyYJDZFLVucbW6GmsHIycyfWEQb7D5R50GzQRJ3/w4qLvnPahBQ3816q63MasbG236c2SsgTytCunCsz6s3aMmeR7Z7GYXAwkPupjpYsl4tOlhy1/KjLZSKrAtrhb7/fM0fCqD+UIm+aMX1Aiq/oNJoP3YBn0oj8m23gCBlRnLHFXxye4g7ET5jgb/dhz3OHZSJkPBPGL3hkFsm4/2sLlGqRZZVjoozimzgA1WOWMHro5ZNuj/3NNBLZX0LJxVePa3jYy8LefA2NnyUOlT1q2mxt/lWH3mPHR0cZTf039pmKBaLh6dceNvZ1ZEvZawyVaqH8/J4nwp/GV9ippwfs1mr8rPGkq/QI/fceYcOERiapAyyiCo4tP4mBCic51scu0ZDJMH+DJol5CWTRk/T6rOtRVMfln5WwFGvhPi2BJfj1OnbGYjCcRYTBiH9f3kQaUsMolw7znImT/dOIxDGDAYYxtTkwR1zg//9yJ6pTTmJ3T+KgquP0AdwRrfZfcW/elqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(2906002)(40480700001)(83380400001)(5660300002)(44832011)(336012)(426003)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(70586007)(54906003)(110136005)(966005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(36756003)(41300700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 06:32:15.1499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f0ff23-bd98-4bb0-2d2f-08dba2d9868e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_ctrlrequest member wValue, wLength and wIndex are of type __le16,
conversion macro cpu_to_le16() input argument is __u16, so properly
typecasted to fix the cast from restricted __le16 warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202209020044.CX2PfZzM-lkp@intel.com/
Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index e6308414cd1f..476c0a8fc5e7 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1757,9 +1757,9 @@ static void xudc_handle_setup(struct xusb_udc *udc)
 	memcpy(&setup, ep0rambase, 8);
 
 	udc->setup = setup;
-	udc->setup.wValue = cpu_to_le16(setup.wValue);
-	udc->setup.wIndex = cpu_to_le16(setup.wIndex);
-	udc->setup.wLength = cpu_to_le16(setup.wLength);
+	udc->setup.wValue = cpu_to_le16((u16 __force)setup.wValue);
+	udc->setup.wIndex = cpu_to_le16((u16 __force)setup.wIndex);
+	udc->setup.wLength = cpu_to_le16((u16 __force)setup.wLength);
 
 	/* Clear previous requests */
 	xudc_nuke(ep0, -ECONNRESET);
-- 
2.17.1

