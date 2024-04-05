Return-Path: <linux-kernel+bounces-133665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8BE89A719
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DC628326B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D5B175562;
	Fri,  5 Apr 2024 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlKMkjtY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D5171640
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712355651; cv=none; b=pyWO7qsDqoxPGWxGbLoOXzbTqhSgpwScIGvmCrJrQHQA5H8PnbWBCsOr4SSTyL26p0oc0IMb/uQsL053JmyH+27u24LhMcua+OKWG/FGuPuXj0mMkcSwFZO3AY6cfoPNzZ14BZ8n4CbAYKRt/dD7dDddkFSKUoRVJOdxTKhNGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712355651; c=relaxed/simple;
	bh=04WfC+O3mSKcSEK0H4M9yvT8rGaRmHNDXRFko3e+79I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qJPfNVi30pwwIq2Ct2asU4K38b+60/ezKhIyy0bPsT22mEIDVoRRRo59I30iBLvm4csNGkYRLarZzFOFdigwAGFRVe+L2FCZOjKqBxazhJOIKe5BfUHXgHA4WuNEghiv9Z6jOCbU6vJdcC2hECkPkljv1jUnKUuNqkZ79PS6nNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlKMkjtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096C1C433F1;
	Fri,  5 Apr 2024 22:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712355651;
	bh=04WfC+O3mSKcSEK0H4M9yvT8rGaRmHNDXRFko3e+79I=;
	h=From:To:Cc:Subject:Date:From;
	b=TlKMkjtYYcJFUXHTcJdjyFE28DCRe/qVTNQCMGh0MrC8YHlOHnfLtMwX5V4oVp5K+
	 YVEi9MY6sdQapFFsSmv6sdj8i9oGrx0IMjw7nCxRfLGZIuZCYKUbXbQn6+qtFkDjZx
	 dFT59XrgtLEsckziZXv2zIQxm50PWWAfWHrG/8jFz/3mLfRzITt6oxVpxlB7nmiRoG
	 BkaONTSrAgY87cBQ/RrjZWJwceQlAZLtKjJdANA6euLNxCerpIVj5FJ/ekVC74ZteB
	 P2VCOrxez1nHb3q3fqvTkTEjbfTCfr0n13Qx4pdrRo64hCltXVP1mcv8srI0b7OGnm
	 1mXyTHMHdkDow==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.9-rc2
Date: Fri, 05 Apr 2024 23:20:41 +0100
Message-Id: <20240405222051.096C1C433F1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.9-rc2

for you to fetch changes up to a469158eaf8f4b10263b417856d923dfa38ae96d:

  regulator: tps65132: Add of_match table (2024-03-25 19:28:27 +0000)

----------------------------------------------------------------
regulator: Fix for v6.9

One simple regualtor fix, fixing module autoloading on tps65132.

----------------------------------------------------------------
André Apitzsch (1):
      regulator: tps65132: Add of_match table

 drivers/regulator/tps65132-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

