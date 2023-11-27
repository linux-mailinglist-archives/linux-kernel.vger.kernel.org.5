Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331017FA633
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjK0QUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbjK0QUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:20:25 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A390CE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:20:24 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a00191363c1so650545066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701102022; x=1701706822; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gQ6YImSRCbx+1xRUL4mfy0bfTlxIzI8pSH1DPk4t6M=;
        b=xXjPfRLMdBVIbfdX2XNa/4RviGs4Dlcw+PuHq6+k4yZcD6aDPRW74yAlAtr6EyE3Pd
         HEju+KFkAyjSo3TExljeFoe3c5I3SwfPQ8c8uu93h7uqTt0xD2ToIWI6DUduI235Hcd3
         vMZIV3PKBuprlfyyRjXrHFkcISbB8nh69ck/07DA6OssCZ4C83HfNBQG1DqR52WwKWb/
         60R5N2lIFMDjHfsog8PgK5iV2INiqN3/i4/Md3sByEPFrQ1zOc6YqvlG6MirQ44m34kT
         Vfe1+Tp4MzZ01uRyPkCofaHg0KVnuj+saOqhJbEEeXDqm9QASmv9+2/lfRY1qZ9DdyGK
         f4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102022; x=1701706822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gQ6YImSRCbx+1xRUL4mfy0bfTlxIzI8pSH1DPk4t6M=;
        b=BiTUSSDNZx1LmOFXtrvpWgT03MAHutx920ZDx9KEnY45pmEq1pjtO+EQLxh+UuxE2G
         HwSzOnTk6lwYih91RGxPs5ly5aPDk2DId+FXRgxq8lP2iOAENnsseKnURWyiRoDdVV2b
         +yvOAG1wWE9dA9pxwlL4SHvwweqo5U9sQnmq4VBSbo4QLTOHkbGTN6V/IllQ8sZ7hj8i
         vinx7JY80oKl6bXl70NpmDJgI3fd4b5Wn94AuoUzOvWK6nXTDCqnw2JnzJ7Pq0H4vaDi
         pVkWXVyCJQuZLAGZjGjTm/X3V64xRl8rE370nL3P2zd3EtNgsoJ8Hvw9aKXToanwSsIM
         +Dmw==
X-Gm-Message-State: AOJu0Yxis0eqLV4ux1iJMiR1lith2mXr3QnzJ6fWLjTCX1NRD9N1GHN8
        doUxjkpS5/ptNiz+lhgCBPE9XJo0Smv6i6eZSlY=
X-Google-Smtp-Source: AGHT+IFPmWmSTHMcfL1yecPUgSq8wRk41FMgkXe1PITU3Isy6yZrSpKslVtSqdOYlcbiQ944Gj61HQ==
X-Received: by 2002:a17:906:3e0e:b0:9c1:edd8:43c2 with SMTP id k14-20020a1709063e0e00b009c1edd843c2mr8518492eji.42.1701102022689;
        Mon, 27 Nov 2023 08:20:22 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709062acc00b009c3828fec06sm5734760eje.81.2023.11.27.08.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:20:22 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 27 Nov 2023 17:20:08 +0100
Subject: [PATCH 6/6] arm64: dts: qcom: sm8450-hdk: Enable the A730 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v1-6-a228b8122ebf@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701102008; l=685;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ZUlIcXR6hgLx+DM+J1BHsWNt1eWJies/ihFtsM1lhWs=;
 b=Cedfa+rVMp6sij89sdZZMlPzRmUJXcuOfEsRWBEN2D21fqvMOO59apxBjB3KBAs4/TDPO0Kqr
 SYlvJAJGZQ/CbFapt8rBADbCSma58YbPuNklA1x7+9wefmw9suo3yzI
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
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 20153d08edde..a20d5d76af35 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -580,6 +580,14 @@ &dispcc {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/sm8450/a730_zap.mbn";
+	};
+};
+
 &i2c9 {
 	clock-frequency = <400000>;
 	status = "okay";

-- 
2.43.0

