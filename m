Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B127F5CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjKWKp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjKWKpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:45:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C47219D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:46:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2EFC433C8;
        Thu, 23 Nov 2023 10:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700736360;
        bh=78dMyxfgW9SIkx6hreURfLR8BhPoNmQF6uctLZQkwMs=;
        h=From:Subject:Date:To:Cc:From;
        b=MA8X9P7QDYSDbph9aIkRqqM+rLkpPAPvMiKYCHculd4A46VOIE+ikw70zIHCswVQs
         GD3HxauUx2b8LGVc6AbElXXzJTvJ7zKUt9tAymHyEkiPOnhvB8bnyo7xwVacH2Ke3v
         LZJF/KF+qlyX3X3Ql8Twa6T7iOFER/n6xxjpRhFsPz2WQzl2VR7JEYMcmZUFgcmW86
         Q/+1+BgnqrIxhjldSaqiZradjQvSoOb1OK//n1NOlB6culDwA+n9Xx4VRRWl9PAjub
         ZLmI8ZupKCYMsyvj4W8LahI0dZZzl3Qqt01/8zAaqVVUkX8M+MkdrOMDZU0AyysxwI
         +o8vkCY/O6m8w==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] kselftest/vDSO: Output formatting cleanups for
 vdso_test_abi
Date:   Thu, 23 Nov 2023 10:45:46 +0000
Message-Id: <20231123-kselftest-vdso-test-name-v1-0-1b30441c422b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFotX2UC/x2MwQqDMBAFf0X27EITpRZ/RTyE+FKX1ijZIIXgv
 zd4mznMFFIkgdLYFEo4RWWPVUzbkF9dfINlqU72YTtjrOWP4hsyNPO56M43RbeB+z54P8A8Xfe
 imh8JQX73epqv6w+CfjexagAAAA==
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=broonie@kernel.org;
 h=from:subject:message-id; bh=78dMyxfgW9SIkx6hreURfLR8BhPoNmQF6uctLZQkwMs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXy1jEAq8ntpbFqgXxWFiBW/XyxqwjEc+evPP3
 UeJuKhm+2mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV8tYwAKCRAk1otyXVSH
 0E1oB/9tCnaICuFXbG6wzPPDmRkNVyV/SQUia0MbBW5MKjsmK6HMOAtOXQcZyQYgjVaQ76HH9Oy
 K+LbB8cwwNSYlGaUbzq9FWvZMVv1n8D/v8lBsHTB0BLTMxp6CPLFZv/BnKW2CqlZwamJiYPylfM
 hoxo4DgGpx4Jzu3+WPaMC/l/gSMMiJ2LResSVNf50y6umkZMd8fmH3j6OnfkO6l7MvDWSe9BW5p
 7Z6+ONOncghKdRZM4NQ/Byxu+2mAl35wDKbgBReXtWLmHKQSeXY5QUjwUkux+5+I3nq+A5Bg3Vw
 3adpqhjWAKFfB+di8stp2CWfOV0YQox01Lb/JFHwKYZAOQOs
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

These patches update the output of the vdso_test_abi test program to
bring it into line with expected KTAP usage, the main one being the
first patch which ensures we log distinct test names for each reported
result making it much easier for automated systems to track the status
of the tests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      kselftest/vDSO: Make test name reporting for vdso_abi_test tooling friendly
      kselftest/vDSO: Fix message formatting for clock_id logging
      kselftest/vDSO: Use ksft_print_msg() rather than printf in vdso_test_abi

 tools/testing/selftests/vDSO/vdso_test_abi.c | 72 +++++++++++++++-------------
 1 file changed, 39 insertions(+), 33 deletions(-)
---
base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
change-id: 20231122-kselftest-vdso-test-name-44fcc7e16a38

Best regards,
-- 
Mark Brown <broonie@kernel.org>

