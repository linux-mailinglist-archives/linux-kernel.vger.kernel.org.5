Return-Path: <linux-kernel+bounces-54956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8902B84B55E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50EE1C2507B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECB2131725;
	Tue,  6 Feb 2024 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="W73jhNOc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05021130E48;
	Tue,  6 Feb 2024 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707222715; cv=none; b=qjKZZ8BYcRiRFOCABd3EZX9GawyRj7TxlzXZkFXC0Esq9JDBWDtptZBsAqpSU2YzcsVEdt55ET1oUTZCeH2bWB+1UGvMvIFI4CDBkp7V2O3MdBMOOuEzxRh1Em+HamsVh0yg+FXg4ScFx2rCSQQ7yKHozEu9L196uL4CRW+taGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707222715; c=relaxed/simple;
	bh=lKFmIHEUO+dJrK7RCAPNBhE2qNe6Nhep6pxKGWFpkfo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J3EWWZC4+4GEcFCz6CxbOypvRX4TF9cZd+AeTk5NaKQPeUMv9aZ+InEeohyr4znuYVcEqm70dHPx342+xswJLRS7vm44NS6NTs2Kq1cBzXDo9fAg5HJRgdeYlmjpq3v/Sor6reBCtHhrU2uU/LQXGfQZSJG4aRCAyRraWkgakmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=W73jhNOc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707222713; x=1738758713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lKFmIHEUO+dJrK7RCAPNBhE2qNe6Nhep6pxKGWFpkfo=;
  b=W73jhNOc8459Y2bJC/7CrDini+cNR1rcWAuv5NDes62zODzb37e4mL8I
   Rvt/k7S2rEh7htSOvlwaVp5p6Y9X0RqiOEea3aNbxAs8pT6Fe1KitwI/b
   tXG5yqMNL0YBdbF+4WheWWmcd+H9rmTO7Y0JuHislh2YZ9sg9aBveTLAK
   IyTQNZC2IG/J5m86jXpH9bUUOhC3MkS+JH6d0XFapdFkTVZOMPfAethVU
   lhs8vN/h04yYBMdLcO2C6Xi0A3KEjDOjIm0p2C5OiKEjT/muditudC5in
   o85Cmio0ekoaCZ6sJzqZTzNAQxEgkT4P4ujgA7czk1E0l48Kt75c/Z/bR
   Q==;
X-CSE-ConnectionGUID: VSc2D1OUSp6Kb5lb+VdjZg==
X-CSE-MsgGUID: DPYhfQf4SVCc0h/wLVDLSg==
X-IronPort-AV: E=Sophos;i="6.05,247,1701154800"; 
   d="scan'208";a="16349947"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2024 05:31:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 05:31:21 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 05:31:19 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: [PATCH net v2] lan966x: Fix crash when adding interface under a lag
Date: Tue, 6 Feb 2024 13:30:54 +0100
Message-ID: <20240206123054.3052966-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

There is a crash when adding one of the lan966x interfaces under a lag
interface. The issue can be reproduced like this:
ip link add name bond0 type bond miimon 100 mode balance-xor
ip link set dev eth0 master bond0

The reason is because when adding a interface under the lag it would go
through all the ports and try to figure out which other ports are under
that lag interface. And the issue is that lan966x can have ports that are
NULL pointer as they are not probed. So then iterating over these ports
it would just crash as they are NULL pointers.
The fix consists in actually checking for NULL pointers before accessing
something from the ports. Like we do in other places.

Fixes: cabc9d49333d ("net: lan966x: Add lag support for lan966x")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v1->v2:
- replace lan966x->ports[lag]->bond with port->bond as it is the same
  and easier to follow
---
 drivers/net/ethernet/microchip/lan966x/lan966x_lag.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c b/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c
index 41fa2523d91d3..5f2cd9a8cf8fb 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c
@@ -37,19 +37,24 @@ static void lan966x_lag_set_aggr_pgids(struct lan966x *lan966x)
 
 	/* Now, set PGIDs for each active LAG */
 	for (lag = 0; lag < lan966x->num_phys_ports; ++lag) {
-		struct net_device *bond = lan966x->ports[lag]->bond;
+		struct lan966x_port *port = lan966x->ports[lag];
 		int num_active_ports = 0;
+		struct net_device *bond;
 		unsigned long bond_mask;
 		u8 aggr_idx[16];
 
-		if (!bond || (visited & BIT(lag)))
+		if (!port || !port->bond || (visited & BIT(lag)))
 			continue;
 
+		bond = port->bond;
 		bond_mask = lan966x_lag_get_mask(lan966x, bond);
 
 		for_each_set_bit(p, &bond_mask, lan966x->num_phys_ports) {
 			struct lan966x_port *port = lan966x->ports[p];
 
+			if (!port)
+				continue;
+
 			lan_wr(ANA_PGID_PGID_SET(bond_mask),
 			       lan966x, ANA_PGID(p));
 			if (port->lag_tx_active)
-- 
2.34.1


