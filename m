Return-Path: <linux-kernel+bounces-103374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C11087BEB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778991C21164
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7266FE10;
	Thu, 14 Mar 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="WDDJTn3o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="HEv9ioSx"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2473D6EB75;
	Thu, 14 Mar 2024 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425865; cv=none; b=eM8wvuew8Acbsn4GeYh3XJPFQWcsx4HOA1cpV0oNTUkm2ZrhgyatoX49dkCnmPKWv5FMOo2/RAD/FpIRzrGuzYsjohFVod16GT5uOuC7tENW5kAFdDHgMszturR+FCl98NR0wY+4ND3MwaV/NG75ZZ5xzdGF79Ehc4VpFrkmUE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425865; c=relaxed/simple;
	bh=jWYS2mbqsaQjwLI0uyHB/By8ZNQs56ApU/CtwXPEKwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UAnv0sJc3HsRAVufZjCKFLtyADLr9J8RcDGuUEl3IOpqr7esinLYcNjWXBb8/tcEFVTV47dcawyaf6bPqX8gHiMQl5EAhJVI4vmDCKkuBN0cPEdtpVXYSObcERRhIIL9QECXpCkldpubWGZjeUH3B1eBKzY60lv+rtsS4tVeOXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=WDDJTn3o; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=HEv9ioSx reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1710425862; x=1741961862;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OdU6t0tVGQtkwjP8lExFoZTBmDQ+ixss7zrTzXEpQSA=;
  b=WDDJTn3oXw9jU1w1CcOrndHzGHD3cgTkION5ON+/cKacTBVvI8ARtIn0
   PtP8bbbGgh5khGWoS09nccBJzUvMqeBgQiLgWTDSN7y6HuQnDV6rHBzrY
   bodeVLhBIwyhUrNH4N/oOH0DcjjJOdlfCI5+fsVlcCkJynmyPOHt0upwn
   Jhu9a9oS40XKOHK1OzD6X6OfXvMKXUq/iBVoTVrzZTFY6E0uXqDc+pcZx
   MtWVlPNC2lv+sMQew3mGjRXCfHykKri+BN/O+TNkDUJxnpWRiB2mtxSAw
   uCvJFBlTLVnx4hmGbti5wjOXfevGIBu4eVUIRLQtpmN0yXwXSnGdOIpYl
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,125,1708383600"; 
   d="scan'208";a="35915606"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Mar 2024 15:17:40 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3497616EB55;
	Thu, 14 Mar 2024 15:17:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1710425855; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=OdU6t0tVGQtkwjP8lExFoZTBmDQ+ixss7zrTzXEpQSA=;
	b=HEv9ioSxwg0rJay/2sMzYhSRLf+GkDo2Vb3bfEcOdQuK8+UVAgUulUQ+dRYAf2d9O8Gdra
	9DnnIA7qGSZ/5mzRjTiIneJkJv0pr+u7DWF5WOhXE7Nvun4ilYCrKgdEK2zQ0kxIzdC8aX
	MNGr78ULvBdAGQ80hE9EqtwCpfLKHyrHYDdNF52C05FGZpL2pkDBC5hL43DLzCevkeHD6I
	1ayQ+ew2Rx2pqVZ3lp97ZgV0WpJ9ydJJYj5ZYHcpTIj50w2/+7Fs+fDR8Urj8AFj8b8UT6
	H5xOdWauNuIxoPlgmIVaPrk5d0OgxAnZ9lcuXC5nUIe4wPAgUrKAt0jxRNqQuw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: imx6qdl: mba6: Add missing vdd-supply for on-board USB hub
Date: Thu, 14 Mar 2024 15:17:35 +0100
Message-Id: <20240314141736.2943858-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This adds vdd-supply powering the USB hub.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
index 4d2abcd44eff..9bf1cc6f508d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
@@ -298,6 +298,7 @@ hub@1 {
 		reg = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		vdd-supply = <&reg_mba6_3p3v>;
 
 		ethernet@1 {
 			compatible = "usb424,9e00";
-- 
2.34.1


