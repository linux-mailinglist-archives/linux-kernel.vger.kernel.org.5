Return-Path: <linux-kernel+bounces-59583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E684F955
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D701C24252
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEB276C65;
	Fri,  9 Feb 2024 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfLrjp5c"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F035692FC;
	Fri,  9 Feb 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494914; cv=none; b=qMDMi5reg8l+Q0x9L3ZK8G0m6Ilt4iGv33WHFdpx4WX51f2gnjVZB9ClFMUBo2hLrvgjIMUu0DRCHaRa+3K+SdSZL3f9XZc1q5sBrm/C/AYt9MICjvzIsX8oJb2joQ8Zncr21lFS8otS0Dc5Nc0WGKdz/eru8/AiJ2buglBK29Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494914; c=relaxed/simple;
	bh=BEU0ExyfWEtee2dblkJlvw/b0nn0Z5QfUq49sGosjHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=t2vB+sh6AqhQZpSzeE5H8kvqCCm3G79GAV52rg8LqK5kthK+Li8Ez5B0W3uv1c3uku+DhFQjAkG2DDJNc9el1k02Pz8SCW6stO5kaohFOWd5R5fD97YZouaBFgCfz1G+wI/rgInp1XwBDSqvhFmvB5xPfF+u9EWVFXBqsKxaleY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfLrjp5c; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so13092185e9.0;
        Fri, 09 Feb 2024 08:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707494910; x=1708099710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TzLKSpIbztwzPT6C+IS9b5enm2u51uagMPSnubcJ8hg=;
        b=KfLrjp5cw0YDbqJk5hH6/QH7cyNtVBw58lSAJJjGD8WMKWfXoaCjQ7j05EcyNpZWG6
         qiYGp5jHldBsZq0oT5Yuk36BMAECNDzYmlG3xrfgEOTeOiu3Dhyn2b9zhndEzVybHipM
         g8+hqO83W6nLj5w0c0R21/YT2GmjmgKgGSSUnnniFx4u9LtKy0uOMSfO9y2YrEwVmKsp
         34Yl1KUFGUP+X8ex46QOeW/Nu3ymS3HC2Misbs8LKI+HuiMoUZGRq4IVYp5QMMqBDJVy
         dwzoha13b5D5K1XBfhR4C8PBC38dJwG39gGPgqHzkjGQbgCTvX/DFG7MDFHo65oMFNcm
         FemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707494910; x=1708099710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzLKSpIbztwzPT6C+IS9b5enm2u51uagMPSnubcJ8hg=;
        b=Gx3D4s001cCJDNBz0MvTLhpHU7PmPocbg8PLjoHXleW6+T/viPbK49rseXSrH5X+IM
         zUfsLsuVyo4UscbItvDOgk6OTqpVX2E7UqUo/P99dJ5OqtOFU9+ddUgktcvDbt910oOA
         bMuSySbRc0/ZMB+3TmeFnXjh5fhuo+dpo3u24y5ezNNB+1fTeU07xahO+NNo2CSzwEiZ
         L3buymaEJtbFou43WxFfqvnC/sgQGzA7TKo1OxW2HngEi6Cb1xlpoZTu+nlvmNEwHKe1
         PTcUOaiIeBMuiW6vIhSHUicdwW/dUG8iwVLyJ3D7uHOON+844rqgVmWFiSs8NxsT3eME
         UxGg==
X-Forwarded-Encrypted: i=1; AJvYcCV0YN9q4OLC4KdGtSiuaD6iZ7/K/1EQ7ArTpjgvzrpgBqofm1ycAUSSEByOhY/w7zD03ObrE1UV5hZ2Mhe7/wIdGdxuM12VgxzZIutW
X-Gm-Message-State: AOJu0Yz0JoUlwTWFOt+FI+jwWNtAqOt2HWdFoILSLMPxNQirE7MOM+Gp
	kxKxHv7h7vJD+kyWStYc7bZn1p621AprJ898LmkuZDCBxP75h7VbJzY+7DcLD4Y=
X-Google-Smtp-Source: AGHT+IGG4FUlez14b7GsJi67PNeZ+8sCc1WWZLXozkMxO09v6l31xu/rN0T+bT/YmhzLPY8b6U5upA==
X-Received: by 2002:a05:600c:1551:b0:410:8782:cf7b with SMTP id f17-20020a05600c155100b004108782cf7bmr49204wmg.20.1707494910424;
        Fri, 09 Feb 2024 08:08:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVC2z7Iy56PqWUKiYFwZYuHACZNPyFNI1Bh1wkW+1/C/J2VPGzeszoYxrJtoEFiPtlYewdKOl7pOPY/mikYD9y5huVYlBzwgEWfljjhovrCN0O3JhAzKdfP7TyoAxkND+nzoWivMJLaHrbLbgl5TkDP4FqKbB1YMzI6k0j21dpqOzt7b4K6jABPVM+JrJ9TIgWfcEF/nVxPa8p704bXXhA0qHu6mGT4HIwVK6Jqu60yZsNSDYA8xLMsr96IAZRYgcF6RPFI3C9GXW3gFV9nMhI3jW19m6MM6uAAdZ+V3KTUhmuPx7UE5rzF/i3Efvg9l/yNsTjc9+zT+pakLtc6E6L1afh6AXKcQEoxv3hbb58FEIXC3Sl0p3vEmwVqI+uDVMOEqteaBdq3alng5ziOtfQkcZ/scLzVAJU3hXNG/iCzMVyg1t66V5wq/Sg8y1yVOZSqUsGWsU1P5gROsp6Xshk3QSVDIQHRxOdiM1JYjPs=
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d674b000000b0033b583ba5e0sm2124312wrw.92.2024.02.09.08.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:08:29 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/gvt: remove redundant assignment to pointer map
Date: Fri,  9 Feb 2024 16:08:29 +0000
Message-Id: <20240209160829.3930396-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The pointer map is being initialized with a value that is never
read, it is being re-assigned later on in a for-loop. The
initialization is redundant and can be removed.

Cleans up clang scan build warning:
drivers/gpu/drm/i915/gvt/interrupt.c:346:28: warning: Value stored to
'map' during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/gvt/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/interrupt.c b/drivers/gpu/drm/i915/gvt/interrupt.c
index c8e7dfc9f791..8c8e37f50a45 100644
--- a/drivers/gpu/drm/i915/gvt/interrupt.c
+++ b/drivers/gpu/drm/i915/gvt/interrupt.c
@@ -343,7 +343,7 @@ static void update_upstream_irq(struct intel_vgpu *vgpu,
 {
 	struct drm_i915_private *i915 = vgpu->gvt->gt->i915;
 	struct intel_gvt_irq *irq = &vgpu->gvt->irq;
-	struct intel_gvt_irq_map *map = irq->irq_map;
+	struct intel_gvt_irq_map *map;
 	struct intel_gvt_irq_info *up_irq_info = NULL;
 	u32 set_bits = 0;
 	u32 clear_bits = 0;
-- 
2.39.2


