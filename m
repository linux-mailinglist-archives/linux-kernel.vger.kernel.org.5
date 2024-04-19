Return-Path: <linux-kernel+bounces-151292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1922A8AAC84
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65390B220C8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C50F80600;
	Fri, 19 Apr 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIuzGDPy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F8E7EF0D;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521378; cv=none; b=JDRHzLKY9kYYN4d4yLbv6mQh4On+X/9kMLa0T6lVIuC5TkU/zKFZzJiIXYgUr9fE9rogLqPaR+0XUAir7hYEjaCsAwAtaDGc+a2Pg6PMP4t+gJ9sQFkCdD3vXb/HbZoSiL1eJ596oj/INm2iD6FVH6+/e8q23rtobjIWW7jI21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521378; c=relaxed/simple;
	bh=MPWVynoTUNwac/iJ0MENGWWoamLgfYANVhzyB554b7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tawwAe7wNVeINQNuzOuh/gFAfBArTKANU2RWZfICMdBxMJmits6dwGUQaXr9WG1yWsyUVHc1Kg8MjJnGX5vYCw47Nq1EY6Qyjs08Fl3qU9b+oHguxrty90rtPixSFAX4HqCcgy1JOrEnh8232seZsCDq1s9z68h3Q+bOu441zVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIuzGDPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9331FC32786;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521377;
	bh=MPWVynoTUNwac/iJ0MENGWWoamLgfYANVhzyB554b7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MIuzGDPy86qKbCskNzq1ibCFxwniHYjuqSWgE7U1iMEhjiFjbeASY4Ub5AqdmICaC
	 LapBmr5PsbHZK6+sNHAh11n8Fo7ihB2Y43N38qdZhApQrwYFQRrWaxptRcXuwASsU3
	 pvyd14JsPZdg1VCib7bfBsZbIFP+VObb0o93pofraY950KQ7cRxX4+qRNsEEnbpTxo
	 NZ9W1c0kJih9rVvTGrytVfcyHw47Cok9Qpe2LkomedQPrjrEn5cgl74/piZSEGxoKc
	 exrA+hm8hXh8uBWtPj6AtobGS4eeljjxbCDm6pvyKy8yzeEKdkZ892x94mwKoAu/Hs
	 x66zmFokoMSwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC0DC071DB;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 19 Apr 2024 13:09:27 +0300
Subject: [PATCH net-next 04/13] net: dsa: mt7530: rename
 mt753x_bpdu_port_fw enum to mt753x_to_cpu_fw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240419-for-netnext-mt7530-improvements-4-v1-4-6d852ca79b1d@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713521374; l=7082;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=3dLKGHYrPqSDgKpGTLFqk6tJoqAjkX99HRjW+A6/q5g=;
 b=ZFB7jy4qzTi9Ud7UxWL7JO2DBS2GHjATaqWxPfrYx0KZy3zGaNxXZXfTkgCjRI/9Z7iB6Stk8
 AVXL2dVqcbOD7Sx2CxBdEw2ESbig9qkpzMF4K7cpY//g2t4h+4bL9VM
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



