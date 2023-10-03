Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2847B6B64
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbjJCOZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjJCOZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:25:32 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88354B0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ityKK8EfPC6fvfmWUNA8icB2xaqpI3YGwKxFACSWw3CkZSxZm2YR1AnKTBGGHGYQy6CeOuUDMesN3wVCF62u0iQ6O8qHHkVRZVelAK6ssQy2o/b4Q0TNWv/POmUg/QtmmtjEBEWXDiCMgSNryboL1hTJNIV6UU4Chwv36Db8n3dwtCVRVCHRAsoGm17treoIIDw0z+yX5wrsHh6IXgJ0V/TiltjLB+tpV5/hgrpdLT7TeoJ9AWPoX5mUrYBobhd1OKPoAvIb2xkRfUTbq97gsGhI/AFjb6KvDzrkvZxdYS8hRJyMw3fz0lAfWJsZHW3/x5U6B6itD5Q9ZKAiRZxvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxNwMgqbmcSkR2tb9C8Bxtw9JOUpazHKzxZuPjAwuCM=;
 b=fsSW653769EvxNF2LuZ0BMWRg/bfUdM/gyIwMXnw0waNUafsY65oIvPzxuyHXX4pADrCxR8C7U1oezM+94ZrsBwLjdBE0knws5OjlVHoWZ9aGezsdFWTobTFDrjITLZ0Yj933MDgpDa+cIuFASeskiRCm3AE8wJbjUyzSKkWGk7olEr6UofAcxZVUDIlLFIsL8OIQ+R8CXaw3PLKwj86hQDwJZaPmxoDwZBQAtiXdEVzHRYjb3D9WJM1Nw4nhJ7xSe3jLeelvkk7tiBy4lNFEVL2qiSwCqUoNK74OHlz7AB3CQ5KN8+cauCbrmjlM9Ag40oFVu0/Q62TmVnizhUMNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=imag.fr smtp.mailfrom=axis.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxNwMgqbmcSkR2tb9C8Bxtw9JOUpazHKzxZuPjAwuCM=;
 b=ZOpESB8FShq7f/m1TX/kmUbqJpSe+FWO/cLs68UmQ5Fw7wC5ooEYQQcIB/5fdt/f6ys9HtUEyhmsecrriyQMTmdCo7uS3aQenKUrzhcAY1Il5K/m9m7NOsyhy+A/mNnV9w5lp6L+yySmSz+qTLJk31IuI3Fr/eDTZXWdo+MVnes=
Received: from AS9P194CA0025.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::15)
 by AM9PR02MB6851.eurprd02.prod.outlook.com (2603:10a6:20b:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 14:25:26 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:46d:cafe::41) by AS9P194CA0025.outlook.office365.com
 (2603:10a6:20b:46d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Tue, 3 Oct 2023 14:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 14:25:26 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 16:25:25 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 16:25:25 +0200
Received: from pc46047-2141.se.axis.com (pc46047-2141.se.axis.com [10.88.90.3])
        by se-intmail02x.se.axis.com (Postfix) with ESMTP id 73B3C12B7;
        Tue,  3 Oct 2023 16:25:25 +0200 (CEST)
Received: by pc46047-2141.se.axis.com (Postfix, from userid 10867)
        id 6CF0647A708C; Tue,  3 Oct 2023 16:25:25 +0200 (CEST)
From:   Anton Eliasson <anton.eliasson@axis.com>
Subject: [PATCH 0/2] coccicheck bugfix and CI improvement
Date:   Tue, 3 Oct 2023 16:25:13 +0200
Message-ID: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEkkHGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAwNj3eT85OTM5IzU5GxdM5MkI3MDE2MDcwNLJaCGgqLUtMwKsGHRsbW
 1AIuV5jRcAAAA
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
CC:     <cocci@inria.fr>, <linux-kernel@vger.kernel.org>,
        Anton Eliasson <anton.eliasson@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.12.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000043:EE_|AM9PR02MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6a5828-46a8-4c98-0768-08dbc41c965e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etvooVWX2uq0+RUJd3vrKKuf2+HrZRgxMKTgU5kl6tkwqqUlvpg3aKAAnds3glpqP7/tvrQmSwrcUn8VUJDO14yu2WqpPnt8+hg3T2lsAuB8KlBXkvSKhMrp8/dfj7k8ufHLpOa29zfrfKAmFH43NNLcGQAx88W+AV4F4OCBr/z4kDrwpQ3OH9O8jrwa9ta6z3c/7zj4K4qHV4Blqz0pUefuts3CovgB/SMA6jjGw3HJvlu1RcqvdSou+0H/+B6LKg0iVciesjg7OMzftlDqglN0kboFCYa8MXfTPJi5PwhcsWsJMRocaYINpMYDDkz4t3a5er8Q2tdTq1Jp5qCSgJxfnoSY/So28ekl4ycQ1kEtRtcFe8zARGSLdrxtEZME6W9WbKucOi8bo+1xekEhzpyucPzJ8J9xyLbnWVC5MXR+76pNUjeBSIAposQpfsJ/weWrF1P3qf/wqoWt6Xddtv6uQKvObUBJjsTJ+OgjzKqz/NPIgV+93qaRDAPLuYm2nFerYZZx1QhV0RUAeFU7FNtk61FTZNugsYFYNM1LWASuilq5NvosERU9rHcyqqWkJunr4Fi9I9897SzrrodHHdgd1QONPUPv/AYD75rCzrdwaHOkTA1oxcHCrer9Quq7XF5dSn778/Pkeu9IVHsN7cHv8y0Xj7tMwBDUZ8AEHDnHPGyWoiNx5qnmJaaWYqzg43ip+5irCpLEKuSOWws8FRYnD4nAcUnd6cK4PgM5Fyc+dmMRuP5X2poi7Wov9KvST/EiIsWmwWEPF9/MJOzjAw==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(6666004)(2616005)(426003)(107886003)(110136005)(336012)(4326008)(8676002)(6266002)(8936002)(478600001)(316002)(70206006)(26005)(47076005)(70586007)(42186006)(41300700001)(54906003)(356005)(82740400003)(40460700003)(44832011)(2906002)(81166007)(5660300002)(40480700001)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:25:26.3617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6a5828-46a8-4c98-0768-08dbc41c965e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6851
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 is a plain bugfix. Patch 2 allows us running coccicheck on an
external kernel module in a Makefile target like this:

    MODULE_SRC_DIR := $(shell pwd)/src
    coccicheck:
        $(MAKE) --no-print-directory -C $(KERNEL_SRC) M=$(MODULE_SRC_DIR) coccicheck MODE=report
        $(MAKE) --no-print-directory -C $(KERNEL_SRC) M=$(MODULE_SRC_DIR) coccicheck MODE=report COCCI=$(MODULE_SRC_DIR)/../coccinelle/custom-spatch.cocci

The output from this target is fairly compact. After filtering out the
"Please check for false positives..." message and sorting the remaining
lines it can be diffed with/without a proposed patch in a continuous
integration system in order to highlight newly introduced spatch
warnings.

Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
---
Anton Eliasson (2):
      scripts: coccicheck: Return error from run_cmd_parmap
      scripts: coccicheck: Separate spatch stdout and stderr

 scripts/coccicheck | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 831fe284d8275987596b7d640518dddba5735f61
change-id: 20231003-coccicheck-64b270430709

Best regards,
-- 
Anton Eliasson <anton.eliasson@axis.com>

