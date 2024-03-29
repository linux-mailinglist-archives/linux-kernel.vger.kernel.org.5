Return-Path: <linux-kernel+bounces-124746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27560891C13
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D080E1F2ADC7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F49817B4F0;
	Fri, 29 Mar 2024 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6v5J1fn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E517AFB7;
	Fri, 29 Mar 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716069; cv=none; b=Fy2Dz9dGTarKXdo1xn8zvNMqyUx4SEY7pwYhECtaZAWpH4MPATOpOXKlJtxQYEdWBCrAszqFhOthvHf+ZI/0lx8iK38LMngm3V8NbYtp2UFYEWBFTHDIr4pRWS5wpWcY3qjfp6/PN3/nR/hDgX2q0gQhJuGDF3NKGwWbviJv3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716069; c=relaxed/simple;
	bh=yZjEyQ6wVYJcUJHFayk7cT+3Wo/67muuoddgJbxgicw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QugfrTR7QH+S2QVC8LbaxV37x16yfI6nUlUCMy58Iuv5d8UftlAl+vG9Juf9ITXHOc3+pQ1Jngo/OOPIR6Vam+TIohFrsUy6KvXbOsLUzi3K/CjCJM5YcCcCfGDSXcRJn9CsBfTK54nDghmQM6h3GOQigMg2sMfvWZrRwi5YrxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6v5J1fn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29139C433B1;
	Fri, 29 Mar 2024 12:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716069;
	bh=yZjEyQ6wVYJcUJHFayk7cT+3Wo/67muuoddgJbxgicw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t6v5J1fndoaNdfNi1PGhMQVxBeSsJJresaLieW/hSCIvYvj86P62NcWOAOUwzAZpz
	 h3Ss+CCH6ZaKnlp0335MRetH1GeQLAk5c8KXdst11VcfieBIQJH7KJ0aQ/XUzXiXir
	 TLIgRIQpUvWnClQHZVtMmQtmvXkz7aBLcguiqz6AFoy6BeIqsVNIdjqe5Zbva+1zHe
	 rempGoPR7dL5mmzS0W0uHtWFux6PZKivqnpO4yL4PbODB2tddjJQqUXE7LjwQ8fLQy
	 dEqCA3jkrwoZK2dat0pcbQ7eFQg9iGs/TPCu4SN8W69CYE7Cy3SosdYQUjflK8pva0
	 TV1U4MkjVWrMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 37/98] arm64: dts: sm8450: correct DMIC2 and DMIC3 pin config node names
Date: Fri, 29 Mar 2024 08:37:08 -0400
Message-ID: <20240329123919.3087149-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 0d3eb7ff1f3a994a5b3e49a9bd48f0c2f3c80ef5 ]

Correct the TLMM pin configuration and muxing node names used for DMIC2
and DMIC3 (dmic01 -> dmic23).  This has no functional impact, but
improves code readability and avoids any confusion when reading the DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240212172335.124845-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 2 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index a20d5d76af352..5a6e0b34934cb 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -1147,7 +1147,7 @@ &usb_1_qmpphy_usb_ss_in {
 };
 
 &vamacro {
-	pinctrl-0 = <&dmic01_default>, <&dmic02_default>;
+	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";
 	vdd-micb-supply = <&vreg_s10b_1p8>;
 	qcom,dmic-sample-rate = <600000>;
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 01e4dfc4babd2..0a802c9a3c8f7 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3934,7 +3934,7 @@ data-pins {
 				};
 			};
 
-			dmic02_default: dmic02-default-state {
+			dmic23_default: dmic23-default-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
-- 
2.43.0


