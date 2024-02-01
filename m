Return-Path: <linux-kernel+bounces-48098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AAC845732
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A89E2861F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ADB15DBB5;
	Thu,  1 Feb 2024 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0NF6bTK"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565C15DBA3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789878; cv=none; b=tmSfFd8AXfxx3BrfI/Tzj08jhBG5w2fLAh21OIEVUu2KHQiRq+h9I5yYweQ+WzXXfBiLuioYWKyhVBSaDxyiZ5zOI/Dimdl/BkQexNcbyAOfQKCEFz27rqLYI0X46gd264qTQJelEL2+HRDOx2+H6xht46zUWheX0BLfNyHfzF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789878; c=relaxed/simple;
	bh=RLMFIhenr6gWEPUUklo7GqtWzySwMhiKr8msi2eBXUM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Iy8scEY2y84O6183XiV1fzJEbovKXz0EbXm4cJOkOsjpi5Kj6XsMXumyB84a8ncffyYl5Q8KZcpp6IHBjwkxBdeCS1m08CS+X+qFulSxbP2RTRJ3J2O3SdZ+wEmBaBsYb9c/R5vEr3NEHben8oZQ+jI4FbzChXNn4VVCn0i/SHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0NF6bTK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a358ec50b7cso153014266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 04:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706789875; x=1707394675; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FaSjJ2/3IHsjyK7hdbHfYJwqnAf7t+fo26BP+dO49xw=;
        b=G0NF6bTKJ2KVs4A/qyPUbpk19uelpRYXjotrhifaDQCjAyYr5jWUMKg9V1+5o5OWdB
         e8k9MjL9381/jLeepp9Ycw6wIIqkdG77sbpX1RCVMKOUaP71WqS455yRVgVASS7HNREk
         PLGR5VN2AoYw798iEXLSM1ET5Vnn3DX0gJ9C9zY1oWhg6N26JxtPL4MPd1nATGM9NjtM
         YALs6OpWXEsaKrK9UWXBP2Nu0VzMugaiNpJmfXNXKk/nd6aqFx2Jljr4jpBgF/Jzxzbt
         m4ucL9XYYJKbMXjfXJiLuF7+UGciHsccJMZuVxxgn3ymYp8yIG/EIUyQ8HLLMaDjK62w
         eH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706789875; x=1707394675;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FaSjJ2/3IHsjyK7hdbHfYJwqnAf7t+fo26BP+dO49xw=;
        b=LAxsLtZYMsVlB3sYbdYQAAwUOXRqry8Wkk1+J0u4xgXjYrzKtFebhleaTnVkwQ3UTN
         zZ4ImMnyWRm40b2v/HZfexx+G9djo96O0FSEUyrkGC2itmVBShAMajefLflJVDKGsnDt
         g2YX+yMrl8Sx6I+lY/iK7vOcTxtic7TgCJB7sAvqkrz48cDpQMQelPtNKux6/orBlIuq
         08tCHewkinTrX38raMvqTjJgs/ACIDtszvm4h28CsfSJbJ4uA9Yu1tT7ztlIc8r7v6v/
         2KIKeaBJ8ZpPqxlYTn9c2b9LT09jDESrUcnbbq/pWekzf8S/KPohaGbpcFTq3yVcnXHY
         cFIA==
X-Gm-Message-State: AOJu0Yz8+UG20lQDED2EpwsnRKfjDG3R6+uNhcj93tS4xOu17x7zgA5f
	JEEl0FYcHnUDPmyAIAPQ4bwxIz3pG/8Xs1Ed4N9UHh8T9hMMt2S3voCvKgNrT3w=
X-Google-Smtp-Source: AGHT+IFRmyZYbZ8wILJI69a8R58bPmWo2as2I6NuRjJp2cSD6cmhkOsjhNJ5kFgyo6vD/sGEQPiHjQ==
X-Received: by 2002:a17:907:8dcb:b0:a31:818c:ffe0 with SMTP id tg11-20020a1709078dcb00b00a31818cffe0mr6665139ejc.19.1706789875145;
        Thu, 01 Feb 2024 04:17:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXFy8FhlJQVZMlOMcjnrSnVeSiR2+7WMqhCcakWEW5XjcH59ufArQ4j65amlYcOJQHTAZNEhIu7T4K1H3tdGrDwibXlwOkDTbMYYhCRc/A6jnZ/2cCPSYCH4k5kRVEw0vMZaNlZSCu16lq4TOncwBDc/3/qKI3tS4o3MUOc3+frl+g+nPYtRu6cpyj0EwmIUWDfuyEwhaYuvcBuVwuVlB+OcIqECD23W3N361NrR/0K9PXSHik0M6Kj2w==
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id i26-20020aa7c9da000000b005581573e251sm6761196edt.2.2024.02.01.04.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:17:54 -0800 (PST)
Date: Thu, 1 Feb 2024 15:17:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] irqchip/qcom-mpm: Fix IS_ERR() vs NULL check in
 qcom_mpm_init()
Message-ID: <22e1f4de-edce-4791-bd2d-2b2e98529492@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_ioremap() function doesn't return error pointers, it returns
NULL on error.  Update the check accordingly.

Fixes: 221b110d87c2 ("irqchip/qcom-mpm: Support passing a slice of SRAM as reg space")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/irqchip/irq-qcom-mpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index cda5838d2232..7942d8eb3d00 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -389,8 +389,8 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 		/* Don't use devm_ioremap_resource, as we're accessing a shared region. */
 		priv->base = devm_ioremap(dev, res.start, resource_size(&res));
 		of_node_put(msgram_np);
-		if (IS_ERR(priv->base))
-			return PTR_ERR(priv->base);
+		if (!priv->base)
+			return -ENOMEM;
 	} else {
 		/* Otherwise, fall back to simple MMIO. */
 		priv->base = devm_platform_ioremap_resource(pdev, 0);
-- 
2.43.0


