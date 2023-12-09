Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C725D80B139
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575006AbjLIBEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574829AbjLIBD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2645C19BF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:03:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30664C433C8;
        Sat,  9 Dec 2023 01:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702083835;
        bh=y25TspdV+qLqbmcbn1y+RPSd8+STa8gj+7s0nXWIqSo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=J/A3j23LirltPnsA17Cg7bvPuTKcWwf8jvLZAK4sEbZlJAOpe2+8X7tawR9FE3w3t
         Fx8By7Do41Q7ivBEJyv14KM0NGW8JiAsI9BoLesAqPTXFKekzy8/adibFGyYCFQ0+O
         91W/yIQtw8rQYaTTpDthezXC8U85kYPKqQZWrrzVpYKsqDzFXMVZFa0UyzeU3DvANh
         biTiuQobpDUikvi+0g0mkmzdGUKhS0iOvI+PPt60S4zARySs527XoZxEbnUm1rwFMA
         ktvXBKHgmFRLVVPfit06xx9sbCFrasC0L3C4jhMD/lFoNVmnID5AMZrmb4lYbPuv6m
         K/cM4AGiSe2/w==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 09 Dec 2023 01:02:59 +0000
Subject: [PATCH 13/13] arm64/sysreg: Add new system registers for GCS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-b4-arm64-sysreg-additions-v1-13-45284e538474@kernel.org>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1873; i=broonie@kernel.org;
 h=from:subject:message-id; bh=y25TspdV+qLqbmcbn1y+RPSd8+STa8gj+7s0nXWIqSo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlc7zdabWpx1jnlabpkPLThggY6InxyhArse4xX
 CoVcO8hAVuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXO83QAKCRAk1otyXVSH
 0F8rB/9liwVA5gLZFJMc/Pj5zn/eUrlxzYir/9V1OzmeD+iGbXqVVoHRwumIk/n2SpZFcwzW0U/
 lmAkZHyueHOR27e4V0ODIu1QuVmYzIPI9nFXXwGuVyUJ6G+niO98MR9Vgv5KH5hw/bWRYnqMeDf
 u0jdWa7TTFrIfsXYfb4EFgaYIq1zDjdGfO2XfTC8vgijdNGHOT80Bh6HkxqUx6NEqZc+3DWW15R
 fsCPxt15dzszEX+kmyr0Tuem2aPA0ia4S8e09J7GgV/Kdr5/LNoKSTIhw9eRANHewSSnfLhusBx
 k9WALFF83AwpIYsDB2pajOi0osFbAknjtGKTlH/MR0F4EXEs
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FEAT_GCS introduces a number of new system registers. Add the registers
available up to EL2 to sysreg as per DDI0601 2022-12.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 1c6d1c904750..b2007963523e 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1903,6 +1903,41 @@ Sysreg	SMCR_EL1	3	0	1	2	6
 Fields	SMCR_ELx
 EndSysreg
 
+SysregFields	GCSCR_ELx
+Res0	63:10
+Field	9	STREn
+Field	8	PUSHMEn
+Res0	7
+Field	6	EXLOCKEN
+Field	5	RVCHKEN
+Res0	4:1
+Field	0	PCRSEL
+EndSysregFields
+
+Sysreg	GCSCR_EL1	3	0	2	5	0
+Fields	GCSCR_ELx
+EndSysreg
+
+SysregFields	GCSPR_ELx
+Field	63:3	PTR
+Res0	2:0
+EndSysregFields
+
+Sysreg	GCSPR_EL1	3	0	2	5	1
+Fields	GCSPR_ELx
+EndSysreg
+
+Sysreg	GCSCRE0_EL1	3	0	2	5	2
+Res0	63:11
+Field	10	nTR
+Field	9	STREn
+Field	8	PUSHMEn
+Res0	7:6
+Field	5	RVCHKEN
+Res0	4:1
+Field	0	PCRSEL
+EndSysreg
+
 Sysreg	ALLINT	3	0	4	3	0
 Res0	63:14
 Field	13	ALLINT
@@ -2133,6 +2168,10 @@ Field	4	DZP
 Field	3:0	BS
 EndSysreg
 
+Sysreg	GCSPR_EL0	3	3	2	5	1
+Fields	GCSPR_ELx
+EndSysreg
+
 Sysreg	SVCR	3	3	4	2	2
 Res0	63:2
 Field	1	ZA
@@ -2531,6 +2570,14 @@ Sysreg	SMCR_EL2	3	4	1	2	6
 Fields	SMCR_ELx
 EndSysreg
 
+Sysreg	GCSCR_EL2	3	4	2	5	0
+Fields	GCSCR_ELx
+EndSysreg
+
+Sysreg	GCSPR_EL2	3	4	2	5	1
+Fields	GCSPR_ELx
+EndSysreg
+
 Sysreg	DACR32_EL2	3	4	3	0	0
 Res0	63:32
 Field	31:30	D15
@@ -2590,6 +2637,14 @@ Sysreg	SMCR_EL12	3	5	1	2	6
 Fields	SMCR_ELx
 EndSysreg
 
+Sysreg	GCSCR_EL12	3	5	2	5	0
+Fields	GCSCR_ELx
+EndSysreg
+
+Sysreg	GCSPR_EL12	3	5	2	5	1
+Fields	GCSPR_ELx
+EndSysreg
+
 Sysreg	FAR_EL12	3	5	6	0	0
 Field	63:0	ADDR
 EndSysreg

-- 
2.39.2

