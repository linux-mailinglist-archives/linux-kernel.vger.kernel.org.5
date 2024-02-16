Return-Path: <linux-kernel+bounces-68440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D15857A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91BC5B22853
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A0324B4A;
	Fri, 16 Feb 2024 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UM/aahXc"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25324B50
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079103; cv=none; b=G/D9pIvWvZmTOXzY3GgQtz7R4BtfTGt8Wzb5uiVfrSJHTmCyufp+L+lU4t9hSY26PHliFrepZX471iq8iYBjgwC4/L8jCSrgr0qZ+UcylcoH5tQKyN+Os5HiwBuY2U12fwFf4F6MhX/qyo+f+jUp07XNG2PfCw4w3tHi4Vq3W4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079103; c=relaxed/simple;
	bh=RdNpeE3d+oW3k9ivrv9Mt8CvCnEdyMVqc1Bql/ZN4PY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eZglw1tBSUvqs6ZfLjazJePdb6dBFUovU1WTpaDBbwX2xjIgn3Bpa4/P91km3zzyaH2niE9TAvTsOcLKlsdQP22NV3GIU611zhM/AvVFxPoit4PULtFml6DjZPaXWboEeQudYQGJ336nGzhSo4UGSUi21AIlMDmBFWjsQx3o6+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UM/aahXc; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51182ece518so2231855e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708079100; x=1708683900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9uwpxzD7wxs4tMFhIUi84X6jUwWhqp/NQm+0nfPH8IA=;
        b=UM/aahXciZlLYHfxTdI9OXA3DvoKrpnvGJ1K2CBDNzfkVbUzRr672q7PDqvjfln/Np
         RZ1BF1TRjybdeVqknWBojcrxTk59vfeax6KTnwviSqDiTUlV3hEE/4DYfRClQSKz6ZyU
         5EdOnL3y4a8A0AqCm2mo9NtVx/85+p9k8PU9wQWbka37NqtG6D2Xr5JUvwUjCACKLNkK
         C36Ch0/nfsK9P0QuOZ8aahLP2uwQ1ZHZKe/H3VT2S8ePK48VFevHITFKJCs8/sFcoUxN
         QANUvkyX0fSwILlSTZb8MFBxjQA9k0Iyp2JpgBFz3Mcu0DW4dVAsuYd8TuYx3kxMTNcN
         IalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708079100; x=1708683900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uwpxzD7wxs4tMFhIUi84X6jUwWhqp/NQm+0nfPH8IA=;
        b=fVLjYnhP661iNGw2AQbDaIgGmGTuHHN6Gkl5dw87eBAK4VJA3fDXV2Hetp5EY35fu+
         FXhg19fEOcAmR14Ioy7OWXKCz4ZaDxwBqsJr6jUTXPf228KQLHiALSCZjtrs6f4MnvAZ
         zZCOmd1nE54IsrQjpaQ0vNHeNF4N570JRWAbnk7C9B6giRBggquN6YdS+prQn5ysddIf
         nC9moCw4R4qWrPmKr7sjDbLeuZq59YvGBdgzAtALJ6jYgOLJasSAV2N5ARawBu6GUxec
         3Gue68uu14VsfhhXOrY5CmC3GttoslPEizzNcB3tPSuWKCBYZGqTLUSkakVRV/9ngUIF
         Q0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCU8K/6HRnldy9Ij2PqDTDkokVBN/0cEkmer4vuifGtxpi7EwGpLzHOCB6PgEHuRL0Le/pDk7g/A460Zdk3N5JyIEK2XC7NIcOYh6qZM
X-Gm-Message-State: AOJu0YxzD7nTQIipBvTqy2egYFUE2qtjHqLYQ8d7WrAhTxetTj2tF/aX
	QL735j+iZPRpwOd1Z7ab3u7wBU+K3ch8TeS+ugvoolqYfC8EObm5eouiEJa0O/P8sPL8wEdhHI5
	2
X-Google-Smtp-Source: AGHT+IGoZm/xp1G/OD/8Sl4FoiC95cUmkntuMFrDr7Qmfp/kfCwUeNUTxLGICD5tmQBANj3SLO1Z1Q==
X-Received: by 2002:a17:906:7196:b0:a3c:7fcc:3967 with SMTP id h22-20020a170906719600b00a3c7fcc3967mr3430139ejk.40.1708079078897;
        Fri, 16 Feb 2024 02:24:38 -0800 (PST)
Received: from krzk-bin.. ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id hw12-20020a170907a0cc00b00a3d5d8ff745sm1438580ejc.144.2024.02.16.02.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 02:24:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: sm8650-lpass-lpi: correct Kconfig name
Date: Fri, 16 Feb 2024 11:24:35 +0100
Message-Id: <20240216102435.89867-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use proper model name in SM8650 LPASS pin controller Kconfig entry.

Cc: <stable@vger.kernel.org>
Fixes: c4e47673853f ("pinctrl: qcom: sm8650-lpass-lpi: add SM8650 LPASS")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index e0f2829c15d6..24619e80b2cc 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -125,7 +125,7 @@ config PINCTRL_SM8550_LPASS_LPI
 	  platform.
 
 config PINCTRL_SM8650_LPASS_LPI
-	tristate "Qualcomm Technologies Inc SM8550 LPASS LPI pin controller driver"
+	tristate "Qualcomm Technologies Inc SM8650 LPASS LPI pin controller driver"
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_LPASS_LPI
 	help
-- 
2.34.1


