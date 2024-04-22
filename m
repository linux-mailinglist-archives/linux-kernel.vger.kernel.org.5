Return-Path: <linux-kernel+bounces-154298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 313C58ADA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CD5281488
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE16D17BB09;
	Mon, 22 Apr 2024 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXKEHIIT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD2A47A7C;
	Mon, 22 Apr 2024 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830261; cv=none; b=LiLROkK15sQlRaggmhbMz0iTJcqVQgcHvQXTY/PND31em1ee1c7iymNPbC4Dz3LTjfUXK99rIGGXCx3uVXkFWjkCT5HoMywL26rpb2Mw28DzUSjC/1w8dadxjeH+fHP0yc9EoiIiu66o58yE71NsYqbaciqz0yZX04Is+jUzTOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830261; c=relaxed/simple;
	bh=FgoSh+QPbzaQrY/HfqxnOD/ntA5TUZSR+j4YUz1zZmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iynj4WFWX1/V2tKwJnuzD0/vf3t2bdeXexGV6rkOiCffR54aY3LPCj1FuTfpyjY0pRptmqrCzCZpNBUv4yqILkAXNfUWqZDz3u+acz0LnYssCNup7wF3MX+nz1h0EmtwDY0Vku4LhS3Oe/ftf5Ly972TaZ4rO2mbnTC108k+1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXKEHIIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C13C32782;
	Mon, 22 Apr 2024 23:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830260;
	bh=FgoSh+QPbzaQrY/HfqxnOD/ntA5TUZSR+j4YUz1zZmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UXKEHIITFq8ostax0QnxPN+ce8ehNCgvji3YtvUDyAQWCaNRjSqbj9U9ceb1RgBtk
	 i03Azqk6lWYQNkhuJoLGSWOLTJqTlMSIr5A+zXS4i8VSJbm4b3FytDCXKpGUu6/7Wl
	 e+QsRggtM7l/biPPjV1suoCC7ex3/6DobfS6bjQHfP9yibEHjiMMQFP+8lbt7oydrp
	 5mU52tNQiOavxjqlbwC4cux32xqpQmc4ubhxl90SBkSW4183sfaTL5MmPXqS9NOnAe
	 sXmFIvNWelbdeSv5hv+XHSTC4FQ7APuJ28ztgw1EQALf3zEuNA8mun+fvckk0+4xCt
	 oNHEYDKSfpa4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org
Subject: [PATCH AUTOSEL 6.1 08/19] memblock tests: fix undefined reference to `BIT'
Date: Mon, 22 Apr 2024 19:18:22 -0400
Message-ID: <20240422231845.1607921-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231845.1607921-1-sashal@kernel.org>
References: <20240422231845.1607921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
Content-Transfer-Encoding: 8bit

From: Wei Yang <richard.weiyang@gmail.com>

[ Upstream commit 592447f6cb3c20d606d6c5d8e6af68e99707b786 ]

commit 772dd0342727 ("mm: enumerate all gfp flags") define gfp flags
with the help of BIT, while gfp_types.h doesn't include header file for
the definition. This through an error on building memblock tests.

Let's include linux/bits.h to fix it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Suren Baghdasaryan <surenb@google.com>
CC: Michal Hocko <mhocko@suse.com>
Link: https://lore.kernel.org/r/20240402132701.29744-4-richard.weiyang@gmail.com
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/gfp_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index d88c46ca82e17..6811ab702e8dc 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_GFP_TYPES_H
 #define __LINUX_GFP_TYPES_H
 
+#include <linux/bits.h>
+
 /* The typedef is in types.h but we want the documentation here */
 #if 0
 /**
-- 
2.43.0


