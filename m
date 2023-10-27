Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E427F7D93D6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345614AbjJ0Jh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbjJ0Jh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:37:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D6ECE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:37:24 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so24549911fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698399442; x=1699004242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxAhGTRk8WbWkwB+dTuwh9bEQbrCU7H1RI+9l+q0K90=;
        b=CaYEmVjIgu/fK1yY7wGa2klX283fs7FTn5YX4C5x57qDRx2YjZqfNL9pznt4iwdzSm
         E6EsfY0Mhf8tG5188WbUeFXtB/VLMIdh1WoFeZrs85LD4v5gGz2aMEBoGrhiOB+g7RLP
         rdKPr9owAgCMjXufL0hJ7PawKfgW1BydwFkbbKDnWVUldw09rcCLgQvH+UreKmTlyrVw
         LcQX2NjEoTxhMpzrgl40DreWsvVIggSP8xVDN1yZapbqBNVSwfP/If+/vxm5NwKvloYr
         /CSNfM8zNFLwI44hmZQoU80TCbOELgW0f/jEunSBuGelZChZON2jQQ/mzENUU2xBthHQ
         nLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698399442; x=1699004242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxAhGTRk8WbWkwB+dTuwh9bEQbrCU7H1RI+9l+q0K90=;
        b=jMyhkZcsIZT1JsAnB0Cao6b9B3svLRi4S0Vbg915R3H8Nk+QX7bSUT9EKcuJz+uqzB
         dOiO9EFi/uKdyCprqCNiHaczDVxJFHVoa/RLhoZahiZ7c+pAF1vu8gX9DpijPFMKoiXi
         MeWcLhcuGyHeTy/6VVk2Vp+ZuuZyy3JEV1DmHiJRJWwEQz+3t6hOWnvo9A5KAYLS7dg/
         W7uzwTpFI/OJkUqCMDOoSs/99zqRTcLextTuEIIq4JMQJL5Oq1XFRazXgR9Cp68s7e64
         kqfdWt7mIFSIMPeLDGAoK/5s8aoofettG9Q4r00+fXpN1isLH2h+aZ6WYcboFgDJvZpU
         R69A==
X-Gm-Message-State: AOJu0YwSgMVAyABXILee5+x3XfK8B+Ot00RNOV4j3xqY40XPsS8ICEe3
        Z8AT194QecIOOm1rLdUjmpW14A==
X-Google-Smtp-Source: AGHT+IFQw7hIScOFSzvtLz9DA9eBVKE2Jz65xnKksveBucyHsbC6nhpEUWiEVVT/vo9qDs+HweEaXw==
X-Received: by 2002:a05:651c:42:b0:2bf:f32a:1f64 with SMTP id d2-20020a05651c004200b002bff32a1f64mr1718197ljd.18.1698399442460;
        Fri, 27 Oct 2023 02:37:22 -0700 (PDT)
Received: from krzk-bin.. ([78.10.206.168])
        by smtp.gmail.com with ESMTPSA id s26-20020a2e151a000000b002c12c2094e4sm223341ljd.74.2023.10.27.02.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 02:37:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/2] pinctrl: qcom: add sm8650 lpass-lpi
Date:   Fri, 27 Oct 2023 11:36:13 +0200
Message-Id: <20231027093615.140656-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dependency
==========
This patchset depends on v2 of:
https://lore.kernel.org/all/CACRpkdYzhEJhN9BFdbZkJ7LurtT+dFMg97SLY-q91SNCZ8bikw@mail.gmail.com/

Due to conflicts with current fixes, the v2 above was postponed for v6.8, thus
this should wait as well.  Review can happen anyway now.

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  dt-bindings: pinctrl: qcom,sm8650-lpass-lpi-pinctrl: add SM8650 LPASS
  pinctrl: qcom: sm8650-lpass-lpi: add SM8650 LPASS

 .../qcom,sm8650-lpass-lpi-pinctrl.yaml        | 148 ++++++++++
 drivers/pinctrl/qcom/Kconfig                  |  10 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 .../pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c   | 255 ++++++++++++++++++
 4 files changed, 414 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c

-- 
2.34.1

