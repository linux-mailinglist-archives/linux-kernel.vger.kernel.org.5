Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D287A0155
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbjINKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbjINKME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:12:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737461BE8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:12:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B15C433C7;
        Thu, 14 Sep 2023 10:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694686320;
        bh=tg73HwlfXsKZhdh4RL7L2T0Hnl/NRRkP/rTZVsJfwCE=;
        h=From:Date:Subject:To:Cc:From;
        b=PfSt2AWw71pvcWkFbOzfcPyQQe+/SL4Kn7FEoBNBx34jJ8o3Sc1nyGWLlFWoqJvur
         wEuYKG2QYQLZmfwLrt8KCrV01LN8sxzPDt4Qv6/JCmddoSnXoj2yY07GOxaFvION7h
         73VxN4qdwJ7ql7m+JhCC3MkfMg12KPngwKy3OYU7USJkEoPEHP8N81Fpbyoov6hlkK
         Uhsa+Wz3/fY4BBfOIu1dGLQQlbqn7hYr8KCdJkCEOSXzGkRau3g/vg9xgYqpY1Enfk
         ljdRgw02771bIb5mQlBqu1Qh5F3Azle3cYehzx597LdNNwhu9fKVGkcDM5fioNZHpy
         ov7OFSpq8YB2A==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 14 Sep 2023 11:11:31 +0100
Subject: [PATCH] arm64/sme: Include ID_AA64PFR1_EL1.SME in
 cpu-feature-registers.rst
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-arm64-pfr1-sme-doc-v1-1-b6c497d10d77@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFPcAmUC/x3MMQqAMAxA0atIZgOtEUWvIg7VRs1QlRREKL27x
 fEN/yeIrMIRxiqB8iNRrrPA1hWshzt3RvHF0JiGzGAJnYauxXtTizEw+mtFR+R4Md73NEAJb+V
 N3n86zTl/RPiEMGQAAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Maydell <peter.maydell@linaro.org>,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tg73HwlfXsKZhdh4RL7L2T0Hnl/NRRkP/rTZVsJfwCE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlAtxtk1gZpqGv6hl5g0BXkgwnwzJqIRrFwvHhFSyQ
 okEHm0WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZQLcbQAKCRAk1otyXVSH0KP8B/
 9PYd5xB5hGCTeAV4HqaHsqCAtQgkDA5FVh3qlaS/XwOhIMYX3UqSte/tx9PsFfc6YCBRav/mwqoSM+
 9ffk+0L1yCjd9muxUJm9dSB2g2USzu1DoAbtkgVYTfGNwgcseOGJG+9E1NPsc+dm7hjaINmvPCL/4b
 ukg1W+G7MKdhOPOUx3QHvqWUFF7PN8zi9rbWMYREWLaV20bibIyzNwNV/1e9CC7bfoeJLvjPZ3PiK4
 0yHUZR5ZxOmGKqaaxXciyTTqcxyZRYug88/djKSnKS9j9Dp09KdPKMnD31HNAqCLOS4cvParWZ+LQP
 pwzb6r1zbuZt25WFsDUN483WyQ5P41
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We expose ID_AA64PFR1_EL1.SME to userspace but do not document this in
cpu-feature-registers.rst. Add it.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/cpu-feature-registers.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/arch/arm64/cpu-feature-registers.rst b/Documentation/arch/arm64/cpu-feature-registers.rst
index 4e4625f2455f..5e9ef91f5e36 100644
--- a/Documentation/arch/arm64/cpu-feature-registers.rst
+++ b/Documentation/arch/arm64/cpu-feature-registers.rst
@@ -175,6 +175,8 @@ infrastructure:
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
      +------------------------------+---------+---------+
+     | SME                          | [27-24] |    y    |
+     +------------------------------+---------+---------+
      | MTE                          | [11-8]  |    y    |
      +------------------------------+---------+---------+
      | SSBS                         | [7-4]   |    y    |

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230913-arm64-pfr1-sme-doc-a33aeb0dd739

Best regards,
-- 
Mark Brown <broonie@kernel.org>

