Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1047DB6E0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjJ3J6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjJ3J6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:58:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2379111C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:57:59 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c5210a1515so61778681fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698659877; x=1699264677; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=boPn1BJjjSE/ytLrgmFhqTRFBvGpmv5D8XGSJlsI6/c=;
        b=XGfR+XkJkschzG14v+iZz7tfpCZBpyaolER6H8zIRNeejF8TxwQsbAIFMrMTaA8Ykt
         OH7rdN5H/pwHdMjiO0Gbv61JPv7fIaYstFx28LbjtUdzKXj8hTYig50zjU3aHK078F3V
         vhxCrBD0A6Wiq7Pz+y4zVrQmsqXACvPdtbM1uNNNFLN+2qNA4q+xEuGYTvX7nXobFIo1
         6KP1Go3ab3shmTzV7uGRK+A98K1BNrEP9Kw+jb4VGGYIKzpPlhbIL3M/3Jfe7x6q04hz
         Jp0N0ChlEL+VtfRVybh/7wi+cZvMykLf1bp4Hbb6xQAytKyim360Wth7bsJF/Lfyof5/
         A5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659877; x=1699264677;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boPn1BJjjSE/ytLrgmFhqTRFBvGpmv5D8XGSJlsI6/c=;
        b=CmMmnmbi/GY98Pfg1PSB+j6J6WpsoraPsjy0ghtq9ZKxd9XCexu44p6KgLcypC+cs2
         KMcXka2KWwSdzJYjHgmll/mPllu63KxTQgPnklMNUIww9zZUM6GA5Ie357Sd1uFD5Ik+
         AsVVFc/U82f0VawqPsXHZRbxCY+AgJCjMb/FijtPTVRbZtKFJW1xa5t61djt6q8qWK2C
         GL/DcVDzpBz30fSUXA+gCFTzYyIqfK/77AYAEBeyPwYDypguM1wXfqax+DSgo97yPaXF
         Fk54vlsn66qLL/1PPpLxMKktgcLzIOUkQ8ppW9DJrYj3Xi+9w7aKhzxls0tI6LVMJ1H7
         1OXw==
X-Gm-Message-State: AOJu0YyPtqWV6puDdAiW4iQIG0Z3c+c+4VY5sGg9NIzYzdyPBvT/vDc3
        0xvf5sLsKEmc4/SFQ/x5N3J9Fg==
X-Google-Smtp-Source: AGHT+IEMVQHxFbY6ktxdqB9yv2n6nNHFNFcHUZP8HO2JOU7GFCQS6YBNivSexA+aWjJGhPvo52A8rw==
X-Received: by 2002:a05:651c:86:b0:2c5:2fa8:716a with SMTP id 6-20020a05651c008600b002c52fa8716amr7968437ljq.9.1698659877407;
        Mon, 30 Oct 2023 02:57:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b00402ff8d6086sm8703714wmq.18.2023.10.30.02.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:57:56 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 00/10] clk: qcom: Introduce clocks drivers for SM8650
