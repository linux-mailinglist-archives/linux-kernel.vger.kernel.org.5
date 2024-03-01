Return-Path: <linux-kernel+bounces-88141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E1086DDD1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52DF91C2318F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5142B6A34F;
	Fri,  1 Mar 2024 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jBkSH9aa"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6B6A02F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283949; cv=none; b=npxqxn1hRmb61SIc/ivOxUfUw4i298z+NvzeuvRt2X14545FIRO7a6oYSfZG2PFTMoqtk9EI9Tg6j6bmTIS/GPOymLgJ6ydOVKdtMuDLWJmIVKz7I2A2kbd+I/fy0MzqWnrnXbKDneHtig3v6jZ7K0Trn/F24SiQq5Jr6UrC5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283949; c=relaxed/simple;
	bh=Vm6CiRWRPbLZbzLjXw0SAbyS5VeoUChXkooIq7LvyHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e7HbrrPO9IXRGqp4N2KDVlcDjENaERw3jV/tqyw4RLur2pT7gAu1Xd/k2Vq8m2h7bLlpOOBK6uoKQS484osTXIRXZAaoOpYjuLnpmKI0GZJFDBvEWI0ZmAwGxi98UuAQ8wBQ6jullT+yi9M9kURUQUUxVTsBlQmeOy+CvK6Wwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jBkSH9aa; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709283939; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nBALHPo6UgPPUyrD3FvDp+iwsXKQboxe3VkcEgjHgOg=;
	b=jBkSH9aabv6Xmz7R/M6VNDizyZDWBvd+KNF29GqzpPooJKlc/JWM/dCINg2Uen++qy5XpT+4Vs/aKfZYcyyd1w9CMlakpfbbPFCVePpMQeZQ6jNoC4TfUcs40byZqdTwDwK4p4V/cpKsV06/ln4Gzs63AL19l5JHGHh+Gik+HKY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1azjs2_1709283938;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W1azjs2_1709283938)
          by smtp.aliyun-inc.com;
          Fri, 01 Mar 2024 17:05:38 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 2/2] drm/xe: Remove unneeded semicolon
Date: Fri,  1 Mar 2024 17:05:35 +0800
Message-Id: <20240301090535.87969-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240301090535.87969-1-yang.lee@linux.alibaba.com>
References: <20240301090535.87969-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes the unnecessary semicolons at the end of the
switch-case statements which cleans up the code and ensures consistency
with the rest of the kernel coding style.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/xe/xe_rtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_rtp.c b/drivers/gpu/drm/xe/xe_rtp.c
index fb44cc7521d8..316ed2f6d1f0 100644
--- a/drivers/gpu/drm/xe/xe_rtp.c
+++ b/drivers/gpu/drm/xe/xe_rtp.c
@@ -165,7 +165,7 @@ static void rtp_get_context(struct xe_rtp_process_ctx *ctx,
 		*gt = (*hwe)->gt;
 		*xe = gt_to_xe(*gt);
 		break;
-	};
+	}
 }
 
 /**
-- 
2.20.1.7.g153144c


