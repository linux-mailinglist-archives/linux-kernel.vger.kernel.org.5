Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049667EB23D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjKNOf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjKNOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:35:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB14D56
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:35:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187CFC433CD;
        Tue, 14 Nov 2023 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699972539;
        bh=W6NILgEt2d5dF4rtCICDrMO+KDYmPRbi2cIO83aqtdM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PnSStsPA2cgYrHi5FDsSH3S/3kGThJYhLVmpsngs3QYTxoITH/VpGSrTqbT3J422j
         h7k9W390Tcn5dTFar3Qc7SCDSLtggHuivb9tjLyI8BD8AdeSACjKEpKyv4hak4SREA
         cY8JmL1/xDU8uoIY1BaozTDj87focnidxQu+yUNG2jXbAOn7l1pCBzXdsYazKCARdO
         3hnun6V+sR+Zk74uCy77rhPHK2aaW0NW02wsxtg/T8kzt/FpsnVAZFDlzzZL+6Eb5Q
         JxVpoolHbjnx++pG9Om2QzqdUchzjLY3Y2H9nIIbub0PC0aYE+fi4XwA+Kkk+ONwfq
         jSPtmjbO1N3Cg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 14 Nov 2023 14:34:50 +0000
Subject: [PATCH v2 05/21] arm64/sysreg: Update ID_AA64SMFR0_EL1 definition
 for DDI0601 2023-09
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-5-47251894f6a8@kernel.org>
References: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
In-Reply-To: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275; i=broonie@kernel.org;
 h=from:subject:message-id; bh=W6NILgEt2d5dF4rtCICDrMO+KDYmPRbi2cIO83aqtdM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WY4LJ3zW0Njv0NlTJy7v8HYTzo6HIUyrg3DyeQ
 +CAvzPiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFmAAKCRAk1otyXVSH0FIVB/
 9BIqFDzBtxuWhtbQOuFi6+eNGWMJx4iMowyvGz63y8VgUS9cZeux0IVqrLoDcwMbrm+1DwQAdfacr6
 789/QCJQanP9LK/vkGPuFI402nyKT4M2KuDn5a3uGINMNOx0RAWSzlPZClTPhF7khd5kNjEtCwLfrV
 TmJY7+Ws21dMvU06SO5WEThROgwMkxm5wikcV2ZftSfDGMCe81g5hfHcxPfpFPdhu02DnESnta7GpX
 2kD/rvYklk/0x3fzupXEzIxqbyd+J6tlub1BZoPcRPzW1AFJRtJjuIbAhaoXT6cVm06QfmreQjqnOm
 lFO9XIGGDykqZhFjgkM3hRal3cBxpG
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
index c9bb49d0ea03..aee9ab4087c1 100644
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
2.30.2

