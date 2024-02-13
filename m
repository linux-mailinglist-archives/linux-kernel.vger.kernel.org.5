Return-Path: <linux-kernel+bounces-64432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4774A853E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1761C22D37
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26C17429E;
	Tue, 13 Feb 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US5syN1I"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1269E10;
	Tue, 13 Feb 2024 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861963; cv=none; b=j+lcxTlj2Sxcsxwen+r5gCl3oGeOrehB1BrscmG0TOm+oSePSgJTtyyH0BJTZR7HAFuK4V+17rOV0Od79UqzMI5o+V28tBWPGjxW7kz1KM+8l8Jj+2KqP/6P7ZUxhmvWqR0qaAuANv3NXiRCKq0AgxJyj13AQgpO/TyER3Og3hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861963; c=relaxed/simple;
	bh=yMiFz9mUYxlHMRSQVDDmvaIcbWUmQQAdWdv5fkArP/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQ2jMh2N0hC2pRjZRBwbdzFW2PZEd3ekNFS8Km5BhzWnCro0hzL+hefqbVMPpkz9cbRycbsbXdJb7KRPCdh28a0h7+A8RZEeasdWQPFdJsXuE6j6vc3w+ZukuJQPdjVRH9UDT9HkpFiqryI/uDaUHfRu08Nwbbvh/4HDwrWEUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US5syN1I; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-561f8b8c058so394141a12.0;
        Tue, 13 Feb 2024 14:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861959; x=1708466759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qrf9eahK2JmvAuMzFkBBc7G4ZdpSxxspNCqWeEFsoYc=;
        b=US5syN1IGGrUWYItoZH5riN7/gh34iaAPGU7J+odhMmwLCKLVHrMe2C9yTLofG+a2s
         Ux5twcZkd8NmqplaCAF1fcZEIJSQ3b0k5v2b19xH+QZhL+57sldMjZWzQTxPSs02Vo1a
         Db5j82n7InUSJLr9Z3D6li+HOGtoHHq32ePSQVX4NF3Yz1eGPtThzyfpfjXmmfWcoA1G
         DB3hpHGkxA2xwfKABbp55vfz0sBggo8r/06CfVz/j43SVXuEeXWINnINS/hrG+7n8EXY
         /wD3uq9R9UO6/jSizx2Ua/IgLed27aNrCfi92a1ViXKyXsOgB5xQDocuywtw4yMPIYrw
         Rkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861959; x=1708466759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qrf9eahK2JmvAuMzFkBBc7G4ZdpSxxspNCqWeEFsoYc=;
        b=lvamkg9FcqvPMrprKZ3MImaFj4t9GPKbB9r1cc3uaWiNBhwvOjhrczn6thIT+WG9nA
         5hY54BeynN+8w0C9kWs5tavMiFtU2T+MWU9Vs0t6ZMcCl1TTyEyiDBiYtHrM86gcVgkO
         14pH69TWO5+IQtofOpduwX1tnMKKLx+S1qQkfGTP1hD3ozkykvbPUX2JAr5DNs9Kp1hW
         xZi3mUF8oPkCxYZrdKYa96K15MhE/rOsfVy6IGxoyp+GsjMHW1pAZc+8qN5vne7ZdPp4
         /YqYB3GHkhCw1bsiV71KO5JmcGhLZiFGnuqPkY9mp53ZRFZov0ZYyWop5ExEDBBqyL9A
         K5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcT9OUSR+tW90+ZVId65N8POAqiCDL7WcIrQ0RXFQXqnYfmPp2KX0IluzSTgfcNpcQ40LCi6itOs2b0jpj/CfRVI3zFyoFL/Kt6vsE
X-Gm-Message-State: AOJu0Yw6LclGJtrRlCM6eut6wR9pBv5GHTeUn+/q+L0AjRpGbJOHVkc2
	XbNINCL5PS3vv+SWXB1IGjw9nljMtqMy77Sskxu7TqA5v5Ue6DyYj5V00gGR1no=
X-Google-Smtp-Source: AGHT+IH1uQb7LXAJj3UHPqDPp0SN+HDKQSG+tGa2EU+Q/lARN/1KP8UGVGBY6usVcirqjxaswJOBlw==
X-Received: by 2002:a17:907:6d0c:b0:a3d:37a4:809d with SMTP id sa12-20020a1709076d0c00b00a3d37a4809dmr150783ejc.7.1707861958861;
        Tue, 13 Feb 2024 14:05:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXN+KHy19m3510ARFBTZmrS+SbV1BYC/xFUqolzqGzwmklav/82BcO3aNP658aWlqzsxmPL8cw8vSKdmySgJR6IRWusXfoG5RVddWeU6U1lNpJqjPcwp1tQsYO8dfGTWkPEhss15m3FR/iX7/0K2TFgWcg2e/Cop4xnfY+VByC9v2akeNsRaoWbsthAN2WY5FqGwWXuv5L+EAyh4Amy5ARgpzJ/zrB9Fojz0kypUJkYvYrbp35BSEsrfDWHZKaYPMC8YF683v/5A6J+HlJAM5hgeC985WydaZql9Vdw3I+OO/itx37lvwT/cnWY1y19UrhfQoFsEEvHZdsRQk+EMiAyoy7xWSAB056UpKDrfRIk6+MML/pq/MLjvn5BoomrFB8D6uHVFZ+6JrY4vFi/aaYe8PzzqCl3GvHodt7RqT5YIJq2VEpevvqzIWj2cZbYG+H6G91uqFTUTABTj7w18NTkitCgjOHxtcAH8+dlikPWuDA=
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a170906b20c00b00a3bdf8ae86asm1706800ejz.10.2024.02.13.14.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:05:58 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 10/15] net: dsa: tag_sja1105: prefer precise source port info on SJA1110 too
Date: Tue, 13 Feb 2024 23:03:23 +0100
Message-Id: <20240213220331.239031-11-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213220331.239031-1-paweldembicki@gmail.com>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Now that dsa_8021q_rcv() handles better the case where we don't
overwrite the precise source information if it comes from an external
(non-tag_8021q) source, we can now unify the call sequence between
sja1105_rcv() and sja1110_rcv().

This is a preparatory change for creating a higher-level wrapper for the
entire sequence which will live in tag_8021q.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v4:
  - introduce patch and replace 'slave' with 'conduit' after rebase

 net/dsa/tag_sja1105.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 7639ccb94d35..35a6346549f2 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -652,12 +652,12 @@ static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 	if (likely(sja1105_skb_has_tag_8021q(skb)))
 		dsa_8021q_rcv(skb, &source_port, &switch_id, &vbid, &vid);
 
-	if (vbid >= 1)
+	if (source_port != -1 && switch_id != -1)
+		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
+	else if (vbid >= 1)
 		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-	else if (source_port == -1 || switch_id == -1)
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	else
-		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
+		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
-- 
2.34.1


