Return-Path: <linux-kernel+bounces-110556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D186888608A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7751C20865
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A3B133420;
	Thu, 21 Mar 2024 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9RRziWb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E013340A;
	Thu, 21 Mar 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711045772; cv=none; b=oX7DLvtlT7TV2fYJp5Gbz/0tBwEb9bHWq0jJW0nbO+HXIioxQaHTRiRXDCxLuO0Mnv4bqn0FtlA2FaREIKBvGbkViIwupuCdcySUjsE47/bN0zue0BWE75FVdHioJyyBYU8mjVwaQWyGwUq0tyfN0vVwhB7Avcs+1J1aB9tjgX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711045772; c=relaxed/simple;
	bh=E3plSq6pMYSImGt0wVp3XxOmTpdXXINVNGbm/p3aTMM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o7FzY30gT7MhJq8aJGOCFuHbkEfZcDOgvd9UbFL7fpAK3/5ExsPsFk/bcy/jbrSxowkMgj8Dh6iBdtjSSpPidGQGpaL4eGNdusYRp66+9sQqUyHj6YXCPQcc1DCKDnDucpCCMqW7SlMb46AcT9FhKiqVFf/TyY2ZwkXvmKBH1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9RRziWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D14BC433C7;
	Thu, 21 Mar 2024 18:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711045771;
	bh=E3plSq6pMYSImGt0wVp3XxOmTpdXXINVNGbm/p3aTMM=;
	h=Date:From:To:Subject:From;
	b=h9RRziWb4sYzLp83UC+myLIxGZ/xZ+Gb9KE5rKE69gcMKZfFVp0mKxn6VGkqWkqpi
	 a8cjiOJh05K6IN965aaGSlxOhQWF+DAfT4wcoHM3wyN68EKL8h0AjsBs4pDUhwbFTE
	 1iN2lNLZjKHHdin8q4T0gTh7apB39S5UhJvbslWqvRexHqU9L7YJMQs0x4vrWeXiBl
	 AXTuWEeQZgia0PwCw+pSgbyMNyIE7VzoRSSTiyd4yfR60c/zM4guwUtx6jprHyRl9D
	 xC4aTeow+XHH+lZ81TNZaR8xUrMLaEYV+vsl9Ljdf42AjYiHWMTbQuy9yGR4Sz4zWo
	 W8uPB5/7uaahw==
Date: Thu, 21 Mar 2024 19:29:26 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and cleanups for v6.9-rc1
Message-ID: <Zfx8hg0RRDmKbJ0O@carbonx1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull fixes and cleanups for the fbdev subsystem for kernel 6.9-rc1.

Beside the typical bunch of smaller fixes, the Linux console now allows fonts
up to a size of 64 x 128 pixels.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.9-rc1

for you to fetch changes up to 0688d3b1d882dd1dcf73305306e71ebf1653f595:

  fbdev: panel-tpo-td043mtea1: Convert sprintf() to sysfs_emit() (2024-03-20 09:02:32 +0100)

----------------------------------------------------------------
fbdev fixes and cleanups for 6.9-rc1:

- Allow console fonts up to 64x128 pixels (Samuel Thibault)
- Prevent division-by-zero in fb monitor code (Roman Smirnov)
- Drop Renesas ARM platforms from Mobile LCDC framebuffer driver
  (Geert Uytterhoeven)
- Various code cleanups in viafb, uveafb and mb862xxfb drivers by
  Aleksandr Burakov, Li Zhijian and Michael Ellerman

----------------------------------------------------------------
Aleksandr Burakov (1):
      fbdev: viafb: fix typo in hw_bitblt_1 and hw_bitblt_2

Geert Uytterhoeven (1):
      fbdev: Restrict FB_SH_MOBILE_LCDC to SuperH

Li Zhijian (2):
      fbdev: uvesafb: Convert sprintf/snprintf to sysfs_emit
      fbdev: panel-tpo-td043mtea1: Convert sprintf() to sysfs_emit()

Michael Ellerman (1):
      fbdev: mb862xxfb: Fix defined but not used error

Roman Smirnov (1):
      fbmon: prevent division by zero in fb_videomode_from_videomode()

Samuel Thibault (1):
      fbcon: Increase maximum font width x height to 64 x 128

 drivers/firmware/efi/earlycon.c                        |  2 +-
 drivers/video/fbdev/Kconfig                            |  2 +-
 drivers/video/fbdev/arkfb.c                            | 15 +++++++++++----
 drivers/video/fbdev/core/fbcon.c                       | 16 +++++++++-------
 drivers/video/fbdev/core/fbmem.c                       | 12 ++++++------
 drivers/video/fbdev/core/fbmon.c                       |  7 ++++---
 drivers/video/fbdev/core/svgalib.c                     | 15 +++++++++++----
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c             | 18 +++++++++---------
 .../fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c | 12 ++++--------
 drivers/video/fbdev/s3fb.c                             | 15 +++++++++++----
 drivers/video/fbdev/uvesafb.c                          |  2 +-
 drivers/video/fbdev/vga16fb.c                          |  6 +++++-
 drivers/video/fbdev/via/accel.c                        |  4 ++--
 drivers/video/fbdev/vt8623fb.c                         | 15 +++++++++++----
 drivers/video/sticore.c                                |  2 +-
 include/linux/fb.h                                     | 18 ++++++++++++------
 include/linux/font.h                                   |  3 ++-
 lib/fonts/fonts.c                                      | 15 +++++++++------
 18 files changed, 110 insertions(+), 69 deletions(-)

