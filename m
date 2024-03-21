Return-Path: <linux-kernel+bounces-109636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8FE881BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462CB284D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C7BA22;
	Thu, 21 Mar 2024 03:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="d84fziIw"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E84B657
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710993218; cv=none; b=YE1SW33S90MKElYciBdScQ9u5fjpcXCZBs6e/foVuTDTSzD/sVsqf6vFlJzVhDuI9H4R6R/i9qxZ0m4UJDw+j75FIpI20KnXbvFtEc2eg5jZkzN2ntw1KfNsYpovM00+2WGrQkjxnboD5uKZSKjG1Z7nQ7Rgal5cVfE0ZQevDBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710993218; c=relaxed/simple;
	bh=V6V18kwypKyFM10FE3AI9buU1umGXBFSwUci4SxL9eg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=G+JJqZEqAM5U+BbCAF06Wjxl5okLL1Tyfs5w1qpMZEJ3NdcZEomoWzwcMfT2ooLK0Fid0P0jHYh4igM6O5s1Z4hdNwUdJRfa61Mw9WiaHKzNAbF1vZ/Nr49PV6ZEivr3PLvrNlq3LEOfxBuiNmHlb+Uy0dcH28gAGk3t7h4NJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=d84fziIw; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710992911; bh=eqU7rPSQYUeIM0ABNvJ9ggZ+OdedolOfDpmn7pWZN2E=;
	h=From:To:Cc:Subject:Date;
	b=d84fziIwKJAa/sVpfwXYSiFjJ3Fcy6Sla2gFq5diH4bDeWE/dvnPhMDdFrhWrMK9l
	 wcg7d6Ib4/phkzYzu4czI5+C98XwKQQFpuIqHV8rJ0X+PPUPXjgF/mhBgRYNCJx5ec
	 eETHfEcxc9Ly60nJ3sgPb4r/QosCdAB0dXkigQ14=
Received: from localhost.localdomain ([153.3.156.52])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id C1BAB218; Thu, 21 Mar 2024 11:48:27 +0800
X-QQ-mid: xmsmtpt1710992907tiqej8r5a
Message-ID: <tencent_909E215498A54E4E100E456A92A7F13DAD06@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9k9L57IzZBIEuQ19ten/U7ZIVy1B8HQs0uj3/7fAVAjPtLc9Hkj
	 /IaSQdLtG93XPZav6SnP3I7PnFUOvsEBU/6GEav15+q820H83+FPpt8vyGC4OszjQW42AeqkbS/b
	 072h+zeWELtMkuMVCW3YFiPCyxAv3vYwmzA9nPHpc0G0kpvsRoTY9VH0mtHD+k4XWNQj3BWDonUl
	 5yXa6bBUGREUz2Ap9d9f1hHCIhr/X2PX/4TBkxjjlkOcyN0Cww3iRw+ULJBJPC1iz2IqD4Ai83w7
	 Ufvex4TLS8+R09ObvTA7W56264CrULwStXP0l/8PWEtC2A9Q8QEhuLO4wIUNNeeFg+h0hMUw1CpY
	 OCZM48xK0kS62LRcwywhcmPoRtIgrtj/T/Nk3hEGLjkYVuLPws2j3ktKwWUM9TLBd0ml19R2KWz6
	 G/fqGcSs2WM/3NLy+sXMh5BDNtpQgCxtJ0x5Ksc3LBPIYDKv3FNvf/bb5fGif5ORUtVRrSOAUClK
	 g4ljB8DVDm+X+qZz0L/tc+ZJIi2XlKkNGq9mtmjZpmsBHpOnEWKvmCG83WAaFsth+ySeYArmr0nN
	 axj+4UWUtxZrbXg0fwaAldTg23t6FnepZtMckYz1Ix0AKANp5nIDlbdktRAWA6c9qIhB7wAbh5UE
	 NknbLMgK5xBgJUHrh4a15P/OFR80XzNztC4CS4dtBPKTZ4A9P7IX8wjHrXa32uZ7QD2onE0wGcfz
	 lc4iTravxlw9DnuDJhhKdSPXgecTGoflfM/Ve6AvdZUAXVjloN9rjI+NnuDwBVEHC6x8A++KtgDe
	 n4YeC/yngEB9GozlBhHfAKEQ1w+1srOt7tOOmEDeiuzKz55ZdDhyNJoIeN+Dki6I7qzawNh+Ia5V
	 VmLMe+9ZOu4LbmcYUzky1yCtLKGBpBys2Zyp0THQwXf0hpbUWYFHrwIvsmjK4VQYZ0eKR3d7LF9K
	 oJQFpCwoekQUeMC9YKLDr9Zx8i7MUbG4Dty0siQfDSWicEc/yOZiqT4vTfaTZq7q/F/6oKovv00E
	 We40waFbdnIvZXq444
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: linke li <lilinke99@qq.com>
To: 
Cc: xujianhao01@gmail.com,
	linke li <lilinke99@qq.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
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
Subject: [PATCH v2] mm/slub: mark racy accesses on slab->slabs
Date: Thu, 21 Mar 2024 11:48:15 +0800
X-OQ-MSGID: <20240321034816.59019-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reads of slab->slabs are racy because it may be changed by
put_cpu_partial concurrently. In slabs_cpu_partial_show() and 
show_slab_objects(), slab->slabs is only used for showing information.

Data-racy reads from shared variables that are used only for diagnostic
purposes should typically use data_race(), since it is normally not a
problem if the values are off by a little.

This patch is aimed at reducing the number of benign races reported by
KCSAN in order to focus future debugging effort on harmful races.

Signed-off-by: linke li <lilinke99@qq.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..0d700f6ca547 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6052,7 +6052,7 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 				else if (flags & SO_OBJECTS)
 					WARN_ON_ONCE(1);
 				else
-					x = slab->slabs;
+					x = data_race(slab->slabs);
 				total += x;
 				nodes[node] += x;
 			}
@@ -6257,7 +6257,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
 
 		if (slab)
-			slabs += slab->slabs;
+			slabs += data_race(slab->slabs);
 	}
 #endif
 
@@ -6271,7 +6271,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 
 		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
 		if (slab) {
-			slabs = READ_ONCE(slab->slabs);
+			slabs = data_race(slab->slabs);
 			objects = (slabs * oo_objects(s->oo)) / 2;
 			len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
 					     cpu, objects, slabs);
-- 
2.39.3 (Apple Git-146)


