Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2633E7F0635
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 13:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjKSMt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 07:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSMt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 07:49:27 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE0C2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 04:49:24 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5736540E0191;
        Sun, 19 Nov 2023 12:49:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RE5be2dXbN0k; Sun, 19 Nov 2023 12:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700398160; bh=iz8U7lF5R1vmoQUt2UXXlLqYcGtsUr7NDwKO9d3sxZY=;
        h=Date:From:To:Cc:Subject:From;
        b=BCkM97yqDmi9xrD4ojpeOGMKlBnlSVWNSsvuowNdeFQcRZsV+B/Ua3VVWRVxrrxZz
         3hbZn7UhgZS9C/av1oaA06PTKd9WkaXZOKqSGinS4NlRfbCgZjQPQkdyp7X3OgU2Ch
         qMvdVyHoYG0cARFf4+GEZ44gM82rEktKpgytsGWuzpp8jr778++z2K9TtzvYvKZrgR
         kZhFIb2qVmIX3dTlTEIfUwbtE4K2tNQuTjfQHWWnza+PdFZkmSDAyR6XCDmKhCwMPD
         qAJdr9B5lwyWWJ+244uKbPk4oM3mMvUiYFoJaDm78CkmkPnKk+5D50CKoB+CVkCMQi
         SNrI1W62JtwaR1KFhubMxtaF1GFf3QgAa4S8bSdLwTjrtl7N2a2zpyNlV8Itd8jPd3
         G9Cwn0TeQF/uLZWSyLmwmzqgi0WyDr2jx1+eLk8Y4+4KK7oXWTtcAlSxh9FvCO09rd
         dDQlcbJcstIthSWFjrRno+sNp4IBZD4ixJ+5z83cCT36fh2V3LKiSki2VkxqUtUjhC
         /+ephRCyflwOWwyOl3z4O0evmwoGzOQScvV3LoEulKa3byl6gsRpq1MmDYRPtk3mdY
         wr9N6Xaw1nDxCwkdndKpT9YbPLHtQuEh5Y1EsiCAHVwXJCxZfCTH7iNFttXjfHJsl0
         CRbcCNvEb1FIgdEltqTm5doo=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9E8A40E0030;
        Sun, 19 Nov 2023 12:49:16 +0000 (UTC)
Date:   Sun, 19 Nov 2023 13:49:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v6.7-rc2
Message-ID: <20231119124911.GBZVoER+18ZrR1geho@fat_crate.local>
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

please pull a single futex fix for 6.7.

Thx.

---

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.7_rc2

for you to fetch changes up to c9bd1568d5462f4108417518ce1af7b924acfb6f:

  futex: Fix hardcoded flags (2023-11-15 04:02:25 +0100)

----------------------------------------------------------------
- Fix a hardcoded futex flags case which lead to one robust futex test
  failure

----------------------------------------------------------------
Peter Zijlstra (1):
      futex: Fix hardcoded flags

 kernel/futex/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
