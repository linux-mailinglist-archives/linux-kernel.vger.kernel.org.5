Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83797770E66
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjHEHVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjHEHVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:21:40 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DB64ECB;
        Sat,  5 Aug 2023 00:21:38 -0700 (PDT)
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qSBbU-0002p2-0R; Sat, 05 Aug 2023 09:21:36 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 5/5] docs: stable-kernel-rules: mention that regressions must be prevented
Date:   Sat,  5 Aug 2023 09:21:33 +0200
Message-Id: <ddb5cb0d6b7aa4ef31642cd9657a0fb53d79cddb.1691219455.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1691219455.git.linux@leemhuis.info>
References: <cover.1691219455.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1691220098;d8ef99a8;
X-HE-SMSGID: 1qSBbU-0002p2-0R
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document that changes intended for a specific stable series have to be
in all newer series still maintained, as otherwise users would run into
regressions.

CC: Greg KH <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/stable-kernel-rules.rst | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 2b7f04211d9d..41f1e07abfdf 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -56,6 +56,12 @@ at the time of submission. :ref:`option_3` is an alternative to the two earlier
 options for cases where a mainlined patch needs adjustments to apply in older
 series (for example due to API changes).
 
+When using option 2 or 3 you can ask for your change to be included in specific
+stable series. When doing so, ensure the fix or an equivalent is applicable,
+submitted, or already present in all newer stable trees still supported. This is
+meant to prevent regressions that users might later encounter on updating, if
+e.g. a fix merged for 5.19-rc1 would be backported to 5.10.y, but not to 5.15.y.
+
 .. _option_1:
 
 Option 1
@@ -133,7 +139,7 @@ Option 2
 
 If the patch already has been merged to mainline, send an email to
 stable@vger.kernel.org containing the subject of the patch, the commit ID,
-why you think it should be applied, and what kernel version you wish it to
+why you think it should be applied, and what kernel versions you wish it to
 be applied to.
 
 .. _option_3:
@@ -142,7 +148,7 @@ Option 3
 ********
 
 Send the patch, after verifying that it follows the above rules, to
-stable@vger.kernel.org and mention the kernel version you wish it to be applied
+stable@vger.kernel.org and mention the kernel versions you wish it to be applied
 to. When doing so, you must note the upstream commit ID in the changelog of your
 submission with a separate line above the commit text, like this:
 
-- 
2.40.1

