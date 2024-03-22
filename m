Return-Path: <linux-kernel+bounces-111757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B11B7887083
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DD61F24362
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234A15C8F8;
	Fri, 22 Mar 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEa+617z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4485A106;
	Fri, 22 Mar 2024 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123818; cv=none; b=Zg0yFqEqrID+cVPscoyMmYmToLyJXsDAK7NspnAIh5cpD/AzIpVlKjjzAb77gY0FNInAuwTrvouFDHNNPJHwbKxX5cjJEMIES/+mrfz4iV2oikyyD3X2pgsNwqyxoRT3DbGX6P8ooDZtwEeeE1+6kbvw2NytSBZ+n6iLQP++QTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123818; c=relaxed/simple;
	bh=Qjtq2wXAU324eUdNx1w4/HYyFHq77oZw5qpk2Noef4c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ujTRjrAyAeO0rpWv86soQsP4uEeTmrTy70Zu04biSpZRUFQybvej/hThOYDYjlBPowPFMs2HSa6aneU70xiBGaKfcmOErDW7MDh6avdqgzB+Q/8d6sqB5ewCfHUMU3Flqjo0LB1N/cnP3cUVqcqDKJi5DycGQ7nfZD+fJlRSOAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEa+617z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8369DC433C7;
	Fri, 22 Mar 2024 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123817;
	bh=Qjtq2wXAU324eUdNx1w4/HYyFHq77oZw5qpk2Noef4c=;
	h=Date:From:To:Subject:From;
	b=NEa+617zEcJHGxnmY6gCZqYL2SUxo3byK5uzGBirzzdmRUJjHjb3ZeZ9nM81YbTVr
	 l6DhzWMMUYoRZ+LiMG3OUArLCtqMLdE3r5lug6wdPYflty7Rmhwzc5Zlb80SXngBK3
	 4DeJaO9DiF/VO0rquE/4uFsfqH/LHSxUlKhnilIqA/EQwKErEuBMhgHfEouYj5S5G8
	 l7gaDuUZ2OAnwYLI/au7QaUKWkHKBbDAcRUy6HDiz68t8zjnMlswqUOn4PQ8eDssOQ
	 aLnf7n/jdJpg7IyvO4uJAHH/poexRbAIeMShJRlLKCUI+w1tIOgMMBLDIZvk31TxvQ
	 273DabFMr7b0Q==
Date: Fri, 22 Mar 2024 17:10:13 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and cleanups for v6.9-rc1 (v2)
Message-ID: <Zf2tZcWuMMQGFGgb@carbonx1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Yesterday's fbdev tree showed one small compiler warning which has been fixed
in this pull request.

So, please pull the latest fixes and cleanups for the fbdev drivers for kernel 6.9-rc1.

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

