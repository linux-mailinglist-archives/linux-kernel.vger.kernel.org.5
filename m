Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4E47743C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbjHHSKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjHHSJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:09:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA6B67682
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:11:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe48a2801bso9749006e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691514690; x=1692119490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KW5W/BsMVq6+QNzWH4B7mMdqsIsqWz/fCs4TWl8ltY=;
        b=PeDpiZiPdx0rfY/xiGGijxkiUGkLshZvKNY254WpIwc0Xip6UnSyZACDX6cDjqhWEh
         CaQl+o/tQXR+U6aSuTa9yyC2JPB7WpGmzDIyBp2DmiG+tqIteTNm/KmomrTaqpXEQvrS
         THy+M9D3OAQ1Hs1DG8keqSMDLN9Au33yUyvtx6X9+yL5ra/t80O87n5bnS3PggqP41bk
         kaeTKWbaWHw9/4zDFQfNti+iXhiNbahmQT0AtKjwgyIFfLqQ10Y7tsajfYu+S62s2rwM
         WijFwD4toa4fj9J/ta/T2R8eS3kfErFzPb60yoq2W50KhhxIyVgtKSaagvfHw/81b8fH
         QvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514690; x=1692119490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KW5W/BsMVq6+QNzWH4B7mMdqsIsqWz/fCs4TWl8ltY=;
        b=i9/iC21x4z+BD4XRUxGGMToQWM8yUIGetIC2C9tDfPhPNFZl5Gqt5zG4Eu6jbo1wLX
         r1LlPuaU8jia4iunrPzKe/mA5nIqFGAGbCfHBFU9yCSuV8MUnkkqbuGuazd5Tt+TDDR9
         QChEPTuflozHjf8m8jMacgrla8HOuxoDihPc3Jog2U2FMswvvsWzE9KdkhEUcDfIB3fd
         EdG0SfVwEUkojl+NKvJeSC0PdZJFMtrkbIvlCzFDqRfipK/tV70+pIXE5GAS6VJeN3VU
         9FBtyiz3yCtjVKbMMEA3eDmYgYP0yqt1tsQOWWNueIoWZ9VLJfnw5Sy6vgZLyouO9rdt
         t6GA==
X-Gm-Message-State: AOJu0YzIMbl3Y+4VLz3j8U31msUOY5+df5HAEQF0oZUtL7eCKi0JPYEE
        2Zfy0Aqq2yNJ+V3LKe+dVxOBf9llJR7fG7eWVAo=
X-Google-Smtp-Source: AGHT+IG1IYYssFkGiczWRJXJ2hNd7aUPVrG4bPRpm+cL/fBJQfj5HgLT+UBhH2Xhh05RcC4OK+d9Kw==
X-Received: by 2002:a19:6518:0:b0:4fd:d18e:be33 with SMTP id z24-20020a196518000000b004fdd18ebe33mr7634340lfb.26.1691487889572;
        Tue, 08 Aug 2023 02:44:49 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id i6-20020a056512006600b004fdba93b92asm1818884lfo.252.2023.08.08.02.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:44:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 11:44:41 +0200
Subject: [PATCH v2 1/6] arm64: dts: qcom: msm8998: Drop bus clock reference
 from MMSS SMMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v2-1-34273e275c51@linaro.org>
References: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
In-Reply-To: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Imran Khan <kimran@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Joonwoo Park <joonwoop@codeaurora.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691487885; l=994;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3dPVka+1yoTBWJAX5iuBqo/JljLJGzd9OEipOW26gpY=;
 b=P/xfTwdFTTKmfRH1cHDGu0mhCVETc7DhmfzfJHr6hh8cV9OWxxp8ilKs4ThwIArS2RVFHOVnf
 uG9mGb1qwVACAbr6fd75bvJra8iZTVEziz1Kd1WLVE66/LQYZdFZUkQ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMSS SMMU has been abusingly consuming the exposed RPM interconnect
clock. Drop it.

Fixes: 05ce21b54423 ("arm64: dts: qcom: msm8998: Configure the multimedia subsystem iommu")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index a41a34dbcc3c..e40f6461f4fd 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2743,10 +2743,10 @@ mmss_smmu: iommu@cd00000 {
 
 			clocks = <&mmcc MNOC_AHB_CLK>,
 				 <&mmcc BIMC_SMMU_AHB_CLK>,
-				 <&rpmcc RPM_SMD_MMAXI_CLK>,
 				 <&mmcc BIMC_SMMU_AXI_CLK>;
-			clock-names = "iface-mm", "iface-smmu",
-				      "bus-mm", "bus-smmu";
+			clock-names = "iface-mm",
+				      "iface-smmu",
+				      "bus-smmu";
 
 			#global-interrupts = <0>;
 			interrupts =

-- 
2.41.0

