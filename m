Return-Path: <linux-kernel+bounces-144891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BF08A4C38
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D528B2386E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979558118;
	Mon, 15 Apr 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeq/Cioo"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262D4E1D0;
	Mon, 15 Apr 2024 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175670; cv=none; b=VJv6TipqAZQE4MAs5QroQYiv26z5s4E3fVtfP6DvJiVqMuunp54l3+6HRxnOjvh+xjqbHIJ+Cl0U/BNssc3AJw4oSQK8c1z8LhMLSKPCfUFt7YHSJazDdXqt1E42SqkdRaQZoXyCLd5VSj+vbKBYe8kM+A7x8w4I5zO0tCHJRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175670; c=relaxed/simple;
	bh=OUDm6TSBsNjr+Cb6y3SsnnfA3Q/GV80ZgRBDX4QKbJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0trCF4oOC8nrRQiZDUR3xIxZ/rFg3dOcrzhIA1DMV2wRYP56j/gMY7Cj6xBJoubffmZSy8iDmfKsq06YRjEAhjn2fUiJV45Kipx0O29Uf+84oeWls7Woivi/0TxDEjQcOMQfNkQS3gOwPCp2hmf4jbfw3jtLwSRPj9ok1VRLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeq/Cioo; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d3776334so3820073e87.1;
        Mon, 15 Apr 2024 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713175667; x=1713780467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7D2lBznLwyqilw5dfNMB9DZiuNs09gqrSFR58m/9kr0=;
        b=aeq/Cioox+/8MPy81neYWYK9F3osOmjiLpAiwo/uzt/ag9GgTYF2zWc6ZoP1uLloY6
         CSuHU3SBg3KeNI9eWcQnJY739EURzxglzxuZZL0SWh4eD/8OoAblf3uk3REjw9X6UA7d
         nZGn7yU6XoylbZw9GKZNZ5tj8V/EKEwoTt7E2dZt0HlBwLYRQBKyUvVchg/uCkzs3waq
         dJG9P6TrO0FrBWB8JIS4SCLEwPpkom/CsiIoVsMsyY8YHjpNUOA0PA0RhZFIeeqvyFgy
         nNMwCKHcAk64s8DORMZIPqGLq1+q9T+n6c+qLNUAL1tHcGLYnGk+ctjk233YPKs221fg
         Sx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713175667; x=1713780467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7D2lBznLwyqilw5dfNMB9DZiuNs09gqrSFR58m/9kr0=;
        b=gYgdG/H8ggcmPoa7KMAq9Q6MmZpAfa/mWxwspWnLJXBLu83efzlZsLglAuKtZwZkyB
         QD2NyDHAyxDBdRkNwe8WG0Ag/2+uQjWBqFS3r5jzUcmpDkfZPrkdAVLpOImouxf7g33D
         Xc7gRhGyFXAxSQIcmNLYJw79RHv7kjKhrZoTHEMp4tYUzNOCVHVfT/QLSOAZhfDqr+SV
         CG49M1twj6CS8SP/XifAIlEiazHfwUKRJWEx8BAzPAzJxwHmH4JqK/ilSNnCCWLbf5k/
         /u+GX7kiK6G2KxHSzs4zdgfSPnUgolrdKrpySEiW/Y44QF0Xa07oypJ6brvdUDiOHCek
         XREw==
X-Forwarded-Encrypted: i=1; AJvYcCV3q5lcbyoWwEFWTPxXf3cn3SqqCbmbByJSvbefY4d78G8vEixhuw6vmNWUCB+gyUTLKWpIDu0ucvOjAG4hZ/xO0IVhh9iHFH3l/LDFlaaUX6XnKVpSQjDBq3bIWWSkd+FQDT12xSwe/cc=
X-Gm-Message-State: AOJu0YyTTKakKGJwc+rhJ/PcKJcu0xjyXpcQEzDS0G02iOBO6HgS6JGK
	u+k/PzNTnEo8uRJnC/+CaKfjnIZC8znvXn8jjRreKdVxRDnzQeRf
X-Google-Smtp-Source: AGHT+IFo/wty98UTMMtG8GAS4WFnVQ24ZyfTc9ByO9/mu4xXiPZMmo65Bqm2j5F0X4kXN3HouoytBg==
X-Received: by 2002:ac2:4567:0:b0:516:9f03:6a9b with SMTP id k7-20020ac24567000000b005169f036a9bmr6839145lfm.4.1713175667244;
        Mon, 15 Apr 2024 03:07:47 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a0565123b8b00b00518f53da2dfsm149571lfv.291.2024.04.15.03.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:07:46 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] media: chips-media: wave5: support reset lines
Date: Mon, 15 Apr 2024 13:07:20 +0300
Message-ID: <20240415100726.19911-3-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415100726.19911-1-brnkv.i1@gmail.com>
References: <20240415100726.19911-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for optional reset lines. For now, simply deassert
resets on driver probe and assert them back on driver remove.

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 .../media/platform/chips-media/wave5/wave5-vpu.c | 16 +++++++++++++++-
 .../platform/chips-media/wave5/wave5-vpuapi.h    |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 68a519ac412d..54d1d44ed35a 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
+#include <linux/reset.h>
 #include "wave5-vpu.h"
 #include "wave5-regdefine.h"
 #include "wave5-vpuconfig.h"
@@ -179,6 +180,16 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, dev);
 	dev->dev = &pdev->dev;
 
+	dev->resets = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
+	if (IS_ERR(dev->resets)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(dev->resets),
+				     "Failed to get reset control\n");
+	}
+
+	ret = reset_control_deassert(dev->resets);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to deassert resets\n");
+
 	ret = devm_clk_bulk_get_all(&pdev->dev, &dev->clks);
 
 	/* continue without clock, assume externally managed */
@@ -191,7 +202,7 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 	ret = clk_bulk_prepare_enable(dev->num_clks, dev->clks);
 	if (ret) {
 		dev_err(&pdev->dev, "Enabling clocks, fail: %d\n", ret);
-		return ret;
+		goto err_reset_assert;
 	}
 
 	ret = of_property_read_u32(pdev->dev.of_node, "sram-size",
@@ -282,6 +293,8 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 	wave5_vdi_release(&pdev->dev);
 err_clk_dis:
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
+err_reset_assert:
+	reset_control_assert(dev->resets);
 
 	return ret;
 }
@@ -297,6 +310,7 @@ static void wave5_vpu_remove(struct platform_device *pdev)
 
 	mutex_destroy(&dev->dev_lock);
 	mutex_destroy(&dev->hw_lock);
+	reset_control_assert(dev->resets);
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
 	wave5_vpu_enc_unregister_device(dev);
 	wave5_vpu_dec_unregister_device(dev);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index fa4dc53949e6..d5c9480242b6 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -762,6 +762,7 @@ struct vpu_device {
 	struct kthread_worker *worker;
 	int vpu_poll_interval;
 	int num_clks;
+	struct reset_control *resets;
 };
 
 struct vpu_instance;
-- 
2.44.0


