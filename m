Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72028087A9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379241AbjLGMWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjLGMWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:22:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B06810CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:22:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB499C433C8;
        Thu,  7 Dec 2023 12:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701951764;
        bh=epH6N4HOQY9d/F5eZFuiUiKcD6erclTqiNFuoeHNibM=;
        h=From:Date:Subject:To:Cc:From;
        b=ZRuAepFhfUG/d4JUckztQmMS323WJgPb0oGVjoiVT16Sw9k3gd2mcP1s2X+UCQhvm
         TTX8vLZ/lNjgv68XatsoQiJNDp2Kmmq9H854ivI9VPmVLP9p70meAooJGYxI1LJTgL
         QT/RAmD1b14G3rSJqRc4372ZDLz6i5nKmz2lsxe4xSDv12Y2ByD3xiexVsFxncGrDS
         TOt/qKsUYnZ/laPTjMCTRn0sqo0B84C9zuiZ566wL1mJ04fGJnN8aY5gdcLCG56hkV
         9aevdE7LoYOLkHTHMomf0iLxG91JcLifQyl1l9vrt/8PZHvaTouWNw3vypYTYqvEE0
         ss+Dg2q8YUkIQ==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Thu, 07 Dec 2023 13:22:39 +0100
Subject: [PATCH] selftests/hid: fix failing tablet button tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-b4-wip-selftests-v1-1-c4e13fe04a70@kernel.org>
X-B4-Tracking: v=1; b=H4sIAA65cWUC/x3MQQ5AMBBA0avIrE2i1SKuIha0g0kE6QiSxt01l
 m/xfwShwCTQZhECXSy8bwkqz8AtwzYTsk8GXehS6aLG0eDNBwqt00lyCjplK+uNN7ZuIGVHoIm
 ff9n17/sBuP0ArGIAAAA=
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Jiri Kosina <jkosina@suse.com>,
        Benjamin Tissoires <bentiss@kernel.org>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701951762; l=1894;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=epH6N4HOQY9d/F5eZFuiUiKcD6erclTqiNFuoeHNibM=;
 b=n/90PDIVzBVYmex40erDeyr8UfBLYJJvGN2LIAvfkl2wkUtPc4ZONsXa4LXWuHGuUhRNjEr3t
 S29RzIxWhgoCbx0SJBI78CjhJjrx8MqBr1/El5ybpfDF2e1WRSpLa54
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

An overlook from commit 74452d6329be ("selftests/hid: tablets: add
variants of states with buttons"), where I don't use the Enum...

Fixes: 74452d6329be ("selftests/hid: tablets: add variants of states with buttons")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Not sure what happened, but I mustn't have run the tests before
sending the series, and they fail blatently.
I'm deeply sorry for that, I thought these failures were fixed.

Cheers,
Benjamin
---
 tools/testing/selftests/hid/tests/test_tablet.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index dc8b0fe9e7f3..903f19f7cbe9 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -115,7 +115,7 @@ class PenState(Enum):
         # we take only the highest button in account
         for b in [libevdev.EV_KEY.BTN_STYLUS, libevdev.EV_KEY.BTN_STYLUS2]:
             if bool(evdev.value[b]):
-                button = b
+                button = BtnPressed(b)
 
         # the kernel tends to insert an EV_SYN once removing the tool, so
         # the button will be released after
@@ -155,7 +155,7 @@ class PenState(Enum):
                 if button_found:
                     raise ValueError(f"duplicated BTN_STYLUS* in {events}")
                 button_found = True
-                button = ev.code if ev.value else None
+                button = BtnPressed(ev.code) if ev.value else None
 
         # the kernel tends to insert an EV_SYN once removing the tool, so
         # the button will be released after

---
base-commit: f556aa957df8cb3e98af0f54bf1fa65f59ae47a3
change-id: 20231207-b4-wip-selftests-c1565d4d4578

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>

