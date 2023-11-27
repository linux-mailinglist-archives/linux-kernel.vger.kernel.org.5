Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07FA7FA62C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjK0QUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjK0QUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:20:23 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE435DD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:20:22 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a02cc476581so594842566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701102020; x=1701706820; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+c7o+g11wQaVIfs6Upk57wmZsR4iWH52vbiNHzvWM8=;
        b=To2sSPpSziK+Wlz+BUdzbCJ94utfLl57qE++BM+6U071Tl+KtenLvLDnO6o2YJEZri
         krRPBNj3xhDOQ0ZZ17XtBc9CgHihwj6wMUFKx29kDI1Jqd66p9MrHogHMZqtcJDXBouE
         6pMcvylY5nV13l3EAsuxBMPcGPtjj4IQHAPhX/BtTPTNfVqWN5uq9tEl5BS2R+bpuPkf
         +2BaiNMDGh2LcmmOiR2QngRxtvG6+Eq0S0DZKIXF6zt3OgpQSjpp+pJwdIyk5TKaYEcq
         HZH1pNd9xuoDkpvfLD4PEuJzuf1dHDKb4pmowboPwaeAEqqsoUNg4r48H48pM+qWH21x
         jQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102020; x=1701706820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+c7o+g11wQaVIfs6Upk57wmZsR4iWH52vbiNHzvWM8=;
        b=AQna5DyTbDobQ+HHrBhJ+LsHy+xggqgU7TxNth0hTX0ZNF0+MdSmJ/Twv5W/Rr/f3W
         vQ8UQtEkWNGmgZmotTyNUMqcZNtlwX86y7aKVwaFaa1Oz3og5v7b8T17FcfWQ3QAP7RT
         ZkahebPnpyjJ60WQGvXQ5R5CTMzGLSmRU1gYpJ5cNJEbXYcZkC+jZy8TPfS/5Y/VzGC5
         dqVTN6Pe7pFsS0kEIrO6CczOu4YSp+m5zUrIBinvZR463DGjlsGPJeMi2w/jZghAEbvE
         R8SkT0mMa1ecMDGwmuyDb6fi0qy6cG1qy4ltHZqBDOBcHv7IHSi0ndLUlmlmMGMKk1Zh
         Ukug==
X-Gm-Message-State: AOJu0Ywap/nbFO+Pj1KO8ihr8Fem6vDoRAoG5ei3BZn9JOl6s8CZ306k
        AqHr7Wstlxs8kbHEiRrrO6Ye/tfkNSmolRxIX40=
X-Google-Smtp-Source: AGHT+IEqwnM1Zk0NU5iClHhAf8DuvbmDFdZ/y49v5SALbxoGoB9jxKWr8LOq25RqeNMDSYJdvz5jQg==
X-Received: by 2002:a17:906:1dd0:b0:9fe:4d14:800e with SMTP id v16-20020a1709061dd000b009fe4d14800emr9032787ejh.39.1701102020723;
        Mon, 27 Nov 2023 08:20:20 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709062acc00b009c3828fec06sm5734760eje.81.2023.11.27.08.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:20:20 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 27 Nov 2023 17:20:07 +0100
Subject: [PATCH 5/6] arm64: dts: qcom: sm8550-mtp: Enable the A740 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v1-5-a228b8122ebf@linaro.org>
References: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
In-Reply-To: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701102008; l=668;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kZlLueRiP9pbt+9Wm47psoQj32zcJNffjpfPIXiL3Bo=;
 b=WRE83MLWSmpWessB7dY2coUQjzm2iYdVGzHYcmSdqDG6gP7YK80Ny1kvOBPNCJW7eUVt17kWT
 iGpNakUX2RMDVvsD7DpAWz4E9Kr/O4fKm9GopVgSiee5bK+ao4OTcRl
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

Enable the GPU and provide a path for the ZAP blob.

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

