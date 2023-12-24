Return-Path: <linux-kernel+bounces-10751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDE881DB43
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7559D1F2195D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE41B18C28;
	Sun, 24 Dec 2023 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PhEUKsgK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F318034
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d4ee4cbbcso15638415e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 07:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703432685; x=1704037485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+PqwhjS/mLmgDZ1FNMLs9KmhmVK/DvYHDWz6xCaG9k=;
        b=PhEUKsgKLYxfIsgx6EBP5jlB18se7KxfTNb2RgjMFeZ34J7MO7Ule5Ru7NvQ4wQzP0
         r+73uVppNKSeIL2kX5NMhU2U/GeO8NZQqNCBcQaBYIJlmo9c2ACs55aPgJkx/22DG6yk
         I6Bl6qJkencMlu//RaLnBvd5R/tJonydF+6GQ9CleVYtBiBdD+t3ISPqsEj/qUUWDJmr
         4L4d+qVF2vjuAgd89Xg2nELn26lUr2oTtzQ8K3xWnFp5BCxfaAJOzDS08z7tAJWx7eE9
         sZoPaLpfsb0OMYQT70FAPw24YLBk4z/K0bSJh5GWFnzL7ivsdzGGyvGcslHjvc34je7b
         OEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703432685; x=1704037485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+PqwhjS/mLmgDZ1FNMLs9KmhmVK/DvYHDWz6xCaG9k=;
        b=OZOENfmOgCCGvhIxWEIfKWuRTUNtUZqOtC1/wj4lFwtj/6OZqDzw+JNZ1mYF2W/ZU2
         0syPOJyrfopoPuxMvCMDoRxxrHno/HLbsl9TufqarwZjOVI+leysPG46gLKw8zRXLkO+
         J+q59k6DOXt/vd8gX+OsqMCNaiMnBK+eZOITR2/9a7ObG1uc7Xqk5f2fs4cp0rbxJjLV
         8xzzNjtH0O5dA7kSxVdCpSjKyFPH9mU+PnHz4lK7gtPGMAPi0WqApcVL2UhVTITlk2Dc
         7+PCl+b2h0tmImRejnbUIRrXZ/qyTGgo3Q8+aOVElwzTqcFxeeFJDK2h7P/nAalUdEbh
         Zx2w==
X-Gm-Message-State: AOJu0Yx/GOGATeuDjQnoPKvylvr50RuEjvZlmibTxvtR8cY53pcaw+4N
	GgldUlYD+qywsV4Cad93BMziwyb6+t69ig==
X-Google-Smtp-Source: AGHT+IHsdpLGhrTWdR2PM12LvCAZT+GmCIeOjlssIDAiXxh0F5PQ8Q1KllNosT7odAwn1NahfRJATg==
X-Received: by 2002:a05:600c:4ed2:b0:40d:5319:4f89 with SMTP id g18-20020a05600c4ed200b0040d53194f89mr1014756wmq.177.1703432685231;
        Sun, 24 Dec 2023 07:44:45 -0800 (PST)
Received: from [127.0.1.1] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id ge12-20020a170907908c00b00a26ac403032sm3325901ejb.65.2023.12.24.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 07:44:44 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 24 Dec 2023 16:44:11 +0100
Subject: [PATCH 12/15] media: s5p-mfc: constify local pointers to
 s5p_mfc_enc_params
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231224-n-s5p-mfc-const-v1-12-a3b246470fe4@linaro.org>
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
In-Reply-To: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Aakarsh Jain <aakarsh.jain@samsung.com>, linux-fsd@tesla.coma, 
 linux-samsung-soc@vger.kernel.org, 
 Smitha T Murthy <smithatmurthy@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5075;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=MyjbnMtRY4pnTAtRZmc7TqzfbEZN91NOwcZsaBA9CSc=;
 b=owEBfgKB/ZANAwAKAcE3ZuaGi4PXAcsmYgBliFHY3Qe+OEd6XMbY4Xs+O0ln3OAH8/hcDWsSY
 UvK8SNc3T6JAkQEAAEKAC4WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZYhR2BAca3J6a0BrZXJu
 ZWwub3JnAAoJEME3ZuaGi4PXfC4P/0lweb+ijrsP6Ae78B2EkRIlDKNMFd6RmLLDTrhU/qJdFXS
 Zu9CAto7F1C/d1ZOOyeJQnRpOdnu4jkdglkcBKJNVsX6XRdq7N7X4nvfaQmyJfHwcZJkKaUVXrb
 pMGxl0n4QTRsoeRqzQmn1lQAu1WU9qrAa6w7FGrmqeNa40wNRrGVwcNU6/b+lcHR9SgwZlyi/Hw
 GEuK8Ka30XhGN4YssiDuWUy4w9/X/Y/Cs4tXALh74oDFHMNy/ZcTIJbuGzqdZ7ylTvPr/rN43hT
 lIRxj7QlinGuWmpPCYbHbXDuyGme5uNAlUD6Irm6qFNCWdG6e3I1MZG//E48O5c5QF+E3yFQ2Il
 6yf3K2H06qadoIqMOws3HCHGs4wJFxZ+ywtd8+KN1JgDgbUDXBmbe9pgiLGZo+A4UZNtJCBZotQ
 Rwe4YYpBCCfY0tjqV5eMlt1dOc434tYzobZnJdYPRPBJDLxXhx7PinDyup384ru+t7xUN8OjUHS
 ZnydqBJ9W1IsPa8fVnAw9NYBFzMAq/893T/WvD/AsfknacRW2wHQ8B97/FO690X4kdhn09fLTuE
 I98q6i2pkTK1mmt3YMtfknWBMtOJ+fAsjQfIJ2oonEKrU7OKtE+j+JdGdwsyBPE805UHOqyVVgW
 Cu06PMM4bkarU5jOLI9Znk0WK7Fz2FkYKuh7Q
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Constify the local variables pointing to "struct s5p_mfc_enc_params" and
other encoding params to annotate the function is not modifying pointed
data.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c    | 14 +++++++-------
 .../media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c    | 18 +++++++++---------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
