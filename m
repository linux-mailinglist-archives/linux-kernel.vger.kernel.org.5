Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF29A805C35
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbjLEQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345240AbjLEQvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:51:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5185CD45
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:51:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3837CC433C7;
        Tue,  5 Dec 2023 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795088;
        bh=W6NILgEt2d5dF4rtCICDrMO+KDYmPRbi2cIO83aqtdM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=U/yjq/Q4n+Uy944C3SvVJetHRPEuJ4H2z+ODEZlbSFsI1T9ebnE0KvOD1DlOvxy8E
         r52IGobAKYvYZlraf01qpIcYMXoqFu8Sta1YqHSaSx0xOY4LVjD/g9RrBtp83mROQY
         wr2RxD7boL+tuCSXsa4QqbXxIUT7GvsoNV6RpkEpm7VBp7xnJUnYYhWASFt1qiBl15
         GAA9+tl3gv0AUVnkn7d/SwSH7UHXsfHamezG+6DnvH2MEf9Yn8WcUDDTi98KmHelvg
         WTppYrguRSTJ26nysMCBbspcHQSJlYDKofHWfuKvoY61Ln6k0r0XMhhmA6RBvAB33F
         gaWvkONXmb+ng==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 05 Dec 2023 16:48:03 +0000
Subject: [PATCH v3 05/21] arm64/sysreg: Update ID_AA64SMFR0_EL1 definition
 for DDI0601 2023-09
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-5-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275; i=broonie@kernel.org;
 h=from:subject:message-id; bh=W6NILgEt2d5dF4rtCICDrMO+KDYmPRbi2cIO83aqtdM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1TsKq7swo01ZkVFa/VQHZoThC+z4Y4fL2g29UXE
 dzJ0FXCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U7AAKCRAk1otyXVSH0AaVB/
 9lKtnavJF8ZGIV9aySxHECd6VY9AT0MZTZmplzW2effo/DO6sujl1Rjnx+Wr0Osariqu6lrr2gcnxf
 J7/osAEMjuaruInbAdqxq1pGvp1Ps79xHqDy/Qo96j8ii08IDnqToevRZijxjVOL+Dm9goH49P6D+h
 ei4VEQM6LYv8V/X6vjjkznyV9HkQsdJOkXpNZ9tErRL7RgQxjXBwI6R0KVU6tgyGz7f9Hbw18KXoZ+
 GLLlbKUL6jJkLeJxs1VH3NnIHhQclXzeeekQgrsciLp3NENCaaZYI6OV3tcNBW9JGVe0tQSny8HUNh
 GOD+ZemjKdK54revv7GaXT3QnoItUj
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

