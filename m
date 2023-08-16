Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EF577DA20
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbjHPGFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242055AbjHPGFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:05:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8342123
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:05:07 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bad7499bdcso54481571fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692165906; x=1692770706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5FCw1CPqx54w0jYmvAqrzvFjd8VR0SxTC9P+XCSNJRQ=;
        b=tGk1bPEkOBHeBlQxJj/SI8T/27N1y4RAUWhfAtNb4ujTMDSQN7v93qajRtFZpTDES1
         RecvngziqUQvMyHVAQ/knD5KThMOD6GKn5MLJIw38zF3CJdZmCL6JZdKxjOKYmeSSncd
         ei4kxsXvbGGQh4RRfreU77MBVhZSmgQzb5yx1nr82/Ywmh0l5I1pT0ovqFhJ3f5Lh6MQ
         jQPt0Cv8DDyMxCKElvm0mJhKjkVhqtUeu5ez6yU9JdCMIT2wS96eMpRPXZkXSa8/C1bT
         uTIbvaslriG+KWR6vYZu63bBoh9ocUqkl/lf6xhXIcqF9g+yz/H6upuDHAeDsKFcr6YK
         56OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692165906; x=1692770706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FCw1CPqx54w0jYmvAqrzvFjd8VR0SxTC9P+XCSNJRQ=;
        b=Rmbs2HgeOGfRO1zddJqld4qTN5cwMx6wyZGG9Bron0YD5xtyONLtvZ4EW3MfEHtOoa
         ZEEpj3vr7qn0z2/bzIJGji+bZEEIs+j/8ahDYirRhxOAvz8jm+ciS8IoLSanL76saiGS
         Q+fZlgWtgqlscskNoZr4ZbQCfr3DZw3i/SOKCVapEVnm6MEsXRexlC5uO32fcrWUZkFP
         unNYMWJcJHXotWfCs7wLHIIwxqGn3dyZmPTGnGBUu6QVTskwEtniWks0BENt5mlsp5Tn
         AFRxQ+MB/t1DtZuF/P8vzgWDvQ8FCIRT3Q6jgzzfPn9TMgufvBRbzE0TOo2kKbklX4cD
         sUHg==
X-Gm-Message-State: AOJu0Yy/outdWLvrgC6Qarqw43W2UDGl035NrpPfXJP39noCkvBem4EV
        RJfJ/r3Mx48ocztwqdHkD3C89A==
X-Google-Smtp-Source: AGHT+IE5PLQ1WJDusUIUWYS9w0Yzlr5sh3wtjqlXFOFeNypchay8XOxEIucKSpEr6M761qypC2+/og==
X-Received: by 2002:a2e:9bd3:0:b0:2b7:14d4:ce6d with SMTP id w19-20020a2e9bd3000000b002b714d4ce6dmr796610ljj.48.1692165906233;
        Tue, 15 Aug 2023 23:05:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id z15-20020a05600c114f00b003fe2bea77ccsm20037168wmz.5.2023.08.15.23.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 23:05:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] arm64: dts: qcom: sc7280-crd: add Bluetooth VDDIO supply
Date:   Wed, 16 Aug 2023 08:05:02 +0200
Message-Id: <20230816060502.16789-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Bluetooth requires VDDIO supply and Doug Anderson suggested it is
vreg_l18b_1p8.  Add one to satisfy `dtbs_check`:

  sc7280-crd-r3.dtb: bluetooth: 'vddio-supply' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Use vreg_l18b_1p8 (Doug). Due to such change, don't add Rb tag.
---
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
index afae7f46b050..c2cba9d7179b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
@@ -38,6 +38,10 @@ vreg_s1k_1p0: smps1 {
 	};
 };
 
+&bluetooth {
+	vddio-supply = <&vreg_l18b_1p8>;
+};
+
 ap_tp_i2c: &i2c0 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
2.34.1

