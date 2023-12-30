Return-Path: <linux-kernel+bounces-13431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0129820684
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670851F219DC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A1F156EA;
	Sat, 30 Dec 2023 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KxxCvqrH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D1A14F72
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5532b45c286so8639425a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 05:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703941482; x=1704546282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIS8BVV6xMe2SYH6GmTY+cChP0QmWaX59VMotnHi2Jo=;
        b=KxxCvqrHO4/drNDWV4CWPSqHhtYeJl7olP7tsF7CbEKRTnjIO8lyNkcLfM0gXE57WT
         CrkojEuPivqn4ew6NUXELnN8LYVmr+gKT45Cl+HaccChdK/+4ZH4JY1cB0IBQ8qI74q6
         H1WP8VhPXAfQif4qweJZOY6x4lN6L4NqrMyT8jd1GIKNqyfnx3sbenioCGj6do/7d45J
         /3OZo1cWVa7xDXCBUgu3r+sicHuilBThIlLjE/5Nwo7ZN426XemAxaFJoqeDaHwfOWD3
         sdgdTxHyYsRLK53BrNsFBJnzQIkWUwqFfoRJDeEXuti8LB2I7mgc5dXjPCIWJaDzIoE4
         /QqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703941482; x=1704546282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIS8BVV6xMe2SYH6GmTY+cChP0QmWaX59VMotnHi2Jo=;
        b=iUb3VUa9l8ckBfSN6rzrsW6kk0mjtKAuLz3an3GVphhdDQRr91DDrw4KCqyPK6XJE3
         NUSL9Vts0mPz3DQIPtVkUgWscW3TO2tSEK1cxH0qzmHPSaPb1GJM8z9KVfU3Tbprn0ux
         cdfKRsKKcr3qQIJ/ou0oghyjSSnvk7FH1G5g0lMi885pEiwNMZZI4uBc93rxehbjOyp2
         TgPr4O/uO5yc72V2V3upZCG5xbbi2LBIo7JuByEEPHK5EI+b9b7zFKU6h10D5t1GuBjq
         0WhHutPWt5v6voMuzRLjT22MSSAaEGdSyg8bEsQ2fmdRUcrm/LM7vqsMs79gBE6NeHhk
         KqmA==
X-Gm-Message-State: AOJu0YwxmvPKRlTsruIV8UZm39KqsRhEqg3hg8BoHrFY/xuUTXiERpk9
	jv1mCdbLPtPLpmeC22rzhNSeY1u7EKeepr1k+lWJwdr7C0g=
X-Google-Smtp-Source: AGHT+IGVcURXqxidAdIs2dZlk4wni3bZ/v5fZi21exN0qfgk4ncWS12LCpGSLe9ozHmNAspQ8oQLkw==
X-Received: by 2002:a50:8a92:0:b0:54c:4fec:e3 with SMTP id j18-20020a508a92000000b0054c4fec00e3mr5855215edj.114.1703941482766;
        Sat, 30 Dec 2023 05:04:42 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id ij14-20020a056402158e00b00554368c9ce8sm11359578edb.1.2023.12.30.05.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 05:04:42 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 30 Dec 2023 14:04:12 +0100
Subject: [PATCH v4 10/12] arm64: dts: qcom: qcm2290: Add VDD_CX to GCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v4-10-32c293ded915@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703941465; l=764;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HEE3DdJ4zQzS/Foajh/2RBi9l8ssp2UwDgoH6XqPOSE=;
 b=9J3qXflG8Scq/7kdhRwm8M6cjo138i21rmtDQKUhjTi2dwX/DXp8Ms6kCDV5ud/j6x16z/vMC
 cQ19VkWCoBECAMWq+OQoZ0en5K843K+Zo6HeRwZ6hBWsgYPToaaIvu/
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The GCC block is mainly powered by VDD_CX. Describe that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 0911fb08ed63..51b05019ee25 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -647,6 +647,7 @@ gcc: clock-controller@1400000 {
 			reg = <0x0 0x01400000 0x0 0x1f0000>;
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&sleep_clk>;
 			clock-names = "bi_tcxo", "sleep_clk";
+			power-domains = <&rpmpd QCM2290_VDDCX>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.43.0


