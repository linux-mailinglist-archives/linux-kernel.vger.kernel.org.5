Return-Path: <linux-kernel+bounces-165562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 145368B8E05
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BAC282C96
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FE2131E2E;
	Wed,  1 May 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxGjyRLH"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA75C12FF8F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580392; cv=none; b=DAxLmXqzcVoY/FAzoM6MvRQTgBpeQ+icocQdya6A/TXKnfZTc+6tyhcxNImFLbHiWsuZXFlEvYDhnKBhJH9NVeyeHD0Qp7bYxU7rBs4hB6TYSfaoQR+YU5qEZC2S9FlKx8x4scTF7j0tOaf7uJE/N7cPAmIwL7jHClmFt94GU/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580392; c=relaxed/simple;
	bh=naWFrW0qlpkbnfyMNz6lkTT4Kg5gQ1w71bgFqDbRi3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iQh2vOdiSNhzyoIo6b/pmb0GGMNPep+89yM1ZBU441BRsF8kZtBOQkQfkXb9YCOdszTWJXlTQPPdS/T0/xgs0RcUUWt+1WUUP5OwiaWvLX50EbUnNCmhzPALzJAyzf2hNVlaS+ulOa2Uk4/aPAG5qQ38bQy5v4MI1Z7l5q80YoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GxGjyRLH; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-518931f8d23so7102485e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714580389; x=1715185189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlBgmHn/PpDtQuONndN96choDJkuX35LPpUAOc/PmjE=;
        b=GxGjyRLHcDAZIkTBzK3wXaDcPdcYty/+Ah/K1XFYmnAX1IyGk2WVFya+b57G0NTynE
         Pkq5orai+/qNC0GV2JKvAXFGy29olEf3eqBUATo+UcZQZ3RQdgemVhRKDKt2uj0+8/0q
         n7pVCd1VAgW6Yt2jk/vfDeHJI3hFVQA3tmzWiptSAW43eTWDemJZgjhZzBxY1oldxeHL
         P+BJJpGlJDUqKyzGAwPBjqBkty2aF6X2Wa6PkXVFB5qCBvCdQNrQyk4MZfwcth9eLJz3
         7kEf6Cj/Yq8C+J2kQxCRB1STRiQwJXBbSNjPgf0nR6rDva0yuXbZtA/PsAF0nZwDRIYP
         VZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580389; x=1715185189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlBgmHn/PpDtQuONndN96choDJkuX35LPpUAOc/PmjE=;
        b=kqeFOddL374hwkwVnETKpiGHC0cSX0FKgHpkeg25ZtFzCDXxEFkpLF6lvQku1vjAUP
         wwNPAKgIMTj7ssfeoQ+pLf6zjGyt1PUx2N935Xjs5TjzZ7N52W/qrCmSkvQNto/6oAdk
         14DdjrxSafciNEfT38j8GOBBwHvkIPG0IS90V4AjQUvn/TiG0Yb8/WoHo2zz5HrLXco0
         iJFSlELQk9iGuVbmMpSxx6gy8Doviqe6e9om9gYMRq2pAwoBUoEJ58ksch+m/Ss1M3Ky
         FydsOhdFzZZfhT7cahCjEUonHRjWVILNJNu+aJ3nOdQ6MCQwbGt5737QZm5cilo3RLPL
         YO7g==
X-Forwarded-Encrypted: i=1; AJvYcCUsejCvhPZZTCXqQOYkTjGvfofEuYc4Sl+z++UdxZN5fsrLnGxhu8uhIKb+CO18B52r3ItY5YaU1jZwBJApXSpgxGTB8L4q/EonZ0Fb
X-Gm-Message-State: AOJu0YwLiw3bggIUqM2Inx+RZpiKr934YUviHhYwZWAaM56VwJkkk9tz
	2SFnzPgM5CA3Gn7TGuG46VHFqUols4B18RCPfmeOHms+pN5ts/xU5nbJANEx7Ig=
X-Google-Smtp-Source: AGHT+IH8FWbYXk3WZsUX6Htio1PWuqLPJdA+M4B9jVwynpQ7Y34McbPbsLdTXEBKn2F/NOZNkgGkPA==
X-Received: by 2002:a05:6512:3a91:b0:519:2828:c284 with SMTP id q17-20020a0565123a9100b005192828c284mr2198578lfu.65.1714580386985;
        Wed, 01 May 2024 09:19:46 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id d30-20020a0565123d1e00b00516d0029383sm4909306lfv.28.2024.05.01.09.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:19:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 01 May 2024 19:19:33 +0300
Subject: [PATCH 07/13] arm64: dts: qcom: sm6115: add power-domain to UFS
 PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-qcom-phy-fixes-v1-7-f1fd15c33fb3@linaro.org>
References: <20240501-qcom-phy-fixes-v1-0-f1fd15c33fb3@linaro.org>
In-Reply-To: <20240501-qcom-phy-fixes-v1-0-f1fd15c33fb3@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>, cros-qcom-dts-watchers@chromium.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 David Wronek <davidwronek@gmail.com>, Andy Gross <andy.gross@linaro.org>, 
 Evan Green <evgreen@chromium.org>, Douglas Anderson <dianders@chromium.org>, 
 Iskren Chernev <me@iskren.info>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=776;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=naWFrW0qlpkbnfyMNz6lkTT4Kg5gQ1w71bgFqDbRi3E=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmMmuZwoMNt8+h8OWQtoxvqSZIxiOCZBaMItpbd
 b/edI/5yvGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZjJrmQAKCRCLPIo+Aiko
 1eZ7CACMljpmbXnA5ga9/FaUsBK5o+tLmIW71XhWxRYNLrt8LMrExJ4ipQK0K8sWVC/looM7E/R
 u7XZZ7lBhiqujgBmVDadEoCCXwNOC/TywEiJ92xuL0vxnq+kVahLBmqTs24oGW87n1Z142516f7
 uyVkoLc9H0RYffUSnOurYUZ5vg/dZUdySGjrV2MMAhLOb+PdPolrSChfj/wtoRQGSoRwVoWIZSz
 za0TYe6q4Bn7/3HjjUvStVIbss2akuYGHOnJ7/zx+jH+SwEIZirRJVNVVobMsx7ufawo5ZBTw7b
 7uW+TcAQVjV7dwgP6qTnUV7Nrhs35mcse7ZfzM0vXQifmcse
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The UFS PHY is powered on via the UFS_PHY_GDSC power domain. Add
corresponding power-domain the the PHY node.

Fixes: 97e563bf5ba1 ("arm64: dts: qcom: sm6115: Add basic soc dtsi")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index aca0a87092e4..5896868d9e6b 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1230,6 +1230,8 @@ ufs_mem_phy: phy@4807000 {
 				      "ref_aux",
 				      "qref";
 
+			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
+
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
 

-- 
2.39.2


