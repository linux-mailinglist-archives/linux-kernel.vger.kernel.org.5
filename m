Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A554A7D9B19
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346169AbjJ0OUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346124AbjJ0OUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:20:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33FD10A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:20:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b95622c620so347453166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1698416430; x=1699021230; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0/j0TiNzPUhDHoMqO5+ZQ6Ubp+GWwLgzxQZaKqp7fdY=;
        b=cqkVYRwB/Gy4YBzI/DvRTzW/lADWc7ljNMXAxq6eukVHNWV4G81RvzjBc+3LsujeMV
         Iw6ioToqIXaNhqHwxK1FGIupDlI62EAmyH0EKDZ4Irq8y0Ky25hsKPaV8rCGezBjrNoL
         qLV+GeIto8Tz71NvV/A1ueN0oRSiyo5yVCSBP4MQ/xHnf0N2F3onCBqFePcWPBAOcSQM
         majP/l9ppJwlB47i8zMQC1m930eN7wBW1FLb7BpiauJcBfASaqgxPEYTBB5FqLsCWThI
         pYXPy093Vj59nnEW72ZVCb3AwmqnmgCqwmGiW699B/8ivXjPIc9XXMZyYlaJbCFlJaB5
         S8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698416430; x=1699021230;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/j0TiNzPUhDHoMqO5+ZQ6Ubp+GWwLgzxQZaKqp7fdY=;
        b=P6W7ohiCjMApqkWGrg388hazgAtznlXZmrhJValacOhlCZhvBpqkHjOUJQqbReV/wZ
         b2RJY5LB9Orj9FQPa3KfuW6G1fpiomCoFpMFQFaBQgA7vJZuoaqSeRhSNTwJkZwGRmhw
         FEC8Pkk7F65CO5q2rx8BE+FXsneXAujSbnRpo61iiQeDjD943jcz/G9iaIILS/RnOpN4
         Zf5OgJnDxft5IXXsQG+b3Yh6mqAI1OOjQegn1BHdO5uhD9b+fBSwucRGS7ytwQWA3DtE
         aBScgRwm13ivOv0ybYIdgX6+mz9sT6IoTY+Mbkf7g14oTu2c+Tve80Thz4C485dSfZ1+
         i/iw==
X-Gm-Message-State: AOJu0Yym5LmsJLrDdxTdMtacGfOThkYgnIZjg/jLg/fzgRRq15GEwwcT
        6scobJlCNLWCjLJ/7bJdkLteHw==
X-Google-Smtp-Source: AGHT+IEHU68OfuGWAvG3zTnVTKwBQCICdozH6KFZV9fK/3NTvhj+P36e1Upf25B4a1jWyFcm/BO63A==
X-Received: by 2002:a17:907:5cb:b0:9b2:7367:a6a4 with SMTP id wg11-20020a17090705cb00b009b27367a6a4mr2620117ejb.31.1698416430256;
        Fri, 27 Oct 2023 07:20:30 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906075700b0099cc36c4681sm1254076ejb.157.2023.10.27.07.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:20:29 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/9] Remoteprocs (ADSP, CDSP, WPSS) for SC7280
Date:   Fri, 27 Oct 2023 16:20:22 +0200
Message-Id: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACbHO2UC/x3MQQqEMAxA0atI1lNIo2DxKjKLIUbNQivJIIL07
 haXb/H/DS6m4jA0N5ic6pr3ivhpgNffvkjQqRoIqY1IfXDuKWEw2fJfDsvsAbtEmJijxBZqeJj
 Mer3T8VvKA2dC/J9kAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the ADSP, CDSP and WPSS remoteprocs found
on SC7280. And finally enable them and WiFi on the QCM6490-based
Fairphone 5 smartphone.

The first two patches are fixes for the MPSS to fix some dt validation
issues. They're included in this series to avoid conflicts with the
later patches and keep it simpler.

Please note, that the ChromeOS-based devices using SC7280 need different
driver and dts support, similar to how there's already
qcom,sc7280-mpss-pas for "standard" firmware and there's
qcom,sc7280-mss-pil for ChromeOS firmware.

I'm aware of the series also adding SC7280 ADSP support with the last
revision sent in June this year.

https://lore.kernel.org/linux-arm-msm/20230616103534.4031331-1-quic_mohs@quicinc.com/

However there's some differences since that series added the "pil"
variant for ChromeOS, not "pas" for standard firmware. Also it seems on
ChromeOS devices gpr+q6apm+q6prm is used. On my device it appears to be
instead apr+q6afe+q6asm+q6adm but I don't add either in this series to
keep it a bit simpler, and I couldn't test much of that yet.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (9):
      dt-bindings: remoteproc: qcom: sc7180-pas: Fix SC7280 MPSS PD-names
      arm64: dts: qcom: sc7280: Remove unused second MPSS reg
      dt-bindings: remoteproc: qcom: sc7180-pas: Add SC7280 compatibles
      remoteproc: qcom_q6v5_pas: Add SC7280 ADSP, CDSP & WPSS
      arm64: dts: qcom: sc7280: Use WPSS PAS instead of PIL
      arm64: dts: qcom: sc7280: Add ADSP node
      arm64: dts: qcom: sc7280: Add CDSP node
      arm64: dts: qcom: qcm6490-fairphone-fp5: Enable various remoteprocs
      arm64: dts: qcom: qcm6490-fairphone-fp5: Enable WiFi

 .../bindings/remoteproc/qcom,sc7180-pas.yaml       |  21 ++
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts |  24 +++
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |  24 ++-
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |   2 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 225 +++++++++++++++++++--
 drivers/remoteproc/qcom_q6v5_pas.c                 |  19 ++
 6 files changed, 300 insertions(+), 15 deletions(-)
---
base-commit: 6a0dad42244c987e3c12bfae728199e360acf079
change-id: 20231027-sc7280-remoteprocs-048208cc1e13

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

