Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CF4806C9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377804AbjLFKr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377705AbjLFKq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD21D1BD4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21B6C433AB;
        Wed,  6 Dec 2023 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859595;
        bh=qlUB59mdEXNSA6/Zy2rtughuPHzMiJYZi2ulYjUvu2c=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=O9I5lN34VEbMkUNQPkDh2gcPlZCb/4oo4HxVfVBsJZDFEdGfsBIu1Dl0KV7TsOc1+
         thVHfa5iaAsFXqjzpltYqH2cJaMTfEC+1Oz9PilY/L21mxoQsQwhQbFB+ZQmztkvI7
         3qzKTxDVtFsPke6jhxiPNgUhnjGq07Np+HCWNVxU2Xn2BEMfIiZS79lzgpYw8kNqaQ
         0Amuw944V/ZwodOsYbIUwnQYLz2DBRTICETb7adtS5shOAsdKzBlvqJqLDIFvHxnNf
         qxKG/4demQ7u1IOapRbP2FO/p+yaxqquDnvFxr1gcJIOg2KOGLKUmqdbhkxEht8mc3
         Xc2ck5F0nBJuw==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 06 Dec 2023 11:46:05 +0100
Subject: [PATCH v2 14/15] selftests/hid: fix mypy complains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-14-c0350c2f5986@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=2690;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=qlUB59mdEXNSA6/Zy2rtughuPHzMiJYZi2ulYjUvu2c=;
 b=eNuto/PCVNKt4hEZ3qf3mbOg5IFQ64ju2cLEbB7qwWDnWb+JsGHfxC2TZ818Uigmv40m14QLs
 gmWRqXz+HseB49TOWMNIE0QwU8o9CxUQHoTHdea4CjX4JMMC85zKw1+
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

No code change, only typing information added/ignored

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 tools/testing/selftests/hid/tests/base.py        |  4 ++--
 tools/testing/selftests/hid/tests/test_tablet.py | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/base.py b/tools/testing/selftests/hid/tests/base.py
index 5d9c26dfc460..51433063b227 100644
--- a/tools/testing/selftests/hid/tests/base.py
+++ b/tools/testing/selftests/hid/tests/base.py
@@ -14,7 +14,7 @@ import logging
 
 from hidtools.device.base_device import BaseDevice, EvdevMatch, SysfsFile
 from pathlib import Path
-from typing import Final
+from typing import Final, List, Tuple
 
 logger = logging.getLogger("hidtools.test.base")
 
@@ -155,7 +155,7 @@ class BaseTestCase:
         # if any module is not available (not compiled), the test will skip.
         # Each element is a tuple '(kernel driver name, kernel module)',
         # for example ("playstation", "hid-playstation")
-        kernel_modules = []
+        kernel_modules: List[Tuple[str, str]] = []
 
         def assertInputEventsIn(self, expected_events, effective_events):
             effective_events = effective_events.copy()
diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 9374bd7524ef..dc8b0fe9e7f3 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -87,9 +87,9 @@ class PenState(Enum):
     )
 
     def __init__(self, touch: BtnTouch, tool: Optional[ToolType], button: Optional[BtnPressed]):
-        self.touch = touch
-        self.tool = tool
-        self.button = button
+        self.touch = touch  # type: ignore
+        self.tool = tool  # type: ignore
+        self.button = button  # type: ignore
 
     @classmethod
     def from_evdev(cls, evdev) -> "PenState":
@@ -122,7 +122,7 @@ class PenState(Enum):
         if tool is None:
             button = None
 
-        return cls((touch, tool, button))
+        return cls((touch, tool, button))  # type: ignore
 
     def apply(self, events: List[libevdev.InputEvent], strict: bool) -> "PenState":
         if libevdev.EV_SYN.SYN_REPORT in events:
@@ -162,7 +162,7 @@ class PenState(Enum):
         if tool is None:
             button = None
 
-        new_state = PenState((touch, tool, button))
+        new_state = PenState((touch, tool, button))  # type: ignore
         if strict:
             assert (
                 new_state in self.valid_transitions()

-- 
2.41.0

