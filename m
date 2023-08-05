Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA13770E67
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjHEHWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjHEHVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:21:40 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2634E4EC8;
        Sat,  5 Aug 2023 00:21:38 -0700 (PDT)
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qSBbT-0002p2-NF; Sat, 05 Aug 2023 09:21:35 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 4/5] docs: stable-kernel-rules: fine-tune various details
Date:   Sat,  5 Aug 2023 09:21:32 +0200
Message-Id: <e1960a70acae2c2f18b838aee9f8bf6055fae89b.1691219455.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1691219455.git.linux@leemhuis.info>
References: <cover.1691219455.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1691220098;d8ef99a8;
X-HE-SMSGID: 1qSBbT-0002p2-NF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* various fine tuning to the text that cleans up rough edges the three
  previous preparatory patches left behind to keep the diffs simpler
* s/Linus' tree/mainline/g, as that's the term more commonly used and
  known
* create a short intro for the three submission options and streamline
  the explanation when to use which of them
* fix a >= vs <= thinko in an example to make it more straight forward
* there were two blank lines before some sub-headings and just one
  before others; use the former style everywhere

CC: Greg KH <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/stable-kernel-rules.rst | 72 ++++++++++---------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 597016297fb4..2b7f04211d9d 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -30,6 +30,7 @@ Rules on what kind of patches are accepted, and which ones are not, into the
    - No "trivial" fixes without benefit for users (spelling changes, whitespace
      cleanups, etc).
 
+
 Procedure for submitting patches to the -stable tree
 ----------------------------------------------------
 
@@ -41,33 +42,40 @@ Procedure for submitting patches to the -stable tree
 
 There are three options to submit a change to -stable trees:
 
-:ref:`option_1` is **strongly** preferred, is the easiest and most common.
-:ref:`option_2` and :ref:`option_3` are more useful if the patch isn't deemed
-worthy at the time it is applied to a public git tree (for instance, because
-it deserves more regression testing first).  :ref:`option_3` is especially
-useful if the original upstream patch needs to be backported (for example
-the backport needs some special handling due to e.g. API changes).
+ 1. Add a 'stable tag' to the description of a patch you then submit for
+    mainline inclusion.
+ 2. Ask the stable team to pick up a patch already mainlined.
+ 3. Submit a patch to the stable team that is equivalent to a change already
+    mainlined.
+
+The sections below describe each of the options in more detail.
+
+:ref:`option_1` is **strongly** preferred, it is the easiest and most common.
+:ref:`option_2` is mainly meant for changes where backporting was not considered
+at the time of submission. :ref:`option_3` is an alternative to the two earlier
+options for cases where a mainlined patch needs adjustments to apply in older
+series (for example due to API changes).
 
 .. _option_1:
 
 Option 1
 ********
 
-To have the patch automatically included in the stable tree, add the tag
+To have a patch you submit for mainline inclusion later automatically picked up
+for stable trees, add the tag
 
 .. code-block:: none
 
      Cc: stable@vger.kernel.org
 
-in the sign-off area. Once the patch is merged it will be applied to the
+in the sign-off area. Once the patch is mainlined it will be applied to the
 stable tree without anything else needing to be done by the author or
 subsystem maintainer.
 
-To accompany a note to the stable team, use a shell-style inline comment (see
-below for details):
+To sent additional instructions to the stable team, use a shell-style inline
+comment:
 
- * Additionally, some patches submitted via :ref:`option_1` may have additional
-   patch prerequisites which can be cherry-picked. This can be specified in the
+ * To specify any additional patch prerequisites for cherry picking use the
    following format in the sign-off area:
 
    .. code-block:: none
@@ -87,8 +95,8 @@ below for details):
      git cherry-pick fd21073
      git cherry-pick <this commit>
 
- * Also, some patches may have kernel version prerequisites.  This can be
-    specified in the following format in the sign-off area:
+ * For patches that may have kernel version prerequisites specify them using
+   the following format in the sign-off area:
 
    .. code-block:: none
 
@@ -102,27 +110,28 @@ below for details):
 
    For each "-stable" tree starting with the specified version.
 
- * To delay pick up of patches submitted via :ref:`option_1`, use the following
-   format:
+   Note, such tagging is unnecessary if the stable team can derive the
+   appropriate versions from Fixes: tags.
+
+ * To delay pick up of patches, use the following format:
 
    .. code-block:: none
 
      Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
 
- * For any other requests related to patches submitted via :ref:`option_1`, just
-   add a note to the stable tag. This for example can be used to point out known
-   problems:
+ * For any other requests, just add a note to the stable tag. This for example
+   can be used to point out known problems:
 
    .. code-block:: none
 
-     Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for >= 6.3
+     Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.3
 
 .. _option_2:
 
 Option 2
 ********
 
-After the patch has been merged to Linus' tree, send an email to
+If the patch already has been merged to mainline, send an email to
 stable@vger.kernel.org containing the subject of the patch, the commit ID,
 why you think it should be applied, and what kernel version you wish it to
 be applied to.
@@ -133,16 +142,9 @@ Option 3
 ********
 
 Send the patch, after verifying that it follows the above rules, to
-stable@vger.kernel.org.  You must note the upstream commit ID in the
-changelog of your submission, as well as the kernel version you wish
-it to be applied to.
-
-Note that for :ref:`option_3`, if the patch deviates from the original
-upstream patch (for example because it had to be backported) this must be very
-clearly documented and justified in the patch description.
-
-The upstream commit ID must be specified with a separate line above the commit
-text, like this:
+stable@vger.kernel.org and mention the kernel version you wish it to be applied
+to. When doing so, you must note the upstream commit ID in the changelog of your
+submission with a separate line above the commit text, like this:
 
 .. code-block:: none
 
@@ -154,12 +156,17 @@ or alternatively:
 
     [ Upstream commit <sha1> ]
 
+If the submitted patch deviates from the original upstream patch (for example
+because it had to be adjusted for the older API), this must be very clearly
+documented and justified in the patch description.
+
+
 Following the submission
 ------------------------
 
 The sender will receive an ACK when the patch has been accepted into the
 queue, or a NAK if the patch is rejected.  This response might take a few
-days, according to the developer's schedules.
+days, according to the schedules of the stable team members.
 
 If accepted, the patch will be added to the -stable queue, for review by other
 developers and by the relevant subsystem maintainer.
@@ -191,6 +198,7 @@ Review cycle
    security kernel team, and not go through the normal review cycle.
    Contact the kernel security team for more details on this procedure.
 
+
 Trees
 -----
 
-- 
2.40.1

