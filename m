Return-Path: <linux-kernel+bounces-137477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8967B89E2AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C79283FD5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD53157492;
	Tue,  9 Apr 2024 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="MV3p69d3"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EA4156C51;
	Tue,  9 Apr 2024 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687817; cv=none; b=QoeXcUqeLbChl1tonPR5bsdyAUVjU2vWeLlIMgtihg7InIC1ty4w035Yq7cfsUQ95yhsYQoEVfrVG7pGrwRqtZIPHrsdGaZO6jYwdTQxBw8gFfvjCR0oofQQ5NLW0QP7gPx2mfg9t6WIYyOLsm/ZwVwwWtj5qZlKuFfFJRtCN+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687817; c=relaxed/simple;
	bh=+ayaTanXY1BoZODK0R5VCBAqY8Ylbg2XOaM+3Rh7RfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0HpiPNHSP+X35YgFPp7PeGe3JjygWV3bUE9bLEhfs/XE4TjkSr4iOm0pbAtZ9FOnfWr2wYLxai5R1aT8AoslLS0hfvojsMkWJiRDE/ceRDi9lGT1KzAsWTPH6Z3IjY+Ddcup6/7ufxgqU6uTnDQmMTPOMQPeQCrHwoq36C+Lz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=MV3p69d3; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712687813; bh=+ayaTanXY1BoZODK0R5VCBAqY8Ylbg2XOaM+3Rh7RfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MV3p69d312eA9OfMiSwLW7UnZChrckze4sNfGc374bb0Y78wshOhc8JiLq5gznVbB
	 lzetwF/8XI1DevwWKmRCa5FYx7+ds+ygBabfhgl8Mn0gOqtRS5k6bftr1C9vUhh24v
	 gRpQRN1DdYF2AN4afdMafVbCFMczqs2tUmpOFx2s=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Tue, 09 Apr 2024 20:36:37 +0200
Subject: [PATCH v2 2/2] ARM: dts: qcom: msm8974-hammerhead: Update gpio hog
 node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-qcom-pmic-gpio-hog-v2-2-5ff812d2baed@z3ntu.xyz>
References: <20240409-qcom-pmic-gpio-hog-v2-0-5ff812d2baed@z3ntu.xyz>
In-Reply-To: <20240409-qcom-pmic-gpio-hog-v2-0-5ff812d2baed@z3ntu.xyz>
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
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmFYrDsi6aMOVf5AY4ya9hmCJhzhKb32Ryq6Y4N
 mQE6VbLYT6JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhWKwwAKCRBy2EO4nU3X
 VrowEAC3NbGH98YVuUC6KW5U1GmVH/ouiBhiZuGM5fMLb6204TUZRlXV/BnNhzk1AvEi0btph2t
 xeDzbh0HdjBGiJ3Bm6e83au6QqQTsIlCCoy7buqpMkh5thnnI9wGpoBZUSRaT3Ta2qRlOXT5Pid
 Zmg8tOrGZTpYqg2ed9sgDpU7vFJrTWY+HprNi3qGjOt5opEcneiazQkePGRaeRIy1XDA6xHLOoD
 8k4vuRxbTGzq/hdIfj3Z780Uwc0ldxpZxAOT4Dhf5jAZIuljZUCl46g6o5Ek+zvIhPuZN/uFoCj
 aR2Ub6TOy0I/i1odrdwWLfetM5TbhOqmM4emHOz93hGvDGnJRYRiezWC8YYH6QNSv9RO7iMHWM3
 GsshlHZSlWUseuIJzqyTGnjRFzxmVhZCdSTDEmd3IUJ7wQ++1O2leLxhPE/SELOITs3UugySz9a
 4O6wpufGj/2sEpjA+7suYqS5T3m7V0b/p1X6pZ5QJqcJhK5FTLo4ivZnTPneLwS4FMfgsy6nxjo
 qi69g927Q+/Bqt2gU2sWPG5+67CLb2EPXe7mRbi8UF3Fu62m+e2vuwZsqfoN2w30DiBLuxHqjMD
 UmsGfSx+krtUnEYm5ssz0D/S/zDrHyOxKGLbJ6NUDEqxsuMd2uyEd2gCVYsS1qhOxDKGmeHcRUc
 EaMTy3JjkI0KKUw==
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


