Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7D87DD6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 21:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjJaUQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 16:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjJaUQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 16:16:34 -0400
X-Greylist: delayed 424 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 13:16:31 PDT
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A8AF3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 13:16:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=novastrider.com;
        s=key1; t=1698782965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=McCJc14guP8yKKFOSL2omkE6jgC9UadK7MEeeUAlNhk=;
        b=IQZigNqD37TIb9IuCV/22K6EP+dlhwlI0naHdHE9IjOPoetSpvoeFYgm0ETDxnHT02mnfd
        ok40q5IZGM9tfJ+7z+m5uhYNRVrxohZ+yIW7s3xQbFRZr2333FKxvOEzyjWy/u0V/AqNk1
        OOvmxxfj5cY1gm3+dZCUGi6IU2NFOdj7SpP347un1BxvjkKXg9IUTyMgvr31Uatisxbpvz
        ynM3qna7we0wQLBVeaYPSMQA1HHkYmDNLAxG7Z9uHe2IJXSbw8LvpwgHiZ6VD2tDyb2/dw
        +ZcowgRcyHFhItQeoVmjgneS53WTPCoxjR4VJDWZ8WXRu/+x50HCWEMIeoIeFA==
From:   Marielle Novastrider <marielle@novastrider.com>
To:     linux-doc@vger.kernel.org
Cc:     marielle@novastrider.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/arm64: Fix typos in elf_hwcaps
Date:   Tue, 31 Oct 2023 20:08:38 +0000
Message-Id: <20231031200838.55569-1-marielle@novastrider.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small typos in register and field names.

Signed-off-by: Marielle Novastrider <marielle@novastrider.com>
---
 Documentation/arch/arm64/elf_hwcaps.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index 76ff9d7398fd..9d51f0d72fc4 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -174,7 +174,7 @@ HWCAP2_DCPODP
     Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0010.
 
 HWCAP2_SVE2
-    Functionality implied by ID_AA64ZFR0_EL1.SVEVer == 0b0001.
+    Functionality implied by ID_AA64ZFR0_EL1.SVEver == 0b0001.
 
 HWCAP2_SVEAES
     Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0001.
@@ -222,7 +222,7 @@ HWCAP2_RNG
     Functionality implied by ID_AA64ISAR0_EL1.RNDR == 0b0001.
 
 HWCAP2_BTI
-    Functionality implied by ID_AA64PFR0_EL1.BT == 0b0001.
+    Functionality implied by ID_AA64PFR1_EL1.BT == 0b0001.
 
 HWCAP2_MTE
     Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0010, as described
@@ -232,7 +232,7 @@ HWCAP2_ECV
     Functionality implied by ID_AA64MMFR0_EL1.ECV == 0b0001.
 
 HWCAP2_AFP
-    Functionality implied by ID_AA64MFR1_EL1.AFP == 0b0001.
+    Functionality implied by ID_AA64MMFR1_EL1.AFP == 0b0001.
 
 HWCAP2_RPRES
     Functionality implied by ID_AA64ISAR2_EL1.RPRES == 0b0001.
-- 
2.39.3 (Apple Git-145)

