Return-Path: <linux-kernel+bounces-11461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D202A81E6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE8F1C21E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A24B53E17;
	Tue, 26 Dec 2023 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uHPnSNt7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E47A539E2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703583863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmRdlIlTFvsGqdkNb3BKpWuB8bJE73vQSHmgBrz+694=;
	b=uHPnSNt7jI7Wkji8vG7Fm5kd70eP4RgIvmULyn+cjC0V3T2nOZtkzpmB8gOLI1x8pnfv08
	b9CvhHgnSM9rszSMhXohQjzM+q/JySMwzCLkKul0mN+SHJZAavuxQ2NgOJ6y0/laMoLFwx
	qhAK6NO+pz4QsYitaO9ltx7rkLoSV+s=
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
Subject: [PATCH 12/14] netfilter: cleanup struct nft_object
Date: Tue, 26 Dec 2023 17:42:53 +0800
Message-Id: <20231226094255.77911-12-dongtai.guo@linux.dev>
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

Add comments for udlen, udata in struct nft_object.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/net/netfilter/nf_tables.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 526332bde1b4..dab1727f3487 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1301,11 +1301,13 @@ struct nft_object_hash_key {
  *	struct nft_object - nf_tables stateful object
  *
  *	@list: table stateful object list node
- *	@key:  keys that identify this object
  *	@rhlhead: nft_objname_ht node
+ *	@key: keys that identify this object
  *	@genmask: generation mask
  *	@use: number of references to this stateful object
  *	@handle: unique object handle
+ *	@udlen: length of user data
+ *	@udata: user data
  *	@ops: object operations
  *	@data: object data, layout depends on type
  */
-- 
2.39.2


