Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A62758093
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjGRPPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjGRPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:15:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F313E170C;
        Tue, 18 Jul 2023 08:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+h8qqLhBhAiAumRPi/1LthlaoPq7Sn7Yib1Dg7HWgC9YIWde7khvNk0l3jLEpIpJvGGARnk4QLw2r8fYbLOksr3d9Xg7pKttGxKua4CGHfneUrGewLMty0MMtowTBDNLoCnMDdYVaWVnyqxXq3UjXshsNyKIYSo1U32Zqb8s8fbMfMMRBaE13kV3Lk5FxRtoUBMIoAZ52YOTmaSdFtEvnMgPNTodrHTWrvpL1XoWorSQvfBTOnTUxHk9beUJtK1dSBhOXAykYgr1UymFANiuZS9wMax4BWS/giUKZUdlqZYk72U8vu+krvj73E7ZIcKjSQMgMlSIkfKefAoxTdigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8rMpB1V6eQ29/v+a8uQ8ImD0gWgEqhzmdnyEnER2mE=;
 b=mrGc/+vmCXmt3dtPQGF9bJJ2NesKZ5/7y89IIfzuPJCSUz9G/XqX6W3OpKYYk5F/wvb4az6TjiIIC6p7+VGfuXp7NFfkIo73M2p2M9vpVPlX9gpHaUIyCQGrFu/+cQQu7uVPnJPztb97irJ5kGxNXEhXYSyzat/nzDL5JxK2I15l7gp8yvOtWm3C8JB+nDPvltGRB2Q+dUf3ps/ixpJPIRv5TgFFBBoH9/E25emey/qmPHz8M31/dd6aKzSA04MoudAx91Y4vzqpBIv4ldc5ohjyuc1gSiAkJ2b6skHkDzJK9ylIRaToBYaEIkbNZRJ6aioofgoXWECQ1enaplFZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8rMpB1V6eQ29/v+a8uQ8ImD0gWgEqhzmdnyEnER2mE=;
 b=lKopU1aZSUNI5MS9Dlec174jfd+Vfe3uIUq2NJyOCRum/qXwL6CQUOm8y3BxavpYcahV4Cx0kY2E+0Uy3+8GK2YmlNrAYRXlBLcY+xvv3BLNmZ9AnkH9aLbwGb8vzSnokeU885KD6GFOHiQKIJHvsz1TIRxxmQP+cDHnG22mKHI=
Received: from MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::19)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 18 Jul
 2023 15:15:38 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::73) by MW4P222CA0014.outlook.office365.com
 (2603:10b6:303:114::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 15:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 15:15:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Jul
 2023 10:15:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Jul
 2023 10:15:36 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 18 Jul 2023 10:15:36 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <ojeda@kernel.org>
CC:     <jani.nikula@linux.intel.com>, <rdunlap@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konstantin@linuxfoundation.org>, <rust-for-linux@vger.kernel.org>,
        "Carlos Bilbao" <carlos.bilbao@amd.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v8 2/2] docs: Integrate rustdoc generation into htmldocs
Date:   Tue, 18 Jul 2023 10:15:34 -0500
Message-ID: <20230718151534.4067460-3-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718151534.4067460-1-carlos.bilbao@amd.com>
References: <20230718151534.4067460-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: b484d83b-4111-400a-38fc-08db87a1d7aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXzMG13AivBd30obCJ9ztmT1oOHuwo2hfvC9OmcT8dTPQVgi7OLwkt4VXGsEe+rSUnNHJnnl5+BQY2TM306httumlC8euUykEYgFptemgLy+m8l6L0V/XvR5MMwW+ootiY84Pd7lK7d5R19elDebGf7tIbrsHwm7jKmNYwtEbxb41EsD/Xt0uoVg1pIj6eFwB1PxuVoFnulCXUAB2/D88dHPigjsK74ZHyyEHmgsZL2Z7LJzsL+w6phXIiq1/Y9MqQJ9MdNZtyZmkGFcWqQ4Ogd8FHDph9FdWC2JFFEc8EewH+vlYgCUeyMxRKo3PMP1xvwRdr/tvCgnXtnYq32IyuWsoNSAMXee/WjhMD3sn3PzmprDRngudSUcC+Ku1gKUs4IzkI5ILUl4Z6540WbhQVSr67+yNn45bNU3iLg8t9bVE+OsWuPGwStr1tKb1j1jgkU7lEsdk3AoM5TgvNIuQjzIXmeLe5iayFHMrQF5uux2qxQMIDANPNuGaNMXYleGeKHPeP4MEjwwPxyJ1UU04ahTdzEVZ014glCvalqQyfxtAvvvKI/h9ItEaMa22ZU4UFNg8qAAjCjEp5+ZdzMdpK2UbubYDPQWrwdkMYcYGq2auJAM40yF48W3ZORVm2z3s8tHa34ykp31oPUQtFzuPctZ3ALnjbHcHq1b75fQqvoyjp/u0u2ApPQ+3sU88P4cTUwRsn2PzgJ2Fr91TnpKmv1CviGRKXKR4AcMG+8u4QYqXTA6GfmcyHZvt4G7V65NI9NBk6OFhSvJTdq+ROTCLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(70206006)(70586007)(44832011)(316002)(8676002)(4326008)(8936002)(40460700003)(5660300002)(41300700001)(86362001)(36756003)(2906002)(40480700001)(7696005)(478600001)(426003)(336012)(82740400003)(186003)(26005)(1076003)(2616005)(110136005)(54906003)(36860700001)(356005)(81166007)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:15:37.9236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b484d83b-4111-400a-38fc-08db87a1d7aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
 Documentation/Makefile | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 023fa658a0a8..2f35793acd2a 100644
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
 
@@ -95,6 +101,16 @@ htmldocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
+# If Rust support is available and .config exists, add rustdoc generated contents.
+# If there are any, the errors from this make rustdoc will be displayed but
+# won't stop the execution of htmldocs
+
+ifneq ($(wildcard $(srctree)/.config),)
+ifeq ($(CONFIG_RUST),y)
+	$(Q)$(MAKE) rustdoc || true
+endif
+endif
+
 texinfodocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,texinfo,$(var),texinfo,$(var)))
-- 
2.34.1

