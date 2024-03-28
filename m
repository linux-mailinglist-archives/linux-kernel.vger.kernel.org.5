Return-Path: <linux-kernel+bounces-122943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837D588FFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EF91C282A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A807F7CA;
	Thu, 28 Mar 2024 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0evmTQG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E4480620;
	Thu, 28 Mar 2024 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631721; cv=none; b=d6DTrABHgk2GYZLXihSGP6YrJBFEyMX55/V7RJVG8L4U2NOh40f6Lz/hmqHN100KGZnB3tFhLLmN6QEc7StUlPIfH/Ocwuvccv3/rzT6LPFjUXaIILx5MVGfxrSahEhNCxprQGlZoKgYMkTEkTpqT5YGHaX+XVo8QoXx/X5MEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631721; c=relaxed/simple;
	bh=m+h/KdE9apj2uOki2BwzpthHKlZsGJkW3Mwx6nf/uSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NWGc6VX5SxImBiA2AaszXyOm5cjZLByzYJaUPZoorQXEIOWOpJC4NFfx4YUDMt0Bm/lynGseykNhVaY6tjOpTMXpHoLYq8b8J6Khtp586lO+I9aRRaW3ume+0igSuRHy6heiMrm/eXnxhTAVykUn01HmBZM2r54m1rpHbcLurzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0evmTQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ECFC433C7;
	Thu, 28 Mar 2024 13:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711631720;
	bh=m+h/KdE9apj2uOki2BwzpthHKlZsGJkW3Mwx6nf/uSU=;
	h=From:To:Cc:Subject:Date:From;
	b=h0evmTQGspNWIp9UxCKK5g7GZlsPRhW+Ixig9oMLHg46zlCMFblwQzP06UDKGcFVO
	 aChVP7F5CFGgUQfGS4nUPTH5R2A3XmDOR4pW4ZsNNINcCqtFBRrHt1d1jFT1lk5maR
	 cxP8bYS/WAtyf6ipv9HN6WGd24NYM5CGFPCBOuvenNcC8FUrt3KvLD4ebl/4Dj582A
	 ngaMla9n4E8weFmdwLrwP4hVSnZlA7kr/PEaw08tdTmSBNpNj3GdImauAC9zBz3Bzq
	 A3AwiRhOCXzv/fgI5DhEmk70kpqSCs7OQt9lUWeA9riDhPOsZUuU0G8okELQj9fAsV
	 mi9ZtLJqcflhg==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect fixes for 6.9-rc
Date: Thu, 28 Mar 2024 15:15:01 +0200
Message-Id: <20240328131501.641457-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This pull request contains one core and one driver fix for the current
cycle. The details are in the signed tag as usual. It is not based on rc1,
but on a previous tag that you pulled, because i got these fixes during
the merge window. All patches have been in linux-next for more than a week.
Please pull into char-misc-linus when possible and propagate further when
you have more char/misc fixes.

Thanks,
Georgi


The following changes since commit 5464e7acea4a6c56b3c5c2d7aeef2eda92227b33:

  interconnect: qcom: x1e80100: Add missing ACV enable_mask (2024-02-04 23:36:06 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.9-rc2

for you to fetch changes up to de1bf25b6d771abdb52d43546cf57ad775fb68a1:

  interconnect: Don't access req_list while it's being manipulated (2024-03-14 13:51:44 +0200)

----------------------------------------------------------------
interconnect fixes for v6.9-rc

Here are fixes for two reported issues. One of them is a fix for
a driver that tries to access a non-existent resource which prints
a warning message during boot. The other one is fixing a race
condition in the core framework where one struct member has been
left unprotected by mutex.

- interconnect: qcom: x1e80100: Remove inexistent ACV_PERF BCM
- interconnect: Don't access req_list while it's being manipulated

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Konrad Dybcio (1):
      interconnect: qcom: x1e80100: Remove inexistent ACV_PERF BCM

Mike Tipton (1):
      interconnect: Don't access req_list while it's being manipulated

 drivers/interconnect/core.c          |  8 +++
 drivers/interconnect/qcom/x1e80100.c | 26 --------
 2 files changed, 8 insertions(+), 26 deletions(-)

