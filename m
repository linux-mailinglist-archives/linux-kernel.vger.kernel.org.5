Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3877C99C2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjJOPYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJOPYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:24:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13142D6;
        Sun, 15 Oct 2023 08:24:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEB9C433C7;
        Sun, 15 Oct 2023 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697383459;
        bh=EeAFUmhDkUq+jO/KcEvufbQw6SOLKJn71OsRyOL/rYU=;
        h=Date:From:To:Cc:Subject:From;
        b=q9PBkm58LbxfZoz6szyxvYQe380lgmUt2vw1XUsK0gS6BFbCXp9054ay7C2SrF/AU
         l3xPKSshhlaRojm7A4ytWvpjn3ll6VN5DMBPu0uFzMV6HNG0750zHz6GMZIm5QFKqx
         Bisq/Hy/eNxKnSMvCvlfdy6EQD5npY3oSef6qAHo=
Date:   Sun, 15 Oct 2023 17:24:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.6-rc6
Message-ID: <ZSwEIUTAuRP2TsiP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.6-rc6

for you to fetch changes up to b3fa3cf02e3ce92d32bfdeedd5a6bd0825f55a14:

  ASoC: ti: ams-delta: Fix cx81801_receive() argument types (2023-10-08 07:17:07 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.6-rc6

Here are some small tty/serial driver fixes for 6.6-rc6 that resolve
some reported issues.  Included in here are:
  - serial core pm runtime fix for issue reported by many
  - 8250_omap driver fix
  - rs485 spinlock fix for reported problem
  - ams-delta bugfix for previous tty api changes in -rc1 that missed
    this driver that never seems to get built in any test systems

All of these have been in linux-next for over a week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Janusz Krzysztofik (1):
      ASoC: ti: ams-delta: Fix cx81801_receive() argument types

Lukas Wunner (1):
      serial: Reduce spinlocked portion of uart_rs485_config()

Tony Lindgren (2):
      serial: 8250_omap: Fix errors with no_console_suspend
      serial: core: Fix checks for tx runtime PM state

 drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++---------------
 drivers/tty/serial/serial_core.c    | 15 ++++++++++-----
 sound/soc/ti/ams-delta.c            |  4 ++--
 3 files changed, 22 insertions(+), 22 deletions(-)
