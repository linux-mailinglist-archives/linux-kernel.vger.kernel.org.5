Return-Path: <linux-kernel+bounces-49546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A90846BB9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2739C1F25757
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130E77F23;
	Fri,  2 Feb 2024 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jedQRPVG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B4A63119;
	Fri,  2 Feb 2024 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865573; cv=none; b=Vvd0rZWFS9cAV4BbRCIS9FNawUioRDdRIl10UI3bjQUIBXLIgldPMOR5TYCEPZnr4Kg4dhpK/vKefxD2Dj3K5sXFMY/SRXz98+6y+1ibfRO8xCMoPTeRINMPoD79nNn4Zl3o5MdFEG4epzrJj2dEQbntGUtm9sAVv8hhnpJnfz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865573; c=relaxed/simple;
	bh=rCvaDAdvVEPkc/5uSMACu9gWCQ1/fxBqVhcE39XQOQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4O7dYpGRh4FojwxTeHznpFnFz/VKRn7wFmL23Fv4hbGK7wQOz42vR9MNxjRprEaA80B7Z/lgN192uNLTSBRiIcMYCdwY3mv2vZsVXa9488N3+xW37mH1t4sp81JZbr+lbsbQbyuwQ9adiL6RCkjEu1DMKxG4HSc5M414xduong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jedQRPVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B11D4C433C7;
	Fri,  2 Feb 2024 09:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706865572;
	bh=rCvaDAdvVEPkc/5uSMACu9gWCQ1/fxBqVhcE39XQOQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jedQRPVGaqsVoflMFNGtVWJlXpfMwFOMXBbGSAXWJXebPXa0Rl8xvaFZZB7l5yL5P
	 spg70w7n5wcikpt0DRk+fAlAAJCmSs1CLNvxtMgJZ3S33dY1UqwkPuiMb6gdayVbVl
	 yYqYnTAFUB+Hc5my9apQcy/6LB2QuQ72U173iPglKqBFbq4YL3Wb1dGpnlm991878Z
	 mZZDfDeREsDJbwIeDMvJkV2qaYBgOM9sQJh46CwEBky5NgW3Bb4ePQ3B8e8CDT88nN
	 vIcvsTltXzPRsGVrzJzp8CgX+JAkxx2RxOkRDw45ZnqEMUPWH03Kv7Lr7zJ9HJGIDd
	 pFbv/yJw6MuKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90493C48291;
	Fri,  2 Feb 2024 09:19:32 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 02 Feb 2024 12:19:07 +0300
Subject: [PATCH net-next v3 1/7] net: dsa: mt7530: empty default case on
 mt7530_setup_port5()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240202-for-netnext-mt7530-improvements-2-v3-1-63d5adae99ca@arinc9.com>
References:
 <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
In-Reply-To:
 <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com, 
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706865569; l=1561;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=4iqmJSREOOSr69rzXZ9fMqbTsIjeBdURHVNrmhTA6EI=;
 b=TeFqFshuDfZ5ZtHlV2wYOCIagEY8/cQ/3dz9qwLIC/uvZRz991/HxiXn7Sc7VwzOs3fXymSgc
 2QG09ps/xpsCkrJzsYBYius5Nc8Wj7wCPq+UiEBslQK8hZxHpMleGK9
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

There're two code paths for setting up port 5:

mt7530_setup()
-> mt7530_setup_port5()

mt753x_phylink_mac_config()
-> mt753x_mac_config()
   -> mt7530_mac_config()
      -> mt7530_setup_port5()

On the first code path, priv->p5_intf_sel is either set to
P5_INTF_SEL_PHY_P0 or P5_INTF_SEL_PHY_P4 when mt7530_setup_port5() is run.

On the second code path, priv->p5_intf_sel is set to P5_INTF_SEL_GMAC5 when
mt7530_setup_port5() is run.

Empty the default case which will never run but is needed nonetheless to
handle all the remaining enumeration values.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/mt7530.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 68be38ae66e0..330e22abc076 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -943,9 +943,7 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 		val &= ~MHWTRAP_P5_DIS;
 		break;
 	default:
-		dev_err(ds->dev, "Unsupported p5_intf_sel %d\n",
-			priv->p5_intf_sel);
-		goto unlock_exit;
+		break;
 	}
 
 	/* Setup RGMII settings */
@@ -975,7 +973,6 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 	dev_dbg(ds->dev, "Setup P5, HWTRAP=0x%x, intf_sel=%s, phy-mode=%s\n",
 		val, p5_intf_modes(priv->p5_intf_sel), phy_modes(interface));
 
-unlock_exit:
 	mutex_unlock(&priv->reg_mutex);
 }
 

-- 
2.40.1


