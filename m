Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E5575EE67
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjGXIyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjGXIyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:54:33 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26308E7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:54:29 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8Yr16NmMzBRx5N
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:54:25 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690188865; x=1692780866; bh=chwR9bvFIg7iBGHVcSR9ITXkkoJ
        jDG51eV1JMt2fqig=; b=SFzxcNQJfmH2iWnlPIODSRbG3ucbAh4R+FuRW4eH1H2
        xCLYm0bqatfPCsRUMZaQraniglwPE3h4b42OhQ/l2fS814Xikw7YYP/6Sg2hYO6H
        QB+9lAlOfSPvoc5d7PO6GfoM7Pnkyh3SgHiV0ygy12RlobLuE+hbmDVtPhZsxZOD
        H5o/yH76RDH/rOxrsYh3Y4AUrj2IjKIXgfaHdfy1bn+rXDvheqc5nsMPTD9QTVDQ
        OkozNrYdTWPp+jo0HUPOBHSu4EM9qEdRNECXA9mzAlJObAOP0fwcyyzd+0/bCDMH
        wXbk+gcGEwCrMjHjAdCc1RtOPKB5YcQXR1ElCmI/ilA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5I3g6DxNccOw for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 16:54:25 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8Yr14866zBKnld;
        Mon, 24 Jul 2023 16:54:25 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 16:54:25 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: Clean up errors in smu_v11_0_7_pptable.h
In-Reply-To: <20230724085303.9607-1-xujianghui@cdjrlc.com>
References: <20230724085303.9607-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <c5575527bac1642f2cf896ae0ee9f582@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: trailing whitespace
ERROR: open brace '{' following struct go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  .../amd/pm/swsmu/inc/smu_v11_0_7_pptable.h    | 41 +++++++++----------
  1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h 
b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
index 1cb399dbc7cc..64d60d48846a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
@@ -42,23 +42,23 @@
  #define SMU_11_0_7_PP_POWERSAVINGCLOCK_VERSION            0x01          
  // Power Saving Clock Table Version 1.00

  enum SMU_11_0_7_ODFEATURE_CAP {
-    SMU_11_0_7_ODCAP_GFXCLK_LIMITS = 0,
-    SMU_11_0_7_ODCAP_GFXCLK_CURVE,
-    SMU_11_0_7_ODCAP_UCLK_LIMITS,
-    SMU_11_0_7_ODCAP_POWER_LIMIT,
-    SMU_11_0_7_ODCAP_FAN_ACOUSTIC_LIMIT,
-    SMU_11_0_7_ODCAP_FAN_SPEED_MIN,
-    SMU_11_0_7_ODCAP_TEMPERATURE_FAN,
-    SMU_11_0_7_ODCAP_TEMPERATURE_SYSTEM,
-    SMU_11_0_7_ODCAP_MEMORY_TIMING_TUNE,
-    SMU_11_0_7_ODCAP_FAN_ZERO_RPM_CONTROL,
-    SMU_11_0_7_ODCAP_AUTO_UV_ENGINE,
-    SMU_11_0_7_ODCAP_AUTO_OC_ENGINE,
-    SMU_11_0_7_ODCAP_AUTO_OC_MEMORY,
+    SMU_11_0_7_ODCAP_GFXCLK_LIMITS = 0,
+    SMU_11_0_7_ODCAP_GFXCLK_CURVE,
+    SMU_11_0_7_ODCAP_UCLK_LIMITS,
+    SMU_11_0_7_ODCAP_POWER_LIMIT,
+    SMU_11_0_7_ODCAP_FAN_ACOUSTIC_LIMIT,
+    SMU_11_0_7_ODCAP_FAN_SPEED_MIN,
+    SMU_11_0_7_ODCAP_TEMPERATURE_FAN,
+    SMU_11_0_7_ODCAP_TEMPERATURE_SYSTEM,
+    SMU_11_0_7_ODCAP_MEMORY_TIMING_TUNE,
+    SMU_11_0_7_ODCAP_FAN_ZERO_RPM_CONTROL,
+    SMU_11_0_7_ODCAP_AUTO_UV_ENGINE,
+    SMU_11_0_7_ODCAP_AUTO_OC_ENGINE,
+    SMU_11_0_7_ODCAP_AUTO_OC_MEMORY,
      SMU_11_0_7_ODCAP_FAN_CURVE,
      SMU_11_0_ODCAP_AUTO_FAN_ACOUSTIC_LIMIT,
-    SMU_11_0_7_ODCAP_POWER_MODE,
-    SMU_11_0_7_ODCAP_COUNT,
+    SMU_11_0_7_ODCAP_POWER_MODE,
+    SMU_11_0_7_ODCAP_COUNT,
  };

  enum SMU_11_0_7_ODFEATURE_ID {
@@ -130,8 +130,7 @@ enum SMU_11_0_7_PWRMODE_SETTING {
  };
  #define SMU_11_0_7_MAX_PMSETTING      32        //Maximum Number of 
PowerMode Settings

-struct smu_11_0_7_overdrive_table
-{
+struct smu_11_0_7_overdrive_table {
      uint8_t  revision;                                        
//Revision = SMU_11_0_7_PP_OVERDRIVE_VERSION
      uint8_t  reserve[3];                                      //Zero 
filled field reserved for future use
      uint32_t feature_count;                                   //Total 
number of supported features
@@ -160,8 +159,7 @@ enum SMU_11_0_7_PPCLOCK_ID {
  };
  #define SMU_11_0_7_MAX_PPCLOCK      16          //Maximum Number of PP 
Clocks

-struct smu_11_0_7_power_saving_clock_table
-{
+struct smu_11_0_7_power_saving_clock_table {
      uint8_t  revision;                                        
//Revision = SMU_11_0_7_PP_POWERSAVINGCLOCK_VERSION
      uint8_t  reserve[3];                                      //Zero 
filled field reserved for future use
      uint32_t count;                                           
//power_saving_clock_count = SMU_11_0_7_PPCLOCK_COUNT
@@ -169,8 +167,7 @@ struct smu_11_0_7_power_saving_clock_table
      uint32_t min[SMU_11_0_7_MAX_PPCLOCK];                       
//PowerSavingClock Mode Clock Minimum array In MHz
  };

-struct smu_11_0_7_powerplay_table
-{
+struct smu_11_0_7_powerplay_table {
        struct atom_common_table_header header;       //For 
sienna_cichlid, header.format_revision = 15, header.content_revision = 0
        uint8_t  table_revision;                      //For 
sienna_cichlid, table_revision = 2
        uint16_t table_size;                          //Driver portion 
table size. The offset to smc_pptable including header size
@@ -178,7 +175,7 @@ struct smu_11_0_7_powerplay_table
        uint32_t golden_revision;                     //PPGen use only: 
PP Table Revision on the Golden Data Base
        uint16_t format_id;                           //PPGen use only: 
PPTable for different ASICs. For sienna_cichlid this should be 0x80
        uint32_t platform_caps;                       
//POWERPLAYABLE::ulPlatformCaps
-
+
        uint8_t  thermal_controller_type;             //one of 
SMU_11_0_7_PP_THERMALCONTROLLER

        uint16_t small_power_limit1;
