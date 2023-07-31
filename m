Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6182C769257
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjGaJvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjGaJvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:51:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A5AE78;
        Mon, 31 Jul 2023 02:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gobcieiM1ikFi+5FZrlWTzc3fwEf56K4lxLtQJ4Kt+bjVOOPmxKBpBnzkKO7gi/dVkeKsqU2umlf0tEHeXnwW1ITJKA7WlMZSlvF3r2Iis6c+rjhecPQ8X2jrbDosfIaTYWMBUIN1fIN7l+DluzdB4LT0zRX4ULB6miVi1ymNqGCJxnB15PzuZazqnug++uQGSrEIxyKoT5TOBPrlvfFGGh1QQPmERLDE929rKYuVVVUPVCd++FcZ9qET22+xoZNDfxuhUV9+/AdKnWvndh8qGQqWjjSGdZD6BK/by7HA8vBhorEddQERLL+1pFNgJX4+8Lk/Cv1/ll2yVTeyV8LOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOUXFZ2fh6HfnylylmEOHS+AdxbgHvY4dnmAq80H97c=;
 b=nop5xx8Ju+aaxtQ1CdXEapk65aI+x3c+WCf0RgI03MJibHm47MG7/EFiRHSirCXYnKGSBqaq90ACZOEchO0Nx9ve5wzoCPGcZ1/D05T+yMKCg6H9aQh3sSmfg/kSrbtjgFblmmd1/O2uedcQQYXIAaehWcgRKA/yEVwE0+F3TjwN7o99TV8hiBuvM2im7nzttzMDjTCQmgUXel1QD21bgM+rYX4gA5N9XiQOGhb7K4WldrS9ylZT6mGjD5CJ52SORLS1pfMKmSgt+V9ymGknK186TZuvEvDuy4XOG+UE21gzeZuutrbiS81HdSkfocNeEAZO7kD/V0uumqkHzBblLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOUXFZ2fh6HfnylylmEOHS+AdxbgHvY4dnmAq80H97c=;
 b=1OoTEjO1YvPDFbrW66TQIqEFVjuNfPlaUqaTzoCXhHzOes52yqEZRHLX6FfmR+HpcqDBaGWSLlvLHE/3SeYJkKMNHPfa0V4q2k+6UQu2taJcpU9qHf+VnfP//jJIQdXNRcJcum2rXeVd3wEHzuG35LH62DEh5ZBvAvcRN/AaMT0=
Received: from MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 09:50:48 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::9d) by MW3PR06CA0030.outlook.office365.com
 (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42 via Frontend
 Transport; Mon, 31 Jul 2023 09:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.42 via Frontend Transport; Mon, 31 Jul 2023 09:50:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 04:50:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 04:50:46 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 31 Jul 2023 04:50:42 -0500
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
Subject: [PATCH v3 3/4] dt-bindings: pinctrl-zynqmp: Add output-enable configuration
Date:   Mon, 31 Jul 2023 15:20:25 +0530
Message-ID: <20230731095026.3766675-4-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731095026.3766675-1-sai.krishna.potthuri@amd.com>
References: <20230731095026.3766675-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eaccb49-806a-418b-a26b-08db91ab9e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RVEUhVYrsBu49phAegynB6xmyx5ZRRN/iLouA1H3WcGe25Pq/UzaJw7ffozlyYpePEtZR0EIfUtWD23OJVIawQY9Yy3NzzdpYhEHY38iNMAm1/qyuLHvzczZwuKfQesPUh0yGBrwEArQzXGVywLB+xIGs8SB8grLmWv0gpLvEHrhNOotrnblNrsuU4vl40T6VTWuZ1SrQd//J/deM2DlUoLQOIPASpwwMZs+4if02OAxzT4ioHJ0zRKQD1rVJM3K8LPXcGpXcUx7sjfcmY/AQSFt5PWccgdTM5u0mVVDvmqugsbyU8lhIlIke00HJKwbg63oXvxb4gqIQS5KXSdf644dPVvbIZBXs7gJxrxyzguCGiy+1Sq5Ymfw9FMHDNWZoLurabz0bignvN7bsw077Ya9u8nX8yn2dJrY7lWb8rhkOpnxFH5BD09XHpu46Xi2oy0k409AjCmzkESKEy84+4HK//MjAyLhEw1NVqWnSkjN/aRCjzcORKaAkNAWe23TKZXxEwjnD0ag8FrlTnFugpU0O0fuUpS3Zb5z7zcHphsDgmBUSH9PSGrv/FfQJdEzIPW5oHEzb0/jHB1UU4OvOlZRG9RB5BYlSUGXtrocKN5UdhbWaf0cdBZfVMpkSLd4e9loGQLgft75oW0Kux2qOgoctQlXa8sUaEeoSS8FZRobSRzPJ+SRvJ7SwYrSHJlC9CgWNeS7BQ+CkJKbiESh6gR0GRlc1osc23+oCAKM5SktSkji8ddT824GUEiZ7elIxbPCp3WMD2R0IGpcu50TvYh8pJlAjkilfJmRAT+dPo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(2906002)(41300700001)(316002)(86362001)(40460700003)(8936002)(8676002)(7416002)(103116003)(36756003)(40480700001)(5660300002)(336012)(356005)(921005)(81166007)(186003)(478600001)(2616005)(54906003)(110136005)(82740400003)(6666004)(1076003)(26005)(47076005)(36860700001)(70586007)(70206006)(4326008)(426003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:50:47.7943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaccb49-806a-418b-a26b-08db91ab9e05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'output-enable' configuration parameter to the properties list.

Using these pinctrl properties observed hang issues with older Xilinx
ZynqMP Platform Management Firmware, hence reverted the patch previously.
Commit ff8356060e3a5e126abb ("Revert "dt-bindings: pinctrl-zynqmp: Add
output-enable configuration"").

Support for configuring these properties added in Xilinx ZynqMP Platform
Management firmware(PMUFW) Configuration Set version 2.0. Linux firmware
driver checks if the configuration is supported by the PMUFW when it gets
request for TRISTATE configuration from pinctrl driver. If it supports,
then calls will be made otherwise it returns error.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
index 2722dc7bb03d..1e2b9b627b12 100644
--- a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
@@ -274,6 +274,10 @@ patternProperties:
           slew-rate:
             enum: [0, 1]
 
+          output-enable:
+            description:
+              This will internally disable the tri-state for MIO pins.
+
           drive-strength:
             description:
               Selects the drive strength for MIO pins, in mA.
-- 
2.25.1

