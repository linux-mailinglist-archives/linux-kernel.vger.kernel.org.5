Return-Path: <linux-kernel+bounces-86732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2965C86C9CB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96851F2313E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925B11361BF;
	Thu, 29 Feb 2024 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvWp2SDG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CDF12C520
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212040; cv=none; b=tDnCiDCNlbsM+C6cXNRrDsoPp8Ribo4pjltz+/G90yqXnEjF1wFh4sqAUjTwz1ulAZhpJWpZ5gSakeGI0JRb4KBHrKpKcTyQ8gB0moed2gZKtXt9NsNeYcAoLt4dPAOwBHbFpYUYUo5s8Md4ftVcWj2GwIgmJqF6cCp9mMr7AgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212040; c=relaxed/simple;
	bh=MsxEEfnne02nqOkZki/+nigAQ0nhYoGqJj7vVZuWZn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VOBkN6AnIEQPAHrXMAoJU+wfAXa1Gmdi2EXeRkKbK1LBvepY6or8Ndk1AjfVJMuArqt2rJZGET7JBo8E/Tx5nBQ28zXjwqHfHJ5j+tpyI8dERyoSxo4I1mdf7ya4gl4XeJQ2699S12Qgt2oG2Hw+5vi5828xadeeUK4RcZgy7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CvWp2SDG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412bc3350d0so4770055e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709212037; x=1709816837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fywjC4h+f6+K3smJr1nJvUkccespMrFvMNirPgXOt7Q=;
        b=CvWp2SDG/zVNOZL8/UpiUGPJ3hKRQdG4lI8hKskWZj2JeGJQ9M/RgsdZyGJhvSfh/v
         kpeD5rZ2gPqQgSSZmdPeSVkHnYosQ6lTKwUsxi81PueCm6c0QsN8OHZnTpzAcM2K2jwq
         eWTH5DTvF72AGU7H9n7PgVXVZ3izbYF7zbGlLF3cpd6PQpo9dX7zagm6BBhqW4AQ1r6r
         oj8om+tUVrSI8OujgJ6NLyd9uqMi4ByePckuZYBew5LOrXTCgG9r4YWLKQghGb2M+dQw
         0IeEY1Dl3QAMB2DI0isVz9Ku9zVKVFAf4OOsNY99GNp+xeTalApgg68O7nylk0SEaNPO
         qPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709212037; x=1709816837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fywjC4h+f6+K3smJr1nJvUkccespMrFvMNirPgXOt7Q=;
        b=C3fxfLSjvjgAmBNg5WkoPTnWaFTnMFWcUnWE9ewCPN8hzMuzI6h1KQZ1gVmwYr+J8B
         m/oWe5bgcbABRo391a4wv6e3Odw1DHW5PAwa96tYuFACEpnOzHwsefwDj2TcEdGBxbUo
         MOosZL602oOwFvG5IZGfCYs+U3JLJkD8PfMt++W7ctqP/xvyzwDTDIXCypaa4y/kMjzc
         dVEegePlKJaD4a2zsJi/8TdT2nphrUFUMQBaH/abAWneqpLgjHL4yXfTnMJRLvzDlzni
         snn7s2d2NTE/Or4DyRESi1osG50ElKZLmuIa9JNBN/GL51VK1wYLKORvDvf8OjTFi8Y6
         eVGg==
X-Forwarded-Encrypted: i=1; AJvYcCWwJSNAi40KUbodWkzE3JFgb7gihDtSBz+m1e8f/yV7+sVKkLkMBNMSHCJj3NkEcxbNj3Z6IoJvfFgAFKLRUJtblkkR3NpVIBzah4ha
X-Gm-Message-State: AOJu0YzVEM/vShh3u/sqJuzeqQI/WD58ourYaqdJHrcUTgbmXG45+q1n
	9aOSTpqPSWCoMqnAPdrRXR2ITtjUJGSAMpUZoN/AGaSf0tu0qM24BIg37dXrMa8=
