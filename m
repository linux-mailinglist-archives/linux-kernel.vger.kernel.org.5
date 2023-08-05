Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B2C770E69
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjHEHWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjHEHVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:21:40 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B374ECA;
        Sat,  5 Aug 2023 00:21:38 -0700 (PDT)
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qSBbT-0002p2-AL; Sat, 05 Aug 2023 09:21:35 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 3/5] docs: stable-kernel-rules: make the examples for option 1 a proper list
Date:   Sat,  5 Aug 2023 09:21:31 +0200
Message-Id: <59deaabfabf0629d7cf2a52b196cec19d1f9ec47.1691219455.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1691219455.git.linux@leemhuis.info>
References: <cover.1691219455.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1691220098;d8ef99a8;
X-HE-SMSGID: 1qSBbT-0002p2-AL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the description for option 1 and the examples how to use it by
making the latter an indented unordered list.

No text changes.

CC: Greg KH <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/stable-kernel-rules.rst | 48 ++++++++++---------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 61b4701d3469..597016297fb4 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -59,16 +59,18 @@ To have the patch automatically included in the stable tree, add the tag
 
      Cc: stable@vger.kernel.org
 
-in the sign-off area. To accompany a note to the stable team, use a shell-style
-inline comment (see below for details). Once the patch is merged it will be
-applied to the stable tree without anything else needing to be done by the
-author or subsystem maintainer.
+in the sign-off area. Once the patch is merged it will be applied to the
+stable tree without anything else needing to be done by the author or
+subsystem maintainer.
 
-Additionally, some patches submitted via :ref:`option_1` may have additional
-patch prerequisites which can be cherry-picked. This can be specified in the
-following format in the sign-off area:
+To accompany a note to the stable team, use a shell-style inline comment (see
+below for details):
 
-.. code-block:: none
+ * Additionally, some patches submitted via :ref:`option_1` may have additional
+   patch prerequisites which can be cherry-picked. This can be specified in the
+   following format in the sign-off area:
+
+   .. code-block:: none
 
      Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
      Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
@@ -76,42 +78,42 @@ following format in the sign-off area:
      Cc: <stable@vger.kernel.org> # 3.3.x
      Signed-off-by: Ingo Molnar <mingo@elte.hu>
 
-The tag sequence has the meaning of:
+   The tag sequence has the meaning of:
 
-.. code-block:: none
+   .. code-block:: none
 
      git cherry-pick a1f84a3
      git cherry-pick 1b9508f
      git cherry-pick fd21073
      git cherry-pick <this commit>
 
-Also, some patches may have kernel version prerequisites.  This can be
-specified in the following format in the sign-off area:
+ * Also, some patches may have kernel version prerequisites.  This can be
+    specified in the following format in the sign-off area:
 
-.. code-block:: none
+   .. code-block:: none
 
      Cc: <stable@vger.kernel.org> # 3.3.x
 
-The tag has the meaning of:
+   The tag has the meaning of:
 
-.. code-block:: none
+   .. code-block:: none
 
      git cherry-pick <this commit>
 
-For each "-stable" tree starting with the specified version.
+   For each "-stable" tree starting with the specified version.
 
-To delay pick up of patches submitted via :ref:`option_1`, use the following
-format:
+ * To delay pick up of patches submitted via :ref:`option_1`, use the following
+   format:
 
-.. code-block:: none
+   .. code-block:: none
 
      Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
 
-For any other requests related to patches submitted via :ref:`option_1`, just
-add a note to the stable tag. This for example can be used to point out known
-problems:
+ * For any other requests related to patches submitted via :ref:`option_1`, just
+   add a note to the stable tag. This for example can be used to point out known
+   problems:
 
-.. code-block:: none
+   .. code-block:: none
 
      Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for >= 6.3
 
-- 
2.40.1

