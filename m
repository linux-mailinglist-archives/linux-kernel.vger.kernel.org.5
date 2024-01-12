Return-Path: <linux-kernel+bounces-24457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A782BCCC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF5C1F259AD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A5756760;
	Fri, 12 Jan 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5k63JAL9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9E56B66;
	Fri, 12 Jan 2024 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705051066;
	bh=O8R6Tl/ZTR5Muen1a2GjvA7YfWRZPwhCu3cK0cZsUbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=5k63JAL9T/PxRBRj1uDPUsNOUUKU/q6vAvnFCwyKRHFGnIo5syqMLPy3iSuQ0B3Nm
	 tWotH14AUl1hlNj6QgQJajHpJv+Ufr+fyBNjvb8m184SW/CnPRAenc7mkw3lTnffn7
	 mH8tfxgcce20a22DS4nLZGFXerZcSfYiNXHyEyAcHDF6oe57wjTrE5KiBfUm0080zD
	 7TmZlMRp1K6R7MRRX4hfhrmiRgFeAhMBlgaXk9u3G9vLu89gGbGQHd3RrxU3zJc9nh
	 GsGo3HMeo1bSwpBRUL2ulgikv5auO9h3mS+yMLuygnXA5lnukSzPSLR0TWVGnSB88u
	 I2Df60o/EOnKw==
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3ED0D378202D;
	Fri, 12 Jan 2024 09:17:46 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
	id CA3109ED98CE; Fri, 12 Jan 2024 10:17:45 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@collabora.com,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: ti: k3-am625-beagleplay: Add boot phase tags for USB0
Date: Fri, 12 Jan 2024 10:17:08 +0100
Message-ID: <20240112091745.1896922-3-sjoerd@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112091745.1896922-1-sjoerd@collabora.com>
References: <20240112091745.1896922-1-sjoerd@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The USB0 port on the beagleplay can be used for DFU booting. To enable
that functionality mark with bootph-all.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index eadbdd9ffe37..1c243ec63dd8 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -573,11 +573,13 @@ &mcu_i2c0 {
 };
 
 &usbss0 {
+	bootph-all;
 	ti,vbus-divider;
 	status = "okay";
 };
 
 &usb0 {
+	bootph-all;
 	dr_mode = "peripheral";
 };
 
-- 
2.43.0


