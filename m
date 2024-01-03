Return-Path: <linux-kernel+bounces-15519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE936822D29
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3479A1F2420D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DA019442;
	Wed,  3 Jan 2024 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dbb8Q4bR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F618ED9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-556cd81163fso545950a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 04:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704285372; x=1704890172; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+s0dp5DatYp/J08ZyMTNZZ+6BOa/8d/K9WWRhoOwgwk=;
        b=dbb8Q4bREAgqg2O/0WZg7vzaHoBjokOt3xYNGXitczDVqUXi6S8z7o2fvXsm9K3QB3
         J3UPLElRLbtpUGB0tSgxfkfEeIwB8CTjPEs008hKX++YiBgZ6pskPNtjVhLtmHbvje0K
         T5PjIgrEn8glssCm+99fGoy/ey/U0abnPxN+BXrLAz2lz0MC85fQ27LcKyP3nmnEPYg/
         8HHI/BnAl2jkViRCQxyxSXImmlDdvJgWVDzrUx9nbz02gx5Yh8nr+NYUGcQqCuTAR3rc
         pmbJdOoPmcCQ0mE78jRQh+c7IXIIsUnYmd0uKR9XwKC6P6S4Sm8/jBEf4/T/rwM3bUdD
         8tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704285372; x=1704890172;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+s0dp5DatYp/J08ZyMTNZZ+6BOa/8d/K9WWRhoOwgwk=;
        b=YP1yzO2HO4EYVozh0UBf9wP+n/msNmeXXSvRBb9FAsiBp3MvQoIMC4uwwmlQRvQh7Q
         Nrp8q3AtlEcRUY7wRaS6WGrNB15wD72e0stz9Gl/miBPZEeSSN/nNFPLswaaN+p2Oat3
         t5H/hMttHT+sM2V4nyXqS3iwttmQcehdN7FR7UE8rL/MwB3xSMcz3x/pURpCZXK96O7x
         i+AO1EdfORuqj5/+3gm/KS5Mq6JYM/eD9MH0+BMuF187Bey+qAvMvncZwnFwUy+7ljyN
         Q7rAy2FPFNow2Klv6dD+Cc6ejxOroaj2krXuH8e2C1T1Ey5qLmToJUHqfRdq55cywWga
         kM/w==
X-Gm-Message-State: AOJu0YzrjYdTHiufEo2fZbmrwktirXaKRD980bUHr1xBCPShKy9GO74B
	l0AobxsjdiW1IGWy1P5xFOwHjKmwdnwy0Q==
X-Google-Smtp-Source: AGHT+IHTlIV+MUjfHZN7D2+8CQ5/YdFs4/QpJ1lfvSWj3f2hRKi89REdhRo6RrqHGFuZMpezboV/nA==
X-Received: by 2002:a50:9e67:0:b0:555:1b4f:6908 with SMTP id z94-20020a509e67000000b005551b4f6908mr4543723ede.49.1704285372272;
        Wed, 03 Jan 2024 04:36:12 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id r14-20020a056402018e00b00556d13abcc7sm675362edv.85.2024.01.03.04.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 04:36:11 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 03 Jan 2024 13:36:08 +0100
Subject: [PATCH v2] power: supply: qcom_battmgr: Ignore notifications
 before initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-topic-battmgr2-v2-1-c07b9206a2a5@linaro.org>
X-B4-Tracking: v=1; b=H4sIALdUlWUC/x2N0QqDMAwAf0XyvEBbdYP9ythDGqMGXJW0joH47
 5Y93sFxB2QxlQzP5gCTr2ZdU4Vwa4BnSpOgDpUhuNA571os66aMkUr5TBbQ9+wfI/F9aHuoUaQ
 sGI0SzzVL+7JUuZmM+vtfXu/zvACz+6zvdQAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xilin Wu <wuxilin123@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704285371; l=1885;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ODWm1IaDFE2NpVyeLRbMWGZv/BmufuK6hOWy1KUm/rA=;
 b=6xTIV3xZVCCi3rJJfDz1pUorgA2CokGIroSqeYNyeHh36OAyoaP1TPok7oC34p0G980+P05Ey
 DSaKETbABwpD4sLWwsxOB9fhDShB/2S3wqVQpTCqW5tFWQHCiYKni7R
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Commit b43f7ddc2b7a ("power: supply: qcom_battmgr: Register the power
supplies after PDR is up") moved the devm_power_supply_register() calls
so that the power supply devices are not registered before we go through
the entire initialization sequence (power up the ADSP remote processor,
wait for it to come online, coordinate with userspace..).

Some firmware versions (e.g. on SM8550) seem to leave battmgr at least
partly initialized when exiting the bootloader and loading Linux. Check
if the power supply devices are registered before consuming the battmgr
notifications.

Fixes: b43f7ddc2b7a ("power: supply: qcom_battmgr: Register the power supplies after PDR is up")
Reported-by: Xilin Wu <wuxilin123@gmail.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Fix the commit title
- Link to v1: https://lore.kernel.org/linux-arm-msm/d9cf7d9d-60d9-4637-97bf-c9840452899e@linaro.org/T/#t
---
 drivers/power/supply/qcom_battmgr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index a12e2a66d516..7d85292eb839 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1271,6 +1271,10 @@ static void qcom_battmgr_callback(const void *data, size_t len, void *priv)
 	struct qcom_battmgr *battmgr = priv;
 	unsigned int opcode = le32_to_cpu(hdr->opcode);
 
+	/* Ignore the pings that come before Linux cleanly initializes the battmgr stack */
+	if (!battmgr->bat_psy)
+		return;
+
 	if (opcode == BATTMGR_NOTIFICATION)
 		qcom_battmgr_notification(battmgr, data, len);
 	else if (battmgr->variant == QCOM_BATTMGR_SC8280XP)

---
base-commit: 0fef202ac2f8e6d9ad21aead648278f1226b9053
change-id: 20240103-topic-battmgr2-15c17fac6d35

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


