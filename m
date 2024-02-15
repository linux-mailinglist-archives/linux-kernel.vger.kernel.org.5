Return-Path: <linux-kernel+bounces-67826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89157857181
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3FA1F217CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB02145B10;
	Thu, 15 Feb 2024 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsI4PMKX"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2831F13DBA4;
	Thu, 15 Feb 2024 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708039315; cv=none; b=iyWvNl0mpi2gc4KKnubhDLV9nvO3qBo/H37k8uaU6zO1qcqE02CZI63G+C9zR/tOtZ1LHkJZT/C9YyhGAdt4PDkOWFEG92m9OsWK1v8eC1p57IrLoPVgmOmHXFq5jIq81XkQLjrP7dG9nz0zy1XGLs7+ilDLvCp/AVFbqR/QYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708039315; c=relaxed/simple;
	bh=PxZ0C5029R4CmL53vNyyyaYcbdLIwRGPgflhW6LzmCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Trw4slXnMogdazZlkIXHQ5W1W2HANo+sRHaCncxSt+Np6x4g3xpwXJt3bt9sbbTKu29vKbkN6viQMhK3Y6ELNohDXHem1OM5g1CH7VdAxTthDwFpxi1kNgOPEmYa6k8ly3xxGe+J59RFSbn5+7gD9Pg2A8bfraeOP+FWQZosjJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsI4PMKX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-411d76c9ce3so11898565e9.3;
        Thu, 15 Feb 2024 15:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708039312; x=1708644112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6D72u9OCvXFc6xIZabN3BHkMoZhGyXgCQr1DeQ1S8gQ=;
        b=YsI4PMKXbnwLvPqr03H140KZU9clMCADu5IwnJYSTDzSA29mJ00XrH7KyuLm97wa3/
         0fjat+vU1MsSUVsK5pW9UhDQ9ZYzmyeKQggyK6Cz/sTJuve1VGKrJwL6kdBsI77SQ0B7
         5DKGHx3/RalefnZRk03HDFiWSRFndpBpbF/Nj7C24oNmJPR+qCSa/z5YSQXrvkIB7HHe
         mVKPNz0uauWxXlNVSt9TP9U8W4qMs+BtPcXbqh0B/cAYPw/VuIQDfTYfEiwwaUhtyZof
         lUw6/5u7JUIeIRBGcQCbXtfESIuGIoSAywKROjMkt/3J1BdmstWei6qShM8LKOF+WVUW
         T5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708039312; x=1708644112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6D72u9OCvXFc6xIZabN3BHkMoZhGyXgCQr1DeQ1S8gQ=;
        b=M2Zu19mnjhURIon53ooC7DswmL+zkVoa7oXeW8lsvx0uOmWY9gSWNBAp4dQccceRP4
         h5y9ATYngf8Ks2un7aimwpjXHXga4Aa3k3la1UiHUei1+dPtehJ0LYVvC9GsG0TEeJxS
         YaRC5uocBd2MHqzRexFvJmfvadAemIWe19r8ru9DFZpz3ZP1zHiAlZP3jmsMXRDQ8AP5
         Q4ZDqkRQNAEA3xPVXX7WrYS0Hu1hn/iEnc3fDUchBmvh5Eu+7aUqa7uAc80udJvKiDwn
         in2iLmTy3sx6RBStVZtgf5axEvabSh9BBPWnE7vMCfL5suVfxcZj81JDRaAl07IbOtAR
         Uc5g==
X-Forwarded-Encrypted: i=1; AJvYcCUF280JdBT4HFIYN9DfiLWuLPMGFEgS7rNr/QbI+DwNMZG4czCo5MaPM+lBZoQMyQyDDqpzjQh7wHqVufjTbUd4IbEoxjSgB8pF+vEiaUivh3YtOX8J5tY87b2i9f74a8uv3ZxAD4tYbwaz9vaucWlY3oC+JT72GdcY7Fm13a7cLlfEIRs=
X-Gm-Message-State: AOJu0YwAQ78Os5b5dfKprcZsmqZdmv/T7lNnszMlNj8f9gdg9eFtBWvy
	872IAT3UuRriOF/jXsV0xO+R+MEzQc6t/Zbc1IusxOo0etWWu9Md
