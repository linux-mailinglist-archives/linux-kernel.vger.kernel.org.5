Return-Path: <linux-kernel+bounces-154269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C362D8ADA1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF4028706E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4295161327;
	Mon, 22 Apr 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCL5DAaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C8161305;
	Mon, 22 Apr 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830184; cv=none; b=lPko327kU5N/XXa+7JTlU3nXCErLceHyb3B58lP9pnDpnaqOB9LwJeD7CbACBGy0nMbyvROTPZ63IYSw7fskCH8vmxZfz3hotdQXDF6GOcZT1pJ/EbDLL7C+7pXk6i7fXzbQ+Y+8QqJKJxuqTbtzOyPHsgaEVjAUMEn3FKyTxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830184; c=relaxed/simple;
	bh=463WU74UafRM4JLsYmYPi8HB3ZVhJzdNeKKPSlj0sEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMmggizlPsZGOyMi6CGHpMehgZYXnR3nIzQ8+tgItOi2hFbxG6aVJLNWGfclb6xS/b+KOOawk4zZjDGE4F5boZcDsVBiD9WGZu214Kn/Gd3YqEY+gQk/UAP3zp0hY6ZhnE4ulv9HoohHqYkaIjd/Pwh1BLD0rb4n8JLi7UYKjF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCL5DAaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9064C2BD11;
	Mon, 22 Apr 2024 23:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830183;
	bh=463WU74UafRM4JLsYmYPi8HB3ZVhJzdNeKKPSlj0sEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCL5DAaWh/caWf4syXm4FvCvCMgKyfv1s/TiHdcW4V7QAP9di9LUXR9DZbIzC9NSE
	 AXDDM9pQ3ggN0cGaQDSndEizZreu/CUZeVR7nmhk+/vUvBX5Dy8Kw0k/QcKt/W2yia
	 CSQkoaJ01h8iu5mp+qxVxRoWRxCVezUP91PPdtPsQCsg5oyfrXC0dc146EazSo+frk
	 WGhbpGE6t9ygF3owRgS3ZDGyMm7SpyaQjJoRhGiYiwKl1mAnKPcISCeyfp04NghMqv
	 GQNOrR98av0PhxorOjiDmv37RREVVoDNKTmNpoo4IOMMTbXfkjCezfvWd3kVV2fKsz
	 gn3usqefwQ8HQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	rongtao@cestc.cn
Subject: [PATCH AUTOSEL 6.6 08/29] memblock tests: fix undefined reference to `early_pfn_to_nid'
Date: Mon, 22 Apr 2024 19:16:49 -0400
Message-ID: <20240422231730.1601976-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Wei Yang <richard.weiyang@gmail.com>

[ Upstream commit 7d8ed162e6a92268d4b2b84d364a931216102c8e ]

commit 6a9531c3a880 ("memblock: fix crash when reserved memory is not
added to memory") introduce the usage of early_pfn_to_nid, which is not
defined in memblock tests.

The original definition of early_pfn_to_nid is defined in mm.h, so let
add this in the corresponding mm.h.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Yajun Deng <yajun.deng@linux.dev>
CC: Mike Rapoport <rppt@kernel.org>
Link: https://lore.kernel.org/r/20240402132701.29744-2-richard.weiyang@gmail.com
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index f3c82ab5b14cd..7d73da0980473 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -37,4 +37,9 @@ static inline void totalram_pages_add(long count)
 {
 }
 
+static inline int early_pfn_to_nid(unsigned long pfn)
+{
+	return 0;
+}
+
 #endif
-- 
2.43.0


