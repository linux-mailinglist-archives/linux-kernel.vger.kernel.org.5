Return-Path: <linux-kernel+bounces-6169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A56819550
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9F41F21937
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B821FB6;
	Wed, 20 Dec 2023 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nhVvrj4O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA9210A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e51a7545dso128755e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703032252; x=1703637052; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWZvCxitZuGixzKuEq3TIl4LD0lytvrrFKs/eeQVctM=;
        b=nhVvrj4OBtbpKfJMlEyXCbmjR3jkqWIKomhxSBhtkWE2CQof7kJr97E2niBrP5AxUy
         1d6af0oWrEJFYXnBZBj0utiNYQ6h2ZNSJ6kBI9R8XXyg7zYOPE+77AHFFJGrO1bj+76m
         BoRJa0u5AyzBlHFacOB62PavCgioofhN4GrJuAkU+5tuZPdE/lFRKdbditFOPcrn/mMv
         yTKA2Auktqqbay3yCgoM4ET0PSVtZS0k0CbOJ2vGlHQxAW/DvbqxtKLyRsol68ZLIe5Y
         PlHqdkZ3tyte6B8NikP9F0f+KojtgfnsOLhPKVYZfyiOjT+QDvIxRfC5rYqg6P/+eeDc
         LY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703032252; x=1703637052;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWZvCxitZuGixzKuEq3TIl4LD0lytvrrFKs/eeQVctM=;
        b=HOPlSlI7hG10GkO0XpuAYAA97w3sauebSOEANXgrj9Z78WFPPgdInOYonj8P8j9A/g
         W5493AD+tUyt0COmLV64YLgITIuFOaZTfR0eKwmUvDecZCXSNsGy9wbw/TTuQBNwosul
         394ipvKjKDK7OuyzYT5hqurE1FOKK/P/lyiQD06VAxq93n222/tE/0D4RVFHvvhIopAh
         oVYEfigfmSkZLnZoVNmIYgG9Jy6tlQUDCuCN3huiE5lrSN6WaiKVCFD5rQYiG+BV67+i
         B0JIYEHayngE85Pg/7J/oARm4FeScoTR6RwcJddU79cfI6y03BxqnO02xLClvXCyvzrj
         vCRA==
X-Gm-Message-State: AOJu0YyhSy4tcfFwk9WaEHxX/UeaxfNcv5Emvjhq7X30sQGDXly4zXQ2
	dEAySvaFhEBkoRc7AchubIj/LQ==
X-Google-Smtp-Source: AGHT+IGvuuqQ6CZNter5M4MFcL7ofl2/ybStrzPNyOZhDeuRUxCyN2bNpEA+fgT8CcCcVxbW8V9itw==
X-Received: by 2002:a05:6512:3d90:b0:50e:38ff:d9e2 with SMTP id k16-20020a0565123d9000b0050e38ffd9e2mr2473150lfv.32.1703032252285;
        Tue, 19 Dec 2023 16:30:52 -0800 (PST)
