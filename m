Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B054680B134
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574981AbjLIBEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574983AbjLIBDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F203919A8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:03:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015B8C433C7;
        Sat,  9 Dec 2023 01:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702083827;
        bh=SXOzPYewMehp5kLzJ8toIJZX15vIOKRG/jjVAEJaZs4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=syQZMI6LUK3gJjpRTQTUebmQ+0+uZ7NNJiej0he9e9bEXJFl6Z5VB9Bb/uKaRLlmy
         O4IXiPRWhMc8gW1BX6zeQN6zqqu+KsLKjycQN3G1cOif5H/mqjnN6+NuOa6c9ZmT07
         7TqGgrQ2F7goNjUWuCoMqLn7frdinx6LUrmZ91qBJACrrd+Dt5wCMg6V7ZvZOPJozV
         4dTJ+GOENUWGW9PycrhmtWNsiqQ0PK/TiQNfDlitILGeJL4SsDJ1BW22Txy2EPkxxQ
         pPYSoZfKGdQgJjqJjVTd1RjRklbb/egY7xJ1TOx1hbavwHGP/3u0aPjyrGdOajKwpP
         PdvGNc52QF52g==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 09 Dec 2023 01:02:55 +0000
Subject: [PATCH 09/13] arm64/sysreg: Update ID_AA64SMFR0_EL1 definition for
 DDI0601 2023-09
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-b4-arm64-sysreg-additions-v1-9-45284e538474@kernel.org>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SXOzPYewMehp5kLzJ8toIJZX15vIOKRG/jjVAEJaZs4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlc7za4N6KNMtWb1LiLfL4tUOatq5NO7Rv2l019
 oe8eE2fTSCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXO82gAKCRAk1otyXVSH
 0K2JB/9V4ZXra3T08GKGegPlNsLc9AvTK5K7Q3D9ZJ+ow9T0RQa0EZtOprbQmj143hkxRVkpmRS
 RViyL70cGUIeIZ+7HjNmzDrR60Bii2WsTH3cRHzxBgJi871NAPkniqQxLpWB7koRlTCn+qUIGkW
 FFeYFM1RjlW2x4b2D6v2m4LlUv1UCIhAvHV+17WHuuKIwrC271/2vqTSJjsSlrZW3KwZS6iyid9
 4ydkokHc7CNYPtb4Ji0TB2Nfes3Z+wm1HxR8DCINs0335TPE3w7Og8uOFNpVmz8HxXWWfxpVu07
 ugiwmIzYRPrs+jZm0DcCw1Y4ckc6317CHEkHnTcdi56TpW2r
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

The 2023-09 release of DDI0601 defines a number of new feature enumeration
fields in ID_AA64SMFR0_EL1. Add these fields.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 68236cf1abda..839f7cca53e0 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1079,7 +1079,11 @@ UnsignedEnum	63	FA64
 	0b0	NI
 	0b1	IMP
 EndEnum
-Res0	62:60
+Res0	62:61
+UnsignedEnum	60	LUTv2
+	0b0	NI
+	0b1	IMP
+EndEnum
 UnsignedEnum	59:56	SMEver
 	0b0000	SME
 	0b0001	SME2
@@ -1107,7 +1111,14 @@ UnsignedEnum	42	F16F16
 	0b0	NI
 	0b1	IMP
 EndEnum
-Res0	41:40
+UnsignedEnum	41	F8F16
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	40	F8F32
+	0b0	NI
+	0b1	IMP
+EndEnum
 UnsignedEnum	39:36	I8I32
 	0b0000	NI
 	0b1111	IMP
@@ -1128,7 +1139,20 @@ UnsignedEnum	32	F32F32
 	0b0	NI
 	0b1	IMP
 EndEnum
-Res0	31:0
+Res0	31
+UnsignedEnum	30	SF8FMA
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	29	SF8DP4
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	28	SF8DP2
+	0b0	NI
+	0b1	IMP
+EndEnum
+Res0	27:0
 EndSysreg
 
 Sysreg	ID_AA64FPFR0_EL1	3	0	0	4	7

-- 
2.39.2

