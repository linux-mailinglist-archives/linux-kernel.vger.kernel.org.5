Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0652D7F5CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344842AbjKWKqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjKWKp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:45:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2B21BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:46:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAC7C433C7;
        Thu, 23 Nov 2023 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700736363;
        bh=kb3AIT5xG1kFCiQ1Vz+UvRYW0kxBneNP3MyKZ8I3yMw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ajdIZ+/e6/N4hUqFRjdNpAhx8Ye4yk+RAxJEwyynxyAOoXTxab//qTui6Vvq/uLiY
         uHpxjyuH81bRUlgtyjXwhNoIybaLNtYSTGoYjgFzuHX+5wvfR4Orua9Oe/AuMrSV7C
         5LFOuRGV46yoMjL54cmdPzMacP2qw47l6rN9AybNku1l265sEhcBYP+xWt8GK74JpP
         khidagGHu+FBOGTC8DTXmlDASF6n+0GzOVf6yfl37qbkW/gAPj/eH0p1OP5UiXViGl
         21DSJhZm1gNZZy0Qx5eh+ynz8Spe3gu4hrJUYAJP208viZpCI++MlhCE6VLe1ELxbr
         BNGqHTUYao3Lw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 23 Nov 2023 10:45:48 +0000
Subject: [PATCH 2/3] kselftest/vDSO: Fix message formatting for clock_id
 logging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-kselftest-vdso-test-name-v1-2-1b30441c422b@kernel.org>
References: <20231123-kselftest-vdso-test-name-v1-0-1b30441c422b@kernel.org>
In-Reply-To: <20231123-kselftest-vdso-test-name-v1-0-1b30441c422b@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=broonie@kernel.org;
 h=from:subject:message-id; bh=kb3AIT5xG1kFCiQ1Vz+UvRYW0kxBneNP3MyKZ8I3yMw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXy1kdvjeWC86olt31l1UALcmPYTkSVpBieK6Q
 AQu19N/ubqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV8tZAAKCRAk1otyXVSH
 0O9BB/4mWSoAfdRNgPQ8rNiUEhipeTPetXaKsihnKxpsSxSwaR1M2CX0hyEnzzU7yIBXvEsp7nj
 OZ+A+/ALdtzdpXHes2R2/gnRJ9y+ck0SCa80S45QAC6w89R/W09Vq3jZWz33U7SGVH4yBuxol65
 Q3WyjU5Q6mj3GR7BIFFC6reEhfGtvgJsOUpcXcMyvRJF6lxR9iZ9dSi3Cq3ZMl/1TwvHx8ITUw0
 8K8AsnQTlAX1by2G5XKUgPxuV0RWwA7nTkke2Q3yzLb0YnB3GZtpY8zX90X5pvSfUgWfS5aOt1u
 M9edALMMYGp5YvmwUlU5OCeccmQwxWZpVODQ3nAUVkSIh0gK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When logging the ID of the currently tested clock vdso_test_clock() puts a
spurious newline at the start of the format string resulting in output
such as

  #
  clock_id: CLOCK_BOOTTIME

which is a valid but empty KTAP informational message followed by a non
conferment output line. Remove the initial newline to create a more KTAP
friendly

  # clock_id: CLOCK_BOOTTIME

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index b304abae6e8f..d0e247cca58a 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -170,7 +170,7 @@ static void vdso_test_clock_getres(clockid_t clk_id)
  */
 static inline void vdso_test_clock(clockid_t clock_id)
 {
-	ksft_print_msg("\nclock_id: %s\n", vdso_clock_name[clock_id]);
+	ksft_print_msg("clock_id: %s\n", vdso_clock_name[clock_id]);
 
 	vdso_test_clock_gettime(clock_id);
 

-- 
2.39.2

