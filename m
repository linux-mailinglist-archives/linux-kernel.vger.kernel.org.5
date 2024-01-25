Return-Path: <linux-kernel+bounces-39321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B6E83CEBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A8A1C23E60
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B1E13B783;
	Thu, 25 Jan 2024 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="xP0S2Ujr"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D995B1E8;
	Thu, 25 Jan 2024 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218541; cv=none; b=PnKVJHIJOlC4Ejsuyl5YUhUuJjk8KOAshiH3RZImghwGmNDFH9TvUGiXMKJ2KQh2CmKgpJtdRCROUdqaMDTRg24ACQWzoTUGOi71JCgNRzkTuy7OuuEvI7Pafqe3GBIwTf4MKFguLnXGzxFKhnPwscmUB/PNPOl625Ku9FFCTc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218541; c=relaxed/simple;
	bh=xh9qon9uSb2P4Lif5swmXLPlXmBT6MHyg+9ChYhCDvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c2g4iPOBxFj4q6tA1rVbjnAfBCp2J3tP9oG15IizML4rh1pYuGHgoX19t45URInvxr+QDVkZLENNz2IR0KhXmfuDCRxYYc1mIoN2w2K0gb3czQE9zhVGGCAJ7yRltQ3lG8DHR19V7Bkt+S24DQDnF1fEcCKLOozZFgPI5pqfUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=xP0S2Ujr; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1706218538; bh=xh9qon9uSb2P4Lif5swmXLPlXmBT6MHyg+9ChYhCDvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=xP0S2UjrPUwkmvw6sUjkJaNfZcJ31AnIrK4GUa/KSNjx5U2T4OFoOUY1tUKxWOnjt
	 RvdJC4afSF6wrG2xPIEYzRI93rlvfdyPW1uiRLODGPf+pqhYHWIpHwWgJsr5GZvsVx
	 ELvPdgrpgs3AvhRWOFvMpDGn1Ua9Ndejov6HeaVg=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Thu, 25 Jan 2024 22:35:12 +0100
Subject: [PATCH v2 1/3] dt-bindings: clock: gcc-msm8953: add more resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-msm8953-mdss-reset-v2-1-fd7824559426@z3ntu.xyz>
References: <20240125-msm8953-mdss-reset-v2-0-fd7824559426@z3ntu.xyz>
In-Reply-To: <20240125-msm8953-mdss-reset-v2-0-fd7824559426@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>, Vladimir Lypak <vladimir.lypak@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=LRUAlEGpm7vwiiZudwOrNyuxrWuDT7lijZ3surPmQl4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlstQmXrmcDVSdaQOgOy02TRqd5MrT02SsRltmt
 Qq2fJMCe1OJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZbLUJgAKCRBy2EO4nU3X
 VuzTEADayMZEyalP4CoUzhuIvH3OkGc57bjnSsTsGwGnlv6PMuVGYLJC3mZNHpHv+62XMkImiKf
 1jDg42irzsgnU7djdJAvHF56t1CiVghART1jmZEMKPE8TuPzjsh1JjbvFL2nGZhb9r1vdNn0iR7
 lLhbSOgOw7LcsYxu9mUGVynrHEHzy5lkNCyK+dg15UUgjPYAB8Jdnj/6waHSK4CVTHXpw+bzUVM
 4cCKb3UG/zGvMaRvecWJDBQsf6QUFzsejEHvKXg+V7YJK5slV7o2Bsv68KdZgwatM9LQbKk4msw
 sHclg0Q+t/GIIJED2KjFYo9VPt5eEE3hd7RJ1XYkGi+FSGGfho7XoOkAT5x0QNvu9Gzd+X9wsWs
 FGRaNhyJ5yx5j3npf8B7CFxP9gjgT3WNfMOkcvJk09FV8fwYXta1NbBIpfz1JdepRnHhKtv+VAb
 tDkZJ54cf9n3KG9sOHp740g9nFg9bTUPtC7FdX0cPCIkl31I0Dq+oHvXUQCNK09pBk3JW4oh6DT
 bV4p3X7SMR4p8qSNBML9dhxp7mo+eBx+fp3uhGbg34fzZYnDM2fQU0Ylk2kSfZHFY8cmwW+O4au
 QKnmYVhO00onAhS1XGjsOsZiQk+oaJIYj5W2dv+cUDCSaIfiUPn3UVXcncdL+UwiHh8WXLrpTNG
 UgIlDgLCcJRsgSQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Add new defines for some more BCRs found on MSM8953.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
[luca: expand commit message, add more resets]
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 include/dt-bindings/clock/qcom,gcc-msm8953.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-msm8953.h b/include/dt-bindings/clock/qcom,gcc-msm8953.h
index 783162da6148..13b4a62877e5 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8953.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8953.h
@@ -218,6 +218,10 @@
 #define GCC_USB3PHY_PHY_BCR			3
 #define GCC_USB3_PHY_BCR			4
 #define GCC_USB_30_BCR				5
+#define GCC_MDSS_BCR				6
+#define GCC_CRYPTO_BCR				7
+#define GCC_SDCC1_BCR				8
+#define GCC_SDCC2_BCR				9
 
 /* GDSCs */
 #define CPP_GDSC				0

-- 
2.43.0


