Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E648B7B2C96
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjI2Gt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjI2GtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:49:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63B51A5;
        Thu, 28 Sep 2023 23:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPyyLl60OQYytysSFMIRnDcduVjygZn7ExLBE015e2ajZvJ5Tx+6aAnDUufICiF1+TIZCmwHuk+fz99IFM4c0BPh8RkbmeKo4w1okxEshvnwvCB76paX3qDmXl7N7JqRuriOPOfw9QtwK5tW+62BPvFg2YakAtyj/KyU0sW2LcOWB+Sy/RNCHRc4D9NF6FJwPFPmu9ta4JJIxFJ7h5gZdMwAAn4/cqe6zZNq5JuO2IgDMcyfVNlyPNnhRs3b2SAZqUv0ajqHk64XB7f6sAPXaJfY05FTj3OrVbIDStC1FLTh6W+VkmR8QFxJhIRJKkFZiw1/D0zk7DF7EbMVNqygMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMC0rhvn9eui6qw7dlYdSXsNb5PHD/SCtgQUwxah8YM=;
 b=OXYWURnuUwuaNXXeolRdQx/7unBQkrJ0Jp/XPH1jUbQbR9hj0p6OA+xVA5vzwBvXx/26fEPJFYCMYazjmZEtEUVB2qX/m7C416TKTXGp3sS9cwy28ycw7fjfSJIPgGcZXNKHkRJrycBXWso+E4JJ7yJ0yYLQxXjmBkwGkHLXg4rp6mMxaOlyADCknGCDcRhKXbf3LLIB3biykaJ3ZvxDyeIijJmm/l9LqccuInPWdk63DRr8gzutt2JI+1ThM+14aqcml8JXYJnBIZArnD/8tumCWwbiXenjZvmAhfXeLt4UDC+FeymclTKW1xzEJ5MAaLl9XNXZpkcWdtrmlp4waQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMC0rhvn9eui6qw7dlYdSXsNb5PHD/SCtgQUwxah8YM=;
 b=yq2g4ghtRUspN+RRE5p5fgn740hfvGQ/oFull6zMmVEqRF4mx8uMG+e6aC3Lr7tgMw7Ct07/UJhrxs1Kny4+E+uN1o4U8GJS4xSns5IKEp8TnCDUtekLoTJvEpHhK/IfrofQrCz4dlDhM3PYQdzPOD2yB68LXj9JbADckdC+ZjE=
Received: from DM6PR02CA0082.namprd02.prod.outlook.com (2603:10b6:5:1f4::23)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.35; Fri, 29 Sep 2023 06:49:18 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::22) by DM6PR02CA0082.outlook.office365.com
 (2603:10b6:5:1f4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Fri, 29 Sep 2023 06:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 06:49:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 01:49:17 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 01:49:14 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <peter.chen@kernel.org>,
        <linus.walleij@linaro.org>, <paul@crapouillou.net>, <arnd@arndb.de>
CC:     <piyush.mehta@amd.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>
Subject: [RFC PATCH 0/3] usb: phy: Add platform driver support for ULPI phys
Date:   Fri, 29 Sep 2023 12:18:49 +0530
Message-ID: <20230929064852.16642-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d2fc6f-4eb8-4311-5e98-08dbc0b83410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iD8MnXFXsaemyiZVV1YDvSC9CTjgmXIzGUcU7Oa0NSVOjYAyF/ZbwU5KNCGdr/h5PoEwAILSJ8nTyxchcoYq96q4mgmliNMA+GiuQlNh+ZxZIZuwpjozkEcxrHbC2f5cWeoRtEbL1qw/s5TX1JQdnPMwriLymG4njk6EY8OPaEESlUEJ6Zz66IkbL19XjAtEnl2Ka5lV6Ud112RS6oDKki+PERARHHZQEjSzZTUkPv2F9+QPS5Fbzd1q2bSDu4a/uMN3aYvsdyNFeMKPvchpiqONKMv3KfEnvA2zcH7hCtza7ikqT2a9OpJShedimbolcpnOVdwt0k1Z00Gn7g73Rm7HxxXi6QN6U42QqaxZmXJCHa8oE2yeH7Gdr9QZ+11ZzPKVbLpt42H7i2z40b93ohRYk3jfRm1MjjCjx7FE1rMezK3UavBF0+kHLJt+NUKjX3Ie+O/8kj9k2FSXLt+KVoBShoQ93vb0D1urpHNvdGQuAasHV2FaY6haIClftyOEeKUk6APLeJ4WGZixdGoFwuwkedVYQRmGcPo3RGJyNMgOm22Q3TjV8GOlCFPOihuGGMZmsGh/cosVnsTEhWUeCnKLJz+RD9c21w/zDHj8Yg3D49heXRJQhT0vStX0gYW458SVsuX1ugoRSOZCquEO4zmcE4yG+bzB8S8mK6A2zJW1GECd1Gu5GnwQOqyzgtkXFF2LM2y5f1PH6nyJ12cLzBvYSa7mGd34duEon0/nfE5dnz1n98bjgAjgBTggPn3Ti/k23fckAWVUp6Z30YenUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(82310400011)(64100799003)(1800799009)(451199024)(186009)(46966006)(40470700004)(36840700001)(54906003)(41300700001)(316002)(8676002)(70586007)(70206006)(4326008)(8936002)(5660300002)(44832011)(83380400001)(6666004)(478600001)(26005)(1076003)(2616005)(7416002)(336012)(47076005)(426003)(110136005)(36860700001)(82740400003)(81166007)(356005)(86362001)(36756003)(40460700003)(2906002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 06:49:18.2280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d2fc6f-4eb8-4311-5e98-08dbc0b83410
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added USB2 phy for Zynq platform and converted ULPI framework to platform
driver to drive CPEN to enable external 5 volt supply when Zynq USB is in
host mode.

---
On zynq platform chipidea USB controller is capable of fulfilling a wide
range of applications for USB 2.0 implementations as a host, a device, or
On-the-Go. The USB controllers are integrated into the PS IOP to bridge
between the PS interconnect and an external ULPI PHY. The register provides
indirect access to the ULPI PHY register set. The ULPI PHY register I/O
interface uses Viewport to access PHY registers.

In current approach we have extended generic ulpi phy driver and made it a
platform driver. This solves the problem, but would like to know if it is
the right approach?

The another approach would be to have access to the ULPI register via
viewport flow by creating a new platform driver at path "driver/usb/phy"
using "phy-ulpi-zynq-usb.c" source file, where the source driver would be
particular to the Xilinx/AMD zynq platform. And binding patch [1/3] would
be specific to Xilinx/AMD-specific.

We need your inputs in order to have access to the ULPI register via
viewport flow.
---
 drivers/usb/phy/Kconfig    |  2 +-

Piyush Mehta (3):
  dt-binding: usb: ulpi-phy: add ulpi-phy binding
  usb: chipidea: add usb2 phy interface for Zynq platform
  usb: phy: Add platform driver support for ULPI phys

 .../devicetree/bindings/usb/ulpi-phy.yaml     | 48 ++++++++++
 drivers/usb/chipidea/ci_hdrc_usb2.c           |  8 ++
 drivers/usb/phy/Kconfig                       |  2 +-
 drivers/usb/phy/phy-ulpi.c                    | 90 +++++++++++++++++++
 4 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ulpi-phy.yaml

-- 
2.17.1

