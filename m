Return-Path: <linux-kernel+bounces-5445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5A8818AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828481C24419
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D741C2A5;
	Tue, 19 Dec 2023 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBCf1sbk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395091C6AD;
	Tue, 19 Dec 2023 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c6736d10fso58713095e9.1;
        Tue, 19 Dec 2023 07:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702998200; x=1703603000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+2uydkqP7/GP5xpG18IqG/AnXLR2V5zI/Eof83ojXM=;
        b=MBCf1sbkBdX7Cm6+sehy+PjH1tsSNW7TCWj0FXNGHDulHfD3N7D3d+etVCZGLaC8rA
         Nz9Y5NXsPuR+M34kXn7MlDd7FKzfEQVfeAlqt8nSpi6TOdSJuupIj5TGgI7m10syub7H
         WVjzJSLeMxatBaHamiJ4U7NXcmTw/TDJP8kFUGT0qqdtfN7sH54Zchp6VWcafkCG3hpa
         /pZPwWFUJHi9CgAOs5UeuxZrIxJoOnlfQ598TAeIRuE3/Kzh7vzJkcYMM6GXrxG3y/1Q
         Dnae50bARAh+XGDwHlzLOpAg/rj3/peeShpt6tGcRAvDSE5hfoSSxqSsNVwi+2drYYbk
         7NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702998200; x=1703603000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+2uydkqP7/GP5xpG18IqG/AnXLR2V5zI/Eof83ojXM=;
        b=R6ieSdoqRnO97mwNIHBbEFq5elffTofPQifxhITKPGA0LBXYhZvf2fZLCV+1vJxgGl
         HuWakuOnJ9LRWTtmNSNRi4GuRguyRLAtSXWnIY0k2LMZE9Pv3dFfKSGQk7tQwZc7Dcmk
         JFcVjvwdtHNQgK2XsrXkEGcSCXjv3wagp3U5hfTLY+arXxHsPrrv+YO4crnOCR29HPUd
         X7aM/2+TmYwE4Iwd2f8/EVR6E/7YDLEpl0XZ/U7UkUJhEDv05DY1QctCqrr5T+5jt+Qj
         OQbLy4LUvIOfIc1GTistx8GShDfThrXJpbdB7yQNSImjS/henf5GPlh0pRN2GhF4zD6H
         v4rw==
X-Gm-Message-State: AOJu0Yy3VbPXEcXNfCFbog+yllLGzk8ZcjF9o2m4hik5tSSqvhhkDs1E
	cZwNvFEpj9xqA/1tnL+Bto0=
X-Google-Smtp-Source: AGHT+IGxnNsXzTz9OUKp2xip5KTPq0mzABVaftCPhQeLID8u1htUaLAIfs8yDDd4UNZQPtmE2nIdMQ==
X-Received: by 2002:a05:600c:46c6:b0:40c:2ba6:809 with SMTP id q6-20020a05600c46c600b0040c2ba60809mr10002784wmo.157.1702998200183;
        Tue, 19 Dec 2023 07:03:20 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b0040b45282f88sm3190226wmq.36.2023.12.19.07.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 07:03:19 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ben Skeggs <bskeggs@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/therm: remove redundant duty == target check
Date: Tue, 19 Dec 2023 15:03:18 +0000
Message-Id: <20231219150318.368398-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The check for duty == target is always false because it is in an if block
where duty != target. A previous change added the duty != target check
and so the check duty == target check is now redundant and can be removed.
Cleans up a cppcheck warning:

drivers/gpu/drm/nouveau/nvkm/subdev/therm/fan.c:93:17: warning: Opposite
inner 'if' condition leads to a dead code block. [oppositeInnerCondition]

Fixes: e4311ee51d1e ("drm/nouveau/therm: remove ineffective workarounds for alarm bugs")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/fan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fan.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fan.c
index f8fa43c8a7d2..c4aaf7473065 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fan.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fan.c
@@ -90,8 +90,6 @@ nvkm_fan_update(struct nvkm_fan *fan, bool immediate, int target)
 
 		if (duty > target)
 			delay = slow_down_period;
-		else if (duty == target)
-			delay = min(bump_period, slow_down_period) ;
 		else
 			delay = bump_period;
 
-- 
2.39.2


