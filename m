Return-Path: <linux-kernel+bounces-152121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCD18AB972
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7E41C20AE0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662AD17584;
	Sat, 20 Apr 2024 04:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qyzDHv4Z"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289C5D529
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 04:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713585683; cv=none; b=l7ODsqjY4ZU4dezuva9viaG+LgOzVSv8Fj1mnlcLmF48Q5KUmBepsOjar35aEqu7wbcVG5Xs1xHElCK5toUhD9y28w553MaltVgX1TfResEvISyYK9tlEmRnaVw7V6To7r/EuPzLBMCzt2M6uc65qbzd3MJLPZmnT0NEpfuaBS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713585683; c=relaxed/simple;
	bh=xqaqEfOaXrzm0qh8jMjmh7qB545I7zB6szsBh+ORuJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qW6LTsHjBP27Sda+/JkS7qQMlccYi2dcxo6YxGjHqtlGVLKA1lV5L+9boPzwy9TaajwcVFHqgI0/KpCPxNtrb1C17ry8G0UO3WPi47S2UREuLK+dc6uK6V/7FLWV6gp2LgAoXLjSaz+9VxcJdieq7IJz0dp4kby37SjzRqKZqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qyzDHv4Z; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51967f75729so3169614e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713585679; x=1714190479; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlCR2/E8btYXcVN5ux6VZAFo+1MPQWKcOcJ/NXb0eoQ=;
        b=qyzDHv4ZWUn8tkXT5U54I7yrEhGu8nPe8yoe3oid0L+VdTfxlOm3x8b051vp6bJFgh
         qWYU93h0lTH26+QG2A9wJq5xetS0/NF0Z7Xpd7YSHqNMk66ZAv87gNl1JBLOGVDeOKHl
         B3cBRcXP/HGemzbXMC5YejA+A9Vhr7GC5+Os4kSldfyffZpBy3edz2KmS2rX73cjSZ5a
         he4buslywyoCTbgWMVNsPfPYJmfsBCgL49aKNR9jU3NEpvA8PLJvn+ER1PZTCozQCgkt
         ovc2q26oNLsQXWiYR0LeLPJU/cEioHCsYW9/EshE5XTGRnWG30ybpuCp2cFsd4de+OCA
         r0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713585679; x=1714190479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlCR2/E8btYXcVN5ux6VZAFo+1MPQWKcOcJ/NXb0eoQ=;
        b=S+hQPiV5QFWSBk21CzqIC6mm2F95SzSohkQh+UxRllYmkOjsD72M/S5niEFxthQLtB
         qNWIi8ay3yFxI1y8WnVkGmiPpSZ1jlKl1MHckkOy5DVs45MVScuBbxKOHU5lHQYBm5Ud
         yklP/upA4Y/4p0MILSF5ZQgoi1j+37tt/x7ytlorChwS6qy0AIQcoTjk33ezhOIpLdrB
         e+JwsIZyNLRxA4336NsD1ZWRDEKc2FRBx6KVcqdj1wYYD48lq1V2L/52ZrgFdjxZQCd9
         zp+HVtIy+D6eVHlWwCOrpDSDRPviHr2VNzoJzN3K0DFh6/fVLN7q9zrSUxcIUzd+wjuL
         oeng==
X-Forwarded-Encrypted: i=1; AJvYcCVrEuJoWH42TI6KEBP5QXcEJc6L55vtymq3TAx5C8V2UBFEsewuHBqDayIp/yGgtSHQ6qxexCWA/5fm+a6er56Tf9oBLrHtbdLsJVPW
X-Gm-Message-State: AOJu0YydN/VRXTrq3ttv0/G7V8+zOCIy5vjuefJAlLuboe98kvQ4WoM/
	g702KANj7d4bDkOoOAkSCWc5BE/uMR6Mm0qzwuElowTI/qh2IeuuQIt3lo5RH/I=
X-Google-Smtp-Source: AGHT+IEpnHexbT35jn1HanPCop9w7Xea09PPWd6ix8/T7A9gwooJRKp8zobZrcMvHtM6+E2mzAqovA==
X-Received: by 2002:a05:6512:3b88:b0:519:6953:2ffc with SMTP id g8-20020a0565123b8800b0051969532ffcmr2870356lfv.42.1713585679380;
        Fri, 19 Apr 2024 21:01:19 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id n2-20020a0565120ac200b00518c9ccef2esm1003993lfu.22.2024.04.19.21.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 21:01:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 20 Apr 2024 07:01:04 +0300
