Return-Path: <linux-kernel+bounces-102100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF80B87AE67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B50D2837B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3AB59B45;
	Wed, 13 Mar 2024 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL6qwwwl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A0F18E765;
	Wed, 13 Mar 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348485; cv=none; b=dfodiuRrqpdhAyigulPoanzk8PIefm+g7k/SEfnNhqPU7cb5fDUX9FykWIihX1zEv+RQTnl+A6aezpkls66XW8XqclvjS17Vw3FEhDpHlMKCzSY51G2SqEV6EyvJQaaTiwPADffoudGT/k46SmNws+nGlLS+8JA8RGttObSR69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348485; c=relaxed/simple;
	bh=W9xFk2aGKq23BRvIDavZFLWHtpgTel/LJN8fQNnslCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFjCH9XXizB02rrcxU/3bMzsrrUpsp3VusA5QSRj1mgcpPa3LmGUEqwZ5Xn/6yOL51487SItnKrdImiEiiH+ZzeUKF9W5ddDtW2JEjAEYwHc5aMvir/m90AwOeWhBkczwckZ9jw3+2owZk6t0Bp7ZkGNDOWlRcnUARJbUm/98R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL6qwwwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034FBC433B1;
	Wed, 13 Mar 2024 16:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348484;
	bh=W9xFk2aGKq23BRvIDavZFLWHtpgTel/LJN8fQNnslCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lL6qwwwltJ5Dt+5NEv7q8FxsMM78YBd3dReQJAndX0kswXPzFJlbSN8NdiVLGK5oU
	 8KXDbK2yBsKkWJFsmOpgrGK5knCn4nlMsYQwfP4+OhclAUqigOoK3FcAcnJVjwSQ4X
	 OTLzOCZA9Xd/WrkmU2Id6MzcBcnGo+8x3eaIQr9v5bHcr6w4lFd1gNv+3LaQlJO7Hq
	 /yJu7GoqtZIq24zUZs+J8LLFPygnU1tt5BczIXkOcGC9vNtxL9tYKcpJNzH2o2KtQt
	 XNgf7Ls8K+487JXBLZqTFUHOW9nxiIQpcZGM34zotcy/UvHskLK8YQpElCIEfs7BzM
	 S47sY0K3hKW9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 73/73] Linux 5.10.213-rc1
Date: Wed, 13 Mar 2024 12:46:40 -0400
Message-ID: <20240313164640.616049-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d7ec0be4cd791..fe73c377e5e47 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 212
-EXTRAVERSION =
+SUBLEVEL = 213
+EXTRAVERSION = -rc1
 NAME = Dare mighty things
 
 # *DOCUMENTATION*
-- 
2.43.0


