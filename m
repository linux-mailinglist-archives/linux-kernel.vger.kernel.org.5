Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B57B476A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjJAMZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbjJAMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:25:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCAB99;
        Sun,  1 Oct 2023 05:25:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A16C433C7;
        Sun,  1 Oct 2023 12:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696163120;
        bh=x4nfW4rGufhSP0OLtY1Dc8A+janGFVIJNE7+pWDRktI=;
        h=Date:From:To:Cc:Subject:From;
        b=SYf4b1nD48L3IwXnQQ/EjTcVA9Ifv7LhCjNB6PiKKu6/e8mhd4/N5uKuLlOXPbcD1
         CMiJ9vkjN/n6+eqqKMfi9Pro4+fjRLfXG3l5ywV1IAt+/gPv5e7Q+Jw6VW3dgjqhae
         zUZIEXv8ByOv8AJbHPKRPqF0RLgQ+/7SLbtRfEbk=
Date:   Sun, 1 Oct 2023 14:25:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.6-rc4
Message-ID: <ZRllLjvypvT34qFa@kroah.com>
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

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.6-rc4

for you to fetch changes up to 29346e217b8ab8a52889b88f00b268278d6b7668:

  Revert "tty: n_gsm: fix UAF in gsm_cleanup_mux" (2023-09-18 10:12:11 +0200)

----------------------------------------------------------------
TTY / Serial driver fixes for 6.6-rc4

Here are 2 tty/serial driver fixes for 6.6-rc4 that resolve some
reported regressions:
  - revert a n_gsm change that ended up causing problems
  - 8250_port fix for irq data

both have been in linux-next for over a week with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      serial: 8250_port: Check IRQ data before use

Daniel Starke (1):
      Revert "tty: n_gsm: fix UAF in gsm_cleanup_mux"

 drivers/tty/n_gsm.c                 | 4 +---
 drivers/tty/serial/8250/8250_port.c | 5 ++++-
 2 files changed, 5 insertions(+), 4 deletions(-)
