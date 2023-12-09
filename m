Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D744C80B12D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjLIBD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjLIBDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8402F1724
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:03:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981AFC433C9;
        Sat,  9 Dec 2023 01:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702083811;
        bh=D0x4eDaFNy9CplC6ugInaO3mzbHR6NewCofpneeFhJM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=DM0hOl9zuGqeqKV1d5nEhT2TpJtrUiWfPX3oq6W0zwBBkyQoMF+FSSTEpmS1cjvIO
         oo2mwqt5oDfYvY5vQ2abMKegVxkUgf/KWQ59cPDWpgNztJAsIBBCCnQOTxK6xzES/G
         aviZRi1WXeAMHyP/UkovRDXlcG531sAePby18lnloEo+p+lFMJathBbbtHlVxwe6Ti
         P0doWMuFUbj5ErlD80BQfO4EesP1AqVthl7qIUKpFqf75S86pSw2xTp0syzHP0TcxK
         RP7Vml6JYAxCLSa1pC6m6iG+dh2nC+bkjBDP+3M8gDLJW+RqU2DVM/D1OgTkYdoHT+
         H9tbmJplUyArA==
From:   broonie@kernel.org
Date:   Sat, 09 Dec 2023 01:02:47 +0000
Subject: [PATCH 01/13] arm64/sysreg: Update HFGITR_EL2 definiton to DDI0601
 2023-09
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-b4-arm64-sysreg-additions-v1-1-45284e538474@kernel.org>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ObpJ/GUYoGCLCd37FqC0lL4xZaGn7vmlaFdliJ688GQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlc7zUB8eIn24i8d97jHyWrQZ1uDGgOoNtWgqWk
 N1B9sNhpCmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXO81AAKCRAk1otyXVSH
 0EsiB/9TCw3QFMLGparJs31LY34X1oA3n1SpQdwgIwlV7DU8OHI4XbmNtXOMnhrBLwxI86f/I01
 VeTKLE7uGokwnJ0a6usdqvT3xJsKwMVNU5sZoIiDcsYTLWFjSuyjRuozoZxIyLXS4crYml14Rzb
 KIUjUeQjozILQdVdenpAwoyqG4nTCNMnW8IpdWojswYhfpHG4cr/uMb8rdrlHR8dglrbCSHRd/I
 3wzuWNy2p+f3jZTORMY3hf3Bjss+iAi6wZ0aN+d9Jyobb1A2tqEbRIQywsCrZX7zu2kpaUhBExm
 1+yJKEKGoBSv+XvyxI9KiUAbIO2REyo+zxZJvkH3UsdaTrP5
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

From: Fuad Tabba <tabba@google.com>

The 2023-09 release of the architecture XML (DDI0601) adds a new field
ATS1E1A to HFGITR_EL2, update our definition of the register to match.

This was extracted from Faud Tabba's patch "KVM: arm64: Add latest
HFGITR_EL2 FGT entries to nested virt"

Signed-off-by: Fuad Tabba <tabba@google.com>
Message-Id: <20231206100503.564090-4-tabba@google.com>
[Extracted the sysreg definition from Faud's original patch and reword
 subject to match -- broonie]
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 96cbeeab4eec..8faeab1ee024 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2102,7 +2102,9 @@ Fields	HFGxTR_EL2
 EndSysreg
 
 Sysreg HFGITR_EL2	3	4	1	1	6
-Res0	63:61
+Res0	63
+Field	62	ATS1E1A
+Res0	61
 Field	60	COSPRCTX
 Field	59	nGCSEPP
 Field	58	nGCSSTR_EL1

-- 
2.39.2

