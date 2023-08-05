Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A579770E65
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjHEHVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjHEHVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:21:39 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB2C4EC7;
        Sat,  5 Aug 2023 00:21:37 -0700 (PDT)
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qSBbS-0002p2-W0; Sat, 05 Aug 2023 09:21:35 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 2/5] docs: stable-kernel-rules: move text around to improve flow
Date:   Sat,  5 Aug 2023 09:21:30 +0200
Message-Id: <16f2377ee40dd7dfa146727fcbe7d1ebccf5b5be.1691219455.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1691219455.git.linux@leemhuis.info>
References: <cover.1691219455.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1691220097;44a1d2ae;
X-HE-SMSGID: 1qSBbS-0002p2-W0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the short description about when to use which of the submission
options to the top of the section, as it currently sits somewhat odd in
the middle between option 3 and examples of option 1.

Also move the examples of Option 1 into the section describing it (which
in the diff looks like option 2 and 3 are moving down).

No text changes, just moving it around.

CC: Greg KH <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/stable-kernel-rules.rst | 88 +++++++++----------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index e68a76abe44b..61b4701d3469 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -41,6 +41,13 @@ Procedure for submitting patches to the -stable tree
 
 There are three options to submit a change to -stable trees:
 
+:ref:`option_1` is **strongly** preferred, is the easiest and most common.
+:ref:`option_2` and :ref:`option_3` are more useful if the patch isn't deemed
+worthy at the time it is applied to a public git tree (for instance, because
+it deserves more regression testing first).  :ref:`option_3` is especially
+useful if the original upstream patch needs to be backported (for example
+the backport needs some special handling due to e.g. API changes).
+
 .. _option_1:
 
 Option 1
@@ -57,50 +64,6 @@ inline comment (see below for details). Once the patch is merged it will be
 applied to the stable tree without anything else needing to be done by the
 author or subsystem maintainer.
 
-.. _option_2:
-
-Option 2
-********
-
-After the patch has been merged to Linus' tree, send an email to
-stable@vger.kernel.org containing the subject of the patch, the commit ID,
-why you think it should be applied, and what kernel version you wish it to
-be applied to.
-
-.. _option_3:
-
-Option 3
-********
-
-Send the patch, after verifying that it follows the above rules, to
-stable@vger.kernel.org.  You must note the upstream commit ID in the
-changelog of your submission, as well as the kernel version you wish
-it to be applied to.
-
-:ref:`option_1` is **strongly** preferred, is the easiest and most common.
-:ref:`option_2` and :ref:`option_3` are more useful if the patch isn't deemed
-worthy at the time it is applied to a public git tree (for instance, because
-it deserves more regression testing first).  :ref:`option_3` is especially
-useful if the original upstream patch needs to be backported (for example
-the backport needs some special handling due to e.g. API changes).
-
-Note that for :ref:`option_3`, if the patch deviates from the original
-upstream patch (for example because it had to be backported) this must be very
-clearly documented and justified in the patch description.
-
-The upstream commit ID must be specified with a separate line above the commit
-text, like this:
-
-.. code-block:: none
-
-    commit <sha1> upstream.
-
-or alternatively:
-
-.. code-block:: none
-
-    [ Upstream commit <sha1> ]
-
 Additionally, some patches submitted via :ref:`option_1` may have additional
 patch prerequisites which can be cherry-picked. This can be specified in the
 following format in the sign-off area:
@@ -152,6 +115,43 @@ problems:
 
      Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for >= 6.3
 
+.. _option_2:
+
+Option 2
+********
+
+After the patch has been merged to Linus' tree, send an email to
+stable@vger.kernel.org containing the subject of the patch, the commit ID,
+why you think it should be applied, and what kernel version you wish it to
+be applied to.
+
+.. _option_3:
+
+Option 3
+********
+
+Send the patch, after verifying that it follows the above rules, to
+stable@vger.kernel.org.  You must note the upstream commit ID in the
+changelog of your submission, as well as the kernel version you wish
+it to be applied to.
+
+Note that for :ref:`option_3`, if the patch deviates from the original
+upstream patch (for example because it had to be backported) this must be very
+clearly documented and justified in the patch description.
+
+The upstream commit ID must be specified with a separate line above the commit
+text, like this:
+
+.. code-block:: none
+
+    commit <sha1> upstream.
+
+or alternatively:
+
+.. code-block:: none
+
+    [ Upstream commit <sha1> ]
+
 Following the submission
 ------------------------
 
-- 
2.40.1

