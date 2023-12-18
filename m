Return-Path: <linux-kernel+bounces-4204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C217817916
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9080DB2348A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AA57CD18;
	Mon, 18 Dec 2023 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTG8rUde"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F77BF09;
	Mon, 18 Dec 2023 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cc259392a6so40380091fa.2;
        Mon, 18 Dec 2023 09:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921285; x=1703526085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Db9zQ/cEzdabx9SHSYCUhC/ZN+6oeRqIuZFUX0OxwU=;
        b=PTG8rUdeNkGfdmowl5R1KJTy3z+neKeSws7v5yD1wstCvJwJcF4spM55YveLjCSf3D
         mH1b207EF+Caj+ublnDu8Ap9wfmwnn09pIs85YhdpSjwtHS9Vptv9VgkkQ3fAdsvnXgV
         8ZZmZq4WB+C0m+zOFpLoUnoQSDLhl9eTaYOYVNG6Am9j5/PPv4hmNOjOjLHVm8SEh7LW
         Y60d9OZHnOPMKwWvHdvucp9beBoNXiiKiI7JIzJJmpiViLSu16KJKvvRbdbkk3KSHgvZ
         2NU83GoZlwx8G3ZkaUxFUoMj4Dh2J1cKXsEVvm+u6+S1uANnjcPNuTg6/ea0kYuW2V5x
         bbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921285; x=1703526085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Db9zQ/cEzdabx9SHSYCUhC/ZN+6oeRqIuZFUX0OxwU=;
        b=r1+xxZonbHKcPBZJYgXt7o5oMJfkaVL3EhCLau8E2XSp8TV7Lx+9chD7kZbSO9Xj6G
         oMg+T4gQU4KZwb5lGxHerRRgCXbLhIiE/CSRBRJZ+BEz3KXC4Gj0sDQd1U8BkM9tioqy
         CTgxDxxHbB18dmsBEx2GxoDvoj0VaPjiFIjmExxcXd17MK1qhxsoqr+vRVfVJRqlhpD4
         QEKZa7j90LK6w69wbKVpgauPJmlFgmIWanuT2413aMH+ko7z1UaTbYeXx3aMgVmVoZeF
         TcwpWh347jK65+tCGvi3dTVIHTPjJ07Yk67oqShWg7vpv3ytZhc45MumP02ZfR1sA0ZL
         H4Dg==
X-Gm-Message-State: AOJu0YxetExudEY1aFXulm/cWD+YnyqqbXOwCpyVMT8SUidT/+E6eldx
	kCxcID1VcP7dIBuDUIzGOZyMObA9EAwseA==
X-Google-Smtp-Source: AGHT+IF9vx4KlzpdrYsIUTYLFL8RO+IiPNxkVU/6Y5Pspf+P2xp+K3abQf+H/+3amsy4xccrqY4b+Q==
X-Received: by 2002:a2e:8783:0:b0:2cc:5a63:3903 with SMTP id n3-20020a2e8783000000b002cc5a633903mr1994561lji.79.1702921285505;
        Mon, 18 Dec 2023 09:41:25 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id k11-20020a2e888b000000b002cc5f5fc8cesm866940lji.63.2023.12.18.09.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:25 -0800 (PST)
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
Subject: [PATCH v2 19/20] media: i2c: ov4689: Refactor ov4689_s_stream
Date: Mon, 18 Dec 2023 20:40:40 +0300
Message-ID: <20231218174042.794012-20-mike.rudenko@gmail.com>
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

Remove repetitive pm_runtime_put calls in ov4689_s_stream function,
and call pm_runtime_put once at the end of the "on" branch if any
error occurred.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index e997c3231e85..884761d02119 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -555,35 +555,26 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 					  ov4689_common_regs,
 					  ARRAY_SIZE(ov4689_common_regs),
 					  NULL);
-		if (ret) {
-			pm_runtime_put_sync(dev);
-			goto unlock_and_return;
-		}
+		if (ret)
+			goto cleanup_pm;
 
 		ret = ov4689_setup_timings(ov4689, sd_state);
-		if (ret) {
-			pm_runtime_put(dev);
-			goto unlock_and_return;
-		}
+		if (ret)
+			goto cleanup_pm;
 
 		ret = ov4689_setup_blc_anchors(ov4689, sd_state);
-		if (ret) {
-			pm_runtime_put(dev);
-			goto unlock_and_return;
-		}
+		if (ret)
+			goto cleanup_pm;
 
 		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
-		if (ret) {
-			pm_runtime_put_sync(dev);
-			goto unlock_and_return;
-		}
+		if (ret)
+			goto cleanup_pm;
 
 		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
 				OV4689_MODE_STREAMING, NULL);
-		if (ret) {
+cleanup_pm:
+		if (ret)
 			pm_runtime_put_sync(dev);
-			goto unlock_and_return;
-		}
 	} else {
 		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
 			  OV4689_MODE_SW_STANDBY, NULL);
-- 
2.43.0


