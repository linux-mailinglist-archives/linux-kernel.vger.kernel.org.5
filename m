Return-Path: <linux-kernel+bounces-159068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 572DE8B28E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4231F23C55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0397152536;
	Thu, 25 Apr 2024 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="Z7yNjK4K"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE4D14E2E2;
	Thu, 25 Apr 2024 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072505; cv=none; b=di08Z1dF2dyNqVemCMFcl6eGXcr0/LZNyyEZNwFk6KnPjPkbB57uCnMGpdCwTMun4tsVqN6etYDxaOTaseK3qumYEv4kf3G2kMt7UHZYm8jVvhCFRYKs0VTGO+4QIGrEVqSSy6XIUSuh4fB2vVWEMrX6wcM/X3Z+ovv4PDohpEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072505; c=relaxed/simple;
	bh=rJHw5omQJciszaycw9jQ1BU1kW+IPml4fyta6y5HyGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SEYRx3HVylem+pcdAeYstjvhkjUZ8I20eN9ciqDRoC7EPoLxjvp2v4gbB61ExPU3Zefc0slYkqMQhuJFtwNSH+VbCBliuHEjwg+XKeFL1PX61R33OCoUWJgFwzA2LVuPN2+6sOjWWENdE47i+9Jr8VXrRoQtvPYxtzvNe6lSmTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=Z7yNjK4K; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1714072501; bh=rJHw5omQJciszaycw9jQ1BU1kW+IPml4fyta6y5HyGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z7yNjK4K1pzODlL/FK7PBJUoiiZovNTRVACgihMAVg22JTGkOa1bU53YZxQZ2NFqK
	 TT6jAchcKILHcOoddgB8IBXKSR/5SKvLnATRBqoEBZgm2xE+FOAC6q2VG+kYJlfkfj
	 SYBCPkLfK8WqQ++7swKY8wUK+2tHTi61ulWQbnww=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Thu, 25 Apr 2024 21:14:30 +0200
Subject: [PATCH 1/2] dt-bindings: remoteproc: qcom,smd-edge: Mark qcom,ipc
 as deprecated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-qcom-ipc-deprecate-v1-1-a8d8034253ea@z3ntu.xyz>
References: <20240425-qcom-ipc-deprecate-v1-0-a8d8034253ea@z3ntu.xyz>
In-Reply-To: <20240425-qcom-ipc-deprecate-v1-0-a8d8034253ea@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=rJHw5omQJciszaycw9jQ1BU1kW+IPml4fyta6y5HyGc=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmKquzDbuD/7Ocdt6L6llEaZ1wSZthFgiHqehAe
 ICMe6LF7PCJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZiqrswAKCRBy2EO4nU3X
 Vt2HEADIWIPaIpe25qijWBb+g56aLiqyKB1aWMpA10jb1Uc8li/5DZy1GcIk39jkilNHtEVZKzV
 r762c63ZpoFeJVNEKFzp3fr4e8zKIHQajP4FBgwzH5WNB3F7oyaH3YKHbz9UHm7LvWGOPRCX+rO
 +3gOD27h4cP9m0tzAYsKW9H4qfAPBJqNGsCgumy3VkiiuLPXxLn54jzK2WbHHrotHyqiP4Hg2+a
 pDrJfC27imgrVD55s28Qj/SkILXad789CGIGhegkS6zLN6rMyNnXmfXymuAuigDBfdGCp7/ZG1L
 Hr56xqe4uKL42SCnzIskgDvrAWlPiG9LyTkRdmTBtxRPoijHJyrUNpeiYrbBUn6ZB9gorPEwNgR
 MM4cISfcfUqnyl7b/+n4wnnoCesYgOL20c9ukKNN7m2yjjgSiVKq9kVv/v0RO9GBhT6Gin7fzx6
 sPn7xKA/1rSth1m7xyJHmsHe33gNThzvlXnSCW/2O6KiBsYkKNU0JnNvsGM+9t9A59KNToFZJxI
 7Y0HlzO+MOlyfv4ZGO/YS+HOaoTNL8SexA0XG4jaRhUGjR8Cq3rSrw7cj8lh4a6Nfo8krXqyFK9
 CPVPBhvy2sJxnR0sHKFZfvgSeg0mxMYWzehMsOBGKlgkYKD938OH+C+qfNyReMz+BLjbxesRjw3
 dEjGDgymVrw9+yg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Deprecate the qcom,ipc way of accessing the mailbox in favor of the
'mboxes' property.

Update the example to use mboxes.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
index 02c85b420c1a..63500b1a0f6f 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
@@ -61,6 +61,7 @@ properties:
     description:
       Three entries specifying the outgoing ipc bit used for signaling the
       remote processor.
+    deprecated: true
 
   qcom,smd-edge:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -111,7 +112,7 @@ examples:
         smd-edge {
             interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
 
-            qcom,ipc = <&apcs 8 8>;
+            mboxes = <&apcs 8>;
             qcom,smd-edge = <1>;
         };
     };

-- 
2.44.0


