Return-Path: <linux-kernel+bounces-118733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4F688BEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFD41F3EAC4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456CE58139;
	Tue, 26 Mar 2024 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5DokoNF"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED39C535CF;
	Tue, 26 Mar 2024 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447344; cv=none; b=OD0fvaScK5g33rj41oYd/YYEvlbms97ez5cn1dptdGcIcA6pgJ10RTjYRw0rTtrMY6lD/4VInR/h+wXFrOwnBCVe4YORAIwQUqGCmqwGSkGRr4U+R1K3Ms34j7eDT5C27aNrblqkZcLg0SVgWHlrE2/nIgjVBlvj5+wZ9lj1oP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447344; c=relaxed/simple;
	bh=paSe/HuDKXIeylvXPujrMLvc1Uk9K9OYT2dFpkHmeUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=j6CXO5qaGUOWNaqNDud9vESd9XLISB3AXrt5gQ1RmAIH2Wi0F8EyLMhDEl8svqHhpTM8npasWXIpLPbaOKKuqGIwFe7Sji2nODpVl4gSrNOF0vXWFdkRyxNMKg4DCiRu/7PWOAw2iMYWtc1ClZzaP789W0l2YIk96g4qkLqzM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5DokoNF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4148f497a2fso2277435e9.1;
        Tue, 26 Mar 2024 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711447341; x=1712052141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rH2uk+dUlYoWneISw+2iSY12AXnUflXf4kTlEdX1VEg=;
        b=f5DokoNFRn03+mgBZ+1qy30eJ4dKkQcLxF8kldgbBjqQLywUStEHaZaiDdDtld3Ddf
         D8xtw0ENFyc/5RAe1iKQ2zknwFrnJ7QKRGRZKorXpoC2BesVMuJux5NpnC5o6ycEGnYZ
         smL7JPmSD5++CTZVO9qnhGSRUllfEd0wlcrhKRcWrxk3dMfIu6qM4ZHrSQUp5rfvI4uj
         YH+PmdGXzAv9UXk0a4CCHGv9iBSSedZDRP9ebT2FH2+zr+AcTGbjKwKdW3me1Knnmdob
         TgnXeI7yVWDOKeBaZ+k7VUobOsWwTIw0h3pY9Ov1phCUJp+fnaPBDP+wxvGLKBMIkAwx
         YSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447341; x=1712052141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rH2uk+dUlYoWneISw+2iSY12AXnUflXf4kTlEdX1VEg=;
        b=D9ER4pGqiHTB2RKhSWToh9RRfzYuypkGWExL7WUppOsqKmDCCWHkxK5bx7CCvU7UtQ
         Yu6Y/U9RosxhAqDCW32CAjiFoDu0Xu3dXifReVILnfLxgroQ4N20qjjHamLhE8wWYtep
         n9+RYrXnS7JfTEhPUbHyhKNoYYYanJoYEOWQ0xD63NojZftaanzeF3peXg0BPfshTl0B
         pQlKIDsZ6jTgidrwgzPRaJM4Fe0iqlqbbwfFDzjpUepvpogPTq1z5B4LKqNePjV+dIp9
         /IagO/cXp4wSUm4Im7EZaeHPN8C5V1H1vFI+zivh44kN81lEN2xgQHc3SvPktTcL77uT
         wYUA==
X-Forwarded-Encrypted: i=1; AJvYcCWxRlmnmT5PIcPwZ9XdspnNRmXOqHZw1IrhLN4CVUSV/iiDib/CLW6ItZS8XG6IrSDhXvcbV/WYLXZXkxXJYjleFnWmfrZy7oQ+hV2v
X-Gm-Message-State: AOJu0YzS1VlzX+jv261AN1D7e3s0wr26fqr83YsEy77lQGW5aBg3MO/d
	hPOImwFGva01nBQvdcefe0nwhP8t5yK2Vc9sJlgFnzk+GgtjymZ3
X-Google-Smtp-Source: AGHT+IEDcklL7s7XSdqdxsiiNhhq5CFW4ZA+MM5Ng7WIZ+LPtv63W2DfF8RCMPyeUgecR29BiFct+g==
X-Received: by 2002:a05:600c:5120:b0:414:65cb:7e99 with SMTP id o32-20020a05600c512000b0041465cb7e99mr1564905wms.26.1711447341002;
        Tue, 26 Mar 2024 03:02:21 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c45c800b0041487f70d9fsm7531688wmo.21.2024.03.26.03.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:02:20 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/panthor: Fix spelling mistake "readyness" -> "readiness"
Date: Tue, 26 Mar 2024 10:02:19 +0000
Message-Id: <20240326100219.43989-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a drm_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 6dbbc4cfbe7e..0f7c962440d3 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -333,7 +333,7 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
 						 val, (mask32 & val) == mask32,
 						 100, timeout_us);
 		if (ret) {
-			drm_err(&ptdev->base, "timeout waiting on %s:%llx readyness",
+			drm_err(&ptdev->base, "timeout waiting on %s:%llx readiness",
 				blk_name, mask);
 			return ret;
 		}
-- 
2.39.2


