Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE58D80B132
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574978AbjLIBDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbjLIBDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A2D1710
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:03:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15C0C433CB;
        Sat,  9 Dec 2023 01:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702083821;
        bh=ljVMYGlOEnassD0jpwgx38Ji3kGBKgGn/szIk9T4wCI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fheSCHRjAtetr4iFT0F6x63+789JWVirqFnePtK5C2wTlT0Ow0LVPqWbJeWfUYUBt
         +4EYVN4b5s+2nxl9yorxhWuHzqzbp51FvpvIWs7NyPwxlJx9qWTa2vem19m10M8p9u
         34CVb/PI28UQdqZLn+lva6bvETaYLdvUCEwjkTJr2ruWonP5aCBB7j0pnnmWne1Vmb
         2GFxWXoXOmKykNbOoBo9/5fzB3uyQYaBpgd9j6zM9gQrPxZ15WGWWJ5MD9Ptz1aSlk
         nm4Ao7pLW4A6YT2nR5ur/lfE9jvIelViVfOCl2pzOIhWETZN2RTm+lbIgKXe/DVVDR
         Cpgev2L5arFiQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 09 Dec 2023 01:02:52 +0000
Subject: [PATCH 06/13] arm64/sysreg: Update ID_AA64ISAR2_EL1 defintion for
 DDI0601 2023-09
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-b4-arm64-sysreg-additions-v1-6-45284e538474@kernel.org>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ljVMYGlOEnassD0jpwgx38Ji3kGBKgGn/szIk9T4wCI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlc7zYZKXcBBiljB+++g5TZhgBYYbocTpxuv+rD
 LRY44EaWQqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXO82AAKCRAk1otyXVSH
 0BMHB/9Ass2mKpojppu7EsVYL4f7Cf36ZWAWKvPpQWDb2yH3zta5z1NFzEs0wRGji78baJpS+pQ
 mz5UpVjG6GJOn4gV2aGsRs1SG6H+pc1NlvflrLC+S4eoTzPxTy1Vl2B1TeQ/COmwK9oyQPGSkWS
 53O92weiGw8dhQyN8F7V6MQwfQ5CybwtR+OuZeoyPtV7Vozwm7c7nVQ02zPTATkR4Hpn6K9iSh+
 ooip1YsFE3Oo2GsPsl52DjKv9Idag0j1lzH0lcx109qH8Ha4Gj/s7EPSvfFwljxr3IAGKalmF6P
 w6ocEpDGOtCMGEFq61mK6b+esl67cCCjMvi3W5wf+7e0Vkij
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

DDI0601 2023-09 defines some new fields in previously RES0 space in
ID_AA64ISAR2_EL1, together with one new enum value. Update the system
register definition to reflect this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index c48a3b8d00ad..3f382f8d0f4a 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1365,7 +1365,14 @@ EndEnum
 EndSysreg
 
 Sysreg	ID_AA64ISAR2_EL1	3	0	0	6	2
-Res0	63:56
+UnsignedEnum	63:60	ATS1A
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	59:56	LUT
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	55:52	CSSC
 	0b0000	NI
 	0b0001	IMP
@@ -1374,7 +1381,19 @@ UnsignedEnum	51:48	RPRFM
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	47:32
+Res0	47:44
+UnsignedEnum	43:40	PRFMSLC
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	39:36	SYSINSTR_128
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	35:32	SYSREG_128
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	31:28	CLRBHB
 	0b0000	NI
 	0b0001	IMP
@@ -1398,6 +1417,7 @@ UnsignedEnum	15:12	APA3
 	0b0011	PAuth2
 	0b0100	FPAC
 	0b0101	FPACCOMBINE
+	0b0110	PAUTH_LR
 EndEnum
 UnsignedEnum	11:8	GPA3
 	0b0000	NI

-- 
2.39.2

