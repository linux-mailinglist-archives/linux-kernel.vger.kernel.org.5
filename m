Return-Path: <linux-kernel+bounces-3844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 140D38173D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B111F23DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008B4200A4;
	Mon, 18 Dec 2023 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdu15u9r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4361D14B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2358a75b69so198303866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702910318; x=1703515118; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T1aDtV/pShDyAWkmUyjEhMPgDCV55yLxt5gxRNXj18Y=;
        b=vdu15u9rD21O9hC0Rw44hMAgKeKvDsAsa7TR9aJYJ1oRpjuBLDk777yuLaHl/36era
         chyEf81w9H/BQ4CjMaPaI2D549x8LLHp2ayEAcooB1QKgmPMIZ8xi7uvOZCc3T6DalXN
         peCyTzAId3sp3EaWO+2TQN1JGl54fV1hBcxI6Ooq1hmtFxSSFIDTAopFcVXIMCkT5Fqs
         LNtrYP+mfyw0rTmGUhK55UV8HhwUdR1SPFCqk89Ld3AiaIu97VF7PG+XOlxP3dXcjnqQ
         VazdezdCZcqVAo/cW5OgyY7uExGL/Y+GeRWgqFP75S5stWFUvI0J7UMjGPhWBszSNrOz
         0brA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910318; x=1703515118;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1aDtV/pShDyAWkmUyjEhMPgDCV55yLxt5gxRNXj18Y=;
        b=mwNkorW+xtg4lTtDHTi345Tt+wyjroLVqMDnWOeeFIIzGoSNJC8dXuNK67RCiCWg62
         JQVqEviCREu/vmoY3lM8ATI6MHiCGukEooum3Q0S4jqeyCDHqul+5uybAAjrC6+A07Xl
         O2rDuaV2kaQgRoAgQiJYObF/6tzsPeVAWe2cbzRySra/TRADiZPv/1sCShmV2b+ArNwl
         uUyyDKNa7tb1556uJfQYjhvvWbMsw7cH+92+gvhbZToRH80F76Pn/ie6WNbfX2VHgMnp
         hra1RlUbf2odhgPUyozuvacDge2uoFJHzbqj5ITVvNd9TWJCgqnyQEh7sLFnjxVqjSpJ
         +1tg==
X-Gm-Message-State: AOJu0Yy2EAzNj7r3qWeCdJ0/8LSuhNlClFuIlm+eQ3l8FguSSDUc6n9y
	hFZ7/Pu2YaGYJSh9bfr807/y4w==
X-Google-Smtp-Source: AGHT+IGq2yjJwlHGUer2NhX/byRfpcZ7tQTsvKqTVWVwC0FWST5LtfwgdGv/BQTu7n+dzMK900AXRA==
X-Received: by 2002:a17:907:c08:b0:a1f:9842:5a4b with SMTP id ga8-20020a1709070c0800b00a1f98425a4bmr17423559ejc.66.1702910318177;
        Mon, 18 Dec 2023 06:38:38 -0800 (PST)
Received: from [10.167.154.1] (178235179137.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.137])
        by smtp.gmail.com with ESMTPSA id go32-20020a1709070da000b00a1ce98016besm14141718ejc.224.2023.12.18.06.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:38:37 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 18 Dec 2023 15:38:33 +0100
Subject: [PATCH] arm64: dts: qcom: sc7280: Mark SDHCI hosts as
 cache-coherent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-7280_dmac_sdhci-v1-1-97af7efd64a1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGhZgGUC/x2N0QrCMAwAf2Xk2UDbKZ3+isjI0mgDsxuNijD27
 xYf7+C4DUyqisGl26DKR02X0sAfOuBM5SGoqTEEF3of/ICvZVXGGAY3pifxaCmzYk+OopziUc4
 CrZ3IBKdKhXOry3uem1yr3PX7n11v+/4DogKiynwAAAA=
To: cros-qcom-dts-watchers@chromium.org, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <swboyd@chromium.org>, 
 Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702910316; l=1106;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FIyohTj/QMEcc9QxeFddK2gL9Q6S2as+uH4t0LwM+RA=;
 b=hkEcmF1nVbZohzlbX29PA4k3BMQqBWCvLL+KcGEPwO2aH7wu0TgZHabijsYUmY6v6G7e6N9+1
 VtxxEF7kqzaBmDsDORaILASsTSq9eYKVvuL7vRtQYsajFCAxaIi6Wc0
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The SDHCI hosts on SC7280 are cache-coherent, just like on most fairly
recent Qualcomm SoCs. Mark them as such.

Fixes: 298c81a7d44f ("arm64: dts: qcom: sc7280: Add nodes for eMMC and SD card")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index ff1e07171dc4..83b5b76ba179 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1000,6 +1000,7 @@ sdhc_1: mmc@7c4000 {
 
 			bus-width = <8>;
 			supports-cqe;
+			dma-coherent;
 
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
@@ -3458,6 +3459,7 @@ sdhc_2: mmc@8804000 {
 			operating-points-v2 = <&sdhc2_opp_table>;
 
 			bus-width = <4>;
+			dma-coherent;
 
 			qcom,dll-config = <0x0007642c>;
 

---
base-commit: ceb2fe0d438644e1de06b9a6468a1fb8e2199c70
change-id: 20231218-topic-7280_dmac_sdhci-3a0a7e574e9e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


