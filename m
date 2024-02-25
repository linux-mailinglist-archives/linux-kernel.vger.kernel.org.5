Return-Path: <linux-kernel+bounces-80081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79547862A87
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3B6B20F94
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F516134AC;
	Sun, 25 Feb 2024 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OwkrW7bk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA04134A9;
	Sun, 25 Feb 2024 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708869392; cv=none; b=VhyCsVTlGq4C/x5hmYMNVy5hMaJ1E88OUhvx2Gp/aNp4jZ+4A+p5JVlkEijoTq3DeRtiRIamdm8HLRw46uZuYKlpuE4QgYNpiZ2mWCK1JPWTItDYbcxQSnZ+5rR0g+BeH0t3oNcjJ0bdMVoC4DWZ/LPz4DwFiFzyarMXSRPqEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708869392; c=relaxed/simple;
	bh=jninB+c867ZYjDn80RMmQCDZLviyFLUtkIe6k0RA7Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZUrQbYWOLlzW+9y5s8cSKvzNsVPqv5RB4dzNPD4cF8Y/eCY1gpKeCdSEcZ2XtIAvvDiBWR6BKUBPQNaKiGnI6TtTP+sWZeizHLAzWTB7mDFqPrsZRJbT9L3W4JZzLeSR+4cQ1gATK99tWsnyB6aXGe1oRfCm8ZHU77VOOj1v+jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OwkrW7bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6690DC43390;
	Sun, 25 Feb 2024 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708869391;
	bh=jninB+c867ZYjDn80RMmQCDZLviyFLUtkIe6k0RA7Jc=;
	h=Date:From:To:Cc:Subject:From;
	b=OwkrW7bk4mDnN12p2uoGzyKKGaWw/99pxi15QOf7H2XfZczAiIIS2IQXobkjg+luk
	 w3FtKOQkrYcB/fq3l69nyV7xCkt1p9m0znb/Pj/LzONJWkWUXcOg8bZBYjGaofKJ2J
	 6FLVOyZjhdFDIRZ3UJWcw438Ee/9hCU6KJnN03vM=
Date: Sun, 25 Feb 2024 14:56:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.8-rc6
Message-ID: <ZdtHDUx9Xsqq59k7@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc6

for you to fetch changes up to 3b69e32e151bc4a4e3c785cbdb1f918d5ee337ed:

  serial: amba-pl011: Fix DMA transmission in RS485 mode (2024-02-19 09:43:37 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.8-rc6

Here are 3 small serial/tty driver fixes for 6.8-rc6 that resolve the
following reported errors:
  - riscv hvc console driver fix that was reported by many
  - amba-pl011 serial driver fix for RS485 mode
  - stm32 serial driver fix for RS485 mode

All of these have been in linux-next all week with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Lino Sanfilippo (2):
      serial: stm32: do not always set SER_RS485_RX_DURING_TX if RS485 is enabled
      serial: amba-pl011: Fix DMA transmission in RS485 mode

Palmer Dabbelt (1):
      tty: hvc: Don't enable the RISC-V SBI console by default

 drivers/tty/hvc/Kconfig          |  8 ++++--
 drivers/tty/serial/amba-pl011.c  | 60 ++++++++++++++++++++--------------------
 drivers/tty/serial/stm32-usart.c |  4 ++-
 3 files changed, 38 insertions(+), 34 deletions(-)

