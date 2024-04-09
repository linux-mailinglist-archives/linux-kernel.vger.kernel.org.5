Return-Path: <linux-kernel+bounces-137503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17FA89E2FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009A91C21087
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D991157E9C;
	Tue,  9 Apr 2024 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgregSBu"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E86D157E66;
	Tue,  9 Apr 2024 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689728; cv=none; b=mHG/jjvVEDe1vahCLKo0r81EDhCR9aZm4pPIrpkQcolvWSiSCZm6W2Mo76DJ1R0S87nJln5nm+jtc3+thaJVmPNkJ+0LN9WhRTRyrH2NuoZlBRIZL7vpNzDEoEInui4mZlXknFl+meDGEBu+t9+CwRVu6VnashIpvGfaHno7HHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689728; c=relaxed/simple;
	bh=WrOGNkfl6FdnCGOJ7wXflZrinARRn6qOE75KPRt97Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AjjObN0ocsOJ7Jc16LZuI012gEcltrkOrLGNxa/VR/2fSIpqRbhtcLa5G32IQ7T/yzm59uQU8TPSo+uUgkDuaQhW+2ojVFs+xKqhC8SUBuyXUBi+PiLnRYZo84I4SOKPSpL/+uGC4mAWyzKpHoS4KjngrjVP2Gqj6lV413mOxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgregSBu; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a9c875ceecso3318818eaf.2;
        Tue, 09 Apr 2024 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712689726; x=1713294526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZgmkaydqDgMItdlvtLLtr4XRisZHdvGf+UHvwLYIo0=;
        b=UgregSBuwqKUlxQhWW2zUQQraZkXmXiZrllo2BS+S7Wega5OBZPx0G7KarRq/DPmW/
         rHAfoVmUhKZRcqDTcwQyiMxZKr51c0mDoEpBTPUBxLGKQyaTisuVlxTl0qqCf33XJSuD
         6LxmaBo15+JFRJn7NkfJDwFaVgRLRPvZkXUGnkXd3RRkQktut8wwVyqs6uIb6+tCagIQ
         0QTD544QWWjZiw6kX+YLiLSmhxkU9yXBIGcYGHBPbBp11fIqTZQqUlruE0s6QU7hp4i+
         3ggmUPPx0eqj9FTkuT+APmSXtuPHxGc7mXs12SB33YKkIrT0ESxnE6mZpq3QvXnb8b/j
         Zt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712689726; x=1713294526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZgmkaydqDgMItdlvtLLtr4XRisZHdvGf+UHvwLYIo0=;
        b=qLU+lOvfeY7T504I/7VPYSnwVUVr1pJwyHyn1l/vYRVTmCOInvGs0hL1JmprfzHlOU
         WY5kmwyQE6Fky2096UVmOBeU3K7geigsJH7Muw0WqYaX425/jQ1Rz5rPPprUbq7u9hrs
         dH7k9KIpon8Rl4wkN2SXu+d5hvqX4ysQ3E34ER1XyG4B78icmpoDgQMkxfFWInmy6DSF
         hosWKeI1Rn4ufpu9fc6WJXSZYqIAEBSopeNoPARFlOdAH5wL48Ju0Xw868V5DGMtdj1R
         74SxGtIBo/gKaZudtiSooXLH5BZdBjNEoyxXRWEzMI/EGV61FrY8975JGzP544WYj0y+
         If6A==
X-Forwarded-Encrypted: i=1; AJvYcCXFAak/fPhxtF0Jo2y5VVJnZPte1ii5VfMM6yCVaI7JGGhNP9hg+N3VkN7mfh6Kw98FVoT/frrir8Z/K6y5sjnu50xofUo97B5lGHF3XI5o2XFZVyzpgqJzHN0w94F+w2yefHY9WeTO0OXHB8lg/Q7MAKfBm8qPURlqlyE8/Kg4PihWvo/gYGY=
X-Gm-Message-State: AOJu0YxrC3vHugwnbb+Trt5qMykOD6hlfAKvOn95r+bEbo0Q+O6yuw9U
	bkdnoF7mKxycD6w7iYszYsGJRWEDgFrIqIpA9O+4TpBS9ElJ3I7Z
X-Google-Smtp-Source: AGHT+IGiME8d4pJkFeFHGfQFDyNAq9/Vl7xfXdxtFnHfzc4Tw8Y6pdQ+xVXSrnZR01C24EMRzlNnog==
X-Received: by 2002:a05:6820:1e02:b0:5a5:21df:7eef with SMTP id dh2-20020a0568201e0200b005a521df7eefmr877211oob.2.1712689726402;
        Tue, 09 Apr 2024 12:08:46 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id f11-20020a9d7b4b000000b006ea1cf91a8dsm674920oto.40.2024.04.09.12.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 12:08:45 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] dt-bindings: phy: qcom,ipq8074-qmp-pcie: add ipq9574 gen3x2 PHY
Date: Tue,  9 Apr 2024 14:08:31 -0500
Message-Id: <20240409190833.3485824-6-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPQ9574 gen3x2 PHY is very similar to IPQ6018. It requires two
extra clocks named "anoc" and "snoc". Document this, and add a
new compatible string for this PHY.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
index 634cec5d57ea..017ad65a9a3c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
@@ -19,19 +19,22 @@ properties:
       - qcom,ipq6018-qmp-pcie-phy
       - qcom,ipq8074-qmp-gen3-pcie-phy
       - qcom,ipq8074-qmp-pcie-phy
+      - qcom,ipq9574-qmp-gen3x2-pcie-phy
 
   reg:
     items:
       - description: serdes
 
   clocks:
-    maxItems: 3
+    minItems: 3
 
   clock-names:
     items:
       - const: aux
       - const: cfg_ahb
       - const: pipe
+      - const: anoc
+      - const: snoc
 
   resets:
     maxItems: 2
@@ -61,6 +64,32 @@ required:
   - clock-output-names
   - "#phy-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq6018-qmp-pcie-phy
+              - qcom,ipq8074-qmp-gen3-pcie-phy
+              - qcom,ipq8074-qmp-pcie-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq9574-qmp-gen3x2-pcie-phy
+    then:
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 5
+
 additionalProperties: false
 
 examples:
-- 
2.40.1


