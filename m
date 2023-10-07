Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585247BC413
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjJGCHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJGCHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:07:32 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F32BE;
        Fri,  6 Oct 2023 19:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MieEGUnR1Gcf7beK8dFMdyfOIX2JGGsKZ8Hso3yvsRELz0L/bBbKce1a7GSB9vs+Bn8vs0/eIT6TFqQXzL6ayRh8UnDD8jt5ruekv/jErhHwrBx6J/ZbM5Uq1xMY/nX/RDQ5/ykKpa6lhGErJUzydTSDcArCmBQt10j61nCuLLOd5UdZuJFThyVgzwqoznkL+R70x7gEyqdxD9SQX94tfNqWjgBt1ZBd7aZEDcQYJldWTdHVuGCmWgSb++Pd24Xb5d4i0CGAQZUIrtb/F59z2XEUCMqM9if9EOgECy1jxPqJVhZf0YyV9ceZ8v2GIvXEqCYNr/2XFExXI44FM+B3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSx9Mf4EfQOTtlGXcpmwLF9odZ9iD7TmE0cKtFGgkU0=;
 b=WOZKfjmUC4UaVnOabGntzNT/RgeUixK6tFUKH/tFtURXxBba/JlmX35XM3+bJoVmtna1GIZBleiumc8ww+mw+cGPoUSKdE6usHeOdiS7HNa2Y9a2KmwTvfrf2uxI4kSB2yC+Ej6CsoxBNS3IYI1/iE/0BFWPvEiz6jUBYe5OcBqqOaJQdJVskClsLaAxBxFvvkk0vDA3SykCjWQe6/22cA7DoJYcsQO1/0AzgygaLcZgsB0VO7wTFABjQic3jfIn+UHJQ4NKAzSbzx+7kf7FKsYIOvwwDttzoniloXqqczGCprehyZ4dmpotghOMA3o/mOpem8DIj6BonyCVaJiKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSx9Mf4EfQOTtlGXcpmwLF9odZ9iD7TmE0cKtFGgkU0=;
 b=Vwdi+RwmGi5NqWV1VrXn5iev/jAhAb91o3pVh0o9a8bvpQCdnyK/kIDt16lKnL2mpTvmTNGWtp4bu9cYX5pKI/odxogdggdQBHTCOHhkzshEh1wEaRGW5Ww54f6JRnxcH13juBcs0m8Ml6fQ2yZSehrKz6xj6d9sjI817MsF4vU=
Received: from DU2PR04CA0075.eurprd04.prod.outlook.com (2603:10a6:10:232::20)
 by AS8PR02MB9315.eurprd02.prod.outlook.com (2603:10a6:20b:57e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Sat, 7 Oct
 2023 02:07:28 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::f0) by DU2PR04CA0075.outlook.office365.com
 (2603:10a6:10:232::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.30 via Frontend
 Transport; Sat, 7 Oct 2023 02:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Sat, 7 Oct 2023 02:07:27 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 7 Oct
 2023 04:07:27 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 7 Oct
 2023 04:07:27 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Sat, 7 Oct 2023 04:07:27 +0200
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id CC29C2895;
        Sat,  7 Oct 2023 04:07:26 +0200 (CEST)
Received: from lnxchenhuiz2.sh.cn.axis.com (localhost [127.0.0.1])
        by lnxchenhuiz2.sh.cn.axis.com (8.15.2/8.15.2/Debian-22) with ESMTP id 39727PY51912667;
        Sat, 7 Oct 2023 10:07:25 +0800
Received: (from chenhuiz@localhost)
        by lnxchenhuiz2.sh.cn.axis.com (8.15.2/8.15.2/Submit) id 39727Pq91912666;
        Sat, 7 Oct 2023 10:07:25 +0800
From:   Hermes Zhang <Hermes.Zhang@axis.com>
To:     <sre@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: power: supply: bq24190: Add BQ24296 compatible
Date:   Sat, 7 Oct 2023 10:07:00 +0800
Message-ID: <20231007020701.1912553-2-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231007020701.1912553-1-Hermes.Zhang@axis.com>
References: <20231007020701.1912553-1-Hermes.Zhang@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|AS8PR02MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee0ebae-f40b-48ba-7131-08dbc6da2811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEa24qfhiek74SqCg53kJp0sqBlbBIG0nJAN2cs2GP5CJ81eaHdgwnP9hfU3ixAG5dmVxq0U2ymQ3Mh6RSMUJMB3CRSfq2jRT+2NoYXrd4NxxOXRiOqGjTaV0CBafmfcmjJSycf0ZpV+nlEm4Y6WyGUPFxaW7o+aGDXbtQvp78ENECsUU504VtzuidRrBtoJuZMstGgm0v+C02KMY6XomMoBxwGxnFGCDDVhEUKUDKiygfV/+vcUxetymp5UjmlzT9laZNvMNPJRtjLTBugapGBIldLKGzvtdH8uQLdvuVZRU6wf0fpvjozP+6yipzsXK4p5RgO6UQEA2Vt5feaq7XjlIrUEJPckQ5h2tka2BSJT9tgMKq+JQ1G22AIiKhVb2CSLNJXQBzE6DfYpI3j0YfYHlAenPdBl8+FHxY6KJXv/INdSjpP1iYLA0RQSO6Fk6qJIXtUNXbAoJIfTudpxyQh91smGmlrILmprteC38QLTCDwIwwLeUM8dwjn3HiibpWqsuySOIh2bmvXuO+CGhgbf5ZaAMRXCngbugodLEpeaY25f3RiddhNBXVtQxlPqFQ7BBi3meu9hXYqoiKnyFPqHKTCn0MPYJMbUbl4bES+rZBmMeVk7XIqwNFm5mb/+hHJvpe72bB2owWzf45OshloP82JxYf03DA0LThVBaY5O10+K5y3xQq4nYHrIcrqUtTWU6sb3NgPW6TffsRScVX73rohWgCaHjojlkaPsH9Hva28Zian7yWDjWo/O38EJDYlHjRRzMXiiQ17SfjTmkg==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(451199024)(1800799009)(64100799003)(186009)(36840700001)(46966006)(40470700004)(41300700001)(1076003)(110136005)(70206006)(2616005)(54906003)(42186006)(316002)(70586007)(8676002)(26005)(5660300002)(4326008)(8936002)(336012)(478600001)(6666004)(426003)(40460700003)(47076005)(2906002)(83380400001)(4744005)(81166007)(82740400003)(36756003)(40480700001)(36860700001)(356005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 02:07:27.9834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee0ebae-f40b-48ba-7131-08dbc6da2811
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9315
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hermes Zhang <chenhuiz@axis.com>

The BQ24296 is most similar to the BQ24196, but the:
1. OTG config is split from CHG config (REG01)
2. ICHG (Fast Charge Current limit) range is smaller (<=3008mA)
3. NTC fault is simplified to 2 bits

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---
 Documentation/devicetree/bindings/power/supply/bq24190.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
index d3ebc9de8c0b..131b7e57d22f 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
@@ -20,6 +20,7 @@ properties:
       - ti,bq24192
       - ti,bq24192i
       - ti,bq24196
+      - ti,bq24296
 
   reg:
     maxItems: 1
-- 
2.30.2

