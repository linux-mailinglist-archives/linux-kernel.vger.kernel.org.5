Return-Path: <linux-kernel+bounces-149678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE378A9470
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9651F21378
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32DB7BAF3;
	Thu, 18 Apr 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0PXVUT1p"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BE371B3D;
	Thu, 18 Apr 2024 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713426672; cv=none; b=jqM+q29kDQ+bJIj6m3zLYxrCjZWcQg4Exom4fDxXJEKaZhPt+P6qmB9jArR1SxIdvntzc9/ZUBNXdJJ8I3aP4dPCv4fNzevBG6ARG6aJMIcptp8mg1m6V6AWGQ6uSa3Rql9uWsyTyvphnQB2zMqIJKCX9EjLuEefMOzHxL/DoT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713426672; c=relaxed/simple;
	bh=ue3wSJsGvBdnw1N4bfdmEQKVEAV5JrZU9sFns46sUdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IskmhZ26s6gk1qX0r0PdwA13ebwhAh6hiWo2d8yo6eln+frrrmtMUn1Tgd13X4eaRaim8+bcyHTX2Zd/JBMbmdu4WhcQXR6mNrkxh7tUQRtQYrMzgZNyEBOOcKJ+Z7Og6Ki2hai+ZrMbGt+hIKB/m+aIC0Xb82GwTb14ixCLNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0PXVUT1p; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713426670; x=1744962670;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ue3wSJsGvBdnw1N4bfdmEQKVEAV5JrZU9sFns46sUdU=;
  b=0PXVUT1p0/PQVnujfYIDyMSgtL2q4bNsOjTjzR477hNx2RnkkLd5joGB
   6GRPp+D64yMvKzhYXPCCNuhzVA5H85B4gMDKyspJoW2Yb154viVHvVIz4
   a0ZyHoE5ujpuZ/UIIqAic2sK+QHBnP+pGUSpBhAycd7N3YzEB0nHdgcYt
   X7qE0IeVsKHVAmpwLnhsMJTN7ehTLRvFWzlS9/soLBwEStI4Hun3kj74f
   WFeFM1MfEvvzeX/dbRbUFG3kXMg+04twfhMME8lBC8Y/gaaD82ZND9n/7
   kIyifoYE/M2MM/tasBHO1ueHcks1+MvHu5q9gzEAoQIL2xGOMPj8vlcoC
   w==;
X-CSE-ConnectionGUID: Kx0F0lTSSFatiU+MgdlHCg==
X-CSE-MsgGUID: 2X+B/dxRQDe9vjIsMgnRLw==
X-IronPort-AV: E=Sophos;i="6.07,211,1708412400"; 
   d="scan'208";a="188859615"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 00:49:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 00:49:33 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 00:49:30 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 18 Apr 2024 09:49:00 +0200
Subject: [PATCH net-next 1/5] net: sparx5: add new register definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240418-port-mirroring-v1-1-e05c35007c55@microchip.com>
References: <20240418-port-mirroring-v1-0-e05c35007c55@microchip.com>
In-Reply-To: <20240418-port-mirroring-v1-0-e05c35007c55@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Yue Haibing <yuehaibing@huawei.com>, Daniel Machon
	<daniel.machon@microchip.com>
X-Mailer: b4 0.14-dev

