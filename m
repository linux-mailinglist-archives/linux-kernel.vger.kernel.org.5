Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DCD8139A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573067AbjLNSOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572979AbjLNSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:13:59 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0A1123
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:13:59 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bee606265so9040194e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702577637; x=1703182437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3r1bVN6/4LrrGw5N6lGME8swP3TVIC1FuDgOiCIYg4=;
        b=BtMVHhqCysRUHwWJ73akUFQC1nfiyOUsguAex6zNmRQeXlCLD/IUc3laFaacULo3HQ
         Jt3y9AyACu4vfVd/Dm882cElZAwNCYIIcDIU0Ok7o0t/cAA5p4HRT4DCbl2bW8lgtslR
         WNWCIC7jKs7CRH0tyOyz6OD0yR+rUzjcHLkr5zJuvlYdk6GAi4zSnKb/11NVlbQbntrO
         TLrodUfm0fFfvPrqb5KuSFuHV3vdGGNe+pTI1rlihKB3MD/IAuhKS/uGjfccDZIG01zo
         6dqg5r6bAjA4gRCbWjUs12LtAmGXeWf3G7hRNJSvoYc9nzyjU1X9KB42atIq0GWWADBc
         h+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577637; x=1703182437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3r1bVN6/4LrrGw5N6lGME8swP3TVIC1FuDgOiCIYg4=;
        b=QxGkcitZxPkVgts3OJSak2l2NnU+TMRwh+BJdncIlZlNV/7vHtWRm9IFWqF7E1GTVD
         aAWPx9vS8W8Six7OK3s95dVH4d4S3c8RXuaYcRtMdaSQk1TzB1nz+uw4QdQqbR3/qUYU
         6beXMRnvdVfxpWRgdiO/83A8UiZTW4SzXOifnZiiBINN6MPn2Mzr8RwK+M4MRBc0dw3m
         wxKM4Db4ECchMBccfhLQCqQtWWsqgxigk7BO4JTVjyRsfp/zhVboCmL0dLjDaJmfAVFw
         aAcoWrBQanMU3zLwW7wfEYxyQB98x6S5iPekZ2tbCXLCeL6hfQaamzin+aaoQ0FMdKZR
         uT4g==
X-Gm-Message-State: AOJu0Ywc2IHRDo7yEzkpyoQk6XgH4VLlviANdUIjx/aaSygWr0++Npcb
        c9j44csS4BgJFfdlR/fjRPPLGg==
X-Google-Smtp-Source: AGHT+IFPIcdi3YU4QH0WRzX5cow7BNQovSiBGe4ipKRLZtpdKnnMSnIkKUjU+kYaS1ZwHlP7i4J8Xg==
X-Received: by 2002:a05:6512:2192:b0:50b:e9df:b7d6 with SMTP id b18-20020a056512219200b0050be9dfb7d6mr4039069lft.72.1702577637523;
        Thu, 14 Dec 2023 10:13:57 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n11-20020a0565120acb00b0050be6038170sm1928838lfu.48.2023.12.14.10.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:13:57 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 14 Dec 2023 19:13:42 +0100
Subject: [PATCH 5/6] arm64: dts: qcom: sc8180x: Describe the GIC
 redistributor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-topic-sc8180_fixes-v1-5-421904863006@linaro.org>
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

The redistributor properties were absent in the initial submission,
add them.

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 98fc3ec881a3..a2287ce14fc5 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3425,6 +3425,8 @@ intc: interrupt-controller@17a00000 {
 			reg = <0x0 0x17a00000 0x0 0x10000>,	/* GICD */
 			      <0x0 0x17a60000 0x0 0x100000>;	/* GICR * 8 */
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0 0x20000>;
 		};
 
 		apss_shared: mailbox@17c00000 {

-- 
2.40.1

