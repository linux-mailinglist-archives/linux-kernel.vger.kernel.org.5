Return-Path: <linux-kernel+bounces-151297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A28AAC90
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6F01F21C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65B9129E7B;
	Fri, 19 Apr 2024 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHown39m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C587F496;
	Fri, 19 Apr 2024 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521378; cv=none; b=U4kNwVQ8Al0R553B18YcrsDRAIYS8+Q6deVG1zi8LKvjC3wL6ot4zZ+DyBcNVS56D6bieotqGvARuf6nOzylWjKMnukfeMP7kxpBh2osxP40WhNTV2FIEtdNbIkv9wfMSb2ISaUq4Ck5vEfxIm3JO4KZQWFsRsj5rn6GJpVWqAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521378; c=relaxed/simple;
	bh=Opp1CZsglNYhlA4uuP5oQQWhKy/UVwr883h+FPxyU0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=laBls/pEsqtbrNrP00T9AfZNYlOhQmSr9pLVLtSyiz4POi2yJsJys62uXrp2QCTbevb0vL8xqIgI3GCpdjYgbmpDppDRIZ5LsiclsphpgSJoMMs1Y3uGxobLQKS/PGW6/F+JYA0fiRdRJIEmNK/TRwfQcB4fvtErdC5fJ4dDlds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHown39m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 191B4C4AF13;
	Fri, 19 Apr 2024 10:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521378;
	bh=Opp1CZsglNYhlA4uuP5oQQWhKy/UVwr883h+FPxyU0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CHown39mLVAYE8GFHYlJ0cUkUvs8qd06BFw7NaSRSCVJhl+tKLueIXlyIt8X+bozV
	 9ps4ooVKnqZZ3leu3TWoTiyrQveOozY2H8RFSkkcHn9lhdSy5A1fvETCTnOetsFPKG
	 7dDsqXmNDww10VX++vkFF89ZM23AKkr7q44Ct6oe/+P9fNHbQC34Isg71+ntck/nht
	 6W9/ifPfgZSqyQOXy6hE5yXZfxGRyVNN4GHeanrnwY9gLZZtb4l1/jFPMrL/kMic8f
	 F+aYupzlV9G8xWK2DLVb4AhkBP0OWvY9DtwboEf+cKmdd8IasGL/ZZQh5axgPHJmLB
	 7diwgOzeFVBOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDB1C4345F;
	Fri, 19 Apr 2024 10:09:38 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 19 Apr 2024 13:09:33 +0300
Subject: [PATCH net-next 10/13] net: dsa: mt7530: get rid of function
 sanity check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240419-for-netnext-mt7530-improvements-4-v1-10-6d852ca79b1d@arinc9.com>
References: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
In-Reply-To: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713521374; l=960;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=HUYFdupAh6c43NX7egvGTzUNU8mBqV4dnjn+5D+OLfw=;
 b=MRcbQMKN8mdudDJJ1IvD98gm/l+nrwqQ5IH6uGhsuhwSTcrtnXunHkxCXRLKAZaHc+RGjVxXT
 Mt4GsJ13BrpB+JSqZQa7kY0Rpkm9zRSr7H6vubTCo4gbRVs/2gsdkUt
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Get rid of checking whether functions are filled properly. priv->info which
is an mt753x_info structure is filled and checked for before this check.
It's unnecessary checking whether it's filled properly.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 8a141f849673..842c2573dfe4 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3232,13 +3232,6 @@ mt7530_probe_common(struct mt7530_priv *priv)
 	if (!priv->info)
 		return -EINVAL;
 
-	/* Sanity check if these required device operations are filled
-	 * properly.
-	 */
-	if (!priv->info->sw_setup || !priv->info->phy_read_c22 ||
-	    !priv->info->phy_write_c22 || !priv->info->mac_port_get_caps)
-		return -EINVAL;
-
 	priv->id = priv->info->id;
 	priv->dev = dev;
 	priv->ds->priv = priv;

-- 
2.40.1



