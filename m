Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A907DF14D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjKBLmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKBLmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:42:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208EF181
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:42:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9d224dca585so125817866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698925319; x=1699530119; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ku2yghToBtZf7AmsCT5H5GSjoVJ9gQzHcY+n0fbFqrU=;
        b=D0jK1QO+bGmqY6/kgYiC4wKGvWSuT21bd+alEZ2TBG6qtJRhNI1+DDoS0xGp/L1pj3
         QnFExUNkOWD1U26N1FRzy2M5Z2Kbo4NX7mBhLqqrXDOTcJN/7F0l3gZ8A5eW84Nf4DK7
         rnk+PtHLLFTrl78eKn77b5Gu1BdBtoQXyXOTiueCWLXd3sKSiPKx8ExT8MDl1V5h1bvU
         65pBBVB6YyisXp+EbkFG7K6vedrWJXuroKl35ZpjlkgggryhpKLtQcNnUnr2PhX+Fz26
         BVPfBK92IO1sMXlSUbtIBhx73a6AZHMzzOtwZLASOHjeGVQyOJncirWd/goiIGYUtvjQ
         uz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698925319; x=1699530119;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ku2yghToBtZf7AmsCT5H5GSjoVJ9gQzHcY+n0fbFqrU=;
        b=hpYY8AdgKJBYaei6Xer+WVu79Py/YWRuQ/F9FslmB+rkJl4wQ7X7W+0a37fLcpE9a9
         uAYb9D/Irdo/e9KkD0NUYFXkqTG7iC2cP29wOvf6VPSjkk+dDCX1Rxw6sABiOmsTjf5W
         0NDQ8gRE4D3iMXGgV2thIRTprKmS0Mg98lxKg/FMAR6O0ceIxWMi1UEzMN47p1FC+p1c
         JlgOZutfGGNShyov4w4cLSVtkB61fwccbmL8kJCTI3bJW7bX5r2NKyhiCglPmVhzRw0/
         4jmCT5hNLIIuouQTt4bqiD38GsGcQWBhPkowuAWRg/N695bsDT2EcOLp+oOQ1LQghYXa
         qHnQ==
X-Gm-Message-State: AOJu0YwCVWIJTfT7M9FziULzA9LC4P+VUxwekD2qKyCFq1N+39Whps3D
        HKmyhfoS25YaBfoVSXUG41WJEw==
X-Google-Smtp-Source: AGHT+IEycpwS4EGuyKSLia2H6bem4NDEZOuXXECda4Wz+aqXbSFiWLitAGF/ZvZspzKnly99dCr+4A==
X-Received: by 2002:a17:906:7948:b0:9da:a00f:7337 with SMTP id l8-20020a170906794800b009daa00f7337mr3826286ejo.55.1698925319467;
        Thu, 02 Nov 2023 04:41:59 -0700 (PDT)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id j41-20020a05600c1c2900b004060f0a0fdbsm2717720wms.41.2023.11.02.04.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 04:41:59 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/6] media: qcom: camss: Add sc8280xp support
Date:   Thu, 02 Nov 2023 11:41:53 +0000
Message-Id: <20231102-b4-camss-sc8280xp-v1-0-9996f4bcb8f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAGLQ2UC/x3MMQqAMAxA0atIZgNNdaheRRxsTTWDtTQggnh3i
 +Mb/n9AuQgrjM0DhS9ROVMFtQ2EfUkbo6zVYI3tiAyh7zEshypqcNaZO6Nh8gOxt+Qj1C4XjnL
 /z2l+3w8JRkBTYwAAAA==
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, vincent.knecht@mailoo.org,
        matti.lehtimaki@gmail.com, grosikop@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sc8280xp is the SoC found in the Lenovo X13s. This series adds support to
bring up the CSIPHY, CSID, VFE/RDI interfaces.

A number of precursor patches make this series smaller overall than
previous series.

sc8280xp provides

- 4 x VFE, 4 RDI per VFE
- 4 x VFE Lite, 4 RDI per VFE
- 4 x CSID
- 4 x CSID Lite
- 4 x CSI PHY

I've taken the yaml from a dtsi series and included it here since 1) I sent
the yaml to the wrong person and 2) it already has RB from Krzysztof.

Requires CAMCC for sc8280xp which applies to qcom/clk-for-6.7:
https://lore.kernel.org/linux-arm-msm/20231026105345.3376-1-bryan.odonoghue@linaro.org/
b4 shazam 20231026105345.3376-1-bryan.odonoghue@linaro.org

Requires the named power-domain patches which apply to media-tree/* :
https://lore.kernel.org/linux-arm-msm/20231101-b4-camss-named-power-domains-v3-5-bbdf5f22462a@linaro.org/
b4 shazam 20231101-b4-camss-named-power-domains-v3-5-bbdf5f22462a@linaro.org

To use the camera on x13s with say Google Hangouts or Microsoft Teams you
will need to

1. Run Firefox
2. Update about:config to enable pipewire
3. Use this WIP version of libcamera
   https://gitlab.freedesktop.org/camera/libcamera-softisp

A working bootable tree can be found here:
Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/lenovo-x13s-linux-6.5.y

b4 base:
https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/b4/camss-sc8280xp

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Bryan O'Donoghue (6):
      media: dt-bindings: media: camss: Add qcom,sc8280xp-camss binding
      media: qcom: camss: Add CAMSS_SC8280XP enum
      media: qcom: camss: csiphy-3ph: Add Gen2 v1.1 two-phase MIPI CSI-2 DPHY init
      media: qcom: camss: Add sc8280xp resource details
      media: qcom: camss: Add sc8280xp support
      media: qcom: camss: vfe-17x: Rename camss-vfe-170 to camss-vfe-17x

 .../bindings/media/qcom,sc8280xp-camss.yaml        | 581 +++++++++++++++++++++
 drivers/media/platform/qcom/camss/Makefile         |   2 +-
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     | 108 +++-
 drivers/media/platform/qcom/camss/camss-csiphy.c   |   1 +
 .../camss/{camss-vfe-170.c => camss-vfe-17x.c}     |   0
 drivers/media/platform/qcom/camss/camss-vfe.c      |  25 +-
 drivers/media/platform/qcom/camss/camss-video.c    |   1 +
 drivers/media/platform/qcom/camss/camss.c          | 376 +++++++++++++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 9 files changed, 1086 insertions(+), 9 deletions(-)
---
base-commit: f5602ca81598f12d3fdb327beb29688871955596
change-id: 20231101-b4-camss-sc8280xp-0e1b91eb21bf

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>

