Return-Path: <linux-kernel+bounces-160967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080718B453B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1AF28331B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2356645BEA;
	Sat, 27 Apr 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="sPeMcUKV"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B933A3C062
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714207931; cv=none; b=BsoWYkAZZO3JUeMp8z+DX6PeBIjcqlZXBI2OWdScowSTYVmE96o145tZVYHuSrwutXMHZzNQgEWuM06DG32RNKm7sRxEwGCol0jmJjZtu6Lvf/Tv4pSlhfvOn4Ew4/GHC2kkigCecMrZAfBF7RUsKRg1rYRQ+8ZBi3k5NxBYC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714207931; c=relaxed/simple;
	bh=7AUy7Q3VmafyN7bcigCy6Cg8/qEU6ohYVzhx0Np1CBk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=MKVCNKA2yhBu7aez+05ykjtUXLB0E5QGJ7DvOLx9aEHD7IWkSjIMZvB1VyOCG6pxyAknLlp5X/pgSSBwZSHnXFrQ+M85MugT5CDcwmzi9Rz3vVN9k9q2PXV5JIrfA73WpszWk4G6PkPIE0hFqtXGa/PfumT8PnTmJCVMHlrGGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=sPeMcUKV; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714207924; bh=sHjG5dTObITpgnBpC3M6KzXKNedzHy80OgTnL62Ihkw=;
	h=From:To:Cc:Subject:Date;
	b=sPeMcUKVqHB4haoSmY3E0nT5AwEeCB93Pd8BU0qmjDgesBqZCu4grEplPMLemD5tb
	 0vuAUVMf8ZHmmqHATVkj3Kih8YHImVf3ls1cU2/MyuPSCzMLq0qE5P0LnEL/d5I8Uv
	 Tu6t/5x6PWC56dRZVfJhbvQqpwfINIOuVLXv4IhY=
Received: from localhost.localdomain ([58.213.8.145])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id D0101220; Sat, 27 Apr 2024 16:52:01 +0800
X-QQ-mid: xmsmtpt1714207921twha7fb4m
Message-ID: <tencent_579220610AF1240FE3735A3443DBB01F9D07@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTorIFbPMI2XNsr8ZOywSyWezSfQE1t1etn8KAMOZXaUAzyVQBaa
	 9yYeJiQPs2E3lCCKDYF3e/y3glKgqRFPETzrGQPiCog3jqd5K0clL0ESM/tUQGEH1+Xj/aLqsBK5
	 eu9q3y8egdqNTTo692J2q3RWzq9ghHMMySdQqJBaVmhrurOIa8HiqYwUtZ2jLVwudvlYUlAlJdJl
	 /kZfkDmVOWnYZKBhAbGEuDo3WUn4IB5LEeu39HUS8DJ0in+5Ha4VJufQbqJz9Id3I96/9shDPMcl
	 y/BbDHxANKRe5egZvas992gBHS9o6tzKMbBi2BS4iQDply0fUSGHmzrp6OKTfUnX3909tWs1oDzG
	 erGNdrOkk6n3gJhwGgYC7bq6cNc+wSH/Qch/iwXTtLlySjjfG+rQeEd+hWdCk3IIfK8MLwwqdQ9U
	 l5+NH3k1GNJOqbEB+kSF1TM86mnAuN84Nbs8c9fFKgQCkd9OcSARA0gl6WLr3fMHB6dw+zkxD4iv
	 XuSgjh9a+GAbiAT9d2rHDNizchjhVV6vJINRypm07rmDmL0KQGfVhfHBuGahByUgKKANyU25LzYW
	 4NKdSULI42DkNGiWf1/HvPFV0ygBlAw9BoGAHvA+p2kIRODFTw4Eer0Pfx0himNzQAi6RHMdenZq
	 HuJOwDxD0lYmBPCjudGJYf4J5jFrpMQk5okh5Tpl/i7QeMl4lqtoIZBgnnWrzcSZHTZFzjeWl9g4
	 W+U9kSx/erqOxJtez7shS6UFhB5gG9atlspWtooz+U121h6G/Ose5Yxikf5a92zB6kUH6ja8wB1C
	 XguEAyFS1DsgYSa3t/bDrKwPw5emRrxexIZDHdeDUnxoEeqozD8T08CmQS2HYFG7ICQs49IFRwk5
	 tUmIzVgnE3pVsh2FL9DJmECQ/YIdRo3kRAyrYR5QUetISc5hmRdIxUQ1wkWILq7Hdk5hpsDoiz2A
	 iFyRY6tbYafVR9lGNueabLZ21GjNcj1WQiH3n07WGmXidJchXR1g7tag9Erlms2inm7Egm/XsFIs
	 aA9bGwK5dgOAen5YAt0mH7lFy9OhY=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: linke li <lilinke99@qq.com>
To: 
Cc: xujianhao01@gmail.com,
	linke li <lilinke99@qq.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: mark racy access on slab->freelist
Date: Sat, 27 Apr 2024 16:51:54 +0800
X-OQ-MSGID: <20240427085154.33456-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In deactivate_slab(), slab->freelist can be changed concurrently. Mark
data race on slab->freelist as benign using READ_ONCE.

This patch is aimed at reducing the number of benign races reported by
KCSAN in order to focus future debugging effort on harmful races.

Signed-off-by: linke li <lilinke99@qq.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0d700f6ca547..bb0e05a321e9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2813,7 +2813,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 	struct slab new;
 	struct slab old;
 
-	if (slab->freelist) {
+	if (READ_ONCE(slab->freelist)) {
 		stat(s, DEACTIVATE_REMOTE_FREES);
 		tail = DEACTIVATE_TO_TAIL;
 	}
-- 
2.39.3 (Apple Git-146)


