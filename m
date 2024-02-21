Return-Path: <linux-kernel+bounces-74689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A29E85D7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6770284084
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB21E51C5E;
	Wed, 21 Feb 2024 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mteirsb+"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717194F894
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517598; cv=none; b=lq8zwqOZpQ86AcsCtRAS/AaBH3aOiNy2+4gNONNJzvUDUMiv1IQHtFtknKKfCsvcqc1mpTu6IOdAEMoICic4askzwPcxBflOvgrhfwkUh3en7/b18hKqomRmWTcbePE3F4iWIQscSvNpjSOSh7U0AfPlkEH7YCn1eEMZjPkEbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517598; c=relaxed/simple;
	bh=ofDIzQwuszXOaZHAYe8/D7AxU3OQRgHCtFquTvgqqfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoXgD/LJ4+bbM5MUYwhkYhcF6QcDbKNIj66rd+PbssmNiS0quTH9FRSPZvo3XPBnX4xQKNqy6GvxA/OHJuKAJhlAZAgm2rOGeLH+hh19snJVk1fdSsPllUzfEGagcSTGaol+jtiBWNgIUILLJzp+yekSQ4xNCJNeBjCjstSk268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mteirsb+; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708517594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhS11vlbSRPVjtePx2vj2SfRKzyV/eHJgrhw6EiukQI=;
	b=mteirsb+AwFzqqexC55Jbjfm6efaZXq7mGfkk8IMH14fHRl1HuaJkF4MVDThAb1urEtC/4
	BTrNOQrySCuH5Xei2D2GZSWyUWkUztG/0JdZBft/y7yHadlE6Vxw9e7zYsisbcduj/GOix
	ObbyANIoXE4b16ue/uDg/afpdLYdq6k=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Wed, 21 Feb 2024 12:12:54 +0000
Subject: [PATCH 2/2] mm, slab: fix the comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240221-slab-cleanup-v1-2-63382f41d699@linux.dev>
References: <20240221-slab-cleanup-v1-0-63382f41d699@linux.dev>
In-Reply-To: <20240221-slab-cleanup-v1-0-63382f41d699@linux.dev>
To: Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708517585; l=780;
 i=chengming.zhou@linux.dev; s=20240220; h=from:subject:message-id;
 bh=ofDIzQwuszXOaZHAYe8/D7AxU3OQRgHCtFquTvgqqfY=;
 b=9SVMJ2TH7SmFMqZ6TgcaMs/Z/nVtEURX7uP3QgENgkurJ8/77EOzV8658D0efom6qkPkGuVqp
 kp/Iejh0mjvAiWCJXNazK9Uny3roCoOMjFtYej0VrI0+uCtwsertYQi
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=5+68Wfci+T30FoQos5RH+hfToF6SlC+S9LMPSPBFWuw=
X-Migadu-Flow: FLOW_OUT

The partial slabs on cpu partial list are not frozen after the commit
8cd3fa428b56 ("slub: Delay freezing of partial slabs") merged. So fix
the comment.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 95700f2b17ae..d5ca58e65053 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -391,7 +391,7 @@ struct kmem_cache_cpu {
 	};
 	struct slab *slab;	/* The slab from which we are allocating */
 #ifdef CONFIG_SLUB_CPU_PARTIAL
-	struct slab *partial;	/* Partially allocated frozen slabs */
+	struct slab *partial;	/* Partially allocated slabs */
 #endif
 	local_lock_t lock;	/* Protects the fields above */
 #ifdef CONFIG_SLUB_STATS

-- 
b4 0.10.1

