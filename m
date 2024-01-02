Return-Path: <linux-kernel+bounces-14778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559A1822213
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F752846D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5DE16422;
	Tue,  2 Jan 2024 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmXQ5TsW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CF516413;
	Tue,  2 Jan 2024 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3f8af8297so34447305ad.2;
        Tue, 02 Jan 2024 11:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704224033; x=1704828833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=luPtVbWA4WkeKb/ML1jEiRoj2bd2p8W6YJcqHctkuXs=;
        b=BmXQ5TsWx1kJbhQHVWvMQ8aDyNwWx38soRIDLmNJRh58nxx/7Sc7jWXmHGXMr7dZna
         kQZ9B/X9uYp7Vw39iLQe+2FZ5LiCrjqAolMohhXxOBlXx1NWwjxNe7pgcnPZLW7Ho7wx
         TJNLRCHO7PDzmMMvTHT7ERTmrCISZoKW3oEJQjxnAsafJ5OsbpvLUDTqmQqoXccsx4HE
         mzV2/jw6KHeBs4S8s+g1MubDx7CkfrXtGK+hD2jfbL9pm/+J3g+im16OSu4be4st0wko
         M2GxaHP7sbuk/fk10yJgs0/szP5g+PjA1dZ84RwMztOax/KoqzJ4xkBWpO1acSm4YtPw
         iNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704224033; x=1704828833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luPtVbWA4WkeKb/ML1jEiRoj2bd2p8W6YJcqHctkuXs=;
        b=F5A8smEvwHo2PVqSVp26XdhBARMdF7rZDq5hN07tMF4YDB2f3Q1ZIwkq3Wdi5bU18G
         +YtXURSVT6OE+EXCnVjooIq1T/Zc4HYnfs6YzCvQf33Wtp+6bMZ+WE1THL1886qX+7K+
         mHvh0Es+pLI4AP1eo/Ks4GJ2cwi/Uv/3hlX6qEkfOltwPC/qfZ5aO22uz3ZzzT9Ho2ku
         /GEsaOZF21eZSoN8YPG82vquqtWAFgn9umyYJ0EJBIRJikAi9LEIHSYHDBENXdJ+MiSh
         9KOeZNCIDB//GWHWKV6mTja8OCr1Pse2S1ea5DMf/jWYXnVb8D7pxb/6jvj2Ebu8tOsq
         mzbg==
X-Gm-Message-State: AOJu0YzCtlvo30IqDstobudc+C/GZeMdrHUM4leIGjD1S+vUxH2GcNLI
	yV6g6up57LRgQP7ZIhhTv2g=
X-Google-Smtp-Source: AGHT+IFhwzQzpZlwnGPVfu0XEYA8BSoSkhH6CurSOcH7BLHojR2bA2a6+ZxoT09Eb80mmHaTQ/2xXQ==
X-Received: by 2002:a17:902:daca:b0:1d4:3797:f829 with SMTP id q10-20020a170902daca00b001d43797f829mr8680675plx.5.1704224032869;
        Tue, 02 Jan 2024 11:33:52 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b001d3563c87a6sm22863074pln.281.2024.01.02.11.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 11:33:52 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Akhil P Oommen <quic_akhilpo@quicinc.com>,
	Danylo Piliaiev <dpiliaiev@igalia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a7xx: Fix LLC typo
Date: Tue,  2 Jan 2024 11:33:45 -0800
Message-ID: <20240102193348.250917-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

We'd miss actually activating LLC.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a5660d63535b..54dc5eb37f70 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1646,7 +1646,7 @@ static int a6xx_gmu_pm_resume(struct msm_gpu *gpu)
 
 	msm_devfreq_resume(gpu);
 
-	adreno_is_a7xx(adreno_gpu) ? a7xx_llc_activate : a6xx_llc_activate(a6xx_gpu);
+	adreno_is_a7xx(adreno_gpu) ? a7xx_llc_activate(a6xx_gpu) : a6xx_llc_activate(a6xx_gpu);
 
 	return ret;
 }
-- 
2.43.0


