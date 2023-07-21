Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E5575CBE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjGUPgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjGUPgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:36:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B3D35A3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:36:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso3394158e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689953769; x=1690558569;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNWCdaJdpClcitMaIL9p7WOYWVXCxYwceUbe7OdUFQU=;
        b=KPnDZPYYz24xIjuhQDTvVyfwtgZoAkcRKUSpNvEi28AUyssfjyjRGx2AfDR29+iT+h
         jkXHyasxK/pCcDfxsplUs9Wfd2EIqFnOaTTvJkkJH50BGHcRhVGnn2QvjPwkbi/UZiDQ
         J/lORLm7/5zQM2HlGlef2I8j/n7AZrJNP4wkliN1M8/l0T+O48CtjV7GzQNd65dqWE97
         1a6x/RQIW5Osilx1P7haYO2eoIWzbt4WY0BYVIyKIWphmggtdafTvFYt8jbbDLEuaBDZ
         rvVgipYwj58GaHvXBnlM7AOLsy1iqoKep5Hg9XxyNxm0GuQrgTbB2DfgyuuFRPaiG3OQ
         QmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953769; x=1690558569;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNWCdaJdpClcitMaIL9p7WOYWVXCxYwceUbe7OdUFQU=;
        b=kXKIGio/G0CP68WZRzZW24TNG5FrZskWV1NEgNAvC5hmTYZ8iHVL9/uGTSq9CT6sV3
         MDKAAjpYYCjLYqFT3uvGAIBKd2aQgq48+0afM63vccHnrqWZJTku0dYZhAKlfVoaIDzy
         c6hvKlQ1pg5AzmIAf8BtG2mou1C70XJaHGrOZjbGYf1PnNCRLk/Yb/hJ1bG7XsBrR6K8
         v9kksdiY6CO9Le7q8vbr4k7GqjWPJRohqoNMqgfg7/LKHkd4MMzosOdOpK2t1FovczEX
         NQ5unYi1bSZPd4a0ZdSjkRsHAiURxAXuyEQa5gL8yZpzCXBTWapVv0r4qkzEn4PRksAb
         v47w==
X-Gm-Message-State: ABy/qLYBynhFPXc0e6Dq5JnoL3kdsfhhoZ1HyouaN08ixfSHXPvrhfjj
        kgZUFY/q2cZTJUbhllVEjuwgBw==
X-Google-Smtp-Source: APBJJlEWsQH7vQXNdvfKKwzYrZg4NjS/CWHBzHmpytj3/CqqwwBopJV9EP+dBekKjX+CEaUD3BBYIg==
X-Received: by 2002:a05:6512:23aa:b0:4f8:6ac4:84 with SMTP id c42-20020a05651223aa00b004f86ac40084mr2004363lfv.8.1689953768733;
        Fri, 21 Jul 2023 08:36:08 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id t9-20020a19ad09000000b004fba1278e6dsm782535lfc.107.2023.07.21.08.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:36:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 00/11] Clean up RPM bus clocks remnants
Date:   Fri, 21 Jul 2023 17:36:03 +0200
Message-Id: <20230721-topic-rpm_clk_cleanup-v1-0-cf6cd5c621d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOOlumQC/x2N0QrCMAxFf2Xk2UBTBcFfEZG0y1ywdiV1Ioz9u
 8GH+3AuHM4GXUylw2XYwOSjXZfqQIcB8sz1IaijM8QQj+EcCd9L04zWXvdcnj7hujakFKcTE+c
 xELibuAsm45pnt+taip/NZNLvP3a97fsP+NpVrnwAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689953767; l=2180;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4fL61MHD0Kzh42mw3EY0OMR0foISpp2lD0Ucz/dWu/E=;
 b=3NHRlG5hjOMt1yY+y8JJLaNsK0ZsVpOwbUrA2J496pNW0yW124rAEN1I6lTvm1Dq6Lo6g7VQP
 YT5J0o7v0GACFWTXqLVy2EAGHf1TIGrnOxFV3YVRvxTCuD9HPv5Bl5x
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

After the recent cleanups ([1], [2]) some in-tree abusers that directly
accessed the RPM bus clocks, effectively circumventing and working
against the efforts of the interconnect framework, were found.

Patches 1-5 drop deprecated references and the rest attempt to stop
direct bus clock abuses.

Depends on [2].

8996 and 8998 remoteproc changes were not tested, they never worked on
my Sony phones.

[1] https://lore.kernel.org/linux-arm-msm/20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org/
[2] https://lore.kernel.org/linux-arm-msm/20230721-topic-icc_bindings-v1-0-93e2bc728fb7@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (11):
      arm64: dts: qcom: msm8916: Drop RPM bus clocks
      arm64: dts: qcom: msm8996: Drop RPM bus clocks
      arm64: dts: qcom: qcs404: Drop RPM bus clocks
      arm64: dts: qcom: sdm630: Drop RPM bus clocks
      arm64: dts: qcom: msm8939: Drop RPM bus clocks
      dt-bindings: remoteproc: qcom,adsp: Remove AGGRE2 clock
      dt-bindings: remoteproc: qcom,msm8996-mss-pil: Remove PNoC clock
      remoteproc: qcom: q6v5-mss: Remove PNoC clock from 8996 MSS
      arm64: dts: qcom: msm8998: Remove AGGRE2 clock from SLPI
      arm64: dts: qcom: msm8996: Remove AGGRE2 clock from SLPI
      arm64: dts: qcom: msm8996: Remove PNoC clock from MSS

 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |  2 -
 .../bindings/remoteproc/qcom,msm8996-mss-pil.yaml  |  2 -
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  9 -----
 arch/arm64/boot/dts/qcom/msm8939.dtsi              | 12 ------
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 43 +++++++---------------
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  5 +--
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |  9 -----
 arch/arm64/boot/dts/qcom/sdm630.dtsi               | 29 ++-------------
 drivers/remoteproc/qcom_q6v5_mss.c                 |  1 -
 9 files changed, 20 insertions(+), 92 deletions(-)
---
base-commit: ae867bc97b713121b2a7f5fcac68378a0774739b
change-id: 20230721-topic-rpm_clk_cleanup-1b2f4a1acd01

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

