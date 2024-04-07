Return-Path: <linux-kernel+bounces-134315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E1D89B03E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B181C20A3A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3FC1DDF5;
	Sun,  7 Apr 2024 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="gBMHA8Ok"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4A1803D;
	Sun,  7 Apr 2024 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712483945; cv=none; b=dvbQQtisRYhSIXN3svJ+yjVc5xQ2FVIeaifkdQAZxZg/+cncn/57mK8S7/spZr839lGHk3vSOC41HEgrrSep1T/dPCbwDd8VaygZxsUPMPGgw1htwx02Xj5pvVZdxJCui0l64GsjF035jEY108jjdoJSYK2aN1gKfAVqqNoqn7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712483945; c=relaxed/simple;
	bh=WjPOf9k3nwhewS3omCTcjIA7XrxAEkxjng4ePhM2H0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h7zVx6cbKEmp7yBtUiSszDxuz94/iCXz6fbFxWuH32VadvNN7f/M1UeEwbjSAYJ+FhbBg3rPsJShM1gmQlVhE1dXtQ9gWeyvgpL2uQtiM59Uo6iVZbFWHsXyG/LJ2x+53sMwUYekF0PORx6qYcOHY0ZumE2E8Nj09GkgqosbulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=gBMHA8Ok; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712483942; bh=WjPOf9k3nwhewS3omCTcjIA7XrxAEkxjng4ePhM2H0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gBMHA8OkpAyKizvWrePKqi2r8HLPgUmFKb4at2uyBUKFk0m0DfxxyKVPA2AszzUyP
	 ruJiP0WH5UsxdpfEY8HNMdvtirr4Rmw6mSG/dVmFS8DxLcI8Np9Audw5tVy6NJNul7
	 2JYvzDWm9Et9aZXPlzHtWaJbyCs6pl1QkoJ0rcOk=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 07 Apr 2024 11:58:30 +0200
Subject: [PATCH 1/3] dt-bindings: remoteproc: qcom,qcs404-cdsp-pil: Fix
 qcom,halt-regs definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240407-qcom-halt-regs-fixup-v1-1-a0ea4e2c178e@z3ntu.xyz>
References: <20240407-qcom-halt-regs-fixup-v1-0-a0ea4e2c178e@z3ntu.xyz>
In-Reply-To: <20240407-qcom-halt-regs-fixup-v1-0-a0ea4e2c178e@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=WjPOf9k3nwhewS3omCTcjIA7XrxAEkxjng4ePhM2H0M=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmEm5ihNfpd7tpLPqcNtFlLWyPn2+9lzCxB35Ur
 vimLq0hemCJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhJuYgAKCRBy2EO4nU3X
 Vsv8EAC8pce2P1kNFUK5gOqTALLo3lVpodVhZNmgq/jLWpyxZzDIWejIfQYB/MxagkVkGB6unJt
 AMSusasQ9EIjjkFJtjr7cpBvW22AP0UDP5T7zJOAOElcP9x0GVjKB6dcBIIgkdPSCCOWvpLoHXE
 w+Zw2NlnycXGKZ97ZR73zwfrG1lGARU50/ijsh5KzMNjYXqN6kJsQGbudSxImPIMN53Stm6Ul9k
 J3r/25cNGyZW2uYfRPqTeX9cbVlIWeET/XrfauGmbRN0fH3+63pPnZ8V1gXR6WjIQHxE6FOETMT
 e/WJqrsLEQL7MPQEgBQsrO2t1yM4eloIrhboSazpvVuKUdo1Ew8U4Vv80UB740JPixWwP8v6pVM
 2O1xMYR3p81O4RpU+9uADm1RAQzccutyeInkhVDDOStf8YCSSpmekrG/3N8l67YkeGuujcoezVP
 knMUu9nmD+omaSM4rfnPuYVcfTiTPkv920djbcVh/WDGm7fJjFIHrLuGcXyYA+rAJd22yoypnXe
 Fov1siLHMj5yNd374e8BlopvsR0Gj8BhijSxuWNtwcCC7FWULZggkKZUdTqsERdOxohG/upGzho
 7BnUCTZCV70dMwgfNdpIZERYEQkxLiSMj2ESbcpDt+J6hXnze0N79F8H2r6SGnRVHoJm392pDNz
 kse8Q9bbg9kADeg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Set the 'items' correctly for the qcom,halt-regs property and update the
description to match what it should be.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml        | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
index 06f5f93f62a9..bca59394aef4 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
@@ -81,7 +81,11 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description:
       Phandle reference to a syscon representing TCSR followed by the
-      three offsets within syscon for q6, modem and nc halt registers.
+      offset within syscon for q6 halt register.
+    items:
+      - items:
+          - description: phandle to TCSR syscon region
+          - description: offset to the Q6 halt register
 
   qcom,smem-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array

-- 
2.44.0


