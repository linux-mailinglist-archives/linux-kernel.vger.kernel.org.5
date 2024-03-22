Return-Path: <linux-kernel+bounces-111237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC988698A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C301F22B98
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FC83DBBE;
	Fri, 22 Mar 2024 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxO0ke2M"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36E2C18D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100573; cv=none; b=BLXQW7ewvz/+K+RwK70pLKxrsqfdpH2LAt248KF+voU/LkxPzctOuPjgf8KM7kQWoJwoadz7ZCLFbLiD4+EXw6s6vA6E+cGYXhMYU2El/dyEf5xjazMmwQ2PPzF7HPF8+MfldZTjIgjZMruDy99Wof7VcsZHbYAulnucGjzrqj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100573; c=relaxed/simple;
	bh=AAacFwAsEP617vZeav2SflN/fi/qz19efJB6LuW989g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FE5qbQycWcq8sI2HV6xqv1tw7/SO+GoQhiABh0P5Gm+S818mRB2DieFEJPH8XCpq6LutYbUlEvHReYsWkvzQzUYRx7G5I1o0Nrh4KlCgDiwnUg01UlOlWJiI7qWoP0k1ib57CoE7KZMu+oGpPvp77hqW3TWlH8U+tR8gIjyZ1Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uxO0ke2M; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so28245161fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711100569; x=1711705369; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6jwgd2Axk9fB0Aki1YRcqjY/e9Dl6tqP0b8TVLuwoY=;
        b=uxO0ke2MtbkDG3yjeWcXjIwIkSVd5pD5mHajIR+gB7uUGY6PKGY8OqYr4hr4Ta3U/A
         JflEAfN9TWvkIwy364BuRAb/42sPoQQUZIt3KbW6kF3mysSK52oP2xYHMNxqs5xKAC2N
         5uMqNCj89DfahpEQlxyb1Uravd+8vUVul4QaV62n0kOHYCh/wCcNY8or5wZwIrZp2J0Y
         U2Gch7/5Q8fftXWOpTjGcFdVXt7agU47iC9KwjSDtHGIH+xPPgfeEUHrLW1dyqngulMG
         cSix+kGAEERzjsiQ9WQYtYB7Nk2t3DxH6oLg+0hpcLxVNhfYwIhsAOTWvZUAt6gHs4/J
         eH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711100569; x=1711705369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6jwgd2Axk9fB0Aki1YRcqjY/e9Dl6tqP0b8TVLuwoY=;
        b=tA1K79czuXZKGmdFXLzKNXRO1/NmZLS7hSWBTiS+w04U6IrU2Sap6pHzcVqydFKir2
         +oxG3OZpR5N045xg5G/hDzx7kRhEmepNF2ElGF/wBbehQs3rK7nEhxY7YwN8d1Nvea8S
         5e0BY0NsJDjB/pHA51fzoSqt9OAA/7/+ta728Gzi933+8tlf6wITkF1blvu63cwBiLjE
         sSXrQ5QhP23fbjZLSoTIg+DWV4+PbtlnGuhwBcp1Tcv+7X6wWINKOY/vGnSdgnDpp5/n
         yzeOFOsDlr9OH5xLcmhs3LTldYvT0tSZHC77yu7EUgBf9lr/C4muX7nXAmE/qaYBh34p
         voXg==
X-Forwarded-Encrypted: i=1; AJvYcCVDVQ0P78jhNHh2iX79ZxY4cfjugu3zJ8mjuBKI6rf0TlbcHibScurx5FUgelgNBVV9iKizDCNscI2PyG0aJ9/kZeb/OXdSQN6DcTS5
X-Gm-Message-State: AOJu0Yw0lY7UfM6RuWkHIlECUevyZyWWy/Gssx6RDugllyP+QnoXs0nY
	WRvUHVqXNZpMx9NCxQCOke26Z5WDPNjztLXCWdpSQUym+qYIkeiJjK8lPGEeW3k=
