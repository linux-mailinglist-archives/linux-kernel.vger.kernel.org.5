Return-Path: <linux-kernel+bounces-87109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE2E86CFBE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652862859BA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5911770AE5;
	Thu, 29 Feb 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StaxK95a"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C6D6CBED;
	Thu, 29 Feb 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225634; cv=none; b=Nho3mHW6v8x8rX7xuZ6JpySxyxUu0LgbGb1EfSpBdm1ShzQV1kWO9gb1No3zqaYmmjJXHRnsEhK8UQWXbS0Meo9TF/9399XUk5XMLrWHslpY7MdFkqKJlZcn8XKLxMqEtmZeMwyu3iHR6NbCVfVW7h9UdTyvyP47Y907hO4Yjoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225634; c=relaxed/simple;
	bh=j606ZlD8gl05cV2S9Sv71dKFd6GOqrmr3w9wbDSb3Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pn2uwRcnT+K4/vqCX/nuqnQnu9CPbwFEbYAx6IIAKtf3LzFP/O7BLaFVPGVGk5/mGvIrwwNdgTvM28R9Zvi06Xd8GKXlLMWS/RRCydi0DKydojhLIwoiz+tZ9CKeyGWvJhdjQxD2fK546XpJhNwwRpdZVP+/yzW/x1OHBJWFXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StaxK95a; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5132181d54bso1252677e87.3;
        Thu, 29 Feb 2024 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225630; x=1709830430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5ZvgJwue3pMCGuTCyOPC8+J9NNnO47EiCt5EDIclk4=;
        b=StaxK95a9gy9AnUdHRO10ggwCGVEf2lWTF72SU2ZCYl9Bg0WjlXv5Wt3sE98j6gVTh
         17C2COwTdcBpnIUaSdniAOx6oPgQj/mEVrI7s6GZeQk/++NdAgrkPNCKoCtCMiwbrzl8
         bqEi9xy4VGFsQzV/IumY+gpzXzuHWf9i7yqw3cfLzZJ1hBtYhLSqKXWRL9kzvq2b4xm4
         CINpaMT25i7bdLic/7PF7twzquv7NTFwXGbliiSB3y3qf3mChQhPGrywHT/d6iryWzwa
         lje9hmBbaoADkRw/Qk0BFT7SGrP2L2o4Kx0JC7wOzsI/UlIHJM/t7A5TY6xgmU8LzgT3
         Rv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225631; x=1709830431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5ZvgJwue3pMCGuTCyOPC8+J9NNnO47EiCt5EDIclk4=;
        b=C4IhcOFbJtff+Pj22ptoy7OOpYATo1REBPHs3N52PsLG/MTe9BRwT2NPFNON/eNV2n
         nIOUWTafwHwJoiPfWLxqNXBD28i4HaHKB0q7XgYlnRZvBxKlpl5tI62zShwWV11gJZsZ
         PJWKorcRIvOExrjdrbeVnElMLwrFwtFz4KIc/d/bd2Zb2Yo9ukG1A1lDKrWTMU2cETZj
         fS7Jk5L5TSEdrF2KlKQTWNvjT9xSMKMmath/Xg/KzUuudjuWPVVOcBu0rwTfyZr98QbU
         4TsbFrukspmxTbgBntVzjW9zsNwjwb/2rhi5iCtwSkW9K9FR/wXQN7V1Ccf7uIT+jqRk
         M5OA==
X-Forwarded-Encrypted: i=1; AJvYcCUMnBYQwnyBYN1eQqbnuZdqF/5eCiNJY4NyYWsWPUZlTy4KgXLFVIGVfd/6WiZIDXYADW43Qz1I/VkwpHFtj7vFnizXtk4XiNhMWS2j
X-Gm-Message-State: AOJu0Ywjgh7ecim/q4nFu9KO6+/57Exfo/GxvlaQGYeVWiQixc4insx3
	UJxALc5vZ7uGUMVmprSm9oJEfyLpvRh/YwkvFhm9fGB4+i2Cq0OOeci3pH1D8js=
X-Google-Smtp-Source: AGHT+IFFopAHgABNiCnnmrTCDHTh1+/5AFtlUuuSwlj/1f+1Xupf4e2mMvy74apZVcCeHoLHYjf62w==
X-Received: by 2002:a05:6512:3049:b0:512:fccc:f289 with SMTP id b9-20020a056512304900b00512fcccf289mr2202630lfb.6.1709225630635;
        Thu, 29 Feb 2024 08:53:50 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id m20-20020a195214000000b0051322d314e9sm305373lfb.137.2024.02.29.08.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:53:50 -0800 (PST)
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
Subject: [PATCH v3 03/20] media: i2c: ov4689: Fix typo in a comment
Date: Thu, 29 Feb 2024 19:53:16 +0300
Message-ID: <20240229165333.227484-4-mike.rudenko@gmail.com>
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

Fix a spelling error in a comment.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index a6c101044eb3..f2614a0b1340 100644
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


