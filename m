Return-Path: <linux-kernel+bounces-15590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB68822E84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0891C21737
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D4D1A582;
	Wed,  3 Jan 2024 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDl/Qdzg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B419219BB9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d5336986cso102496555e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704289020; x=1704893820; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+lunZAMttuE9Ow0qpAJPT+j8jCm31qhcStv57z+apCk=;
        b=rDl/QdzgXvwMOkjPRGcFFEqdayg1zr7TwjWRDe5efyqAgI+KnE82F3Lb3SY2eR5OJi
         8vLGnMebRksp0plJpstEVBgJyWXF4U7igZo91moT9dUTb2QngtH9m1nP6rUntvEj9hIL
         uViP2NT1rJDph3kinXA1qZAuX85iX8freE0seuGItXS9RdbAVBQkfxth03tAF2+0/IK2
         K/JRt9+DbNFF8FxD1EuoXjzeRfx8FRiPoinqVErJetGu/GaYbJif7Vt6ehF9AbbmiQKz
         NJXd7F8CBNG0olndTJ6X0u3iqKiP+IdBpDXAlJDW20sPyQ+k4DSEqEm7OKj1MR7qdYbL
         1/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289020; x=1704893820;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lunZAMttuE9Ow0qpAJPT+j8jCm31qhcStv57z+apCk=;
        b=dC4wMXz71Q6MJhMd7lfi1h5YT8O4SVs6P77qqup3mGIt60L3RQJ/0GaNPvCklP4uVR
         ri9TTohldoCxh/4kLJQwGUq2Rjvm/ohsq7LO0H+a7ZjkA1WZLjtuSI7ELCP8ZCxN34GR
         bLGtQxt41JZwkElrkYT8i8fw7R36006jJE8po19FlV4bDoQQ3TxQNJZMx6DWGc3bQL0i
         bflgO4ns9TpJpROTxi77e3Xrv/TjHXKW3Y/u+aVQ7Y2CAaXQJhvI4mcD3BrQsaHDVVRD
         bN97YPrMEBr2g+LARn33O9Wytvkuy8o6FXLkEmnDXetzlVZl6S3y9X0X9pwa0OV1O6pv
         Z0mA==
X-Gm-Message-State: AOJu0YyGUr0pexPAlU7tKOFJCtWmrRoOr1UPmoPybdeuxURmLuvWZhoG
	j4poy24ChP2wS9WxXj0QmI3tIw/YaVAGNA==
X-Google-Smtp-Source: AGHT+IHemrkk4u2vVOqxyLBQMBAZW021XstPr5HMfvK9SpHdTYyQpUp8NI1bvbctD2e447ECKHWpgQ==
X-Received: by 2002:a05:600c:5251:b0:40d:87bd:9483 with SMTP id fc17-20020a05600c525100b0040d87bd9483mr2293748wmb.238.1704289019933;
        Wed, 03 Jan 2024 05:36:59 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id cl2-20020a170906c4c200b00a275637e699sm6474351ejb.166.2024.01.03.05.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:36:59 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v5 00/12] Unregister critical branch clocks + some RPM
Date: Wed, 03 Jan 2024 14:35:58 +0100
Message-Id: <20230717-topic-branch_aon_cleanup-v5-0-99942e6bf1ba@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL5ilWUC/43NQQrCMBAF0KtI1kaaSZpYV95DRNLp1AZKUpJaF
 OndTcWN6KLL/5l5/8kSRUeJHTZPFmlyyQWfQ7ndMOysvxJ3Tc4MCpCFEYaPYXDI62g9dhcb/AV
 7sv42cF0ZjUK2ZASy/F7bRJ+7DPhb3+dyiNS6+3vvdM65c2kM8fGen8TSrliaBC84GLNXDRirW
 nXsnbcx7EK8skWdYK0Ei2TLvVS6oBb0jyTXSjJLkqSokSrUfyS1VlKLBAiVbKipRPklzfP8AvG
 LRte0AQAA
To: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704289018; l=5349;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AAdD+G7CZ9x5aHJoFiaqQdcBFQcbek9/aDqwS0Y5sxg=;
 b=HEHLt41pJSfOsIcDXm/+l93um1gxoAZqIiCMx64z5F8DoflgpzpI9VDASS0FCPL0vfMxwkxgk
 VRKMAwyx/itAPZ1CATYh3xMwoeSHg7q12IZOEeanzTywE5CVG+nV8Ma
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

On Qualcomm SoCs, certain branch clocks either need to be always-on, or
should be if you're interested in touching some part of the hardware.

Using CLK_IS_CRITICAL for this purpose sounds like a genius idea,
however that messes with the runtime pm handling - if a clock is
marked as such, the clock controller device will never enter the
"suspended" state, leaving the associated resources online, which in
turn breaks SoC-wide suspend.

This series aims to solve that on a couple SoCs that I could test the
changes on and it sprinkles some runtime pm enablement atop these drivers.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v5:
- Change the "Keep the critical clocks always-on" comment to "Keep
  some clocks always-on"
- Add the same comment to commits unregistering clocks on 6115/6375/2290
- Link to v4: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org

Changes in v4:
- Add and unify the "/* Keep the critical clocks always-on */" comment
- Rebase (next-20231222), also include 8650, X1E and 8280camcc drivers
- Drop enabling runtime PM on GCC
- Improve the commit message of "clk: qcom: gpucc-sm6115: Add runtime PM"
- Link to v3: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v3-0-3e31bce9c626@linaro.org

