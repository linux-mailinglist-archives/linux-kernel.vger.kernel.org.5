Return-Path: <linux-kernel+bounces-32218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FC5835853
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00441F21AA1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B633339ADD;
	Sun, 21 Jan 2024 22:41:44 +0000 (UTC)
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600638384;
	Sun, 21 Jan 2024 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705876904; cv=none; b=r0pIWznhxuWOVaGh1POM6trHhNnhOvTgD856WzqzgKgovlPHXLaO6vpe8S+DfLswMAj9Wp6RS9W40wrnsVW2VkvPThso7R57pP3c2bkJumJNTH46IVN1JT9oIC2WijrXTcv2R5kDKKI4ONVQ31FhfKiaGS8m7WWSajrCesMrTfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705876904; c=relaxed/simple;
	bh=WJ4yt2ceaxagRwjbxAaPjRX6Swf4XBTvvfUCXxi7z30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NlpNbgb7spG5SCcoARM4en9i7VOtcgfRqyYsf04AXD876HBTZdRuN0yek7VsklDVCgTwgSx9ApzQXMn0GUuBXusklf0HKJRMb89jY6vETjXawT+jU/ggRXfiRaH2G4GtHCoI2kzG5K/h8wxh8YLsgneKjOl9FyYpgFs7ixncgiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 00E04203AA;
	Sun, 21 Jan 2024 23:33:43 +0100 (CET)
From: Marijn Suijten <marijn.suijten@somainline.org>
Date: Sun, 21 Jan 2024 23:33:43 +0100
Subject: [PATCH v2 6/6] arm64: dts: qcom: msm8956-loire: Add SD Card Detect
 to SDC2 pin states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-msm8976-dt-v2-6-7b186a02dc72@somainline.org>
References: <20240121-msm8976-dt-v2-0-7b186a02dc72@somainline.org>
In-Reply-To: <20240121-msm8976-dt-v2-0-7b186a02dc72@somainline.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Luca Weiss <luca@z3ntu.xyz>, Adam Skladowski <a39.skl@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Martin Botka <martin.botka@somainline.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.4

In addition to the SDC2 pins, set the SD Card Detect pin in a sane state
to be used as an interrupt when an SD Card is slotted in or removed.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
index b0b83edd3627..75412e37334c 100644
--- a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
@@ -264,10 +264,27 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdc2_off_state {
+	sd-cd-pins {
+		pins = "gpio100";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
 &sdc2_on_state {
 	clk-pins {
 		drive-strength = <10>;
 	};
+
+	sd-cd-pins {
+		pins = "gpio100";
+		function = "gpio";
+		drive-strength = <2>;
+		input-enable;
+		bias-pull-up;
+	};
 };
 
 &sdhc_2 {

-- 
2.43.0


