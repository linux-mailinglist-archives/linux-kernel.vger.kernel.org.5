Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D721806C86
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377724AbjLFKqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377591AbjLFKqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31A810E4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A80C433C9;
        Wed,  6 Dec 2023 10:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859573;
        bh=bOE6yEXLphMEqWjRTeCXJQbg+0EMud/88Rsqb9t5l5E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fKQwYsHHE13PYh9LBiopiY18h9aNZqyT/kp/CrUa5v+Yg44M7fkuLeo3fEwGJoWqb
         3qhAFjiO5X6F0z5/bFYI6Gi273CBIF6sb1FLKHBzndMI/AIk/xKaEvUSQ9ige0E9S/
         hvpRcpSW3LjTu1KIoJdLjZM/cbuQU7aOHgoQj1T6XBNvXQErG+STENx+maq7dUR7gS
         ntw+ctU8cUq6OkXOHuxjDnxpFiWr0y/Lmj6FStb/mVdjYCFok+4Qq824N0CjwXSUA3
         /kGAhs+p6NtLnTF55JPDeYeRZYEOgU+TZfp+eYZsKaSp0y4YOtpguyJ4HrDMLoFnXI
         KD0nuupmsheYg==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 06 Dec 2023 11:45:54 +0100
Subject: [PATCH v2 03/15] selftests/hid: base: allow for multiple
 skip_if_uhdev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-3-c0350c2f5986@kernel.org>
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
In-Reply-To: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=1292;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=bOE6yEXLphMEqWjRTeCXJQbg+0EMud/88Rsqb9t5l5E=;
 b=YmF07rZ0fvqbn4E0ltVG89A/3NDLNAd85T6nXnHOVec7pFT482QYSqybb0L/HL2Qv5oZ5gLYw
 ARMqfkEEmogCu9p8yytaX5ruU3tWIrUeBe/MhUw4ujTcZhvDrl9uF0R
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can actually have multiple occurences of `skip_if_uhdev` if we follow
the information from the pytest doc[0].

This is not immediately used, but can be if we need multiple conditions
on a given test.

[0] https://docs.pytest.org/en/latest/historical-notes.html#update-marker-code

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/tests/base.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/base.py b/tools/testing/selftests/hid/tests/base.py
index 1305cfc9646e..5d9c26dfc460 100644
--- a/tools/testing/selftests/hid/tests/base.py
+++ b/tools/testing/selftests/hid/tests/base.py
@@ -238,8 +238,7 @@ class BaseTestCase:
             try:
                 with HIDTestUdevRule.instance():
                     with new_uhdev as self.uhdev:
-                        skip_cond = request.node.get_closest_marker("skip_if_uhdev")
-                        if skip_cond:
+                        for skip_cond in request.node.iter_markers("skip_if_uhdev"):
                             test, message, *rest = skip_cond.args
 
                             if test(self.uhdev):

-- 
2.41.0

