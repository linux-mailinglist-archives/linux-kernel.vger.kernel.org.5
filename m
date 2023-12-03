Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3784980208F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 04:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjLCDZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 22:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCDY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 22:24:58 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2C5125;
        Sat,  2 Dec 2023 19:25:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHbaRV9J0wV3Z90DXa2Whr7Si00sBNpUqU+Ubk995Wnk1MhDVyTSf30Lf1bwTlMDVeIvXkFM65GL/tBB2TusxXpdM/EtUCl8c/lReFv28BnlpiGbZwFY/+NM/+dQI/aJ8/xdOPyuPLTB/0NOwlEkMaMfiJIb2pqFVVOI/AarpoqOTf4Xmwj+XRj/en3rjhnET3C5g6Jp6yKGq+PMXgsmILDNWElzEEbUYssCOhIDtbp3h4W/1Oa0J+ClN5+L9k5S/BGGwxNet+h0qgUWLTOpiAO/npNIkMipMbJjP227p+N6pk27aIe74qqshl3OKa/CGm4NQMHEwyofjFOsTHF/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XmUoPsG8niYFGZjKrINLXOukbBatwwVbBIm2AsGTm8=;
 b=dAfOWf5jG8PPpuryiMdJn2c/VUIRLovtdRl/MPHeAw6ezPnp+52jZfBfZgpaBDhWrcOTOFb26HDCJ6RDqCuuuSZsR7JM/EiBlt8IY7fx9+w+G5X1h05U5Ci9f75NJOR+6PQxnq/9bLUPlOea2I3L9XqajDJkKBh33TB2oGYbKUYR11qJ4rjsfzyNb4dTfE9yGshh0vFPJAacLLhOfKEU+nFyRNXpOzgQ0bY1u1Uzy3BoECb2h4IVMrDbmJkYAnlvrlPVJEM8dHKeRcNj2lBV45p8tYJ3FtOoxe/L8aS8bEiPVIJ6dekKM0vO6VT8ScjAIGlUQNFsb1ntn8UiUdFHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XmUoPsG8niYFGZjKrINLXOukbBatwwVbBIm2AsGTm8=;
 b=M11J0p3mOiTeLWTlUb8loKBXfOJGxsgOBSADvAyZy8yF4eo/dBqgVK11hJqXyqWXbsEiZmvDpVlIMuSfNxZrXaI1QkVXZJ1FdatiXhRf/liavad74u8LnJYCryMVBPmQ94dlUIf5fbMs2XGUGmH3PCFpJw/jy2hnJaRE+pcd3yI=
Received: from MN2PR11CA0024.namprd11.prod.outlook.com (2603:10b6:208:23b::29)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 03:24:59 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::1d) by MN2PR11CA0024.outlook.office365.com
 (2603:10b6:208:23b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.30 via Frontend
 Transport; Sun, 3 Dec 2023 03:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Sun, 3 Dec 2023 03:24:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 2 Dec
 2023 21:24:58 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/2] Fixes for spurious wakeups on some Lenovo laptops
Date:   Sat, 2 Dec 2023 21:24:29 -0600
Message-ID: <20231203032431.30277-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 846072bf-b488-49f7-06b2-08dbf3af6df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSIStPZjfPQvLeeolZSzRHPs2orW8ArOKN5Jyi6WX+mnfjA6YnwbmFCshJE5ynUGZY9SuOPXZZzSXGPZflyoKo04IuN/bCZ9MYUDKvV7qGZBD2StW/YYQt4NMrQR6LQkkHA1gvaQ/7xSUJqk/m80uqqNEcWef4EGvYheRqPn4jrD622bA5kh+ZdnlkzBO87PSHrkxxjTSXz3toTrHZZPdGXMAunFOaj/eSuV3iwpGF29ymnJRXUwLpeIBMN6ado43W5Ks6M34dvpa9mTvNLJcogo2j5/zOlkex/VCwadvoiONpTR69oTgMHhndwfCL9vbaBShls4X9ZC06MJLDBPTr/7LoykOkq3Bl4Xea78g27s/A0zAIFo2N4Gu/hlRsKj6mjyGK8QNhaH3YCgGlYMA5Md5SwW7096rTV021l/vPGEPtQEB45OoPCLIzUDHeNbi20fRf3fbz3Vw9nkPUFoA/OLgL23F8Kd4cOcyqt1/IOAwxTjIU8KzHb1mm2Kdr5rLxAdN1hHfBBsbEGT35a8qFom0IpNlVdSxVMfhfjKQI2srNxknm0vEkmWw77jb4/sBQS9aNlD1XT9v4U0z7zRqh6DbWNZGIXdpWCapqJIoxhuuzGsZPSJBll/Hm7r3J4xyNoP4648XRBYHmPYTdfd2I4YELkg99GTbViYAy5W4AFRS3vMDwhug3TR9KAL3tz9Yg+bhDXSeG7sFVTy9wPeB/1MwMU4/nWa0POQ4JGwz8OJ54kD9VXcvHdUPOBTNez3NhzPYJYr/HjWbLNuVm0fyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(5660300002)(40460700003)(44832011)(4744005)(86362001)(4326008)(8676002)(8936002)(2906002)(41300700001)(36756003)(2616005)(40480700001)(1076003)(356005)(81166007)(82740400003)(426003)(83380400001)(16526019)(336012)(478600001)(26005)(7696005)(6666004)(47076005)(36860700001)(110136005)(316002)(54906003)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 03:24:59.2320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 846072bf-b488-49f7-06b2-08dbf3af6df7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users have reported the inability to properly suspend on
Lenovo Yoga Slim 7 Gen 8 14APU8 and Lenovo YogaAir 14s APU8

Analyzing the problem there are two issues where HID devices connected
over I2C cause spurious wakeup events or high power consumption.

One of the HID devices isn't configured as a wakeup source so the APU
if the interrupt fires over suspend it will wake the APU from a hardware
sleep state but will not return control to the OS.

The second HID device is configured as a wakeup source and continually
fires both at runtime and suspend.

This series mitigates the impact from both of these devices.

Mario Limonciello (2):
  HID: i2c-hid: Add IDEA5002 to i2c_hid_acpi_blacklist[]
  pinctrl: amd: Mask non-wake source pins with interrupt enabled at
    suspend

 drivers/hid/i2c-hid/i2c-hid-acpi.c | 5 +++++
 drivers/pinctrl/pinctrl-amd.c      | 9 +++++++++
 drivers/pinctrl/pinctrl-amd.h      | 5 +++++
 3 files changed, 19 insertions(+)

-- 
2.34.1

