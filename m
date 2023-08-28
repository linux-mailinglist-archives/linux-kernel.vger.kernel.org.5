Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01A278B3D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjH1O74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjH1O7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:59:32 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586AB125;
        Mon, 28 Aug 2023 07:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnL0w3CVaOJJLw64c7jFRN0HaW0O5i2YFHUClrmRbsiJLRkunLTzI2OMKgXdYiWqkKZhWTW7EUzlMV8aQ1sClyNfToBJt+cDDOAkFcYf/9OQrqFFbPm7h0zPQ8KSvP8WUJkfJAC6cqk9xZCvmSU6JzfMTVavbWqDilJmivFNdOaCcQzU5ddqX3s5r/hT8NYeN8zuQYEZhAuP6MybT1reMsKslsvl4CIrt0l+tuRWOhyuejY2gQUbhXr/VVVRwbiLo4aRG3eR/eSql225x/zROElkp0wLi6zwSUuq8gb6ulHcMSzGJ2q8bPSHoVG4amlk+6ArFd3pZrArDSubvEkBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiNpyDqRiYWktV1C64e2mX8bZeZaw6NqJ2xejZ25Lrg=;
 b=BIKmbzWepF+svr6elqeRVGv2gzvWblrp1C4ABEoDTxaeLLePH0s946RUhetqC8Gmi239NqgLFCl3C1w06TW+CGfK7+oeJD8GvE3y5Wc4bHSPcBXRcvPQ3rGToEWmtlOi7rPgqFZrF6nOAEy3DdewTQkJPoZk2Ll3/zQFyVMiJpSczoO3+n3/IKDMq8P3xZd4eea66w0a8CLfykPpY6gsPOlTleTwh6u3fhId6F1E9J8DKXDiq5fnBeOxOtqKI/WXzksRb0JuZTKKWDjn6To/GO4CTjPu2yd0k2gam4l9iZ2mJxEyVsQmBCowmsiqJh+a6z4DqkkJMqrltXL0M+rMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiNpyDqRiYWktV1C64e2mX8bZeZaw6NqJ2xejZ25Lrg=;
 b=Tavv+SC/lvg/b4Rj5yCXE4pJf1F2ssBvNFCpF3hYZcITE7r+WkdDGmoH88g1RNvmG4cRP55MgoYzHsUdcPOT3wq6g+OXeM5CgcTYEVlKoE4r0qa7FNn4/ubcg3lRIVBDTm/U/87Q6lavBVzxhyRfLa+VA4qBSwNWMLlKPySWvQ0=
Received: from SJ0PR03CA0230.namprd03.prod.outlook.com (2603:10b6:a03:39f::25)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:59:25 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::15) by SJ0PR03CA0230.outlook.office365.com
 (2603:10b6:a03:39f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 14:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 14:59:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 09:59:19 -0500
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 28 Aug 2023 09:59:15 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        <naga.sureshkumar.relli@xilinx.com>,
        "Srinivas Goud" <srinivas.goud@amd.com>
Subject: [PATCH v3 0/3] can: xilinx_can: Add ECC feature support
Date:   Mon, 28 Aug 2023 20:28:42 +0530
Message-ID: <1693234725-3615719-1-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b587a9e-6645-49e7-dc68-08dba7d75e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EodCXGZIPQV2qRC3kNTSHRTediW+X5DNVbEjWHpATAW2bOB2SlDNiOkHG7FB+WNsyxRs/vh+CG+QlrVs0dGTqaMnn0PElK6rXjkpgsAKedKDzfCawjXlm0aGL3/CnjS437SllxkxN7ifB1+4tcGkYQ7Z3wwfJm6krbFeO5PwKuw9TGKHntEKH1eb1xY2kPScLPABP5FyxeE5zF80sQIoJJ2htuIuxxMjbxfiVQeFCHePIQTeKq46pSEe12cNjnbHlWgAd63qnuIomLMQ7n1VPgzQAHjCJmQq55rDiT9kE3MKD5sl+JlNbaQnWmPu/F3KUmpByOFFvFPTaLRpwc0kE1DuduxkGH6xNM9glFy4tafjskZ9aTRZkDzPDMk3qyFTjvZul62EndQbIyYbkqH0EkIvyFX9wQd5z4OIAjrvHvUWxgZCfMLjfo9yWqhM/WCVFbEhFnMBTMZlaw1K/b4zFXvkC7Rx5ILh+LMKAPJanCDgbTY5+51Oww9tMZx9jGbAy4Lqt61WiHzdVMTnK16Wd5jRp9agwhQKtDVX/PmzGGeto/+JchdU2Yd78ToHStP7fuZNjPyzsTlHhoO56zzScyJ4WszCANtKzPkXwSgEtOvULUmXWVWXtGhCTjY3+gdgohQDOmHgSgXUNMq4ZZHyIElRcy29+099KC4TX6l3mHBquY0koGfNAQi6laFWKnnlectab4RfLgO5Zn9bgyFecuXJOOixVvXz0MrFEmLMaNZ66Y2tzikKdK6Fx1MqWgNavGD+j1RA3T2LfCbRjlUxCFYWcjEJFhBgQ7QRTVykEbI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(82740400003)(6666004)(36756003)(40460700003)(86362001)(81166007)(356005)(921005)(40480700001)(36860700001)(47076005)(2616005)(2906002)(426003)(336012)(26005)(83380400001)(478600001)(110136005)(70586007)(70206006)(4326008)(8676002)(8936002)(5660300002)(44832011)(41300700001)(7416002)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:59:24.6084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b587a9e-6645-49e7-dc68-08dba7d75e75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ECC feature support to Tx and Rx FIFOs for Xilinx CAN Controller.
Part of this feature configuration and counter registers added in 
Xilinx AXI CAN Controller for 1bit/2bit ECC errors count and reset.
Also driver reports 1bit/2bit ECC errors for FIFOs based on 
ECC error interrupts.

Add xlnx,has-ecc optional property for Xilinx AXI CAN controller to 
support ECC if the ECC block is enabled in the HW.

Add ethtool stats interface for getting all the ECC errors information. 

There is no public documentation for it available.

---
BRANCH: linux-can-next/testing

Changes in v3:
Update mailing list
Update commit description

Changes in v2:
Address review comments
Add ethtool stats interface
Update commit description


Srinivas Goud (3):
  dt-bindings: can: xilinx_can: Add ECC property 'xlnx,has-ecc'
  can: xilinx_can: Add ECC support
  can: xilinx_can: Add ethtool stats interface for ECC errors

 .../devicetree/bindings/net/can/xilinx,can.yaml    |   5 +
 drivers/net/can/xilinx_can.c                       | 154 +++++++++++++++++++--
 2 files changed, 144 insertions(+), 15 deletions(-)

-- 
2.1.1

