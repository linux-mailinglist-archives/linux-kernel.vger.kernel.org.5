Return-Path: <linux-kernel+bounces-147707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E713A8A7800
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C38B22FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A16C13C3DE;
	Tue, 16 Apr 2024 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdRVdV8M"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1265713BAD6;
	Tue, 16 Apr 2024 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307541; cv=none; b=N/A3JKHa4LvS91ggXzxMiE/sai1QlLlqYcokbI+vSM4H/J4PeJvlGAZkV6RqlRNiK4pnc52OItdUi8q4lKerLSrjafh5TdfCj+Lb9EjEPn2PlJLnbiC8jY3F929SfrGrWtCJMNwyHmBSbNTcJNgF9ev8Y61cDSgYeR6woyIJoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307541; c=relaxed/simple;
	bh=VTXE4UhrTmceY1NPmrJgDEtmUJXENr5T4SfLMtc2i2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkMqAxS2AdCfN60SnvNATAlKCO4oG6b0yiqH1lhV5ASd4kF8R6v0AiGo/JwQPaV3nNUtvHQgeu8FHOCsK6gHdLgzMnYjfWpVYWZDxH0xTEfMtFXRqbjYF1N4YvYqCD1bcpVInG1WNpr3TFuiT5lNdvpq85mobF2xYG2ueF8uyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdRVdV8M; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d4d80d00so6143081e87.0;
        Tue, 16 Apr 2024 15:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307537; x=1713912337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vdGgiBkIc5YnTlEo2gOEmdH658ja8P/q71eV02YwcA=;
        b=QdRVdV8Mv4ta1pMRM4ACeCtNfkgOr2CqGPHaUduwSyJvRhRO8FybrS0KRGRGL93Y2Y
         CpYeoNjj6k20IVv5kflgLdHkEmAFEzGE/gcZIM6Dnb2HJwjQn36Du3qbMX7aafmevdk8
         O1ZtoGAnM0gVbT/+7JFmb6GJVQStNmetJ6ZxO4SA7nYvZWsAfdbDqR24R+x1qrM5HZUe
         lD2qAdYlLv+jXnyNeLAuxwQu3atAMwofxyrZ9Am+uzfSMx30wtMuimRApXyd5SgZQbVJ
         fLKzBY/lkTMNuBWp4xqhfuZvFRvYBzBaGc5ruD29mv57e5KASzJ2Tbpkd6yJgvrhTSKm
         U8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307537; x=1713912337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vdGgiBkIc5YnTlEo2gOEmdH658ja8P/q71eV02YwcA=;
        b=uqtAo6nQpEgDWyXS0FIfzsS+2bW+9TL+3Jg5TOB5roEG/FKpJTNtqmzpUa/U7WAvhf
         ngRmVbfDy7uKYcqH/GFLUmlVKzKv+TDv3dmwR3ZPtnkhlhccUnNYzVC9IZjX6Nf/YNqk
         aQUT3/Ja+q4xWOpWwLtmWYnhP0p5t6ZHP/vtLHtNrDYALp9+KjxJhgHyxJGZU5h517RF
         vq/JUzH6erm06iULf/b1y7Vk22UW5Ds1oZ5o+wKPwHXMZkjOW6ojKs9h1ryJRpSuOuzl
         m0NI6tTdECbTsZyacb6fWZeRnqrYM/GHBiX/CpxKG2YMz8DOWPTn1B3i2Fj7ULJYDWTJ
         Zz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+OZqLMdt44nMrUVHvYa55rGFoNyZuiD1iYTY+yAOI8isMrgBIerfzawnF9wK5qlUElcFHeyKYDv2du6MUvRWvEVunWZdb7H8BaiOh
X-Gm-Message-State: AOJu0Yw8sJmCSlzm2PkQLAvvNlhBLdXCfCfKPyNQdm5QMb8NAjmjgCWp
	JGyYmsEwRTxYJ/2n9vWiN38PSbe8p8rRKzvvnShNS7qbKkvfOYSodm/aD2HT8YM=
X-Google-Smtp-Source: AGHT+IHV3Rl5Kj5X5gq4S1dZsdPwKit3xs05UygSRKauN4NgZtn2MPpbTr1HGc0kC5Cx5tSJEb5wlQ==
X-Received: by 2002:ac2:5f1c:0:b0:518:9f1f:8f33 with SMTP id 28-20020ac25f1c000000b005189f1f8f33mr7379150lfq.15.1713307537395;
        Tue, 16 Apr 2024 15:45:37 -0700 (PDT)
Received: from localhost (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id s12-20020ac2464c000000b00516cea36d5bsm1752857lfo.21.2024.04.16.15.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:45:36 -0700 (PDT)
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
	Mikhail Rudenko <mike.rudenko@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH v5 06/16] media: i2c: ov4689: Refactor ov4689_set_ctrl
Date: Wed, 17 Apr 2024 01:45:14 +0300
Message-ID: <20240416224524.1511357-7-mike.rudenko@gmail.com>
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

Introduce local variable for regmap within the ov4689_set_ctrl
function. This adjustment eliminates repetition within the function.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index a3fb6498753f..883dcee52d5f 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -580,10 +580,11 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct ov4689 *ov4689 =
 		container_of(ctrl->handler, struct ov4689, ctrl_handler);
+	struct regmap *regmap = ov4689->regmap;
 	struct device *dev = ov4689->dev;
 	int sensor_gain;
 	s64 max_expo;
-	int ret;
+	int ret = 0;
 
 	/* Propagate change of current control to all related controls */
 	switch (ctrl->id) {
@@ -603,16 +604,15 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	switch (ctrl->id) {
 	case V4L2_CID_EXPOSURE:
 		/* 4 least significant bits of exposure are fractional part */
-		ret = cci_write(ov4689->regmap, OV4689_REG_EXPOSURE,
-				ctrl->val << 4, NULL);
+		cci_write(regmap, OV4689_REG_EXPOSURE, ctrl->val << 4, &ret);
 		break;
 	case V4L2_CID_ANALOGUE_GAIN:
 		ret = ov4689_map_gain(ov4689, ctrl->val, &sensor_gain);
-		cci_write(ov4689->regmap, OV4689_REG_GAIN, sensor_gain, &ret);
+		cci_write(regmap, OV4689_REG_GAIN, sensor_gain, &ret);
 		break;
 	case V4L2_CID_VBLANK:
-		ret = cci_write(ov4689->regmap, OV4689_REG_VTS,
-				ctrl->val + ov4689->cur_mode->height, NULL);
+		cci_write(regmap, OV4689_REG_VTS,
+			  ctrl->val + ov4689->cur_mode->height, &ret);
 		break;
 	case V4L2_CID_TEST_PATTERN:
 		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
-- 
2.44.0


