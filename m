Return-Path: <linux-kernel+bounces-133664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6267C89A718
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DCFB21EC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F7917555E;
	Fri,  5 Apr 2024 22:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuLf/LZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB2171072
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712355637; cv=none; b=swTFs2mT1d63B0AfLQUJCeFtioVCuZtXALoLnKGUS3i+USKhK6HuqEu7oILysgMAeyC7faZi6BrILgV9EGEOcVfTJBrZTWS31GMSEC2NOb+wZigJ124SDRUHBeorkVmjqmpi39C70ysdM2BhH1H3+E32FZcUz6WN6FNw5IX3zlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712355637; c=relaxed/simple;
	bh=uTY5jVjpH0FTqCBHDUNVadQhyUCYEKH4MhY3pgtsHE4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=amGJa4L9aftlOdxrpMRY7PnzKVl1Yn49ENIiScfTO+XRHL+hYljNsaAAD3hlRZVM+xKPSx9SQ1eHWTM3pBjjvtCY6IRRjZKoScsZRunryikQyX77R3eQl6//QTpvxZ+JmylQmZ8b3ze1mtV/Ccf/f3bnYiesVJyYydVvSdMIoiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuLf/LZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306A2C433C7;
	Fri,  5 Apr 2024 22:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712355635;
	bh=uTY5jVjpH0FTqCBHDUNVadQhyUCYEKH4MhY3pgtsHE4=;
	h=From:To:Cc:Subject:Date:From;
	b=EuLf/LZCNa6DplLX2Ma3a/UWKJxHs7SZD6lsF1wcFalsEZ3w/v63HkQAhRu5tB2ju
	 1h7Kbz+8ZhhXskqcHtYjIEOoMJA3IQrhvjO2mkxNnrijdRgrgifbLNBuF8+WqFIf3i
	 e+4oxokFpFFkpzFELmaNaP4Y3ZC71IRCKccsLGiHOCa387XfCnolX4H9SWCILPEUlV
	 ekGmlOPAz4uq2/DsTzO+0lYCat66QJ+1jSbxV5MeX7lzf0QdjLmozpulf/YryRJBNX
	 bTsW2+fVbH3ejAzXPxWhpvH6gASFgEgm2IJAq0a6RlwctKPMjm/hb/wgU99zlnNm5P
	 Mq2jC0GaXkdXw==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.9-rc2
Date: Fri, 05 Apr 2024 23:20:26 +0100
Message-Id: <20240405222035.306A2C433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.9-rc2

for you to fetch changes up to eaa03486d932572dfd1c5f64f9dfebe572ad88c0:

  regmap: maple: Fix uninitialized symbol 'ret' warnings (2024-03-29 16:32:26 +0000)

----------------------------------------------------------------
regmap: Fixes for v6.9

Richard found a nasty corner case in the maple tree code which he fixed,
and also fixed a compiler warning which was showing up with the
toolchain he uses and helpfully identified a possible incorrect error
code which could have runtime impacts.

----------------------------------------------------------------
Richard Fitzgerald (2):
      regmap: maple: Fix cache corruption in regcache_maple_drop()
      regmap: maple: Fix uninitialized symbol 'ret' warnings

 drivers/base/regmap/regcache-maple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

