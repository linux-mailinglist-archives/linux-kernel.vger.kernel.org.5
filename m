Return-Path: <linux-kernel+bounces-117976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A35A88B1F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521D91C62D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8F58526D;
	Mon, 25 Mar 2024 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU3X7MZi"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7F86D1BB;
	Mon, 25 Mar 2024 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399533; cv=none; b=UOzjXDU0Kqtt2A+89lcbkm4KGftJCl/Hg4XglqvT8I9ECUGL4RBrCdguvlIknV27CKUBUQIhLIrICLTlnYPnVRlMayK45EvReEvGEV9JTAEq1IATIrF79pHKqPkh10/BXw50Ll1alI+RvEeKvMs0IWF0AnbBWsNHH8ta7MW7C6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399533; c=relaxed/simple;
	bh=bqJJx/zrSTCy5XUk4jROLUayidTR0avivuWUquHNNB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JCZHxB2OPCkjO34R5pva9svsNfMYw7IxtTUCWJWLdIDD+TnjUBplD+CwUV+jwNCJpN+c9bMtzqpAXoyOORc0Vxj0nZR4OTmjOUgmF02rIIR5rUpPPaNbQImf7q4a7kLQzKfsJg43qMD+XyTWsxQqzwO+JrGJ7D2q1Ucmzm+sCnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hU3X7MZi; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d49f7e5c2cso64584351fa.2;
        Mon, 25 Mar 2024 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399529; x=1712004329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNp1OGI/1SWamqfMcRFzMSU1aNElG2nHb7wTH+ue4Ik=;
        b=hU3X7MZis/uscoPLJYF1Io0OOvGZP3M8+ixVoijoWxk80ipP24J9HAlHGrAJqSvKGC
         gPMsYvI6VzynQb3FlTUM/CWxtBnqRScoBFTD1u8qgePNgjz14LRlMreFOIki6sbcZ/qz
         4FnSNacBEJl1YNsAvm6wwJsvtGyuXxOJwIQfH0SAQLqGzldh2L9mlCe0Mt+JCEO7FVHK
         h9YtxJpj/O4P44wDpGMmHqs/QLGsaGjfysSlTZSv7trY/lW1pNxsaSCXFZ0LfRxu7vWn
         NGWns/GmoL0GHHanAkX2RfC8AUiiMDb+eKgaEmhFsRZzKUC9SdL4NNuwPkTxUjOkh3aH
         jklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399529; x=1712004329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNp1OGI/1SWamqfMcRFzMSU1aNElG2nHb7wTH+ue4Ik=;
        b=B5hdPS0VXt6qSZ0fPB/cIQZlVAYKE5Gt9yot/waiI28qVhwjVzpLku10tSPamJow3J
         l2RXSm94okdU9OWlQgCUB72CcaKdd9d7kMiWpwelT1LeH/QsRbsoqX7lIaYpuIQssNmt
         cwhL8NMQgtX3TuLVTHkCyYzdzF2aT9YPOksxJ7DuW4ozG4yAEepc1eElFMJUYjEMLSCt
         ZxuQBCabqiJHUIYZErTJ0eIV8tzfAsmecv7GhNx6vZn1RWvDz+Zdd7mm8INMrbUKwwrn
         zw+S/Tvkc2vgPddMafGXZAZHaRgIV3kVe+4qobnuvJpVhYVukYLOgQzX5VTvoWzHbtLD
         4bmA==
X-Forwarded-Encrypted: i=1; AJvYcCUrkS+VAqpOYijB4R0p+DQEMlxcXNamrY38jkvwhzNb2gwyxbkUMvyyG4miAVbXHw/Jy5hhwwDEit78GWXGQPc4eKaHd/SKK8NrgXgz
X-Gm-Message-State: AOJu0Yz4WYSN8qpXwlM4K925l5WOnkUI8KTbQWf/XjeRhRrHTawD6NOc
	2OOIIuO1cspbGrFFEIpgXwCeNV5xDrsbycKn1CebNymeAmeqYNrixTBDGiRzBI0=
X-Google-Smtp-Source: AGHT+IGChCtBunqe0A4RfA7EI03c4cmaad9++riRDdXdL8CT7wP9awJANdmhHntZkEH9tW0Uy+fUTA==
X-Received: by 2002:a2e:8014:0:b0:2d6:a699:4bae with SMTP id j20-20020a2e8014000000b002d6a6994baemr5340908ljg.6.1711399529268;
        Mon, 25 Mar 2024 13:45:29 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm591751edv.25.2024.03.25.13.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:45:28 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 14/16] net: dsa: Define max num of bridges in tag8021q implementation
Date: Mon, 25 Mar 2024 21:43:39 +0100
Message-Id: <20240325204344.2298241-15-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325204344.2298241-1-paweldembicki@gmail.com>
References: <20240325204344.2298241-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Max number of bridges in tag8021q implementation is strictly limited
by VBID size: 3 bits. But zero is reserved and only 7 values can be used.

This patch adds define which describe maximum possible value.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v7:
  - added 'Reviewed-by' only
v6:
  - resend only
v5:
  - added 'Reviewed-by' only
v4:
  - introduce patch

 drivers/net/dsa/sja1105/sja1105_main.c | 3 +--
 include/linux/dsa/8021q.h              | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 6646f7fb0f90..6e22d7a6bfa3 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3156,8 +3156,7 @@ static int sja1105_setup(struct dsa_switch *ds)
 	ds->vlan_filtering_is_global = true;
 	ds->untag_bridge_pvid = true;
 	ds->fdb_isolation = true;
-	/* tag_8021q has 3 bits for the VBID, and the value 0 is reserved */
-	ds->max_num_bridges = 7;
+	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
 
 	/* Advertise the 8 egress queues */
 	ds->num_tx_queues = SJA1105_NUM_TC;
diff --git a/include/linux/dsa/8021q.h b/include/linux/dsa/8021q.h
index f3664ee12170..1dda2a13b832 100644
--- a/include/linux/dsa/8021q.h
+++ b/include/linux/dsa/8021q.h
@@ -8,6 +8,11 @@
 #include <net/dsa.h>
 #include <linux/types.h>
 
+/* VBID is limited to three bits only and zero is reserved.
+ * Only 7 bridges can be enumerated.
+ */
+#define DSA_TAG_8021Q_MAX_NUM_BRIDGES	7
+
 int dsa_tag_8021q_register(struct dsa_switch *ds, __be16 proto);
 
 void dsa_tag_8021q_unregister(struct dsa_switch *ds);
-- 
2.34.1


