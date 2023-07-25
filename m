Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1D760DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjGYJBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjGYJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:01:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841CF1BCF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:00:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so51760255e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690275634; x=1690880434;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j7Qh4SLEY1eLgJVS8m4AG3+oVzUXdrRAOvEVED2PMdU=;
        b=qAmEn5KU8WaxCdLJKYsT6B7H3MTGmTKWRj4CjmcCMDAC7t8j4iL/ALonYKoRqOdqFy
         vuh2ueNCHD8Z9tGVV45pdlWu0yg8jAg/5m/btZQHBUCf7WfUqTVORU+N1969jlOfwlHu
         7h7lv2qQQtoi5xUKT4c6nFJN/VUC9zwfFCtsZpldsHpepW7T8VJ26WboW0J4nbRLV2Aa
         yZsCLHwubAY+ll28aPUUXRPyRi5S6E6/EUuvPjAAUHpl46ipxDwd1sHqL+IDkQw0ag8y
         YCyOFT/EazzY//gEefkEGsSLAM1X39ozh0R+G2g9o+Fg9hRWeS+3pCZXd9Kd671Myhe/
         cLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690275634; x=1690880434;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7Qh4SLEY1eLgJVS8m4AG3+oVzUXdrRAOvEVED2PMdU=;
        b=CDOje+zJJU8GxgCVSRtyBWNdlyAbAUYH8XAcLbgbv5X+XoXxBwDUJ52F8hqRQYvAFT
         tR4aITIPcIL+qjKplS3xQ1bjdzk7jvSXB/AVvSiMqnV/Y/vyGNvSuYpDudx3YOtub2Yk
         UcnZDw1ZqF2sDqRzVY0CjSECIkqy+f0oPkAvVfMSOc0Jm8G5XOi2vosVbtHdlueTQtx0
         6Qp5sExspV+d2a53qLJ68+rZjKD7+iS00dvDSZ6/F/bMaXet+tjunJJk33jJvqWyCnjl
         eldk5puj8jXBGKkbYAFfzWyIvLPrLQtBnI5BFtbkCwT7whbuR7vt9dmboKy7kGDGTvEd
         YI1w==
X-Gm-Message-State: ABy/qLaMKbCB5CL2hr++qCMDUGRaqeMXKDFUOces6GnzEX19s+evRDQX
        9PlW64w/+RLh+Xib1BGiAsU8FA==
X-Google-Smtp-Source: APBJJlGI2bvBb8cUMLfFKTvfQy/8j2HbRp6KngSO9LZm27HZyh5fpzLeuHCrPJJ07fcGW6ABaS5oRQ==
X-Received: by 2002:a7b:c453:0:b0:3fa:99d6:4798 with SMTP id l19-20020a7bc453000000b003fa99d64798mr10044249wmi.37.1690275633845;
        Tue, 25 Jul 2023 02:00:33 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id f5-20020a1c6a05000000b003fc015ae1e1sm12648420wmc.3.2023.07.25.02.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 02:00:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v4 0/3] SM6375 remoteprocs
Date:   Tue, 25 Jul 2023 11:00:27 +0200
Message-Id: <20230725-topic-6375_rproc-v4-0-d55e8a6d0f5f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACuPv2QC/0WNQQ6CMBBFr2K6dkhpCw2uvIcxZigtNGKHTNFoC
 He3cePy/eS9v4nsOfosTodNsH/FHCkVMMeDcBOm0UMcCgsllZZWNbDSEh202jY3XpgcmCCtwU4
 FbIIoWo/ZQ8+Y3FTE9JznMi7sQ3z/fi7XwoHpAevEHv/1Wna1blpjK607pQzUcKfEOFTDp3eRz
 nNMyFQRj2LfvwyNBA+6AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690275632; l=1779;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fw4ZCgvUkpz8oGonNg5rYSidS90Y7mSsueusBESngNc=;
 b=2nrR5I4qmkcWiMkQisBkgUu7tnSNSdqmhYswI/yyOAVzvqnc/9hyS2ImF5EtZPoKup89aXn1j
 SAmn8O8VuJgB3zZgHxIs0HDVA/WHnwOwYpgLaYh7RZYW8bD7K6s7MH+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending as the previous revision was mostly ignored on the rproc side.

Changes since v3:
- Pick up krzk's rb on bindings
- Drop patch 4 (applied)
Link to v3: https://lore.kernel.org/linux-arm-msm/20230109135647.339224-1-konrad.dybcio@linaro.org/

This revision merges two [1] [2] previously separate series,
adding SM6375's ADSP, CDSP, MPSS and related bindings.

[1] https://lore.kernel.org/linux-arm-msm/20230107120623.1903056-1-konrad.dybcio@linaro.org/T/#m89d629bd788593dfd27e4dbf0cf0bf94ffd0a7ce
[2] https://lore.kernel.org/linux-arm-msm/622afd8b-a469-4c95-d2b8-030e47b0cac2@linaro.org/T/#m17aee8f3a51cfbd3f92fe2b4dd48b3722a6a0a7e

Konrad Dybcio (4):
  dt-bindings: remoteproc: qcom,sm6375-pas: Document remoteprocs
  remoteproc: qcom: pas: Add SM6375 ADSP & CDSP
  remoteproc: qcom: pas: Add SM6375 MPSS
  arm64: dts: qcom: sm6375: Add missing power-domain-named to CDSP

 .../bindings/remoteproc/qcom,sm6375-pas.yaml  | 137 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm6375.dtsi          |   1 +
 drivers/remoteproc/qcom_q6v5_pas.c            |  18 +++
 3 files changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml

--
2.39.0

---
Konrad Dybcio (3):
      dt-bindings: remoteproc: qcom,sm6375-pas: Document remoteprocs
      remoteproc: qcom: pas: Add SM6375 ADSP & CDSP
      remoteproc: qcom: pas: Add SM6375 MPSS

 .../bindings/remoteproc/qcom,sm6375-pas.yaml       | 137 +++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5_pas.c                 |  18 +++
 2 files changed, 155 insertions(+)
---
base-commit: 1e25dd7772483f477f79986d956028e9f47f990a
change-id: 20230725-topic-6375_rproc-4f074a92fa5f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

