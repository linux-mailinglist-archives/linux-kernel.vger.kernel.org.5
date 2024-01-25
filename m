Return-Path: <linux-kernel+bounces-38751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242CF83C552
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10A029635F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D89745D2;
	Thu, 25 Jan 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3GdZcOO"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3336473169
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194216; cv=none; b=cbNGoKyl1HkFewClU+I63+gV4PY9ZFbpI0ZDN5jgrrZ+tVlhUnsoL5OK9ycyjSNmXsyNiQT026blfXNVETfsvxVS+Obf45aVc7pGP8jW0ACqOX8AUIfzFA40ctTovCxxBIs2t3KJRjKXsxk0M4wNkedoHMeUs7iJqbmBJJ9Jf40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194216; c=relaxed/simple;
	bh=c7iSgUJTrECnQEQ+PYY72b3yXlblzBzUREV9meR6/uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfTQE1jNZ23hmrFH6cUXC4mJZ1wNJQV1sJDGQZ4DjlUbOw3UzgxsKesd5Duxg/ylKdK53RZpY2EobS+wh2mBsKgC7ETKAuOqJwK4cIcLxmwu9QQ/2LJApb7UEJ8yLDQ1HHvswShLCAUeLg2u8q75hzJSeZdshVyWVJn9KF5i/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W3GdZcOO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40ed2333c8fso7343735e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194212; x=1706799012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8tycZHq++FMKvH1QpORqsbZ4vIzt59SLtlLRtqr3vk=;
        b=W3GdZcOOtvHLtDQnedR+4ABUpj+lCoqcwQydmo/gkKBRtieGaWJSvksCTfNB+zxnvF
         xrS9kPSzLJQLmYw/8Xt0YzmuIzkb+bpxnWpQKH7BRNzzLsLSwpF5wgHigImdBv1+34YT
         d0w0zl4eaa+X1r9fCPqk4GUy8tb1Nbh8BW71kso1lCr+WZlHyOaZNhumTwDH1ocPnsuD
         LVZfBfcMzpjD/+vI2NL1MCDuUzlS6f/2dFbwEmuk0xz9/w52h1gsj95OADEZSymHgkCZ
         uka+ZIu5u/3K4+R4GDRdDT+iKKfFlaYY5Byram/4jaNxt5Rj26hEj1NHgVr4lttwQsjj
         vgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194212; x=1706799012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8tycZHq++FMKvH1QpORqsbZ4vIzt59SLtlLRtqr3vk=;
        b=SHmf37EFjwoNJXaQR77tJOnjNGVEWR974ar9SG3VHOkUuYyIuLNwObTcpcPpmNXQOd
         b+xMuNOG0cuBYuqh358yjUD8qAiBNajQ7WrDSBYmQGJ/tlrtmJ0h/vG+ln6bOAp6UANG
         sIFNLrNDUYqpgiP/hmzx88i3o/py8xJAMbvHFp8tkGp9lCXNjwyJO89k5i9yvj523OiV
         L7H4URwYzwcFTt4WxOinuv1xIwu4DvBUaiR0esjWjFEvCFId1iWAr7BUavsWkFsOqvmy
         HaKgLRYLplfKtX5Ml98wC4EgmfBo+qrDhFDBaMDWddhcomeYkMX1Zxm7CEVj+0WPx77V
         RLHQ==
X-Gm-Message-State: AOJu0YxIixCSFBbgR/3iOm4gyXY7/5uKTqkThA3NnIQrDNbdLNgM4oto
	J1wEWJEaqE2Y8ULr+wGmfyoa6YqU0NXkRTei8+Kil+CUuXK7TbIWP++ovD9bhPo=
X-Google-Smtp-Source: AGHT+IHYnZONiZcWx4qZ7LILotRhmsFf3p9jhJElO2+JWwazr0DZjqKuTBjkH5FNJ9qnXfLbjx9uug==
X-Received: by 2002:a05:600c:5717:b0:40e:76b7:e8e3 with SMTP id jv23-20020a05600c571700b0040e76b7e8e3mr626383wmb.226.1706194212500;
        Thu, 25 Jan 2024 06:50:12 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:12 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 02/28] spi: s3c64xx: explicitly include <linux/bits.h>
Date: Thu, 25 Jan 2024 14:49:40 +0000
Message-ID: <20240125145007.748295-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125145007.748295-1-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses GENMASK() but does not include <linux/bits.h>.

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

Include the missing header.

Fixes: 1224e29572f6 ("spi: s3c64xx: Fix large transfers with DMA")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c1cbc4780a3b..2b5bb7604526 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -3,6 +3,7 @@
 // Copyright (c) 2009 Samsung Electronics Co., Ltd.
 //      Jaswinder Singh <jassi.brar@samsung.com>
 
+#include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
-- 
2.43.0.429.g432eaa2c6b-goog


