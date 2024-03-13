Return-Path: <linux-kernel+bounces-102227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3835587AF97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0E91C26D55
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4752815112F;
	Wed, 13 Mar 2024 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ2TFM26"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73A76F01;
	Wed, 13 Mar 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349524; cv=none; b=qBIYrGCOurb20n09tNmH6AuYx0EjbqhFIm2XCjlKo5mEKDs30Hlt778mw8yPRUavByiOEq+SjIxXpRFhEYfFemjqekJUdmWXc1hNFQ0xk3Vqptb0lnmOmgW3emc3qYp0Ww0lb6e9bX/DgIfd7rxyLjrZtQH4KiZqGqlD8UuooHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349524; c=relaxed/simple;
	bh=8pPanzqmda9HQRheRwuL+iwvrL5EGjFgJRManGKVxic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onvYeGZwZBGV6FXHLno5/GqXcl9gXnC3Q7uakTJwtUhilsaMVwFvtXR//5iDJ5JHxLbmrtkUYS9hDNWZ1RdGYCUsxFHl1bb/hoHhDIKlBlkIw58VavE2ATTgBteH/tCfZsuC7LWCPWRD2YzEl/c+YMpoWebthjP77TlcBppjwkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ2TFM26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60C6C433C7;
	Wed, 13 Mar 2024 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349524;
	bh=8pPanzqmda9HQRheRwuL+iwvrL5EGjFgJRManGKVxic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZ2TFM26jcdkz1k+lDAKfnmk9brZ4Lpfyq+Dz1YQzK0epOsSHT8wShOAu8L37tJE4
	 o5BVZbE3dFCltQBlmq1yhHuO64V7+4hAYBuqVwFSA3f2Riyp/rJgui/MJ4jYGIGNFo
	 gm1kqvI0QtBWkDh1tGTPOe9HVKYUSHnmaRAi20+daEnmoe+yf/rmt+DmjPGzFqcIXa
	 dc17s4qlMJiSFPsGUkX+1Hggqb3SuvKPGt5HUFMHoGXAGieOISPqtKZx3+Ktla0WEU
	 Z0R3pCAcz2Q8Tomf1KvEoeC82eVEduDzXaPn6sguupNW07ToQeyLLk69+EwkxFb7z8
	 Sf1L5Zb8IVqkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 41/41] Linux 4.19.310-rc1
Date: Wed, 13 Mar 2024 13:04:35 -0400
Message-ID: <20240313170435.616724-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9648c95ee3201..2e45148cd10b2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 309
-EXTRAVERSION =
+SUBLEVEL = 310
+EXTRAVERSION = -rc1
 NAME = "People's Front"
 
 # *DOCUMENTATION*
-- 
2.43.0


