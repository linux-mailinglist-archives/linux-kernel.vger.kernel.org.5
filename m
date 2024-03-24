Return-Path: <linux-kernel+bounces-115609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D22DD889ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC44B64ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56B7347C5A;
	Mon, 25 Mar 2024 02:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6Rz501K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC07130AEB;
	Sun, 24 Mar 2024 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321366; cv=none; b=Zyvu84Elh8WAHtvWVHrpju0D0/+hwVCpehtDdK4Nmlxe54qWgK5w/O0ofCem22p2kTXDmEXhZ8wD5aJNzfEzbYD14vlMwc9FGzCBFAFGXTFP0VENd4PDEwLAaPlTeaAEx3X+hR6wJ0fMg1yHbDk32EARI03wMlqdI46619aRNoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321366; c=relaxed/simple;
	bh=i0oQUREjAqNwxGyvagSKI/3J+uyjgN2fidxYHn5b9EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AakM9PWDyUi8pRwLtWZXvsTeVMmDQvEO9RKs48AUxrQgOxiJpMRLmtjT3Wlf5iTRsgxQVQ2JjBWnrhjTw8eLUq+yXJ0LzUurT9JTpyacAIZi675fsMVHoL8k8MGHP2X/2t4hFO7TQ9svkfkO8LrAV1c+nhmRsI0f74Z1zrAawjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6Rz501K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52775C433C7;
	Sun, 24 Mar 2024 23:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321365;
	bh=i0oQUREjAqNwxGyvagSKI/3J+uyjgN2fidxYHn5b9EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6Rz501KoCtNIxUtLGE0TmzUs2ogElHSbL9e6FpQHiD1nLFZnkYnXM2URSEGfbHAu
	 jxZxg0XRLbo9fOCSmxsOfKdY+Iv73VqGyf6H5l28qQsFVX+PT4EU5JjQQKY86NigRx
	 yix/Ly8uz6q9U753De63lTogFvIed4wGXe9cbS4KmcS4kbEKlNcTQwDa4QiUA0pZ66
	 ZPIybxw8GuLq8fZ5MyXD2obt5P5AoSuvN5hlUfLhZLdb4KvFMQiYa49asy60q0fZtR
	 a7OtsHYTQhJHpPGfYrXKVnhkiHw801lEKUNVNOeW7DLiybP3mLamBfxJCzfZm92m6B
	 fGLLGHh9vILPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 089/638] ovl: remove unused code in lowerdir param parsing
Date: Sun, 24 Mar 2024 18:52:06 -0400
Message-ID: <20240324230116.1348576-90-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit c835110b588a750650988ca5000913c3c60d246b ]

Commit beae836e9c61 ("ovl: temporarily disable appending lowedirs")
removed the ability to append lowerdirs with syntax lowerdir=":<path>".
Remove leftover code and comments that are irrelevant with lowerdir
append mode disabled.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Stable-dep-of: 2824083db76c ("ovl: Always reject mounting over case-insensitive directories")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/params.c | 95 ++++++++-----------------------------------
 1 file changed, 16 insertions(+), 79 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index f6ff23fd101c8..0059cc405159e 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -346,7 +346,7 @@ static void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx)
 /*
  * Parse lowerdir= mount option:
  *
- * (1) lowerdir=/lower1:/lower2:/lower3::/data1::/data2
+ * e.g.: lowerdir=/lower1:/lower2:/lower3::/data1::/data2
  *     Set "/lower1", "/lower2", and "/lower3" as lower layers and
  *     "/data1" and "/data2" as data lower layers. Any existing lower
  *     layers are replaced.
@@ -356,9 +356,9 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 	int err;
 	struct ovl_fs_context *ctx = fc->fs_private;
 	struct ovl_fs_context_layer *l;
-	char *dup = NULL, *dup_iter;
+	char *dup = NULL, *iter;
 	ssize_t nr_lower = 0, nr = 0, nr_data = 0;
-	bool append = false, data_layer = false;
+	bool data_layer = false;
 
 	/*
 	 * Ensure we're backwards compatible with mount(2)
@@ -366,10 +366,10 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 	 */
 
 	/* drop all existing lower layers */