Subject: [PATCH v2 7/9] drm/msm: convert msm_format::unpack_align_msb to
 the flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-dpu-format-v2-7-9e93226cbffd@linaro.org>
References: <20240420-dpu-format-v2-0-9e93226cbffd@linaro.org>
In-Reply-To: <20240420-dpu-format-v2-0-9e93226cbffd@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8913;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=xqaqEfOaXrzm0qh8jMjmh7qB545I7zB6szsBh+ORuJc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmIz4JhH4dVZgtWEhN5C0adIfxXHR8f3DQj3CIg
 U5XJ9WN+a2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZiM+CQAKCRCLPIo+Aiko
 1Us+CACvz1UirPYuyhcyJFgzN0KnjuTJQ+G8OEfJLLeMkoGMfUKgpGdElvxy73tS1kEAq9ira8P
 k/SAWlvFlgiCs9scgjRSgaiAjl8llqZYmMaAS39PM1LW5PD9snvXAkFInPD3KO1p5COrKtJCHKZ
 jVuGuLOuN0jJAY48WLaBny1Hf4FDldwFm5qFTdcbcGUe3jtooXgxqBwlD9O91zUbKSXr5P1/BQs
 D6s+C5IeRmph2wIYyw90fQOTQTYi1jIQkzfqpv5UShby5j0/DtlCtozXdPY7N26QY/HsvSU8Vwq
 rKHfCfN6ChGH4B5Fc6QA9owWCnwKFf+cEPjh55IPH0DXrwxm
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Instead of having a u8 or bool field unpack_align_msb, convert it to the
flag, this save space in the tables and allows us to handle all booleans
in the same way.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c | 12 ++----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c   |  2 +-
 drivers/gpu/drm/msm/disp/mdp_format.h       |  4 ++--
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
index 705b91582b0f..2bb1584920c6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
@@ -43,7 +43,6 @@ bp, flg, fm, np)                                                          \
 	.bpc_r_cr = r,                                                    \
 	.bpc_a = a,                                                       \
 	.chroma_sample = CHROMA_FULL,                                     \
-	.unpack_align_msb = 0,                                            \
 	.unpack_count = uc,                                               \
 	.bpp = bp,                                                        \
 	.fetch_mode = fm,                                                 \
@@ -64,7 +63,6 @@ alpha, bp, flg, fm, np, th)                                               \
 	.bpc_r_cr = r,                                                    \
 	.bpc_a = a,                                                       \
 	.chroma_sample = CHROMA_FULL,                                     \
-	.unpack_align_msb = 0,                                            \
 	.unpack_count = uc,                                               \
 	.bpp = bp,                                                        \
 	.fetch_mode = fm,                                                 \
@@ -86,7 +84,6 @@ alpha, chroma, count, bp, flg, fm, np)                                    \
 	.bpc_r_cr = r,                                                    \
 	.bpc_a = a,                                                       \
 	.chroma_sample = chroma,                                          \
-	.unpack_align_msb = 0,                                            \
 	.unpack_count = count,                                            \
 	.bpp = bp,                                                        \
 	.fetch_mode = fm,                                                 \
@@ -106,7 +103,6 @@ alpha, chroma, count, bp, flg, fm, np)                                    \
 	.bpc_r_cr = r,                                                    \
 	.bpc_a = a,                                                       \
 	.chroma_sample = chroma,                                          \
-	.unpack_align_msb = 0,                                            \
 	.unpack_count = 2,                                                \
 	.bpp = 2,                                                         \
 	.fetch_mode = fm,                                                 \
@@ -127,7 +123,6 @@ flg, fm, np, th)                                                          \
 	.bpc_r_cr = r,                                                    \
 	.bpc_a = a,                                                       \
 	.chroma_sample = chroma,                                          \
-	.unpack_align_msb = 0,                                            \
 	.unpack_count = 2,                                                \
 	.bpp = 2,                                                         \
 	.fetch_mode = fm,                                                 \
@@ -147,11 +142,10 @@ flg, fm, np, th)                                                          \
 	.bpc_r_cr = r,                                                    \
 	.bpc_a = a,                                                       \
 	.chroma_sample = chroma,                                          \
-	.unpack_align_msb = 1,                                            \
 	.unpack_count = 2,                                                \
 	.bpp = 2,                                                         \
 	.fetch_mode = fm,                                                 \
-	.flags = flg,                                                     \
+	.flags = MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB | flg,                  \
 	.num_planes = np,                                                 \
 	.tile_height = DPU_TILE_HEIGHT_DEFAULT                            \
 }
