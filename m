Return-Path: <linux-kernel+bounces-97392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004118769F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952411F21FE9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673F640853;
	Fri,  8 Mar 2024 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HoJR+jDg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43333309E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919026; cv=none; b=XqgndkvIqesbn6hGIBGZcaNOaZWB5pynQuLyMsnNQ0aHruPe9UYBTabwfCeAMKIqaamkYCm73fqqe9MjSaqFSYR1q/rpiK/pfNJ1g2fRXh51COXfeS9zzHzolXlBQkvqqIznfSxjXxYU6S2qhk3rkLV3Vy0pSfKeaubtIjlUHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919026; c=relaxed/simple;
	bh=0tjok9qYVr02zjkLB7D5hc/K8Id5Sl72q3jr/3O8PGg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=feuv/JGnVt/BS5ixmXHL1pwI+DdzY93+vRJywV8Etbvw/0TJhvHOCW8LCSVcusQsFIG8Cmj6dTP86v4HJsUHcSXwFJOzFAVqaEQ1NXoXU8qpGUk3Rwyt3kDtw9KY3mHdVhy/h/vqBYFOlKThzfaRaku1Uf9BoAgGd1JOgaNecb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HoJR+jDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE97C433F1;
	Fri,  8 Mar 2024 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709919026;
	bh=0tjok9qYVr02zjkLB7D5hc/K8Id5Sl72q3jr/3O8PGg=;
	h=Date:From:To:Cc:Subject:From;
	b=HoJR+jDgpSaSNAL51JU6K8X/bgKfm85kpgbmBO/RbqPPiBu/sGhLL6M4lP4aMbLLA
	 XpN3kBCaYfhfC/hppd68ANNLL0811n+DdsX1LsZQOpiRxKjlry9pjti1xwMgZ9buax
	 J0uCr3v3L6CAy7VFdx2EsKWedCLf7hVS4NHhL95o=
Date: Fri, 8 Mar 2024 17:30:23 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.8-rc8
Message-ID: <ZetLL3YjQ32l-2pW@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.8-rc8

for you to fetch changes up to a0776c214d47ea4f7aaef138095beaa41cff03ef:

  mei: gsc_proxy: match component when GSC is on different bus (2024-03-05 14:30:09 +0000)

----------------------------------------------------------------
Char/Misc driver changes for 6.8-rc8 (or -final)

Here are a few small char/misc and other driver subsystem fixes for
reported issues that have been in my tree for inclusion in 6.8-rc8 or
-final, which ever is next.

Included in here are fixes for:
  - iio driver fixes for reported problems
  - much reported bugfix for a lis3lv02d_i2c regression
  - comedi driver bugfix
  - mei new device ids
  - mei driver fixes
  - counter core fix

All of these have been in linux-next with no reported issues, some for
many weeks.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (3):
      mei: me: add arrow lake point S DID
      mei: me: add arrow lake point H DID
      mei: gsc_proxy: match component when GSC is on different bus

Cosmin Tanislav (2):
      iio: accel: adxl367: fix DEVID read after reset
      iio: accel: adxl367: fix I2C FIFO data register

Ekansh Gupta (1):
      misc: fastrpc: Pass proper arguments to scm call

Frej Drejhammar (1):
      comedi: comedi_8255: Correct error in subdevice initialization

Greg Kroah-Hartman (2):
      Merge tag 'counter-fixes-for-6.8b' of https://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-linus
      Merge tag 'iio-fixes-for-6.8b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus

Hans de Goede (1):
      misc: lis3lv02d_i2c: Fix regulators getting en-/dis-abled twice on suspend/resume

Ian Abbott (1):
      comedi: comedi_test: Prevent timers rescheduling during deletion

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_mpu6050: fix FIFO parsing when empty
      iio: imu: inv_mpu6050: fix frequency setting when chip is off

Kees Cook (1):
      iio: pressure: dlhl60d: Initialize empty DLH bytes

Nuno Sa (1):
      counter: fix privdata alignment

Vasileios Amoiridis (1):
      iio: pressure: Fixes BMP38x and BMP390 SPI support

Wentong Wu (1):
      mei: Add Meteor Lake support for IVSC device

 drivers/comedi/drivers/comedi_8255.c          |  1 +
 drivers/comedi/drivers/comedi_test.c          | 30 +++++++++++++---
 drivers/counter/counter-core.c                |  7 ++--
 drivers/iio/accel/adxl367.c                   |  8 +++--
 drivers/iio/accel/adxl367_i2c.c               |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  5 +++
 drivers/iio/pressure/bmp280-spi.c             | 50 ++++++++++++++++++++++++++-
 drivers/iio/pressure/dlhl60d.c                |  7 ++--
 drivers/misc/fastrpc.c                        | 10 +++---
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c        | 21 ++++++-----
 drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c    |  8 +++--
 drivers/misc/mei/hw-me-regs.h                 |  2 ++
 drivers/misc/mei/pci-me.c                     |  2 ++
 drivers/misc/mei/vsc-tp.c                     |  1 +
 15 files changed, 126 insertions(+), 30 deletions(-)

