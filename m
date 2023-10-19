Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369E67D0008
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbjJSQ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345242AbjJSQ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:56:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38AD2134
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:55:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC460143D;
        Thu, 19 Oct 2023 09:56:38 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.67.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB0223F5A1;
        Thu, 19 Oct 2023 09:55:54 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, maz@kernel.org, suzuki.poulose@arm.com
Cc:     broonie@kernel.org, James Clark <james.clark@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] arm64/sysreg: Move TRFCR definitions to sysreg
Date:   Thu, 19 Oct 2023 17:54:59 +0100
Message-Id: <20231019165510.1966367-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019165510.1966367-1-james.clark@arm.com>
References: <20231019165510.1966367-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add separate definitions for ELx and EL2 as TRFCR_EL1 doesn't have CX.
This also mirrors the previous definition so no code change is required.

Also add TRFCR_EL12 which will start to be used in a later commit.

Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 12 ----------
 arch/arm64/tools/sysreg         | 41 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 38296579a4fd..068dd6abe273 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -278,8 +278,6 @@
 #define SYS_RGSR_EL1			sys_reg(3, 0, 1, 0, 5)
 #define SYS_GCR_EL1			sys_reg(3, 0, 1, 0, 6)
 
-#define SYS_TRFCR_EL1			sys_reg(3, 0, 1, 2, 1)
-
 #define SYS_TCR_EL1			sys_reg(3, 0, 2, 0, 2)
 
 #define SYS_APIAKEYLO_EL1		sys_reg(3, 0, 2, 1, 0)
@@ -496,7 +494,6 @@
 #define SYS_VTTBR_EL2			sys_reg(3, 4, 2, 1, 0)
 #define SYS_VTCR_EL2			sys_reg(3, 4, 2, 1, 2)
 
-#define SYS_TRFCR_EL2			sys_reg(3, 4, 1, 2, 1)
 #define SYS_HAFGRTR_EL2			sys_reg(3, 4, 3, 1, 6)
 #define SYS_SPSR_EL2			sys_reg(3, 4, 4, 0, 0)
 #define SYS_ELR_EL2			sys_reg(3, 4, 4, 0, 1)
@@ -904,15 +901,6 @@
 /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
 #define SYS_MPIDR_SAFE_VAL	(BIT(31))
 
-#define TRFCR_ELx_TS_SHIFT		5
-#define TRFCR_ELx_TS_MASK		((0x3UL) << TRFCR_ELx_TS_SHIFT)
-#define TRFCR_ELx_TS_VIRTUAL		((0x1UL) << TRFCR_ELx_TS_SHIFT)
-#define TRFCR_ELx_TS_GUEST_PHYSICAL	((0x2UL) << TRFCR_ELx_TS_SHIFT)
-#define TRFCR_ELx_TS_PHYSICAL		((0x3UL) << TRFCR_ELx_TS_SHIFT)
-#define TRFCR_EL2_CX			BIT(3)
-#define TRFCR_ELx_ExTRE			BIT(1)
-#define TRFCR_ELx_E0TRE			BIT(0)
-
 /* GIC Hypervisor interface registers */
 /* ICH_MISR_EL2 bit definitions */
 #define ICH_MISR_EOI		(1 << 0)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 76ce150e7347..5bf0d91ac073 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2628,3 +2628,44 @@ Field	5	F
 Field	4	P
 Field	3:0	Align
 EndSysreg
+
+SysregFields TRFCR_EL2
+Res0	63:7
+UnsignedEnum	6:5	TS
+	0b0000	USE_TRFCR_EL1_TS
+	0b0001	VIRTUAL
+	0b0010	GUEST_PHYSICAL
+	0b0011	PHYSICAL
+EndEnum
+Res0	4
+Field	3	CX
+Res0	2
+Field	1	E2TRE
+Field	0	E0HTRE
+EndSysregFields
+
+# TRFCR_EL1 doesn't have the CX bit so redefine it without CX instead of
+# using a shared definition between TRFCR_EL2 and TRFCR_EL1
+SysregFields TRFCR_ELx
+Res0	63:7
+UnsignedEnum	6:5	TS
+	0b0001	VIRTUAL
+	0b0010	GUEST_PHYSICAL
+	0b0011	PHYSICAL
+EndEnum
+Res0	4:2
+Field	1	ExTRE
+Field	0	E0TRE
+EndSysregFields
+
+Sysreg	TRFCR_EL1	3	0	1	2	1
+Fields	TRFCR_ELx
+EndSysreg
+
+Sysreg	TRFCR_EL2	3	4	1	2	1
+Fields	TRFCR_EL2
+EndSysreg
+
+Sysreg	TRFCR_EL12	3	5	1	2	1
+Fields	TRFCR_ELx
+EndSysreg
-- 
2.34.1

