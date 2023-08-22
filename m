Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F8783A02
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjHVGcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjHVGc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:32:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723FE19F;
        Mon, 21 Aug 2023 23:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehC7qj/dz4paPJeeoe/R/sxXnvobZJv9w0yerF4391G39h6ajDMlg4m8dBTyXGhHl5tbfH1kxkJZdtaoRMRHBKcy+zC3e+bV2rQ4ItBbe7GhOWelqMFUYG319i4zX+f4x6iJ9P/HPmpfQ389/SXc8gBSF5wJUAFPWmiAnZVaC2IEyYLpCO7ZNIUKz/oy7mRzz7IKqc5j+rAtJt9uMTbpZ+2W/Om6cKRbzVyzoWOogkjkXpUVgjRtHpE3wj8eP1l7NalTNLAezoDA8sucBFDykFCClxHxWCSy+IM2PPfUMVonxTntd+7GC5c+rGk8s9VNLK3zlpRO+WOre9cwVwyWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MjL+ML2y6Enkx6e9QqFUpIzl+JaghabegtSoU4mUiM=;
 b=hTIgoSvtysUtwHrUq0N/2LCuqlcSFM+ko6628QrFJr0o4DrD9uUT3U0GUoCkD6M0V/Y3BD7FkE+oueWtyrqgpYWlB6VA4x5tMWnGFISO04411E/EXEGDkRxyv5Ps8vfB12/YpBNjJwAdFHDZI54gqwst0VMLGFtHKP8raZhvfuos5GAWnR/jNDbpzRRG84+EyFVButkYlI1W9ROz9YXFq/g43shvxp50ithLzM7m6RehOfTiWTown74cava/4SBg/m3PJvNtAdLWD5N4X8TnQHswSw1S9tMj3FpgfvjbGh0p4d+AdOymAf9hVDkGlJ56MTGUl8p98d+USVymS4Hb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MjL+ML2y6Enkx6e9QqFUpIzl+JaghabegtSoU4mUiM=;
 b=uUv19XgxLVRNQWOkXBJtjsOoED/Mk2qWLD9K2lkPKkOHkX9wPIZcKJY/63ixijn6R9tU7E9GDQqJBKMZU0+pK0eSVD53FR1jqNKSHZ7+AQW11xkgMm4V+0bFbAZt+a/dlIb3+hCzca/d5MutJtKsDwzn8Iz194ozNsuF/A3xmnw=
