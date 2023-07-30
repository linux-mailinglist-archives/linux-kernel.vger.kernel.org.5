Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6F7684B2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjG3JoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 05:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjG3JoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 05:44:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AF919A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 02:44:23 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9A011EC09A6;
        Sun, 30 Jul 2023 11:44:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690710261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=cJgnnm/2lMjOUI2vycfZpz/QK4LO/f3Z5hnK4V5LwME=;
        b=PLMCHQpDhGd8mTkzxFRKmlZEpjQiwYSdCoa4DoSQkwIqQYRbkKH13Ok6dsP3ZJvSRn6zaH
        fyirtsj5DJ1mqlv2WZd9PuSxcm22l0eoj4OcGOEDrbuuryXveElUd7SE/GdBlipsp0uy/n
        DNaAW8BsnzYuT+xprPSnqH+G5ju5AI4=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id w4eid4cD87eD; Sun, 30 Jul 2023 09:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690710259; bh=cJgnnm/2lMjOUI2vycfZpz/QK4LO/f3Z5hnK4V5LwME=;
        h=Date:From:To:Cc:Subject:From;
        b=C1DXp04CevlYqQT51Kjp5E6bXmdy+3veXuWYu8ARlN+gbP3vJE+EvrxPwNiOGEOvi
         JO77AFX/pnlSgGbv+LXEWkXlp5GEdPW8ah1oicZkOKJqxdM83Ob4Ht1YhlLu5imFG0
         ovBOMlTONS6HOI+aFXFY5mZEFJ66lC9Q97truYpKgeslEIY+FpHQz73Mikls5jJj2y
         vtcEYJiGMLG2mC6YdWrQQv6nAAFenaKGtzIG1nDw9wo1tI+TzEDYUFehlvo1M03EOZ
         3lNjWbFWr+0EvY/r1+SnWw73pNq5g5NAz43yb/0mguFugAJCKrPPdYIw8bUUbvd43b
         qWbrGPUUmCw5PGdbZ/PilpPxcwzmNv8LPIFcIohVnSsQlqRaffmFCDYIIbSPII3dl5
         9m+1XxICHCU5On2bZmJfzUMtr6FbOouXjuMmrBLRmsBFdIAz2m8QUmVUqRPwZMuq33
         WeDA0zib13hiZ89U6CfGYP2DTrFvh6VDYoYgWZXhJxGuMQAqsVP9pONoxzUVaEcCuI
         HlWejSQIgM81NK3mbDljq56H1/9glujVWTEXuJf2C4fto/9rgJEa0u2QSxgXZsVCmq
         zOLdtgn/eB2QqKqGlUsuyPPikeFUkR3Sf0T+FA4vhWEjD7XaOKUsNrXO+KkE02XUl+
         vtJT/04xvUvUwPPhm/+9D8Nc=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0809D40E0034;
        Sun, 30 Jul 2023 09:44:16 +0000 (UTC)
Date:   Sun, 30 Jul 2023 11:44:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v6.5-rc4
Message-ID: <20230730094410.GCZMYw6t2O0L+N/93z@fat_crate.local>
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

please pull a single urgent locking fix for 6.5.

Thx.

---

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.5_rc4

for you to fetch changes up to f7853c34241807bb97673a5e97719123be39a09e:

  locking/rtmutex: Fix task->pi_waiters integrity (2023-07-17 13:59:10 +0200)

----------------------------------------------------------------
- Fix a rtmutex race condition resulting from sharing of the sort key
  between the lock waiters and the PI chain tree (->pi_waiters) of
  a task by giving each tree their own sort key

----------------------------------------------------------------
Peter Zijlstra (1):
      locking/rtmutex: Fix task->pi_waiters integrity

 kernel/locking/rtmutex.c        | 170 +++++++++++++++++++++++++++-------------
 kernel/locking/rtmutex_api.c    |   2 +-
 kernel/locking/rtmutex_common.h |  47 ++++++++---
 kernel/locking/ww_mutex.h       |  12 +--
 4 files changed, 155 insertions(+), 76 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
