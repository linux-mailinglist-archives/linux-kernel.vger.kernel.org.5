Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ACC7C82D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjJMKPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMKPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:15:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF2EAD;
        Fri, 13 Oct 2023 03:15:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb1RQfQ30N9vRhvdmXHj4iWPnjGSlmwEnhV0Ihao/4PACHDoMgxaG7pqsQG7ucyDQlr7BcNdbLXDcm9ktScH+1Ur2bu1sQQB9y8bV6EAaewpcoTRF6OpxVTG4VPf5+RUHglD0q3H+bDJchOtNBet8PkZcnsTyJHEWWxFEtsgABOHEG+qvNcu+BnmaWIafSsGGQMjDR+F/aSQEpPw1l7CCWmcnupuoBvpmfqfm5zO7xCL7lIwXNX6I3dS8lkxtecXoA8C7lTmoNpPESbl1h5dEeBsemHYIqm27n1cYAX+Gw4j/lxc6dNW0BKASzNOK2wEG9PR6qWOJ8w0pWNVir0opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pnqJWGqcHKd1ItX8vgK47VvtPzK3wzzGVR7FFyTKpw=;
 b=Zp/qT0HqJiVA0lOyztUejjlJHhpd2KT3TKixXTCFLr14kjJcpQigv5wJvq3jBEO3fpD4GdAUd7Bk/bY3gIZTKDm6+WoBZMIjGAhH/zDi1FqMOC6fG0xuoyDk9fLakHITn7ASU/qGZVkgBdbtYEyO8Z8RTqkGAzep9m/LfXIlPj+9TllakzKGbZ2J49TP/kcBnTZQEENf+anfVUTMt951gH7zJay3kWTbcn894gHoWzAcGXUdYHA0lh/m/Bx02pbHW6mOwJK108p1ISkXkPD7RFj2eyUlmXHeHUn0lv7Rrw/QJ26vLorI/fQjDVc5B2TNVquTZzG4cmsLpTbCkvhZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pnqJWGqcHKd1ItX8vgK47VvtPzK3wzzGVR7FFyTKpw=;
 b=MmFDaJsfGg11AkQMe7nFOt75fiTj+ZGsq1mfKDfnfO2IozfVK+I/Lm7gV4iMv5fQzNXs6xixUw19ZxkJIERUzXHnheRoxo/UJOvmJRDbnF/fbRL5lvvaL3ort2vInzQkk05A+anvIvHkeMBx+Zz7olWMk7I9bbo+KFThfXaA05I=
Received: from BL1PR13CA0290.namprd13.prod.outlook.com (2603:10b6:208:2bc::25)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 10:15:14 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::ac) by BL1PR13CA0290.outlook.office365.com
 (2603:10b6:208:2bc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.16 via Frontend
 Transport; Fri, 13 Oct 2023 10:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 10:15:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 05:15:13 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 05:15:05 -0500
From:   Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] Add ZynqMP efuse access support
Date:   Fri, 13 Oct 2023 15:44:45 +0530
Message-ID: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 0050dcd7-7aa7-4a5e-07f7-08dbcbd54ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tX+VNDAwbUWJiN5Oiz/kDS8KV0KEPSyVN7mfyX9I6RIGsbYR3KJqJs7khI15vUKwWPqgr/bTHm/6QbuR2JzVH4MAPPRLZ/jncYzOLAar/y2+29rGZb/Pq+mQQUi6MEtaaPHsblzW9/3xANsg9ERz7xeLuF7vgW3gjdjoL2rMTKkEcrvxV+VnxvV+Hp/kUM7kTIWPaM0fw8EOvtYeeNFeSXOmt8td4mDgk68b01h1GcCxUJ/fwPYeIYBxG7qoMs+9HtYS9taMG2SdHhGn2GwcHCcq6O58jWI6cw/HU2QVBYyPpEt1+iqaEBtpeviNCmXjYkwUUoNE5wnWWNjd89afp/l8oJQ8doVzSXOHrIZhTHsr7KdyvglQWVipeeFmfViqgp7HEKtAm6oiJliNRUPfCzyoVjpiMnbCaD+5aWej00CqkhlGBeLS+n8UxJ2dJN3X39hQVY54KxIogd/8ULvh1WJ1w0g7NFZeqq4jXypcD/Kc/wyZd0V7IBUbM5cVYL+S+Sg8Z6WQUaa4/i5MiVH6X0725exl80wRabtDXB6ouJnqk5NeqAC/ucWqK6CT3uioLWNJElnDEBvWBAf4i5ilfnyOVLyw9i3KtPCvp+7dPonjnGTq2uWpnMlUSNsZCd9KzoMC/UtI7BP8GvG3E3sCKEJzAhSenQsJU4Tn0FVSYFLIR27gF57k/NnpKmsOQ7WVuoX9TfX8xcrPM6MlffdVCKejdRXvB4PBr262o0lqUoueNMObnSvJWxX3OtRpLa5KZ0l/t0uvTKhm+HwGvtGmNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(82310400011)(1800799009)(451199024)(186009)(36840700001)(40470700004)(46966006)(83380400001)(426003)(26005)(336012)(40480700001)(8676002)(316002)(356005)(70206006)(82740400003)(2906002)(70586007)(40460700003)(1076003)(5660300002)(103116003)(110136005)(8936002)(2616005)(81166007)(41300700001)(4326008)(36860700001)(36756003)(478600001)(86362001)(47076005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 10:15:14.5578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0050dcd7-7aa7-4a5e-07f7-08dbcbd54ac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add following support
 - ZynqMP efuse firmware API for efuse access
 - Convert txt to yaml file
 - Add nodes for ZynqMP efuses in yaml file
 - Add device tree(DT) nodes for nvmem access
 - Update driver to provide support to
    read/write ZynqMP efuse memory

Praveen Teja Kundanala (5):
  firmware: xilinx: Add ZynqMP efuse access API
  dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml
  dt-bindings: nvmem: Add nodes for ZynqMP efuses
  arm64: zynqmp: Add ZynqnMP nvmem nodes
  nvmem: zynqmp_nvmem: Add support to access efuse

 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      |  46 ---
 .../bindings/nvmem/xlnx,zynqmp-nvmem.yaml     | 270 ++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  55 ++++
 drivers/firmware/xilinx/zynqmp.c              |  25 ++
 drivers/nvmem/zynqmp_nvmem.c                  | 216 ++++++++++++--
 include/linux/firmware/xlnx-zynqmp.h          |   8 +
 6 files changed, 543 insertions(+), 77 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml

-- 
2.36.1