@@ -168,11 +162,10 @@ flg, fm, np, th)                                                          \
 	.bpc_r_cr = r,                                                    \
 	.bpc_a = a,                                                       \
 	.chroma_sample = chroma,                                          \
-	.unpack_align_msb = 1,                                            \
 	.unpack_count = 2,                                                \
 	.bpp = 2,                                                         \
 	.fetch_mode = fm,                                                 \
-	.flags = flg,                                                     \
+	.flags = MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB | flg,                  \
 	.num_planes = np,                                                 \
 	.tile_height = th                                                 \
 }
@@ -190,7 +183,6 @@ flg, fm, np)                                                      \
 	.bpc_r_cr = r,                                                    \
 	.bpc_a = a,                                                       \
 	.chroma_sample = chroma,                                          \
-	.unpack_align_msb = 0,                                            \
 	.unpack_count = 1,                                                \
 	.bpp = bp,                                                        \
 	.fetch_mode = fm,                                                 \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index d411d70b8cd8..f4b4cd084282 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -264,7 +264,7 @@ static void dpu_hw_sspp_setup_format(struct dpu_sw_pipe *pipe,
 		(fmt->element[1] << 8) | (fmt->element[0] << 0);
 	src_format |= ((fmt->unpack_count - 1) << 12) |
 		((fmt->flags & MSM_FORMAT_FLAG_UNPACK_TIGHT ? 1 : 0) << 17) |
-		(fmt->unpack_align_msb << 18) |
+		((fmt->flags & MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB ? 1 : 0) << 18) |
 		((fmt->bpp - 1) << 9);
 
 	if (fmt->fetch_mode != MDP_FETCH_LINEAR) {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
index 19163634855f..93ff01c889b5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
@@ -97,7 +97,7 @@ static void dpu_hw_wb_setup_format(struct dpu_hw_wb *ctx,
 		(fmt->element[1] << 8)  |
 		(fmt->element[0] << 0);
 
-	dst_format |= (fmt->unpack_align_msb << 18) |
+	dst_format |= ((fmt->flags & MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB ? 1 : 0) << 18) |
 		((fmt->flags & MSM_FORMAT_FLAG_UNPACK_TIGHT ? 1 : 0) << 17) |
 		((fmt->unpack_count - 1) << 12) |
 		((fmt->bpp - 1) << 9);
diff --git a/drivers/gpu/drm/msm/disp/mdp_format.h b/drivers/gpu/drm/msm/disp/mdp_format.h
index 18b2822dd552..d17f63c045a7 100644
--- a/drivers/gpu/drm/msm/disp/mdp_format.h
+++ b/drivers/gpu/drm/msm/disp/mdp_format.h
@@ -15,12 +15,14 @@ enum msm_format_flags {
 	MSM_FORMAT_FLAG_DX_BIT,
 	MSM_FORMAT_FLAG_COMPRESSED_BIT,
 	MSM_FORMAT_FLAG_UNPACK_TIGHT_BIT,
+	MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB_BIT,
 };
 
 #define MSM_FORMAT_FLAG_YUV		BIT(MSM_FORMAT_FLAG_YUV_BIT)
 #define MSM_FORMAT_FLAG_DX		BIT(MSM_FORMAT_FLAG_DX_BIT)
 #define MSM_FORMAT_FLAG_COMPRESSED	BIT(MSM_FORMAT_FLAG_COMPRESSED_BIT)
 #define MSM_FORMAT_FLAG_UNPACK_TIGHT	BIT(MSM_FORMAT_FLAG_UNPACK_TIGHT_BIT)
+#define MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB BIT(MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB_BIT)
 
 /**
  * struct msm_format: defines the format configuration
@@ -29,7 +31,6 @@ enum msm_format_flags {
  * @fetch_type: how the color components are packed in pixel format
  * @chroma_sample: chroma sub-samplng type
  * @alpha_enable: whether the format has an alpha channel
- * @unpack_align_msb: unpack aligned to LSB or MSB
  * @unpack_count: number of the components to unpack
  * @bpp: bytes per pixel
  * @flags: usage bit flags
@@ -45,7 +46,6 @@ struct msm_format {
 	enum mdp_fetch_type fetch_type;
 	enum mdp_chroma_samp_type chroma_sample;
 	bool alpha_enable;
-	u8 unpack_align_msb;
 	u8 unpack_count;
 	u8 bpp;
 	unsigned long flags;

-- 
2.39.2


