Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D579A797C43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbjIGStp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344324AbjIGStg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:49:36 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87942B2;
        Thu,  7 Sep 2023 11:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diX4bKg9F8hkpxuVVtDiNDG9BG1n4uK/Dt0cZu55JpJy+TjFHz7qI82cOsv1Y1HIfxlemGyCPA4r6Onxd3I/lKkyQRBzgUCMf5t+vIh81WeCnoyoSLymWm0urjAdAShkWje/+/NrOLkNJjlbvPkb4Z5srs4TlYX6HTWAwkhdyiwo7MRznYs5pWDLWrWU/F/N4lf3RkHGo42vhEfckqa6bNtPRdVqzlBvhiXmTxma6kHBYmA2bEcsbsb7qjQ8FjFajFhcOjkjagtNs/L4ZtaV82rlrefDwwoGCqpV0Plm+nsoXclZDLK549L5iW2nYUDteWZZmHQe8LxYCJQcYKlnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdJiPbUYQtU9W2j49ud60rcC0m8WFcBFMQB8d9GdwjU=;
 b=QxuYdwUg38ZVnpsB0ZCS07bG/vNUub3P0FlT3asnXbp2FOF98uNkAgb1RvTm/SvQe9Ih9kUkkG0e+9sWOW3Z5jPZ7NDhAq6oTY6t7NurqqKe3IWxjIX9FZAiXS6UfQjdxY6BS9ylcQmoSex2AA/PQ1AYZhl7ULEp6YReWEcDBzoiWHp+C/8372vrzhEOhJYobcOxolPXKk882PC7ukvagUiT0GnUJAeLQwb01kA18JzE0c4ywwjymRa1m9VjJySJQsqD+dfDFYGOc6asLt8Stn2S5sR7GsfsG+pLVbPr09wHl0FoA5DnFpLedDPripBJQ1yTXL8n92S9boke/jW31w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdJiPbUYQtU9W2j49ud60rcC0m8WFcBFMQB8d9GdwjU=;
 b=ySxdVlA+v9+qWV6NM4QASNnP4R4UjeGLm2G86iEHbTY94twJVmDhW7OkSG11HZQXX8Omuwz+U8KPMXsivRc5Rb5JLWdQRHWi8KDBlAr2YG+WhwwfTm70j1QfIQI6JdVmQmeeA+XAEVfnzHgrgul/sYUkQNvbeqTx6DBe4cDZt/I=
Received: from CH2PR12CA0017.namprd12.prod.outlook.com (2603:10b6:610:57::27)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Thu, 7 Sep
 2023 18:49:29 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::3) by CH2PR12CA0017.outlook.office365.com
 (2603:10b6:610:57::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 18:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 18:49:29 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 13:49:26 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <thomas.lendacky@amd.com>, <john.allen@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Rijo-john.Thomas@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/5] crypto: ccp: Add support for extended PSP mailbox commands
Date:   Thu, 7 Sep 2023 13:48:43 -0500
Message-ID: <20230907184846.47598-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907184846.47598-1-mario.limonciello@amd.com>
References: <20230907184846.47598-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be53ce6-04f9-4d14-b866-08dbafd32aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4k3B/JU91fFvPkaH7XJjItrxr+MLxxV/nQfiqRFc0WbijhIH8P/tPlAy/myA9OiVSeJXDwzY7v56VEPKY+omLyWj40WlpzvYUdwRuGQTYj2ND5cFK+TdV/bYfymZflWXKU5haM++lp6jJRQW6ukclI47eAXh0DVvJdyKD9h7beuy2v+L3P3JBR3Gnoic+WVfFooVdsGh3QSEp7FzV0Ua9DUay5NQYP7cLZr/gd+NTAE+52sXEYCAHbHj/yxGMgbJILvg3Nj4zK3Z7AGO088W+EampNzsUVMwXrrNYANV7MONWEuaAkh/VLNkH4GwSg1ybhV8hkI61+qhTO9nx7iE2TPkK3LyH25mZz9xp7HflGwv4Lsf2S2rbrUbHgJupKn+ycQXErt1u0Ai4KQ50kfc0hiltmFbfM+HYhKMnUbnon1VtqsHEEk/q4DbQKw6+3g68LKpFenwA+03gg1uKFXx2sjkVznTnzo1/drb7TUoLA469i96x+o/YRkgR7hoVV3EZIRW3CeoccyrFP3AHJQL7csVUd8bioAIM0Ursl63VrVlP2xZmClEeNKFwF6Dmx/iwAdC/E6V5fq8nUIuvjy0OWQc5qqJus+ZxlMTpG2vVctFbIoDpAcBxu8E9B17JHO4uqyf+vv7R3+9rfGjZdn3qeCSfGXMmH5Ukjb4F3inY7lZIsiD2xH77sR/Xnpy3N8LHl12THD78tljrJCZsUP/Cw+vS5PdwIm5EBq80NTUDgMVRVqOkoYMHshhE7M5xRv8gsvXFU8N1XJY+jPxgvDW9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(44832011)(8676002)(5660300002)(316002)(110136005)(36756003)(70206006)(2906002)(70586007)(54906003)(8936002)(4326008)(41300700001)(40460700003)(16526019)(336012)(1076003)(36860700001)(7696005)(47076005)(26005)(40480700001)(426003)(15650500001)(6666004)(81166007)(356005)(478600001)(83380400001)(2616005)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:49:29.1329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be53ce6-04f9-4d14-b866-08dbafd32aae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PSP mailbox supports a number of extended sub-commands.  These
subcommands are placed in the header of the buffer sent to the mailbox.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/psp-dev.c | 24 ++++++++++++++++++++++++
 drivers/crypto/ccp/psp-dev.h | 21 +++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index 3258c4612e14..f9f3b3404f87 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -78,6 +78,30 @@ int psp_mailbox_command(struct psp_device *psp, enum psp_cmd cmd, void *cmdbuff,
 	return ret;
 }
 
