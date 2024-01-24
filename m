Return-Path: <linux-kernel+bounces-37308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC6683AE14
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221A21F250CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383537E794;
	Wed, 24 Jan 2024 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9/2awFm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEAB7CF37;
	Wed, 24 Jan 2024 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112700; cv=none; b=Mnpm/sahLZnVfKtbmGvlgJy+XQyq7d4aF92wuoEB/braJ4+6VI9Z9bOIdodJR7ecaySGYh+LVqbhspmVdW+aH/cVcaN06t2VH9ndmDG8IIh/o6QSGkeEzBwACf+aOzkq98p/4vNEbB9b3wJzkykks2i12/vle4TckWl1KYUc1ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112700; c=relaxed/simple;
	bh=888Xfe7DxNuyULyYMnQLFv/4qhy732lEuQhhLHccKJM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i5GzLRwVlIW+7D1Gv/Rr+aVKfyZqs95XLUmgZKY31m0tniiEt+wmdyJuyVhYzJdz1EOjzXMuEkdi6n1cnhwKl4Gftytqzsp2C8KrFlQ14uTTCv07XUCOdaZ7Atayx6fQA7oTjSdyUAJ1haQo3V7jqCFc4YR+i0GN6LhaFonNYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9/2awFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D009C43399;
	Wed, 24 Jan 2024 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706112699;
	bh=888Xfe7DxNuyULyYMnQLFv/4qhy732lEuQhhLHccKJM=;
	h=Date:From:To:Subject:From;
	b=d9/2awFmfY5SR40WVEPzND3SxzZVzqC02DQ91vWwRZgxkwZLbaHV2+ktdkypf81ul
	 3NXxi2bjLTjQrDDARp3GnRR8Se/coY383I3B9gOkTQu05i25nJ2rtzrm4L7ltzeMvT
	 /VXuMKmYRS+nBaUuuuBOOO0SVs/yE5TIhXpu1ukoc1v9AoSiwLg3EfrD+uFnetjN+T
	 VLfiKPfhLYguIP96eR36tYaoprW+ywAD9WxLI1s/H4pvmiDhzUC/iptShlS/gGEQl3
	 qbyU4BoJshIgUUJunsNW8oJ8ZqLpJcSyFdbQNq1EMOIgHJyPmzhhdpbhoJfBFecULM
	 DwnquqBb3d6hw==
Date: Wed, 24 Jan 2024 17:11:35 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fix for v6.8-rc2
Message-ID: <ZbE2t9LoFlro7J-H@carbonx1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull a small patch set with 3 fixes and 2 small cleanups for
fbdev for kernel 6.8-rc2:

A crash fix in stifb which was missed to be included in the drm-misc tree, two
checks to prevent wrong userspace input in sisfb and savagefb and two trivial
printk cleanups.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 7a396820222d6d4c02057f41658b162bdcdadd0e:

  Merge tag 'v6.8-rc-part2-smb-client' of git://git.samba.org/sfrench/cifs-2.6 (2024-01-20 16:48:07 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.8-rc2

for you to fetch changes up to 4b088005c897a62fe98f70ab69687706cb2fad3b:

  fbdev: stifb: Fix crash in stifb_blank() (2024-01-23 09:13:24 +0100)

----------------------------------------------------------------
fbdev fixes and cleanups for 6.8-rc2:

- stifb: Fix crash in stifb_blank()
- savage/sis: Error out if pixclock equals zero
- minor trivial cleanups

----------------------------------------------------------------
Fullway Wang (2):
      fbdev: savage: Error out if pixclock equals zero
      fbdev: sis: Error out if pixclock equals zero

Geert Uytterhoeven (1):
      fbcon: Fix incorrect printed function name in fbcon_prepare_logo()

Helge Deller (1):
      fbdev: stifb: Fix crash in stifb_blank()

Jiapeng Chong (1):
      fbdev: vt8500lcdfb: Remove unnecessary print function dev_err()

 drivers/video/fbdev/core/fbcon.c             | 3 +--
 drivers/video/fbdev/savage/savagefb_driver.c | 3 +++
 drivers/video/fbdev/sis/sis_main.c           | 2 ++
 drivers/video/fbdev/stifb.c                  | 2 +-
 drivers/video/fbdev/vt8500lcdfb.c            | 1 -
 5 files changed, 7 insertions(+), 4 deletions(-)

