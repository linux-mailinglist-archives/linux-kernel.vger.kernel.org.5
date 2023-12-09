Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB1B80B130
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574958AbjLIBDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574923AbjLIBDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13A4199A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:03:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F2EC433C8;
        Sat,  9 Dec 2023 01:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702083819;
        bh=+CrA8GLdeby5fZNZUG7C4JaZX+guEFM149i9ekNOlnI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lAG75vcLxgN9VsUVk4io08i19CMDxPWO1NVN7wZMUTsDxVPHhWKNQn+aZ/rl1KQlJ
         DtfbyhzlW75jon/YeoJbejCFTXe5j0nj0ydaIlhB/AT6ZN42NQ8f1kswvx3Nr7mlI2
         lTo9WjqfYHwcWtumEiS9jk65XBVJROW5BXcr2Zt/ncJnnBAaHpHIF6Td0UG67wIiuz
         tCTxAL/EjDgREFz+eM4k4etPKLkxvM6wsEm/tp+jM3Ax2UFTqKeK4Fjl7skFyrzf8m
         S3yq92lOZ2DjmT47auQVo/fehq0tHi6NBNKXi/1OSaTrB9vxW6sWpMfBWJgRTdC00h
         8Va0/yinbPLcQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 09 Dec 2023 01:02:51 +0000
Subject: [PATCH 05/13] arm64/sysreg: Add definition for ID_AA64PFR2_EL1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-b4-arm64-sysreg-additions-v1-5-45284e538474@kernel.org>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+CrA8GLdeby5fZNZUG7C4JaZX+guEFM149i9ekNOlnI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlc7zXDeyEmTmXDOpwophFnrgssK7NnOROK6Iga
 JjznT/NUKSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXO81wAKCRAk1otyXVSH
 0DGHB/9E/0k2imvd9dGlfFXBTu01xQ4nwySf94gbcS2IXnegOjCHn7yyfcdburotElZeXJa+Fvk
 aoHudV6cjRupdrzOOOjDeMRI00sTbmBy1Urk2z8oLiVJA490VuVVqydFZFcgZ/A24vxWj1MUjMM
 4gtEeYmWc1jINUplTDl+jYPlYZRt4t8lpVmXtSRFt342EThp4xe13Wxn0TEx7WqutR06yjH6K9r
 QbUDVqKdUKx75toiL0w+qE0/5No9Fdv+qoDJ5JKMOvMI3VNhs+b/I7kUwkW5xHwOVl0IeHTb6PE
 qRDPliYWNgoojdTabxfC2G8RnOh26VpxBdKpzwgwcU+cGYe0
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

DDI0601 2023-09 defines a new system register ID_AA64PFR2_EL1 which
enumerates FPMR and some new MTE features. Add a definition of this
register.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index c2dbbaa22620..c48a3b8d00ad 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1002,6 +1002,27 @@ UnsignedEnum	3:0	BT
 EndEnum
 EndSysreg
 
+Sysreg	ID_AA64PFR2_EL1	3	0	0	4	2
+Res0	63:36
+UnsignedEnum	35:32	FPMR
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+Res0	31:12
+UnsignedEnum	11:8	MTEFAR
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	7:4	MTESTOREONLY
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	3:0	MTEPERM
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+EndSysreg
+
 Sysreg	ID_AA64ZFR0_EL1	3	0	0	4	4
 Res0	63:60
 UnsignedEnum	59:56	F64MM

-- 
2.39.2