+int psp_extended_mailbox_cmd(struct psp_device *psp, unsigned int timeout_msecs,
+			     struct psp_ext_request *req)
+{
+	unsigned int reg;
+	int ret;
+
+	print_hex_dump_debug("->psp ", DUMP_PREFIX_OFFSET, 16, 2, req,
+			     req->header.payload_size, false);
+
+	ret = psp_mailbox_command(psp, PSP_CMD_TEE_EXTENDED_CMD, (void *)req,
+				  timeout_msecs, &reg);
+	if (ret) {
+		return ret;
+	} else if (FIELD_GET(PSP_CMDRESP_STS, reg)) {
+		req->header.status = FIELD_GET(PSP_CMDRESP_STS, reg);
+		return -EIO;
+	}
+
+	print_hex_dump_debug("<-psp ", DUMP_PREFIX_OFFSET, 16, 2, req,
+			     req->header.payload_size, false);
+
+	return 0;
+}
+
 static struct psp_device *psp_alloc_struct(struct sp_device *sp)
 {
 	struct device *dev = sp->dev;
diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
index d917657c6085..396a80d846c0 100644
--- a/drivers/crypto/ccp/psp-dev.h
+++ b/drivers/crypto/ccp/psp-dev.h
@@ -78,15 +78,36 @@ struct psp_device *psp_get_master_device(void);
  * enum psp_cmd - PSP mailbox commands
  * @PSP_CMD_TEE_RING_INIT:	Initialize TEE ring buffer
  * @PSP_CMD_TEE_RING_DESTROY:	Destroy TEE ring buffer
+ * @PSP_CMD_TEE_EXTENDED_CMD:	Extended command
  * @PSP_CMD_MAX:		Maximum command id
  */
 enum psp_cmd {
 	PSP_CMD_TEE_RING_INIT		= 1,
 	PSP_CMD_TEE_RING_DESTROY	= 2,
+	PSP_CMD_TEE_EXTENDED_CMD	= 14,
 	PSP_CMD_MAX			= 15,
 };
 
 int psp_mailbox_command(struct psp_device *psp, enum psp_cmd cmd, void *cmdbuff,
 			unsigned int timeout_msecs, unsigned int *cmdresp);
 
+/**
+ * struct psp_ext_req_buffer_hdr - Structure of the extended command header
+ * @payload_size: total payload size
+ * @sub_cmd_id: extended command ID
+ * @status: status of command execution (out)
+ */
+struct psp_ext_req_buffer_hdr {
+	u32 payload_size;
+	u32 sub_cmd_id;
+	u32 status;
+} __packed;
+
+struct psp_ext_request {
+	struct psp_ext_req_buffer_hdr header;
+	void *buf;
+} __packed;
+
+int psp_extended_mailbox_cmd(struct psp_device *psp, unsigned int timeout_msecs,
+			     struct psp_ext_request *req);
 #endif /* __PSP_DEV_H */
-- 
2.34.1

