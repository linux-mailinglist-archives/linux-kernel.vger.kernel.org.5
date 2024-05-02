Return-Path: <linux-kernel+bounces-166378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471D48B99D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A5A1C22CBD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090D3604B3;
	Thu,  2 May 2024 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="LMwzycgt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZX2MdgFB"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6525EE78;
	Thu,  2 May 2024 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648416; cv=none; b=Cp94ht9zYdgjDMYowRPECSddPuu0E9UT+4makhMaDR6t4oBZl1+8X+fO4IbCIVLITPtdZoKb8OE1R0TneSMlS+PZx48siY8fLFY+mkXh+bvjUKb29jCtf9bsViOjew3F5B0tEgf7K9YDExDLHrKoq13anSDYrIxYgIbD6c1xHaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648416; c=relaxed/simple;
	bh=aEuGJn6C2hjQqBv7yfjTEeMXV7bZQW48JcGE/PzMBbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bFJ5JtWPC+SdUF8duL2mAKW0Mfzs1sH2KbBqP0f2ga0Bu4J53MAT4l0/LGaVk8uCJEr+RaNyz8U48+DkyLAnmF1dcoDkHfzY+BEt0QfOCdImM/dNyTOgVcr18mk2IwFYNm3zFGLl82CLX7ih56Zh06hQiOFwniTH4LrfxWODBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=LMwzycgt; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZX2MdgFB reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1714648412; x=1746184412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=53pHXiAdsvwKPhY16IoTwzigk+Wig4043dPMtgU7Yoo=;
  b=LMwzycgt317JxrgboHiAf8R11hnLgIE+F+68MQiDmBir68ISPVrdvFdH
   JsedkKMqktReXqVoN4jg1qTWhFAHH2Aldm9J6LSP7p3XBCS3TpXqbdkv2
   NXBvAIzNWJJifL/Zcgo3c7O+Yk9qaS5BayrYxgtUsBRO5o3zRbJgkMK5k
   XQR5dpt+pBi6HtJQXaXo0mz2WSUk1/BXcHuUPO7XqsaTbrKWHveZYtSQR
   GAZq01YXe3tVggb7IbEzmeXkjOjovE/lto5DcDpKhpZY+/bq2oHi2mpVq
   PtunXFKfW74Dl4qxHH6FLtm/8UErOX85G9iJPbvsAq9+YboN8lybeD1Sw
   A==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="36716023"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 02 May 2024 13:13:23 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3D7816E1FA;
	Thu,  2 May 2024 13:13:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1714648399;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=53pHXiAdsvwKPhY16IoTwzigk+Wig4043dPMtgU7Yoo=;
	b=ZX2MdgFBttEkrDWIv8wZMczVxO4zmIWtUCopSkPQLieGUlyXH0uvTCzBUgfq1VfnBZhe/f
	Bm+evIUDxSke0tB22HU+Rp+l8ERNQPtHWHukwNdjqgxjyNasLX42jC7PRnWVAuj7z82JAj
	tKyEJmQuBLhLNEdxJqJC1rTWS2M+FFjuPPGaYO0A0TpiA/+PZAkh6CkQk9upCcpAAbATL4
	cMci5I3NK439pVgKsK+FHk43s+utYkZph8lUZ7koq6iJiEPASNeFrzm9U2MJKE8h8rERLJ
	0AOsIWldHXH3su9cbPzYTkARDLsTTb0VdWOsCWVQdY99Uhr0cOzTsEEG0c1jdg==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH net-next v2 1/2] net: phy: marvell: constify marvell_hw_stats
Date: Thu,  2 May 2024 13:13:00 +0200
Message-ID: <24d7a2f39e0c4c94466e8ad43228fdd798053f3a.1714643285.git.matthias.schiffer@ew.tq-group.com>
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

The list of stat registers is read-only, so we can declare it as const.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: New patch

 drivers/net/phy/marvell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 860dc4001d415..a57ad53cd09cb 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -313,7 +313,7 @@ struct marvell_hw_stat {
 	u8 bits;
 };
 
-static struct marvell_hw_stat marvell_hw_stats[] = {
+static const struct marvell_hw_stat marvell_hw_stats[] = {
 	{ "phy_receive_errors_copper", 0, 21, 16},
 	{ "phy_idle_errors", 0, 10, 8 },
 	{ "phy_receive_errors_fiber", 1, 21, 16},
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


