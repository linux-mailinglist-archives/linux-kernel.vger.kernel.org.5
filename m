Return-Path: <linux-kernel+bounces-32329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCBE835A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54FE1C21265
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55285221;
	Mon, 22 Jan 2024 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="mCcnkNQX"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF523610D;
	Mon, 22 Jan 2024 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705901714; cv=none; b=a26A/4Km21Ulls0F7OH3gLgt+C760/PD5rjPEGOfV4Od+zkZRTUiUH38Ab3WZ2TeWslD8/MA7qZKr1kMUxWbn3XDwALhcny5RbSBlTwODyDMJqGoSXVjepu49c1gnEBS6NO9QFXTHeiuqAhWo21PBfu3JElK/WoOVXb8frSY040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705901714; c=relaxed/simple;
	bh=hRF0aPYrIl+rj+n+zPviTduuqOvCrIt4LkBgLxiF1yc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N40J8wq9I/tVCZ+iCYC4p7+Zt/mvOzfb/D+SwibvZ5qiLVyKDTZDBl24I8mm1QMofeuo/flO1BGe3y5MYs30l3jB7xGQQHJj65GGA5DLQYr88VN5vVJHk3MKVMzdedzX56O7+6ttAQnFx9tz3ic+5Bf6Abp61ylrCdSZlYLigKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=mCcnkNQX; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA6ADE0003;
	Mon, 22 Jan 2024 05:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1705901704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wVryOrXzPY580622zM/GGPFMmmCK42LZWFJnOO2aqMo=;
	b=mCcnkNQXmoIhmIPt+q0Fw6YDW+BaCkMLbG5wq34zevtavUwCGKT03Q6t3mAkAVj/yZOvEt
	EGHDIFqygMikyutqvGnQpLWStv4JJUDjjkH5rduAwCamUDsG/gP2Hd88lnMq5/o2ol8R93
	x9/jS0ttDpY6AplTh51jI1DKX9PVMW/FJ9rM+mS3HvhT5tXzyCw3yDn1uyqjd0eXc8rtb7
	MZg0qcMpZ3e8HxN66IbNSbQID1QcKBvXQotrZT+PZZlxXZrtUHknpUqeTCLTKpfSzz4NVC
	q980fL/PjRqQMw0H84D7V+L0iZ4QUv9vLF26NuHml+6nlJNHwP4MPtPt18bZBg==
From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: mt7530: select MEDIATEK_GE_PHY for NET_DSA_MT7530_MDIO
Date: Mon, 22 Jan 2024 08:34:51 +0300
Message-Id: <20240122053451.8004-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

Quoting from commit 4223f8651287 ("net: dsa: mt7530: make NET_DSA_MT7530
select MEDIATEK_GE_PHY"):

Make MediaTek MT753x DSA driver enable MediaTek Gigabit PHYs driver to
properly control MT7530 and MT7531 switch PHYs.

A noticeable change is that the behaviour of switchport interfaces going
up-down-up-down is no longer there.

Now, the switch can be used without the PHYs but, at the moment, every
hardware design out there that I have seen uses them. For that, it would
make the most sense to force the selection of MEDIATEK_GE_PHY for the MDIO
interface which currently controls the MT7530 and MT7531 switches.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index f8c1d73b251d..3092b391031a 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -48,7 +48,7 @@ config NET_DSA_MT7530
 config NET_DSA_MT7530_MDIO
 	tristate "MediaTek MT7530 MDIO interface driver"
 	depends on NET_DSA_MT7530
-	imply MEDIATEK_GE_PHY
+	select MEDIATEK_GE_PHY
 	select PCS_MTK_LYNXI
 	help
 	  This enables support for the MediaTek MT7530 and MT7531 switch
-- 
2.40.1


