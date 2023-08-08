Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB897743E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbjHHSLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjHHSKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:10:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57B71BAE3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:13:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bed101b70so846086766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691514783; x=1692119583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+614xtHjgD1nkm8xRBKqqyV2uZni5hqr1Y2F11sHVk=;
        b=Ve2TIQdKK/NdzaYfIuspk1xhzrl8T2ojwRfERXse1GT2fJPGHqKXI3eqJUyVKQ8zDa
         Z7PIuil4QlVAKiaW9vZ4dxv+CqqDKUKwErIemaLF8iaPH5RlgJsHx5G5g520IrgUY7Na
         p2i4cBf9PzfnpISRFk/gIMezsinWnoSWToIbh0cTo0yw7EwxAMNBIaDw70E1UkaD3cJi
         Z1EnwfyOiHdzD7tyM2Pr0G94TmhwHXtol7PczcTre5KtSKNxJj9H63GXSL0L/FdudXHf
         kSXNWvS506f6D29z/ElS5a+RWrsAfJZqFYtfV8e92xjJZ2wcSyoyZ3vjZUIxMOMH0Q8y
         3Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514783; x=1692119583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+614xtHjgD1nkm8xRBKqqyV2uZni5hqr1Y2F11sHVk=;
        b=eBkurp4o59twQrHRBYvfseKZ/G7i3WCwOhqG6y/d0Rc3KS/f2KkVh0ti8K1zPYo1BM
         Lg5sjg1voCvTXqESLW2zZqyUJ+SazAdeqdbDmwx8FvgykXFNFngj8nBGw7dgEwgVtd2X
         qXJG5HX5hFXkS8lCAxi1Cdy1gkQKEfeo/Mb8Xx+wI3ih5fei8sik2z8aeWuVO9fs1mIT
         egsesQAS6Z+2KhD2PHsxTD6Cv8rBU+TZRwpwipmdZhnwwdeF4HI5Gr9ehF/ocGVYiKyc
         SHFjt6eoazGfbqrx32Ru7dx9D+AUtmlYhSc2Tj0HHzMZWTC22Vuq+TR+o/JAQB6FWSkr
         2Mqg==
X-Gm-Message-State: AOJu0YzM6GKx3X8wget0btJwqwVsAtP/0v1xAgrcKR5Gn5KCIdiqZW18
        LwJivuinzPHMrtR85Cpfo4iypYf17uD33FrRuP0=
X-Google-Smtp-Source: AGHT+IFVMdcEkHvqjIMX5oEgG2oBE7nbsEMOVRk5VcpuTnRc1mcmt8mNUyLq7GYjCrQ3jyb2zmb5Gw==
X-Received: by 2002:a05:6512:e9b:b0:4fe:5680:db1f with SMTP id bi27-20020a0565120e9b00b004fe5680db1fmr7912704lfb.53.1691487891249;
        Tue, 08 Aug 2023 02:44:51 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id i6-20020a056512006600b004fdba93b92asm1818884lfo.252.2023.08.08.02.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:44:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 11:44:42 +0200
Subject: [PATCH v2 2/6] arm64: dts: qcom: msm8998: Add missing power domain
 to MMSS SMMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v2-2-34273e275c51@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691487885; l=854;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/yznmFUOFfvt3H81R22ABUv0eOeLe9LUwSr+QNKzGV0=;
 b=6ok/LWtlPH6zSyy5UMAq/t5bgWP3Ud7Ij9vBySuwjh3vMiS1gJVjxUKw6nLHyS95ARxX+LJAd
 Ibm+ib3FKxpBIIhASbXVDOfZYxEwn1cNsRmJHG+sQTEmtuUOfL5elUO
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

The MMSS SMMU has its own power domain. Attach it so that we can drop
the "keep it always-on" hack.

Fixes: 05ce21b54423 ("arm64: dts: qcom: msm8998: Configure the multimedia subsystem iommu")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index e40f6461f4fd..39db67211fae 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2770,6 +2770,8 @@ mmss_smmu: iommu@cd00000 {
 				<GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&mmcc BIMC_SMMU_GDSC>;
 		};
 
 		remoteproc_adsp: remoteproc@17300000 {

-- 
2.41.0

