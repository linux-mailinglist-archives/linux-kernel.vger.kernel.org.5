Return-Path: <linux-kernel+bounces-24724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6364182C15A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD5D1F21BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CCB6D1CD;
	Fri, 12 Jan 2024 14:07:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591426BB3E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rOIBr-0000z6-A2; Fri, 12 Jan 2024 15:07:19 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rOIBp-002AeU-U1; Fri, 12 Jan 2024 15:07:17 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rOIBp-00BOTg-2k;
	Fri, 12 Jan 2024 15:07:17 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [RFC net-next v3 0/3] net: dsa: microchip: implement PHY loopback 
Date: Fri, 12 Jan 2024 15:07:13 +0100
Message-Id: <20240112140716.2715664-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

changes v3:
- add Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com> to first 2
  patches
- move ksz879x specific loopback handling to separate functions

changes v2:
- add Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com> to first 2
  patches
- make sure reverse x-mas tree is present in all patches
- add new lines between if statements
- reword commit message of the 3. patch 

Oleksij Rempel (3):
  net: dsa: microchip: ksz8: move BMCR specific code to separate
    function
  net: dsa: microchip: Remove redundant optimization in ksz8_w_phy_bmcr
  net: dsa: microchip: implement PHY loopback configuration for KSZ8794
    and KSZ8873

 drivers/net/dsa/microchip/ksz8795.c     | 400 ++++++++++++++++--------
 drivers/net/dsa/microchip/ksz8795_reg.h |   1 +
 2 files changed, 270 insertions(+), 131 deletions(-)

-- 
2.39.2


