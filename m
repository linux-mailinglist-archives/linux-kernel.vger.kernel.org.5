Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEA2813994
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573017AbjLNSNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbjLNSNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:13:46 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB0411D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:13:52 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9ea37ac87so117381441fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702577631; x=1703182431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMx4XjMEUXuFYA5pBx18NGkYFcvy16oralmVb/gOmdY=;
        b=XmxIajswJcFXJA6CjCTt/SIx+EnQ/Sk1L7t+9xvQTzWOM+4vx01B5F7nYqL35QJIYb
         Wc6s+mDrRb6V/NgsT6BUxTjAWesM7tSO1iqGWqaZxDueVCwWwS8CJ++V/TJHac6w6y8q
         JT1EYuASd4Eokhs5kt4DaSCRzFEgBBn+54NvwsK5skVK4WgMcGrajmuk7i3RgDX8KWhL
         UUkcdPWh57HvYjcSvbTihs/BYZNned+A13RgoHBmHluZe1pTVYoAqne9LBNXLEfO5vTG
         40PfbJQ/e3e9Xj3uruXBxo1vbnG6agc7W08r5K3kzFs8+OKqPiBuZE7GkkmIvjVbHmDX
         3plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577631; x=1703182431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMx4XjMEUXuFYA5pBx18NGkYFcvy16oralmVb/gOmdY=;
        b=bu4a8FYxPodp7PdubblqXGtDfkJ+S/h9vMJklwd67giHlOx5ZuQ29vKEqq2LUS0oZI
         JeoslSUW2t+ck66FdLRcJrac6MCNT8VO5i3odaQm4qf1KOWcBRm9bO1flRGnoS6T/jbL
         gk/9HZdjgFp0Yakme60o3RAeiifXeLGUrQZWkGJGVqJzoEigRWj4qk1lZlcRRPwkvT+v
         P0XffZgQljW8sqdGvtuSEAji4jpTSiYkSwu3cGKku1cMaQ/bqKpoXm23pN77c1VM0GXj
         Om1ViR98Fo0SOnS5v2Nu+UqVizDEVc+WUxy4SaG0YZlGKPzJf/3/tJp9Luu6GRHsLqFO
         IAvA==
X-Gm-Message-State: AOJu0YyS/jCOzM2p0lwlEpALYx5/0GbsgDFV6zW5wwWvl0TKBVRfXyIg
        iMT6p2Ik00rGgDPNjcqG7ea+Kg==
X-Google-Smtp-Source: AGHT+IEu9dXQFBaqMYJ+X69RlJ4+zf3oIcdvrbMBRHhbl71TJdITQrXpgbz1sLqSWFMJZE916w9O+Q==
X-Received: by 2002:ac2:428b:0:b0:50d:ae2:2a9f with SMTP id m11-20020ac2428b000000b0050d0ae22a9fmr4280323lfh.24.1702577630824;
        Thu, 14 Dec 2023 10:13:50 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n11-20020a0565120acb00b0050be6038170sm1928838lfu.48.2023.12.14.10.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:13:50 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 14 Dec 2023 19:13:39 +0100
Subject: [PATCH 2/6] arm64: dts: qcom: sc8180x: Add UFS GDSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-topic-sc8180_fixes-v1-2-421904863006@linaro.org>
References: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
In-Reply-To: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Gustave Monce <gustave.monce@outlook.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make sure the UFS controller and some relevant clocks have power
flowing to them, hook up the forgotten-about GDSC.

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index b857959a896b..09b4e66367bf 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2110,6 +2110,8 @@ ufs_mem_hc: ufshc@1d84000 {
 					<0 0>,
 					<0 0>;
 
+			power-domains = <&gcc UFS_PHY_GDSC>;
+
 			status = "disabled";
 		};
 

-- 
2.40.1

