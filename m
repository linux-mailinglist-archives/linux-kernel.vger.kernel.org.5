Return-Path: <linux-kernel+bounces-150186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 977F68A9B79
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391E61F22DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5576215FD0D;
	Thu, 18 Apr 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="FspPPls3"
Received: from smtpdh20-1.aruba.it (smtpdh20-1.aruba.it [62.149.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C015FD16
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447758; cv=none; b=UCCwsXfWbGMJchTEWuYSLMQRaAwXCWanY8Ra50htwHuvTEO6H4nSNvBiPn2O7s2/Ok5hGYaeGxlm/mmjennpUwc5Bsh0ItNIqwk9rZcsWYIvLPQfX2QwCsJk834h61dD02skXo5vfrvofr/5Hf28JEq2VdqODhZ6z82d2kaOJP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447758; c=relaxed/simple;
	bh=BPnGJTtrBvdVCZOyJP7914EN0dAiey74ztwFVJtarM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nk/Tyg6noyXvFJKusLOlrXwpApKI2A2kC4WNo9TDvwP5keSURZ9R3kNXC+mh1WMWmklU8Zz1I166LscWAlejZau0vjG0RnjNrAeur9Zr4zAgoePF0BeTYTBP1w9K2RF3P/YJoNz/O42a8ScHb7ufxNRQGRYE3IGq8GOSV+dA7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=FspPPls3; arc=none smtp.client-ip=62.149.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.28.123])
	by Aruba Outgoing Smtp  with ESMTPSA
	id xRz2rgYv8wWj2xRz4rpftO; Thu, 18 Apr 2024 15:39:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713447566; bh=BPnGJTtrBvdVCZOyJP7914EN0dAiey74ztwFVJtarM4=;
	h=From:To:Subject:Date:MIME-Version;
	b=FspPPls3NCm0nYqZeYqlkCZgQ3zN+iDB9qLoxTr2Pnhtzm2uYtsJaLOZfG2h4jB/8
	 GmMy7fdKJvEGe+P+4lNshPhKZBnx20HsNCaYzqBHYelZOI8GyzJfIeDd3g3zHU+FQE
	 V4R3ij8SkHYLLJE6iGRh+1P1Iw91/2BmMWO/H/rD8MqhjnVswz9C/7JFK3J7qqlHyL
	 Jh25uR64I/8IWu2s2NBf9l+goMQNsukmRa3N7LulaCYBRx2piZ6baCiLuCGYH+uC+q
	 yr0OMdSH3zBJ2b8Dm/bvGMVJTsfs7qOBYGtl74uFO79lCl9X2bVXag7cZa1sjs7EKK
	 0tLA0nRJ6e1lg==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fabio Aiuto <fabio.aiuto@engicam.com>,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: fsl: add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
Date: Thu, 18 Apr 2024 15:39:21 +0200
Message-Id: <20240418133923.3705-2-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418133923.3705-1-fabio.aiuto@engicam.com>
References: <20240418133923.3705-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLPJjMyjuC46EePe1tB96/9btQeWSPEKQd8nMiBOciL4/I/k80FuI2OCQZSoAVSxtrbAPJcmCyYr7zN2Fw1D1aVoW/BQPbue5kadG7bPGNMAufDG97zR
 DTIqauKgc9+6o+lE9x9k8tvP0SGnOiLgFoE4CGm0MArZmlpdj8ewoVcgtyKWk5HW4YuKlvVnAFB3ZVFOoVAo3Kxf31Lk5Zq1+0eqvx1/c2LKKAmWh7XndKP8
 N/JJ+QzDmUN+riSRkQ6cdU25hIxHehCNmNxsLrAndngSlAFFMgSPFlufKBV3LUHAsqB/tVlRsvY1yXQ3l3Diq3amCWHcRQfDFR6N+ZkBfFZ8O1UvcgFZyANW
 JqHNNg/MCyV1tsjFo6ZZl9KnkMYOYeM7SZGaVqEF+XT+u+8pveRc6kPSZufFfy62wQ1nz30akqCTo8HYCZca+utl010WIQOTmJJ9IH75mxfv39BHfGFVYd9r
 ZgQG4ywkWD72irQwXnnZpH6xOIL2N7+DgOIxnOP8iG/UTD7kGjE31TgePG/E8U8kIoKI4+ojQZh0Ugplr5H0omiv45+cmkw3eb1puMSGCEw+1lsnxfxyMwsJ
 nWmb+q0zQkQ09T/HFzrw0wdO

i.Core MX93 is a NXP i.MX93 based EDIMM SoM by Engicam.

EDIMM 2.0 Starter Kit is an EDIMM 2.0 Form Factor Capacitive
Evaluation Board by Engicam.

i.Core MX93 needs to be mounted on top of EDIMM 2.0 Starter Kit
to get the full i.Core MX93 EDIMM 2.0 Starter Kit board.

Add bindings for this board.

Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0027201e19f8..b497a01c7418 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1265,6 +1265,13 @@ properties:
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
+      - description: Engicam i.Core MX93 based Boards
+        items:
+          - enum:
+              - engicam,icore-mx93-edimm2         # i.MX93 Engicam i.Core MX93 EDIMM 2.0 Starter Kit
+          - const: engicam,icore-mx93             # i.MX93 Engicam i.Core MX93 Som
+          - const: fsl,imx93
+
       - description: i.MXRT1050 based Boards
         items:
           - enum:
-- 
2.34.1


