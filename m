Return-Path: <linux-kernel+bounces-97391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630788769F0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196EE1F22301
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DFA4F213;
	Fri,  8 Mar 2024 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zZ9WRtmj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7817BDC;
	Fri,  8 Mar 2024 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919003; cv=none; b=isOHC5nakSFOdIvF2x0AewzqOrsyA1WLJ7XO6SHoDaEONQwAs8m09PPEmDhxImVKQwbPahRSaMVDISZ9DwCqgoXYmEvEzgEGOeaVqYsEdqFR56zNkP1L8oG3muRecMDFQ6vkWRT4dgAdE1NbzkC1amGxdJ4q2wPxOtBWTBcYcBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919003; c=relaxed/simple;
	bh=+fYU4rVa57612tN4lcMLxbO7KHDmsQ7TxqDmyM2EsSA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ei6gXjEBU91mjiBvDR7+bEGEbyfJZ5np/AG4EkMuzDZuDLQJolThWjT2Fow5cw+QjkLTXtpP/G+3mT4eAtO+CadaRVuyTilAp7Q9H48T1J+DgLtnIl4bObKRIXQtTZoOFCulHUg+Z4yLYaNvjvdj7EcDyMDx2O/1Aq5OCpwwVbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zZ9WRtmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67719C433C7;
	Fri,  8 Mar 2024 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709919002;
	bh=+fYU4rVa57612tN4lcMLxbO7KHDmsQ7TxqDmyM2EsSA=;
	h=Date:From:To:Cc:Subject:From;
	b=zZ9WRtmj1mMb1Bc38bj3FGl7FIVLGdG19Iel4dI6Qv/TsmSjWmwb3QdK75VPA1pO6
	 A2D72zko9YGI7X5b+Ja04lqS6das5srg4fH1LXw60An8GMSqHP8vguGWrreVIw3ZTg
	 wPBYgj3VZ+kSWIjvtXoA+LCzzSpdaY6nyms7lLKU=
Date: Fri, 8 Mar 2024 17:29:59 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.8-rc8
Message-ID: <ZetLF6nPrugVB28o@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc8

for you to fetch changes up to 3d9319c27ceb35fa3d2c8b15508967f3fc7e5b78:

  Revert "tty: serial: simplify qcom_geni_serial_send_chunk_fifo()" (2024-03-05 13:40:34 +0000)

----------------------------------------------------------------
TTY/Serial fixes for 6.8-rc8 (or -final)

Here are some small remaining tty/serial driver fixes for 6.8-rc8.
Included in here is fixes for:
  - vt unicode buffer corruption fix
  - imx serial driver fixes, again
  - port suspend fix
  - 8250_dw driver fix
  - fsl_lpuart driver fix
  - revert for the qcom_geni_serial driver to fix a reported regression

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Douglas Anderson (1):
      Revert "tty: serial: simplify qcom_geni_serial_send_chunk_fifo()"

Nicolas Pitre (1):
      vt: fix unicode buffer corruption when deleting characters

Peter Collingbourne (1):
      serial: 8250_dw: Do not reclock if already at correct rate

Rickard x Andersson (1):
      tty: serial: imx: Fix broken RS485

Sherry Sun (1):
      tty: serial: fsl_lpuart: avoid idle preamble pending if CTS is enabled

Yicong Yang (1):
      serial: port: Don't suspend if the port is still busy

 drivers/tty/serial/8250/8250_dw.c     |  6 +++---
 drivers/tty/serial/fsl_lpuart.c       |  7 +++++--
 drivers/tty/serial/imx.c              | 22 ++++++++++++++++++----
 drivers/tty/serial/qcom_geni_serial.c | 10 ++++++----
 drivers/tty/serial/serial_port.c      | 25 ++++++++++++++++++++++++-
 drivers/tty/vt/vt.c                   |  2 +-
 6 files changed, 57 insertions(+), 15 deletions(-)

