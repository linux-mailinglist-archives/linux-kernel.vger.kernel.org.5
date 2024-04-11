Return-Path: <linux-kernel+bounces-139653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32898A05D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B1B1C2258A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834E1657D3;
	Thu, 11 Apr 2024 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRbtp6my"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FDE64CE9;
	Thu, 11 Apr 2024 02:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712802428; cv=none; b=DwXngz149gqH5WEudm/d1JRad26uNd2xPRBTomrnSfPnrv93mUNNbkAZg/ETAfvgdF5023k4BN/SyMKYefEso8L5bE67ACozyWmsDSzt//EnI44L9ul7s7VB4u4hlgbM8L9s8b2FIH49qqUmIFfeWL2No9VVywTt2QgwePzG0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712802428; c=relaxed/simple;
	bh=sfUwpap+R/EPllEb5TUcvasvhhCwJm6Fd9uo045tkoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ITTSFDaq7lWDhx3+8HfEBa93MsiAEQGraUvyriVRh53Vh2D0Fs+YkHc6rioEFyaya+7EtkGYMH4e1udC+IU8LyqErWzlG0UoYz6Y2pYeSj60xVRxeVQSkLk5R5xqXtqjU0LUfLGIRp46Ezz6pkST3hyrg2N2Eq7hbk0VG5bXUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRbtp6my; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10649C433F1;
	Thu, 11 Apr 2024 02:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712802428;
	bh=sfUwpap+R/EPllEb5TUcvasvhhCwJm6Fd9uo045tkoQ=;
	h=Date:From:To:Cc:Subject:From;
	b=mRbtp6myVAZzdLEuUxSCJak8eS9pj69yb0BXlvJY9RP8Xifddh6mxUP5nq+ypLoGT
	 t5SDWNsSBcjKcn/lN6dcFBlVMifp6wrC4wI6u2sXaduxys0LvPerE1WwQ28G/x0c0z
	 XBU24QCjUVLrjhwd3HRpdH5RbKa/Fc8HDhChY1IoHhzejEIa24rWnkvuPNVgEvICr7
	 acG7PXidhVdTKi73hU+q2tIIjYPqMAMlJspCctKYSByfjYILNzl6AbYKkc1cLvy5tg
	 bMTEkk6EIUh+w7YmsHub3tV8cWtTEY0uCpLOxsWdImAcxSxoGlIeAwi+fuoxNrV+vM
	 oRZ3iY4Q74R3g==
Date: Thu, 11 Apr 2024 10:27:05 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: torvalds@linux-foundation.org
Cc: pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
	tzungbi@kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform fixes for v6.9-rc4
Message-ID: <ZhdKeS8lzaJLPlMM@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull chrome-platform fixes for v6.9-rc4.

Thanks,
TzungBi

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-fixes-for-v6.9-rc4

for you to fetch changes up to 5e700b384ec13f5bcac9855cb28fcc674f1d3593:

  platform/chrome: cros_ec_uart: properly fix race condition (2024-04-11 09:53:04 +0800)

----------------------------------------------------------------
chrome-platform fixes for v6.9-rc4

Fix a NULL pointer dereference.

----------------------------------------------------------------
Noah Loomans (1):
      platform/chrome: cros_ec_uart: properly fix race condition

 drivers/platform/chrome/cros_ec_uart.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