Received: from [10.167.154.1] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id k16-20020a056402049000b00552d03a17acsm4824397edv.61.2023.12.19.16.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 16:30:51 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 00/15] Unregister critical branch clocks + some RPM
Date: Wed, 20 Dec 2023 01:30:41 +0100
Message-Id: <20230717-topic-branch_aon_cleanup-v3-0-3e31bce9c626@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALE1gmUC/42NzQ6DIBAGX6XhXBr+CranvkfTGMRFSQwYUNLG+
 O5F00tvHufL7syCEkQHCd1PC4qQXXLBF+DnEzK99h1g1xZGjDBOFFV4CqMzuInam77WwddmAO3
 nEcubkoZyC4oaVN4bneB3VwR+HoYyjhGse++956tw79IU4mfPZ7qtB0qZYoKZUpVomdLCisfgv
 I7hEmKHNmtmR01sM+lrxYUkYJn8M63r+gVEK473IAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703032249; l=4596;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TOhUcZQV9pL6H0IYh/H/hiMLY+tqB9v/ZY20JeDivt0=;
 b=XreHTluc+J6PWRiZWAkckyzExqA5QYvxffRmYmTZr71esThReM+XO9BjyqYjw96eW6ueQNoSK
 fyn35Aqry4wC7X5SHWqEXQoiUlen3BLA155GhzScg2AxeAM8tVJHn5i
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
Konrad Dybcio (15):
      clk: qcom: branch: Add a helper for setting the enable bit
      clk: qcom: Use qcom_branch_set_clk_en()
      clk: qcom: gcc-sm6375: Unregister critical clocks
      clk: qcom: gcc-sm6375: Add runtime PM
      clk: qcom: gpucc-sm6375: Unregister critical clocks
      clk: qcom: gpucc-sm6115: Unregister critical clocks
      clk: qcom: gpucc-sm6115: Add runtime PM
      clk: qcom: gcc-sm6115: Unregister critical clocks
      clk: qcom: gcc-sm6115: Add runtime PM
      clk: qcom: gcc-qcm2290: Unregister critical clocks
      clk: qcom: gcc-qcm2290: Add runtime PM
      arm64: dts: qcom: sm6375: Add VDD_CX to GCC
      arm64: dts: qcom: qcm2290: Add VDD_CX to GCC
      arm64: dts: qcom: sm6115: Add VDD_CX to GCC
      arm64: dts: qcom: sm6115: Add VDD_CX to GPU_CC

 arch/arm64/boot/dts/qcom/qcm2290.dtsi |   1 +
 arch/arm64/boot/dts/qcom/sm6115.dtsi  |   3 +
 arch/arm64/boot/dts/qcom/sm6375.dtsi  |   1 +
 drivers/clk/qcom/camcc-sm8550.c       |   9 +--
 drivers/clk/qcom/clk-branch.h         |   7 ++
 drivers/clk/qcom/dispcc-qcm2290.c     |   3 +-
 drivers/clk/qcom/dispcc-sc7280.c      |   6 +-
 drivers/clk/qcom/dispcc-sc8280xp.c    |   3 +-
 drivers/clk/qcom/dispcc-sm6115.c      |   3 +-
 drivers/clk/qcom/dispcc-sm8250.c      |   3 +-
 drivers/clk/qcom/dispcc-sm8450.c      |   6 +-
 drivers/clk/qcom/dispcc-sm8550.c      |   6 +-
 drivers/clk/qcom/gcc-qcm2290.c        | 127 ++++++-----------------------
 drivers/clk/qcom/gcc-sa8775p.c        |  24 +++---
 drivers/clk/qcom/gcc-sc7180.c         |  21 ++---
 drivers/clk/qcom/gcc-sc7280.c         |  19 ++---
 drivers/clk/qcom/gcc-sc8180x.c        |  27 +++----
 drivers/clk/qcom/gcc-sc8280xp.c       |  24 +++---
 drivers/clk/qcom/gcc-sdx55.c          |  11 +--
 drivers/clk/qcom/gcc-sdx65.c          |  12 +--
 drivers/clk/qcom/gcc-sdx75.c          |   9 +--
 drivers/clk/qcom/gcc-sm4450.c         |  27 ++-----
 drivers/clk/qcom/gcc-sm6115.c         | 145 +++++++---------------------------
 drivers/clk/qcom/gcc-sm6375.c         | 126 +++++++----------------------
 drivers/clk/qcom/gcc-sm7150.c         |  22 ++----
 drivers/clk/qcom/gcc-sm8250.c         |  18 ++---
 drivers/clk/qcom/gcc-sm8350.c         |  19 ++---
 drivers/clk/qcom/gcc-sm8450.c         |  20 ++---
 drivers/clk/qcom/gcc-sm8550.c         |  20 ++---
 drivers/clk/qcom/gpucc-sc7280.c       |   8 +-
 drivers/clk/qcom/gpucc-sc8280xp.c     |   8 +-
 drivers/clk/qcom/gpucc-sm6115.c       |  52 +++++-------
 drivers/clk/qcom/gpucc-sm6375.c       |  33 +-------
 drivers/clk/qcom/gpucc-sm8550.c       |   9 +--
 drivers/clk/qcom/lpasscorecc-sc7180.c |   6 +-
 drivers/clk/qcom/videocc-sm8250.c     |   5 +-
 drivers/clk/qcom/videocc-sm8350.c     |   9 +--
 drivers/clk/qcom/videocc-sm8450.c     |  12 +--
 drivers/clk/qcom/videocc-sm8550.c     |  12 +--
 39 files changed, 236 insertions(+), 640 deletions(-)
---
base-commit: aa4db8324c4d0e67aa4670356df4e9fae14b4d37
change-id: 20230717-topic-branch_aon_cleanup-6976c13fe71c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


