Return-Path: <linux-kernel+bounces-143904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50CB8A3F55
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 00:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E83281F68
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D34257316;
	Sat, 13 Apr 2024 22:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpWYHUnN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07F447F45;
	Sat, 13 Apr 2024 22:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713046138; cv=none; b=tVesKRwMHlULxXBNzGyHbfg2eZjzY15PPkh4QbueYFYIYh3ib/up5fRJ6Lz5YpqUl8rKK6BpzUm3QttwrtAFl3E2CshXusvWTFGtUDvelbwL7k6cgjmmus4cAqK2oSUNm/GJiPz+uiMKzQD98WfEgJhVhTZgg7mah4+shhcEx40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713046138; c=relaxed/simple;
	bh=w3Fko/vEfLXqrM24t7NMSuNjon9r3RjbL4inMywtDFQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TsZ+O7xCd0tPaqaeP5CyWBUWlvD0TxV/1kCk8ljPN8noSHBYWJNQXgK9i+4eJsisLzvOdl4YC56/MXyg0UOqCD5FPYxO9O94UD9RGCDcnLA7ElEioKaxeZyYfFJmGrboQ5RYDzO5wQ+R2p6foh6gMAEEWIvTmeNpcjV1dfi2om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpWYHUnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28F7CC113CD;
	Sat, 13 Apr 2024 22:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713046138;
	bh=w3Fko/vEfLXqrM24t7NMSuNjon9r3RjbL4inMywtDFQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FpWYHUnNRQT99CFyyL7pHxRGSIhE9qOCjMnV3/WcpPtRWXj0tqIEz504f44xOp5l4
	 beYoDmMEX48jV4xAWbU+4B5Aeg209YY62SebL/OviS+JJUQ51N1mK/GvbSqYmcwI7a
	 TDVOG7RtCnvQSnMHoCuZBO20TALQMUBzoOjPLGQtNQCROifkTAlTXn2H5f8Nf9FduP
	 YNTUgb3GGKz/zcTTrmXwP48rItCxKZgnWFFOYwlqCopR7JBC6raUaNnns2FZluHcyr
	 4OSQVVBN41A7BCHe7wivJ3y8FXA01Maa9/xnObYWqttjxcGOYgpKLUUyIcmWxgXT+d
	 M2Fcx/qbBQjcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2EBC4345F;
	Sat, 13 Apr 2024 22:08:58 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH net-next 0/2] Read PHY address of switch from device tree
 on MT7530 DSA subdriver
Date: Sun, 14 Apr 2024 01:08:18 +0300
Message-Id: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v1-0-b08936df2770@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFICG2YC/x3NSwqDMBRG4a3IHfcHq/FBt1IcRHNTL9QkJKEo4
 t6bdngm3zkpcRRO9KhOivyRJN6VuN8qWlbtXgwxpampG1W3jcKsYH2E4+x4z9jy0LU1wnpAGxN
 ho99gMrQzSLKFt9gDi48MHxJ6pYa+G0eeWVNZhMhW9v/+SYXEz6Tpur5OGlHzmAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713046128; l=902;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=w3Fko/vEfLXqrM24t7NMSuNjon9r3RjbL4inMywtDFQ=;
 b=QWDZGIXGNPR9Klrs9q8VfkYcp1RGyM6dDStUMGu1gEScLx5wWklQHOY10a4ufb7F0DVBI5nh5
 ONGSyTrDFb0AASNbPK2u2Ll4uN6j+y0kBW7Lvy9+SipHmplA1de/veF
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



