Return-Path: <linux-kernel+bounces-3529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F8B816D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7630B1F23C86
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5334B15A;
	Mon, 18 Dec 2023 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXAzGQ5E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291394B5C3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3ad3ad517so2509925ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702901263; x=1703506063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lYTGtSYRVAJ3w0j3YsinoBhP2NVVpIT5xX2iQPFdpw=;
        b=xXAzGQ5EbKNX/Dy3L2mw797oLF8fBLW2fzRsHPP+qd/K8tdTvi3D+QnCFuo7BkTlTN
         JLNdi/9mtIMDll76NRk1tgnsNSLX/Kaboe49Ialaav0lpPG8xzLWngSQ0KKxTuziLVlC
         UkcwHxtKwucRYAUBtipfsRM5PpuoP/5Gik8K3c5p19atSF7ScE/lQp8qLu6nw4zf6X8V
         uykFqnSpyOFk4QvaUpfC1rsPEMx2Mr52Yb2ACFAd9JF8qJzR8ReqquM4RIS5cHQkVE6g
         PB6V23hGMvjsuuid9I0Kp5vjoNvTVXCA7YUfRwd2jFBDGqU1CZ5HLnQd+0vWrJhA7hdz
         FlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702901263; x=1703506063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lYTGtSYRVAJ3w0j3YsinoBhP2NVVpIT5xX2iQPFdpw=;
        b=si9PhV48zujeJDImfb1KlnGYBeNwwXCvbuPHuU7YaHoWW2h7tnxh0iXXIxfwjHxIoZ
         eh1DvQ+Rn88k6wEcXwZdk5U+kQe6QCCE/JwTNzXl1XRswrAmE/oVK30eBNfRwsHLlzdG
         yLuTRieW0wBTy06rpws5ZJ2Akk1sX3vvKQFcW03nBEk+LpAtRqMuxLp6zqTwNYwkKUvf
         OYjhhvJqTe2qujQ5y/h8hc/ccFyZJ4NJkD1RZh/DQF5OyHRj6k6xNPIh09ARSIipViHl
         UsosIRMg6deZW/uT/gfC6wXc2c3+sHxE068wNzIzgq8Su9mztr8OVHJw5+2Vwjt8Ixsz
         NDVQ==
X-Gm-Message-State: AOJu0Ywei2OckbUV5VnpRKmnSN36mIpqw7OoCjsZYjwWV9x0aBnfmP64
	kGSmNWF/caia8GDq/rtrRx2N
X-Google-Smtp-Source: AGHT+IFchFcItXdYBMDjNrlYDL5eL8NpYrejRm/1PBJqhUeZQOSSH05NdaFx3MvPVMg5AHAMkiQ1PQ==
X-Received: by 2002:a17:903:32c7:b0:1d3:6110:32fd with SMTP id i7-20020a17090332c700b001d3611032fdmr4820556plr.110.1702901263463;
        Mon, 18 Dec 2023 04:07:43 -0800 (PST)
Received: from localhost.localdomain ([117.207.27.21])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902c3d200b001d368c778dasm1285709plj.235.2023.12.18.04.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 04:07:43 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	vkoul@kernel.org,
	sboyd@kernel.org,
	mturquette@baylibre.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	quic_cang@quicinc.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 03/16] dt-bindings: clock: qcom: Add missing UFS QREF clocks
Date: Mon, 18 Dec 2023 17:36:59 +0530
Message-Id: <20231218120712.16438-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218120712.16438-1-manivannan.sadhasivam@linaro.org>
References: <20231218120712.16438-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing QREF clocks for UFS MEM and UFS CARD controllers.

Fixes: 0fadcdfdcf57 ("dt-bindings: clock: Add SC8180x GCC binding")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 include/dt-bindings/clock/qcom,gcc-sc8180x.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-sc8180x.h b/include/dt-bindings/clock/qcom,gcc-sc8180x.h
index e893415ae13d..90c6e021a035 100644
--- a/include/dt-bindings/clock/qcom,gcc-sc8180x.h
+++ b/include/dt-bindings/clock/qcom,gcc-sc8180x.h
@@ -246,6 +246,8 @@
 #define GCC_PCIE_3_CLKREF_CLK					236
 #define GCC_USB3_PRIM_CLKREF_CLK				237
 #define GCC_USB3_SEC_CLKREF_CLK					238
+#define GCC_UFS_MEM_CLKREF_EN					239
+#define GCC_UFS_CARD_CLKREF_EN					240
 
 #define GCC_EMAC_BCR						0
 #define GCC_GPU_BCR						1
-- 
2.25.1


