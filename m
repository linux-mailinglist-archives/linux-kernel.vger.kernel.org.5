Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7F67684E9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 13:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjG3LHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 07:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG3LHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:07:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8F710F9;
        Sun, 30 Jul 2023 04:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 595BC60BF0;
        Sun, 30 Jul 2023 11:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E806C433C7;
        Sun, 30 Jul 2023 11:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690715267;
        bh=z7eCUNy3iX2XjR7jBZ8ZyKqURba5wd64yA/7cw1uRu4=;
        h=Date:From:To:Cc:Subject:From;
        b=oQeTHige9Ng+x7/VSMgXlGj43t8WjH1TEmwgST0515wsU7Fui7LCCfIzVKIwt6j5Z
         7eYzpP5jOscVG1UNbfOJtlgF1UT//sMz46AhJ/gdis3bjnsZBFnmOCbyc/+9boVVpw
         Jklhh9aMtZ4I/bUcNpWsDSmTt3f9byCOeJIbB4Ew=
Date:   Sun, 30 Jul 2023 13:07:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.5-rc4
Message-ID: <ZMZEgcrNeJRvKlY-@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.5-rc4

for you to fetch changes up to 748c5ea8b8796ae8ee80b8d3a3d940570b588d59:

  serial: 8250_dw: Preserve original value of DLF register (2023-07-25 20:31:31 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 6.5-rc4

Here are some small TTY and serial driver fixes for 6.5-rc4 for some
reported problems.  Included in here is:
  - TIOCSTI fix for braille readers
  - documentation fix for minor numbers
  - MAINTAINERS update for new serial files in -rc1
  - minor serial driver fixes for reported problems

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Biju Das (1):
      tty: serial: sh-sci: Fix sleeping in atomic context

Chaoyuan Peng (1):
      tty: n_gsm: fix UAF in gsm_cleanup_mux

Randy Dunlap (1):
      Documentation: devices.txt: reconcile serial/ucc_uart minor numers

Ruihong Luo (1):
      serial: 8250_dw: Preserve original value of DLF register

Samuel Holland (1):
      serial: sifive: Fix sifive_serial_console_setup() section

Samuel Thibault (1):
      TIOCSTI: always enable for CAP_SYS_ADMIN

Tony Lindgren (1):
      MAINTAINERS: Update TTY layer for lists and recently added files

 Documentation/admin-guide/devices.txt | 2 +-
 MAINTAINERS                           | 6 ++++++
 drivers/tty/n_gsm.c                   | 4 +++-
 drivers/tty/serial/8250/8250_dwlib.c  | 6 ++++--
 drivers/tty/serial/sh-sci.c           | 2 +-
 drivers/tty/serial/sifive.c           | 2 +-
 drivers/tty/serial/ucc_uart.c         | 2 +-
 drivers/tty/tty_io.c                  | 2 +-
 8 files changed, 18 insertions(+), 8 deletions(-)
