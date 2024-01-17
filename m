Return-Path: <linux-kernel+bounces-28836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A75583038F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DFD282297
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42A31D6A2;
	Wed, 17 Jan 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="GRL4GvMd"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2CF1DA36;
	Wed, 17 Jan 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487343; cv=none; b=DzinMI/EJq8WVWnQX10VoI+BzbLuEPS/yK+GaYkwjddp5yj//+ghZybufXYrRRPuV7qugZJGcQ5U7hMR06HqFNnOZB+lWNUn5KysX80ZK2gF68ZhQIZR0fXRkK/NRBoyTjRnQPq2FlBmYht5KlpqBPTTrhTR1d7SRZedxuVZeHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487343; c=relaxed/simple;
	bh=yAcYLNg55z41pL27utNBHpuUvxkDcfdOEgiC8Jx3dCc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl; b=iYgilAdZ9PkcAQBGod5icLwGE+k6ByjqmQ4X/4gDOsmRXiFu1aucmcz8n+f6A3PjO1mseTszHQMBGy+jeBmGn7RKVdfx4AP5wHvZZhmKywK6mFCPXMMpoLlmB77titA80EFUpYSRaGGb0B8QebmeFa8pbHsEh5pnnh8NOTbaW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=GRL4GvMd; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 804D54000D;
	Wed, 17 Jan 2024 10:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1705487339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehY7MTwLJceulhBYYQjUSWYeXY0wgMcqskl/4hnkdS0=;
	b=GRL4GvMdUAHexlp4cQzFR/2dJ5u3H7CqQ8MdYH3FW78qc5G2tQwAIZ3+ZhbVPOyKJvaxUS
	1dvwq6OfKDKgmUOqbbKdqC5pzGo/sO5UcZJ0pzPQaFvYnt+UNGm1vNp0qCTF2wvWIjRG1j
	XC9zqm69mcl/gfIANIxxGaXH8mK+qhEj6bLgUcTJ5VhP5HfGsh+MWStONR+1ao+PgH/ahT
	7TNxXtDSs7tx3d+dRbc+S46hLoJkdBE79U/T6vG2C6rBClf8pQ6WikwcAZOscJuxuwPfhv
	PvbvrJGnwOj7SKLRrlxpySfzotYA080yQgTzB3xJQqF/EYDnzFo7/nDfXSAuuw==
From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC PATCH net-next 2/8] net: dsa: mt7530: set interrupt register only for MT7530
Date: Wed, 17 Jan 2024 13:28:32 +0300
Message-Id: <20240117102838.57445-3-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117102838.57445-1-arinc.unal@arinc9.com>
References: <20240117102838.57445-1-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

Setting this register related to interrupts is only needed for the MT7530
switch. Make an exclusive check to ensure this.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mt7530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index c55edbda32bd..d2e861361191 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2054,7 +2054,7 @@ mt7530_setup_irq(struct mt7530_priv *priv)
 	}
 
 	/* This register must be set for MT7530 to properly fire interrupts */
-	if (priv->id != ID_MT7531)
+	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
 		mt7530_set(priv, MT7530_TOP_SIG_CTRL, TOP_SIG_CTRL_NORMAL);
 
 	ret = request_threaded_irq(priv->irq, NULL, mt7530_irq_thread_fn,
-- 
2.40.1


