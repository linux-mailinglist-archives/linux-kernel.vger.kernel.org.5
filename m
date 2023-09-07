Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7383C797C42
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbjIGStl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344316AbjIGStf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:49:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650479D;
        Thu,  7 Sep 2023 11:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HExwwfhgFPvpPlyiutojPzlpd6ISrkH4R22MpF4VB6QKdTby7OAdQyiCvdN1c9eaCn/CwN+2ZhXZ7f7EeH+cjmXp/qAB3y6DHrrWUUNNEYd/IHfJcZMllxqPSiZETsI1cFDGGR7rx4m1tj4cxh60rhxLccy+AS0fcD+Qf29XGK1lXe4BIWud0jXky8SlOTNzhF+fRpeaEvUoS+O4iK52qjG7eEKQiknhRywcqeHrl+Zv5EA5KANVlSg3js4fEJ1SmPGQFvJUGu8q9SFmQRqeY43u5y689Th79yoORu72QZWliBS7/4H2JBof6uy2c4YCy0lmEUIwmqaYzuuanSkWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjdjvKP7swsd7+Yvbl98AxprlIDL/qZ4F8ZtV67bsns=;
 b=Acm9giiO1+zPBklXxfHx5FGgjfWYsWkjzWcYrBuMZDU0e4z19f8PhjIOwnzcOlE6SDmSq3L6jV7PWfKhBrm9Gnc0h+7N8JdhMYvKwrLJ3H8h8Ww5qK4sBh6TLcbLZsQuoGbdrwYKiTFwyc4W1bIiwnRbUl5isXECyZ+BH6DiXRKJY0V5aiouyCF+8sB6KLWozlAdtaobTSlUTFqggxCvzLF4rHHzaaKK0AEw/mEqGiN/SPPvoUB8X42ec++8Xi/KJ7CeiBEEEAhwHc/ONDmp2IMOUYG6ADPEkLjog2UBgflPgxnpEzmCKZjaWlknU96okgWiSfCkDXwqrwUYPV5JtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjdjvKP7swsd7+Yvbl98AxprlIDL/qZ4F8ZtV67bsns=;
 b=gu9h9zmCSm/NRpbzi9ZYXMAgpuohH/fo/lGbf87MGdUO7wG3EACH12TVX8RPsznLJfEyT9glegdimSVElJFLfZU69gHI9MiWZ1Jpavv9h4PEGKH8+Mpanz7KA0Af2ot2qQB/ML58ExZDu10oNTTZEpVBM6TyfDZugiZhauPVLW8=
Received: from CH2PR12CA0010.namprd12.prod.outlook.com (2603:10b6:610:57::20)
 by MW3PR12MB4586.namprd12.prod.outlook.com (2603:10b6:303:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 7 Sep
 2023 18:49:28 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::a3) by CH2PR12CA0010.outlook.office365.com
 (2603:10b6:610:57::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 18:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 18:49:28 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 13:49:25 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <thomas.lendacky@amd.com>, <john.allen@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Rijo-john.Thomas@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/5] crypto: ccp: Move direct access to some PSP registers out of TEE
