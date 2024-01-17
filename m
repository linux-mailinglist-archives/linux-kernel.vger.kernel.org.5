Return-Path: <linux-kernel+bounces-28834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DDA83038B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6196281733
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8061114AA0;
	Wed, 17 Jan 2024 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="gCx0K+My"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DBF14A84;
	Wed, 17 Jan 2024 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487334; cv=none; b=JBnbMORRcGjJiSotmut98ttzwQZz8QKZeGBDgH5dblLYSWZPGs0HH7EqKJ1eSX71TaoSb6tewNG2grc71JRTK3ZJ4Nq/PrFgSTXzrn0+KVpINze704IIkkSM4wKEU7Ybcxpe0WDW/sJXRvV/jDInNkwXAC4CEW9WfLkkLwRNk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487334; c=relaxed/simple;
	bh=2JtBUicn3F5/xGvtr4W2purAsoey2tUeezM4/nAGynE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-GND-Sasl; b=NY8gKTOgGz6da8rw4Z4OxshjaLb5GJA1XVzc9f9EKvfzrU9pDBdt1+16qTFcklogaW2tee4qGa6yU1Y5lOAeX8pO+2TbSWJ3W1SIFxiLlToQS5c2n8zIxYnR8Lx3WeJeI0jDRt2uS2laAQholgOLLU5cX3O/8tUJEE+Zlz39WYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=gCx0K+My; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3FE3240008;
	Wed, 17 Jan 2024 10:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1705487330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mVtGIgwkGXkguB4MvPhZK/Q8mhOzuHbn1l8x9D2I17U=;
	b=gCx0K+My9QVshgTPmG70Ieg22AYFOiv/+wEl+CpuuwADi73GpmElmaWarKaIOfwXCQNs7h
	JG4DA2cUCVRC3WVezvuHPgehSDzRnkIK23gZjAY1+vsIxYeQfWiPP8Wxe+E8QDGmHUkdNX
	3VJ3NlCK1D9KVHDZ3xxOBRMSfQvKIk1ch3PiJ2MAAufl29tYzyudbAUemwEYdUuIlpTgVj
	fYCcpvaMzVT7fqR6m8v0iFCsO5ku510uN7d3JPpsnG7DgeSh/XyU00YcccJKEOdnmIXFZU
	5gfeQ2War/BoAEbaMIjKly+OTFjFRz9CQTjzZzYxX4rPCwuRSYuEBgwbTg2TNg==
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
Subject: [RFC PATCH net-next 0/8] MT7530 DSA Subdriver Improvements Act III
Date: Wed, 17 Jan 2024 13:28:30 +0300
Message-Id: <20240117102838.57445-1-arinc.unal@arinc9.com>
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

Hello.

This is the third patch series I'm submitting for review.

Cheers.
Arınç

Arınç ÜNAL (8):
  net: dsa: mt7530: remove .mac_port_config for MT7988 and make it
    optional
  net: dsa: mt7530: set interrupt register only for MT7530
  net: dsa: mt7530: do not use SW_PHY_RST to reset MT7531 switch
  net: dsa: mt7530: get rid of useless error returns on phylink code
    path
  net: dsa: mt7530: get rid of priv->info->cpu_port_config()
  net: dsa: mt7530: get rid of mt753x_mac_config()
  net: dsa: mt7530: put initialising PCS devices code back to original
    order
  net: dsa: mt7530: simplify link operations and force link down on all
    ports

 drivers/net/dsa/mt7530.c | 251 +++++++--------------------------------
 drivers/net/dsa/mt7530.h |  15 +--
 2 files changed, 46 insertions(+), 220 deletions(-)

-- 
2.40.1


