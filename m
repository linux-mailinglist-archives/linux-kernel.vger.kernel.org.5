Return-Path: <linux-kernel+bounces-66997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3637856496
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A091D283B16
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4649130AEF;
	Thu, 15 Feb 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5Khjlhs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137DC130AFA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004340; cv=none; b=lXkorCjfkTTa9vdO2XiUwQbanIGkuuLlgbgivOZlQtPm3120pX0tDMpq3cw2wzROT3aVgm+K5Q8bw8KEk+YcTfPZVOB2EyCeMpwRnyV7G+eANRO3eigE7VyF85D+DdrikoAqHZqtbZqztqRMf2HM37GHSafffLj6qikgyUfi0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004340; c=relaxed/simple;
	bh=gH9ku1QDX+Zj/aXl31t2RlyN06RpOUwIFMFjNC9DisM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qxiefXaWOft/EmVKKcoLOPxWO2kXLBI+BRqo85tvY5GHcJ7im5m9te1NNLODz5ff5kmH+R8PNmBn+g0mOqDGMPY3Hel5wFxpqFJeZL0YzclSyitU9WSAY6zL7c/v4nAFdbbcdYDomCCTpxP0bGN75BDHJjSypDjSqZRqrPWVqPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5Khjlhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FADBC433F1;
	Thu, 15 Feb 2024 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708004339;
	bh=gH9ku1QDX+Zj/aXl31t2RlyN06RpOUwIFMFjNC9DisM=;
	h=From:To:Cc:Subject:Date:From;
	b=A5KhjlhsBMIaPjNcVv0oqVsL/LX+a49iw1w+2IGdywWLd7m2fI9L08NTB1ErtHAXw
	 iWHjFJeuxQc5BulnsdHbCcFkeIBZJr3L9Q56DiaYS33WS1fWWCj25o5aIt6VK7Wxa+
	 2ydSyAYoc2QxKO4gr0C/VSDtTd3U/3YgLKs04cRqiW/SzMdVj0GcOVzIlmGoc+mOW7
	 /0Vm/rbhL77m9o3a+1nbEVlGCBmB4dd6kM6GxEKppro/1aum2H9G0KhY0KAXu5iR1N
	 pRC/icDEv/I/3mHLs3MV7/W9s4py+R8/tAMXo5aEuzpLY1yWLizGWvfROTtm7HlI5z
	 NUKqFDIJ7v/SQ==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.8-rc4
Date: Thu, 15 Feb 2024 13:38:44 +0000
Message-Id: <20240215133859.2FADBC433F1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.8-rc4

for you to fetch changes up to 2f0dbb24f78a333433a2b875c0b76bf55c119cd4:

  regmap: kunit: Ensure that changed bytes are actually different (2024-02-12 13:55:51 +0000)

----------------------------------------------------------------
regmap: Fixes for v6.8

Guenter runs a lot of KUnit tests so noticed that there were a couple of
the regmap tests, including the newly added noinc test, which could show
spurious failures due to the use of randomly generated test values.
These changes handle the randomly generated data properly.

----------------------------------------------------------------
Ben Wolsieffer (1):
      regmap: kunit: fix raw noinc write test wrapping

Mark Brown (1):
      regmap: kunit: Ensure that changed bytes are actually different

 drivers/base/regmap/regmap-kunit.c | 57 ++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 17 deletions(-)

