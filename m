Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B78768499
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 11:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjG3JN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 05:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjG3JN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 05:13:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B338F19AC
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 02:13:17 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C772A1EC09A6;
        Sun, 30 Jul 2023 11:13:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690708395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=N+V0U3MZcKxkYwmH5jmUg4h3OJxnopEeII9e4YtTv0s=;
        b=mHH9Ccq7qsYbQ71B51uuEvHDNm9hZqXc5spAllZR1zSS9I58Af98HvgfYKL9CidjSiQZDs
        z0Uc4euoNUn0wWsAJl8Fpy/QByfscdhKmX9M8D0r1GzrSi8luY/TMW8uehlagsgnbRWRwv
        L/f1te6322QcH/tFYXuWtK8R7RoNi2k=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z6M5Hz8HAWu7; Sun, 30 Jul 2023 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690708392; bh=N+V0U3MZcKxkYwmH5jmUg4h3OJxnopEeII9e4YtTv0s=;
        h=Date:From:To:Cc:Subject:From;
        b=SM9nAGz1T/y+bisPJzJaQkeUGJGx0YBDfEwhq+P/4m8zdxLd8Wsk0MBBz8dvHWhC8
         G6EXP2EpUpwgonUvPZqRIzUyltxWFmlGPMTyC7zP2ywv9yMYDOR6T7JPfJ6GsVitzw
         suaprL9FTwHqUOtOrklbfAlhkRa1oQ8u8k/Ou8pDxvROogs5TwXoBEFviUK8lYE9Mi
         fQfJrmxH54Dl621TnejM1Ft7Fjsx8kM2N0FgPqH1PVleLcjLWQk/qa2aqHbb4tFjXf
         TeBK/izYTtREw1fjRVkTJLGKP/kZF95NQcJIfaYHffuKwT/9aMkEoIO+PuICAFoLQB
         zaMSNoUXeCedM1mzoNvM9mU9ZB3Jj6824Qba9vGbZvN5cI4M821GCeHzVD1qrK8bp5
         QoLMHNplZitWVQ2Apuv2iij6hDE+LWSRmbuRhSXG6+hHmfEvzRBBMlEU4yvqs9e2nL
         UHi+9wAyHe5r7Vv3Z+EUvmIjiX7RyAnPpMtOQpO4O/kJzDm2bVOoRYCkptGU4L1Aen
         zDbYjCLC3beJDmF4HZueUDldlvWSmCk6Z40WuEyIkD2ZGrlsRUPZlcpdmHS6w98l6a
         HQhmU4CA95meEHMdtWYIkeCgNAMCoglivTLJYH+XmrxV2LUORgz6XBe6c2JnOfI+kQ
         lIhvMxAnzRnOpBPPuao/RsgI=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE19140E0034;
        Sun, 30 Jul 2023 09:13:09 +0000 (UTC)
Date:   Sun, 30 Jul 2023 11:13:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.5-rc4
Message-ID: <20230730091303.GAZMYpn+LlFokfH0XD@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NO_DNS_FOR_FROM,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull urgent irqchip fixes from Marc Zyngier.

Thx.

---

The following changes since commit 67a4e1a3bf7c68ed3fbefc4213648165d912cabb:

  irqdomain: Use return value of strreplace() (2023-06-30 11:13:44 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.5_rc4

for you to fetch changes up to de990908521073d98a46ad0e29885df447e95242:

  Merge tag 'irqchip-fixes-6.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent (2023-07-24 10:27:43 +0200)

----------------------------------------------------------------
- Work around an erratum on GIC700, where a race between a CPU
  handling a wake-up interrupt, a change of affinity, and another
  CPU going to sleep can result in a lack of wake-up event on the
  next interrupt.

- Fix the locking required on a VPE for GICv4

- Enable Rockchip 3588001 erratum workaround for RK3588S

- Fix the irq-bcm6345-l1 assumtions of the boot CPU always be
  the first CPU in the system

----------------------------------------------------------------
Jonas Gorski (1):
      irq-bcm6345-l1: Do not assume a fixed block to cpu mapping

Lorenzo Pieralisi (1):
      irqchip/gic-v3: Workaround for GIC-700 erratum 2941627

Marc Zyngier (1):
      irqchip/gic-v4.1: Properly lock VPEs when doing a directLPI invalidation

Sebastian Reichel (1):
      irqchip/gic-v3: Enable Rockchip 3588001 erratum workaround for RK3588S

Thomas Gleixner (1):
      Merge tag 'irqchip-fixes-6.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

 Documentation/arm64/silicon-errata.rst |  3 ++
 drivers/irqchip/irq-bcm6345-l1.c       | 14 +++---
 drivers/irqchip/irq-gic-v3-its.c       | 78 +++++++++++++++++++++-------------
 drivers/irqchip/irq-gic-v3.c           | 62 ++++++++++++++++++++++++++-
 4 files changed, 117 insertions(+), 40 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
