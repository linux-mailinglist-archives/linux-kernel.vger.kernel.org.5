Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8701B7573B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGRGLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGRGLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:11:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7804DEA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:11:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666eb03457cso3323325b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689660666; x=1692252666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPAaQscYyYfWa0/+4P1+lL3rpjQtoe/1gDGIsUASAgQ=;
        b=KW1ie5FGzFjDrqMygdPl4Lj1piL5u2RpqrK7sQ8XQ01mFfxWHmNnYfSk9bBjZH491Y
         ikeoK63NNt6MxydcJOrQzONDq57gOXSfPOYHR2EwV4VrIeDm0ip75L8ZeGKh6MnUIbSw
         V7a6G0lCqDQykbFBVtz8k0TXxiA0+5pGpY24thKkXbLbH841r2UnBfiZc+wbCu5jC0Q6
         8d6/l4W79/hFeVv6WnXMSGEokFsVlgBdvetMLfnl8I90tGW1vLsFnzp7LMJch8JMLF2S
         aRvizq3H97TKTMCZEuZKx9FHblXblqrbzLtzFHfrnpmdCuZOhsHLK9av3P6Gc90UOkFO
         BanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689660666; x=1692252666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPAaQscYyYfWa0/+4P1+lL3rpjQtoe/1gDGIsUASAgQ=;
        b=JqBBg/vqeaYuMcSQgivIDTOVf51ml+x6pbn3pCCT4xbQBE28L6kd71qs+e8jhD4ylM
         tywZJcYKVZszY2i2bwi4YYdAnT2V0Ja2uSxp6bekZpc+bNqYnu3G7HnnCx776ShUbF4x
         W0qj5NiFzlWw4DMsOaZVP8lF1PgmStVWitFSGD1tCaprvJc784kkcz/t+mZhoaZSM49R
         E0ocL2pVbFCtENBKdNoYt+fXYyuLuv1g4QGZ7iLoF6rj4Az3AVv9rUTa6+NKQkkzRS7q
         MBBK/0ywZ5Iraxl0TljBOPI7tI98Cb4yYMqHcq1wzfFX/qb1+W4LX86JYGuK2GKftqec
         aGfw==
X-Gm-Message-State: ABy/qLaebTYC0PY4uAHgbPWgyDMnLNgM9qLuNIINhysI/eGJd9C9dT3S
        2U+/qLmEuHLKOeLiGv/aOalNXA==
X-Google-Smtp-Source: APBJJlE0Vx3+AL/QmINR2rZ0+C9ed8ADDT1oKhzLMD93Mi58PrLI956au/YOin1349SeJj7WK4s5PQ==
X-Received: by 2002:a05:6a00:1ac8:b0:67e:e019:3a28 with SMTP id f8-20020a056a001ac800b0067ee0193a28mr11334070pfv.16.1689660665744;
        Mon, 17 Jul 2023 23:11:05 -0700 (PDT)
Received: from localhost.localdomain ([223.233.68.54])
        by smtp.gmail.com with ESMTPSA id h21-20020a62b415000000b0067db7c32419sm778106pfn.15.2023.07.17.23.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 23:11:05 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org,
        stephan@gerhold.net
Subject: [PATCH v9 0/7] Add Qualcomm SM6115 / SM4250 EUD dt-bindings & driver support
Date:   Tue, 18 Jul 2023 11:40:45 +0530
Message-Id: <20230718061052.1332993-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v8:
-------------------
- v8 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230717103236.1246771-1-bhupesh.sharma@linaro.org/
- Konrad and Stephan pointed that I should define 'tcsr syscon' node for sm6115.dtsi,
  and use phandle for the same inside the EUD node, which would eventually be used
  inside the eud driver. Added [PATCH 1/7] and [PATCH 5/7] for the same
  in this series.
- Rebased on latest linux-next/master.

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

Bhupesh Sharma (7):
  dt-bindings: mfd: qcom,tcsr: Add the compatible for SM6115
  dt-bindings: soc: qcom: eud: Document vendor-specific 'secure mode'
    property
  dt-bindings: soc: qcom: eud: Add SM6115 / SM4250 support
  usb: misc: eud: Add driver support for SM6115 / SM4250
  arm64: dts: qcom: sm6115: Add tcsr syscon node
  arm64: dts: qcom: sm6115: Add EUD dt node and dwc3 connector
  arm64: dts: qcom: qrb4210-rb2: Enable EUD debug peripheral

 .../devicetree/bindings/mfd/qcom,tcsr.yaml    |  1 +
 .../bindings/soc/qcom/qcom,eud.yaml           |  9 +++
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts      | 27 ++++++-
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 56 ++++++++++++++
 drivers/usb/misc/Kconfig                      |  2 +-
 drivers/usb/misc/qcom_eud.c                   | 76 +++++++++++++++++--
 6 files changed, 164 insertions(+), 7 deletions(-)

-- 
2.38.1

