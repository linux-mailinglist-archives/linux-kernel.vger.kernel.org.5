Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F0B7F5CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344782AbjKWKsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjKWKsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:48:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CA919D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:48:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAF2C433C8;
        Thu, 23 Nov 2023 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700736492;
        bh=9yui0R04mhFExuav9xVkKApPeY+JtFqlYoCe4ZrZqok=;
        h=From:To:Cc:Subject:Date:From;
        b=omjmjL6D78vmJrGWDGCkTtHo2/UR2dHGY1OD8YpQcro0vxHo4EmYEo8FtZkQYuXsy
         QQsfkhP2ASvvH5kSOvqSzdIPlRE0Ozdb0wP8m+/vU55eOzmHDYOVwvfN5f+awoUL6r
         JGy+H5YeEflDjDnxRiQmnNhn2piGz8L6AhL1djvGA/DlLwM2G/4ztjICm+hr1Dkhbx
         slID6Dy4qeqEJQU1E6/TmUx3ZfWPLgTPoMRrq4FX9Hi790x9Np+TQ0GV6cBFFRd9PQ
         3BiJaryxrBmElMfVny2KMzKzkjUAIIryWLXr4lpDtn9UlrGBQHSPU8bb8dsotzRvwl
         eWUswVhpzLOUA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] powerpc: -Wmissing-prototypes fixes
Date:   Thu, 23 Nov 2023 11:47:58 +0100
Message-Id: <20231123104801.15537-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Most of the other fixes I sent have been picked up in other trees
in linux-next already, but I saw the powerpc ones were still missing.

I've folded the fixup for the ps3gelic patch in, the other two
patches are unchanged. Please apply, or ignore if you already
have them in some tree.

    Arnd

Arnd Bergmann (3):
  powerpc: ps3: move udbg_shutdown_ps3gelic prototype
  powerpc: pasemi: mark pas_shutdown() static
  powerpc: powermac: mark smp_psurge_{give,take}_timebase static

 arch/powerpc/Kconfig.debug                   |  1 -
 arch/powerpc/include/asm/ps3.h               |  6 ++++++
 arch/powerpc/platforms/pasemi/setup.c        |  2 +-
 arch/powerpc/platforms/powermac/smp.c        |  4 ++--
 arch/powerpc/platforms/ps3/Kconfig           | 12 ------------
 arch/powerpc/platforms/ps3/Makefile          |  2 +-
 arch/powerpc/platforms/ps3/gelic_udbg.c      |  1 +
 drivers/net/ethernet/toshiba/ps3_gelic_net.h |  6 ------
 8 files changed, 11 insertions(+), 23 deletions(-)

-- 
2.39.2

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
