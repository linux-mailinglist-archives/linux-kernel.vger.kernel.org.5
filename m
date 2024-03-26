Return-Path: <linux-kernel+bounces-118989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0786988C256
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B531C3F919
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492AF6AFB6;
	Tue, 26 Mar 2024 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="dY81StrC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="HgTQ8uDg"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B332656B6D;
	Tue, 26 Mar 2024 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456711; cv=none; b=M+24DIbGI7FOMPkEPFWWg+VTkqVSOAmqdvgzWrgx/zTjenr4pANM4VMvb4M14WoxeEsfSh6OrCek6YEgTgVuV3N7tSgGvY8VYRi5jyWsKrsl4+nwclKrhh7lVdgfCShcIwjDWnNZGowunlTMlIk2109FvQZPCU+rGnWqJ/ki/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456711; c=relaxed/simple;
	bh=jFKUb40DZC4SPayHqkoEEjo/AYuxKlE3F6/vEvGczt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZhRyU0iCYZFX7aqeVsVwGPiFZQqKsbk28Q0FqTzs+/bARmXK9/+45KKC2HPWIrKGnooZglCIq0+FKMvlsklUHehpOs9WzO7M8ZDQFxWo+eBSVwjPfcXdXsyF7S4NeN/nH3kXqmiUhi2RET613Vp2wZ35EGl3mLxoCDsOamj8lvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=dY81StrC; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=HgTQ8uDg reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1711456707; x=1742992707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cIgfPJMO3kcEzxeMu7u2y81h8x78l/MyhCWjISx7zGw=;
  b=dY81StrCE0xfQL9+ls/4admVqW74OXI36xf0X3Ip1gmR1ef6X6G1RQrM
   RcuY6L3WXILt5eaQo6A6z4tHvUequ6MmkrmW2CZKrbRf2kqzB1oBFRr7t
   qqi8IMkeYizmSWiUh3aJLIRLGCPbd0HnF70D+X88dfeuf9N73tYgj2AXf
   qVzBA1bFDhvinCiFOFH0ILcaUuoNR0agpEVA1Fj69JK7F1iUI0j7EaIJ/
   IkWwdxlTW4wg1Li3FrZntM515hXvcDUu03TyH99C29XbfLj6GsqelaZ60
   VKBYZAh3vrRHdrcOpPj5Byjk72SclXB70vzO8HDuk0GHXfL41Cy4PTUCp
   A==;
X-IronPort-AV: E=Sophos;i="6.07,156,1708383600"; 
   d="scan'208";a="36105106"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Mar 2024 13:38:23 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98A67171151;
	Tue, 26 Mar 2024 13:38:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1711456699;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=cIgfPJMO3kcEzxeMu7u2y81h8x78l/MyhCWjISx7zGw=;
	b=HgTQ8uDgi3Z5nlRuwWttnUIPGKz6QOcUDy0hOVm4OfCYDRPYCnQwE3TXqpiQNnghLmz+Ms
	Hov4GG8MInLm/0kmrdS97TAmwuycSyTQMpD7hD8vrYWYjEZdY1uBDMi81NMttuQkKPD3Nk
	GHp8YoxgpTZiCLcNob2M1UTvG41FbDOMeUn8NgYhqDd8WZyNDxCVhWI4Ed3ZJoh4cl5glE
	6OrX7UReElz0TBHG3Qa0nXJFqUYWu/sA0pQvo/zMnXkMgQNVvmsYqV6qkgt0ymxz3TrxzW
	DcIYMTUjXjcjC+8LufmmImZfLF9aoojbeitfk6TnC+6XlS5+vOvb/2p0eKsmug==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lukasz Majewski <lukma@denx.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Michael Krummsdorf <michael.krummsdorf@tq-group.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] net: dsa: mv88e6xxx: fix usable ports on 88e6020
Date: Tue, 26 Mar 2024 13:36:54 +0100
Message-ID: <20240326123655.40666-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Michael Krummsdorf <michael.krummsdorf@tq-group.com>

The switch has 4 ports with 2 internal PHYs, but ports are numbered up
to 6, with ports 0, 1, 5 and 6 being usable.

Fixes: 71d94a432a15 ("net: dsa: mv88e6xxx: add support for MV88E6020 switch")
Signed-off-by: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

I was unfortunately too busy to notice the issue when the patch this
Fixes was resubmitted in my name. It would have been better to change
my From into a Based-on-patch-by or similar when modifying it - and the
final version obviously wasn't even tested on an 88E6020...

Best regards,
Matthias


 drivers/net/dsa/mv88e6xxx/chip.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 9ed1821184ece..c95787cb90867 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5503,8 +5503,12 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6250,
 		.name = "Marvell 88E6020",
 		.num_databases = 64,
-		.num_ports = 4,
+		/* Ports 2-4 are not routed to pins
+		 * => usable ports 0, 1, 5, 6
+		 */
+		.num_ports = 7,
 		.num_internal_phys = 2,
+		.invalid_port_mask = BIT(2) | BIT(3) | BIT(4),
 		.max_vid = 4095,
 		.port_base_addr = 0x8,
 		.phy_base_addr = 0x0,
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


