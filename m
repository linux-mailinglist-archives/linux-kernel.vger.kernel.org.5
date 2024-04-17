Return-Path: <linux-kernel+bounces-149151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E038A8C93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED592876AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436B53D967;
	Wed, 17 Apr 2024 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GerZe6sh"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C2374D2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384187; cv=none; b=f+dXBAooPNhwwdZOHqAsy5iKUxTjcB5iZ6dMaPXU22CPU4ZdDTYXth20xZ6WedZApnqwrRwGD+wu9EpnesZOF24BwlRvabcneChTZkK/CFpcH7RDAfZy9OZYfGsRrFqUHmDp/t741hMI6pBmgJSCLcvtWMTtY859PPwO9UXa+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384187; c=relaxed/simple;
	bh=DJ8DSD99sxYhrIfsLOLcFHZ/8SkT9S5JHfim2UIEGSk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oksd6cc3Du67agdVJLyYLy9wwZ6uZd6VD65J5c/cFncVN9I+PuriO4Q8M5XuqUQhaj2Dv4R6HkJCpB58tt3LDNyuzhfBboYS58VzI4r+XvxtAHbErWm8NBJl4fnp7qjYr4CdqA0i12ZtNYceKuoTpNr/Ahju6+kz6UAtgQnYqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GerZe6sh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so2201687a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713384184; x=1713988984; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tdMXP9Q/2N2bcDJp1OXtz16aXO1zuRSl77E+ubHuLLQ=;
        b=GerZe6shr7ssE+oFxDokI2AGdbBcbZBvUz0ZSsW74njCbWRkafRuQ6WzOQJGZiwPeR
         5w8LgwdT1oPjuo4FV3FYQs2xqIzqAwxnaF+ioGQVbQwjCpNnhMc17kvMStbsmR0mzufK
         piD5FxW1aaXnghzc4B7HMBOXxSkaaTnxl9Ul1zUuXQvAWYgAdtLcHir/sc6vcM7q0xMe
         vQ6GwGFNxe2MTYOwXgI3bJv7XMr6jyuAaOdEp2vtr4Bw9Z65JRsHHQhOa6Wo/W7bjVfb
         Cbonu7gclw+DkokKoRZUeuWIqFyYBCCqp7zbDC6Z/D9E3WLHtfbUvV64Re/dnfBXMwJ9
         gbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713384184; x=1713988984;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdMXP9Q/2N2bcDJp1OXtz16aXO1zuRSl77E+ubHuLLQ=;
        b=SkN0ih+2/qu8wtPs1Lx4sssT40zhqmE/SvGwIf8jm35gU1tQL833UQ5LcmckohPGig
         eMR2uGLF7D33FMv0cIeEuQCgkGFpCtFaxYNZhrIWsONUObeq+09a9mu0gf3SphTfh2rt
         a1COvDPztQ03yLePZ39j6I7yRua2cYJ/W6xDw0hFLLsuWYeaVqVNgccRHqV7dVDKyK5v
         Kbyk4A2vrGRB8VSVdDOG4PqASgYnKJGrMSIw2MA281zIqYubjToLs1pkjPnEP1vB+fxq
         5OWkdqvRHewefXeCpgb3NMRUnTL5KDuNoOaPBq8/Q3DiAzLDe9fJ33GNaxwkwZ2OYgWl
         MiUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1xKqtMFL1XU3tA8re41u92uVGhaQXbXc18t/GQDYavPYYi7O7bGg25w+U5Q7JEEzxZ2i1tKI6sO/EA5NORETTQAsP48+s+D2SRiXh
X-Gm-Message-State: AOJu0YzPPmYtJPtHEnp/T3wAlcYYzQr2Tm8RtW5HwVm5EIdw1ChBUNs/
	UmgaJuk6CPOHPAY/h/VZZ81mNMG935LOt3bsdVV0Vi+ZRxQy+4PFOqYnPiCnvKhBTXf+2n352Kp
	E
