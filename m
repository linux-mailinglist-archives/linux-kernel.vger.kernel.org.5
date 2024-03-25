Return-Path: <linux-kernel+bounces-116996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DC188A5EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058771C3B8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE02D3DABFE;
	Mon, 25 Mar 2024 12:28:20 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B51C36
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369700; cv=none; b=on7OPA2cCGvzUPuotqZ2yF/Yj974UmxoVq8HL9Quo08x48AFwkGU6a17flXJcNA/azu6grxIInsVT4b8xJkYd9oRi8sIiFAy3l4a+yixIZqKfcM5iNh0n9B00JGNjQbylN0iVMV3UGVke+zeoY0ANoJMZLIXahb7zBR5dPuUNwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369700; c=relaxed/simple;
	bh=pVQ4C4YTtp5rFp83Ly0FdisDcQMQ7N/FhVjm3Tit5BM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BoHdPIIc9aqDhHhyerGS++0L6GCwvEZ0NIfAfJDmfxoz3pjU5tFx69cjACFpm90z+ox1CAFpkJ5jnVHiKmGzscbC8XxpOo+9M269Hi+d9qov+X0EpOB3WUxTuKARPLUp3Kdp2A8BX2FaO42bLlLph6QhGz6zdOz7kcUSgoX4uHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V3BzT12sGz4f3jq6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:28:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2669B1A0B61
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:28:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RHXbQFmlg4nIA--.47806S4;
	Mon, 25 Mar 2024 20:28:08 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xiujianfeng@huawei.com
Subject: [PATCH -next] mm/slub: correct comment in do_slab_free()
Date: Mon, 25 Mar 2024 12:22:17 +0000
Message-Id: <20240325122217.273978-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RHXbQFmlg4nIA--.47806S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZF43GrWDtw1fZFyUCF43trb_yoWxCFX_C3
	W8XFWxZw18AFn7KrZ8AFs7XrnIkw4kWryYkF4fC345Jw17trWkJws7Wr1fArW8ZrW7t3s8
	CanF9rZI9rsF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

slab_alloc_node() should be __slab_alloc_node().

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7b68a3451eb9..33ac769a69b9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4446,7 +4446,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	c = raw_cpu_ptr(s->cpu_slab);
 	tid = READ_ONCE(c->tid);
 
-	/* Same with comment on barrier() in slab_alloc_node() */
+	/* Same with comment on barrier() in __slab_alloc_node() */
 	barrier();
 
 	if (unlikely(slab != c->slab)) {
-- 
2.34.1


