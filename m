Return-Path: <linux-kernel+bounces-152360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF2E8ABCE8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 21:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7871C20A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C3C481A2;
	Sat, 20 Apr 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1RV3/I6t"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0740BFD;
	Sat, 20 Apr 2024 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713641394; cv=none; b=Ig0MAbdn/lODxvrprg60AWvrJcaToLIxsNkJ6uMwYEICdsNxfdnhpPbqyw4Et05tFpYJOCi/5soNDVNrXB+t6SdeiKtsAQ+X5uMQa9xy5eK92b0tG+LaEDYxcBbbWXTLw0lqf+a5LcynNJ8LsjWRnx589z9g8hRAZPhByPL5FqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713641394; c=relaxed/simple;
	bh=ue3wSJsGvBdnw1N4bfdmEQKVEAV5JrZU9sFns46sUdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aIumqLr4KKIDJPDa4j8EdVsoa6dIpmqN9mPbWtWzR5WvRn1JKfo+X5D2oVfXWdcgle4IQkqo+f5KVsQSnOPjv8frotO/bxkkdd5e+M6NLMxyJ3v+i2HhgysO6Zy3lejvyPgabXGtwoZwBUROdQYkWZpzC3CkWFnj9FTgdKe81RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1RV3/I6t; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713641393; x=1745177393;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ue3wSJsGvBdnw1N4bfdmEQKVEAV5JrZU9sFns46sUdU=;
  b=1RV3/I6t2pWUfyuHqX7lF5UXu7jMdq2bHyZo3uI87mgpPMtenS/eeQhd
   zggKzsZ7lP5fV11PhOaVPZ2DET7WGJPJp2eqRzC+R6eIP0VdGr9Ri9jcN
   pZ9A96nx6GiWvd6p55SIvWOB2rMNEHBaElxY9zVQkz/j34hk+X1Chwa5u
   v3Ov/Ky5ex1P7ijvAVOPkBlO8uRuXIwcpKbUlqNsyNRwu0h+sqXCX4NaK
   WGh7qZU0ZVA+PvaSUuGZjpRMsmAHglfX3aP+Y0kOBiQFrkPkrcb+WVNc2
   5toxisznQE6ySeKmXItNqnib6RQVDklPVKeekegQzAWOxWIVdM4gvLBp9
   Q==;
X-CSE-ConnectionGUID: r3PO+GVPQoGyYBK6996e2w==
X-CSE-MsgGUID: DyOyp7H8TBe6qpBDMhUneA==
X-IronPort-AV: E=Sophos;i="6.07,217,1708412400"; 
   d="scan'208";a="22513531"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2024 12:29:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 20 Apr 2024 12:29:23 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sat, 20 Apr 2024 12:29:19 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Sat, 20 Apr 2024 21:29:10 +0200
Subject: [PATCH net-next v3 1/5] net: sparx5: add new register definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240420-port-mirroring-v3-1-0fe3ac52006d@microchip.com>
References: <20240420-port-mirroring-v3-0-0fe3ac52006d@microchip.com>
In-Reply-To: <20240420-port-mirroring-v3-0-0fe3ac52006d@microchip.com>
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


