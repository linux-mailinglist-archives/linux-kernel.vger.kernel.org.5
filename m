Return-Path: <linux-kernel+bounces-27659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5E882F3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844631C2382B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646C61D554;
	Tue, 16 Jan 2024 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="f0aF9gHl"
Received: from mail.fris.de (unknown [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E11CF81;
	Tue, 16 Jan 2024 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428696; cv=none; b=Fc3JJ0XfG8TGVhD3kyhqAEIGTbTyC/FlqONepimFn/+4zHtEAuRR2UNRcqO5kuy8B1jyTia+lFv7VFATegBXWAh8UMTKDlgPMzTG28YwiNbODWorX1mQMMA0lT6hihV5ts7eCQfhNPPEflbbnCRJ3qCM5iJoQqezqNUoDIrip1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428696; c=relaxed/simple;
	bh=XbWgE+CYL49hgwKT8v3/GrBBpCtWLXV0q1Pbf9whgH0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version; b=csMG1dRTINM/l6TAPLIRCtd/MzniHCHvkblWB4jZ2M3Ws9dM5CDZPagm9IfznR2HiMeHlyHnZF4XQ+MtqYkL+LJdZBZ+L89HGkbHejmAkvOjYZ7gG06W6HcyHS22itDGxIKeG8GBAhTLctxVHqxWmZt95LnlrGdXDNPmFWSWVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=f0aF9gHl; arc=none smtp.client-ip=116.203.77.234
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 846ADC035A;
	Tue, 16 Jan 2024 19:11:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1705428693; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=MhS5GDYFLCMXV6OqsNcSGAUTSMO7Y4+ZUH6mT6ZU5jw=;
	b=f0aF9gHlXSSRfhqtfRTyIYKcdkBRMcd7wEQop4rgB/9KHuctY9i+8wZkSmlAjtMHxxui9g
	Kv5DXFviGM7gXxTA1y8f9RY9zhJia/LbLnwq0ULVdV261slZt12qL8440kEsPbl6oaVup4
	SweJm3yd1TunY9SXrXeJiP4cp6gUQfW7hcrFmp6kGJ4+yl3pZYQaaL2geitBWxPKde3bk6
	LlimVUygy0cRxPB/YZdRvTOtjgw1fi75F5HrD7A7w+nr2zt+tHcSZPwV/a+vtrCb/F0G6e
	Wo34Jz58EK0ziabD2jM1Y2Jc8Gnpb9MAkjOsvmE4eNlBNAC+xynbW43ddioa0Q==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org,
	Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Josua Mayer <josua@solid-run.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 2/3] dt-bindings: arm: fsl: Add Sielaff i.MX6 Solo board
Date: Tue, 16 Jan 2024 19:10:27 +0100
Message-ID: <20240116181100.382388-3-frieder@fris.de>
In-Reply-To: <20240116181100.382388-1-frieder@fris.de>
References: <20240116181100.382388-1-frieder@fris.de>
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
* Add Acked-by from Conor (Thanks!)
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


