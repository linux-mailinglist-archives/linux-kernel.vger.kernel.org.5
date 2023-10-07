Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B526B7BC817
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 16:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343966AbjJGOBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 10:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbjJGOBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 10:01:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702DEB6;
        Sat,  7 Oct 2023 07:01:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-406650da82bso27725625e9.3;
        Sat, 07 Oct 2023 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687258; x=1697292058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JA8pNS1sjO+SvOcd9f6aWXsYXEvGmALJgnPRfN+5ZZI=;
        b=UDnIXIB++NvBHV9SoQCxqfjMq56DJVSBM5z50WqruSFt0D/CpePQzTycSdXcn56RY9
         yb0Pda6b8xa8ocvBAyV2onRN+4BkIfHmQs8KC56PExjaSekwU5dqcShBBlBLhfPfsDbZ
         KD2/tNFdxSlyYrtiC4tZ9zknfNalf8Q3Ju3DyAQNCmZOtvtGTq/rpxvS+vlAU9Wu1ulz
         mu/dTgJ/KMV3ax1Yoce5WqItvlX1Cz1wIwPnAyDoOy7OnPNly/6J27fac88phZlj40hy
         1BsAfFggVIx1adAsOnDRgOsn+atTXIVoaAlOsOL1N7aTnw3PV+SylLuvOEhYz0GUwdR/
         YyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687258; x=1697292058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JA8pNS1sjO+SvOcd9f6aWXsYXEvGmALJgnPRfN+5ZZI=;
        b=U4HMmMIdFacu88IWGUoxvISys3ipvr0/rIhG++8yoSnhLMFtuD8g2MVSiwtmFhM9Cf
         yfI7Z/qvx7eqnqbdbaW22O0NpA7CS4nbDvJi+85FjAQw6i81AHQ7nNvNvGGGhlnvsQf9
         e2R+YHTz1ORL523Ry+AAsKqJyiqFRdPzA3GvT7DwGqnbKmlDTKxLxc/aIAAvfHxS8xLU
         +9wWE7AQZsaw6rDg4lNRww+siNIVdz7ZT6rgghcputP38D4bH8tODqTYkrYzbRTNA8q+
         TnQBxgRAgc08nnuj8IzeAkhijomH9tkEak353pVg/ex/yTKxI/J53Hh7DYCFxZhCAxcq
         sSfQ==
X-Gm-Message-State: AOJu0Yx/8z8FXZR5jcMYAdTuCe2r1ECjBb8RzJlVbA/ryrn0ycWod5Pu
        o6rYt/pB5AsjUO2Yb1ie4UM=
X-Google-Smtp-Source: AGHT+IGw5xKTNOEryOEGkm2GmWpAQMQ7XWxlFiwFmem0T2DEt25XxN9BwEq7jE9+BmH9cReNhqOUuQ==
X-Received: by 2002:a1c:4c09:0:b0:401:b204:3b97 with SMTP id z9-20020a1c4c09000000b00401b2043b97mr10662857wmf.4.1696687258088;
        Sat, 07 Oct 2023 07:00:58 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([77.22.112.104])
        by smtp.googlemail.com with ESMTPSA id q8-20020a05600000c800b0032415213a6fsm4332043wrx.87.2023.10.07.07.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:00:57 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Joe Mason <buddyjojo06@outlook.com>
Cc:     cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        hexdump0815@googlemail.com, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, David Wronek <davidwronek@gmail.com>
Subject: [PATCH 0/7] Add UFS support for SC7180/SM7125
Date:   Sat,  7 Oct 2023 15:58:24 +0200
Message-ID: <20231007140053.1731245-1-davidwronek@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces UFS storage support for SC7180 and SM7125, as
well as support for the Xiaomi Redmi Note 9S.

David Wronek (6):
  dt-bindings: ufs: qcom: Add SC7180 compatible string
  dt-bindings: phy: Add QMP UFS PHY compatible for SC7180
  dt-bindings: arm: qcom: Add Xiaomi Redmi Note 9S
  phy: qcom: qmp-ufs: Add SC7180 support
  arm64: dts: qcom: sc7180: Add UFS nodes
  arm64: dts: qcom: sm7125-xiaomi-common: Add UFS nodes

Joe Mason (1):
  arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S

 .../devicetree/bindings/arm/qcom.yaml         |  1 +
 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        |  1 +
 .../devicetree/bindings/ufs/qcom,ufs.yaml     |  2 +
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 70 +++++++++++++++++++
 .../boot/dts/qcom/sm7125-xiaomi-common.dtsi   | 16 +++++
 .../boot/dts/qcom/sm7125-xiaomi-curtana.dts   | 16 +++++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       |  3 +
 8 files changed, 110 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts

-- 
2.42.0

