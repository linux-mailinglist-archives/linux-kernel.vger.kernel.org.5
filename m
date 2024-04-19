Return-Path: <linux-kernel+bounces-151208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06C58AAB1F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09E81C20D00
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B6674BEC;
	Fri, 19 Apr 2024 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Idho3yEw"
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA863E;
	Fri, 19 Apr 2024 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713517403; cv=none; b=m+O8DngoRKxxttusUntahmNIzpTC11cA/fhj8nu0pVGvmbJgyNgQ7o7f5e5+HUbIhTM+CfBcdD70qsbnVLt+rfbZFe5adVy5tcluw2dsfDLgGyn4myx2Orc2DvDJJ7GmxUtDQTfeVgorRj3yQq4JSjW58VXFssei94GdPPJK/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713517403; c=relaxed/simple;
	bh=r7Ueo3QrwRq1LyGSoZ1jq9O1XRvuYMvB/OSyodQmiP8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NKb3nljCV7LrtxhtKk2ZB+VnG2afUPpsOz8lLd9zkw999v4hU8opjjMndHkJ4Ahyzlr7snjCjTnEuODnstrQVXQCgkd9o55puaay/1cPh5WZ/PeVJM1xOm1sIPGpOrBkssCpjED4KHZ2ZhK1rreNyXQmh5ICZKIMhzJe63HCtmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Idho3yEw; arc=none smtp.client-ip=47.90.199.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713517381; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZRVUqPqFKY9UkFb8maKJ04mKt/601F+KNCAqbJtq7Tw=;
	b=Idho3yEwv2yWHpGtXi7ieAmyDcy93X6Sfe8ub435dRU0auxYT1qeyKOfHlY0uUSfx4/HqsGRw9/OoZFNbIEw/dT5mPLM2EtLdg7xSvqJLMLafddlE0W58U6LRZ+VIyZg/PWGIfSSNYFpFND6fTG0qBb/mRyyBlaUEFgXFTjfB0A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W4rnyph_1713517380;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W4rnyph_1713517380)
          by smtp.aliyun-inc.com;
          Fri, 19 Apr 2024 17:03:01 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] dma: Add dev_id parameter description in request_dma_bycap
Date: Fri, 19 Apr 2024 17:02:59 +0800
Message-Id: <20240419090259.39542-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the missing description for the dev_id parameter in the
kernel documentation for the request_dma_bycap function.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/sh/drivers/dma/dma-api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index 89cd4a3b4cca..65005d348877 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -116,6 +116,7 @@ static int search_cap(const char **haystack, const char *needle)
  * request_dma_bycap - Allocate a DMA channel based on its capabilities
  * @dmac: List of DMA controllers to search
  * @caps: List of capabilities
+ * @dev_id: Unique identifier for the device that is requesting a DMA channel
  *
  * Search all channels of all DMA controllers to find a channel which
  * matches the requested capabilities. The result is the channel
-- 
2.20.1.7.g153144c


