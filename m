Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06408753B31
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbjGNMk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjGNMk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:40:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA6269D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:40:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so3249483e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689338451; x=1691930451;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMCvrRbG3eEHni7DJadXrX/4XYjVj/I3WUzNH8fXQ/s=;
        b=FVZ0RTM9dtahF48Q6C/3ClhJsT7ZCh6UweyM2SlNHmXjOuLcOPoilZRlltV4LmccnK
         ZUPGoIwV7jCNM8755sKuyQ3rw0g0L0AteDQ9sHgNCXKCzteRIVHq56lBz37jA4/I5Erg
         VvZixzMHNTh4nmxpbvkf3r7Yl07QLS93CKNIwXXczpvu2YLD35GrhjXP6vxCdPmHUFJc
         J/YK4FLPxDCwFLKGMynkrT/h7DnT/RGhde5f6gm7C3pAbR24UFSVR2MBlOZvNgnWsIHv
         CaWk9k8+8TZfmQ/Yp8kaiy1XOn/X/Gp0THAryfOIpPu72t3o3QeuDoy4+AOPw5uJg2fv
         QpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689338451; x=1691930451;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMCvrRbG3eEHni7DJadXrX/4XYjVj/I3WUzNH8fXQ/s=;
        b=MFyXRRqZboyDmxhaGJAs+aZgJzIEE+93Xd30bV3SabrnPdQ5yvUiqDxY6T9Vsf3VTw
         Beygkv++6mp24MKNdsfA4yLJ9kXpsjqdIhnK5dtic+MLGA7ODNEPV+a7SJIyZV+Db95H
         ZbuLyS9vIqpvjmoWsmAxTXw5R8cXvW6C9rg9ElaTp69kt/3yoiAKOXx5c9v7IKNbj2YP
         L710hHE0PRtxx15iQtaHAQMTfTTGMUqW7mLMcV1wPvjW98Ma566UODKvxfsI6zZRe9XJ
         b1fBTZ6zYTTQQGd/g6tTZL/4mbOtOqmNVY6KQP30g612wCmOm+80vLLhyWxULql4o0hj
         ghOg==
X-Gm-Message-State: ABy/qLalspa9NXe8JTYTRbxodO9gZR7OhPZdGdcnMeKRv5PY8yxnprvq
        0mpQvG1eDiTIXkuQDzPzJklGOA==
X-Google-Smtp-Source: APBJJlHn/5VdSC50EYrgnvHeqg01QGP4ijhCvZtnycHIAeQhFQcagg+At/7vpMK0Zx2lkwknnnOBTg==
X-Received: by 2002:ac2:5f62:0:b0:4fb:7be5:46b3 with SMTP id c2-20020ac25f62000000b004fb7be546b3mr3154336lfc.55.1689338451328;
        Fri, 14 Jul 2023 05:40:51 -0700 (PDT)
Received: from [192.168.1.101] (abxj146.neoplus.adsl.tpnet.pl. [83.9.3.146])
        by smtp.gmail.com with ESMTPSA id b6-20020ac25e86000000b004fb2244563fsm1482588lfq.289.2023.07.14.05.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 05:40:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/3] Clean up LPASS_LPI probe
Date:   Fri, 14 Jul 2023 14:40:45 +0200
Message-Id: <20230714-topic-lpass_lpi_cleanup-v1-0-dc18b5bd14f7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1CsWQC/x2N7QrCMAwAX2Xkt4V96TZfRWSkNXWB0oXGyWDs3
 Q3+vIPjDlAqTAr36oBCX1Zes0FzqSAsmN/k+GUMbd129dD07rMKB5cEVeckPIdEmDdxsRvQ38Y
 4TeMVrPao5HzBHBbr85aSSSkUef/vHs/z/AGX0pT2fgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689338449; l=1045;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=8DDyjVP4q1BXBuCaQyRFK9fvQH4xjE517KGgWzFlkr8=;
 b=b1FrtZd1MuxUfhJsK5Wr1mfg1aiJEuK6IjqOsNdVulkGBV8FHgOlJCzv7n1uxgroV777dQQwn
 BU2nBIxCY8mADjTujPRSXN/BsPmT0QPYyNRpbP+K47AVeo8Bf/ZRynC
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs (like SM6115 or SC7280 with various firmwares) expect a single
clock for the LPASS pinctrl.

This serires addresses that by simplifying the probe code and relying
on bindings to sanction the correct number of clocks. That allows us to
shoot down another downstream-ism.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (3):
      pinctrl: qcom: lpass-lpi: Make the clocks optional, always
      dt-bindings: pinctrl: qcom: lpass-lpi: Remove qcom,adsp-bypass-mode
      arm64: dts: qcom: sc7280: Remove qcom,adsp-bypass-mode

 .../devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml  | 5 -----
 arch/arm64/boot/dts/qcom/sc7280.dtsi                                | 1 -
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c                            | 6 +-----
 3 files changed, 1 insertion(+), 11 deletions(-)
---
base-commit: 7c2878be573282a9961c359b806ccf70afe1a6b6
change-id: 20230714-topic-lpass_lpi_cleanup-f37ab68f9985

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

