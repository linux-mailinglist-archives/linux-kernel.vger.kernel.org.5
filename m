Return-Path: <linux-kernel+bounces-161923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D268B5364
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2A7281D12
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC17017C79;
	Mon, 29 Apr 2024 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="cPbIcjPb"
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C436179A8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380457; cv=none; b=jztAvCsNvRHtMtsrhGvItnt1jepM7GsbEgzaS5p5NpDgxHLpljqlK4l1BMVpfEB19xNSJF04I5CphWbbEiGdDDlw2r6V8MicaZJwZj5iJi2ijJtXI7OXsYQl8nMFxiVWfybcOjHj/JQJPZs3LiAO2BA1rt2gu3PrRzwdRzMelfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380457; c=relaxed/simple;
	bh=FfU2/VmdwOCYJk5ygqerKdlzjtUJBdYAJKCiSEkMOOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kcfdCj81oY92GtktC0x3cVNgi1z6ZiI52sc6s2K5voHdAsSo6wdcuvgamV4oWmbZCyRLoA3Y2DDB5x0H82IICFejBA0ulWxDGTyPxFc17FwN46wlMvC6v+qW/SVRzTYUgt++tiz3JPYuz76bxTGJ4vNosF1L9Y0fPAXE6uO+2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=cPbIcjPb; arc=none smtp.client-ip=62.149.156.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.8.107])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 1McasUO2u8U421McbsNcfl; Mon, 29 Apr 2024 10:44:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714380266; bh=FfU2/VmdwOCYJk5ygqerKdlzjtUJBdYAJKCiSEkMOOs=;
	h=From:To:Subject:Date:MIME-Version;
	b=cPbIcjPbS7M2cyrm5NJDGr3fOVwoy1JILmS1O7YvJiZ1JUU2YvXHy7ZARc7We3IQp
	 JCzW3wlhcnogV9iObY44rmHkxK1NXw4U/A2VnU9KIH/C497U7wPhO4+fbV/LrRum83
	 fkLuF85JTqShlYZ48o+7L+eCjN5FeX/b5e/5xzFAnSi6RLMWUDfcbFYa42I3prPIaq
	 l8tlWwnvqm7b6IuFzJEvpnMlNwwh0tmkpSH4kuvjOA2LP9aWl/G2QFBczHBCFA8saN
	 LvqM8Rt2xSI2OfRuczU6Zfw9MSJBYoElxlcCqk1a0CTSejp5rsNwAB052BYaTP0nqN
	 /Tcp1IAbIFgbg==
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
	Mirko Ardinghi <mirko.ardinghi@engicam.com>,
	Krzysztof Kozlowsky <krzk@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 1/3] dt-bindings: arm: fsl: add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
Date: Mon, 29 Apr 2024 10:44:20 +0200
Message-Id: <20240429084422.8369-2-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429084422.8369-1-fabio.aiuto@engicam.com>
References: <20240429084422.8369-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfM6qNwel1KC5Si4WV3IGnUXaGcpR6YEHXiOIiAuUFsY1bQRS6gecJCiTq2qoJBmJJHGpdS6/C740iEWDu9gKfGYUVjJTyVYFZfuQabiccvxolxEUmSEK
 A6iMqCJr7lT1g7NCz/HzjbEvWQi/gXHUPfMkrr0kA0b1CA5VZ1JS+QPtXvyOBciMrllnF7cHmPM53Bgtd0QbrrNOoHSODp3foKFKOzFCT9ba751lfn5XZPvj
 DxJb/6hV7mL3vb6SKyu48/zMioDFJ57bNN1Q9vVfnXsjR6RT3t1k+hTeDPOe7EbWJO5u0slmQGlxoM3gwg5NcBwYVmo0bSpq4sYezapMGxla9YSkGUHF/gJb
 IKEEDB9CJjt63PMbQxXU6q+dIXOVsxu5M3p6eKocQAeqQSCrT0NayflzAPeMND8gpva2YJYTG2oOiwOnS+uUH3EsscF/u1szlXPM7LSXdL2f3AqFrrR8c0sF
 gg454zM8/4SmJ5wuSe/a+FrmbPZ0dcdZRrutBmxBsN2JJIMch+IUsJvgVm7OJNM3Hoz1tVj88U91otEVmq2bOmfX1LnahgiETIKKms9QDGM5W0tetoMOKSSP
 HFcdJov2RXnXheh2rbou/Cpr1MKGkipRmX5rsgb02KSYQSvvs7ZnB+GnLVZUTj49ASr/RX4JQsoGRKDppBUKbH6h

i.Core MX93 is a NXP i.MX93 based EDIMM SoM by Engicam.

EDIMM 2.0 Starter Kit is an EDIMM 2.0 Form Factor Capacitive
Evaluation Board by Engicam.

i.Core MX93 needs to be mounted on top of EDIMM 2.0 Starter Kit
to get the full i.Core MX93 EDIMM 2.0 Starter Kit board.

Add bindings for this board.

Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
Reviewed-by: Krzysztof Kozlowsky <krzk@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
---
v3 ---> v7:
        - no changes
v2 ---> v3:
        - added {Reviewed,Acked}-by tags
v1 ---> v2:
        - no changes

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


