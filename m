Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4983380B12E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574926AbjLIBDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574927AbjLIBD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A144172A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:03:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28F3C433C7;
        Sat,  9 Dec 2023 01:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702083813;
        bh=SMs9DURrlwQv5gPyahEkDLCmi0S2kSbgn0z5hciRS6A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CUupU+tUfH4WTWBCaws7pxl6xAzlGsL9CN7Jag/ZYH1YIjz8eV9gyv4KFMtCkRhDS
         5r8J1p1an/P1BOvVGk4Plxt/wuFG+fi69RQQ1GtkHteNoWtblU151LnzRv8Z2AKH8L
         5XVuXHvhRoRCSwGRk6ENCf78FDQl62Su2Drgob/9ffySBMxcoDIS4emekKGBz/g0Gd
         IJNpTcl7DiJunF7wl8so+ACuL9JodkFviQyHbHbPm7wyjFJqND2RXcrTN7DES6Mdjx
         njJ1eIxySaL9avIX0WSp0NRjcAS2mrhRroqzOaXdRxcYvs/4qIkUQnW1B+40OUyiEL
         Y/FcJ32j93f7Q==
From:   broonie@kernel.org
Date:   Sat, 09 Dec 2023 01:02:48 +0000
Subject: [PATCH 02/13] arm64/sysreg: Add definition for HAFGRTR_EL2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-b4-arm64-sysreg-additions-v1-2-45284e538474@kernel.org>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1942; i=broonie@kernel.org;
 h=from:subject:message-id; bh=03a8bhxsStAaFvzqNA01b3Zl+lnIoFTnWmbrFIb9KiY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlc7zVoi2/ttIEijQ4PezqkqLzao1A7yQ0CEfiU
 rIufd76xGeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXO81QAKCRAk1otyXVSH
 0E0AB/46lUBpmgt2XcdczfVgY/JKEzJOp/LDapnIQbATmcM49PGlkPdZTupBfNEDB+v2zvAAWvi
 ga7KHeRSTnUUJv/4+o7nWNSFfHKAqaIioIsnroXxCg4Ryl2dAfhq6qkMkXvN99A2mVtgur/VjNM
 OK+nzu720iRnbZYWi+iMBTZ3KMSZz/rBv36KS4jl5ksR/+8aZbfgcVMePYlfWEE56LJlkA3zvlh
 4A0ttMEnXFmQMsXjD7WZU0TWHbr8BObrDHmdfUtiFDKOjBVMfJthRcSccbOb8u2TK8wLf4UigLR
 moKZAoqxPmH2jezN5x5sHGYIzgDZopMb5WYcbypXAauIO9GZ
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

Add a definition of HAFGRTR_EL2 (fine grained trap control for the AMU) as
per DDI0601 2023-09.

This was extracted from Fuad Tabba's patch "KVM: arm64: Handle
HAFGRTR_EL2 trapping in nested virt".

Signed-off-by: Fuad Tabba <tabba@google.com>
Link: https://lore.kernel.org/r/20231206100503.564090-6-tabba@google.com
[Extract sysreg update and rewrite commit message -- broonie]
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8faeab1ee024..145b33f75a96 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2297,6 +2297,49 @@ Field	1	DBGBVRn_EL1
 Field	0	DBGBCRn_EL1
 EndSysreg
 
+Sysreg HAFGRTR_EL2	3	4	3	1	6
+Res0	63:50
+Field	49	AMEVTYPER115_EL0
+Field	48	AMEVCNTR115_EL0
+Field	47	AMEVTYPER114_EL0
+Field	46	AMEVCNTR114_EL0
+Field	45	AMEVTYPER113_EL0
+Field	44	AMEVCNTR113_EL0
+Field	43	AMEVTYPER112_EL0
+Field	42	AMEVCNTR112_EL0
+Field	41	AMEVTYPER111_EL0
+Field	40	AMEVCNTR111_EL0
+Field	39	AMEVTYPER110_EL0
+Field	38	AMEVCNTR110_EL0
+Field	37	AMEVTYPER19_EL0
+Field	36	AMEVCNTR19_EL0
+Field	35	AMEVTYPER18_EL0
+Field	34	AMEVCNTR18_EL0
+Field	33	AMEVTYPER17_EL0
+Field	32	AMEVCNTR17_EL0
+Field	31	AMEVTYPER16_EL0
+Field	30	AMEVCNTR16_EL0
+Field	29	AMEVTYPER15_EL0
+Field	28	AMEVCNTR15_EL0
+Field	27	AMEVTYPER14_EL0
+Field	26	AMEVCNTR14_EL0
+Field	25	AMEVTYPER13_EL0
+Field	24	AMEVCNTR13_EL0
+Field	23	AMEVTYPER12_EL0
+Field	22	AMEVCNTR12_EL0
+Field	21	AMEVTYPER11_EL0
+Field	20	AMEVCNTR11_EL0
+Field	19	AMEVTYPER10_EL0
+Field	18	AMEVCNTR10_EL0
+Field	17	AMCNTEN1
+Res0	16:5
+Field	4	AMEVCNTR03_EL0
+Field	3	AMEVCNTR02_EL0
+Field	2	AMEVCNTR01_EL0
+Field	1	AMEVCNTR00_EL0
+Field	0	AMCNTEN0
+EndSysreg
+
 Sysreg	ZCR_EL2	3	4	1	2	0
 Fields	ZCR_ELx
 EndSysreg

-- 
2.39.2

