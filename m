Return-Path: <linux-kernel+bounces-61605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EE185142B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F231F22319
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF013A1CE;
	Mon, 12 Feb 2024 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ly2gxTxg"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD2F3A1B2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743420; cv=none; b=FLreJTyg+gv3ZLo+xz+6xRDO5+WVIoT6w5LLuJc1FMA8GHLbfdkCjquDMTXPO0349Ve2gMoOCOX0tpX/amG7uxeF38tRoadNBKoTtdCl1EHJvMagJJaPWvJo4azvMTEBDNXz3QKHXUm5+tJkeqk3VSt4qwvv+rySUVP0Py7O5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743420; c=relaxed/simple;
	bh=+63/Xgcnvvl++vw0kFSv69jgv62HeXw4wvXx3EN09/E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fS6k7bBwPoGPcYD212YKa3tJ8IybsZoeNCG9b+EmAynxKl+4HaKPONTIm1y/BX+p34itaJ3ErLDrtpHSMhN8gKAFBG2FDfZmhFfTe5Gq1v33tShi8O97eq6zamk6lSJTpOEKwVn6i5PVHKgh2iNfNEy1ZVenMqT0wstTd+dV2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ly2gxTxg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so553778566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707743416; x=1708348216; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BsrFFtFar7TX/ORI8AiadfGDjdZ6VxExU8R2VKF2tt0=;
        b=ly2gxTxgpbya2bAiKtoBObXqZnhjrMEVDw2J4VRBlQ1a8W0a2B6sInInc7+fcmjuyb
         h1k+oXJqX766ETHzGLMA+wK2cDtG13BMHbevZB6RvlMeKI9Olp5l0LMRDCb4hPUeihVx
         f/lr6ykwlRhlEDhg0WkX+O7uSJt7gBCdE5cDwAg4xLeg0QNFGGc5yFDFKH0mxlueomgC
         2dZkZDENS3PsKUBapssta2Jkx98A4fsYhb5lLpqCoTgdOUYCHP8hIuLKeKZwrYrHiLGE
         m06IqwGVl+LoCfekWsao9mdwML7ej84QX9JyPoUzZHNTCzR7Hgh8qfEZ5tYrNpcxIS2A
         dwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743416; x=1708348216;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsrFFtFar7TX/ORI8AiadfGDjdZ6VxExU8R2VKF2tt0=;
        b=JhMUnd5MeJG/2CCJBrY19XDs5qualfEiJFdhU/6hXhfbBuzjwwO19TR50oOCxpCOac
         3wogIY6XNV8uuKLi/kiF6CAPxRshEM4r9sEvb2eoA5/ttr1oW/DHhvk7NlyqxNbzm3jJ
         gFJ5HuaH1K/v4Q/QlRumihhH3OKlDcWVwObqKvLnyXfzhy3AQXnh9tSZ+nOm3SNtcEcF
         UeDMVRTSLJ0jCo/1x/VL6bUyMlx/znjM5dQOSBb17PNeULbNtJL/uldM1B3FwGqT08s5
         GaEeQ8vDO27nki9RXSQxgP+7je8unlUVxpKGDpeAL+C6/Gp1/10OQclwnTAwS7lNd5QV
         4LiQ==
X-Gm-Message-State: AOJu0Yz0R1pylzTe8I6F9CxzO1FQePkb7ywVMr0fD8FnhjgbFUDDWlAl
	W7DR1F+rWx3kzq2010vQ+AHR/yvWhkpHQyXayrpw5P9mV7Oeqd98wbhI60smTBM=
