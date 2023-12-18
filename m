Return-Path: <linux-kernel+bounces-4192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547178178FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B1F1F21296
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F275D72D;
	Mon, 18 Dec 2023 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xff4szit"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38F7144B;
	Mon, 18 Dec 2023 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cc690a3712so21501661fa.3;
        Mon, 18 Dec 2023 09:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921268; x=1703526068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lcZDt5QGRhe9n/LLDxuh6IIVZbIKKGFKFqVIvYPe3o=;
        b=Xff4szitaYWeBor/vHoMfDqoUga6kFfxCFtVavBW2qNnhTwNPQkuakCopuNh4/o0Mx
         aJ8RuJ9i+9+bZ3j4YxsMbh7jq1WaaJVIy6y+rhLZ+mVs6wUxybIj8z83ismvI84ZsQ4y
         an0Ss8XfXziyKGKKoG7H/s7A3A4JGDLSRhQwp0s42KWwbrHwj/ckZJVo0SVIkjVm3SbK
         yimKP/cDeTeMiFGHG4TdGP0hJNbfOAiumEb8xNMoxigzd9tSdnimnaU6Msq5yaBIv6ba
         wlfwTmgVbQXhuq9yh1Bx/s3CkwdFiznydtwUKbWmv+o11eCnxyizxPTzJkhJ6nYENgmQ
         WTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921268; x=1703526068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lcZDt5QGRhe9n/LLDxuh6IIVZbIKKGFKFqVIvYPe3o=;
        b=nS39qulgPNrkmM7DU+NVwroJm82ef0QG8/sArfoqz9pHRqh+AsfgylGgSFdZm8y/z1
         5965BhKtQiXgXsbngcGzxxdvyVqWRzaReoq/OPoBPsqVWfm1q3EadbCsSSKbI61Y4Jib
         Oal/yBteQ6px1ps3tDTMkeQlau1qibYQRWd3Own9G+OR0wgGxqNB9dI2CCDq+UrZW2fD
         XV1C1E/LdFllJ2kkG42b7ZqSY6WMJOwHzmI6WUUXZyN7XujtshocW5hK+VR66uOBOsgF
         pKClOeKaQ+5SnkZPxwL/50G5LYaVycbnnKBOox27c9jbbhZiT6y8uB3//YUggvQSShOG
         44Mg==
X-Gm-Message-State: AOJu0YzfFOQdaREyzEBvomdS9sVVQTNPTmMW+tkcvXSoLvj8dKTgJkYs
	7dxXn618oiI4Gups4xRUSgCpZJK4L7PFkQ==
X-Google-Smtp-Source: AGHT+IFJ7DMdENSn1mXdrbi/Y7ERcM2t2FtjbfFdZg9Evs/GZ/Fr4tWkWnnVSiXj7M98mEb+GPNomQ==
X-Received: by 2002:a2e:9857:0:b0:2cc:7c8c:5748 with SMTP id e23-20020a2e9857000000b002cc7c8c5748mr18239ljj.63.1702921267816;
        Mon, 18 Dec 2023 09:41:07 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id z5-20020a2ebcc5000000b002cc259a574esm2497812ljp.117.2023.12.18.09.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:07 -0800 (PST)
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
Subject: [PATCH v2 08/20] media: i2c: ov4689: Enable runtime PM before registering sub-device
Date: Mon, 18 Dec 2023 20:40:29 +0300
Message-ID: <20231218174042.794012-9-mike.rudenko@gmail.com>
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

As the sensor may be accessible right after its async sub-device is
registered, enable runtime PM before doing so.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 501901aad4ae..5300e621ff90 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -876,19 +876,21 @@ static int ov4689_probe(struct i2c_client *client)
 		goto err_clean_entity;
 	}
 
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_idle(dev);
+
 	ret = v4l2_async_register_subdev_sensor(sd);
 	if (ret) {
 		dev_err(dev, "v4l2 async register subdev failed\n");
-		goto err_clean_subdev;
+		goto err_clean_subdev_pm;
 	}
 
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-	pm_runtime_idle(dev);
-
 	return 0;
 
-err_clean_subdev:
+err_clean_subdev_pm:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 	v4l2_subdev_cleanup(sd);
 err_clean_entity:
 	media_entity_cleanup(&sd->entity);
-- 
2.43.0


