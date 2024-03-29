Return-Path: <linux-kernel+bounces-125223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D989226D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CAC1C240C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D921311BD;
	Fri, 29 Mar 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJ6wQ72T"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711739FF7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732231; cv=none; b=pSi98T8wcM8a3imvGHRc/jL0gb647/vUx4gz1aB4IQ4aWLxTcqTKIsHSPDrZb8iY5bf0vuCAPLjMrz/ocFVQ1dF5fFDvDZbI6t+O1XjmTPnNgf0B6Ju/rz+iEZU6Wg6sIHZZ5a7O8M8F/oEmleIfTBISx5B1x8C20MaesC3Fdec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732231; c=relaxed/simple;
	bh=Uau+Vd08xpT0jTfyRy7WJ6vCP5AAkr/VcXUgsWmBkTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NrTEmGHsbPSHhoCY00AV4BJZrKCCEN6ff4+pTHfaKL4WkN8VVpqesKB2CUPr6niaNwT2zk69ENeIszdGdeMZp+ygKL/Z/kOdxYlpJHtrBbuvB3kMgB21Ify0BTkm4sqLM7RBhu8r6IbXHHvpq1BHbQ+10pI2O0Mf5RVAakSiFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uJ6wQ72T; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-341cce3e5f0so1892721f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711732228; x=1712337028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=scJlWaAaKpFFDTYwmXG3k2pA63Nw8VkQF7EI66SPrBk=;
        b=uJ6wQ72TR/ul5nkgmveVmNK5sAopsS27F+tR64QLWvM0hJtIqGlUdjVGhWAioZFxpU
         HukQUBplFCRBE16F6EB5iWUVhrUMqFqfY2CxAfjnMp5SzFtMxHJYMZ5mGOvbajC0XmoZ
         a7DhYk63xKafnjgOKapS1nZs0bHlYqMW78UHL37Y/8noJ1AsRYoIjYieFY4bjnc9AVQC
         xLEgz3Y29y3z4P/vbstnIGKADSTFvdoGCA04XeQqnyaeMP4Yn5XaU1twD3qwZ/ZjWElY
         5YtMfyATHzAApkA2i2m+g3lRCWOjthUUZVFV50/uXAtlJDRGMsuICo/AUzoFWm8D35l7
         UjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732228; x=1712337028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scJlWaAaKpFFDTYwmXG3k2pA63Nw8VkQF7EI66SPrBk=;
        b=SCF2Zy+oz59GcSw8BkMnqTdZ1xAXOXjm8cK3Ez4Kort3U7Xtyc06ezz1zPGpLT3aM+
         kTI/ziE6DJYRzUA2H42LUKB7xiou/z8Oqdv5BQHcuEkxf3Xyfqt+gUgvfE4GZxm8afL6
         kygd41B8Y/nf/CsBiu0MupXZhHuJIvTuEJajgbXb3cnXaucXtMyVsnWh0rh2DnKQ6NhG
         HbEiZyW5B8ea3kKbVtpexwl5kazWGmYvW0lPz0FAbKf0rUjNjwSfCfrT1tiymZikzrZ/
         lyeOMtQ2OtW2ub9HAjXZXHDXdEYQhQ5eOoCLhZCH3Vstdr4v+HmlEheBGz5MredC9wz0
         E6EA==
X-Forwarded-Encrypted: i=1; AJvYcCXy+3C4KdLZtkBMbdYi5x4/00LyVwzSKojqYG7CDs0Du0r7l1C+SQA6YsgRx8Uz5mBAcbgMMHR2S8JgLamfLbIF07k/PzCm+FoM6uFu
X-Gm-Message-State: AOJu0YzRqe8aDa/7/76Z0Of7liqGcv8mFKuxXB8Fr5WZuWzm2pBl4Wa+
	9o9iedH05B6ZvSVUc/0U1Xk3m/0kXCR3O6Rc87i6r0SpWqBSulK/HTcOUzqo4Uw=
X-Google-Smtp-Source: AGHT+IGDQp7e0jPhkOMyziKZaKLfPE5T5Kcol2EeQhlM9DkpzIZIjFl5zFSJ3My5eoSqC7Y7mRV5qw==
X-Received: by 2002:adf:ee91:0:b0:33d:2474:5aa with SMTP id b17-20020adfee91000000b0033d247405aamr2185921wro.40.1711732228295;
        Fri, 29 Mar 2024 10:10:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d6851000000b0033ec9936909sm4577665wrw.39.2024.03.29.10.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:10:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/6] wifi: ath10k: sdio: simplify module initialization
Date: Fri, 29 Mar 2024 18:10:14 +0100
Message-Id: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
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

FYI:
I have ongoing patchset touching few lines above this patch chunk
(sdio_driver) which might go via different tree. If that patchset is
applied via different tree, it might result in a trivial conflict, but
there is no dependency. They can go via separate trees (except that
trivial conflict).
---
 drivers/net/wireless/ath/ath10k/sdio.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 0ab5433f6cf6..1acb9fba9a8e 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2671,25 +2671,7 @@ static struct sdio_driver ath10k_sdio_driver = {
 		.pm = ATH10K_SDIO_PM_OPS,
 	},
 };
-
-static int __init ath10k_sdio_init(void)
-{
-	int ret;
-
-	ret = sdio_register_driver(&ath10k_sdio_driver);
-	if (ret)
-		pr_err("sdio driver registration failed: %d\n", ret);
-
-	return ret;
-}
-
-static void __exit ath10k_sdio_exit(void)
-{
-	sdio_unregister_driver(&ath10k_sdio_driver);
-}
-
-module_init(ath10k_sdio_init);
-module_exit(ath10k_sdio_exit);
+module_sdio_driver(ath10k_sdio_driver);
 
 MODULE_AUTHOR("Qualcomm Atheros");
 MODULE_DESCRIPTION("Driver support for Qualcomm Atheros 802.11ac WLAN SDIO devices");
-- 
2.34.1


