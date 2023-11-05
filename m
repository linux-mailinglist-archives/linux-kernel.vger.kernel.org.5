Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3391D7E158C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 18:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjKERpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 12:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKERpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 12:45:07 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F27ECF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 09:45:04 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso52145071fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 09:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699206303; x=1699811103; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs2X2TC3aDgjhTmsm2pl3o3Tuf0i4SGLrwDNMlOpie8=;
        b=AD5ufH6Y5YZWI/owFG2qHUAkLLckwuaifyHefPfBEIMfTi+YUw3WMXYCqtlls5nOk5
         TDJ4JkeSSI+2X/doBmPMQjWyVgvPHL6YEw1GwjM5CF9oI9Bl/5jW4ZvGvTczfiT5/jt4
         BIhy0mhN81ERBVurdRamDp8ofT7tP+9d+Z9YSZoDPTnyj3yrP1EqxZ7thXVP36VgL06o
         TmWgpu4mlNie+Y/snbcMYN5RaPuz7lTMppmn16UC9rdjjJIO7hPMDppDV2WupPXOtP3Z
         Y6pYQi21sgXJUYFRZznNPSaZ1XH2VqJjWHTLc5ZJlroKpFQ5g/mG2R1rmrC5e/cjT3r8
         BpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699206303; x=1699811103;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vs2X2TC3aDgjhTmsm2pl3o3Tuf0i4SGLrwDNMlOpie8=;
        b=UXmDAOcM7AIl+krr3NtcxJ98STSld0o/9tM3Pc6kod05/GWS74To2k1fsSsnigRgFS
         ZRrHUNBlWEWb5pXA/O88cQ3qGCl+KfnVh+mIwZqyvnV1GV1M1dcoRGFEIjQKIdwLDioH
         d23yCFAOINkJBu/2iNiwoSOv0JJKMVCOUIehmQ2XHNvYi1596zrgD9XYT7BvB1bC4s2Y
         2xWsHicZAwcTSEYW/k7axm/EEH0soXHIShWrJ66D/AbxuwiGbd6qlAzENNHbnJcdYKIc
         t5XN2uXmMlB1clV0Wemb5sYt7H5A8WK8EctVwCURssndKfm6t5QaKMGDgnjKY6ffq/DE
         TBWQ==
X-Gm-Message-State: AOJu0YzDZ2lzNj27St1bArUdDQeuYCdXChz9kup3rpRmuPr7rZB9ii8u
        waTu4UQ4JuUHwHh26vgcMI69NQ==
X-Google-Smtp-Source: AGHT+IGtdNn5u7/gsPQPsmxiIo3xFFeBvAYua2DHDn5mAefSlgnlXsioKcpVAsoPWOujMRB2NtMRaw==
X-Received: by 2002:a2e:8090:0:b0:2c5:183d:42bf with SMTP id i16-20020a2e8090000000b002c5183d42bfmr19958196ljg.45.1699206302309;
        Sun, 05 Nov 2023 09:45:02 -0800 (PST)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b004064ac107cfsm9553346wmq.39.2023.11.05.09.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 09:45:01 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v3 0/6] media: qcom: camss: Add sc8280xp support
Date:   Sun, 05 Nov 2023 17:44:59 +0000
Message-Id: <20231105-b4-camss-sc8280xp-v3-0-4b3c372ff0f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJvUR2UC/23N0QrCIBTG8VcZXmd4jlZzV71HdKFON6Hm0JDF2
 LvnBkHBLv8fnN+ZSbLR20SaaibRZp98GErwQ0VMr4bOUt+WJsiQAzCgWlCjninRZGqs2TRSZkF
 LsBpBO1Luxmidnzbzdi/d+/QK8b29yLCuXw13tAyUUSnl2QltdO3E9eEHFcMxxI6sXMZfgu8RW
 Ah9UU60eOIK2R+xLMsH19WlTvYAAAA=
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
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-26615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V3:
- Strip pointer to dependencies from yaml patch
  I was hoping the robot would understand the links but it doesn't -
  Krzysztof

Link to v2: https://lore.kernel.org/r/20231103-b4-camss-sc8280xp-v2-0-b7af4d253a20@linaro.org

b4 base:
https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/b4/camss-sc8280xp-v3

V2:
- Rebase to capture is_lite flag from named power-domain series
- Amends commit log of final patch to give more detail on rename - Konrad
- Opted not to change switch() statements with returns. - bod/Konrad

Requires CAMCC for sc8280xp which applies to qcom/clk-for-6.7:
https://lore.kernel.org/linux-arm-msm/20231026105345.3376-1-bryan.odonoghue@linaro.org/
b4 shazam 20231026105345.3376-1-bryan.odonoghue@linaro.org

Requires the named power-domain patches which apply to media-tree/*:
https://lore.kernel.org/linux-arm-msm/20231103-b4-camss-named-power-domains-v4-0-33a905359dbc@linaro.org/
b4 shazam e700133b-58f7-4a4d-8e5c-0d04441b789b@linaro.org

Link to v1:
https://lore.kernel.org/r/20231102-b4-camss-sc8280xp-v1-0-9996f4bcb8f4@linaro.org

b4 base:
https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/b4/camss-sc8280xp-v2

V1:
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
 drivers/media/platform/qcom/camss/camss.c          | 383 ++++++++++++++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 9 files changed, 1093 insertions(+), 9 deletions(-)
---
base-commit: 89e965e1a58f58cd359472b14c0cc25587bcf264
change-id: 20231101-b4-camss-sc8280xp-0e1b91eb21bf

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>

