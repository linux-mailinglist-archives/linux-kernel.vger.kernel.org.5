Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083B07A0145
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbjINKJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbjINKJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:09:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DDF1BE5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:09:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A462CC433C8;
        Thu, 14 Sep 2023 10:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694686187;
        bh=M/UStgUGbH8CuX1BJTYF0ZWJ/du0vQ5shdk+mEey+/U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=WbWYAh87UgoKpI5+C5LpRlJlb0/IgTke5H+d50ANDjuDv5kKwkSQ4ErBmuQm0f05I
         cfygEiD0TWtTxHV15xvJJzrSsOTC6a+957f8/z0eKSlJuJVyKr5Ttq4jgtXUO4xqlx
         hamvSeqKplNoZz+3S3V47XKg36siWszxNVGiOjQnX6j3tJRwTVpMqWXQzQhBNMX5+H
         K4lQRce3gVWrranATOmHxyUMmcglwW5nk/+MN3bazD2OxeYu/gP4v+SxXFzLwhVgTM
         6kMJ8S8qWlzlMU2J5rSfLraEogeDIobNAYyVGtESY4z2w5bMIPipX4jwZnSmNwTgy2
         T9VduW5a4E/gw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 14 Sep 2023 11:09:29 +0100
Subject: [PATCH 1/2] arm64/hbc: Document HWCAP2_HBC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-arm64-feat-hbc-doc-v1-1-797d25f06897@kernel.org>
References: <20230914-arm64-feat-hbc-doc-v1-0-797d25f06897@kernel.org>
In-Reply-To: <20230914-arm64-feat-hbc-doc-v1-0-797d25f06897@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=762; i=broonie@kernel.org;
 h=from:subject:message-id; bh=M/UStgUGbH8CuX1BJTYF0ZWJ/du0vQ5shdk+mEey+/U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlAtvnOXvSBQHWoqKFjEXKFE6IWq/dRWg/KyX8JbhP
 maa6Y8yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZQLb5wAKCRAk1otyXVSH0OmPB/
 wPf2HxezQHHZecUw5wx04ZrPkkcE6JRgOQJXSXmHecA3Yu8MOkG9BqTExKR6KZ4y5Jv4YuEs+zvpWt
 cLreomVmVIa0dktOAq8cVs8jBX4TmEClgN4tDDqgTKtMVzML22EXaZBfv9uy6Zs9ChMpi9mh15GCH6
 +0/EPEV3Hen/KkAH/V9wYldrPAcAGYS0Dcb3VPfiG4iqUW08nx6a8DCefuC0P1P27uzNvKFMIiLRoQ
 aN4ThRxt/BNnBfH8s90nODWUrFwNZ2djvn83v8g01DlLxBLUKoxsxGYPYB/8UVIjLxMUwOA7nvs2sl
 MIm1L85YdNm+sk7tOSjDq1Qeu0L9AF
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we added support for FEAT_HBC we added a new hwcap but did not
document that we had done so, add the documentation.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/elf_hwcaps.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index 8c8addb4194c..76ff9d7398fd 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -305,6 +305,9 @@ HWCAP2_SMEF16F16
 HWCAP2_MOPS
     Functionality implied by ID_AA64ISAR2_EL1.MOPS == 0b0001.
 
+HWCAP2_HBC
+    Functionality implied by ID_AA64ISAR2_EL1.BC == 0b0001.
+
 4. Unused AT_HWCAP bits
 -----------------------
 

-- 
2.30.2

