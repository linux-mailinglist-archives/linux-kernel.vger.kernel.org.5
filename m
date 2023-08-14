Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD03A77B7BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjHNLpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbjHNLp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:45:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D16210DE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:45:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so8754466a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692013522; x=1692618322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S6AKnTEHPXpg5NR0UUsJCKvwm2JoJ+o0ceNdgqZocao=;
        b=cdptNf605rEgZG42+BM0M8Yy0A2X/iijwBjdk9Qs26eIT60m98kAiWYzGuVtm4tQaf
         IW5I15aBKA2zFJrKEec50CeB7YAV/My6EL2ew1D77wlOL+Wa2pCh6UOs8xaay/zCw9VZ
         c0SEN3Zbdgsps/C+sI8BxAvL/yPigliip1yaY3RhAAlT8CyHZk16IGInDoeKkRLhuPhk
         X7JKVTcp0bbI80K8G6ikzAgeQ6MgT/CZtKKPX8eRZKsMhHSzwq3kTHiUupOBkp8ogPSM
         Z+MJaDB13FjxscO+i5dz79sNX0KbzTXYfBv+0QR/aOXEFkN7s17TJ1Sa3KptoAZY+YcN
         dJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692013522; x=1692618322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6AKnTEHPXpg5NR0UUsJCKvwm2JoJ+o0ceNdgqZocao=;
        b=mAOWpDPIn9MXKRmPPcWhfk+EHJ2/FXJcHv5FbRsHiNAufzKpZCRm/stuHLt14lcJ8j
         IFv6Sb5q1azgWeCJro5/yAxm1x9gpVGLkiRf+b4qC8Ga/w/2MXJbdyvqvhD4en//ZPjJ
         NwRtog4meKoahXOWmkFl3jn1CWnGVurQ6eaWLL5usCuBpGj0g95mCpBc8G3xpOTBWHse
         s3Rri+6jc0h+6TA+87+zQ05i0holqkdYutWj/rc3inJN1L0sCiRMHICZYDqfPcrAql7+
         gp3HZNrn900Yr3tFCT6LtjfzsODLFBDnEIxhTP8WWlKkN7ZAONcFA/9crJIMOfCCPS9h
         CViQ==
X-Gm-Message-State: AOJu0YyxQJafCmmWXMdvBRGRc5U6QfyAF7Nw8XgXFwU9uOdZT8FSdeRa
        ceGdbRJVANcC1yY0z8g3+IPBQQ==
X-Google-Smtp-Source: AGHT+IE4jTVxHl2kuyWDM45aDkacQap9Jvr2WZXVucNZjIMFHYI5kHZqt4TdguiICjyye7cTVN76OQ==
X-Received: by 2002:a05:6402:3588:b0:522:b9ae:db3c with SMTP id y8-20020a056402358800b00522b9aedb3cmr13930161edc.6.1692013521655;
        Mon, 14 Aug 2023 04:45:21 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id c5-20020aa7df05000000b005222b471dc4sm5402266edy.95.2023.08.14.04.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 04:45:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] pinctrl: qcom: new drivers for v6.6
Date:   Mon, 14 Aug 2023 13:45:18 +0200
Message-Id: <20230814114518.26243-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

That's what I got in my queue for v6.6.

Best regards,
Krzysztof


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/qcom-pinctrl-6.6

for you to fetch changes up to 2422f74eb9dc99097c9537c30ef50f88a0b54acb:

  dt-bindings: pinctrl: qcom,pmic-gpio: document PMC8180 and PMC8180C (2023-07-26 11:11:47 +0200)

----------------------------------------------------------------
Qualcomm pinctrl changes for v6.6

1. Add support for the SM6115 and SM8350 LPASS (Low Power Audio
   SubSystem) TLMM pin controllers.

2. Add bindings for the Qualcomm PMC8180 and PMC8180C PMICs GPIO pin
   controllers.

----------------------------------------------------------------
Konrad Dybcio (2):
      dt-bindings: pinctrl: qcom,sm6115-lpass-lpi: add SM6115 LPASS TLMM
      pinctrl: qcom: Introduce SM6115 LPI pinctrl driver

Krzysztof Kozlowski (3):
      dt-bindings: pinctrl: qcom,sm8350-lpass-lpi: add SM8350 LPASS TLMM
      pinctrl: qcom: sm8350-lpass-lpi: add SM8350 LPASS TLMM
      dt-bindings: pinctrl: qcom,pmic-gpio: document PMC8180 and PMC8180C

 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |   2 +
 .../pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml     | 135 ++++++++++++++++
 .../pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml     | 143 +++++++++++++++++
 drivers/pinctrl/qcom/Kconfig                       |  19 +++
 drivers/pinctrl/qcom/Makefile                      |   2 +
 drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c    | 175 +++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c    | 167 ++++++++++++++++++++
 7 files changed, 643 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
