Return-Path: <linux-kernel+bounces-52190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450D7849521
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02679281AA7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22994111A2;
	Mon,  5 Feb 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="me72vfHR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C419B11CA9;
	Mon,  5 Feb 2024 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120652; cv=none; b=mRLnFeR1u7k9A0LPZwMT0ougQVL9HA4+kyDZm3WQS89wJdmcORqUNhZ3DX9TDqoric7jOFH6G1cK4FPAEtUdBUwY5mGPVUF8di+fe0wOv9YfR+0aB4kG/6p0XJfnLik9NFZQBzrVyjNCQru3rMFE+Oa2fhjEhJIpyeixjFwyYHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120652; c=relaxed/simple;
	bh=3ucSGTFs8one78Y6iL+BGkNxpmGL9+cLmwl64Uax07E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bvYe3ILkGWJcoEw8PwfAVbdJ8JtZlspa4VO/cjTK5waFkp8YEwzejOnEFwa+ublexsDJKK/4TYf8TzFsDkpID/5scK6TLkINMY7fbZF8uXdvaubXJX3X2TWwM2Mn8legB0pXb2UPK8O+H2qI3cZseVpO7joBMZfeeWZnqbN6/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=me72vfHR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707120650; x=1738656650;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3ucSGTFs8one78Y6iL+BGkNxpmGL9+cLmwl64Uax07E=;
  b=me72vfHRYTxo9UtdkkseLaJHowhHB/L3p3dVK9MhyIZlvsvh5SrzjSqb
   uh++atguJbY7DxMvyLSLattn908pY7DRDndkKnEdyf3JWKYp4u9PU7iRZ
   U60bk6RfaYWetBovGPhJekpUO/w4tGFF7KYc4DwQVpvRr62YWjZ9FwklD
   DrzqTtWCLnvj4Wmeoo/uv2VLnVB/pkReJ2H2ohzKp79DWOVGmjjFFCzlC
   SBcTloNkw6epx6XSlZxSXf9cnRuUoMFPV283WXa9LFHy29T3TuB6/P60i
   E52PT+UnGcRsFg/ppkyQeQPUAdvrx1TEeUZ+RPmVUiE+4HlbuDjtoUs8+
   Q==;
X-CSE-ConnectionGUID: G0jFP2bBRLutVp1LQAF9Lw==
X-CSE-MsgGUID: +XWcqZs0QeGrs5xxSawVBA==
X-IronPort-AV: E=Sophos;i="6.05,242,1701154800"; 
   d="scan'208";a="183027790"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 01:10:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 01:10:29 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 01:10:28 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net] lan966x: Fix crash when adding interface under a lag
Date: Mon, 5 Feb 2024 09:07:56 +0100
Message-ID: <20240205080756.2134143-1-horatiu.vultur@microchip.com>
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
---
 drivers/net/ethernet/microchip/lan966x/lan966x_lag.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c b/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c
index 41fa2523d91d3..89a2c3176f1da 100644
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
 
+		bond = lan966x->ports[lag]->bond;
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


