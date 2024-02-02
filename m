Return-Path: <linux-kernel+bounces-49046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57DF846541
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439EB1F26149
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5105689;
	Fri,  2 Feb 2024 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uzsU+wtY"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095BAEAEA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 01:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706835911; cv=none; b=Eg8NiqTiXfqacd+5OOFTueDH6nuHF1JPDtFtd01F/3hvHOVugr7Zvb4bQP7VuI4pAYKuUYM0zb8IGI2LiEPUI6YTSKx/GLB9PiKSfRqUV6W8I1Whc+OGgQLaf+YWikBEJgwHIhbyKmf5MC4fP0ZQeXqUzt2qb4cJkOK5C9AlddU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706835911; c=relaxed/simple;
	bh=7PGtiOLQjanCi8F2lUfCU2lTtZMSLUVGqrAhBRM1FOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=janiQmRb3ewJRKkCBt/P10CfJmXaPVJcLQNQjfWI7kX8WmsFDB/AGN9Dint+oKAgFXmV/VVgMVFGousRbt3YS5qwaH+teniMHpyS88xAyfCDup7VySTDkmDBVssZfoOJ7iB2ToEfpSypd0O5RQ7DU12yg5hjc4eVk0RkSKi9YTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uzsU+wtY; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2184133da88so883402fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 17:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706835908; x=1707440708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1SwapE9xLdXkr+1FZM2yZImYM8kfTZEX3iqcU3VUeD0=;
        b=uzsU+wtYDGGXhPKLI28SmCscN92VLwtCyhPKDVcPbgtFAROQ7WqnLTi6fxqwg6PXTq
         rCJEAvF2g9H8Oq7gPJv5LMBw/xMvW6yPijLZU3XyQtswkpSslrPefqd5o6nXMCVxA6iv
         m+u/gfVw2R7mpp2CQCnvgoLBMA+SWDo2WkuP1mFBhrsT9qN4phiHfy/UvjNU7v5aei22
         EdqT0jXYE73cRQYka9uCbyBo9Ucb0PbB9aPOI0RqxwiTjW5kH5ag5xdb1VqcFRQ/d4DS
         zRXOp6ZYUxRkqBcLalmilnbmuGPu1zVkNPq5E4dmX9LqBgvpGp1fAauxU6pQ0S5R8iIh
         wN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706835908; x=1707440708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SwapE9xLdXkr+1FZM2yZImYM8kfTZEX3iqcU3VUeD0=;
        b=uzj/oJnb1Fa3BEgh+3HtqECoE1LfgQ99l6IJadI+SZSX/sXzQKPz6OvkpQ40jSy6FU
         3Uz6SgOMyj9au7zEm3cnKUfjamX5Y9X3SPyHSeQ4/FynuIR7Zi+J3cSCO3vDrOdm4eSR
         RL09Upv3J2K2AGXcri4UkuB34N7+FHIDkmHzcZU6LV53l6J2RCzFYOY9j9ArwdBEM2Wk
         jpzYKP2yABg3hx4aeHypLmggi3C09gFVGad3fKTESn/NyaZdj16vyxOajRPb9IHJZUi3
         cVJMpX+hOCJvmTtnhOv+wIytxfoZ8w3vLRueCoKWPwNc1AqPuRU6wZKQCMhv46q500vK
         8iqw==
X-Gm-Message-State: AOJu0YzpKrTf/muiC2o+xaR0+idjNvywz4r1Z/l8N2smGSHmFrLB9ruG
	kpY5MsmSeukOVCKVISSxkqwNA8hsdIOju54w/TQ3TezfAvteg4Nz5fYI8t7l/RQ=
X-Google-Smtp-Source: AGHT+IHHssTzP7MXolDOLkfQGC5ALneKZAZicvelx4/ifGxiL8zBzKn0w2ESMFFxOFjxQIO76cQMOQ==
X-Received: by 2002:a05:6871:4502:b0:206:c520:2811 with SMTP id nj2-20020a056871450200b00206c5202811mr4865347oab.2.1706835908098;
        Thu, 01 Feb 2024 17:05:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUQDuJuCrbniDvpUfQ6lL+8xFL7Q3VSs/I+mnU+pKKO5ifo8TpBvmZ3Tk05LFi+zq4+CoiHahvPWhMb/h72W/xpxRAwgN7eEArtvHJeEwuveMGeV+dQ5oOgNNN0dn3DxT8qSvFXMduAHdj/hzWkjmPsVFw758tdJzK/PHu+hTArsZhhsvN20QmcVJo2KKHHpjA85Ky/sVVobTLcIhxlUh4v+5m16G3zfAKGl7GjUNcegid5qHpct07cIiS8i8uvVMg/b24ZzqMJz0JMqbjoxsI0liL/zUHJwYDfwZK/96pvkyZOPDiS
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id ds43-20020a0568705b2b00b00218e9960187sm229534oab.13.2024.02.01.17.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 17:05:07 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: samsung: Remove superfluous braces in macro
Date: Thu,  1 Feb 2024 19:05:07 -0600
Message-Id: <20240202010507.22638-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 59f37b7370ef ("tty: serial: samsung: Remove USI initialization")
removes parameters from EXYNOS_COMMON_SERIAL_DRV_DATA() macro, but
leaves unnecessary empty braces. Remove those to fix the style. No
functional change.

Fixes: 59f37b7370ef ("tty: serial: samsung: Remove USI initialization")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index fcc675603b14..23cabdab44ff 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2452,7 +2452,7 @@ static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 #endif
 
 #if defined(CONFIG_ARCH_EXYNOS)
-#define EXYNOS_COMMON_SERIAL_DRV_DATA()				\
+#define EXYNOS_COMMON_SERIAL_DRV_DATA				\
 	.info = {						\
 		.name		= "Samsung Exynos UART",	\
 		.type		= TYPE_S3C6400,			\
@@ -2477,17 +2477,17 @@ static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 	}							\
 
 static const struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
-	EXYNOS_COMMON_SERIAL_DRV_DATA(),
+	EXYNOS_COMMON_SERIAL_DRV_DATA,
 	.fifosize = { 256, 64, 16, 16 },
 };
 
 static const struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
-	EXYNOS_COMMON_SERIAL_DRV_DATA(),
+	EXYNOS_COMMON_SERIAL_DRV_DATA,
 	.fifosize = { 64, 256, 16, 256 },
 };
 
 static const struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
-	EXYNOS_COMMON_SERIAL_DRV_DATA(),
+	EXYNOS_COMMON_SERIAL_DRV_DATA,
 	.fifosize = { 256, 64, 64, 64 },
 };
 
-- 
2.39.2


