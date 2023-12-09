Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD8180B12C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574914AbjLIBD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLIBDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E021720
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:03:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01446C433C7;
        Sat,  9 Dec 2023 01:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702083809;
        bh=BErQWrldxeV1sBUXqZHMHhJA9PvNZRymEwCy4RD9z34=;
        h=From:Subject:Date:To:Cc:From;
        b=aO5UiJuurBAks19I70iYXp0RzPsBpyzX48BRLht8RH3ErRpd+l1rhyb/lP7OrJlNW
         gfpv4lEaoJJI2oKxtmcV6wTId8DW1pC+SF+QYASCX0HdIVwa2TaDo25IRDNgO4l6Cg
         rdCq6kzvl3HV7RBwtMm0owmqVBIPpEVCTyX5dKKhJLF1OX77ZwFds1WnDQX3Lw6KsR
         3xNij9cNZabNvp2RQ2O3orcyeVF/qVXgxcEJ6FCuvwiRmd5SwiXloJjm6RHDe4JmLO
         Q2uewNiDLwmGBOZm4f7CjORau24v7Kr6jNKYoJmed2kk8cHNEsMV2Mc0moPMazpzX2
         /4BF3zgU7e9hw==
From:   broonie@kernel.org
Subject: [PATCH 00/13] arm64/sysreg: System register updates from the
 2023-09 XML release
Date:   Sat, 09 Dec 2023 01:02:46 +0000
Message-Id: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALa8c2UC/x3MPQqAMAxA4atIZgO2FhGvIg61TTWDPyQiinh3i
 +MbvveAkjApdMUDQicrb2sOUxYQZr9OhBxzg61sbWzV4ujQy9I41FuFJvQx8pGRYjCpHp0PMaU
 Wst+FEl//ux/e9wMFiflPawAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2214; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BErQWrldxeV1sBUXqZHMHhJA9PvNZRymEwCy4RD9z34=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlc7zUxT/y0DncibSyBkBu1ee5A0wlRm3vmW324
 bj6oXwH2sWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXO81AAKCRAk1otyXVSH
 0JenB/wMqKbDToJqe2IJkggTQM3KjFHW29AfV1lvJhL5PEE4KyuXenFFg23mDV61ywGraW2OK5k
 1TN6/KAM+6T1Dey0rFNeJaVGh5HKcNmJyrXfPwwpCWt/KCLr9n6G/0/I9AES3K0GAXowc9CqvtX
 fl/qf5wIdqXQFEreX465jmrXGvx48RBUOQ+P3opWiF9mCZj3B5SoN4FN7bmiOJSiQgvwZ5waK3g
 g/JCTJgw49ZhCG1Jm0co2Cxd3sX6N22O3xBxuIIV5VpvBXiwJEDuweMVvQsHbG/T6YjBvf1c4jC
 qf+6F3ce01dAFqnu9fpVkW/fi9wPyskOeOkJKckuJCwNxr2J
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

A number of serieses on the list have updates updates and additions to
the system registers, and as a result of the work being done on KVM
(especially nested virtualisation) there are overlaps and duplication of
work between people unaware of other pending serieses.  This series
collects together all the work that's been done on updating the system
register definitions that don't have pending review issues which I'm
aware of with the aim of at least making it easier to find things.

Since the system register definitions are part of the architecture
they're unlikely to change based on review of the serieses that they are
included in so it seems like it might make life easier to merge these
updates even without their users.  There is a small amount of overhead
from the increased size of the source and generated files but on the
other hand it would reduce the size of the serieses while they are in
review and make it less likely that we get duplicated work.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Fuad Tabba (2):
      arm64/sysreg: Update HFGITR_EL2 definiton to DDI0601 2023-09
      arm64/sysreg: Add definition for HAFGRTR_EL2

Joey Gouly (2):
      arm64/sysreg: add system register POR_EL{0,1}
      arm64/sysreg: update CPACR_EL1 register

Mark Brown (9):
      arm64/sysreg: Add definition for ID_AA64PFR2_EL1
      arm64/sysreg: Update ID_AA64ISAR2_EL1 defintion for DDI0601 2023-09
      arm64/sysreg: Add definition for ID_AA64ISAR3_EL1
      arm64/sysreg: Add definition for ID_AA64FPFR0_EL1
      arm64/sysreg: Update ID_AA64SMFR0_EL1 definition for DDI0601 2023-09
      arm64/sysreg: Update SCTLR_EL1 for DDI0601 2023-09
      arm64/sysreg: Update HCRX_EL2 definition for DDI0601 2023-09
      arm64/sysreg: Add definition for FPMR
      arm64/sysreg: Add new system registers for GCS

 arch/arm64/include/asm/sysreg.h |  13 ++
 arch/arm64/tools/sysreg         | 270 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 273 insertions(+), 10 deletions(-)
---
base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
change-id: 20231208-b4-arm64-sysreg-additions-c1f3b4acdff8

Best regards,
-- 
Mark Brown <broonie@kernel.org>