-	if (!*name) {
-		ovl_parse_param_drop_lowerdir(ctx);
+	ovl_parse_param_drop_lowerdir(ctx);
+
+	if (!*name)
 		return 0;
-	}
 
 	if (*name == ':') {
 		pr_err("cannot append lower layer");
@@ -385,36 +385,11 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 	if (nr_lower < 0)
 		goto out_err;
 
-	if ((nr_lower > OVL_MAX_STACK) ||
-	    (append && (size_add(ctx->nr, nr_lower) > OVL_MAX_STACK))) {
+	if (nr_lower > OVL_MAX_STACK) {
 		pr_err("too many lower directories, limit is %d\n", OVL_MAX_STACK);
 		goto out_err;
 	}
 
-	if (!append)
-		ovl_parse_param_drop_lowerdir(ctx);
-
-	/*
-	 * (1) append
-	 *
-	 * We want nr <= nr_lower <= capacity We know nr > 0 and nr <=
-	 * capacity. If nr == 0 this wouldn't be append. If nr +
-	 * nr_lower is <= capacity then nr <= nr_lower <= capacity
-	 * already holds. If nr + nr_lower exceeds capacity, we realloc.
-	 *
-	 * (2) replace
-	 *
-	 * Ensure we're backwards compatible with mount(2) which allows
-	 * "lowerdir=/a:/b:/c,lowerdir=/d:/e:/f" causing the last
-	 * specified lowerdir mount option to win.
-	 *
-	 * We want nr <= nr_lower <= capacity We know either (i) nr == 0
-	 * or (ii) nr > 0. We also know nr_lower > 0. The capacity
-	 * could've been changed multiple times already so we only know
-	 * nr <= capacity. If nr + nr_lower > capacity we realloc,
-	 * otherwise nr <= nr_lower <= capacity holds already.
-	 */
-	nr_lower += ctx->nr;
 	if (nr_lower > ctx->capacity) {
 		err = -ENOMEM;
 		l = krealloc_array(ctx->lower, nr_lower, sizeof(*ctx->lower),
@@ -426,41 +401,17 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 		ctx->capacity = nr_lower;
 	}
 
-	/*
-	 *   (3) By (1) and (2) we know nr <= nr_lower <= capacity.
-	 *   (4) If ctx->nr == 0 => replace
-	 *       We have verified above that the lowerdir mount option
-	 *       isn't an append, i.e., the lowerdir mount option
-	 *       doesn't start with ":" or "::".
-	 * (4.1) The lowerdir mount options only contains regular lower
-	 *       layers ":".
-	 *       => Nothing to verify.
-	 * (4.2) The lowerdir mount options contains regular ":" and
-	 *       data "::" layers.
-	 *       => We need to verify that data lower layers "::" aren't
-	 *          followed by regular ":" lower layers
-	 *   (5) If ctx->nr > 0 => append
-	 *       We know that there's at least one regular layer
-	 *       otherwise we would've failed when parsing the previous
-	 *       lowerdir mount option.
-	 * (5.1) The lowerdir mount option is a regular layer ":" append
-	 *       => We need to verify that no data layers have been
-	 *          specified before.
-	 * (5.2) The lowerdir mount option is a data layer "::" append
-	 *       We know that there's at least one regular layer or
-	 *       other data layers. => There's nothing to verify.
-	 */
-	dup_iter = dup;
-	for (nr = ctx->nr; nr < nr_lower; nr++) {
-		l = &ctx->lower[nr];
+	iter = dup;
+	l = ctx->lower;
+	for (nr = 0; nr < nr_lower; nr++, l++) {
 		memset(l, 0, sizeof(*l));
 
-		err = ovl_mount_dir(dup_iter, &l->path, false);
+		err = ovl_mount_dir(iter, &l->path, false);
 		if (err)
 			goto out_put;
 
 		err = -ENOMEM;
-		l->name = kstrdup(dup_iter, GFP_KERNEL_ACCOUNT);
+		l->name = kstrdup(iter, GFP_KERNEL_ACCOUNT);
 		if (!l->name)
 			goto out_put;
 
@@ -472,8 +423,8 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 			break;
 
 		err = -EINVAL;
-		dup_iter = strchr(dup_iter, '\0') + 1;
-		if (*dup_iter) {
+		iter = strchr(iter, '\0') + 1;
+		if (*iter) {
 			/*
 			 * This is a regular layer so we require that
 			 * there are no data layers.
@@ -489,7 +440,7 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 
 		/* This is a data lower layer. */
 		data_layer = true;
-		dup_iter++;
+		iter++;
 	}
 	ctx->nr = nr_lower;
 	ctx->nr_data += nr_data;
@@ -497,21 +448,7 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 	return 0;
 
 out_put:
-	/*
-	 * We know nr >= ctx->nr < nr_lower. If we failed somewhere
-	 * we want to undo until nr == ctx->nr. This is correct for
-	 * both ctx->nr == 0 and ctx->nr > 0.
-	 */
-	for (; nr >= ctx->nr; nr--) {
-		l = &ctx->lower[nr];
-		kfree(l->name);
-		l->name = NULL;
-		path_put(&l->path);
-
-		/* don't overflow */
-		if (nr == 0)
-			break;
-	}
+	ovl_parse_param_drop_lowerdir(ctx);
 
 out_err:
 	kfree(dup);
-- 
2.43.0


