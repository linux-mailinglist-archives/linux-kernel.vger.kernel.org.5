Return-Path: <linux-kernel+bounces-152844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5428AC532
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DEE1C20E34
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4E250292;
	Mon, 22 Apr 2024 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DauG5tsz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024734AEE0;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770131; cv=none; b=Fb44DFgub6EBWdvd3R1EroQHppW/FZP6XWvi9O9yRXKkt6sCzAnaD9JcEEki1ZxU7Gab0aASWi/uMzm9IoQ9RKP9NTIi3Qr65APHZUod9Taa4tWqnOBE8q6Mu/wBr1aX1Vk5gKdQk6+MBy53rtkMqw2WVPt/bTM44Of2ufke4Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770131; c=relaxed/simple;
	bh=MPWVynoTUNwac/iJ0MENGWWoamLgfYANVhzyB554b7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s5mhUjHyEBdzL9fMQ6tfVdnYKGbzcoPEcHTP0HHGwW0pbLOMJHuPri3FBjlam9aEQx82T6RiDdAtEAsZwxcviZs9g6Cb+eA8giBhK5NZOpmfPOphMFnzG4M3CrhsgTpgsIpWKblyG7Hmjkatj0EmrRHkbFv6B+6wcwQc3wGe88U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DauG5tsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3882C4AF0A;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770130;
	bh=MPWVynoTUNwac/iJ0MENGWWoamLgfYANVhzyB554b7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DauG5tszI8oQkqJk1vfzEa495Vid6JFlL6L4qWwFBVjOJk1gpvyLoH/51qCQnPhth
	 8AaqS52i3f6RgJDYry+7hyfzXm8nHZ6Ah3VyEwPWlwoxJdYfG4vhck9lETNzpau/lk
	 VjHqAOZvs83V87b72HEkOxi1t23vZ0QMwrkOKsjssji00bS5mPT/IOOYNT8fv80Yu5
	 RiDLtPemh2xxe3Sq9cRSVUJPLOIllVKHJya4bFu0nFVKhuIbd82OGV9BUQjNI0i7rV
	 iP1ebAv10VkB/QPf8DT7QJhtV4DUOUzC5qfb83MQ0sIIq4AuGm2yOj8bIfZLFGD3ba
	 p9UaWkdm2TEcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BF1C04FF6;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Apr 2024 10:15:11 +0300
Subject: [PATCH net-next v2 04/15] net: dsa: mt7530: rename
 mt753x_bpdu_port_fw enum to mt753x_to_cpu_fw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240422-for-netnext-mt7530-improvements-4-v2-4-a75157ba76ad@arinc9.com>
References: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
In-Reply-To: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713770127; l=7082;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=3dLKGHYrPqSDgKpGTLFqk6tJoqAjkX99HRjW+A6/q5g=;
 b=fTnF5CE7QcXy3Y8v6GOjJufswpwrw4nfVhGImJP5SaX2BikEP3FP8yDCD9SsbVMTw7rf8PFfn
 x1+bsxQ5WJkCQUpgEKRoo/mA4e+vZFJp/HEDRUFa11hD/w6RqZwq2k8
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The mt753x_bpdu_port_fw enum is globally used for manipulating the process
of deciding the forwardable ports, specifically concerning the CPU port(s).
Therefore, rename it and the values in it to mt753x_to_cpu_fw.

