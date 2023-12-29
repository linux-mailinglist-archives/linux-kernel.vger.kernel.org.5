Return-Path: <linux-kernel+bounces-13144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB9D820048
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0721C22693
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5721C125C1;
	Fri, 29 Dec 2023 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="O4dcZzNV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72D912B68;
	Fri, 29 Dec 2023 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from newone.congress.ccc.de (unknown [151.217.64.190])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id B034016392E;
	Fri, 29 Dec 2023 16:33:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1703863992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P/5ISZ6OJ0Mvq7F8hX2ojwDxgD+/zwnsH6ub40eIdx8=;
	b=O4dcZzNVigyMN8pjMFbpmZw2sxFdkMilPQQL9gvMAiFOzBUQyL6FxZlZ7xnTdj4ei3BG80
	a3/MM8uKzUJq+q1jXs0UFByxghyCvkqMFxsy/VpbKY3eYqL9ju8k6rqGsDBpfEpMmKvmjJ
	qwyTuV+uLBahaARY9MDXn79v6lVPRWk=
From: David Heidelberg <david@ixit.cz>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>
Cc: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: PCI: qcom: delimit number of iommu-map entries
Date: Fri, 29 Dec 2023 16:32:58 +0100
Message-ID: <20231229153310.206764-1-david@ixit.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code or specific SoC doesn't seem to limit the number of iommu-map entries.

Fixes: 1a24edc38dbf ("dt-bindings: PCI: qcom: Add SM8550 compatible")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2: added Fixes tag

 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index eadba38171e1..c6111278162f 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -61,8 +61,7 @@ properties:
     minItems: 1
     maxItems: 8
 
-  iommu-map:
-    maxItems: 2
+  iommu-map: true
 
   # Common definitions for clocks, clock-names and reset.
   # Platform constraints are described later.
-- 
2.43.0


