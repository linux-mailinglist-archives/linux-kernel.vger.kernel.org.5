Return-Path: <linux-kernel+bounces-3339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C46816B32
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38571C22728
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9018B13AC2;
	Mon, 18 Dec 2023 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3atk2b7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A44D14F7C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c2c65e6aaso34562485e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702895425; x=1703500225; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iU1lhXR5gZm4tFUOyUKe/ySso0cBl9UN6mf5vn/m5Rw=;
        b=D3atk2b7Jn92JP711cNMKnwxPfSyCrvzuBbuCaFBQsZj2cFPKwdNiPIu8N1SMzLgy8
         8Gz2n8EuL+94uJfoO4xaHjJo4rs5H/rA81/z2fgDx9u7+UNThlmn5gjiUTj+Lad6gF0X
         0QTE6Pb3JdkxNCK2TghsZCZUxZXP6spfCtWBvZecpOS6syCvp7LW+lxnLBiGl6w/Lt4g
         ooqeCHLSjVt5Q00Vt1MB8g9tGsQBmBCm4fN7k/FsTmP4bOqDwHRJw/NNeKj6FAjhctRK
         aI84b/s37uJRoYxjXguyyFafRfKBM888auflRg0SibujzOiCw6HSUu/PuvwaxUVJlZQK
         J/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895425; x=1703500225;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iU1lhXR5gZm4tFUOyUKe/ySso0cBl9UN6mf5vn/m5Rw=;
        b=QFowc7+waXLq0eKa17osJ17iuqcr0+9/DWxoYvS60zVT4Qybj4bE+3sjOOxoM77/WD
         IA8mNXulcu+ihm0+T3Hc5vOYkjYpv3aL0j+YDtD1rU10JoVGZyOmMssn/tAhxYnZNwXi
         sC3NJNUf1oIssXiH13z6dmOpOa+q/d+B7eXEEqY4E6JrNaZDlc/RrXkqd0fU95P5OxHD
         5KFCiCR9XFa0FFxwe8vIZ0zqpldJr66ms7dOKcE1YdqldaBHLUqMFEWi9v0leqH0fz7P
         1n8/RP9DyI2xyxwj6oqYSYSy+BJ9YqWZC0/OMDAp+vX5yJ77EiLLvndrvor3TJegNjAV
         FSuQ==
X-Gm-Message-State: AOJu0Yz3FuorLk26DptxLu+odGUaA9VV3jlxRlBBogSRr5qoONYPYJSG
	V8bgL087CWMrKV+dPeHxJZKM7w==
X-Google-Smtp-Source: AGHT+IGPseYqfva1RIExZdMNDFkLibsv9Q7zJDn2klSr+VO/6FVtBHoOUoOsHkGucbiEaLLTM96I2g==
X-Received: by 2002:a05:600c:3103:b0:40c:4b3e:bd08 with SMTP id g3-20020a05600c310300b0040c4b3ebd08mr5864134wmo.92.1702895425111;
        Mon, 18 Dec 2023 02:30:25 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x6-20020a5d6506000000b00336505c4ef1sm9157600wru.75.2023.12.18.02.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:30:24 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 18 Dec 2023 11:30:23 +0100
Subject: [PATCH v2] arm64: defconfig: enable GPU clock controller for
 SM8[45]50
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-sm8x50-upstream-gpucc-defconfig-v2-1-e5892470a10b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAD4fgGUC/5XNSw6DIBSF4a0Yxr0N4CO2o+6jcUDhgjepQECNj
 XHvpe6gw/8MzrezjIkws3u1s4QrZQq+hLxUTI/KOwQypZnkshaSNzCHSBry1G8thyXmOaGawMV
 FazBodfCWHNRYGy275oW8Z+UrJrS0nc5zKD1SnkP6nOwqfuu/wipAAHaiNZbrRtnb401epXANy
 bHhOI4vkVc+DdsAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=NArf2Llfo0fGUpngpSXnVQbG686zND4st1NpA4HTQGw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlgB8/taJ0l3Y77Rt+Q7vvhGJCYNn9YDtmuaZbo00f
 iz/rKw2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZYAfPwAKCRB33NvayMhJ0d3LEA
 Cjaj449t5/p6riKNUL5qqpWt++YrLGtjexgL6OVZ9mbmsYzY7edT13rPEx9Ly2CKA8O/qO2uCX+iVO
 VxNqoKKnUnzsZHsIEaYpVBa6kn1wY7o77ZrI/GB0cd4B+r+yoh8r4TZT6SKpp6PqURy+Urfu8ZZKTw
 U1fFQQwzTz15Fybn0gDSUp8UOdgmzRB4f3VCMsVefrpJ5tBk5YwAzko0klP1fbg/lSsc4ZhTanXgty
 53+82PCnbXjPzqbWesLevVcCuX17PCKT+1l4JTV6EAVSA3Ss/hNUb3+18qqCbDoF8+mP0tUGYuB8iK
 22BHJqK2tMF/kNj3evayAkJUdLbbkpW3qcT87hxsYeHXaDWf3SZJEuSZ9/KxANSalJZwYYUb5djVYx
 QoSKxzTSF5BoY44AlzRLaZ8G+KCa/Y+BaymjPOR8RMRp9wyfU4ilPhOHBviWFDZJjUse4+aEJa717A
 k8OTTVYSXGEKZ45eK1jX4maS2WGjfFSYjtozY9jhT0XAlbx2VL2bL6kE2QrvHCXxrQDq4GIw7z5HJW
 xl2ZM+3rEY6Bm8fNieuH1l0VPP1d2vpm7P6teAjZ7BfrBzluDuOF930++RJFvjQY6j6YHb4HwRDjNk
 NSFm6d5zA7bh01XLNmXGVqseCYcflPcOXaGCveuXd0M9F5aCY2q8uBs7NDSg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Enable GPU Clock Controller for SM8450 and SM8550 to allow using
Adreno GPU on these SoCs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Switched to =m since there's no reason to keep them built-in
- Link to v1: https://lore.kernel.org/r/20231204-topic-sm8x50-upstream-gpucc-defconfig-v1-1-e615df0c4af9@linaro.org
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5ad2b841aafc..fd59c9ba5983 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1266,6 +1266,8 @@ CONFIG_SM_TCSRCC_8550=y
 CONFIG_SM_GPUCC_6115=m
 CONFIG_SM_GPUCC_8150=y
 CONFIG_SM_GPUCC_8250=y
+CONFIG_SM_GPUCC_8450=m
+CONFIG_SM_GPUCC_8550=m
 CONFIG_SM_VIDEOCC_8250=y
 CONFIG_QCOM_HFPLL=y
 CONFIG_CLK_GFM_LPASS_SM8250=m

---
base-commit: 9046d05c6ad632a271fc4173624e26f396975a80
change-id: 20231204-topic-sm8x50-upstream-gpucc-defconfig-3e3dc264be08

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


