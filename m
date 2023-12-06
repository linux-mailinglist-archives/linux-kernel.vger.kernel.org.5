Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7983B806C97
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377767AbjLFKrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377759AbjLFKqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FBB173E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89C7C433CD;
        Wed,  6 Dec 2023 10:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859583;
        bh=4zleTS1syp3MMWCgpz68nisdsjLtNx642uQ5ALXPbwU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=otx5oY/7aOYzUCHm0+Wal4grzP0hALifiz/kblIrGWFMdrlKLNZXNQ1jYyOI6FGgd
         CBMEdpiBDbPuk01/0Y8tIwQtFePt7FhXYp/ItEq5Ib4n/qyJyVuS4wHNByXzceg2BZ
         1zSmoeHqeSG2u4dI2qVJ1a+TKAW/kqsXCcHpeEfJhOazEyt6umNIrP9YwMOQokevp8
         Kv5J7LNG+rxdz/YZ0lzUYnnIn+n1QIVLf3YShrMG017Nd4X0/t38YDK6KYvqLFMpWY
         JhTUuZuZac+rCJtG0sBVBJ9is0WeEjlVzfzf9YPOjmQbUsHstWz42JVDEo6Fw9UFlG
         e+gWswO6Uy6WA==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 06 Dec 2023 11:45:59 +0100
Subject: [PATCH v2 08/15] selftests/hid: tablets: set initial data for
 tilt/twist
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-8-c0350c2f5986@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=1669;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=4zleTS1syp3MMWCgpz68nisdsjLtNx642uQ5ALXPbwU=;
 b=wFyaODHbKOxoT5j8xyDHC2qJHzmHuEprhItc8UzFlNeXgJ0cKsxGN/s1i6P464tR5E5LIipA9
 kGaSwNjeaujBXRroxcW2ahvrOKt0aUXWsX4NnvDwU62jds6r2il1ZIh
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

Avoids getting a null event when these usages are set

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/tests/test_tablet.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index cb3955bf0ec5..0ddf82695ed9 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -276,9 +276,9 @@ class Pen(object):
         self.barrelswitch = False
         self.invert = False
         self.eraser = False
-        self.x_tilt = 0
-        self.y_tilt = 0
-        self.twist = 0
+        self.xtilt = 1
+        self.ytilt = 1
+        self.twist = 1
         self._old_values = None
         self.current_state = None
 
@@ -292,8 +292,8 @@ class Pen(object):
                 "width",
                 "height",
                 "twist",
-                "x_tilt",
-                "y_tilt",
+                "xtilt",
+                "ytilt",
             ]:
                 setattr(self, i, getattr(self._old_values, i))
 
@@ -361,8 +361,8 @@ class PenDigitizer(base.UHIDTestDevice):
             pen.height = 0
             pen.invert = False
             pen.eraser = False
-            pen.x_tilt = 0
-            pen.y_tilt = 0
+            pen.xtilt = 0
+            pen.ytilt = 0
             pen.twist = 0
         elif state == PenState.PEN_IS_IN_RANGE:
             pen.tipswitch = False

-- 
2.41.0

