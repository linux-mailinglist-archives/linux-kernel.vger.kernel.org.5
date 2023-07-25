Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC33761CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjGYPDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjGYPDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:03:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F33219B4;
        Tue, 25 Jul 2023 08:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jrv6MfcXZ66rk3/y25vMOG0OK4qqjjysbr89eV3gyz9fwXgDGMF8U9yfvnNpDW35JnRBI6bi+g/X5+poOs+FSMx229kYPdF2YUaGEY3MdyrMsMWsSieFvAlrBQCVco9MdqfMdJ2M2jbDah9pin7SW5nxjx9Oaw+eyphr/mPb2atjLgodP/ViEA4fj09UQRlx6eeqs/EIw7pt5npmu9nSfaW0TiXZDbaoNjnKRMOdSDWm0Pm7phuxFBtCFaepADU8R+FkJK1sF3uN1aGfWYlxb/rOFeEdPFrUFVVe1q9UGF3PgXLx2yJa9n2xwlLO1W1MP+0qWKKK38uf/aXMtdzyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nifJsE2UV2mEH8F5u5axUMVcgqtGZhETfORgcci/IUg=;
 b=OZ6Iibxa4Biy5Vi6Spqb/aLPH045SiOyfG5JJ+gqnEU/wcm0IA/VdAGdZgbDlY3OFckgyOJdqtkQV0vs1xl/09w1joYkKvquGpvyvDTpBpLQd3cQWHUObm14eCNrcwMRJX04MCFPE1nHjAZs2b+fHXsmN+YovFkzii+wrMjKKFXy7nfyWDmX7krm1YxTYXhDJWmybdAlsu55q1nyt/amC8h9D+azeIy/JDwdviZu8f4xwBbDX/c2bLGmXp7tSyyLneosvUH5fd4jSjO8kT4tt7tz7Y2scehmgLhOag45mLR65zRGbg5YiYbvdF5O8wdOJkqViNQY5GIsdzZMQdEl2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nifJsE2UV2mEH8F5u5axUMVcgqtGZhETfORgcci/IUg=;
 b=tDz8YpfVVe1vvoiW8udEsXDk+haswp9j8NcfVPiNaqZim7+s8KvpTGtb2HH+8eAWZ4cmjwnp+dz8yFggJf/fp4OuDb2cHVigEn6CS5MhsKCfLhflM9DzHNL6tRCX5aOLyo7OlsSPYLyD2anfFaxYGv86dkBz/KKJOnXDusuyy9U=
Received: from MW4PR03CA0065.namprd03.prod.outlook.com (2603:10b6:303:b6::10)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 15:02:33 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::fc) by MW4PR03CA0065.outlook.office365.com
 (2603:10b6:303:b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 15:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 25 Jul 2023 15:02:33 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 10:02:26 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <leo.yan@linaro.org>, <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [RESEND][PATCH v4 0/3] perf/mem: AMD IBS improvements
Date:   Tue, 25 Jul 2023 20:32:03 +0530
Message-ID: <20230725150206.184-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c78e04c-3ea8-4e41-37ed-08db8d202cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akHezD1tWE9ybjWSEZreqwnUXGAOqjlwV3PmiCkUjp/oShybDxfTZC1XWHYmPPWygkFimmz4Sac12+f7CPxgpSjLKprB6epuDt6yqkU4x4yrvz+4ach5iZXCdmi1+UV2549XGESdQxWhH9K2Rsr4/ZkcUYiahkd6iLYnnkIjl3kIuV8ndG2lmjEeG1B9jXrXTjqqJGrNZwYwuQcZ0GboePu6Av8qAtwSTajZTwv9yDPP0hKSmiArhZ2ifMPdQcFIuKIHTS95jPEPAAtLOXiOMGZYbca40UNzDnPPej3GKS9O0oEsre8w1GF9HswUYI7FnbqM9uJtEo8Ydf38W1QeIB264G09AGVGkSyPtI3QdCwrNIeWTzYnW9tVIKf30dOto1LPNK2LnGsTdcLPfZogcj0djNJbX0nIJE7isL7C5cy8qST5YngS2gChl7peoytVv3QaFGFHrUSgFqK3WKBSSt6dABCjRE9xgITQFv0Gs+uQVZH33J7sUWBZGzX6Fl2TIWC2iY/xTE2FzMGzF/pUbj8yuOGWywEn2Ie/qstmVXJjQ7QGtM/50vtUJc1Z2nSf/Dmd7Kch1F6m5ZW9gsMgD7i02MPd8sMNpfbL2JM+nWodcG1glnDOiVQ2K6orPV18P0muX0Xoc0ZBhI00qglk6P5jTEWHO/rzdcrioE4KHEWsQ32Z6qIkDOtck2maxRgu+pJq83ICBpe1T8fE+yBjLe1k1mdX7Awl+aaqJoTjTzd8YY/B5z4TQZsrhUFOhL0THUk8cmel/coQr/vc9e0evQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(186003)(40460700003)(336012)(5660300002)(44832011)(36756003)(36860700001)(16526019)(8676002)(8936002)(7416002)(81166007)(2906002)(356005)(2616005)(426003)(47076005)(82740400003)(86362001)(40480700001)(4326008)(316002)(70206006)(70586007)(6666004)(478600001)(7696005)(966005)(83380400001)(41300700001)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 15:02:33.2029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c78e04c-3ea8-4e41-37ed-08db8d202cd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel IBS driver wasn't using new PERF_MEM_* APIs due to some of its
limitations. Mainly:

1. mem_lvl_num doesn't allow setting multiple sources whereas old API
   allows it. Setting multiple data sources is useful because IBS on
   pre-zen4 uarch doesn't provide fine granular DataSrc details (there
   is only one such DataSrc(2h) though).
2. perf mem sorting logic (sort__lvl_cmp()) ignores mem_lvl_num. perf
   c2c (c2c_decode_stats()) does not use mem_lvl_num at all.

Set mem_lvl_num, mem_remote and mem_hops for data_src via IBS. Handle
first issue using mem_lvl_num = ANY_CACHE | HOPS_0. In addition to
setting new API fields, convert all individual field assignments to
compile time wrapper macros built using PERF_MEM_S(). Also convert
DataSrc conditional code to array lookups.

v3: https://lore.kernel.org/r/20230407112459.548-1-ravi.bangoria@amd.com
v3->v4:
 - Tool patches were already picked up by Arnaldo. Resending only
   kernel patches with few tweaks in commit messages. No functionality
   changes.

Namhyung Kim (1):
  perf/x86/ibs: Set mem_lvl_num, mem_remote and mem_hops for data_src

Ravi Bangoria (2):
  perf/mem: Introduce PERF_MEM_LVLNUM_UNC
  perf/mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_NA

 arch/x86/events/amd/ibs.c       | 156 ++++++++++++++------------------
 include/linux/perf_event.h      |   3 +-
 include/uapi/linux/perf_event.h |   3 +-
 3 files changed, 72 insertions(+), 90 deletions(-)

-- 
2.41.0

