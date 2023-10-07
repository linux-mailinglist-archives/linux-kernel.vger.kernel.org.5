Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70547BC846
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 16:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343969AbjJGOGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 10:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343933AbjJGOF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 10:05:58 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAE25BC;
        Sat,  7 Oct 2023 07:05:56 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 397E5OlR025463;
        Sat, 7 Oct 2023 16:05:24 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, security@kernel.org, corbet@lwn.net,
        workflows@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Solar Designer <solar@openwall.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [RFC PATCH] Documentation: security-bugs.rst: linux-distros relaxed their rules
Date:   Sat,  7 Oct 2023 16:04:54 +0200
Message-Id: <20231007140454.25419-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-distros list relaxed their rules to try to adapt better to
how the Linux kernel works. Let's update the Coordination part to
explain why and when to contact them or not to and how to avoid trouble
in the future.

Link: https://www.openwall.com/lists/oss-security/2023/09/08/4
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Solar Designer <solar@openwall.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/security-bugs.rst | 33 ++++++++++++++++++-------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index 5a6993795bd2..8bbad669af1f 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -66,15 +66,30 @@ lifted, in perpetuity.
 Coordination with other groups
 ------------------------------
 
-The kernel security team strongly recommends that reporters of potential
-security issues NEVER contact the "linux-distros" mailing list until
-AFTER discussing it with the kernel security team.  Do not Cc: both
-lists at once.  You may contact the linux-distros mailing list after a
-fix has been agreed on and you fully understand the requirements that
-doing so will impose on you and the kernel community.
-
-The different lists have different goals and the linux-distros rules do
-not contribute to actually fixing any potential security problems.
+While the kernel security team solely focuses on getting bugs fixed,
+other groups focus on fixing issues in distros and coordinating
+disclosure between operating system vendors.  Coordination is usually
+handled by the "linux-distros" mailing list and disclosure by the
+public "oss-security" mailing list, both of which are closely related
+and presented in the linux-distros wiki:
+<https://oss-security.openwall.org/wiki/mailing-lists/distros>
+
+Please note that the respective policies and rules are different since
+the 3 lists pursue different goals.  Coordinating between the kernel
+security team and other teams is difficult since occasional embargoes
+start from the availability of a fix for the kernel security team, while
+for other lists they generally start from the initial post to the list,
+regardless of the availability of a fix.
+
+As such, the kernel security team strongly recommends that reporters of
+potential security issues DO NOT contact the "linux-distros" mailing
+list BEFORE a fix is accepted by the affected code's maintainers and you
+have read the linux-distros wiki page above and you fully understand the
+requirements that doing so will impose on you and the kernel community.
+This also means that in general it doesn't make sense to Cc: both lists
+at once, except for coordination if a fix remains under embargo. And in
+general, please do not Cc: the kernel security list about fixes that
+have already been merged.
 
 CVE assignment
 --------------
-- 
2.17.5

