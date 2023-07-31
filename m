Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481AC769251
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGaJvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjGaJvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:51:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA810D;
        Mon, 31 Jul 2023 02:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYJmq2ORVLrIbJ4JEFdgVwbSqTmjUygblfBMQC9NFlT1pp7B8JGyyWSalWSbttAPGKZGAiKxI/NAr/EwIq8Fxbcjp3hA3pPf9Hmn6jUfhY0cUxkIcHbZhZBL0eGvgA9SCvUT/4lvagc0vHUSPM1xqcwA7fx3YouU7z95HaFA7ggC+ea3l2DRpU2f6oXmwJ+4hkxybZ8EOISvJAIKLbqy/cAKFJ6WjY7zVknBfQRY+wn3r6Mth969G4dxItBQHao8P4ZMWGf0+V4d48vyqiDP/7GLxcADc8K/ShM8e4T6H8Zif8VbB847iFYNkz5FvJxfB9jBBn55ZUEh8rcqpHIa4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ike59PuTkkPz0thAr6u49OH90yIlaioDS28OPuEx37A=;
 b=bGPX6l3wkchwoCaAty/H9dBEXTXzC75VMNsgoae0udg0e5MRbplxShCw38x12H5cSvGnH0akXj6ziVNAzux7XRA5GRGwPCUzx4R9XLAKYOGt6jRILveShT1SgcfWaUDaVaVZW80JVwJccU7e5NZ197RqF0zlwIUiC+ztL6dpxhvt+3n3/Z7O/2LG3IfEOG2Q8/ZnPdKxf5sMrOR0WugIzEpqRx61CaLITzWUDR8vMHsaGYawOEQIXxLQh+8/nhxb5Opyh64ypFQHZWO1tn5lhP6Jd9ztb5mIvhw5yXPAlvY8x5aCn4BXW8elH55vTx8GiJ1GloeLrekyIdpP3Olgjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ike59PuTkkPz0thAr6u49OH90yIlaioDS28OPuEx37A=;
 b=uITGHKmtWs5QQ3JGFPrGnb18KeFStqGEOtW+hcSJ5smwX6kUo0p5G26DyAKpmnsZcANDRtWHldSzN/pu0fPLGEDbvKgkrU2E1idesA2CPxG2awtGeayIKkDWKsGI8uDO1xsd+EEln2vGBZax71hBqnZtfDQAhVP/Z5wb1Xjkcjs=
Received: from MW4PR03CA0203.namprd03.prod.outlook.com (2603:10b6:303:b8::28)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 09:50:33 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::1a) by MW4PR03CA0203.outlook.office365.com
 (2603:10b6:303:b8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43 via Frontend
 Transport; Mon, 31 Jul 2023 09:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.0 via Frontend Transport; Mon, 31 Jul 2023 09:50:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 04:50:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 02:50:31 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 31 Jul 2023 04:50:27 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Marek Vasut <marex@denx.de>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <saikrishna12468@gmail.com>,
        <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH v3 0/4] pinctrl: pinctrl-zynqmp: Add tri-state configuration support
Date:   Mon, 31 Jul 2023 15:20:22 +0530
Message-ID: <20230731095026.3766675-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f519d8a-1116-42bd-221b-08db91ab9522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQQywT+fJL8TkX0AcYjZpe43J19G42YWko9ZFPgAvlMoxRMRlv7Ixui48ooINq86eOcJt5VPoxzPIbVO4eJeWs11+vyQdE8ppuYbQLTNcjBJAnVz40bcLJfWX54+RIIrEddXvWTvvcc1l2KSb249MEPk5Na1dpN9p1DbWFHHt0V0yi6eXgG//tMUP1AjenxgVPXsURx18ErhGvHruq3S5VlXQLYfmWoO671XwDNuZo5NJ3zw778CwVmfHPM+Y3OSOqtCFLVARaUEG9Wyjzvl+2hHjBQKIYSZKPs6kM+LwyV2ZCzreamwfOnj1anuKRZCM/7UeigwFiwqFlzhDwFT25KSMNSkqkDx6cscdvBfyVRZiqaz+jZZyBo8Pi6P/sCRmq491Lyob6qJx7yQTM3UuOrWWQ+07PTSV/qdhY+csAqK+HvbsMXGFRzCxXt6/V0nIRerPO4ixFXZCXEnvFf0WZvDeDW51JA3UOXC6HsE91D5h0dxHkAwF6/1+sPVNKUjS1Xr9ajAknJbNTNE+uFVtz8hHzLSPSBuh9oT77EMmglmCZqg/LlqKLFW6nIhhI0Ho9tu2lUqCJE5Nk7zBxMaJAIk131k/d2Q82MTIHritM31qdFuTf7X/sjIss7JqMRvJuqqGWlN0LjrvGgWuE1CkjBf0zmpAovD+ZyS62+mfB+qI6F+8QWgMGnfkdLfu2u/7G3YhZ2Mn5TE2noh4EgOe8hrVEGeYQ4uY82btYqx2PPRPk98YUHRWS30p4Kj92HgJlzMotJ5oAUk5nZLTuTnCEn/dyNDD2s1q0ftD4eUYzY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(2616005)(1076003)(26005)(426003)(186003)(41300700001)(47076005)(70206006)(36860700001)(336012)(4326008)(70586007)(83380400001)(8936002)(7416002)(5660300002)(8676002)(316002)(6666004)(478600001)(110136005)(54906003)(2906002)(40480700001)(82740400003)(81166007)(921005)(356005)(36756003)(86362001)(103116003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:50:32.8815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f519d8a-1116-42bd-221b-08db91ab9522
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694
X-Spam-Status: No, score=3.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl driver support to handle 'output-enable' and
'bias-high-impedance' configurations with proper Configuration Set version
check. This will ensure system not to crash even if older Xilinx ZynqMP
Platform Management Firmware is used.
Initial Commit details:
Commit 133ad0d9af99bdca9070 ("dt-bindings: pinctrl-zynqmp: Add
output-enable configuration").
Commit ad2bea79ef0144043721 ("pinctrl: pinctrl-zynqmp: Add support
for output-enable and bias-high-impedance").

With the above patches, using these pinctrl properties in the device-tree
cause system hang issues with older Xilinx ZynqMP Platform Management
Firmware, hence reverted the patches.
Reverted Commit details:
Commit ff8356060e3a5e126abb ("Revert "dt-bindings: pinctrl-zynqmp: Add
output-enable configuration"").
Commit 9989bc33c4894e075167 ("Revert "pinctrl: pinctrl-zynqmp: Add support
for output-enable and bias-high-impedance"").
With the latest firmware and driver changes, driver will ask firmware if
that feature is supported or not by checking the version. This way it
works with all Xilinx firmwares.

changes in v3:
- Used GENMASK for Family and SubFamily macros instead of individual LSB
and MSB macros as suggested by Michal Simek.

changes in v2:
- Updated commit description in 3/4 patch as suggested by Conor Dooley.

Dhaval Shah (1):
  firmware: xilinx: Add support to get platform information

Sai Krishna Potthuri (3):
  firmware: xilinx: Add version check for TRISTATE configuration
  dt-bindings: pinctrl-zynqmp: Add output-enable configuration
  pinctrl: pinctrl-zynqmp: Add support for output-enable and bias-high
    impedance

 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml |  4 ++
 drivers/firmware/xilinx/zynqmp.c              | 49 +++++++++++++++++++
 drivers/pinctrl/pinctrl-zynqmp.c              |  9 ++++
 include/linux/firmware/xlnx-zynqmp.h          | 13 +++++
 4 files changed, 75 insertions(+)

-- 
2.25.1

