Return-Path: <linux-kernel+bounces-39478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B55283D1CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5C61F24E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FF764F;
	Fri, 26 Jan 2024 00:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aJzEIXpg"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7CB385
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230673; cv=none; b=b0ABXbTo9m2hSwXr2CsO0pow21f74f2EFzUVNlyJVVDPZwXmE4j1DJguRP65t7xor318vFsb1o5d1wSQcLfISArY2d5VASsQCnJJstT6/gl0+nPgfrTk9mZ8a/Oz7bF87sGcjXZIKkwZ8+hN4y7n9FQgVESbeV+9QJkxiEXOzs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230673; c=relaxed/simple;
	bh=kHudmBPINusm2w6k2rIG1aaCRzhkHkSauwC48cvfedk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4HVWmnp9v9kaGRRWK5iPyvViEkZobZAwD/AgYtPbuJskgkHLVHxQw8kI7vUEomB6IKYerwRDRO05cLMayEYF6Pfg/9rDt/Obw/Ir8qbix1X2y0GrW+qFvihxoT/Z6hHMtfaIBcuuj45alQVJrvGkkUnctCPkeDSF0lExgq6Fb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aJzEIXpg; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706230667; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6eOqHqoVnxkqq7rfHLN/88N72xWcS7f6JQdNTv4/SmU=;
	b=aJzEIXpgoaiIyqc3d06BoRPAZHEUI+WhIUfGcMSkpBO9awDLNUM5TGS3QaEnKoHTs018p0lJqclEQpcRnmLzJMCrQeYtpc+zaq0dBm1D0jmAi3fF67L5nlJjRaqrpzbY+ier/kfYZVn+jmmULN0QiCdrJSz7D0wgMP3BqGIcFE0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.Ld7Nn_1706230666;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W.Ld7Nn_1706230666)
          by smtp.aliyun-inc.com;
          Fri, 26 Jan 2024 08:57:47 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: bhe@redhat.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] crash: Remove duplicated include in vmcore_info.c
Date: Fri, 26 Jan 2024 08:57:44 +0800
Message-Id: <20240126005744.16561-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files kexec.h is included twice in vmcore_info.c,
so one inclusion can be removed.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/vmcore_info.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index 8f48c0a42e2e..8f77e238a54f 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.20.1.7.g153144c