Date:   Thu, 7 Sep 2023 13:48:42 -0500
Message-ID: <20230907184846.47598-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|MW3PR12MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: 118b268d-771d-4061-f96a-08dbafd32a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJtdbd+6EVuiGIoc/FOtqGoKgggy56IjzmVc3znHFSdFm9385ZZqoZLvo7Lnx7lpY2M7OaSExmbnlcgImGGsO5zLk1OzCpDreWDXM9PAKpFhQduH8L5d4mjvEcm9qp9J/nAm+H1nXEWuVprgw6STu7JarWtrz2G5Nl2fCmsvKlEwmfDPdlYST97cLLZEV1L7uhpTXdxPISo2R3/Ajgueur/cLYd2oj33gk4XgXaVV1xMH22Y3d1FL8Z6MDqe2dCTZo/B/dCpGuT74O/RZtkfDmjnrbmK2kGA4OqmCfYB5CBoamXflC6aCCCmTfMu6orMkF++hK6wDF8CXLr9oAQ5svaTB+2w6eXgqNW63jOBncv/0PAKfKCG2JDKJqDJS4w/O2npV/l7VXMbiHPbqmpBk80DwDLxpS6qB9McwjEHhQxSuHl/bnGjjdzzZq4/6bjixzCU0baRY58fg9exr5FLkG4t0a8+OYge1j9IxQBY89htuzAAhl9UTPfHDg8g9zPukSb+YTHJj7m/TFpuy//+GSR/KHD0RsM7qHwYY56gI0FZ/GCoae1rGROVfMss/DipiWbqgWk4tKdUtbKuiIizYl+b64n3tkVTRgf/mG23ob+GhWaKmCwlw04wLjZx3dOCnMUOlIWdXKs1AFrr8U2sbYHaWMJ96CgeglCDvVbuHTdlsddIOXVf1wucHg3nTkZQ3O3zGTIMZomUD6Rv2FSmDZX1IAGlX5T7TArH2lNCqlwW5ZIatk6iS2XoP4S4ye1DMM9mcRFvLG5UbaZarjEOPXCF2gvFLB/mlueVaa0UfulO6qJBpGpTUE+F46eBRRcl
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(82740400003)(356005)(81166007)(70206006)(6666004)(7696005)(40460700003)(36756003)(36860700001)(86362001)(40480700001)(47076005)(1076003)(2616005)(30864003)(26005)(426003)(16526019)(336012)(83380400001)(478600001)(110136005)(41300700001)(70586007)(8936002)(4326008)(8676002)(5660300002)(316002)(2906002)(44832011)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:49:28.2892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 118b268d-771d-4061-f96a-08dbafd32a2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4586
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

With the PSP mailbox registers supporting more than just TEE, access to
them must be maintained and serialized by the PSP device support. Remove
TEE support direct access and create an interface in the PSP support
where the register access can be controlled/serialized.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/psp-dev.c | 60 ++++++++++++++++++++++++++++++++++++
 drivers/crypto/ccp/psp-dev.h | 18 +++++++++++
 drivers/crypto/ccp/sp-dev.h  |  3 ++
 drivers/crypto/ccp/sp-pci.c  | 18 +++++++----
 drivers/crypto/ccp/tee-dev.c | 48 ++++++-----------------------
 drivers/crypto/ccp/tee-dev.h | 15 ++-------
 6 files changed, 104 insertions(+), 58 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index d42d7bc62352..3258c4612e14 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -9,6 +9,9 @@
 
 #include <linux/kernel.h>
 #include <linux/irqreturn.h>
+#include <linux/mutex.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
 
 #include "sp-dev.h"
 #include "psp-dev.h"
@@ -19,6 +22,62 @@
 
 struct psp_device *psp_master;
 
+#define PSP_C2PMSG_17_CMDRESP_CMD	GENMASK(19, 16)
+
+static int psp_mailbox_poll(const void __iomem *cmdresp_reg, unsigned int *cmdresp,
+			    unsigned int timeout_msecs)
+{
+	while (true) {
+		*cmdresp = ioread32(cmdresp_reg);
+		if (FIELD_GET(PSP_CMDRESP_RESP, *cmdresp))
+			return 0;
+
+		if (!timeout_msecs--)
+			break;
+
+		usleep_range(1000, 1100);
+	}
+
+	return -ETIMEDOUT;
+}
+
+int psp_mailbox_command(struct psp_device *psp, enum psp_cmd cmd, void *cmdbuff,
+			unsigned int timeout_msecs, unsigned int *cmdresp)
+{
+	void __iomem *cmdresp_reg, *cmdbuff_lo_reg, *cmdbuff_hi_reg;
+	int ret;
+
+	if (!psp || !psp->vdata || !psp->vdata->cmdresp_reg ||
+	    !psp->vdata->cmdbuff_addr_lo_reg || !psp->vdata->cmdbuff_addr_hi_reg)
+		return -ENODEV;
+
+	cmdresp_reg    = psp->io_regs + psp->vdata->cmdresp_reg;
+	cmdbuff_lo_reg = psp->io_regs + psp->vdata->cmdbuff_addr_lo_reg;
+	cmdbuff_hi_reg = psp->io_regs + psp->vdata->cmdbuff_addr_hi_reg;
+
+	mutex_lock(&psp->mailbox_mutex);
+
+	/* Ensure mailbox is ready for a command */
+	ret = -EBUSY;
+	if (psp_mailbox_poll(cmdresp_reg, cmdresp, 0))
+		goto unlock;
+
+	if (cmdbuff) {
+		iowrite32(lower_32_bits(__psp_pa(cmdbuff)), cmdbuff_lo_reg);
+		iowrite32(upper_32_bits(__psp_pa(cmdbuff)), cmdbuff_hi_reg);
+	}
+
+	*cmdresp = FIELD_PREP(PSP_C2PMSG_17_CMDRESP_CMD, cmd);
+	iowrite32(*cmdresp, cmdresp_reg);
+
+	ret = psp_mailbox_poll(cmdresp_reg, cmdresp, timeout_msecs);
+
+unlock:
+	mutex_unlock(&psp->mailbox_mutex);
+
+	return ret;
+}
+
 static struct psp_device *psp_alloc_struct(struct sp_device *sp)
 {
 	struct device *dev = sp->dev;
@@ -164,6 +223,7 @@ int psp_dev_init(struct sp_device *sp)
 	}
 
 	psp->io_regs = sp->io_map;
