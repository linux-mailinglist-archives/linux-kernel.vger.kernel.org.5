Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A117EC785
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjKOPjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOPjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:39:09 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C6C2;
        Wed, 15 Nov 2023 07:39:06 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4ac2c1a4b87so2729598e0c.0;
        Wed, 15 Nov 2023 07:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700062746; x=1700667546; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ka6oEPkfLKrGnat5klQHHSJAKoZdHvZ4vqzdVi71ZtY=;
        b=l/yCOwBzS7yxYMWD4KmFnlwyPnqDFYi0T0QNqRUoKH/nOo5AKHeAW4E0sygLRbffRG
         cY4kAdSbJYkOdxIu01w7Mk5ONd/d2vK6GLzmlten5arLwxX/gHxHhWR4LMvz8tadoWwW
         +A+wqmim6zy+PRjUlw5P+Q6g1Y7nY4jTX+8mJFQarLVNNMWWhxOfpeWp8QnhhkwreJZG
         HIEkxOj7vK0KQ7DvcMkRjXK53JmlIj08uXKgTlzmSxC7TS2hMl2tzU/AnNgkzt5C7ybv
         lsmeUVOJFu65ERNOYl/7EUrTkjoOkqLHrP4cY3P6OxUZFpqmGWBUn3EVkCmgoCa4vhnj
         /eQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062746; x=1700667546;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ka6oEPkfLKrGnat5klQHHSJAKoZdHvZ4vqzdVi71ZtY=;
        b=qT7b4q+D41P9B+qri4ZD3GvAnWZFoud/08ixeIdtoodmOWanJjLsbrhBP9I3C3cD3R
         NkhS67VS0lIto7qriUjHBV8uJftDXtfrCtDf7bWu07s3xhFC7gXpB9WjhnFc5LMPjEko
         6+wIEqpWDJpexg5qD3BJPBZij/fImiN7V6Lxg1qjGnUy9unGrrv3BZqTrulW/x+c0RE4
         j3Pf5cO2xcrVVSbjRLbRMXJ9GovFOF/9UhbS4GDvfkeuWZ50xRGq9SmEwmRlYkYydP9o
         kigNeSiUhfGsbjfGDijgEjCAWRZ1ro+dH3wyD/wezUc1Fg6prNO7GAwGntStC1gN9t5+
         ZiEQ==
X-Gm-Message-State: AOJu0YweRSqswyAf22dMU5Q1lg7XBxLscESF/uNfQJ01qp7JZkcFpeq2
        UFkOQLbMXXXg+hMGlY9WQ52NAkupS90I/aT3bswH195eDH+RG/a8lZk=
X-Google-Smtp-Source: AGHT+IF2MHChcNxtzmpKThCzu49QGOdBWtNv/atMno9IuYGomNn4RXZcC8XOgVmbqV/mqWo+mBqJNKMtof6nBXYIDUM=
X-Received: by 2002:a05:6122:3bd0:b0:4ab:f4e6:7d7 with SMTP id
 ft16-20020a0561223bd000b004abf4e607d7mr16288432vkb.0.1700062745848; Wed, 15
 Nov 2023 07:39:05 -0800 (PST)
MIME-Version: 1.0
From:   Isaev Ruslan <legale.legale@gmail.com>
Date:   Wed, 15 Nov 2023 18:38:53 +0300
Message-ID: <CACDmYyfOe-jcgj4BAD8=pr08sHpOF=+FRcwrouuLAVsa4+zwtw@mail.gmail.com>
Subject: [PATCH v2] arm64: dts: qcom: ipq6018: add QUP5 I2C node
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node to support this bus inside of IPQ6018.
For example, this bus is used to work with the
voltage regulator (mp5496) on the Yuncore AX840 wireless AP.


Signed-off-by: Isaev Ruslan <legale.legale@gmail.com>
---
v1 -> v2: fix clocks typo; fix reg size warning.


 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index e59b9df96..00a61de9d 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -506,6 +506,21 @@ blsp1_i2c3: i2c@78b7000 {
                        dma-names = "tx", "rx";
                        status = "disabled";
                };
+
+               blsp1_i2c6: i2c@78ba000 {
+                       compatible = "qcom,i2c-qup-v2.2.1";
+                       #address-cells = <1>;
+                       #size-cells = <0>;
+                       reg = <0x0 0x078ba000 0x0 0x600>;
+                       interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+                       clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
+                                <&gcc GCC_BLSP1_AHB_CLK>;
+                       clock-names = "core", "iface";
+                       clock-frequency = <400000>;
+                       dmas = <&blsp_dma 22>, <&blsp_dma 23>;
+                       dma-names = "tx", "rx";
+                       status = "disabled";
+               };

                qpic_bam: dma-controller@7984000 {
                        compatible = "qcom,bam-v1.7.0";
--
2.42.0