Changes in v3:
- Rebase (next-20231219)
- Fix up a copypaste mistake in "gcc-sm6375: Unregister critical clocks" (bod)
- Pick up tags
- Link to v2: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org

Changes in v2:
- Rebase
- Pick up tags
- Fix up missing pm_runtime_put in SM6375 GCC (Johan)
- Clarify the commit message of "Add runtime PM" commits (Johan)
- "GPU_CCC" -> "GPU_CC" (oops)
- Rebase atop next-20231129
  - Also fix up camcc-sm8550 & gcc-sm4450
  - Unify and clean up the comment style
  - Fix missing comments in gcc-sc7180..
  - Drop Johan's ack from "clk: qcom: Use qcom_branch_set_clk_en()"
- Improve 6115 dt patch commit message (Bjorn)
- Link to v1: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org

---
Konrad Dybcio (12):
      clk: qcom: branch: Add a helper for setting the enable bit
      clk: qcom: Use qcom_branch_set_clk_en()
      clk: qcom: gcc-sm6375: Unregister critical clocks
      clk: qcom: gpucc-sm6375: Unregister critical clocks
      clk: qcom: gpucc-sm6115: Unregister critical clocks
      clk: qcom: gpucc-sm6115: Add runtime PM
      clk: qcom: gcc-sm6115: Unregister critical clocks
      clk: qcom: gcc-qcm2290: Unregister critical clocks
      arm64: dts: qcom: sm6375: Add VDD_CX to GCC
      arm64: dts: qcom: qcm2290: Add VDD_CX to GCC
      arm64: dts: qcom: sm6115: Add VDD_CX to GCC
      arm64: dts: qcom: sm6115: Add VDD_CX to GPU_CC

 arch/arm64/boot/dts/qcom/qcm2290.dtsi |   1 +
 arch/arm64/boot/dts/qcom/sm6115.dtsi  |   3 +
 arch/arm64/boot/dts/qcom/sm6375.dtsi  |   1 +
 drivers/clk/qcom/camcc-sc8280xp.c     |   6 +-
 drivers/clk/qcom/camcc-sm8550.c       |  10 +--
 drivers/clk/qcom/clk-branch.h         |   7 ++
 drivers/clk/qcom/dispcc-qcm2290.c     |   4 +-
 drivers/clk/qcom/dispcc-sc7280.c      |   7 +-
 drivers/clk/qcom/dispcc-sc8280xp.c    |   4 +-
 drivers/clk/qcom/dispcc-sm6115.c      |   4 +-
 drivers/clk/qcom/dispcc-sm8250.c      |   4 +-
 drivers/clk/qcom/dispcc-sm8450.c      |   7 +-
 drivers/clk/qcom/dispcc-sm8550.c      |   7 +-
 drivers/clk/qcom/dispcc-sm8650.c      |   4 +-
 drivers/clk/qcom/gcc-qcm2290.c        | 106 +++--------------------------
 drivers/clk/qcom/gcc-sa8775p.c        |  25 +++----
 drivers/clk/qcom/gcc-sc7180.c         |  22 +++---
 drivers/clk/qcom/gcc-sc7280.c         |  20 +++---
 drivers/clk/qcom/gcc-sc8180x.c        |  28 +++-----
 drivers/clk/qcom/gcc-sc8280xp.c       |  25 +++----
 drivers/clk/qcom/gcc-sdx55.c          |  12 ++--
 drivers/clk/qcom/gcc-sdx65.c          |  13 ++--
 drivers/clk/qcom/gcc-sdx75.c          |  10 +--
 drivers/clk/qcom/gcc-sm4450.c         |  28 +++-----
 drivers/clk/qcom/gcc-sm6115.c         | 124 +++-------------------------------
 drivers/clk/qcom/gcc-sm6375.c         | 105 +++-------------------------
 drivers/clk/qcom/gcc-sm7150.c         |  23 +++----
 drivers/clk/qcom/gcc-sm8250.c         |  19 ++----
 drivers/clk/qcom/gcc-sm8350.c         |  20 +++---
 drivers/clk/qcom/gcc-sm8450.c         |  21 +++---
 drivers/clk/qcom/gcc-sm8550.c         |  21 +++---
 drivers/clk/qcom/gcc-sm8650.c         |  16 ++---
 drivers/clk/qcom/gcc-x1e80100.c       |  16 ++---
 drivers/clk/qcom/gpucc-sc7280.c       |   9 +--
 drivers/clk/qcom/gpucc-sc8280xp.c     |   9 +--
 drivers/clk/qcom/gpucc-sm6115.c       |  53 ++++++---------
 drivers/clk/qcom/gpucc-sm6375.c       |  34 ++--------
 drivers/clk/qcom/gpucc-sm8550.c       |  10 +--
 drivers/clk/qcom/lpasscorecc-sc7180.c |   7 +-
 drivers/clk/qcom/videocc-sm8250.c     |   6 +-
 drivers/clk/qcom/videocc-sm8350.c     |  10 +--
 drivers/clk/qcom/videocc-sm8450.c     |  13 ++--
 drivers/clk/qcom/videocc-sm8550.c     |  13 ++--
 43 files changed, 234 insertions(+), 653 deletions(-)
---
base-commit: 0fef202ac2f8e6d9ad21aead648278f1226b9053
change-id: 20230717-topic-branch_aon_cleanup-6976c13fe71c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


