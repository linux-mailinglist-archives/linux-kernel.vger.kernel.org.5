Return-Path: <linux-kernel+bounces-147710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299C18A7806
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9661C22EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B339613C8EE;
	Tue, 16 Apr 2024 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/cKjnt/"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7F513C668;
	Tue, 16 Apr 2024 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307545; cv=none; b=Z26qKKcHbjDCXRfsKBxd4aFIWFlAu7FO9fe0BYHNquV7ahra+GJ4k7sV2b0gYkI1mK3I1ope+jqIV3HGBQDZN99yTsQPM7M+9o6igI9u7278wgxIb2vrwACF27v/Y+59LzDD3jxu+JxAkcCeWYauF8vS9S7I/SN67rzLHtA2ysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307545; c=relaxed/simple;
	bh=dV8K4F0A9pXNtzsdUUObhQc03J0IRYcsli8GUU2LmRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJxfutJg+FHxuh3fBiGx/RJcyG1JdHuo8Bb2Dw5PIKNqMLTOLh3zqHJIWz3OU2VVRCkNuBU+++EuBwTUdvUsJ+7YuNh1Th3fEVdzJg80BWtyycqAA8Ltsnz5jhkmLx5mecCm41H8EP8KjgPdnl1kH5E+2mkgyxrLRXEzHoV9GwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/cKjnt/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d6e23253so5512666e87.1;
        Tue, 16 Apr 2024 15:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307541; x=1713912341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wi/0pJh/E7nGNzByWLAqj9/04e2L/P2ERnTt5QTMBc=;
        b=H/cKjnt/zPYr5Ahe4jm4hCJe1YtVRXrlaqY080OSEYTqFbfb7uGaFUnfRgrJy/uwD0
         1ISJfpLeYRXgZgDe3t4ThtA52wnqeCwdN6PWJ9yvzZHIdUp24yOHt4P4YXeVfg+UaNWA
         hVJkdKlaODX8Br8IY9tAz0/9sdaBkfAUmHTl9rsFmyKX6Mg/j9zoPiJqx+DSMUSft4O1
         yQTq8+NCSMAiKtMT9Nhc7faAQYm2dz4BnL5by3jYZ8fD89Iq4NSc7ZE1kWCMFw0mxA8c
         DlcrxYU5/dVZLmhoRCjh1YNvNIxul7rgTvusyBJUrZ7YFTHLeNdLRzYS/KVOBbM5d3Lq
         rbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307541; x=1713912341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wi/0pJh/E7nGNzByWLAqj9/04e2L/P2ERnTt5QTMBc=;
        b=L1X0N+JDrOepbd+dHxClCLHgUNdSbWeblKSyNWHjWJlmlBj4crCuY7PLlThJyajPqY
         15mIKnM9FliPcSxbmNScKuGZpAGsBlz7Jk2gco90rJGIzz1uQYcrugA4rFpM44ECu60G
         FqOHVxxYVGE6dCLL3BpxvqwRahT5dzWxxLshZuNXGGqLRXeSBKArfS4nk8eKEczatXze
         ClLqsRtfWepBqK1ENZGAlcaOMdmzDgARzXcdMC3mKgMOsYs+Eakzv3jFYw9QXAZkGl5+
         eEfOoKb+rXx6LBMDrLHj0TCNDKG0eMxARKvIMbnPV+EuUiRBe82xCShIllEh1iWXaFDq
         LJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVViDDzwHqhynLl+sNL8r+Uip1528R8sP1Rdr3FwudfNIgTUwz5odjtf6GCauFBKGUpo0fumjlQyj6ktyqwJ16CfJcHyjt6KAaMkgCk
X-Gm-Message-State: AOJu0YzTlCQ7Gqfs8sGJdNuhS98fklOWUJTtJZKmpVa2IrNpDkURnisN
	/kzc4WDadXkcvkH9plV7G7g440jwmYGQqiSD4Jg+gQrJGVzU6KbnMUXfibP2tRM=
X-Google-Smtp-Source: AGHT+IETqAohtet3hQMMVhNOQpBkqkPJ+OOj+5eX8IifNJsIPT1d7nADsiBnRukOB1bGYxlZzaTYsQ==
X-Received: by 2002:a05:6512:281b:b0:518:d956:5c5e with SMTP id cf27-20020a056512281b00b00518d9565c5emr7813250lfb.67.1713307541016;
        Tue, 16 Apr 2024 15:45:41 -0700 (PDT)
Received: from localhost (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id y5-20020a196405000000b00515d407aaa0sm1756247lfb.252.2024.04.16.15.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:45:40 -0700 (PDT)
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
Subject: [PATCH v5 09/16] media: i2c: ov4689: Use runtime PM autosuspend
Date: Wed, 17 Apr 2024 01:45:17 +0300
Message-ID: <20240416224524.1511357-10-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416224524.1511357-1-mike.rudenko@gmail.com>
References: <20240416224524.1511357-1-mike.rudenko@gmail.com>
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index ab30d7de5a52..12bd4b010c05 100644
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
2.44.0