index 2a0fb78e8e82..ba22c6a3219a 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
@@ -674,7 +674,7 @@ static int s5p_mfc_set_enc_ref_buffer_v5(struct s5p_mfc_ctx *ctx)
 static int s5p_mfc_set_enc_params(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_enc_params *p = &ctx->enc_params;
+	const struct s5p_mfc_enc_params *p = &ctx->enc_params;
 	unsigned int reg;
 	unsigned int shm;
 
@@ -757,8 +757,8 @@ static int s5p_mfc_set_enc_params(struct s5p_mfc_ctx *ctx)
 static int s5p_mfc_set_enc_params_h264(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_enc_params *p = &ctx->enc_params;
-	struct s5p_mfc_h264_enc_params *p_264 = &p->codec.h264;
+	const struct s5p_mfc_enc_params *p = &ctx->enc_params;
+	const struct s5p_mfc_h264_enc_params *p_264 = &p->codec.h264;
 	unsigned int reg;
 	unsigned int shm;
 
@@ -914,8 +914,8 @@ static int s5p_mfc_set_enc_params_h264(struct s5p_mfc_ctx *ctx)
 static int s5p_mfc_set_enc_params_mpeg4(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_enc_params *p = &ctx->enc_params;
-	struct s5p_mfc_mpeg4_enc_params *p_mpeg4 = &p->codec.mpeg4;
+	const struct s5p_mfc_enc_params *p = &ctx->enc_params;
+	const struct s5p_mfc_mpeg4_enc_params *p_mpeg4 = &p->codec.mpeg4;
 	unsigned int reg;
 	unsigned int shm;
 	unsigned int framerate;
@@ -993,8 +993,8 @@ static int s5p_mfc_set_enc_params_mpeg4(struct s5p_mfc_ctx *ctx)
 static int s5p_mfc_set_enc_params_h263(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_enc_params *p = &ctx->enc_params;
-	struct s5p_mfc_mpeg4_enc_params *p_h263 = &p->codec.mpeg4;
+	const struct s5p_mfc_enc_params *p = &ctx->enc_params;
+	const struct s5p_mfc_mpeg4_enc_params *p_h263 = &p->codec.mpeg4;
 	unsigned int reg;
 	unsigned int shm;
 
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 6157c5f97707..08545213caa9 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -750,7 +750,7 @@ static int s5p_mfc_set_enc_params(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
 	const struct s5p_mfc_regs *mfc_regs = dev->mfc_regs;
-	struct s5p_mfc_enc_params *p = &ctx->enc_params;
+	const struct s5p_mfc_enc_params *p = &ctx->enc_params;
 	unsigned int reg = 0;
 
 	mfc_debug_enter();
@@ -1196,8 +1196,8 @@ static int s5p_mfc_set_enc_params_mpeg4(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
 	const struct s5p_mfc_regs *mfc_regs = dev->mfc_regs;
-	struct s5p_mfc_enc_params *p = &ctx->enc_params;
-	struct s5p_mfc_mpeg4_enc_params *p_mpeg4 = &p->codec.mpeg4;
+	const struct s5p_mfc_enc_params *p = &ctx->enc_params;
+	const struct s5p_mfc_mpeg4_enc_params *p_mpeg4 = &p->codec.mpeg4;
 	unsigned int reg = 0;
 
 	mfc_debug_enter();
@@ -1278,8 +1278,8 @@ static int s5p_mfc_set_enc_params_h263(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
 	const struct s5p_mfc_regs *mfc_regs = dev->mfc_regs;
-	struct s5p_mfc_enc_params *p = &ctx->enc_params;
-	struct s5p_mfc_mpeg4_enc_params *p_h263 = &p->codec.mpeg4;
+	const struct s5p_mfc_enc_params *p = &ctx->enc_params;
+	const struct s5p_mfc_mpeg4_enc_params *p_h263 = &p->codec.mpeg4;
 	unsigned int reg = 0;
 
 	mfc_debug_enter();
@@ -1348,8 +1348,8 @@ static int s5p_mfc_set_enc_params_vp8(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
 	const struct s5p_mfc_regs *mfc_regs = dev->mfc_regs;
-	struct s5p_mfc_enc_params *p = &ctx->enc_params;
-	struct s5p_mfc_vp8_enc_params *p_vp8 = &p->codec.vp8;
+	const struct s5p_mfc_enc_params *p = &ctx->enc_params;
+	const struct s5p_mfc_vp8_enc_params *p_vp8 = &p->codec.vp8;
 	unsigned int reg = 0;
 	unsigned int val = 0;
 
@@ -1737,8 +1737,8 @@ static int s5p_mfc_h264_set_aso_slice_order_v6(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
 	const struct s5p_mfc_regs *mfc_regs = dev->mfc_regs;
-	struct s5p_mfc_enc_params *p = &ctx->enc_params;
-	struct s5p_mfc_h264_enc_params *p_h264 = &p->codec.h264;
+	const struct s5p_mfc_enc_params *p = &ctx->enc_params;
+	const struct s5p_mfc_h264_enc_params *p_h264 = &p->codec.h264;
 	int i;
 
 	if (p_h264->aso) {

-- 
2.34.1


