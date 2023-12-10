Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB480BA47
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjLJLJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJLJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:09:26 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34975D9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 03:09:33 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C8E940E00CC;
        Sun, 10 Dec 2023 11:09:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ToIbD_q8wRBg; Sun, 10 Dec 2023 11:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702206569; bh=7WNv4qtpX1+eq/BofIjrMkMwhfxln7sbW+CENUkIFEo=;
        h=Date:From:To:Cc:Subject:From;
        b=cDXMRL8COprwwPnbYLqC5J7TeN4GWkLpBdLJhBMVnRAAJ3p9rYSh1g5Nu+WpAqbI8
         OR0cGkLK+X57/4eYIQtYvdxiLM8doxoIRv5DSUXC/Q7kUwLQbEOatB0jkAiPOqj/FD
         enGUFUfQBlf2gSOpCnt+qHqAA/JxXXM3oqOiK/loopa36ysmETrLYc1Si98aTD+UzD
         cBzi7lD4n8/+pDR5NMqpiu1ez9kEtV7GNuBadOaucwI69HI2hPG0uyFkCM3hwPcH7r
         HuhnE+hWKw7Mcg8SIH+8c1joQs9dmbcVrE6/iEMYJt01FHvHexP2PSm6LvigoOJWkZ
         NppuTh/cBCpdc6Li8wrWZspN3dUgDSAeCHHRvgYiXBMX2VMwdjFNMF2dD4SYGaCdL/
         lYNN/xnEzeRpRR5koMeJMwkfmfyD01l1DroeyPEfXzv6F6DKNndoVnBdp1vfpuabe3
         AlkMWf2WKMHsEtYHiocrd3jDEotc0eVv5bH3QN0F8pwGojsRL7Pw9RV3Q1d8HIp7EV
         TrDm8fc9O0+6UZ91RILJhsrMnTtt2t8GNRkpRBjeM+jQFlXiJBG/eLAGvZ1MDi5vpL
         +7+T7y4VgxBeMRDeDzAKQTxc+IIfVLADp5cXzwASWaZwIqkRBFnghivmwzM+nRNrj8
         PR7m10vlYQVm1baderFsstTM=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8BD9A40E00A9;
        Sun, 10 Dec 2023 11:09:26 +0000 (UTC)
Date:   Sun, 10 Dec 2023 12:09:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.7-rc5
Message-ID: <20231210110924.GAZXWcZIYk7wDdydJS@fat_crate.local>
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

please pull a single urgent scheduler fix for v6.7-rc5.

Thx.

---

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.7_rc5

for you to fetch changes up to 23ab79e8e469e2605beec2e3ccb40d19c68dd2e0:

  freezer,sched: Do not restore saved_state of a thawed task (2023-11-29 15:43:48 +0100)

----------------------------------------------------------------
- Make sure tasks are thawed exactly and only once to avoid their state
  getting corrupted

----------------------------------------------------------------
Elliot Berman (1):
      freezer,sched: Do not restore saved_state of a thawed task

 kernel/freezer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
