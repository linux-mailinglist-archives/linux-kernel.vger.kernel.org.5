Return-Path: <linux-kernel+bounces-101818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416E687ABDC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F116A283161
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F9F5F54B;
	Wed, 13 Mar 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1iX1o8k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632569D3D;
	Wed, 13 Mar 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347849; cv=none; b=rk73adof4EPSZ9cd6p4uKuvSgMwtCjjo828DDsP5bQnPwS+uA7t4KSOG2IBjhxPcoyTB+u5qgHzY9Y+oCU+22xK+Tl+/Yl9H/Qm/7hd6BgMtswIjHM7DhiktpeiIZ+bGSx132WS5eYxmZif50XX1bdNFETsoXKruGNCPT6TN6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347849; c=relaxed/simple;
	bh=elnMBHka88rUmVGmopIALyoBEoazhj+EqQHa0KAIQYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpn74kMQU7KjL3renTQm2ZL2NSFomkFSx1OjXr28YhXKCwcFjPKZuoUtJdZmTh1aWtBQAlzeKS4XpN0qdJM/FOSkCrBzxu1v9Zkq4eomDqNEHTmd6H4UaAcGEkignzwfEnm0qVXV0+hP7csWiA5B3iywi1wDv2cGaZHd9K81iUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1iX1o8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E9AC43399;
	Wed, 13 Mar 2024 16:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347849;
	bh=elnMBHka88rUmVGmopIALyoBEoazhj+EqQHa0KAIQYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1iX1o8kLVwOLfFJToccAiNp3E81IiEm4Pb4WOUVR+e8ebfBLaRXu82oymqzTn8nf
	 707caOqh7YA/uHzK0HQk2+BYW5oPDIRy63eG9YCbbTrULA/sQINXkq0XQBVx1w48XQ
	 XPFYWPeJ47sv5xiN0/zQYAd7wXz3ao8sjJq5jQpgjo/SodxFxYoUwytnwIa4XJlDgc
	 7CqZMiUVzZkU1ra8Jy6E6yv9kf1Zh6v6qZ8GrMczIbPCJpklZ+fLtqNYEA9TjLGLTB
	 tqgiBwAMuEhmKntkRlfc/DN1UuwG2uMvhgTKbbW6iEnt4xC1XazokczT7DrPrlwbsv
	 ZTV9UWcN+VCiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 15/60] Revert "net/mlx5e: Check the number of elements before walk TC rhashtable"
Date: Wed, 13 Mar 2024 12:36:22 -0400
Message-ID: <20240313163707.615000-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

[ Upstream commit b7bbd698c90591546d22093181e266785f08c18b ]

This reverts commit 4e25b661f484df54b6751b65f9ea2434a3b67539.

This Commit was mistakenly applied by pulling the wrong tag, remove it.

Fixes: 4e25b661f484 ("net/mlx5e: Check the number of elements before walk TC rhashtable")
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index d5d33c3b3aa2a..13b5916b64e22 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -152,7 +152,7 @@ void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev)
 
 	xa_for_each(&esw->offloads.vport_reps, i, rep) {
 		rpriv = rep->rep_data[REP_ETH].priv;
-		if (!rpriv || !rpriv->netdev || !atomic_read(&rpriv->tc_ht.nelems))
+		if (!rpriv || !rpriv->netdev)
 			continue;
 
 		rhashtable_walk_enter(&rpriv->tc_ht, &iter);
-- 
2.43.0


