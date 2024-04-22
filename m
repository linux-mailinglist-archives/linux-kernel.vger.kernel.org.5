Return-Path: <linux-kernel+bounces-152983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF98F8AC713
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 450B0B215DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D407B51C52;
	Mon, 22 Apr 2024 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wfu7hjzv"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E64481C2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774800; cv=none; b=iVDhFeZRHqdV1JhhfXW6E903kPPCb0yYhDfSWQmzZPf3wzYWFDU8vjmV/WGPglwMCQEzaiOFGkf/q5JLbkYO1Xt+s36MZ6xRBBX/qoEg/lpq4LTcYBiIWI5fHJ91cMyM69VMqMeI96xGT1tL4J7ieSy2FWHj0px587RPzuu1IcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774800; c=relaxed/simple;
	bh=1bqm37cHBp77XacdQMnUI5xOez5SEa+Brh+86TcfY3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UD783UNaXFOTwsqQU7oqxQAUpJFAXKHuNkNpSZlnConVw9piFVa+nZiR4FhMe5h3Qbi+WMAQxMTL8Flx083Ioh/6hf18+a8aKmF0UrQk7vsWM6ZqiCwT2c8imw/ml0ftW+Z1oD+6H2UczgAzaTZ5LUr+hQjCWSOBMMwmFwRYF/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wfu7hjzv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a0979b9aeso8804145e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713774796; x=1714379596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbaftYc/ei4oHUBSrTKOEB6H45OgBK8ia0PvwI9H3VM=;
        b=Wfu7hjzvwJ8ncJbK6t+XkaiKI6Ud9a3SPi8kiCROo5yVNK4+kH32uS9VCW+PY8AQ+C
         D/7+UddUoePs4f5lLVJfTFbkxXFxeZg0zLypZD2UTOOVMtVsdnnR2VDGSE2iYGPdq73N
         AX/b0oKkQiSbyzX3uzjSDbyeD11joR5YkpSa0o55Q+LGbC1stLRu7eQgaGVb5xsfJloc
         J6to9DLmpoA8HUdNyGpJN5SLpnUK3mbumw0yNwQoN59+iUClNjjnSNgutJuvayRIuG2n
         Ael1fYI4G1I7GQinaxikP3tKWc9Rg8uVR7dj1+mzUOqz145nb8uL1TBH7BzanlqfHl7D
         3UdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713774796; x=1714379596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbaftYc/ei4oHUBSrTKOEB6H45OgBK8ia0PvwI9H3VM=;
        b=eAYHE1EgldE3A2eK5x7ahLdhXDt6Rg8e2gJpOOlOFdhadYgkDJtDCmXgGrV2OBJ0TM
         GHTR4a/49zeEttOLksAc/3J/PJ6t/SE1G6WNcCGXXkYxjHZ5Q1p3xa/VahwktXAuTKov
         SfXuGYQvqi5d3FqkXtoGCeUfR58qBYEEMhxQ48nzYxvJtklbQSJDaxAYGIjcxBOoZ083
         r9m8KeWYclBkmEwlsSjmIHie9lg5nPyhBgD/C8Ut8h/jR1ZJ7QorOmQdeEIwWR4VSLfx
         MMiC2mOWl9gFbnKD2einqNFhTGfeY31wAVdAty9QL/H28CQ5SoPVORsMirWxwwg+Nytk
         CrlA==
X-Forwarded-Encrypted: i=1; AJvYcCVqgj8kOJNMzXivaxgQTFrDGzLaKH4oNqWwa/+aHv4tH5Z7Qo1/cdAquYnmkS5nnBTzBs2fDXJD8MwE8ihLvPvBJAJWLMF0bBtL3AMn
X-Gm-Message-State: AOJu0YwbwfQT9cxM7gOi38+sBhHUJddJdNZi/uLcXUT4Qc5VdGN5eKVj
	doxru5E7X0NoiJAEg2dJeZsHCr9CA1s+1s+tX1Jl3nt3qXVlOwQoKqodcqB43kl1UtBqxPk4/3w
	14RcvAw==
X-Google-Smtp-Source: AGHT+IFicJC7O9U8o8rAx4zgXVTbsVkwjy+Gj1FuHZ9l8m1zL6WLESNfZCg+Bhih6Vkw9yAbP5NU8g==
X-Received: by 2002:a05:600c:19c6:b0:418:ec7a:4493 with SMTP id u6-20020a05600c19c600b00418ec7a4493mr8915365wmq.12.1713774795471;
        Mon, 22 Apr 2024 01:33:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b004161bffa48csm15978786wms.40.2024.04.22.01.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:33:15 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 22 Apr 2024 10:33:11 +0200
Subject: [PATCH v3 1/3] arm64: dts: qcom: sm8450: remove pcie-1-phy-aux-clk
 and add pcie1_phy pcie1_phy_aux_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v3-1-799475a27cce@linaro.org>
References: <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v3-0-799475a27cce@linaro.org>
In-Reply-To: <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v3-0-799475a27cce@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1bqm37cHBp77XacdQMnUI5xOez5SEa+Brh+86TcfY3k=;
 b=owEBbAKT/ZANAwAKAXfc29rIyEnRAcsmYgBmJiDI6pxVr0gA/n+E41e6tENZ2BTnQpZZk0QoVMZe
 ZjN5DHCJAjIEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZiYgyAAKCRB33NvayMhJ0UsFD/
 dXgjhQb2AfQt7uk4tf71uWR5pq4c4HxdkCK+T30MKoFhN40JukvMNWTm2Lo8HrG+eCQ3lvabXVPli4
 2YFizwjobRbZc1yQ5zikDLllpW0YFlc7Uq1Ng6N6neQl9ibqZYnk5S2EqaOPSzup10SOznaDAfFNlt
 R8KRdBPgbULrpUNi5BPHRs2SKPhXY8Qsu+znuW24+zCNu5/Bax2PIjXQyS2OqPauw6+Z8lMu2bTgM0
 hpXwnLQ6R42uzPbictmvD1kzY2MEYxScvb62DrdW8yKyjBpXet0GOZ5o12lvKmp0THX2HM8bKDc7EV
 M0WXrB/pxYMuBvWRxgElS/EFxbbJb+1/+BJxRATX3c23DjiDGb4bi8ZV+n7jsQU3Ia8r12p89NH0Ka
 kvcsq2MDJXQAQ1hOQTR/hbQJGjw/GXfTqvkfsCeNVqq3Jzp2suRwRKiOg5BaGEciCqZSgI8jJwD0mg
 SDX6ifm9jqyu8ji97Bl/+Ug7JmlDVP+D93tPbbWpTPRRT2ff1vogKnt9GBQzPxOls6gUIgfryGiULl
 ix3gHppYOZjrSpjMMhbuM1JwY7NyZG9dH0JnPM3aq2R7psmoKOiXyUWTcdio7IVa3TeoOdaSz2LUnK
 r3KQVDFaE1DeCnIYn8jU9EULmiSaGJuO7eHfI7dhAcvzxCtURp5zagHZvQ
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
index 616461fcbab9..71797f337d19 100644
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
@@ -2000,8 +2000,8 @@ pcie1_phy: phy@1c0e000 {
 				      "rchng",
 				      "pipe";
 
-			clock-output-names = "pcie_1_pipe_clk";
-			#clock-cells = <0>;
+			clock-output-names = "pcie_1_pipe_clk", "pcie_1_phy_aux_clk";
+			#clock-cells = <1>;
 
 			#phy-cells = <0>;
 

-- 
2.34.1


