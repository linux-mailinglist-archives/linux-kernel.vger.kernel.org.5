Return-Path: <linux-kernel+bounces-98203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DF487766A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037961C20AFB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABB928383;
	Sun, 10 Mar 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="zqoS9Ja3"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F61DFE3;
	Sun, 10 Mar 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710070922; cv=none; b=CBFlyBRuv8eWn/YdlR3KnO3noAQPML5r8dp6ECt3DXxZALf8zOnyxiqrcyVOCRD1lvcwYexXpbq4qA6g/ZFTGDvgadFS0i3dv8ahfWpCe22q8L0/tRdFrtu6zzeBw9WabjuAFfd6ujbN1HyTodbh06DWMsTgWKGtc9DM43B0SLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710070922; c=relaxed/simple;
	bh=I4A1mRf+nnfvFlrOIk0IJXTuAiKh7+M48w5pBvyMqk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pz+UYPfZSYdBp9zJCPV1071aywd6eeZYC/xFBRuv3HZWjKEV4952wzwn8MAJrcEJyIW7PvyFCCYspliup+972+W8Pz8YP1/xHVEo4P0iFcnK/ITzZBIjxiLp3snNiqNHDjk4csJiCevgQCv/1Son5bkDLGW9yJbr/zdVBbMs338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=zqoS9Ja3; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710070912; bh=I4A1mRf+nnfvFlrOIk0IJXTuAiKh7+M48w5pBvyMqk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=zqoS9Ja39xuxlTnb5TDqR8m7tEVkHPzWghfILgE//qnBaDYdjRwMsZGqFZHH7Y6uP
	 VYInNHjsRNNK/avnwV+mnuVPVL5GU2iIjaIxSKIc3uF/TeuQwTufm99t50D9CN+xob
	 9b5OuEJ+HRYApGDvoxqIc1goWZtmU56MsLcYkxcA=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 10 Mar 2024 12:41:08 +0100
Subject: [PATCH 2/3] dt-bindings: arm: qcom: Add Sony Xperia Z3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240310-shinano-common-v1-2-d64cd322ebca@z3ntu.xyz>
References: <20240310-shinano-common-v1-0-d64cd322ebca@z3ntu.xyz>
In-Reply-To: <20240310-shinano-common-v1-0-d64cd322ebca@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=707; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=I4A1mRf+nnfvFlrOIk0IJXTuAiKh7+M48w5pBvyMqk8=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl7Zx9gJTvxkzv/Lc2oQoSd4x5Q5Q7pxYGOFg6r
 NRz/PQWYEqJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZe2cfQAKCRBy2EO4nU3X
 VgpqEADN0DfsiwibNLGK9dMCVvHG59TYghiDMQDE8oL2WSNuPOQziE+kjFsBcY6OCAByr/PMvSn
 mQEIJEYf0H4gawvaKG6zXdEgQAbg688e8wPwjsAnX+1Rsqa0gJTY/+C2UKigl9oixI+Po2RoYmU
 Cz0HyQ7hWB+M8kuvmiPOZ25MJNbmHGvgfrLfNUZhus8wS7WKxr8G/YQ37R19YG2wLSE4qA/Zw51
 iJijUNY0MuNLEyYQfMzsIqlumPoTaBKsUBSAC4j4O16CXJMQ+j/ageaRN8cXnVk+JtV4Hhk+m4y
 ZJuztp0+dX0fuIg0t6jcQeSwtAzR/ihJEYRntm50jubhl3qeM/h5l8ZuaXfPkrN0A+bCpjx44ei
 5IsmIbmxNwbr1Ph8nhbL77Ref9GZ4e5d74cgtKgJYA7QK3ct+Y6qEM70EqiSR4x0Sy3D7z2fwzZ
 3q2xfQMS1gmBJSp6XHcRTIA+RhOl+pEZNeEjzjnBVcT/0W7i5zvczZ33tBgL6KSNgJ3nSuKShgW
 jOCeAKImPys1gRoPgx65gvtHGd/vi/3ZSLmZGHAIMdhnxQ3xs6f2Rt4mq7faDMAejTY8fBwqLSu
 z7aHxHEXhTAsm72mqTaWxus77nSy882Xx3Wg9/zXC73j8p+ioN5sThbK7zVUq+f3hYf754Avggn
 iDiZRB5l4P2/PgA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the compatible for this Sony smartphone.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..d6a7ee5e1d91 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -224,6 +224,7 @@ properties:
               - oneplus,bacon
               - samsung,klte
               - sony,xperia-castor
+              - sony,xperia-leo
           - const: qcom,msm8974pro
           - const: qcom,msm8974
 

-- 
2.44.0


