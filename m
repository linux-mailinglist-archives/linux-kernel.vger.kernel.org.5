Return-Path: <linux-kernel+bounces-103707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A589A87C334
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6B11F25B44
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E1763EB;
	Thu, 14 Mar 2024 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="Qcqpb03x"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B676053;
	Thu, 14 Mar 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442615; cv=none; b=S/RCg8mX8cWblxqr9AayJkMdXjylp84AplB/OByIgShHdv4AYgKfJDGIzekBmjabn6ZmfEdF1TZqVIoitqil06UdpfP1y/JQzvloFlh9Rf4Zweg3fWQPwDBl+orKkqgK6lZ+i0kL1D1I/PfKajguuAxVoZPJfEbCo6KXsfs8jT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442615; c=relaxed/simple;
	bh=lYbYS5yoHLJHaD+1HuvoIkpzmsKK3QGoKfXGJRdyE14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sorf6LNg8AMPIS3vnoZ65jjLnk+K1PyAzH+fiQS3Y13B4KEoW4O8qToCq+I3KF1Q6p3rGkLNV/OWKSXPXQf2K7/iqOmeggevowIUV5/VWHQJB+JglehpzYIIW+NFIpKPFbY1shcX01UIpmtb5ubRWMQvP2J+z1XRc2Xdm1INzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=Qcqpb03x; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710442605; bh=lYbYS5yoHLJHaD+1HuvoIkpzmsKK3QGoKfXGJRdyE14=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Qcqpb03xmq9jccd9OX+mhvPcqaiShoBzN9+b4D+SLjP4knBsvjVuwVptA59A4xhWt
	 1aZtQ5s6MmW13dI9gLpPH2V3ZD87AeII590TLhIt054MuqA28OzcSzLMFslg9ITNOY
	 E0eeD+G3s4VcG1koRr4R6zQ7jWwhyYFfUFeTgAME=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Thu, 14 Mar 2024 19:56:23 +0100
Subject: [PATCH v2 2/3] dt-bindings: arm: qcom: Add Sony Xperia Z3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-shinano-common-v2-2-a0fce1c72c74@z3ntu.xyz>
References: <20240314-shinano-common-v2-0-a0fce1c72c74@z3ntu.xyz>
In-Reply-To: <20240314-shinano-common-v2-0-a0fce1c72c74@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=771; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=lYbYS5yoHLJHaD+1HuvoIkpzmsKK3QGoKfXGJRdyE14=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl80hl83YqROvOUZcxIcQVHFyGX2A7XfD6MVBGI
 Nb7qjT8122JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZfNIZQAKCRBy2EO4nU3X
 VobtD/9V/efeE0rFtQdDfQrUABxKgO4wD6dLiDK3L9fc1pkOJPWGEjaIZV9zoNkqsJ3WN5KNIFn
 QwoZHv6E+da8UYsnf4SeAidFY2wsHYYgLh9hcDzjeqmhWn++myy2erctNvUKyRv3Z4fhQAfOffM
 B+SQV3oVM2kzrV7kyUDePGv3ZJiIMM4d6iPsAY2Fgb0yIp369OLV8YrPNkFbokNw0D/nw3xNcau
 YhTFIdnMw6jSSLhScvWOp4+e7aqHCG4ZqtKeBjEaMFpeS4vivf3Th3sQw2QSgV04dlNJ0fDp4BP
 W+w5DKFyxgy/WpulhPIcepRDkCTfQdtG/LcZhbOhUiC7zYsqzJ5kde6cNtS5oU4EO0Pwo3NkYyI
 5Abn2pUBf/MzoFoIVG+kjcgxidU1GmVqs4Kix7TAVFE/KqSbHaudKqYyT0YpWK/adtvqlyZWcKs
 KkMJWfW5eVDA21CKQWwUv/lcUS0bOYoT9EcqHIcOR70LO14/tVRT1y+dH+t52H8NzsV0R1ZUfTu
 864jvBYnrQjWznRkv2xISlnX5OPdXnyQKQhX3G3QA/V1O6p+b/WIsGlKJZdlyvzoTDDa26D7qOZ
 UhVhJZD7sT6dGSFrkSk+cMXmYR7ZrEq5GIySAe3yPsR6Nb1wJxpbpEHvSNk36ktQjMIWPG7ofo/
 w6bDXR+wNFyPKGQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the compatible for this Sony smartphone.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


