Return-Path: <linux-kernel+bounces-129401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE9896A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7415AB2B20E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A808D7F7FF;
	Wed,  3 Apr 2024 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vfz1xBHk"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6B77F48F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135492; cv=none; b=k27o2SQSZWaGbMHVsfqMDAfbsvge9KvU9xq1siFeQOF5oBW/EKu6B+uXG1v5JVTwFCOSOQOIgXYRnOvlOYTKSmgPqRzAIMrdX3t6SXmAFNAgFkI4MUuaX9vXe9A875LLvoC7QrWQErCKso+jPMKONh3037grCLJ5xePtDWXtxZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135492; c=relaxed/simple;
	bh=cCQQDgLrW72Veyqz+hhDHWkB/JGA5IkQ8Ht8vMOBfMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j4pSblW+RBlXuLdE0qDfuRx7roK7f4Wf5pdyNuHPFtuMmE4RXQM7bCnRo5XbNLZBYTr6aCvqlXk3EugWA+T9JlScVY7OUSkibW1iUzcoNfGB5qUawYJzd2+U3eHjy21bS+XD+Dh7GydYUPbGn6gf/If4Hy0GnLxtAaL8F/eygqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vfz1xBHk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0f0398553so54669245ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 02:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712135490; x=1712740290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQqEHjYdisnUD2snQA56jk2b7liMK6zBTYwXTs6Sj2M=;
        b=vfz1xBHkPqBzS99B3WDYlNQdlAugSstm9OIgdCDi7G5moCweMnbfgwsor6akoNAvhc
         Q4YvLj8eK5hJ3fGh1+i3Dy0cGay3/dB5EpbtMHlx87qZ6grEDmRH/6XQOeCR8L37/iUw
         +vCedcHrLDaT5BnqCRBbClBbb8lJbdhiZmuuCATWutyKk59UduEq3g6CxTMkRaqmP+kJ
         eCYyiBIxrAnEDMzowkRbGThwM2y4vk2aPzch7JqPwg1p4v7GS4evICdgXtyUd7NfnQYB
         B0ErcckSizS7KHyu8Yyui/MUvZHfFT8jmwIfn8Mew29MAggKxaJb4W5mHO3F9Uc3XmHV
         4e/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712135490; x=1712740290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQqEHjYdisnUD2snQA56jk2b7liMK6zBTYwXTs6Sj2M=;
        b=K54pBoTjRKXn+8jPLC3hFvBOGrVpQhaZJYWqhR8KJ9RCH2d9jy/2JKMG9NwjZ1d6f4
         0mMq3srrkZc6hgoMtizpHg1ifD50W3l3FartH1jG6tDRWT+vMZTD7/iUax9xG5zknewt
         rxhtSSbRKqCbZnwgijv6uNK4VFzfpm8AAzbWOFY1cQ+wDsSCnfBAhONzCr69iLda3kj8
         04HwIkngOeq3cYDv14ykYFeo4oXWGAQ7d0BJk5ZJm4+uaLDa+mq86KKxeqI8AdBKXLhS
         Lv1souVMOU7t1pM96WTTXbVM4R6LSsfpmAWUIesf6SSX7NBbbB/v9FKwTNajq62TPRDO
         Dv6g==
X-Forwarded-Encrypted: i=1; AJvYcCWi+3upF5OBC3koAJRHDCpTtZeoaSZv9mmRPB1GMJus/CyuPDFIbw0F887h/OvTcnXIrGnI02Lk6vVlBnpx9mCmfUCkL2gkubXRB5CF
X-Gm-Message-State: AOJu0YxPRVfK2lOXclmktNoJnbkqulJ6zKb2zzIwCq12bZYJWfnayu0l
	j0zk1Uu0M8nnhj6i8HMEia+tDHInspT+WH4BId7pKI3CKOMMhpdlydqB3UH7fxQEKMq4Q4lJIo2
	mjlfBDQ==
X-Google-Smtp-Source: AGHT+IGoKCZcGfq8O6r5TZMV+3488gW9BqB93GhZMP+8qde52gj2tgoCMbgU1QhQAK5AgXTygCwvkA==
X-Received: by 2002:a17:902:ea0b:b0:1e0:b287:c1d8 with SMTP id s11-20020a170902ea0b00b001e0b287c1d8mr18367183plg.5.1712135489852;
        Wed, 03 Apr 2024 02:11:29 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.66])
        by smtp.gmail.com with ESMTPSA id lo14-20020a170903434e00b001e0aded0ca7sm12688087plb.239.2024.04.03.02.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 02:11:29 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 03 Apr 2024 17:10:59 +0800
Subject: [PATCH v3 3/6] drm/msm/dsi: set VIDEO_COMPRESSION_MODE_CTRL_WC
 (fix video mode DSC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-msm-drm-dsc-dsi-video-upstream-v1-3-db5036443545@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712135460; l=1680;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=3j8eHIegp4Va/VwA/6lBtYTg4B03+RKnNiDyMKiJ2vk=;
 b=KYx0Ix2CdVVcXMEVCmbw5LBcbUcSc2xtRS6uG1UPryAnL/gyF8kCDnP4OTQ0zJLN/6LZPkyCK
 qarGJC8xk8BDG+YYUxsw3+ChRenief6Vx+FotV/IsSCYwbmF6Znv3ai
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

From: Jonathan Marek <jonathan@marek.ca>

Video mode DSC won't work if this field is not set correctly. Set it to fix
video mode DSC (for slice_per_pkt==1 cases at least).

Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 2a0422cad6de..80ea4f1d8274 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -858,6 +858,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	u32 slice_per_intf, total_bytes_per_intf;
 	u32 pkt_per_line;
 	u32 eol_byte_num;
+	u32 bytes_per_pkt;
 
 	/* first calculate dsc parameters and then program
 	 * compress mode registers
@@ -865,6 +866,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	slice_per_intf = msm_dsc_get_slices_per_intf(dsc, hdisplay);
 
 	total_bytes_per_intf = dsc->slice_chunk_size * slice_per_intf;
+	bytes_per_pkt = dsc->slice_chunk_size; /* * slice_per_pkt; */
 
 	eol_byte_num = total_bytes_per_intf % 3;
 
@@ -902,6 +904,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 		dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL, reg_ctrl);
 		dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2, reg_ctrl2);
 	} else {
+		reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_WC(bytes_per_pkt);
 		dsi_write(msm_host, REG_DSI_VIDEO_COMPRESSION_MODE_CTRL, reg);
 	}
 }

-- 
2.34.1


