Return-Path: <linux-kernel+bounces-93093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90219872AFF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE631C24AA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AD912DD95;
	Tue,  5 Mar 2024 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="LnNfVQGt"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A312D20D;
	Tue,  5 Mar 2024 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681208; cv=none; b=YY46E9RCZaNT3H0DJUZoZ9FKPrrsgCyG0lHuUPVl08VXrKoJiGwfHjRgDKTU4C9YVMbKf0nfcekGj5pV5Qo8MkD35cNWozpLEaMAfYXbbc+Qr4Sy2qIdKtP/FxKeCtbeu6H/dSKbS1PzjtKS2PHsRay7RsUfXDz0XH+zEpS4Wgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681208; c=relaxed/simple;
	bh=31ibeEGJ5Em1DeIcxHNvakpTfpM5nu/ekQP55sZySEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p/1K8y5jTgOFUAUkIvh3dwbXdhztey0sKeI8c4Z2veg2Qk/oqML4egd/C0R9C9HXYHpq0t870r38HhwqcydwCa9wR9cjsHBPoWNfvm4fl5LsYRokIf3mPlGkEmei8F7LJTLOgg+teqXMGgtd4oz0U15z/rnMoHCK0ZOBgiCxwEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=LnNfVQGt; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1709680705; bh=31ibeEGJ5Em1DeIcxHNvakpTfpM5nu/ekQP55sZySEU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LnNfVQGtVh/089VnLWPm5bpqlJmpPTz36nu89g/EIwQRcYJmAmRXdZOqdmbDpC9vR
	 qAClE+Uvbo9tVfDsBfmFR59sscXGwovyxPItCUu0yoS2CMhfqbxBGrcJfPvsIVv4nI
	 Mc0W7N32YsVC0w2eWBXc5/dECbKacVZFj8in61qU=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 06 Mar 2024 00:18:05 +0100
Subject: [PATCH 2/5] ARM: dts: qcom: msm8974pro-castor: Add mmc aliases
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-castor-changes-v1-2-2286eaf85fff@z3ntu.xyz>
References: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz>
In-Reply-To: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=822; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=31ibeEGJ5Em1DeIcxHNvakpTfpM5nu/ekQP55sZySEU=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl56g8h6ORRDJyVZSt309qt0OmUG3CrqdTbuf8s
 qFMJlsELrKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZeeoPAAKCRBy2EO4nU3X
 Viz8EADOuKWvxh6qAS6qgr7ptj0750yFhmVJA8pdL0r1EMca+TYmDjHaSfkWqwHCTbBjVKg4HX7
 dyAx/ut+Q5odb/O4X+2MUEnIBM9L2KS+s1eVwOAZYLdz+wkeyoVgbeaX50Pb3QP76MvjMAgHjdA
 uChP186u1AXncRsXD0j4CK163pcElrAkkNPFbT9C4yOWQssWSGda6wkp5Zm9uu9dY+NqTrU3vme
 E4PDNQ/sPOvEFODW1aK2fH4sm0xqNmsLMFmBAdaMCHZTOwJDWDslZAG8bF3nqiq5aBZ0x9BQsIt
 nF2d464OwcXzAEv6wQBcjrx31M9qOSXJGlkeJB6Tq1Bw50eGlaVZjcQptCG7MGLWBFAgs2EprI0
 Tr4bai7GjFDajUmHw4Wdzji5I+YdwmcP5MDq6UWGtUrzdUAs53poDPOEwCli87SJPfEVvwaMbR6
 +Hr96diSucU2pvK1ZP/YWSp9q6u6xHFETtveqpWFFU82AgvRDwvgOQk3OhADVuCtebNE87slWOj
 kiJNlOXuldl1sjDRvp/qy6A+k6X2q2eED2CMS8g4Cqf3OvUWtVqznUDr5xAT9JCLpNwNRjCrrtF
 gUKtbqUQ5KFWQ9jFKm9L9pK3XEmeYEzhyMwTrxH6BWI4YUhW3i67gzgJIUEzOoR3We+uFuPrlbx
 GnD5fJmTvMRfIeg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the mmc0 & mmc1 aliases to make sure internal storage always becomes
/dev/mmcblk0 and SD card becomes /dev/mmcblk1

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 2db2ddf00580..da554f72528a 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -12,6 +12,8 @@ / {
 	chassis-type = "tablet";
 
 	aliases {
+		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2;
 		serial0 = &blsp1_uart2;
 		serial1 = &blsp2_uart1;
 	};

-- 
2.44.0


