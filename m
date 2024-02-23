Return-Path: <linux-kernel+bounces-79169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30274861E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A50CBB228B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF0314EFEE;
	Fri, 23 Feb 2024 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNXStYk7"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD5514EFC5;
	Fri, 23 Feb 2024 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722161; cv=none; b=lWc+bv5RFngLWJ7C+Cseifwwzr56hVQdDoDL+gNRGoKXFh+JHZNDbzEGkGtCv1Mb45DlqNzxOvN4fIi9wEo/0tZkUkHK6fwTkWGDn0lEj7cistqOB4Kxw5uuOae7YKQh39AMWNbbVss9XR67aP82AYFYkA1eHov5Ozk++hRB+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722161; c=relaxed/simple;
	bh=2iUVpsRP+GziJHbqwVWUqIeakMzbVBwpep9BwrCTVN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xt0vyel0C9vsK/EA8XXa7GfpbtxHFtzf8q4MN0bQrPkhxaC8XeKhaYL4uqO/8svKr0qdKImHaCP0f0qTcbGTpbtLdK8aUQPDaj2gL+Lm1V5Ir/ToOPZd4YSPgTCA0jGTdhOV++ZyjddHfCl8UmqQUIcKoJ+7RxNmClpZaQ3yRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNXStYk7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so127023266b.2;
        Fri, 23 Feb 2024 13:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722158; x=1709326958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NLCOmx0IepUq3FGeXL96wdgQ4A1ty/0t9iA55p68ic=;
        b=PNXStYk70Er1WvWKORv5EiLjIBatBy+v3gb8FvENboTSbZLSAYa7gRjOHXA2QlAZt0
         3lFg/56GI1UNw7Hty4SLOkkrquZuJuVbbWon/MKe1FNiBVEewnNiDigce7MoIEJTq1bQ
         Ab7Xw26lQXet+Xs3TZHSA7jikc+sHFTK/5BzxFiScz2zwNFF70cifDvJ/ISRc6f7Crc3
         5JGkQ7np69Sy9cNuPT4YfrtDxKh5MW+ukMBzzS7RwFmd0IoLlvAFdxjDT4R46Ng3+TJp
         BrsDSBh44PRDZbwhllQR0HvrcbKy4BycHumplud4+d/LezoxRa239cAngC0rPRE0ADrA
         /ulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722158; x=1709326958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NLCOmx0IepUq3FGeXL96wdgQ4A1ty/0t9iA55p68ic=;
        b=j47woY2c7M5wCt9bK8U5iXWEsVLGzOJoUuRWBx/ARplVGJX72WwsJbxTZ4eseVvXcQ
         Tbz1TyFzh8LEWlpu1zXCpSZII2hGFKAyczuAUC4I5F/rcH2lxEu5LTGPAL1rHDZS0orw
         MXDRr2Q0c4wDzVBlwA8RUAKNaK8KsO+fEzJ3+VsaXlen3WAm7IrJmwjjrWO7yRwsfT/F
         P7IPRppcBMuA3rLHpMuup/KDhVkW8I3nKtcgyI5m19Q2CTzVUlGeG9IXZknz9VP1Pg9W
         x/w4nKGfVNHI1OaI9Mta9eax+iKram+O29ptj1LslKXVrBhJXF9sbq4UDFldE2ZpjH7P
         B/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpLM5ocNDNRjzWfMq0bQEJuVNWZa0klKCdITOGDMa2cOBFbmNVQ+QHwYFJh/J/+lFskkmCTOZQ0RVjJi/REYBdMNjE4zkSK6pYNqVQ
X-Gm-Message-State: AOJu0YyKGt4WPTsedDrfZ6WQknnIVY2licYi/x+MpLk7lCRjgz/YPh3m
	i61PcU8SXufRH9EyFaD16K7YRyMHZNJhD05/TsZfG974hLbaSMfn9Jl1H6hajGk=
X-Google-Smtp-Source: AGHT+IEaotSAMr41DL2euvzOhXf8mHXbPlfAdMNEbBS8HQCPP3PttQDXaZseZ2s663P/pjs0m077Lw==
X-Received: by 2002:a17:906:d20e:b0:a3f:9f38:ded with SMTP id w14-20020a170906d20e00b00a3f9f380dedmr584159ejz.69.1708722157949;
        Fri, 23 Feb 2024 13:02:37 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:02:37 -0800 (PST)
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
Subject: [PATCH net-next v5 10/16] net: dsa: tag_sja1105: prefer precise source port info on SJA1110 too
Date: Fri, 23 Feb 2024 22:00:40 +0100
Message-Id: <20240223210049.3197486-11-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223210049.3197486-1-paweldembicki@gmail.com>
References: <20240223210049.3197486-1-paweldembicki@gmail.com>
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
v5:
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


