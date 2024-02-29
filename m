Return-Path: <linux-kernel+bounces-87125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E131586CFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114F71C21FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8E3144052;
	Thu, 29 Feb 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Txigak+7"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3159B13C9F8;
	Thu, 29 Feb 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225656; cv=none; b=TdHacpnCmwYCoUziHbu3NeC03gzHS8gl74op2N3BzbFUMnR6DWcO8mIxt6lp8BXx071Sq30aQ/anEkizGf9EBR9cU4DhlYAQFTQNxM6pQNXqxjnRk/ko6AtRJU0Lqp0kkXzSrxtfB8ttIcHGpsq92RB7n8wT7b/lIsyjehRX0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225656; c=relaxed/simple;
	bh=DQgBBCe30PiuMHNAPhMabPDvQSowIGICsrFN+nn2ZhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3xHUpNvuGC1yPF4CCF+Qgj+ToErym6PLjiUQClEjHy+2HTWgPrfbQlOtwC4is9XeGgQmCYLQcyVJedUSneDjnFUVKqbHBJ7rTTydsBR3cuLS6CmGHxxlucf8lgheNAI9Jk5gUnPpD5V47yEfWlhmN4nnVMiCUamwRx2qblzvZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Txigak+7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d28387db09so12600911fa.0;
        Thu, 29 Feb 2024 08:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225652; x=1709830452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itbmjfXIRedOHxtrfBuhEmKTtpYmXBkZ0ygkNfj1H5o=;
        b=Txigak+7vqkYKc1MXfCYyTBzC7DZ9PFEPETMkRAq90XMM1hq102EcaMdazA+RhWED4
         EtVJo53XRamKWZhjo2b10FuhAMCohVqbKIhxYvmiwCoveJi4s/RJJsMGFgbRO5A145Kc
         KJAbhUOJZWp4oxwGEXemPgEp9ZMVjGdsmvi1VCmBRTbq2f4moZefZebiVPcDyMTWR6wU
         gPWeauLYdtFSia0rEZcISMaMAMNZkSM6AFj9EGhLCY+iVTZphw2QY386jgMh0i+4ACGl
         1XTTGFr8lSSoWx1fO+TqL6tSCxi57WpODB3WY71LcfTzQHQqfkMa/kKYmBb2Wl9Xgd3W
         uYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225652; x=1709830452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itbmjfXIRedOHxtrfBuhEmKTtpYmXBkZ0ygkNfj1H5o=;
        b=fkN0UA5pf/Ilc8/XdhusdvHkOynVNuotXT4mymP/YA0X8jp1/CxODE6/7fIw0q6oZN
         dgd6ZJmzgP3eXPRXfSUHthSbbeq4XifVTeNAzW4wzCot9xQWBH+lfIg4Il+DwD5tUPex
         OH5xG/zPVUpR1VcG1VBwSMvi6Ec9QCMV50FeD2IsmuAHpxs50qFTQ7CqYnSIPuMvNzxo
         ut2AkL7TEsu3sZCFI4Ivd7NrdllA84VVjb0iByhjcjiNmUnHaCu2A6c7d2J2T5NTGqc6
         J/AZkuKPsyI38FduSIa8EuT24gy6HX+8It93+ttu08umRtQDmKCAn/HcxNMpKc3DEo7A
         t6Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVBnyKQmRRBNAKRbuTYrEctsJpWvFRcGmF6YuOhtaCtr0BLuDTUoUG6/ECSToTMCZ03a7WdBoBizaz3fm6jIIzpcfQXdOmIVJ7hVkOa
X-Gm-Message-State: AOJu0YysOsxnVV0u70BiL9/pJQfZMuDZy2UNHr5ak+N2qlcklvKuycao
	AeNjdQwKvRtNxlPkZvRAPzSc5r8u2tZH8ijM6ynxPOs6z6avZXiuHef0u0dJ540=
X-Google-Smtp-Source: AGHT+IE5bERwoR7nvXNmX5EEwXzLtN+OhCQtCadZJZH32mf06N02X70yuzSFhmVeS8p23iYNsSuuMQ==
X-Received: by 2002:a2e:964c:0:b0:2d2:478a:83e with SMTP id z12-20020a2e964c000000b002d2478a083emr1793764ljh.24.1709225651922;
        Thu, 29 Feb 2024 08:54:11 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id h8-20020a2e9008000000b002d267e3bf5dsm275909ljg.81.2024.02.29.08.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:54:11 -0800 (PST)
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
Subject: [PATCH v3 19/20] media: i2c: ov4689: Refactor ov4689_s_stream
Date: Thu, 29 Feb 2024 19:53:32 +0300
Message-ID: <20240229165333.227484-20-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229165333.227484-1-mike.rudenko@gmail.com>
References: <20240229165333.227484-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split ov4689_s_stream into __ov4689_stream_on and __ov4689_stream_off
functions. Also remove repetitive pm_runtime_put calls and call
pm_runtime_put once at the end of the __ov4689_stream_off function if
any error occurred.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 100 ++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 2496067b90a0..5cea9b5ba201 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -537,61 +537,67 @@ static int ov4689_setup_blc_anchors(struct ov4689 *ov4689,
 	return ret;
 }
 
+static int __ov4689_stream_on(struct ov4689 *ov4689,
+			      struct v4l2_subdev_state *sd_state)
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
+		goto cleanup_pm;
+
+	ret = ov4689_setup_timings(ov4689, sd_state);
+	if (ret)
+		goto cleanup_pm;
+
+	ret = ov4689_setup_blc_anchors(ov4689, sd_state);
+	if (ret)
+		goto cleanup_pm;
+
+	ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
+	if (ret)
+		goto cleanup_pm;
+
+	ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
+			OV4689_MODE_STREAMING, NULL);
+	if (ret)
+		goto cleanup_pm;
+
+	return 0;
+
+ cleanup_pm:
+	pm_runtime_put(ov4689->dev);
+	return ret;
+}
+
+static int __ov4689_stream_off(struct ov4689 *ov4689)
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
+		ret = __ov4689_stream_on(ov4689, sd_state);
+	else
+		ret = __ov4689_stream_off(ov4689);
 
-unlock_and_return:
 	v4l2_subdev_unlock_state(sd_state);
 
 	return ret;
-- 
2.43.0


