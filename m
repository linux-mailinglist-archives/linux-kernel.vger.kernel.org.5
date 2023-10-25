Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2787D62EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjJYHcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjJYHcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:32:16 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159ED10E4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:32:12 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso14518111fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219130; x=1698823930; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkK06hkxzdwxK+868ZNfQOlrMKOnjIUgKDjw97JuG+E=;
        b=CP6fAhQdNQHxbFCGvyNAig0lhqLQCpHazulAV2WIYg2LEV7xR9Bg2TG1wls42fO+W7
         4rqwexrp0ImsZDIfhMz5hBxI43dtY6roRPtmznmnRtHdtbp3fUabCqoWxEEpuzkf/Ihb
         BsY6CCZnsk6/FXc3dwtv95x9saEKdTNpKwjXcTrNFdcW99lyfi9cdUHMwgAFoDTJdD7G
         s2Qa0oTflZCleCTA+oWcJaZzTCxxq5+B4uEUIGDF35UOd8q1HVyBFfVRs2J+TeVbzfCm
         dlHMxaPZVwRAhZlxzfXuo+LNJn9eFNqpSTzVJ/UwuAwMcE10dURyCDfRrOkvRURDEDXp
         DyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219130; x=1698823930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkK06hkxzdwxK+868ZNfQOlrMKOnjIUgKDjw97JuG+E=;
        b=XZsHlroXWMH/ROg3CC1Lr3W9ypqXdXB0cLS5YuAuHH9Rxkr8/TwX/hquZZUp2StjO8
         5wjLJWl0bWwpA9gtE5Cp7tZ25SIbfbh6S8raItTUkhpJq77vMoA19R3whZim6Xjq21jO
         h6YQ4PuHSF7AWzhc3X6NoV9xJwk5e3CW434pAg/eVlIDw8pxzNAyjWK3yiZrTkR/M3UW
         5F/qFDtE9cJOlI8q3/vgrCCUQwfK3guouCJhym88+QmrZ+sXJic8RqVagtIYyr6fUGas
         Ik2EjhkbCV9syswJeuk56P0q5iLYLB8JZUw9HXCpFpsk8tHxvDG8KtQl9dN08bhY43sc
         7Bug==
X-Gm-Message-State: AOJu0YxtCZSlUh6wP/bNmTmjnwQ7XRqfUxj7/nGzVPrttlwnL9NFVXid
        bgnhx75GpRFnhpDIK1g2wL/BpQ==
X-Google-Smtp-Source: AGHT+IH+Yira0OYgCUa++PaIdfxYJvBb1lvUtqlD4An+snbTHt/sntEuCvgnEiScLvU95z7u0RShvg==
X-Received: by 2002:a2e:b790:0:b0:2c2:a337:5ea with SMTP id n16-20020a2eb790000000b002c2a33705eamr10722063ljo.27.1698219130228;
        Wed, 25 Oct 2023 00:32:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0040841e79715sm14036237wmq.27.2023.10.25.00.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:32:09 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:32:02 +0200
Subject: [PATCH 1/2] dt-bindings: power: qcom,rpmpd: document the SM8650
 RPMh Power Domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-rpmpd-v1-1-f25d313104c6@linaro.org>
References: <20231025-topic-sm8650-upstream-rpmpd-v1-0-f25d313104c6@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-rpmpd-v1-0-f25d313104c6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=iyrV9MsmSRaFXNkt/CNnLJ+tmAlijZsh8rTitKBaq6g=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMR3jqfahPM5bx7B4kHScB4B7os/yKbaBRvnfuAh
 57/rSfiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjEdwAKCRB33NvayMhJ0UtIEA
 Cops3457fn46b3U7vAcShT+c9Ygo+mADKziI7dm1hbLr4QG4NGE+FIODg3wwZKokavLf0eFByaK/DX
 qUJfNKjL5NRXTtzK47e1Qx4TNYk2bVZKAUgNf2exI2xDT+J7bXJViJefoXRMigdUstrFITmgXYlQrl
 tFlnGOEZ/f/E0FnnsUrntmxqx/ItUkCTT1lSUBjjVzZYNeFYU+aJKbvJ+WUDCqZajTsoJrY92B1Sq7
 S8LCfi/lBWrClR5HlKYXzMSizhDNt+SUG6gwJmtJmA2/8ASpd/t7Db6YCq9Mx5EsYyeh2z311IqROM
 uiUEjEeXKxN5ViXMh0uW+NYcflAwAGF8ZpBl8lsSlRJn/M4WEfOdL8qmua9c5hnT7HcOXAVifjchIF
 rPVTcr/d7u5TSKxBSfUBMaF3xsesYOwWMXzPbxXxPICaO5Fesl98sxoXvt2XDXr0pSCqHcTKg0ayM7
 piTzkOU1ABgvx//823/PfXqyDl+hHrjLC6/1uUK4IVcupAwSmCAJ4JxaKbVxoXC5hEl41Vwp7tmvn2
 nNtMfPam9ZE6vbFyk509Yt4tEnvBCHM0Yccze/ibipTa7l662LbhgoFZZpiGX/HbmavmOfriqljZB7
 POm21Sw47PoozQbGOJhZKuwDZJrDOe1u3CJKgvjuChbkoXAzqwZEXJcU18vA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the RPMh Power Domains on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 include/dt-bindings/power/qcom,rpmhpd.h                 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index d38c762e1280..2803f7d56821 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -55,6 +55,7 @@ properties:
           - qcom,sm8350-rpmhpd
           - qcom,sm8450-rpmhpd
           - qcom,sm8550-rpmhpd
+          - qcom,sm8650-rpmhpd
       - items:
           - enum:
               - qcom,msm8937-rpmpd
diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
index 7c201a66bc69..0f6a74e09970 100644
--- a/include/dt-bindings/power/qcom,rpmhpd.h
+++ b/include/dt-bindings/power/qcom,rpmhpd.h
@@ -26,5 +26,6 @@
 #define RPMHPD_QPHY             16
 #define RPMHPD_DDR              17
 #define RPMHPD_XO               18
+#define RPMHPD_NSP2             19
 
 #endif

-- 
2.34.1

