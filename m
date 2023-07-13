Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808A37520E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbjGMMNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjGMMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:13:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0356F2D52;
        Thu, 13 Jul 2023 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689250370; x=1720786370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f+gmfGrxcQqjXfZd/zTckfTRTww6zd62gI4c22r/Xm8=;
  b=WGeBSf+FFc7Yc6Gn2urT3dvm+Vm+GHxyDTBoVku7VfgO2gDwCVFVGWfH
   sGTOGFAzU8lT4qNq9+Xu6WqY/cIdcm4sma8KLBnyPa/aqJjFRoTSbRBjh
   1Kfz6ijoDAfNAZfydUaQQfb/5OtMQVZBwdMQ7IrPRu56o4fZomIfNE/8H
   IQqaw3+zk9gnAkD+PkAhGOa/1nOCHzlx0ChCLN0D835KWHHgxLWpx0CGL
   sBRT6BMXw6Et3w4jQZ/GkALuPwG1d0Ts4wnFQ+kj448X16Cp5MkSinA/I
   aya9SRLuUCb+DVi7FfO2NgK8FmEQjbby2rF6/uQZ6bPQ13BzZN7skKT5m
   g==;
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="235310992"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2023 05:12:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Jul 2023 05:12:47 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Jul 2023 05:12:44 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        "Heiko Stuebner" <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 06/11] RISC-V: add missing single letter extension definitions
Date:   Thu, 13 Jul 2023 13:11:04 +0100
Message-ID: <20230713-train-feisty-93de38250f98@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713-target-much-8ac624e90df8@wendy>
References: <20230713-target-much-8ac624e90df8@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=f+gmfGrxcQqjXfZd/zTckfTRTww6zd62gI4c22r/Xm8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnrX17bI3rjyOnwwzrWLC0GMSG3z2w8vanr5aRqx39+l64K hSXbdZSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiu6cwMmxLVZkYrfh/+u+YuieTj9 5e0/hzo9mWmzunui3xb2wzudPE8N+La9K6q9sSFBe5ZZYdCv9u+8taTf6wjd9VgwnJ534xCHADAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To facilitate adding single letter extensions to riscv_isa_ext, add
definitions for the extensions present in base_riscv_exts that do not
already have them.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/hwcap.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 2460ac2fc7ed..a20e4ade1b53 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -14,12 +14,17 @@
 #include <uapi/asm/hwcap.h>
 
 #define RISCV_ISA_EXT_a		('a' - 'a')
+#define RISCV_ISA_EXT_b		('b' - 'a')
 #define RISCV_ISA_EXT_c		('c' - 'a')
 #define RISCV_ISA_EXT_d		('d' - 'a')
 #define RISCV_ISA_EXT_f		('f' - 'a')
 #define RISCV_ISA_EXT_h		('h' - 'a')
 #define RISCV_ISA_EXT_i		('i' - 'a')
+#define RISCV_ISA_EXT_j		('j' - 'a')
+#define RISCV_ISA_EXT_k		('k' - 'a')
 #define RISCV_ISA_EXT_m		('m' - 'a')
+#define RISCV_ISA_EXT_p		('p' - 'a')
+#define RISCV_ISA_EXT_q		('q' - 'a')
 #define RISCV_ISA_EXT_s		('s' - 'a')
 #define RISCV_ISA_EXT_u		('u' - 'a')
 #define RISCV_ISA_EXT_v		('v' - 'a')
-- 
2.40.1

