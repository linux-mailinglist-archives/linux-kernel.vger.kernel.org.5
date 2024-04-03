Return-Path: <linux-kernel+bounces-129402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2371896A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7293D28E4E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F1D8062A;
	Wed,  3 Apr 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ckzVL5RH"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D856FE1D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135499; cv=none; b=g5h93vFZ/+1z9mJJHm7TaJB9gsZ545gqreVbylhZ5axjyraT1+sFBWv7JHyJ9lWL1ZGHXhzf8vJKRQYHyO8l3t4cFUvU321UM6zHsCsLIfXGwXpiK/xDkVgn0hb2GKOqLEBvtgWH/AwifKWCQ/2KL1ap+Pu4cg+tVhLSuX6Xo5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135499; c=relaxed/simple;
	bh=dA9w5cYqVEFj/cyAADWyuxfZfHcRIjXDTZ5b4w0V9fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UIw1M8FrEHyJm8j8RxLklSN1VNEqauiHsFkXg5PlcKKbnLzsp5jE+0HS4wFLde/zA5iP4ZvHTqIsaemAjIOptlWeANA4XtZyy90lROQvMf0THX5h4u36CsqKqMTteVBfZB5uffe3I1C4ZXKxuJuDc5SGa9CU5m7jXmfG7Sn032g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ckzVL5RH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0d82d441bso55086045ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712135496; x=1712740296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hWxdEOmU4e6legIFUkyIF7zkRnOsSH8ACzlOjPdkh8=;
        b=ckzVL5RHpjOxGuQj1Ai93bcL7r6h+YFNegavq2gxk7p3i5qsenL64AqEC8F9ESD7ei
         3IvVJ7/Ik4mOwjrt/KTrL0ns2QWAJ2CWe2lC2I0EJID79MrOi+A/g0pSsXJZVq97CqLp
         50URucood7St101amjJe2LES2VlfPEUloNdswuTNY0BPbdaCY0zYM5S4dyELctQYSrip
         ubFoDQM/1XSSzx7QB0SnHuBPKTlH3yv21ktDz/QFruCPQs1qMV5h6shzPVvmzuU7W/UL
         HPx7TY4YfvDg91K1aV4zsjx45q7NBNnX2V1flf5dcWq60o5oCeQL2Ze7j5iHMyGSp2v6
         ryug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712135496; x=1712740296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hWxdEOmU4e6legIFUkyIF7zkRnOsSH8ACzlOjPdkh8=;
        b=jMCtsgUsq5wv5+3pMQeqauBvruxNLBLkG1J/uBaQCn1XRIM2rnerfGLJLaEMmQi/CU
         xNzCxDJIgyhutCbmdvbcOzXJAdC4lfhBGGjWj0jnKBm20hH0yO0yvJri9L6Z01YxWbWb
         t4MKNzgCKiOQq+1kDy2Zx+CuATiXazabQqvipZ7uFFJuuMVul06ozDO7XYmXtLHm0L1V
         pvK7KxLBa78xn+miYkPJidmPelKlw29NN0gJV5ZXeYx5gyANRYnyQZwugIuC9v/QVv5G
         26P/BOrD5WcaeeUvGaSXON+mUqFoBAzXNvJ18lwjfzqSM5OHWucdPEhLus6wsscYQ5aK
         5UwA==
X-Forwarded-Encrypted: i=1; AJvYcCWFQC3LWrfucJzmPVJCyEDmTcb6ZRgfETtj0ecrrVWGds8G+ny/Tm6ZRnE1KKQFuKUpO4N7GKsNZsY07ye9BeRFgllnJPI47jiZyDrR
X-Gm-Message-State: AOJu0YxWtnHZYN5ba1VIaB9TyZrbkUHfUbahzIHDZ3v5OZSKQBNpImxm
	Kyed9txi8HDCLU/SqT25nHRw6Mh7PwkN6ktUEMGBgHxWUuW+QXx0dZLkmyDhC8Nbytf0fHvcxLA
	dLz5WAg==
X-Google-Smtp-Source: AGHT+IEyWqFwLOjN3DoRlpo+4Cc/2ygcGvENqA9aW1FSgOsYovoVqqyZlsMxzOzAo8DY7Gr1mb6hXA==
X-Received: by 2002:a17:902:ba89:b0:1e0:1bb2:b38f with SMTP id k9-20020a170902ba8900b001e01bb2b38fmr1861834pls.59.1712135496335;
        Wed, 03 Apr 2024 02:11:36 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.66])
        by smtp.gmail.com with ESMTPSA id lo14-20020a170903434e00b001e0aded0ca7sm12688087plb.239.2024.04.03.02.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 02:11:35 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 03 Apr 2024 17:11:00 +0800
Subject: [PATCH v3 4/6] drm/msm/dsi: add a comment to explain pkt_per_line
 encoding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-msm-drm-dsc-dsi-video-upstream-v1-4-db5036443545@linaro.org>
References: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
In-Reply-To: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>, Jonathan Marek <jonathan@marek.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712135460; l=1185;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=Px8G3VT/pPMatEDJd8W5yLoDD+nxWLUBSZSRl+j+Bac=;
 b=GouXgYabwVWTVj3bHeksyAclYhr+CiBGfhejkhmQ72YqrJmdWZDRL9rczqXKkqVvK6U3n59oc
 Jop7S7F3ONhAPe9XAtU0TkJ5J1p3pJJ6BIpzfOAN3HGhKpSG0lzgNdq
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

From: Jonathan Marek <jonathan@marek.ca>

Make it clear why the pkt_per_line value is being "divided by 2".

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 80ea4f1d8274..b0507a42ee6a 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -886,7 +886,11 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	/* DSI_VIDEO_COMPRESSION_MODE & DSI_COMMAND_COMPRESSION_MODE
 	 * registers have similar offsets, so for below common code use
 	 * DSI_VIDEO_COMPRESSION_MODE_XXXX for setting bits
+	 *
+	 * pkt_per_line is log2 encoded, >>1 works for supported values (1,2,4)
 	 */
+	if (pkt_per_line > 4)
+		drm_warn(msm_host->dev, "pkt_per_line too big");
 	reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE(pkt_per_line >> 1);
 	reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM(eol_byte_num);
 	reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_EN;

-- 
2.34.1


