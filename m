Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92627DA60C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 11:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjJ1I6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 04:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjJ1I6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 04:58:15 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D48F0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 01:58:13 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E223640E01A4;
        Sat, 28 Oct 2023 08:58:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0eXZT-Wx-o-g; Sat, 28 Oct 2023 08:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698483489; bh=mr3QWdB73HaXgDoe666bSEFWwqICFYnqYysJ66nia0M=;
        h=Date:From:To:Cc:Subject:From;
        b=PxL99Dbz8hy/RjSIxum/Fzo2yKPYWhHmJvUCb38aON/pyjs1bxVue1NIOAfv47mwA
         Cm0iJPjQN/amsSc3dSkXK5IN/usb6ym/tgbt7HUvgppTCbOfuRB9EULjEIpeMXAp2u
         F9cP8DCMpuF7XOBDlKWLV9lGrTJtIylh0SkKC5VSQUksIU4QhYQb0wK4VXgqqqHYeh
         xM5dlYHTYuRjGp+/2U+CFVFaPLP1C/aTXOWV3LrECYjhhQS5yTdsHcTKAkTLCa3NnO
         HnnNwI2qNT/9dO4kSI14RKVXOVAkeolPAlOWWCgdZ5Y2di8eu9IbOD25XPCCLu10zx
         WmFFiCeKjhHSG5izS18V9dl0cVY+O57lDmF35D9wadbWKm2OP8o+SZUntKQBZ/BTv4
         43/ZmHrAybjmf0YLzqBpGMUGbQeXNkiRJqSu6Ry+Vn1Fv6pwvHhvvb7Z762oyLUDoX
         QoekdOGc6YeK4QLt25nmGHW62OJOkqGD1dgrHJVKHWn9gIZqs22er5Z/DXtHoMg6un
         JiOfu5pomUHUQuHXjtvg9JA9zJJLyIeufTcaJ6mauuP8GnSpaq8x6mLN28fSEjdg2+
         XTr/BhvwrveK6H3+PF2+aqp+YrQMkV+nxiAYGQn5R90wkgb83TU3Cfj6xZEU+WQVlx
         2JrCFsUlq76hwqAHtQyG0DIU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D1E3740E0171;
        Sat, 28 Oct 2023 08:58:06 +0000 (UTC)
Date:   Sat, 28 Oct 2023 10:57:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/fpu for v6.7
Message-ID: <20231028085759.GAZTzNFwTVps6lLNZO@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single x86/fpu fixlet for 6.7.

Thx.

---

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_6.7_rc1

for you to fetch changes up to 90879f5dfcf6cf1d56f4d1b696a25c44e1f5ba14:

  x86/fpu/xstate: Address kernel-doc warning (2023-10-03 22:46:12 +0200)

----------------------------------------------------------------
- A kernel-doc fix

----------------------------------------------------------------
Zhu Wang (1):
      x86/fpu/xstate: Address kernel-doc warning

 arch/x86/kernel/fpu/xstate.c | 1 -
 1 file changed, 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
