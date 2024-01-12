Return-Path: <linux-kernel+bounces-24458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAAF82BCCD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B22E1F25B47
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B928E56B79;
	Fri, 12 Jan 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4hFYb8mW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D658D56B64;
	Fri, 12 Jan 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705051066;
	bh=Tot+frsXFgaeAJ2AlshpfjEjrHzSav+eawGjWON9Ing=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=4hFYb8mWa2rCu9kDz1tMIbkZo3IHwXXUJ++49mBi7Ats44QedA/Vznx+TYa/dv2i0
	 pVuXFeCuZI/TKl4jePgfGbriR7LKD67erZIux1JbSb4sjSVi+2ONlrtkOe5uIzbHyq
	 TT2SxaPVQNhSSbLdxlyzZjTLoMGZr20QjfcYjI71tuyh0v2VOlkqZsP3W04i7nwjWG
	 lX/6VPCMg+49vqHSjqcRtqHOAmJjibhID3El/dseBMxsMCWz/VvL7N8BFZw1O29dD0
	 rsoRc+41K8pUc3QJQSGIrVFylGHeTK9mB1eCNAX7dMFTCkPgwUcWEDP/ZopFBBqF7z
	 ujYzK9JAegK4A==
Received: from beast.luon.net (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 156B03782021;
	Fri, 12 Jan 2024 09:17:46 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 9F3A89ED98CC; Fri, 12 Jan 2024 10:17:45 +0100 (CET)
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
Subject: [PATCH 1/2] arm64: dts: ti: k3-am625-sk: Add boot phase tags for USB0
Date: Fri, 12 Jan 2024 10:17:07 +0100
Message-ID: <20240112091745.1896922-2-sjoerd@collabora.com>
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

The USB0 port on the AM62x SK can be used for DFU booting. To enable
that functionality mark with bootph-all.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---

 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 33768c02d8eb..d59a8a4c0ea5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -460,6 +460,7 @@ mbox_m4_0: mbox-m4-0 {
 };
 
 &usbss0 {
+	bootph-all;
 	status = "okay";
 	ti,vbus-divider;
 };
@@ -470,6 +471,7 @@ &usbss1 {
 };
 
 &usb0 {
+	bootph-all;
 	#address-cells = <1>;
 	#size-cells = <0>;
 	usb-role-switch;
-- 
2.43.0


