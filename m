Return-Path: <linux-kernel+bounces-19048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF5B826735
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 02:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2721B1F21880
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788F10E9;
	Mon,  8 Jan 2024 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1/SKIvw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737EA5B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 01:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B6BC433C8;
	Mon,  8 Jan 2024 01:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704678981;
	bh=nPOBRGC2VotsfeV0BHpZIaFmtAz84IpUskz3nT4flEo=;
	h=From:To:Cc:Subject:Date:From;
	b=m1/SKIvwIoMtpiufn9DfEI2gNw+dHtBCOvTSZbpRfL7+Sq70oaux33kALqJ2A8i1V
	 AaFWWh03maX1JGhg9wecn5rH0qNR+NmPcM3+KmNAOO1D8WYey1pgOQWiL+JtVq2jgM
	 kTiSneWBy78cFCLWvWruk6KyyE2oFMxbwO0pwSaSAM9IKFWxhEoow2Za+0sG0+AWrN
	 rSOUE1vG8b4ch0LLHQrAe2IRguBbWvgfSJQaryrtM7zw3Ud7gzZNRr+RlncSUqWJcy
	 lxsbBeLiIdJqcq4ZMZ2YUiwoQWdgSjI4pXnrPOQK6KQEb2Ej1kgeAjiMXAPwHuQCyw
	 BPrdRms+xl/nw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v6.8
Date: Mon,  8 Jan 2024 02:55:31 +0100
Message-ID: <20240108015531.528189-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

A single cleanup for auxdisplay.

The commit has been in -next for more than a month. No conflicts
expected.

Please pull for v6.8 -- thanks!

Cheers,
Miguel

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-6.8

for you to fetch changes up to c52391fafcefe4c562bdac62088a2735c185b942:

  auxdisplay: img-ascii-lcd: Use device_get_match_data() (2023-12-01 16:39:45 +0100)

----------------------------------------------------------------
auxdisplay changes for v6.8

A single cleanup for 'img-ascii-lcd': use 'device_get_match_data()'.

----------------------------------------------------------------
Rob Herring (1):
      auxdisplay: img-ascii-lcd: Use device_get_match_data()

 drivers/auxdisplay/img-ascii-lcd.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

