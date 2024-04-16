Return-Path: <linux-kernel+bounces-146990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7B78A6DED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7B31F21EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59152131745;
	Tue, 16 Apr 2024 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjpoSWjI"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C61131197;
	Tue, 16 Apr 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277162; cv=none; b=PxXiMKS1t11l2gqkw5wE6kE39Poa3oV6JgEpoyc7sRM21m8jCiE+QeWaQHD6u9CrSLz83MXIZlA8Tn5n0vLHKwnN2f52+P2DATN2doWA6W0iOnQMf+g56wKKhIaCh+gZqXT8l0r5k97AYgBX3Fi7HFJWClB7lNtPZx+exEOLH0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277162; c=relaxed/simple;
	bh=VD7sF7wNf6E8hter+2Fpq1VzyDvV4t+EIagEUr9qBVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qji1H0KDSarCQDeeNrzEfHJ1q1rDOpqtOYDDMDdPrEKaXWJfd/B2kLh7/2W8mw1cftDnGIxHYWNQMnl3Lp4+u3txE41t39tNOoINrAXiTJTPfiO4FynH+ZzevPNhRyi7vnoFC3YsdpgPPuh6xTkuVrLkcBG3lOgcWfJME/68BNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjpoSWjI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3465921600dso3975524f8f.3;
        Tue, 16 Apr 2024 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713277159; x=1713881959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jplUX2Z22IzViGFKKT1zerZd+0Nbd9om17H2hhvI1qU=;
        b=DjpoSWjIeNOlCcWfXyApEj2SN7qXZUVP8PmX0y4ZzN2ZUFZ240sH9OECeVE4w8HsEo
         DRvYGVHsaygk+2iVQ2ChCKqUMxR91yPCPcRkR8HGXYoh9xea+GQtvhK2KKCqLZJrbh5R
         8C1w8Uv4NN/HMbW6F96Np+XsYxUqozdjPW0ROh3wCD0tGMF9Weud+qR3y3M3AJPOPWCn
         R8l6oKYO9fJEyKT82Pg5BHpal2vS1oP9nyfSH88Bq7w6l8IYsicadKJrzABKkwk3nU/N
         izmQLm0p4eyn36rY+iEHX5oZmD9NMWhGk0WNZbrb+j5w+zUk2q/BUzsKKiIe6IeUpXR4
         TRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713277159; x=1713881959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jplUX2Z22IzViGFKKT1zerZd+0Nbd9om17H2hhvI1qU=;
        b=sfT2sXMbRJHR4DOvjdS3gqdVo/jk373srSAbcC0G2Wo1n66NkGQFxTz1GuOVDqMYGg
         oIce8GAXCGsEKED/Y2YgeHYkC//19XNY7HslUUOsvDnslHxztnVYfbeujwFSaj8C3TUr
         P028NRTNmW1/xKlqWbftYvtyJ//N+eC+5G9yGkohORzt3GZSXKCOwid1wL/CHUQNN3Mf
         QnsBcg9nVxYwFhL6TPR/FK2nYYmftK0PycHbtvdHJve9kJXR3NWjJbvlPew5/CXfvVop
         nCJ82UixbohH4AWuT8pW+rAfa3IvP+iD2sySLZJOaZeEpcdxW2GTwmpDnc8x2Kt7KIU1
         8bzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi4Nviu0F5hMTBXJkLkoZa7eyaQp62q7OQyLpTu0JFfGJEI04/lWTqbWFLHL0Ks95ietfWV2fFgZfO9DFXODWk43MCWSlzKbMsYdjgDM5buiMhRqEvLBfw4qzp8U8JLag/1nex8YiuMUU=
X-Gm-Message-State: AOJu0YwO57G7vhTWswE3YF38Dk01tUkS4r1ZaoXsH4frFjBDxL8kh37X
	oMzp18B+kX4B8Zv2OWn09c45JaCJhYIV+tJiRpl335QwFp1zcMGO
X-Google-Smtp-Source: AGHT+IFix+57hY89L4+mjqA0Cz3qrEdkRBWQepHFIfBHt+YatMHq0HeYk2ornFqRaHEJSwZGgrR/MA==
X-Received: by 2002:a5d:4411:0:b0:349:8a92:7eda with SMTP id z17-20020a5d4411000000b003498a927edamr968333wrq.12.1713277159450;
        Tue, 16 Apr 2024 07:19:19 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-57-233.cust.vodafonedsl.it. [188.217.57.233])
        by smtp.gmail.com with ESMTPSA id b11-20020adfe30b000000b0034625392416sm15055114wrj.104.2024.04.16.07.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 07:19:19 -0700 (PDT)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: martin.hecht@avnet.eu,
	michael.roeder@avnet.eu,
	tomm.merciai@gmail.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] media: i2c: alvium: implement enum_frame_size
Date: Tue, 16 Apr 2024 16:19:04 +0200
Message-Id: <20240416141905.454253-5-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416141905.454253-1-tomm.merciai@gmail.com>
References: <20240416141905.454253-1-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the enum_frame_size pad operation.
The sensor supports a continuous size range of resolutions.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/alvium-csi2.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index 2ab4c7e563d2..30ef9b905211 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1717,6 +1717,27 @@ alvium_code_to_pixfmt(struct alvium_dev *alvium, u32 code)
 	return &alvium->alvium_csi2_fmt[0];
 }
 
+static int alvium_enum_frame_size(struct v4l2_subdev *sd,
+				  struct v4l2_subdev_state *state,
+				  struct v4l2_subdev_frame_size_enum *fse)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	const struct alvium_pixfmt *alvium_csi2_fmt;
+
+	if (fse->index)
+		return -EINVAL;
+
+	alvium_csi2_fmt = alvium_code_to_pixfmt(alvium, fse->code);
+	if (fse->code != alvium_csi2_fmt->code)
+		return -EINVAL;
+
+	fse->min_width = alvium->img_min_width;
+	fse->max_width = alvium->img_max_width;
+	fse->min_height = alvium->img_min_height;
+	fse->max_height = alvium->img_max_height;
+	return 0;
+}
+
 static int alvium_set_mode(struct alvium_dev *alvium,
 			   struct v4l2_subdev_state *state)
 {
@@ -2224,6 +2245,7 @@ static const struct v4l2_subdev_video_ops alvium_video_ops = {
 
 static const struct v4l2_subdev_pad_ops alvium_pad_ops = {
 	.enum_mbus_code = alvium_enum_mbus_code,
+	.enum_frame_size = alvium_enum_frame_size,
 	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = alvium_set_fmt,
 	.get_selection = alvium_get_selection,
-- 
2.34.1


