Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E8677D40A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjHOUUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbjHOUUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:20:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0598B1BE7;
        Tue, 15 Aug 2023 13:20:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97A7461FDA;
        Tue, 15 Aug 2023 20:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6782BC433C7;
        Tue, 15 Aug 2023 20:20:28 +0000 (UTC)
Date:   Tue, 15 Aug 2023 22:20:25 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Sam James <sam@gentoo.org>
Subject: [GIT PULL] parisc architecture fixes for v6.5-rc7
Message-ID: <ZNveCSXhx2LrtgVL@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull one single patch for the parisc architecture for 6.5-rc7:

Fix the parisc TLB ptlock checks so that they can be enabled
together with the lightweight spinlock checks.

Thanks,
Helge

---

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc7

for you to fetch changes up to 7a894c87374771f3cfb1b8e5453fbe03f1fb8135:

  parisc: Fix CONFIG_TLB_PTLOCK to work with lightweight spinlock checks (2023-08-14 09:54:49 +0200)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.5-rc7:

- Fix TLB ptlock checks to not break lightweight spinlock checks

----------------------------------------------------------------
Helge Deller (1):
      parisc: Fix CONFIG_TLB_PTLOCK to work with lightweight spinlock checks

 arch/parisc/kernel/entry.S | 47 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 24 deletions(-)
