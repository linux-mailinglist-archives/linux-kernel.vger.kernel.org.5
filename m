Return-Path: <linux-kernel+bounces-150521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36D88AA076
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151DE1F21F10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5CD17167A;
	Thu, 18 Apr 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lIdzdawf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85B16078D;
	Thu, 18 Apr 2024 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459421; cv=none; b=c0Zrd1pr/5xBHBTbXS8TqpMFufgAynrFZwE/66ITvRqYmQ7RTTzfWkSyGFe8dda5G0A9LWGcPXywnMEQbOf355x2C1Bs0X0wkzEq+t5C4LKNofVnBd6Bl+F6KrejtChJDmNueUEJRibiWTKCymaTZuyYQjkj3JLp0oA48orATds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459421; c=relaxed/simple;
	bh=ue3wSJsGvBdnw1N4bfdmEQKVEAV5JrZU9sFns46sUdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y3O83N3mne+9d8rxkM53vcJ0UEXGDlHwc+qY02R51QxaLmNVMA1c4/c+IJK6Nm777Jr11cftQe+YF9DaeZh/Q0Na1GkNgvjKTZUF6wZRLKntJ4y3CsniTcWA1+o6h70mYzfqo8Wyye8PpdeKwwYwBLCguHKa64t8FDZstBGb718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lIdzdawf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713459419; x=1744995419;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ue3wSJsGvBdnw1N4bfdmEQKVEAV5JrZU9sFns46sUdU=;
  b=lIdzdawfGSHxO5ID5DufouyJm2g3gEjSOtZY5fJZiehYVlxKhZE/g0iL
   o6MhQqavk+O8/wvn8oxAr++VH3gY+6PrgUi3RhrOURvJtIrfOTuEN283K
   G29yeenW2ejQIWgZMDQv10Gb3+oJ3fAdGkzldSZ+IvCBQgo8oe46L5Ckd
   6rmhSfmZerTS6ykjK6KKv6KCwqnIOYGfkgxa4+F3R6ThSLDG39/kbbywv
   z8UrCb1fg3dby8+NJFhm2nuQ2UMVx5lk7EJYNF+LyajsBOZ1GV0eCjLmq
   k63aK0tFDl23SfvWS8YL6xG+75A7ooDHQyzzmDZpqPs+YTrZzcnY3VGfx
   Q==;
X-CSE-ConnectionGUID: Qo6wP4qWQgaZp9Zd8+/FOQ==
X-CSE-MsgGUID: OGqPZDvSSPKdJsQs7m8/dg==
X-IronPort-AV: E=Sophos;i="6.07,212,1708412400"; 
   d="scan'208";a="22186909"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 09:56:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 09:56:47 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 09:56:44 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 18 Apr 2024 18:56:34 +0200
Subject: [PATCH net-next v2 1/5] net: sparx5: add new register definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240418-port-mirroring-v2-1-20642868b386@microchip.com>
References: <20240418-port-mirroring-v2-0-20642868b386@microchip.com>
In-Reply-To: <20240418-port-mirroring-v2-0-20642868b386@microchip.com>
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


