Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF8E755089
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjGPSmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 14:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGPSmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 14:42:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77029116
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 11:42:12 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2486E1EC096C;
        Sun, 16 Jul 2023 20:42:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689532931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=GxGezcAwkBcGtUwyX+J8v7tcHhZV47pZ7EUlmh0zRns=;
        b=F8j1ZJUhTdfWLVST64hzEpk498a97DOBXNoaGkvD1V/qAzSueZF2Lxd81JcjHZrYFIyb6z
        6ww1mmRNHInqjNLTVqKb5nlkDDmf9qRRmZ7o4R6ZJZDLrYWEyzxYynIg1Dgln+8mHsay9Q
        LVFqQFVIgZVhgBWi2ff6uPfQ1OoY1+M=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0bR7prrroyNn; Sun, 16 Jul 2023 18:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689532928; bh=GxGezcAwkBcGtUwyX+J8v7tcHhZV47pZ7EUlmh0zRns=;
        h=Date:From:To:Cc:Subject:From;
        b=dRu7xOZ5olELO/yRSIVQr9GqSMJ9BiM+63KdtEt7aAaYSlB5IFAqDd6zoJb1s2fmb
         jKI+R5ZdNY+9JMOLVneY4QFf+7fYkWnflHTIhkP2bU7laRvaUQteJW8WNoZr4jAC4/
         dCbLn7hxoOqZO3+oC20S96Zo2wB1lOYE/VL/na96PnOJ3XmIuFkXUqp3Kt4UB4/rtl
         FChaV71l7ayvU/OZMRCHIxueZm/M6CRSuW1sMNnH9slHkUy+cioOEHyu8h9owY1a6T
         m+N2yHUE2FSSEeWSusqnV4BaRpsM6H30wZdyla1UfrbGomWYGJGlrXUuErINcEgeac
         Uozv0fkVVj9jA1Sq/IrT3p5VWV3ARus25yowqgpAS036cxEQsywX7Wob5mmQlZIdcb
         9zr/1PyCKQ4xaSjJKIC9qaUNQvm7ZMx97rN65fdVF5K5zJlCWfLJoh/iZHBhbjiWQ1
         2aQDk5sY7pGJuxinLRyUo2b4bgDr8w1qPY85qzoSOvpfdRAVDt6s96G+yNF4gYmt2y
         Ay7shiSU8CsVr+cMc1nQIOn9QJaltu1XDj5JZ+oGrvBWxwZJPP4+smx9a8+7iNjFS/
         IcGdJ13ma7nG1TntSTMbhRmzY2x1X+LFEcQ0ebNYbUwJwhi6X7firphsiQGhA1VoaU
         k7TmIFfqewM5zkP0y8DfLAmY=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 860C440E00F4;
        Sun, 16 Jul 2023 18:42:05 +0000 (UTC)
Date:   Sun, 16 Jul 2023 20:42:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for v6.5-rc2
Message-ID: <20230716184204.GFZLQ5/DJ1+q8vpuuN@fat_crate.local>
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

please pull two urgent objtool fixes for 6.5.

Thx.

---

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v6.5_rc2

for you to fetch changes up to 719a937b7003933de1298ffa4b881dd6a234e244:

  iov_iter: Mark copy_iovec_from_user() noclone (2023-07-10 09:52:28 +0200)

----------------------------------------------------------------
- Mark copy_iovec_from_user() __noclone in order to  prevent gcc from
  doing an inter-procedural optimization and confuse objtool

- Initialize struct elf fully to avoid build failures

----------------------------------------------------------------
Michal Kubecek (1):
      objtool: initialize all of struct elf

Peter Zijlstra (1):
      iov_iter: Mark copy_iovec_from_user() noclone

 lib/iov_iter.c      | 2 +-
 tools/objtool/elf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
