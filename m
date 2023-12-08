Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC22180A6E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574297AbjLHPJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574320AbjLHPJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:09:13 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17984199F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:09:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1da1017a09so264036766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1702048157; x=1702652957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5saW7f08DRNg60nP1egaBbrtQdtUawHIZ006YWZ+vGo=;
        b=iVSDUnwgi00pXXu/e7hHEpen3vn61cDhuVfiXrcTc9yDwHTDzhNMaSnQHXCRn7nSnT
         5yahXJP3yTplAMjDrhvx1HWf+iIl841nHgZekgaXvy1r6ynMAEzU127A07AcKIB/zRg3
         zCA4sNdz3EuDO9URtJYzvqzmzBX31S6qY5B9VEhYBSWbE/aQxquY23PQyyhGqbN6Akzi
         QXvyQhGfOZn9V+fEEu+dcaMHNzVbjQ22C70slcyqVX96gmaVRvrAUxEhdQrldpsfeanf
         bJWdOy690YtuH8CVuIgz3XdSqFTySK7CeddqfJISNfksvm4yLoaeJ26W/xoGOb7zwNO4
         fYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048157; x=1702652957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5saW7f08DRNg60nP1egaBbrtQdtUawHIZ006YWZ+vGo=;
        b=lQyf33y2KoQEvYnvKcvCfWR4ud7mBrb4yi3GLMljTYUW2Y9NfYwpT7xPIRtmCqk9iI
         vQiO+50Xna3AXaRGDvCiViQR7bOc7HGd7rlOYvm6nBOaMLdAfAwo92mzXYP2bL4nzxg5
         +ZAgihZvN3W/2/RbMlkwecqDFlk8en4af4xYlV0cmGUIJ7yUFHyyLnVx0hpCdkmYfYDT
         HPDFh/vExRskcVD61SjKPB9WilVyn0x8YXYXQMriaH9SMKJEP4LLlpu6teEcVY6xvPsk
         c24tS9Kj94+XkQfuqTsWc5QQGAol+rYZceM9KG8rK3dbIryrsADgAn+VnxZNN6SoHZ3m
         k38A==
X-Gm-Message-State: AOJu0YzJlc+6GJ1TXlFLbLh7LRe6DrLxMQcqJK2s6p4wXw+U1/7DGxhW
        GJ15gzWy/qaAyT7igdN8E1exKg==
X-Google-Smtp-Source: AGHT+IEd51m0JuEJzkDN/9QlvvgYBDbrDZhxRc+YXzhVBNr7lRFtZjwsx9lkYs0+gZHZb4zXuUHSdg==
X-Received: by 2002:a17:906:10c7:b0:a1d:2e32:d284 with SMTP id v7-20020a17090610c700b00a1d2e32d284mr60291ejv.23.1702048157297;
        Fri, 08 Dec 2023 07:09:17 -0800 (PST)
Received: from [192.168.55.221] (tmo-113-102.customers.d1-online.com. [80.187.113.102])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906351900b00a1cc1be1146sm1096114eja.217.2023.12.08.07.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:09:17 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 08 Dec 2023 16:08:07 +0100
Subject: [PATCH v3 11/11] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable
 WiFi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231208-sc7280-remoteprocs-v3-11-6aa394d33edf@fairphone.com>
References: <20231208-sc7280-remoteprocs-v3-0-6aa394d33edf@fairphone.com>
In-Reply-To: <20231208-sc7280-remoteprocs-v3-0-6aa394d33edf@fairphone.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the WPSS remoteproc is enabled, enable wifi so we can use it.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Depends on (just to resolve merge conflicts, could also rebase without
that):
https://lore.kernel.org/linux-arm-msm/20231201-sc7280-venus-pas-v3-3-bc132dc5fc30@fairphone.com/
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 830dee4f2a37..03ec0115b424 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -914,3 +914,8 @@ &venus {
 	firmware-name = "qcom/qcm6490/fairphone5/venus.mbn";
 	status = "okay";
 };
+
+&wifi {
+	qcom,ath11k-calibration-variant = "Fairphone_5";
+	status = "okay";
+};

-- 
2.43.0

