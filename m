Return-Path: <linux-kernel+bounces-153687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D125F8AD1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F238B23A13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1637B154427;
	Mon, 22 Apr 2024 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Igrxod99"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4223153811
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802595; cv=none; b=BoSm3lI4OdpF/EhDy4vnZqCH4VQqmJcdSSbfRoP40rTz3rnmkvPn4oB0OfVmXNiA5U895CwTa4EOCPlM/FN7vKpSLsTiXR5LTf0yRT5K/Tf46POUeijjMXl2cLyD4I73aPf2Ms+1RVlwVu/g610wzA81Mv8nDyCoVIDjG8cdGww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802595; c=relaxed/simple;
	bh=1bqm37cHBp77XacdQMnUI5xOez5SEa+Brh+86TcfY3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/m8mV/PZDsHe4APLYwKBMMqThGBuNsI1rMOBRsaZGEFovIvji/jgG1KNDjODRisMFNJr4Pp8zCv5zs2fCDTPeEdr9S1MfPaBJNKE6fIt5WE5LcX5MZF0a5QMG2OrT96mL1y+5vVS3A3J8GMM0rLhFUROQXoc4iu/+ilnthIc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Igrxod99; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a0979b999so11362475e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713802584; x=1714407384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbaftYc/ei4oHUBSrTKOEB6H45OgBK8ia0PvwI9H3VM=;
        b=Igrxod99UfQ70ME31cEfIJk3zaLvjBjaC9Ro8yZvCBDPDmHKY0zSGyRWXoD1IFTOtb
         W5aDaoLd4DRwzxS1/XsFQ9G2JPIJZKVRkuXazZ1o1e31FsCXZ7xRzyu8wAVsB91nkU8K
         gDl1aYHfi4zzysh9iiJa/LeaUrYshXc574+9eVdiMFfXlEkqeeQJ2+SZeGzpa5HEV4Hz
         7BriEakJKJ7yfRRQiCbrbm6Id99WdQrSWBpkX3R/ZO3lDpNVQKz3yknK9q60OPmQAyBV
         weJfPrHs4zNmFUGqdjb/D8Qf0HQnzK1IiJ7JsaujzKK6AFAadID8v+X8SoEK9clUacct
         ZwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713802584; x=1714407384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbaftYc/ei4oHUBSrTKOEB6H45OgBK8ia0PvwI9H3VM=;
        b=piCOCLrC9pAkV6SEu6gxrSbkNNdgOG9AqRdhfyCKCdN/S8UC+NLymtnY33MRlmv1kI
         4ujcl0fCaRk4mkURRUoDSUDln3HHh38EA+2gBKBafDYVVHvmxQ+sF9nHVMcWBWqmD7UN
         h+xY0BBiF5WbSgujpH8PyF6wKjhsZtBejjdB1TCYFB/DJqWcdXxw1fl3P+mZraoY99hc
         2jPCO0+swnhh/iq14ol76BuHUfSN+uFk9uaizVU9A/OCHAb4yljha3zr8tAaJiQSTq8q
         vy+gqwADy258CxE9jX7DkZtacxJRD8+Bccg35BjGIIa7Fh3muZYTs6g802GEKteyDWF7
         PQ2g==
X-Forwarded-Encrypted: i=1; AJvYcCXbs8bMy8Zf/kECud/t5t7WrA9u+lbkDpLgPP/njXZlfYt5Z4jQkjpGPY6TCWGWBO36gcLZvAA4NPPWZCcNyJEbjGClp5LTczSjGx2n
X-Gm-Message-State: AOJu0Yw7zcYDB0ALjKuLILXNq9dUoP3ofspPBpzvZTi/DTAIPiZrrXKY
	j2KD4nVPbgPrmXRJp5z4gxpDjHdAW3tE1aFnqfQDLTy8vv58ftFotR2aZLk0wE8=
X-Google-Smtp-Source: AGHT+IFtuRbB7/bsMHFBiRzVKO0N2/H4DC2fwitR9R+6Qndbhc6U5jg5aAj6yfHlfDcTrPds0p9osA==
X-Received: by 2002:a05:600c:354d:b0:41a:c92:d323 with SMTP id i13-20020a05600c354d00b0041a0c92d323mr4315677wmq.10.1713802583862;
        Mon, 22 Apr 2024 09:16:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000100c00b00349ceadededsm12463710wrx.16.2024.04.22.09.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:16:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 22 Apr 2024 18:16:18 +0200
Subject: [PATCH v4 1/3] arm64: dts: qcom: sm8450: remove pcie-1-phy-aux-clk
 and add pcie1_phy pcie1_phy_aux_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v4-1-868b15a17a45@linaro.org>
References: <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v4-0-868b15a17a45@linaro.org>
In-Reply-To: <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v4-0-868b15a17a45@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmJo1UjpLONI6SQLX+Etrq9QTUa1CvKcawV0W+TVTt
 GPpSoVCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZiaNVAAKCRB33NvayMhJ0XBDD/
 0TejuyODhFAqwnaXddK6COIB6YKsg41/lT08lAx38ZYgt4B1XhVFBj3c7X+2wkkz4WYcSSyg/h/CCi
 pwYBYcPmfWTC/5hJHw1P7WhNdKN+FpJGPz2XNNVozZKv5RXZQv5IqwNo5oxuz+n7SXoTHDXIf7UDfA
 D16TTPg9+FGXEK/e+DAuf9RPAQxDSlT+ZfkTsuK2CXFQvr6oFUZX6w4gJQ7phajn8e25a8FKeBlXpd
 eCizpX9iOSFcLd0zykGiqJj7vKjiKtBIwQ5N93hQbcJNMQvLDpDC1i668KqrSuuOuojG6SGVeJcCLU
 1WbBNgqtpv7K5bOmvn16rVvnfWMAdX8BQcWQ9/3N6BR+hFIXzuGKAYXxizZYZMtjNc3fsDAuEcqZIJ
 /VniMWKcpXRopV+dBuJYSAoT2jzrnU4UB6RQ5NDj1mH5Jr4tXbWYXre+lnND8CNai+7nWjTPdSyHV2
 S/u2bHc+rrte7dD3BnLufgsaHS240hoI1AL5HtbcelM9G0RPbRpI15TG4+6GJcYYkZI7/pz5+ShNKA
 UNTkW6nkPuZ8BadWtayoDwOQkdOWTX+iPU/wTuj18QwQX4MPb8GHehcCGP4nsWliabx293PIj1cXi4
 sWyzYLe5TeQkESuCDijH2eS638vz4H+ujMQYlaRRnYI+QGJISdkDzXqKc5qw==
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


