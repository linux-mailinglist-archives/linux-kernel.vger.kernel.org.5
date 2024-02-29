Return-Path: <linux-kernel+bounces-87115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA8786CFCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55181F23EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B301F134406;
	Thu, 29 Feb 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyDY43fr"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB97828E;
	Thu, 29 Feb 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225643; cv=none; b=Df/5l3klqziRcn/soJqmFs5sDTiJb6m6N1xkZbS9AhZcS6rjmRZ9+PMgeJ+qD3RUFFOiuXWXPObe/t6AbyPp9LncY5IdxIWyME0voe2wYKpQNEhJMaoaoyUfof7CRDQ90pXc1z4sAdsO+YozXQrDzVAOEPKrafJXTTnP8rN2Dps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225643; c=relaxed/simple;
	bh=RwZBkjBcy8SZvMSBuFZPyUzF0WRfRC8eJK3XqPT99Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raQD6vV33uY2SYEE5Vl0QO/3TqV9a0w6PNwd3xGtP6RzeCZn2GceB0zNMw2Nt4EanfBqQvnLez/hYchcHjwbc8do/+UmS7hYC20lYUE55BYHIjm6CCFK7lb7gxxijn2K681ot7uLRmKt1hib1zV01h9T4qDh91+69hQzbDe1jy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyDY43fr; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5131f3fc695so1241300e87.1;
        Thu, 29 Feb 2024 08:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225639; x=1709830439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WePeaNPDWRbNBkHA7ri2XyOGnHUFGGKonSsyXRKZzm4=;
        b=XyDY43frMoh6LvnPFTHmvxOCMp7dtYtyL0x/naWmsE11kF3b8FvOzXZhdu10pLRfR8
         iYZcFPMSoUByLBhaM8vlKdGR0dJ0ftbvNDmnDcCn7v75ACUFo1HLJWes2n0FazZD6I6R
         11GfkeSgYPRSWZPCwzipJdoCM1K7clL1tetj8+n65AMmIu7KIh8OSaLAhAJZDYz7UlIM
         /RCvyMsqtI6MdyxbowwJj1wjPmzsjkRAzADItpY57Aoim+TYSo/nkJMlipK0nHkywU7J
         GbQIQ8BmtCi2+ZSEl+4WklINynC6wDAuqgXd9rNYL+K3RpB54ymfH/ZkO0Vt5ezoIoRb
         3rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225639; x=1709830439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WePeaNPDWRbNBkHA7ri2XyOGnHUFGGKonSsyXRKZzm4=;
        b=bGmKXp5ETWCpcZci/7QZ3P2QwbUuiZDQp//TAD6vDzVxE/c3sUORMSqU5t3bFpQzXE
         HBfdS3b8h9RqSL2SrnZnve4Jmry4RM5BtCW3aD9XYyObNluXIwFyMxflTL8aJlo+vrFc
         OywOk0/5ILWE0XLeEQI9B/N4fjse1dD6O0PNcbwVJkas7PafHKfpKWjWCuYi/QRtzOyh
         DTijVjR+nn6Oj5fVgiMPFYt8LHl9pAZ6gIF2EWfVg3NsSCEgiPo2Mj2f889p9OOdEGKU
         TrvVELZ5YCDWAlU1LFRNIKVmOz3WTPtq7XMJzTaSGornazN8DSEu1CNnKCcxw5BD3bj/
         uj7w==
X-Forwarded-Encrypted: i=1; AJvYcCVYnty9/z2q9IZ3Otm9ccCezinByDLp2fnXvFKP9qJr5xNaquNrotLkyrnRyAxoY6lalECrJ0zz/S0jq01k9O/KYRGiY1iPtfEX+U/E
X-Gm-Message-State: AOJu0Yy2thx3JWUpCxOsB25RDpnKHOZ3qPk0cKPBL2AOWTek9Oe6SQaM
	PpSu4MY/YwNBLh5XtqWJMHAFH2XORjowFACSD2kMysMbJ1BTMCnp6QVe5gCNaT4=
X-Google-Smtp-Source: AGHT+IEXNx+UQ8+kfdXzFWGX7Hq5W+1lYNTkOanfNqdFOots3m+mWWwOMNThz5ANOdwkJqaZGE3zSQ==
X-Received: by 2002:ac2:549c:0:b0:513:19df:4eb6 with SMTP id t28-20020ac2549c000000b0051319df4eb6mr1699606lfk.12.1709225638773;
        Thu, 29 Feb 2024 08:53:58 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id p1-20020a056512312100b005131c9b1c8csm301594lfd.273.2024.02.29.08.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:53:58 -0800 (PST)
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
Subject: [PATCH v3 09/20] media: i2c: ov4689: Use runtime PM autosuspend
Date: Thu, 29 Feb 2024 19:53:22 +0300
Message-ID: <20240229165333.227484-10-mike.rudenko@gmail.com>
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

Use runtime PM autosuspend to avoid powering off the sensor during
fast stop-reconfigure-restart cycles.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 0e0e694510aa..2354397ab34c 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -426,7 +426,8 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 	} else {
 		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
 			  OV4689_MODE_SW_STANDBY, NULL);
-		pm_runtime_put(dev);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
 	}
 
 unlock_and_return:
@@ -606,7 +607,8 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
-	pm_runtime_put(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -876,8 +878,10 @@ static int ov4689_probe(struct i2c_client *client)
 	}
 
 	pm_runtime_set_active(dev);
+	pm_runtime_get_noresume(dev);
 	pm_runtime_enable(dev);
-	pm_runtime_idle(dev);
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
 
 	ret = v4l2_async_register_subdev_sensor(sd);
 	if (ret) {
@@ -885,11 +889,14 @@ static int ov4689_probe(struct i2c_client *client)
 		goto err_clean_subdev_pm;
 	}
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 
 err_clean_subdev_pm:
 	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
 	v4l2_subdev_cleanup(sd);
 err_clean_entity:
 	media_entity_cleanup(&sd->entity);
-- 
2.43.0


