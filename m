Return-Path: <linux-kernel+bounces-10702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E45581D8FA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A434282304
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCA712E40;
	Sun, 24 Dec 2023 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yR/SNaCv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E910797
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55322dbabf6so3368703a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 03:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703418571; x=1704023371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqxFJT/Vp5f9kw7muiT1rKjgk7yNDMWKW8fhqHiMN7k=;
        b=yR/SNaCvAI8rqaebDhMAsZXxYbx/oOD7oQIjPxhCz1jJBKRw9q74XoTsN0NTOCJ8uu
         c1YaNALbELql5FG3jQ4O5QaR/aOc/xMaiDB2owT2sMFglqoauK1hctv82lBi24UyXDaj
         oOSebY+o7HeiwV8XPYN7K68+ygMB6q7pLa2XiLdS090BIvRJVr0WqsD6mDV8EDPe5Q1L
         Z70B6oYV0yA/mup3QZdh1fhKkaWOxm60aSBx5SDwq4jGi/9oLBOlTXxDMUr2L4SFCVGh
         /+DVep8XfLG9Kr0OddAopHHnEi3pBJPWhqir0XSb70czFXnG7kfYfpLKwm1siTsFdBDZ
         YWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703418571; x=1704023371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqxFJT/Vp5f9kw7muiT1rKjgk7yNDMWKW8fhqHiMN7k=;
        b=IBI3D/3X+l0OfDjRT8SvzswOb8ctSH6OV5iHizOhXQk1yAJ2/lqIGVFrc56nsW32qE
         knGcE83cUE1DCFCtTQtzj/8aDg/0Ag5OkqlWz2j/hI97qHBavFPT/jyfaBzzsdE+2F4N
         PMqngrf1vuCEKJz5i48DyKkRLlXxDJ+rERg8Grq1rWO5uIuMrLeC7+Op9dS+k6NIEd8L
         4I7ILmGTrBf9FM2aqNWXQceuPvOeAn3NVPWRVm1Aoaf2RhxVm3fqxprhKMuGl9Y9gS83
         e+R2UigNugJE0lhx1IR+MydjAbl8kitsaajhaI54ysBpVX9nPYl6ONwzlZm0o3EByJCT
         +pNQ==
X-Gm-Message-State: AOJu0Yz1XuNbnKWQbvJyuAeZoy9Lq/kdtv6leQjTTHoAtsND1InFv/kC
	XPq99+p8YlKDJ6zTZOJUbBS3sMQQZiakrg==
X-Google-Smtp-Source: AGHT+IGM42YRtVprr9pekRIX2Xfig8OCXNZ5jUD1e/9F7EsT/K1svsCB6WfvK9coNOuAmg8mWuQ68Q==
X-Received: by 2002:a50:8711:0:b0:551:9675:53c2 with SMTP id i17-20020a508711000000b00551967553c2mr2358523edb.49.1703418571430;
        Sun, 24 Dec 2023 03:49:31 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id z23-20020aa7c657000000b0054ccac03945sm4999771edr.12.2023.12.24.03.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 03:49:30 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] media: fimc-is: constify local pointers to fimc_dma_offset
Date: Sun, 24 Dec 2023 12:49:14 +0100
Message-Id: <20231224114916.111433-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224114916.111433-1-krzysztof.kozlowski@linaro.org>
References: <20231224114916.111433-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constify the local variables pointing to "struct fimc_dma_offset" to
annotate the function is not modifying pointed data.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/exynos4-is/fimc-reg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-reg.c b/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
index dbc43b703324..0ed6e22e6c47 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
@@ -167,7 +167,7 @@ void fimc_hw_set_out_dma(struct fimc_ctx *ctx)
 {
 	struct fimc_dev *dev = ctx->fimc_dev;
 	struct fimc_frame *frame = &ctx->d_frame;
-	struct fimc_dma_offset *offset = &frame->dma_offset;
+	const struct fimc_dma_offset *offset = &frame->dma_offset;
 	const struct fimc_fmt *fmt = frame->fmt;
 	u32 cfg;
 
@@ -421,7 +421,7 @@ void fimc_hw_set_in_dma(struct fimc_ctx *ctx)
 {
 	struct fimc_dev *dev = ctx->fimc_dev;
 	struct fimc_frame *frame = &ctx->s_frame;
-	struct fimc_dma_offset *offset = &frame->dma_offset;
+	const struct fimc_dma_offset *offset = &frame->dma_offset;
 	u32 cfg;
 
 	/* Set the pixel offsets. */
-- 
2.34.1


