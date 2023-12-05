Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DE7805B6C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345186AbjLEQvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345167AbjLEQvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:51:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EFB1A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:51:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E47C433C9;
        Tue,  5 Dec 2023 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795084;
        bh=9pvl6RJ+p+9jph69b/rCGpkJ7MZ4wRu40V+N9vMPcAQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bCUlN2GGTua9qa72K1mtSyuE7ZxTuyttlLdzKH1zl9Rymz3dWDBuTUp7ApDepZ+me
         roMx7SK8lar/aOevnm/yGo/6Be//C1zF2+u769o4LXiFlu82n1VtUdfDtF8eT4QUFh
         wpbGKx0N77O1B5U6GOXHTM0WxLaBXFkOfOoop2DeR7FC+kGmTDM3OcR8iCFNdnyg64
         27aHK/MNUqUOqVchtSwUofVzTjrk2vS/0CzmtLYwPO+fpXZTmOSbsNsEdaA8rjktit
         HOcFUptOyyvHyP10xqnKH6jVsvzwsNMH6zLWlDxyIV+zR1okBoKMH92DBIsLRWks5X
         QVEwIH3ZWvvPA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 05 Dec 2023 16:48:02 +0000
Subject: [PATCH v3 04/21] arm64/sysreg: Add definition for ID_AA64FPFR0_EL1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-4-dbcbcd867a7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9pvl6RJ+p+9jph69b/rCGpkJ7MZ4wRu40V+N9vMPcAQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1TrvV5rna06zZ0R7YS6xNCHxITzVj9D3u4v8uxw
 d/s1LPyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U6wAKCRAk1otyXVSH0FjaB/
 9O3byCSaZGu13WSmusqy9kOLd6fiiqn7ht96D8PImcQm4yUHZvffiH6ZcgmtXsHWq9jE04wp4qPU+q
 38Z5A5BicCc0ouXQB2K7FuDnSsxlFjqxihj/3b7n/0fKmWVeQysU+/lFsPLwE/dt8ra8ezT4RIIRow
 DKy8RHIyEK+GzD46WKMX8epElIZLBydL7JFuQhvUYerjq+irrLMFLtYQ/Xxfu83bTLmIt8Nt2gq3Vo
 /K4InVaS7j9OXuG0p9tyTK5itak7khvpe8Eg1BWzLEudnK6nJ6M8297KVDdqfn1ovmKV6vFVVLqOdM
 TL9FIhBJOOjRDqFLxgGfPYmW2qLy0m
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
index 3d623a04934c..c9bb49d0ea03 100644
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
2.30.2

