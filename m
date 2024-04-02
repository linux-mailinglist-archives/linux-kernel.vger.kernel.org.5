Return-Path: <linux-kernel+bounces-128384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B94895A25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FDF282AF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EA615E1ED;
	Tue,  2 Apr 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfmzf294"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B1515DBCA;
	Tue,  2 Apr 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076412; cv=none; b=f87TBVL0jb4k7dMG3vb8jIM5naknIo79XLlA4qPnBPG4j25ex8tDnzNU4yWKgRMa2Uctbh5J+Y7F4ZrTuFFnQJT692P1eBTJ0qa7CQCgZCKbN4dFxpbiezGLGuPy1uq9//TTil1em2d7iHklq5isz/IJrkUPCYmsiOtd27Hb72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076412; c=relaxed/simple;
	bh=KeQZSc6qLuPCqKYTf+fXZ35RQcX3xbkDNgXZF0afbWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTRfC8dYlMp4T3aPMXmdxN1XejR/PHvKa7WEKwsQZw5ew4K4C4Nrq5m+YY73mXabZjM7gxtvv3AzMnx3aVJDnUyPDDoBfI1fUTwEbsUvQGXQ81fOBoDTT++88xRfhLMHXRk1bG9invJA6z8F/10fBYgmKXtREWIVETrOiJo6G58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfmzf294; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d6fd3cfaa6so74490611fa.2;
        Tue, 02 Apr 2024 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076408; x=1712681208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wP6dhYTebLfn0dU0utzWWRiXR+PetY3yk82kLJ9TWMg=;
        b=hfmzf294g1aomp5rJ1CgQO4g8oMdhNHdo1anXPwPricmff0YOEETgTaorhuXMRkP7W
         1yzQYJmCfh8DOuNiu433cvvfYlay2Bud/a0aUM/uVIRhT806JNQfws+BlSTvD0NkgdkS
         91z5m8Zkm8N8o60/vAECAhL54yGcjdbLSnkji8tjlPv4pXbDzFQi3smdRROyvjOghKFh
         hfXiWGIsbP/85+YD7snUc6J6l/8sd0rK+OQFvsMkWopQp1mAhf1epNf8ZcdnoTQMWd7S
         Oe2JHrlUIGVPDq6Q5HzEWnnfM62mKi7iPJLTjEheRD+g0tMqLM9vKsXkhlmH2JpXb4gl
         uJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076408; x=1712681208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wP6dhYTebLfn0dU0utzWWRiXR+PetY3yk82kLJ9TWMg=;
        b=Y/mzhk/XhsYWyIuX/7CTx/ZPHPiSJ4oNNO7zBBeXAJ+SmUU1QkGsp2IHZADytX7cXB
         5pos3LkFjaf43ddhSY3k5D1KtVUIoOwLnU4TO/jYC0Zh/cflQlRgHqnvlwZfvGrunjNS
         K/IB1+/fNz8EnIO7eMB8vlaAFpg+zitTrdoLc6dqmS2zhIb7pxY2HJqEVfkhJ56gRNVJ
         B3lO43S4uoaWcktW+ez7OwiTG66lcDHExItl3kQlBQu35CSm3k1oyAB8a5fHPjA8RzFM
         Q62PfCNvXdAaX9H64/FOY9MMkS32YGo0P9dmP7K5ihAbqhrz0dQHVBwwBLqNOwjpm1iW
         DXfA==
X-Forwarded-Encrypted: i=1; AJvYcCVcsLc0VegQhrfBXuEVFjRE66yIPqO+/HFhK/E918pr6hzw85JnaVbfkDKehGSxi2FDJbNY7q1Im+T+gU19USHl8GrOrFxymckbXml5
X-Gm-Message-State: AOJu0Ywf4G+obevZ64nxTMndZjI5sof1YoBaHYfiQfSWjqrESWfJ1Ljw
	oUv1Ox4GRjsWnmlHRQt7PAMpsQcQAJ3vi2S7/DknEN9/XfrVrQQZnkW7ZWQw1ybrYg==