X-Google-Smtp-Source: AGHT+IFKbMC1s6wqqPUhJW/7GMB8Y7THK880B/b6bjhNmzH93s3LvP0Ub+ycCPoHRdbPHtzxiFVKtg==
X-Received: by 2002:a2e:9b90:0:b0:2d3:aecf:4c32 with SMTP id z16-20020a2e9b90000000b002d3aecf4c32mr1295935lji.41.1711100569287;
        Fri, 22 Mar 2024 02:42:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b0041461a922c2sm2547845wmq.5.2024.03.22.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:42:48 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Mar 2024 10:42:42 +0100
Subject: [PATCH v2 5/7] arm64: dts: qcom: sm8450: remove pcie-1-phy-aux-clk
 and add pcie1_phy pcie1_phy_aux_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-5-3ec0a966d52f@linaro.org>
References: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
In-Reply-To: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=AAacFwAsEP617vZeav2SflN/fi/qz19efJB6LuW989g=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl/VKSvg7Tvnjp3QY9GSz61hPxi7sEpbaE5DYgzELK
 OhP+/8uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZf1SkgAKCRB33NvayMhJ0URLEA
 CE+/A3kTJC+heZj8hKqmqzp0kpMNxTtOyNuBoV3WwN0siHNKDIN7Eg6nVZCJ4QP7lFI5x21rh06d3z
 Z9vXQrH7DBL1aZTkBdt1HDO2scC+V1gdE1hubNfwFf0xYiJb/L2hXxDokEX6ucKhwbq/UvlBp2WldW
 rkvYUGdBRdBDP32xrpPZ1qZNh+iJNnWFNywd5AFz5r2pwEPycW99Kj05zjT9t06TCOGjyTuaPY4WHl
 Z+FMx8K7hcU19zKWTsJM878uAcCvDENdVRx6WaAbUXFKVHGojzZEl08otuP1eXkUzZcBbKosn7BT8q
 of/m7LwFR1wyDQL4YOhiGAc3un3g7xZfr/V/EiTXeS/lLsqkmsKE3tRVgyRl6FrbYcPyEJ1RJBZZYY
 bJXskGyQal6BznNL2ca7XvDhgdn0NjnHyhFUdYxS4vkccGCpdRFMNPkI/95Z7RkMeGmUJxMyhLu7PH
 pnyLh7jTv5NtUv4ktE96Y47zfM0zrFjntKZiCTmzgpiwyj8xr6Eg7YKrvv29qvHlHfD5HRGIP1TbVc
 SRlayhQqj/4jsStJiBYeR/y7PcjOgAcfmZQXCPjDJtEr/aUZH2BrCpfM6n25qH1YRkf1ZhteVCN3zQ
 RKruGREzYYmM046dRLFs9Q6LqWAfgQdhddZM6dEP/HJ8kQV70uddSYDyaUIQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Remove the dummy pcie-1-phy-aux-clk clock and replace with the pcie1_phy
provided QMP_PCIE_PHY_AUX_CLK.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index b86be34a912b..32361af98936 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -754,8 +754,8 @@ gcc: clock-controller@100000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&sleep_clk>,
 				 <&pcie0_phy>,
-				 <&pcie1_phy>,
-				 <0>,
+				 <&pcie1_phy QMP_PCIE_PIPE_CLK>,
+				 <&pcie1_phy QMP_PCIE_PHY_AUX_CLK>,
 				 <&ufs_mem_phy 0>,
 				 <&ufs_mem_phy 1>,
 				 <&ufs_mem_phy 2>,
@@ -1988,8 +1988,8 @@ pcie1_phy: phy@1c0e000 {
 				      "rchng",
 				      "pipe";
 
-			clock-output-names = "pcie_1_pipe_clk";
-			#clock-cells = <0>;
+			clock-output-names = "pcie_1_pipe_clk", "pcie_1_phy_aux_clk";
+			#clock-cells = <1>;
 
 			#phy-cells = <0>;
 

-- 
2.34.1


