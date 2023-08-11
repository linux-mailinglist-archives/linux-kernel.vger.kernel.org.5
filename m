Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C21C7798BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbjHKUso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjHKUsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:48:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9602D55
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:48:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe58faa5cfso3788184e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691786920; x=1692391720;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5TPOEsfFCSpiqVwGkRqEltiUJSr99Y9mXi/siq2ftI=;
        b=GFhm2MAx+1kKc2pRbgWkaOtekCI6A76FsUWMFpywmyuvzy1q8FlICaYYMm37i/TwmE
         z6ZgTPxlyPzARk/kHs9CROagJHsJ6P5CMgOTTA5UsmU/BjiElUvCkrVF+tUkBYhTSw1+
         XzQ6kN/mRUnhL3KQUJ9HI9Vu0bJ+R3LDNwZs3wErYCzy5/vCI4ecQWSdWvZ9MbBZYapr
         BUZt9GXkm1QGvgr4lHzTvuUWnYMi+/nB2MytfpSKNpert6BUr3fIK5g1gXk4krU/Wamm
         hzZ92IKeut8YbPPIayyTf01PIDm3Mtt1Qrl5qXMOdzlbJd6WdrQjyMIi+98iM6OWgfz5
         oCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691786920; x=1692391720;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5TPOEsfFCSpiqVwGkRqEltiUJSr99Y9mXi/siq2ftI=;
        b=DmwbiUl3fzdcc9fF5h5xOrstv+UHuMela/hb5Dje/bXdDKDiYpZrhWtMoCyhWUhGQT
         yHjHh2LlbWKTxJLy4Lh9i/8aHwrIu67rkLx+Psw7DnYdPgZeqNQMALNbhkTX5GOEln1O
         x1rbw/AhdGKpVxKchu5J/VIasWGghpXLAK1/R70r+/5+0q60MewK7elG02D3Jdxf9Mgb
         l+a40qJhKsLNqbkpUfuXnYQe9aFU+qkGwoErfifyi0uhLWI+RJSaa4Fg5phIdztmjXDP
         E3eXV6XwUhk/P8vXspRiSi1EEc1B++g3ghVszoF9DnLqcyvMqMcqfPoPtRGwTefXTAYD
         qkXA==
X-Gm-Message-State: AOJu0YxRoaGPC6OkJn+lmQ0VEU0hbOOx1J00LXwH76fWOzy5ZebhjAKK
        bbzNV7W1kUnQM18eRxboYSnCpg==
X-Google-Smtp-Source: AGHT+IGnwyortsfYOQzQO7Zei8frL+xb8cL3tzUtPlW3b94eb06Zen7O6v6vUzM+9WQ24bI8LP/aYA==
X-Received: by 2002:ac2:489b:0:b0:4fd:c0dd:d54b with SMTP id x27-20020ac2489b000000b004fdc0ddd54bmr1896767lfc.65.1691786920098;
        Fri, 11 Aug 2023 13:48:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id w1-20020ac24421000000b004fe8d684172sm843603lfl.234.2023.08.11.13.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 13:48:39 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/6] Add missing wakeup-parent to TLMM
Date:   Fri, 11 Aug 2023 22:48:33 +0200
Message-Id: <20230811-topic-tlmm_wakeup-v1-0-5616a7da1fff@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKGe1mQC/x2NQQqDMBAAvyJ77kKiqMWvSClJXHVpjCHRKoh/7
 9LjDAxzQabElKErLkj05cxrENCPAtxswkTIgzCUqqzUU2vc1sgON78s78N8aI9IbV01Q90o1Vq
 QzppMaJMJbpYy7N6LjIlGPv+j/nXfP4W7uCN4AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691786918; l=1351;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2CeVul6akyOZYYHElLa9VXIasUqtIOe+mOACljBs9AA=;
 b=2WrImQ3CbRPCdZuhhDZXc5yDApLDnTkafPK26hLizc0LPxetDxGur376mcWiuXEiZqbISvyQd
 rqKapqqNU9MD4DT3pJIXJ04QE+tp5l7ikjBvXxeAuI5NQVeycTgRXDC
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some TLMM pins are wakeup-capable, but not all platforms described that.

While MPM is not yet hooked up, PDC platforms can and should utilize this
functionality. This series attempts to do so. As part of it, I had to add
PDC support to SDM670, as it apparently hasn't been introduced yet.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (6):
      dt-bindings: interrupt-controller: qcom,pdc: Add SDM670
      [RFT] arm64: dts: qcom: sdm670: Add PDC
      arm64: dts: qcom: sc8280xp: Hook up PDC as wakeup-parent of TLMM
      arm64: dts: qcom: sa8775p: Hook up PDC as wakeup-parent of TLMM
      arm64: dts: qcom: sdm670: Hook up PDC as wakeup-parent of TLMM
      arm64: dts: qcom: sm6350: Hook up PDC as wakeup-parent of TLMM

 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml    |  1 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi                         |  1 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                        |  1 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi                          | 11 +++++++++++
 arch/arm64/boot/dts/qcom/sm6350.dtsi                          |  1 +
 5 files changed, 15 insertions(+)
---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230811-topic-tlmm_wakeup-e7536d56007b

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

