Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED77A79422E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbjIFRrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjIFRq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:46:59 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2085E1A8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 10:46:54 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RgqZ34HL0zMqBHj;
        Wed,  6 Sep 2023 17:46:51 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RgqZ24LfwzMpnPr;
        Wed,  6 Sep 2023 19:46:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1694022411;
        bh=TfkqCFw9fQU2v552mpoFTO2ELWAlUDWmCzHIa660XPY=;
        h=From:To:Cc:Subject:Date:From;
        b=ClhOlrVfLd19/EMmD/j91maQdpi7SfIAKBFvDhtIZAglJD4QFB/PIqNnzG9Z8Efp/
         0xAXJkuaRlO7fHWSI24ppbRag2J77XptIH7BLdt+iRs72oFpmVciiu6rwKx7N76mGt
         ah3coHZOJ+eiiyH5qBLvuvgcH98S1lzX0csvMnLc=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock updates for v6.6
Date:   Wed,  6 Sep 2023 19:46:38 +0200
Message-ID: <20230906174638.189459-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This PR adds one test fix and a __counted_by annotation.  Please pull
these changes for v6.6-rc1 .  These commits merged cleanly with your
master branch, and have been successfully tested in the latest
linux-next releases for a week.

Regards,
 Mickaël

--
The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.6-rc1

for you to fetch changes up to 2a2015495142ee0a35711b5dcf7b215c31489f27:

  selftests/landlock: Fix a resource leak (2023-08-30 18:53:08 +0200)

----------------------------------------------------------------
Landlock updates for v6.6-rc1

----------------------------------------------------------------
Ding Xiang (1):
      selftests/landlock: Fix a resource leak

Kees Cook (1):
      landlock: Annotate struct landlock_rule with __counted_by

 security/landlock/ruleset.h                | 2 +-
 tools/testing/selftests/landlock/fs_test.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)
