Return-Path: <linux-kernel+bounces-8784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0407381BC2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E61289C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D205D58213;
	Thu, 21 Dec 2023 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOoqmBbB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D2336084;
	Thu, 21 Dec 2023 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3368ae75082so438168f8f.1;
        Thu, 21 Dec 2023 08:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703176799; x=1703781599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qQwY6XnPHId/GQPAHNHHHDHjZjYcdu/ELu7dEzkGITM=;
        b=SOoqmBbBl4CWhJQVWc3ooc/P3Bgw0HBpDU+OVaktRV+6UUY1FAv7fKQ/QdDSSoJIFD
         t7N/BiOa1ZMdgDwUFjzv+rgHFJHZC2Dth0A6fAbfF76f+b2gwoTTxWnhtKJzapKvNIzP
         9ARS1qE44KiV0cfgYsSptkIOm7m1qLannxeOQGzRGPPkcUdUgESUJxP016th+4TfQF3/
         YfgicpIt7yHLT0p6qZBEHF40k0qc8GxAYprLn+IVz9WtY1h/kvgfEal2vbZIgO/+EMaQ
         IvpSHpVQQxdDgwE0spwE8X8x9TfTYisL+NXWMakeAlBU15H7C9THKudaSoXf5mQpSlup
         t+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703176799; x=1703781599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQwY6XnPHId/GQPAHNHHHDHjZjYcdu/ELu7dEzkGITM=;
        b=TEVV5zvMvmK50NKw1dgBz4lOHdUtOp8eVUTF2kbYTlquN3R65sWuzn4+30E+Ejp2Om
         LDLEcjy7BEQt6UmOh88s/qnRLhEFZPul0MXzRYFlCN5XQN34h4ysJPYtIJliTEqQN3R8
         e2lHwmdflUEU3nnc9iDT+4V7lu4+iLBOZ3XYGWxbVLauOZDrpPLQkMLU0RoLE/SzGQN1
         xihdzCgkp34DAMaVL1fI34GUItwTusTmuklmgr9IK11hwBvPmgV0KMBdZT5FKy7Qf3Tv
         pKPQ4lecOGnnhfEdmZK0rEWzuulnSyydExetXVOvFOr+ldA2LvaKw7ktqBWR1KdU2pvS
         Hbhg==
X-Gm-Message-State: AOJu0YxFJNNXzsPuI4OaOLwQ4GMzYYKqvU+5ndG94rEXHdcgm+G71wBA
	gZ92aKiThZmsOAL3aapJikjIKKY9GAM=
X-Google-Smtp-Source: AGHT+IE5+MF6rh1Jp/X8nhABVaLFMXHWskbRuKk0vikfXmBaV5XdNxg1TED5H+t/Vw2BreVJ7HyxpA==
X-Received: by 2002:a05:600c:a49:b0:40c:3db4:70f2 with SMTP id c9-20020a05600c0a4900b0040c3db470f2mr732544wmq.142.1703176798709;
        Thu, 21 Dec 2023 08:39:58 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c359600b0040d2524270asm3937020wmq.8.2023.12.21.08.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:39:58 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>,
	Martin Hecht <martin.hecht@avnet.eu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] media: v4l2-subdev: Fix spelling mistake "heigth" -> "height"
Date: Thu, 21 Dec 2023 16:39:57 +0000
Message-Id: <20231221163957.165030-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/i2c/alvium-csi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index 34ff7fad3877..389dac50fee9 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1472,7 +1472,7 @@ static int alvium_get_hw_features_params(struct alvium_dev *alvium)
 
 	ret = alvium_get_img_height_params(alvium);
 	if (ret) {
-		dev_err(dev, "Fail to read img heigth regs\n");
+		dev_err(dev, "Fail to read img height regs\n");
 		return ret;
 	}
 
-- 
2.39.2


