Return-Path: <linux-kernel+bounces-48077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB768456F0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF131C22D56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B016160886;
	Thu,  1 Feb 2024 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVV8y9Yt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5018C15F330;
	Thu,  1 Feb 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789163; cv=none; b=nHGndeufk42uaG5YvwU2KUA0segmoEUeYtjT8gMbM7dK7dyuVb5MMPwNuFoG73nX75pfCddjbaKvbyEsGTCRogPtVlXF8wn9jAZ5TuZ5wQB1YuZAwYR+WbgK5GTT04ZTrj0oYDDDNrymE4KbWFddP/J9GYD47QVZxNCQdQmGdXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789163; c=relaxed/simple;
	bh=wtovyXGq+lANxIqxjzQGfZMIslZlpYTFhgC/2Kdi7hw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Jp9HWGKU4l1myWgkWD4es3TtdcXhPwi4JFJ1fLK9QI9tHiEKT+C8jy/MyjOFI7AMSPJMASnZO+JOuSniAf78ImdCJpGowNSftL5S0eMZREVRUBmdvJsnjP3oXHBb9xGiB/5/o0VDYAEF0NSmOYHDe7Vtv6jh51wbuu+y6KERnzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVV8y9Yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29FCC433C7;
	Thu,  1 Feb 2024 12:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789163;
	bh=wtovyXGq+lANxIqxjzQGfZMIslZlpYTFhgC/2Kdi7hw=;
	h=From:To:Cc:Subject:Date:From;
	b=IVV8y9YtftBdMkEZ6HKC6yBseYCxKozy7o5YI+1XjDws0wRvljdw5Ipvo9Aep5L27
	 vVVitKfbPRiHk27JlTfwj/PMe7svilEd6Z/4/UY1SWPu8AtUB6HWi6gSC9vxvLfLaV
	 Qe53YlR9O7V1hu+wyGSMWh/DlpwyvPB6a7RboIHpmb0XKsp+f6A7qGv2B7y43uVX03
	 gbOA0NiMOyC/WiuCdBmofcBX+Oif2LR13Yb3sXyA4rOOc3zwTzac5Izc+r/Cm8qY5e
	 YEJwbA7NuA6kcAcY7dy8zn7QimBZwbCKd8DPiOniFfwyZ5X/ODxAZ5RGXzpS5YSesf
	 r/pG87CKW6Rbw==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.8-rc2
Date: Thu, 01 Feb 2024 12:05:52 +0000
Message-Id: <20240201120602.C29FCC433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 8c2ae772fe08e33f3d7a83849e85539320701abd:

  spi: fix finalize message on error return (2024-01-25 21:55:48 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc2

for you to fetch changes up to 6500ad28fd5d67d5ca0fee9da73c463090842440:

  spi: sh-msiof: avoid integer overflow in constants (2024-01-30 15:27:21 +0000)

----------------------------------------------------------------
spi: Fix for v6.8

One simple fix for a minor but valid issue with constants overflowing
identified via cppcheck.

----------------------------------------------------------------
Wolfram Sang (1):
      spi: sh-msiof: avoid integer overflow in constants

 drivers/spi/spi-sh-msiof.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

