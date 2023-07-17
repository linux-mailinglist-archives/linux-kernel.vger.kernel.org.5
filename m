Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE8175607E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjGQKdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGQKd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:33:28 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479E21996
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:33:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b89b75dc1cso34248045ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689589972; x=1692181972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YCtIw1yZ3S2uUrUX8jf3/pYkWYgNAeFdvtX0Nwm6tRo=;
        b=OVWFBoF7A4dbxIPSQS7A1fxbtHnOZJRoHJIPdv1OcQ7EGWBfjaATm7M6LnJRf9qrZo
         9m03NDmVfE32AcCBPT2CSgNAl4pi8/DjaM0PbQJ55V6/mZF3oolqlmu7Cg7PMI2dZhUQ
         QuJfj9uh+bGZfUSsdGi62pEipBguS/GDj0TumMdEg0bAzSa0LK5gw5Wxx0f/hRfikqq+
         rTvJMGxElz7BAq24EjEO0dGaE4UA82gY55w+q1hI5iWoGnQvvoALAXlNryaVUN8IY2Cy
         Pqe/ARcsPThUmRdY2l+XqKIdBzUmeFyeit5nfhMDQSzJt1TpApKLpaGnXJQikqQR7YWT
         Gqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689589972; x=1692181972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCtIw1yZ3S2uUrUX8jf3/pYkWYgNAeFdvtX0Nwm6tRo=;
        b=JAfSG0zg3fm4P6I2X/lXc+KKG0jt7/ayHGbRFfyOOn6y70xvrX3d1cWpHQCNQQPjSx
         Uy2UY7D5spa805ZIz+cq+H88q9p0zaeUUbflVeOdwmLKh8LiZgEcm/88s8TLv6UN2FTk
         MzHV/KF+6LDXKsKPykT0BuQHltidU64imkMx1Y/piHtiKSMcu/QBYd1FWWatvmX4jIxF
         klp71cgJLRvFvrA5X5RyoYfke8IQGdWeq04rMPEQmDpEyeGLo8GWeBtme8zQsrt4ONOJ
         FSFG9hSNtdoRe1lK9zOcbejz9lY29uM6jZhJCVLHYbGrRDQ3wt++UezGN5tT5+VOj/sF
         Rmdg==
X-Gm-Message-State: ABy/qLalv3YaIHnAqCtN+Mk5JnkTiMIVynorNE2n0JPKhh90btjlnami
        1FeqMYxqu0nc4rdcPcPAKwXo0Q==
X-Google-Smtp-Source: APBJJlHCIWVJTmsD5TJGSYmWrvdcLnycU/tHpgHLD9MTYD3N8SqyjfjRT9Uly8B6k60jq2IJlgVzpA==
X-Received: by 2002:a17:902:dac2:b0:1b6:a37a:65b7 with SMTP id q2-20020a170902dac200b001b6a37a65b7mr12828808plx.23.1689589972362;
        Mon, 17 Jul 2023 03:32:52 -0700 (PDT)
Received: from localhost.localdomain ([223.233.68.54])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001b9de67285dsm12633616plb.156.2023.07.17.03.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 03:32:52 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org
Subject: [PATCH v8 0/4] Add Qualcomm SM6115 / SM4250 EUD dt-bindings & driver support
Date:   Mon, 17 Jul 2023 16:02:32 +0530
Message-Id: <20230717103236.1246771-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v6/v7:
-------------------
- v6 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230517211756.2483552-1-bhupesh.sharma@linaro.org/
- Konrad and Krzysztof had different suggestions on how to tackle
  different SoCs inside the eud driver which require access to secure mode
  manager register space. While Konrad's suggestion was to use a dt property,
  other comments suggested using optional platform data for determining
  the same. Modified [PATCH 2/4] accordingly to use the optional
  platform data for now.
- Added Krzysztof's RB for [PATCH 1/4] and also addressed his review comments
  received on v5.
- Dropped eud cleanup patches (which were sent a v7) as they have been accepted in linux-next.
- Rebased on latest linux-next/master.

Changes since v5:
----------------
- v5 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230516213308.2432018-1-bhupesh.sharma@linaro.org/
- Addressed Mani's comment and added Fixes tag for [PATCH 1/6].
  Also collected his Ack for this patch.
- Fixed [PATCH 4/6] as per Greg's comments and added a separate patch
  for identation issues -> [PATCH 3/6].

Changes since v4:
----------------
- v4 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230505064039.1630025-1-bhupesh.sharma@linaro.org/
- Addressed Konrad's review comments regarding EUD driver code.
- Also collected his R-B for [PATCH 4/5 and 5/5].
- Fixed the dt-bindings as per Krzysztof's comments.

Changes since v3:
----------------
- v3 can be viewed here: https://www.spinics.net/lists/linux-arm-msm/msg137025.html 
- Addressed Konrad's review comments regarding mainly the driver code.
  Also fixed the .dtsi as per his comments.
- Also collected his R-B for [PATCH 1/5].

Changes since v2:
----------------
- v2 can be viewed here: https://www.spinics.net/lists/linux-arm-msm/msg137025.html 
- Addressed Bjorn and Krzysztof's comments.
- Added [PATCH 1/5] which fixes the 'qcom_eud' sysfs path. 
- Added [PATCH 5/5] to enable EUD for Qualcomm QRB4210-RB2 boards.

Changes since v1:
----------------
- v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20221231130743.3285664-1-bhupesh.sharma@linaro.org
- Added Krzysztof in Cc list.
- Fixed the following issue reported by kernel test bot:
  >> ERROR: modpost: "qcom_scm_io_writel" [drivers/usb/misc/qcom_eud.ko] undefined!

This series adds the dt-binding and driver support for SM6115 / SM4250
EUD (Embedded USB Debugger) block available on Qualcomm SoCs.

It also enables the same for QRB4210-RB2 boards by default (the user
still needs to enable the same via sysfs).

The EUD is a mini-USB hub implemented on chip to support the USB-based debug
and trace capabilities.

EUD driver listens to events like USB attach or detach and then
informs the USB about these events via ROLE-SWITCH.

Bhupesh Sharma (4):
  dt-bindings: soc: qcom: eud: Add SM6115 / SM4250 support
  usb: misc: eud: Add driver support for SM6115 / SM4250
  arm64: dts: qcom: sm6115: Add EUD dt node and dwc3 connector
  arm64: dts: qcom: qrb4210-rb2: Enable EUD debug peripheral

 .../bindings/soc/qcom/qcom,eud.yaml           | 42 ++++++++++++-
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts      | 27 +++++++-
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 50 +++++++++++++++
 drivers/usb/misc/Kconfig                      |  2 +-
 drivers/usb/misc/qcom_eud.c                   | 62 +++++++++++++++++--
 5 files changed, 173 insertions(+), 10 deletions(-)

-- 
2.38.1

