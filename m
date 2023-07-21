Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9016475C86A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGUNyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGUNyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:54:23 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0FA273A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:54:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fba74870abso3221704e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689947658; x=1690552458;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKID3iVQH5n9h8RKBsuwUVNGEeysVbMR50pc5l3Ilu0=;
        b=HoH/uzLs5rN/KQTy/ozW4NalUSymBB9CYBNtvTJf1o7NbdtZu3VmE9rp0OERiPsiU1
         cu4o1FqMMzkJSc4i3FpbQR8WXfA8fOqQb/+e2DENLH+tFTCpiFcnqHs9r/e7zG9+6Q0e
         AD6GP8vw/wzCmOzJHs2vLwHv2BA8djOtcQhhojc6bvtf8rIhvabosp5A2K+Vd3ZMWnX5
         YBCTiKXn4g0QTewgm7ehiH4jpkqJe+7/JthbdWrcdAnyfy/v07ngEtni9+Zjl19a1hX4
         ufD8KPu70R9tETjEPpW6XWo8wCiuD+taRZQX9BKW7cRrtl1WX/+J8YGI5LnSColsZSzh
         +j+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947658; x=1690552458;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKID3iVQH5n9h8RKBsuwUVNGEeysVbMR50pc5l3Ilu0=;
        b=H9Xe5nNgesZ4+oD40NenWl9NYZRXS5wjCubaYD7t5P8jHHbAEA1BLVBfArkmYjmF0f
         4/JuXqm49/wd/TdCxVHEP9sYbTrpuPm4mSropY0GdGi8053WyjYQCduegnkv0SHR2r78
         mFCgCvUlad5Xgus6OFTf5juHHF3OCR4Eyv89+oXrkWAsY0iPA6eakYquMjjv7I26ZN4U
         5UU+Z5p6seh8lJOTSP4sWOgSfVO9BTWGEJ2GBzY7axauVf8HdJXVmsgUS8J27klfOT3A
         hNwU13go7xQ9r9hvPNxE6EegrOer+m9kJmfQRG9nU6EJYVcju/a2mU188tVuMFfqdodF
         FgeQ==
X-Gm-Message-State: ABy/qLaNNgFT1FEmfWpkZZ/q5gKlX4Kx+9Fm8HwgdCXQnmERfbSYW2dJ
        /bU9koha2IH6cAbIXC7C1Ef/Kw==
X-Google-Smtp-Source: APBJJlEwRYvgUcZ2vs7ZV9h8nJeMgbF7zh+vWPUMZuhuyCxCAxZDIIdomJFZhF2xUTkzFsvuPIDNKg==
X-Received: by 2002:a2e:7205:0:b0:2b9:383b:89fc with SMTP id n5-20020a2e7205000000b002b9383b89fcmr1599079ljc.0.1689947657987;
        Fri, 21 Jul 2023 06:54:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id k21-20020a2e92d5000000b002b6ad323248sm953838ljh.10.2023.07.21.06.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:54:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/7] Update RPM ICC bindings
Date:   Fri, 21 Jul 2023 15:54:10 +0200
Message-Id: <20230721-topic-icc_bindings-v1-0-93e2bc728fb7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAKOumQC/x2N0QqDMAwAf0XyvEDb4Yr7lTFGW6MGJErjRBD/f
 WGPd3DcCUqVSeHZnFBpZ+VFDPytgTIlGQm5N4bgwt3F4HFbVi7IpXwyS88yKsbQ+ej8Y2i7Fiz
 MSQlzTVImS+U7zybXSgMf/9PrfV0/2uIg63kAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689947656; l=1988;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xqMYpd9F/kb53hSBYg/8pwD7vM3ZQ2FNDVHQCyN099Q=;
 b=kg392TliDi3WroYKThrRrZneSn9sSCIXlf/aQDHNb1GFqhp3vBMsPcjn57Ewxd4QmDdNyQGuh
 VmJBN3eykaqDehKBDDXT1QIiuVa+lgc54ysoMm+9oHIRgvKR4v91WNP
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent necessary overhaul [1] of how we represent SMD ICC and RPM
bus clocks changed the way they're connected. The bindings however were
not updated to reflect that. This series tries to address that, while
also making the relevant bindings less convoluted.

Now, instead of referencing RPM SMD bus clocks via clocks=<>, they're
handled internally within the interconnect framework (via direct RPM
calls from there). We still need to allow some "interface" clocks,
which are necessary to access some registers and not managed for us.

[1] https://lore.kernel.org/linux-arm-msm/20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (7):
      dt-bindings: interconnect: qcom: Introduce qcom,rpm-common
      dt-bindings: interconnect: qcom: qcm2290: Remove RPM bus clocks
      dt-bindings: interconnect: qcom: Fix and separate out MSM8916
      dt-bindings: interconnect: qcom: Fix and separate out QCS404
      dt-bindings: interconnect: qcom: Fix and separate out SDM660
      dt-bindings: interconnect: qcom: Fix and separate out MSM8996
      dt-bindings: interconnect: qcom: Fix and separate out MSM8939

 .../bindings/interconnect/qcom,msm8916.yaml        |  52 ++++
 .../bindings/interconnect/qcom,msm8939.yaml        |  74 ++++++
 .../bindings/interconnect/qcom,msm8996.yaml        | 165 ++++++++++++
 .../bindings/interconnect/qcom,qcm2290.yaml        |  54 +---
 .../bindings/interconnect/qcom,qcs404.yaml         |  52 ++++
 .../bindings/interconnect/qcom,rpm-common.yaml     |  31 +++
 .../devicetree/bindings/interconnect/qcom,rpm.yaml | 281 ---------------------
 .../bindings/interconnect/qcom,sdm660.yaml         | 131 ++++++++++
 8 files changed, 509 insertions(+), 331 deletions(-)
---
base-commit: ae867bc97b713121b2a7f5fcac68378a0774739b
change-id: 20230721-topic-icc_bindings-72917016f595

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

