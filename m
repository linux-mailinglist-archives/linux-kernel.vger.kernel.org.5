Return-Path: <linux-kernel+bounces-136696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 046AE89D731
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C24284A02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3740A85628;
	Tue,  9 Apr 2024 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q09RKB4R"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFF4839F1;
	Tue,  9 Apr 2024 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659373; cv=none; b=qyCTQBWYozqbz6GkbfnrXH8jFM1ofFiKsHhx8OSJyDN9UtRAxx1Ng+u18biunIsiQLNJf/sGJHAu5ehsPTtiYQG7RvW4uQJS56KI1SZCafXWZ/3BxSd4+CEpCBYboHWFj/ZtImf0nuN1j9irYttVBSYIofN1FcFSM0FyUwSZ7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659373; c=relaxed/simple;
	bh=zXZk78fX6ey/HH5mcDYS5WkqMHv4YbyQDlNsKpS0w5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=m1puSGJF0lJ7BBczJ2kMRlGI1sGI7yCtlAiEmJbWNlwAUS0/7obdmhiwbSWVOsr35lvun5nGDY/JP4mibxrsPkNHom3zq7eYXAa+GWe9KGPOV9RHe+yIUhuU4bMU88Dmn/htCiPSe9//PKnlo9LnXeDzsqRaTX00XcttnKtMKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q09RKB4R; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712659371; x=1744195371;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=zXZk78fX6ey/HH5mcDYS5WkqMHv4YbyQDlNsKpS0w5c=;
  b=q09RKB4RrX1R6CGF8D5fJ/PP92c985X+D6omY00DDxsER/pNKh4DbvDK
   00689esUIsTYUCse8tJa5myQqIVLkr7hIf2Ch9GtnKy7uSic4e2DLT+m7
   wyXcoHNVwEGBErF3crDG8p7DOSgxuqRwcRwmWYsnaYshXckWUDqwg3ezT
   IG2vb1V45EOZdjIH0nv2qszbOwyxW466kwXtCT8cdhSL+DCyJki7WNecG
   E8JBkKLymjn0nu7ufUEoJyyIUNDs3dQiiKA8DtM9nuKdkWCEdpq4ePqTs
   vDbyGkwfo/cO72kWXfIpF24oed+ILto6qtArHZfP0CyJeQFzjEZRTw1O0
   Q==;
X-CSE-ConnectionGUID: aYh2mCPPSBCKJQPimdsGEw==
X-CSE-MsgGUID: /BbIteXrSF+o5/uMVSDuLw==
X-IronPort-AV: E=Sophos;i="6.07,189,1708412400"; 
   d="scan'208";a="187446254"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Apr 2024 03:42:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 03:42:11 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 03:42:09 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 9 Apr 2024 12:41:59 +0200
Subject: [PATCH net v2] net: sparx5: fix wrong config being used when
 reconfiguring PCS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240409-link-mode-reconfiguration-fix-v2-1-db6a507f3627@microchip.com>
X-B4-Tracking: v=1; b=H4sIAHYbFWYC/4WNQQ6CMBBFr0Jm7Zi2tERdcQ/DAssUJkpLWiQaw
 t1tegGX//3893dIFJkS3KodIm2cOPgc1KkCO/V+JOQhZ1BCaVELgy/2T5zDQBjJBu94fMd+zSt
 0/MHBXRvpyBkjDGTHEinj4r+DpxW6DCdOa4jf8rnJUhW9/qvfJEq0Ul/Ew6paN307s43BTrycb
 ZihO47jB7PHJFHTAAAA
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>
CC: <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Steen Hegelund" <steen.hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>
X-Mailer: b4 0.14-dev

The wrong port config is being used if the PCS is reconfigured. Fix this
by correctly using the new config instead of the old one.

Fixes: 946e7fd5053a ("net: sparx5: add port module support")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v2:
- Rewrite subject and commit description
- Link to v1: https://lore.kernel.org/r/20240405-link-mode-reconfiguration-fix-v1-1-c1480bc2346a@microchip.com
---
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 3a1b1a1f5a19..60dd2fd603a8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -731,7 +731,7 @@ static int sparx5_port_pcs_low_set(struct sparx5 *sparx5,
 	bool sgmii = false, inband_aneg = false;
 	int err;
 
-	if (port->conf.inband) {
+	if (conf->inband) {
 		if (conf->portmode == PHY_INTERFACE_MODE_SGMII ||
 		    conf->portmode == PHY_INTERFACE_MODE_QSGMII)
 			inband_aneg = true; /* Cisco-SGMII in-band-aneg */
@@ -948,7 +948,7 @@ int sparx5_port_pcs_set(struct sparx5 *sparx5,
 	if (err)
 		return -EINVAL;
 
-	if (port->conf.inband) {
+	if (conf->inband) {
 		/* Enable/disable 1G counters in ASM */
 		spx5_rmw(ASM_PORT_CFG_CSC_STAT_DIS_SET(high_speed_dev),
 			 ASM_PORT_CFG_CSC_STAT_DIS,

---
base-commit: 1c25fe9a044d5334153a3585754b26553f8287b9
change-id: 20240305-link-mode-reconfiguration-fix-df961fef5505

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


