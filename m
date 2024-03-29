Return-Path: <linux-kernel+bounces-124889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB1891D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44D91F25EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A794022BF74;
	Fri, 29 Mar 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6pz1coR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09DB22BF61;
	Fri, 29 Mar 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716373; cv=none; b=QYe/BuovkkiT9nGLzlN3Looc/TOmF99iEn+NcGRe1W6HdUprIw7hcu2boCGCeSVHatHkO1yNf1wTsoFaodpjGt3ym0uhyOMOils7A6/3ke5BPIKfba3By29fMcPa4P0w6EiuzPaXX6lPLYnJWylup0EgsLGEDaUUDH7gQbPBn1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716373; c=relaxed/simple;
	bh=wBIl6iQn8dGuig7/GIxe4/ELuK8o053YSZQT2q6DHWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhXjeDSykGEjRuTfJDFq345GN4sdWaK4gUH3YUI+BpSYHVv+L/b6aJnpZ/XK6G83FylRddxEmv/JuBzUK0+URtEyF4ZsuCnXQqhmqEAmI6HaWxoIPDGmMvXujdQEt87+SPbwygsnHdJD/uE+jnAPxtVqpGrBQ+4dPt/2orv+hGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6pz1coR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3CEC433B2;
	Fri, 29 Mar 2024 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716373;
	bh=wBIl6iQn8dGuig7/GIxe4/ELuK8o053YSZQT2q6DHWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6pz1coROI3aF1UtzNJvElSo/dR4tOs9q9J8Bt3JmBvgbmmIGPVk0agN33okJOiCY
	 W1GlCYqUTzm2mH3m5WNzrw2CTkwZYnvyN18d4IKcOY+6OTdlVCKUMbgiggU14R41iM
	 skwA8MPwiANU8O4QgTfDnufA5TR1r2HVhsGrcR8e8x1qeuuX0p2rBuAhF+emh0wPDg
	 UuyU7RH67UTd9uARVszDKh4t9jOmEtNLySvNxXJpeo7DiFcEh13glflJLssTeF2zEg
	 6ruM7WDh2uwCfHbF5x013cDKEgQ8x6zFPAnd4Soz4p+9DrnBMtlKmM7SQEk07j5FM+
	 2WnFIz6F9SNJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/52] arm64: dts: qcom: sda660-ifc6560: enable USB 3.0 PHY
Date: Fri, 29 Mar 2024 08:44:59 -0400
Message-ID: <20240329124605.3091273-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 319a12e7c399df4316f54f6cc83cd6cdffb4ec4a ]

The Inforce IFC6560 board actually has USB SS lines routed to the USB-C
connector. Enable USB 3.0 PHY and SS mode for the USB3 host.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240116-sdm660-usb3-support-v1-4-2fbd683aea77@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index f824036871cc1..2128a90e7ef97 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -452,16 +452,15 @@ &usb2_dwc3 {
 };
 
 &usb3 {
-	qcom,select-utmi-as-pipe-clk;
-
 	status = "okay";
 };
 
 &usb3_dwc3 {
-	maximum-speed = "high-speed";
-	phys = <&qusb2phy0>;
-	phy-names = "usb2-phy";
-
 	dr_mode = "peripheral";
 	extcon = <&extcon_usb>;
 };
+
+&usb3_qmpphy {
+	vdda-phy-supply = <&vreg_l1b_0p925>;
+	status = "okay";
+};
-- 
2.43.0


