Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A89752DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjGMXFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjGMXFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:05:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5B02D73;
        Thu, 13 Jul 2023 16:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A518661B45;
        Thu, 13 Jul 2023 23:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB17CC433C7;
        Thu, 13 Jul 2023 23:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689289459;
        bh=Z1s5R43qfeyf0CsFH9TvxSaOG72jfmcq8W4z9hdnCrU=;
        h=From:To:Cc:Subject:Date:From;
        b=FmTemCxFBZCobEeGXA4UWVt6IO3vYs2m/5m4OrJSP8JpSzalMuSUWEuNwAUaj2JD1
         o10VdAGTPPOXAzy9Axkb/aFBFXVXDdqJKqgLx0mQfoLm6FvQK8PCqRXIZzA7SdHB4h
         OBMFYz9TWbx/r2CnM+fvgucRstexPghR/sBElQUUgq8ZLfuUQ6qMeGOes60+doGMHo
         6I+ScjAWaMagJw9X/P/5/Vgox+xksvf82itSxYJ+3IzmD2BPgE0vhaYIWmtiW/9b0b
         JultZ+R8jPKl7eOH0mTyiXKMT/Y6m2NKGH6VWRi7ulvLPRpWq2csBi+G4D9u6gsr0I
         dxcyFUK1Q3zrg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     corbet@lwn.net
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        torvalds@linux-foundation.org
Subject: [PATCH docs] docs: maintainers: suggest including lore link for conflicts known to linux-next
Date:   Thu, 13 Jul 2023 16:04:17 -0700
Message-ID: <20230713230417.1504773-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not completely sure what is the best practice for notifying Linus
about conflicts which have already been resolved in linux-next.
I presume they are a no-op to him, so maybe we shouldn't even call
them out?

That's the question I was hoping to answer by reading this doc :)

For the small-time maintainers who aren't Linus including a lore link
to the resolution from linux-next is the most optimal way in my experience.
Sometimes people put the whole resolution diff into the PR message
which occasionally confuses merge prep scripts making a mess of things...

If Stephen already resolved the problem, just include the link.

Cc: torvalds@linux-foundation.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/maintainer/rebasing-and-merging.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/maintainer/rebasing-and-merging.rst b/Documentation/maintainer/rebasing-and-merging.rst
index 85800ce95ae5..4134e63528fe 100644
--- a/Documentation/maintainer/rebasing-and-merging.rst
+++ b/Documentation/maintainer/rebasing-and-merging.rst
@@ -175,7 +175,11 @@ So what should a maintainer do when there is a conflict between their
 subsystem branch and the mainline?  The most important step is to warn
 Linus in the pull request that the conflict will happen; if nothing else,
 that demonstrates an awareness of how your branch fits into the whole.  For
-especially difficult conflicts, create and push a *separate* branch to show
+conflicts already resolved in linux-next include a lore link to the posted
+resolution.
+
+For especially difficult conflicts and when linux-next resolution is
+not available, create and push a *separate* branch to show
 how you would resolve things.  Mention that branch in your pull request,
 but the pull request itself should be for the unmerged branch.
 
-- 
2.41.0

