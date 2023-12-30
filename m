Return-Path: <linux-kernel+bounces-13421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3697582065B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB201F21611
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934CC8BFB;
	Sat, 30 Dec 2023 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBbyL0F5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377978BF6
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5555f9061b9so3553851a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 05:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703941467; x=1704546267; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eAK3GkpXOGhDaB/Q0hZvmQy//6V7+7rM0YC0FJDvdW4=;
        b=QBbyL0F5kI/gLJE4aLvgUrNB83KztRf1fR9gyiKHcO5bEbyHnYxVK8hWOE7PdaS+e0
         l9wQhB7ZzDdRHl4mqKBCReYhuDWulSCM4F49F34riUUVWEvSe1WhZEeFpQd6PrOMzhWd
         vKJEVyiI6cagnNKIj6RypLCon3WI/JyOuyMlo68luoZCuPFBR1FDQNDA5V0HBhoidOGX
         t2jxtehgitsiAMpwyFC3S9SoqyxerXeqUyB4/2NCDu9Pjd86GiRHNHlx0pmy8K0Xukle
         9lfBxhRHO5F/WnirlDxF48HMO+LrgFcMt6ibd7fNU9Kzz9ScBg4kK9vFN9WGgS3lbyvP
         BRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703941467; x=1704546267;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAK3GkpXOGhDaB/Q0hZvmQy//6V7+7rM0YC0FJDvdW4=;
        b=IbYJ9wpXTuuNhwXpdSjDEdaO6H7bO+tqOQOjeLK1Mfp70EwiDArSTdQcml1bKF2gL6
         4vtyquLSfkSU76wrMPSm2io5o4phbf6O5nbbAO7x4tmYC9hzyQ99KLq4QwDP0xq9T4vw
         SYZ5oLbbHwRAKcEcQITre/QTRj5FtQAuK4mxUdujDvi+SHvK8jvjVAwfhgWMya1YK9Az
         51I6oPTC3Sq3LGVsAu48WTIlUzbT7iHlXcEdqcoUZqVEhzlMOk+KHPO+0YURZkRYvLIN
         EvEHTukAEoaM2Xr1etmQARnpu8/SrSZJI+FF7SFdk5WuTmPs4JYy6Ynt/WtWr5qSSytd
         SdtQ==
X-Gm-Message-State: AOJu0YwDG5pEU8Qr8NcVMn/rFBAKC794WRvsqvBfR9CAIEPJw7bYx/Ci
	UGeYE1erkcK21zRGSzk5Uf3BACXfLSmM3s6WShfAKbGtkoA=
X-Google-Smtp-Source: AGHT+IFApVGYIiluQ6V//KKyvVa+N8o1/XlEG++DvWMnCS3ySSr/AKv0DWlWNQA7bkWDlxZMh4jquA==
X-Received: by 2002:a50:bb69:0:b0:54c:87a1:34fe with SMTP id y96-20020a50bb69000000b0054c87a134femr8479103ede.10.1703941467118;
        Sat, 30 Dec 2023 05:04:27 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id ij14-20020a056402158e00b00554368c9ce8sm11359578edb.1.2023.12.30.05.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 05:04:26 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v4 00/12] Unregister critical branch clocks + some RPM
Date: Sat, 30 Dec 2023 14:04:02 +0100
Message-Id: <20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEIVkGUC/43NTQ6DIBAF4KsY1qWRn4LtqvdoGoM4KAkBA2raG
 O9eNF21G5fvZeZ7C0oQLSR0KxYUYbbJBp8DPxVI98p3gG2bM6IlZaUkEo9hsBo3UXnd1yr4Wjt
 QfhqwuEqhCTMgiUb5vVEJvncZ8JNzuRwiGPva9x7PnHubxhDf+/xMtvbA0kxwiamUFW+pVNzwu
 7NexXAOsUObOtOjEt0kdakYFyUYKv4kdlRiWWLASKPhqsWPtK7rB+8p7yBqAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703941465; l=5058;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BX4AD0XKdE4IXC+Rm7JwsEKLVBZzcfLUrFI0a0Z2nm0=;
 b=bEAanTKBC7TP6EUNGTuwHzPQ6xbD7FPr/oHbFsFZyI8A6KXbP/a4TZsct1wjlXytuaWSXI+W7
 2/khx7fmCAOCUCluXvzwGdKiFOSg2i2tIcIrGVnfpY8ntXOtXO20h+7
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
 drivers/clk/qcom/gcc-qcm2290.c        | 105 ++---------------------------
 drivers/clk/qcom/gcc-sa8775p.c        |  25 +++----
 drivers/clk/qcom/gcc-sc7180.c         |  22 +++---
 drivers/clk/qcom/gcc-sc7280.c         |  20 +++---
 drivers/clk/qcom/gcc-sc8180x.c        |  28 +++-----
 drivers/clk/qcom/gcc-sc8280xp.c       |  25 +++----
 drivers/clk/qcom/gcc-sdx55.c          |  12 ++--
 drivers/clk/qcom/gcc-sdx65.c          |  13 ++--
 drivers/clk/qcom/gcc-sdx75.c          |  10 +--
 drivers/clk/qcom/gcc-sm4450.c         |  28 +++-----
 drivers/clk/qcom/gcc-sm6115.c         | 123 +++-------------------------------
 drivers/clk/qcom/gcc-sm6375.c         | 105 +++--------------------------
 drivers/clk/qcom/gcc-sm7150.c         |  23 +++----
 drivers/clk/qcom/gcc-sm8250.c         |  19 ++----
 drivers/clk/qcom/gcc-sm8350.c         |  20 +++---
 drivers/clk/qcom/gcc-sm8450.c         |  21 +++---
 drivers/clk/qcom/gcc-sm8550.c         |  21 +++---
 drivers/clk/qcom/gcc-sm8650.c         |  16 ++---
 drivers/clk/qcom/gcc-x1e80100.c       |  16 ++---
 drivers/clk/qcom/gpucc-sc7280.c       |   9 +--
 drivers/clk/qcom/gpucc-sc8280xp.c     |   9 +--
 drivers/clk/qcom/gpucc-sm6115.c       |  52 ++++++--------
 drivers/clk/qcom/gpucc-sm6375.c       |  33 +--------
 drivers/clk/qcom/gpucc-sm8550.c       |  10 +--
 drivers/clk/qcom/lpasscorecc-sc7180.c |   7 +-
 drivers/clk/qcom/videocc-sm8250.c     |   6 +-
 drivers/clk/qcom/videocc-sm8350.c     |  10 +--
 drivers/clk/qcom/videocc-sm8450.c     |  13 ++--
 drivers/clk/qcom/videocc-sm8550.c     |  13 ++--
 43 files changed, 230 insertions(+), 653 deletions(-)
---
base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
change-id: 20230717-topic-branch_aon_cleanup-6976c13fe71c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