X-Google-Smtp-Source: AGHT+IFM+Tkd6DmAKXKi//1/Ntx3dDJahu5QeiRyAdMYEH9RSkeO98alH8ZM5ZhVx6fRbAST+feLtw==
X-Received: by 2002:a5d:5106:0:b0:33c:f574:3706 with SMTP id s6-20020a5d5106000000b0033cf5743706mr2319455wrt.63.1708039312294;
        Thu, 15 Feb 2024 15:21:52 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b00410e638357asm541891wmq.10.2024.02.15.15.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 15:21:51 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: mac80211: clean up assignments to pointer cache.
Date: Thu, 15 Feb 2024 23:21:51 +0000
Message-Id: <20240215232151.2075483-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@intel.com>

The assignment to pointer cache in function mesh_fast_tx_gc can
be made at the declaration time rather than a later assignment.
There are also 3 functions where pointer cache is being initialized
at declaration time and later re-assigned again with the same
value, these are redundant and can be removed.

Cleans up code and three clang scan build warnings:
warning: Value stored to 'cache' during its initialization is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@intel.com>
---
 net/mac80211/mesh_pathtbl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 735edde1bd81..91b55d6a68b9 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -599,13 +599,12 @@ void mesh_fast_tx_cache(struct ieee80211_sub_if_data *sdata,
 
 void mesh_fast_tx_gc(struct ieee80211_sub_if_data *sdata)
 {
 	unsigned long timeout = msecs_to_jiffies(MESH_FAST_TX_CACHE_TIMEOUT);
-	struct mesh_tx_cache *cache;
+	struct mesh_tx_cache *cache = &sdata->u.mesh.tx_cache;
 	struct ieee80211_mesh_fast_tx *entry;
 	struct hlist_node *n;
 
-	cache = &sdata->u.mesh.tx_cache;
 	if (atomic_read(&cache->rht.nelems) < MESH_FAST_TX_CACHE_THRESHOLD_SIZE)
 		return;
 
 	spin_lock_bh(&cache->walk_lock);
@@ -621,9 +620,8 @@ void mesh_fast_tx_flush_mpath(struct mesh_path *mpath)
 	struct mesh_tx_cache *cache = &sdata->u.mesh.tx_cache;
 	struct ieee80211_mesh_fast_tx *entry;
 	struct hlist_node *n;
 
-	cache = &sdata->u.mesh.tx_cache;
 	spin_lock_bh(&cache->walk_lock);
 	hlist_for_each_entry_safe(entry, n, &cache->walk_head, walk_list)
 		if (entry->mpath == mpath)
 			mesh_fast_tx_entry_free(cache, entry);
@@ -636,9 +634,8 @@ void mesh_fast_tx_flush_sta(struct ieee80211_sub_if_data *sdata,
 	struct mesh_tx_cache *cache = &sdata->u.mesh.tx_cache;
 	struct ieee80211_mesh_fast_tx *entry;
 	struct hlist_node *n;
 
-	cache = &sdata->u.mesh.tx_cache;
 	spin_lock_bh(&cache->walk_lock);
 	hlist_for_each_entry_safe(entry, n, &cache->walk_head, walk_list)
 		if (rcu_access_pointer(entry->mpath->next_hop) == sta)
 			mesh_fast_tx_entry_free(cache, entry);
@@ -650,9 +647,8 @@ void mesh_fast_tx_flush_addr(struct ieee80211_sub_if_data *sdata,
 {
 	struct mesh_tx_cache *cache = &sdata->u.mesh.tx_cache;
 	struct ieee80211_mesh_fast_tx *entry;
 
-	cache = &sdata->u.mesh.tx_cache;
 	spin_lock_bh(&cache->walk_lock);
 	entry = rhashtable_lookup_fast(&cache->rht, addr, fast_tx_rht_params);
 	if (entry)
 		mesh_fast_tx_entry_free(cache, entry);
-- 
2.43.0


