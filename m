Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D59B80BA3C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjLJK7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 05:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJK7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 05:59:51 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B18D1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 02:59:58 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 59A8D40E00CB;
        Sun, 10 Dec 2023 10:59:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YKlv-6rIx3XE; Sun, 10 Dec 2023 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702205994; bh=09II0VDiAiPcYozbcT3D2s+X2kXtp2YRphoTnEr86tI=;
        h=Date:From:To:Cc:Subject:From;
        b=Wwv23EeFBKNef3aLw5+AegfUKGswqA8s6EAfdew6Z5+ln0QeCdBpq1UnRT/Boo6gu
         XYb2NKNEiTs0WfN4KbljsUG1I5DOmXsUQ30QIxfdo5m9IVXHgbV67WtZMdd8d0+hA2
         BcJA/RIHZnxUM+HbaMQPu1Z8C6eu7s4zqAhYiTf1/ix698VraC2dMEIw6NhVcw8Udl
         KAsYeX4EVcPWtM676olz33iMn2ehDb8DRzzaOoSfkJ1qb+j3/xcIBQ7gfZ/1AgkozX
         pZ6f7Mq/lb5BkvOTvKNiwgs+gVO4avvCgFyGoD6DrnVnYXxTcm9pcfTaHBsa3NsFgx
         /ajxGty5KdjVawS1GaRUCHYD6aFeSYp0WqxX9EplgUpDd3JChWPMBpfsoSk+1odFxS
         Y3bPq/8aMYBrY5yOzTo4spRIFDIn80xPQ8rWlItf2n5IsvBLmX9jj/THieP0F9x4wP
         xai8Ak5UE2JTgl8lZe67S3dxciHeH2QraPL/qd7Be/eV6hloJu8SAi9PxWXuZnoRTr
         qGisHUYXAJRznpfYcczW8oxB1NmoCL2SHWcCBk0/vcrNsde35JgmcgOcqb5I9+/oM+
         b9faS7LJGMlwotGilOnRyy3ynWghoHekmZYrIATT/mRB3zlwxLRJsMkC7kx6p/8H7I
         8nFlT9GQfdtrJ6o/S7kovMJI=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 813E240E00C5;
        Sun, 10 Dec 2023 10:59:51 +0000 (UTC)
Date:   Sun, 10 Dec 2023 11:59:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.7-rc5
Message-ID: <20231210105949.GAZXWaJe6DeHU9+ofl@fat_crate.local>
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

please pull a single urgent perf fix for v6.7-rc5.

Thx.

---

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.7_rc5

for you to fetch changes up to 382c27f4ed28f803b1f1473ac2d8db0afc795a1b:

  perf: Fix perf_event_validate_size() (2023-11-29 15:43:50 +0100)

----------------------------------------------------------------
- Make sure perf event size validation is done on every event in the
  group

----------------------------------------------------------------
Peter Zijlstra (1):
      perf: Fix perf_event_validate_size()

 kernel/events/core.c | 61 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 23 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