X-Google-Smtp-Source: AGHT+IHJn6r/VkcN7BUe5TY1y2qtDETHmV5Y4YSmS9lKPUDa1Ar8h6bYFFVkY2orMC4dB24dRrOEcw==
X-Received: by 2002:a17:907:36c1:b0:a55:6135:7ab7 with SMTP id bj1-20020a17090736c100b00a5561357ab7mr163979ejc.6.1713384184137;
        Wed, 17 Apr 2024 13:03:04 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id xa4-20020a170906fd8400b00a5252e69c7dsm5905590ejb.160.2024.04.17.13.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:03:03 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/7] Add SMEM-based speedbin matching
Date: Wed, 17 Apr 2024 22:02:52 +0200
Message-Id: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOwqIGYC/22NQQqDMBREryJ/3ZQkaJGueo8ixSSjfqiJJBJax
 Ls3Fbors3oD82ajhMhIdK02isicOPgC+lSRnXo/QrArTFrqWpaINSxsRZoxP9ICOMNetA6wTho
 MElSWS8TAr8N67wpPnNYQ38dJVt/252v++rISUlho015q3Sijbk/2fQznEEfq9n3/AOJYqwO3A
 AAA
To: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713384181; l=2910;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DJ8DSD99sxYhrIfsLOLcFHZ/8SkT9S5JHfim2UIEGSk=;
 b=qPZ9W7adu9DGmD4JrUVkPIxmZpfCiw/Zfg4GfqJo5ewDABLjWBmW8KhtVN69tnCvwbjFzsZE8
 wueUz4LeEDxDsH/1HVL2yf7+59ucDJZ5PQfqTXiOaOCFikruX6L3QLi
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Newer (SM8550+) SoCs don't seem to have a nice speedbin fuse anymore,
but instead rely on a set of combinations of "feature code" (FC) and
"product code" (PC) identifiers to match the bins. This series adds
support for that.

I suppose a qcom/for-soc immutable branch would be in order if we want
to land this in the upcoming cycle.

FWIW I preferred the fuses myself..

Patches 5 and 6 coooould be omitted, but I'd reaaally like them to land
and soon at that. This would enable even more overdue and necessary
cleanups/feature prepwork sooner than later.

The dt patch can only be picked if the drm patches are there.

Depends on:
https://lore.kernel.org/linux-arm-msm/20240412-topic-adreno_nullptr_supphw-v1-1-eb30a1c1292f@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Separate moving existing and adding new defines
- Fix kerneldoc copypasta
- Remove some wrong comments and defines
- Remove assumed "max" values for PCs and external FCs
- Improve some commit messages
- Return -EOPNOTSUPP instead of -EINVAL when calling p/fcode getters
  on socinfo older than v16
- Drop pcode getters and evaluation (doesn't matter for Adreno on
  non-proto SoCs, might matter in the future or w/ other peripherals)
- Rework the speedbin logic to be hopefully saner (accidental support
  for A2xx-A4xx, I guess!)
- Reorder some existing function calls to avoid crazy nullptrs
- ""fix"" the smem dependency inconvenience
- Link to v1: https://lore.kernel.org/r/20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org

---
Konrad Dybcio (7):
      soc: qcom: Move some socinfo defines to the header
      soc: qcom: smem: Add a feature code getter
      drm/msm/adreno: Implement SMEM-based speed bin
      drm/msm/adreno: Add speedbin data for SM8550 / A740
      drm/msm/adreno: Define A530 speed bins explicitly
      drm/msm/adreno: Redo the speedbin assignment
      arm64: dts: qcom: sm8550: Wire up GPU speed bin & more OPPs

 arch/arm64/boot/dts/qcom/sm8550.dtsi       |  21 +++++-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c      |  34 ----------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  54 ---------------
 drivers/gpu/drm/msm/adreno/adreno_device.c |  13 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 103 +++++++++++++++++++++++++----
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  11 +--
 drivers/gpu/drm/msm/msm_gpu.c              |   3 -
 drivers/soc/qcom/smem.c                    |  33 +++++++++
 drivers/soc/qcom/socinfo.c                 |   8 ---
 include/linux/soc/qcom/smem.h              |   1 +
 include/linux/soc/qcom/socinfo.h           |  34 ++++++++++
 11 files changed, 198 insertions(+), 117 deletions(-)
---
base-commit: b13768266bf3a129adf5bbd0bad28e23a74329a2
change-id: 20240404-topic-smem_speedbin-8deecd0bef0e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


