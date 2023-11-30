Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7AF7FEB1B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344929AbjK3Iq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3Iq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:46:58 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934F9A2;
        Thu, 30 Nov 2023 00:47:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv/mc6BLtJd4Wt1MhYCFeszoFKwlHOxNUDreAU1vBzZEPhNH15AoQ+1rvAJlOPZ8EjksracRRebH0T9KRAzwzxilRPK8oDxcEsiiKny7U1acVPE5QIfV60Ch8UtvfWsKYGSYkbG2tmeh5GZVUNXJf80vAET7OKUPTUEHmWZJ5LJZ8ly2XyZXT855Ydo0Yya/GGnITOQSlUXX7aOMpIK9IKwtln/bJIAEv1nJRC9JYkghZc4a766ZhkafbRkfey7qpEQA9lFtJu1zGOq8fxgh/lB+ysUEf+H3TsUqXg2R0Bq2pnwh2Oj3mwOXjheLOuI7RxxZnWEYT4bBeQnAE5+rog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPFZx6Yg7tKg0fdBcKXYmEcQWRs4QQjiZcK6/4mnxag=;
 b=WOoFSC4saLjwg3LDtsap/fZZNa2oAP75ph9AG4yCgojJ9pRu+qG0MjQMuwmHpaXrJQSanl2gT1dmJUwzUVI1llAZiuqqiG8+rIlwErxSUdtgG2FotBVKLCX5xTauPC3qEbXhCKoJ5cS8cc99DFYrgS4Afbp4Tj+bMGkrXJ5n5Z4qUkGJEsN85BJngbtk8+tgBSG1NhRhcOvrFYlF/AnXkG8lE7yzj1zVv5cFGFXfHrDKtaWfZe/g7igj0OdB2I/5AfayUni7b5vewF3zlIUtq4hFzNQ9SWACrgsa3PHvuIaGLHeS/x1BGljob8Nw4qwR95zoLaMLWzvXS7j3NRZmIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPFZx6Yg7tKg0fdBcKXYmEcQWRs4QQjiZcK6/4mnxag=;
 b=FTInMXls1vd9DPijELpFZWLRPqdxbqdGcJNpdK2m3YW3e9rTWFBdBqrNaHr25Lqif2fqkl9hRSTS3R+wLU/HZwEPL1XJC2qi6VjPTUMXdHGcMv1q2v4s9D6Ygph0ccP0z2tcWTLxyYAeffEe7kFqzFEmUpnmTXTxd9Ss5xLRi90=
Received: from MN2PR18CA0006.namprd18.prod.outlook.com (2603:10b6:208:23c::11)
 by SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 08:46:59 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::ce) by MN2PR18CA0006.outlook.office365.com
 (2603:10b6:208:23c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 08:46:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 08:46:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 02:46:56 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
Subject: [PATCH] dt-bindings: hwmon: Increase max number of io-channels
Date:   Thu, 30 Nov 2023 09:46:54 +0100
Message-ID: <441d9babc7042892350a58ba4300df4761876ae3.1701334008.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=michal.simek@amd.com; h=from:subject:message-id; bh=max88p5KZ++t+kwX6Rah3pgbr7Yq+Wrjb4/Q4PJ25Xo=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQM7x/Tww9bxbT2trpPcHi4IurL5Wg/BxHzCquAPqPDP 1jlN/zpiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABOZs5VhQX9//qT/Kl+nX/sb sH/7TVlVx1KhqQzzVD594pRS3veqzeZdfK2x2sUP6esFAQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SA0PR12MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4ae3c2-f6bd-45b5-52aa-08dbf180ea61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AtQiTLF0fvAoMZGLYX8yuDcstOs5bGbvtNA6rzo74NGmnZd1StbDW75k7k6Aa+3RhEM1+JiW4ulXZ3mxiWF9ClHTnuZ0uoSqHgoKA/3iHoQvjPNlknjq1PW8SfJmjPgrQ7BHbcxDwCSGWkmHzMnkfkFvOwRp9G+56AXzqy1jIDqNtPs6pKbiR+tJU2xWrad2tnShLI2fDvSwjOLR0B7I0/OQiFxP3TYZgSeC9Q0CS38sVZi2ZCBl4pSwlnZaO23U0Xac1bw1sZyqRURFV1A7uCTBRyUOcDHp/bWirzJJUHGxZxr6u7XUW8VukHAbKhyYx6zPVcWYYahHqwiNQRp5OJBth4moDZbeGXlp6+nT8qOwf5l+rN2eloyZDm+p5bYcJNUne2GmbPMZtYiaAvAaWXFgXijdWTzvxELyFRkzPCEztxpA8k6/3jNr2UAzweyuvZOedqjb4P5sd8L359CXBUwzsq1/5sNOLq6EC1PXUj//prIrv7sekju+4tC4Ih7fbkoZ+Xz6ArqqVP/CPVEyrFV1RVxwYv0NMfzBO0chgJcXVdZVfQE6xLusAktFtTOqHkDqYEBBKTLfSK6qQE0EVuJlZ5ueYklH5NBQmN9lBc/YPc8wu90Dr8oRJTmjaQQPeNlE130G3n+Ocf04YYu49DjacSRII92/u2xz0itIGSJx+TPG62j+VQMDkeVRRQUg5wtnP4hgADDzXyPdFFg4fv1AKRk3i0FDLcHFNz52LW5AzC0HJNOiCHxA9n0ofedvjHISwioyBOVDmpvN3PpVhGgs4Se0V3yZFuv+er9B7DX+BahtnqEeWnE6XQKB4XUT7vdVqCiMPA+d2ACUoImZvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(54906003)(316002)(70206006)(8936002)(8676002)(4326008)(70586007)(478600001)(110136005)(44832011)(36756003)(7416002)(86362001)(5660300002)(4744005)(2906002)(41300700001)(36860700001)(356005)(81166007)(47076005)(2616005)(16526019)(26005)(83380400001)(82740400003)(426003)(336012)(40480700001)(202311291699003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 08:46:59.3099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4ae3c2-f6bd-45b5-52aa-08dbf180ea61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4527
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts is defining 30 channels
that's why increase it.
But AMS binding defines 51 channels
Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
that's why increase number to 51.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
index e5b24782f448..be5c7d4579bb 100644
--- a/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
+++ b/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
@@ -19,7 +19,7 @@ properties:
 
   io-channels:
     minItems: 1
-    maxItems: 8 # Should be enough
+    maxItems: 51 # Should be enough
     description: >
       List of phandles to ADC channels to read the monitoring values
 
-- 
2.36.1

