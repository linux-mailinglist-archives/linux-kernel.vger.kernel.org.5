Return-Path: <linux-kernel+bounces-110058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9E3885971
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF3FB21BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D35D83CD2;
	Thu, 21 Mar 2024 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSkxeRJ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911898062A;
	Thu, 21 Mar 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025557; cv=none; b=KsdUeuVChLwUVqdV4rb8NRSnxxrSzEEBjpGQo55qH9j+uPfbzgxT6Np4yS94ibLDfrSo3Gav6+CR8LdcD4s3BipcjffqVBCYKKtfPO1sZoBMp4EO0y025JBEOHHHD/8KuerdvE3LBbRDHIguifalDdD6rYzN275pAGv3B83criw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025557; c=relaxed/simple;
	bh=+1MLeFvybcEalYGQKL++8f/M5U9YN7gmE4KskSqtg2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PysxAHW63ZhvMYvrYPuC2HVCdOh0H4T5EKFw3Jp+WkhAb1NPz/KqcBbXqQ8caz/7WaieeV7aems+XQAEieqffYRQSajzAH4KgCvDOe3NjJMfA6FbEJdVS1fE52PRgKlshN05wv45t6GljN78N58aWpU/QTxa+GztPInHnX302Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSkxeRJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF5FC433C7;
	Thu, 21 Mar 2024 12:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711025557;
	bh=+1MLeFvybcEalYGQKL++8f/M5U9YN7gmE4KskSqtg2E=;
	h=From:To:Cc:Subject:Date:From;
	b=QSkxeRJ5kKk16+tgclhMuYgOAU+Gn2Y/V/1f1I3oTlYFgGDDXMgBmdPGEh/gdSWjV
	 BhWR/88VmsnDlXEx2txoVNWASVcj/NDczzVhH0Nb+YzLg8oDrC4LBm4ob1h/NTcqtk
	 CDVdlwe2ylwO9f70wPfnQBMZ8kLjNpLN3OstoxsPV3Zescf9Wig3UI/hBbYF6FJLJr
	 sS0JUuun8FoMFFeEMJ5P2B+l8HxTK5WnFW61djd1YUWzEvyne5fH4GynILz3yzo63M
	 IbZl76crkPg0/26LZx4SUmW5AibNTT6N7LmgeISWDLq8HMXFpY3VUx/6vU7xvzTP4F
	 Rb+1yBB0AFckg==
From: Bjorn Andersson <andersson@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Davis <afd@ti.com>
Subject: [GIT PULL] hwspinlock updates for v6.9
Date: Thu, 21 Mar 2024 05:57:28 -0700
Message-ID: <20240321125730.1676568-1-andersson@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.9

for you to fetch changes up to cebaa386d5ee1a44a58c12f1d220f62cc567fdb0:

  hwspinlock: omap: Use index to get hwspinlock pointer (2024-03-05 20:01:14 -0800)

----------------------------------------------------------------
hwspinlock updates for v6.9

This provides some code cleanup for the OMAP hwspinlock driver.

----------------------------------------------------------------
Andrew Davis (4):
      hwspinlock: omap: Remove unneeded check for OF node
      hwspinlock: omap: Use devm_pm_runtime_enable() helper
      hwspinlock: omap: Use devm_hwspin_lock_register() helper
      hwspinlock: omap: Use index to get hwspinlock pointer

 drivers/hwspinlock/omap_hwspinlock.c | 57 +++++++-----------------------------
 1 file changed, 10 insertions(+), 47 deletions(-)

