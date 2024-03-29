Return-Path: <linux-kernel+bounces-125230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E8A892279
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F2D1F24F20
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EB8137902;
	Fri, 29 Mar 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2yBLTrw"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A6C1369A7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732285; cv=none; b=UHvh0NpDbvoNUavMgDbH2R9okoxgRBhqlSuu+mF72F2yn+CoWVEGBR8pVwxoDADazGk0viKU58GlCjn6FlDOPZgD7eI3ITj1WBuf7HoQwjEvXVSpEk2sl3MzaQ2GifibFLsfW5ACUtkZ7h8GHoIVlY+lGFMxIQd0NE+dmRIZ/Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732285; c=relaxed/simple;
	bh=BvkCan4CYqT9KahpHLPinkF0Oqsyu4ARVTxo69Ya3OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=khAtV/x1Cd0O2J1uHO7h1/lCQM7XHa4wy1t1eqVCQlIo2muCPm8lKSrp9JLqimLRt0EFSYUx3H3fXjbWaSTbQ4G3XgEiGBIjUENnD+gm4xkVvp6i7g7n1xBg/xmjMSJ9wMWMtpR9BBq0yMENRSxXi9gj9CnHA19vbWOPyK7jzoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F2yBLTrw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3416a975840so1646953f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711732282; x=1712337082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ojAEQZDNOooKXWE3jOPqHLahg+qtKGfAOZ8JmZimIqs=;
        b=F2yBLTrwsoGuf6FL2iqke3TmioSLLDxIeF7/jhPwFCYHfnAmnpUxNIDSIILllyA6tF
         k7P68wBrNNAzp0aPSbYUqwJ9fJI0XEUv3gHv3otPRecsSRj6g+f9A+GOLz3Qf+OJPglM
         XiEwcWzkOJFNyxioXH/UyWDE796rnEFwjNwnio+cPfDJTjRIMJRdHQyASAEVjJHcvs4f
         lsI4QSp+J8cdWGw1/72CQAYIkceRNhgLK/Uwz64hWVIYs4CBSAATH3tIlZELs2wjXW0B
         vh7foDWqW5CrpW7Evci+ZbWxS3ZXPyhatT/xS61KtMwKo+6Y9OTgo/7/6kEmNgMDksXE
         XkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732282; x=1712337082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojAEQZDNOooKXWE3jOPqHLahg+qtKGfAOZ8JmZimIqs=;
        b=QmuNbmAuwR+Q1NOt8IqbiMr+ZV6Jh4gLK4PSuDVB1DhtcPH/mGasnoeCkZHGZuy97f
         6FLqsPwEGUJ8B8FfHI+VolMN5d55rxy6YoikO6FLPncjBy02isgKt80ohnAHy3jA9BEB
         A3AN49qYFIKKBwsHgYfPiOohBL74koiiwjtTEN/wGkENw3IDdehl74+P2e+F2G9dzYay
         5cHaRQwzGANyRQ/eZ2XQouUkOi3yZyrsJzU7Edig6LNQNF7CFIb0xR5sgQ2aT0dx6goI
         hVEtnYBQtFjTqEmY/29UfFb6T2hA5oj/9H3EUPjDsYcECFJvRADjiyW5ej49QRLi40dA
         bV3A==
X-Forwarded-Encrypted: i=1; AJvYcCX9ZL2McouQTSmhSmZdreDEPGYvShGN1UeGKhgjg34dek87zhA2ucMpxNuwVNmEQ5CoaJT8YO9SS9Y6vnv+3XPFADAa11zAbSxg9SIL
X-Gm-Message-State: AOJu0YyKHKB3W9nI5CsKXvvr/ns7QYcZGtweoNxc2BPcjM2GDemh7C8w
	5iN0qjFwXvJs/rZ+z6UppboZXM7LZjxo2lfLgpRiYc2nqb1Of+tGfEpW1kURzYpA0SjNSWmJWsJ
	+
X-Google-Smtp-Source: AGHT+IEAy+f4w+/Jzcajbg5rnkuzn9DVcYFe2lv/hmJoucFb8AAoUbo15n3rDzI0YgxpEZXplS0/3w==
X-Received: by 2002:a05:6000:4014:b0:343:2e09:58d1 with SMTP id cp20-20020a056000401400b003432e0958d1mr2500413wrb.44.1711732282727;
        Fri, 29 Mar 2024 10:11:22 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id q13-20020adff78d000000b0033ecb329f15sm4622520wrp.9.2024.03.29.10.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:11:22 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] media: mmc: siano: simplify module initialization
Date: Fri, 29 Mar 2024 18:11:19 +0100
Message-Id: <20240329171119.63992-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver's initialization functions do not perform any custom code,
except printing messages.  Printing messages on modules
loading/unloading is discouraged because it pollutes the dmesg
regardless whether user actually has this device.  Core kernel code
already gives tools to investigate whether module was loaded or not.

Drop the printing messages which allows to replace open-coded
module_sdio_driver().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/mmc/siano/smssdio.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/media/mmc/siano/smssdio.c b/drivers/media/mmc/siano/smssdio.c
index 065b572e0272..8199077faf36 100644
--- a/drivers/media/mmc/siano/smssdio.c
+++ b/drivers/media/mmc/siano/smssdio.c
@@ -344,30 +344,7 @@ static struct sdio_driver smssdio_driver = {
 	.probe = smssdio_probe,
 	.remove = smssdio_remove,
 };
-
-/*******************************************************************/
-/* Module functions                                                */
-/*******************************************************************/
-
-static int __init smssdio_module_init(void)
-{
-	int ret = 0;
-
-	printk(KERN_INFO "smssdio: Siano SMS1xxx SDIO driver\n");
-	printk(KERN_INFO "smssdio: Copyright Pierre Ossman\n");
-
-	ret = sdio_register_driver(&smssdio_driver);
-
-	return ret;
-}
-
-static void __exit smssdio_module_exit(void)
-{
-	sdio_unregister_driver(&smssdio_driver);
-}
-
-module_init(smssdio_module_init);
-module_exit(smssdio_module_exit);
+module_sdio_driver(smssdio_driver);
 
 MODULE_DESCRIPTION("Siano SMS1xxx SDIO driver");
 MODULE_AUTHOR("Pierre Ossman");
-- 
2.34.1