Change FOLLOW_MFC to SYSTEM_DEFAULT to be on par with the switch documents.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 44 ++++++++++++----------------
 drivers/net/dsa/mt7530.h | 76 ++++++++++++++++++++++++------------------------
 2 files changed, 56 insertions(+), 64 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 5b6aeeddb5d9..7f864f895ba0 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1107,42 +1107,34 @@ mt753x_trap_frames(struct mt7530_priv *priv)
 	 * VLAN-untagged.
 	 */
 	mt7530_rmw(priv, MT753X_BPC,
-		   MT753X_PAE_BPDU_FR | MT753X_PAE_EG_TAG_MASK |
-			   MT753X_PAE_PORT_FW_MASK | MT753X_BPDU_EG_TAG_MASK |
-			   MT753X_BPDU_PORT_FW_MASK,
-		   MT753X_PAE_BPDU_FR |
-			   MT753X_PAE_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-			   MT753X_PAE_PORT_FW(MT753X_BPDU_CPU_ONLY) |
-			   MT753X_BPDU_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-			   MT753X_BPDU_CPU_ONLY);
+		   PAE_BPDU_FR | PAE_EG_TAG_MASK | PAE_PORT_FW_MASK |
+			   BPDU_EG_TAG_MASK | BPDU_PORT_FW_MASK,
+		   PAE_BPDU_FR | PAE_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   PAE_PORT_FW(TO_CPU_FW_CPU_ONLY) |
+			   BPDU_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   TO_CPU_FW_CPU_ONLY);
 
 	/* Trap frames with :01 and :02 MAC DAs to the CPU port(s) and egress
 	 * them VLAN-untagged.
 	 */
 	mt7530_rmw(priv, MT753X_RGAC1,
-		   MT753X_R02_BPDU_FR | MT753X_R02_EG_TAG_MASK |
-			   MT753X_R02_PORT_FW_MASK | MT753X_R01_BPDU_FR |
-			   MT753X_R01_EG_TAG_MASK | MT753X_R01_PORT_FW_MASK,
-		   MT753X_R02_BPDU_FR |
-			   MT753X_R02_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-			   MT753X_R02_PORT_FW(MT753X_BPDU_CPU_ONLY) |
-			   MT753X_R01_BPDU_FR |
-			   MT753X_R01_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-			   MT753X_BPDU_CPU_ONLY);
+		   R02_BPDU_FR | R02_EG_TAG_MASK | R02_PORT_FW_MASK |
+			   R01_BPDU_FR | R01_EG_TAG_MASK | R01_PORT_FW_MASK,
+		   R02_BPDU_FR | R02_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   R02_PORT_FW(TO_CPU_FW_CPU_ONLY) | R01_BPDU_FR |
+			   R01_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   TO_CPU_FW_CPU_ONLY);
 
 	/* Trap frames with :03 and :0E MAC DAs to the CPU port(s) and egress
 	 * them VLAN-untagged.
 	 */
 	mt7530_rmw(priv, MT753X_RGAC2,
-		   MT753X_R0E_BPDU_FR | MT753X_R0E_EG_TAG_MASK |
-			   MT753X_R0E_PORT_FW_MASK | MT753X_R03_BPDU_FR |
-			   MT753X_R03_EG_TAG_MASK | MT753X_R03_PORT_FW_MASK,
-		   MT753X_R0E_BPDU_FR |
-			   MT753X_R0E_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-			   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY) |
-			   MT753X_R03_BPDU_FR |
-			   MT753X_R03_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-			   MT753X_BPDU_CPU_ONLY);
+		   R0E_BPDU_FR | R0E_EG_TAG_MASK | R0E_PORT_FW_MASK |
+			   R03_BPDU_FR | R03_EG_TAG_MASK | R03_PORT_FW_MASK,
+		   R0E_BPDU_FR | R0E_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   R0E_PORT_FW(TO_CPU_FW_CPU_ONLY) | R03_BPDU_FR |
+			   R03_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   TO_CPU_FW_CPU_ONLY);
 }
 
 static void
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index c8155e32edbe..0d5167f5ba6b 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -67,47 +67,47 @@ enum mt753x_id {
 #define MT753X_MIRROR_MASK(id)		((((id) == ID_MT7531) || ((id) == ID_MT7988)) ?	\
 					 MT7531_MIRROR_MASK : MIRROR_MASK)
 
-/* Registers for BPDU and PAE frame control*/
+/* Register for BPDU and PAE frame control */
 #define MT753X_BPC			0x24
-#define  MT753X_PAE_BPDU_FR		BIT(25)
-#define  MT753X_PAE_EG_TAG_MASK		GENMASK(24, 22)
-#define  MT753X_PAE_EG_TAG(x)		FIELD_PREP(MT753X_PAE_EG_TAG_MASK, x)
-#define  MT753X_PAE_PORT_FW_MASK	GENMASK(18, 16)
-#define  MT753X_PAE_PORT_FW(x)		FIELD_PREP(MT753X_PAE_PORT_FW_MASK, x)
-#define  MT753X_BPDU_EG_TAG_MASK	GENMASK(8, 6)
-#define  MT753X_BPDU_EG_TAG(x)		FIELD_PREP(MT753X_BPDU_EG_TAG_MASK, x)
-#define  MT753X_BPDU_PORT_FW_MASK	GENMASK(2, 0)
-
-/* Register for :01 and :02 MAC DA frame control */
+#define  PAE_BPDU_FR			BIT(25)
+#define  PAE_EG_TAG_MASK		GENMASK(24, 22)
+#define  PAE_EG_TAG(x)			FIELD_PREP(PAE_EG_TAG_MASK, x)
+#define  PAE_PORT_FW_MASK		GENMASK(18, 16)
+#define  PAE_PORT_FW(x)			FIELD_PREP(PAE_PORT_FW_MASK, x)
+#define  BPDU_EG_TAG_MASK		GENMASK(8, 6)
+#define  BPDU_EG_TAG(x)			FIELD_PREP(BPDU_EG_TAG_MASK, x)
+#define  BPDU_PORT_FW_MASK		GENMASK(2, 0)
+
+/* Register for 01-80-C2-00-00-[01,02] MAC DA frame control */
 #define MT753X_RGAC1			0x28
