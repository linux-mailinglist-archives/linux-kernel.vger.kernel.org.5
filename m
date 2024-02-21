Return-Path: <linux-kernel+bounces-74379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 456F485D33C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA157B23F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93553D0A8;
	Wed, 21 Feb 2024 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bwpzQIri"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019923D38E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507084; cv=none; b=HnFM9hSaHvVoiodrUjUYscmyXPLS5q7X+DjAc+p+rhxJaIBE3sP4+GK2P6UcwpKnHpBQKOOdrzUz9QhlqwUrEZNLGErYAJdcjt2PlHPe21ydk5y9DE52iNMQtOJ0zohplofyA4AnxyLISbFfVv7G7k7b7quzo0bwJlv4er8PPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507084; c=relaxed/simple;
	bh=wAQj5nvfCIOH1JW9X4ndLX9htm/n/DPR7gaftd4bR28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JF7Rqi2cu5JYpY+dUoLfL5bcLPxjDP0CR793BwNUybOAqQoY/uc9PECXBeguepTiEQXHKrIbmqm+0UDFWHz17rirNrwDQ6BnbU92odICzDlXrnV7FNgNUnYz4yHTKepLiY76bhk10/aCLEttKt8Og7LqRBOF7HO1L6UXkn3IyGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bwpzQIri; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708507072; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vb2IT9WftsLMsivtOiIkK93g1bjf2OnNq4gtLguxxug=;
	b=bwpzQIrihbiGrIlF+xLcpm7X9capHY+FkTxLDtyGiUvm2O/nUtj448zqMZxZhCogvOwEGSDbHmkrk1Uv+dJ6umxxN1wOJiZj8/p1XEZo/YqmKbfVZ2n7SLEUswEDo19QEw+TzMlQg/EaMq5xvXzKmYpxQs0YudrTj01pAYdcYVU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W0zR752_1708507069;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W0zR752_1708507069)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 17:17:52 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: msakai@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 7/8] dm vdo dedupe: Modify mismatched function name
Date: Wed, 21 Feb 2024 17:17:25 +0800
Message-Id: <20240221091731.7007-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240221091731.7007-1-jiapeng.chong@linux.alibaba.com>
References: <20240221091731.7007-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

drivers/md/dm-vdo/dedupe.c:2792: warning: expecting prototype for vdo_dump_hash_zone(). Prototype was for dump_hash_zone() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8279
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/md/dm-vdo/dedupe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-vdo/dedupe.c b/drivers/md/dm-vdo/dedupe.c
index a9b189395592..a2535e909a80 100644
--- a/drivers/md/dm-vdo/dedupe.c
+++ b/drivers/md/dm-vdo/dedupe.c
@@ -2785,7 +2785,7 @@ static const char *index_state_to_string(struct hash_zones *zones,
 }
 
 /**
- * vdo_dump_hash_zone() - Dump information about a hash zone to the log for debugging.
+ * dump_hash_zone() - Dump information about a hash zone to the log for debugging.
  * @zone: The zone to dump.
  */
 static void dump_hash_zone(const struct hash_zone *zone)
-- 
2.20.1.7.g153144c


