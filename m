Return-Path: <linux-kernel+bounces-10697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5ED81D8EA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5D11C2084A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9CD258D;
	Sun, 24 Dec 2023 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGtYT3OQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F56AA7
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a22deb95d21so384385966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 03:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703418565; x=1704023365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/7yGGqfPDJBjbjF6BHEdiopGYDrUqZzrzy34YLYqKk=;
        b=EGtYT3OQ3/Z+GiG4WPAUTtJzHUjhgn6tBoqetRM8gMTs1tyucxdA22fZ56bANWWnZ4
         QhS27uSsQWrIHQHJFczdyduVbVBHOTnq/e5iej4sOdhyj78VF3M8FQeGU5XNA7MO+Pua
         RIk/ZPZ5nY7RRnID++voHij4EUtMcG2pjIXnNlMr+IxID+jB6iMdlbRFT9WNTvcwXGtb
         zcXJjhlVCBvXDFuv41nmL4iteyL7y3i6LsEhgl7jpFYR2Y29bRo/Io1Og3Ks4bBbiEYf
         gQmNAscgYNeQ0Bj792hJBzflvyEuaLn6uSKUcyU2RCQeUJVUcFH3hysv4GL4mmHoxTq4
         E+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703418565; x=1704023365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/7yGGqfPDJBjbjF6BHEdiopGYDrUqZzrzy34YLYqKk=;
        b=V7HTXNSF5gwDg9RDjGoylXVVllC3Zopuqr9gZozBCgae25ZJ392GaklmfjOIMUOheL
         XlDIRgnt142ltjgRJad2HRdWorSDph33qYhgkZK3QYKe9hjer7i4+k7DGaG2LLDfwLuP
         lWhumEM0LbWuvX5DsffVFKkv8rt556gLWamrQar63HcLd3rHSUggfNEriQAJnSF3uGZh
         NBZL8DR9mjwIBLETL6Cc4/zJlGKVqXU999YIyotroqQ3oUwWxFibXDbDVg6UegUCmOEz
         GS1FQHiY5Cce/tmuubg9C9XKcT5VITabGyivpddHqj+lgeBxvhM0zQa1YeSlrftx7BOu
         pm7w==
X-Gm-Message-State: AOJu0YxI7ieyid17ns4RgxdtjgHss+F2I7PgjSYCch9sluS+eCGh5yQ1
	v5AkmN3iIpJhPZAkRRiCO/laI8rJkEMRpw==
X-Google-Smtp-Source: AGHT+IFLjltbFzIwlpp3xAsCt2d9jf2K9GA7p6ymjiYtOcDsBvKRMm8oOAQJL/Y8h0fI23mJ17ZFRA==
X-Received: by 2002:a50:d617:0:b0:553:f06d:3ab7 with SMTP id x23-20020a50d617000000b00553f06d3ab7mr2823307edi.35.1703418565299;
        Sun, 24 Dec 2023 03:49:25 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id z23-20020aa7c657000000b0054ccac03945sm4999771edr.12.2023.12.24.03.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 03:49:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] media: fimc-is: constify clock names
Date: Sun, 24 Dec 2023 12:49:09 +0100
Message-Id: <20231224114916.111433-5-krzysztof.kozlowski@linaro.org>
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

Static array with clock names can be made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/exynos4-is/fimc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-core.c b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
index 97908778e1c8..ad72cc31dc45 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-core.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
@@ -29,7 +29,7 @@
 #include "fimc-reg.h"
 #include "media-dev.h"
 
-static char *fimc_clocks[MAX_FIMC_CLOCKS] = {
+static const char *fimc_clocks[MAX_FIMC_CLOCKS] = {
 	"sclk_fimc", "fimc"
 };
 
-- 
2.34.1


