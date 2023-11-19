Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2963B7F06BB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 15:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjKSOIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 09:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSOIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 09:08:23 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29389E6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 06:08:20 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2AE7840E0171;
        Sun, 19 Nov 2023 14:08:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gWn2q1ceo5Kz; Sun, 19 Nov 2023 14:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700402896; bh=kT+oG024KE0VJq0wyblDLolJlfvCsKzYhNk126iiReY=;
        h=Date:From:To:Cc:Subject:From;
        b=ih/TZF1QQZKTICyts+SgU/ikOL/GwvKyTm8E8fc0LgFSLkI3amNTzgazJ0caN9rzD
         l6I89CU46iAZm0D6e/b75m682mxrG09Zw95IQRQf7wTUvqrqdGDtM6UReGrm02Z3kb
         lazutJrMmmqmU09Nnu2WFLQMvaVeDuJWcqoD1r3mX1qt4N0k1DQM1TNHKjGAdBIF2g
         DI13Wel2yltLAUnfLebt9ouyqLoUCFalFAYYryb9miahnK4GRgJ2lNczY/wWZUmctn
         kz0b5xA2BTACc07oo40ackYK3K2LDPKGH2c/MIjnpdeFGWnQbQWLks5TJS9tZy8fDd
         AWwnyZ8aAJyTsZXhGhb1u0+D6mjH3b7RSF3KycTNXDxTTIdBStdm/EcwItGRtCyiKk
         vrcsfQBQELlNrnLNvLTWgOEEPLsWG8YKlt5nknTqnbYkhNVCVWCC96x48HFJwz6MKp
         HCl4dVh/MicyiOMxH79dwauwMKStzGgxCR3TWbD+oShkV8jVQJmCKXV25opTYkqaVH
         xtKnj4w2NvBi32VAoUMt7O6wV/1MO9fwWo8ipDK7BJWhz6S5nrYI7LD7qH8ekqwCKh
         7EuQqoLNGcRs+CdVGDnh1jeGZLY3Gga6QsLlu1iB72dUYvQ448CAdASkI9bzFpIC2s
         H7fh56Tq1z7dNX7R9f3Qj7B0=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F411940E0030;
        Sun, 19 Nov 2023 14:08:12 +0000 (UTC)
Date:   Sun, 19 Nov 2023 15:08:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.7-rc2
Message-ID: <20231119140805.GAZVoWxXNTMoe+M/zD@fat_crate.local>
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

please pull a single urgent irq fix for 6.7.

Thx.

---

The following changes since commit 8999ad99f4cb19638d9ecb8017831f9a0ab8dc3d:

  Merge tag 'x86_tdx_for_6.7' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2023-11-01 10:28:32 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.7_rc2

for you to fetch changes up to d3badb15613c14dd35d3495b1dde5c90fcd616dd:

  irqchip/gic-v3-its: Flush ITS tables correctly in non-coherent GIC designs (2023-11-06 01:16:33 +0100)

----------------------------------------------------------------
- Flush the translation service tables to prevent unpredictable behavior
  on non-coherent GIC devices

----------------------------------------------------------------
Fang Xiang (1):
      irqchip/gic-v3-its: Flush ITS tables correctly in non-coherent GIC designs

 drivers/irqchip/irq-gic-v3-its.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
