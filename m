Return-Path: <linux-kernel+bounces-34903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3F7838908
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E992D28D668
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D1E59B4B;
	Tue, 23 Jan 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LdrqLV50"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982AD58228;
	Tue, 23 Jan 2024 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998775; cv=none; b=WV3VkRa0sDGRe3WkQ1EjLj80phGjLc/TEAGkMIUJyfztB6VSbM6gedEIN4LjzPcXoYGA30IaX/XM2aSRsr/gDgw7JmSQHJHwNQL6TtCKPJYYVV9aKcgVUxrGKF4/g0mmCQJbW/cRfPlYNyM8J1iEuL8FZt5NGrx5FeI4oc+gc0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998775; c=relaxed/simple;
	bh=gcUgEiITJ184PeMqB2WZMxJ49L8v0mCfvJW/ucY2+VQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fI1sxByfrp35GVTZdP1F4cb6MT5bRzBWdmST3LzBVtNA8a1azwRRa9gtGm2GVcftp/Ujbsyj+ZgpjOUnQfC7SBNgC8JKuXD/53CXJXyCgbZNwqJiVccxDKZlDQq5KgTwtHJmkJqgItHkzQVU01o05e9vOrDlkRh2ceZ5tp2YS1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LdrqLV50; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705998775; x=1737534775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gcUgEiITJ184PeMqB2WZMxJ49L8v0mCfvJW/ucY2+VQ=;
  b=LdrqLV50FpFPL2s/B0ZMccp9hVtWf+1T7mS18EX3HrvDT3y2H28Y8BL4
   0pP36ZakMBhJUnysdObnJDgssY19U/Gr4G3/Dp9U3TYsRe9V+SDMSdpsl
   JE7oZcYKWy8O3Ipg7ll7Uczp9D3ikXwzs0TtbikTMek8Zt4TyMKpf1zYk
   PYvi7ks5/hy9dpAWJ1LvDwn7i0qCfsHxs33cd/Bi35wICKZurN60B6YRU
   vu1S6J5PYarUFbxQNl8HZ413l0osFEW4S+LhykX40XIGLsbqMDu3kvLw/
   lx3Tmym2O3DH+Pilyu09y+hv1tnQsxCTrk8thdWiDA5n/M8l8j+odYYjr
   g==;
X-CSE-ConnectionGUID: 8Z0MiRbqTTiGlgq+aKWHzg==
X-CSE-MsgGUID: ZrCxuTuqSFeIcJlEyQCGog==
X-IronPort-AV: E=Sophos;i="6.05,213,1701154800"; 
   d="scan'208";a="15154463"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 01:32:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 01:32:36 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 01:32:34 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 5/8] ARM: dts: microchip: sama5d27_wlsom1_ek: Add power-supply property for sdmmc0 node
Date: Tue, 23 Jan 2024 10:31:55 +0200
Message-ID: <20240123083158.7339-6-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123083158.7339-1-mihai.sain@microchip.com>
References: <20240123083158.7339-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The sdmmc0 controller is powered from 3.3V regulator.
Add vmmc-supply and vqmmc-supply properties to sdmmc0 node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
index 15239834d886..7b36e1970bb7 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
@@ -199,6 +199,8 @@ &sdmmc0 {
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
 	status = "okay";
 };
 
-- 
2.43.0


