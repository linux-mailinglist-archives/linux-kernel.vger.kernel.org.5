Return-Path: <linux-kernel+bounces-4197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5291B817907
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56D21F2516C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F9D72045;
	Mon, 18 Dec 2023 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsmO4MPg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F497408A;
	Mon, 18 Dec 2023 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cc4029dc6eso41241111fa.1;
        Mon, 18 Dec 2023 09:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921269; x=1703526069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+AOlN1QWf7zHgr+1BqJOwJHJOoAiKQ8ZouD3wx/nb4=;
        b=hsmO4MPgEEvT84rvsWcOuG8HLxtbSnqmbwbKWYoBaFgp9Wgx3EgdAls70FT5zxg54+
         v+iNXcIRZtHNYcqtDL75wAu5xpwNm6umzKHFbesJQHVRyNehu2Te+DQOuDBEfMxcTQ2C
         ojqDmfgaezA0sbuiDy7qa5iRJ0ouW6wMoQUR85srW7F9xOUF1nJQnhlSQ4LQIBwgaUJ3
         cwbMTiz1CwREdfCfjfF/7VasvwMb+WedEHkhAK3Dxy8BVEQQBBE8Iq3w1VjyTCQQokL/
         bZSAczwKtbkMLMKqNLrYsSWrh7WfwQUxWUtUsvJn7s5+3+AOk5wD0GP7jqIOvgN8cJB7
         Ia6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921269; x=1703526069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+AOlN1QWf7zHgr+1BqJOwJHJOoAiKQ8ZouD3wx/nb4=;
        b=i5/vlKX7aJP3PwG4zhEF0fu8LUi62SIkD1P7mE17tJqOrJTU2AULEH0yotYWwBbkIX
         lSr0VSoPGZBR7rvXC5As9Rgexw5syq8meyJbKOIL0iXALaPL+B89iVXfKx5/VxQmd4+5
         98RfjUZthCvhKwtW/fk7+9C6JxLexqsK4xJbVhvIvD9Di7mxwREjX1ocpWThfyhqtLqp
         RcE1SmAU5FhHAEqNwtEjGHwl2enJV/GZ7TO3UEzWkDPjXC1PHwYOZf97W3iGYK7fchlv
         JGaHTFkUaec2FX427nJaP5aOsUXSY1jJ8Rc8bAwUQIs5pC4WSt6vzOQ53CK6cF/0oKV0
         YlGA==
X-Gm-Message-State: AOJu0YzHkB3R7Kzd85CFCm6d2vAS22unW/a5EBo85h1KoKmr8hOv5h3S
	QS8MHJiuq1wqcgnBk8LptXvE5MQlzXcBGw==
X-Google-Smtp-Source: AGHT+IHwpj/ptq03du2UQFOKrRI41kSsBCF0FBxBKU/3tNcFaqP9tLQwjSDhNd/ueoYRbFegnVyQTA==
X-Received: by 2002:a2e:bc08:0:b0:2cc:41c9:9c71 with SMTP id b8-20020a2ebc08000000b002cc41c99c71mr5214230ljf.25.1702921269208;
        Mon, 18 Dec 2023 09:41:09 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id w22-20020a2e9bd6000000b002cc710614besm455091ljj.0.2023.12.18.09.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:08 -0800 (PST)
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
Subject: [PATCH v2 09/20] media: i2c: ov4689: Use runtime PM autosuspend
Date: Mon, 18 Dec 2023 20:40:30 +0300
Message-ID: <20231218174042.794012-10-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218174042.794012-1-mike.rudenko@gmail.com>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
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
 drivers/media/i2c/ov4689.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 5300e621ff90..64cc6d9e48cc 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -407,26 +407,27 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 					  ov4689->cur_mode->num_regs,
 					  NULL);
 		if (ret) {
-			pm_runtime_put(dev);
+			pm_runtime_put_sync(dev);
 			goto unlock_and_return;
 		}
 
 		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
 		if (ret) {
-			pm_runtime_put(dev);
+			pm_runtime_put_sync(dev);
 			goto unlock_and_return;
 		}
 
 		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
 				OV4689_MODE_STREAMING, NULL);
 		if (ret) {
-			pm_runtime_put(dev);
+			pm_runtime_put_sync(dev);
 			goto unlock_and_return;
 		}
 	} else {
 		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
 			  OV4689_MODE_SW_STANDBY, NULL);
-		pm_runtime_put(dev);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
 	}
 
 unlock_and_return:
@@ -606,7 +607,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
-	pm_runtime_put(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return ret;
 }
 
@@ -877,8 +880,10 @@ static int ov4689_probe(struct i2c_client *client)
 	}
 
 	pm_runtime_set_active(dev);
+	pm_runtime_get_noresume(dev);
 	pm_runtime_enable(dev);
-	pm_runtime_idle(dev);
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
 
 	ret = v4l2_async_register_subdev_sensor(sd);
 	if (ret) {
@@ -886,11 +891,14 @@ static int ov4689_probe(struct i2c_client *client)
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


