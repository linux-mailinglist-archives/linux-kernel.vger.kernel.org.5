Return-Path: <linux-kernel+bounces-10695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D35B581D8E4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7014FB21312
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42216AA1;
	Sun, 24 Dec 2023 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0xhWpr9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877BB3D7C
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-554d06bfd83so183248a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 03:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703418563; x=1704023363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+A2sLdMYd9jrOu4aUtIFiY1f/32swGwSuhGRSvbimyg=;
        b=f0xhWpr9yAuT8pn3ZBNfas90r1lbC3N5IR7Gr0buY5B3uORUkmoPij2PA9MtJ2gGR4
         r6c2w2uhg3KCEJTADH9QJ6ynr+J13UB+KBnI9j6b0+I5UI8iUC8otz43UhzNH4RIHP8q
         gWX/5lSTNt0jihNQeVNvBgkKHQki1dMxjHra7LgqkHhjogWx9ZN7tzDZE4sVtZdubICR
         xWzpZIfm5nkLE2yLTBkfBz8Lwgw7zlwNH86pYrl6w6LBu9pDVnLr94W+qmOYea49H31K
         uh3hJIUzc1u1oeSHfTezjVIk4/E8jeDj1RLIyL5QRJnLpQVv/QnZhB9bq+FbLm6k7Rcv
         nSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703418563; x=1704023363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+A2sLdMYd9jrOu4aUtIFiY1f/32swGwSuhGRSvbimyg=;
        b=Ry7uJcRfZ7zyY7AaZD3RZjbVNIxH4FWztFmXW60HTFTbUceyGMBBCHWjUZOvxP3FTt
         pLF/LBN3J5gZftVwqUuRtdiO87YX4siCr943SzwNyGK3jjadkK3V1BYtSkjmitJbJCL8
         55hlfUZEUNd4kjwZL50/75X11pO9ntP2mwoDP3v6B0laROgORI195eI2LUzu66/AV9Zw
         8SNEB2QiFIErzQGDsu0qE6ZVxWMQe0M6h8zQ+HqDvfPjQgSiDdPWeJCxpsI62Bt79jk8
         TOpaB3EY2nJqv5sMG2YmdU3HLESAKhH3o4gskIO05hYqV9+Aot1gemK3wpiKvZjI3G9A
         b1Lw==
X-Gm-Message-State: AOJu0YwxXNs2gLYluR/6YRz0VD1Cxp8ts/9daN+CDH7+gjT5UmodIj/z
	FJ6hIDI5qWCe1oZk3TKllriHuzLM67vtoA==
X-Google-Smtp-Source: AGHT+IFiO4BeiGCukyoTdsjS7Uq7esREyuxI/9413ugA/P7Cwu/jb+Dq6hBnXpvSUiCHMkV3mLBjXQ==
X-Received: by 2002:aa7:cb50:0:b0:551:4f67:18df with SMTP id w16-20020aa7cb50000000b005514f6718dfmr2757054edt.59.1703418562841;
        Sun, 24 Dec 2023 03:49:22 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id z23-20020aa7c657000000b0054ccac03945sm4999771edr.12.2023.12.24.03.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 03:49:22 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] media: fimc-lite: constify pointers to v4l2_pix_format_mplane
Date: Sun, 24 Dec 2023 12:49:07 +0100
Message-Id: <20231224114916.111433-3-krzysztof.kozlowski@linaro.org>
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

In few places functions do not modify pointed "struct
v4l2_pix_format_mplane", thus the pointer can point to const data for
additional safety and self-documenting intention of the function.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/exynos4-is/fimc-lite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-lite.c b/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
index 7898c9bebb04..d1d860fa3454 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
@@ -738,7 +738,7 @@ static int fimc_lite_try_fmt_mplane(struct file *file, void *fh,
 static int fimc_lite_s_fmt_mplane(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
-	struct v4l2_pix_format_mplane *pixm = &f->fmt.pix_mp;
+	const struct v4l2_pix_format_mplane *pixm = &f->fmt.pix_mp;
 	struct fimc_lite *fimc = video_drvdata(file);
 	struct flite_frame *frame = &fimc->out_frame;
 	const struct fimc_fmt *fmt = NULL;
-- 
2.34.1


