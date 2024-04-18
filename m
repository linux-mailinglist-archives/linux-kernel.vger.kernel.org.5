Return-Path: <linux-kernel+bounces-149526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6948A927B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAF31C20D62
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1724E69D3C;
	Thu, 18 Apr 2024 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWMO8GEp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6554F98;
	Thu, 18 Apr 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713418559; cv=none; b=BVuOzWFZLDf11G+nCQtNxn9mcpsIlxZjUC4bdcewico83UBqCy/oaKMGFtSbvHPaEXSaSbmV1iKi4nRXYhPlk18IaP7GvJlVQjRUDkyfTj8NV4ykUTDRu/9rO9xzY3qnSm7WBatrRfJ8a/JmCV75noDHpXAtcS6Lo/vmGHty+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713418559; c=relaxed/simple;
	bh=SzDN9toTqBr0GiH5AKRvQI5qpmgWxF0RN8hrv7mhvnE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vC0/Iy6d9njS1ujq8KVC5StKs+HjgjyQ017azrcEaObMkmjfkEXb2eF6hhF6kAWs5veazvAG1MfEdRpnJHjfTO67uILJZgFeS7wNMFgJOavOwy6EVrT7Ubw8/AIFP0R7eFv2CXAMWWm8HlRF+o68YkVH9yzTxRipjouPyqFBhJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWMO8GEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF003C113CC;
	Thu, 18 Apr 2024 05:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713418558;
	bh=SzDN9toTqBr0GiH5AKRvQI5qpmgWxF0RN8hrv7mhvnE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aWMO8GEpSYEvFWa6UnkaL+dUHq692Z4FzRMZ3rPt4em1I6dZKYie6DhoidCUlpCAU
	 6jz46yOLcc9GH+oN6eHdOTo7j7FBO4AAF5dlEu099jnOdLmm8g1ikSdPmpXRNBPVdj
	 xU9zXOgBo7hEV4CDEv8W35YNJyi0WLKxK8gK/sdL02mYHC3jRCZ+t3TltvNtrNei+2
	 xr89mZc6/slLU1g0Dq4hMIuxmfxd4CR1atw/t6RAPjAtkrcTY7OFGHeFoZ2aRKshoI
	 i/M40wtE/kwbjCA3hnEIXU0EnEzoYNwnu9f/KitX6OIWeCD268FqDszVXjX3ph9KRT
	 vqS5nDKHEf5pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA33BC4345F;
	Thu, 18 Apr 2024 05:35:58 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH net-next v3 0/2] Read PHY address of switch from device
 tree on MT7530 DSA subdriver
Date: Thu, 18 Apr 2024 08:35:29 +0300
Message-Id: <20240418-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v3-0-3b5fb249b004@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACGxIGYC/63OwW7DIBAE0F+JOHcrDATsnPofVQ4YlhqpBmtBV
 qzI/x7Kref2OBpp3jxZQYpY2O3yZIR7LDGnFuTbhbnFpi+E6FtmggvFpVAwKwiZIGFN+KiwVnO
 VHLblAOs9QaC8gq9gk4cS1+07hgNcJoS8FdBKGX0dR5zRskZshCE+Ov/J2iT8bLJ7a5ZYaqaj/
 9qH3vcLavjjhX0ADjMfJ6l9EMbwD0sxuend5bXLu/hPTTRtsEarySkvZ/1LO8/zBZ9kUQ+BAQA
 A
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
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713418557; l=1603;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=SzDN9toTqBr0GiH5AKRvQI5qpmgWxF0RN8hrv7mhvnE=;
 b=oYU7F2zcwRLKpqjIwaaYIv+FBg9Jih3CavG5flzWyPS1k6apLTqz0Y1UOsntLB/8cVvMOAasm
 iE3qA9yTmSxAtZ+Nw8KeF+4mwHYGT/qJAS+1Ao0ErK4w62bFF3IXT6t
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

This patch series makes the driver read the PHY address the switch listens
on from the device tree which, in result, brings support for MT7530
switches listening on a different PHY address than 31. And the patch series
simplifies the core operations.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Changes in v3:
- Patch 1
  - Whilst compiling, GCC suggests parentheses around '+' in operand of
    '&'. Address that on the MT753X_CTRL_PHY_ADDR macro.
  - Instead of storing the PHY address in the mt7530_priv structure, store
    the MDIO device pointer as suggested by Florian.
- Link to v2: https://lore.kernel.org/r/20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v2-0-1a7649c4d3b6@arinc9.com

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
 drivers/net/dsa/mt7530.c      | 127 +++++++++++++++++++-----------------------
 drivers/net/dsa/mt7530.h      |   4 +-
 3 files changed, 75 insertions(+), 84 deletions(-)
---
base-commit: 2bd99aef1b19e6da09eff692bc0a09d61d785782
change-id: 20240324-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-64476588ebea

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



