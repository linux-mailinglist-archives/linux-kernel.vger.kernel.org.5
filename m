Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EADE7EB037
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjKNMt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjKNMtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:49:19 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEBF1A7;
        Tue, 14 Nov 2023 04:49:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwpwaT8s6iKScHChRQV903JQ6/GsHfEq7gccAD2KgSIwOA8o/v09ENEUDa1AgDtm1ucIw1H5FMITSKem1v/WaQgcsEXg5jpybG/vNYw00SeTWOV7brjs0cMPcvAc0uPcErjTDGXeo2bDpnVU/uMwOJJ8yflSRkNZoq3LneI01hMSqPsBDEKFnhyenEMH0SQwgOG9POLtM/MSFaGyw0z/2HeTIoy+NpL8TQ0kEAm51yp7IOKzkER8AABamRrAHpTyOgCy1r3lo8xvFbvVG2o8HjB7abEloVqwg35FdHdY1Gfwlpcpiqg86XgWz2AcWfrgjzM36c+AwFv7Ff9gj5pRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQpXlyDONzimOsaHr6N0meVwJEruFBCSVGiH0P1lF/Y=;
 b=iyreijANeNJ+q+bHefy5sAyZMrIPZMjFO8Kyz4XuAHKyTl5ChWtf8RnLczpZFCfAo1gC7XTwic6nreadbg6KkcbQmfGFu3jVaK5u9eTPEwZ3UZgik188v/in6valOodkac/i140TcsyNsrY+ov/uEMCFe+pbWrUyeuh14mediyDGB5X3P6fus6cA4Z1QD7C6/90W0QvbAwkZNe8ADAeqtEjHtVEJmyh8AUzc5IawIqya2im4Vzl5a/gJBCF3OTmcO0zhz8YzKR3Ofwr6wfvz2CcRNSg+mRB5Fd0ejr/PzAr8raYKQTtaA76cL1b7Mis3W2d2JBI3zRu2uTac2LiOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQpXlyDONzimOsaHr6N0meVwJEruFBCSVGiH0P1lF/Y=;
 b=ymOScf6kcNYQe+6euvlIVEBqRo8a4vg/qf+6NDBdgkVdmUg7QGdIrtJnVeagoWOCGRZM5uNYUc0W7tI8O2g6+WSsrLPuI9VBQuXEEUP7k/c5J5uH/pq6Z9DP7GM5ctfNHVJEXxdVzk58p83+o3LYqHhDV65399G3kDMID1gMfVM=
Received: from MN2PR12CA0020.namprd12.prod.outlook.com (2603:10b6:208:a8::33)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 12:49:10 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:a8:cafe::26) by MN2PR12CA0020.outlook.office365.com
 (2603:10b6:208:a8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Tue, 14 Nov 2023 12:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.14 via Frontend Transport; Tue, 14 Nov 2023 12:48:43 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 06:48:38 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 04:48:37 -0800
Received: from xhdmubinusm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 14 Nov 2023 06:48:34 -0600
From:   Mubin Sayyed <mubin.sayyed@amd.com>
To:     <krzysztof.kozlowski+dt@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>, <michal.simek@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <git@amd.com>, <mubin10@gmail.com>,
        Mubin Sayyed <mubin.sayyed@amd.com>
Subject: [LINUX PATCH v2 2/3] dt-bindings: timer: Add bindings for TTC PWM
Date:   Tue, 14 Nov 2023 18:17:47 +0530
Message-ID: <20231114124748.581850-3-mubin.sayyed@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114124748.581850-1-mubin.sayyed@amd.com>
References: <20231114124748.581850-1-mubin.sayyed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b602e4-0dd0-4e20-c528-08dbe51018c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHMgSg2FmBbWoeBxmOOi4hfe2SACmbD0xZKBb3q1sods81yv33T873ADOEG0jDe2hWh6uaBiOgP+I0mENzOKTLhaIzrbnOgyUd7RZDo6M7UeD0dbimGunIq2KJjGSHfrowSXO591nm/tPkUV6ZPQf9TWiAnnfUsz8WGcsf3vLB7ZdEfY4C45q0cP9TAbgxWpoBkz7qi/C5nTZl5F5ggDGD5C3ejY4HyOveBCSw94UuGAOYaRsZAK6qrucSTcEIgluRSM1/9Qs1OFkLbpP4eF276t1plEw5DpCQm4Ars8p7Fi1CIFxpb+ACGV6qC7UGDBRXRXYOE2isVNknPIZ+xquF7bahvvNqXqFTuZb12ul7rfqpOcXfrsESoeIeBIbpa1YliEE8qo/Z8iXfgFiQQ/eWdIOUnADJHAyZRoLG08Am+sNK9Ofsa3BiupIZJAiqEE8d/Sp6WdumHiYXXvNu6jHTIEsSZ1viJe++sTl1v23RMYr6T59LE++tZGDrpbwjLwmjnwhAzSmpUP8mq3+qsKOFxsNQgQ+Pm2h5xmsV10lk9CHvMj3z8JKCDoGmNCtmHPO2hVlbEASakVuNEqYMIZiknulcgfO36byqGj4Y8eJssoyoOC5Fw58K5BB3X0FOWdvdDqRQhw/S3c324m+ayxCjZTwVJu6u3SotE9yInr9UKFEjdHlzaUDZCQrjkQMYjNo4i0qw3iayqn3bRK8E3ezU2id02LF2eg0Sv9LZYrTtAQLo3mPKCm2aSFVhvSx0jt7AdNCFghtUzYaVtsltF8iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(70586007)(70206006)(110136005)(6636002)(316002)(54906003)(81166007)(82740400003)(356005)(36756003)(86362001)(83380400001)(336012)(426003)(26005)(6666004)(2616005)(36860700001)(478600001)(2906002)(5660300002)(47076005)(44832011)(41300700001)(4326008)(8676002)(7416002)(1076003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:48:43.9345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b602e4-0dd0-4e20-c528-08dbe51018c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence TTC can act as PWM device, it is supported through
separate PWM framework based driver. Decision to configure
specific TTC device as PWM or clocksource/clockevent would
be done based on presence of "#pwm-cells" property.

Also, interrupt property is not required for TTC PWM driver.
Update bindings to support TTC PWM configuration.

Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
---
Changes for v2:
  Update subject
  Modify #pwm-cells to constant 3
  Update example to use generic name
---
 .../devicetree/bindings/timer/cdns,ttc.yaml   | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
index dbba780c9b02..da342464d32e 100644
--- a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
+++ b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
@@ -32,12 +32,23 @@ properties:
     description: |
       Bit width of the timer, necessary if not 16.
 
+  "#pwm-cells":
+    const: 3
+
 required:
   - compatible
   - reg
-  - interrupts
   - clocks
 
+allOf:
+  - if:
+      not:
+        required:
+          - "#pwm-cells"
+    then:
+      required:
+        - interrupts
+
 additionalProperties: false
 
 examples:
@@ -50,3 +61,12 @@ examples:
         clocks = <&cpu_clk 3>;
         timer-width = <32>;
     };
+
+  - |
+    pwm: pwm@f8002000 {
+        compatible = "cdns,ttc";
+        reg = <0xf8002000 0x1000>;
+        clocks = <&cpu_clk 3>;
+        timer-width = <32>;
+        #pwm-cells = <3>;
+    };
-- 
2.25.1

