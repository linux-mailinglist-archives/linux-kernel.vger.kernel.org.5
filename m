Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1A7F063A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 13:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjKSM6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 07:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSM6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 07:58:04 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5C5B9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 04:58:01 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C5DA840E0191;
        Sun, 19 Nov 2023 12:57:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IBD6oGHS2qgR; Sun, 19 Nov 2023 12:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700398677; bh=zEHFaZ88zzwqzod2rooBuMwnm2KfigYzVKU+Z5qB6vo=;
        h=Date:From:To:Cc:Subject:From;
        b=V2uKmPO3SzLp+wYrC0/tbmh/BtssgCTskghJ139ZD750u5tN0EydH4KBNpWFyh3mD
         /egZyq2BWr5U9CtYwZR0eAWrS9ipIVyKiCp+3AsfON7DzsqT4iTP9UIMoW7auKYGL5
         QuRC/sbuVQFJAatGPCqGFhjE2QNTo4SGOinZQTjnixUMP6WUlFabP0h1jrxvH5TydE
         xKBaf3kTuZ2gH1ZOv+lOgEvfXnVD3UumGuxaTvyRYDYcwhwxR3EmnjUXfMH7AyBJDf
         zorocMcxx4Onvej9aSgIsHRH417AEMTWpU+pXczt90bsj5BE9tWbVkMQyr/Y1MQnOg
         Da0jmE9MbxQ5iYcsPJJTLR/rK/p75BdwfZJzLB0hZ3ENffgp8KYu8SK3GUDhot0q3i
         NPZ2iMK2BNBa8CXfG5/6o/JuYUkk/sYpzEOS/x5DtCyHbFoeBd4PTAIpePmuWKH66O
         XgpUhCoVpuX3bA1JJ79fs056yWse86JOsKgsYxbLblhyr7nnjVWEvY8rQYhaN8ONr/
         EgRiBGtGzGHXUsrGEGMoWM+B1VBWg26IgzJtkJ8W4DAU2wgtPHsjGyZLgLy3OVxpTr
         ffBAy2CPflvPnzpjvnJya2gEcgcRFWtNcABje5sUpIGXpCGlSS5UauK4BqDmJV9bLf
         WOrJXrMTZyB+kHtSlBcUvxOU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A952940E0031;
        Sun, 19 Nov 2023 12:57:54 +0000 (UTC)
Date:   Sun, 19 Nov 2023 13:57:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.7-rc2
Message-ID: <20231119125753.GCZVoGUQHr5N9ILels@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a bunch of urgent scheduler fixes for 6.7.

Thx.

---

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.7_rc2

for you to fetch changes up to 6d7e4782bcf549221b4ccfffec2cf4d1a473f1a3:

  sched/fair: Fix the decision for load balance (2023-11-14 22:27:01 +0100)

----------------------------------------------------------------
- Fix virtual runtime calculation when recomputing a sched entity's
  weights

- Fix wrongly rejected unprivileged poll requests to the cgroup psi
  pressure files

- Make sure the load balancing is done by only one CPU

----------------------------------------------------------------
Abel Wu (1):
      sched/eevdf: Fix vruntime adjustment on reweight

Johannes Weiner (1):
      sched: psi: fix unprivileged polling against cgroups

Keisuke Nishimura (1):
      sched/fair: Fix the decision for load balance

 kernel/cgroup/cgroup.c |  12 ----
 kernel/sched/fair.c    | 161 +++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 135 insertions(+), 38 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
