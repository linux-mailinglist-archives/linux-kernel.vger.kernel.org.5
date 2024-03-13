Return-Path: <linux-kernel+bounces-102017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1BC87AD9C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FDA282B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEF265189;
	Wed, 13 Mar 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9hzHWNQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C5814EFDB;
	Wed, 13 Mar 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348231; cv=none; b=BjL9ljSNRCf869FC6rT8b+j3+0S2Pgk1T4DAPf39jspDgoniBqU4Y/KtCPGqOpKasLOig17KV3Oh3Yeuh5HXdOENQ1SUVsoXNlLCIiGIXkhbd/NQyTL/U4P3ctHJ4dsrVPrZESphSgD0Q2KrVCIYFqkEgUafxFlVeSANCTo/meg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348231; c=relaxed/simple;
	bh=XRFMJqIjV3rtLAD3YwO2M67wwOFBpj3sqQC4IfSTEAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAOEFy2JCRqsiYvhFvl5DaiVCkq53YS0rKftd9xTBoMJcuA6MChzMSqe6ZT2ICE7V7NWBqCq3U6S5LxxHKjyFkXyL3xclGMn3j/Wv3U4JQt+5LzwPRT0zRtppAT7Dw9bi40zJd41rh3iBe5ObBQK3Hf4GgL6sfopLv9l45GGTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9hzHWNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A306C433C7;
	Wed, 13 Mar 2024 16:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348230;
	bh=XRFMJqIjV3rtLAD3YwO2M67wwOFBpj3sqQC4IfSTEAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z9hzHWNQHP6G6CoWkYaYDOoSZTnj91+mMG4qz3dHLdRbBbgj8XY0eSIPqQjGAVL33
	 rgCk7HU2CpgdW2yG+mIEaj/YC1J7Lur4qF47BqFE7m77t3ZSopGhOYRpuAztO58U8L
	 +NfMWWY1un6hG6VAmhlnhv1Gl7XK11RTh1tbU8J0zjj7SIkhMwgL9y3MfRCZp6dNtw
	 s9i9qRWGQc4O2v+5jRAecDgHv48lXRa3Vmu3yC1nbsDbhTOkI9l0gEZgMyKvX+kX19
	 gWEPDI5bl3+fo9ISmJlTccmo3XyC+W8Svg/6EmCJy8I1nqkmGTVwqdBS/Q6R+qUmvN
	 NWZGW1i3D+zpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 76/76] Linux 5.15.152-rc1
Date: Wed, 13 Mar 2024 12:42:23 -0400
Message-ID: <20240313164223.615640-77-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index bb73dba0e5052..34a2aba46cebf 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 151
-EXTRAVERSION =
+SUBLEVEL = 152
+EXTRAVERSION = -rc1
 NAME = Trick or Treat
 
 # *DOCUMENTATION*
-- 
2.43.0


