Return-Path: <linux-kernel+bounces-43767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CCE8418AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76EC1C24443
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4025336136;
	Tue, 30 Jan 2024 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQA5UstH"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0EB364A4;
	Tue, 30 Jan 2024 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579426; cv=none; b=l1yo0oM/+4bUQn60DgZ9sLTnbM2XBy4PLsFWe6V7zUmcSOR/nfj9qWG+VaOkvtIeHmpADw9WO2iznj1wD/KjvsieKv5r1EMFZF6zUywUyZM4sJ5KjmlcI2XDpQtIT49q8xPiLt8hV54IGUTJdIIfA53BKOeTqDHjRbflY4x+PHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579426; c=relaxed/simple;
	bh=ctyGQzUBNYU8qBSBPjEZBOif3MsACRTFRapPZ12s724=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BQSyWtijkEeGJQjjxjbq3q5J03HIHfQIzZ9rHg+aMEgMUyBcWBx2+WaS7vF0iICYrUOc0uluFODDtadr062003W9iUQJSCN2yFW5FvA7ydyer5WPnqTKLxv5cFFI0hNrCsXzU/LrorBn52//hSAZGU4n16o2jpxttwA8F6PZTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQA5UstH; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6dde5d308c6so2325642a34.0;
        Mon, 29 Jan 2024 17:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706579424; x=1707184224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+/+BqCwMuDGeOCcrnZSnGmH94q8LFSE4MJFDmMTUoM=;
        b=eQA5UstHzDkd4K7t5kCKYds0s7x/zgF0aG5WEJRzXczP0Nn8E8Y81hF/mGV4DtdyX5
         +rXIk04oo7Akqw4p/Xzsej2L52w2ARD+kaw7ZIcWL6pcKrAL16pyHZCpCPpQdiloN3XQ
         sHfQH1yrP4Rfmnc2p5ORQUbk8vnezX71GKKtM2CEik+C1e61VuwKK1SpeKQ5tTfTrLf1
         9+diL4UqQ0FMIlUs116zqCKHPqQzmMpJjv+/ifJsDC9bJAsVifDurdeVOJhtnqQF0/+U
         owAiekTY0upOZsOTbRctvT5RzjjAxF3J0wfRfjd20UdWR/rrnE5JPucuZSliKlL0GGcS
         Z2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706579424; x=1707184224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+/+BqCwMuDGeOCcrnZSnGmH94q8LFSE4MJFDmMTUoM=;
        b=gEcYPWFddnyO+sdPgTFcmrCYr5I7PLwlH6KHujQ3oGo0X1ry0NmSa18bb7trSV/hWa
         EiuXO1tlIyio7ouG3Qm/9j9gJ4YbwvMUMTvmUGIHtNk0DNuilBoBrH/CXKtGkZC/476/
         H9u3pKgxmTLlN/QSU2Ukb7wrN5ThrOYxDS4STqBWdv/bfxv9jIOf4qR/PEjSvfspaJAR
         w3IvoOBQSs6WV5QR8Zbiy+zr8zcJPo4CmIY/4HSyb6fdHUM+4tCMrEg8MqB50Bk/czGq
         K7970S1iYcGrj+ZCUrxl8ebvxIQq9CUFJEFMBDlYgxA8Pshh00fw8nJZlTF3SqpuBmIy
         JBnQ==
X-Gm-Message-State: AOJu0Yx5p7Bykndk2wcmxv+O2+jLBQrSO254o+JtAlqJBMkOI2FB0tcR
	ISoVkTyjRkhcLvRKsqVBr62MXJwbKZKlULNB15FtjOocpszUY1+Z
X-Google-Smtp-Source: AGHT+IFq9Xk7811v3ADb80CtutRY0zvjWZvOVPlUhN9sU9gbnK+EK7WvbooNwP/qEMA3CSlitF72rg==
X-Received: by 2002:a9d:7855:0:b0:6dd:eaaa:a33d with SMTP id c21-20020a9d7855000000b006ddeaaaa33dmr5219120otm.21.1706579424090;
        Mon, 29 Jan 2024 17:50:24 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id z24-20020a056830129800b006e13a9ff830sm194148otp.53.2024.01.29.17.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:50:23 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	p.zabel@pengutronix.de,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v3 2/4] reset: simple: add support for Sophgo SG2042
Date: Tue, 30 Jan 2024 09:50:08 +0800
Message-Id: <1cfd7b3ba447942784c4f7aa595e962399e9f617.1706577450.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706577450.git.unicorn_wang@outlook.com>
References: <cover.1706577450.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Reuse reset-simple driver for the Sophgo SG2042 reset generator.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/reset/Kconfig        | 3 ++-
 drivers/reset/reset-simple.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index ccd59ddd7610..2034f69d5953 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -213,7 +213,7 @@ config RESET_SCMI
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST || EXPERT
-	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || ARCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC
+	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || ARCH_SOPHGO || ARCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC
 	depends on HAS_IOMEM
 	help
 	  This enables a simple reset controller driver for reset lines that
@@ -228,6 +228,7 @@ config RESET_SIMPLE
 	   - RCC reset controller in STM32 MCUs
 	   - Allwinner SoCs
 	   - SiFive FU740 SoCs
+	   - Sophgo SoCs
 
 config RESET_SOCFPGA
 	bool "SoCFPGA Reset Driver" if COMPILE_TEST && (!ARM || !ARCH_INTEL_SOCFPGA)
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 818cabcc9fb7..276067839830 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -151,6 +151,8 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 	{ .compatible = "snps,dw-high-reset" },
 	{ .compatible = "snps,dw-low-reset",
 		.data = &reset_simple_active_low },
+	{ .compatible = "sophgo,sg2042-reset",
+		.data = &reset_simple_active_low },
 	{ /* sentinel */ },
 };
 
-- 
2.25.1


