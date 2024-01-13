Return-Path: <linux-kernel+bounces-25298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ACC82CD1D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D201F22297
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5460D139B;
	Sat, 13 Jan 2024 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q5A2u/Zp"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDDF15CB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ccec119587so89945421fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 06:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705157457; x=1705762257; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/I/XuCXTujbt8vVT93hkh8hG2X/qqDSbSC/vDBIwwM=;
        b=q5A2u/ZpdPqOCzCY65fvqKkZagGFZsuAA1mk2ykZgKRm8CPdqkoo0OQBMgjES3HLRe
         yu8k0WcrGmdGcjwVTVDcgQCLAPSq0V4hjLGitsdpPRJexc5qaWb6GbvlHamIl3nf1wkj
         fRkrljMfOwE+H3uzWFjtTQuWlyCVnDK1ViLnUagPtVMOJcLdR3oPffDnfbaUoctk/zSb
         HDQrd7VpVOi4Nxjw+76c8AlHlLp9dmCEF5zMr2ZdURPKwxQlShiSB9KT3nHThHPaWdZ2
         mqUNsIUlGyqOesgere3FigZs86/pAUMcXvTWtNKWIrw3E4ijFP9zmY7ULYAwYpD4KKsr
         VWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705157457; x=1705762257;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/I/XuCXTujbt8vVT93hkh8hG2X/qqDSbSC/vDBIwwM=;
        b=hp1iBuy/LvOdtPZax0cMB0jvD6ZQg1j2auiymd6MYLPvIN9V/pgX6HTmsvQGbfdkqv
         tLcdYdC2ALOyqlnc0RBvt7gN+s6PRcMxVwHUwcKFr2YyC52dO+JrMTcexXtW2fMXsjSe
         K2O9SDa7P9iMxbtvzRYQgWhn4QudPZQz2JwXi6ChhsbVAwA2upfPdYZ8cnjHANJ1h/z2
         b6vvpEh4/8qHP9Jt4F26R1/RoQ8guukSLlECfUvieg1tUfYOT7ujGq4NLHbofcAoPtIU
         apm2zm4VRKU714RejY9HW8FFCmTgBkflLHn/mBogubFx1EzK6hRuKKXExVBaI4QB/4Iz
         8Ljg==
X-Gm-Message-State: AOJu0Yyys4ukbEhv2bHnu+BCEa4pg3HpTXA8oe0fznS1MoELWDBhxMHG
	2/FeEmrIfB2Hl0MR7NGaFV55s12ffzC41rv6nA37g8EaLUE=
X-Google-Smtp-Source: AGHT+IEIkD8M+NRpyGNFGTUOTUgSGHF6/CfxX89txVZtbvmTwMrQqcYA225a9wiy10Vh5XUxVPwmlg==
X-Received: by 2002:a2e:9094:0:b0:2cd:2334:ed0d with SMTP id l20-20020a2e9094000000b002cd2334ed0dmr1484478ljg.88.1705157457269;
        Sat, 13 Jan 2024 06:50:57 -0800 (PST)
Received: from [10.167.154.1] (178235179017.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.17])
        by smtp.gmail.com with ESMTPSA id es18-20020a056402381200b00554b1d1a934sm3014593edb.27.2024.01.13.06.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 06:50:56 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v6 00/12] Unregister critical branch clocks + some RPM
Date: Sat, 13 Jan 2024 15:50:49 +0100
Message-Id: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEmjomUC/43NwY7CIBQF0F8xrAdTHhTElf8xMQbow5I00IA2Y
 0z/faiZjXEWLO/Ne+c+ScEcsJDj7kkyLqGEFGuQXzviRhOvSMNQM4EOeKeYorc0B0dtNtGNF5P
 ixU1o4n2mUivpGPeomCP13ZqCf3cViPdpquWc0Yef1973ueYxlFvKj9f8wra2YWlhtKOg1EEMo
 Izw4jSFaHLap3wlm7pAqwSbZPoDF7JDD/JD4q0SrxJHzqxD7eQ/kmiVxCaBA80HHDTrP6S+Veq
 rpLUWgNJ6Zs2btK7rL2ZRG3H+AQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705157455; l=5611;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vkGbXU848WEspgSharGEk+6olgNHHL+yL2Y/bvSVj1Y=;
 b=B+x4cJRS0CIrn1Z9W2YFKQpp0A4nI77fQC9MYbBOHmqv1dBNWdU9qu9Lf7YuSAeHDNYnTJhEQ
 C2AaPzVQLX8CuPgjNFWbsaIK3c8GZlmfGTJ1myCgprrkpOhYypfjjdI
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
Changes in v6:
- Rebase (next-20240112)
- Reorder qcom_branch_set_clk_en calls by register in "*: Unregister
  critical clocks" (Johan)
- Pick up tags
- Link to v5: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v5-0-99942e6bf1ba@linaro.org

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
base-commit: 8d04a7e2ee3fd6aabb8096b00c64db0d735bc874
change-id: 20230717-topic-branch_aon_cleanup-6976c13fe71c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


