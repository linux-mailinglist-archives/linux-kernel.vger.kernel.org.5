Return-Path: <linux-kernel+bounces-32099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DC4835671
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B461C2148F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080AE37703;
	Sun, 21 Jan 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="taKDeJHB"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77F3771C;
	Sun, 21 Jan 2024 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705851673; cv=pass; b=OPw0mqnEHD2ffdoc/8YRmBfEuL8lA1flbrrikOVSh39nP5wUxjqH+qA/fTbIfhLZtb1gbSBrUNg/cAueTGl9hfvWBpCeEE5+jYzuLV/wZe9FKlOC0xgUM9e1a1vEwaITAzMa2KgtC1RkmpNe2CtXIYquYS60/jYmjCeOJE2gZ3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705851673; c=relaxed/simple;
	bh=ik6qCUEqxmnFHKkHRE328geiO+07leDvG+heycD0R9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=en49Srg6eA6ToMf9whIuTYidFA8k4m65nUDphDX9Iu3r+QE+UByNfaZAC1Pqiw0pcjP8IxGapfoxsfC9L/rZrnLMgs4/ro1wHh2JvRNYwuL8uLaLGTpfdO7jLU3+deYA+5vXmJvAlnpDb6pdHJ83PU8UHcReqUUZm8dkIaa9044=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=taKDeJHB; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1705851667; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l8ep7wAUn+RaA2pPFAi4jmfLgyJvllS+oOm/JJEP4qktQMOMdfgNKbcgC8OcOoU6LJgYcXQvW8nga4x5igs3CZyC0GNnlgMy8Ni+tOxu9tPpPjAJiIsZCoijRhLP2etULQuTNbMn0StzBFCeUK3czvw3DOBuSoR5GpUm5WKJRbI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705851667; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QJQSc5Zs0LAGeoCIvUPc8jDMeS43dCWdp6AOjy8XecQ=; 
	b=Nk6SmmmDkbe7f3IebHO6t5zYZYJGwKSjFmzbFDwKx4TJphqPv8hquKndliAvHFaDWkx5LlbpO5mUreen/SmbNF+rBFKmO7K4FcOtu3RnNL0Ij6fGVdVSa9Of1tBVMjG0KgNjDcdZ0RDGFBEXCali4c8tf+YmRuuepHb7YPkuu7g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705851667;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QJQSc5Zs0LAGeoCIvUPc8jDMeS43dCWdp6AOjy8XecQ=;
	b=taKDeJHBeCHBsRqGeOEkoDef/m9SyMAhLAmDfle4sCurw/3RQqlJBg8sdqTzo+89
	AfT66Aj9GPXMLgZ+g9BUu0iwtu0ayZdoYdsZyTexvqcLuR82rpqVmtz/8/tKPxC2euG
	06F+sBZv/+3Naa1vmZcsTzrWxTc8ACMe1bK82ya8=
Received: from tb.lan (182.118.232.129 [182.118.232.129]) by mx.zohomail.com
	with SMTPS id 1705851666482538.1377714303437; Sun, 21 Jan 2024 07:41:06 -0800 (PST)
From: Rong Zhang <i@rong.moe>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 2/4] ARM: dts: qcom: msm8974-samsung-klte: Pin brcm,board-type in wifi
Date: Sun, 21 Jan 2024 23:39:57 +0800
Message-ID: <20240121154010.168440-3-i@rong.moe>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240121154010.168440-1-i@rong.moe>
References: <20240121154010.168440-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

klte variants, namely, klte*, have little difference in the WiFi part.

Pin brcm,board-type to "samsung,klte" to allow klte* load the same
firmware.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
index 013946ccda0f..9025345a1ab9 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
@@ -665,6 +665,12 @@ wifi@1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 
+		/*
+		 * This aims to allow other klte* variants to load the same firmware,
+		 * as klte variants have little differences in the wifi part.
+		 */
+		brcm,board-type = "samsung,klte";
+
 		interrupt-parent = <&tlmm>;
 		interrupts = <92 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "host-wake";
-- 
2.43.0


