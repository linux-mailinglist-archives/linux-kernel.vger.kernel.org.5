Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E497550B8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGPSuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 14:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGPSt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 14:49:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193321BF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 11:49:51 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A14521EC0B55;
        Sun, 16 Jul 2023 20:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689533389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=Bf3ZJui8s1cEpFEztwJHC55MLiCs8iIoCTaUdjsn0fE=;
        b=aGi4tl9kp3cbLjSoGa4uZnsOFXZKaCnhDykDwMsvh0e/pLxZCCA6yS+NSQCWJg2WNDIe3w
        mKVDAiReLsoSL67xdmg9DILOCJn9HWWhiPkUkGCoGPgrMumVOOWiTPed7WSugVLqXkN7Ni
        rGOe1dtHQCcrEv0wWiSgvnmBCS7e6EY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bOWwyktzWvkc; Sun, 16 Jul 2023 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689533387; bh=Bf3ZJui8s1cEpFEztwJHC55MLiCs8iIoCTaUdjsn0fE=;
        h=Date:From:To:Cc:Subject:From;
        b=BrUHkHgzJW2XHTxFKrP/bQ9EMu0jXLRTUaFNVQc4wVyMw46+BxbyXGRCvLGrPC4aF
         kLb/bTYL0iTUrEYwZqsH8DzrZmvY520f4yH8sSEA+3uhgjs2X50FWMHmI4uCldXada
         BW/W67YerjadrkahIz8aSuYPHphIahOl0+igVfXrizeFNjNZK0o9B9MGqR+7nAFwH2
         Caw+QW2S1OhiL4VIxgyaMTUyXNCcRbgAmfH2Iy+Pjd1nrhfSgcOnLb5N1t+cshAF2z
         YSiNH+F9R4lImxKXqIOsMCWIKf0+lzQ4v63F9K4UnjO7abPRxZBONpFNGSYMyspv1+
         FR5lWki9g+O7BwaKGImQYEYZG4FaVtOpcsqT5dC9FRCeVYce4ugN9Q0VknADmuATR3
         +cGbMtBmIq4cz2ilbqLy+HYVIdcDDNCld3CWReUzxBMc8oMp7D9XYOPCMo8aLQqKNJ
         XIr5KkwA0hIDJ+SRgTqD+luc6goL8t68N1+mtvgJc86RiFIgFH7wnCECq218o86n3a
         Rw/fBTpCtqXp6ZjhTyZIvnKfhcOifvuIJfqUUkWMGyMzhxkd698y9HOTOavvk+NhPC
         2d/W7c9FHRbikoWMMvSb8Uhm8IQIw0/hP+5DGD+19XHJZtqD4YSFnPprHWf+LuTGUi
         T82GErpB3eaJ81WPemslRn64=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0BAFD40E019D;
        Sun, 16 Jul 2023 18:49:44 +0000 (UTC)
Date:   Sun, 16 Jul 2023 20:49:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.5-rc2
Message-ID: <20230716184943.GGZLQ7x4VZlQZb4aWq@fat_crate.local>
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

please pull a single urgent perf fix for 6.5.

Thx.

---

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.5_rc2

for you to fetch changes up to 27c68c216ee1f1b086e789a64486e6511e380b8a:

  perf/x86: Fix lockdep warning in for_each_sibling_event() on SPR (2023-07-10 09:52:20 +0200)

----------------------------------------------------------------
- Fix a lockdep warning when the event given is the first one, no event
  group exists yet but the code still goes and iterates over event
  siblings

----------------------------------------------------------------
Namhyung Kim (1):
      perf/x86: Fix lockdep warning in for_each_sibling_event() on SPR

 arch/x86/events/intel/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
