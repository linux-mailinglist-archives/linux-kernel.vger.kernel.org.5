Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252B378A560
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 07:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjH1FxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 01:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjH1Fwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 01:52:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE8EA9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 22:52:44 -0700 (PDT)
Received: from nazgul.tnic (dynamic-046-114-154-102.46.114.pool.telefonica.de [46.114.154.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A70331EC00F4;
        Mon, 28 Aug 2023 07:52:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1693201963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=j/Qx+36eU7KYfClJp570PFFK/VGOpisKllJLzShFeIM=;
        b=IKljQRpAkfC8ZUF5NRTXc+UHJ/Wgd9Ghk5noCn2TNSsu5zyFiqr7v5e43AuvZsW5g5/3Tp
        N55poMH84Tn9EW39JwkX0v2HFswbe9RVdFRxDFiESdN7uKY3pw3j2OLWFfQpvrLSSL/EI7
        /K16YQ0yTeOpw9EA0bWpZjZbxKf6bBU=
Date:   Mon, 28 Aug 2023 07:52:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ras/core for v6.6-rc1
Message-ID: <20230828055239.GCZOw2J+mTIHZIDkQ/@fat_crate.local>
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

please pull some RAS updates for 6.6.

Thx.

---

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.6_rc1

for you to fetch changes up to 4240e2ebe67941ce2c4f5c866c3af4b5ac7a0c67:

  x86/MCE: Always save CS register on AMD Zen IF Poison errors (2023-08-18 13:05:52 +0200)

----------------------------------------------------------------
- Add a quirk for AMD Zen machines where Instruction Fetch unit poison
  consumption MCEs are not delivered synchronously but still within the
  same context, which can lead to erroneously increased error severity
  and unneeded kernel panics

- Do not log errors caught by polling shared MCA banks as they
  materialize as duplicated error records otherwise

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/mce: Prevent duplicate error records

Yazen Ghannam (1):
      x86/MCE: Always save CS register on AMD Zen IF Poison errors

 arch/x86/kernel/cpu/mce/core.c     | 35 ++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mce/intel.c    | 19 ++++++++++++++++++-
 arch/x86/kernel/cpu/mce/internal.h |  6 +++++-
 3 files changed, 57 insertions(+), 3 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
