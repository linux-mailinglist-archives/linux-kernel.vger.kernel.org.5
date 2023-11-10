Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9D7E805D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbjKJSJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345845AbjKJSG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:06:57 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6229B76BC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:37:20 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1330701a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1699598240; x=1700203040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZkVaBG0vteO7021P9A28Nc2SPcEoHes6KG3sccedrc=;
        b=O/gVJH+Fu6wVesV+pChgZ4ELO5JGjDzD77RPRTEzzCkxFfgPWkWAcwbu0IQQxOeist
         7TqtlTOb3SxB9K9eQ5Ma0sRupY1Je8BNIRltVqElfKG8kEcX3Yj1yvN21lQQ7TN/lDSF
         k+ltXn9g0GEnVAf9FwxDsNBFye/gXaAiPcxePLqu3RuUnN3VsJLlZFzjml6SHrVex3Ji
         AtyRtGOPwoaT5iOez28GhuafEFPS1kTHhpaY4hUUTlJGDIjKru0e1hdYknTlw+TNVmea
         aIT9k32P76kMGSRqyoTCnE5Gy1MqTIH9y4jcLGElndU/G7nVShG/AEjeUcgn/baVMFXX
         9tDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598240; x=1700203040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZkVaBG0vteO7021P9A28Nc2SPcEoHes6KG3sccedrc=;
        b=fK+nXrdY4morUa3FqwCftXW0xvbyJ16eyrQFJBUpwpL1P6DRJd2HLI3GEqCYCnFoUO
         hb8xKMovv/PUKqTkTPyNjCwyslgR++23ag8/Pv+Z3RRgUQL8XUMPTbRPxKvgiiRoFPDT
         Kh7kEBJgqO3ovnpH74NECR8TebDYA8vdmdRF9hEAyBo2tUQNqyOr3cBqIKXxp+kgatHa
         zThwGDm06GuLsZsjBqO1KUu0BSngMakqTkTnBZkJR1AP4e3kZaZYCtaeI9WtnznsWwDW
         ZIHR5Sh1a3LK9wtp8gNGXuPaI0E7epVzH9Mj5JQzNTPSEpmzC1TCBoecRQByMeX2W+2L
         /dmg==
X-Gm-Message-State: AOJu0YxSUeAa0XATFlAFPvf/fqiubi2Nccrb06C3X0JmkA7aFu5lA0cq
        iYSQzENzBKxRWWiyXkMSkVosEZqrsNKug6HNzyBIrg==
X-Google-Smtp-Source: AGHT+IHzUkskBvz7HGScU42uWeC4Dc9zc0SH/QAjzmC+CEGdzduzni4Fc5/WgCHXiLlaS0Owh+jM3Q==
X-Received: by 2002:a17:902:6547:b0:1ca:abe:a08b with SMTP id d7-20020a170902654700b001ca0abea08bmr5289987pln.68.1699588381511;
        Thu, 09 Nov 2023 19:53:01 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b001c61e628e9dsm4301857plc.77.2023.11.09.19.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 19:53:01 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Sunil V L <sunilvl@ventanamicro.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] wifi: iwlwifi: Fix build warning when DMI is not enabled
Date:   Fri, 10 Nov 2023 09:22:55 +0530
Message-Id: <20231110035255.2925292-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver currently assumes CONFIG_DMI is enabled along with ACPI.
This may not be true. Due to this, the kernel test bot reports new
warning like below for RISC-V allyesconfig builds.

>> drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:25:
warning: '%s' directive argument is null [-Wformat-overflow=]

1190 | "System vendor '%s' is not in the approved list, disabling PPAG.\n",

Fix the warnings by printing "<unknown>" when DMI interface returns
NULL.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311040602.sCjU3UXr-lkp@intel.com/
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
Changes since v1:
	1) Modified the fix not to add dependency on DMI in Kconfig as
	   per feedback from Johannes.

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c     | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index b96f30d11644..8cbb426f97e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1273,7 +1273,7 @@ bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt)
 	if (!dmi_check_system(dmi_ppag_approved_list)) {
 		IWL_DEBUG_RADIO(fwrt,
 			"System vendor '%s' is not in the approved list, disabling PPAG.\n",
-			dmi_get_system_info(DMI_SYS_VENDOR));
+			dmi_get_system_info(DMI_SYS_VENDOR) ?: "<unknown>");
 			fwrt->ppag_flags = 0;
 			return false;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 329c545f65fd..e0c519daffe2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -882,7 +882,7 @@ static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
 				 le16_to_cpu(rsp->block_list[i]));
 
 	pos += scnprintf(pos, endpos - pos, "\nOEM name: %s\n",
-			 dmi_get_system_info(DMI_SYS_VENDOR));
+			 dmi_get_system_info(DMI_SYS_VENDOR) ?: "<unknown>");
 	pos += scnprintf(pos, endpos - pos, "\tVendor In Approved List: %s\n",
 			 iwl_mvm_is_vendor_in_approved_list() ? "YES" : "NO");
 	pos += scnprintf(pos, endpos - pos,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 403bd17b8b7a..c11ecb372dbc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1231,7 +1231,7 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 	if (!iwl_mvm_is_vendor_in_approved_list()) {
 		IWL_DEBUG_RADIO(mvm,
 				"System vendor '%s' is not in the approved list, disabling TAS in US and Canada.\n",
-				dmi_get_system_info(DMI_SYS_VENDOR));
+				dmi_get_system_info(DMI_SYS_VENDOR) ?: "<unknown>");
 		if ((!iwl_mvm_add_to_tas_block_list(cmd.v4.block_list_array,
 						    &cmd.v4.block_list_size,
 							IWL_TAS_US_MCC)) ||
@@ -1245,7 +1245,7 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 	} else {
 		IWL_DEBUG_RADIO(mvm,
 				"System vendor '%s' is in the approved list.\n",
-				dmi_get_system_info(DMI_SYS_VENDOR));
+				dmi_get_system_info(DMI_SYS_VENDOR) ?: "<unknown>");
 	}
 
 	/* v4 is the same size as v3, so no need to differentiate here */
-- 
2.39.2

