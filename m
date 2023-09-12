Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8CC79D0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjILMLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbjILMLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:11:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7AF10EC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:11:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41B7C433C7;
        Tue, 12 Sep 2023 12:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694520686;
        bh=KXNNit1NR0Sy8mgpeMe5utffy8Ysa2Z5Lh2pnEXXbtY=;
        h=From:To:Cc:Subject:Date:From;
        b=MqOlKaLiuoyjAdBLO5SRg2YsMzBaQeoMfgxh6uUAYTQ7qzik7rNC1Xid7haASVvN7
         9VGIVRKdO1vxWv42KfVk4tfuJyOs4O5VkYNKUDe+MNQGPHvRpPPqsUTvXLdLyJRYEW
         WyyaEkxQgvItBsK5kxhkExvlrUA33dynP1vnbgsPBtPB+hXiD3mD59UrJCNcZ4oCrf
         W2GU6ew3DOHMc/BhslpTUMxb6f4sELYcxfZRoqQhDU9seEeDeFyMiBN1qnar4B71Av
         lNEZmsLaNWpKVlY+vkGsWhvgBDorrd03Z3A1UEi7ZaGPCo13nN3Ab8dz29aiIp1shz
         zpMi8CUDGcwxQ==
Received: (nullmailer pid 380681 invoked by uid 1000);
        Tue, 12 Sep 2023 12:11:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: Add Cortex-A520 CPU part definition
Date:   Tue, 12 Sep 2023 07:11:14 -0500
Message-Id: <20230912121120.380420-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CPU Part number for the new Arm design.

Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 5f6f84837a49..74d00feb62f0 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -79,6 +79,7 @@
 #define ARM_CPU_PART_CORTEX_A78AE	0xD42
 #define ARM_CPU_PART_CORTEX_X1		0xD44
 #define ARM_CPU_PART_CORTEX_A510	0xD46
+#define ARM_CPU_PART_CORTEX_A520	0xD80
 #define ARM_CPU_PART_CORTEX_A710	0xD47
 #define ARM_CPU_PART_CORTEX_A715	0xD4D
 #define ARM_CPU_PART_CORTEX_X2		0xD48
@@ -148,6 +149,7 @@
 #define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
 #define MIDR_CORTEX_X1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1)
 #define MIDR_CORTEX_A510 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A510)
+#define MIDR_CORTEX_A520 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A520)
 #define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A710)
 #define MIDR_CORTEX_A715 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A715)
 #define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
-- 
2.40.1