In preparation for port mirroring support through tc matchall, add the
required register definitions.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
index bd03a0a3c1da..22acc1f3380c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
@@ -83,6 +83,64 @@ enum sparx5_target {
 #define ANA_AC_OWN_UPSID_OWN_UPSID_GET(x)\
 	FIELD_GET(ANA_AC_OWN_UPSID_OWN_UPSID, x)
 
+/*      ANA_AC:MIRROR_PROBE:PROBE_CFG */
+#define ANA_AC_PROBE_CFG(g) \
+	__REG(TARGET_ANA_AC, 0, 1, 893696, g, 3, 32, 0, 0, 1, 4)
+
+#define ANA_AC_PROBE_CFG_PROBE_RX_CPU_AND_VD GENMASK(31, 27)
+#define ANA_AC_PROBE_CFG_PROBE_RX_CPU_AND_VD_SET(x)\
+	FIELD_PREP(ANA_AC_PROBE_CFG_PROBE_RX_CPU_AND_VD, x)
+#define ANA_AC_PROBE_CFG_PROBE_RX_CPU_AND_VD_GET(x)\
+	FIELD_GET(ANA_AC_PROBE_CFG_PROBE_RX_CPU_AND_VD, x)
+
+#define ANA_AC_PROBE_CFG_PROBE_CPU_SET      GENMASK(26, 19)
+#define ANA_AC_PROBE_CFG_PROBE_CPU_SET_SET(x)\
+	FIELD_PREP(ANA_AC_PROBE_CFG_PROBE_CPU_SET, x)
+#define ANA_AC_PROBE_CFG_PROBE_CPU_SET_GET(x)\
+	FIELD_GET(ANA_AC_PROBE_CFG_PROBE_CPU_SET, x)
+
+#define ANA_AC_PROBE_CFG_PROBE_VID          GENMASK(18, 6)
+#define ANA_AC_PROBE_CFG_PROBE_VID_SET(x)\
+	FIELD_PREP(ANA_AC_PROBE_CFG_PROBE_VID, x)
+#define ANA_AC_PROBE_CFG_PROBE_VID_GET(x)\
+	FIELD_GET(ANA_AC_PROBE_CFG_PROBE_VID, x)
+
+#define ANA_AC_PROBE_CFG_PROBE_VLAN_MODE    GENMASK(5, 4)
+#define ANA_AC_PROBE_CFG_PROBE_VLAN_MODE_SET(x)\
+	FIELD_PREP(ANA_AC_PROBE_CFG_PROBE_VLAN_MODE, x)
+#define ANA_AC_PROBE_CFG_PROBE_VLAN_MODE_GET(x)\
+	FIELD_GET(ANA_AC_PROBE_CFG_PROBE_VLAN_MODE, x)
+
+#define ANA_AC_PROBE_CFG_PROBE_MAC_MODE     GENMASK(3, 2)
+#define ANA_AC_PROBE_CFG_PROBE_MAC_MODE_SET(x)\
+	FIELD_PREP(ANA_AC_PROBE_CFG_PROBE_MAC_MODE, x)
+#define ANA_AC_PROBE_CFG_PROBE_MAC_MODE_GET(x)\
+	FIELD_GET(ANA_AC_PROBE_CFG_PROBE_MAC_MODE, x)
+
+#define ANA_AC_PROBE_CFG_PROBE_DIRECTION    GENMASK(1, 0)
+#define ANA_AC_PROBE_CFG_PROBE_DIRECTION_SET(x)\
+	FIELD_PREP(ANA_AC_PROBE_CFG_PROBE_DIRECTION, x)
+#define ANA_AC_PROBE_CFG_PROBE_DIRECTION_GET(x)\
+	FIELD_GET(ANA_AC_PROBE_CFG_PROBE_DIRECTION, x)
+
+/*      ANA_AC:MIRROR_PROBE:PROBE_PORT_CFG */
+#define ANA_AC_PROBE_PORT_CFG(g) \
+	__REG(TARGET_ANA_AC, 0, 1, 893696, g, 3, 32, 8, 0, 1, 4)
+
+/*      ANA_AC:MIRROR_PROBE:PROBE_PORT_CFG1 */
+#define ANA_AC_PROBE_PORT_CFG1(g) \
+	__REG(TARGET_ANA_AC, 0, 1, 893696, g, 3, 32, 12, 0, 1, 4)
+
+/*      ANA_AC:MIRROR_PROBE:PROBE_PORT_CFG2 */
+#define ANA_AC_PROBE_PORT_CFG2(g) \
+	__REG(TARGET_ANA_AC, 0, 1, 893696, g, 3, 32, 16, 0, 1, 4)
+
+#define ANA_AC_PROBE_PORT_CFG2_PROBE_PORT_MASK2 BIT(0)
+#define ANA_AC_PROBE_PORT_CFG2_PROBE_PORT_MASK2_SET(x)\
+	FIELD_PREP(ANA_AC_PROBE_PORT_CFG2_PROBE_PORT_MASK2, x)
+#define ANA_AC_PROBE_PORT_CFG2_PROBE_PORT_MASK2_GET(x)\
+	FIELD_GET(ANA_AC_PROBE_PORT_CFG2_PROBE_PORT_MASK2, x)
+
 /*      ANA_AC:SRC:SRC_CFG */
 #define ANA_AC_SRC_CFG(g)         __REG(TARGET_ANA_AC,\
 					0, 1, 849920, g, 102, 16, 0, 0, 1, 4)
@@ -6203,6 +6261,16 @@ enum sparx5_target {
 #define QFWD_SWITCH_PORT_MODE_LEARNALL_MORE_GET(x)\
 	FIELD_GET(QFWD_SWITCH_PORT_MODE_LEARNALL_MORE, x)
 
+/*      QFWD:SYSTEM:FRAME_COPY_CFG */
+#define QFWD_FRAME_COPY_CFG(r)\
+	__REG(TARGET_QFWD, 0, 1, 0, 0, 1, 340, 284, r, 12, 4)
+
+#define QFWD_FRAME_COPY_CFG_FRMC_PORT_VAL   GENMASK(12, 6)
+#define QFWD_FRAME_COPY_CFG_FRMC_PORT_VAL_SET(x)\
+	FIELD_PREP(QFWD_FRAME_COPY_CFG_FRMC_PORT_VAL, x)
+#define QFWD_FRAME_COPY_CFG_FRMC_PORT_VAL_GET(x)\
+	FIELD_GET(QFWD_FRAME_COPY_CFG_FRMC_PORT_VAL, x)
+
 /*      QRES:RES_CTRL:RES_CFG */
 #define QRES_RES_CFG(g)           __REG(TARGET_QRES,\
 					0, 1, 0, g, 5120, 16, 0, 0, 1, 4)

-- 
2.34.1