-#define  MT753X_R02_BPDU_FR		BIT(25)
-#define  MT753X_R02_EG_TAG_MASK		GENMASK(24, 22)
-#define  MT753X_R02_EG_TAG(x)		FIELD_PREP(MT753X_R02_EG_TAG_MASK, x)
-#define  MT753X_R02_PORT_FW_MASK	GENMASK(18, 16)
-#define  MT753X_R02_PORT_FW(x)		FIELD_PREP(MT753X_R02_PORT_FW_MASK, x)
-#define  MT753X_R01_BPDU_FR		BIT(9)
-#define  MT753X_R01_EG_TAG_MASK		GENMASK(8, 6)
-#define  MT753X_R01_EG_TAG(x)		FIELD_PREP(MT753X_R01_EG_TAG_MASK, x)
-#define  MT753X_R01_PORT_FW_MASK	GENMASK(2, 0)
-
-/* Register for :03 and :0E MAC DA frame control */
+#define  R02_BPDU_FR			BIT(25)
+#define  R02_EG_TAG_MASK		GENMASK(24, 22)
+#define  R02_EG_TAG(x)			FIELD_PREP(R02_EG_TAG_MASK, x)
+#define  R02_PORT_FW_MASK		GENMASK(18, 16)
+#define  R02_PORT_FW(x)			FIELD_PREP(R02_PORT_FW_MASK, x)
+#define  R01_BPDU_FR			BIT(9)
+#define  R01_EG_TAG_MASK		GENMASK(8, 6)
+#define  R01_EG_TAG(x)			FIELD_PREP(R01_EG_TAG_MASK, x)
+#define  R01_PORT_FW_MASK		GENMASK(2, 0)
+
+/* Register for 01-80-C2-00-00-[03,0E] MAC DA frame control */
 #define MT753X_RGAC2			0x2c
-#define  MT753X_R0E_BPDU_FR		BIT(25)
-#define  MT753X_R0E_EG_TAG_MASK		GENMASK(24, 22)
-#define  MT753X_R0E_EG_TAG(x)		FIELD_PREP(MT753X_R0E_EG_TAG_MASK, x)
-#define  MT753X_R0E_PORT_FW_MASK	GENMASK(18, 16)
-#define  MT753X_R0E_PORT_FW(x)		FIELD_PREP(MT753X_R0E_PORT_FW_MASK, x)
-#define  MT753X_R03_BPDU_FR		BIT(9)
-#define  MT753X_R03_EG_TAG_MASK		GENMASK(8, 6)
-#define  MT753X_R03_EG_TAG(x)		FIELD_PREP(MT753X_R03_EG_TAG_MASK, x)
-#define  MT753X_R03_PORT_FW_MASK	GENMASK(2, 0)
-
-enum mt753x_bpdu_port_fw {
-	MT753X_BPDU_FOLLOW_MFC,
-	MT753X_BPDU_CPU_EXCLUDE = 4,
-	MT753X_BPDU_CPU_INCLUDE = 5,
-	MT753X_BPDU_CPU_ONLY = 6,
-	MT753X_BPDU_DROP = 7,
+#define  R0E_BPDU_FR			BIT(25)
+#define  R0E_EG_TAG_MASK		GENMASK(24, 22)
+#define  R0E_EG_TAG(x)			FIELD_PREP(R0E_EG_TAG_MASK, x)
+#define  R0E_PORT_FW_MASK		GENMASK(18, 16)
+#define  R0E_PORT_FW(x)			FIELD_PREP(R0E_PORT_FW_MASK, x)
+#define  R03_BPDU_FR			BIT(9)
+#define  R03_EG_TAG_MASK		GENMASK(8, 6)
+#define  R03_EG_TAG(x)			FIELD_PREP(R03_EG_TAG_MASK, x)
+#define  R03_PORT_FW_MASK		GENMASK(2, 0)
+
+enum mt753x_to_cpu_fw {
+	TO_CPU_FW_SYSTEM_DEFAULT,
+	TO_CPU_FW_CPU_EXCLUDE = 4,
+	TO_CPU_FW_CPU_INCLUDE = 5,
+	TO_CPU_FW_CPU_ONLY = 6,
+	TO_CPU_FW_DROP = 7,
 };
 
 /* Registers for address table access */

-- 
2.40.1