+	mutex_init(&psp->mailbox_mutex);
 
 	ret = psp_get_capability(psp);
 	if (ret)
diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
index 8a4de69399c5..d917657c6085 100644
--- a/drivers/crypto/ccp/psp-dev.h
+++ b/drivers/crypto/ccp/psp-dev.h
@@ -14,6 +14,8 @@
 #include <linux/list.h>
 #include <linux/bits.h>
 #include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/psp.h>
 
 #include "sp-dev.h"
 
@@ -33,6 +35,7 @@ struct psp_device {
 	struct sp_device *sp;
 
 	void __iomem *io_regs;
+	struct mutex mailbox_mutex;
 
 	psp_irq_handler_t sev_irq_handler;
 	void *sev_irq_data;
@@ -71,4 +74,19 @@ struct psp_device *psp_get_master_device(void);
 #define PSP_SECURITY_HSP_TPM_AVAILABLE		BIT(10)
 #define PSP_SECURITY_ROM_ARMOR_ENFORCED		BIT(11)
 
+/**
+ * enum psp_cmd - PSP mailbox commands
+ * @PSP_CMD_TEE_RING_INIT:	Initialize TEE ring buffer
+ * @PSP_CMD_TEE_RING_DESTROY:	Destroy TEE ring buffer
+ * @PSP_CMD_MAX:		Maximum command id
+ */
+enum psp_cmd {
+	PSP_CMD_TEE_RING_INIT		= 1,
+	PSP_CMD_TEE_RING_DESTROY	= 2,
+	PSP_CMD_MAX			= 15,
+};
+
+int psp_mailbox_command(struct psp_device *psp, enum psp_cmd cmd, void *cmdbuff,
+			unsigned int timeout_msecs, unsigned int *cmdresp);
+
 #endif /* __PSP_DEV_H */
diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index 2329ad524b49..c4e125efe6c7 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -71,6 +71,9 @@ struct psp_vdata {
 	const struct sev_vdata *sev;
 	const struct tee_vdata *tee;
 	const struct platform_access_vdata *platform_access;
+	const unsigned int cmdresp_reg;
+	const unsigned int cmdbuff_addr_lo_reg;
+	const unsigned int cmdbuff_addr_hi_reg;
 	const unsigned int feature_reg;
 	const unsigned int inten_reg;
 	const unsigned int intsts_reg;
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index b6ab56abeb68..d1aedc5c1a68 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -418,18 +418,12 @@ static const struct sev_vdata sevv2 = {
 };
 
 static const struct tee_vdata teev1 = {
-	.cmdresp_reg		= 0x10544,	/* C2PMSG_17 */
-	.cmdbuff_addr_lo_reg	= 0x10548,	/* C2PMSG_18 */
-	.cmdbuff_addr_hi_reg	= 0x1054c,	/* C2PMSG_19 */
 	.ring_wptr_reg          = 0x10550,	/* C2PMSG_20 */
 	.ring_rptr_reg          = 0x10554,	/* C2PMSG_21 */
 	.info_reg		= 0x109e8,	/* C2PMSG_58 */
 };
 
 static const struct tee_vdata teev2 = {
-	.cmdresp_reg		= 0x10944,	/* C2PMSG_17 */
-	.cmdbuff_addr_lo_reg	= 0x10948,	/* C2PMSG_18 */
-	.cmdbuff_addr_hi_reg	= 0x1094c,	/* C2PMSG_19 */
 	.ring_wptr_reg		= 0x10950,	/* C2PMSG_20 */
 	.ring_rptr_reg		= 0x10954,	/* C2PMSG_21 */
 };
@@ -466,6 +460,9 @@ static const struct psp_vdata pspv2 = {
 static const struct psp_vdata pspv3 = {
 	.tee			= &teev1,
 	.platform_access	= &pa_v1,
+	.cmdresp_reg		= 0x10544,	/* C2PMSG_17 */
+	.cmdbuff_addr_lo_reg	= 0x10548,	/* C2PMSG_18 */
+	.cmdbuff_addr_hi_reg	= 0x1054c,	/* C2PMSG_19 */
 	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
@@ -476,6 +473,9 @@ static const struct psp_vdata pspv3 = {
 static const struct psp_vdata pspv4 = {
 	.sev			= &sevv2,
 	.tee			= &teev1,
+	.cmdresp_reg		= 0x10544,	/* C2PMSG_17 */
+	.cmdbuff_addr_lo_reg	= 0x10548,	/* C2PMSG_18 */
+	.cmdbuff_addr_hi_reg	= 0x1054c,	/* C2PMSG_19 */
 	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
@@ -485,6 +485,9 @@ static const struct psp_vdata pspv4 = {
 static const struct psp_vdata pspv5 = {
 	.tee			= &teev2,
 	.platform_access	= &pa_v2,
+	.cmdresp_reg		= 0x10944,	/* C2PMSG_17 */
+	.cmdbuff_addr_lo_reg	= 0x10948,	/* C2PMSG_18 */
+	.cmdbuff_addr_hi_reg	= 0x1094c,	/* C2PMSG_19 */
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10510,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10514,	/* P2CMSG_INTSTS */
@@ -493,6 +496,9 @@ static const struct psp_vdata pspv5 = {
 static const struct psp_vdata pspv6 = {
 	.sev                    = &sevv2,
 	.tee                    = &teev2,
+	.cmdresp_reg		= 0x10944,	/* C2PMSG_17 */
+	.cmdbuff_addr_lo_reg	= 0x10948,	/* C2PMSG_18 */
+	.cmdbuff_addr_hi_reg	= 0x1094c,	/* C2PMSG_19 */
 	.feature_reg            = 0x109fc,	/* C2PMSG_63 */
 	.inten_reg              = 0x10510,	/* P2CMSG_INTEN */
 	.intsts_reg             = 0x10514,	/* P2CMSG_INTSTS */
diff --git a/drivers/crypto/ccp/tee-dev.c b/drivers/crypto/ccp/tee-dev.c
index 5560bf8329a1..5e1d80724678 100644
--- a/drivers/crypto/ccp/tee-dev.c
+++ b/drivers/crypto/ccp/tee-dev.c
@@ -62,26 +62,6 @@ static void tee_free_ring(struct psp_tee_device *tee)
 	mutex_destroy(&rb_mgr->mutex);
 }
 
-static int tee_wait_cmd_poll(struct psp_tee_device *tee, unsigned int timeout,
-			     unsigned int *reg)
-{
-	/* ~10ms sleep per loop => nloop = timeout * 100 */
-	int nloop = timeout * 100;
-
-	while (--nloop) {
-		*reg = ioread32(tee->io_regs + tee->vdata->cmdresp_reg);
-		if (FIELD_GET(PSP_CMDRESP_RESP, *reg))
-			return 0;
-
-		usleep_range(10000, 10100);
-	}
-
-	dev_err(tee->dev, "tee: command timed out, disabling PSP\n");
-	psp_dead = true;
-
-	return -ETIMEDOUT;
-}
-
 static
 struct tee_init_ring_cmd *tee_alloc_cmd_buffer(struct psp_tee_device *tee)
 {
@@ -110,7 +90,6 @@ static int tee_init_ring(struct psp_tee_device *tee)
 {
 	int ring_size = MAX_RING_BUFFER_ENTRIES * sizeof(struct tee_ring_cmd);
 	struct tee_init_ring_cmd *cmd;
-	phys_addr_t cmd_buffer;
 	unsigned int reg;
 	int ret;
 
@@ -130,23 +109,15 @@ static int tee_init_ring(struct psp_tee_device *tee)
 		return -ENOMEM;
 	}
 
-	cmd_buffer = __psp_pa((void *)cmd);
-
 	/* Send command buffer details to Trusted OS by writing to
 	 * CPU-PSP message registers
 	 */
-
-	iowrite32(lower_32_bits(cmd_buffer),
-		  tee->io_regs + tee->vdata->cmdbuff_addr_lo_reg);
-	iowrite32(upper_32_bits(cmd_buffer),
-		  tee->io_regs + tee->vdata->cmdbuff_addr_hi_reg);
-	iowrite32(TEE_RING_INIT_CMD,
-		  tee->io_regs + tee->vdata->cmdresp_reg);
-
-	ret = tee_wait_cmd_poll(tee, TEE_DEFAULT_TIMEOUT, &reg);
+	ret = psp_mailbox_command(tee->psp, PSP_CMD_TEE_RING_INIT, cmd,
+				  TEE_DEFAULT_CMD_TIMEOUT, &reg);
 	if (ret) {
-		dev_err(tee->dev, "tee: ring init command timed out\n");
+		dev_err(tee->dev, "tee: ring init command timed out, disabling TEE support\n");
 		tee_free_ring(tee);
+		psp_dead = true;
 		goto free_buf;
 	}
 
@@ -174,12 +145,11 @@ static void tee_destroy_ring(struct psp_tee_device *tee)
 	if (psp_dead)
 		goto free_ring;
 
-	iowrite32(TEE_RING_DESTROY_CMD,
-		  tee->io_regs + tee->vdata->cmdresp_reg);
-
-	ret = tee_wait_cmd_poll(tee, TEE_DEFAULT_TIMEOUT, &reg);
+	ret = psp_mailbox_command(tee->psp, PSP_CMD_TEE_RING_DESTROY, NULL,
+				  TEE_DEFAULT_CMD_TIMEOUT, &reg);
 	if (ret) {
-		dev_err(tee->dev, "tee: ring destroy command timed out\n");
+		dev_err(tee->dev, "tee: ring destroy command timed out, disabling TEE support\n");
+		psp_dead = true;
 	} else if (FIELD_GET(PSP_CMDRESP_STS, reg)) {
 		dev_err(tee->dev, "tee: ring destroy command failed (%#010lx)\n",
 			FIELD_GET(PSP_CMDRESP_STS, reg));
@@ -370,7 +340,7 @@ int psp_tee_process_cmd(enum tee_cmd_id cmd_id, void *buf, size_t len,
 	if (ret)
 		return ret;
 
-	ret = tee_wait_cmd_completion(tee, resp, TEE_DEFAULT_TIMEOUT);
+	ret = tee_wait_cmd_completion(tee, resp, TEE_DEFAULT_RING_TIMEOUT);
 	if (ret) {
 		resp->flag = CMD_RESPONSE_TIMEDOUT;
 		return ret;
diff --git a/drivers/crypto/ccp/tee-dev.h b/drivers/crypto/ccp/tee-dev.h
index 49d26158b71e..ea9a2b7c05f5 100644
--- a/drivers/crypto/ccp/tee-dev.h
+++ b/drivers/crypto/ccp/tee-dev.h
@@ -17,21 +17,10 @@
 #include <linux/device.h>
 #include <linux/mutex.h>
 
-#define TEE_DEFAULT_TIMEOUT		10
+#define TEE_DEFAULT_CMD_TIMEOUT		(10 * MSEC_PER_SEC)
+#define TEE_DEFAULT_RING_TIMEOUT	10
 #define MAX_BUFFER_SIZE			988
 
-/**
- * enum tee_ring_cmd_id - TEE interface commands for ring buffer configuration
- * @TEE_RING_INIT_CMD:		Initialize ring buffer
- * @TEE_RING_DESTROY_CMD:	Destroy ring buffer
- * @TEE_RING_MAX_CMD:		Maximum command id
- */
-enum tee_ring_cmd_id {
-	TEE_RING_INIT_CMD		= 0x00010000,
-	TEE_RING_DESTROY_CMD		= 0x00020000,
-	TEE_RING_MAX_CMD		= 0x000F0000,
-};
-
 /**
  * struct tee_init_ring_cmd - Command to init TEE ring buffer
  * @low_addr:  bits [31:0] of the physical address of ring buffer
-- 
2.34.1

