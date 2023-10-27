Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852137D9B20
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345941AbjJ0OUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346117AbjJ0OUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:20:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657831B1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:20:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9bdf5829000so346926266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1698416432; x=1699021232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pY5w7Bh5EYkfQAkYpZoq0bZLBNjbmv28cc4lnv8Ll9I=;
        b=aHnZV7dV5+yi+0oU2d6hlrnfy1rMELaNvyKZPuEQlJwz/vZHHMFXNaAqsY00RvFtMF
         7Q+sF5Ma+tzzS+mOdaZu3RcTsa0VoR0q1uyAfQSczDE+Y4FvmhPQXsT6I4X0fEdVXF7C
         VTxMjvdw/CWRGNBdednjTv2DcwrBsH6pQFSeWykMuz4mWGt+tfu1rTt3/ziTJpwWV3M0
         uh/eKse9RnzjrF4+qq+ihe7TZwuPiIIEYOQeibbJI88gm9HK8WqBl/ykHd8/FJlfPSv8
         DetYLASWaQ7BIcPS6My9/vEupK+CpUrQVNcQHZfOuXtqwVbBcxkIDmA+USSU1dm3Zsrs
         ZiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698416432; x=1699021232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pY5w7Bh5EYkfQAkYpZoq0bZLBNjbmv28cc4lnv8Ll9I=;
        b=CsXSFaeoFuQ0kbH8qmdAO/g6ogPpGlXh5nYa72O2yySf8BNZXxBvCLUsPIFrPyGSOt
         dmsL271mG+tAqLlKdApb7SAysPDBVUMiFpiJmUYRXNHLK/n1EldmMlMJozJfGG6kU1YL
         3XWampd+pN6yaEtHSGldE4i5WC0a/Sti9PHyEMM0SFgzG9BuRSDbtM2Bmf68iVu0K4j+
         GHWQK1RVP4KeT7ycvrKVWHwQEg/VeEUrOBwmdtxwHdfDnPT9rMinvHtaBqmaM03P2DOc
         qzpQK3Sl5Zh/nMvX4bUn1QHF+TuVF5e7eolGIyTbcefrM6syf/Zxb1nIt641Rpnoz+4s
         Wyxg==
X-Gm-Message-State: AOJu0Yy0cGI9HIEUMUSWzX6zhzeai2cgXciAYvy7cWnLqUz1Ps1i/00D
        KXSflGWRzm6ZTUqDbJRnsBr50Q==
X-Google-Smtp-Source: AGHT+IGW4u2KfBM90vMKxhLrcqy8HbkaqtvIK0ZxxsXDMDiAWz6lFDgrjRgnZjEl4dWhiMUeVF29PA==
X-Received: by 2002:a17:907:940b:b0:9a1:f81f:d0d5 with SMTP id dk11-20020a170907940b00b009a1f81fd0d5mr1934297ejc.54.1698416431800;
        Fri, 27 Oct 2023 07:20:31 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906075700b0099cc36c4681sm1254076ejb.157.2023.10.27.07.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:20:31 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 27 Oct 2023 16:20:24 +0200
Subject: [PATCH 2/9] arm64: dts: qcom: sc7280: Remove unused second MPSS
 reg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-sc7280-remoteprocs-v1-2-05ce95d9315a@fairphone.com>
References: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
In-Reply-To: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings for sc7280-mpss-pas neither expects a second reg nor a
reg-names property, which is only required by the sc7280-mss-pil
bindings.

Move it to sc7280-herobrine-lte-sku.dtsi, the only place where that
other compatible is used.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 2 ++
 arch/arm64/boot/dts/qcom/sc7280.dtsi                   | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
index 95505549adcc..203274c10532 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -33,6 +33,8 @@ &ipa {
 
 &remoteproc_mpss {
 	compatible = "qcom,sc7280-mss-pil";
+	reg = <0 0x04080000 0 0x10000>, <0 0x04180000 0 0x48>;
+	reg-names = "qdsp6", "rmb";
 
 	clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
 		 <&gcc GCC_MSS_OFFLINE_AXI_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 5db468d1a06e..0d9cc44066ce 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2848,8 +2848,7 @@ adreno_smmu: iommu@3da0000 {
 
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sc7280-mpss-pas";
-			reg = <0 0x04080000 0 0x10000>, <0 0x04180000 0 0x48>;
-			reg-names = "qdsp6", "rmb";
+			reg = <0 0x04080000 0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
 					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.42.0

