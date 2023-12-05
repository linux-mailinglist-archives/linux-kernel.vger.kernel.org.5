Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6385805C23
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbjLEQxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345443AbjLEQwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:52:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE811BF7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:52:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EE4C433CD;
        Tue,  5 Dec 2023 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795138;
        bh=RtrbRWeplo/J+dSChm3CUN1rkk7mxJJmNnU3ySYX5lo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YRLIbCimtgBlJYEdyxF9hD+TexA96gyzv2Cp7KVIysejHpC1ZV/hlUKJmn1K68C+n
         /qNf+tYW1lVyyfJtS3wX5M/buQarU8cUfPF/vRjfcTIXKAPOuuodHmVPhiz/Ip8HuG
         nKrx5VnxaHZHlAKQjvZ3gSBWPxBmz9ydygJc5fwG96voLvBrAHyZ5T+DD10iYRojMJ
         Ofz0/O1+qcwgxuqGlbNf7+i7uQslabni9/PZ1VJ0tASjBBp5sADbmyoMsAfAt1sQh/
         Lh7i3kyytiPwyeNhFJY48hqtlyP6uJP0az59qBKxnBWnWOdw9I+CkpqL2Se/BGncZV
         QEabB/cpfMCRQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 05 Dec 2023 16:48:18 +0000
Subject: [PATCH v3 20/21] KVM: arm64: selftests: Document feature registers
 added in 2023 extensions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-20-dbcbcd867a7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RtrbRWeplo/J+dSChm3CUN1rkk7mxJJmNnU3ySYX5lo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1T4CgCPiHmKGN/VARDp7A3cLzr3fw+Oqk/gk6kB
 jrlxPJ+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U+AAKCRAk1otyXVSH0HnrB/
 wLwtOnY0ZOVUQqzs2bZEncaCUPR7CtD1MQGN0vdj44RZgh6yX1UYEvULTVJOjRm4pGi9yk4aN747A5
 OmLixp/5QUJEtY+hqnBh2tKagwP1qSuNtSLt1BF00TpxzIipRwMhYxGgtpa9zPRBRZjA/nUCyoopxB
 J372rjpTzH7NN+bfY8mkG6acKBMY9JtdGk5yRRhOlzBp5cypJd7tfIasgkAU2/eqRKM5oVZuAqlfer
 IruowDG6Frpqyb/a/t4H59yo97OK/kQyIHcxMQ/g2wyh+f7kp0k0vOskzDFdeZ5CDfOCy9F1eVIu2H
 EKo1kd4LPjhDEFNh4TG3n0C4ZYJjYt
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

The 2023 architecture extensions allocated some previously usused feature
registers, add comments mapping the names in get-reg-list as we do for the
other allocated registers.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 709d7d721760..71ea6ecec7ce 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -428,7 +428,7 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 0, 4, 4),	/* ID_AA64ZFR0_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 4, 5),	/* ID_AA64SMFR0_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 4, 6),
-	ARM64_SYS_REG(3, 0, 0, 4, 7),
+	ARM64_SYS_REG(3, 0, 0, 4, 7),	/* ID_AA64FPFR_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 5, 0),	/* ID_AA64DFR0_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 5, 1),	/* ID_AA64DFR1_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 5, 2),
@@ -440,7 +440,7 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 0, 6, 0),	/* ID_AA64ISAR0_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 6, 1),	/* ID_AA64ISAR1_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 6, 2),	/* ID_AA64ISAR2_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 6, 3),
+	ARM64_SYS_REG(3, 0, 0, 6, 3),	/* ID_AA64ISAR3_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 6, 4),
 	ARM64_SYS_REG(3, 0, 0, 6, 5),
 	ARM64_SYS_REG(3, 0, 0, 6, 6),

-- 
2.30.2

