Return-Path: <linux-kernel+bounces-57488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE284D9BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F241B239A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF1B67C6C;
	Thu,  8 Feb 2024 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qobWeyRg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD767C65
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 05:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707371859; cv=none; b=D8lLUw5zKMoLu3XVcyKg3HPk02QHnInvd5j4ibYTxsCrHntk3qcdFIwoq7Ms+0UrqSr5D2D+ib4omNGJjHGemTyDaT46j8dSFo7M7jZoWn/3omxY6D7P1KZmqM/ZfqSjiy3w3cOgvVKNl1BVq8f/XsWkuqXKpJk//0A2JxyugxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707371859; c=relaxed/simple;
	bh=qs2ZH+IMPreIcpGqfLhXaBid/V19O7NUQFYfUfFiAaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Etn4cLTwsLXt6fVsrXl7fS5DwbWniGB4HAPoXbHH3trX0D5j+laRBTWKGQWB4NwKa/mJcoLx5z3adykwPaisOGMr/ZJZR6LA63bu3KYAk850AKnfyt6k4SLfjfH3JZkBcA4QZK7kAtgpTFKDW/2HDsEvN0lWUV89dS3VlJ+cnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qobWeyRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7C9C433C7;
	Thu,  8 Feb 2024 05:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707371859;
	bh=qs2ZH+IMPreIcpGqfLhXaBid/V19O7NUQFYfUfFiAaQ=;
	h=From:To:Cc:Subject:Date:From;
	b=qobWeyRgRAgU9May68PgmQwTn7GhMhfvD2HUG+SihzQxezkMQs2669xpCEBrzPshC
	 ujPp2q/KoXk9+pRKrGRvmemBTVVeUMyPUU6uLOIEzJuHstoLhW4jzNKexCLut8lvKL
	 aT97E6VFo5+dMamtfVtWBAjoZjmb4iI/EPOXLdMHEdFaKHu88fa7iqpip2L0kpkCTP
	 sA0bEaU1A1kHqi1bJBw9dRLGKHjeXkd50H8eX2W8gLVkiNV5120OvRnb0JKzsvL1zo
	 52fgyWlVpupGiZlvOJi/dJzk2ncM8vQr4F6IOiPaiT2NIEJHViUEAGenUgz9qKd8Me
	 gXTdz2ZAvkmYQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update mm and memcg entries
Date: Thu,  8 Feb 2024 07:57:27 +0200
Message-ID: <20240208055727.142387-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Add F: lines for memory management and memory cgroup include files.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..ddf11ff13b86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5383,6 +5383,7 @@ R:	Muchun Song <muchun.song@linux.dev>
 L:	cgroups@vger.kernel.org
 L:	linux-mm@kvack.org
 S:	Maintained
+F:	include/linux/memcontrol.h
 F:	mm/memcontrol.c
 F:	mm/swap_cgroup.c
 F:	samples/cgroup/*
@@ -14093,15 +14094,24 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
 F:	include/linux/gfp.h
 F:	include/linux/gfp_types.h
+F:	include/linux/memfd.h
+F:	include/linux/memory.h
 F:	include/linux/memory_hotplug.h
+F:	include/linux/memory-tiers.h
+F:	include/linux/mempolicy.h
+F:	include/linux/mempool.h
+F:	include/linux/memremap.h
 F:	include/linux/mm.h
+F:	include/linux/mm_*.h
 F:	include/linux/mmzone.h
+F:	include/linux/mmu_notifier.h
 F:	include/linux/pagewalk.h
 F:	include/linux/rmap.h
 F:	include/trace/events/ksm.h
 F:	mm/
 F:	tools/mm/
 F:	tools/testing/selftests/mm/
+N:	include/linux/page[-_]*
 
 MEMORY TECHNOLOGY DEVICES (MTD)
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
-- 
2.43.0


