Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187D6779B8C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbjHKXro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbjHKXrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:47:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1541716
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:47:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso22636245e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691797661; x=1692402461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vmPpz4LCaDoZPw2B7U3w5DHuzdPqZsglckegaLGREXw=;
        b=nrbCXe3zevFVHfSYLQN9e4arPs5g4ge+ZXcfTza7FzlO6eOPxvkGmLg2wMb8SyAhIe
         OJeLVuz0ZzI8BzdK/tvVG+mDQ0+JMnCi2Jv+DQdEYFZ8hd4fJFjsQtzX+okbgrryZX0a
         JbACNpEg5xs8zU6u6Tbv9RNf44ouYRe4fzMPGzhGHX3e5T/L4VvFdlTg4kMcd+WaF+mz
         aW04dyGkX3lBQvH/ElmgdL+oM5ruU+rD8ADjHE+CJyVeR/jC0qi4jC1blGJAmtqTIJng
         LnGt8rgQ3v4kmbzM7Okk6ja5MTo225hXHaEWAyzJEVTGvQcq83XGUS1z4+ZTiSQmHMYf
         i7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691797661; x=1692402461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmPpz4LCaDoZPw2B7U3w5DHuzdPqZsglckegaLGREXw=;
        b=jzFJuU1+SE9SvZb3V2QYXW+54AsJvQwo63xXPIaRrc0dC57aeLd6rKQSw/8L2BO7y0
         hTeA2qjc8DQXmoWTuV/2P5nvRdbPYKJWjwTUqjjVsdNqSZvASIHkraXITy9oXFBxngap
         c2Z13fVN+0IBEdRP0O5PXq8fqzQiwIuoP9+ShKORDHhReomzdH7ZmCb2pu6+yGrnsp2y
         ZrRMZQd04r/41ByeFJpLTdX67Qz6djqq6zcY+AyldcEgjmh5W9nUOL18AkTiE6+JBjrZ
         fB8/kV5/gBxDn0Q7GVtelJzBbTtG/yNokGqwSf6Z7iXSAY6DBS/99B//WUnKN598kf3b
         txmA==
X-Gm-Message-State: AOJu0Yyerau0yIFZD9zXY0UAOnwq04o8ZoCMd/zk9mQYqfZak3wggY0H
        VXq80ZWAmAT4I6hqKgQUhXqOwA==
X-Google-Smtp-Source: AGHT+IEvXO89Wf7pxRGeb83+ECbk4RBaAtG85EAFkCsiLHriYQSSF52CWl6GM4T7QWu8r8Ex2ufS6g==
X-Received: by 2002:a05:600c:3787:b0:3fe:89be:cd3 with SMTP id o7-20020a05600c378700b003fe89be0cd3mr2111753wmr.22.1691797660968;
        Fri, 11 Aug 2023 16:47:40 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c025400b003fa98908014sm9599051wmj.8.2023.08.11.16.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:47:40 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH v3 0/7] apq8016: camss: Update dts with various fixes
Date:   Sat, 12 Aug 2023 00:47:31 +0100
Message-ID: <20230811234738.2859417-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V3:
- Fixes licensing boilerplate error in d3 mezzanine - Stephan
- Moves regulators into d3 mezzanine - Stephan
- Drops redundant enable of camss in d3 mezzanine - Stephan
- Declares ports in core dtsi - Konrad
- Adds R/B for assigned-clocks - Konrad

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-08-07-db410c-rb3-camss-dts-v3

V2:
- Adds R/B - Konrad
- Adds newline as flagged - Konrad
- Squashes patch#6 into patch#5 ammends commit log
- Following up on TPG comentary:
  The CAMSS would not have populated device nodes prior to this series
  save for the case a user had a D3 Engineering board.
  Splitting out the sensor from the core board is correct w/r/t the
  hardware/dts since few db410c have the mezzanine.
  Once split we can enable the basic camss node by default and thus get the
  TPG going for both the mezzanine and non-mezzanine cases.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-08-07-db410c-rb3-camss-dts-v2

V1:
This is a series which updates the apq8016-sbc to fixup CAMSS support.

The first four patches fixup the current state of the ov5640 bindings for
the apq8016.

Following on from that we move the ov5640 sensor from the main apq8016-sbc
into a standalone mezzanine dts with an accompanying patch to enable the
sensor by default in the mezzaine. This makes sense since the D3
Engineering camera mezzanine is but one of a slew of camera mezzanines we
can attach here.

The final patch switches on CAMSS in the core apq8016-sbc allowing us to use
the test-pattern-generator TPG on apq8016-sbc with or without a camera mezzaine
attached. This to me is a good idea since it means we can test out and
verify the CAMSS on this board absent a camera mezzaine on the main apq8016
board.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-08-07-db410c-rb3-camss-dts

Bryan O'Donoghue (7):
  arm64: dts: qcom: msm8916: Define CAMSS ports in core dtsi
  arm64: dts: qcom: apq8016-sbc: Fix ov5640 regulator supply names
  arm64: dts: qcom: apq8016-sbc: Fix ov5640 data-lanes declaration
  arm64: dts: qcom: apq8016-sbc: Set ov5640 assigned-clock
  arm64: dts: qcom: apq8016-sbc: Rename ov5640 enable-gpios to
    powerdown-gpios
  arm64: dts: qcom: apq8016-sbc-d3-camera-mezzanine: Move default ov5640
    to a standalone dts
  arm64: dts: qcom: apq8016-sbc: Enable camss for non-mezzanine cases

 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../qcom/apq8016-sbc-d3-camera-mezzanine.dts  | 81 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 68 ----------------
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  8 ++
 4 files changed, 90 insertions(+), 68 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts

-- 
2.41.0

