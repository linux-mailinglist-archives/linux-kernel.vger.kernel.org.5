Return-Path: <linux-kernel+bounces-71898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B2E85AC46
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9102282E84
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC755A10C;
	Mon, 19 Feb 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8gTpAJD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06FF59B67;
	Mon, 19 Feb 2024 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371888; cv=none; b=sr8/MR85WIfc6NI/8aM4iX04qmaOOmVW0Kgzvm1qycg5cVP1Y4L5GeBvkwWpoJBesJqzlf4P5ESeY4gggGQla15zQx+OHF6KugT6zNgtab9z/P7vSdLZ2y2FhEWYT8D79aJuFiZ96M3yaRSszzetycmRbCzCpkEyYwFp3Q7rM2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371888; c=relaxed/simple;
	bh=JKYORKiKp9fESKQKjIG1tUqNr+4IIyTYixshjOr7TsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NCmemoEOoR55PbQ9dQiZ58XegXqG5lYbfZLFnBxWox4YUiJWUJkrAvBpTpsafAodltgaoMicmFff3mVeLwKRhDjU0UgeqS7LRusyj5POFjZMTL68KNCkAIJHcM65cbJGhFDVkC6lmQ33WwL9AgPivq6lyXu8zoFCPc1RTP3pRJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8gTpAJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F302FC43601;
	Mon, 19 Feb 2024 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371888;
	bh=JKYORKiKp9fESKQKjIG1tUqNr+4IIyTYixshjOr7TsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8gTpAJDSUzJv8SYnqnTE+B4iPJvIqmm7yTz4AgyCUn2q6YUpC/PRX2+d/wOAti1S
	 YgtPp8CLq7n025xJ/5a7E8FrGh6nPgEzzziDF/GySMDgyJzDRX9qe9+GEIxn8frWWv
	 vFkGXpDH3rBXUZzCeYvB5bhyfjtRAZODGi9WIx1Dqnh25o70cAIH/DiPCnjmB0C9hE
	 e8zcW3eIeT4hAqhLacEzc6/J49hpuP9T1531pVqwKmDi3tv0q1ihiL/i+WIvv6LR7y
	 Bkkc9Pm5IH7cnm1+YZN2RbaqMCGNqhltt4sznZ+sKGB+D2XikKVTeEVt+z46zXNubF
	 7cb1/2hWWXAuQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/20] Docs/ABI/damon: document quota goal metric file
Date: Mon, 19 Feb 2024 11:44:27 -0800
Message-Id: <20240219194431.159606-17-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219194431.159606-1-sj@kernel.org>
References: <20240219194431.159606-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the quota goal target_metric file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index a1e4fdb04f95..dad4d5ffd786 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -229,6 +229,12 @@ Description:	Writing a number 'N' to this file creates the number of
 		directories for setting automatic tuning of the scheme's
 		aggressiveness named '0' to 'N-1' under the goals/ directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goals/<G>/target_metric
+Date:		Feb 2024
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the quota
+		auto-tuning goal metric.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goals/<G>/target_value
 Date:		Nov 2023
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.39.2


