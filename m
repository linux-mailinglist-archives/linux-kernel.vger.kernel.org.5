Return-Path: <linux-kernel+bounces-143994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36CD8A4083
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630C5281DEA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047C51CD35;
	Sun, 14 Apr 2024 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEHkUMEm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ECE1BF37;
	Sun, 14 Apr 2024 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713074885; cv=none; b=cm/Z5ggsGLi8amMJYIDMLn6WGstgRv/fRbkIWXfYL1ib2h9Eo1epPzpDXkFzDhOYthsCY0W12HiIAUukHXpuTyA/AOGFVd+WvGEtWxZ0zlLk2geu2/ishpBVh8Mrfad/R69IUMvNDNqg6FaPC+CZ+jbRxcW+JdrM4myWxOBPd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713074885; c=relaxed/simple;
	bh=YiSrDyH5sar5y3AAnJV3/y0r3SDCqTTEYTkGIy6heR0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VhhgoLiMDJ2gG3Rv9RdAXwwUlwte41A5e3NLG/eJmOtTNqITModbvREFvcvJtzxz5fu/aNcavQGAjIr1BXFIq3QxmdtHte5CRX+7KZe3JOISFMJOI9S/gU6KiLn0UYyz7k9LXeU/QSXo8sdTvrbFfg68C6crwtDLJRtnAB6GkJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEHkUMEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7021C072AA;
	Sun, 14 Apr 2024 06:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713074884;
	bh=YiSrDyH5sar5y3AAnJV3/y0r3SDCqTTEYTkGIy6heR0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=SEHkUMEmMRU1NSxTzlRsFSA2+Q+JlnCtlECp9HaLuvhbW2/sc8I8GIYU8v7C2+qaz
	 4WJ+vZpavR8xTUxIkWrWouuv/0GpOTlXY/L/1u4CKOozSJSnwqOXcAt175bK6SJ818
	 Vg+9yPoNRIT0br75l+8BDsY9kR/M0dLFIIFikjrKMDTby4Yi2p3icEyUGet5tMFOM2
	 v/8L9rP2zKLRaTXndSe4iLpBk29OE/Vs462I5Ajr+/x0lAfPGyD/Nz+aiX1rXL6dqW
	 Im0NsKo0YuLh063uPdv1EXQQI23LldrtupKJrwyDMt7i9c2L1n2i0v8t06/m2dce6v
	 e72V+znTuRXYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4844C4345F;
	Sun, 14 Apr 2024 06:08:04 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH net-next v2 0/2] Read PHY address of switch from device
 tree on MT7530 DSA subdriver
Date: Sun, 14 Apr 2024 09:07:40 +0300
Message-Id: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v2-0-1a7649c4d3b6@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKxyG2YC/6WOQQ6CMBBFr2Jm7ZhSKqAr72FcFDqVSaQl04ZID
 He3cgWXLz95/30gkTAluB4+ILRw4hgK6OMBhtGGJyG7wqCVNqrWBnuDPgoGyoHeGafcnmuF87i
 idU7QS5zQZbTBYeJpfrFfcYhCGOeEjTFtc+466slCuZiFPL/3+zsUJf6c8CjLyClHWfeupdr3P
 cFUfyYsFSrsVXepG+d126qbFQ7D5TTECR7btn0ByX2KQRMBAAA=
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713074874; l=1173;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=YiSrDyH5sar5y3AAnJV3/y0r3SDCqTTEYTkGIy6heR0=;
 b=g9fxueRTXfEj3oZC0MCJ4YNUIg2UCQDKxUMG+k7tkIpM1X8wRBkaDFzzjQPI0maur/GbtwDQA
 XkxSk+hJOUQBe7QIamivKclcD7+/clBzTwLhvCbyKqayM/4lAqvdjrT
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

This patch series makes the driver read the PHY address the switch listens
on from the device tree which, in result, brings support for MT7530
switches listening on a different PHY address than 31. And the patch series
simplifies the core operations.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Changes in v2:
- Patch 1
  - Use a more efficient definition for the MT753X_CTRL_PHY_ADDR macro
    provided by Daniel.
- Link to v1: https://lore.kernel.org/r/20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v1-0-b08936df2770@arinc9.com

---
Arınç ÜNAL (2):
      net: dsa: mt7530-mdio: read PHY address of switch from device tree
      net: dsa: mt7530: simplify core operations

 drivers/net/dsa/mt7530-mdio.c |  28 +++++-----
 drivers/net/dsa/mt7530.c      | 125 +++++++++++++++++++-----------------------
 drivers/net/dsa/mt7530.h      |   4 +-
 3 files changed, 73 insertions(+), 84 deletions(-)
---
base-commit: 32affa5578f0e6b9abef3623d3976395afbd265c
change-id: 20240324-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-64476588ebea

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



