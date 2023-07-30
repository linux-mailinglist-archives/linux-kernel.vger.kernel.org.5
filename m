Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8DB7684E2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 13:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjG3LGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 07:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG3LGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4504710F9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 04:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D76F960BFA
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 11:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5873C433C7;
        Sun, 30 Jul 2023 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690715160;
        bh=V546RUpxt63ZWqQa6M0/DBvPcQOj9XCJwcNEKgwKQDQ=;
        h=Date:From:To:Cc:Subject:From;
        b=sQorlwEyhplrM87Gh1qSTzw9U6xOWz1SFvcOJioN04hYQBtUibIxWJSmo5l0PPEkP
         QX9X7zWADm6JvFDDnNyCS31cYPudvRwb/T4Bf0Bf7PXgD10y9zpTpzXBgS9dUEHf4s
         BbsO6cbHUAo8ekz8N0bZBQJQHxD386KDMvOlArwQ=
Date:   Sun, 30 Jul 2023 13:05:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.5-rc4
Message-ID: <ZMZEFScpcIdjLiFy@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.5-rc4

for you to fetch changes up to f8ea95021022826a010f56cf19451c21f4c9c155:

  misc/genalloc: Name subpools by of_node_full_name() (2023-07-26 09:45:01 +0200)

----------------------------------------------------------------
Char driver and Documentation fixes for 6.5-rc4

Here is a char driver fix and some documentation updates for 6.5-rc4
that contain the following changes:
  - sram/genalloc bugfix for reported problem
  - security-bugs.rst update based on recent discussions
  - embargoed-hardware-issues minor cleanups and then partial revert for
    the project/company lists

All of these have been in linux-next for a while with no reported
problems, and the documentation updates have all been reviewed by the
relevant developers.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (4):
      Documentation: security-bugs.rst: update preferences when dealing with the linux-distros group
      Documentation: security-bugs.rst: clarify CVE handling
      Documentation: embargoed-hardware-issues.rst: clean out empty and unused entries
      Documentation: embargoed-hardware-issues.rst: add AMD to the list

Linus Walleij (1):
      misc/genalloc: Name subpools by of_node_full_name()

 .../process/embargoed-hardware-issues.rst          |  3 --
 Documentation/process/security-bugs.rst            | 39 ++++++++++------------
 drivers/misc/sram.c                                |  2 +-
 lib/genalloc.c                                     |  2 +-
 4 files changed, 20 insertions(+), 26 deletions(-)
