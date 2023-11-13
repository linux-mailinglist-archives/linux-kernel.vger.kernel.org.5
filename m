Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6727A7E986C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjKMI5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjKMI4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:56:46 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A88C1729
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:35 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso611622366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1699865793; x=1700470593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHFRmzvU5T3tlzyLJ6u+L9D1svx2JsEEqR5zHg9JW1s=;
        b=qUwO+ta1ElsepjclimtwfnWbQX16Z+Q7FjTwuVNuPDBAhAk1VhXGKqUVy/HgJgBtYw
         90VbKbOA2H3fPTMWutCMGwEoooBYSkz618InRSpGLoRDc7emjltlnMlCzsr8rjIeF5Z0
         PcRCY2m3ssO5/tEbAwHIGQLHobetEqPS110Odj5c1lNdwnoml8bhoBt8O4Lyxc+tCh8K
         7O4FFfts/Nix3cmEhIm0j+lyWu0xkaIwcuJO3kz4Ikadozxi/xePv/MmCh9hmzRlEV3E
         IPnjiJoz51Kqfx+w6UWHUjne2xCzEzixfvJnRDDpte9qQEoqn72LtSMA+RYR7EYWKtrl
         tFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865793; x=1700470593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHFRmzvU5T3tlzyLJ6u+L9D1svx2JsEEqR5zHg9JW1s=;
        b=rsLKAhz4tmo0DYJPA8F6NyOIdCX+i8vlnaN40qSxLDCt1RmM9m5hUdFinogzAD0FMI
         Ehjr5nCTIVetGsKdwoudjQVltpDqnmGbiRtrGo5lRSYBCSzpaa7kltUMn9sRzOh2w1Rb
         8okRsgyLoYfhueoBMfkfCq3dOWOWxX/sW1+x+dKbPQZ06g8yg8cZ1+rcT2rDGYZEoh6Q
         sCwZ5Dzt6epaNu6GcsYQah/o3YW5F8S4lAkMTcaaSDyxzudrbsdiTqc/K1rz/jUw7lb8
         RflBgk0++85dc70/1OCGVpRzwZzv9ViVAF3uFZNRJUz2jHcPQRuJ96cYv0/L4DshzFh8
         t0Ng==
X-Gm-Message-State: AOJu0YwMYvt/N9Py4Nj51uxYW3EskOmLs0zRRmdX0+BDMTPJZDcPL9MS
        sq8ZGnZkABQcAKxvmKPwB6Amww==
X-Google-Smtp-Source: AGHT+IHa8Pb31leGcq/BfLuDTezKdtxG/yoxKfwEJl9LGFiOL4LSbWDBIt1ehToQWQGdY76XglA3OA==
X-Received: by 2002:a17:906:7fd7:b0:9de:b20c:be5e with SMTP id r23-20020a1709067fd700b009deb20cbe5emr4170846ejs.53.1699865793553;
        Mon, 13 Nov 2023 00:56:33 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id kk22-20020a170907767600b009c758b6cdefsm3673538ejc.128.2023.11.13.00.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 00:56:32 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 13 Nov 2023 09:56:22 +0100
Subject: [PATCH v2 11/11] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable
 WiFi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231113-sc7280-remoteprocs-v2-11-e5c5fd5268a7@fairphone.com>
References: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
In-Reply-To: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
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
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the WPSS remoteproc is enabled, enable wifi so we can use it.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Depends on (just to resolve merge conflicts, could also rebase without
that):
https://lore.kernel.org/linux-arm-msm/20231002-sc7280-venus-pas-v2-3-bd2408891317@fairphone.com/
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 307062c1a0cb..c0287d8f4ed6 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -693,3 +693,8 @@ &venus {
 	firmware-name = "qcom/qcm6490/fairphone5/venus.mbn";
 	status = "okay";
 };
+
+&wifi {
+	qcom,ath11k-calibration-variant = "Fairphone_5";
+	status = "okay";
+};

-- 
2.42.1

