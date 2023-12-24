Return-Path: <linux-kernel+bounces-10741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C5A81DB25
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A2FB21202
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7868ED299;
	Sun, 24 Dec 2023 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zwh4aTfl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55327747F
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-554ca5fac07so350149a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 07:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703432671; x=1704037471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Onwp4Wr1mUGcp5LZpvd0xonQACtJfZwXbS/++yMm9d8=;
        b=Zwh4aTflSYfFfHuo2iYfF64kG6kdsf6Ek6sR2cAF5ozBLBAnt/Q7MZ+ZoiZr6PhADs
         GYyRU9aKuyJGFd86tbKp6UTmAckIGesT12zQvvaghUq+xf+hxtDAr6nnY4zqAW+9e/aq
         wwvj7oWW/tjcJIuc7b4GOhFVQqxwMDC8KnlzeVr4Y0N8yslw1ckq6O7w4pNsXZI315mK
         KSy8ZrT96g8XD5UDjKwNSrwqyGWoyFxyRp5GsdfLpHR56TSKUqpwDtQgh6P13dwbhifv
         JljK53qAAHP6IcC17H9fF/8bpcdLPWXytzMigFLXzqFp9yCEWWStbltQpIQ04CaLLNuE
         LFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703432671; x=1704037471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Onwp4Wr1mUGcp5LZpvd0xonQACtJfZwXbS/++yMm9d8=;
        b=SZQ6FA3X/tW/vNxqMfNsIf64k7NMb03ZZzliUCEjOcF0kH/2ADVbCK+ZKsRPsuThyz
         KlKqnljnAQ3CQNenR2N4iMsI1vmVRCjHfJIrMUyrc3wEGqCwfpcQowDa66uRPj7j3pAO
         TO21ktPUSOOySMM/sTKoOqxBvC+nuan9Kb0OOiWye57uUKM4rmAzZ4mF8PzmTR8pLRNs
         F4MnFtYoE7l08zhxVkchVhwhNg+rl5zAWZnbv46EOeScxXgjMozT4aBrOhoQKSYHPL6x
         LSyZ+Cxm/VIKQAem1jrqUUPqbrsr0sQdzqL7+LRf1o/hBNA49Fik3Qly771TYf7C+foA
         igdQ==
X-Gm-Message-State: AOJu0YyjfAvrIZi4pbZEtybXRjEdWq3cPfCfglRdA/wFEYffYzuSDupU
	am3/gU6fafYOfLIWzQ3oWqD3D7/NZFpFPw==
X-Google-Smtp-Source: AGHT+IESUFUOS1uBJFg3d1DW1wsZmKy7QL9mSj2CDo1xn0OLo+tYjRvyt6wulJLJVaRh5xueH8Xlow==
X-Received: by 2002:a50:9316:0:b0:554:262:3115 with SMTP id m22-20020a509316000000b0055402623115mr2237467eda.61.1703432671722;
        Sun, 24 Dec 2023 07:44:31 -0800 (PST)
Received: from [127.0.1.1] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id ge12-20020a170907908c00b00a26ac403032sm3325901ejb.65.2023.12.24.07.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 07:44:31 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 24 Dec 2023 16:44:01 +0100
Subject: [PATCH 02/15] media: s5p-mfc: drop unused static s5p_mfc_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231224-n-s5p-mfc-const-v1-2-a3b246470fe4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=SGfvZrymg/GAF5fJD7rUJGwMU1wlhVHljcM4HZIJOUU=;
 b=owEBfgKB/ZANAwAKAcE3ZuaGi4PXAcsmYgBliFHPINUgnCaukbsTkqOz02P9rYU/IEHonJNio
 Yt89shzGsOJAkQEAAEKAC4WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZYhRzxAca3J6a0BrZXJu
 ZWwub3JnAAoJEME3ZuaGi4PX1e8P/R/7U5mMUd1VtV+BK7C5r2nay0DcsfSLWuO0T9OwRSvrFnp
 ySYSEO0r4IHt0nsjgFrw6/CRQwTc+zs7UZ+k34p+vJ87Nt0wK2DSoJ1hFnIqYnS7+0Jr+9URJIH
 mLrWZLfQXKPPWGaM/qHBcWfXHntXz1iziCqFQSD22V4huu14mE3MbZYDXwV0U0VMOE7gSwqlbXW
 Lps6BgTmwDEwQsohTjA1al47R4MtX+OaiPlO+TUmYvAIfR/i3sH9k5NptQis8n6OtVI9NnOnuge
 zUGacpiZR40eBdBXtgry7XADd5/PebvdBuUp42fI7clXcs9kPZo8cpX0nM2GWW9t0jjtFXXxiPY
 ygGJGIV/VPrXwent8N5Dj5lcvG7cVsVLyqOdReVUQcaMUrFrnIcB/ZegJkE1qp7wfzRmesuA2Ml
 oKQH725AMGNb/rrPYqFMTbJSLXzvCCvSfoG9hnZqi4FWAPHn/paZyqsYONVlXlS+oXz7PRM5RRY
 haKUpwYUI48ayV4rZ0rux4k7JjD79yFOn/qMBPhh8eu/tvkJnv9MS00IR8PCLX04zpK5HqdNXZO
 FVFK9DI1doPrAu5tNbtS0FgI2ZfqN6TRHZKesgTv5TsSCnhADIsUCkoepVr2MV/pOOhErGEqMG8
 0D2YzNvIOmNKKb0ej3JeFXE9CzW4rE3NUINKd
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

File-scope static variable "s5p_mfc_ops" is not read after assignment,
thus it can be dropped entirely.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.c
index 673962301173..5ba791fa3676 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.c
@@ -14,18 +14,15 @@
 #include "s5p_mfc_opr_v5.h"
 #include "s5p_mfc_opr_v6.h"
 
-static struct s5p_mfc_hw_ops *s5p_mfc_ops;
-
 void s5p_mfc_init_hw_ops(struct s5p_mfc_dev *dev)
 {
 	if (IS_MFCV6_PLUS(dev)) {
-		s5p_mfc_ops = s5p_mfc_init_hw_ops_v6();
+		dev->mfc_ops = s5p_mfc_init_hw_ops_v6();
 		dev->warn_start = S5P_FIMV_ERR_WARNINGS_START_V6;
 	} else {
-		s5p_mfc_ops = s5p_mfc_init_hw_ops_v5();
+		dev->mfc_ops = s5p_mfc_init_hw_ops_v5();
 		dev->warn_start = S5P_FIMV_ERR_WARNINGS_START;
 	}
-	dev->mfc_ops = s5p_mfc_ops;
 }
 
 void s5p_mfc_init_regs(struct s5p_mfc_dev *dev)

-- 
2.34.1


