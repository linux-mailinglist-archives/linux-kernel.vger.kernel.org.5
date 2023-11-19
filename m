Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E5E7F0631
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 13:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjKSMjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 07:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 07:39:14 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF160131
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 04:39:09 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 030DB40E0191;
        Sun, 19 Nov 2023 12:39:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TNvRTqsYTnbQ; Sun, 19 Nov 2023 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700397544; bh=YicfXqtbJsMLRVI3JBK0/NfpA3EkJxvF0Ygurr5QvRM=;
        h=Date:From:To:Cc:Subject:From;
        b=fzorWOT1/A+XUomUryAhg8ahlTG2ftwu8SbKsUQjZ2xbte54L4aZ29rtMQzdrsBhO
         jOxcZAwbHX0i45GGD2bOEdu+xavl49CazFAE4L7EFw9KGiXKowQz4wtLPLpFHbmLRc
         XPOzurbK+AkMUHqdAWJKbEPu+qrpP0vbdnaMdkrTO7w9oV/i/JC8d6OhGaYwcsg+y3
         2bGq9xYuwvVnBv5SXwYNLE125o7RZRKa/ShO/NPHZJJtAFdQPZ29xAwVidc+Hyo6r6
         fbpeaLqq6P9HTpY/78QPwbcAEBtRNay0PIG4WpWhVmVb09ZQ1zU4y+qlinGQvxG/Fk
         a25+nEr9ONR4d0xCYO9qTbweaWCSJZG1VnuZE/79kOirkZDrgCKGoyRf6w0QptzrHn
         NRIOSMgZS4mAVkFy2EyaQt+wIxQLURnieJ11kyOKzcNdP+OkgxKO1Ig3l1e4n7FNv8
         xti7pbxuJTGCR1OcmGjniYNE8Ivkdusp8ozT+nBgqBCw9RpY+2ZVW/iM8Axk7kywSR
         K4Pd+YY1MuIq3U2hwQGfJsw4aq6hAU2utG0bdntY4w6VMYWta0ZYxxXaBAe4qiO/2w
         6SR7k5GzHT0+bfKoT4VWBRBzj55GTGtMJzLNUUUk/zKD5nFl+f7jDX8Va/cqk7dMiN
         ydL6Tbj+V5UbO4yMvyM0i3rU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BA70040E0030;
        Sun, 19 Nov 2023 12:39:01 +0000 (UTC)
Date:   Sun, 19 Nov 2023 13:38:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.7-rc2
Message-ID: <20231119123855.GAZVoB39FG7JDZxDN6@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent perf fix for 6.7.

Thx.

---

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.7_rc2

for you to fetch changes up to 889c58b3155ff4c8e8671c95daef63d6fabbb6b1:

  perf/core: Fix cpuctx refcounting (2023-11-15 04:18:31 +0100)

----------------------------------------------------------------
- Make sure the context refcount is transferred too when migrating perf
  events

----------------------------------------------------------------
Peter Zijlstra (1):
      perf/core: Fix cpuctx refcounting

 include/linux/perf_event.h | 13 ++++++++-----
 kernel/events/core.c       | 17 +++++++++++++++++
 2 files changed, 25 insertions(+), 5 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