X-Google-Smtp-Source: AGHT+IGKQcbm/gLY8lNaBXnZ8bB41KLkoXe2u6YPlJKH4J4XNBLaZGYA1IMY4H/1Je6cum9j4HdrKw==
X-Received: by 2002:a17:907:7630:b0:a3c:d535:39b4 with SMTP id jy16-20020a170907763000b00a3cd53539b4mr732454ejc.9.1707743416229;
        Mon, 12 Feb 2024 05:10:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXtlT2GK2hRcxDFaqLSEtNzsZew685DrIL22y3sX+/RTcf+JI+CNzNXA4MIXhBGQkVmhkZ8xie983qK3t5/DQVwP5jSRfo+grt8qUVWoNG7TARAtc40DsNPCNn3F1ZpKGmsWtljMslQcH+fZExpwMdTsUd4OUWjs19NZSkpDpvDyp+g/XTSOjbIoCvdCQNbpyO8HSyeCI453DLUNpDsWKoVLZYba73m+8tAyieSo2WmBA3I3m/ZXpmOBxByRFZ7KK8GlWEPaZUA8GcRceQgP8STyP77sHHG7Yn51geCFQGj6HmvPVuoPKBPpNojRNfAtSpdZRde1Qxa0sr86vbkJ9a6WGb0AFngzJ/rZQgzOUCzWuet+leYZz2ctLwaClJGbyqnpkGkOYugYGFNYT+rPQ4JT9SfP5m1BENaBaI41BYyu4bRMQG15iPwMAyHwrfNKHDck8lw9bSW3vmGxFQzv01fdYpPABWqNL3DL9alskhwQ2gCXDoeyZGhydxxlAJwCJz+S6SpH/wm+NdHEXAonp6BfbV1ZiMQWHte51UkTKAnmaIiXUz9HcpM44yV91nDjVWmMAQP93Ft1FR5dPIvsAsHE3dK2ffJc1AdtCxGHWv8WQWv9n0XRpVf69WZhl5GJ1gJ9SyzIPhc3H1Y7aHd2Nu8hvGyvHLm7g1dHgKrUvhfDSh+jALsFRS2jSsGmGE8koyh1Lz5s3KEqc/NGW8np8iITcGd5r1Ook7uDpyro+CQRh0d8KyFnfKCWKApLRof45G6gbKuU/XbfV48Awihs62JBwtOwjeW76cwLbFJmq9wO2Me417dgRSxomPOd12eSjhNHy+nDY7/hSPnareqyLvfDwJ
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id gz9-20020a170906f2c900b00a3515b35be4sm193052ejb.104.2024.02.12.05.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 05:10:15 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/7] Xperia 1 V support
Date: Mon, 12 Feb 2024 14:10:08 +0100
Message-Id: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALAYymUC/x2MSwqAMAwFryJZG2iL/6uIi1qjBqRKqyIU725wO
 Y95kyBSYIrQZQkC3Rx59wI6z8Ct1i+EPAmDUaZQRis894Md6ht1Q23V1pNRZQWijzYSjsF6t8r
 BX9sm4xFo5ufv98P7fprnii5vAAAA
To: James Schulman <james.schulman@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>, 
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707743413; l=1101;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+63/Xgcnvvl++vw0kFSv69jgv62HeXw4wvXx3EN09/E=;
 b=6YV2ckgdeayZEZbm5EwxHt13hD4TlThi32QfPyjikJXM4FpoWrBqYyXFMJjgA6J2yL1nJmbXU
 IFYcrqy+DKiDHpnmQkzMx7gpsT1kjrSsW7cc/ESlI/vW8tJtCgvXG8Y
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

DTS for the phone and some fly-by fixes

Patch 1 for Mark/sound
Rest for qcom

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (7):
      dt-bindings: ASoC: cs35l45: Add interrupts
      dt-bindings: arm: qcom: Add Xperia 1 V
      arm64: dts: qcom: sm8550: Mark QUPs and GPI dma-coherent
      arm64: dts: qcom: sm8550: Mark APPS SMMU as dma-coherent
      arm64: dts: qcom: sm8550: Add missing DWC3 quirks
      arm64: dts: qcom: sm8550: Mark DWC3 as dma-coherent
      arm64: dts: qcom: Add SM8550 Xperia 1 V

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 .../devicetree/bindings/sound/cirrus,cs35l45.yaml  |   3 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts    | 779 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  20 +-
 5 files changed, 801 insertions(+), 3 deletions(-)
---
base-commit: ae00c445390b349e070a64dc62f08aa878db7248
change-id: 20240210-topic-1v-18e9697d2056

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


