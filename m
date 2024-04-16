Return-Path: <linux-kernel+bounces-147703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AEF8A77F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A361F220FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6386413AA2F;
	Tue, 16 Apr 2024 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXMju8nv"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182191386BF;
	Tue, 16 Apr 2024 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307536; cv=none; b=aKjqxz7qOr0A+IF4F+l1HL2x4qDv8sEoMlJDwpGcAURcJekg8d7UK4zsInzDdrwbBXHsHlwFwUfOTiCteLjcDJqANT8wwFzga+evPsOTKyjnzmkbOD8srf+xbp+WoTZwOTW0tIza5EdIYml6MFnLJenh9FkT25XDUpfIrW5Lr7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307536; c=relaxed/simple;
	bh=FJrlk6QnL//BUemzFKki2Dq54faR6yE8vBjGpDaJcxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=in/wN63XGxSgC97dj7uiBGwewVUXVhEesAS2qohJb2UgBuwVtkWQcCIcQ+82fYsUST62L6iaWNWQ4ReK+0UJWWak7rSBWYNajtWtrZJLhCu2GhenQL8rWdyvuORXRXLwfEf3A56RgCcjZfhNHefU+6BiiRAJJ/u2ryig/kRbFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXMju8nv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516d6e23253so5512551e87.1;
        Tue, 16 Apr 2024 15:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307532; x=1713912332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DAM7ahXd7SQRtOs2FSyPEW9HzmQhg/l7bpOIUxyW00=;
        b=nXMju8nvP9J64lhP8buQVxW6qqr8zZK0pPZsjET2tWHy75Ap4tnRlgPJZAeQv/POXn
         vzLbJGPbMcQTBMd/bU0qDbVk+mu6DezLS0vXIWEUfOhrTnuFlRCx2dHfC9LPCGiz0saE
         uDRLPeeEbQFPqklzmPRNf9e6Mo02JAWPeu1MZ5JxqWyK++R8HATHO5OifRFVN4KMMbmo
         vJoQsiQlU7e/d8a9pCjIFZCd/z9jsq60h/RpHbxgmlrSTfq3d26aVXMYlKxglb5ZE4Ri
         Cllw4bMTjdO8RQgMrqikyqcSNHSHasuz681AvxZSaqV4tyPVjiirvptpoZpKuNkeD/4B
         zRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307532; x=1713912332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DAM7ahXd7SQRtOs2FSyPEW9HzmQhg/l7bpOIUxyW00=;
        b=aLJCYVT+iHRTmtj9xcn87gH+QfNF6s6BW7XgYWmFkjP2dMzq22+IlVU86Pr0EmLvQ7
         05Wil7BeNl956E6k8yfw3GRKASK/VfLkv6qvNB9cY0xBzi1662oxOEVgHVWIYL6OPqKh
         aSWKXF/cYdl1JdmRXIRIO/ID3AvgiXrmln9A8Q3gOamx5yurESqQ90XjHE1Y/J/WulPX
         YxVXxy+2X1Qlj3IxlYZcLQx0OhUHhUVsI95a2gWnNsKj1teKh99wDRzmtgzjTDXsZMTu
         NSLYosesU4PT8UfVnmmoTBTbPn+570IHaANcwPDgWR9v0Gx2ZQ6YHmocPiKxbFOi6hlO
         Gn0A==
X-Forwarded-Encrypted: i=1; AJvYcCXKbnotw+G7hI2l/JPzJfze1c1mrCUHE0XFwRRAcThUwwKIsTgDN08tYWnnkDU/Rqre3Y/Q2W1rxpUmpw7zOgXfvhFINUhDFvjLwEAn
X-Gm-Message-State: AOJu0YxMBgXWmtH4jr37TBgiK6Ab37j8vQJaty86x1g/b7u28m53OZLu
	1+KepEhFBIY+KLZPzyefb+QHvkGg3bfZ+Yjsd9NacPISmYFcw1bI0FaBkbplaSo=
X-Google-Smtp-Source: AGHT+IFX2Dt4ozv+xwfHUx898pIdk0gN72rg8VtZDXpTZLK+ddEd2acJQT/ZVoYsjvsoQXGlMlyeUA==
X-Received: by 2002:ac2:48b7:0:b0:518:6d35:e4cc with SMTP id u23-20020ac248b7000000b005186d35e4ccmr10336742lfg.25.1713307531804;
        Tue, 16 Apr 2024 15:45:31 -0700 (PDT)
Received: from localhost (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id n12-20020a19550c000000b00515d32e33a8sm1733241lfe.99.2024.04.16.15.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:45:31 -0700 (PDT)
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
Subject: [PATCH v5 02/16] media: i2c: ov4689: Sort register definitions by address
Date: Wed, 17 Apr 2024 01:45:10 +0300
Message-ID: <20240416224524.1511357-3-mike.rudenko@gmail.com>
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

Put register defininitions in the order of increasing register
address.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 9890189bcbd5..c4d4afd38906 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -19,15 +19,15 @@
 #include <media/v4l2-subdev.h>
 #include <media/v4l2-fwnode.h>
 
-#define CHIP_ID				0x004688
-#define OV4689_REG_CHIP_ID		0x300a
-
 #define OV4689_XVCLK_FREQ		24000000
 
 #define OV4689_REG_CTRL_MODE		0x0100
 #define OV4689_MODE_SW_STANDBY		0x0
 #define OV4689_MODE_STREAMING		BIT(0)
 
+#define OV4689_REG_CHIP_ID		0x300a
+#define CHIP_ID				0x004688
+
 #define OV4689_REG_EXPOSURE		0x3500
 #define OV4689_EXPOSURE_MIN		4
 #define OV4689_EXPOSURE_STEP		1
@@ -41,12 +41,12 @@
 #define OV4689_GAIN_STEP		1
 #define OV4689_GAIN_DEFAULT		0x80
 
+#define OV4689_REG_VTS			0x380e
+
 #define OV4689_REG_TEST_PATTERN		0x5040
 #define OV4689_TEST_PATTERN_ENABLE	0x80
 #define OV4689_TEST_PATTERN_DISABLE	0x0
 
-#define OV4689_REG_VTS			0x380e
-
 #define REG_NULL			0xFFFF
 
 #define OV4689_REG_VALUE_08BIT		1
-- 
2.44.0


