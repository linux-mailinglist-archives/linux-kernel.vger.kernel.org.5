Return-Path: <linux-kernel+bounces-129579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D72896CC7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268CC1F2D9C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A401487E8;
	Wed,  3 Apr 2024 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJm5OFpG"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1EE1411E7;
	Wed,  3 Apr 2024 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140704; cv=none; b=jRDswXW2RXreqMYOOXXMIbXYups9b8WjiPKiwIB9B6rZ6SqhSor4BX1QRCkAzFPYc2MSJZh4faDtz3J/WyMODEXntv09HpQpyRJ+1OY4iaxLKlYUdh3Jj3FtGz0hGaX2eUQfVtsXiKO6D2iCB5ame4LGX1DA1/X+ZVmkl+plQDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140704; c=relaxed/simple;
	bh=YRa59gJY/XsWFS+u6VlDmpnJ/CnyVXNTail4JvfjdE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FcUeKwwHoySn6B1R3Xk67m3fQV1Gz/sht9z3eMEs9friXiOvL8sWXd3KdNSlue4qpeGe7gcoTrAmqQN/RzmMl7jK0ZfJSUYcLCuZ/ymNBmbW0AfO5W7Hjuf+quRbH9JRfQi8lN574ynGE9CL0dAt9PEGCh/RZ2E66tWVeayGrD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJm5OFpG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a450bedffdfso712084066b.3;
        Wed, 03 Apr 2024 03:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140701; x=1712745501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4unurX3MPlAms8eZV65/F9OvE29jWvNeK6uk80WwigY=;
        b=WJm5OFpG3pSBfRGsYDIcjGrwM4opPlFestsag+y1JnOw+VmAUGY6+YoXGKJjL7NKmi
         eA5G0arf6i2PFIi57FOS4p+5nLdY5GL6hFv2mY+vnfkrlOKaGazjQ28Ce3yK7gLlX9Or
         gEkDyp3nexJ2Mbou4Zcredp2CLLft91oMlI6nQiLqQ6NY3eIwZmClvadk/CwYSidgcYy
         8CHcdFzkMVy/rqyL+EOOhAzLA/LbEXplPtujs15HoK2jgWUJfrlsS4jmLtwIRLDSwvTY
         2anRdbJmLAnV9qw6KyFFOwfYBf6xZMENluB7wx1cEKBPL/qlvlTrpdU4hPrg1T9megSw
         e+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140701; x=1712745501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4unurX3MPlAms8eZV65/F9OvE29jWvNeK6uk80WwigY=;
        b=vw7FJP5A1nhUcTGziHlJqRdV7nau+9f7166JhczUtkHi1DKTPvFAtyx4O2DJp6GXlE
         dP7RC32OWXpLfrYf5nJNvxR6QdyAUf5lP+jWrp3zZ4DOcDdBovkc2FvnmjT54zCqE64k
         3YAXx/KZfvfj6x8kjKfd93YoQ0DQPrEkUuTObyCqxoSRNOTL6DwZt/HWtKcw6ydjvyqR
         exL//FkUsnHHXUfEC9ozCB93nx7AwpzL0rwI9mtO6H624AuOOQE5A6sufT9Yuiotfaun
         jvYdlFY6v56KXa7HUCtFH36u56mgNm3JPjApCNAQ+Wz0c/8wBsR0VQLqmc71IUGIUAAp
         mNpg==
X-Forwarded-Encrypted: i=1; AJvYcCWdmLPhAIho67VLXP06TJz73TrgBJTPGreGMQ/PFqDjqc2bJq1aDrMN1p7ZTwdEem/mD4jUkhTBLkuTv5ylDNvO+0yINWfjrdd9ni7s
X-Gm-Message-State: AOJu0YxTLJ9/VyoLtdMGdWdYxk14QmCHBy/YCjILk2yRtsfV6LViw10G
	HlAQ4qpObUXGZU5IZLVB1iqPZIcvS9Q8C9B63XTcQhue1QpxQlRz3ocsXiVlJmw=
X-Google-Smtp-Source: AGHT+IGjPP+3VGxR12GrZA9pz8ZkeM3mhbsCYSHUd2PEB2a1HF1xGJSBePxNCTsPeFLHEuY3b8qumg==
X-Received: by 2002:a17:907:844:b0:a4e:17bb:b06 with SMTP id ww4-20020a170907084400b00a4e17bb0b06mr1974795ejb.13.1712140700758;
        Wed, 03 Apr 2024 03:38:20 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm6858169ejb.11.2024.04.03.03.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:38:20 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
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
Subject: [PATCH net-next v8 10/16] net: dsa: tag_sja1105: prefer precise source port info on SJA1110 too
Date: Wed,  3 Apr 2024 12:37:26 +0200
Message-Id: <20240403103734.3033398-11-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403103734.3033398-1-paweldembicki@gmail.com>
References: <20240403103734.3033398-1-paweldembicki@gmail.com>
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
v8,v7,v6,v5:
  - resend only
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


