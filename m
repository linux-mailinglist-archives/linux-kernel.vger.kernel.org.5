Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1DE7F0643
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjKSNEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjKSNEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:04:33 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA02138
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 05:04:29 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 32A5640E0191;
        Sun, 19 Nov 2023 13:04:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CbNtfTxjyutd; Sun, 19 Nov 2023 13:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700399066; bh=0wL1M9zoh60qJBvNk/VKoM237wV26ubTQBBCPvcxsTY=;
        h=Date:From:To:Cc:Subject:From;
        b=Uq7BmxjL7OM1AczPQMql4f7e57BTFdMZ+wABBnGaL5F1NQCYmp23Wk9vjXwQP276i
         msLY3xZv+RP6EeaDFYf3UADvN+HIQHjtGKKzvnyL6n1NhANpjHt3A257sQGFwsJ4P5
         FUuQSTd1DRi+mcqCieb/kUa3eLhGAWSgIfDdhNKRS13/1SniUT9OLoYTDxY0mpoAOp
         xAE+BvGzdaBQHjzhe7xWg4NC5AIAnemaoElNvb/h51tClBdHT8cdFmotjL72jvY0up
         +8+YULFW5MY3XVVtuSdxttHZHyUYP0ovhppJSym8W/hNBlvxiKcwEMQ24OztCk10Bi
         yV8i5cS50X8A3x8h6A0koEYiuKdu7I0m06zlUHfqBr0Hft8jZg35Tl5uZxAoRRLcc6
         x6E5GdTVNL4nrLoUmxSR8J5cOyOrK9DDFBzpnZszdT+vOFUhiSDC3bwEj0aW3H9Flx
         QDWcR2EPWfn5vHEqXroGWRHEsV3G+/elzbLHNPt3c93hRoxNjMWHnh1GJdPQ4ed6g0
         UyHUfEw04SAm7bFra1OjUfyLVzXJ/DULpnXBOf12CJADpJWvtF3RMus/nxQefeGyUo
         AZETxMSfgE1i7W/XYkr+rTQnKsC9lpDo2PKVxXTqHW8a4J//6nolx4kOkfGgOtFxwF
         KHvwwT6yEvkdYIG9gIDYXjm8=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D823540E0171;
        Sun, 19 Nov 2023 13:04:22 +0000 (UTC)
Date:   Sun, 19 Nov 2023 14:04:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v6.7-rc2
Message-ID: <20231119130421.GDZVoH1TocfbiUjKfA@fat_crate.local>
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

please pull a single urgent timers fix for 6.7.

Thx.

---

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.7_rc2

for you to fetch changes up to 5c0930ccaad5a74d74e8b18b648c5eb21ed2fe94:

  hrtimers: Push pending hrtimers away from outgoing CPU earlier (2023-11-11 18:06:42 +0100)

----------------------------------------------------------------
- Do the push of pending hrtimers away from a CPU which is being
  offlined earlier in the offlining process in order to prevent
  a deadlock

----------------------------------------------------------------
Thomas Gleixner (1):
      hrtimers: Push pending hrtimers away from outgoing CPU earlier

 include/linux/cpuhotplug.h |  1 +
 include/linux/hrtimer.h    |  4 ++--
 kernel/cpu.c               |  8 +++++++-
 kernel/time/hrtimer.c      | 33 ++++++++++++---------------------
 4 files changed, 22 insertions(+), 24 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
