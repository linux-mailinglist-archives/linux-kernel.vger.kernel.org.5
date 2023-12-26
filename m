Return-Path: <linux-kernel+bounces-11463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A85081E6B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5541F21C25
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871A954760;
	Tue, 26 Dec 2023 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jcZJD8fA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887D5467D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703583872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLqrcEqlQDuXOmtMoD41DhPaHHKeGyUrjqKv3FgY7JM=;
	b=jcZJD8fASaNXDquW+AXlv17kgtzk/MAMMST3c01jyYwDTPW8vbVbKmgeGdMg27PVJRqwtP
	3L7K7OkWooSRnOOQRZmfjzSLtgoP171Jz4oAVdj8a3cMfSZiybw7tSmIvhlEnaCGvLRogf
	BEvSqJzM3OTW/loYXqjAca5eRT7TysE=
From: George Guo <dongtai.guo@linux.dev>
To: horms@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 14/14] netfilter: cleanup struct nft_flowtable
Date: Tue, 26 Dec 2023 17:42:55 +0800
Message-Id: <20231226094255.77911-14-dongtai.guo@linux.dev>
In-Reply-To: <20231226094255.77911-1-dongtai.guo@linux.dev>
References: <20231226094255.77911-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Add comment for hook_list in struct nft_flowtable, and remove comments
for dev_name and ops which are not members of struct nft_flowtable.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/net/netfilter/nf_tables.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 505128d10073..a880e9439cc2 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1409,9 +1409,8 @@ void nft_unregister_obj(struct nft_object_type *obj_type);
  *	@genmask: generation mask
  *	@use: number of references to this flow table
  * 	@handle: unique object handle
- *	@dev_name: array of device names
+ *	@hook_list: hook list for hooks per net_device in flowtables
  *	@data: rhashtable and garbage collector
- * 	@ops: array of hooks
  */
 struct nft_flowtable {
 	struct list_head		list;
-- 
2.39.2


