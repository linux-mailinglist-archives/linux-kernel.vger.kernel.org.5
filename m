Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFEE75675E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjGQPR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjGQPRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:17:25 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38130D2;
        Mon, 17 Jul 2023 08:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhRiGvI3XDBh7ZCGJThleXgXiEtKHKGKsKkz7TKBBFT4DdTKgWYyaEt319XfWlNnBKxyCjWVYzTvHGHXo5e1jXjEjTIWhqNmlQcmu+hgsQrPjv/V0+LfsdqwDxPRvtJhKVedZ1W2cfZIeRQxTwhWllg43xgVoqO2EizGMS7smrO9uwvZusXZkuW2SSwVv59Iv04jbpjzTTk3/H++IQYgXxXUXv7gEezfKLb35kbtD0Vr2zufbH63G7F8YcQoqCBiZhW5KLOoAycjvbIOVIzCNQ0pgTC1WMie1qpcuiDZoa8ZpFUv+kCDSqsUpeA1vWA+XOEx4JFmtgaVV8WzSlwY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdJeC2kWIZIZdeObkmzMk7lTUT798Y0jJoEjwbupOSE=;
 b=ckd0DBLU87Bw/4HBUWwN/XYSaHvG+OSHkNXAnAPCk6n6xm+5GWR3yhtAXRulTeGQ89/wZVUxPCI58ffY0ZN/PEfDWBrMCmmEA4lh/rnE61Y+UJZEpNCBToELOqdU7fner4v1AJyuLzsSIF3DfinNJOgpVP6O/+h8vAKMK4aeH2+2Bn9hAg9gNg+6woczxMfgTkeVKwULSJKi98J7acVbniDNnepOCxYdC8Id0oZuu2IAGgwPcSLmkSTc7iGQQG6RfBjlpckNWdHxEs3aADGyP6hErwcaJej5Wh0L8J1cfa+kqADcqwYYzBK+vdL/Avd8xm+U3d2BqsKuTZAu5AK93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdJeC2kWIZIZdeObkmzMk7lTUT798Y0jJoEjwbupOSE=;
 b=4PiaADqgHsvJ/Nt7nrn4knJRKzySZzp965dRs1Vhy4f9N4zyc598HP1tOz8jKQT7VtlDG/gDBQ3xORduiysMgRmwS2LdWzkNYncI866AqEgBd23XaA/LM6S6oDMKBl+5TIWmKtDH5AoGtUvf9fwvH3TChKaouYRhM+XYo8+Ebhw=
Received: from BN9PR03CA0866.namprd03.prod.outlook.com (2603:10b6:408:13d::31)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:17:21 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::a1) by BN9PR03CA0866.outlook.office365.com
 (2603:10b6:408:13d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 15:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 15:17:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 10:16:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 10:16:33 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 17 Jul 2023 10:16:33 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <ojeda@kernel.org>
CC:     <jani.nikula@linux.intel.com>, <rdunlap@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konstantin@linuxfoundation.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v7 2/2] docs: Integrate rustdoc generation into htmldocs
Date:   Mon, 17 Jul 2023 10:16:24 -0500
Message-ID: <20230717151624.3470714-3-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717151624.3470714-1-carlos.bilbao@amd.com>
References: <20230717151624.3470714-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd3a633-a67c-4ea8-db89-08db86d8ea12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIUFiZrcyuR8bNKKSRV3yiWP8TmU0zVlUQmm8K+CXf8jTKKvwB9vosfo6qV9F4lVnfGqSvjDMjhhwwUldEBsEGiY9cdLOAfSSe97nU7prZYXmNVxeK/6vrZBfQ8BRRFFzIEfQFx2sBnK1svGbrr5SX8hCHbLctuu1nvRj1Ybc4FziEIEnv0qMGP9O9BOLzonp1cf040Dme5Pq9NVZ6rtOWi9GFucxiMb+ABKGTLGs+erhZ3P5WdlDBdEhN4CkYpgRhFQAVnP2qyW82Cnpm3+PrrxY4s+suaoUSDJZu+ZTkISz6n4I6E634ojXRRzifNZj3lDQrfzfyQj+jY9E2hlUqcR9dzi5SeKQpHW4TZk/Qgav8c/zz26Bv6E05MJ2G013h+zqdzI1wlFKDxGsEk5Bz8TMoIq0LMkFhdH+wvvZhNcFwE/1fc7l3tgn//+KCTZhCORSgc/lzfSgT4/AMsQ7fzHa/9YyGLZpJatmN8CToHg/ACis7rFhct6cgn+mWdO0w7X1M/BUpC2lEEBwCa7LeCrUClWA/NjQORdV5IlOvduB9PVVJTF5z9C3/CcHABa046J0PHxj/BvcAVQMHcQmMm8kToqfQYf9ztNeOCg3vDicipkifR73NJ6EJ2kxtKraKUDOs+su9NdgfEJFS8Ug2Hl/5+P+N05sdst+/6qS+Z/jo/MO3d6QGfxzDddbDPVfq5EOBzX64AjRj4FjdKV3T4lAJFgJqK6f221QJF4DBmF1OP3B60NKKB84aTgVrep2Gw5zgxu+UqtXSGV06iPjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(54906003)(110136005)(356005)(81166007)(82740400003)(6666004)(7696005)(70206006)(41300700001)(478600001)(8676002)(8936002)(5660300002)(316002)(70586007)(4326008)(2616005)(336012)(36860700001)(186003)(1076003)(26005)(426003)(47076005)(86362001)(36756003)(44832011)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:17:20.0750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd3a633-a67c-4ea8-db89-08db86d8ea12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change target `make htmldocs` to combine RST Sphinx and the generation of
Rust documentation, when support is available and .config exists.

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/Makefile | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 023fa658a0a8..3c375c34fd81 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -59,6 +59,12 @@ PAPEROPT_letter = -D latex_paper_size=letter
 KERNELDOC       = $(srctree)/scripts/kernel-doc
 KERNELDOC_CONF  = -D kerneldoc_srctree=$(srctree) -D kerneldoc_bin=$(KERNELDOC)
 ALLSPHINXOPTS   =  $(KERNELDOC_CONF) $(PAPEROPT_$(PAPER)) $(SPHINXOPTS)
+ifneq ($(wildcard $(srctree)/.config),)
+ifeq ($(CONFIG_RUST),y)
+	# Let Sphinx know we will include rustdoc
+	ALLSPHINXOPTS   +=  -t rustdoc
+endif
+endif
 # the i18n builder cannot share the environment and doctrees with the others
 I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
 
@@ -95,6 +101,20 @@ htmldocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
+# If Rust support is available and .config exists, add rustdoc generated contents.
+# If there are any, the errors from this make rustdoc will be displayed but
+# won't stop the execution of htmldocs
+
+ifneq ($(wildcard $(srctree)/.config),)
+ifeq ($(CONFIG_RUST),y)
+	$(Q)$(MAKE) rustdoc || true
+else
+	@echo "   Skipping Rust documentation since CONFIG_RUST is not y."
+endif
+else
+	@echo "   Skipping Rust documentation since .config was not found."
+endif
+
 texinfodocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,texinfo,$(var),texinfo,$(var)))
-- 
2.34.1

