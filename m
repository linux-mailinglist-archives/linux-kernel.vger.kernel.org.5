Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869C57E9841
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjKMI4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjKMI41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:56:27 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBA410CF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:22 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9d242846194so615214966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1699865781; x=1700470581; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BsrM2PDilSjaMLE5U2fdt5pzgmWoxeOH6PNobCuBiz0=;
        b=FSpMhuH/3Zfeac8j1BJ2eRmh5UChmU3h0O/1f0MZpcATECPV6lY0p1pHAceVNycu+7
         8wVZKydkdXK4wgmlTTPwL5RaIJSBj2+XmGWsBf4U21LKX1v2Y3k5IrDsWtu5FDY9mHi5
         H+1F7/vgoBhlszOfihRvjH7XVIwr624IJWMPUgz1VAuTDuCHk5cd41VKipdd1mey2WL9
         J8JuZRXQW6zI3d7s+3fzS0IGOZQLWMVajmE98Oqe2vLZjYVS3nb07ZpF8ub5SORII57Q
         /5wFGaqytQ6f5rhYwxy0BhQSOVql8/0/faWNlWzdP+VLBX536IouUkgXb5E7S+vYDTpF
         8SmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865781; x=1700470581;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsrM2PDilSjaMLE5U2fdt5pzgmWoxeOH6PNobCuBiz0=;
        b=J5FjNjSQSDC+c0GUZwOOk/77QsPwZxpmgZLQ9bVHvlVxgekrcGNQ4i+QtqbMaVna89
         N4aDmsIOYuNQMWMUv/JWHM+kloYqcry6UxE6puvMh5AeNevNCa28oB+Rn03KshkSS+Eg
         V6CNJFhPJ34FJf2gFUUo2gYTY88UeL02wRPuijhOjY6u4jx4nng3sIjuqdMMOISMTwcY
         dG76uxWTuHB+Mg9YkFPR8wJnkhIUKPYD3H7bKHRCqTwPa8xHYAHaeLEo/GFkXic1nR4x
         jYfaoTRaiek//nZGq2Dbm0zO78T7BCS+s+ofbiqYJP3LjC/mZKUNeozxMBE01MVP72Rt
         q6Ig==
X-Gm-Message-State: AOJu0YwkKK1idxG6lQZgL7tXXfGLf8vNPW6+LTdplQdKogFP4MzR9IoV
        hAIgvJ6HCM7FXOrVEBXejUM1qw==
X-Google-Smtp-Source: AGHT+IHlTp66zVzK76fU9FdGoO9JFmDj4DyrwLiTq46FFbsxHQAjsaN6E5t9RqrwzKCvGBZ5oYhhAw==
X-Received: by 2002:a17:906:3458:b0:9dd:dc2a:eb8b with SMTP id d24-20020a170906345800b009dddc2aeb8bmr3641569ejb.41.1699865780941;
        Mon, 13 Nov 2023 00:56:20 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id kk22-20020a170907767600b009c758b6cdefsm3673538ejc.128.2023.11.13.00.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 00:56:20 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 00/11] Remoteprocs (ADSP, CDSP, WPSS) for SC7280
Date:   Mon, 13 Nov 2023 09:56:11 +0100
Message-Id: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKvkUWUC/32NQQ6CMBBFr0Jmbc202ACuvIdh0QyDzAJKpoRoS
 O9u5QAu30v++wckVuEE9+oA5V2SxKWAu1RAU1hebGQoDA5dbdE1JlHjWjTKc9x41UjJ4K112BJ
 ZtjWU4ao8yvuMPvvCk6Qt6uf82O3P/s3t1qBBT9z5oautD48xiK5TXPhKcYY+5/wFIsfscLgAA
 AA=
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
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Then there's two patches reorganizing the reserved-memory setup for
sc7280 in preparations for the new remoteprocs.

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
Changes in v2:
- Add patch renaming memory@ reserved-memory nodes (preparation for
  next)
- Add patch moving mpss_mem and wpss_mem to sc7280.dtsi
- Follow *_mem node being in sc7280.dtsi also for ADSP & CDSP patches
- Use (squashed) .mbn instead of (split) .mdt for FP5
- Set qcom,ath11k-calibration-variant for FP5
- Pick up tags (except for Krzysztof's R-b for ADSP & CDSP since there
  were changes)
- Link to v1: https://lore.kernel.org/r/20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com

---
Luca Weiss (11):
      dt-bindings: remoteproc: qcom: sc7180-pas: Fix SC7280 MPSS PD-names
      arm64: dts: qcom: sc7280: Remove unused second MPSS reg
      arm64: dts: qcom: sc7280: Rename reserved-memory nodes
      arm64: dts: qcom: sc7280*: move MPSS and WPSS memory to dtsi
      dt-bindings: remoteproc: qcom: sc7180-pas: Add SC7280 compatibles
      remoteproc: qcom_q6v5_pas: Add SC7280 ADSP, CDSP & WPSS
      arm64: dts: qcom: sc7280: Use WPSS PAS instead of PIL
      arm64: dts: qcom: sc7280: Add ADSP node
      arm64: dts: qcom: sc7280: Add CDSP node
      arm64: dts: qcom: qcm6490-fairphone-fp5: Enable various remoteprocs
      arm64: dts: qcom: qcm6490-fairphone-fp5: Enable WiFi

 .../bindings/remoteproc/qcom,sc7180-pas.yaml       |  21 ++
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts |  45 ++--
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |  35 ++-
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |   7 +-
 .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi   |   1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 271 +++++++++++++++++++--
 drivers/remoteproc/qcom_q6v5_pas.c                 |  19 ++
 7 files changed, 336 insertions(+), 63 deletions(-)
---
base-commit: 9046efc22ed7a73cb888a8c5660a21f99c89af03
change-id: 20231027-sc7280-remoteprocs-048208cc1e13

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

