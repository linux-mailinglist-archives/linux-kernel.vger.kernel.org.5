Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E7D77D0AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbjHORK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238711AbjHORKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:10:47 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9132EE52;
        Tue, 15 Aug 2023 10:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxnvTb7fPC/zf1MV+EF4wXz2bh/n9UYuWZSiwHRYmvjYBGPBxt+dyi09MduNHnwVnptAdrMxw/xQqyRZ6f672k8yfVdusSkJQi4+IvHictagXKzn7ClRSFI3nbNi9p4+zTEDI1KfpZOaWQ6uFaxffGScU07cyZdNe/74JePbqAVb+n8OKB6MeaZIar2iXHDl8fZVRGuk8TEPYIrAa+outkDGO1rDNiIfjZ7ZcriWupOxIaPV6vmnbYZFG9BnbL+/IV1QBzj5nZNBQv87nGkwr6MVOBvbc+CZpsmOe5EdWL6wopdh79rgcTB7Ceh3kBHB7ch7O51xfGAT9VOMIDuLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSkdZEp+Jww856/UYZzBtI7Zq5ifa5yTr7tOL2zAf4c=;
 b=mAFcxQNiqDeocXoVS8DwD5oi4gl/l4HQsR1j1XwKbKscXBblfyYTEiKmbS7jsShRvSyULyOfFTqLywPwQvwmJ5oRzHrqkZCRTrcB6JhTM9sK7msXjpbi+t3Hlc9pxlp+uZbMRjzknIlyFT1XGXaxG9/eLRMAVeFtUofKDsXlKOkYmG4DyreSJ4pPLbX3X29aMGYYuB1u/711YOwLHwW6dLY1u7FIl6T1yOH0yghcNXEucso321q8i+Qftd9VasSppx8mjtKkCzVgUMqQ3WANtd/dg5oCBjfcxfFzrOtswGgE3Zqg0GAmkBxRrJKdQ0hhFYmiMDlGRKoBZwf//YjhrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSkdZEp+Jww856/UYZzBtI7Zq5ifa5yTr7tOL2zAf4c=;
 b=qA6I4RIaFDhPfHlEJEvskddnkn5kwbQZap5srlqtIu+8lt0E2gmUMRqf7Vd6zgogqCBq2EjEjQAhxGLh0uevGPuZND+cij/AUQ8Zsr5Bitmw+P+2UhVLG051jtWBzXU+97u+sB4pEqL2ijDB6f73c545olkpfn+z8kTwlihicbk=
Received: from SA1P222CA0042.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::16)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 17:10:42 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::47) by SA1P222CA0042.outlook.office365.com
 (2603:10b6:806:2d0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 17:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 17:10:41 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 12:10:40 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: register a dirty framebuffer callback for fbcon
Date:   Tue, 15 Aug 2023 13:10:10 -0400
Message-ID: <20230815171011.232410-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b7da1e-1d9c-48dd-9f14-08db9db28e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzaaO03OpECgnnnUOU29s2O/QB7oL5x/ETdqfJYKji3aNYk/MDaYwDB9RG6nB3knQwWXKAOeroICpnC70SdQsYJor1jzXTCy/AqRTUR5MjW0UYJvUgdJnatueWt9IM7yEE/VHC2MPR/9mM80G8/Wyy0Aj0CdGjpEgjJ9Y2DPcLjNJZFicJSE/mFq60As0gCr133GPod5PVOX16lN82PuW3amrp3EAP9U7UOb+lJY0Pfj5C9KV78TaUpD8JBGaY7wLNFLb6KWq6pIi8q2UaoLtfz6/OlfUkQJo/R/IDqmREZK3f1MZytGbLDqgKHmhhQIJ1sTmXWuo6O3xsQgvm/tk9ioaZ+jNDdXO/UxldAUBpCgsRkVBTX6c9OCYosBbNHGZG7GyFFp64afMLw+tdqcTpoh3BIunT0/2Euat4ieHUin2mwvusKM8CC/oXKP+r2v3xQ8PGddaSP/Ev6fEm7JVjRZnSsccEf5IXNLOnXE/9cdGAGHM7IO2zASZYEsZwNvPlfh9wyhJBmZKgMfY/rz+jZg95sBFctt1e2XNAFMaApsYALXApYxdUj3atAQ3ddeuH4ANygYhJj6EmBHasCd/MxCc/OU4EtwCC1TC/zm7/cct40ckXycuFKd3Fno0EljOdDgAxueMQFgyvmU150yudq8dte8BGob4Sy3QmZzWXrtJ4Iq2R6G1Ez62ytGGq/VYYD36aaXqfFsHf9OE7K7T6Dydn6A2E71D9fN1l/Cmq4Ejm8IenVGTGzOn/ayc5gL4SA4Fej4ENgfqIWlOAaj2/kZYITm/S2asVKdR87hcHIxgwqfJ15n8Bc70m3FLLd/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(1800799009)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(70206006)(8936002)(6916009)(478600001)(6666004)(54906003)(70586007)(86362001)(316002)(426003)(41300700001)(2906002)(336012)(40480700001)(36860700001)(36756003)(26005)(1076003)(16526019)(40460700003)(47076005)(83380400001)(966005)(356005)(81166007)(82740400003)(4326008)(8676002)(5660300002)(44832011)(2616005)(14143004)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 17:10:41.8902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b7da1e-1d9c-48dd-9f14-08db9db28e42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fbcon requires that we implement &drm_framebuffer_funcs.dirty.
Otherwise, the framebuffer might take awhile to flush (which would
manifest as noticeable lag). However, we can't enable this callback for
non-fbcon cases since it might cause too many atomic commits to be made
at once. So, implement amdgpu_dirtyfb() and only enable it for fbcon
framebuffers on devices that support atomic KMS.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org # 6.1+
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2519
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 26 ++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index d20dd3f852fc..743db9aee68c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -38,6 +38,8 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
@@ -532,11 +534,29 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
 	return true;
 }
 
+static int amdgpu_dirtyfb(struct drm_framebuffer *fb, struct drm_file *file,
+			  unsigned int flags, unsigned int color,
+			  struct drm_clip_rect *clips, unsigned int num_clips)
+{
+
+	if (strcmp(framebuffer->comm, "[fbcon]"))
+		return -ENOSYS;
+
+	return drm_atomic_helper_dirtyfb(framebuffer, file_priv, flags, color,
+					 clips, num_clips);
+}
+
 static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
 	.destroy = drm_gem_fb_destroy,
 	.create_handle = drm_gem_fb_create_handle,
 };
 
+static const struct drm_framebuffer_funcs amdgpu_fb_funcs_atomic = {
+	.destroy = drm_gem_fb_destroy,
+	.create_handle = drm_gem_fb_create_handle,
+	.dirty = amdgpu_dirtyfb
+};
+
 uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 					  uint64_t bo_flags)
 {
@@ -1139,7 +1159,11 @@ static int amdgpu_display_gem_fb_verify_and_init(struct drm_device *dev,
 	if (ret)
 		goto err;
 
-	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
+	if (drm_drv_uses_atomic_modeset(dev))
+		ret = drm_framebuffer_init(dev, &rfb->base,
+					   &amdgpu_fb_funcs_atomic);
+	else
+		ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
 
 	if (ret)
 		goto err;
-- 
2.41.0