Date:   Mon, 30 Oct 2023 10:57:47 +0100
Message-Id: <20231030-topic-sm8650-upstream-clocks-v2-0-144333e086a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABt+P2UC/33NQQ6CMBCF4auQrh3TlhapK+9hWJRSYCJQ0kGiI
 dzdSly7/N/iexsjH9ETu2Ybi35FwjClkKeMud5OnQdsUjPJZS64KGAJMzqgsSw0h+dMS/R2BDc
 E9yDIHTetKlR9aRRLxBx9i6+Dv1epe6QlxPfxtorv+oOl/g+vAji40tTaaKOcbW8DTjaGc4gdq
 /Z9/wAqYeXeyQAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3139;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6kOWUwSglVcj5gFYTNNhjlyysqL+sfrTrZAH9+/FiV8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP34fh4uYBtsbMq8xaz7b1Mva0tqDEbw9IcE/D+Mw
 SgciTNyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT9+HwAKCRB33NvayMhJ0QucD/
 9MXi4Lr7G32WDtPtRoxxP0HMKxlr9wPP35zJIM5LNxFRHlUBIg88qPdICSqJ52JyOVEXs/4rJOOtym
 Q3GFZPpDFCjq+9gOxtJy11395tUZUo32pjBcdRfcOBUkjXDJHWEjLvfej40pzATg/iPGPihIyOVv+A
 cu2HBzaavTGsJ9y4ALzMyG6z2Ez2IvxqstXN3PNn6TpCyLx41YKCw2T5N8XiS/zd1cdc57J/kVq6Xo
 sguALAt63wGJOB+JrAme5hthdT6DRpQwXXmRAaqlunqGhPzln52ohB9NbRweSMIAgKktnHQSsel7wZ
 3hxFASDNOiF78eCecmAxDdwY/fpqYFLvJAxAWY2v6ZEDkWnftfhK098b+LyryVbslWW3aMMU7fUNaE
 nVklmP9Kyd7j8Y7ceMBRYRao5FpjVJERAljZP4QGCzsYC4ZzUVdtd6Vl6c5p7p20iTbzIyA5hyG2SE
 3QlCZ8o6q3AOSPnFBRQjkWXU0ibfv1bLgGnjBycTlDsmDILd0eTe+8NG+qbdBV3FTi3a/Ra+UDCrP8
 uTkRRYdiED/4hHG4oT+iNFgpSjeMKFm6fvZgNHK5vXFqgPpp3LQC7trczpNa+ANl6VKb6nBreOdqki
 imsaBw4jPMtFwf/adbkCvcj9u4bKNsd66Ndqbqw5MHPe4nayvnRyPzD43Qmw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces the following SM8650 Clock drivers:
- GCC: Global Clock Controller
- DISPCC: Display Clock Controller
- TCSR Clock Controller
- GPUCC: GPU Clock Controller driver
- rpmh clocks

Dependencies: None

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Fix Copyright headers
- Fix include in all c files
- Use "select GCC" instead of "depends on GCC"
- GCC:
  - remove UBWCP clocks until we know how to use them
  - switch to clk_rcg2_shared_ops when needed
  - use RETAIN_FF_ENABLE and/or VOTABLE GDSC flasgs when needed
  - add GDSC collapse_ctrl/mask when needed
  - fix "Keep the critical clock always-On" comments
- TCRSCC: use qcom_cc_probe()
- DISPCC: fix runtime_pm_sync on error
- rpmh: expand comment on clk3a
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-clocks-v1-0-c89b59594caf@linaro.org

---
Neil Armstrong (10):
      dt-bindings: clock: qcom: document the SM8650 TCSR Clock Controller
      dt-bindings: clock: qcom: document the SM8650 General Clock Controller
      dt-bindings: clock: qcom: document the SM8650 Display Clock Controller
      dt-bindings: clock: qcom: document the SM8650 GPU Clock Controller
      dt-bindings: clock: qcom-rpmhcc: document the SM8650 RPMH Clock Controller
      clk: qcom: add the SM8650 Global Clock Controller driver
      clk: qcom: add the SM8650 TCSR Clock Controller driver
      clk: qcom: add the SM8650 Display Clock Controller driver
      clk: qcom: add the SM8650 GPU Clock Controller driver
      clk: qcom: rpmh: add clocks for SM8650

 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |    2 +
 .../bindings/clock/qcom,sm8650-dispcc.yaml         |  106 +
 .../devicetree/bindings/clock/qcom,sm8650-gcc.yaml |   65 +
 .../bindings/clock/qcom,sm8650-tcsr.yaml           |   55 +
 drivers/clk/qcom/Kconfig                           |   35 +
 drivers/clk/qcom/Makefile                          |    4 +
 drivers/clk/qcom/clk-rpmh.c                        |   34 +
 drivers/clk/qcom/dispcc-sm8650.c                   | 1810 +++++++++
 drivers/clk/qcom/gcc-sm8650.c                      | 3849 ++++++++++++++++++++
 drivers/clk/qcom/gpucc-sm8650.c                    |  661 ++++
 drivers/clk/qcom/tcsrcc-sm8650.c                   |  182 +
 include/dt-bindings/clock/qcom,sm8650-dispcc.h     |  102 +
 include/dt-bindings/clock/qcom,sm8650-gcc.h        |  254 ++
 include/dt-bindings/clock/qcom,sm8650-gpucc.h      |   43 +
 include/dt-bindings/clock/qcom,sm8650-tcsr.h       |   18 +
 include/dt-bindings/reset/qcom,sm8650-gpucc.h      |   20 +
 17 files changed, 7241 insertions(+)
---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-clocks-3c09f464b7d4

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

