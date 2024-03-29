Return-Path: <linux-kernel+bounces-124574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F7891A20
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2528D1C25416
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFD4155A5B;
	Fri, 29 Mar 2024 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOINRrsF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF97155A32;
	Fri, 29 Mar 2024 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715439; cv=none; b=VTK9FLX9Zjza8Eo9LBHJuFSNX4bQFw9aRNsHq5TCX+hWTQsDv2OetFeYFLBZp6aqL3DmitefPwbqsBrnDaSFSed3xg+mmAA6sZAcrH9fRQ0WWVLDxYCIUSkQI0OzS7TOTenlKp2cXnNDPraw7ODxtue3eAl8PQmpDPXJBXZgVJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715439; c=relaxed/simple;
	bh=MbeWrcMdf2eEBAMXOJ41Og82HMKLg9i/HDKp0mCLC+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYuXVyMtIwjcV2SDcwM3blpRe5wuHb3zM1TnMoYOJOyK2cQYyKEODe5l97G5+7rzVJOlpp8WxyfSr2DEW+Ga8ceEPEBnULQI78fjVENOZXkzZCHPwnVsA0/XEaFuevS9IYlk7xy9wrQdLLGNwiUe5ksKZKgHl3Ka032pR18r6is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOINRrsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0C1C433C7;
	Fri, 29 Mar 2024 12:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715439;
	bh=MbeWrcMdf2eEBAMXOJ41Og82HMKLg9i/HDKp0mCLC+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mOINRrsFORDLbWbP5eEFlm58Bv9716I+Xbm5m6kVb/MLR8XiA3MtLyThftkJhg6RX
	 XsIPL+/EKgZFnJ0APX8DxSN5nHYOyNZgUkWcYljDiFWYmC6DhSyr1vQXfByxjgmlGE
	 B4L1/6hKrf0FPFcdhIfuvNfP4tPV8BiikRCLdqfeZ5+H6rybt4m3985wlEpinSOVGG
	 Ztq/My+nJ388hn77oDB0TSl8OmAyWd+DYzsHxxIVQH/z8LHAtNcgSA3hVZ/5NV0yF4
	 U44yeeEuzNUGu6hWcgyykxb7BPvp6H2xUXYUrmdjecR+8htO4H5Xcl2SRqqEjmWpVd
	 cJrA4WhhaJXdg==
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
Subject: [PATCH AUTOSEL 6.6 23/52] arm64: dts: sm8450: correct DMIC2 and DMIC3 pin config node names
Date: Fri, 29 Mar 2024 08:28:53 -0400
Message-ID: <20240329122956.3083859-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index bd5e8181f2aa0..c1f58449f08c7 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -1129,7 +1129,7 @@ &usb_1_qmpphy_usb_ss_in {
 };
 
 &vamacro {
-	pinctrl-0 = <&dmic01_default>, <&dmic02_default>;
+	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";
 	vdd-micb-supply = <&vreg_s10b_1p8>;
 	qcom,dmic-sample-rate = <600000>;
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 91d856e5b06b5..77c90b3c616b6 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3755,7 +3755,7 @@ data-pins {
 				};
 			};
 
-			dmic02_default: dmic02-default-state {
+			dmic23_default: dmic23-default-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
-- 
2.43.0


