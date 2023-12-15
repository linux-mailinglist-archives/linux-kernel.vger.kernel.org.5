Return-Path: <linux-kernel+bounces-819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBED81469D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2FF91C22BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43E12E633;
	Fri, 15 Dec 2023 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UF8HDZ0/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D52DB87
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-336417c565eso399108f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702638957; x=1703243757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oz5guiKfUu5OkDBbdm/LWYtpQOKOV0guWSD3BkGnL4M=;
        b=UF8HDZ0/2AoYrajwOFa0iAZwufNoL+V7QaYLRPM4det4QnOqDbSUTXGB4jV6gG4Diw
         e5etBRCEjJm74WHK6+Uv8f4AvFsvy/616WFgb/gPiZpdv7zD9L4rT+JkpG0Q3lBesjuw
         J1XgIziXIj2Mq5aamNAjKFNnll+oErWyfj6pS9OiIwd38Gy8rwBYJQx/3ZobermqJxdq
         +cITS361gYPi0H3zTC9PsOmLPMsudB9GbY7QKhqqxwdLgXAxHo5+ZV39qoTA1S0JZdGk
         C3WsRAVZUMM2D0rpqgxIj+3Htett5m7d0Ch/z3uCWNe+OzySxg+AB3xrWEUL2ZRyDgOu
         LoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638957; x=1703243757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oz5guiKfUu5OkDBbdm/LWYtpQOKOV0guWSD3BkGnL4M=;
        b=LqMgsGdPyEECUGq81J5/E03Sy5H+d6ner8gqH2rvcE5lZWaG91oAJgKc3GcjWJ248i
         v2+EYIQETgt/ZM1/lwUfGHFu/K8VXaHTR/C6w5x8TsISCZQa1xr+ghHpRrZecT1/FzFw
         HC5GrjfHtJ942gu39jfLxIpruwBJgxp0AG0C/hl3Bk9cuZjOgas710ihzQf95e4OcbEr
         VpU89yZFllfxXFznGWfonEujJ69+suRcn7GU0lvPTBjpUzdOuJoI1NGm3XkRoxgXm/ZG
         vRhZSehPCwzo2xzKaeSKYMvoBRN51AHC8pKWPZMLLapFoZUpDbaIZiT4vbJTKCjEkDCW
         SCug==
X-Gm-Message-State: AOJu0YylUkcohLyBIOhtqu4XS0+P/c7EhJgjla1vjIqcw34FwU4suDWb
	/vhfNXed9QqgNkuG3lzjmxBiKg==
X-Google-Smtp-Source: AGHT+IE0eyG/kZrxQ07tUJgniLeOXWkHI7YVXgUUzf5+6aPrP0/Lv6ASYjILCNUOFz/kURIq2ZjZfQ==
X-Received: by 2002:adf:fec4:0:b0:334:b2ba:7244 with SMTP id q4-20020adffec4000000b00334b2ba7244mr3997319wrs.174.1702638956919;
        Fri, 15 Dec 2023 03:15:56 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g13-20020a056000118d00b003333d46a9e8sm18511497wrx.56.2023.12.15.03.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:15:56 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/10] nvmem: stm32: add support for STM32MP25 BSEC to control OTP data
Date: Fri, 15 Dec 2023 11:15:36 +0000
Message-Id: <20231215111536.316972-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
References: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2231; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=4O4WBaJhnw+j/8i/dvSP/B2/3NEdWuXi4KfR7fhrYm0=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlfDVYlyX1V5fA3OGAmnHqciQ/gqZpouklcrtwJ uWQX60PZ+OJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZXw1WAAKCRB6of1ZxzRV NwCBB/0SEYgVT+0cRSdc9Epo1PpmIEag/pDdzgwIBM7Y49/eIwUxUHZN1AHyQqaW3is6i2iO4FN ChjUjrnd1gIkmbfDobB6DuY+9QW00GNjg4kcDixxYmO1+Rk646SJrnacW2vSmtQtQzU+82rOGKm GVto3RE5tbDUcMqTQVyOlX2DLkPtKGJs6QeEFFOdn6CSV8nTTfndNuZZuxdo2VFCMIkTGnKZcFP kygxBPd3YSzbSaT0BiyHAhnPdjipqhNbOLJo2ExboZ3m2bakxdOjRs/XfobPC6dSfUtpcS8/lvl mgxkX8TUosjv+bi43X6jmqA8iR0pXJ23u4G+Tnm09iel+NYb
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

On STM32MP25, OTP area may be read/written by using BSEC (boot, security
and OTP control). The BSEC internal peripheral is only managed by the
secure world.

The 12 Kbits of OTP (effective) are organized into the following regions:
- lower OTP (OTP0 to OTP127) = 4096 lower OTP bits,
  bitwise (1-bit) programmable
- mid OTP (OTP128 to OTP255) = 4096 middle OTP bits,
  bulk (32-bit) programmable
- upper OTP (OTP256 to OTP383) = 4096 upper OTP bits,
  bulk (32-bit) programmable,
  only accessible when BSEC is in closed state.

As HWKEY and ECIES key are only accessible by ROM code;
only 368 OTP words are managed in this driver (OTP0 to OTP267).

This patch adds the STM32MP25 configuration for reading and writing
the OTP data using the OP-TEE BSEC TA services.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/stm32-romem.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 8a553b1799a8..82879b1c9eb9 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -269,6 +269,19 @@ static const struct stm32_romem_cfg stm32mp13_bsec_cfg = {
 	.ta = true,
 };
 
+/*
+ * STM32MP25 BSEC OTP: 3 regions of 32-bits data words
+ *   lower OTP (OTP0 to OTP127), bitwise (1-bit) programmable
+ *   mid OTP (OTP128 to OTP255), bulk (32-bit) programmable
+ *   upper OTP (OTP256 to OTP383), bulk (32-bit) programmable
+ *              but no access to HWKEY and ECIES key: limited at OTP367
+ */
+static const struct stm32_romem_cfg stm32mp25_bsec_cfg = {
+	.size = 368 * 4,
+	.lower = 127,
+	.ta = true,
+};
+
 static const struct of_device_id stm32_romem_of_match[] __maybe_unused = {
 	{ .compatible = "st,stm32f4-otp", }, {
 		.compatible = "st,stm32mp15-bsec",
@@ -276,6 +289,9 @@ static const struct of_device_id stm32_romem_of_match[] __maybe_unused = {
 	}, {
 		.compatible = "st,stm32mp13-bsec",
 		.data = (void *)&stm32mp13_bsec_cfg,
+	}, {
+		.compatible = "st,stm32mp25-bsec",
+		.data = (void *)&stm32mp25_bsec_cfg,
 	},
 	{ /* sentinel */ },
 };
-- 
2.25.1


