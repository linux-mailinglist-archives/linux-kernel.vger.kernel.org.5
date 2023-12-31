Return-Path: <linux-kernel+bounces-13721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E730820BA2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5DE1C20EB3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20D1B653;
	Sun, 31 Dec 2023 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="CeRHjMud"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491996112;
	Sun, 31 Dec 2023 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1704034145; bh=tVjN4y/BnadVs97PBPGAD+VjNQlvK4oNmgi6kkD+O/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CeRHjMud6XWX40zWnbKtNDtb427ErZ9/Owab5DLKsPgbVDQCvWfzQi9Eg+0+uMpUt
	 EOPjb2Fuy7DzPYrqkS/T3eMaAlEZLw94FkujE7VP2hjRZWLW4pwFdj6Lw4YbgD7uk8
	 0nLIQ5M7XfPw5ppvQXR4UT+g6TCjvPccBVxx2vro=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 31 Dec 2023 15:48:45 +0100
Subject: [PATCH 3/3] arm64: dts: qcom: qcs404: Use specific compatible for
 hfpll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231231-hfpll-yaml-v1-3-359d44a4e194@z3ntu.xyz>
References: <20231231-hfpll-yaml-v1-0-359d44a4e194@z3ntu.xyz>
In-Reply-To: <20231231-hfpll-yaml-v1-0-359d44a4e194@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=tVjN4y/BnadVs97PBPGAD+VjNQlvK4oNmgi6kkD+O/4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlkX9esuevqApXc3vIL/HJ1Wd9C4bC8OXDGBq5V
 sD6FIi41KGJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZZF/XgAKCRBy2EO4nU3X
 VqFqD/4riijlKN8UQrEk8JI1yX3T3yETB/ns9rWEQMbrpBpEPBOq7w0nAcWqbWQriUYeQ/yjFKU
 b6hMbItKaEJwFBc2FdQWWj7s+TV60CyT5TmBw5Dw5QwzgNu7FWuIRr0GnOknfFbZPYkQ3A6b8bz
 q2Zsu++1ffScpTvT1EqsPbMU5TiXU1f1w0OScaObnAzbmY/8hP8GGnqoKW9070S0QVv0UO0OGWc
 CtT23QRxU6yB8oxkKZJieC6Sj5mLIjBeDIZA5jGSBDFYQk/IFHl43HxHhjSOaLBoD0le+SKGhQM
 27A43OMnUtyYAmMO5LG/Gsf/wnpFDJhPa+Wdd0cS1rrFpe97F8EzsfK22hxyCIlJslHkMctc6w0
 zO+eUh9OzHUNZH+qHb2yybytL+WwXrXx5pbRTM3LXORUOMM7AHS/PjJasQX3x3pUlgL6+KLwix1
 fdo5N3qphM2722Dv3rvA2wGEU+26sZrEQAJ1LZVSrINVlmBVOkJKJLRjmpgbYEE/LI3q6icZQHg
 d8DEsEr1NI94b537FKx9ETdEkfaRONMdhWjngrWw6vBnc2mNxSzB9CblIXvF5k+wUx859zzqvcV
 5SOCS2JYOR7gzGcgUI1p4z3e5VswnnXLmCvAZ6fcOKq4N/UCp4U/QX548AL2URiC2JyFil4kvRP
 TDprAB3WilIY3Cw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Follow the updated bindings and use a QCS404-specific compatible for the
HFPLL.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 6ac64ce9bb68..788dcc747a24 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1317,7 +1317,7 @@ apcs_glb: mailbox@b011000 {
 		};
 
 		apcs_hfpll: clock-controller@b016000 {
-			compatible = "qcom,hfpll";
+			compatible = "qcom,qcs404-hfpll", "qcom,hfpll";
 			reg = <0x0b016000 0x30>;
 			#clock-cells = <0>;
 			clock-output-names = "apcs_hfpll";

-- 
2.43.0


