Return-Path: <linux-kernel+bounces-27277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 637F482ED2A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B78CB230A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA25199BD;
	Tue, 16 Jan 2024 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="cGWnULrm"
Received: from mail.fris.de (unknown [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E671946E;
	Tue, 16 Jan 2024 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 273F4C0393;
	Tue, 16 Jan 2024 11:53:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1705402426; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=KGsp2ET18R7VVq0Ua70B7k4zn/i7OqgsUzQBbBtgh2A=;
	b=cGWnULrmy/jcmgGRtsLEqmY8NxUQfdEgDEeNzyqWMHme28CNc+aObZCRDuF1XbRVDlVTx4
	1u0tbtjlZ6+8R+LZioRk2Z42D5GEsQLCCXUj35tBOkWhRWdOu2Uune8OlKmm1Mbng87eRv
	ypAja2lPavc3OYWV0THCib83USfe4lM7y3dq26AbdN/bSZP5aA9GC4lmrN0itvOf+ZT/80
	agNkcTyib94h5q1xv+MYh7Sb1eq/XXgoQyMOp+cNxP0C8DAS3U5tvmO/K12r6PY3HXkMan
	NlGg9DCVSNOcBQtlfX9dW9cti+hAcsEwdJ5PVeCj8VqfsZ1QXup51ex8QP6hAw==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org,
	Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Josua Mayer <josua@solid-run.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 2/3] dt-bindings: arm: fsl: Add Sielaff i.MX6 Solo board
Date: Tue, 16 Jan 2024 11:51:56 +0100
Message-ID: <20240116105317.267525-3-frieder@fris.de>
In-Reply-To: <20240116105317.267525-1-frieder@fris.de>
References: <20240116105317.267525-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add compatible for the Sielaff i.MX6 Solo board.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 32b195852a75c..f6cdf4a8e51a2 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -469,6 +469,7 @@ properties:
               - prt,prtvt7                # Protonic VT7 board
               - rex,imx6dl-rex-basic      # Rex Basic i.MX6 Dual Lite Board
               - riot,imx6s-riotboard      # RIoTboard i.MX6S
+              - sielaff,imx6dl-board      # Sielaff i.MX6 Solo Board
               - skov,imx6dl-skov-revc-lt2 # SKOV IMX6 CPU SoloCore lt2
               - skov,imx6dl-skov-revc-lt6 # SKOV IMX6 CPU SoloCore lt6
               - solidrun,cubox-i/dl            # SolidRun Cubox-i Solo/DualLite
-- 
2.43.0