X-Google-Smtp-Source: AGHT+IF5SHeIBv4y7JFQoUnfwEl/nga/kneK6KmwsmHQJMRK9styGPFjelcmVyl29oT75A+1YByctw==
X-Received: by 2002:a05:600c:4fc6:b0:412:c1e0:e95c with SMTP id o6-20020a05600c4fc600b00412c1e0e95cmr550358wmq.12.1709212037288;
        Thu, 29 Feb 2024 05:07:17 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c198700b00412a38e732csm2071473wmq.35.2024.02.29.05.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 05:07:16 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 29 Feb 2024 14:07:07 +0100
Subject: [PATCH RFT 7/7] arm64: dts: qcom-mode-switch: allow 4 lanes for
 DisplayPort and enable QMP PHY mode-switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-7-07e24a231840@linaro.org>
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
In-Reply-To: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=MsxEEfnne02nqOkZki/+nigAQ0nhYoGqJj7vVZuWZn0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl4IF9MdD4p3qfj/k9iDx4mHLqSVCaj4RDbCJRWBM7
 p5FfNVGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZeCBfQAKCRB33NvayMhJ0QkJD/
 sElXkF1lTcwKxlvSHshNzoZANrB1IsApIQKCsylEXa3rV848swZ0XipoTQ+DlYBLwtQZlFbQuMLW+V
 lQBLxxZ1hRmjE8c8vBzqVPtWwsBDdkzli/VeDPA4/iV4qsZ8L0ZGXyv7QE/Rj4sCAORdCo0m63M+io
 rJ8MXfFUVeWcHhYizPLjjJ/4x6M4Hl3oe2hbCRjUS4h1rbz+rIA/4/sQ0fzzw4R0Fut3rIczCKetkL
 nWSwyzsAw9PLfa2Gr58/Y84zGs4/MoLq7hGxndGx6VK9VO56tHz68/O7QANPe91Bmm3dZ+9fN8T8P3
 YSFhK/ZaxXpvzPP8tNcvCzuhu6JiN/bal6NlNWqen6edtPsRFKgQP2Y56dsoExRw3vTi8OQWFjO81b
 jb6aSVR1rI/PTIDKVRPvG6oy12Ili+6haJwq/ZhKUQYd2JL4d5GFGxE5NcLXs7NEnpZq1coyblzbM1
 NbD8qCEzRPIyK/2mAa0UEiDmhURs56Yx9vNe9DWRL/Jxeyt6Hx5c5trKuzHNBmFJZxy5hZsiTCB6+m
 7kCy2PPviHgmk+mhTgTZrZPuvTrtonz96w0o3ZKL4vaMgIi8mfz2YSK4Oj6tsbZ5eO7URXeiPj0hte
 XDz+8cgf6uMz9YxJ2A9fxXwG41jlapzlRtdeabuWBo4mIWY2P0yk2b5GIXbA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the Controllers
and allow mode-switch events to the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index a0fdef55a40a..6c73e0fc001f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -556,7 +556,7 @@ &mdss0_dp0 {
 };
 
 &mdss0_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&usb_0_qmpphy_dp_in>;
 };
 
@@ -565,7 +565,7 @@ &mdss0_dp1 {
 };
 
 &mdss0_dp1_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&usb_1_qmpphy_dp_in>;
 };
 
@@ -1112,6 +1112,7 @@ &usb_0_qmpphy {
 	vdda-phy-supply = <&vreg_l9d>;
 	vdda-pll-supply = <&vreg_l4d>;
 
+	mode-switch;
 	orientation-switch;
 
 	status = "okay";
@@ -1149,6 +1150,7 @@ &usb_1_qmpphy {
 	vdda-phy-supply = <&vreg_l4b>;
 	vdda-pll-supply = <&vreg_l3b>;
 
+	mode-switch;
 	orientation-switch;
 
 	status = "okay";

-- 
2.34.1


