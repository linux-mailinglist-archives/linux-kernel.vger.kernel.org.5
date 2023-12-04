Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB25D80341B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbjLDNMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjLDMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:55:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101F2A8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:55:48 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c671acd2eso3466617a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701694546; x=1702299346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYBJZvf16al31yAEkvLrTZBLEk08fvZeDLHzDDQHdx0=;
        b=I88nEEOKAbsbAQrSA+jpKZxAnGi1l3XoSJblEP4/ZlCghoBNlT0zzVaRAv2O4JRB4J
         q9JkTwvlRCMUklID80Xx/JUhqjLDY4Nt/S2TuuvJKygmZf+DU1Ee2yNzfYexrkY6lf/F
         osZF5Qr8Qq9I+AqyfDZ0b6DgCuuKxA1OE9YTTGfJW5U0xCEi0D/BFaycea/lNPdrO+9P
         ew1CAHiw5NhkzILRVwfWMoIi43n9645npT5sML8v/L1GCWGOho4zFhsKd01BDfM1PUCu
         zcMLxzwUiPeozJkWj+zCBkdRSHBWiw5EqzWPr8bKnD3fOAmaZLi83vOacLyzHumYDrS8
         dYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694546; x=1702299346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYBJZvf16al31yAEkvLrTZBLEk08fvZeDLHzDDQHdx0=;
        b=IbhJ2gCfTSFotiQGaRBMiftoESnsTwmT2ad2cWSmH9cFMWhK/Ctu9/VU/otjUW1/D7
         9mCEH8TQ0Qlurvr+SEcORArrayO22E+VRWTqYKnli6SK0DNQcdlfQQrT/W3EaF8kcLz8
         BOx2BkS22FGn7Pblu6p2T2hr8LBBJhAnzzHBJvy4d7ApzBT3QXWb2+LT/EbCN8t5cfk5
         78VATEUNC5OOFYnVzgdj5lCgj/QDHTzwVnQZNTCOFvxmR9a+E5wrA6p+wV0eiDNSjctN
         eFNft7Jj7LVWCER/XqkZ6guQHxwvXVcOqfSAWFRAW2W4O/FK7JBbuYr4JKqUSNW7+5ff
         CAgQ==
X-Gm-Message-State: AOJu0YytokhIilIkJI3oKBrxGBh5SegRllP0geydBk7n1D5f0i2UyJPW
        5nB7lu9gDGlgB5wCrWv5v/1A9g==
X-Google-Smtp-Source: AGHT+IHoHO9TKConiwiagXCkku3lVT4S1J8QynxoRRmySDKBpuPSv9oHBFS3wp7AR1UsVLO+J4Qu9w==
X-Received: by 2002:a17:906:da04:b0:a19:a19b:c72f with SMTP id fi4-20020a170906da0400b00a19a19bc72fmr2953051ejb.127.1701694546652;
        Mon, 04 Dec 2023 04:55:46 -0800 (PST)
Received: from [10.167.154.1] (178235179097.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.97])
        by smtp.gmail.com with ESMTPSA id ay22-20020a170906d29600b009efe6fdf615sm5241373ejb.150.2023.12.04.04.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:55:46 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 04 Dec 2023 13:55:24 +0100
Subject: [PATCH v2 5/6] arm64: dts: qcom: sm8550-mtp: Enable the A740 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v2-5-2a437588e563@linaro.org>
References: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
In-Reply-To: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701694533; l=725;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9FJMq5XZXBPBjP7KOy0b1q2lfGMXMmYwfkQChVXyG58=;
 b=dZQFJAa43yRKRFVuhYC59lVTywRwiU+Z0ruBiOuzMDG984BZCFwibm30OYopXSQz1iEUiR2Kv
 fnvSNpONBQeAECiGUNL/pvHsWJ8Izr1Y1LW3p+shWU/3y27ivta91tX
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the GPU and provide a path for the ZAP blob.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 9a70875028b7..52244e9bfdee 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -512,6 +512,14 @@ vreg_l3g_1p2: ldo3 {
 	};
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/sm8550/a740_zap.mbn";
+	};
+};
+
 &i2c_master_hub_0 {
 	status = "okay";
 };

-- 
2.43.0

