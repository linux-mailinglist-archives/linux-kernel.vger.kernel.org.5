Return-Path: <linux-kernel+bounces-96421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4F1875BE0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476001F227CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5836224EF;
	Fri,  8 Mar 2024 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxkS3Y3M"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD5523750
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860348; cv=none; b=tMP0Yrviw8J2Eos9X5jKTdSEuHBEJbDHR3ELcVJ9V4xHaODcDLNyOHm6rNOoNYU7xDjyViI7OkPtHjR8BYK4RqD+9mHCydzjBTBrt3eRgx2B6uGJIlD7BrOSjfW+NstntUWk6m0spxfscTagF0FVH9xAp6KAfOQWTHJUNjZ1NTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860348; c=relaxed/simple;
	bh=sA5YotOtX3AcvjjrYf5fHrYUORIzots7hTq07UQbKVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3Y4/lvJO+nluz5GD6eSoOHJ7ZNPQHZUIODAAgM9Ydl4z/YwDtECwDetYd2T4iXrjrJ7kPZ9J2v60z6MvS3MGHa18Jjgd7dsLH+L/f7VG4iPGMx8TNrDBCCXO9EleVOcpk5S0V0i7ozvUqAhBUVEn+krQiD0ik46oFa8+3V2mU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxkS3Y3M; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e742ca96bso404483f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 17:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860345; x=1710465145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Owx6jt72g5QT/V0uQHGstO9uCqzU46h0v31gh/DzxSw=;
        b=PxkS3Y3MU+Ds4ZgLtFQCLvB35mWreYDwDKbu+q1SeOQBVjewFykej39z3w8s/bkAZo
         /gZyqQwUanCxijE6clPgp3HYgkGerqqAMqPrhuoch1MhaamW9wvgBPFUGSaQpDOjhaDd
         vXCb4PD9+rrZz1Cb74sfpZ9o33HCeArsIvCEhkuIUY1Si6XTi0vrzQn+9JtMkbN/3FNu
         KgQLptuh6GVKbRhB/Xsme2HjFIcXJPgwGRgjPoJjocCA1gC7YyvWsyDOMcz/FXpTDmeg
         S2brMlNBSdRWHzjB/m3rqZwrlRMPeeNkcbVNcZF5SbAV4MBRgO6RAiOQefwebiXnwzft
         WFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860345; x=1710465145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Owx6jt72g5QT/V0uQHGstO9uCqzU46h0v31gh/DzxSw=;
        b=GvuS+6GJ8hzZDUGN6+6g6rCYdffi+h0AbdhNoMFUAelXew6JO6v5hkSPoJVp3fivyI
         1oeC0h4bLGH898Oz5fdFFN6tKY2g2W84VgvOTNwPJjNNAtpsAcizYVlvgPqRSwn3aUr8
         f9XGnLkIcgNz7sxmZCNJrG0Z4Q5o6EdDSFHOJNqwPR9zwoWjs3ZU7AvVQJgKs2TdfBFB
         QcUakDJQFDWYf6Tal4GTlXd2UPO3aVjsIFHUXd/1jWZfixJALvgNFFU8fbi4m5L3b6KA
         zVFsdpvXqjCNTY6qq1PCY+TTM1302Dw72vM84iFmTNmsvjJLPCmbIL3qN4lCI6faGGc9
         3IMw==
X-Forwarded-Encrypted: i=1; AJvYcCV/CqdC2PqdPS1DPojXrwAmtPvcFyEi+wZD/+YqKBCPe4EKf+F73VO4AqgnvkxtWgxF4O2fHh38fX1y7f7T27Hl41I1sHMdmAnnWzh+
X-Gm-Message-State: AOJu0YxEIkVrkshix4mk6wA7XW8/MvyLwLpYC2bbNq4iQCFqzwNK+935
	U2R2fVxPx26vGxh7aQkUTIAE5q5blJNum4SaNVpuBb9iQuaoq09L
X-Google-Smtp-Source: AGHT+IGyFK85fLcK62sC298qj//c9CgMsC5e3P8Va0z/mRDqMFtCe0XGX8iOSmZnzWnJeMlfMP112A==
X-Received: by 2002:a5d:554d:0:b0:33e:6760:6def with SMTP id g13-20020a5d554d000000b0033e67606defmr2195331wrw.56.1709860344707;
        Thu, 07 Mar 2024 17:12:24 -0800 (PST)
Received: from localhost (ec2-18-169-47-158.eu-west-2.compute.amazonaws.com. [18.169.47.158])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d50ce000000b0033b66c2d61esm21450770wrt.48.2024.03.07.17.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 17:12:24 -0800 (PST)
From: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
To: regressions@leemhuis.info
Cc: 1054514@bugs.debian.org,
	airlied@redhat.com,
	carnil@debian.org,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	kraxel@redhat.com,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	timo.lindfors@iki.fi,
	tzimmermann@suse.de,
	virtualization@lists.linux-foundation.org,
	Alex Constantino <dreaming.about.electric.sheep@gmail.com>
Subject: [PATCH 1/1] drm/qxl: fixes qxl_fence_wait
Date: Fri,  8 Mar 2024 01:08:51 +0000
Message-Id: <20240308010851.17104-2-dreaming.about.electric.sheep@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308010851.17104-1-dreaming.about.electric.sheep@gmail.com>
References: <fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info>
 <20240308010851.17104-1-dreaming.about.electric.sheep@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix OOM scenario by doing multiple notifications to the OOM handler through
a busy wait logic.
Changes from commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") would
result in a '[TTM] Buffer eviction failed' exception whenever it reached a
timeout.

Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
Link: https://lore.kernel.org/regressions/fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info
Reported-by: Timo Lindfors <timo.lindfors@iki.fi>
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054514
Signed-off-by: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_release.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 368d26da0d6a..51c22e7f9647 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -20,8 +20,6 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <linux/delay.h>
-
 #include <trace/events/dma_fence.h>
 
 #include "qxl_drv.h"
@@ -59,14 +57,24 @@ static long qxl_fence_wait(struct dma_fence *fence, bool intr,
 {
 	struct qxl_device *qdev;
 	unsigned long cur, end = jiffies + timeout;
+	signed long iterations = 1;
+	signed long timeout_fraction = timeout;
 
 	qdev = container_of(fence->lock, struct qxl_device, release_lock);
 
-	if (!wait_event_timeout(qdev->release_event,
+	// using HZ as a factor since it is used in ttm_bo_wait_ctx too
+	if (timeout_fraction > HZ) {
+		iterations = timeout_fraction / HZ;
+		timeout_fraction = HZ;
+	}
+	for (int i = 0; i < iterations; i++) {
+		if (wait_event_timeout(
+				qdev->release_event,
 				(dma_fence_is_signaled(fence) ||
-				 (qxl_io_notify_oom(qdev), 0)),
-				timeout))
-		return 0;
+					(qxl_io_notify_oom(qdev), 0)),
+				timeout_fraction))
+			break;
+	}
 
 	cur = jiffies;
 	if (time_after(cur, end))
-- 
2.39.2