Received: from BY3PR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:217::7)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 06:32:14 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::eb) by BY3PR04CA0002.outlook.office365.com
 (2603:10b6:a03:217::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.22 via Frontend
 Transport; Tue, 22 Aug 2023 06:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Tue, 22 Aug 2023 06:32:14 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 01:32:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 23:32:08 -0700
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 22 Aug 2023 01:32:05 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <u.kleine-koenig@pengutronix.de>, <linus.walleij@linaro.org>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 0/3] usb: gadget: udc-xilinx: fix warnings
Date:   Tue, 22 Aug 2023 12:01:58 +0530
Message-ID: <20230822063201.16929-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b17615-9798-4e6c-e2e9-08dba2d98632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQbyo4P9dIpk0IRPaI4xQ1/Lis+dmKtoGG/Y/z51clweXzstftBeEAFZWftJg76vjYeiCgbTw4uTLeiccJWXnRyoVzkIvFKY004JjM2NF9+J512sl0i7jX5ayjEi9BrCHpUMVQozusg0pI0+MBIjIz8+Jn568H2S5Jbff+kInb8VmBasQT1iE+czYI4VuO1WysqxmxDt2EKu+3hKOTuGliI+3Wkl+bCdTPIYmUm3+Eawu4ylZsdJWxqvK2IxLKujlPr+65rEhhRUc42QAxKFwme96y5sEWJWiL92G4wK5WsPbWPieDA6nPAPyuGf+3TloAMjZrHBu4TCUHiZyPbtPgpzeIqFSdtx1AM1LWzSVyog7GtHt6o8RB3XAdHUtEKyS0iAFTNK1/yatzq697UwSDgzfm/B1aHr4FjLy/nAzEbhBqz5pVS4Y2VijrPIyb03kSkepJ9958nq9T9ip4MccwGtgFZV273wcTMCLkxzoUxdHLs2UhNqLWm47Iu1a+jSgdFpW2pVZ72102sF37QAORf8zvQc319Md30JbWi1Qu9Nr9f3eBIZ7DA4lIM2A/2I8sAhhb78fQYQM3OmmhcBGx6ISKUc1eN/U2Cc8VD+TIDo7Pnd2kD+Is0AaqrnUwIyiGmV8zDJLDqE26RSjvzBwbxckGxGTeES94VM2udyn3BAq4OzbJK8f6LGXCrcG5DXalUbXMp+cGF7zrHOgdnuYsqN/UhDoOyqzL97iJwD6Tfg57J3lFct2+djQ7PxvHKPskzwiflWb/q9Pq8nBG2RlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(70586007)(54906003)(70206006)(316002)(110136005)(8936002)(8676002)(4326008)(2616005)(1076003)(40460700003)(41300700001)(36756003)(82740400003)(356005)(81166007)(478600001)(966005)(6666004)(40480700001)(2906002)(83380400001)(86362001)(47076005)(36860700001)(336012)(44832011)(426003)(5660300002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 06:32:14.4579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b17615-9798-4e6c-e2e9-08dba2d98632
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed below sparse warnings for the udc-xilinx reported by the kernel
test robot.

Link: https://lore.kernel.org/all/202209020044.CX2PfZzM-lkp@intel.com/

Sparse Warnings:
drivers/usb/gadget/udc/udc-xilinx.c:1620:35: sparse: warning: restricted __le16 degrades to integer
drivers/usb/gadget/udc/udc-xilinx.c:1626:31: sparse: warning: restricted __le16 degrades to integer
drivers/usb/gadget/udc/udc-xilinx.c:1641:34: sparse: warning: incorrect type in assignment (different base types)
drivers/usb/gadget/udc/udc-xilinx.c:1641:34: sparse:    expected unsigned short [usertype]
drivers/usb/gadget/udc/udc-xilinx.c:1641:34: sparse:    got restricted __le16 [usertype]
drivers/usb/gadget/udc/udc-xilinx.c:1669:35: sparse: warning: restricted __le16 degrades to integer
drivers/usb/gadget/udc/udc-xilinx.c:1669:35: sparse: warning: restricted __le16 degrades to integer
drivers/usb/gadget/udc/udc-xilinx.c:1689:46: sparse: warning: restricted __le16 degrades to integer
drivers/usb/gadget/udc/udc-xilinx.c:1695:46: sparse: warning: restricted __le16 degrades to integer
drivers/usb/gadget/udc/udc-xilinx.c:1758:29: sparse: warning: cast from restricted __le16
drivers/usb/gadget/udc/udc-xilinx.c:1759:29: sparse: warning: cast from restricted __le16
drivers/usb/gadget/udc/udc-xilinx.c:1760:30: sparse: warning: cast from restricted __le16
drivers/usb/gadget/udc/udc-xilinx.c:1872:34: sparse: warning: restricted __le16 degrades to integer
drivers/usb/gadget/udc/udc-xilinx.c:1883:49: sparse: warning: incorrect type in argument 3 (different base types)
drivers/usb/gadget/udc/udc-xilinx.c:1883:49: sparse:    expected unsigned int [usertype]
drivers/usb/gadget/udc/udc-xilinx.c:1883:49: sparse:    got restricted __le16 [usertype] wValue
drivers/usb/gadget/udc/udc-xilinx.c:1888:47: sparse: warning: restricted __le16 degrades to integer

Piyush Mehta (3):
  usb: gadget: udc-xilinx: fix restricted __le16 degrades to integer
    warning
  usb: gadget: udc-xilinx: fix cast from restricted __le16 warning
  usb: gadget: udc-xilinx: fix incorrect type in assignment warning

 drivers/usb/gadget/udc/udc-xilinx.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

-- 
2.17.1

