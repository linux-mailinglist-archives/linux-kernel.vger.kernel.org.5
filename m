Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95866775E5F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjHIMEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjHIMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:04:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE4D1728
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:04:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso57433405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 05:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691582676; x=1692187476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DpLjRlIwfiCIPhXQ/Dw8a2LYQYJEGEfEBrbeVKy3sfo=;
        b=VwphgqyKEgD0KNQ2yo88rEAVFK6PIJpR1FHyQi5VcbsChtgHPx7X4+qXQodK4c4hBw
         zTn+NK72RI82gAm9QXfM8KgKi16Bv6qMRImdGg9aiwybypcZk06br3Taceyww59RF6pI
         4P1pKhSqhD9K9VWIbebdQSYCfVPNmPqBNdSbb9hGe8rUReMSEQeYx/+6itqKJZcqPmtZ
         QYHiwPz3UDdVJXb76uErpgrmX06bYGD5QkyC7AYO+ijNadK7q7S9IfVKC+o9kA9EsZ+B
         irl7FmrbcfV++JFpP9zjy7QNbezYfawmtJkRDtaOA8JIfWRx3dAt0XR9Qe5wGf+9Klvr
         EwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691582676; x=1692187476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpLjRlIwfiCIPhXQ/Dw8a2LYQYJEGEfEBrbeVKy3sfo=;
        b=ceogyrURVGOM2mz+4UbZfkgMdEGNoSe/KVcbJe17qAv2M5cN7C6+MeNmnS8AxRyIWa
         2xV1SN659rdLmNQEluqxfqUVRYC5rgGeISMNuZG9X75d6xltNnD0h2ytMKXG9mWxdKSQ
         5yzynTdW1e8RqoHme5P7s49OY0xX1ArailCWMqvuDUTzSinc+VstP3gk+XKO7xDHBfKP
         1bVuh2tXdT9qBzlxuBp/rsuSwzhY6y0vutdYOtVFdwUCECKmdw84T6fLdP4dMzbayaSC
         l14PHkenMoN4sTMBNsaMI6Y34y7GfMsEnsaMNhilAAmtU91ZwK1yKKwgw7NACDhh/ze0
         WpNQ==
X-Gm-Message-State: AOJu0Ywwi0t5xZ34P5BI7pTqYD/norbPxAvm2UOp5GA+3unRyv1Wm+7L
        6i02pEMRkAql+Dz50DjghsE7zQ==
X-Google-Smtp-Source: AGHT+IEiZ4Ynt42q1VGJptXkiqEPdpToCeX/GNcbNwxNZADxCAbwrpvgOCbEKfUmrKARtFrKvmGnkQ==
X-Received: by 2002:a05:600c:2116:b0:3fe:2102:8085 with SMTP id u22-20020a05600c211600b003fe21028085mr1999263wml.8.1691582675791;
        Wed, 09 Aug 2023 05:04:35 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b003fe1a96845bsm1808573wmi.2.2023.08.09.05.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 05:04:35 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, loic.poulain@linaro.org, rfoss@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH 0/7] apq8016: camss: Update dts with various fixes
Date:   Wed,  9 Aug 2023 13:04:25 +0100
Message-Id: <20230809120432.1036405-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  arm64: dts: qcom: apq8016-sbc: Fix ov5640 regulator supply names
  arm64: dts: qcom: apq8016-sbc: Fix ov5640 data-lanes declaration
  arm64: dts: qcom: apq8016-sbc: Set ov5640 assigned-clock
  arm64: dts: qcom: apq8016-sbc: Rename ov5640 enable-gpios to
    powerdown-gpios
  arm64: dts: qcom: apq8016-sbc-d3-camera-mezzanine: Move default ov5640
    to a standalone dts
  arm64: dts: qcom: apq8016-sbc-d3-camera-mezzanine: Enable the sensor
    by default
  arm64: dts: qcom: apq8016-sbc: Enable camss for non-mezzanine cases

 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../qcom/apq8016-sbc-d3-camera-mezzanine.dts  | 54 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 39 --------------
 3 files changed, 55 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts

-- 
2.39.2