X-Google-Smtp-Source: AGHT+IESLx1jISymY0C/8VYRIEFF1eum84jCbOVc/DUMVwIDkDkSQ9YTBtiQ5CY10c7jFUP+vxPJyQ==
X-Received: by 2002:a2e:be1e:0:b0:2d8:a71:b17a with SMTP id z30-20020a2ebe1e000000b002d80a71b17amr150576ljq.3.1712076408367;
        Tue, 02 Apr 2024 09:46:48 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id f10-20020a2e950a000000b002d45ad8efdesm1643033ljh.106.2024.04.02.09.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:48 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v4 19/20] media: i2c: ov4689: Refactor ov4689_s_stream
Date: Tue,  2 Apr 2024 19:45:50 +0300
Message-ID: <20240402164552.19171-20-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402164552.19171-1-mike.rudenko@gmail.com>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split ov4689_s_stream into ov4689_stream_on and ov4689_stream_off
functions. Also remove repetitive pm_runtime_put calls and call
pm_runtime_put once at the end of the ov4689_stream_on function if any
error occurred.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 100 ++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index f43be255234b..e652d626f32f 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -537,61 +537,67 @@ static int ov4689_setup_blc_anchors(struct ov4689 *ov4689,
 	return ret;
 }
 
+static int ov4689_stream_on(struct ov4689 *ov4689,
+			    struct v4l2_subdev_state *sd_state)
+{
+	int ret;
+
+	ret = pm_runtime_resume_and_get(ov4689->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = cci_multi_reg_write(ov4689->regmap, ov4689_common_regs,
+				  ARRAY_SIZE(ov4689_common_regs), NULL);
+	if (ret)
+		goto error;
+
+	ret = ov4689_setup_timings(ov4689, sd_state);
+	if (ret)
+		goto error;
+
+	ret = ov4689_setup_blc_anchors(ov4689, sd_state);
+	if (ret)
+		goto error;
+
+	ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
+	if (ret)
+		goto error;
+
+	ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
+			OV4689_MODE_STREAMING, NULL);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	pm_runtime_put(ov4689->dev);
+	return ret;
+}
+
+static int ov4689_stream_off(struct ov4689 *ov4689)
+{
+	cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE, OV4689_MODE_SW_STANDBY,
+		  NULL);
+	pm_runtime_mark_last_busy(ov4689->dev);
+	pm_runtime_put_autosuspend(ov4689->dev);
+
+	return 0;
+}
+
 static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 {
 	struct ov4689 *ov4689 = to_ov4689(sd);
 	struct v4l2_subdev_state *sd_state;
-	struct device *dev = ov4689->dev;
-	int ret = 0;
+	int ret;
 
 	sd_state = v4l2_subdev_lock_and_get_active_state(&ov4689->subdev);
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(dev);
-		if (ret < 0)
-			goto unlock_and_return;
-
-		ret = cci_multi_reg_write(ov4689->regmap,
-					  ov4689_common_regs,
-					  ARRAY_SIZE(ov4689_common_regs),
-					  NULL);
-		if (ret) {
-			pm_runtime_put(dev);
-			goto unlock_and_return;
-		}
-
-		ret = ov4689_setup_timings(ov4689, sd_state);
-		if (ret) {
-			pm_runtime_put(dev);
-			goto unlock_and_return;
-		}
-
-		ret = ov4689_setup_blc_anchors(ov4689, sd_state);
-		if (ret) {
-			pm_runtime_put(dev);
-			goto unlock_and_return;
-		}
-
-		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
-		if (ret) {
-			pm_runtime_put(dev);
-			goto unlock_and_return;
-		}
-
-		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
-				OV4689_MODE_STREAMING, NULL);
-		if (ret) {
-			pm_runtime_put(dev);
-			goto unlock_and_return;
-		}
-	} else {
-		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
-			  OV4689_MODE_SW_STANDBY, NULL);
-		pm_runtime_mark_last_busy(dev);
-		pm_runtime_put_autosuspend(dev);
-	}
+	if (on)
+		ret = ov4689_stream_on(ov4689, sd_state);
+	else
+		ret = ov4689_stream_off(ov4689);
 
-unlock_and_return:
 	v4l2_subdev_unlock_state(sd_state);
 
 	return ret;
-- 
2.44.0


