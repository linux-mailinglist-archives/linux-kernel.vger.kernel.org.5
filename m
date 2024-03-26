Return-Path: <linux-kernel+bounces-119507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 752E788C9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31EF63252AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1F31F94D;
	Tue, 26 Mar 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NgAbQoFx"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4871F95A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471715; cv=none; b=AuB/yLGPrMD9UPd+THk4De/MwlbzInlLYBUkAJbnYJytceE3qt2TylpOt++hJjfMy9fhqVYp/vV5F5erH7vTIEv90b2Fk+ALtk/Ultr2wJWD6ESnP6VxK3utxiCUbr+u5rywaveIqXdcbb66nLlrkOjBd+SUzRvMiT81bBSHbT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471715; c=relaxed/simple;
	bh=UCmlrZz5wIpqDNxx5pcqKcqwMTpJe2YHlubTTGszCI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3Nl70Ri9UQOwoH7isyXVL5RusZg9GuGtTZemJrm1WQlVluMF1bb9cwKXRKNX4fuGtADyF/tpmbJo8k4/bPQLIleAb0zGjeCMjU+SEAfFyjy8+m7jilDy+QLTNte83HbjCePZtjVqeFLpdXIujqxwolcAlUyHZonvgJMxt43oB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NgAbQoFx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41490e42c74so2883515e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711471710; x=1712076510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUX0Fe8KaQL1u5v0D+HurQZKsoXBEzxwHFFOyTDa+54=;
        b=NgAbQoFxb03SX/9WndFalmq1spl8kPkm8Co80Kl/iEiAXQgu9eyXYsR16IuF79Mu2l
         vVsKzvybRhPPI1UU3TRcCt0OL9LCb88a2HBI7MVAorKO1CwM4V+su/svPPPPBYeQOJU1
         3W49J3Yw29mAlnwrgIf8CZIfSFnecK/wEuIgg4mrfpUIVJfx9+tfqHKwCU6pgGHkgCIP
         MExXknojh+gorKZBes63BoF+eVHoc46fecgxFU2kzpkXWFVQlC0XggMLXOwcq3lJGbyo
         xt81qwfWHd0xPsAztrUHj9mWSHgrfrPe3s52kF+7pKtPGmodTEYiH4UwzBP49SutumUI
         U/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711471710; x=1712076510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUX0Fe8KaQL1u5v0D+HurQZKsoXBEzxwHFFOyTDa+54=;
        b=V7gendyxspZewJr7j4XgRauAPYuE7I9jKC9DnBvyOKhJXBHJuyeyRJ+2ZOQWK1NIBD
         /jNWHzavdwF8Bu1Ir0ac9vMcDSp8v/LxNmF0I9lM1I2iiy4PXjqU+7hdXdKSUES0Gsgt
         giaXDv0ejgOvyAE6VmZAYGuD/ojlQvoc09LMc1KnL6oGkOEv8cIv8qHw5JmbWU/KJb77
         BKq5geKyfHwpnBc89E4sU8rQu/b+a9DKNW2CJyelaI8YP9Pdj2AHXe23hyMQDvn5wGYP
         Lx5V9uvzmWDbzD6o702Y5I/mzGA2pt7cbwuMqK2Xz/TL9N8uFTlAnhX4LF898N6LYTLE
         MoEQ==
X-Gm-Message-State: AOJu0YyQuM+7w+y3CnZHB7b5p/VbmVkauC2Z6g+V/6nCWllfwQQJVOUv
	72p1R4jGI1sN8JeXbBXUYhXL/1P2XpRddZRSJ7OwWFlsnI/kVV2q7bQtkw2fukO6gV59T5frOnO
	jPKhiwuWd
X-Google-Smtp-Source: AGHT+IGSD6SX1h+XJYSDCQWy+wNksm/8PaF5+BJG0gN4k4HXxpQXN5S50Qe4XQBW+X7oG57o0CzNiQ==
X-Received: by 2002:a05:600c:4e14:b0:414:925c:a860 with SMTP id b20-20020a05600c4e1400b00414925ca860mr353338wmq.11.1711471709882;
        Tue, 26 Mar 2024 09:48:29 -0700 (PDT)
Received: from yamato.baylibre (alyon-651-1-22-137.w82-122.abo.wanadoo.fr. [82.122.123.137])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c4e8a00b00412e5f32591sm12135535wmq.28.2024.03.26.09.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:48:29 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH] MAINTAINERS: update Angelo Dureghello e-mail address
Date: Tue, 26 Mar 2024 17:47:33 +0100
Message-ID: <20240326164733.15271-1-adureghello@baylibre.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update my e-mail address to adureghello@baylibre.com.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..c3e365b9d759 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8512,7 +8512,7 @@ F:	Documentation/devicetree/bindings/crypto/fsl,sec-v4.0*
 F:	drivers/crypto/caam/
 
 FREESCALE COLDFIRE M5441X MMC DRIVER
-M:	Angelo Dureghello <angelo.dureghello@timesys.com>
+M:	Angelo Dureghello <adureghello@baylibre.com>
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-esdhc-mcf.c
-- 
2.43.1


