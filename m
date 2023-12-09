Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E7D80B4B5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 15:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjLINx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 08:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjLINx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 08:53:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF32610C4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 05:53:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC58EC433C8;
        Sat,  9 Dec 2023 13:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702130013;
        bh=NGosgo9icqUGfR9kDXlIy5kT5uIVLre2hE6LsRIINVM=;
        h=Date:From:To:Cc:Subject:From;
        b=y9Bmdkr0b7scSy9hvqejhBkxHhSagzPsxJUCSSuIHC7MMRAP8mIzp8gqQDQSUDV6H
         U52m8AwYIKOPKy8wTtkIpKjnZvkuKBcusUZsACl8Jyh517LpKGeok9wNSrtikgSxBo
         mhSg/OroQAX3kShaw1AeD3mykaHh3yLC15W2CPUk=
Date:   Sat, 9 Dec 2023 14:53:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.7-rc5
Message-ID: <ZXRxWubSRJ4lGC1N@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.7-rc4

for you to fetch changes up to e92fad024929c79460403acf946bc9c09ce5c3a9:

  serial: 8250_dw: Add ACPI ID for Granite Rapids-D UART (2023-12-07 10:48:56 +0900)

----------------------------------------------------------------
Serial driver fixes for 6.7-rc4

Here are some small serial driver fixes for 6.7-rc4 to resolve some
reported issues.  Included in here are:
  - pl011 dma support fix
  - sc16is7xx driver fix
  - ma35d1 console index fix
  - 8250 driver fixes for small issues

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andi Shyti (1):
      serial: ma35d1: Validate console index before assignment

Andy Shevchenko (1):
      serial: 8250_dw: Add ACPI ID for Granite Rapids-D UART

Arnd Bergmann (1):
      ARM: PL011: Fix DMA support

Daniel Mack (1):
      serial: sc16is7xx: address RX timeout interrupt errata

Ronald Wahl (3):
      serial: 8250: 8250_omap: Do not start RX DMA on THRI interrupt
      serial: 8250_omap: Add earlycon support for the AM654 UART controller
      serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit

 drivers/tty/serial/8250/8250_dw.c    |   1 +
 drivers/tty/serial/8250/8250_early.c |   1 +
 drivers/tty/serial/8250/8250_omap.c  |  14 +++--
 drivers/tty/serial/amba-pl011.c      | 112 +++++++++++++++++------------------
 drivers/tty/serial/ma35d1_serial.c   |  10 +++-
 drivers/tty/serial/sc16is7xx.c       |  12 ++++
 6 files changed, 85 insertions(+), 65 deletions(-)
