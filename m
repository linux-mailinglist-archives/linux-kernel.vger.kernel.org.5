Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B95780B133
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574937AbjLIBEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574944AbjLIBDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4F0173F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:03:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD978C433C7;
        Sat,  9 Dec 2023 01:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702083823;
        bh=QTngaX2hHTEVCSFJdBGb/xbuq6b7ERo+ziUU7N9Rwx4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=sgabQXI1vu0IXkQjuXYw7NZm4x26ewNdOu9Qx6PMwCFQpRx2/adVVeRTVHonlfLFr
         iJZAW6BYrK3j7WEmG/SWynnnjlih04hdWG31PDeYbTiTaMGxKow/5tw6Xh4semeDDk
         NqlEcqC7YVky2zgvbGwTkS+2K4NnywOfulylf2OoZC4KF1021VfcCBtYmxF4g//7M2
         o61izJ5zcoKXGAH/3nj2iz5dqfn6GQNA/tNmXxIDwn5d+wUKwwQZG4goIiRzJusfTd
         ddHrlyeJkjwxl2sTIg0Ee+WninBYedUDfsk6I8Qevv1GPw+UfCr477PMvDNSjJy465
         hnhUBRQk5420A==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 09 Dec 2023 01:02:53 +0000
Subject: [PATCH 07/13] arm64/sysreg: Add definition for ID_AA64ISAR3_EL1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-b4-arm64-sysreg-additions-v1-7-45284e538474@kernel.org>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QTngaX2hHTEVCSFJdBGb/xbuq6b7ERo+ziUU7N9Rwx4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlc7zZkOtojDJemv6o40LA6AkjZXKHc39dpd6Gb
 TrthRsrc0aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXO82QAKCRAk1otyXVSH
 0Ef8B/9+uJyaYAqoPACGPdHfuVJXDvK0DaMAvEIp7k+4rkTbNfUAstxdQ/B86gk6yay5sabbHyc
 7/lJDcugwSlqymXDhG7YLCzPKAmfxozLo3F1KrvLzATcZGbAj5HFCix6HoLkBqa2BR35xBChj/G
 FY3bpj58klSO2bGkARKuMgD4s4DZ21hIzhe3V7VfbMwYfFbGCh+KQzGIxL/aHLVCERReT2ai0fo
 Z1dK4qi7cuAxLJeWUoEqNdz7cqMLj0GzrlPQ5L1wQOCrshODShOHextKhJh6q2qhf7yJZVFmbvd
 68EkesXJh5M0E1OekZ+jPxzrQ26KtlXDIZdPUTjTkQWMADGo
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

DDI0601 2023-09 adds a new system register ID_AA64ISAR3_EL1 enumerating
new floating point and TLB invalidation features. Add a defintion for it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 3f382f8d0f4a..d1bb6ebcd959 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1433,6 +1433,23 @@ UnsignedEnum	3:0	WFxT
 EndEnum
 EndSysreg
 
+Sysreg	ID_AA64ISAR3_EL1	3	0	0	6	3
+Res0	63:12
+UnsignedEnum	11:8	TLBIW
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	7:4	FAMINMAX
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	3:0	CPA
+	0b0000	NI
+	0b0001	IMP
+	0b0010	CPA2
+EndEnum
+EndSysreg
+
 Sysreg	ID_AA64MMFR0_EL1	3	0	0	7	0
 UnsignedEnum	63:60	ECV
 	0b0000	NI

-- 
2.39.2

