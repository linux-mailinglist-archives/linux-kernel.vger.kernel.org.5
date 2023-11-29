Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7127FDC06
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjK2PZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjK2PZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:25:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90A61719
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:25:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBB9C433CA;
        Wed, 29 Nov 2023 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701271517;
        bh=XtPjsU5+IxLgDeg42cN6iOZ79VywBRfgVyknH2ur/4A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NZpcLgMO9RqQMQczNI7n38lEze9h5miaSq4hI89SWSIpk2HAhAo9CDwIqMy5O7lxt
         5bfCuMKD9RpgIoLO6lEt4cOjT87ODQrApuUOHJ2XhKs7zcV1M83MJljjlVgwUFURj8
         UdYKKMlThyzVjWYhbBbFDTsUIHhxLTCNw61Y++DDOzokm4mvuja1onzdvhkOcNADVb
         aq9kD4Tg9gHNQisSd0Vv9HyEa9YVbG3B/yen1428IcJxG5mUhp4eNLG3m+1mrrce+C
         LxzTK3uVtOx/BvCFBDyPJKsme4n9mf94OKvP2FY9LhuTaHRcpasx3gopkZu3ARvUn9
         IRADik8d2NnIA==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 29 Nov 2023 16:24:33 +0100
Subject: [PATCH 08/12] selftests/hid: tablets: set initial data for
 tilt/twist
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-8-ba15a1fe1b0d@kernel.org>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
In-Reply-To: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=1586;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=XtPjsU5+IxLgDeg42cN6iOZ79VywBRfgVyknH2ur/4A=;
 b=CPZpA+NacCCwdjXGsWjew6pe/NmSHolAtr5gZ0Tj4ZfJt7ZIeCAFk1zsMRYilllE3NU0JJ383
 cvHqBfw/8PtAUGPbAOezZ4JgNTtWrxmh7JyiNl/HAScTMAnJQ5iLWgh
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids getting a null event when these usages are set

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index f93dfbb2a3e5..83f6501fe984 100644
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

