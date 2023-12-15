Return-Path: <linux-kernel+bounces-607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E709814379
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D2A1C225B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC601802E;
	Fri, 15 Dec 2023 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="diDZQ6dA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E216433
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so4283865e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702628505; x=1703233305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEWvOGCN/u1S0GBF+sW6ffPiHV6fPcYw3Pxlfl13c70=;
        b=diDZQ6dAL+hEw4ZcfCvmcW8CO1xU2RwoC+hqXW082sNHLfKVqjSbZ1gt722hJOXe7o
         8NmvF+TOKGo7thhUftpn/HGmBwIJPMox27ZRC9ABuxlgGQx9azvQpc8mdV/+4aWbr3qf
         Mr+QhEz1AaaiYvbpiZvJXnbS7+PSnm3jYJfRFtd5RoJdnkv4UEFU4c2d2rE54n1LdRpp
         zEXcSSa8s9+mlyTLaICZOwT1JVv1O16VmtFkhhBacV1F1KSvlcllB6klr95/Yr9g50Zw
         dKvRE41mTj/Bev8O7KdCwF0jqVXZ73/pZoSIvlUy0ZPMD3XCQm20XNXktHrdHoVtFUYO
         GdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702628505; x=1703233305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEWvOGCN/u1S0GBF+sW6ffPiHV6fPcYw3Pxlfl13c70=;
        b=Vphty72BvCab3Q8l43xwOO/8EOW1GkR8F32563BdhK3rUQfdWCXpkbuckQWx/DXzcx
         go4O9Vv7d74z5XtzDhziRcx33I8k7ylri863mWEAJUFmiOlbxk4xnUWXs2N0z/A0rHUb
         fhH1C2dFUd1sIrt+hTD91sHt9sweYspLs/YsSdNR+Swl39HOnMWrHAHIeOtazbI0NG7U
         qLzxn0YFptDIJg+jcuokXfOnFr/hxG82fDHhTELUofxT6zvXZ11PmOU0mShSc1anVNxd
         gAbY7i/kyNbOO5r5ywhLWy2san9xNCn5BG7MsWU1xvo2eGMPAG2tLsbUHj7SwusZsRiI
         j0fw==
X-Gm-Message-State: AOJu0Yz0lRHc9gjx95fzi2ksn/yuBSRFs1LPeFe3eGe7IJPKT0iHRG7O
	xllYsRnc3iq7nFDwbge/ynnIvQ==
X-Google-Smtp-Source: AGHT+IGvO7zkyFnU8GsRJmvW+rPS2Q+LIghaAx6KbttBuhmMA07qt3UDlPud8epnRuHUWI8Gp3z4/g==
X-Received: by 2002:a1c:7218:0:b0:40b:5e59:f714 with SMTP id n24-20020a1c7218000000b0040b5e59f714mr2742618wmc.134.1702628505281;
        Fri, 15 Dec 2023 00:21:45 -0800 (PST)
Received: from 1.. ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c1d8100b0040b47c69d08sm30365570wms.18.2023.12.15.00.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:21:44 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: pratyush@kernel.org,
	michael@walle.cc,
	miquel.raynal@bootlin.com
Cc: richard@nod.at,
	jaimeliao@mxic.com.tw,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 2/4] mtd: spi-nor: mark the flash name as obsolete
Date: Fri, 15 Dec 2023 10:21:36 +0200
Message-Id: <20231215082138.16063-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215082138.16063-1-tudor.ambarus@linaro.org>
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=tudor.ambarus@linaro.org; h=from:subject; bh=IB4QfMo7QOIyKQXCF0nV7DFWobXewCSfAICOVpteVKQ=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlfAySVVu12IWkgPGS2uNZhNhqZQi2mTtOCZdp9 lPA+WdxHkmJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZXwMkgAKCRBLVU9HpY0U 6QRfCACQfEZgkzJZCB6bxYk+Nl/lieSKRnJ8+3ATk4izz80IDzr2Yp4EjAhhTGV/whZVhcXDLme Q5tkFn5g4y9u82uiX6pUCp8epAVuwNvOCgCcz975n0lFVEjZOroebxyRwuun9dvn8i3krcg6h4c vkx0fEf2RJYy/kVQyIsETwYFLreijtOqimzgdJKBYZaX7J+QiN9LdwCMKPgNjFjRdZ2Ypf0piOM npFhJwD7rqY8pCqVKmGyXtHdkO0bjSRl/35NKbNwJwMXI7Za4+v2PeBJx3k+kJJqGEVje4W5Mi8 D75HI+hO3ymNk3NMqNsG1dQvL4Q7NBeJyC4UbBiLd1cuBkI7
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit

The flash name is unreliable as we saw flash ID collisions. Mark the
name as obsolete.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 29ed67725b18..d36c0e072954 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -465,7 +465,7 @@ struct spi_nor_id {
  * struct flash_info - SPI NOR flash_info entry.
  * @id:   pointer to struct spi_nor_id or NULL, which means "no ID" (mostly
  *        older chips).
- * @name: the name of the flash.
+ * @name: (obsolete) the name of the flash. Do not set it for new additions.
  * @size:           the size of the flash in bytes.
  * @sector_size:    (optional) the size listed here is what works with
  *                  SPINOR_OP_SE, which isn't necessarily called a "sector" by
-- 
2.34.1


