Return-Path: <linux-kernel+bounces-32214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7BA83584B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7062281795
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7941738FB3;
	Sun, 21 Jan 2024 22:41:43 +0000 (UTC)
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2DF38DFB
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705876903; cv=none; b=qKCHBfPFAWGAxzuFlPTxQALK9l8pfhcXs226zyvlNqiTVlwhFKvuojThMcfFVDFVd7Njvt1oIbPB72QGUiLx/OZdUhaGjplYEuz8OsVt4VOzcM00gANe32BOJx5IC2LJgSFKUrDI3Io/s/rFDxcOSeXqHxRpfjm2y/BDPdKWtsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705876903; c=relaxed/simple;
	bh=CTNcfJwybjX/Tkl9gEBdYFF2xig/uDP3Ncqgqn4vJJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9kDqVMCc9iHGcgEwRAUXkAN8L3wgvp4xjlxswK55EMAk/DXCi4+aRqX/8G/RrBm/8uQlF58GM+ANpt5BbCs0uRfjLhp54yP6IdX0jOe4i29EO5OcqX19wfRQ5uH5xAkAOmhuzo2Hfc+1uS/SF2li3uQ933zs1AcWbhLY3qOFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B06C32037A;
	Sun, 21 Jan 2024 23:33:41 +0100 (CET)
From: Marijn Suijten <marijn.suijten@somainline.org>
Date: Sun, 21 Jan 2024 23:33:40 +0100
Subject: [PATCH v2 3/6] arm64: dts: qcom: pmi8950: Add missing ADC channels
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-msm8976-dt-v2-3-7b186a02dc72@somainline.org>
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

These seem to have previously been excluded due to either not residing
on the test board, and/or lacking VADC_USB_DP/VADC_USB_DM definitions.
Now that the channel constants are included in dt-bindings, add the
channels to DT as well.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 arch/arm64/boot/dts/qcom/pmi8950.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
index 49e97ebdbb3c..bc341849b9fe 100644
--- a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
@@ -69,6 +69,30 @@ channel@d {
 				qcom,pre-scaling = <1 1>;
 				label = "chg_temp";
 			};
+
+			channel@e {
+				reg = <VADC_GND_REF>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
+			};
+
+			channel@f {
+				reg = <VADC_VDD_VADC>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_vdd";
+			};
+
+			channel@43 {
+				reg = <VADC_USB_DP>;
+				qcom,pre-scaling = <1 1>;
+				label = "usb_dp";
+			};
+
+			channel@44 {
+				reg = <VADC_USB_DM>;
+				qcom,pre-scaling = <1 1>;
+				label = "usb_dm";
+			};
 		};
 
 		pmi8950_mpps: mpps@a000 {

-- 
2.43.0


