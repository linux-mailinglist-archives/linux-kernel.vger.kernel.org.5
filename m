Return-Path: <linux-kernel+bounces-135696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7254E89C9DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA2728A2CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52450143871;
	Mon,  8 Apr 2024 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="XLdFAVh5"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F419142652;
	Mon,  8 Apr 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594397; cv=none; b=Qpz6++7l1k4gurilPUoITr3654ue/b9qRrbAdGTl2JQgwB+06LE5axSWiKb48n+uE5VU0163xA6TjmDlHljsZhY5WqZjsdQGH6lfrEGr6HDuPPI4xbe2Q9r+JdoBcTVqzwrlNkYP9/N+ehqjU/SFM4QN53hqyWk5ggfeEo1EgZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594397; c=relaxed/simple;
	bh=+ayaTanXY1BoZODK0R5VCBAqY8Ylbg2XOaM+3Rh7RfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BDi2OfDPwO/GUwWX6+S31cCZBTKR7cGXq/Y18C/2/O0aaucMXL/NwiO25yGRyGU3Uq5nXfUY9AgcA9V0vK4CwUsjUdDtTg7cNZWHtuUMXLEf56bV5nFAw6MxIokWSXsz7aIEscIWkn7d+/EHdpfRz3/LXx8IDlBb2y85bZFRuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=XLdFAVh5; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712594394; bh=+ayaTanXY1BoZODK0R5VCBAqY8Ylbg2XOaM+3Rh7RfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XLdFAVh5OS/br+w8wFVvIf/EPbaKrrAxTr7Hob+QYz3fPiVHyZgMPAbyY1en2zLrY
	 nhQJ6HeQ1cQFO28ERHudylZlqp9HhThmpICAeHipUOclkSArJODdMaDDUrY9HZzuOM
	 OQRJR6ZbzFrgxWpKIbpNLtRb8p+mRKf8CkJRmOxI=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Mon, 08 Apr 2024 18:39:48 +0200
Subject: [PATCH 2/2] ARM: dts: qcom: msm8974-hammerhead: Update gpio hog
 node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-qcom-pmic-gpio-hog-v1-2-f61fc5323110@z3ntu.xyz>
References: <20240408-qcom-pmic-gpio-hog-v1-0-f61fc5323110@z3ntu.xyz>
In-Reply-To: <20240408-qcom-pmic-gpio-hog-v1-0-f61fc5323110@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=763; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=+ayaTanXY1BoZODK0R5VCBAqY8Ylbg2XOaM+3Rh7RfI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmFB3YDxLvRVsxb9nTkZozxM4XvfH1dYr3FRlbY
 BIc+CeW3N6JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhQd2AAKCRBy2EO4nU3X
 Vut5D/9DMtNCNuU4Y0MpLDm8ZJWPCbS3mIXaweMlva5I6z1BRBzXEkVc1Sgs9fyS/MOMwyLfTQ9
 slKaGakE7hMNZluPw8D+xzKjbDTVNx04TJYiKJL+GoJlFPk1ZTGCUeFuDFSl1HISTFWopKJ5cF6
 GmGNv9lpnGgqt6pZTXLap93GU/DAUXfn6moJbHGeEpSug2qUmDzWI4CZ1IRj9FnwmmxSo0c13qz
 bo3vrohf5KKuulIRRB54QeXGFvGkzN9paeRN3kWfDhKRm0nec5TG7Wd79ViQ3YGJ28zsRihErEW
 4+r8FQ84TK1+r0a/M4A4VjyLCkdRrOFUSnZWQ+fbx2bKibHnH/V7tgYmflZBPHWnk6Yz0xsG5o2
 E4/GQZ3gMRDStjjmHgTt3JlUndtwSkRKVd5/LRoQQp39zDX3kraB9AhpJXqxrzcMQV3rTFrCmHr
 TICNoIYMe3Jcz5UQXcY3z1scFMQW/IV02ziCBe3bIGlsQWGZ71qRiPxVtj6Jy3cGEvFye/LWOGB
 vX0ieic56wcUw4E/UCVx13Q0MR0BWr38WbEf8+JBwPTeN846U2YzrQfAPZTuVDZAAzE3jwlcUat
 cAq92CVAzFPTTmbSqEC5Ua2I/wA6M3uww98VhZBjo0qI77XqFr+4wY5mgTK0sjkAGT4Z8zGrTVb
 ML1Kht28nwaDZOA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Follow the gpio-hog bindings and use otg-hog as node name.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
index 4aaae8537a3f..06549051be50 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -328,7 +328,7 @@ wlan_regulator_pin: wl-reg-active-state {
 		power-source = <PM8941_GPIO_S3>;
 	};
 
-	otg {
+	otg-hog {
 		gpio-hog;
 		gpios = <35 GPIO_ACTIVE_HIGH>;
 		output-high;

-- 
2.44.0


