Return-Path: <linux-kernel+bounces-128751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD10A895EF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9451F255BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B2A15E801;
	Tue,  2 Apr 2024 21:54:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C69E79DD4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094877; cv=none; b=ML0xFuerAXZnMmUr0jO8HPPdZIN58p0OCaoDS6sG2cIBacmpcO/LtgCwD2Y7nsrNjLcIgnC0KRgV6Oue06PmC7XvQ+d36aMRcr62xX8u2MozsHxr+ZLtk6v1KnayfUwiPx5vCDdFRozncuPmfao1kfqbviSuRZHTDiK1gkNBi9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094877; c=relaxed/simple;
	bh=pfXumYy099kiErELMn9mqWqeDvXeUZ/t+84EEBKXLQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNJUmZAaN6dU/5a9sBccuyAbvxPiUooBmW5hdFowLR5slXywGBznKQok+5AI46kJRW/A9i9YG0AjZAtJzQ0Q/vRxelpvCf08QnVT8Bf/ReuLZQXW2WB3RHa6h7L72/BtV4fzKtVRpqGqE99W+M/tRwi73fIvR4pnCHeFA3hWT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4907B1007;
	Tue,  2 Apr 2024 14:55:05 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08AA93F7B4;
	Tue,  2 Apr 2024 14:54:32 -0700 (PDT)
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Steven Price <steven.price@arm.com>
Subject: [PATCH 1/2] drm/panthor: Cleanup unused variable 'cookie'
Date: Tue,  2 Apr 2024 22:54:22 +0100
Message-ID: <20240402215423.360341-1-liviu.dudau@arm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 962f88b9c916 ("drm/panthor: Drop the dev_enter/exit() sections in
_irq_suspend/resume()") removed the code that used the 'cookie' variable
but left the declaration in place. Remove it.

Fixes: 962f88b9c916 ("drm/panthor: Drop the dev_enter/exit() sections in _irq_suspend/resume()")
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index dc3e9c666b5bd4..2fdd671b38fd9b 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -323,8 +323,6 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
 												\
 static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)			\
 {												\
-	int cookie;										\
-												\
 	pirq->mask = 0;										\
 	gpu_write(pirq->ptdev, __reg_prefix ## _INT_MASK, 0);					\
 	synchronize_irq(pirq->irq);								\
@@ -333,8 +331,6 @@ static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)
 												\
 static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq, u32 mask)	\
 {												\
-	int cookie;										\
-												\
 	atomic_set(&pirq->suspended, false);							\
 	pirq->mask = mask;									\
 	gpu_write(pirq->ptdev, __reg_prefix ## _INT_CLEAR, mask);				\
-- 
2.44.0


