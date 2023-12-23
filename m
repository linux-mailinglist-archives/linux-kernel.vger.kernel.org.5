Return-Path: <linux-kernel+bounces-10359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5EC81D358
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9BF28542F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAC4944F;
	Sat, 23 Dec 2023 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0pkt+Ti9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF69CA4C;
	Sat, 23 Dec 2023 09:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3434C433C9;
	Sat, 23 Dec 2023 09:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703324191;
	bh=c7w7Td7hvk3yk3T4+0e3MPRvg+8ZTAWeuyd81csuZd0=;
	h=Date:From:To:Cc:Subject:From;
	b=0pkt+Ti9+qTvr4IALKMWXzmKWt+7nQG+PNVqb4D0oleNezTo7n54CNvjJdVYOrcTG
	 Ke2ZZYccTWD2A8HFRKQMPYJYRIKDp18j1RfFb/1yxBtgnylfef49dIsPIsUhHkNUGm
	 VjovBJ1qmiwe82TMWGb53QKZ9fPLmR4aPIVpz65U=
Date: Sat, 23 Dec 2023 10:36:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.7-rc6
Message-ID: <ZYaqHUkBTsBP0_ZQ@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.7-rc7

for you to fetch changes up to ab241a0ab5abd70036c3d959146e534a02447d17:

  Merge tag 'usb-serial-6.7-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2023-12-22 09:59:30 +0100)

----------------------------------------------------------------
USB / Thunderbolt fixes for 6.7-rc7

Here are some small bugfixes and new device ids for USB and Thunderbolt
drivers for 6.7-rc7.  Included in here are:
  - new usb-serial device ids
  - thunderbolt driver fixes
  - typec driver fix
  - usb-storage driver quirk added
  - fotg210 driver fix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alper Ak (1):
      USB: serial: option: add Quectel EG912Y module support

Dan Carpenter (1):
      usb: fotg210-hcd: delete an incorrect bounds test

Gil Fine (1):
      thunderbolt: Fix minimum allocated USB 3.x and PCIe bandwidth

Greg Kroah-Hartman (2):
      Merge tag 'thunderbolt-for-v6.7-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus
      Merge tag 'usb-serial-6.7-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Johan Hovold (1):
      usb: typec: ucsi: fix gpio-based orientation detection

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid failed operations when device is disconnected

Mark Glover (1):
      USB: serial: ftdi_sio: update Actisense PIDs constant names

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RM500Q R13 firmware support

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W265 with new baseline

Tasos Sahanidis (1):
      usb-storage: Add quirk for incorrect WP on Kingston DT Ultimate 3.0 G3

Yaxiong Tian (1):
      thunderbolt: Fix memory leak in margining_port_remove()

 drivers/net/usb/ax88179_178a.c      | 23 ++++++++++++++++++++---
 drivers/thunderbolt/debugfs.c       |  2 +-
 drivers/thunderbolt/usb4.c          | 10 +++++-----
 drivers/usb/fotg210/fotg210-hcd.c   |  3 ---
 drivers/usb/serial/ftdi_sio.c       |  6 +++---
 drivers/usb/serial/ftdi_sio_ids.h   |  6 +++---
 drivers/usb/serial/option.c         |  5 +++++
 drivers/usb/storage/unusual_devs.h  | 11 +++++++++++
 drivers/usb/typec/ucsi/ucsi_glink.c |  2 +-
 9 files changed, 49 insertions(+), 19 deletions(-)

