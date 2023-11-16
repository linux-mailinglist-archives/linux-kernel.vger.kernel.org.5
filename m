Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45117EE0E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbjKPMwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345169AbjKPMwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:52:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5161AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:52:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A4CC433C9;
        Thu, 16 Nov 2023 12:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700139158;
        bh=z/GTSUVgAaIxP2s2u7Y93d6tpqT1f5YeehxRbaLZg2c=;
        h=From:Date:Subject:To:Cc:From;
        b=FFWyR79McdYnQ/zWZpLU0bpBFDvKYQZj7QVHyEBTWrLTCTV5TuYoIL3eEHeFtzv/H
         rHDQKWxucUUble4HOh09umUcOFcVwbuBqFiaz3xVW+HjhQ0yLz7/XHYuyTpilXTW7Y
         uN+HmsVVx5vhFT0Q8B9LCiXohJ6lw0fJJNS1U7s0dIxrEvi5aXwNVKSJB3vlT0sNuh
         BLx+ep2Zo6WUNJlBO+736GRJKbpSBRDWuUEekm/+WwKlMv1JtDNQcFfCwgc4wdjVKk
         VT98l5ZT6M1hYba8ZnEkdMQFZe3Xsnbch4BzfyoN8G6fLku+DDrWBkFZUfrTePdBOH
         5fcZ5xb9yRAwQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 16 Nov 2023 12:52:29 +0000
Subject: [PATCH] kselftest/arm64: Fix output formatting for za-fork
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-arm64-fix-za-fork-output-v1-1-42c03d4f5759@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIwQVmUC/x2MywqEMAwAf0VyNmDqi91fkT2UNmoQraS6iOK/W
 zwOzMwFkVU4wje7QPkvUcKSgPIM3GiXgVF8YjCFKYmoRqtzU2EvB54W+6AThn1b9w0NOe9b29K
 ndpDyVTlZ77r73fcDk4urImoAAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068; i=broonie@kernel.org;
 h=from:subject:message-id; bh=z/GTSUVgAaIxP2s2u7Y93d6tpqT1f5YeehxRbaLZg2c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlVhCQKIl3nvwpx955b3AQ0M511w63OM2oM7kzO
 W5k2qAY2t6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVYQkAAKCRAk1otyXVSH
 0H5vB/91Jpk6PxJcrw2BnwzUUGipORtm/pqOhxlTCwAc30s9vw6ZZsEmPMBVa+CoqjMBryBPRAH
 DzNfUYacgvCnUDq1zHWzlrBIBHC1jrltoTlbFO6VNy/sJ/KAh43DhQ2K101Q3XlH2xYe/lepvp3
 6vsFLCAXFvMZDEs1YMS/qjLSrXlbm+ZkkA/zNBOGXuBsfIb+7AGITEnCxFYs2ghxXZq+XUHD3Mw
 +MsCiCJl4c2Qo7/dQUmj8Y6T1qaX37EfJaaeuoewjxqSROIF/UkucjQXOb3WrujDe7VXGVVipgk
 nDSuUkso4zn8kZiqYBHnNWi5KxHm/pkuqDa1ttTPx3B+Qmls
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The za-fork test does not output a newline when reporting the result of
the one test it runs, causing the counts printed by kselftest to be
included in the test name.  Add the newline.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/za-fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/za-fork.c b/tools/testing/selftests/arm64/fp/za-fork.c
index b86cb1049497..587b94648222 100644
--- a/tools/testing/selftests/arm64/fp/za-fork.c
+++ b/tools/testing/selftests/arm64/fp/za-fork.c
@@ -85,7 +85,7 @@ int main(int argc, char **argv)
 	 */
 	ret = open("/proc/sys/abi/sme_default_vector_length", O_RDONLY, 0);
 	if (ret >= 0) {
-		ksft_test_result(fork_test(), "fork_test");
+		ksft_test_result(fork_test(), "fork_test\n");
 
 	} else {
 		ksft_print_msg("SME not supported\n");

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231115-arm64-fix-za-fork-output-21cdd7a7195c

Best regards,
-- 
Mark Brown <broonie@kernel.org>

