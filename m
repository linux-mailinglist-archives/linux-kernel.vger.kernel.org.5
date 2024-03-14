Return-Path: <linux-kernel+bounces-103577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B00F87C156
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2BCB21C41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679767353F;
	Thu, 14 Mar 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX8Zf4od"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1195270CA8;
	Thu, 14 Mar 2024 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434115; cv=none; b=vGSBopvsGEsCWtPYh5xpkZwveC4SWccEAkLmxVReYYCgzxQRC8+8PPjQu2IROLBv/yoAJOkBpeU11cn95FoCfJvmJoHIpkwrSauWyQhClhDQQZQzyUouNV8XWhfltF5ioG+sqcmD+hLs1+16GZ7+7r3uSOg9Ei7keFKFfsncLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434115; c=relaxed/simple;
	bh=WD4pFfaN5EK2gR4oPGKEc40ZY4i6lXlbjdoFiH6yqdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uKnD5kmy1x7ic+6P7+CH9ph+5qa9pPVmCkedHMDyf1j3xQ+xT7JsghlAEyR74NT4k7glqI17a+VFx25t7XQhRXE82Wz4g/Vh9i/+dIqmC4bQAFzXgCpf59N/w4+TUtPFDkg4SK9BPDnKaw5KqaukG5bHMP/Jr1vKJrFm55hDydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX8Zf4od; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d38c9ca5bso653486f8f.2;
        Thu, 14 Mar 2024 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710434112; x=1711038912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3febcg30MUvzziLDV9p5DhB+HO5C8w1a7PC8hf/KTOA=;
        b=PX8Zf4odVGVb8SbryYl5liUFDm4h8siJ/9fwNrzw+b4viHfBwBsHywa72wpgC1ZQGv
         ff43JKfxEpCEckKW7iosVHVyem1wzKyWlEPcMmXgTKYfKFK8zrrFw3yxylSACaXFoJM4
         BGt3VyvFfL+mzMwGt/tEwRu61ojCV8c+sE7RF5qmMehJZo2O2IBiN04HuzRqYMWY1Wjw
         5mMcA8TkTHLFSwR3m8HfNa01YGGn0DNGco3YoHBu0xSyQHUjgmJpzYwrM0dBtMByTByp
         ovxqXLpCxdxuX6bsQ4gkmKUX0EuLPoyWdkn21hPqStz0Bhd8PJimnoB+Vud4IaPZiJQg
         RjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710434112; x=1711038912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3febcg30MUvzziLDV9p5DhB+HO5C8w1a7PC8hf/KTOA=;
        b=rUBj17wvIhNV9LW/OrlnwofEyoNr1DnxwPjL3RiWG9uNAv/aEhuzoOCxJ+wvD4o2zL
         dzYahlg4hcZ0Dg6wYdaSswd2U/8D98zu/Ia6ABGdDnGu1ydyfQ265idn/t0CxK2XnM6T
         TfmFHqDk5Prr7uCwWwq4miOYLr5XAwBzGkF3VW6scUZc8q70pS9LTrQC2YigSeaL66J0
         FOtRx4pRWJe/tdbbcN0Zx5xh7/vbCtv7lCrLLONGZtFNoQPPTzGybG2nkSZYQQd5luZO
         O4pGwUCxsCqea8e5wfyrFUmuiIlM/tY0MnuFCOCMNKY9bnHkcqtmPQIb0uznMw4inYXM
         HAMg==
X-Forwarded-Encrypted: i=1; AJvYcCXHRSYCFJobSTa8taetbQdtdPaHcuD7qnAEXxhpPNZBA00xmo87yArxWUHacMpn21s9Nm8Zre0Rb/JfVKdkyzue6XEO+Z7RVRF/XqKx
X-Gm-Message-State: AOJu0YzdrM7152flRUhYHyf4XRCATr9DCOcMYQI2zD+qsvftBklvOdMo
	+nLjfBAv8Y3uRTEmZU1iC0uNHtv3JTuwXdMHfPYmXQdhznayz1aY
X-Google-Smtp-Source: AGHT+IE7wio3dnoMGVtXz8wtABUS0fpDn3g6mBSI8Z6/SWNg9HZmBIqQ1Zp7CyQqZNKiMCi/VKBiZA==
X-Received: by 2002:a5d:5750:0:b0:33e:34aa:d78a with SMTP id q16-20020a5d5750000000b0033e34aad78amr1707480wrw.8.1710434112289;
        Thu, 14 Mar 2024 09:35:12 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q15-20020adff78f000000b0033e192a5852sm1126824wrp.30.2024.03.14.09.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 09:35:11 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/gma500: Fix spelling mistake "patter" -> "pattern"
Date: Thu, 14 Mar 2024 16:35:11 +0000
Message-Id: <20240314163511.2372458-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a DRM_DEBUG_KMS message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index dd1eb7e9877d..cc2ed9b3fd2d 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -1547,7 +1547,7 @@ cdv_intel_dp_start_link_train(struct gma_encoder *encoder)
 	}
 
 	if (!clock_recovery) {
-		DRM_DEBUG_KMS("failure in DP patter 1 training, train set %x\n", intel_dp->train_set[0]);
+		DRM_DEBUG_KMS("failure in DP pattern 1 training, train set %x\n", intel_dp->train_set[0]);
 	}
 
 	intel_dp->DP = DP;
-- 
2.39.2


