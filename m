Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2DA7FE008
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjK2TAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjK2TAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:00:13 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E751BF0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:59:54 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so167801a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701284393; x=1701889193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4ii9nB0ErmXn2KODC7R6V48jENPZfDAwImjQKSTU3A=;
        b=V9+pQ2NMkuxQYdVvTWgPhsW4LUUotYYFqs7FwvklFPAR4MPbwrAY3uTTMHGDhFNFHH
         fktV3lgN2FQhzco3a4LZWqgoZ3K7TOwn+TRDuD9cNXPbulYGKufaFpURKPA3kVDc9omB
         Czdfe/5Q6IwKXboNg4hW2TSz8v5oJnNtruq/kxFan/olXyhNE/qTeHG74abDEf3vsVPU
         wT6YX2sAe6gVVCbP5ARMci2EaZCcelc7Cd9MTd+7cXJuJYh8wXZ74hBD66akjC4cGMne
         r8Dab2qo9gJAKQ+A7RtJmzLljA/pUzrSjdDua8tH3DdN6fBrlI3KBsHk03LJIf820PX+
         nVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701284393; x=1701889193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4ii9nB0ErmXn2KODC7R6V48jENPZfDAwImjQKSTU3A=;
        b=JXBQjNsO7DmURuqXInnJgQ9orNAa/KnTXF/PNgvVjO1FhYo1NcgM2QicVENmMkNDv0
         lwYNIC7sY25vb5B++z9vaaUu1YeqBomRA3fZ2dSFWKGTU9YTJMInIFHZE5WKul84bYYI
         +1HFu+F6VtYxDq/Ad45BPyIJTPwTh8WKQuFkeYaHugtoixiwffF5mnDejL7iM9lKHMa8
         8uZh1vD9sW5Oj2G+9OYGEcI5TrW5o9/ru8jNH9I4mfwOZyBDK5JLXT1wXEqSlfOe5b/k
         J9Mp4R8B/PhgaHVs/EOgNv/IT9FogPpyNL/B5cR0mRY9kJx+EvDCduXhMw2VLMnM/czr
         iUxg==
X-Gm-Message-State: AOJu0Yz+EHOGdvArRPzX+xSFiw9Er2497ebsnOH97Ub7ELrf/dPhpPSe
        Z2auBBbIT7CoP6WHAp1xfn1YuA==
X-Google-Smtp-Source: AGHT+IFLeQnvRIS+r/1dK/xhN6DpgvYxGQeVp1B8bbLaDgTIFJsEC+Ip5tJcKd5AgN5Qtig5plLMJg==
X-Received: by 2002:a17:906:2c4d:b0:9bf:b022:dc7 with SMTP id f13-20020a1709062c4d00b009bfb0220dc7mr14250083ejh.48.1701284392924;
        Wed, 29 Nov 2023 10:59:52 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id o11-20020a1709061d4b00b009faca59cf38sm8160232ejh.182.2023.11.29.10.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:59:52 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Nov 2023 19:59:34 +0100
Subject: [PATCH v2 15/15] arm64: dts: qcom: sm6115: Add VDD_CX to GPU_CC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v2-15-2a583460ef26@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701284367; l=911;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BH4GhoJ2luOm/yEgTY6YbdfpMwm4FAVH7lxzWBafJRY=;
 b=sxfubn9p6AvpZf1s4Og8CFO93otX1/zFCaT7/7QoHV3HKzBvwUxgYUgII5dqxN+mU9aR0EvsC
 RA2sksOWtpeD7PeaE0vw1Pc1Mj8WdkkJjIzsW55tBorUngx3f3RC7vp
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU_CC block is powered by VDD_CX. Link the power domain and
provide a reasonable minimum vote (lowest available on the platform)
to ensure the registers within are accessible.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 29b5b388cd94..bfaaa1801a4d 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1430,6 +1430,8 @@ gpucc: clock-controller@5990000 {
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
 				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			power-domains = <&rpmpd SM6115_VDDCX>;
+			required-opps = <&rpmpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.43.0

