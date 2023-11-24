Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6AF7F7793
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345714AbjKXPW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345599AbjKXPWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:22:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBDC171D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:22:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20744C433C8;
        Fri, 24 Nov 2023 15:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700839350;
        bh=eOmzk2kjD2qGLqrF6Q6BvgazwN+efxPGwLtAu031LrQ=;
        h=From:Date:Subject:To:Cc:From;
        b=tP47FDox6zvAd0CAisIZRgXBpQCvZESDI7nmtsqnX5rpS9X14SPmYq3DKU9hGYYpy
         WBKHLU1KG6r+IYhrBRvY2i7ay6+aTe3qh/l6d0vQHg2GkRJniyEDu23gp/sUsQtFnZ
         niUdeGlNbe8iOsrI0Q69m3LRBHTzoJnXx7yiFekJgMHx/WYSw4sx4E1R6fi7Yfsela
         QtaRYn9x9yWujw8qHgwyv0Kmzy6MAUHxAMvI0W5aY8y7uUezDwfXY0rxOOuffRJ9Ez
         RqmQzrwBdGEL5FvBUrXxTMxI/+m56CT06eclwqPywdjOU5exVi3wqechoNNDsPp6bT
         ntcEpiE3lLj+w==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 24 Nov 2023 15:22:21 +0000
Subject: [PATCH] kselftest/arm64: Improve output for skipped TPIDR2 ABI
 test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231124-kselftest-arm64-tpidr2-skip-v1-1-e05d0ccef101@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKy/YGUC/x3MQQqEMAxA0atI1gZsGxTmKoML0VSDjlOSIoJ4d
 4vwN2/zLzBWYYNPdYHyISb/vcDVFYzLsM+MMhWDb3xwzhOuxlvMbBkH/bWEOcmkHm2VhBS6liL
 FEkE5JOUo53v/9vf9AMcLRtZtAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eOmzk2kjD2qGLqrF6Q6BvgazwN+efxPGwLtAu031LrQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlYL+yR76ZEEXIOFVMLt4fDAAXcrbLJgL1eipot
 DPjYuPlK9eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZWC/sgAKCRAk1otyXVSH
 0OiIB/480+RDhxLSMZRDkXaICXSlMATxrxDQzBvISYnkBsX9mAimgnYPxYSvswfOuVOSNptdQUL
 YSu/myNZqWhILtJrob4ms7vuGMDaT4+6b4sbeyKNpxwSRPM1q/DR083SZrJDFtn2dO/UGpK/HRo
 siI831FLOYphc7jzTgNqh9+NDtkor31dauF4UydCccFKiNVv5ckAzjCh3kO/XUDOlglNbRv2ZQI
 Qr/C1EHYMfPhCBLsWAlQJ+ZzydqhYs5PZIaFehUHlHuhuayaXJcOylB5DzCiqaoUhkBt88uO8pN
 riuyMfH7wY2q8X0J+L2s6pndHqVNNTPI5GHmtFsjZX8uo2aA
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

When TPIDR2 is not supported the tpidr2 ABI test prints the same message
for each skipped test:

  ok 1 skipped, TPIDR2 not supported

which isn't ideal for test automation software since it tracks kselftest
results based on the string used to describe the test. This is also not
standard KTAP output, the expected format is:

  ok 1 # SKIP default_value

Updated the program to generate this, using the same set of test names that
we would run if the test actually executed.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/tpidr2.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/tpidr2.c b/tools/testing/selftests/arm64/abi/tpidr2.c
index 351a098b503a..02ee3a91b780 100644
--- a/tools/testing/selftests/arm64/abi/tpidr2.c
+++ b/tools/testing/selftests/arm64/abi/tpidr2.c
@@ -254,6 +254,12 @@ static int write_clone_read(void)
 	putnum(++tests_run);		     \
 	putstr(" " #name "\n");
 
+#define skip_test(name)			     \
+	tests_skipped++;		     \
+	putstr("ok ");			     \
+	putnum(++tests_run);		     \
+	putstr(" # SKIP " #name "\n");
+
 int main(int argc, char **argv)
 {
 	int ret, i;
@@ -283,13 +289,11 @@ int main(int argc, char **argv)
 	} else {
 		putstr("# SME support not present\n");
 
-		for (i = 0; i < EXPECTED_TESTS; i++) {
-			putstr("ok ");
-			putnum(i);
-			putstr(" skipped, TPIDR2 not supported\n");
-		}
-
-		tests_skipped += EXPECTED_TESTS;
+		skip_test(default_value);
+		skip_test(write_read);
+		skip_test(write_sleep_read);
+		skip_test(write_fork_read);
+		skip_test(write_clone_read);
 	}
 
 	print_summary();

---
base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
change-id: 20231124-kselftest-arm64-tpidr2-skip-43764f4ff4f4

Best regards,
-- 
Mark Brown <broonie@kernel.org>

