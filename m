Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E917B30ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjI2K5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjI2K5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:57:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564D1139
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:57:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enb7LvvHKZWxtdPOLq1thtOGNHbgdcpS3lMTV7XR8Eaexv7Q52q1GdbCcJN4HIEGOqPey4qaOb5JNqX/uOjtmCrt61PvSB6DI421LqC9LLPCYR4a8q2sNJNOG773Y1itE1NY3eD3gHVaibaYUf694RwWFzubNkyV0gPV1qyfQaZByv/bZA/ygPE+d1lALO/MrH1GWAq3CK9SmkwZ5qC59GoPJB8TZKQAOuELnXH4IWjMnGGzEuWIY1c84Dbyg92l3bNAUQpmWPnaCiMltaO7XrYs7wh1HwPocFwoiIwkMIR7pBc8TV9DJWwqyfYcBBHIp50bUwKYXjF/Xv4aUTNzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7775Fau7bbJrjIy040YFr8hyoGXWhO8fALzafpsjl5c=;
 b=J8smfOTyyCU9B1vSKSSoN0Ry4ZN33r5ZAYONRx3fftB/5sBqj0zzlja3zoEoKq2nTxoNo28OWBzu1J4UGcajJaowxmOLFqoVFKLjjQYuEZso8I26jihCPpdnln3tZjrTLb1VicsNI9SH31lWaSDed+vElrCZJCFbFEXK2aNfujv/xfK6QSBf6O8hiI/Jb4WHfrxVHpm6dm1ccCzkrOIbT81YU5DZgyZIeNBUs2CwsV+QagAOUaiHY12QRkiREbtJGYYyFhN++PGkYo1dFamEh3GY4kUbdagmyTtwLSSRT5yXLppZQ69PZLrPquS1vTL9nqQxlmn3vWdlZ/VYj5edig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7775Fau7bbJrjIy040YFr8hyoGXWhO8fALzafpsjl5c=;
 b=otBks8DxQARfo9lzRd+uxXNPWAL7t86VqTfyg7z/h8Pjhf09jPCqD3pyDWJniUwAKSdjiTY8oILlvrkayzkrTyss7CoKuLB+1xPCT8nNqq9oypFwPEAFoDWr2r7VQCOMZkohyDNju58VTZS4CJ9VSLWVYIc42FAU763qQDQRT/s=
Received: from PH8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:510:2cd::16)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 10:57:22 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::da) by PH8PR07CA0008.outlook.office365.com
 (2603:10b6:510:2cd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 10:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 10:57:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 05:57:21 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 05:57:20 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <tanmay.shah@amd.com>, <sai.krishna.potthuri@amd.com>,
        <nava.kishore.manne@amd.com>, <ben.levinsky@amd.com>,
        <dhaval.r.shah@amd.com>, <marex@denx.de>, <robh@kernel.org>,
        <arnd@arndb.de>, <izhar.ameer.shaikh@amd.com>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH 0/7] update for versal net platform
Date:   Fri, 29 Sep 2023 03:55:51 -0700
Message-ID: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5746f6-0fd6-4962-0d0c-08dbc0dadbaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZje5Hnv9NQaNRvj5pNOMSbjgnjz1dJuuJ46lcfY0OVzUnizYG51BkbxEjNe7G3YHlAC/YTi57qhPmTOkLgkaE+NexmmbdIL57hN0DhoImyT4LY+/uAqwoyMF7DF12vCOYQW4g81I5XDtUkATg/VCxRjiQ3vGzfwlvd0uUP666DDR/zS/UDp+d5W0Tp+zRgcjohXkHjeuGZFbS/O/I9rwlUZ3ZNyjG28apGBIm16ENQu/mF0Ae/kXW0ZkxhP+hC03XQSBHzmbhoEUaoZ830AeF6er4/4LMdmIkEdU332uyF9dTD91a51RhV4aGXH0EpY6sjbjrzOBbFOKCrXPpRyWtAfkUewc1lXAhb2wOs7lc/ZjjG6OzsuS3YuDO87Vwm0z5WBEVfFe2cWopCJ13x1Q5S0iksdlqvmFpHg1aUWzrB7yZGrgZ2MMWtjBYUbFTxG79vkKsPTkubuQMYFVAOR9ATpPi+5W6wEDjRfUJxgpVpuRpwUKmA0rFQGrU8WVQOvKHJZ7dKBzAwoJ9SvxItYRoOcjJ17YCDpWeLSsQY2RNIBncYXyWL6//4JD/evd1PeqAOUDAS6nhZ8IX77Hpll6l9pyr3yqT3GjgJe4BFv4Bi6aXUshvmGuTATQjDxSPNOgVvxqlXd9GeO1hOjUW39yniRlcN8i02yDlsFwZzihX3eJJLeDR+lybn4zL7k9Nn0lxaXHre8faRIUNqOOqA0dhjA5nB/zF9llCrvGZNsmUiq2E9ua5D08bIfiHytlg8MRqcEm5gvO1yhAiBoT6soD3CDHDeU0tcZkE0qcCD0WMs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(36840700001)(46966006)(40470700004)(2616005)(6666004)(478600001)(83380400001)(47076005)(1076003)(26005)(426003)(15650500001)(4744005)(2906002)(44832011)(110136005)(70206006)(70586007)(5660300002)(54906003)(316002)(8936002)(41300700001)(336012)(8676002)(4326008)(40460700003)(36860700001)(36756003)(86362001)(921005)(82740400003)(356005)(40480700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:57:22.3190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5746f6-0fd6-4962-0d0c-08dbc0dadbaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update firmware and SoC drivers to support for Versal NET platform.
Versal Net is a new AMD/Xilinx SoC.

Jay Buddhabhatti (7):
  firmware: xilinx: Update firmware call interface to support additional
    arg
  firmware: xilinx: Expand feature check to support all PLM modules
  drivers: soc: xilinx: add check for platform
  firmware: xilinx: Register event manager driver
  drivers: soc: xilinx: Fix error message on SGI registration failure
  firmware: zynqmp: Add support to handle IPI CRC failure
  drivers: soc: xilinx: update maintainer of event manager driver

 MAINTAINERS                             |   2 +-
 drivers/firmware/xilinx/zynqmp.c        | 212 +++++++++++++-----------
 drivers/soc/xilinx/xlnx_event_manager.c |  34 +++-
 drivers/soc/xilinx/zynqmp_power.c       |   2 +-
 include/linux/firmware/xlnx-zynqmp.h    |  31 +++-
 5 files changed, 173 insertions(+), 108 deletions(-)

-- 
2.17.1

