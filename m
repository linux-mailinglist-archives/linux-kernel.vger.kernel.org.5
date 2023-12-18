Return-Path: <linux-kernel+bounces-4187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2485C8178F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC223B22F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D7F7347A;
	Mon, 18 Dec 2023 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiBl11nX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ADF5D75A;
	Mon, 18 Dec 2023 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e389473fcso1732707e87.2;
        Mon, 18 Dec 2023 09:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921260; x=1703526060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTDInBpm9IOKZKwVJjEBdmix1UD/v8KGld+1PsGVp6w=;
        b=SiBl11nXBEMHTM5Oe5DpIjlyoSvW9JFsoiLyu4PRkumz9HCk71neQmlVGjuqgr+oCl
         TdQeuEy4cCmkR8zOgT1HbVPnAR0h4MjgEudfjWCzP53Y26qfDWxCGDWp7YgF4KQVDDVU
         qNQ4qYayOlC1WcfXvs9zAzgvobdjZnAmRBcKBm7Pkk76mJh+3kCC/RlNPHYKDHIoR+Yb
         XdpnKHdAtLGyOJcYZ2fKv6jhjzZwQKJlsVEJSGFgAGJPgskTPeSvW8Jkb9HwjynOQbGf
         Cz2kQxyiWUb/nBpsiSzfS3Va/UGy45SsJ4zzpNnmexOta5j+VNzOtlWrQ0kf9SFDpF5e
         jiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921260; x=1703526060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTDInBpm9IOKZKwVJjEBdmix1UD/v8KGld+1PsGVp6w=;
        b=nFmvA/rMl1UKeopbR6X8zBhaaSSNiBTQVu+ssWBDyvb4SKDz6rqsNcqXVV3DtnuSLj
         zxT++KHIGz6ASK2LOOCUMyhDu4dSqmTAAr41RxCMJ/PEj/FjDK3CG2rHHxboV6M4JI6v
         uRkHl8CJ2ONWNvsD/JuWQBHu76aIabJc5mfGy/8gRD6yQ/7ALMKUnNjTlC47yL7heCSy
         3hnp6nykzVecpHB6+s9juIhVesofn7kU4wahW1wuw0lAPh3F79EbVtjMys01RON7ZV67
         oCruYoDON3+GSjEEd+D6mXQ3G0yjhT6UIDfSJl7LBAx23mh9H6nVvimcUZ4AapVcB3/m
         SzTQ==
X-Gm-Message-State: AOJu0Yy+8INZZ3z/J8E2DGxdOq9z8/E2SZKMxgK/keFpy01q0gz+7MSN
	VOUSJaEdTz4xdNhkZd8bstSJbQQn3LPv4w==
X-Google-Smtp-Source: AGHT+IF8m8vP0MsejeJK8yQbMHuQD09w2Ti/wP3cYuz/5CHJeklc0I5BDObhq9cKffHNyB42jbQiIQ==
X-Received: by 2002:ac2:46f3:0:b0:50e:24c4:6080 with SMTP id q19-20020ac246f3000000b0050e24c46080mr1815577lfo.7.1702921260303;
        Mon, 18 Dec 2023 09:41:00 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id k5-20020ac24f05000000b005094486b705sm3016372lfr.16.2023.12.18.09.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:00 -0800 (PST)
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
Subject: [PATCH v2 03/20] media: i2c: ov4689: Fix typo in a comment
Date: Mon, 18 Dec 2023 20:40:24 +0300
Message-ID: <20231218174042.794012-4-mike.rudenko@gmail.com>
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

Fix a spelling error in a comment.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 1ae6d9b9c9b3..7c33961fbb89 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -692,7 +692,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_EXPOSURE:
-		/* 4 least significant bits of expsoure are fractional part */
+		/* 4 least significant bits of exposure are fractional part */
 		ret = ov4689_write_reg(ov4689->client, OV4689_REG_EXPOSURE,
 				       OV4689_REG_VALUE_24BIT, ctrl->val << 4);
 		break;
-- 
2.43.0


