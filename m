Return-Path: <linux-kernel+bounces-99064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F0E87830C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 983F6B216DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEEC55C3A;
	Mon, 11 Mar 2024 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYG+ipwL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195255774
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169973; cv=none; b=It0wnb3pty/nqMecvSl24dDH9BdThlENkAqmBs4mtRyHMM5NfaUZ5/Q7fQojLa1F+EWLKsxpWiG2w9Idb7EtcF0HIPUnzUa0KkIqmmyn2TQkKTJaryYDn2yfQ0nVcHnCdxBIAkICkr/0VStG8oCJdi8B8BbnGlvupwN+SesFQVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169973; c=relaxed/simple;
	bh=PJtnhDdIoAXOMW3yzLoefuskzemlJ9YSHhJNxBAL2cY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FkndpKZ8losNSyEymdMEP3AWpTJdOh9K7ZdwUlgTjh4DZIhDno6nqQrCbRCBAUItzRXAurg/AubiNyd3rws+CSvC802T73EIuP51tYKm0hhWkpW6fpTbWgo1821lXnupu8gGg0aoTu93I8RONW1P/k52bpSNjqTkMUJ1T60ZMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYG+ipwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E617C43390;
	Mon, 11 Mar 2024 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169973;
	bh=PJtnhDdIoAXOMW3yzLoefuskzemlJ9YSHhJNxBAL2cY=;
	h=From:To:Cc:Subject:Date:From;
	b=mYG+ipwLW1gd1lSW6y9Z7t0PsqWZ0y8puJRX1VOC2006oMWdctIy/aGh50YpXdH+K
	 NrdFWZagYSY5+0QkPaZdmlKvzyES8Jk2GC3rBhFcurvxwDDjjMOnlH/bmjTDgb2vt/
	 lCAoE7wBrxsC4jWwqUmuF0do7iviYdyRDtVv+Z0E0OJXJrXLku72OX2xKewqp3YPPB
	 lZChL3chsIC2FG8opsDFlPN6GwnuA2AO0O04HLX9msLwL6rQa4RItCYSRiXMpx8zHy
	 nQ+alpUIHN7/hdZma0lo9C25sS9PeU4WaJD5TSryXet7zLoMtUWPaCjhM+nTrRVxjJ
	 ymyFWj80F6oog==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.9
Date: Mon, 11 Mar 2024 15:12:40 +0000
Message-Id: <20240311151253.0E617C43390@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.9

for you to fetch changes up to bb92804ba2b6636e28db05f589a9a8ef62a07917:

  regmap: kunit: Add a test for ranges in combination with windows (2024-02-26 13:46:24 +0000)

----------------------------------------------------------------
regmap: Updates for v6.9

Just two updates this time around, a rework of max_register handling
which enables us to support devices with only one register better and a
new test which will be used to validate use of some new SPI
optimisations which will be coming in during this merge window.

----------------------------------------------------------------
Jan Dakinevich (1):
      regmap: rework ->max_register handling

Mark Brown (1):
      regmap: kunit: Add a test for ranges in combination with windows

 drivers/base/regmap/internal.h      |  1 +
 drivers/base/regmap/regcache-flat.c |  2 +-
 drivers/base/regmap/regcache.c      |  4 ++-
 drivers/base/regmap/regmap-kunit.c  | 66 +++++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regmap.c        | 10 +++---
 include/linux/regmap.h              |  5 +++
 6 files changed, 82 insertions(+), 6 deletions(-)

