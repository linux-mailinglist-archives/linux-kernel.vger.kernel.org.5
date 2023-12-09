Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122F380B135
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574966AbjLIBED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574972AbjLIBDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0BE199A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:03:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CE4C433CC;
        Sat,  9 Dec 2023 01:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702083825;
        bh=Y5SerbhVojl5VXMjEVGY1+9njK/+3OPBXOKJhGec7oQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cDwbLBKsKApO60iwy0m56XY9K72wcH2aHGSAcMwXqpUh7fxk3vADP6ojZgN0f1Qin
         ILBTcmj+rI5R+s7P72VRUTESgCwYeV0/wZIoO+xvvZ3eDP6ekXWR/10+EveeX6G6Uw
         PQLJXXeUqOiCJEj2dY3g8aJ3zBMuMvCj6ZRoZ8p6Yo5uzWlbeushswLNKvh5nBCy72
         vK1i8tiwkqz+eYhAecSV7e9jwELaCgpkU7Fn6DxhTzs93HnxAQLsxv9YT5Yi1Cky+F
         8+1+x90F3XENa8m5LHU97MN0v19kId8m7/cfEJLYIru4i6f7S7Oq2h0XbP0HAUS7xE
         FW9TdhB0jaBag==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 09 Dec 2023 01:02:54 +0000
Subject: [PATCH 08/13] arm64/sysreg: Add definition for ID_AA64FPFR0_EL1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-b4-arm64-sysreg-additions-v1-8-45284e538474@kernel.org>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Y5SerbhVojl5VXMjEVGY1+9njK/+3OPBXOKJhGec7oQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlc7zajbABv+mNMmsOPPDSYis9GUeJl2kvZLwbq
 ulsnAJkSMGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXO82gAKCRAk1otyXVSH
 0B8DB/4hftRVI2sb3KKc+Whqekp19wsxqJaNXe5E/JL9LcvpLuaamNErd/QKziTLaI418oq3Am7
 cMkkIauJhKJHmXBP911/mS/ic3/HfThK8nbpueOxj87zbo4sUNBQDxbJRzb3p+Kqcavc1bg1VqP
 2pIVvHpTvcaA9YPx3mnwi3ve8H8oAn3PiOSE//ngEDncKDp6J+78myjzwaSSufMGFd54H8RahbY
 jsyx/MTybWFYDxpapNJHNDCGsfAxHwL1arz2WNrwRRNDnpWpvGPd267FXG+ZAJDW9L0EJ8uSwxj
 8mzz0/p2LWuJrW82cG/hQXZ4D7j3l9l6jeEyp+xnR8x+/tYR
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

DDI0601 2023-09 defines a new feature register ID_AA64FPFR0_EL1 which
enumerates a number of FP8 related features. Add a definition for it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index d1bb6ebcd959..68236cf1abda 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1131,6 +1131,35 @@ EndEnum
 Res0	31:0
 EndSysreg
 
+Sysreg	ID_AA64FPFR0_EL1	3	0	0	4	7
+Res0	63:32
+UnsignedEnum	31	F8CVT
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	30	F8FMA
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	29	F8DP4
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	28	F8DP2
+	0b0	NI
+	0b1	IMP
+EndEnum
+Res0	27:2
+UnsignedEnum	1	F8E4M3
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	0	F8E5M2
+	0b0	NI
+	0b1	IMP
+EndEnum
+EndSysreg
+
 Sysreg	ID_AA64DFR0_EL1	3	0	0	5	0
 Enum	63:60	HPMN0
 	0b0000	UNPREDICTABLE

-- 
2.39.2

