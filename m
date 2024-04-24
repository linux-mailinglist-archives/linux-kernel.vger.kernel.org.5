Return-Path: <linux-kernel+bounces-157330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548D28B0FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9E4286CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12EA16C854;
	Wed, 24 Apr 2024 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="KxZb4Ihh"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCB01598EA;
	Wed, 24 Apr 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976464; cv=none; b=fDMRoPwQOwDlREYs5CfoF1GLx7eWfjt12AaaS3RY8x2hzfW6IXcPg18WrYg11JQZqiyXDMFgt7Wj0+y07MgJkB8Pvq7zNnTYiTHxdJUh8TD8fOsN4Tz7v/ltSZFafYcWC2UA7eq4NihAfr/iHiqZOGdo2B7q7sh6dqPf4njadQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976464; c=relaxed/simple;
	bh=R1dglupSB88KtRABHMa3LWVRmrMi6PYIteYLYg2xY+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Te4JUAU12sja+UevVDKK8x9JG2OmmGJ6+TV3Scmx7bgJ3q3ftCYSJH2liPjWM/gpL52Fow1dZV6RZqP5dAxGwNkSH+mhRjHaCxcHGt5GZ5FQdIkGTfAmLEjM54QaEdm+7yIDa2wQVJdIiVi5Ulo5Cb1vIzqSJbJXudAKZQAAnQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=KxZb4Ihh; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1713975865; bh=R1dglupSB88KtRABHMa3LWVRmrMi6PYIteYLYg2xY+0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KxZb4Ihh7f2RXuDcs3j0c/g04nu5+VbFZWkjxS9DNmfIpAh/r/i8aHoUYATXxMNe3
	 s3obQQLRiK/F3LODLd4fLvtFZEiH5CziRCDHYwSKFPxktzsmvXt+P0B0SoAKu69/lr
	 ehg53I055DqvOCzsoWMnkmY5ltlT4Mfp3eCSN2XI=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 24 Apr 2024 18:23:57 +0200
Subject: [PATCH 4/7] arm64: dts: qcom: msm8939: Use mboxes properties for
 APCS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-apcs-mboxes-v1-4-6556c47cb501@z3ntu.xyz>
References: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
In-Reply-To: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=R1dglupSB88KtRABHMa3LWVRmrMi6PYIteYLYg2xY+0=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmKTIzWeuJ0gzE/BH7sEN/gEOMejEaQZPoSYJI5
 KKQOWZ6VouJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZikyMwAKCRBy2EO4nU3X
 Vi0XD/9hVUYVPLwAml4TsfZ6UZA6upU5mk4Eh7M6UUeTup4mwq3PSxOI5vq0TSBnboTRf0mHLgS
 XB6Lg2bmKJEafrmxHvO9NLfKO7+OTSUxUOGehvVKtwUswMhQWY+QzGmsQl2vkH6MgGs52E92IB7
 tmXrzc432OBFJg9r9zZxGjNee5tKLkL862lmLNcokI4Nw21ShFaBQAoosCNZ6PPJGBs9rBIO8D9
 rfBkmJy3/T6ZhObqppZihXUsUdClXsLiRxoolq0aV4CMg+zEoRsafNQg8va8u6SZfMrK7Jcsxy2
 gwqtMPV1t1rZilfmVrNMrkCg2DjvJpdUX74IyelVMkvJbKNANdfL8xb3ZkiQgSKvEeCCqphp98d
 pcTRJeyttUM5DILmqjpdOvvfCsa4b5+/+r+9LtRMZ+To62tJ9EgLKAju2qWjKaTIiBhgkokbNR9
 ex1A4AaLtAlta3zhiamEjK8WDQx4J6P/DI5cfUAIzNseWogdxoTFPPAW2k6UMcIT+YOQr+h9rwb
 NW6OMN8njgplCSIUfETNLdFUr5lQ6tvK/Rfl1R+SU1Aj6H86xL/4aRaxaHlLXtRwDoH/rB30Hub
 GKTEP6qrJJi93iqLVlIK8DPysx3lgzZEB5QaAzRL2uo9PKHjk1bF4gbfkcnobOlOl2361g+aSyI
 kWHYbOc6ktu7nTg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Instead of passing the syscon to the various nodes, use the mbox
interface using the mboxes property.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index dd45975682b2..95487de2ca6a 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -248,7 +248,7 @@ rpm: remoteproc {
 
 		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			qcom,ipc = <&apcs1_mbox 8 0>;
+			mboxes = <&apcs1_mbox 0>;
 			qcom,smd-edge = <15>;
 
 			rpm_requests: rpm-requests {
@@ -2067,7 +2067,7 @@ wcnss_iris: iris {
 
 			smd-edge {
 				interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
-				qcom,ipc = <&apcs1_mbox 8 17>;
+				mboxes = <&apcs1_mbox 17>;
 				qcom,smd-edge = <6>;
 				qcom,remote-pid = <4>;
 

-- 
2.44.0


