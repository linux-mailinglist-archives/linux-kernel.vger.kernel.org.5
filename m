Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21226785132
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjHWHND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjHWHNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:13:02 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2047.outbound.protection.outlook.com [40.107.117.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7027D1;
        Wed, 23 Aug 2023 00:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJWFm2vwxurz3bjf7ORp09Edh72HNvo/tMfPB56lvfDG0ul0AFDq3ca6TsK+5NR5kw5scPPfNb83h2EN5AMlsvd2tBqHdtYHUHh2jLb842s/n0pwbh7ntwT/6AUXAxt8ltQupDIzUgAuFkg+hg2iPJ5dlVHYInm66Yk1Gx4G8GnT7AsjJcUfAn+jrRZQn3ILN4zTPIyVVRwcEtbYj8Y0UbS7oZW4ceOsJmm21EqkAhEBoUqE5Nwf1ipLGjah4gCDt1EXdimjOnK/H5VS9S7Sgqf3xwIGq7eSgfRnIe0zO39qY8QVRQZFKdCk1VaJO+J8GQB1ZZVkITF3mKwApRZv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwDPLZtAyHatlg2hwtop+Faa8mph+phfV89NVDiFpBc=;
 b=X9cqxYTbBfYJr4ySUDGU+udFy5LCPWK2n6AemtRVEkDMuWH6hv38Za0bJI2tzwt4LIlCvLdfRrKvaQKvWC1nHVmr2QTbrngQshcmp4eXZz/5eJFPO/cx0cQoEP2jKPVayBHSNuVLld5xC092FQl/QMj3UEGwAzDK15cbU4yajSphOU6zai5bbEWfRSyq8nINn5HRHa/pxXKafnbLLPSgOCh5ZYP1NqFqy9FjCtCMy3JxIUYe/OF7knO4pYJSACp5XsUv/J1Y1QuOWrRmDy7+MbIp6WkIIi5AJpdBkcaf3QooHMCc+wDMwfdM6cHkgTWM+PSvQ4gvA64NE7V/GcX96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwDPLZtAyHatlg2hwtop+Faa8mph+phfV89NVDiFpBc=;
 b=bt3NPm3UFAMEepYs9lXzmhGRwsAzlCKhtzyEyLtzRNoB22VI9QXxYD8pouHt9JXal6KkjLv1AWEfXLZUgxYN6vh47yiGJ6AtOCxHDZcoVmKTWMfjAcADIflAZ/uk0eAM1EpFynfOvA7LBVAD61VLsgMDOr+yeGJepFGgXn8iniI=
Received: from PU1PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::32) by TYZPR03MB7395.apcprd03.prod.outlook.com
 (2603:1096:400:420::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 07:12:55 +0000
Received: from HK3PEPF0000021A.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::ef) by PU1PR01CA0020.outlook.office365.com
 (2603:1096:803:15::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 07:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK3PEPF0000021A.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 07:12:54 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 23 Aug
 2023 15:12:51 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 23 Aug
 2023 15:12:50 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 23 Aug 2023 15:12:50 +0800
From:   Seven Lee <wtli@nuvoton.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>,
        <SJLIN0@nuvoton.com>, <scott6986@gmail.com>,
        <supercraig0719@gmail.com>, <dardar923@gmail.com>,
        Seven Lee <wtli@nuvoton.com>
Subject: [PATCH 1/2] ASoC: dt-bindings: nau8821: Add single-ended input feature
Date:   Wed, 23 Aug 2023 15:12:43 +0800
Message-ID: <20230823071244.1861487-1-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021A:EE_|TYZPR03MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3cf316-5472-458b-1bb5-08dba3a85f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEd4zGR2tbeELCBSvW9TZbteTk5bnh0zMjKzR37TfOkMkN+BMLM3VIwMEeF3XOwyJDpa3Ti93Pf2lgb0cwTQjVZ+pdhe8KaqjvB1DFOSPMU2XGuR926BSClaPe1o/XbmbEvUEpXtZJleNsNBU7PzbHtZZ/+sVL/6YEnSdjicZ05WlDYYTJEJC7gHRj8X/foaNYr7mh9XRTR46K1Aa+YLBSxkotdlTDWVMeNrJBxdVZF2silM/O4r2ILwYIOfV4Jx9h4e9nH+SfhTSRabXUAiP/lg8mypEinCDipzKXYhSAJsYEmtrfh29Rk7jv60dgh2aSCjCwp1Du/Wy3KHJY5ijPHFjWU1nFHBkJrGBYKz2RvP9xDaSaGQsr4RNK7UsC7uMc+Hw3W9PIT10/ggkpE9UT8q8III49Lr4hzcUxh2t2Q7iYY98YB3Zpst62crRwaCFf+SDJoCxf/RssRRVYnhbsEa7CDW63dziPM3MH3OLiPYqqF14mu8ahb4oKTyt0M2UqkGkz40u/royNnooMgUcbJuJOIVOfUee87FmkPT2llqOzXlMassuaGx9dboC+RxgIPOi+AFd+1BoR45PewNURYMpBDQ1WbrFbsyLGPH7DsvvGioYAUibRjaLX1RUxuPCjE4tcj52l/3taY9gwuiJDSZpbMSxlcTpjz+9FdXSY2q5hEUUvc31IB5bt66uxBJdvQpmwcQjyY1I1184RB8Zm3AhQLQqVR+nIl6WJ7CGvB9HdMzl8x4oxZk3bND9vFQEc/og/zcwFxloAK2sCVsV9PksWwmQG7QvwyR28gFUe8/R3JhcVfgSVIMNqhhBXxY
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(478600001)(6666004)(54906003)(70206006)(70586007)(316002)(6916009)(47076005)(40480700001)(41300700001)(8676002)(4326008)(1076003)(86362001)(8936002)(2616005)(107886003)(12101799020)(5660300002)(26005)(336012)(426003)(36756003)(83380400001)(40460700003)(7416002)(356005)(82740400003)(2906002)(81166007)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:12:54.6420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3cf316-5472-458b-1bb5-08dba3a85f00
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7395
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add input with single-ended control.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 .../devicetree/bindings/sound/nuvoton,nau8821.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
index fc2f4ce4db88..3e54abd4ca74 100644
--- a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
@@ -89,6 +89,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 3072000
 
+  nuvoton,left-input-single-end:
+    description: Enable left input with single-ended settings if set.
+        For the headset mic application, the single-ended control is
+        just limited to the left adc for design demand.
+    type: boolean
+
   '#sound-dai-cells':
     const: 0
 
@@ -114,6 +120,7 @@ examples:
             nuvoton,jkdet-pull-enable;
             nuvoton,jkdet-pull-up;
             nuvoton,key-enable;
+            nuvoton,left-input-single-end;
             nuvoton,jkdet-polarity = <GPIO_ACTIVE_LOW>;
             nuvoton,micbias-voltage = <6>;
             nuvoton,vref-impedance = <2>;
-- 
2.25.1

